class Company < ApplicationRecord
    has_many :employee, dependent: :destroy 

    mount_uploader :logo, LogoUploader
    # we also must check uniqueness of name on the database side
    validates :name, presence: true, length: { minimum: 2, maximum: 100 }, uniqueness: true

    validates :email, length: { maximum: 100 }, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Requires a valid email format' }, allow_blank: true

    validates :website, length: { maximum: 100 }, allow_blank: true
    
end  
