class CreateStations < ActiveRecord::Migration[6.0]
  def change
    create_table :stations do |t|
      t.integer :stop_id
      t.string :direction_id
      t.string :stop_name
      t.string :station_name
      t.string :station_descriptive_name
      t.integer :map_id
      t.boolean :ada
      t.boolean :red
      t.boolean :blue
      t.boolean :g
      t.boolean :brn
      t.boolean :p
      t.boolean :pexp
      t.boolean :y
      t.boolean :pnk
      t.boolean :o
      t.jsonb :location

      t.timestamps
    end
  end
end
