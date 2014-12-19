class AddNotifyOnLawyerOffer < ActiveRecord::Migration
  def change
    add_column :lawyer_offers, :notify, :boolean, default: false
  end
end
