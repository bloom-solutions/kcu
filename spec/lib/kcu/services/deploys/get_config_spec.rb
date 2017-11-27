require 'spec_helper'

module Kcu
  module Deploys
    RSpec.describe GetConfig do

      let(:kcu_config) do
        YAML.load_file(SPEC_DIR.join("fixtures", "kcu.yml"))
      end

      context "#{described_class::CONFIG_FILE_NAME} exists in the repo_dir" do
        it "returns the configured resources" do
          resulting_ctx = described_class.execute(
            repo_dir: SPEC_DIR.join("fixtures"),
          )

          expect(resulting_ctx.config).to eq kcu_config
        end
      end

      context "#{described_class::CONFIG_FILE_NAME} does not exists in the repo_dir" do
        it "returns the configured resources" do
          expect {
            described_class.execute(repo_dir: SPEC_DIR)
          }.to raise_error(
            ArgumentError,
            "#{described_class::CONFIG_FILE_NAME} is not present in #{SPEC_DIR}"
          )
        end
      end

    end
  end
end
