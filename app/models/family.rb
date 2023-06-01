class Family < ApplicationRecord
    has_many :family_menbers
    has_many :users, through: :family_menbers
end
