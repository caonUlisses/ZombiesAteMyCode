class Person < ApplicationRecord
  enum infected: { healthy: 0, confirmed: 1 }
end
