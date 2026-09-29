class AddToLiveEvents < ActiveRecord::Migration[7.2]
  def change
    add_reference :live_events, :user, null: false, foreign_key: true
  end
end
