require 'test_helper'

class PlaneTypesControllerTest < ActionController::TestCase
  setup do
    @plane_type = plane_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plane_types)
  end

  test "should create plane_type" do
    assert_difference('PlaneType.count') do
      post :create, plane_type: { name: @plane_type.name, seat_count: @plane_type.seat_count }
    end

    assert_response 201
  end

  test "should show plane_type" do
    get :show, id: @plane_type
    assert_response :success
  end

  test "should update plane_type" do
    put :update, id: @plane_type, plane_type: { name: @plane_type.name, seat_count: @plane_type.seat_count }
    assert_response 204
  end

  test "should destroy plane_type" do
    assert_difference('PlaneType.count', -1) do
      delete :destroy, id: @plane_type
    end

    assert_response 204
  end
end
