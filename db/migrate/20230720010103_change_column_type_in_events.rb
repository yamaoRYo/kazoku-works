class ChangeColumnTypeInEvents < ActiveRecord::Migration[7.0]
  def change
    change_column :events, :event_type, 'integer USING CAST(event_type AS integer)'
    change_column :events, :visibility, 'integer USING CAST(visibility AS integer)'
  end
end
