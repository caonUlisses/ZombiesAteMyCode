require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test 'a person should be registered as healthy' do
    person = Person.new()

    assert_equal person.healthy?, true
  end

  test 'a zombie should be infected' do
    assert_equal people(:zombie_one).infected?, true
  end

  test 'a person should be able to update its location' do
    person = people(:person_one)
    first_location = person.last_location

    person.update!(last_location: [
      Faker::Address.latitude,
      Faker::Address.longitude
    ])

    assert_not_equal first_location, person.last_location
  end

  test 'a person can be flagged as infected' do
    people(:person_one).confirmed!

    assert_equal people(:person_one).infected?, true
  end
end
