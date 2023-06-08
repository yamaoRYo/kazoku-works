class User < ApplicationRecord
  authenticates_with_sorcery!
  # 所属していないことを許可する設定
  belongs_to :family, optional: true

  validates :name, presence: true, length: { maximum: 50, allow_blank: true}
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum:3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  end
