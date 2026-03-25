require("nomig.autocmd")
require("nomig.remap")
require("nomig.set")

-- Fire all custom code before any plugin
require("nomig.lazy")


-- Better reloading and printing
P = function(v)
    print(vim.inspect(v))
    return v
end

RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end
