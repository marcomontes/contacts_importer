class InvalidContactsController < ApplicationController
  def index
    @invalid_contacts = current_user.invalid_contacts.page params[:page]
  end
end
