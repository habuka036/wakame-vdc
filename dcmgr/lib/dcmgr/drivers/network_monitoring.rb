# -*- coding: utf-8 -*-
require 'fuguta'

module Dcmgr::Drivers
  class NetworkMonitoring
    class Configuration < Fuguta::Configuration; end

    def register_instance(instance)
      raise NotImplementedError
    end

    def unregister_instance(instance)
      raise NotImplementedError
    end

    def update_instance(instance)
      raise NotImplementedError
    end

    def self.driver_class(key)
      case key.to_s
      when 'zabbix'
        Zabbix
      when 'public_zabbix'
        PublicZabbix
      else
        raise "Unknown network monitoring driver: #{key}"
      end
    end
  end
end
