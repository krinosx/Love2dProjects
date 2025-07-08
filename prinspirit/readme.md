# PrinSpirit

>The princess is dead! But the knight, Julien, doesn't know it and is going to try to save her from a mighty dungeon. You, once a living and happy not so defenseless princess, is now a spirit. You're going to make anything to keep the knight far away from the dungeon where your body is, even if that means hurting him ... badly.

PrinSpirit is a game made for Global Game Jam 2014 by Blue Monkey (Vitor Navarro and Arthur Ferrai) and Giuliano Bortolassi.

## General guidelines

This game was made in Löve2D purely, you can download it [here](https://www.love2d.org). Löve uses [Lua](http://www.lua.org) a nice script language widely used in the game industry, you should take a look.

[This tutorial](http://tylerneylon.com/a/learn-lua/) and [this one](http://lua.gts-stolberg.de/en/?uml=1) should help you get started.

## Building

The following guides were taken directly from [Löve2D wiki](https://www.love2d.org/wiki/Game_Distribution) and explain how to build this game for MacOS/Windows and Linux YAY

### Create a .love-file

Please note that some operating systems use case-sensitive paths. To avoid unnecessary hassle make sure that the path specifications you use in code matches that of your folders and files.

To create a .love-file you have to create a zip file of the whole game directory. Make sure that your main.lua is in the root of the archive, e.g. if you have

   * somedir\SuperGame\gfx\character.png
   * somedir\SuperGame\main.lua
   * somedir\SuperGame\conf.lua

You must ensure the zip file containts

   * gfx\character.png
   * main.lua
   * conf.lua

and not the directory SuperGame\.

Once you have your zip file you simply rename the ending from .zip to .love and you are done!

### Platform Specific Notes

#### Windows

Windows supports creation of zip files out of the box. For detailed instructions click [here](http://windows.microsoft.com/en-hk/windows-vista/compress-and-uncompress-files-zip-files)

Alternatively you can use the Distribution Utility that is available [here](https://www.love2d.org/forums/viewtopic.php?f=5&t=30259)

#### Linux / OS X

Assuming your current directory is SuperGame/ you can create the .love file from command line directly using

```
zip -9 -q -r SuperGame.love .
```

### Creating a Windows Executable

Once you have packed your game into a .love file you can create a game executable that directly runs your game.

For this you have to append your .love file to the love.exe file that comes with the official LÖVE .zip file. The resulting file is your game executable.

Once you have your game executable you can pack it together with all the other DLL files of the official LÖVE .zip file into a new .zip file and share this with the world.

Note: it is highly recommended to use the 32-bit build of the Löve engine instead of the 64-bit version.

### Platform Specific Notes

#### Windows

To create your game executable under windows use the command line to run

```
copy /b love.exe+SuperGame.love SuperGame.exe
```

Alternatively you can create a .bat (e.g. create_game_exe.bat) file with the contents

```
copy /b love.exe+%1 "%~n1.exe"
```

and then you can simply drag your SuperGame.love file onto the .bat file and it will create the file SuperGame.love.exe which you could then use for distribution.

This method creates a fused game.

#### Linux / OS X

You can create the windows executable from Linux and OS x using the command line.

First download the official zipped 32 or 64 bit executable (not the installer) from <https://www.love2d.org/>.

Then in the command line/terminal run

```
cat love.exe SuperGame.love > SuperGame.exe
```

to obtain the game executable SuperGame.exe.


When distributing the windows executable you will need to include the dll files that came in the folder of the love.exe you used (so don't mix the 32 bit dll's with the 64 bit dll's). Without these files you will get error message when attempting to run SuperGame.exe on a windows machine.

The contents of your final distribution folder should look something like this:

* SDL.dll
* OpenAL32.dll (note: this file is different in the 64 bit download despite still being called 'OpenAL32.dll')
* SuperGame.exe
* license.txt (note: the license requires that it be included in any further distribution)
* DevIL.dll


#### Creating a MacOS X App

Once you have your game prepared as .love file you can make your game available for MacOS/X users using the official LÖVE Zipped Universal Build from <https://www.love2d.org>. This will then run directly your game instead of the LÖVE demo.

These are the steps required:

1. Unpack the Zipped Universal Build from <https://www.love2d.org>
2. Rename love.app to SuperGame.app
3. Copy your SuperGame.love to SuperGame.app/Contents/Resources/
4. Modify SuperGame.app/Contents/Info.plist
5. Zip the SuperGame.app folder (e.g. to SuperGame.osx.zip) and distribute it.

When modifying the file SuperGame.app/Contents/Info.plist make sure to change the values of the following XML-tags:

* CFBundleIdentifier
* CFBundleName

and remove the section UTExportedTypeDeclarations which ensures that Mac OS does not associate all .love files with your app. Overall the changes should be something like this:

**Original Info.plist**

```
...
<key>CFBundleIdentifier</key>
<string>org.love2d.love</string>
...
<key>CFBundleName</key>
<string>LÖVE</string>
...
<key>NSPrincipalClass</key>
<string>NSApplication</string>
<key>UTExportedTypeDeclarations</key>
<array>
...
</array>
</dict>
</plist>
```

**Modified Info.plist**

```
...
<key>CFBundleIdentifier</key>
<string>com.SuperCompany.SuperGame</string>
...
<key>CFBundleName</key>
<string>SuperGame</string>
...
<key>NSPrincipalClass</key>
<string>NSApplication</string>
</dict>
</plist>
```

#### Distribution for Linux

For Linux there is not yet a simple way to distribute your game. The general approach here is to point to the official LÖVE packages at <https://www.love2d.org>. Once the package is installed, the .love packages are usually automatically executed using the installed LÖVE package or using the command line:

```
love SuperGame.love
```

A common mistake is to use the following method to make binaries for Linux;

```
cat /usr/bin/love SuperGame.love > SuperGame
chmod a+x ./SuperGame
```

Please keep in mind, while the binary `SuperGame` will run on your machine, and other Linux distros that have the same architecture and similar version libraries, there's a good chance that it will not run on many other Linux distros.

#### Distribution on the web

There is an experimental project to run .love games in a WebGL capable browser (up to date Firefox, Opera, Safari, Chrome...) without needing extra plugins, see forum [thread](https://love2d.org/forums/viewtopic.php?f=5&t=8487)

#### Mobile distribution

There is an experimental project to run .love games natively on Android phones, see [subforum](https://love2d.org/forums/viewforum.php?f=11)