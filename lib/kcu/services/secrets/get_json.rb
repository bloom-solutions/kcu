module Kcu
  module Secrets
    class GetJson

      extend LightService::Action
      expects :resource_namespace, :resource_name
      promises :secret_json

      executed do |c|
        shell_command = [
          "kubectl",
          "get",
          "secret",
          c.resource_name,
          "--namespace=#{c.resource_namespace}",
          "--output=json",
        ].join(" ")

        stdout_str, stderr_str, status = Open3.capture3(shell_command)

        c.secret_json = JSON.parse(stdout_str)
      end

    end
  end
end
