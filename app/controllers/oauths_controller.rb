class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false
  
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    # キャンセルした場合はparams[:denied]が存在するので、条件分岐で処理を分ける
    if auth_params[:denied].present?
      redirect_to root_path, alert: 'ログインに失敗しました'
    else
      if @user = login_from(provider)
        redirect_to families_path, notice: 'ログインしました'
      else
        create_user_from(provider)
        redirect_to families_path, notice: 'ログインしました'
      end
    end
  end


  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end

  # ログインしている場合はそのまま、していない場合は作成する
  def create_user_from(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
  end
end
