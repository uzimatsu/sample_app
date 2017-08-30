module SessionsHelper

  def sign_in(user)
    #生成した記憶トークンを挿入
    remember_token = User.new_remember_token
    #永続化クッキーの設定（20年）
    cookies.permanent[:remember_token] = remember_token
    #ユーザーの記憶トークンの更新
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    #サインインユーザーの設定
    self.current_user = user
  end

#サインイン判定
  def signed_in?
    !current_user.nil?
  end

#サインインしているユーザーを決定
  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

#使用しているユーザーとサインインしているユーザーが一致しているか判定
  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "あなたはまだログインしていません"
    end
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end
