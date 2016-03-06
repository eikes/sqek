require 'test_helper'

class SquatsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @city = cities(:berlin)
    @squat = squats(:berlin_squat)
    @city_user = users(:berlin_user)
    @not_city_user = users(:london_user)
    @valid_squat_params = {
      name:               @squat.name,
      body:               @squat.body,
      lat:                @squat.lat,
      lng:                @squat.lng,
      periods_attributes: [ { start_year: 2000 } ],
      tags:               []
    }
  end

  test "should get index" do
    get :index,
        locale:  :en,
        city_id: @city
    assert_response :success
    assert_not_nil assigns(:squats)
  end

  test "should get new" do
    sign_in users(:admin)
    get :new,
        locale:  :en,
        city_id: @city
    assert_response :success
  end

  test "should create squat" do
    sign_in users(:admin)
    assert_difference('Squat.count') do
      post :create,
           locale:  :en,
           city_id: @city,
           squat:   @valid_squat_params
    end
    assert_redirected_to city_squat_path(@city, assigns(:squat))
  end

  test "anonymous cannot create squat when no email is provided" do
    assert_no_difference('Squat.count') do
      post :create,
           locale:  :en,
           city_id: @city,
           squat:   @valid_squat_params
    end
  end

  test "anonymous can create squat when email is provided" do
    assert_difference('Squat.count') do
      post :create,
           locale:  :en,
           city_id: @city,
           squat:   @valid_squat_params.merge({external_user_email: 'someone@example.com'})
    end
    assert_redirected_to city_squat_path(@city, assigns(:squat))
  end

  test "#create should send mail when anonymous user creates squat" do
    assert_difference('ActionMailer::Base.deliveries.count') do
      post :create,
           locale:  :en,
           city_id: @city,
           squat:   @valid_squat_params.merge({external_user_email: 'someone@example.com'})
    end
    squat_notification = ActionMailer::Base.deliveries.last
    assert_includes(squat_notification.to, @city_user.email)
    assert_not_includes(squat_notification.to, @not_city_user.email)
  end

  test "#create should not send mail when registered user creates squat" do
    sign_in users(:admin)
    assert_no_difference('ActionMailer::Base.deliveries.count') do
      post :create,
           locale:  :en,
           city_id: @city,
           squat:   @valid_squat_params
    end
  end

  test "should show squat" do
    get :show,
        locale:  :en,
        city_id: @city,
        id:      @squat
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:admin)
    get :edit,
        locale:  :en,
        city_id: @city,
        id:      @squat
    assert_response :success
  end

  test "should update squat" do
    sign_in users(:admin)
    patch :update,
          locale:  :en,
          city_id: @city,
          id:      @squat,
          squat:   @valid_squat_params.merge(name: 'New Name')
    assert @squat.reload.name == 'New Name'
    assert_redirected_to city_squats_path(@city, anchor: @squat.slug)
  end

  test "should destroy squat" do
    sign_in users(:admin)
    assert_difference('Squat.count', -1) do
      delete :destroy,
             locale:  :en,
             city_id: @city,
             id:      @squat
    end

    assert_redirected_to city_squats_path(@city)
  end
end
