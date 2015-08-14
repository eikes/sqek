class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :body
      t.string :email
      t.boolean :published
      t.references :commentable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
