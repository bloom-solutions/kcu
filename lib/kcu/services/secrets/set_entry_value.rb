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

        stdout_str, stderr_str, status = ExecShell.(
          "kubectl",
          "patch",
          "secret",
          c.resource_name,
          "--namespace" => c.resource_namespace,
          "--patch" => "'#{patch_json}'",
        )

        c.skip_remaining!
      end

    end
  end
end
