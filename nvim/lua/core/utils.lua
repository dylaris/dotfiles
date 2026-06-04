--=============================
-- Text
--=============================

function get_visual_selection()
  -- store v register
  local saved_register = vim.fn.getreg('v')
  local saved_register_type = vim.fn.getregtype('v')

  -- copy selected text to v register
  vim.cmd('silent normal! "vy')
  local selection = vim.fn.getreg('v')

  -- restore v register
  vim.fn.setreg('v', saved_register, saved_register_type)

  return selection
end

--=============================
-- Buffer
--=============================

function open_buffer_in_win(direction, scratch)
  scratch = scratch or false
  direction = direction or "down"
  local split_cmd = {
    left = 'vsplit',
    right = 'vsplit',
    up = 'split',
    down = 'split'
  }

  vim.cmd(split_cmd[direction])

  if direction == 'right' then
    vim.cmd('wincmd l')
  elseif direction == 'down' then
    vim.cmd('wincmd j')
  end

  vim.cmd('enew')

  if scratch then
    vim.opt_local.buftype = 'nofile'
    vim.opt_local.bufhidden = 'hide'
    vim.opt_local.swapfile = false
  end

  local bufnr = vim.api.nvim_get_current_buf()
  print("Opened new buffer: " .. bufnr)
end

function close_other_buffers()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end

--=============================
-- Term
--=============================

local terminals = {}
local max_terminals = 5
local fruit_names = {"apple", "banana", "orange", "grape", "pair"}

local function get_next_name()
  for _, fruit in ipairs(fruit_names) do
    local name = "term-" .. fruit
    if not terminals[name] then
      return name
    end
  end
  return nil
end

local function get_count()
  local count = 0
  for name, term in pairs(terminals) do
    if vim.api.nvim_buf_is_valid(term.bufnr) then
      count = count + 1
    else
      terminals[name] = nil
    end
  end
  return count
end

function open_term_in_tab()
  if get_count() >= max_terminals then
    print("Max terminals reached (" .. max_terminals .. ")")
    return
  end

  local name = get_next_name()
  if not name then
    print("No available names")
    return
  end

  vim.cmd('tabnew')
  vim.cmd('term')
  -- vim.cmd('startinsert')

  local bufnr = vim.api.nvim_get_current_buf()
  terminals[name] = {
    name = name,
    bufnr = bufnr,
    type = "tab"
  }
  vim.api.nvim_buf_set_name(bufnr, name)
  print("Opened: " .. name)
end

function open_term_in_win(direction)
  if get_count() >= max_terminals then
    print("Max terminals reached (" .. max_terminals .. ")")
    return
  end

  local name = get_next_name()
  if not name then
    print("No available names")
    return
  end

  direction = direction or "down"
  local split_cmd = {
    left = 'vsplit',
    right = 'vsplit',
    up = 'split',
    down = 'split'
  }

  vim.cmd(split_cmd[direction])

  if direction == 'right' then
    vim.cmd('wincmd l')
  elseif direction == 'down' then
    vim.cmd('wincmd j')
  end

  vim.cmd('term')
  -- vim.cmd('startinsert')

  local bufnr = vim.api.nvim_get_current_buf()
  terminals[name] = {
    name = name,
    bufnr = bufnr,
    type = "win"
  }
  vim.api.nvim_buf_set_name(bufnr, name)
  print("Opened: " .. name)
end

function close_terminal()
  local current_buf = vim.api.nvim_get_current_buf()

  for name, term in pairs(terminals) do
    if term.bufnr == current_buf then
      vim.api.nvim_buf_delete(term.bufnr, { force = true })
      terminals[name] = nil
      print("Closed: " .. name)
      return
    end
  end

  print("Current buffer is not a terminal")
end

function close_all_terminals()
  local count = 0
  for name, term in pairs(terminals) do
    if vim.api.nvim_buf_is_valid(term.bufnr) then
      vim.api.nvim_buf_delete(term.bufnr, { force = true })
      count = count + 1
    end
    terminals[name] = nil
  end
  if count > 0 then
    print("Closed " .. count .. " terminal(s)")
  else
    print("No terminals to close")
  end
end

function only_terminal()
  local current_buf = vim.api.nvim_get_current_buf()

  local is_terminal = false
  for name, term in pairs(terminals) do
    if term.bufnr == current_buf then
      is_terminal = true
      break
    end
  end

  if not is_terminal then
    vim.notify("Current buffer is not a terminal", vim.log.levels.WARN)
    return
  end

  local kept_name = nil
  local closed = 0

  for name, term in pairs(terminals) do
    if vim.api.nvim_buf_is_valid(term.bufnr) then
      if term.bufnr == current_buf then
        kept_name = name
      else
        vim.api.nvim_buf_delete(term.bufnr, { force = true })
        terminals[name] = nil
        closed = closed + 1
      end
    else
      terminals[name] = nil
    end
  end

  if closed > 0 then
    print("Closed " .. closed .. " terminal(s), kept: " .. (kept_name or "current"))
  elseif kept_name then
    print("Only terminal: " .. kept_name)
  end
end

--=============================
-- Other
--=============================

function parse_error_report()
  local selection = get_visual_selection()
  local patterns = {
    "([%w%._]-):(%d+):(%d+)",         -- main.c:1:1
    "([%w%._]-)%((%d+),(%d+)%)",      -- main.c(1,1)
    "([%w%._]-):(%d+)",           -- main.java:1
    'File%s*"([^"]+)",%s*line%s*(%d+)',   -- File "main.py", line 1
    'syntax error at (.-) line (%d+)',    -- syntax error at main.pl line 3
  }
  for _, pattern in ipairs(patterns) do
    local matches = {selection:match(pattern)}
    if matches[1] then
      local result = {
        file = matches[1],
        row  = tonumber(matches[2]) or 1,
        col  = tonumber(matches[3]) or 1
      }
      return true, result
    end
  end
  return false, "no matching error format found"
end

function open_file_in_bottom_split(back, file_path, row, col)
  -- remove some extra useless characters
  file_path = file_path:gsub("^%s*(.-)%s*$", "%1"):gsub("[\r\n]+", "")

  -- check if file exists
  if vim.fn.filereadable(file_path) == 0 then
    print("file: '" .. file_path .. "' not exists (pwd: " .. vim.fn.getcwd() .. ")")
    return false
  end

  vim.cmd("bot split " .. vim.fn.fnameescape(file_path))
  if row then vim.api.nvim_win_set_cursor(0, {row, (col or 1) - 1}) end
  if back then vim.cmd("wincmd p") end

  return true
end

function print_plus(v)
  print(vim.inspect(v))
  return v
end

