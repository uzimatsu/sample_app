class LikesController < ApplicationController

  respond_to :html, :js

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @like = Like.create(user_id: current_user.id, micropost_id: params[:micropost_id])
    @likes = Like.where(micropost_id: params[:micropost_id])

    # respond_with root_url
    redirect_to root_url
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    Like.find_by(user_id: current_user.id, micropost_id: params[:micropost_id]).destroy
    @likes = Like.where(micropost_id: params[:micropost_id])
    redirect_to root_url
    # respond_with root_url
  end

end
