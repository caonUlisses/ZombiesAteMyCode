class Flag < ApplicationRecord
  belongs_to :flagger, class_name: 'Person', foreign_key: 'flagger_id'
  belongs_to :flagged, class_name: 'Person', foreign_key: 'flagged_id'

  validates :flagger, uniqueness: { scope: :flagged,
    message: "you cannot flag a person twice" }

  def process
    flagged.health_check
  end
end
