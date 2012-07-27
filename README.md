Madride
=======

Zero-configuration command-line HTTP server with cow super-powers...

It's main purpose is to provide environment for quick prototyping of
pages with *slim* (or any other template engine - feel free to open
feature request issue) without need to run full stack of big boys like
*sinatra* or *rails*. All you need is to simply execute `madride` with
paths to your assets and pages.

The most simple example is:

    madride .

This will start a server on `0.0.0.0:3000` serving files from `.`
directory. You can provide a dummy data (that will be available in your
templates) with `--data path/to/data.yml` argument. See `example` dir.


Installation
------------

    gem install madride


Usage
-----

See `example` for details.


License & Copyrights
--------------------

* Copyright (c) 2012 [Aleksey "ixti" Zapparov](https://github.com/ixti)
* Released under the MIT license. See LICENSE for details.
