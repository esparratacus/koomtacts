class ImportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(contacts_file_id)
    @contacts_file = ContactsFile.find contacts_file_id
    ContactImporter.new(contacts_file: @contacts_file).call
  end
end
