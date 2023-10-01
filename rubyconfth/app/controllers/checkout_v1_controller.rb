class CheckoutController < ApplicationController
  def create
    order = {}
    begin
      order = CreateOrder.new.call(order_params[:user_id], order_params[:ticket_id])
    rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
      return
    end
    
    begin
      checkout = CheckoutOrder.new.call(order)
      if checkout == 'insuficient fund'
        render json: { error: 'insuficient fund' }, status: :unprocessable_entity
        return
      end
    rescue PaymentService::PaymentError => e
      render json: { error: e.message }, status: :unprocessable_entity
      return
    end

    render json: { id: order.id }, status: :ok
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :ticket_id)
  end
end


