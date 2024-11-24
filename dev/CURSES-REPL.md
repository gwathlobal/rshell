# Interop between curses and Lisp REPL

It is impossible to launch a curses window directly from REPL, and on top of that curses requires that all curses calls are done in the main thread.

So, to enable REPL development with curses, you need to do the following:

* Run _sbcl-cr-micros.sh_ or _sbcl-cr-swank.sh_ in a terminal (depending on whether you use Lem or Emacs as IDE). This will load SBCL with a minimal curses window running. Leave it as it is.

* Run Lem, press M-x, type **slime-connect**. This will connect to SLIME to the SBCL from the previous step.

* Inside Lem's REPL, type **(ql:quickload :rshell)**, and then **(rshell:run-from-repl)**. This will load the game into SBCL, and start the game in the curses window.

* Switch to the curses terminal window and you will see the game screen there. You can play the game inside that window and at the same time see that the REPL inside Lem is not blocked, so you are able to inspect the game's inner workings while playing.
