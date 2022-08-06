class User < ApplicationRecord
  has_many :user_coins
  has_many :coins, through: :user_coins

  def is_hold?(coin_id)
    user_coins.exists?(coin_id: coin_id)
  end
end
