# -*- coding: utf-8 -*-

require 'spec_helper'
require 'yaml'

describe Dcmgr::Metadata::AWS do
  describe "#get_items" do
    subject(:items) { Dcmgr::Metadata::AWS.new(inst.to_hash).get_items }

    context 'with all settings to make it work' do
      let(:inst) do
        Fabricate(:instance, request_params: {}) do
          network_vif(count: 2) { Fabricate(:network_vif) }
        end
      end

      it 'sets metadata items that mimic the aws metadata layout' do
        expect(items['ami-id']).to eq inst.image.canonical_uuid
        expect(items['hostname']).to eq inst.hostname
        expect(items['instance-action']).to eq inst.state
        expect(items['instance-id']).to eq inst.canonical_uuid
        expect(items['instance-type']).to eq inst.image.instance_model_name
        expect(items['local-hostname']).to eq inst.hostname
      end
    end

    context "without request_params set" do
      let(:inst) { Fabricate(:instance) }

      it 'doesn\'t crash' do
        items
      end
    end
  end
end
