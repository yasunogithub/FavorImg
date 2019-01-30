class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
          uid:      auth.uid,
          provider: auth.provider,
          email:    User.dummy_email(auth),
          password: Devise.friendly_token[0, 20],
          image: auth.info.image,
          name: auth.info.name,
          nickname: auth.info.nickname,

          # TwitterApiで必要なKey
          access_token: auth.extra.access_token.token,
          access_token_secret: auth.extra.access_token.secret,
          consumer_key: auth.extra.access_token.consumer.key,
          consumer_secret: auth.extra.access_token.consumer.secret,
          )
    end

    user
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
