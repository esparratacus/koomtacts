 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/contacts_files", type: :request do
  # ContactsFile. As you add validations to ContactsFile, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      ContactsFile.create! valid_attributes
      get contacts_files_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      contacts_file = ContactsFile.create! valid_attributes
      get contacts_file_url(contacts_file)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_contacts_file_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      contacts_file = ContactsFile.create! valid_attributes
      get edit_contacts_file_url(contacts_file)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ContactsFile" do
        expect {
          post contacts_files_url, params: { contacts_file: valid_attributes }
        }.to change(ContactsFile, :count).by(1)
      end

      it "redirects to the created contacts_file" do
        post contacts_files_url, params: { contacts_file: valid_attributes }
        expect(response).to redirect_to(contacts_file_url(ContactsFile.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new ContactsFile" do
        expect {
          post contacts_files_url, params: { contacts_file: invalid_attributes }
        }.to change(ContactsFile, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post contacts_files_url, params: { contacts_file: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested contacts_file" do
        contacts_file = ContactsFile.create! valid_attributes
        patch contacts_file_url(contacts_file), params: { contacts_file: new_attributes }
        contacts_file.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the contacts_file" do
        contacts_file = ContactsFile.create! valid_attributes
        patch contacts_file_url(contacts_file), params: { contacts_file: new_attributes }
        contacts_file.reload
        expect(response).to redirect_to(contacts_file_url(contacts_file))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        contacts_file = ContactsFile.create! valid_attributes
        patch contacts_file_url(contacts_file), params: { contacts_file: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested contacts_file" do
      contacts_file = ContactsFile.create! valid_attributes
      expect {
        delete contacts_file_url(contacts_file)
      }.to change(ContactsFile, :count).by(-1)
    end

    it "redirects to the contacts_files list" do
      contacts_file = ContactsFile.create! valid_attributes
      delete contacts_file_url(contacts_file)
      expect(response).to redirect_to(contacts_files_url)
    end
  end
end
