Interaction with the server
===========================
Liquidsoap starts with one or several scripts as its configuration, and then
streams forever if everything goes well. Once started, you can still interact
with it by means of the *server*. The server allows you to run commands. Some
are general and always available, some belong to a specific operator. For
example the `request.queue()` instances register commands to enqueue new
requests, the outputs register commands to start or stop the outputting, display
the last ten metadata chunks, etc.

The protocol of the server is a simple human-readable one. Currently it does not
have any kind of authentication and permissions. It is currently available via
two media: TCP and Unix sockets. The TCP socket provides a simple telnet-like
interface, available only on the local host by default. The Unix socket
interface (*cf.* the `server.socket` setting) is through some sort of virtual
file. This is more constraining, which allows one to restrict the use of the
socket to some priviledged users.

You can find more details on how to configure the server in the
[documentation](help.html#settings) of the settings key `server`, in particular
`server.telnet` for the TCP interface and `server.socket` for the Unix
interface. Liquidsoap also embeds some [documentation](help.html#server) about
the available server commands.

Now, we shall simply enable the Telnet interface to the server, by setting
`set("server.telnet",true)` or simply passing the `-t` option on the
command-line. In a [complete case analysis](complete_case.html) we set up a
`request.queue()` instance to play user requests. It had the identifier
`"queue"`. We are now going to interact via the server to push requests into
that queue:

```
dbaelde@selassie:~$ telnet localhost 1234
Trying 127.0.0.1...
Connected to localhost.localdomain.
Escape character is '^]'.
queue.push /path/to/some/file.ogg
5
END
request.metadata 5
[...]
END
queue.push http://remote/audio.ogg
6
END
request.trace 6
[...see if the download started/succeeded...]
END
exit
```

Of course, the server isn't very user-friendly. But it is easy to write scripts
to interact with Liquidsoap in that way, to implement a website or an IRC
interface to your radio. However, this sort of tool is often bound to a specific
usage, so we have not released any of ours. Feel free to [ask the
community](mailto:savonet-users@lists.sf.net) about code that you could re-use.

Interactive variables
---------------------
Sometimes it is useful to control a variable using telnet. A simple way to
achive this is to use the `interactive.float` function. For instance, in order
to dynamically the volume of a source:
```liquidsoap
# Register a telnet variable named volume with 1 as initial value
v = interactive.float("volume", 1.)

# Change the volume accordingly
source = amplify(v, source)
```
The first line registers the variable volume on the telnet. Its value can be
changed using the telnet command
```liquidsoap
var.set volume = 0.5
```
and it can be retrieved using
```liquidsoap
var.get volume
```
Similarly, we can switch between two tracks using `interactive.bool` and
`switch` as follows:
```liquidsoap
# Activate the telnet server
set("server.telnet",true)

# The two sources
s1 = playlist("~/Music")
s2 = sine()

# Create an interactive boolean
b = interactive.bool("button", true)

# Switch between the tracks depending on the boolean
s = switch(track_sensitive=false,[(b,s1), ({true},s2)])

# Output the result
output.pulseaudio(s)
```

By default the source s1 is played. To switch to s2, you can connect on
the telnet server and type `var.set button = false`.

Interactive commands
--------------------
Starting with liquidsoap version `1.3.4`, you can register custom server commands
to interact with the client with applications such as implementing a `pub/sub` mechanism.

There main commands are:

* `server.write`, `server.read`, `server.readchars` and `server.readline` to read and write interactively
* `server.condition`, `server.wait`, `server.signal` and `server.broadcast` to control the execution of the command

### Read/Write

Writing a partial response is done using the following syntactic sugar:
```liquidsoap
server.write "string to write" then
  log("string done writting!")
  # Do more stuff then send the final response:
  "Done!"
end
```
Read a value can be done 3 different ways. Most simple one is `server.readline`:
```liquidsoap
server.readline ret then
  log("Read line: #{ret}")
  # Do more stuff then send the final response:
  "Done!"
end
```
Then you can read a fixed number of characters:
```liquidsoap
server.readchars 15 : ret then
  log("Read 15 characters: #{ret}")
  # Do more stuff then send the final response:
  "Done!"
end
```
Finally, you can read until reaching a marker, which can be any string or regular expression:
```liquidsoap
server.read "OVER[\r\n]+" :  ret then
  log("Read until OVER: #{ret}")
  # Do more stuff then send the final response:
  "Done!"
end
```

### Control flow

You can pause and resume server commands using an API similar to Unix conditions:

* `server.condition()` creates a condition variable
* `server.wait` pauses a server command. See below for details
* `server.signal(c)` resumes one waiting command
* `server.broadcast(c)` resumes all waiting commands

`server.wait` is used through a syntactic sugar:

```liquidsoap
server.wait c then
  log("Command has resumed!")
  # Do more stuff then send the final response:
  "Done!"
end
```

### Full example

In the following, we define two commands:

* `wait`: when executing the command, the client waits for a message. Message can be one of:
  * `"exit"`: terminate command
  * `"read"`: read one line from the client and print it back
  * Otherwise, the client prints the received value
* `send <value>`: when executing this command, the client sends `<value>` to all waiting clients.

```liquidsoap
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
```

Example of use:

`send`:

```liquidsoap
Connected to localhost.
Escape character is '^]'.
send foo
Ok!
END
send read
Ok!
END
send exit
Ok!
END
```

`wait`:

```liquidsoap
Connected to localhost.
Escape character is '^]'.
wait
>> Received value: foo
>> Write me sumething mister..
Here's to you mon ami!
Read: Here's to you mon ami!
>> All done!
END
exit
Bye!
```

Securing the server
-------------------
The command server provided by liquidsoap is very convenient for manipulating a
running instance of Liquidsoap. However, no authentication mechanism is
provided. The telnet server has no authentication and listens by default on the
localhost (`127.0.0.1`) network interface, which means that it is accessible to
any logged user on the machine.

Many users have expressed interest into setting up a secured access to the
command server, using for instance user and password information. While we
understand and share this need, we do not believe this is a task that lies into
Liquidsoap's scope. An authentication mechanism is not something that should be
implemented naively. Being SSH, HTTP login or any other mechanism, all these
methods have been, at some point, exposed to security issues. Thus, implementing
our own secure access would require a constant care about possible security
issues.

Rather than doing our own home-made secure acces, we believe that our users
should be able to define their own secure access to the command server, taking
advantage of a mainstream authentication mechanism, for instance HTTP or SSH
login. In order to give an example of this approach, we show here how to create
a SSH access to the command server: we create a SSH user that, when logging
through SSH, has only access to the command server.

First, we enable the unix socket for the command server in Liquidsoap:
```liquidsoap
set("server.socket",true)
set("server.socket.path","/path/to/socket")
```

When started, liquidsoap will create a socket file `/path/to/socket`
that can be used to interact with the command server. For instance,
if your user has read and write rights on the socket file, you can do
```liquidsoap
socat /path/to/socket -
```

The interface is then exactly the same has for the telnet server.

We define now a new ``shell''. This shell is in fact the invokation of the socat
command. Thus, we create a `/usr/local/bin/liq_shell` file with the following
content:
```bash
#!/bin/sh
# We test if the file is a socket, readable and writable.
if [ -S /path/to/socket ] && [ -w /path/to/socket ] && \
   [ -r /path/to/socket ]; then
  socat /path/to/socket -
else
# If not, we exit..
  exit 1
fi
```

We set this file as executable, and we add it in the list of shells in `/etc/shells`.

Now, we create a user with the `liq_shell` as its shell:
```
adduser --shell /usr/local/bin/liq_shell liq-user
```

You also need to make sure that `liq-user` has read and write rights
on the socket file.

Finally, when logging through ssh with `liq-user`, we get:
```
11:27 toots@leonard % ssh liq-user@localhost
liq-user@localhost's password:
Linux leonard 2.6.32-4-amd64 #1 SMP Mon Apr 5 21:14:10 UTC 2010 x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Tue Oct  5 11:26:52 2010 from localhost
help
Available commands:
(...)
| exit
| help [<command>]
| list
| quit
| request.alive
| request.all
| request.metadata <rid>
| request.on_air
| request.resolving
| request.trace <rid>
| uptime
| var.get <variable>
| var.list
| var.set <variable> = <value>
| version

Type "help <command>" for more information.
END
exit
Bye!
END
Connection to localhost closed.
```

This is an example of how you can use an existing secure access to 
secure the access to liquidsoap's command server. This way, you make sure
that you are using a mainstream secure application, here SSH.

This example may be adapted similarly to use an online HTTP login 
mechanism, which is probably the most comment type of mechanism
intented for the command line server.
