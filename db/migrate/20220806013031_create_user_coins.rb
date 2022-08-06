class CreateUserCoins < ActiveRecord::Migration[6.1]
  def change
    create_table :user_coins do |t|
      t.integer :user_id
      t.integer :coin_id
      t.boolean :is_hold

      t.timestamps
    end

    add_index :user_coins, [:user_id, :coin_id]
  end
end
