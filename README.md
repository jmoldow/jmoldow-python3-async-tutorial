# jmoldow-python3-async-tutorial
Tutorial for everything async in Python3: generators, coroutines, async/await syntax, and asyncio.

Author: [Jordan Moldow][]  
License: [Apache License, Version 2.0][Apache License]  
Git Repo URL: <https://github.com/jmoldow/jmoldow-python3-async-tutorial>  
Website: <https://jmoldow.github.io/jmoldow-python3-async-tutorial>

---------------------------------------

## Table of Contents
- [Introduction](#introduction)
- [Chapter 1 - Iterators and iterables review](https://github.com/jmoldow/jmoldow-python3-async-tutorial/blob/master/01-iterators-and-iterables-review.ipynb)
- [Chapter 2 - Generators revisited](https://github.com/jmoldow/jmoldow-python3-async-tutorial/blob/master/02-generators-revisited.ipynb)
- [Chapter 3 - `yield from` syntax for delegating to subgenerator](https://github.com/jmoldow/jmoldow-python3-async-tutorial/blob/master/03-yield-from-syntax-for-delegating-to-subgenerator.ipynb)
- [Chapter 4 - Event loops](https://github.com/jmoldow/jmoldow-python3-async-tutorial/blob/master/04-event-loops.ipynb)
- [Chapter 5 - Event loop futures](https://github.com/jmoldow/jmoldow-python3-async-tutorial/blob/master/05-event-loop-futures.ipynb)
- [Locally running the Jupyter notebooks](#locally-running-the-jupyter-notebooks)
- [Copyright Attributions](#copyright-attributions)
- [License](#license)

## Introduction

Have you ever seen code like:

    # Code sample from <https://github.com/aio-libs/aiohttp/blob/2.0.4/README.rst>
    # Copyright (c) 2013-2017 Nikolay Kim, Andrew Svetlov, and other aiohttp contributors: <https://github.com/aio-libs/aiohttp/blob/2.0.4/CONTRIBUTORS.txt>.
    # License: Apache Software License, Version 2.0, <https://github.com/aio-libs/aiohttp/blob/2.0.4/LICENSE.txt>
    async def fetch(session, url):
        with aiohttp.Timeout(10, loop=session.loop):
            async with session.get(url) as response:
                return await response.text()

and wondered things like:
- What do these ``async`` and ``await`` keywords do?
- What does it look like when this code executes?
- How does this asynchronous execution work?

Or perhaps you've never seen this style of Python programming before.

If any of these things apply to you, I hope that this tutorial can be
educational for you.

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

After many attempts, with the help of reading the [CPython source code][], I've
finally developed a decent understanding of what is going on with those
features. Since I personally had trouble learning via the existing
documentations and conference talk videos, I'm hoping that this tutorial can
make the topic more accessible to others who might not understand it yet.

This tutorial is meant to cement my own understanding of async programming in
Python, as well as to augment the existing body of documentation on these
subjects, since I personally found them to be lacking for beginners.

We'll start from simple generators, moving to `yield from` syntax, and then to
coroutines. From there we'll show how the language was extended with
async/await syntax and native coroutines, and then finally we'll look at how
the asyncio library executes these coroutines via its event loop.

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
- ``git clone https://github.com/jmoldow/jmoldow-python3-async-tutorial.git``

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

This projects includes code samples from <https://github.com/aio-libs/aiohttp/tree/2.0.4>.  
Copyright (c) 2013-2017 Nikolay Kim, Andrew Svetlov, and other aiohttp contributors: <https://github.com/aio-libs/aiohttp/blob/2.0.4/CONTRIBUTORS.txt>.  
License: Apache Software License, Version 2.0, <https://github.com/aio-libs/aiohttp/blob/2.0.4/LICENSE.txt>

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
