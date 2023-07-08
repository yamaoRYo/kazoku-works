class Family < ApplicationRecord
  has_many :users
  has_many :invitations
  belongs_to :admin, class_name: 'User'

  validates :name, presence: true, length: { maximum: 50 }

  def invite_user
    invitations.create!
  end
end
