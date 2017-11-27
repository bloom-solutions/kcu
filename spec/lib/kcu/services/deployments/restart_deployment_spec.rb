require 'spec_helper'

module Kcu
  module Deployments
    RSpec.describe RestartDeployment do

      let(:json) do
        { spec: { template: { metadata: { annotations: {
          kcu_restarted_at: Time.now.to_i.to_s,
        } } } } }.to_json
      end

      it "restarts the deployment by setting an annotation" do
        Timecop.freeze

        expect(ExecShell).to receive(:call).with(
          "kubectl",
          "patch",
          "deployment",
          "web",
          "--namespace" => "prod",
          "--patch" => "'#{json}'",
        ).and_return([nil, nil, 0])

        described_class.execute(resource_namespace: "prod", resource_name: "web")
      end

    end
  end
end
