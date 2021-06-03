class Subscription < ApplicationRecord
  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas

  validates :title, presence: true, allow_nil: false
  validates :price, presence: true, allow_nil: false
  validates :frequency, presence: true, allow_nil: false
  validates :status, presence: true, allow_nil: false

  def self.set_up_subscription(title)
    if title == 'economy'
      set_up_economy_subscription
    elsif title == 'standard'
      set_up_standard_subscription
    elsif title == 'zen'
      set_up_zen_subscription
    end
  end
  
  def self.set_up_economy_subscription
    subscription = Subscription.create(:title => 'economy',
      price: 9.99,
      status: 'active',
      frequency: 'monthly'
    )
  end
  
  def self.set_up_standard_subscription
    subscription = Subscription.create(:title => 'standard',
      price: 19.99,
      status: 'active',
      frequency: 'bi_weekly'
    )
  end
  
  def self.set_up_zen_subscription
    subscription = Subscription.create(:title => 'zen',
      price: 24.99,
      status: 'active',
      frequency: 'weekly'
    )
  end
end
