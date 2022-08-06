require 'sidekiq'
require "sidekiq/pro/web"

shared_redis_config = {
  url: ENV["SIDEKIQ_REDIS_URL"] || "redis://localhost:6379/0",
  network_timeout: 5
}

Sidekiq.configure_server do |config|
  # https://github.com/mperham/sidekiq/wiki/Pro-Reliability-Server
  config.super_fetch!

  config.redis = shared_redis_config

  config.on(:startup) do
    require "sidekiq/cli"
    cli = Sidekiq::CLI.instance
    new_config = cli.send(:parse_config, "config/sidekiq.yml")
    Sidekiq.options.merge! new_config
    ActiveRecord::Base.clear_active_connections!
  end

end

Sidekiq.configure_client do |config|
  config.redis = shared_redis_config
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [
    ENV['SIDEKIQ_WEB_USER'] || "feedmob",
    ENV['SIDEKIQ_WEB_PASSWORD'] || "devteamsecret"
  ]
end
