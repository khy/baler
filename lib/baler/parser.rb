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
      def document(type_or_adapter, url, context_path = nil)
        if adapter_class = DOCUMENT_ADAPTERS[(type_or_adapter || DEFAULT_DOCUMENT_ADAPTER)]
          adapter = adapter_class.new(url)
        else
          adapter = type_or_adapter
        end

        Document.new(adapter, context_path)
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
    end
  end
end
