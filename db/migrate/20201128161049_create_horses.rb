class CreateHorses < ActiveRecord::Migration[6.0]
  def change
    create_table :horses do |t|
      t.string :name
      t.string :father
      t.string :mother
      t.timestamps
    end
  end
end
