class LikesController < ApplicationController
  before_action :micropost_set

  def create
    @like = Like.create(user_id: current_user.id, micropost_id: params[:micropost_id])
    @likes = Like.where(micropost_id: params[:micropost_id])
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def destroy
    Like.find_by(user_id: current_user.id, micropost_id: params[:micropost_id]).destroy
    @likes = Like.where(micropost_id: params[:micropost_id])
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  private
  def micropost_set
    @micropost = Microposts.find(params[:micropost_id])
  end
end
