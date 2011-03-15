module Steenzout

  class SequenceManager

    @@sequences = {}

    def self.load_from_tokyocabinet

    end

    def self.load_from_yaml
      config = Steenzout::ConfigurationManager.configuration_for_gem 'steenzout-sqnc'
      @@sequences = config[:sequences]
    end

    def self.reload
      config = Steenzout::ConfigurationManager.configuration_for_gem 'steenzout-sqnc'
      load_from_yaml if config[:method] == 'yaml'
      end


    def self.list_sequences
      @@sequences
    end

    def self.increment_sequence name
      @@sequences[name] = @@sequences[name] + 1
    end

    reload

  end
end