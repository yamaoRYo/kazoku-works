class Event < ApplicationRecord

  # アソシエーション
  has_many :event_visibilities, dependent: :destroy
  has_many :visible_to_users, through: :event_visibilities, source: :user
  enum event_type: { birthday: 0, anniversary: 1, other: 2 }, _prefix: true, _suffix: true
  enum visibility: { everyone: 0, partial: 1, draft: 2 }, _prefix: true, _suffix: true
  
  # バリデーション
  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  
  # イベントの公開範囲を判定するメソッド
  def visible_to(user)
    case visibility
    when 'everyone'
      true
    when 'partial'
      # partialの場合には、イベントと関連があるユーザーのみがアクセスできるようにします。
      visible_to_users.include?(user)
    when 'draft'
      user_id == user.id
    else
      false
    end
  end
end
