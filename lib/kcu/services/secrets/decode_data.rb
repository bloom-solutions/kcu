module Kcu
  module Secrets
    class DecodeData

      extend LightService::Action
      expects :secret_json
      promises :decoded_secret_json

      executed do |c|
        c.decoded_secret_json = c.secret_json
        data = c.secret_json["data"]
        decoded_data = data.each_with_object({}) do |(name, base64_val), hash|
          hash[name] = Base64.strict_decode64(base64_val)
        end
        c.decoded_secret_json["data"] = decoded_data
      end

    end
  end
end
