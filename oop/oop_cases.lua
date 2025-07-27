local index_lookup_case = require('oop.index_lookup')
local inheritance_case = require('oop.inheritance')

return {
    run = function()
        index_lookup_case.run()
        inheritance_case.run()
    end
}