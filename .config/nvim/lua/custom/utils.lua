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

return M
