-- [[
-- TODO :
-- live reload base lsp configs
-- add option to target a git repos (extract .git)
-- so config can be saved on github and relevant
-- on every machines without same project directory
-- ]]

Project = {
	path = "project",
	lspConfigsPath = "lazy/plugins/lsp/configs",
	lspConfigs = {},
	projects = {},
}

local projectDir = vim.fn.stdpath('config') .. '/lua/' .. Project.path .. '/'
--[[
all autoCmds setted with this augroup
will be cleared when chdir out of the
project dir (the augroup will be deleted)

usage :

```lua
function (augroup)
	vim.api.nvim_create_autocmd("exemple", {
		pattern = { "exemple" },
		group = augroup,
		desc = "exemple",
		callback = function () end
	})
end
```
--]]
---@class autoCmdsHookFunction: function

---@class Project
---@field path string
---@field name string | nil
---@field hook function | nil
---@field clearHook function | nil
---@field autoCmdsHook autoCmdsHookFunction | nil
---@field lspConfigs table<string, table> | nil
---@field keys table | nil


---@type Project | nil
local currentProject =  nil

local function loadOneProject(fileName)
	local project = dofile(projectDir .. fileName)
	if type(project) ~= "table" or type(project.path) ~= "string" then
		return
	end
	if not project.name then
		project.name = fileName:gsub(".lua", "")
	end
	project.file = projectDir .. fileName
	Project.projects[project.path] = project
end

local function loadProjects()
	for _, fileName in ipairs(vim.fn.readdir(projectDir)) do
		if fileName:find(".lua$") then
			loadOneProject(fileName)
		end
	end
end

local function loadLspConfigs()
	local lspConfigsDir = vim.fn.stdpath('config') .. '/lua/' .. Project.lspConfigsPath .. '/'
	for _, fileName in ipairs(vim.fn.readdir(lspConfigsDir)) do
		local config = dofile(lspConfigsDir .. fileName)
		if type(config) == "table" then
			Project.lspConfigs[fileName:gsub(".lua", "")] = config
		end
	end
end

local function changeConfigSettingForLspClient(client, settings)
  -- TODO should merge with defaults settings here
	client.config.settings = settings
	client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
end

local function setAutoCmds(newProject)
	if type(newProject.autoCmdsHook) ~= "function" then
		return
	end
	local augroup = vim.api.nvim_create_augroup(newProject.path, { clear = true })
	newProject.autoCmdsHook(augroup)
end

local function clearAutoCmds()
	if not currentProject or type(currentProject.autoCmdsHook) ~= "function" then
		return
	end
	vim.api.nvim_del_augroup_by_name(currentProject.path)
end

local function clearProject()
	if not currentProject then
		return
	end
	require("notify")("unloading project " .. currentProject.name, nil, { timeout = 1 })
	if type(currentProject.clearHook) == "function" then
		currentProject.clearHook()
	end
	clearAutoCmds()
	currentProject = nil
end

local function setProject(newProject)
	clearProject()
	require("notify")("loading project " .. newProject.name, nil, { timeout = 500 })
	if type(newProject.hook) == "function" then
		newProject.hook()
	end
	setAutoCmds(newProject)
  local clients = vim.lsp.get_clients()
  for _, client in ipairs(clients) do
    if client.config.cmd_cwd == newProject.path then
      if (newProject.lspConfigs or {})[client.name] ~= nil then
        require("notify")("notify lsp")
        changeConfigSettingForLspClient(client, newProject.lspConfigs[client.name])
      else
        require("notify")("not notify lsp :\n" .. vim.inspect(newProject.lspConfigs))
      end
    end
  end
	currentProject = newProject
end

local function callback(args)
	local newProject = Project.projects[args.pwd]
	if newProject == currentProject then
		return
	elseif not newProject and currentProject then
		clearProject()
		return
	else
		setProject(newProject)
	end
end

-- probably cleaner to use before_init here so it change config before launch rather than after

local function applyLspConfig(client)
  local project = Project.projects[client.config.cmd_cwd]
  if project == nil or project.lspConfigs == nil then
    return
  end
  local config = project.lspConfigs[client.name]
  if config == nil or config.settings == nil then
    return
  end
  -- require("notify")("on_init config :\n" .. vim.inspect(config))
  changeConfigSettingForLspClient(client, config.settings)
end

Project.on_init = function (func)
	return function (client)
    applyLspConfig(client)
		if func then
			func(client)
		end
	end
end

local augroup = vim.api.nvim_create_augroup("project", { clear = true })

vim.api.nvim_create_autocmd("DirChanged", {
	pattern = { "*" },
	group = augroup,
	desc = "trigger handlers of project.nvim",
	callback = function (ev) callback({ pwd = ev.file }) end
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { projectDir .. '*.lua' },
	group = augroup,
	desc = "test",
	callback = function (ev)
		local fileName = ev.file
		loadOneProject(fileName:sub(fileName:find("[^/]*$")))
		callback({ pwd = vim.loop.cwd() })
	end
})

Project.createProject = function ()
	local cwd = vim.loop.cwd()
	vim.ui.input({
		prompt = 'projectName: ',
		default = cwd:sub(cwd:find("[^/]*$"))
	}, function(input)
		if not input then
			return
		end
		local projectFile = projectDir .. input .. '.lua'
		vim.cmd('e ' .. projectFile)
	end)
end

-- Project.createProject()
Project.openOrCreateProject = function ()
	local cwd = vim.loop.cwd()
	local project = Project.projects[cwd]
	if not project then
		Project.createProject()
		return
	end
	vim.cmd('e ' .. project.file)
end

vim.keymap.set('n', '<leader>Po', Project.openOrCreateProject, {})

loadLspConfigs()
loadProjects()
callback({ pwd = vim.loop.cwd() })
