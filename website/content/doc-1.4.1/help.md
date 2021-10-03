Get help
========
Liquidsoap is a self-documented application,
which means that it can provide help about several of its aspects.
You will learn here how to get help by yourself, by asking liquidsoap.
If you do not succeed in asking the tool, you can of course get help from 
humans, preferably on the mailing list `savonet-users@lists.sf.net`.

Scripting API
-------------
When scripting in liquidsoap, one uses functions that are either *builtin*
(*e.g.* `fallback` or `output.icecast`)
or defined in the [script library](script_loading.html) (*e.g* `out`).
All these functions come with a documentation, that you can access by
executing `liquidsoap -h FUNCTION` on the command-line. For example:

```
$ liquidsoap -h sine
*** One entry in scripting values:
Generate a sine wave.
Category: Source / Input
Type: (?id:string, ?duration:float, ?float)->source
Parameters:
* id :: string (default "")
    Force the value of the source ID.
* duration :: float (default 0.)
* (unlabeled) :: float (default 440.)
    Frequency of the sine.
```

Of course if you do not know what function you need, you'd better go 
through the [API reference](reference.html).

Server commands
---------------
The server (*cf.* the [server](server.html) tutorial)
offers some help about its commands.
Once connected (either via a TCP or UNIX socket) the `help` command
gives you a list of available commands together with a short usage line.
You can then get more detailed information about a specific command
by typing `help COMMAND`:

```
$ telnet localhost 1234
Trying 127.0.0.1...
Connected to localhost.localdomain.
Escape character is '^]'.
help
Available commands:
[...]
| queue.ignore <rid>
| queue.push <uri>
| queue.queue
[...]
Type "help <command>" for more information.
END
help queue.push

Help for command queue.push.

Usage: queue.push <uri>
  Push a new request in the queue.
END
```

Settings
--------
Liquidsoap scripts contain expression like `set("log.stdout",true)`.
These are *settings*, global variables affecting the behaviour of the 
application.
Here, the first parameter identifies a setting its path,
and the second one specifies its new value.

You can have a list of available settings, with their documentation,
by running `liquidsoap --conf-descr`.
If you are interested in a particular settings section,
for example server-related stuff, use `liquidsoap --conf-descr-key server`.

The output of these commands is a valid liquidsoap script,
which you can edit to set the values that you want,
and load it ([implicitly](script_loading.html) or not) before you other scripts.

You can browse online the [list of available settings](settings.html).

All plugins
-----------
Several aspects of liquidsoap work with a notion of plugin: builtin scripting 
functions, audio decoders for files and streams, metadata decoders, protocols, 
etc. The list of plugins can be used to check that your build of 
liquidsoap has such or such feature, or simply to browse available functions 
-- actually, the [reference](reference.html) is built from that output.

You can get the pretty hairy list of all available plugins from the 
command `liquidsoap --list-plugins`, or `liquidsoap --list-plugins-xml` for a 
more parsable XML output.


