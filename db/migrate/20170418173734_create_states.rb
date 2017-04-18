class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :abbreviation
      t.string :full_name
    end
  end
end
