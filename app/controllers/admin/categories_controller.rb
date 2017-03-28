class Admin::CategoriesController < ApplicationController
  before_action :load_category, only: [:show, :update, :destroy]
  
  def index
    @categories = Category.all
  end

  def show
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "success.update"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "error.edit_failed"
      redirect_to admin_categories_path
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "success.delete"
      redirect_to :back
    else
      flash[:danger] = t "error.delete_failed"
      redirect_to :back
    end
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "error.category_not_found"
      redirect_to :back
    end
  end

  def category_params
    params.require(:category).permit :name, :description
  end
end
