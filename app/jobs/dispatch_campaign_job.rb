class DispatchCampaignJob < ApplicationJob
  queue_as :default

  def perform(campaign)
    campaign.processing!

    campaign.recipients.queued.each do |recipient|
      sleep(rand(1..3))
      recipient.sent!
    rescue => e
      recipient.failed!
    end

    campaign.completed!
  end
end
