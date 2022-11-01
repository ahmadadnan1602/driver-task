class Driver < ApplicationRecord
  belongs_to :user
  has_many :card_details
  has_many :fuels
  has_many :transaction_histories
  has_many :wallet_histories
  # validates :licence_number_d, :address, presence: true
  # validates_format_of :name, with: /\A[^0-9`!@#$%\^&*+_=]+\z/
end
