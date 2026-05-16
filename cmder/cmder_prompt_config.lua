-- All of the below was 'borrowed' from https://github.com/AmrEldib/cmder-powerline-prompt

--- REQUIRED. config_prompt_type is whether the displayed prompt is the full path or only the folder name
 -- Use:
 -- "full" for full path like C:\Windows\System32
 -- "folder" for folder name only like System32
 -- default is full
prompt_type = "folder"

--- REQUIRED. config_prompt_useHomeSymbol is whether to show ~ instead of the full path to the user's home folder
 -- Use true or false
 -- default is false
prompt_useHomeSymbol = true

-- Symbols
-- REQUIRED. Prompt displayed instead of user's home folder e.g. C:\Users\username
 -- default is '~'
prompt_homeSymbol = "~"

-- REQUIRED. Symbol displayed in the new line below the prompt.
 -- default is 'λ'
prompt_lambSymbol = "λ"

-- REQUIRED. Adds [user]@[host] to the beginning of the prompt like bash
 -- default is false
prompt_useUserAtHost = false

-- REQUIRED. If true prompt is a single line instead of default two line prompt.
 -- default is false
prompt_singleLine = true

-- OPTIONAL. If true then Cmder includes git, mercurial, and subversion status in the prompt.
 -- default is true
prompt_includeVersionControl = true

-- OPTIONAL. If true then always ignore the cmder.status and cmder.cmdstatus git config settings and run the git prompt commands in the background.
 -- default is false
 -- NOTE: This only takes effect if using Clink v1.2.10 or higher.
prompt_overrideGitStatusOptIn = false

-- OPTIONAL. If true then always ignore the cmder.status and cmder.cmdstatus svn config settings and run the svn prompt commands in the background.
 -- default is false
 -- NOTE: This only takes effect if using Clink v1.2.10 or higher.
prompt_overrideSvnStatusOptIn = false

-- Prompt Attributes
--
-- Colors: https://github.com/cmderdev/cmder/wiki/Customization#list-of-colors
-- Effects: https://github.com/cmderdev/cmder/wiki/Customization#list-of-effects
--
-- Green:      "\x1b[1;33;49m"
-- Yellow:     "\x1b[1;32;49m"
-- Light Grey: "\x1b[1;30;49m"

-- Prompt Element Colors
local color = {
    pink          = { 245, 145, 178 },
    yellow        = { 230, 185, 157 },
    gray          = { 153, 152, 168 },
    white         = { 193, 192, 212 },
    purple        = { 172, 161, 207 },
    pink_conflict = { 234, 131, 165 },
}

local style = {
    normal      = "",
    bold        = ";1",
    italic      = ";3",
    bold_italic = ";1;3",
}

local function ansi_rgb(color, effect)
    effect = effect or style.normal
    return string.format("\x1b[38;2;%d;%d;%d%s", color[1], color[2], color[3], effect) .. "m"
end

-- uah_color = [user]@[hostname] - Pink
uah_color = ansi_rgb(color.purple, style.normal)

-- cwd_color = Current Working Directory - Yellow
cwd_color = ansi_rgb(color.pink, style.normal)

-- lamb_color = Lambda symbol - Gray
lamb_color = ansi_rgb(color.gray, style.normal)

-- clean_color = Clean VCS status - White with Bold
clean_color = ansi_rgb(color.purple, style.normal)

-- dirty_color = Dirty VCS status - Purple with Italic
dirty_color = ansi_rgb(color.purple, style.italic)

-- conflict_color = Conflict VCS status - Pink with Bold
conflict_color = ansi_rgb(color.pink_conflict, style.bold)

-- unknown_color = No VCS status - White with Bold
unknown_color = ansi_rgb(color.white, style.bold)
