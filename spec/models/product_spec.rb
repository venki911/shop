require 'spec_helper'

describe Product do

  before do
    @product = FactoryGirl.create(:product)
  end

  it { expect(@product).to respond_to(:name) }
  it { expect(@product).to respond_to(:code) }
  it { expect(@product).to respond_to(:price) }
  it { expect(@product).to respond_to(:composition) }
  it { expect(@product).to respond_to(:images) }
  it { expect(@product).to respond_to(:category) }
  it { expect(@product).to respond_to(:product_colors) }

  it { expect(@product).to be_valid }

  describe "when name" do
    context "is not present" do
      before { @product.name = ''}
      it { expect(@product).not_to be_valid }
    end
  end


  describe "when code" do
    # context "is not present" do
    #   before do
    #     @product.code = ''
    #     @product.send(:create_without_callbacks)
    #   end
    #   it { expect(@product).not_to be_valid }
    # end
    context "is already taken" do
      before do
        product_with_same_code = @product.dup
        product_with_same_code.save
        @product.save
      end
      it { should_not be_valid }
    end
  end


  describe "when composition" do
    context "is not present" do
      before { @product.composition = ''}
      it { expect(@product).not_to be_valid }
    end
  end


  describe "when image" do
    context "is not present" do
      before { @product.remove_images! }
      it { expect(@product).not_to be_valid }
    end
  end


  describe "when price" do
    context "is not present" do
      before { @product.price = ''}
      it { expect(@product).not_to be_valid }
    end
    context "is not a number" do
      before { @product.price = 'aa'}
      it { expect(@product).not_to be_valid }
    end
    context "is smaller than 0" do
      before { @product.price = -1}
      it { expect(@product).not_to be_valid }
    end
    context "is 0" do
      before { @product.price = 0}
      it { expect(@product).not_to be_valid }
    end
    context "is greater than 0" do
      before { @product.price = 11}
      it { expect(@product).to be_valid }
    end
  end


  describe "when category" do
    context "is not present" do
      before { @product.category = nil}
      it { expect(@product).not_to be_valid }
    end
  end

end
