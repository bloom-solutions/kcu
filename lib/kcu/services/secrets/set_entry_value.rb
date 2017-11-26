module Kcu
  module Secrets
    class SetEntryValue

      extend LightService::Action
      expects(
        :resource_namespace,
        :resource_name,
        :entry_name,
        :encoded_entry_value,
      )

      executed do |c|
        patch_json = {
          data: {
            c.entry_name => c.encoded_entry_value,
          },
        }.to_json
        shell_command = [
          "kubectl",
          "patch",
          "secret",
          c.resource_name,
          "--namespace=#{c.resource_namespace}",
          ["--patch", "'#{patch_json}'"].join("="),
        ].join(" ")

        stdout_str, stderr_str, status = Open3.capture3(shell_command)

        puts stdout_str
      end

    end
  end
end
