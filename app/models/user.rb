class User
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  include ActiveModel::SecurePassword
  extend Enumerize

  field :first_name, type: String
  field :last_name, type: String
  field :display_name, type: String
  field :email, type: String
  field :username, type: String
  field :roles
  enumerize :roles, in: %i[patient doctor admin], multiple: true, predicates: true, default: :patient
  has_one :patient
  field :password_digest, type: String

  has_secure_password

  validates_presence_of :first_name, message: 'Please fill in your first name'
  validates_presence_of :last_name, message: 'Please fill in your last name'
  validates_presence_of :username, message: 'Please fill in your username'
  validates_presence_of :email, message: 'Please fill in your email'
  validates_uniqueness_of :username, message: 'Username already exists'
  validates_uniqueness_of :email, message: 'Please fill a valid email address', case_sensitive: false

  before_create :pre_save

  protected

  def pre_save
    self[:display_name] = "#{self[:first_name]} #{self[:last_name]}"
  end
end
