class WelcomeController < ApplicationController
  def index
    @user = User.first
    puts "aaaa"
    puts @user
    @user
  end
end
