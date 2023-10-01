class CheckoutOrder
  def call(order)
    return failure(:insuficient_fund) if user.balance > order.price

    payment = PaymentService.new(Rails.application.config.payment_api_key)
    payment.submit!(order.price)

    success
  rescue PaymentService::PaymentError => e
    failure(:payment_error)
  end
end

