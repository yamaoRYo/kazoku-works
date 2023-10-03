class ApplicationController < ActionController::Base
    before_action :require_login

    private

    def authorize_user_family_access
        if current_user 
            target_family = @user&.family || @family || current_user.family
            if current_user.family != target_family
                flash[:alert] = t('messages.errors.no_access')
                redirect_to families_path
            end
        end
    end

    protected

    def not_authenticated
        redirect_to login_path, alert: t('messages.errors.login_required')
    end
end
