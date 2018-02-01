require 'spec_helper'

module Kcu
  module Secrets
    RSpec.describe CreateEntryValue do

      let(:entry_value) { "Some string" }
      let(:status) { instance_double(Process::Status, exitstatus: 0) }

      it "creates generic secret from literal" do
        expect(ExecShell).to receive(:call).with(
          "kubectl",
          "create",
          "secret",
          "generic",
          "worker",
          "--namespace" => "prod",
          "--from-literal" => "mysecret=Some\\ string",
        ).and_return(["stdout", "stderr", status])

        ctx = described_class.execute({
          resource_namespace: "prod",
          resource_name: "worker",
          entry_name: "mysecret",
          entry_value: entry_value,
        })
      end

    end
  end
end
