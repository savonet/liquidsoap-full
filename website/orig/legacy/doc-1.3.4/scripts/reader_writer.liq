c = server.condition()

value = ref ""

def wait(_) =
  def rec fn () =
    server.write ">> " then
      server.wait c then
        value = !value
        if value == "exit" then
          "All done!"
        elsif value == "read" then
          server.write "Write me sumething mister..\n" then
            server.readline ret then
              server.write "Read: #{ret}\n" then
                fn()
              end
            end
          end
        else
          server.write "Received value: #{value}\n" then
            fn()
          end
        end
      end
    end
  end

  fn ()
end

def send(v) =
  value := v
  server.signal(c)
  "Ok!"
end
