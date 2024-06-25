require("nomig.remap")
require("nomig.set")
require("nomig.lazy")
require("nomig.autocmd")


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
