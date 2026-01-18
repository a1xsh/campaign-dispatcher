class CampaignsController < ApplicationController
  before_action :set_campaign, only: [ :show, :start ]

  def index
    @campaigns = Campaign.order(created_at: :desc)
    @campaign = Campaign.new
  end

  def show
    @recipients = @campaign.recipients.order(:id)
  end

  def create
    @campaign = Campaign.new(campaign_params)
    recipients_params = params[:campaign][:recipients] || []

    if @campaign.save
      recipients_params.each do |recipient_params|
        name = recipient_params[:name]&.strip
        contact = recipient_params[:contact]&.strip
        next if name.blank? || contact.blank?

        @campaign.recipients.create!(name:, contact:)
      end

      redirect_to @campaign
    else
      @campaigns = Campaign.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def start
    return redirect_to @campaign if @campaign.processing? || @campaign.completed?

    DispatchCampaignJob.perform_later(@campaign)

    redirect_to @campaign
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def campaign_params
    params.require(:campaign).permit(:title)
  end
end
