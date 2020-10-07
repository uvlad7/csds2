class Users::SessionsController < Devise::SessionsController
  include EncryptionHelper
  respond_to :json

  def create
    super do |resource|
      resource.update_attribute(:rsa_pub, params[:rsa_pub]) if params[:rsa_pub]
      resource.update_attribute(:session_key, random_key_32)
    end
  end

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: 'Logged in successfully.' },
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
    }
  end

  def respond_to_on_destroy
    head :ok
  end
end
