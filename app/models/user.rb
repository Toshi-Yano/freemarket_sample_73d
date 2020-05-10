class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  
  has_one  :address, dependent: :destroy
  has_one  :creditcard, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :sns_credentials
  
  validates :nickname,        presence: true, uniqueness: true
  validates :email,           presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9.!#$%&'*+\/=?\A_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\z/ }
  validates :last_name,       presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :first_name,      presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :last_name_kana,  presence: true, format: { with: /\A[ぁ-ん]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ぁ-ん]+\z/ }
  validates :date_of_birth,   presence: true
  devise    :validatable,     password_length: 7..128

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end