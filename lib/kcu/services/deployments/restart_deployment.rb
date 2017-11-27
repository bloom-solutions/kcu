module Kcu
  module Deployments
    class RestartDeployment

      extend LightService::Action
      expects :resource_namespace, :resource_name

      executed do |c|
        json = { spec: { template: { metadata: { annotations: {
          kcu_restarted_at: Time.now.to_i.to_s,
        } } } } }.to_json

        stdout_str, stderr_str, status = ExecShell.(
          "kubectl",
          "patch",
          "deployment",
          c.resource_name,
          "--namespace" => c.resource_namespace,
          "--patch" => "'#{json}'",
        )

        puts stdout_str
      end

    end
  end
end
