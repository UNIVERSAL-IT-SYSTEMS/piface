PiFace v0.3
===========
                                  
Copyright © 2013 David Given

2013-06-21
            
            
                                 
Introduction
------------

piface is a very simple but hopefully useful boot monitor for the Raspberry
Pi. Unlike most other Raspberry Pi software, it runs directly on the
Videocore CPU rather than on the ARM coprocessor. This means you can use it
to run Videocore programs directly on the bare metal without having to use
the ARM-Videocore APIs.



Installation
------------

piface requires a modified version of The Amsterdam Compiler Kit with
support for generating (crude) Videocore machine code. You can get the ACK
here:

    http://tack.sourceforge.net

Unfortunately, at time of writing the Videocore code generator is unreleased.
This means you'll have to check out the ACK from the VCS, get the
dtrg-videocore branch, and build it and install it yourself.

Once the compiler is ready, you can build piface with:

    make

This will build piface.bin, which is the Videocore binary, and piface, which
is a standalone version built with gcc for test purposes. You can safely
ignore this if you're not developing piface itself.

To use, copy piface.bin onto an SD card, and call it bootcode.bin. Insert
this into a Raspberry Pi, apply power, and it will run.

piface communicates via the mini UART, so you'll need to have this connected
to something (at 115200 baud 8n1 no flow control).



More information
----------------

piface's real home is at http://cowlark.com/piface. Go there for the actual
documentation.



The author
----------

piface was written by me, David Given. You may contact me at dg@cowlark.com,
or visit my website at http://www.cowlark.com. There may or may not be
anything interesting there.



Licensing
---------

piface is licensed under the Simplified BSD license. See COPYING for the
full text.

piface contains a copy of the FatFs filesystem access library. This is
redistributable under the following license:

    The FatFs module is a free software and there is NO WARRANTY.
    No restriction on use. You can use, modify and redistribute it for
    personal, non-profit or commercial products UNDER YOUR RESPONSIBILITY.
    Redistributions of source code must retain the above copyright notice.

See http://elm-chan.org/fsw/ff/00index_e.html for more information.

