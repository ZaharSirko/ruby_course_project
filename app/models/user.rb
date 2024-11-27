class User < ApplicationRecord
  has_one :cart, dependent: :destroy

  has_many :orders, dependent: :destroy

  after_create :create_cart

  before_save :set_default_role

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :omniauthable, omniauth_providers: [ :google_oauth2 ]

  def self.from_omniauth(auth)
    logger.debug "OAuth Response: #{auth.inspect}"

    next_id = User.maximum(:id).to_i + 1

    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize do |new_user|
      new_user.id = next_id
      new_user.email = auth.info.email
      new_user.name = auth.info.name
      new_user.password = Devise.friendly_token[0, 20]
      new_user.created_at = Time.current
      new_user.updated_at = Time.current
    end

    if user.save
      ogger.debug "User successfully created or found: #{user.inspect}"
      user
    else
      logger.error "User creation failed: #{user.errors.full_messages.join(", ")}"
      nil
    end
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
