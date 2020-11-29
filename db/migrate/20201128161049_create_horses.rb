class CreateHorses < ActiveRecord::Migration[6.0]
  def change
    create_table :fathers do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :mothers do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :horses do |t|
      t.string :name, null: false
      t.references :father, foreign_key: true, null: false
      t.references :mother, foreign_key: true, null: false
      t.timestamps
    end
  end
end
