# creates Offices table in SQLite database
class CreateOffices < ActiveRecord::Migration[5.0]
  def change
    create_table :offices do |t|
      t.string :position
      t.string :level
    end
  end
end
