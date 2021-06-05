class SubscriptionSerializer
  include FastJsonapi::ObjectSerializer

  # has_many :subscriptions
  attributes :title, :price, :status, :frequency
end