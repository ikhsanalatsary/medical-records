class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  # service entry point
  def call
    JsonWebToken.encode(user_id: user._id) if user
  end

  private

  attr_reader :email, :password
  def user
    user = User.find_by(email: email)
    user.authenticate(password)
  end
  
end
