# hexamplestreaming

An example showing how the package 'streaming' can help to output as soon as information is available.

## How to understand the problem

See also:
https://stackoverflow.com/questions/77770159

Build and start the program and you will see: As soon as the first line of a typed number is entered it will show a partial result.

E.g.

when hexamplestreaming is started

    [

appears

then, when entered:

    7 [Return]

    ["7/=12"

appears and the program waits for the next line

then, when entered:

    34 [Return]
    57 [Return]

the complete output is

    ["7/=12", "34==34", "57/=56"]

## Source file here

https://github.com/JoergBrueggmann/hexamplestreaming/blob/main/src/Lib.hs
