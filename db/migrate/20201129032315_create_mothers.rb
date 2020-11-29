class CreateMothers < ActiveRecord::Migration[6.0]
  def change
    create_table :mothers do |t|
      t.string :name

      t.timestamps
    end
  end
end
