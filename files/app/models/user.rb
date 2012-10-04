class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :name, :email, :password, :image_url, :password_confirmation, :remember_me
  has_many :authorizations, dependent: :destroy
  validates :name, presence: true

  def self.new_with_session(params, session)
    super.tap do |user|
      if auth = session[:omniauth]
        user.email = auth.info.email if auth.info.email.present?
        user.name = auth.info.name
        user.image = auth.info.image
        user.authorizations.build(provider: auth.provider, uid: auth.uid)
      end
    end
  end

  def avatar_url
    return image if image
    "http://gravatar.com/avatar/#{Digest::MD5.new.update(email)}.jpg?s=50"
  end
end


