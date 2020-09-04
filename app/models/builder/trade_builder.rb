class Builder::TradeBuilder
  def initialize
    @trade = Dto::Trade.new
  end

  def build
    @trade
  end

  def set_sender(sender)
    raise 'Sender must be healthy' if sender.confirmed?

    @trade.sender = sender
    self
  end

  def set_receiver(receiver)
    raise 'Receiver must be healthy' if receiver.confirmed?

    @trade.receiver = receiver
    self
  end

  def set_sent_items(items)
    @trade.sent_items = items

    if @trade.sender.totalize(resource_ids(items)) <= @trade.sent_points
      raise 'Sender is lacking resources'
    end

    self
  end

  def set_received_items(items)
    @trade.received_items = items

    if @trade.receiver.totalize(resource_ids(items)) <= @trade.received_points
      raise 'Receiver is lacking resources'
    end

    self
  end

  private

  def resource_ids(items)
    items.map { |item| item.id }
  end
end
