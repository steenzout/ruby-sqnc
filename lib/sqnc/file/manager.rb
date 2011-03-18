module Steenzout

  class SequenceManager

    private

      # Increments the counter and stores it into a file.
      # If the current counter is not already in memory,
      # it will read the initial value from the sequence file.
      # If the sequence file is empty, it will set the counter
      # to the configured offset and increment it.
      #
      # @param name: the name of the sequence.
      #
      def self.increment_and_store(name)

        open(@config[:sequences][name][:location], File::RDWR|File::CREAT, 0644) do |f|

          begin

            f.flock(File::LOCK_EX)

            # read counter from memory or disk
            value = @sequences[name] # get value from memory
            value = f.readline().to_i if @sequences[name].nil? rescue EOFError # get value from file

            # initialize counter to offset, if needed
            value ||= @config[:sequences][name][:offset] # initialize value to offset if none of the above had a value
            # increment
            value += @config[:sequences][name][:step]

            # write new counter into file
            f.rewind if f.pos > 0
            f << value
            f.truncate(f.pos)

            @sequences[name] = value

            return value

          ensure
            f.flock(File::LOCK_UN)
            f.close
          end

        end
      end
    end

end