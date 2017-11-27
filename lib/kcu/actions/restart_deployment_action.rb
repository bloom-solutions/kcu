module Kcu
  class RestartDeploymentAction

    extend LightService::Organizer

    def self.call(resource)
      ctx = with(resource: resource).reduce(
        GetResourceNamespaceAndName,
        Deployments::RestartDeployment,
      )
    end

  end
end
