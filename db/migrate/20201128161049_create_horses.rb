class CreateHorses < ActiveRecord::Migration[6.0]
  def change
    create_table :horses do |t|
      t.string :name
      t.belongs_to :fathers
      t.belongs_to :mothers
      t.timestamps
    end
  end
end
