require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @city = cities(:berlin)
    @comment = comments(:one)
  end

  test "should get index" do
    get :index, locale: :en
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should get new" do
    get :new, locale: :en, comment: {commentable_id: @city.id, commentable_type: 'City'}
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, locale: :en, comment: { body: @comment.body, commentable_id: @comment.commentable_id, commentable_type: @comment.commentable_type, email: @comment.email, published: @comment.published, title: @comment.title }
    end

    assert_redirected_to comment_path(assigns(:comment))
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
    patch :update, locale: :en, id: @comment, comment: { body: @comment.body, commentable_id: @comment.commentable_id, commentable_type: @comment.commentable_type, email: @comment.email, published: @comment.published, title: @comment.title }
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
