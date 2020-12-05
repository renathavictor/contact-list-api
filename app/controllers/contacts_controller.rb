class ContactsController < ApplicationController
  before_action :set_list
  before_action :set_list_contact, only: [:show, :update, :destroy]

  # GET /lists/:list_id/contacts
  def index
    json_response(@list.contacts)
  end

  # GET /lists/:list_id/contacts/:id
  def show
    json_response(@contact)
  end

  # POST /lists/:list_id/contacts
  def create
    @list.contacts.create!(contact_params)
    json_response(@list, :created)
  end

  # PUT /lists/:list_id/contacts/:id
  def update
    @contact.update(contact_params)
    head :no_content
  end

  # DELETE /lists/:list_id/contacts/:id
  def destroy
    @contact.destroy
    head :no_content
  end

  private

  def contact_params
    params.permit(:name, :done)
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_list_contact
    @contact = @list.contacts.find_by!(id: params[:id]) if @list
  end 
end
