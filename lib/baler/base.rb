module Baler
  module Base
    module ClassMethods
      def set_remote_source(url)
        remote_source = Baler::Remote::Source.new(url)
        yield remote_source if block_given?
        instance_variable_set(:@remote_source, remote_source)
      end
      
      def remote_source
        instance_variable_get(:@remote_source)
      end
    end
    
    module InstanceMethods
      def gather
        self.class.remote_source.mappings.each do |mapping|
          send("#{mapping.attribute}=", mapping.value)
        end
        self
      end
      alias_method :harvest, :gather
    end
  end
end