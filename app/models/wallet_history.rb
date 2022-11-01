class WalletHistory < ApplicationRecord
  belongs_to :driver
  belongs_to :wallet
  belongs_to :card_detail
  validates :total_amount, :transaction_histories_ids, presence: true
end
