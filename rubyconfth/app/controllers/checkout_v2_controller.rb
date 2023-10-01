class CheckoutController < ApplicationController
  def create
    order = CreateOrder.new.call(order_params[:user_id], order_params[:ticket_id])
    if order.is_a?(String)
      render json: { error: order }, status: :unprocessable_entity
      return
    end
    
    checkout = CheckoutOrder.new.call(order)
    if checkout.is_a?(Symbol)
      render json: { error: checkout.to_s }, status: :unprocessable_entity
      return
    end

    render json: { id: order.id }, status: :ok
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :ticket_id)
  end
end


