require 'test_helper'

class PassengersControllerTest < ActionController::TestCase
  setup do
    @passenger = passengers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:passengers)
  end

  test "should create passenger" do
    assert_difference('Passenger.count') do
      post :create, passenger: { flight_id: @passenger.flight_id, person_id: @passenger.person_id }
    end

    assert_response 201
  end

  test "should show passenger" do
    get :show, id: @passenger
    assert_response :success
  end

  test "should update passenger" do
    put :update, id: @passenger, passenger: { flight_id: @passenger.flight_id, person_id: @passenger.person_id }
    assert_response 204
  end

  test "should destroy passenger" do
    assert_difference('Passenger.count', -1) do
      delete :destroy, id: @passenger
    end

    assert_response 204
  end
end
