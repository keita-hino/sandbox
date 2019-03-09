class SlackbotController < ApplicationController
  require 'slack-ruby-client'
  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def callback
    @body = JSON.parse(request.body.read)
    return if !(@body['event']['channel'] == ENV['SLACK_SANDBOX_CHANEL'] ) || @body["event"].keys.include?("bot_id")
    case @body['type']
    when 'url_verification'
      render json: @body["challenge"]
    when 'event_callback'
      slack_init
      @client.chat_postMessage(
        # as_user: 'true',
        channel: @body['event']['channel'],
        text: @body['event']['text']
      )
    end
  end

  private
    def slack_init
      Slack.configure do |config|
        config.token = ENV['SLACK_BOT_SANDBOX_TOKEN']
        raise 'Missing ENV[SLACK_BOT_SANDBOX_TOKEN]!' unless config.token
      end
      @client = Slack::Web::Client.new
    end
end
