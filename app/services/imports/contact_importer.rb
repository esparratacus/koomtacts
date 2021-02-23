module Imports
  class ContactImporter
    attr_reader :contacts_file

    def initialize(contacts_file:)
      @contacts_file = contacts_file
    end

    def call
      raise Exceptions::HeaderMappingsNotSetException, 'Header Mappings not set' unless contacts_file.header_mappings

      contacts_file.importer_logs.destroy_all
      contacts_file.update(status: ContactsFile::PROCESSING)

      processed_all? ? contacts_file.update(status: ContactsFile::FINISHED) : contacts_file.update(status: ContactsFile::FAILED)
    end

    private

    def processed_all?(counter: 0, failed_counter: 0)
      CSV.parse(contacts_file.contacts_csv.download, headers: true, encoding: 'UTF-8') do |row|
        counter += 1
        csv_line = row.to_hash
        new_contact = new_contact_from_csv(csv_line)
        next if new_contact.save

        contacts_file.importer_logs.create(candidate: csv_line, error_log: new_contact.errors.messages)
        failed_counter += 1
      end
      failed_counter != counter
    end

    def new_contact_from_csv(csv_line)
      Contact.new(user_id: contacts_file.user_id).tap do |new_contact|
        ContactsFile::HEADER_COLUMNS.each { |col| new_contact[col] = csv_line[contacts_file.header_mappings[col.to_s]] }
      end
    end

  end
end