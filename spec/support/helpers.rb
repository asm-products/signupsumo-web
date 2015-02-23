module Helpers
  module Request
    def json
      @json ||= JSON.parse(response.body)
    end
  end
end
