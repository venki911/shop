class Api::ProductColorsController < ApplicationController
  def index
    all_products = products = Product
      .includes(product_colors: :product_sizes, category: [category_type: :main_category])
      .filter_prod_by_category(params[:main_category], params[:category_type], params[:category])
    filter = JSON.parse(params[:filter]) if params[:filter] != "{}"
    per_page = 4
    page = (params[:item].to_f/per_page).to_i + 1
    count = products.count
    products = filter_prod(products, filter) if filter
    products = sort_prod(products, params[:sort]) if params[:sort]
    if params[:item] == '0' || nil
      products_details = Product.products_colors_sizes(all_products).merge(count: products.count)
    end
    products = paginate_prod_or_nil(products, params[:item], page, per_page)

    render json: {products: products, products_details: products_details}
  end

  def show
    pc = ProductColor
      .includes(product: [category: [category_type: :main_category]])
      .find_by(code: params[:id])
    pr_cat = pc.product.category

    products = Product
      .includes(product_colors: :product_sizes, category: [category_type: :main_category])
      .joins(:category).where(categories: {id: pr_cat.id})
    codes = products.map { |pr| pr.product_colors[0].code }

    pc_code = pc.product.product_colors[0].code

    index = codes.index(pc_code)
    pr_prev = codes[index-1] if index > 0
    pr_next = codes[index+1] if index < codes.length - 1

    items = {
      pr_prev: pr_prev,
      pr_next: pr_next,
      pr_numb: index + 1,
      prs_numb: codes.length,
    }

    render json: {
      pr_det: pc.extend(ProductColorRepresenter).to_hash,
      pr: pc.product.extend(ProductIndexRepresenter).to_hash
    }.merge(items)
  end

  def products_search
    all_products = products = Product.search(params[:search_query])
    filter = JSON.parse(params[:filter]) if params[:filter] != "{}"
    per_page = 4
    page = (params[:item].to_f/per_page).to_i + 1
    count = products.count
    products = filter_prod(products, filter) if filter
    products = sort_prod(products, params[:sort]) if params[:sort]
    if params[:item] == '0' || nil
      products_details = Product.products_colors_sizes(all_products).merge(count: products.count)
    end
    products = paginate_prod_or_nil(products, params[:item], page, per_page)
    render json: {products: products, products_details: products_details}
  end

  private

  def paginate_prod_or_nil(products, item, page, per_page)
    if item == '0' || nil
      products
        .paginate(page: page, per_page: per_page * 4)
        .extend(ProductsIndexRepresenter).to_hash
    elsif item.to_i != products.count
      products
        .paginate(page: page, per_page: per_page)
        .extend(ProductsIndexRepresenter).to_hash
    else
      nil
    end
  end

  def sort_prod(products, sort)
    case sort
    when 'high'
      products.order(price: :desc)
    when 'low'
      products.order(price: :asc)
    when 'new'
      products.order(created_at: :desc)
    end
  end

  def filter_prod(products, filter)
    Product.filter(
      products,
      filter['colors'],
      filter['sizes'],
      filter['price_from'],
      filter['price_to']
    )
  end
end
