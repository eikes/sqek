require 'test_helper'

class CommentNewFormTest < ActiveSupport::TestCase

  def setup
    @form = CommentNewForm.new(Comment.new)
    @valid_params = {
      title:            'Title',
      body:             'Lorem Ipsum',
      email:            'mail@example.com',
      commentable_id:   '1',
      commentable_type: 'Squat'
    }
  end

  test "allow valid params" do
    @form.validate @valid_params
    assert_empty @form.errors
  end

  test "disallow empty title" do
    @form.validate @valid_params.merge(title: '')
    assert_includes @form.errors[:title], "can't be blank"
  end

  test "disallow empty body" do
    @form.validate @valid_params.merge(body: '')
    assert_includes @form.errors[:body], "can't be blank"
  end

  test "disallow empty email" do
    @form.validate @valid_params.merge(email: '')
    assert_includes @form.errors[:email], "can't be blank"
  end

  test "disallow empty commentable_id" do
    @form.validate @valid_params.merge(commentable_id: '')
    assert_includes @form.errors[:commentable_id], "can't be blank"
  end

  test "disallow non numeric commentable_id" do
    @form.validate @valid_params.merge(commentable_id: 'X')
    assert_includes @form.errors[:commentable_id], "is not a number"
  end

  test "disallow empty commentable_type" do
    @form.validate @valid_params.merge(commentable_type: '')
    assert_includes @form.errors[:commentable_type], "can't be blank"
  end

  test "disallow other commentable_type" do
    @form.validate @valid_params.merge(commentable_type: 'Something')
    assert_includes @form.errors[:commentable_type], "is not included in the list"
  end

end
