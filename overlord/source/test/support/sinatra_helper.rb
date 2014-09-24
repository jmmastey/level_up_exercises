# rubocop:disable all
def start_server(reloading = false)
  return unless $pid.nil?
  $pid = fork do
    begin
      load "main.rb"
      ::Overlord::ApplicationController.run!(logging: false) do
        ::Guard::UI.info("Sinatra has started!") unless reloading
      end
    rescue => e
      ::Guard::UI.error("Sinatra died (#{e.inspect})")
    end
  end
end

def stop_server(reloading = false)
  ::Guard::UI.info("Sinatra has stopped!") unless reloading
  Process.kill(9, $pid) unless $pid.nil?
  $pid = nil
end

def reload_server
  ::Guard::UI.info("Sinatra has reloaded!")
  stop_server(true)
  start_server(true)
end
# rubocop:enable all