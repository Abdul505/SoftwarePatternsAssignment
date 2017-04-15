class Customer < ActiveRecord::Base
  has_secure_password
  has_many :comments
  has_many :orders

  VALID_EMAIL_VAL = /\A[\w+\-.]+@[A-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true , length: {maximum: 105},
     uniqueness: {case_sensitvity: false},
    format: { with: VALID_EMAIL_VAL }

  validates :f_name, presence: true, length: {minimum: 3, maximum: 20}
  validates :l_name, presence: true, length: {minimum: 3, maximum: 20}
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

end

class CustomerDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{object.f_name} #{object.l_name}"
  end
end
