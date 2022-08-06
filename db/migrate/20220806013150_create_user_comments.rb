class CreateUserComments < ActiveRecord::Migration[6.1]
  def change
    create_table :user_comments do |t|
      t.integer :user_id
      t.integer :coin_id
      t.integer :rating
      t.text    :body

      t.timestamps
    end

    add_index :user_comments, [:user_id, :coin_id]
  end
end
