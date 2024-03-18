class CheckinsController < ApplicationController
  def create
    @checkin = current_user.checkins.build(checkin_params)
  end

  private
  def checkin_params
    params.require(:checkin).permit(:user_id, :checked_in_at)
  end
end
