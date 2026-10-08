class AddAttendedToLiveEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :live_events, :attended, :boolean, default: false, null: false
  end
end
