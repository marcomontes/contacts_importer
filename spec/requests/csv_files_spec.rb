require 'rails_helper'

RSpec.describe "/csv_files", type: :request do
  
  before(:each) do
    @user = User.create(email: 'test@test.com', password: "password", password_confirmation: "password")
    sign_in @user

    @file = fixture_file_upload(Rails.root.join('public', 'csv_contacts.csv'), 'text/csv')
    @csv_file_attributes = { "contacts_file" => @file, "columns"=>{"name"=>"A", "birthdate"=>"B", "phone"=>"C", "address"=>"D", "cc"=>"E", "email"=>"F"}}
  end
  
  describe "GET /index" do
    it "renders a successful response" do
      get csv_files_url
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_csv_file_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    before(:each) do
      post csv_files_url, params: { csv_file: @csv_file_attributes }
    end
    
    it "creates a new CsvFile" do
      expect(CsvFile.count).to eq(1)
    end

    it "creates a new attachment" do
      expect(ActiveStorage::Attachment.count).to eq(1)
      expect(response).to redirect_to(csv_files_url)
    end

    it "creates three valid contacts" do
      expect(Contact.count).to eq(3)
    end

    it "creates four invalid contacts" do
      expect(Contact.count).to eq(3)
    end

    it "redirects to a csv list of files" do
      expect(response).to redirect_to(csv_files_url)
    end
  end

end
