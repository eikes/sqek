require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @user = users(:admin)
    sign_in @user
  end

  test "should get index" do
    get :index, params: { locale: :en }
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new, params: { locale: :en }
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, params: {
        locale: :en,
        user:   {
          email:                 'new_user@example.com',
          role:                  'user',
          password:              '123321123',
          password_confirmation: '123321123'
        }
      }
    end

    assert_redirected_to users_path
  end

  test "should get edit" do
    get :edit, params: { locale: :en, id: @user }
    assert_response :success
  end

  test "should update user" do
    patch :update, params: { locale: :en, id: @user, user: { email: @user.email } }
    assert_redirected_to users_path
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, params: { locale: :en, id: @user }
    end

    assert_redirected_to users_path
  end
end
