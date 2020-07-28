class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  validates :password, presence: true, confirmation: true, on: :create
  validates :email, presence: true, uniqueness: true
  enum role: [:default, :merchant, :admin]

  has_secure_password

  has_many :orders
  belongs_to :user, optional: true
end
