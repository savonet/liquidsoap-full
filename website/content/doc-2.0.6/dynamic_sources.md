Liquidsoap supports dynamic creation and destruction of sources 
during the execution of a script. The following gives an example
of this.

First some outlines:

* This example is meant to create a new source and outputs. It is not easy currently to change a source being streamed
* The idea is to create a new output using a telnet/server command.

In this example, we will register a command that dynamically create a new output based on an encoded stream
and output it to an arbitrary url, as supported by the ffmpeg copy encoder. This script can be used to create 
a dynamic restreaming platform.

Here's the code:

```liquidsoap
settings.init.force_start.set(true)
settings.server.telnet.set(true)

# Replace the path here with a path to some video files:
s = playlist("/path/to/files")

streams = ref([])
count = ref(0)

enc = %ffmpeg(
  format="flv",
  %audio.copy,
  %video.copy
)

def create_stream(url) =
  if list.assoc.mem(url, !streams) then
    "Stream for url #{url} already exists!"
  else
    out = output.url(id="restream-#{!count}", fallible=true, url=url, enc, s)
    count := !count + 1
    streams := [...!streams, (url, out.shutdown)]
    "OK!"
  end
end

def delete_stream(url) =
  if not list.assoc.mem(url, !streams) then
    "Stream for url #{url} does not exists!"
  else
    shutdown = list.assoc(url, !streams)
    shutdown()
    streams := list.filter((fun (el) -> fst(el) != url), !streams)
    "OK!"
  end
end

server.register(namespace="restream",
                description="Redirect a stream.",
                usage="start <url>",
                "start",
                create_stream)
server.register(namespace="restream",
                description="Stop a dynamic playlist.",
                usage="stop <url>",
                "stop",
                delete_stream)
```

After executing this script, you should see two telnet commands:

* `restream.start <uri>`
* `restream.stop <uri>`

which you can use to create/destroy dynamically your sources.

