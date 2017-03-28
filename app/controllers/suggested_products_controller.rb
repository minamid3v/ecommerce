class SuggestedProductsController < ApplicationController
  before_action :load_suggested_product, only: [:destroy, :edit, :update]
  before_action :logged_in_user
  
  def new
    @suggested_product = current_user.suggested_products.new
  end

  def create
    @suggested_product = current_user.suggested_products.new suggested_product_params
    if @suggested_product.save
      flash[:success] = t "success.suggest"
      redirect_to controller: :users, action: :show, id: current_user.id,
        tab: :suggested_product_tab
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @suggested_product.update_attributes suggested_product_params
      flash[:success] = t "success.update"
      redirect_to controller: :users, action: :show,
      id: current_user.id, tab: :suggested_product_tab
    else
      flash[:danger] = t "error.update_failed"
      redirect_to :back
    end
  end

  def destroy
    if @suggested_product.destroy
      flash.now[:success] = t "success.delete"
    else
      flash[:danger] = t "error.delete_failed"
      redirect_to :back
    end
  end

  private

  def load_suggested_product
    @suggested_product = current_user.suggested_products.find_by id: params[:id]
    unless @suggested_product
      flash[:danger] = t "error.suggested_product_not_found"
      redirect_to :back
    end
  end

  def suggested_product_params
    params.require(:suggested_product).permit :name, :content, :price, :image
  end
end
