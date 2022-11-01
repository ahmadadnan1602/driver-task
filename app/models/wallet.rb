class Wallet < ApplicationRecord
	has_many :wallet_histories
  validates :total_amount, :wallet_type, presence: true
  enum wallet_type: %i[admin user not_set]
end
