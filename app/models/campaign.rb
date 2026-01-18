class Campaign < ApplicationRecord
  has_many :recipients, dependent: :destroy

  enum :status, { pending: 0, processing: 1, completed: 2 }

  validates :title, presence: true

  after_initialize :set_default_status, if: :new_record?
  after_update_commit -> { CampaignBroadcaster.call(self) }

  def sent_count
    recipients.sent.count
  end

  def total_count
    recipients.count
  end

  private

  def set_default_status
    self.status ||= :pending
  end
end
