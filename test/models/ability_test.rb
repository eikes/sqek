require 'test_helper'

class AbilityTest < ActiveSupport::TestCase

  setup do
    @visitor     = User.new
    @berlin_user = users(:berlin_user)
    @london_user = users(:berlin_user)
    @admin       = users(:admin)

    @visitor_ability     = Ability.new(@visitor)
    @berlin_user_ability = Ability.new(@berlin_user)
    @london_user_ability = Ability.new(@london_user)
    @admin_ability       = Ability.new(@admin)

    @berlin = cities(:berlin)
    @london = cities(:london)

    @berlin_squat = squats(:berlin_squat)
    @london_squat = squats(:london_squat)

    @berlin_comment = comments(:berlin_comment)
    @london_comment = comments(:london_comment)
  end

  # Visitor city

  test "visitor cannot create City" do
    assert @visitor_ability.cannot?(:create, City)
  end

  test "visitor can read City" do
    assert @visitor_ability.can?(:read, @berlin)
  end

  test "visitor cannot update City" do
    assert @visitor_ability.cannot?(:update, @berlin)
  end

  test "visitor cannot destroy City" do
    assert @visitor_ability.cannot?(:destroy, @berlin)
  end

  # User city

  test "user cannot create City" do
    assert @berlin_user_ability.cannot?(:create, City)
  end

  test "user can read City" do
    assert @berlin_user_ability.can?(:read, @berlin)
  end

  test "user can update own City" do
    assert @berlin_user_ability.can?(:update, @berlin)
  end

  test "user cannot update other City" do
    assert @berlin_user_ability.cannot?(:update, @london)
  end

  test "user cannot destroy City" do
    assert @berlin_user_ability.cannot?(:destroy, @berlin)
  end

  # Admin city

  test "admin can create City" do
    assert @admin_ability.can?(:create, City)
  end

  test "admin can read City" do
    assert @admin_ability.can?(:read, @berlin)
  end

  test "admin can update City" do
    assert @admin_ability.can?(:update, @berlin)
  end

  test "admin can destroy City" do
    assert @admin_ability.can?(:destroy, @berlin)
  end

  # Visitor squat

  test "visitor cannot create Squat" do
    assert @visitor_ability.cannot?(:create, Squat)
  end

  test "visitor can read Squat" do
    assert @visitor_ability.can?(:read, @berlin_squat)
  end

  test "visitor cannot update Squat" do
    assert @visitor_ability.cannot?(:update, @berlin_squat)
  end

  test "visitor cannot destroy Squat" do
    assert @visitor_ability.cannot?(:destroy, @berlin_squat)
  end

  # User squat

  test "user can create own Squat" do
    assert @berlin_user_ability.can?(:create, Squat, @berlin)
  end

  test "user can create other Squat" do
    assert @berlin_user_ability.can?(:create, Squat, @london)
  end

  test "user can read Squat" do
    assert @berlin_user_ability.can?(:read, @berlin_squat)
  end

  test "user can update own Squat" do
    assert @berlin_user_ability.can?(:update, @berlin_squat)
  end

  test "user cannot update other Squat" do
    assert @berlin_user_ability.cannot?(:update, @london_squat)
  end

  test "user can destroy own Squat" do
    assert @berlin_user_ability.can?(:destroy, @berlin_squat)
  end

  test "user cannot destroy other Squat" do
    assert @berlin_user_ability.cannot?(:destroy, @london_squat)
  end

  # Admin squat

  test "admin can create Squat" do
    assert @admin_ability.can?(:create, Squat)
  end

  test "admin can read Squat" do
    assert @admin_ability.can?(:read, @berlin_squat)
  end

  test "admin can update Squat" do
    assert @admin_ability.can?(:update, @berlin_squat)
  end

  test "admin can destroy Squat" do
    assert @admin_ability.can?(:destroy, @berlin_squat)
  end

  # Visitor Comment

  test "visitor cannot create Comment" do
    assert @visitor_ability.cannot?(:create, Comment)
  end

  test "visitor can read Comment" do
    assert @visitor_ability.can?(:read, Comment)
  end

  test "visitor cannot update Comment" do
    assert @visitor_ability.cannot?(:update, Comment)
  end

  test "visitor cannot destroy Comment" do
    assert @visitor_ability.cannot?(:destroy, Comment)
  end

  test "visitor cannot bulk_delete Comment" do
    assert @visitor_ability.cannot?(:bulk_delete, Comment)
  end

  # User Comment

  test "user can create Comment" do
    assert @berlin_user_ability.can?(:create, Comment)
  end

  test "user can read Comment" do
    assert @berlin_user_ability.can?(:read, Comment)
  end

  test "user can update own Comment" do
    assert @berlin_user_ability.can?(:update, @berlin_comment)
  end

  test "user cannot update other Comment" do
    assert @berlin_user_ability.cannot?(:update, @london_comment)
  end

  test "user can destroy own Comment" do
    assert @berlin_user_ability.can?(:destroy, @berlin_comment)
  end

  test "user cannot destroy other Comment" do
    assert @berlin_user_ability.cannot?(:destroy, @london_comment)
  end

  test "user cannot bulk_delete Comment" do
    assert @berlin_user_ability.cannot?(:bulk_delete, Comment)
  end

  # Admin Comment

  test "admin can create Comment" do
    assert @admin_ability.can?(:create, Comment)
  end

  test "admin can read Comment" do
    assert @admin_ability.can?(:read, Comment)
  end

  test "admin can update Comment" do
    assert @admin_ability.can?(:update, Comment)
  end

  test "admin can destroy Comment" do
    assert @admin_ability.can?(:destroy, Comment)
  end

  test "admin can bulk_delete Comment" do
    assert @admin_ability.can?(:bulk_delete, Comment)
  end

end
