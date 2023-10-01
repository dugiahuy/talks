class CheckoutController < ApplicationController
  def create
    user = User.find(user_id)
    ticket = Ticket.find(ticket_id)
    order = Order.create!(order_params)

    if user.balance > order.price
      payment = PaymentService.new(Rails.application.config.payment_api_key)
      payment.submit!(order.price)

      render json: { id: order.id }, status: :ok
    else
      render json: { error: 'Insufficient funds' }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue PaymentService::PaymentError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :ticket_id)
  end
end


