local RIVALS = "https://raw.githubusercontent.com/larpingledger-star/virshub/main/games/rivals.lua"
local SAB = "https://raw.githubusercontent.com/larpingledger-star/virshub/main/games/steal-a-brainrot.lua"

local byGameId = {
    [6035872082] = RIVALS,
    [7709344486] = SAB,
}

local byPlaceId = {
    [17625359962] = RIVALS,
    [109983668079237] = SAB,
}

local gameId = game.GameId
while gameId == 0 and game.PlaceId == 0 do
    task.wait()
    gameId = game.GameId
end

local url = byGameId[gameId] or byPlaceId[game.PlaceId]
if not url then
    return
end

for _ = 1, 3 do
    local ok, source = pcall(game.HttpGet, game, url)
    if ok and type(source) == "string" and source ~= "" then
        local chunk = loadstring(source)
        if chunk then
            chunk()
        end
        return
    end
    task.wait(0.5)
end
