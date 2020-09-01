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
          name: @person.name
        }
      }, as: :json
    end

    assert_response 201
  end

  test 'should show person' do
    get person_url(@person), as: :json
    assert_response :success
  end
end
