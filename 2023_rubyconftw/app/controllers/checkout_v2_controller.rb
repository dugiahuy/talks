class CheckoutController < ApplicationController
  def create
    order = CreateOrder.new.call(order_params[:user_id], 
                                 order_params[:ticket_id])
    if order.is_a?(String)
      return render json: { error: order }, status: 400
    end
    
    checkout = CheckoutOrder.new.call(order)
    if checkout.is_a?(String)
      return render json: { error: checkout.to_s }, status: 400
    elsif checkout == false
      return render json: { error: "payment failed" }, status: 400
    end

    render json: { id: order.id }, status: 200
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :ticket_id)
  end
end


