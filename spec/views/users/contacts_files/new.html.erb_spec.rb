require 'rails_helper'

RSpec.describe "/users/contacts_files/new", type: :view do
  before(:each) do
    assign(:contacts_file, attributes_for(:contacts_file))
  end

  it "renders new contacts_file form" do
    render

    assert_select "form[action=?][method=?]", contacts_files_path, "post" do

      assert_select "input[name=?]", "contacts_file[file_name]"

      assert_select "input[name=?]", "contacts_file[header_mappings]"

      assert_select "input[name=?]", "contacts_file[status]"
    end
  end
end
