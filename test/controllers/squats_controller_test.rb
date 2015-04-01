require 'test_helper'

class SquatsControllerTest < ActionController::TestCase

  setup do
    @city = cities(:berlin)
    @squat = squats(:kopi)
  end

  test "should get index" do
    get :index, locale: :en, city_id: @city.id
    assert_response :success
    assert_not_nil assigns(:squats)
  end

  test "should get new" do
    create_user_and_sign_in
    get :new, locale: :en, city_id: @city.id
    assert_response :success
  end

  test "should create squat" do
    create_user_and_sign_in
    assert_difference('Squat.count') do
      post :create, locale: :en, city_id: @city.id, squat: {
        body: @squat.body,
        lat: @squat.lat,
        lng: @squat.lng,
        name: @squat.name,
        periods_attributes: [ { start_year: 2000 } ],
        tags: []
      }
    end
    assert_redirected_to city_squat_path(@city, assigns(:squat))
  end

  test "should show squat" do
    get :show, locale: :en, city_id: @city.id, id: @squat
    assert_response :success
  end

  test "should get edit" do
    create_user_and_sign_in
    get :edit, locale: :en, city_id: @city.id, id: @squat
    assert_response :success
  end

  test "should update squat" do
    create_user_and_sign_in
    patch :update, locale: :en, city_id: @city.id, id: @squat, squat: {
      body: @squat.body,
      lat: @squat.lat,
      lng: @squat.lng,
      name: @squat.name,
      periods_attributes: [ { start_year: 2000 } ],
      tags: []
    }
    assert_redirected_to city_squats_path(@city, anchor: @squat.slug)
  end

  test "should destroy squat" do
    create_user_and_sign_in
    assert_difference('Squat.count', -1) do
      delete :destroy, locale: :en, city_id: @city.id, id: @squat
    end

    assert_redirected_to city_squats_path(@city)
  end
end
