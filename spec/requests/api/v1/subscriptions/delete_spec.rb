require 'rails_helper'

RSpec.describe 'deactivate subscription' do
  describe 'happy path' do
    it 'deactivates a subscription when given a delete request with the subscription id' do
      customer = create(:customer)
      subscription = create(:subscription)
      customer.subscriptions << subscription

      Bullet.start_request
      
      expect(customer.subscriptions.count).to eq(1)
      
      headers = { 'Content-Type' => 'application/json' }
      subscription_id = { subscription_id: subscription.id }
      delete '/api/v1/subscriptions', headers: headers, params: JSON.generate(subscription_id)

      expect(response.status).to eq(204)

      expect(customer.subscriptions.count).to eq(0)
    end
  end

  describe 'happy path' do
    it 'returns an error if the subscription does not exist' do
      headers = { 'Content-Type' => 'application/json' }
      subscription_id = { subscription_id: 1 }
      delete '/api/v1/subscriptions', headers: headers, params: JSON.generate(subscription_id)

      expect(response.status).to eq(400)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:error)
      expect(result[:error]).to be_a(String)
      expect(result[:error]).to eq("No such subscription exists")
    end

    it 'returns an error if the subscription id is empty' do
      headers = { 'Content-Type' => 'application/json' }
      subscription_id = { }
      delete '/api/v1/subscriptions', headers: headers, params: JSON.generate(subscription_id)

      expect(response.status).to eq(400)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:error)
      expect(result[:error]).to be_a(String)
      expect(result[:error]).to eq("No such subscription exists")
    end
  end
end