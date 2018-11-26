class User
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  field :first_name, type: String
  field :last_name, type: String
  field :display_name, type: String
  field :email, type: String
  field :username, type: String
  field :password_digest, type: String

  before_create :pre_save

  protected

  def pre_save
    self[:display_name] = "#{self[:first_name]} #{self[:last_name]}"
  end
end
