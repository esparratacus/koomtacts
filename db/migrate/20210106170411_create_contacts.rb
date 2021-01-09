class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.date :dob
      t.string :phone_number
      t.string :address
      t.string :cc_4_digits
      t.string :cc_number
      t.string :franchise
      t.string :email
    end
  end
end
