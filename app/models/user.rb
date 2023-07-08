class User < ApplicationRecord
  authenticates_with_sorcery!
  # 所属していないことを許可する設定
  belongs_to :family, optional: true
  has_many :administered_families, class_name: 'Family', foreign_key: 'admin_id'

  validates :name, presence: true, length: { maximum: 50, allow_blank: true}
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum:3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  
  def create_family(params)
    if administered_families.exists?
      errors.add(:base, "You are already a member of a family.")
      nil
    else
      administered_family.create(params)
    end
  end
end
