class Subscription < ApplicationRecord
  before_destroy :remove_subscription_teas

  belongs_to :customer
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas

  private

  def remove_subscription_teas
    self.teas.clear
  end
end
