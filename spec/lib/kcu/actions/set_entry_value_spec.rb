require 'spec_helper'

module Kcu
  module Secrets
    RSpec.describe SetEntryValue do

      let(:entry_value) { "Some string" }
      let(:encoded_entry_value) { Base64.strict_encode64(entry_value) }
      let(:expected_json) do
        {
          data: {
            "mysecret" => encoded_entry_value,
          },
        }.to_json
      end
      let(:successful_status) do
        instance_double(Process::Status, exitstatus: 0)
      end

      context "successfully updates entry" do
        it "encodes entry_value to encoded_entry_value as Base64 (strict)" do
          expect(ExecShell).to receive(:call).with(
            "kubectl",
            "patch",
            "secret",
            "worker",
            "--namespace" => "prod",
            "--patch" => "'#{expected_json}'"
          ).and_return(["stdout", "stderr", successful_status])

          ctx = described_class.execute({
            resource_namespace: "prod",
            resource_name: "worker",
            entry_name: "mysecret",
            encoded_entry_value: encoded_entry_value,
          })

          expect(ctx).to be_skip_remaining
        end
      end

    end
  end
end
