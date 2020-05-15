require "rails_helper"

RSpec.describe InvalidContactsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/invalid_contacts").to route_to("invalid_contacts#index")
    end
  end
end
