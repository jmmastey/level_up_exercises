require 'test_helper'

class FlightsControllerTest < ActionController::TestCase
  setup do
    @flight = flights(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:flights)
  end

  test "should create flight" do
    assert_difference('Flight.count') do
      post :create, flight: { arrival_city: @flight.arrival_city, arrival_time: @flight.arrival_time, departure_city: @flight.departure_city, departure_time: @flight.departure_time, plane_id: @flight.plane_id }
    end

    assert_response 201
  end

  test "should show flight" do
    get :show, id: @flight
    assert_response :success
  end

  test "should update flight" do
    put :update, id: @flight, flight: { arrival_city: @flight.arrival_city, arrival_time: @flight.arrival_time, departure_city: @flight.departure_city, departure_time: @flight.departure_time, plane_id: @flight.plane_id }
    assert_response 204
  end

  test "should destroy flight" do
    assert_difference('Flight.count', -1) do
      delete :destroy, id: @flight
    end

    assert_response 204
  end
end
