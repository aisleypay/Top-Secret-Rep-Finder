class CreateOfficeSenatorsTable < ActiveRecord::Migration[5.0]

  def change
    create_table :office_senators do |t|
      t.integer :senator_id
      t.integer :office_id
    end
  end

end
