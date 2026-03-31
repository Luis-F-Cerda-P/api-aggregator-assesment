# app/services/service_result.rb
#
# Standardized result object returned by all service objects.
# Provides a consistent interface for checking success/failure
# and accessing returned data or errors.
class ServiceResult
  attr_reader :data, :errors

  # @param success [Boolean] Whether the operation succeeded
  # @param data [Object] The primary data returned by the service
  # @param errors [Array<String>] List of error messages if failed
  def initialize(success:, data: nil, errors: [])
    @success = success
    @data = data
    @errors = errors
  end

  # Check if the operation was successful
  # @return [Boolean]
  def success?
    @success
  end

  # Check if the operation failed
  # @return [Boolean]
  def failure?
    !@success
  end

  # Get the first error message
  # @return [String, nil]
  def error_message
    errors.first
  end
end
