class Coin < ApplicationRecord
  has_many :user_coins
  has_many :users, through: :user_coins
  has_many :user_comments

  def rating
    user_comments.average(:rating)
  end

  def chain
    case chain_id
    when 1
      "ETH"
    when 137
      "MATIC"
    else
      ""
    end
  end
end
