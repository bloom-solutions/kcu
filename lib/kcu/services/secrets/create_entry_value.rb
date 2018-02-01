module Kcu
  module Secrets
    class CreateEntryValue

      extend LightService::Action
      expects(
        :resource_namespace,
        :resource_name,
        :entry_name,
        :entry_value,
      )

      executed do |c|
        literal = [
          c.entry_name,
          Shellwords.escape(c.entry_value)
        ].join("=")

        stdout_str, stderr_str, status = ExecShell.(
          "kubectl",
          "create",
          "secret",
          "generic",
          c.resource_name,
          "--namespace" => c.resource_namespace,
          "--from-literal" => literal,
        )

        puts stdout_str || stderr_str
      end

    end
  end
end
