require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @city = cities(:berlin)
    @comment = comments(:spam)
    @city_comment = comments(:berlin_comment)
    @not_city_comment = comments(:london_comment)
    @admin = users(:admin)
    @city_user = users(:berlin_user)
    @not_city_user = users(:london_user)
    @invalid_comment_params = {
      title:            '',
      body:             '',
      email:            '',
      commentable_type: 'City',
      commentable_id:   @city.id
    }
    @valid_comment_params = {
      title:            'New Title',
      body:             'New body',
      commentable_type: 'City',
      commentable_id:   @city.id,
      email:            'some@mail.de'
    }
  end

  test "should get index" do
    get :index, locale: :en
    assert_response :success
    assert_not_nil assigns(:comments)
    assert_includes(assigns(:comments), @comment)
  end

  test "should bulk_delete" do
    sign_in @admin
    assert_difference('Comment.count', -2) do
      post :bulk_delete, locale: :en, comment_ids: [@city_comment.id, @not_city_comment.id]
    end
    assert_redirected_to comments_path
  end

  test "anonymous should not bulk_delete" do
    assert_difference('Comment.count', 0) do
      post :bulk_delete, locale: :en, comment_ids: [@city_comment.id, @not_city_comment.id]
    end
    assert_redirected_to root_path
  end

  test "should get new" do
    sign_in @not_city_user
    get :new, locale: :en, comment: {
      commentable_id:   @city.id,
      commentable_type: 'City'
    }
    assert_response :success
    assert_select "form[action='/en/comments']" do
      assert_select "input[name='comment[title]']"
    end
  end

  test "should create comment" do
    sign_in @not_city_user
    assert_difference('Comment.count') do
      post :create, locale: :en, comment: @valid_comment_params
    end
    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should render new with invalid params posted to create" do
    sign_in @not_city_user
    post :create, locale: :en, comment: @invalid_comment_params
    assert_response :success
    assert_template :new
  end

  test "#create should send mail" do
    sign_in @not_city_user
    assert_difference('ActionMailer::Base.deliveries.count') do
      post :create, locale:  :en, comment: @valid_comment_params
    end
    comment_notification = ActionMailer::Base.deliveries.last
    assert_includes(comment_notification.to, @city_user.email)
    assert_not_includes(comment_notification.to, @not_city_user.email)
  end

  test "should show comment" do
    get :show, locale: :en, id: @comment
    assert_response :success
  end

  test "should get edit" do
    sign_in @admin
    get :edit, locale: :en, id: @comment
    assert_response :success
    assert_select "form[action='/en/comments/#{@comment.id}']" do
      assert_select "input[name='comment[title]']"
    end
  end

  test "anonymous should not get edit, but redirect home" do
    get :edit, locale: :en, id: @comment
    assert_redirected_to root_path
  end

  test "should update comment" do
    sign_in @admin
    patch :update, locale: :en, id: @comment, comment: @valid_comment_params
    assert_redirected_to comment_path(assigns(:comment))
  end

  test "update should render edit when params are invalid" do
    sign_in @admin
    patch :update, locale: :en, id: @comment, comment: @invalid_comment_params
    assert_response :success
    assert_template :edit
  end

  test "anonymouse should not update comment" do
    patch :update, locale: :en, id: @comment, comment: @valid_comment_params
    assert_redirected_to root_path
  end

  test "should destroy comment" do
    sign_in @admin
    assert_difference('Comment.count', -1) do
      delete :destroy, locale: :en, id: @comment
    end
    assert_redirected_to comments_path
  end

  test "anonymous should not destroy comment" do
    assert_difference('Comment.count', 0) do
      delete :destroy, locale: :en, id: @comment
    end
    assert_redirected_to root_path
  end
end
