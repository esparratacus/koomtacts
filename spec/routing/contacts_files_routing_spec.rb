require "rails_helper"

RSpec.describe ContactsFilesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/contacts_files").to route_to("contacts_files#index")
    end

    it "routes to #new" do
      expect(get: "/contacts_files/new").to route_to("contacts_files#new")
    end

    it "routes to #show" do
      expect(get: "/contacts_files/1").to route_to("contacts_files#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/contacts_files/1/edit").to route_to("contacts_files#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/contacts_files").to route_to("contacts_files#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/contacts_files/1").to route_to("contacts_files#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/contacts_files/1").to route_to("contacts_files#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/contacts_files/1").to route_to("contacts_files#destroy", id: "1")
    end
  end
end
