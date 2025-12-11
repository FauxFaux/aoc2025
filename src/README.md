### AoC 2025

An attempt to do [Advent of Code 2025](https://adventofcode.com/2025)
in Postgres flavoured SQL, using `duckdb` features where appropriate (desperate?).

This was not a good idea.

## Good enough

These solutions are written in code (i.e. with no external codegen),
and I'd expect to solve any problem given by the website.

They may have assumptions hardcoded in (n < 10; len=7, etc.),
but these assumptions would presumably handle any website problem.
There are some edgecases in duckdb where values have to be compile-time
constants, which I wasn't aware of!

The "rule of thumb" for execution time was "under a minute", for which I'm
using duckdb's automatic threading, and an i9-13900kf (8 fast cores, 32 threads).

Notes:

* <kbd>1a</kbd>, <kbd>1b</kbd>,  <kbd>2a</kbd>,  <kbd>3a</kbd>,  <kbd>4a</kbd>,
  <kbd>5a</kbd>, <kbd>6a</kbd>,  <kbd>6b</kbd>,  <kbd>8a</kbd>,
  <kbd>9a</kbd>, <kbd>10a</kbd>, <kbd>11a</kbd>: directly prints the answer in under 200ms
* <kbd>2b</kbd>: prints the answer, in ~5s. Honourable mention for
  [assertion failure in duckdb](https://github.com/duckdb/duckdb/issues/20016) during development.
* <kbd>3b</kbd>: "code generation" for the number of digits, hardcoded in the problem description
* <kbd>9b</kbd>: directly prints the answer, but takes ~40s. Didn't attempt any optimisations as it just worked.
* <kbd>11b</kbd>: ~6 lines of duplicated code which shouldn't affect the answer but does something to the
  optimiser, bringing the execution time down from [OOM after 5 minutes] to ~3s.


## No cheating

Here lies puzzles which have general SQL solutions, but where the input file is large,
as if the looping is managed externally. I think this is acceptable? I'd love to rewrite
these as recursive, but I spent a long time on this for <kbd>4b</kbd>, and afaict duckdb
is returning complete nonsense for my query, so I gave up. Bug report pending.

e.g. there's no nice way to write "run this delete until it doesn't delete anything",
but you can just write the delete out many times, and it will work on any input:

```sql
delete from t where exists (select 1 from t where ...);
delete from t where exists (select 1 from t where ...);
delete from t where exists (select 1 from t where ...);
delete from t where exists (select 1 from t where ...);
delete from t where exists (select 1 from t where ...);
```

* <kbd>4b</kbd>: 100kB of SQL, ~19s of execution time, but does solve the puzzle
* <kbd>5b</kbd>: 45kB of SQL, ~400ms of execution time, generic solution
* <kbd>7a</kbd>, <kbd>7b</kbd>: externally looped for the height of the input (142 lines; 4kB), ~200ms execution time;
    I'd guess it solves any website puzzle without modification


## Manual finishing

Here, the solution provides a tool a human can use to find a solution, but the puzzle doesn't do the search.
Funny how this'd be a ridiculous category in a real programming language, eh, where you could just write a loop,
or a function, or similar. *sobbing*

* <kbd>8b</kbd>: human has to binary search for the 'n' value, code takes ~1s and you only need to try <20 values,
    nice solution apart from the human bit, at least.


## Unsolved

* <kbd>10b</kbd>: I wrote ~4 different implementations,
  and none of them can solve all of the input lines without
  *O(heat-death)* creeping in.
