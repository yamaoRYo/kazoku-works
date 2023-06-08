class CreateFamilies < ActiveRecord::Migration[7.0]
  def change
    create_table :families do |t|
      t.string :name, null: false
      t.date :established_date
      
      t.timestamps
    end
  end
end
