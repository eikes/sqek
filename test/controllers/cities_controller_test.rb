require 'test_helper'

class CitiesControllerTest < ActionController::TestCase

  setup do
    @city = cities(:berlin)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cities)
  end

  test "unauthenticated should not get new" do
    get :new
    assert_response :redirect
  end

  test "authenticated should get new" do
    create_user_and_sign_in
    get :new
    assert_response :success
  end

  test "should create city" do
    create_user_and_sign_in
    assert_difference('City.count') do
      post :create, city: { body: @city.body, lat: @city.lat, lng: @city.lng, name: @city.name }
    end

    assert_redirected_to city_path(assigns(:city))
  end

  test "should show city" do
    get :show, id: @city
    assert_response :success
  end

  test "should get edit" do
    create_user_and_sign_in
    get :edit, id: @city
    assert_response :success
  end

  test "should update city" do
    create_user_and_sign_in
    patch :update, id: @city, city: { body: @city.body, lat: @city.lat, lng: @city.lng, name: @city.name }
    assert_redirected_to city_path(assigns(:city))
  end

  test "should destroy city" do
    create_user_and_sign_in
    assert_difference('City.count', -1) do
      delete :destroy, id: @city
    end

    assert_redirected_to cities_path
  end
end
