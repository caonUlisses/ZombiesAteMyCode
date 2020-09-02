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
end
