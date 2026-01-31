# BDB
*An embarrasingly minimal and forgetful debugger for bash scripts.*

Executes line-by-line of script file, literally. This means you cannot just step
over the head of a loop like in a traditional debugger. For such cases where the
atomicity extends over several lines, you must save them into a buffer and then
execute the buffer.

I don't have a clear conscience about doing something that shouldn't be done with
bash, so I will leave it at this point even with all its design and implementation
flaws.
