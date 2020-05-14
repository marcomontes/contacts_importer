class ContactsController < ApplicationController

  def index
    @contacts = Contact.all.page params[:page]
  end

end
