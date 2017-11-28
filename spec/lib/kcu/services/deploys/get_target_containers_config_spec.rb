require 'spec_helper'

module Kcu
  module Deploys
    RSpec.describe GetTargetContainersConfig do

      let(:kcu_config) do
        YAML.load_file(SPEC_DIR.join("fixtures", "kcu.yml"))
      end

      context "target namespace is not given" do
        it "uses the same config as the `image_config`" do
          resulting_ctx = described_class.execute(
            config: kcu_config,
            image_config: kcu_config["deploys"][1],
            target_namespace: nil,
          )

          expect(resulting_ctx.target_containers_config).
            to eq kcu_config["deploys"][1]
        end
      end

      context "target namespace given" do
        context "namespace is configured" do
          it "returns the staging config" do
            resulting_ctx = described_class.execute(
              config: kcu_config,
              image_config: "does not matter",
              target_namespace: "staging",
            )

            expect(resulting_ctx.target_containers_config).
              to eq kcu_config["deploys"][1]
          end
        end

        context "namespace is not configured" do
          it "raises an error" do
            expect {
              described_class.execute(
                config: kcu_config,
                image_config: "does not matter",
                target_namespace: "non_existent",
              )
            }.to raise_error(
              ArgumentError,
              "`non_existent` namespace is not configured"
            )
          end
        end
      end

    end
  end
end
