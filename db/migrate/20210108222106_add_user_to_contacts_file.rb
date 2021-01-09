class AddUserToContactsFile < ActiveRecord::Migration[6.0]
  def change
    add_reference :contacts_files, :user, null: false, foreign_key: true
  end
end
