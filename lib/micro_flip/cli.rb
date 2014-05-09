module MicroFlip
  module CLI
    class << self

      def parse_args(argv)
        #TODO handle case where we get default= and set the 2nd bit to empty string
        #TODO maybe use optparser for this?
        hashes = argv.dup.flat_map do |a|
          arr = a.split('=')
          if arr.length == 1
            array = [arr.first, '']
          else
            array = arr
          end
          Hash[*array]
        end

        hashes.reduce(&:merge)
      end

      def display_changes(hash, io = STDOUT)
        Hash(hash).each do |key, value|
          value = "empty string" if value == ''
          io.puts "Flip: #{key} set to >> #{value} <<"
        end
        exit(1) if Hash(hash).empty?
      end

      def show_lib_flips
        matching_lines("lib/**/*.rb")
      end

      def show_bin_flips
        matching_lines("bin/**/*.rb")
      end

      def matching_lines(folder_glob)
        matches = Dir[folder_glob].flat_map do |file|
          File.open(File.expand_path(file)).readlines.select do |line|
            line[/\$flip/]
          end
        end
        puts matches

      end
    end

    class Optparser
      def self.parse(args)
        options = OpenStruct.new
        options.show_flips = false

        opts = OptionParser.new do |opts|
          opts.banner = "Usage: flip [options]"

          opts.separator ""
          opts.separator "Specific options:"

          # Optional argument; multi-line description.
          opts.on("-f", "--flips", "Show flips") do |ext|
            options.show_flips = true
          end
        end
        opts.parse!(args)
        options
      end

    end
  end
end
