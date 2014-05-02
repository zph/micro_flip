#!/usr/bin/env ruby

require 'moneta'
require 'sqlite3'

module MicroFlip

  DEFAULT_FILENAME = '.micro_flip.db'
  def self.setup(filename = DEFAULT_FILENAME)
    DB.create(filename)
  end

  class DB
    attr_accessor :db, :filename
    def initialize(filename = DEFAULT_FILENAME)
      @filename = filename
      @db = Moneta.build do
        adapter :Sqlite, file: filename
      end
    end

    def self.create(filename = DEFAULT_FILENAME)
      $flip = new(filename)
    end

    def set(hash)
      hash.each do |k,v|
        db[k] = v
      end
    end

    def get(k)
      db[k]
    end

    def is_true?(key)
      values = [true , 'true' , 't' , 1 , '1']
      compare_values(key, values)
    end
    alias_method :t?, :is_true?

    def is_false?(key)
      values = [false , 'false' , 'f' , 0 , '0' , '' , nil]
      compare_values(key, values)
    end
    alias_method :f?, :is_false?

    def do_if(key, fn)
      fn.call if is_true?(key)
    end
    alias_method :do_if?, :do_if

    def do_unless(key, fn)
      fn.call unless is_true?(key)
    end
    alias_method :do_unless?, :do_unless

    def destroy
      File.rm_f filename
    end

    def method_missing(method, *args)
      if db.respond_to?(method)
        db.send(method, *args)
      else
        super
      end
    end

    private

    def compare_values(key, set)
      r = set.map do |v|
        db[key] == v
      end.compact
      !r.reject {|i| i == false }.empty?
    end
  end

  module CLI
    def self.parse_args(argv)
      args = argv.dup
      #TODO handle case where we get default= and set the 2nd bit to empty string
      #TODO maybe use optparser for this?
      hashes = args.flat_map { |a| Hash[*a.split('=') ] }
      hashes.reduce(&:merge)
    end

    def self.display_changes(hash, io = STDOUT)
      hash.each do |key, value|
        io.puts "Flip: #{key} set to #{value}"
      end
    end
  end
end
