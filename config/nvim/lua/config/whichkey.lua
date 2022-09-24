local M = {}

local whichkey = require "which-key"

local conf = {
	window = {
		border = "double", -- none, single, double, shadow
		position = "bottom", -- bottom, top
	},
  triggers = { }
}

local opts = {
	mode = "n", -- Normal mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}

local function normal_keymap()
	local keymap_p = {
		name = "Project",
		p = { "<cmd>lua require'telescope'.extensions.project.project{}<cr>", "List" },
		s = { "<cmd>Telescope repo list<cr>", "Search" },
	}

  local keymap_z = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  }

  local keymap_t = {
    name = "Test",
    S = { "<cmd>UltestSummary<cr>", "Summary" },
    a = { "<cmd>Ultest<cr>", "All" },
    d = { "<cmd>UltestDebug<cr>", "Debug" },
    f = { "<cmd>TestFile<cr>", "File" },
    l = { "<cmd>TestLast<cr>", "Last" },
    n = { "<cmd>TestNearest<cr>", "Nearest" },
    o = { "<cmd>UltestOutput<cr>", "Output" },
    s = { "<cmd>TestSuite<cr>", "Suite" },
    v = { "<cmd>TestVisit<cr>", "Visit" },
  }

  local keymap_n = {
    name = "Misc",
    t = { "<cmd>Term ", "New Terminal" }
  }

	local keymap = {
    a = { "<c-^>", "Alternate buffer" },
		w = { "<cmd>update!<CR>", "Save" },
		q = { "<cmd>q!<CR>", "Quit" },
    x = { "<Cmd>bd!<Cr>", "Exit Buffer" },
    e = { "<cmd>Telescope find_files<cr>", "Files" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },

    z = keymap_z,
		t = keymap_t,
		p = keymap_p,
    n = keymap_n
	}

	whichkey.setup(conf)
	whichkey.register(keymap, opts)
end

local function code_keymap()
  vim.cmd "autocmd FileType * lua CodeRunner()"

  function CodeRunner()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local keymap_c = {
			name = "Code",
			a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
			i = { "<cmd>LspInfo<CR>", "Lsp Info" },
			r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
			u = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
			z = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format Document" },
      e = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },

      D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
      d = { "<Cmd>Telescope lsp_definitions<CR>", "Definition" },
      I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
      s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
      t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
		}
		local file_specific_keymaps = {}
		local keymap_c_v = {}

    if ft == "lua" then
      file_specific_keymaps = {
        r = { "<cmd>luafile %<cr>", "Run" },
      }
    elseif ft == "typescript" or ft == "typescriptreact" then
      file_specific_keymaps = {
        o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize" },
        r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
        i = { "<cmd>TypescriptAddMissingImports<cr>", "Add Imports" },
      }
    elseif ft == "java" then
      file_specific_keymaps = {
        o = { "<cmd>lua require'jdtls'.organize_imports()<cr>", "Organize Imports" },
        v = { "<cmd>lua require('jdtls').extract_variable()<cr>", "Extract Variable" },
        c = { "<cmd>lua require('jdtls').extract_constant()<cr>", "Extract Constant" },
        t = { "<cmd>lua require('jdtls').test_class()<cr>", "Test Class" },
      }
      keymap_c_v = {
        name = "Code",
        v = { "<cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable" },
        c = { "<cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant" },
        m = { "<cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method" },
      }
    end

		for key, value in pairs(file_specific_keymaps) do keymap_c[key] = value end

    if next(keymap_c) ~= nil then
      whichkey.register(
        { c = keymap_c },
        { mode = "n", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
      )
    end

    if next(keymap_c_v) ~= nil then
      whichkey.register(
        { c = keymap_c_v },
        { mode = "v", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
      )
    end
  end
end

function M.setup()
	normal_keymap()
	code_keymap()
end

return M
