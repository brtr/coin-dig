require 'redis'

url = ENV["SIDEKIQ_REDIS_URL"] || "redis://localhost:6379/0"
$redis = Redis.new(url: url)