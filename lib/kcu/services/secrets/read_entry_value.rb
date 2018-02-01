module Kcu
  module Secrets
    class ReadEntryValue

      extend LightService::Action
      expects :entry_value, :options
      promises :entry_value

      executed do |c|
        c.entry_value ||= File.read(File.expand_path(c.options.from_file))
      end

    end
  end
end
