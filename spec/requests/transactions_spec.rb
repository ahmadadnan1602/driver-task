require 'swagger_helper'

RSpec.describe 'drivers', type: :request do
  path '/drivers/{id}/add_fuel' do
    parameter name: 'id', in: :path, type: :string, description: 'driver_id'
    post 'Creates a fuel' do
      consumes 'application/json'

      parameter name: :fuel, in: :body, schema: {
        type: :object,
        properties: {
          amount: { type: :integer },
          description: { type: :string },
          transaction_type: { type: :integer }
        }
      }
      response '200', 'fuel created' do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
        end
      end
    end
  end

  path '/drivers/{id}/wallet_history' do
    parameter name: 'id', in: :path, type: :string, description: 'driver_id'
    post 'Wallet history' do
      consumes 'application/json'
      response '200', 'Wallet history' do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
        end
      end
    end
  end

  path '/overall_paylater_amount' do
    get('Wallet') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/drivers/{id}/transaction_histories' do
    parameter name: 'id', in: :path, type: :string, description: 'driver_id'
    post 'All transaction histories' do
      consumes 'application/json'
      response '200', 'Transaction histories' do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
        end
      end
    end
  end

  path '/drivers/{id}/settle_transaction' do
    parameter name: 'id', in: :path, type: :string, description: 'driver_id'

    post 'Settle transaction' do
      consumes 'application/json'
      parameter name: :transaction, in: :body, schema: {
        type: :object,
        properties: {
          transaction_history_id: { type: :integer }        }
      }
      response '200', 'Settle transaction' do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
        end
      end
    end
  end
end