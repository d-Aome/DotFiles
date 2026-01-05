return {
    {
        'Civitasv/cmake-tools.nvim',
        dependencies = { 'mfussenegger/nvim-dap' },
        event = 'VeryLazy',
        opts = function()
        local osys = require("cmake-tools.osys")

        -- This table contains all your specific settings from your file
        return {
            cmake_command = "cmake",
            ctest_command = "ctest",
            cmake_use_preset = true,
            cmake_regenerate_on_save = true,
            cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
            cmake_build_options = {},
            cmake_build_directory = function()
            if osys.iswin32 then
                return "out\\${variant:buildType}"
                end
                return "out/${variant:buildType}"
                end,
                cmake_compile_commands_options = {
                    action = "soft_link",
                    target = vim.loop.cwd(),
                },
                cmake_dap_configuration = {
                    name = "cpp",
                    type = "codelldb",
                    request = "launch",
                    stopOnEntry = false,
                    runInTerminal = true,
                    console = "integratedTerminal",
                },
                cmake_executor = {
                    name = "quickfix",
                    default_opts = {
                        quickfix = {
                            show = "always",
                            position = "belowright",
                            size = 10,
                            auto_close_when_success = true,
                        },
                        -- You can keep your toggleterm/overseer settings here too
                    },
                },
                cmake_runner = {
                    name = "terminal",
                    default_opts = {
                        terminal = {
                            name = "Main Terminal",
                            prefix_name = "[CMakeTools]: ",
                            split_direction = "horizontal",
                            split_size = 11,
                        },
                    },
                },
                cmake_notifications = {
                    runner = { enabled = true },
                    executor = { enabled = true },
                },
                cmake_virtual_text_support = true,
                cmake_use_scratch_buffer = false,
        }
        end,
        config = function(_, opts)
        require("cmake-tools").setup(opts)
        end,
    },
}
