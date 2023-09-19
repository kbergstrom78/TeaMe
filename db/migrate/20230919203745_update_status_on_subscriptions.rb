class UpdateStatusOnSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_check_constraint :subscriptions, "status IN ('active', 'cancelled')", name: "check_status_on_subscriptions"
  end
end
