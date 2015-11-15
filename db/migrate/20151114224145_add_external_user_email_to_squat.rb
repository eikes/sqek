class AddExternalUserEmailToSquat < ActiveRecord::Migration
  def change
    add_column :squats, :external_user_email, :string
  end
end
