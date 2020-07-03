class Company < ApplicationRecord
    has_many :employee, dependent: :destroy 

    mount_uploader :logo, LogoUploader

    
end  
