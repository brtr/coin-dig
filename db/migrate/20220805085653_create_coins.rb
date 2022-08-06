class CreateCoins < ActiveRecord::Migration[6.1]
  def change
    create_table :coins do |t|
      t.integer :chain_id
      t.string  :symbol
      t.string  :name
      t.string  :logo

      t.timestamps
    end

    add_index :coins, :chain_id
    add_index :coins, :symbol
  end
end
