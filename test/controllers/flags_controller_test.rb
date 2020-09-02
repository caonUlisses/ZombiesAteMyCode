require 'test_helper'

class FlagsControllerTest < ActionDispatch::IntegrationTest
  test 'should flag a person' do
    assert_difference('Flag.count') do
      post flags_url, params: { 
        flag: { 
          flagged_id: people(:person_one).id, flagger_id: people(:person_four).id 
        } 
      }, as: :json
    end

    assert_response 201
  end

  test 'should confirm a person on third flag' do
    new_zombie = people(:person_four)

    assert_equal new_zombie.confirmed?, false

    post flags_url, params: { 
      flag: { 
        flagged_id: new_zombie.id, flagger_id: people(:person_three).id
      } 
    }, as: :json

    new_zombie.health_check
    assert_equal new_zombie.confirmed?, true
  end
end
