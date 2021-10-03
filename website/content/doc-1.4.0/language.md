Liquidsoap's scripting language
===============================
Liquidsoap's scripting language is a simple functional language,
with labels and optional parameters.
It is statically typed, but infers types -- you don't have to write any types.
It allows the direct handling of liquidsoap notions such
as [sources](sources.html) and [requests](requests.html),
and also provides a convenient syntax for specifying time intervals.

Constants
---------
The constants and their syntax are quite common:

* integers, such as `42`;
* floats, such as `3.14`;
* booleans `true` and `false`;
* strings, such as `"foo"` or `'bar'`.

**Beware**: `3.0` is not an integer and `5` is not a float, the dot matters.

Strings might be surrounded by double or single quotes. In both cases, you can escape the quote you're using: `"He said: \"Hello, you\"."` is valid but `'He said: "Hello, you".'` is equivalent and nicer.

You can include variables in a string using the `#{...}`
syntax:
`"foo #{quote(my_var)} bar"` is equivalent to
`"foo " ^ quote(my_var) ^ " bar"`.

Finally, strings can be interpolated using the following syntax:

```
# s = 'This is an $(name) string. \
       This is a $(if $(value),"$(value)","undefined") value.';;
# s % [("name","interpolated")];;
- : string = "This is an interpolated string.This is a undefined value."
# s % [("name","interpolated"),("value","defined")];;
- : string = "This is an interpolated string.This is a defined value."
```

Most notably, `output.file` can use string interpolation to specify a different file name
using the source's metadata.

Expressions
-----------
You can form expressions by using:

* Constants and variable identifiers. Identifiers start with an alphabetic character or an underscore, followed by alphanumerics, underscores, dots and quotes: `[A-Z a-z _][A-Z a-z 0-9 _.']*`.
* Lists and pairs: `[expr,expr,...]` and `(expr,expr)`.
* Comparison of values is done using `expr == expr` and its negation is `expr != expr`. Most other usual operations are available, allowing usual things like `1+1 < 11`.
* Application `f(x,y)` of arguments to a function. Application of labeled parameters is as follows: `f(x,foo=1,y,bar="baz")`. The interest of labels is that the order of two parameters doesn't matter as long as they have different labels.
* Anonymous functions: `fun (arglist) -> expr`. Some arguments might have a label or an optional value. For example, the definition of a function with two named parameters, the second one being optional with default value `13` is as follows: `fun (~foo,~bar=13) -> ...`.
* Definitions using def-end: `def pi = 3.14 end` defining a ground value, `def source(x) = wrap2(wrap1(x)) end` defining a function. The `=` is optional, you may prefer multi-line definitions without it. The arguments of a defined function are specified in the same way as for anonymous functions.
* Shorter definitions using the equality: `pi = 3.14`. This is never an assignment, only a new local definition!
* Conditionals `if expr then expr else expr end`, or more generally ```
if expr then expr (elsif expr then expr)* (else expr)? end```
. The `else` block can be omitted if the purpose of the conditional is not to compute a value (*e.g.* an integer or a list of strings) but only to have a side effect (*e.g.* printing something in one case, not doing anything in the other).
* Sequencing: expressions may be sequenced, just juxtapose them. Usually one puts one expression per line. Optionally, they can be separated by a semicolon. The evaluation of a sequence triggers that of all of its sub-expressions, its value is that of the last sub-expression. Accordingly, the type of a sequence is that of its last sub-expression.
* Variable references are defined as: `reference = ref "some string"`. New values can be set via: `reference := "new value"`. The contents of a reference can be retrieved by `!reference`.
* Parenthesis can be used to delimit explicitly expressions. In some places where only expressions can be written, as opposed to sequences of expressions, the `begin .. end` block can be used to explicitly form a simple expression from a sequence. This notably happens with the simple form of definitions without `def .. end`, and in the body of anonymous functions. For example `fun (x) -> f1(x) ; f2(x)` will be read as `(fun (x) -> f1(x)) ; f2(x)` not as `fun (x) -> begin f1(x) ; f2(x) end`.
* Code blocks: `{ expr }` is a shortcut for `fun () -> expr`.

**No assignment, only definitions.** `x = expr` doesn't modify `x`, it just defines a new `x`. The expression ```
(x = s1 ; def y = x = s2 ; (x,s3) end ; (y,x))```
 evaluates to `((s2,s3),s1)`.

**Function.** The return value of a function is the evaluation of its body where parameters have been substituted by their values. Accordingly, the type of the body is the return type of the function. If the body is a sequence, the return value will thus be its last expression, and the return type its type.

```liquidsoap
def foo ()
  a = bar()
  b = 1
  "string"
end
# The return type of foo is string.
# The full type of foo is ()->string.
```

Recursive functions can be defined using the `rec` keyword:

```liquidsoap
def rec fact(n) =
  if n == 1 then
    1
  else
    n * fact(n-1)
  end
end
```

**Type of an application.** The type of an application is the return type of function if all mandatory arguments are applied. With the function `foo` previously defined, `foo()` is a string. Otherwise, the application is ``partial'', and the expression still has a function type.

**Partial application.** Application of arguments can be partial. For example if `f` takes two integer arguments, `f(3)` is the function waiting for the second argument. This can be useful to instantiate once for all dummy parameters of a function:

```liquidsoap
out = output.icecast(%vorbis, host="streamer",port="8080",
                            password="sesame")
# out is a function waiting for the other parameters
out(bitrate=112, my_radio)
```

**Labels.** Labeled and unlabeled parameters can be given at any place in an application. The order of the arguments is up to permutation of arguments of distinct labels. For example `f(x,foo=1)` is the same as `f(foo=1,x)`, both are valid for any function `f(x,~foo,...)`. It makes things easier for the user, and gives its full power to the partial application.

**Optional arguments.** Functions can be defined with an optional value for some parameter (as in `def f(x="bla",~foo=1) = ... end`), in which case it is not required to apply any argument on the label `foo`. The evaluation of the function is triggered after the first application which instantiated all mandatory parameters.

Types
-----
We believe in static typing especially for a script which is intended to run during weeks: we don't want to notice a mistake only when the special code for your rare live events is triggered! Moreover, we find it important to show that even for a simple script language like that, it is worth implementing type inference. It's not that hard, and makes life easier.

The basic types are `int`, `float`, `bool`
and `string`.
Corresponding to pairs and lists,
you get `(T*T)` and `[T]` types --
all elements of a list should have the same type.
For example, `[(1,"un"),(2,"deux")]`
has type `[(int*string)]`.

There are several types that are specific to liquidsoap, such as
`source`, `request`, `format`.
Those three types are parametrized by the kind of stream that they
carry. This is described in more details in a
[dedicated page](stream_content.html).

A function type is noted as `(arg_types) -> return_type`. Labeled arguments are denoted as `~label:T` or `?label:T` for optional arguments. For example the following function has type ```
(source,source,?jingle:string) -> source```
.

```liquidsoap
fun (from,to,~jingle=default) ->
  add ([ sequence([single(jingle), fallback([])]),
         fade.in(to) ])
```

Time intervals
--------------
The scripting language also has a syntax extension for simply specifying time intervals.

A date can be specified as `_w_h_m_s` where `_` are integers. It has the following meaning:

* `w` stands for weekday, ranging from 0 to 7, where 1 is monday, and sunday is both 0 and 7.
* `h` stands for hours, ranging from 0 to 23.
* `m` stands for minutes, from 0 to 59.
* `s` stands for seconds, from 0 to 59.

All components `w`, `h`, `m` and `s` are optional. Finally, the `m` can be omitted in dates of the form `_h_` such as `12h30`.

It is possible to use 24 (resp. 60) as the upper bound for hours (resp. seconds or minutes) in an interval, for example in `12h-24h`.

Time intervals can be either of the form `DATE-DATE` or simply `DATE`. Their meaning should be intuitive: `10h-10h30` is valid everyday between 10:00 and 10:30; `0m` is valid during the first minute of every hour.

This is typically used for specifying switch predicates:

```liquidsoap
switch([
  ({ 20h-22h30 }, prime_time),
  ({ 1w }, monday_source),
  ({ (6w or 7w) and 0h-12h }, week_ends_mornings),
  ({ true }, default_source)
])
```

Includes
--------
You can include other files,
to compose complex configurations from
multiple blocks of utility or configuration directives.

```liquidsoap
# Store passwords in another configuration file,
# so that the main config can be safely version-controlled.
%include "passwords.liq"

# Use the definitions from the other file here.
```

In the command `%include "file"` the path is relative to
the script file. In `%include <file>`, it is relative
to the library directory of Liquidsoap.
