class SessionsController < ApplicationController
    skip_before_action :authenticate, only: :create

    # ログイン状態にする
    def create
        # OmniAuth::AuthHash Githubから渡されたログイン情報やOAuthのアクセストークン
        user = User.find_or_create_from_auth_hash!(request.env["omniauth.auth"])
        # ログイン状態にする
        session[:user_id] = user.id
        # セッションに格納されrequestごとにリセットされる特殊なメッセージ
        redirect_to root_path, notice: 'ログインしました'
    end

    # ログアウト状態にする
    def destroy
        reset_session
        redirect_to root_path, notice: "ログアウトしました"
    end
end
