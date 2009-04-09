module Baler
  module ORM
    class ActiveRecord < Abstract
      def self.for?(klass)
        begin
          klass.ancestors.include?(::ActiveRecord::Base)
        rescue NameError
          false
        end
      end
      
      def find(attribute_hash)
        @klass.find(:first, :conditions => attribute_hash)
      end
    end
  end
end