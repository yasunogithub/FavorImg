class WelcomeController < ApplicationController
  def index
    @urlArr = []
    @user = User.first
    if @user.nil?

    else
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = @user.consumer_key
        config.consumer_secret     = @user.consumer_secret
        config.access_token        = @user.access_token
        config.access_token_secret = @user.access_token_secret
      end
      favos = @client.favorites({include_entities:true})

      @imgs = favos.flat_map { |s| s.media}.map { |m| m.media_url.to_s}
    end
  end
end
