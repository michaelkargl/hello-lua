-- class definition / prototype
Pokemon = {}
Pokemon.__index = Pokemon

-- Remember, using the colon operator is syntactic sugar for passing the object infront of `:` as the first parameter.
-- So `function Pokemon:new(name)` is equivalent to `function Pokemon.new(Pokemon, name)`
function Pokemon:new(name)
    -- `self` in this case is the prototype.
    -- we assign the prototype as metatable to the new instance.
    -- This means that access to methods and properties will first look in the instance, then in the prototype.
    return setmetatable({
        name = name or "Pokemon"
    }, self)
end

function Pokemon:attack()
    print(self.name..": Tackle!")
end

function Pokemon:extend()
    local prototype = {}
    prototype.__index = prototype

    -- the new anonymous protoype is set to inherit from the `Pokemon` class using setmetatable. The `self` parameter, which
    -- refers to the `Pokemon` class, is passed as the metatable for `class`.
    -- Remember the lookup order:
    -- 1. Instance
    -- 2. Metatable
    -- 3. __index
    -- This ensures that that calls to unknown methods on the `class` will first look in the `Pokemon` class, but
    -- known calls will be handled by the `class` table (overrides).
    return setmetatable(prototype, self)
end

-- ----------------------------------------------------------------------------

-- Scyther class that extends the Pokemon class / it gives the anonymous subclass a name
-- This will act as prototype for new instances of Scyther.
Scyther = Pokemon:extend()

function Scyther:new()
    -- create a new instance of `Pokemon` but assign its' `self` to the prototype of `Scyther`
    return Pokemon.new(self, "Scyther")
end

function Scyther:attack()
    print(self.name..": Cut!")
    -- call the parent method (super.attack())
    Pokemon.attack(self)
end

-- ----------------------------------------------------------------------------

return {
    run = function()
        print()
        print("-------------------")
        print("Inheritance example")
        print("-------------------")

        local pokemon = Pokemon:new("Caterpie")
        pokemon:attack()

        local scyther = Scyther:new()
        scyther:attack()
    end
}