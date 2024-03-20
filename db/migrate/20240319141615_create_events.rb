class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :user, null:false, foreign_key:true
      t.string :title, null: false
      t.string :location
      t.datetime :event_date
      t.text :description
      t.timestamps
    end
  end
end
