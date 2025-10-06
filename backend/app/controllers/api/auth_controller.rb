class Api::AuthController < ApplicationController
  # POST /api/auth/register
  def register
    user = User.new(user_params)

    if user.save
      render json: {
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          phone: user.phone
        },
        token: generate_token(user)
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /api/auth/login
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      render json: {
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          phone: user.phone
        },
        token: generate_token(user)
      }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation)
  end

  def generate_token(user)
    # For now, we'll use a simple token (user_id encoded)
    # In production, you'd want to use JWT or similar
    Base64.strict_encode64("#{user.id}:#{user.email}")
  end
end
