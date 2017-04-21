# creates cities table in SQLite database
class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :city
      t.integer :state_id
    end
  end
end
