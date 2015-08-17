class TypesController < ApplicationController
  def index
    types = Type.all.map(&:name)
    render json: types
  end
end
