if vim.filetype then
    vim.filetype.add({
        pattern = {
            [".*/templates/.*%.ya?ml"] = "helm",
            -- snitched https://github.com/mfussenegger/nvim-ansible/blob/main/ftdetect/ansible.lua
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
            [".*.service"] = "systemd",
        },
    })
end
