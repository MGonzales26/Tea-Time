require 'rails_helper'

RSpec.describe "customer's subscriptions index" do
  describe 'happy path' do
    it "lists all off the customer's subscriptions active and canceled" do
      customer = create(:customer)
      active_sub = create(:subscription)
      canceled_sub = create(:subscription, status: 'canceled')
      customer.subscriptions << [active_sub, canceled_sub]

      get "/api/v1/customer/#{customer.id}/subscriptions"

      expect(response.status).to eq(200)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)
    end
  end
end