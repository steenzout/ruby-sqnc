require 'rubygems'
require 'steenzout-cfg'

module Steenzout

  autoload :SequenceManager, "#{File.dirname(__FILE__)}/sqnc/manager"

end

Steenzout::SequenceManager.load