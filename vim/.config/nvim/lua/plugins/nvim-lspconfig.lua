MiniDeps.add({ source = "neovim/nvim-lspconfig", depends = { "b0o/SchemaStore.nvim" } })
MiniDeps.now(function()
    -- print("Setup lsp servers")

    vim.lsp.enable("helm_ls")
    vim.lsp.config("helm_ls", {})
    -- snitched https://github.com/mfussenegger/nvim-ansible/blob/main/ftdetect/ansible.lua
    if vim.filetype then
        vim.filetype.add({
            pattern = {
                [".*/templates/.*%.ya?ml"] = "helm",
            },
        })
    end

    vim.lsp.enable("yamlls")
    vim.lsp.config("yamlls", {
        filetypes = { "yaml", "yml", "yaml.docker-compose", "yaml.ansible" },
        settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
                keyOrdering = false,
                format = {
                    enable = false,
                },
                completion = true,
                validate = true,
                hover = true,
                schemaStore = {
                    -- Must disable built-in schemaStore support to use
                    -- schemas from SchemaStore.nvim plugin
                    enable = false,
                    -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                    url = "",
                },
                schemas = vim.tbl_deep_extend("force", require("schemastore").yaml.schemas(), {
                    ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
                    ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "docker-compose*.{yml,yaml}",
                    ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"] = "*.Application.yaml",
                    ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/applicationset_v1alpha1.json"] = "*.ApplicationSet.yaml",
                    kubernetes = {
                        "*.DaemonSet.yaml",
                        "*.Deployment.yaml",
                        "*.StatefulSet.yaml",
                        "*.ReplicaSet.yaml",
                        "*.Service.yaml",
                        "*.Pod.yaml",
                        "*.Namespace.yaml",
                        "*.ConfigMap.yaml",
                        "*.Secret.yaml",
                        "*.Job.yaml",
                        "*.CronJob.yaml",
                        "*.PersistentVolume.yaml",
                        "*.PersistentVolumeClaim.yaml",
                        "*.StorageClass.yaml",
                        "*.Ingress.yaml",
                        "*.NetworkPolicy.yaml",
                        "*.ServiceAccount.yaml",
                        "*.Role.yaml",
                        "*.RoleBinding.yaml",
                        "*.ClusterRole.yaml",
                        "*.ClusterRoleBinding.yaml",
                    },
                }),
            },
        },
    })

    vim.lsp.enable("lua_ls")
    vim.lsp.config("lua_ls", {
        filetypes = { "lua" },
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
                hint = { enable = true },
                diagnostics = {
                    globals = { "vim", "MiniDeps", "MiniPick", "MiniFiles", "none" },
                },
            },
        },
    })

    vim.lsp.enable("tflint")
    vim.lsp.config("tflint", {
        filetypes = { "terraform", "tf" },
        root_markers = { ".terraform", ".git" },
    })
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
        filetypes = { "yaml.ansible" },
        root_markers = { "ansible.cfg", ".ansible-lint" },
        single_file_support = false,
    })

    -- snitched https://github.com/mfussenegger/nvim-ansible/blob/main/ftdetect/ansible.lua
    if vim.filetype then
        vim.filetype.add({
            pattern = {
                [".*/defaults/.*%.ya?ml"] = "yaml.ansible",
                [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
                [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
                [".*/group_vars/.*/.*%.ya?ml"] = "yaml.ansible",
                [".*/playbook.*%.ya?ml"] = "yaml.ansible",
                [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
                [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
                [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
                [".*/tasks/.*%.ya?ml"] = "yaml.ansible",
                [".*/molecule/.*%.ya?ml"] = "yaml.ansible",
            },
        })
    end

    vim.lsp.enable("dockerls")
    vim.lsp.config("dockerls", {})

    vim.lsp.enable("ruff")
    vim.lsp.config("ruff", {})
end)
