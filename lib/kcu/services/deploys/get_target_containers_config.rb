module Kcu
  module Deploys
    class GetTargetContainersConfig

      extend LightService::Action
      expects :config, :target_namespace, :image_config
      promises :target_containers_config

      executed do |c|
        c.target_containers_config = catch(:config) do
          if c.target_namespace.present?
            c.config["deploys"].find do |conf|
              throw(:config, conf) if conf["namespace"] == c.target_namespace
            end

            fail ArgumentError, "`#{c.target_namespace}` namespace is not configured"
          end

          throw :config, c.image_config
        end
      end

    end
  end
end
