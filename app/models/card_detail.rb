class CardDetail < ApplicationRecord
  belongs_to :driver
  has_many :wallet_histories
  validates :card_no, :expiry_month, :expiry_year, :is_active, presence: true
  scope :default_true, -> { where is_default: true }
end
