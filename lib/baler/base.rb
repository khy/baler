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
      
      def build
        remote_source.build
      end
    end
    
    module InstanceMethods
      def gather(index = nil, options = {})
        self.class.remote_source.gather(self, index, options)
      end
    end
  end
end