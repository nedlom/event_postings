class CreateEventsTable < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :host
      t.string :location
      t.string :date
      t.string :time
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
