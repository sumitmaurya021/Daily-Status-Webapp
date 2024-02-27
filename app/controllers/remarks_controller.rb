class RemarksController < ApplicationController
  def new
    @status = Status.find(params[:status_id])
  end
  def create
    @status = Status.find_by(id: params[:status_id])

    if @status.nil?
      redirect_to statuses_path, alert: 'Status not found'
    end

    @remark = @status.remarks.build(remark_params)

    if @remark.save
      redirect_to statuses_path, notice: 'Remarks added successfully'
    else
      # Handle validation errors here
      render :new
    end
  end

  private

  def remark_params
    params.require(:remark).permit(:remark)
  end
end
