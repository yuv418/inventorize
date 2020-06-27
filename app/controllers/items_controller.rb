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

  private
  def permit_params
    params.require(:item).permit(:schema_id, data: [], categories: [])
  end

end
