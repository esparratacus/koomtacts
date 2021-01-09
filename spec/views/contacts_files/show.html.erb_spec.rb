require 'rails_helper'

RSpec.describe "contacts_files/show", type: :view do
  before(:each) do
    @contacts_file = assign(:contacts_file, ContactsFile.create!(
      file_name: "File Name",
      header_mappings: "",
      status: "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/File Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Status/)
  end
end
