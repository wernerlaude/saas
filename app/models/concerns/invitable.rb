module Invitable
  extend ActiveSupport::Concern

  included do
    belongs_to :invited_by, class_name: "User", optional: true

    # Signierter Token statt eigener Spalte (Rails 7.1+):
    # – läuft nach 7 Tagen ab
    # – wird ungültig, sobald die Einladung angenommen ist (Einmal-Link)
    # – wird ungültig, wenn neu eingeladen wird (alter Link verfällt)
    generates_token_for :invitation, expires_in: 7.days do
      [ invitation_created_at, invitation_accepted_at ]
    end

    # Beim Annehmen muss ein eigenes Passwort gesetzt werden
    validates :password, presence: true, on: :invitation
  end

  class_methods do
    # Legt einen User im Account an und verschickt die Einladung.
    # Das Zufallspasswort ersetzt der Eingeladene beim Annehmen.
    def create_and_invite(invited_by:, account:, **attributes)
      user = new(attributes.merge(account: account, password: SecureRandom.base58(24)))
      user.invite!(invited_by) if user.save
      user
    end
  end

  def invite!(invited_by_user)
    update!(invited_by: invited_by_user, invitation_created_at: Time.current, invitation_accepted_at: nil)
    InvitationMailer.with(user: self).instructions_email.deliver_later
  end

  def invitation_pending?
    invitation_created_at? && !invitation_accepted_at?
  end
end
