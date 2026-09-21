class User < ApplicationRecord
  has_prefix_id :u
  has_secure_password
  has_many :sessions, dependent: :destroy
  belongs_to :account, optional: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }


  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true
end
