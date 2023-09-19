class ApplicationController < ActionController::Base
    before_action :require_login

    private

    def authorize_user_family_access
        if current_user 
            target_family = @user&.family || @family || current_user.family
            if current_user.family != target_family
                flash[:alert] = 'アクセス権限がありません'
                redirect_to families_path
            end
        end
    end

    protected

    def not_authenticated
        redirect_to login_path, alert: "Please login first"
    end
end
