require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @city = cities(:berlin)
    @comment = comments(:spam)
    @city_user = users(:berlin_user)
    @not_city_user = users(:london_user)
    @valid_comment_params = {
      title:            @comment.title,
      body:             @comment.body,
      commentable_type: @comment.commentable_type,
      commentable_id:   @comment.commentable_id,
      email:            @comment.email,
      published:        @comment.published
    }
  end

  test "should get index" do
    get :index, params: { locale: :en }
    assert_response :success
    assert_not_nil assigns(:comments)
    assert_includes(assigns(:comments), @comment)
  end

  test "should bulk_delete" do
    sign_in users(:admin)
    assert_difference('Comment.count', -2) do
      post :bulk_delete, params: {
        locale: :en,
        comment_ids: [comments(:berlin_comment).id, comments(:london_comment).id]
      }
    end
    assert_redirected_to comments_path
  end

  test "should get new" do
    sign_in @not_city_user
    get :new, params: {
      locale: :en,
      comment: {
        commentable_id:   @city.id,
        commentable_type: 'City'
      }
    }
    assert_response :success
  end

  test "should create comment" do
    sign_in @not_city_user
    assert_difference('Comment.count') do
      post :create, params: {
        locale:  :en,
        comment: @valid_comment_params
      }
    end

    assert_redirected_to comment_path(assigns(:comment))
  end

  test "#create should send mail" do
    sign_in @not_city_user
    assert_difference('ActionMailer::Base.deliveries.count') do
      post :create, params: {
        locale:  :en,
        comment: @valid_comment_params
      }
    end
    comment_notification = ActionMailer::Base.deliveries.last
    assert_includes(comment_notification.to, @city_user.email)
    assert_not_includes(comment_notification.to, @not_city_user.email)
  end

  test "should show comment" do
    get :show, params: { locale: :en, id: @comment }
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:admin)
    get :edit, params: { locale: :en, id: @comment }
    assert_response :success
  end

  test "should update comment" do
    sign_in users(:admin)
    patch :update, params: {
      locale:  :en,
      id:      @comment,
      comment: @valid_comment_params
    }
    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should destroy comment" do
    sign_in users(:admin)
    assert_difference('Comment.count', -1) do
      delete :destroy, params: { locale: :en, id: @comment }
    end

    assert_redirected_to comments_path
  end
end
