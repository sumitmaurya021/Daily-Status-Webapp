class CheckinsController < ApplicationController
  def create
    @checkin = current_user.checkins.build(checkin_params)
  end
end
