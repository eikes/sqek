require 'test_helper'

class CitiesControllerTest < ActionController::TestCase

  setup do
    @city = cities(:berlin)
  end

  test "should get index" do
    get :index, locale: :en
    assert_response :success
    assert_not_nil assigns(:cities)
  end

  test "unauthenticated should not get new" do
    get :new, locale: :en
    assert_response :redirect
  end

  test "authenticated should get new" do
    create_user_and_sign_in
    get :new, locale: :en
    assert_response :success
  end

  test "should create city" do
    create_user_and_sign_in
    assert_difference('City.count') do
      post :create, locale: :en, city: { body: @city.body, lat: @city.lat, lng: @city.lng, name: @city.name }
    end

    assert_redirected_to city_path(assigns(:city))
  end

  test "should show city" do
    get :show, locale: :en, id: @city
    assert_response :success
  end

  test "should get edit" do
    create_user_and_sign_in
    get :edit, locale: :en, id: @city
    assert_response :success
  end

  test "should update city" do
    create_user_and_sign_in
    patch :update, locale: :en, id: @city, city: { body: @city.body, lat: @city.lat, lng: @city.lng, name: @city.name }
    assert_redirected_to city_squats_path(@city)
  end

  test "should destroy city" do
    create_user_and_sign_in
    assert_difference('City.count', -1) do
      delete :destroy, locale: :en, id: @city
    end

    assert_redirected_to cities_path
  end
end
