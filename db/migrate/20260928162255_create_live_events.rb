class CreateLiveEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :live_events do |t|
      t.string :title, null: false
      t.string :artist_name
      t.date :event_date, null: false
      t.string :venue_name, null: false
      t.text :address
      t.decimal :latitude
      t.decimal :longitude
      t.string :place_id

      t.timestamps
    end
  end
end
