class TransactionHistory < ApplicationRecord
  belongs_to :driver
  belongs_to :transactiontable, polymorphic: true
  scope :non_settled_transactions, -> { where transaction_type: 'paylater', is_settle: false }
end
