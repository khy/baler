module Baler
  module Base
    module ClassMethods
      # Adds a remote source to the class. Can be called using two forms:
      #
      #  set_remote_source "www.example.com" do ...
      #
      # will create an anonymous remote source for the specified url, while
      #
      #  set_remote_source :main => "www.example.com" do ...
      #
      # will create a named remote source. Named remote sources are useful
      # when more than one is defined for a class.
      #
      # The details of the remote source are defined within the block, using
      # the <tt>Remote::Source::Builder</tt> instance that is yielded to it.
      def set_remote_source(arg = nil)
        name, url = arg.is_a?(Hash) ? arg.shift : [nil, arg]
        remote_source = Baler::Remote::Source.new(self, name, url)
        
        if block_given?
          yield remote_source.builder
        else
          raise Baler::NoBlockGiven
        end
        
        remote_sources << remote_source
        return remote_source
      end

      # Returns an array of class instances of the parent, each corresponding
      # to a context element in the remote source, with the attributes
      # gathered appropriately
      #
      # If <tt>name</tt> is supplied, the correspoding remote source is used; 
      # otherwise the first is used.
      #
      # Options:
      # [<tt>:url_mapping</tt>]  Used to resolve the document's URL before gathering.
      def build(*args)
        options = args.extract_options
        remote_source(args.pop).build(options)
      end
      
      # _This method is only available for classes that use a recognized ORM_. 
      #
      # Functions similarly to <tt>#build</tt>, except that if an instance can
      # be loaded from the database using the defined lookup attributes, it will be.
      #
      # If <tt>name</tt> is supplied, the correspoding remote source is used; 
      # otherwise the first is used.
      #
      # Options:
      # [<tt>:url_mapping</tt>]  Used to resolve the document's URL before gathering.
      def build_or_update(*args)
        options = args.extract_options
        remote_source(args.pop).build_or_update(options)
      end
      
      def remote_source(name = nil) #:nodoc:
        raise(NoSourcesDefined) unless remote_sources.any?
        
        remote_source = name ? 
          remote_sources.find{|source| source.name == name} : 
          remote_sources.first
          
        remote_source || raise(SourceNotDefinedForName)
      end
      
      def remote_sources #:nodoc:
        @remote_sources ||= []
      end
    end
    
    module InstanceMethods
      # Applies each mapping in the remote source to the instance.
      #
      # If <tt>name</tt> is supplied, the correspoding remote source is used; 
      # otherwise the first is used.
      #
      # Options:
      # [<tt>:index</tt>]       Specifies which context element will be referenced.
      # [<tt>:url_mapping</tt>] Used to resolve the document's URL before gathering.
      # [<tt>:attributes</tt>]  Specifies a subset of instance attributes to gather.
      # [<tt>:force</tt>]       When <tt>true</tt>, will ignore any gather conditions.
      def gather(*args)
        options = args.extract_options
        self.class.remote_source(args.pop).gather(self, options)
      end
    end
  end
end