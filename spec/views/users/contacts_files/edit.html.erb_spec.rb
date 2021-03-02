require 'rails_helper'

RSpec.describe "/users/contacts_files/edit", type: :view do
  before(:each) do
    @contacts_file = assign(:contacts_file, create(:contacts_file))
  end

  it "renders the edit contacts_file form" do
    render

    assert_select "form[action=?][method=?]", contacts_file_path(@contacts_file), "post" do

      assert_select "input[name=?]", "contacts_file[file_name]"

      assert_select "input[name=?]", "contacts_file[header_mappings]"

      assert_select "input[name=?]", "contacts_file[status]"
    end
  end
end
