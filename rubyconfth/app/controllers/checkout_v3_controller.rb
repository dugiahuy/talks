class CheckoutController < ApplicationController
  def create
    order = CreateOrder.new.call(order_params[:user_id], order_params[:ticket_id])
    if order.failed?
      render json: { error: order.errors.to_s }, status: :unprocessable_entity
      return
    end
    
    checkout = CheckoutOrder.new.call(order.result)
    if checkout.failed?
      render json: { error: checkout.errors.to_s }, status: :unprocessable_entity
      return
    end

    render json: { id: order.result.id }, status: :ok
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :ticket_id)
  end
end

