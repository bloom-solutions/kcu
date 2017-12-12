module Kcu
  module Secrets
    class GetJson

      extend LightService::Action
      expects :resource_namespace, :resource_name
      promises :secret_json

      executed do |c|
        stdout_str, stderr_str, status = ExecShell.(
          "kubectl",
          "get",
          "secret",
          c.resource_name,
          "--namespace" => c.resource_namespace,
          "--output" => "json",
        )

        unless status.exitstatus.zero?
          fail stderr_str
        end

        c.secret_json = JSON.parse(stdout_str)
      end

    end
  end
end
