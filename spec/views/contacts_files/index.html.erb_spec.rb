require 'rails_helper'

RSpec.describe "contacts_files/index", type: :view do
  before(:each) do
    assign(:contacts_files, [
      ContactsFile.create!(
        file_name: "File Name",
        header_mappings: "",
        status: "Status"
      ),
      ContactsFile.create!(
        file_name: "File Name",
        header_mappings: "",
        status: "Status"
      )
    ])
  end

  it "renders a list of contacts_files" do
    render
    assert_select "tr>td", text: "File Name".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "Status".to_s, count: 2
  end
end
