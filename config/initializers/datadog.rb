# Datadog APM configuration
if Rails.env.production?
  require 'datadog'

  Datadog.configure do |c|
    # Configure the Datadog tracer
    c.service = 'blog-app'
    c.env = ENV.fetch('DD_ENV', 'production')

    # Enable distributed tracing
    c.tracing.enabled = true

    # Configure the Datadog agent connection
    # The agent is running on the host (not in the container)
    c.agent.host = ENV.fetch('DD_AGENT_HOST', 'localhost')
    c.agent.port = 8126

    # Instrument Rails components
    c.tracing.instrument :rails
    c.tracing.instrument :pg
    c.tracing.instrument :redis
    c.tracing.instrument :http
  end
end
