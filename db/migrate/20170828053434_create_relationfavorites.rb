class CreateRelationfavorites < ActiveRecord::Migration
  def change
    create_table :relationfavorites do |t|
      t.integer :favorite_id
      t.integer :favorited_id

      t.timestamps
    end
    # add_index :relationfavorites, favorite_id
    # add_index :relationfavorites, favorited_id
    # add_index :relationfavorites, [:favorite_id, :favorited_id], unique: true
  end
end
