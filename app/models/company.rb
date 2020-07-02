class Company < ApplicationRecord
    has_many :employee, dependent: :destroy 
end
