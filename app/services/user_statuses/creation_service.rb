module UserStatuses
  class CreationService < ApplicationService
    def initialize(data)
      @data = data.data
      @user_status = nil
      @errors = []
    end

    def call
      ActiveRecord::Base.transaction do
        create_user_status
      end

      ServiceResult.new(
        success: @errors.empty?,
        data: @user_status,
        errors: @errors,
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
      def create_user_status
        user_status_params = extract_user_params

        @user_status = UserStatus.new(user_status_params)

        unless @user_status.save
          @errors.concat(@user_status.errors.full_messages)
          # Raise to trigger transaction rollback
          raise ActiveRecord::Rollback
        end
      end

      def extract_user_params
        full_name = "#{@data[:user][:firstName]} #{@data[:user][:lastName]}"
        experience = @data[:user][:age] > 50 ? "Veteran" : "Rookie"

        pending_tasks = @data[:user_todos][:todos].select { |todo| !todo[:completed] }
        pending_task_count = pending_tasks.size
        next_urgent_task = pending_task_count > 0 ? pending_tasks.first[:todo] : nil

        user_status_params = {
          full_name: full_name,
          experience: experience,
          pending_task_count: pending_task_count,
          next_urgent_task: next_urgent_task
        }
      end
  end
end
