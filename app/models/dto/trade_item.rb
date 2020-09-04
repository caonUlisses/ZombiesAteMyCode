class Dto::TradeItem
  attr_accessor :id, :resource, :quantity

  def initialize(id, item, quantity)
    @id = id
    @resource = item
    @quantity = quantity
  end
end
