module Kcu
  class GetSecretAction

    extend LightService::Organizer

    def self.call(resource, entry_name)
      ctx = with(resource: resource, entry_name: entry_name).reduce(
        GetResourceNamespaceAndName,
        Secrets::GetJson,
        Secrets::DecodeData,
        Secrets::GetEntryValue,
      )
      ap ctx.entry_value
    end

  end
end
