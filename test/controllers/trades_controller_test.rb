require 'test_helper'

class TradesControllerTest < ActionDispatch::IntegrationTest
  test 'should have valid params' do
    post trades_url, params: { 
      trade: { 
        trader_id: 1
      } 
    }, as: :json

    assert_response 422
  end

  test 'should perform when points match' do
    post trades_url, params: { 
      sender: {
        id: people(:person_one).id,
        resources: [{
          id: resources(:water).id,
          quantity: 1
        }]
      },
      receiver: {
        id: people(:person_two).id,
        resources: [{
          id: resources(:water).id,
          quantity: 1
        }]
      }
    }, as: :json

    assert_response 201
  end

  test 'should not allow trade with zombies' do
    post trades_url, params: { 
      sender: {
        id: people(:zombie_one).id,
        resources: [{
          id: resources(:water).id,
          quantity: 1
        }]
      },
      receiver: {
        id: people(:person_one).id,
        resources: [{
          id: resources(:water).id,
          quantity: 1
        }]
      }
    }, as: :json

    assert_response 422
  end

  test 'should not allow trade when points do not match' do
    post trades_url, params: { 
      sender: {
        id: people(:zombie_one).id,
        resources: [{
          id: resources(:water).id,
          quantity: 2
        }]
      },
      receiver: {
        id: people(:person_one).id,
        resources: [{
          id: resources(:water).id,
          quantity: 1
        }]
      }
    }, as: :json

    assert_response 422
  end

  test 'should not allow trade when resources are not to be found' do
    post trades_url, params: { 
      sender: {
        id: people(:zombie_one).id,
        resources: [{
          id: resources(:ammunition).id,
          quantity: 1
        }]
      },
      receiver: {
        id: people(:person_one).id,
        resources: [{
          id: resources(:ammunition).id,
          quantity: 1
        }]
      }
    }, as: :json

    assert_response 422
  end

  test 'should not allow trade with same person' do
    post trades_url, params: { 
      sender: {
        id: people(:person_one).id,
        resources: [{
          id: resources(:water).id,
          quantity: 1
        }]
      },
      receiver: {
        id: people(:person_one).id,
        resources: [{
          id: resources(:water).id,
          quantity: 1
        }]
      }
    }, as: :json

    assert_response 422
  end
end
