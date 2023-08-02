class User < ApplicationRecord
  # sorceryの設定
  authenticates_with_sorcery!

  # アソシエーション
  has_many :authentications, dependent: :destroy
  has_many :event_visibilities, dependent: :destroy 
  has_many :visible_events, through: :event_visibilities, source: :event
  belongs_to :family, optional: true
  has_one :administered_family, class_name: 'Family', foreign_key: :admin_id
  has_one_attached :image

  # ネストした属性
  accepts_nested_attributes_for :authentications

  # バリデーション
  validates :name, presence: true, length: { maximum: 50, allow_blank: true}
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum:3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  
  private

  # ユーザーが所属しているファミリーを作成する
  def create_family(params)
    if administered_families.exists?
      errors.add(:base, "You are already a member of a family.")
      nil
    else
      administered_family.create(params)
    end
  end
end