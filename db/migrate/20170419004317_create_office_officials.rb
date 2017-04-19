class CreateOfficeOfficials < ActiveRecord::Migration[5.0]

  def change
    create_table :office_officials do |t|
      t.integer :official_id
      t.integer :office_id
    end
  end

end
