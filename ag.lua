PLUGIN_VERSION="1.0.0"
PLUGIN_NAME="ag"

local micro = import("micro")
local config = import("micro/config")
local shell = import("micro/shell")
local strings = import("strings") 
local buffer = import("micro/buffer")

function init()
  config.MakeCommand("ag", ag, config.NoComplete)
  config.MakeCommand("agOpenHere", openInCurrentBuffer, config.NoComplete)
  config.MakeCommand("agOpenInTab", openInTab, config.NoComplete)
end

function ag(bp, userargs)
  local args = strings.Join(userargs, " ")
  local output, err = shell.RunCommand("ag " .. args)

  if err ~= nil then
    micro.InfoBar():Error(err)
    return
  end

  createHorizontalSplitWithSearchResults(output)
end

function createHorizontalSplitWithSearchResults(output)
  local newBuffer = buffer.NewBuffer(output, "ag")

  newBuffer.Type.scratch = true
  newBuffer.Type.Readonly = true

  micro.CurPane():HSplitBuf(newBuffer)
end

function openInCurrentBuffer(bp)
  local filename = getFilenameFromCurrentLine(bp)
  local newBuffer = buffer.NewBufferFromFile(filename)

  micro.CurPane():OpenBuffer(newBuffer)

  bp:Center()
end

function openInTab(bp)
  local filename = getFilenameFromCurrentLine(bp)

  bp:HandleCommand("tab " .. filename)

  bp:Center()
end

function getFilenameFromCurrentLine(bp)
  local cursor = bp.Cursor
  local currentLine = bp.Buf:Line(cursor.Y)
  local currentLineSplitByColon = strings.Split(currentLine, ":")
  
  if #currentLineSplitByColon == 0 then
    micro.InfoBar():Error("No filename found at current line")
    return
  end

  return currentLineSplitByColon[1] .. ":" .. currentLineSplitByColon[2]
end
