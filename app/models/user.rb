class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  
  has_one  :address, dependent: :destroy
  has_one  :credit_card
  has_many :orders
  has_many :items
  
  validates :nickname,        presence: true, uniqueness: true
  validates :email,           presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9.!#$%&'*+\/=?\A_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\z/ }
  validates :last_name,       presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :first_name,      presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :last_name_kana,  presence: true, format: { with: /\A[ぁ-ん]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ぁ-ん]+\z/ }
  validates :date_of_birth,   presence: true
  devise    :validatable,     password_length: 7..128
end