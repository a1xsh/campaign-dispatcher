class AddDefaultStatusToCampaignsAndRecipients < ActiveRecord::Migration[7.2]
  def change
    change_column_default :campaigns, :status, 0
    change_column_default :recipients, :status, 0
    add_index :recipients, [ :campaign_id, :status ]
  end
end
