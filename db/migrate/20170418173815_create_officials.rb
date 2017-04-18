class CreateOfficials < ActiveRecord::Migration[5.0]
  def change
    create_table :officials do |t|
      t.string :name
      t.string :office
    end
  end
end
