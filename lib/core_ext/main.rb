# I fixed ruby loadpaths
def require_local(*filename)
  filename = File.join(filename)
  local_glob = File.expand_path(
    File.join(
      File.dirname(
        caller.first.split(':').first
      ),
      *filename.split('/')
    )
  )

  local_glob.unchomp!('.rb')

  Dir.glob(local_glob).each do |file|
    require file
  end
end
