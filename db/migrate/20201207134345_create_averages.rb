class CreateAverages < ActiveRecord::Migration[6.0]
  def change
    create_table :averages do |t|
      t.references :horse, foreign_key: true, null: false
      t.date :match_day, null: false
      t.float :average_time, null: false
      t.timestamps
    end
  end
end
