module Adaptable  
  autoload :XmlParser,  'adaptable/parsers/xml_parser'
  autoload :TextParser, 'adaptable/parsers/text_parser'
  
  class Parser
    
    class UndefinedParserError < StandardError ; end
    
    attr_accessor :fixture
    
    def initialize(fixture)
      @fixture = fixture
    end
    
    def self.for(fixture)
      klass_name = fixture.name.capitalize << 'Parser'
      Adaptable.const_get(klass_name).new(fixture)
    rescue LoadError, NameError => e
      raise UndefinedParserError.new('Invalid Parser: ' + e)
    end

  end
end