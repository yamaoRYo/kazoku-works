class InvitationsController < ApplicationController
  def new
    @family = Family.find(params[:family_id])
  end

  def create
    @family = Family.find(params[:family_id])
    if ccurent_user == @family.admin
      invitation = @family.invite_user
      invitation_url = accept_invitation_url(invitation.token)
      LineNotifier.new.send_message(@family.admin.line_user_id, "招待URL: #{inbitation_url}")
      redirect_to family_path(@family), notice: '招待URLを送信しました'
    else
      redirect_to family_path(@family), alert: '管理者以外は招待できません'
    end
  end

  def accept
    @invitation = Invitation.find_by!(token: params[:id])
    if @invitation
      session[:invitation_token] = @invitation.token
      redirect_to new_user_resistration_url
    else
      redirect_to root_url, alert: '招待URLが無効です'
    end
  end
end
