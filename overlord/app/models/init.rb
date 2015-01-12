DataMapper.finalize
configure :test do
  DataMapper.auto_migrate!
end
DataMapper::Model.raise_on_save_failure = true