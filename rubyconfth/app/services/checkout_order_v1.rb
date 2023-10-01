class CheckoutOrder
  def call(order)
    return 'insuficient fund' if user.balance > order.price

    payment = PaymentService.new(Rails.application.config.payment_api_key)
    payment.submit!(order.price)
  end
end

