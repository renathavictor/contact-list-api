class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update, :destroy]

  # GET /lists
  def index
    @lists = current_user.lists.paginate(page: params[:page], per_page: 10)
    json_response(@lists)
  end

  # POST /lists
  def create
    @list = current_user.lists.create!(list_params)
    json_response(@list, :created)
  end

  # GET /lists/:id
  def show
    json_response(@list)
  end

  # PUT /lists/:id
  def update
    @list.update(list_params)
    head :no_content
  end

  # DELETE /lists/:id
  def destroy
    @list.destroy
    head :no_content
  end

  private

  def list_params
    params.permit(:title)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
