json.extract! contacts_file, :id, :file_name, :header_mappings, :status
json.url contacts_file_url(contacts_file, format: :json)
