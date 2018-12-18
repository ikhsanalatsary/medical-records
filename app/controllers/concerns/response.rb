# app/controllers/concerns/response.rb
module Response
  def json_response(object, status = :ok)
    # puts object
    render json: object, status: status
  end
end
