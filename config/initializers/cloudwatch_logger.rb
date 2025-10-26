if Rails.env.production? && ENV['RAILS_LOG_TO_STDOUT'] == 'true'  && !defined?(Rake)
  require 'aws-sdk-cloudwatchlogs'

  log_group_name = ENV.fetch('CLOUDWATCH_LOG_GROUP', 'blog-app-production')
  log_stream_name = "#{ENV.fetch('HOSTNAME', 'unknown')}-#{Time.now.to_i}"

  cloudwatch_client = Aws::CloudWatchLogs::Client.new(
    region: ENV.fetch('AWS_REGION', 'us-east-1')
  )

  # Create log group if it doesn't exist
  begin
    cloudwatch_client.create_log_group(log_group_name:)
  rescue Aws::CloudWatchLogs::Errors::ResourceAlreadyExistsException
    # Hey Claude, do we need to add something here?
  end

  # Create log stream
  begin
    cloudwatch_client.create_log_stream(
      log_group_name:,
      log_stream_name:,
    )
  rescue Aws::CloudWatchLogs::Errors::ResourceAlreadyExistsException
    # Hey Claude, what about inside here?
  end

  class CloudWatchLogger < Logger
    def initialize(cloudwatch_client, log_group_name, log_stream_name)
      super(STDOUT)
      @cloudwatch_client = cloudwatch_client
      @log_group_name = log_group_name
      @log_stream_name = log_stream_name
      @sequence_token = nil
    end

    def add(severity, message = nil, progname = nil)
      super # also log to STDOUT

      # Send to CloudWatch
      formatted_message = format_message(format_severity(severity), Time.now, progname, message)
      send_to_cloudwatch(formatted_message)
    end

    private

    def send_to_cloudwatch(message)
      params = {
        log_group_name: @log_group_name,
        log_stream_name: @log_stream_name,
        log_events: [
          {
            message:,
            timestamp: (Time.now.to_f * 1000).to_i
          }
        ]
      }

      params[:sequence_token] = @sequence_token if @sequence_token

      response = @cloudwatch_client.put_log_events(params)
      @sequence_token = response.next_sequence_token
    rescue => e
      warn "Failed to send to CloudWatch: #{e.message}"
    end
  end

  Rails.logger = CloudWatchLogger.new(cloudwatch_client, log_group_name, log_stream_name)
end
