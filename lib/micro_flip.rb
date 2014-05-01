#!/usr/bin/env ruby

require 'moneta'
require 'sqlite3'

module MicroFlip
  def self.setup(filename = '.micro_flip.db')
    DB.create(filename)
  end

  class DB
    attr_accessor :db, :filename
    def initialize(filename = '.micro_flip.db')
      @filename = filename
      @db = Moneta.build do
        adapter :Sqlite, file: filename
      end
    end

    def self.create(filename = '.micro_flip.db')
      $flip = new(filename)
    end

    def set(hash)
      hash.each do |k,v|
        db[k] = v
      end
    end

    def true?(key)
      db[key] == true || 'true' || 't' || 1 || '1'
    end

    def false?(key)
      db[key] == false || 'false' || 'f' || 0 || '0'
    end

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
