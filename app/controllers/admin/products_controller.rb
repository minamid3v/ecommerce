class Admin::ProductsController < ApplicationController
  before_action :admin_user
  before_action :load_product, only: [:edit, :update, :destroy, :show]
  before_action :get_price_params, only: :index
  before_action :load_all_product, only: :index

  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t "success.update"
      redirect_to [:admin, @product]
    else
      flash[:danger] = t "error.update_failed"
      redirect_to admin_products_path
    end
  end

  def show
  end

  def destroy
    if @product.destroy
      flash.now[:success] = t "success.delete"
      load_all_product
      respond_to do |format|
        format.js
      end
    else
      flash.now[:danger] = t "error.detele"
      load_all_product
      respond_to do |format|
        format.js
      end
    end
  end

  def import
    if Product.import?(params[:file])
      flash[:success] = t "success.upload"
    else
      flash[:danger] = t "error.upload"
      redirect_to admin_products_path
    end
  end

  private

  def product_params
    params.require(:product).permit :name, :description, :price, :quantity,
      :image, :sub_category_id
  end

  def load_product
    @product = Product.find_by id: params[:id]
    unless @product
      flash[:danger] = t "error.product_not_found"
      redirect_to admin_products_path
    end
  end

  def load_all_product
    @products = Product.by_sub_category(params[:sub_category])
      .by_classification(params[:classsification])
      .by_name(params[:name])
      .by_min_price(@min_price)
      .by_max_price(@max_price)
    if params[:rate].present?
      @products = @products.select do |product|
        product.average_rate >= params[:rate].to_i
      end
    end
    @products = @products.paginate page: params[:page],
      per_page: Settings.paginate.admin_products
  end
end
