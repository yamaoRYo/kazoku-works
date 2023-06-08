class Family < ApplicationRecord
    has_many :users

    validates :name, presence: true, length: { maximum: 50 }
end
