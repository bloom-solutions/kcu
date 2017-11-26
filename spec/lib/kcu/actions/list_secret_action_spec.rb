require 'spec_helper'

module Kcu
  RSpec.describe ListSecretAction do

    let(:action) { described_class.("br_staging/web") }

    it "lists the kubernetes secret, decoded" do
    end

  end
end
