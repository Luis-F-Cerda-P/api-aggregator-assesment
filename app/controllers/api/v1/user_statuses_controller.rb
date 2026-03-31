class Api::V1::UserStatusesController < ApplicationController
  def show_or_create
    @user_status = UserStatus.find_by(id: params[:id]) || fetch_and_create

    if @user_status.errors.empty?
      render :show, status: :ok
    else
      render json: @user_status.errors, status: :unprocessable_entity
    end
  end

  private
    def fetch_and_create
      client = DummyJson::V1::Client.new
      fetch_result = UserStatuses::DataFetchingService.call(api_client: client, user_id: params[:id])
      return fetch_result if fetch_result.failure?

      creation_result = UserStatuses::CreationService.call(fetch_result)
      creation_result.data if creation_result.success?
    end

    def user_status_params
      params.permit(:id)
    end
end
