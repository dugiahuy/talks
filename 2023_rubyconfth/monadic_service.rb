class MonadicService
  Success = Struct.new(:succesful?, :failed?, :result, keyword_init: true)
  Failure = Struct.new(:succesful?, :failed?, :errors, keyword_init: true)

  def call
    raise NotImplementedError
  end

  private

  def success(result)
    Success.new(succesful?: true, failed?: false, result: result)
  end

  def failure(errors)
    Failure.new(succesful?: false, failed?: true, errors: errors)
  end
end

# MonadicService is a base class for all services that will be used in the monadic way.
# It provides two helper methods: success and failure. These methods return a struct
# that contains information about the result of the service. The struct has two
# attributes: successful? and failed? that can be used to check the result of the service.
# If the service was successful, the result attribute will contain the result of the service.
# If the service failed, the errors attribute will contain the errors that caused the failure.
# 
# Let's see how we can use this class to refactor the CreateOrder service.
# 
# First, we need to change the base class of the CreateOrder service to MonadicService:
# class CreateOrder < MonadicService
#   def call(user_id, ticket_id)
#     user = User.find(user_id)
#     ticket = Ticket.find(ticket_id)
#     order = Order.create!(user: user, ticket: ticket)

#     order
#   end
# end
# 
# Then, we need to change the call method to return the result of the service:
# class CreateOrder < MonadicService
#   def call(user_id, ticket_id)
#     user = User.find(user_id)
#     ticket = Ticket.find(ticket_id)
#     order = Order.create!(user: user, ticket: ticket)
# 
#     success(order)
#   end
# end
# 
# Now, we can use the CreateOrder service in the monadic way:
# class CheckoutController < ApplicationController
#   def create
#     order = CreateOrder.new.call(order_params[:user_id], order_params[:ticket_id])
#     if order.failed?
#       render json: { error: order.errors }, status: :unprocessable_entity
#       return
#     end
#     
#     checkout = CheckoutOrder.new.call(order.result)
#     if checkout.failed?
#       render json: { error: checkout.errors.to_s }, status: :unprocessable_entity
#       return
#     end
# 
#     render json: { id: order.result.id }, status: :ok
#   end
# 
#   private
# 
#   def order_params
#     params.require(:order).permit(:user_id, :ticket_id)
#   end
# end