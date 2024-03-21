class CreateEventJoinings < ActiveRecord::Migration[7.1]
  def change
    create_table :event_joinings do |t|

      t.timestamps
    end
  end
end
