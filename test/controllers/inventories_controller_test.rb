require 'test_helper'

class InventoriesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get inventories_url, as: :json
    assert_response :success
  end
end
