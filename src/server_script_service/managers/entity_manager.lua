-- Entity Manager
local entity_manager = {}

-- Table to store entities
entity_manager.entities = {}

-- Function to generate a UUID
local function generate_uuid()
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    return string.gsub(template, "[xy]", function(char)
        local v = (char == "x") and math.random(0, 15) or math.random(8, 11)
        return string.format("%x", v)
    end)
end

-- Add an entity
function entity_manager.add_entity(entity)
    local id = generate_uuid() -- Generate a unique UUID
    entity_manager.entities[id] = entity
    print("Entity added with UUID:", id)
    return id -- Return the UUID for reference
end

-- Remove an entity
function entity_manager.remove_entity(id)
    if entity_manager.entities[id] then
        entity_manager.entities[id] = nil
        print("Entity removed with UUID:", id)
    else
        print("No entity found with UUID:", id)
    end
end

-- Get an entity by UUID
function entity_manager.get_entity(id)
    return entity_manager.entities[id]
end

-- Get all entities
function entity_manager.get_all_entities()
    return entity_manager.entities
end

return entity_manager
