class Task < ApplicationRecord
  belongs_to :user
  has_many :task_ranges, dependent: :delete_all
end
