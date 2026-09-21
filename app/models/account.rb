# app/models/account.rb
class Account < ApplicationRecord
  belongs_to :user          # Eigentümer, der das Konto angelegt hat
  has_many :users           # alle Mitglieder

  validates :name, presence: true
end
