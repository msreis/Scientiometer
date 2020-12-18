require "rails_helper"

RSpec.describe ProductivityGrantTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/productivity_grant_types").to route_to("productivity_grant_types#index")
    end

    it "routes to #show" do
      expect(get: "/productivity_grant_types/1").to route_to("productivity_grant_types#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/productivity_grant_types").to route_to("productivity_grant_types#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/productivity_grant_types/1").to route_to("productivity_grant_types#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/productivity_grant_types/1").to route_to("productivity_grant_types#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/productivity_grant_types/1").to route_to("productivity_grant_types#destroy", id: "1")
    end
  end
end
