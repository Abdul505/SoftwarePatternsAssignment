class Customer < ActiveRecord::Base

  has_secure_password

  VALID_EMAIL_VAL = /\A[\w+\-.]+@[A-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true , length: {maximum: 105},
     uniqueness: {case_sensitvity: false},
    format: { with: VALID_EMAIL_VAL }

  validates :f_name, presence: true, length: {minimum: 3, maximum: 20}

  validates :l_name, presence: true, length: {minimum: 3, maximum: 20}
end
