class Family < ApplicationRecord
    has_many :users
    belongs_to :admin, class_name: 'User'

    validates :name, presence: true, length: { maximum: 50 }
end
