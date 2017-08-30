class SessionsController < ApplicationController
  def new

  end

  def create
    # フォームから送信されたemailとパスワードでテーブルからデータを引っ張ってくる
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user #サインインしていない状態でアクセスしようとしたページに飛ぶ
    else
      flash.now[:error] = '入力されたメールアドレス、あるいはパスワードが違います。'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
