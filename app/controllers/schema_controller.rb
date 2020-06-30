class SchemaController < ApplicationController
  before_action :authenticate_user! # TODO filter by permissions later.

  def index
    @schemas = Schema.all
  end

  def new
    @schema = Schema.new
  end

  def show
    @schema = Schema.find(params[:id])
  end

  def create
    @schema = Schema.new schema_params

    if @schema.save
      redirect_to @schema
    else
      render 'new'
    end
  end

  def edit
    @schema = Schema.find(params[:id])
  end

  def update
    @schema = Schema.find(params[:id])

    if @schema.update(schema_params)
      redirect_to @schema
    else
      render 'edit'
    end
  end

  def destroy
    @schema = Schema.find(params[:id])
    @schema.destroy

    redirect_to schemas_path
  end

  private

  def schema_params
    params.require(:schema).permit(:name, :autofiller, :autofill, fields: [], autofill_mapping: [])
  end
end
