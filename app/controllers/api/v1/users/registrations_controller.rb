class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  
  def create
    user = User.new(sign_up_params)
    if user.save
      token = Tiddle.create_and_return_token(user, request)
      render json: {user: user.as_json.merge({authentication_token: token})}
    else
      render json: {message: user.errors.messages}
    end
    
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password)
  end
  
end