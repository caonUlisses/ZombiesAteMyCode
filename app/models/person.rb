class Person < ApplicationRecord
  FLAG_LIMIT = 3

  has_many :inventories
  has_many :resources, through: :inventories
  accepts_nested_attributes_for :inventories
  accepts_nested_attributes_for :resources

  has_many :flags, class_name: 'Flag', foreign_key: 'flagged_id'

  enum infected: { healthy: 0, confirmed: 1 }

  def health_check
    confirmed! if flags.count >= Person::FLAG_LIMIT
  end

  def withdraw(resource_id, quantity)
    inventory = inventories.where(resource_id: resource_id).first
    inventory.quantity -= quantity
    return inventory.save if inventory.quantity > 0

    inventory.destroy!
  end

  def receive(resource_id, quantity)
    inventory = inventories.where(resource_id: resource_id).first

    return inventories.create(resource_id: resource_id, quantity: quantity) if !inventory.present?

    inventory.quantity += quantity
    inventory.save
  end

  def totalize(resource_ids)
    Inventory.totalize(id, resource_ids)
  end

  def self.healthy_total
    Person.healthy.count
  end

  def self.zombie_total
    Person.confirmed.count
  end
end
