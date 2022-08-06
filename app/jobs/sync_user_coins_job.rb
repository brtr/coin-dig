class SyncUserCoinsJob < ApplicationJob
  queue_as :default

  def perform(address)
    CoinService.sync_balance(address)
  end
end