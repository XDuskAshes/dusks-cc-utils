-- Name: cat
-- Author: XDuskAshes - <https://github.com/XDuskAshes>
-- Description: Concatenate (display) file contents to the standard output.
-- Part of: Dusk's ComputerCraft Utilities - <https://github.com/XDuskAshes/dusks-cc-utils/>
-- License: MIT License - <https://opensource.org/license/MIT>

local args = {...}

if args[1] == "help" or #args < 1 then
    
    if #args < 1 then
        printError("Cannot accept no args, showing help.")
    end
    
    print("cat - concatenate (display) file contents to the standard output.")
    print("Usage:\n cat <file>\nFlags:")
    print(" help - Displays this help.")
    print("Note: 'cat' expects the file to be the final argument if flags are passed.")
else
    local argsAmount = #args -- Gets the amount of entries in 'args' (i.e. 1 or 2
    local fileToConcat = args[argsAmount] -- Uses the above to do so.
    -- The above works, wahoo. Smartest code I've ever written.

    table.remove(args,argsAmount) -- Removes the assumed file operand.

    if fs.exists(fileToConcat) then

        if not fs.isDir(fileToConcat) then
            local handle = fs.open(fileToConcat,'r')
            textutils.pagedPrint(handle.readAll())
            handle.close()
        else
            error("Is a dir: "..fileToConcat,0)
        end
        
    else
        error("Not exists: "..fileToConcat,0)
    end
end