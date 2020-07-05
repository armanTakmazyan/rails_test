class Employee < ApplicationRecord
  belongs_to :company

  validates :first_name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :email, length: { maximum: 100 }, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Requires a valid email format' }, allow_blank: true
  validates :phone, phone: { allow_blank: true }

  validates :company_id, presence: true
end
