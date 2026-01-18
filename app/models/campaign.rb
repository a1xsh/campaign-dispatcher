class Campaign < ApplicationRecord
  has_many :recipients, dependent: :destroy

  enum :status, { pending: 0, processing: 1, completed: 2 }

  validates :title, presence: true

  after_update_commit -> { CampaignBroadcaster.call(self) }

  def sent_count
    recipients.sent.count
  end

  def total_count
    recipients.count
  end
end
