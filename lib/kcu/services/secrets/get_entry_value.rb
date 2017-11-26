module Kcu
  module Secrets
    class GetEntryValue

      extend LightService::Action
      expects :decoded_secret_json, :entry_name
      promises :entry_value

      executed do |c|
        c.entry_value = c.decoded_secret_json["data"][c.entry_name]
      end

    end
  end
end
