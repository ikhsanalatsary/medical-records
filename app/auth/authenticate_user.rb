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
  rescue Mongoid::Errors::DocumentNotFound
    raise(ExceptionHandler::AuthenticationError, Message.not_found)
  else
    return user if user.authenticate(password)

    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
