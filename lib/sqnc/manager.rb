module Steenzout

  class SequenceManager

    class << self; attr_accessor :sequences end
    class << self; attr_accessor :implementations end

    @config = nil
    @sequences = {}
    @implementations = [:file]


    private

      # Validates gem configuration and initializes the class' sequences.
      #
      def self.load_sequences

        @config[:sequences].each_key do |name|


          # validate :location

          raise ArgumentError.new \
            "Sequence file location #{@config[:sequences][name][:location]} needs to be defined!" \
            if !@config[:sequences][name].has_key? :location


          # validate :offset

          @config[:sequences][name][:offset] ||= 0
          raise ArgumentError.new \
            "Offset value #{@config[:sequences][name][:offset]} for #{name} sequence needs to be >= 0!" \
            if @config[:sequences][name][:offset] < 0


          # validate :step

          @config[:sequences][name][:step] ||= 1
          raise ArgumentError.new \
            "Step value #{@config[:sequences][name][:step]} for #{name} sequence needs to be > 0!" \
            if @config[:sequences][name][:step] <= 0


          # initialize sequence

          @sequences[name] = nil

        end

      end



    public

      # Returns the list of allowed sequence management implementations.
      #
      def self.implementations
        @implementations
      end



      # Validates the configuration and loads the class with the given implementation.
      #
      def self.load

        # retrieve configuration

        @config = Steenzout::ConfigurationManager.configuration_for_gem 'steenzout-sqnc'
        @config[:sequences] ||= {}


        # validation

        if !@config.has_key? :implementation or @config[:implementation].nil?
          error_message = "implementation property is missing from the configuration file!"
          raise ArgumentError.new error_message
        end

        raise ArgumentError.new "there is no #{@config[:implementation]} implementation!" if
            !@implementations.include? @config[:implementation] or
                !File.exist? "#{File.dirname(__FILE__)}/#{@config[:implementation]}/manager.rb"


        # load implementation

        require "#{File.dirname(__FILE__)}/#{@config[:implementation]}/manager"


        # load sequences

        load_sequences

      end



      # Returns the current in-memory value for this sequence.
      # WARNING: if the sequence hasn't been used yet, a nil value will be returned.
      #
      # @param name: the sequence name.
      #
      def self.current_value name

        raise ArgumentError.new "The sequence #{name} doesn't exist!" if !@sequences.has_key? name

        return @sequences[name]

      end



      # Increments and returns the given sequence by step (or offset + step if it has never been used before).
      #
      # @param name: the sequence name.
      #
      def self.increment name
        raise ArgumentError.new "The sequence #{name} doesn't exist!" if !@sequences.has_key? name
        self.increment_and_store name
      end


      # Returns a list of the current sequence names being managed.
      #
      def self.sequences
        @sequences.each_key {|name|
          yield name
        }
      end

  end
end