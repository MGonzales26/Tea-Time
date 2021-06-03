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
      expect(result[:data]).to be_an(Array)
      expect(result[:data].count).to eq(2)

      result[:data].each do |subscription|
        expect(subscription).to be_a(Hash)
        expect(subscription).to have_key(:id)
        expect(subscription[:id]).to be_a(String)
        expect(subscription).to have_key(:type)
        expect(subscription[:type]).to be_a(String)
        expect(subscription[:type]).to eq('subscription')
        expect(subscription).to have_key(:attributes)
        expect(subscription[:attributes]).to be_a(Hash)
        expect(subscription[:attributes]).to have_key(:title)
        expect(subscription[:attributes][:title]).to be_a(String)
        expect(subscription[:attributes]).to have_key(:price)
        expect(subscription[:attributes][:price]).to be_a(Float)
        expect(subscription[:attributes]).to have_key(:status)
        expect(subscription[:attributes][:status]).to be_a(String)
        expect(subscription[:attributes]).to have_key(:frequency)
        expect(subscription[:attributes][:frequency]).to be_a(String)
      end

    end
  end
end