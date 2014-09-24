require 'test_helper'

class EventDatesControllerTest < ActionController::TestCase
  setup do
    @event_date = event_dates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_dates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_date" do
    assert_difference('EventDate.count') do
      post :create, event_date: { date_time: @event_date.date_time, event_id: @event_date.event_id, venue_id: @event_date.venue_id }
    end

    assert_redirected_to event_date_path(assigns(:event_date))
  end

  test "should show event_date" do
    get :show, id: @event_date
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_date
    assert_response :success
  end

  test "should update event_date" do
    patch :update, id: @event_date, event_date: { date_time: @event_date.date_time, event_id: @event_date.event_id, venue_id: @event_date.venue_id }
    assert_redirected_to event_date_path(assigns(:event_date))
  end

  test "should destroy event_date" do
    assert_difference('EventDate.count', -1) do
      delete :destroy, id: @event_date
    end

    assert_redirected_to event_dates_path
  end
end
