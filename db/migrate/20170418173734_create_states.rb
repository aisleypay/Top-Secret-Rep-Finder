# creates States table in SQLite database
class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :abbreviation
    end
  end
end
