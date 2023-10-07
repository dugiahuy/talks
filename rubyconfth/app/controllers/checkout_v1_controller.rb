class CheckoutController < ApplicationController
  def create
    order = {}
    begin
      order = CreateOrder.new.call(order_params[:user_id],
                                   order_params[:ticket_id])
    rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid => e
      return render json: { error: e.message }, status: 400
    end
    
    begin
      checkout = CheckoutOrder.new.call(order)
      if checkout == 'insufficient balance'
        return render json: { error: 'insufficient balance' }, status: 400
      end
    rescue PaymentService::PaymentError => e
      return render json: { error: e.message }, status: 400
    end

    render json: { id: order.id }, status: 200
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :ticket_id)
  end
end


