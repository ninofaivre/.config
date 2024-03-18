local colorschemes = {
	{ "EdenEast/nightfox.nvim" },
  { "catppuccin/nvim", name = "catppuccin" }
}

for _, v in ipairs(colorschemes) do
	if type(v) == "table" then
		v["lazy"] =  true
		v["priority"] = 1000
	end
end

colorschemes[#colorschemes+1] = {
  "ninofaivre/lumen-linux.nvim",
  priority = 200,
  config = function ()
    require("lumen-linux").setup({ light = "catppuccin-latte", dark = "catppuccin-macchiato" })
  end
}

return colorschemes
