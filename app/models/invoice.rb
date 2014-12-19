class Invoice < ActiveRecord::Base
  has_one :patent
  accepts_nested_attributes_for :patent
  has_many :payments
  accepts_nested_attributes_for :payments

  def self.super_select(current_user,params)
  	Invoice.select('invoices.*,payer.first_name as payer_first_name, payee.first_name as payee_first_name, payer.middle_name as payer_middle_name, payee.middle_name as payee_middle_name, payer.last_name as payer_last_name, payee.last_name as payee_last_name, payer.phone as payer_phone, payee.phone as payee_phone,payer.fax as payer_fax, payee.fax as payee_fax, payer.email as payer_email, payer.address as payer_address, payer.city as payer_city, payer.state as payer_state, payee.email as payee_email, (case when file_or_sell = "File" then payee.firm_id ELSE payer.business_id END) as office_id').joins("join users as payee on payee.id = payee_id").joins("join users as payer on payer.id = payer_id").where("invoices.id = #{params[:id]} AND (payer_id = #{current_user.id} OR payee_id = #{current_user.id})").first
  end
end
