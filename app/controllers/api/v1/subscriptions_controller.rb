class Api::V1::SubscriptionsController < ApplicationController
  
  def index
    customer = find_customer
    subscriptions = customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions)
    # customer = Customer.includes(:subscriptions).find(params[:id])
    # render json: SubscriptionSerializer.new(customer)
  end

  def create
    customer = find_customer
    subscription = Subscription.set_up_subscription(find_title)
    customer.subscriptions << subscription
    render json: SubscriptionSerializer.new(subscription), status: :created
  end

  def destroy
    customers_subscription = find_subscription
    if customers_subscription == []
      error = "No such subscription exists"
      render json: ErrorSerializer.new(error), status: :bad_request
    else
      CustomerSubscription.destroy(customers_subscription.ids)
    end
  end
    
  private

  def find_customer
    Customer.find(params[:customer_id] || params[:id])
  end

  def find_title
    params.require(:subscription).permit(:title)
  end

  def find_subscription
    CustomerSubscription.where(subscription_id: params[:subscription_id])
  end
end