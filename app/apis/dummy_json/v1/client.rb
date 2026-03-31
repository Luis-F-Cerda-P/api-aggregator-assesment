require "uri"
require "net/http"

module DummyJson
  module V1
    class Client
      BASE_URL = "https://dummyjson.com".freeze

      def get_user(id)
        url = URI("#{BASE_URL}/users/#{id}")

        get_request(url: url)
      end

      def get_user_todos(id)
        url = URI("#{BASE_URL}/todos/user/#{id}")

        get_request(url: url)
      end

      private

      def get_request(url:)
        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true

        request = Net::HTTP::Get.new(url)
        response = https.request(request)

        JSON.parse(response.body)
      end
    end
  end
end
