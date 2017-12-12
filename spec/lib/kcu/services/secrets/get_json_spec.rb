require 'spec_helper'

module Kcu
  module Secrets
    RSpec.describe GetJson do

      let(:expected_json) do
        File.read(SPEC_DIR.join("fixtures", "secret-encoded.json"))
      end
      let(:status) { instance_double(Process::Status, exitstatus: 0) }

      it "sets the json file of the resource" do
        expect(ExecShell).to receive(:call).with(
          "kubectl",
          "get",
          "secret",
          "web",
          "--namespace" => "default",
          "--output" => "json",
        ).and_return([expected_json, nil, status])

        resulting_ctx = described_class.execute(
          resource_name: "web",
          resource_namespace: "default",
        )

        expect(resulting_ctx.secret_json).to eq JSON.parse(expected_json)
      end

    end
  end
end
