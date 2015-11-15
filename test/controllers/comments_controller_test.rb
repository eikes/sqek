require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  setup do
    @city = cities(:berlin)
    @comment = comments(:one)
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
    get :index, locale: :en
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should get new" do
    get :new, locale: :en, comment: {
      commentable_id:   @city.id,
      commentable_type: 'City'
    }
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create,
           locale:  :en,
           comment: @valid_comment_params
    end

    assert_redirected_to comment_path(assigns(:comment))
  end

  test "#create should send mail" do
    assert_difference('ActionMailer::Base.deliveries.count') do
      post :create,
           locale:  :en,
           comment: @valid_comment_params
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
    create_user_and_sign_in
    get :edit, locale: :en, id: @comment
    assert_response :success
  end

  test "should update comment" do
    create_user_and_sign_in
    patch :update,
          locale:  :en,
          id:      @comment,
          comment: @valid_comment_params
    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should destroy comment" do
    create_user_and_sign_in
    assert_difference('Comment.count', -1) do
      delete :destroy, locale: :en, id: @comment
    end

    assert_redirected_to comments_path
  end
end
