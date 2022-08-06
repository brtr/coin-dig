require 'open-uri'

class CoinService
  class << self
    def sync_balance(address)
      result = []
      user = User.find_by address: address
      if user
        [1, 137].each do |chain_id|
          get_balance(chain_id, address, result)
        end
      end

      user.user_coins.update_all(is_hold: false) unless result.empty?

      result.each do |r|
        coin = Coin.where(chain_id: r[0], name: r[1], symbol: r[2], logo: r[3]).first_or_create
        user_coin = user.user_coins.where(coin_id: coin.id).first_or_create
        user_coin.update(is_hold: true)
      end
    end

    def get_balance(chain_id, address, result)
      url = "https://api.covalenthq.com/v1/#{chain_id}/address/#{address}/balances_v2/?quote-currency=USD&format=JSON&nft=false&no-nft-fetch=true&key=#{ENV['COVALENTHQ_KEY']}"
      response = URI.open(url).read
      data = JSON.parse(response)
      items = data["data"]["items"]
      if items.present?
        items.each do |item|
          next if item["contract_name"].blank? && item["contract_ticker_symbol"].blank?
          result.push([chain_id, item["contract_name"], item["contract_ticker_symbol"], item["logo_url"]]) if item["balance"].to_f > 0
        end
      end
    end
  end
end