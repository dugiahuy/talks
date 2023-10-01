class CreateOrder < MonadicService
  def call(user_id, ticket_id)
    user = User.find(user_id)
    ticket = Ticket.find(ticket_id)
    order = Order.create!(user: user, ticket: ticket)

    success(order)
  rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid => e
    failure(e.message)
  end
end

