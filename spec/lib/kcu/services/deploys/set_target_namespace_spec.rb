require 'spec_helper'

module Kcu
  module Deploys
    RSpec.describe SetTargetNamespace do

      let(:kcu_config) do
        YAML.load_file(SPEC_DIR.join("fixtures", "kcu.yml"))
      end

      context "target_namespace is given" do
        it "does not change it" do
          resulting_ctx = described_class.execute(
            image_config: kcu_config["deploys"][0],
            target_namespace: "staging",
          )

          expect(resulting_ctx.target_namespace).to eq "staging"
        end
      end

      context "target_namespace is nil" do
        it "sets the same namespace as the image_config" do
          resulting_ctx = described_class.execute(
            image_config: kcu_config["deploys"][0],
            target_namespace: nil,
          )

          expect(resulting_ctx.target_namespace).to eq "production"
        end
      end

    end
  end
end
