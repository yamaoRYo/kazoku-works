class InvitationsController < ApplicationController

  skip_before_action :require_login, only: [:accept]

  def new
    @family = Family.find(params[:family_id])
    @invitation = @family.invitations.build
    @invitation_url = session.delete(:invitation_url)
  end

  def create
    @family = Family.find(params[:family_id])
    if current_user == @family.admin
      invitation = @family.invite_user
      invitation_url = accept_invitation_url(invitation.token)
      session[:invitation_url] = invitation_url
      flash[:notice] = t('messages.success.invitation_url')
      redirect_to new_family_invitation_path(@family)
    else
      flash[:alert] = t('messages.errors.no_access')
      redirect_to family_path(@family)
    end
  end

  def accept
    invitation = Invitation.find_by(token: params[:id])
  
    if invitation && invitation.expires_at > Time.current
      session[:invitation_token] = invitation.token
      redirect_to new_user_path
    else
      flash[:alert] = t('messages.errors.invalid_invitation')
      redirect_to root_path
    end
  end
  

  private

  def invitation_params
    params.permit(:family_id)
  end
end