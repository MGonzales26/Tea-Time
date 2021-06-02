class Subscription < ApplicationRecord
  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas

  validates :title, presence: true

  enum title: [ :economy, :standard, :zen ]
  enum frequency: [ :monthly, :bi_weekly, :weekly ]
  enum status: [ :active, :archived ]
end
