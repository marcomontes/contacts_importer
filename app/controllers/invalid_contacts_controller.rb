class InvalidContactsController < ApplicationController
  def index
    @invalid_contacts = InvalidContact.all.page params[:page]
  end
end
