class CreateLiveLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :live_logs do |t|
      t.references :live_event, null: false, foreign_key: true
      t.integer :satisfaction
      t.string :people
      t.text :impression

      t.timestamps
    end
  end
end
