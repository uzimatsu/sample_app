class AddLikesCountToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :likes_count, :integer
  end
end
