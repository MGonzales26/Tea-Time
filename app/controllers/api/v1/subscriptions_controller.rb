class Api::V1::SubscriptionsController < ApplicationController

  def create
    customer = Customer.find(params[:customer_id])
    subscription = Subscription.set_up_subscription(params[:title])
    customer.subscriptions << subscription
    render json: SubscriptionSerializer.new(subscription), status: :created
  end
end