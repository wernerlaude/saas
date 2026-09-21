class AddInvitationColumnsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :invitation_created_at, :datetime
    add_column :users, :invitation_accepted_at, :datetime
    add_reference :users, :invited_by, foreign_key: { to_table: :users }
  end
end
