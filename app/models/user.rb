class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true, confirmation: true, length: { minimum: 6, message: 'mat khau phai 8 ki tu' }, if: :password
  validates_confirmation_of :password
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze
  validates :email, presence: { message: 'email khong dc trong' }, uniqueness: { message: 'email duy nhat' }, format: { with: VALID_EMAIL_REGEX, message: 'email dung dinh dang' }
  validates :name, presence: { message: 'name khong duoc trong' }
  
  def self.from_omniauth(auth)
    result = User.where(email: auth.info.email).first
    if result
      return result
    else
      user = User.new({
        name: auth.info.name,
        email: auth.info.email,
        # password: auth.friendly_token[0,20],
        image: auth.info.image,
        uid: auth.uid,
        provider: auth.provider
      })
      if user.save!(validate: false)
        result = User.where(email: auth.info.email).first
      # where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      #   user.email = auth.info.email
      #   user.password = auth.friendly_token[0,20]
      #   user.name = auth.info.name
      #   user.image = auth.info.image
      #   user.uid = auth.uid
      #   user.provider = auth.provider

      #   #  If you are using confirmable and the provider(s) you use validate emails
      #   user.skip_confirmation!
      # end
      end
    end
    result
  end
end
