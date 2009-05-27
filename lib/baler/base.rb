module Baler
  module Base
    module ClassMethods
      # Adds a Remote::Source instance to the class for the supplied URL.
      # A Remote::Source::Builder instance is yielded to the block.
      def set_remote_source(url)
        remote_source = Baler::Remote::Source.new(self, url)
        yield remote_source.builder if block_given?
        instance_variable_set(:@remote_source, remote_source)
      end
      
      # Returns the Remote::Source instance built by <tt>#set_remote_source</tt>
      def remote_source
        instance_variable_get(:@remote_source)
      end
      
      # Returns an array containing an instance of the parent class for each 
      # context element in the remote document. Each instance's attributes are 
      # gathered according to its array index.
      #
      # Options:
      # [<tt>:url_mapping</tt>]  Used to resolve the document's URL before gathering.
      def build(options = {})
        remote_source.build(options)
      end
      
      # _This method is only available for classes that use a recognized ORM_. 
      #
      # Functions similarly to <tt>#build</tt>, except that if an instance can
      # be loaded from the database using the defined lookup attributes, it will be.
      #
      # Options:
      # [<tt>:url_mapping</tt>]  Used to resolve the document's URL before gathering.
      def build_or_update(options = {})
        remote_source.build_or_update(options)
      end
    end
    
    module InstanceMethods
      # Applies each mapping in the remote source to the instance.
      #
      # Options:
      # [<tt>:index</tt>]       Specifies which context element will be referenced.
      # [<tt>:url_mapping</tt>] Used to resolve the document's URL before gathering.
      # [<tt>:attributes</tt>]  Specifies a subset of instance attributes to gather.
      # [<tt>:force</tt>]       When <tt>true</tt>, will ignore any gather conditions.
      def gather(options = {})
        self.class.remote_source.gather(self, options)
      end
    end
  end
end