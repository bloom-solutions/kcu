require 'spec_helper'

module Kcu
  module Secrets
    RSpec.describe GetEntryValue do

      let(:decoded_secret_json) do
        JSON.parse(File.read(SPEC_DIR.join("fixtures", "secret-decoded.json")))
      end

      it "sets the value of the entry_name on the context as entry_value" do
        resulting_ctx = described_class.execute(
          decoded_secret_json: decoded_secret_json,
          entry_name: "aws_region",
        )

        expect(resulting_ctx.entry_value).to eq "us-east-1"
      end

    end
  end
end
