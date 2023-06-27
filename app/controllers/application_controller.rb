class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Deviseが提供するデフォルトのユーザー情報以外を、ストロングパラメーターで許可することができる。
  # configure設定する permitted許可される
  # before_action :authenticate_user! # ログインしていないユーザーをログインページの画面に促すことができる。

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD'] # 環境変数を読み込む記述に変更
      # Basic認証を導入
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday])
  end # []キーの内容の保存をpermitメソッドで許可している。
  # sanitizer消毒剤 permit許可
end

# 全てのコントローラーが継承しているファイル
# ここに処理を記述しておくことで、全てのコントローラーで共通となる処理を作ることができる。
