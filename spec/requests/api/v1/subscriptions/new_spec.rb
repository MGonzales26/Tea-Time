require 'rails_helper'

RSpec.describe 'new subscription' do
  describe 'happy path' do
    it 'creates a new subscription when given the title and customer id' do
      customer = create(:customer)

      Bullet.start_request
      
      creation_variables = {title: 'economy', customer_id: customer.id }

      headers = { "CONTENT_TYPE" => "application/json" }
      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(creation_variables)

      expect(response.status).to eq(201)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)
      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to be_a(String)
      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to be_a(String)
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to be_a(Hash)
      expect(result[:data][:attributes]).to have_key(:title)
      expect(result[:data][:attributes][:title]).to be_a(String) 
      expect(result[:data][:attributes][:title]).to eq(creation_variables[:title])
      expect(result[:data][:attributes]).to have_key(:price)
      expect(result[:data][:attributes][:price]).to be_a(Float)
      expect(result[:data][:attributes][:price]).to eq(9.99)
      expect(result[:data][:attributes]).to have_key(:status)
      expect(result[:data][:attributes][:status]).to be_a(String)
      expect(result[:data][:attributes][:status]).to eq('active')
      expect(result[:data][:attributes]).to have_key(:frequency)
      expect(result[:data][:attributes][:frequency]).to be_a(String)
      expect(result[:data][:attributes][:frequency]).to eq('monthly')
    end

    it 'creates a standard subscription when given the title and customer id' do
      customer = create(:customer)

      creation_variables = {title: 'standard', customer_id: customer.id }

      headers = { "CONTENT_TYPE" => "application/json" }
      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(creation_variables)

      expect(response.status).to eq(201)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)
      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to be_a(String)
      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to be_a(String)
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to be_a(Hash)
      expect(result[:data][:attributes]).to have_key(:title)
      expect(result[:data][:attributes][:title]).to be_a(String)
      expect(result[:data][:attributes][:title]).to eq(creation_variables[:title])
      expect(result[:data][:attributes]).to have_key(:price)
      expect(result[:data][:attributes][:price]).to be_a(Float)
      expect(result[:data][:attributes][:price]).to eq(19.99)
      expect(result[:data][:attributes]).to have_key(:status)
      expect(result[:data][:attributes][:status]).to be_a(String)
      expect(result[:data][:attributes][:status]).to eq('active')
      expect(result[:data][:attributes]).to have_key(:frequency)
      expect(result[:data][:attributes][:frequency]).to be_a(String)
      expect(result[:data][:attributes][:frequency]).to eq('bi_weekly')
    end

    it 'creates a zen subscription when given the title and customer id' do
      customer = create(:customer)

      creation_variables = {title: 'zen', customer_id: customer.id }

      headers = { "CONTENT_TYPE" => "application/json" }
      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(creation_variables)

      expect(response.status).to eq(201)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)
      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to be_a(String)
      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to be_a(String)
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to be_a(Hash)
      expect(result[:data][:attributes]).to have_key(:title)
      expect(result[:data][:attributes][:title]).to be_a(String)
      expect(result[:data][:attributes][:title]).to eq(creation_variables[:title])
      expect(result[:data][:attributes]).to have_key(:price)
      expect(result[:data][:attributes][:price]).to be_a(Float)
      expect(result[:data][:attributes][:price]).to eq(24.99)
      expect(result[:data][:attributes]).to have_key(:status)
      expect(result[:data][:attributes][:status]).to be_a(String)
      expect(result[:data][:attributes][:status]).to eq('active')
      expect(result[:data][:attributes]).to have_key(:frequency)
      expect(result[:data][:attributes][:frequency]).to be_a(String)
      expect(result[:data][:attributes][:frequency]).to eq('weekly')
    end
  end

  describe 'sad path' do
    it 'returns an error if there is no customer id given' do
      creation_variables = {title: 'economy' }

      headers = { "CONTENT_TYPE" => "application/json" }
      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(creation_variables)

      expect(response.status).to eq(400)
      
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:error)
      expect(result[:error]).to be_a(String)
      expect(result[:error]).to eq("Couldn't find Customer without an ID")
    end

    it 'returns an error if the customer does not exist' do
      creation_variables = {title: 'economy', customer_id: 1 }

      headers = { "CONTENT_TYPE" => "application/json" }
      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(creation_variables)

      expect(response.status).to eq(400)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:error)
      expect(result[:error]).to be_a(String)
      expect(result[:error]).to eq("Couldn't find Customer with 'id'=1")
    end

    it 'returns an error if the customer id is negative' do
      creation_variables = {title: 'economy', customer_id: -1 }

      headers = { "CONTENT_TYPE" => "application/json" }
      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(creation_variables)

      expect(response.status).to eq(400)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:error)
      expect(result[:error]).to be_a(String)
      expect(result[:error]).to eq("Couldn't find Customer with 'id'=-1")
    end

    it 'returns an error if there is no title given' do
      customer = create(:customer)

      creation_variables = { customer_id: customer.id }

      headers = { "CONTENT_TYPE" => "application/json" }
      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(creation_variables)

      expect(response.status).to eq(400)
      
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:error)
      expect(result[:error]).to be_a(String)
      expect(result[:error]).to eq("Subscription cannot be created without a title.")
    end

    it 'returns an error if the title is empty' do
      customer = create(:customer)
      creation_variables = {title: '', customer_id: customer.id }

      headers = { "CONTENT_TYPE" => "application/json" }
      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(creation_variables)

      expect(response.status).to eq(400)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:error)
      expect(result[:error]).to be_a(String)
      expect(result[:error]).to eq("Subscription cannot be created without a title.")
    end

    it 'returns an error if the title is jibberish' do
      customer = create(:customer)
      creation_variables = {title: 'afhgsfhdgkmbjt', customer_id: customer.id }

      headers = { "CONTENT_TYPE" => "application/json" }
      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(creation_variables)

      expect(response.status).to eq(400)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:error)
      expect(result[:error]).to be_a(String)
      expect(result[:error]).to eq("Subscription cannot be created without a title.")
    end
  end
end