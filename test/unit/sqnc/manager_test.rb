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

    # default sequence manager
    @config[:implementation] = :file

    # add value to a sequence file
    File.open(@config[:sequences][:seq3][:location], 'w') {|f| f.write('111')}

  end

  def teardown

    @config[:sequences].each_key {|name|
      sequence_file = @config[:sequences][name][:location]
      File.delete sequence_file if File.exist? sequence_file
    }

  end



  def test_increment

    # run tests for all implementations
    Steenzout::SequenceManager.implementations.each {|implementation|

      # override configuration
      @config[:implementation] = implementation

      # load new sequence manager implementation
      Steenzout::SequenceManager.load

      # run tests
      # no step and no offset defined
      sequence_file1 = @config[:sequences][:seq1][:location]

      assert_equal 1, Steenzout::SequenceManager::increment(:seq1), @config[:implementation]
      assert_equal 1, File.read(sequence_file1).to_i

      assert_equal 2, Steenzout::SequenceManager::increment(:seq1), @config[:implementation]
      assert_equal 2, File.read(sequence_file1).to_i


      # step=100 and offset=100
      sequence_file2 = @config[:sequences][:seq2][:location]

      assert_equal 200, Steenzout::SequenceManager::increment(:seq2), @config[:implementation]
      assert_equal 200, File.read(sequence_file2).to_i

      assert_equal 300, Steenzout::SequenceManager::increment(:seq2), @config[:implementation]
      assert_equal 300, File.read(sequence_file2).to_i
    }

  end



  def test_increment_with_file_containing_initial_value

    # override configuration
    @config[:implementation] = :file

    # load new sequence manager implementation
    Steenzout::SequenceManager.load

    # run tests
    sequence_file3 = @config[:sequences][:seq3][:location]

    assert_equal 112, Steenzout::SequenceManager::increment(:seq3), @config[:implementation]
    assert_equal 112, File.read(sequence_file3).to_i

    assert_equal 113, Steenzout::SequenceManager::increment(:seq3), @config[:implementation]
    assert_equal 113, File.read(sequence_file3).to_i

  end



  def test_increment_with_invalid_sequence_names

    # invalid sequence name
    assert_raises ArgumentError do
      Steenzout::SequenceManager::increment 'seq1'
    end
    assert_raises ArgumentError do
      Steenzout::SequenceManager::increment 'unknown'
    end

  end



  def test_sequences

    result = []
    Steenzout::SequenceManager.sequences {|name| result << name.to_s}
    result.sort!

    expected = ['seq1', 'seq2', 'seq3']
    expected.sort!
    
    assert_equal expected, result

  end

end