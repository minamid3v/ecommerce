class Admin::SuggestedProductsController < ApplicationController
  before_action :admin_user
  before_action :load_suggested_product, only: :destroy
  before_action :get_price_params, only: :index
  before_action :load_all_suggested_product, only: :index

  def index
  end

  def destroy
    if @suggested_product.destroy
      flash[:success] = t "success.delete"
      load_all_suggested_product
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "error.delete_failed"
      load_all_suggested_product
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def load_suggested_product
    @suggested_product =  SuggestedProduct.find_by id: params[:id]
    unless @suggested_product
      flash[:danger] = t "error.suggested_product_not_found"
      redirect_to admin_suggested_products_path
    end
  end

  def load_all_suggested_product
    @suggested_products = SuggestedProduct.by_name_description(params[:keyword])
      .by_min_price(@min_price)
      .by_max_price(@max_price)
      .paginate page: params[:page],
        per_page: Settings.paginate.admin_suggested_products
  end
end
