require 'rake/testtask'
$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")

Rake::TestTask.new do |t|
  t.test_files = FileList['specs/**/*_test.rb']
end
desc 'Run tests'

task default: :test
