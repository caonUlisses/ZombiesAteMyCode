require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:person_one)
  end

  test 'should get index' do
    get people_url, as: :json
    assert_response :success
  end

  test 'should create person' do
    assert_difference('Person.count') do
      post people_url, params: {
        person: {
          age: @person.age,
          gender: @person.gender,
          infected: @person.infected,
          last_location: @person.last_location,
          name: @person.name,
        },
        inventories_attributes: [{
          resource_id: resources(:water).id,
          quantity: 1
        }]
      }, as: :json
    end

    assert_response 201
  end

  test 'should be able to update its location' do
    put location_person_url(@person), params: {
      person: {
        last_location: [0,0]
      }
    }, as: :json

    assert_response 200
  end

  test 'should show person' do
    get person_url(@person), as: :json
    assert_response :success
  end
end
