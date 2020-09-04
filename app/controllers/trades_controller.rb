class TradesController < ApplicationController
  def trade
    trade = Trader.new.perform(params[:sender], params[:receiver])

    render json: 'The exchange was successful!', status: :created, location: @trades
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  private

  def trade_params
    params
      .require(:trade)
      .permit(
        sender: [
          :id, resources: resources_params
        ],
        receiver: [
          :id, resources: resources_params
        ]
      )
  end

  def resources_params
    %[id quantity]
  end
end
