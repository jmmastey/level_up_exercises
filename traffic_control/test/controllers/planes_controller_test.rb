require 'test_helper'

class PlanesControllerTest < ActionController::TestCase
  setup do
    @plane = planes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:planes)
  end

  test "should create plane" do
    assert_difference('Plane.count') do
      post :create, plane: { plane_type_id: @plane.plane_type_id }
    end

    assert_response 201
  end

  test "should show plane" do
    get :show, id: @plane
    assert_response :success
  end

  test "should update plane" do
    put :update, id: @plane, plane: { plane_type_id: @plane.plane_type_id }
    assert_response 204
  end

  test "should destroy plane" do
    assert_difference('Plane.count', -1) do
      delete :destroy, id: @plane
    end

    assert_response 204
  end
end
