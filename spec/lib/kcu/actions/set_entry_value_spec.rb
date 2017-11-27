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

      it "encodes entry_value to encoded_entry_value as Base64 (strict)" do
        expect(ExecShell).to receive(:call).with(
          "kubectl",
          "patch",
          "secret",
          "worker",
          "--namespace" => "prod",
          "--patch" => "'#{expected_json}'"
        )

        described_class.execute({
          resource_namespace: "prod",
          resource_name: "worker",
          entry_name: "mysecret",
          encoded_entry_value: encoded_entry_value,
        })
      end

    end
  end
end
