-- The addon documentation version of it.
sc = {}

-- Addon specific related data are stored
sc.addon = {}

---Converts a class to a ScrapComputersComponent
---@param classData ShapeClass
---@param dataType string
function sc.addon.CreateComponent(classData, dataType)
	-- Validate input parameters
    assert(type(classData) == "table", "bad argument #1. Expected ShapeClass, Got "..type(classData).." instead!")
    assert(type(classData.sv_createData) == "function", "sv_createData does NOT exist!")
    
    -- Store any existing server_onCreate function
    local _server_onCreate = classData.server_onCreate
    
    -- Override the server_onCreate function
    classData.server_onCreate = function (self)
        self.interactable.publicData = {
            SCRAPCOMPUTERS_PUBLIC_DATA = {
                self = self, -- Reference to `self`
                dataType = dataType,
                getEnv = classData.sv_createData
            }
        }

        -- Call the original server_onCreate if it exists
        if _server_onCreate then
            _server_onCreate(self)
        end
    end
    
    -- Store any existing server_onRefresh function
    local _server_onRefresh = classData.server_onRefresh
    
    -- Override the server_onRefresh function
    classData.server_onRefresh = function (self)
        classData.server_onCreate(self) -- Refresh by calling the new server_onCreate

        -- Call the original server_onRefresh if it exists
        if _server_onRefresh then
            _server_onRefresh(self)
        end
    end

    -- Store any existing client_onCreate function
    local _client_onCreate = classData.client_onCreate
    
    -- Override the client_onCreate function
    classData.client_onCreate = function (self)
        -- Call the original client_onCreate if it exists
        if _client_onCreate then
            _client_onCreate(self)
        end
    end
    
    -- Store any existing client_onRefresh function
    local _client_onRefresh = classData.client_onRefresh
    
    -- Override the client_onRefresh function
    classData.client_onRefresh = function (self)
        classData.client_onCreate(self) -- Refresh by calling the new client_onCreate

        -- Call the original client_onRefresh if it exists
        if _client_onRefresh then
            _client_onRefresh(self)
        end
    end
end

---This table contains all layout files from $CONTENT_3660881a-a6b8-40e5-a348-27b368a742e9/Gui/Layout. You could also just write the names independenly.
sc.layoutFiles = {
    Computer     = "$CONTENT_DATA/Gui/Layout/Computer.layout",
    Terminal     = "$CONTENT_DATA/Gui/Layout/Terminal.layout",
    Register     = "$CONTENT_DATA/Gui/Layout/Register.layout",
    Configurator = "$CONTENT_DATA/Gui/Layout/Configurator.layout",
    Harddrive    = "$CONTENT_DATA/Gui/Layout/Harddrive.layout"
}

---Contains json files that are uesd on scrapcomputers.
sc.jsonFiles = {
    ExamplesList      = "$CONTENT_DATA/JSON/examples.json",
    HarddriveExamples = "$CONTENT_DATA/JSON/hdd_examples.json",
    AudioList         = "$CONTENT_DATA/JSON/audio.json",
    BuiltInFonts      = "$CONTENT_DATA/JSON/fonts.json"
}

---Additional features that the normal tostring function dosen't have
---@param value any The value to convert to a string
---@return string string The value as a string
function sc.toString(value)
    if type(value) == "string" then return ""..value end
    if type(value) == "table" then return sc.table.toString(value, 1) end

    return type(value) == "nil" and "nil" or tostring(value)
end