class Dto::Trade
  attr_accessor :sender, :receiver, :sent_items, :received_items

  def received_points
    calculate(received_items)
  end

  def sent_points
    calculate(sent_items)
  end

  def sent_ids
    sent_items.map { |item| item.id }
  end

  def send
    sent_items.each do |item|
      sender.withdraw(item.id, item.quantity)
    end
  end

  def receive
    received_items.each do |item|
      receiver.receive(item.id, item.quantity)
    end
  end

  private

  def calculate(items)
    items.reduce(0) { |value, i| value + (i.resource.value * i.quantity) }
  end
end
