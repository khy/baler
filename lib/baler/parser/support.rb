module Baler
  module Parser
    module Support
      module Proxy
        def wrap(object)
          object
        end

        alias_method :proxy_respond_to?, :respond_to?
        def respond_to?(message, include_private = false)
          !!(subject.respond_to?(message, include_private) || proxy_respond_to?(message, include_private))
        end

        protected
          def method_missing(*args, &block)
            result = subject.respond_to?(args.first) ? subject.send(*args, &block) : super(*args, &block)
            wrap(result)
          end
      end
    end
  end
end