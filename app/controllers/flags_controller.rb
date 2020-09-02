class FlagsController < ApplicationController

  api :POST, 'flags', 'Flag a person as infected'
  param :flagger_id, String, desc: 'Who\'s flagging'
  param :flagged_id, String, desc: 'Who\'s being flagged'
  def create
    @flag = Flag.new(flag_params)

    if @flag.save 
      @flag.process
      render json: @flag.flagged, status: :created, location: @flag
    else
      render json: @flag.errors, status: :unprocessable_entity
    end
  end

  private

  def flag_params
    params
      .require(:flag)
      .permit(:flagger_id, :flagged_id)
  end
end
