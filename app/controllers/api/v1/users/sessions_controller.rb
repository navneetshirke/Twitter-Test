class Api::V1::Users::SessionsController < Devise::SessionsController

  def new
    render json: {message: "Please sign in first"}
  end
  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.valid_password?(params[:user][:password])
      token = Tiddle.create_and_return_token(user, request)
      render json: {user: user.as_json.merge({authentication_token: token})}
    else
      render json: {message: "Username/Password incorrect"}, status: 422
    end
  end

  def destroy
    Tiddle.expire_token(current_user, request) if current_user
    render json: {}
  end

  private

    # this is invoked before destroy and we have to override it
    def verify_signed_out_user
    end
end