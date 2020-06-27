class CategoriesController < ApplicationController
  before_action :authenticate_user! # TODO filter by permissions later.

  def index
    @categories = Category.where(parent_id: nil)
  end

  def show
    @category = Category.find params[:id]
  end

  def new
    @category = Category.new
    if params[:parent_id]
      @category = Category.find(params[:parent_id]).children.new
      @parent_category = Category.find(params[:parent_id])
    end
  end

  def create
    @category = Category.new(permit_params)

    if @category.save
      redirect_to @category
    else
      render "new", parent_id: params[:category][:parent_id]
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to categories_path
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id]) # TODO Allow users to change the parent

    if @category.update(permit_params)
      redirect_to @category
    else
      render "edit"
    end
  end


  private
  def permit_params
    params.require(:category).permit(:name, :parent_id)
  end

end
