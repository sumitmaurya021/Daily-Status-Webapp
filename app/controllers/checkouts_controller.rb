class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    @checkout = current_user.checkouts.build(checkout_params)
    if @checkout.save
      Log.create(user_id: current_user.id, timestamp: Time.now, action: 'check-out')
      AdminMailer.check_out_email(current_user).deliver_now
      redirect_to root_path, notice: 'Check-out successful!'
    else
      redirect_to root_path, alert: 'Check-out failed!'
    end
  end


  def process_checkouts
    checkout = current_user.checkouts.new(checked_out_at: Time.current)
    if checkout.save
      Log.create(user_id: current_user.id, timestamp: Time.now, action: 'check-out')
      AdminMailer.check_out_email(current_user).deliver_now
      redirect_to root_path, notice: 'Check-out successful!'
    else
      redirect_to root_path, alert: 'Check-out failed!'
    end
  end


  private
  def checkout_params
    params.require(:checkout).permit(:checked_out_at)
  end
end
