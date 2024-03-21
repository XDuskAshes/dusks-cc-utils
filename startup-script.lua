-- To use:
-- Rename to 'startup.lua' and restart.

local oldPath = shell.path()

shell.setPath(oldPath..":/utils")

-- OPTIONAL: Shorthands (un-block-comment to enable)

--[[
shell.setAlias("dfm","duskfileman")
]]
