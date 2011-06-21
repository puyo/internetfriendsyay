task :coverme do
  require 'cover_me'

  ENV['COVER_ME'] = 'true'

  Rake::Task['spec'].invoke

  processor = CoverMe::Processor.new(CoverMe::Results.read_results)
  processor.process!
  percent = processor.index.percent_tested
  puts "CoverMe reports test coverage #{percent}%"
  threshold = 100.0
  if percent < threshold
    CoverMe.config.at_exit.call
    raise "Coverage #{processor.index.percent_tested}% < #{threshold}%"
  end
end
