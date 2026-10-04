class RemovePlaceIdFromLiveEvents < ActiveRecord::Migration[7.2]
  def change
    remove_column :live_events, :place_id, :string
  end
end
