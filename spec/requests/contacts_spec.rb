require 'rails_helper'

RSpec.describe "/contacts", type: :request do
  before(:each) do
    @user = User.create(email: 'test@test.com', password: "password", password_confirmation: "password")
    sign_in @user
  end

  describe "GET /index" do
    it "renders a successful response" do
      get contacts_url
      expect(response).to be_successful
    end
  end

end
