module Steenzout

  class SequenceManager

    private

      def self.increment_and_store name

        open(@config[:sequences][name][:location], File::RDWR|File::CREAT, 0644) do |f|

          begin

            f.flock(File::LOCK_EX)

            value = @sequences[name] # get value from memory
            value = f.readline().to_i if @sequences[name].nil? rescue EOFError # get value from file
            value ||= @config[:sequences][name][:offset] # initialize value to offset if none of the above had a value
            value += @config[:sequences][name][:step]
            @sequences[name] = value
            f << value
            return value

          ensure
            f.flock(File::LOCK_UN)
            f.close
            end

        end
      end
    end

end