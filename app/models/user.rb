class User < ApplicationRecord
  has_prefix_id :u
  has_secure_password
  has_many :sessions, dependent: :destroy

  # optional: account_id ist bewusst nullable, weil User und Account
  # sich gegenseitig referenzieren (siehe Migration AddAccountToUsers)
  belongs_to :account, optional: true

  # Ersatz für rolify: eine Spalte, Werte als lesbare Strings in der DB.
  # Liefert user.admin?, user.admin!, User.admin (Scope) usw.
  enum :role, { user: "user", admin: "admin" }, default: :user, validate: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true
end
