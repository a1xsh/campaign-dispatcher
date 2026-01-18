class DispatchCampaignJob < ApplicationJob
  queue_as :default

  def perform(campaign_id)
    campaign = Campaign.find(campaign_id)
    campaign.update!(status: :processing)

    campaign.recipients.queued.find_each do |recipient|
      sleep(rand(1..3))
      recipient.update!(status: :sent)
    rescue => e
      recipient.update!(status: :failed)
    end

    campaign.update!(status: :completed)
  end
end
