# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'users/contacts_files/index', type: :view do
  before(:each) do
    assign(:contacts_files, create_list(:contacts_file, 2))
  end

  it 'renders a list of contacts_files' do
    render
    assert_select 'tr>td', text: 'File Name'.to_s, count: 2
    assert_select 'tr>td', text: ''.to_s, count: 2
    assert_select 'tr>td', text: 'Status'.to_s, count: 2
  end
end
