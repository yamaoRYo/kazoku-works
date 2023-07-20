class Event < ApplicationRecord
  belongs_to :user
  enum event_type: { birthday: 0, anniversary: 1, other: 2 }, _prefix: true, _suffix: true
  enum visibility: { everyone: 0, partial: 1, draft: 2 }, _prefix: true, _suffix: true

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  # 他の必要なバリデーションを追加します
end
