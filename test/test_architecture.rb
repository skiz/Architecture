require 'helper'

class TestArchitecture < Test::Unit::TestCase
  include Adaptable
  
  def test_should_be_able_to_access_parser
    assert(defined?(Parser), "Architecture::Parser undefined")
  end

  def test_should_have_working_fixture
    f = Fixture.new('Smiley')
    assert(f.name == 'Smiley', "Fixture broken")
  end
  
  def test_should_be_able_to_create_instance_with_fixture
    fixture = Fixture.new('xml')
    parser  = Parser.new(fixture)
    assert_equal(fixture, parser.fixture)
  end
  
  def test_should_load_custom_parser_dynamically
    fixture = Fixture.new('xml')
    assert Parser.for(fixture).is_a?(XmlParser), 'XmlParser not loading properly'
  end
  
  def test_should_cleanly_handle_missing_parsers
    assert_raise(Parser::UndefinedParserError) do
      fixture = Fixture.new('bogus')
      Parser.for(fixture)
    end
  end
  
  def test_should_actually_be_usable
    fixture = Fixture.new('xml')
    assert_equal '<xml />', Parser.for(fixture).to_s
  end
  
  def test_should_skip_broken_files
    assert_raise(Parser::UndefinedParserError) do
      fixture = Fixture.new('broken')
      Parser.for(fixture)
    end
  end
  
  def test_should_skip_invalid_parsers
    assert_raise(Parser::UndefinedParserError) do
      fixture = 'fail'
      Parser.for(fixture)
    end
  end
  
end
