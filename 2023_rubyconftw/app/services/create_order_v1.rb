class CreateOrder
  def call(user_id, ticket_id)
    user = User.find(user_id)
    ticket = Ticket.find(ticket_id)
    order = Order.create!(user: user, ticket: ticket)

    order
  end
end

