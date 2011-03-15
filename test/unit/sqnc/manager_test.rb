require 'test/unit'
require 'rubygems'
require 'steenzout-cfg'

# loading development environment configuration settings
Steenzout::ConfigurationManager.load 'config/development.yaml'

# load gem
require 'lib/steenzout-sqnc'



class TestSequenceManager < Test::Unit::TestCase

  def setup
    @config = Steenzout::ConfigurationManager.configuration_for_gem 'steenzout-sqnc'
  end

  def teardown
    @config[:sequences].each_key {|name|
      sequence_file = @config[:sequences][name][:location]
      File.delete sequence_file if File.exist? sequence_file
    }
  end



  def __do_increment_tests

    assert_equal 1, Steenzout::SequenceManager::increment(:seq1), @config[:implementation]
    assert_equal 2, Steenzout::SequenceManager::increment(:seq1), @config[:implementation]

    # invalid sequence name
    assert_raises ArgumentError do
      Steenzout::SequenceManager::increment 'seq1'
    end
    assert_raises ArgumentError do
      Steenzout::SequenceManager::increment 'unknown'
    end

  end



  def test_increment

    # run tests for all implementations
    Steenzout::SequenceManager.implementations {|implementation|

      # override configuration
      @config[:implementation] = implementation

      # load new sequence manager implementation
      Steenzout::SequenceManager.load

      # run tests
      __do_increment_tests
    }

  end



  def test_sequences

    sequence_names = []
    Steenzout::SequenceManager.sequences {|name| sequence_names << name}
    assert_equal([:seq1, :seq2], sequence_names)

  end

end