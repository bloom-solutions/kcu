require 'spec_helper'

module Kcu
  module Deploys
    RSpec.describe GetTargetContainers do

      let(:kcu_config) do
        YAML.load_file(SPEC_DIR.join("fixtures", "kcu.yml"))
      end

      it "returns the configured resources" do
        resulting_ctx = described_class.execute(
          target_namespace: "production",
          target_containers_config: kcu_config["deploys"][0],
        )

        target_containers = resulting_ctx.target_containers
        expect(target_containers.size).to eq 2
        expect(target_containers[0].namespace).to eq "production"
        expect(target_containers[0].deployment_name).to eq "web"
        expect(target_containers[0].name).to eq "website"
        expect(target_containers[1].namespace).to eq "production"
        expect(target_containers[1].deployment_name).to eq "worker"
        expect(target_containers[1].name).to eq "sidekiq"
      end

    end
  end
end
