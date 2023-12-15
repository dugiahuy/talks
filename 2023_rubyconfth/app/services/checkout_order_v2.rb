class CheckoutOrder
  def call(order)
    return 'insufficient_balance' if user.balance > order.price

    config = Rails.application.config.payment_api_key
    PaymentService.new(config).submit!(order.price)

    true
  rescue PaymentService::PaymentError => e
    false
  end
end

