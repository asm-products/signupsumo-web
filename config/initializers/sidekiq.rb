Sidekiq.default_worker_options = { 'backtrace' => true }

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add Sidekiq::Middleware::Server::RetryJobs, :max_retries => 3
  end
end
