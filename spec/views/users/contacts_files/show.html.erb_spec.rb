require 'rails_helper'

RSpec.describe '/users/contacts_files/show', type: :view do
  before(:each) do
    @contacts_file = assign(:contacts_file, create(:contacts_file))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/File Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Status/)
  end
end
