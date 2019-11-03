class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :response

      t.timestamps
    end
  end
end
