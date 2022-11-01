require 'swagger_helper'

RSpec.describe 'drivers', type: :request do
  path '/add_user' do
    post 'Creates a User' do
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string},
          password: { type: :string }
        }
      }

      response '200', 'User got created...' do
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

  path '/new_driver' do
    post 'Creates a Driver' do
      consumes 'application/json'

      parameter name: :driver, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string},
          address: { type: :string},
          licence_number: { type: :string},
          d_o_b: { type: :string},
          user_id: { type: :integer }
        }
      }

      response '200', 'Driver created' do
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

  path '/drivers' do
    get('Drivers list') do
      response(200, 'successful') do
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

  path '/user_lists' do
    get('Users list') do
      response(200, 'successful') do
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

  path '/drivers/{id}/add_new_cards' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    post 'Creates a Card Details' do
      consumes 'application/json'

      parameter name: :card_detail, in: :body, schema: {
        type: :object,
        properties: {
          card_no: { type: :string },
          expiry_month: { type: :string },
          expiry_year: { type: :integer },
          is_active: { type: :boolean },
          is_default: {type: :boolean}
        }
      }
      response '200', 'card created' do
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
  path '/drivers/{id}/card_details' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('card_details list') do
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
end