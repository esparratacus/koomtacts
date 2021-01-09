class CreateContactsFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts_files do |t|
      t.string :contacts
      t.jsonb :header_mappings
      t.string :status
    end
  end
end
