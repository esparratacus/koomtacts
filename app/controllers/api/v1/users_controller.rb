module Api::V1
  class UsersController < ApiController

    def sign_in
      @user = User.find_by!(email:params[:email])
      if @user.valid_password?(params[:password])
        render json: { token: ApiAuthorization::TokenManager.encode_token({ user_id: @user.id} ) }
      else
        render json: { message: 'incorrect password' }, status: :unauthorized
      end
    end

    def create
      @user = User.create!(user_registration_params)
      render json: UserSerializer.new(@user) , status: :created
    end

    private
    def user_registration_params
      params.require(:user).permit(:email,:password)
    end
  end
end