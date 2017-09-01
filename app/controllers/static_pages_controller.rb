class StaticPagesController < ApplicationController
  #home画面にてつぶやきができるメソッド
  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed(current_user).paginate(page: params[:page])
      @feed_messages = current_user.feed_message(current_user).paginate(page: params[:page])
      @likes = Like.where(micropost_id: params[:micropost_id])

    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
