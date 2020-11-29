class CreatePastResults < ActiveRecord::Migration[6.0]
  def change
    create_table :past_results do |t|
      t.references :horse, foreign_key: true, null: false
      t.integer :ranking, null: false
      t.integer :distance, null: false
      t.date :match_day, null: false
      t.float :time, null: false
      t.timestamps
    end
  end
end
