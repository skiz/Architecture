module Adaptable
  class Parser
    
    class UndefinedParserError < StandardError ; end
    
    attr_accessor :fixture 
    def initialize(fixture)
      @fixture = fixture
    end
    
    def self.for(fixture)
      Dir[File.dirname(__FILE__) + '/parsers/*.rb'].each {|file| require file }
      klass = Adaptable.const_get(fixture.name.capitalize + 'Parser')
      klass.new(fixture)
    rescue NameError, TypeError => e
      raise UndefinedParserError.new('Invalid Parser: ' + e)
    end
    
    def to_s
      'Undefined Parser'
    end
    
  end
end