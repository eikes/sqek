require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @berlin = cities(:berlin)
  end

  test "should get index" do
    get :index, params: { locale: :en }
    assert_response :success
    assert_not_nil assigns(:cities)
  end

  test "unauthenticated should not get new" do
    get :new, params: { locale: :en }
    assert_response :redirect
  end

  test "authenticated should get new" do
    sign_in users(:admin)
    get :new, params: { locale: :en }
    assert_response :success
  end

  test "should create city" do
    sign_in users(:admin)
    assert_difference('City.count') do
      post :create, params: {
        locale: :en,
        city:   {
          body: @berlin.body,
          lat:  @berlin.lat,
          lng:  @berlin.lng,
          name: @berlin.name
        }
      }
    end

    assert_redirected_to city_path(assigns(:city))
  end

  test "should show city" do
    get :show, params: { locale: :en, id: @berlin }
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:admin)
    get :edit, params: { locale: :en, id: @berlin }
    assert_response :success
  end

  test "should update city" do
    sign_in users(:berlin_user)
    patch :update, params: {
      locale: :en,
      id:     @berlin,
      city:   {
        body: @berlin.body,
        lat:  @berlin.lat,
        lng:  @berlin.lng,
        name: @berlin.name
      }
    }
    assert_redirected_to city_squats_path(@berlin)
  end

  test "should destroy city" do
    sign_in users(:admin)
    assert_difference('City.count', -1) do
      delete :destroy, params: { locale: :en, id: @berlin }
    end

    assert_redirected_to cities_path
  end
end
