# ulpad

`ulpad` is a small terminal text editor written in Zig.

Core pieces:
- terminal UI and input loop in `src/app.zig`
- text storage in `src/piece_table.zig`
- line tracking in `src/line_index.zig`
- document API in `src/document.zig`
- search and replace in `src/search.zig`
- render path in `src/render.zig`
- file I/O in `src/editor_io.zig`
- terminal control in `src/tty.zig`

## Build

```bash
zig build
zig build run
zig build test
```

## Project Rule: Debug With KISS

KISS means `Keep It Simple, Stupid`.

The original engineering idea is simple: a system should stay repairable under pressure, with limited tools, by normal humans. In software that means debugging must prefer the smallest explanation, the smallest reproducer, and the smallest safe fix.

For `ulpad`, KISS debugging means:
- start from one concrete symptom, not ten guesses
- reduce the problem to the smallest input or keystroke sequence that still fails
- inspect one layer at a time: input -> document -> search -> render -> I/O
- add the smallest assertion or invariant that proves what is wrong
- prefer one direct fix over clever abstractions
- re-run proof after every change

## Assume Tests Can Be Wrong

Treat every test as potentially broken, stale, hacked, flaky, or asserting the wrong thing.

Do not trust a passing test by itself.

Use this order:
1. reproduce the bug outside the test when possible
2. shrink the reproducer
3. check the internal state directly
4. write or update a regression test
5. prove the test fails before the fix when practical
6. apply the smallest fix
7. prove the bug is gone with at least two independent checks

Independent checks can be:
- a focused unit test
- an integration test
- direct state assertions
- file round-trip verification
- render output inspection
- manual CLI reproduction steps

If only one check says "fixed", assume it is not fixed yet.

## KISS Debugging Workflow

### 1. Reproduce

Always start with an exact failing case.

Examples:
- a byte range that breaks `PieceTable.delete`
- an offset that breaks `lineOfOffset`
- a search needle/from/direction triple that returns the wrong match
- a viewport/cursor pair that renders the wrong cursor position
- a CRLF file that round-trips incorrectly

Bad:
- "search feels broken"
- "render is weird"

Good:
- "`find("abc", from=0, backward)` returns a match at `0..3`"
- "cursor line `0` with `viewport.top_line=2` used to underflow in render"

### 2. Reduce

Once the bug exists, make the case smaller.

Examples:
- large file -> 3 lines
- long edit history -> 2 inserts and 1 delete
- full-screen render -> 5 rows x 10 cols
- real file -> temp file with 6 bytes

If you cannot explain the bug with a tiny input, you probably do not understand it yet.

### 3. Isolate the Layer

Debug only one layer at a time.

Suggested order for `ulpad`:
1. `src/input.zig` parses bytes into keys
2. `src/document.zig` mutates text state
3. `src/search.zig` computes matches
4. `src/render.zig` turns state into escape-sequence output
5. `src/editor_io.zig` persists bytes to disk
6. `src/app.zig` coordinates user flow

Do not start in `src/app.zig` if the bug is already visible in `src/document.zig`.

## Debug Anatomy

Use these invariants every time:

### PieceTable invariants
- `byteLen()` must equal rendered text length
- `toOwnedSlice()` must equal the expected logical document text
- insert/delete/copyRange must preserve ordering outside the edited range

### LineIndex invariants
- `lineCount()` must equal `1 + number_of_newlines`
- `lineStart(0)` must always be `0`
- `lineOfOffset(offset)` must map every offset to the correct line
- `lineContentEnd()` must exclude newline except on the last line

### Document invariants
- `byteLen()` must equal `textAlloc().len`
- line metadata must stay in sync after every mutation
- delete and replace operations must preserve text outside edited regions

### Search invariants
- empty needle must not mutate state
- forward search must never return a match before `from`
- backward search must never return a match after the allowed search window
- `replaceAll` must terminate even when replacement contains the needle or equals the needle

### Render invariants
- render must never underflow on cursor or viewport math
- output must remain valid even for tiny screens
- selection highlight boundaries must match logical selection boundaries
- status/prompt truncation must not corrupt the frame

### I/O invariants
- LF files round-trip as LF
- CRLF files round-trip as CRLF
- binary files are rejected
- invalid UTF-8 is rejected
- missing files open as empty documents

## Test Strategy

The test tree lives under `src/tests/`.

Rules:
- one file per concern
- one helper module for shared assertions and invariants
- many small tests, not giant smart tests
- generated matrices are allowed, but only when each generated test still has one clear purpose
- production code and test code stay separate

Current anchors:
- `src/tests/helpers.zig` -> shared assertions and invariants
- `src/tests/editor_io_test.zig` -> real temp-file round trips
- `src/tests/system_core_test.zig` -> low-level constants and terminal expectations
- `src/tests/generated/` -> broad input/state matrices

## What To Do When A Test Passes But You Still Do Not Trust It

Assume one of these is true:
- the test asserts the wrong thing
- the fixture hides the bug
- the test is too high level
- the test is too low level
- the bug is in another layer
- the state is only correct in the synthetic case

Then do this:
1. add a second test at a different layer
2. inspect raw state directly
3. compare before/after text or frame output
4. use a temp-file round trip if I/O is involved
5. keep shrinking until the failure becomes obvious

## What Not To Do

Avoid these anti-patterns:
- shotgun debugging
- fixing several files before proving the root cause
- trusting coverage numbers as proof of quality
- adding abstractions to hide a bug instead of understanding it
- writing one huge test that checks many unrelated things
- claiming a fix before rerunning verification

## Practical Rule

For this project, the default debugging posture is:

`The failing test may be wrong. The passing test may be lying. The state must still prove the truth.`

That is the KISS version of debugging here.
