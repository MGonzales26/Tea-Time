require 'rails_helper'

RSpec.describe 'deactivate subscription' do
  describe 'happy path' do
    it 'deactivates a subscription when given a delete request with the subscription id' do
      customer = create(:customer)
      subscription = create(:subscription)
      customer.subscriptions << subscription

      expect(customer.subscriptions.count).to eq(1)
      
      headers = { 'Content-Type' => 'application/json' }
      subscription_id = { subscription_id: subscription.id }
      delete '/api/v1/subscriptions', headers: headers, params: JSON.generate(subscription_id)

      expect(response.status).to eq(204)

      expect(customer.subscriptions.count).to eq(0)
    end
  end
end