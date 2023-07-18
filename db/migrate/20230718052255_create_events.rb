class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :event_type
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.text :content
      t.string :visibility
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
