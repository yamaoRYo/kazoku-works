class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.string :token
      t.references :family, null: false, foreign_key: true

      t.timestamps
    end
  end
end
