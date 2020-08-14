class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true, confirmation: true, length: { minimum: 6, message: 'mat khau phai 8 ki tu' }, if: :password
  validates_confirmation_of :password
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze
  validates :email, presence: { message: 'email khong dc trong' }, uniqueness: { message: 'email duy nhat' }, format: { with: VALID_EMAIL_REGEX, message: 'email dung dinh dang' }
  validates :name, presence: { message: 'name khong duoc trong' }

end
