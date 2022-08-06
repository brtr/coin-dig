class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :address

      t.timestamps
    end

    add_index :users, :address
  end
end
