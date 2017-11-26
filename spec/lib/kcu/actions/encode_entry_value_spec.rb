require 'spec_helper'

module Kcu
  module Secrets
    RSpec.describe EncodeEntryValue do

      let(:entry_value) do
        "some really long string that would contain a newline somewhere if " +
          "it were not strictly encoded"
      end
      let(:expected_value) { Base64.strict_encode64(entry_value) }

      it "encodes entry_value to encoded_entry_value as Base64 (strict)" do
        resulting_ctx = described_class.execute(entry_value: entry_value)
        expect(resulting_ctx.encoded_entry_value).to eq expected_value
      end

    end
  end
end
