require "rails_helper"

RSpec.describe GrantCurrentnessesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/grant_currentnesses").to route_to("grant_currentnesses#index")
    end

    it "routes to #show" do
      expect(get: "/grant_currentnesses/1").to route_to("grant_currentnesses#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/grant_currentnesses").to route_to("grant_currentnesses#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/grant_currentnesses/1").to route_to("grant_currentnesses#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/grant_currentnesses/1").to route_to("grant_currentnesses#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/grant_currentnesses/1").to route_to("grant_currentnesses#destroy", id: "1")
    end
  end
end
