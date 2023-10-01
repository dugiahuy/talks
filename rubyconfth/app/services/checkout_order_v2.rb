class CheckoutOrder
  def call(order)
    return :insuficient_fund if user.balance > order.price

    payment = PaymentService.new(Rails.application.config.payment_api_key)
    payment.submit!(order.price)
  rescue PaymentService::PaymentError => e
    :payment_error
  end
end

