class Api::V1::SubscriptionsController < ApplicationController
  
  def index
    customer = Customer.find(params[:id])
    subscriptions = customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions)
    # customer = Customer.includes(:subscriptions).find(params[:id])
    # render json: SubscriptionSerializer.new(customer)
  end

  def create
    customer = Customer.find(params[:customer_id])
    subscription = Subscription.set_up_subscription(params[:title])
    customer.subscriptions << subscription
    render json: SubscriptionSerializer.new(subscription), status: :created
  end

  def destroy
    customers_subscription = CustomerSubscription.where(subscription_id: params[:subscription_id])
    if customers_subscription == []
      error = "No such subscription exists"
      render json: ErrorSerializer.new(error), status: :bad_request
    else
      CustomerSubscription.destroy(customers_subscription.ids)
    end
  end
end