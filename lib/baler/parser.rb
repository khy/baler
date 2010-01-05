module Baler
  module Parser
    autoload :Document, File.dirname(__FILE__) + '/parser/document'
    autoload :Collection, File.dirname(__FILE__) + '/parser/collection'
    autoload :Element, File.dirname(__FILE__) + '/parser/element'
    autoload :Adapter, File.dirname(__FILE__) + '/parser/adapter'
    autoload :Support, File.dirname(__FILE__) + '/parser/support'
    
    DOCUMENT_ADAPTERS = {:hpricot => Adapter::Hpricot::Document}
    DEFAULT_DOCUMENT_ADAPTER = DOCUMENT_ADAPTERS.keys.first

    class << self
      def document(*args)
        type_or_adapters = args.shift
        if adapter_class = DOCUMENT_ADAPTERS[type_or_adapters || DEFAULT_DOCUMENT_ADAPTER]
          urls = args.shift
          adapters = urls.is_a?(Array) ? urls.map{|url| adapter_class.new(url)} : adapter_class.new(urls)
        else
          adapters = type_or_adapters
        end

        context_path = args.shift
        if adapters.is_a?(Array)
          Document::Collection.new(adapters.map{|adapter| Document.new(adapter, context_path)})
        else
          Document.new(adapters, context_path)
        end
      end

      def adapter(type, url)
        if adapter_class = DOCUMENT_ADAPTERS[type || DEFAULT_DOCUMENT_ADAPTER]
          adapter_class.new(url)
        end
      end

      def filter(object)
        if object.is_a? Parser::Collection
          object = object.length <= 1 ? object.first : object.to_array.map{|e| e.inner_html}
        end

        if object.is_a? Parser::Element
          object = object.inner_html
        end

        object
      end

      def wrap(object)
        case object
        when Parser::Adapter::Base::Element then element(object)
        when Parser::Adapter::Base::Collection then collection(object)
        else object
        end
      end

      def element(object)
        Parser::Element.new(object)
      end

      def collection(object = [])
        Parser::Collection.new(object)
      end
    end
  end
end
