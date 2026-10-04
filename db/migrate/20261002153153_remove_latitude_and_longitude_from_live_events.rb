class RemoveLatitudeAndLongitudeFromLiveEvents < ActiveRecord::Migration[7.2]
  def change
    remove_column :live_events, :latitude, :decimal
    remove_column :live_events, :longitude, :decimal
  end
end
