# DuskFileManager

( **NOTE**: This is for the **current version** of DuskFileManager, which is ``1.1`` as of 5/21/2024. )

----

## What?
DuskFileManager is a simple, lightweight ( just under 180 lines of code ) file explorer for ComputerCraft:Tweaked. It's key features are below.

* Simple, easy-to-understand design.
* Quick and easy sifting through folders and files.
* Data-driven configuration ( JSON ).
* Simple in-program commands.

---
## Why?
I originally did this as a goofy side project, but I thought, 'why not improve upon it?'

---
## How?

There are two <u>sub-sections</u>, **Basic Use** and **Configuration**.

### Basic Use
First, find wherever you have ``duskfileman.lua`` saved. This is assuming you pulled from the repo directly with ``wget`` and have not moved or renamed it. Open the program, and you will be greeted with a UI like this.

```
/current/directory/
-------------------
list/ of files and directories/ in the current/ directory/




} An input line to navigate with_
Line where special messages go
```

At the top is your **current directory**, and the size of the line will change to reflect the length of the path. Below that is the **directory listing**, which can be either ordered as ``fs.list()`` returns or by directories then files. See more later down on configuration. At the bottom is the **input line**, followed by the **messages line**. The **input line** serves as the primary means of command, file, and directory input and navigation.

Simply type where and what you want to go to/edit with normal usage.

There are a few <u>special commands</u> that you can type: ``info``, ``help``, and ``exit``.

### ``info``
Presents info about the program.

### ``help``
Presents a help screen.

### ``exit``
Exits the program.

### Configuration

In order to *use* DuskFileManager, you will have to create the ``dfm.json`` file in your CC computer's <u>root directory</u> ( ``/`` ). It should look somewhat like this:

```json
{
    "clrOnExit":true,
    "editProgram":"/rom/programs/edit.lua",
    "editOnFileEntered":true,
    "seperateDirs":true
}
```

What do all these words mean?

### ``clrOnExit``
Short for "Clear On Exit", ``clrOnExit`` is a ``true`` or ``false`` value that determines if, when called to ``exit``, DuskFileManager will also clear the screen.


### ``editProgram``
Tells DuskFileManager the path to the text editor of choice. goes hand-in-hand with ``editOnFileEntered``.

### ``editOnFileEntered``
Quite a mouthful, but therefore self-explanatory. A ``true`` or ``false`` value that tells DuskFileManager if it should open the ``editProgram`` or if it should run it.

### ``seperateDirs``
Short for "Seperate Directories in Listing", ``seperateDirs`` is a ``true`` or ``false`` value that tells DuskFileManager one of two things.

* If ``true``, order all directory listings following a hierarchy of ``directories`` --> ``files`` for a marginally cleaner look.
* If ``false``, order all directory listings as ``fs.list()`` returns it.

---