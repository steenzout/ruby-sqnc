require 'tokyocabinet'

include TokyoCabinet



module Steenzout

  class SequenceManager

    private

      def self.increment_and_store name
        raise ArgumentError "TokyoCabinet implementation is not ready!"
      end

  end
end