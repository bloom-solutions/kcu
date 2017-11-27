module Kcu
  module Deploys
    class SetImage

      extend LightService::Action
      expects :image_name, :target_containers

      executed do |c|
        c.target_containers.each do |container|
          stdout_str, stderr_str, status = ExecShell.(
            "kubectl",
            "set",
            "image",
            "deployment",
            container.deployment_name,
            "--namespace" => container.namespace,
            container.name => c.image_name,
          )

          if status.exitstatus.zero?
            puts "Updated #{container.namespace} deployment " +
              "#{container.deployment_name} #{container.name} to " +
              "#{c.image_name}"
          else
            puts stderr_str
          end
        end
      end

    end
  end
end
