require 'test_helper'

class ResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resource = resources(:water)
  end

  test 'should get index' do
    get resources_url, as: :json
    assert_response :success
  end

  test 'should show resource' do
    get resource_url(@resource), as: :json
    assert_response :success
  end
end
