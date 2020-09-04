class Trader
  def perform(sender, receiver)
    set_params(sender, receiver)

    if @sender.id == @receiver.id
      raise 'You cannot trade with yourself!'
    end

    factory(@sender, @receiver, @sender_items, @receiver_items)

    if !points_match?
      raise 'The points does not add up.'
    end

    process(@trade)
  end

  private

  def set_params(sender, receiver)
    @sender = Person.find(sender[:id])
    @receiver = Person.find(receiver[:id])
    @sender_items = map_items(sender[:resources])
    @receiver_items = map_items(receiver[:resources])
  end

  def map_items(resources)
    resources.map { |resource|
      Dto::TradeItem.new(
        resource[:id],
        Resource.find(resource[:id]),
        resource[:quantity]
      )
    }
  end

  def factory(sender, receiver, sent_items, received_items)
    @trade = Builder::TradeBuilder.new
      .set_sender(sender)
      .set_receiver(receiver)
      .set_sent_items(sent_items)
      .set_received_items(received_items)
      .build
  end

  def points_match?
    @trade.sent_points === @trade.received_points
  end

  def process(trade)
    ActiveRecord::Base.transaction do
      trade.send
      trade.receive
    end
  end
end
