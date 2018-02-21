class CreateChampions < ActiveRecord::Migration[5.1]
  def change
    create_table :champions do |t|
      t.string :name
      t.decimal :uri_id

      t.timestamps
    end
  end
end
