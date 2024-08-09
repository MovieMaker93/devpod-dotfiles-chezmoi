local log = require("plenary.log"):new()
local ns = vim.api.nvim_create_namespace "live-tests"
local group = vim.api.nvim_create_augroup("devfortunato-magic", { clear = true })

local test_function_query_string = [[
(
 (function_declaration
  name: (identifier) @name
  parameters:
    (parameter_list
     (parameter_declaration
      name: (identifier)
      type: (pointer_type
          (qualified_type
           package: (package_identifier) @_package_name
           name: (type_identifier) @_type_name)))))

 (#eq? @_package_name "testing")
 (#eq? @_type_name "T")
 (#eq? @name "%s")
)
]]

local find_test_line = function(go_bufnr, name)
    local formatted = string.format(test_function_query_string, name)
    local query = vim.treesitter.query.parse("go", formatted)
    local parser = vim.treesitter.get_parser(go_bufnr, "go", {})
    local tree = parser:parse()[1]
    local root = tree:root()
    for id, node in query:iter_captures(root, go_bufnr, 0, -1) do
        if id == 1 then
            local range = { node:range() }
            return range[1]
        end
    end
end

log.level = 'debug'

local make_key = function(entry)
    assert(entry.Package, "Must have Package:" .. vim.inspect(entry))
    assert(entry.Test, "Must have Test:" .. vim.inspect(entry))
    return string.format("%s/%s", entry.Package, entry.Test)
end

local add_golang_test = function(state, entry)
    state.tests[make_key(entry)] = {
        name = entry.Test,
        line = find_test_line(state.bufnr, entry.Test),
        output = {},
    }
end

-- local add_golang_output = function(state, entry)
--     assert(state.tests, vim.inspect(state))
--     table.insert(state.tests[make_key(entry)].output, vim.trim(entry.Output))
-- end

local mark_success = function(state, entry)
    state.tests[make_key(entry)].success =  entry.Action == "pass"
end

local attach_to_buffer = function (output_bufnr, pattern, command)
    local state = {
        bufnr = output_bufnr,
        tests = {},
    }
    -- vim.api.nvim_buf_create_user_command(output_bufnr, "GoTestLineDiag", function()
    --     local line = vim.fn.line "." - 1
    --     for _, test in pairs(state.tests) do
    --         if test.line == line then
    --             vim.cmd.new()
    --             vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), 0, -1, false, test.output)
    --         end
    --     end
    -- end, {})

    vim.api.nvim_create_autocmd("BufWritePost",{
        group = group,
        pattern = pattern,
        callback = function ()
            vim.api.nvim_buf_clear_namespace(output_bufnr, ns, 0, -1)
            vim.fn.jobstart(command, {
                stdout_buffered = true,
                on_stdout = function (_, data)
                    for _, line in pairs(data) do
                        local decoded = vim.json.decode(line)
                        if decoded.Action == "run" then
                            add_golang_test(state, decoded)
                        elseif decoded.Action == "pass" or decoded.Action == "fail" then
                            mark_success(state, decoded)
                            local test = state.tests[make_key(decoded)]
                            if test.success then
                                local text = { "✓" }
                                vim.api.nvim_buf_set_extmark(output_bufnr, ns, test.line, 0, {
                                    virt_text = { text },
                                })
                            end
                        -- elseif decoded.Action == "output" then
                        --     if not decoded.Test then
                        --         return
                        --     end
                        --     add_golang_output(state, decoded)
                        end
                    end
                end,
                on_exit = function ()
                    local failed = {}
                    for _, test in pairs(state.tests) do
                        if test.line then
                            if not test.success then
                                table.insert(failed , {
                                    bufnr = output_bufnr,
                                    lnum = test.line,
                                    col = 0,
                                    severity = vim.diagnostic.severity.ERROR,
                                    source = "go-test",
                                    message = "Test Failed",
                                    user_data = {},
                                })
                            end
                        end
                    end
                    vim.diagnostic.set(ns, output_bufnr, failed, {})
                end,
            })
        end
    }
    )
end
vim.api.nvim_create_user_command("GoTestRun", function ()
    print("GoTestRun started")
    attach_to_buffer(vim.api.nvim_get_current_buf(), "*.go",{"go", "test", "./...", "-v", "-json"})
end, {})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = "*",
    desc = "Remove withespace on save",
    command = "%s/\\s\\+$//e",
})

-- vim.api.nvim_create_autocmd({"BufEnter", "FileType"}, {
--     group = group,
--     pattern = "*",
--     desc = "don't autocomment new line",
--     command = "setlocal formatoptions-=c fortmatoptions-=r formatoptions-=o",
-- })

