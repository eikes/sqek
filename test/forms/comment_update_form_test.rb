require 'test_helper'

class CommentUpdateFormTest < ActiveSupport::TestCase

  def setup
    @form = CommentUpdateForm.new(Comment.new)
    @valid_params = {
      title:            'Title',
      body:             'Lorem Ipsum',
      email:            'mail@example.com'
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

end
