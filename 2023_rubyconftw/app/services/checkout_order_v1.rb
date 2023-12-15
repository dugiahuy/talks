class CheckoutOrder
  def call(order)
    return 'insufficient balance' if user.balance > order.price

    config = Rails.application.config.payment_api_key
    PaymentService.new(config).submit!(order.price)
  end
end

