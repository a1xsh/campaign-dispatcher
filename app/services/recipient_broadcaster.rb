class RecipientBroadcaster
  def self.call(recipient)
    new(recipient).call
  end

  def initialize(recipient)
    @recipient = recipient
    @campaign  = recipient.campaign
  end

  def call
    broadcast_recipient
    broadcast_progress
  end

  private

  attr_reader :recipient, :campaign

  def broadcast_recipient
    Turbo::StreamsChannel.broadcast_replace_to(
      campaign,
      target: dom_id(recipient),
      partial: "recipients/row",
      locals: { recipient: recipient }
    )
  end

  def broadcast_progress
    Turbo::StreamsChannel.broadcast_replace_to(
      campaign,
      target: "campaign_progress",
      partial: "campaigns/progress",
      locals: { campaign: campaign }
    )
  end

  def dom_id(record)
    ActionView::RecordIdentifier.dom_id(record)
  end
end
