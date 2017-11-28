require 'spec_helper'

module Kcu
  module Deploys
    RSpec.describe SetImage do

      let(:target_container_1) do
        Container.new(namespace: "prod", deployment_name: "web", name: "website")
      end
      let(:target_container_2) do
        Container.new(namespace: "prod", deployment_name: "bg", name: "worker")
      end
      let(:target_containers) { [target_container_1, target_container_2] }
      let(:image_name) { "gcr.io/image/name:12321321" }
      let(:successful_status) do
        instance_double(Process::Status, exitstatus: 0)
      end

      it "sets the image in the target containers" do
        expect(ExecShell).to receive(:call).with(
          "kubectl",
          "set",
          "image",
          "deployment",
          "web",
          "--namespace" => "prod",
          "website" => image_name,
        ).and_return(["stdout1", nil, successful_status])

        expect(ExecShell).to receive(:call).with(
          "kubectl",
          "set",
          "image",
          "deployment",
          "bg",
          "--namespace" => "prod",
          "worker" => image_name,
        ).and_return(["stdout2", nil, successful_status])

        described_class.execute({
          target_containers: target_containers,
          image_name: image_name,
        })
      end

    end
  end
end
