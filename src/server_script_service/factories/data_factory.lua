local data_factory = {}

-- Create a new data object
function data_factory.create_data()
    return {
        triumphs = 0, -- Default value
    }
end

-- Validate data
function data_factory.validate_data(data)
    if type(data) ~= "table" then
        warn("Invalid data object: Expected a table, got " .. typeof(data))
        return false
    end

    -- Ensure required fields exist, fallback to defaults if necessary
    data.triumphs = data.triumphs or 0
    return true
end

return data_factory
