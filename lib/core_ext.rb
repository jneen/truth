Dir.glob(
  File.expand_path(
    File.join(
      File.dirname(__FILE__),
      'core_ext',
      '*.rb'
    )
  )
).each do |f|
  require f
end
