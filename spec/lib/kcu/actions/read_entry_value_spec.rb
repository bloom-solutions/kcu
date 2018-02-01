require 'spec_helper'

module Kcu
  module Secrets
    RSpec.describe ReadEntryValue do

      let(:entry_value) do
        "some really long string that would contain a newline somewhere if " +
          "it were not strictly encoded"
      end

      context "from explicit literal" do
        let(:options) { OpenStruct.new(from_file: "doesnotmatter") }
        it "leaves entry_value as is" do
          resulting_ctx = described_class.execute(
            entry_value: entry_value,
            options: options,
          )
          expect(resulting_ctx.entry_value).to eq entry_value
        end
      end

      context "from options.from_file exists" do
        let(:file) do
          f = Tempfile.new("foo")
          f.write(entry_value)
          f.close
          f
        end
        let(:options) { OpenStruct.new(from_file: file.path) }
        it "sets entry_value to be the file contents" do
          resulting_ctx = described_class.execute(
            entry_value: nil,
            options: options,
          )
          expect(resulting_ctx.entry_value).to eq entry_value
        end
      end

    end
  end
end
