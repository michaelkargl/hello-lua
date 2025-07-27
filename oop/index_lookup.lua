-- This table acts as our class definition / prototpye where we store methods, constructors and class data
Cat = {}
-- __index is a special metamethod that tells lua where to look  when a key or method is not found
-- in a table. This acts on an instances (created with setmetatable), ie. a metatable must exist.
Cat.__index = Cat
-- Together these lines create a self-referencing class structure
-- Given a call to a method
-- 1. Instance doesn't have method -> check metatable
-- 2. Metatable doesn't have it as regular field -> check __index
-- 3. __index points to Cat -> look in Cat table
-- 4. Cat table has the method -> call it

-- constructor
function Cat:new(name)
    local instance = { name = name }
    -- assign `instance` to `self`
    setmetatable(instance, self)
    return instance
end

function Cat:meow()
    print(self.name .. '> meow!')
end

-------------------------------------------------------------------------------

Dog = {}
Dog.__index = Dog

-- constructor
function Dog:new(name)
    -- does the same as Cat:new()
    return setmetatable({
        name = name
    }, self)
end

function Dog:woof()
    print(self.name .. '> woof!')
end

-------------------------------------------------------------------------------

return {
    run = function()
        print("--------------------")
        print("Index Lookup example")
        print("--------------------")
        local cat = Cat:new('Kitty')
        local dog = Dog:new('Woofie')

        print('-------1------')
        cat:meow()
        dog:woof()

        print('-------2------')
        cat:meow() -- meow!
        -- cat:woof() -- attempt to call method 'woof' (a nil value)

        print('-------3------')
        Cat.__index = Dog
        cat:woof()
    end
}