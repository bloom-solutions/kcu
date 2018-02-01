module Kcu
  class SetSecretAction

    extend LightService::Organizer

    def self.call(resource, entry_name, entry_value)
      ctx = with({
        resource: resource,
        entry_name: entry_name,
        entry_value: entry_value,
      }).reduce(
        GetResourceNamespaceAndName,
        Secrets::EncodeEntryValue,
        Secrets::SetEntryValue,
        Secrets::CreateEntryValue,
      )
    end

  end
end
