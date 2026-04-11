local status, mod = pcall(require, "Comment")
if not status then
    return
end

mod.setup({
    padding = true,
    sticky = true,
    ignore = nil,
})
