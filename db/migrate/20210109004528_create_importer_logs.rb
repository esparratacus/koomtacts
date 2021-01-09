class CreateImporterLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :importer_logs do |t|
      t.references :contacts_file
      t.jsonb :candidate
      t.jsonb :error_log
    end
  end
end
