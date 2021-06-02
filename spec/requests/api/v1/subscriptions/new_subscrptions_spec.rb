require 'rails_helper'

RSpec.describe 'new subscription' do
  describe 'happy path' do
    it 'creates a new subscription when given the title and customer id' do
      customer = create(:customer)
      post "/api/v1/subscriptions", body: {title: 'economy', customer_id: customer.id }

      expect(response.status).to eq(201)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)
      expect(result[:data]).to have_key(:subscription)
    end
  end
end