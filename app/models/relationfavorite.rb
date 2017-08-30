class Relationfavorite < ActiveRecord::Base
  belongs_to :micropost, counter_cache: :fav_count
  belongs_to :user
end
