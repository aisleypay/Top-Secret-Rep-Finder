class CreateSenators < ActiveRecord::Migration[5.0]
  def change
    create_table :senators do |t|
      t.string :name
      t.string :address
      t.string :party
      t.string :phones
      t.string :urls
      t.string :photoUrl
      t.string :Facebook
      t.string :Twitter
      t.string :YouTube
      t.integer :state_id
      t.integer :official_id
    end
  end
end
