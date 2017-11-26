require 'spec_helper'

module Kcu
  module Secrets
    RSpec.describe SetEntryValue do

      let(:entry_value) { "Some string" }
      let(:encoded_entry_value) { Base64.strict_encode64(entry_value) }

      it "encodes entry_value to encoded_entry_value as Base64 (strict)" do
        resulting_ctx = described_class.execute({
          resource_namespace: "prod",
          resource_name: "worker",
          encoded_entry_value: encoded_entry_value,
        })
        expect(resulting_ctx.encoded_entry_value).to eq expected_value
      end

    end
  end
end
