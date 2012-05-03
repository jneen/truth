require './lib/truth'

Gem::Specification.new do |s|
  s.name = 'truth'
  s.version = IPLogic::VERSION

  s.authors = ["Jay Adkisson"]
  s.date = Date.today

  s.description = <<-desc.strip
    Datacenter truth
  desc

  s.summary = <<-sum
    (summary forthcoming)
  sum

  s.email = %q{jjmadkisson@gmail.com}
  s.extra_rdoc_files = %w(
    LICENSE
    README.md
  )

  s.files = %w(
    Rakefile
    LICENSE
    README.md
    truth.gemspec
    lib/**/*.rb
  ).map(&Dir.method(:glob)).flatten

  s.homepage = 'http://github.com/jayferd/truth'
  s.require_paths = ["lib"]

  s.test_files = Dir.glob('spec/**/*.rb')
end

