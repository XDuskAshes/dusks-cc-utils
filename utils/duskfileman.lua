-- Name: duskfileman
-- Author: XDuskAshes - <https://github.com/XDuskAshes>
-- Description: Simple file manager/browser.
-- Part of: General ComputerCraft Utilities - <https://github.com/XDuskAshes/general-cc-utils/>
-- License: MIT License - <https://opensource.org/license/MIT>

local args = {...}

local behavior = {}
behavior.onFileEntered = "edit"
behavior.clrOnExit = false

-- The above has two values possible.
-- 'edit' - Opens the file in 'edit'.
-- 'run' - Runs the program then and there.
--
-- Used down in the while true loop.

local dfmVer = 1.0

local function e(s)
    return #s < 1
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
    local txm, tym = term.getSize()

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

if args[1] == "--help" or args[1] == "-h" then
    print("duskfileman - Simple file explorer/manager\n")
    print("usage:\n duskfileman <dir>\n The <dir> arg is needed, or else the program won't run.\n\nFor how to use, run 'duskfileman --howto'")
elseif args[1] == "--howto" then
    print("duskfileman - How to use")
    print("Navigation:\n } <dir>\nExiting:\n } exit")
else

    if not e(args[1]) then
        shell.setDir(args[1])
    end

    while true do

        term.clear()
        term.setCursorPos(1,1)

        local toFuzz = fs.list(shell.dir())

        if e(shell.dir()) then
            topLine("/")
        else
            topLine("/"..shell.dir().."/")
        end

        for k,v in pairs(toFuzz) do
            if fs.isDir(shell.dir().."/"..v) then
                term.setTextColor(colors.green)
                write(v.."/ ")
                term.setTextColor(colors.white)
            else
                write(v.." ")
            end
        end

        term.setCursorPos(1,18)
        write("} ")
        -- TODO: Autocomplete. -Dusk, 3/15/2024
        local input = read()

        if fs.exists(shell.dir().."/"..input) and fs.isDir(shell.dir().."/"..input) then
            shell.setDir(shell.dir().."/"..input)
        elseif input == "exit" then
            if clrOnExit then
                term.clear()
                term.setCursorPos(1,1)
            end
            error()
        elseif input == "info" then
            term.clear()
            term.setCursorPos(1,1)
            print("DuskFileManager v"..dfmVer)
            print("Author: Dusk\n\nPress any button to keep browsing...")
            
            -- I theorize this will break something someday. -Dusk, 3/15/2024
            while true do
                local event = {os.pullEvent()}
                local eventD = event[1]
        
                if eventD == "key" then
                    break
                end
            end
        else
            if behavior.onFileEntered == "edit" then
                print(shell.dir().."/"..input)
                shell.run("edit /"..shell.dir().."/"..input)
                displayCustomMessage("File viewed or modified.")
            else
                shell.run("/"..shell.dir().."/"..input)
                displayCustomMessage("Ran file that was selected.")
            end
        end
    end
    
end