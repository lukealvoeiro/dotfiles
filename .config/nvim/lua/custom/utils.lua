local M = {}

--- Check if the specified buffer is floating
--- @param winid integer
function M.is_buffer_float(winid)
  return vim.api.nvim_win_get_config(winid).zindex
end

function M.is_curr_buffer_float()
  if M.is_buffer_float(vim.api.nvim_get_current_win()) then
    return true
  end
end

--- Parse a given integer color to a hex value.
--- @param int_color number
function M.parse_hex(int_color)
  return string.format("#%x", int_color)
end

--- Get highlight properties for a given highlight name
--- @param name string The highlight group name
--- @param fallback? table The fallback highlight properties
--- @return table properties # the highlight group properties
function M.get_hlgroup(name, fallback)
  if vim.fn.hlexists(name) == 1 then
    local group = vim.api.nvim_get_hl(0, { name = name })

    local hl = {
      fg = group.fg == nil and "NONE" or M.parse_hex(group.fg),
      bg = group.bg == nil and "NONE" or M.parse_hex(group.bg),
    }

    return hl
  end
  return fallback or {}
end

-- Define a generic table type
function M.shallow_copy(t)
  local t2 = {}
  for k, v in pairs(t) do
    t2[k] = v
  end
  return t2
end

---@param c  string
local function rgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---@param foreground string foreground color
---@param background string background color
---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
function M.blend(foreground, alpha, background)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = rgb(background)
  local fg = rgb(foreground)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.blend_bg(hex, amount, bg)
  return M.blend(hex, amount, bg or M.bg)
end
M.darken = M.blend_bg

function M.blend_fg(hex, amount, fg)
  return M.blend(hex, amount, fg or M.fg)
end
M.lighten = M.blend_fg

return M
