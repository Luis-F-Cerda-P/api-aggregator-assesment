class ApplicationService
  # Allows calling the service with Service.call(args) syntax
  # instead of Service.new(args).call
  def self.call(...)
    new(...).call
  end
end
