# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::ContactsFilesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/contacts_files').to route_to('users/contacts_files#index')
    end

    it 'routes to #new' do
      expect(get: '/contacts_files/new').to route_to('users/contacts_files#new')
    end

    it 'routes to #show' do
      expect(get: '/contacts_files/1').to route_to('users/contacts_files#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/contacts_files/1/edit').to route_to('users/contacts_files#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/contacts_files').to route_to('users/contacts_files#create')
    end

    it 'routes to #execute_import' do
      expect(get: '/contacts_files/1/execute_import').to route_to('users/contacts_files#execute_import', id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/contacts_files/1').to route_to('users/contacts_files#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/contacts_files/1').to route_to('users/contacts_files#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/contacts_files/1').to route_to('users/contacts_files#destroy', id: '1')
    end
  end
end

#Tip: Based on detected gems, the following RuboCop extension libraries might be helpful:
# * rubocop-rails (http://github.com/rubocop-hq/rubocop-rails)
#  * rubocop-rspec (http://github.com/rubocop-hq/rubocop-rspec)

#You can opt out of this message by adding the following to your config (see https://docs.rubocop.org/rubocop/extensions.html#extension-suggestions for more options):
# AllCops:
#   SuggestExtensions: false
