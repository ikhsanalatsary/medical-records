# app/controllers/users_controller.rb
class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  wrap_parameters :user, include: [
    :first_name,
    :last_name,
    :username,
    { roles: [] },
    :email,
    :password,
    :password_confirmation
  ]
  # POST /signup
  # return authenticated token upon signup
  def create
    date = Time.new
    year = date.year
    month = date.month
    day = date.day
    tomorrow = day + 1
    user = User.create!(user_params)
    # create patient
    if user.roles.texts[0] == 'Patient'
      p_count = Patient.where(
        created: {
          '$gte': Time.new(year, month, day),
          '$lt': Time.new(year, month, tomorrow)
        }
      ).count
      counter = p_count + 1
      count_str = counter.to_s
      suffix = Array.new(math_max(4 - count_str.length + 1, 0)).join('0') + count_str
      mrn = "MRN-#{date.strftime('%y%m%d')}-#{suffix}"
      Patient.create!(
        medical_record_number: mrn,
        user: user._id,
        created_by: user._id,
        name: user.display_name
      )
    end
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :username,
      { roles: [] },
      :email,
      :password,
      :password_confirmation
    )
  end

  def math_max(*values)
    values.max
  end
end

# email: "ikhsan@123.com", first_name: "Abdul Fattah", last_name: "Ikhsan", password: "12345678", roles: (2) ["admin", "doctor"], username: "ikhsan"