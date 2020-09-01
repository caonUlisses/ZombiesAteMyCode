class ResourcesController < ApplicationController

  api :GET, 'resources', 'List resources and its pricing'
  def index
    @resources = Resource.all

    render json: @resources
  end

  api :GET, 'resources/id', 'Give more information about the resource'
  param :id, String, desc: 'A resource ID'
  def show
    render json: Resource.find(params[:id])
  end
end
