class RelationfavoritesController < ApplicationController
  before_action :signed_in_user

  def create

    @favorite = Relationfavorite.create(favorite_id: current_user.id,
    favorited_id: params[:micropost_id])
    @count = Relationfavorite.where(favorited_id: params[:micropost_id])
    p @count

    # current_user.micropost.id

    # respond_to do |format|
    #   format.html { redirect_to @user }
    #   format.js
    # end
  end

  def destroy
    favorite = Relationfavorite.find_by(favorite_id: current_user.id,
    favorited_id: params[:micropost_id])
    favorite.destroy
    @count = Relationfavorite.where(favorited_id: params[:micropost_id])
    # respond_to do |format|
    #   format.html { redirect_to @user }
    #   format.js
  end
end
