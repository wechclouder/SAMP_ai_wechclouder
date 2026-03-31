script_name("AI Assistant")
script_author("season")

local http = require("socket.http")
local ltn12 = require("ltn12")
local samp = require("samp.events")

-- api аи сервера любого вставь пох типо
local API_URL = "http://127.0.0.1:3000/ai"

function main()
    while not isSampAvailable() do wait(100) end
    sampAddChatMessage("[AI] Готов 😈 пиши /ai текст", -1)
end

function samp.onSendChat(msg)
    if msg:sub(1,3) == "/ai" then
        local text = msg:sub(5)
        sendToAI(text)
        return false
    end
end

function sendToAI(text)
    lua_thread.create(function()
        local response_body = {}

        local res, code = http.request{
            url = API_URL,
            method = "POST",
            headers = {
                ["Content-Type"] = "application/json"
            },
            source = ltn12.source.string('{"message":"'..text..'"}'),
            sink = ltn12.sink.table(response_body)
        }

        if code == 200 then
            local result = table.concat(response_body)
            sampAddChatMessage("[AI] "..result, -1)
        else
            sampAddChatMessage("[AI] Ошибка", -1)
        end
    end)
end