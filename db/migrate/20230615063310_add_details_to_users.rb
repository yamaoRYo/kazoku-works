class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :relationship, :string
    add_column :users, :birthdate, :date
    add_column :users, :age, :integer
    add_column :users, :constellation, :string
    add_column :users, :blood_type, :string
    add_column :users, :image, :string
  end
end
