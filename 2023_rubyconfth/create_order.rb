class CreateOrder
  attr_reader :user_id, :ticket_id

  def initialize(user_id, ticket_id)
    @user_id = user_id
    @ticket_id = ticket_id
  end

  def call
    user = User.find(user_id)
    ticket = Ticket.find(ticket_id)
    order = Order.create!(user: user, ticket: ticket)

    order
  end
end

# ServiceObject usage example
CreateOrder.new(user_id, ticket_id).call

