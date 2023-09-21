# frozen_string_literal: true

class Subscription < ApplicationRecord
  before_destroy :remove_subscription_teas

  belongs_to :customer
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas

  validates :status, inclusion: { in: %w[active cancelled] }
  validates_presence_of :title, :price, :status, :frequency, :customer_id

  def active?
    status == 'active'
  end

  def cancel
    return false unless active?

    update(status: 'cancelled')
  end

  private

  def remove_subscription_teas
    teas.clear
  end
end