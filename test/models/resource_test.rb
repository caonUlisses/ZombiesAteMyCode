require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
  test 'water should be more valuable than ammunition' do
    water = resources(:water)
    ammunition = resources(:ammunition)

    assert_equal water.description, 'water'
    assert_equal ammunition.description, 'ammunition'
    assert water.value > ammunition.value
  end
end
