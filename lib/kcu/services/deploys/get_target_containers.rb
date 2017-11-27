module Kcu
  module Deploys
    class GetTargetContainers

      extend LightService::Action
      expects :target_containers_config, :target_namespace
      promises :target_containers

      executed do |c|
        config = c.target_containers_config
        targets = config["targets"]
        c.target_containers = targets.map do |target_config|
          Container.new(
            namespace: c.target_namespace,
            deployment_name: target_config["deployment_name"],
            name: target_config["container"],
          )
        end
      end

    end
  end
end
