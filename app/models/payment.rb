class Payment < ActiveRecord::Base

  def self.collect_payment(id,first=nil)
    begin
      payment = Payment.find id
      lawyer = User.find payment.lawyer_id
      invoice = Invoice.find(payment.invoice_id)
      payments = invoice.payments
      user = User.find payment.user_id

      customer = Stripe::Customer.retrieve(user.billing.stripe_id).default_card
      token = Stripe::Token.create(
        {:customer => user.billing.stripe_id, :card => customer},
        lawyer.identities.where(provider: 'stripe_connect').pluck(:token).first # user's access token from the Stripe Connect flow
      )

      if lawyer.monthly_or_fee == 'monthly'
        lawyer_charge = true
        charge = Stripe::Charge.create({
            :amount => payment.amount * 100, # amount in cents
            :currency => "usd",
            :card => token.id,
            :description => "#{user.email} payment to #{lawyer.email}"
          },
          lawyer.identities.where(provider: 'stripe_connect').pluck(:token).first # user's access token from the Stripe Connect flow
        )
        Email.lawyer_pay_payment(lawyer,payment).deliver
      else
        lawyer_charge = false
        charge = Stripe::Charge.create({
            :amount => payment.amount * 90, # payment amount in cents
            :currency => "usd",
            :card => token.id,
            :description => "#{user.email} payment to #{lawyer.email}",
            :application_fee => payment.amount * 10 # fee amount in cents
          },
          lawyer.identities.where(provider: 'stripe_connect').pluck(:token).first # user's access token from the Stripe Connect flow
        )
        Email.user_pay_payment(user,lawyer,payment).deliver
      end
      payment.update_attributes(paid: true)
      if first
        payments.each_with_index do |payment,index|
          payment.update_attributes(payment_date: Time.now + (30 * index).days)
        end
      end
      if payments.where(paid: false).length == 0
        invoice.update_attributes(paid: true)
      end
      msg = "Success Fully Charged"
      success = true
    rescue Stripe::CardError => e
      # Since it's a decline, Stripe::CardError will be caught
      err  = e.json_body[:error]
      success = false
      msg = "Stripe Payment Failed: #{err[:message]}, e601."
    rescue Stripe::InvalidRequestError => e
      # Invalid parameters were supplied to Stripe's API
      msg = "Stripe Payment Failed: There was something wrong with your account details, e501."
      success = false
    rescue Stripe::AuthenticationError => e
      # Authentication with Stripe's API failed
      # (maybe you changed API keys recently)
      msg = "Stripe Payment Failed: Internal Error, e401."
      success = false
    rescue Stripe::APIConnectionError => e
      # Network communication with Stripe failed
      msg = "Stripe Payment Failed: Network Error, Try Again, e301."
      success = false
    rescue Stripe::StripeError => e
      # Display a very generic error to the user, and maybe send
      # yourself an email
      msg = "Stripe Payment Failed: e201."
      success = false
    rescue => e
      # Something else happened, completely unrelated to Stripe
      msg = "Stripe Payment Failed: e101."
      success = false
    end

    unless success
      if lawyer_charge
        # Email.failed_payment(payment, msg, lawyer)
      else
        # Email.failed_payment(payment, msg, user,lawyer)
      end
    end
    return [msg,success]
  end

  def self.my_total(current_user)
    select("ROUND(COALESCE(SUM(amount),0),2) as total").where(paid: true, lawyer_id: current_user.id).first.total
  end
end
