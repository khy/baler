module Baler
  module Base
    module ClassMethods
      def set_remote_source(url)
        remote_source = Baler::Remote::Source.new(self, url)
        yield remote_source.builder if block_given?
        instance_variable_set(:@remote_source, remote_source)
      end
      
      def remote_source
        instance_variable_get(:@remote_source)
      end
      
      def build(options = {})
        remote_source.build(options)
      end
      
      def build_or_update(options = {})
        remote_source.build_or_update(options)
      end
    end
    
    module InstanceMethods      
      def gather(options = {})
        self.class.remote_source.gather(self, options)
      end
    end
  end
end