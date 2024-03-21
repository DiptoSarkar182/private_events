class AddColumnToEventJoining < ActiveRecord::Migration[7.1]
  def change
    add_reference :event_joinings, :user, foreign_key: true
    add_reference :event_joinings, :event, foreign_key: true
  end
end
