require 'rake'

spec = Gem::Specification.new do |s|

  s.name         = 'steenzout-sqnc'
  s.version      = '1.0.6'

  s.authors      = ['steenzout']

  s.platform     = Gem::Platform::RUBY

  s.homepage     = 'https://github.com/steenzout/steenzout-cfg'

  s.summary      = 'Steenzout sequence management gem.'
  s.description = <<EOF
This gem provides simple sequence management functionality.
EOF

  s.has_rdoc     = true
  s.extra_rdoc_files = ["README.textile"]


  s.require_path = 'lib'
  s.files        = FileList["{lib}/**/*"].to_a
  s.test_files   = FileList["{test}/**/*test.rb"].to_a

  s.add_dependency 'steenzout-cfg', '>= 1.0.4'

end
