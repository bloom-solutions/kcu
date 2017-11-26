module Kcu
  module Secrets
    class EncodeEntryValue

      extend LightService::Action
      expects :entry_value
      promises :encoded_entry_value

      executed do |c|
        c.encoded_entry_value = Base64.strict_encode64(c.entry_value)
      end

    end
  end
end
