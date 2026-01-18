class Recipient < ApplicationRecord
  belongs_to :campaign

  enum :status, { queued: 0, sent: 1, failed: 2 }

  validates :name, :contact, presence: true

  after_update_commit -> { RecipientBroadcaster.call(self) }
end
