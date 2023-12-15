class CheckoutController < ApplicationController
  def create
    user = User.find(user_id)
    ticket = Ticket.find(ticket_id)
    order = Order.create!(order_params)

    if user.balance > order.price
      payment = PaymentSDK.new(Rails.application.config.payment_api_key)
      payment.submit!(order.price)

      render json: { id: order.id }, status: 200
    else
      render json: { error: 'insufficient balance' }, status: 400
    end
  rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: 400
  rescue PaymentSDK::PaymentError => e
    render json: { error: e.message }, status: 400
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :ticket_id)
  end
end


