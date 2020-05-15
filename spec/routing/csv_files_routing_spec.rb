require "rails_helper"

RSpec.describe CsvFilesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/csv_files").to route_to("csv_files#index")
    end

    it "routes to #new" do
      expect(get: "/csv_files/new").to route_to("csv_files#new")
    end

    it "routes to #create" do
      expect(post: "/csv_files").to route_to("csv_files#create")
    end
  end
end
