class Fuel < ApplicationRecord
  belongs_to :driver
  has_many :transaction_histories, as: :transactiontable
  enum transaction_type: %i[card_type paylater not_set]
  validates :amount, :description, :transaction_type, presence: true
end
