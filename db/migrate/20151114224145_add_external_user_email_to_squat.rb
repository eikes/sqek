class AddExternalUserEmailToSquat < ActiveRecord::Migration[4.2]
  def change
    add_column :squats, :external_user_email, :string
  end
end
