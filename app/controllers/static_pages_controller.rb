class StaticPagesController < ApplicationController
  #home画面にてつぶやきができるメソッド
  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @count = Relationfavorite.where(favorited_id: params[:micropost_id])

    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
