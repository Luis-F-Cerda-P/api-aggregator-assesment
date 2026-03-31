module UserStatuses
  class DataFetchingService < ApplicationService
    def initialize(api_client:, user_id:)
      @api_client = api_client
      @user_id = user_id
      @errors = []
    end

    def call
      data = fetch_data

      ServiceResult.new(
        success: @errors.empty?,
        data: { user: data[:user], user_todos: data[:user_todos] },
        errors: @errors
      )

    rescue StandardError => e
      Rails.logger.error("Data fetching failed: #{e.message}")

      ServiceResult.new(
        success: false,
        data: nil,
        errors: [ "Data fetching failed. Please try again." ]
      )
    end

    private

      def fetch_data
        data = {}
        begin
          user = @api_client.get_user(@user_id)
          user_todos = @api_client.get_user_todos(@user_id)

          { user: user, user_todos: user_todos }
        end
      end
  end
end
