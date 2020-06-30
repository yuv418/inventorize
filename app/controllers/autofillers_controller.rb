class AutofillersController < ApplicationController
  before_action :authenticate_user! # TODO filter by permissions later.
  def index
    autofillers = Autofill.autofillers.map{|autofiller_class| autofiller_class.to_s.gsub("Autofiller", "").downcase}
    render json: autofillers
  end

  def show
    autofiller = Autofill.find(params[:name])
    render json: autofiller.fields
  end
end
