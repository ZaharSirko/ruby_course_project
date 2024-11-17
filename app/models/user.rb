class User < ApplicationRecord
  has_one :cart, dependent: :destroy

  after_create :create_cart

  before_save :set_default_role

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :omniauthable, omniauth_providers: [ :google_oauth2, :github ]

  def self.from_omniauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
    user
  end

  ROLES = %w[admin customer].freeze

  validates :role, inclusion: { in: ROLES }

  def admin?
    role == "admin"
  end

  def customer?
    role == "customer"
  end

  private

  def create_cart
    Cart.create(user: self)
  end

  def set_default_role
    self.role ||= "customer"
  end
end
