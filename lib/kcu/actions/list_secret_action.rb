module Kcu
  class ListSecretAction

    extend LightService::Organizer

    def self.call(resource)
      ctx = with(resource: resource).reduce(
        GetResourceNamespaceAndName,
        Secrets::GetJson,
        Secrets::DecodeData,
      )

      ap ctx.decoded_secret_json["data"]
    end

  end
end
