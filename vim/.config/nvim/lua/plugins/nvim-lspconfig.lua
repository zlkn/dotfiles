MiniDeps.add("neovim/nvim-lspconfig")
MiniDeps.now(function()
    print("Setup lsp servers")
    vim.lsp.enable("yamlls")
    vim.lsp.config("yamlls", {
        settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
                keyOrdering = false,
                format = {
                    enable = false,
                },
                validate = true,
                schemaStore = {
                    -- Must disable built-in schemaStore support to use
                    -- schemas from SchemaStore.nvim plugin
                    enable = false,
                    -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                    url = "",
                },
                schemas = {
                    kubernetes = { "k8s**.yaml", "kube*/*.yaml", "tshoot*/*.yaml" },
                    ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
                    ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "docker-compose*.{yml,yaml}",
                    ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"] = "*.Application.yaml",
                    ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/applicationset_v1alpha1.json"] = "*.ApplicationSet.yaml",
                },
            },
        },
    })

    vim.lsp.enable("lua_ls")
    vim.lsp.config("lua_ls", {
        on_init = function(client)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if
                    path ~= vim.fn.stdpath("config")
                    and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
                then
                    return
                end
            end

            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {
                    -- Tell the language server which version of Lua you're using
                    -- (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                    checkThirdParty = true,
                    library = {
                        vim.env.VIMRUNTIME,
                        -- Depending on the usage, you might want to add additional paths here.
                        "${3rd}/luv/library",
                        -- "${3rd}/busted/library",
                    },
                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                    -- library = vim.api.nvim_get_runtime_file("", true)
                },
            })
        end,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "MiniDeps", "MiniPick", "MiniFiles" },
                },
            },
        },
    })

    vim.lsp.enable("tflint")
    vim.lsp.enable("terraformls")
    vim.lsp.config("terraformls", {
        servers = {
            terraformls = {
                cmd = { "terraform-ls", "serve" },
                filetypes = { "terraform", "tf" },
                root_markers = { ".terraform", ".git" },
            },
        },
    })

    vim.lsp.enable("ansiblels")
    vim.lsp.config("ansiblels", {
        cmd = { "ansible-language-server", "--stdio" },
        settings = {
            ansible = {
                python = { interpreterPath = "python3" },
                ansible = { path = "ansible" },
                executionEnvironment = { enabled = false },
                validation = {
                    enabled = false,
                    lint = { enabled = true, path = "ansible-lint" },
                },
            },
        },
        filetypes = { "yaml", "yml", "ansible" },
        root_markers = { "ansible.cfg", ".ansible-lint" },
        single_file_support = false,
    })

    vim.filetype.add({
        pattern = {
            [".*/playbooks/([^/]+/)*[^/]+%.ya?ml$"] = "ansible",
            [".*/roles/([^/]+/)*[^/]+%.ya?ml$"] = "ansible",
        },
    })

    vim.lsp.enable("pyright")
end)
