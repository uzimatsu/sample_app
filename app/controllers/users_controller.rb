class UsersController < ApplicationController
  #サインインしていないユーザーを弾く
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  #ユーザーの一覧表示（10人ずつ）
  def index
    @users = User.paginate(page: params[:page], :per_page => 10)
  end

  #ユーザーの詳細情報の表示
  def show
    @user = User.find(params[:id])
    #選択したユーザーの投稿内容の表示
    @microposts = @user.microposts.paginate(page: params[:page])
    @count = Relationfavorite.where(favorited_id: params[:micropost_id])
  end

  #新規ユーザー登録画面
  def new
    @user = User.new
  end
  #ユーザーの消去
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "管理者権限でユーザーを削除しました !!"
    redirect_to users_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user #登録成功後ログイン
      flash[:success] = "無事にログインできました、ようこそ！！なんちゃってアプリへ！！"
      redirect_to @user
    else
      render 'new'
    end
  end

  #既存ユーザーの情報編集画面
  def edit
  end

  # 既存ユーザーの情報編集
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "フォローしているユーザー"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers

      @title = "フォローされているユーザー"
      @user = User.find(params[:id])
      @users = @user.followers.paginate(page: params[:page])
      render 'show_follow'

  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  #サインインしているユーザーと、編集されるユーザーが同一かどうか判定する
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  #サインインしているユーザーが管理者権限を持っているか判定
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
