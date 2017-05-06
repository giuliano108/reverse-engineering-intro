# Binary Reverse Engineering

[https://giuliano108.github.io/reverse-engineering-intro/](https://giuliano108.github.io/reverse-engineering-intro/)

A presentation introducing the subject, example MacOS CrackMe (Swift+C) and keygens.

The slides are available [here](https://giuliano108.github.io/reverse-engineering-intro/). Alternatively, run `make serve` and go to [http://localhost:8000](http://localhost:8000) to see them. Most of the code boxes can/are meant to be scrolled around.

| file/dir             | description |
| ---                  | --- |
| `./CrackMe`          | CrackMe app Swift source code, also contains `validate.c` (the "_validate_" function) |
| `./CrackMe.app`      | compiled app binary bundle |
| `./slides`           | the presentation |
| `./0x100001f00.asm`  | _validate_, disassembled using [Hopper](https://www.hopperapp.com/) |
| `./0x100001f00.c`    | _validate_, decompiled to C still by Hopper |
| `./0x100001f00.pdf`  | _validate_, Control Flow Graph |
| `./validate.py`      | _validate_, reversed and translated to python |
| `./cli_crackme.c`    | CLI, pure C, version of the CrackMe. Uses `validate.c`. |
| `./keygen-z3.py`     | Z3 KeyGen |
| `./keygen-angr.py`   | angr KeyGen |


To run the keygens:

```sh
$ make venv
$ . ./venv/bin/activate
(venv)$ pip install -U pip
(venv)$ pip install -r requirements.txt
(venv)$ python keygen-z3.py
email: a@b.com
code : 389444254963840534810840

email: example@example.com
code : 257079862763840534810902

email: someuser@somedomain.net
code : 226010129163840534817001

(venv)$ python keygen-angr.py
WARNING | 2017-05-06 11:57:18,191 | cle.bindings.macho | The Mach-O backend is not well-supported. Good luck!
ERROR   | 2017-05-06 11:57:18,236 | simuvex.plugins.unicorn | You are attempting to use unicorn engine support even though it or the simuvex compatibility layer isn't installed
email: a@b.com
code : 389444254990075435188938

(venv)$
```

To compile the CLI version of the CrackMe:

```sh
$ make cli_crackme
```

## Acknowledgments

* Fravia, _"Thus passes the spirit of RE"_.
* [Z3](https://github.com/Z3Prover/z3/wiki)
* [angr](http://angr.io/)
* Extreme Coders - [Keygenning using the Z3 SMT Solver](https://app.box.com/v/keygenning-z3). The _validate_ function is based on this (great) didactic paper.
* André Baptista - [Demystifying Binary Reverse Engineering](https://www.slideshare.net/9d9d9d/demystifying-binary-reverse-engineering-pixels-camp). "Raptor" image, ideas.
* Paul Rouget - [DZSlides](https://github.com/paulrouget/dzslides).
* Space dog found on [giphy.com](https://giphy.com/).
