class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy]
  before_action :get_categories, only: [:new, :create, :edit, :update]

  def index
    respond_to do |format|
      format.html {
        if params[:category]
          category  = Category.find(params[:category])
          @products = category.products.where("quantity > ?", "0").paginate(page: params[:page], per_page: 28)
          @title    = category.display_name
        else
          @products = Product.where("quantity > ?", "0").paginate(page: params[:page], per_page: 28)
          @title    = "Shop all"
        end
      }
      format.json { render json: Product.paginate(page: params[:page], per_page: params[:per_page]) }
    end
  end

  def show
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html { @bag_item = BagItem.new }
      format.json { render json: @product }
    end
  end

  def new
    @product = Product.new
    @sub_cats = []
    handle_ajax
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Product has been added."
      redirect_to @product
    else
      get_sub_categories
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
    get_sub_categories
    handle_ajax
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "Product has been updated."
      redirect_to @product
    else
      get_sub_categories
      render 'edit'
    end
  end

  def destroy
    if Product.find(params[:id]).delete
      flash[:success] = "Product has been deleted"
    else
      flash[:danger] = "There was an issue trying to delete the product"
    end
    redirect_to products_url
  end

  private

    def product_params
      params.require(:product).permit(:category_id, :sub_category_id,
                                      :name, :description, :price, :quantity,
                                      :primary_img, {other_imgs: []})
    end

    def get_categories
      @categories = Category.all
    end

    def get_sub_categories
      @sub_cats = []
      unless @product.category_id.blank?
        @sub_cats = @product.category.sub_categories
      end
    end

    def handle_ajax
      if params[:category].present?
        @sub_cats = Category.find(params[:category]).sub_categories
      end
      if request.xhr?
        respond_to do |format|
          format.json {
            render json: {sub_categories: @sub_cats}
          }
        end
      end
    end
end
