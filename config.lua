-- Default language code
-- This will be used if the player's language is not available in the language files
-- Please refer to https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes for language codes
default_language = "en"

-- Load language file
local language_file = "language/" .. default_language .. ".lua"
local lang = assert(loadfile(language_file))()

-- Function to get localized string
function getLocalizedText(key)
    return lang[key] or key
end