require 'spec_helper'

module Kcu
  module Deploys
    RSpec.describe GetImageConfig do

      let(:kcu_config) do
        YAML.load_file(SPEC_DIR.join("fixtures", "kcu.yml"))
      end

      context "branch is 'master'" do
        it "returns the config matching the branch" do
          resulting_ctx = described_class.execute(
            config: kcu_config,
            git_branch: "master",
            target_namespace: nil,
          )

          expect(resulting_ctx.image_config).
            to eq kcu_config["deploys"][0]
        end
      end

      context "branch is 'staging_2011'" do
        it "returns the config matching the branch" do
          resulting_ctx = described_class.execute(
            config: kcu_config,
            git_branch: "staging_2011",
            target_namespace: nil,
          )

          expect(resulting_ctx.image_config).
            to eq kcu_config["deploys"][1]
        end
      end

      context "branch is not configured" do
        it "raises an error" do
          expect {
            described_class.execute({
              config: kcu_config,
              git_branch: "xyz",
              target_namespace: nil,
            })
          }.to raise_error(
            ArgumentError,
            "`xyz` branch is not configured",
          )
        end
      end

    end
  end
end
