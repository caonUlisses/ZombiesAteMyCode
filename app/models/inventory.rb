class Inventory < ApplicationRecord
  belongs_to :person
  belongs_to :resource
end
