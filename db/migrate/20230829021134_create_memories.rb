class CreateMemories < ActiveRecord::Migration[7.0]
  def change
    create_table :memories do |t|
      t.references :event, null: false, foreign_key: true
      t.datetime :date
      t.string :title
      t.text :details

      t.timestamps
    end
  end
end
