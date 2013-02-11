# PebbleNotifier

A hack that forwards every notifications from your iOS device to the Pebble
watch.

## Implementation

The hack is split into two parts: PebbleNotifierListener and the main
PebbleNotifier.

PebbleNotifierListener hooks on Srpingboard and forward all notifications
through CPDistributedMessagingCenter to PebbleApp.

PebbleNotifier hooks on PebbleApp. It will listen on those messages from
PebbleNotifierListener, then it use PebbleApp's nicely organized internal
classes to deliver the notification to your watch. PebbleNotifier also disabled
the kill suspend task function of iOS in the context of PebbleApp. This makes
background tasks in PebbleApp can run indefinitely. (Actually, I'm not sure. I
still do get constant syslog messages saying that it's killing PebbleApp due to
policy violation. Maybe it does relaunch the PebbleApp again, at least my
hacked PebbleApp do sends out notifications without any interruptions.)

## Usage

Build those two packages and install it on your phone in the order of:

- PebbleNotifierListener
- PebbleNotifier

You will also need to patch the PebbleApp's Info.plist. Add `gps, voip, audio`
to UIBackgroundModes. This allows PebbleApp to run continuously in the
background (with my hack).

## How to contribute

Please fork it, mess with it and send me a pull request. There are a few things
that I need help listed in the TODO file. It's a good place to start. :)

## Demo

Check out this YouTube [video](http://www.youtube.com/watch?v=5AAHaS_UZJo).

## License

Copyright (c) 2013 Chien-An "Zero" Cho

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
