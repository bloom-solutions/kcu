require 'spec_helper'

module Kcu
  module Secrets
    RSpec.describe DecodeData do

      let(:encoded_json) do
        JSON.parse(File.read(SPEC_DIR.join("fixtures", "secret-encoded.json")))
      end
      let(:decoded_json) do
        JSON.parse(File.read(SPEC_DIR.join("fixtures", "secret-decoded.json")))
      end

      it "sets the decoded secret json on the context" do
        resulting_ctx = described_class.execute(secret_json: encoded_json)
        expect(resulting_ctx.decoded_secret_json).to eq decoded_json
      end

    end
  end
end
