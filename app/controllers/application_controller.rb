class ApplicationController < ActionController::Base
    before_action :require_login

    private

    def authorize_user_family_access
        target_family = @family || @user.family
        if current_user && current_user.family != target_family
            flash[:alert] = 'アクセス権限がありません'
            redirect_to families_path
        end
    end

    protected

    def not_authenticated
        redirect_to login_path, alert: "Please login first"
    end
end
