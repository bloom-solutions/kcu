module Kcu
  module Deploys
    class SetTargetNamespace

      extend LightService::Action
      expects :image_config, :target_namespace

      executed do |c|
        next c if c.target_namespace.present?
        c.target_namespace = c.image_config["namespace"]
      end

    end
  end
end
