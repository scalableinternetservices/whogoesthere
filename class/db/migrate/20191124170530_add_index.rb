class AddIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :events, :user_id
    add_index :invitations, :event_id
    add_index :invitations, :user_id
    add_index :comments, :event_id
  end
end