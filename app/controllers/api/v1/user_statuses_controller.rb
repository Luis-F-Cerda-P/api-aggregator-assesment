class Api::V1::UserStatusesController < ApplicationController
  before_action :set_user_status

  def show
    @user_status
  end

  private

    def set_user_status
      @user_status = UserStatus.find(params[:id])
    end

    def user_status_params
      params.permit(:id)
    end
end
