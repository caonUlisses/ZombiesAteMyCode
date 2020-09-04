class Inventory < ApplicationRecord
  belongs_to :person
  belongs_to :resource

  scope :by_person, ->(person_id) { where('person_id = ?', person_id)}
  scope :by_resources, ->(resource_ids) { where('resource_id in (?)', resource_ids) }
  scope :with_resources, -> { includes(:resource).references(:resources) }

  def self.totalize(person_id, resource_ids)
    Inventory
      .with_resources
      .by_person(person_id)
      .by_resources(resource_ids)
      .sum('inventories.quantity * resources.value')
  end
end
