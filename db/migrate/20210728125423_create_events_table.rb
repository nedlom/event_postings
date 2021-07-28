class CreateEventsTable < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.string :location
      t.string :date
      t.string :time
      t.timestamps null: false
    end
  end
end
