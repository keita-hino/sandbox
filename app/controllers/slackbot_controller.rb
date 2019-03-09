class SlackbotController < ApplicationController
  require 'slack-ruby-client'
  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:exec]
  before_action :slack_init, only: [:exec]

  def exec
    p = Practitioner.new(params['text'])
    result = p.execute
    @client.chat_postMessage(
      channel: params['channel_id'],
      text: result
    )
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
