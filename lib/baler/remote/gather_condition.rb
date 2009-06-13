module Baler
  module Remote
    class GatherCondition
      def initialize(object, expected_value)
        @object = object
        @expected_value = expected_value
      end

      def met?(instance)
        return_value(instance) == @expected_value
      end
      
      private
        def return_value(instance)
          @object.is_a?(Proc) ? instance.instance_eval(&@object) : instance.method(@object).call
        end
    end
  end
end