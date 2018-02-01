module Kcu
  class SetSecretAction

    extend LightService::Organizer

    def self.call(args, options)
      ctx = with({
        resource: args[0],
        entry_name: args[1],
        entry_value: args[2],
        options: options,
      }).reduce(
        GetResourceNamespaceAndName,
        Secrets::ReadEntryValue,
        Secrets::EncodeEntryValue,
        Secrets::SetEntryValue,
        Secrets::CreateEntryValue,
      )
    end

  end
end
