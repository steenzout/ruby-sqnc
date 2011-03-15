require 'kyotocabinet'

include KyotoCabinet



module Steenzout

  class SequenceManager

    private

      def self.increment_and_store name
        raise ArgumentError "KyotoCabinet implementation is not ready!"
      end

  end
end