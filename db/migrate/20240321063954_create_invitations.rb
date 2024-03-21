class CreateInvitations < ActiveRecord::Migration[7.1]
  def change
    create_table :invitations do |t|
      t.references :event, null: false, foreign_key: true
      t.references :inviter, null: false,
                   foreign_key: { to_table: :users }
      t.references :invitee, null: false,
                   foreign_key: { to_table: :users }
      t.string :status, default: 'pending'
      t.timestamps
    end
  end
end
