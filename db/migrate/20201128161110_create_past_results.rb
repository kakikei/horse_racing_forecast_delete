class CreatePastResults < ActiveRecord::Migration[6.0]
  def change
    create_table :past_results do |t|
      t.belongs_to :horses
      t.integer :ranking
      t.integer :distance
      t.float :time
      t.timestamps
    end
  end
end
