class CampaignBroadcaster
  def self.call(campaign)
    new(campaign).call
  end

  def initialize(campaign)
    @campaign = campaign
  end

  def call
    broadcast_status
    broadcast_start_button
  end

  private

  attr_reader :campaign

  def broadcast_status
    Turbo::StreamsChannel.broadcast_replace_to(
      campaign,
      target: "campaign_status",
      partial: "campaigns/status",
      locals: { campaign: campaign }
    )
  end

  def broadcast_start_button
    Turbo::StreamsChannel.broadcast_replace_to(
      campaign,
      target: "start_button",
      partial: "campaigns/start_button",
      locals: { campaign: campaign }
    )
  end
end
