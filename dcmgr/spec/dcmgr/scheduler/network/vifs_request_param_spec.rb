# -*- coding: utf-8 -*-

require 'spec_helper'

Dir["#{File.dirname(__FILE__)}/vifs_request_param_examples/*.rb"].each {|f| require f }

describe "Dcmgr::Scheduler::Network::VifsRequestParam" do
  def set_dhcp_range(network)
    nw_ipv4 = IPAddress::IPv4.new("#{network.ipv4_network}/#{network.prefix}")

    Fabricate(:dhcp_range, network: network,
                           range_begin: nw_ipv4.first,
                           range_end: nw_ipv4.last)
  end

  describe "#schedule" do
    subject(:inst) do
      i = Fabricate(:instance, request_params: {"vifs" => vifs_parameter})

      Dcmgr::Scheduler::Network::VifsRequestParam.new.schedule(i)

      i
    end

    before { Fabricate(:mac_range) }

    #
    # Sad paths
    #

    include_examples "malformed vifs"
    include_examples "dhcp range exhausted"

    #
    # Happy paths
    #

    include_examples "empty vifs"
    include_examples "single vif"
    include_examples "two vifs"
    include_examples "single vif no network"
  end
end
