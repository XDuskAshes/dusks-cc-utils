-- Name: touch
-- Author: XDuskAshes - <https://github.com/XDuskAshes>
-- Description: Create files at a given location.
-- Part of: Dusk's ComputerCraft Utilities - <https://github.com/XDuskAshes/dusks-cc-utils/>
-- License: MIT License - <https://opensource.org/license/MIT>

local args = {...}

if args[1] == "help" or #args < 1 then
    
    if #args < 1 then
        printError("Cannot accept no args, showing help.")
    end
    
    print("touch - create files at the given paths.")
    print("help - Display this help.")
    print("Usage:\n touch <file> <file> <file> <etc>...")
else
-- There's definitely a better way to do this.
    for k,v in pairs(args) do
        if fs.exists(v) then
            printError("Already exists, skipping: "..v)
        else
            local handle = fs.open(v,'w')
            handle.writeLine('')
            handle.close()
        end
    end
end