# -*- coding: utf-8 -*-

module Dcmgr
  module Drivers
    class LocalStore < Task::Tasklet
      helpers Task::LoggerHelper

      # download and prepare image files to ctx.os_devpath.
      def deploy_image(inst,ctx)
        raise NotImplementedError
      end

      # download and setup single image file.
      # it sets up empty image file when backup_object is set to nil.
      def deploy_volume(hva_ctx, volume, backup_object=nil, opts={})
        raise NotImplementedError
      end

      # delete an image file.
      def delete_volume(hva_ctx, volume)
        raise NotImplementedError
      end

      def upload_image(inst, ctx, bo, ev_callback)
        raise NotImplementedError
      end

      def self.driver_class(hypervisor_name)
        Hypervisor.driver_class(hypervisor_name).local_store_class
      end
    end
  end
end
