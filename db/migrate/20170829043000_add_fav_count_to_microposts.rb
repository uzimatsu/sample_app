class AddFavCountToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :fav_count, :integer
  end
end
