class Inventory < ApplicationRecord
  belongs_to :person
  belongs_to :resource

  scope :by_person, ->(person_id) { where(person_id: person_id)}
  scope :by_resources, ->(resource_ids) { where('resource_id in (?)', resource_ids) }
  scope :with_resources, -> { includes(:resource).references(:resources) }
  scope :with_person, -> { includes(:person).references(:people) }
  scope :healthy, -> { where('people.infected = 0') }
  scope :total, -> { with_resources.sum('inventories.quantity * resources.value') }

  def self.totalize(person_id, resource_ids)
    Inventory
      .by_person(person_id)
      .by_resources(resource_ids)
      .total
  end

  def self.current_position
    Inventory.with_person.healthy
  end

  def self.lost_points
    Inventory
      .with_person
      .where('people.infected = 1')
      .total
  end

  def self.average_resources
    Inventory
      .with_resources
      .with_person.healthy
      .group('resources.description').group('people.name').average(:quantity)
  end
end
