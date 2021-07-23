class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :contact
      t.text :address
      t.string :gender

      t.timestamps
    end
  end
end
