class CheckoutOrder < MonadicService
  def call(order)
    return failure(:insuficient_fund) if user.balance > order.price

    config = Rails.application.config.payment_api_key
    PaymentService.new(config).submit!(order.price)

    success
  rescue PaymentService::PaymentError => e
    failure(:payment_error)
  end
end

