class ItemsController < ApplicationController
  def new
    @item = Item.new
    if params[:schema_id]
        @schema = Schema.find params[:schema_id]
        @item.schema = @schema
    end
  end

  def create
    @item = Item.new(permit_params.except :categories)
    @item.categories = permit_params[:categories].map { |id_s| Category.find(id_s) }

    if @item.save
      redirect_to @item
    else
      render "new"
    end
  end


  def show
    @item = Item.find params[:id]
  end

  def index
    if query_params[:category_id]
      @items = Category.find(query_params[:category_id]).items.where(query_params.except(:category_id))
    else
      @items = Item.where(query_params)# TODO actually query stuff
    end
  end

  def edit
    @item = Item.find params[:id]
    @schema = @item.schema
  end

  def update

    @item = Item.find params[:id]
    @item.categories = permit_params[:categories].map { |id_s| Category.find(id_s) }

    if @item.update(permit_params.except :categories)
      redirect_to @item
    else
      render "edit"
    end
  end

  def destroy
    @item = Item.find params[:id]
    @item.destroy

    redirect_to items_path
  end

  private
  def permit_params
    params.require(:item).permit(:schema_id, data: [], categories: [])
  end

  def query_params
    params.permit(:schema_id, :category_id)
  end

end
