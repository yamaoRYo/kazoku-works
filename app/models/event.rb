class Event < ApplicationRecord

  # アソシエーション
  has_many :event_visibilities, dependent: :destroy
  has_many :visible_to_users, through: :event_visibilities, source: :user
  enum event_type: { birthday: 0, anniversary: 1, other: 2 }, _prefix: true, _suffix: true
  enum visibility: { everyone: 0, partial: 1, draft: 2 }, _prefix: true, _suffix: true
  has_many :memories, dependent: :destroy
  
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
  
  # スコープ
  # 特定のユーザーに表示可能なイベントを取得するscope
  scope :visible_to, -> (user) do
    family_users = User.where(family_id: user.family_id)

    everyone_events = where(user_id: family_users.ids, visibility: "everyone").to_a
    partial_events = joins(:visible_to_users)
                    .where(user_id: family_users.ids, visibility: "partial", event_visibilities: { user_id: user.id }).to_a

    Event.where(id: (everyone_events + partial_events).map(&:id))
  end
end
