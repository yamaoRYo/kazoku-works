class AddExpiresAtToInvitations < ActiveRecord::Migration[7.0]
  def change
    add_column :invitations, :expires_at, :datetime
  end
end
