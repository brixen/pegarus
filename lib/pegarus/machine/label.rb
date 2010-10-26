module Pegarus
  module Machine
    class Generator
      class Label
        attr_reader :used
        alias_method :used?, :used

        def self.labels
          @labels ||= []
        end

        def initialize(generator)
          @generator = generator
          @position  = nil
          @location  = nil
          @locations = nil
          @used      = false

          self.class.labels << self
        end

        def set!
          @position = @generator.ip
          if @locations
            @locations.each { |x| @generator.program[x] = @position }
          elsif @location
            @generator.program[@location] = @position
          end
        end

        def used_at(ip)
          if @position
            @generator.program[ip] = @position
          elsif !@location
            @location = ip
          elsif @locations
            @locations << ip
          else
            @locations = [@location, ip]
          end
          @used = true
        end
      end
    end
  end
end
