require 'spec_helper'

module Kcu
  RSpec.describe GetResourceNamespaceAndName do

    let(:resulting_ctx) { described_class.execute(resource: resource) }
    let(:resource_namespace) { resulting_ctx.resource_namespace }
    let(:resource_name) { resulting_ctx.resource_name }

    context "given a resource with namespace defined" do
      let(:resource) { "prod/web" }
      it "sets the namespace and name to be the given details" do
        expect(resource_namespace).to eq "prod"
        expect(resource_name).to eq "web"
      end
    end

    context "given a resource without namespace defined" do
      let(:resource) { "web" }
      it "sets the namespace to default, and name to the given" do
        expect(resource_namespace).to eq "default"
        expect(resource_name).to eq "web"
      end
    end

  end
end
