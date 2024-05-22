-- Name: duskfileman
-- Author: XDuskAshes - <https://github.com/XDuskAshes>
-- Description: Simple file manager/browser.
-- Part of: General ComputerCraft Utilities - <https://github.com/XDuskAshes/general-cc-utils/>
-- License: MIT License - <https://opensource.org/license/MIT>

local args = {...}

local raw = fs.open("/dfm.json","r")

if not raw then
    error("Cannot find JSON config file. (/dfm.json)",0)
end

local behavior = textutils.unserialiseJSON(raw.readAll())

local txm,tym = term.getSize()
local dfmVer = 1.1

local function e(s)
    return s == nil or s == "" or #s < 1
end

local function topLine(string)
    write(string.."\n")

    -- Should create a line that's only as long as the given string.
    for i = 1, #string do
        write("-")
    end

    write("\n")
end

local function displayCustomMessage(text) -- Display a custom message at 1,19 in orange.
    txm, tym = term.getSize()

    term.setCursorPos(1,tym)

    if #text > txm then
        term.setTextColor(colors.red)
        write("Could not display message, too big.")
        sleep(1)
    else
        term.setTextColor(colors.orange)
        write(text)
    end

    term.setTextColor(colors.white)
    sleep(0.5)
    term.clearLine()
end

local function pause()
    print("\nPress any button to continue browsing...")
    while true do
        local event = {os.pullEvent()}
        local eventD = event[1]

        if eventD == "key" then
            break
        end
    end
end

if args[1] == "--help" or args[1] == "-h" then
    print("duskfileman - Simple file explorer/manager\n")
    print("usage:\n duskfileman <dir>\nDefault directory is the current one.\n\nFor how to use, run 'duskfileman --howto'")
elseif args[1] == "--howto" then
    print("duskfileman - How to use")
    print("Navigation:\n } <dir>\nExiting:\n } exit")
else

    if not e(args[1]) then
        shell.setDir(args[1])
    else
        shell.setDir(shell.dir())
    end

    while true do

        term.clear()
        term.setCursorPos(1,1)

        local toFuzz = fs.list(shell.dir())
        local dirs = {}
        local files = {}

        if e(shell.dir()) then
            topLine("/")
        else
            topLine("/"..shell.dir().."/")
        end

        if behavior.seperateDirs == true then
            for k,v in pairs(toFuzz) do
                if fs.isDir(shell.dir().."/"..v) then
                    table.insert(dirs,v)
                else
                    table.insert(files,v)
                end
            end

            for k,v in pairs(dirs) do
                term.setTextColor(colors.green)
                write(v.."/ ")
                term.setTextColor(colors.white)
            end

            print("")

            for k,v in pairs(files) do
                write(v.." ")
            end
        else
            for k,v in pairs(toFuzz) do
                if fs.isDir(shell.dir().."/"..v) then
                    term.setTextColor(colors.green)
                    write(v.."/ ")
                    term.setTextColor(colors.white)
                else
                    write(v.." ")
                end
            end
        end

        txm, tym = term.getSize()
        term.setCursorPos(1,tym-1)
        write("} ")
        -- TODO: Autocomplete. -Dusk, 3/15/2024
        local input = read()

        if fs.exists(shell.dir().."/"..input) and fs.isDir(shell.dir().."/"..input) then
            shell.setDir(shell.dir().."/"..input)
        elseif input == "exit" then
            if behavior.clrOnExit == true then
                term.clear()
                term.setCursorPos(1,1)
            end
            error()
        elseif input == "info" then
            term.clear()
            term.setCursorPos(1,1)
            print("DuskFileManager v"..dfmVer)
            print("Author: Dusk")

            -- I theorize this will break something someday. -Dusk, 3/15/2024
            -- Nothing yet. -Dusk, 5/21/2024
            pause()
        elseif input == "help" then
            term.clear()
            term.setCursorPos(1,1)
            print("DuskFileManager v"..dfmVer.." help")
            print("\nDirectories are in GREEN, files are in WHITE.")
            print("To navigate to a directory, type it's name and/or path.")
            print("To perform file actions, type the file's full path and name, including file handles.")
            print("\nTo exit, type 'exit'.")
            print("For program info, type 'info'.")
            print("To view this help, type 'help'.")
            pause()
        else
            if behavior.editOnFileEntered == true then
                if fs.exists(shell.dir().."/"..input) then
                    print(shell.dir().."/"..input)
                    shell.run(behavior.editProgram.." /"..shell.dir().."/"..input)
                    displayCustomMessage("File viewed or modified.")
                else
                    displayCustomMessage("No such file or command.")
                end
            else
                shell.run("/"..shell.dir().."/"..input)
                displayCustomMessage("Ran file that was selected.")
            end
        end
    end
end