# frozen_string_literal: true

class SubscriptionTea < ApplicationRecord
  belongs_to :subscription
  belongs_to :tea
end
