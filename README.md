# jmoldow-python3-async-tutorial
Tutorial for everything async in Python3: generators, coroutines, async/await syntax, and asyncio.

Author: [Jordan Moldow][]  
License: [Apache License, Version 2.0][Apache License]  
URL: <https://github.com/jmoldow/jmoldow-python3-async-tutorial>

---------------------------------------

## Introduction

Python 3.4 introduced, via the proposal in [PEP 3156][], the
[``asyncio``][asyncio docs] standard library module, a Python standard for
asynchronous programming and event loops.

Python 3.5 expanded this, via the proposal in [PEP 492][], which extended the
[syntax of the Python language][Python language data model reference] with the
``async`` and ``await`` keywords, and also introduced the notion of native
coroutines and awaitables.

I had a difficult time understanding these features. On multiple occasions, I
read the PEPs and the language reference. I also listened to a few conference
talks on the subject. While these references gave good information on the
"what" of the material ("``asyncio`` provides an event loop that can run
multiple IO-bound tasks on a single thread", "``async def`` lets you define an
asynchronous coroutine", "``await`` waits on the value of a coroutine/future
and returns the final result", etc.), they did not help me develop a mental
model of what these things actually meant, how they worked at runtime, or how
one would write or run asynchronous code.

One weekend I immersed myself fully in the [CPython source code][] until, after
two days, I finally emerged with a decent understanding of what was going on
with those features.

This tutorial is meant to cement my own understanding of async programming in
Python, as well as to augment the existing body of documentation on these
subjects, since I personally found them to be lacking for beginners.

[PEP 3156]: <https://www.python.org/dev/peps/pep-3156/> 'PEP 3156 -- Asynchronous IO Support Rebooted: the "asyncio" Module'
[PEP 492]: <https://www.python.org/dev/peps/pep-0492/> 'PEP 492 -- Coroutines with async and await syntax'
[CPython source code]: <https://github.com/python/cpython> 'The source code of the C core reference implementation of Python'
[asyncio docs]: <https://docs.python.org/3.4/library/asyncio.html> 'asyncio - Asynchronous I/O, event loop, coroutines and tasks'
[Python language data model reference]: <https://docs.python.org/3.5/reference/datamodel.html> 'Python language data model reference'

## Locally running the Jupyter notebooks

### Bootstrapping requirements

- ``python3.6``
- ``virtualenv``
- ``make`` (setup can be performed manually if ``make`` isn't available)

### Notebook requirements

See ``requirements.txt``.

### Commands

#### Start the server

    make run_jupyter_notebook

This will create a new ``python3.6`` virtualenv in this directory, install the
latest versions of all the project's PyPI dependencies listed in
``requirements.txt``, and start the Jupyter notebook server. When the server
starts, the home page will be opened in the default web browser.

#### Manually start the server

    make && source .pyvenv/bin/activate && python -m jupyter notebook

This does the same thing as ``make run_jupyter_notebook``, but allows you to
pass custom options to `jupyter`.

#### Clean the repository

    make clean

This will delete everything that hasn't already been committed.

---------------------------------------

## Copyright Attributions

This projects includes code samples from <https://github.com/python/cpython/tree/v3.6.1>.  
Copyright (c) 2001-2017 Python Software Foundation.  
All Rights Reserved.  
License: Python license, <https://www.python.org/3.6/license.html>

## License

License: [Apache License, Version 2.0][Apache License]  
[Jordan Moldow][], 2017

>     Copyright 2017 Jordan Moldow
>
>     Licensed under the Apache License, Version 2.0 (the "License");
>     you may not use this file except in compliance with the License.
>     You may obtain a copy of the License at
>
>         http://www.apache.org/licenses/LICENSE-2.0
>
>     Unless required by applicable law or agreed to in writing, software
>     distributed under the License is distributed on an "AS IS" BASIS,
>     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
>     See the License for the specific language governing permissions and
>     limitations under the License.

[Jordan Moldow]: <https://github.com/jmoldow> "Jordan Moldow"
[Apache License]: <http://www.apache.org/licenses/LICENSE-2.0> "Apache License, Version 2.0"
