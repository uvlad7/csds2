
class Users::RegistrationsController < Devise::SessionsController
  respond_to :json
  private

  def respond_with(resource, _opts = {})
    render json: {
    status: {code: 200, message: 'Logged in successfully.'},
    data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }
  end
end
