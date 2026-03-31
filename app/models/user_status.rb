class UserStatus < ApplicationRecord
  self.table_name = "UserStatus"

  validates :experience, inclusion: [ "Rookie", "Veteran" ]
  validates :pending_task_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
