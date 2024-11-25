-- Entity Manager
local EntityManager = {}

-- Table to store entities
EntityManager.entities = {}

-- Function to generate a UUID
local function generate_uuid()
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    return string.gsub(template, "[xy]", function(char)
        local v = (char == "x") and math.random(0, 15) or math.random(8, 11)
        return string.format("%x", v)
    end)
end

-- Add an entity
function EntityManager.add_entity(entity)
    local id = generate_uuid() -- Generate a unique UUID
    EntityManager.entities[id] = entity
    print("Entity added with UUID:", id)
    return id -- Return the UUID for reference
end

-- Remove an entity
function EntityManager.remove_entity(id)
    if EntityManager.entities[id] then
        EntityManager.entities[id] = nil
        print("Entity removed with UUID:", id)
    else
        print("No entity found with UUID:", id)
    end
end

-- Get an entity by UUID
function EntityManager.get_entity(id)
    return EntityManager.entities[id]
end

-- Get all entities
function EntityManager.get_all_entities()
    return EntityManager.entities
end

return EntityManager