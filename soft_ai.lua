-- Başlangıç mesajı
local function print_welcome_message()
    -- Logo ve başlık
    client.color_log(255, 255, 255, "╔════════════════════════════════════════════════════════════╗")
    client.color_log(65, 105, 225, "                    Soft.AI Free Version                      ")
    client.color_log(138, 43, 226, "                     Coded by dope <3                        ")
    client.color_log(255, 255, 255, "╚════════════════════════════════════════════════════════════╝")
    client.color_log(255, 255, 255, "\n")
    
    -- Türkçe
    client.color_log(255, 0, 0, "▌ ")
    client.color_log(255, 255, 255, "Türkçe:")
    client.color_log(255, 255, 255, "Bu Lua tamamen ücretsiz bir versiyondur, para ile satın alınmaz.")
    client.color_log(255, 255, 255, "Şu anda kullanılan kod, ücretli versiyonun yaklaşık %8'i kadar işlevseldir.")
    client.color_log(255, 255, 255, "Yapay zeka hizmeti VDS'ye bağlıdır ve oyun verinizi burada biriktirir.")
    client.color_log(255, 255, 255, "Bu yüzden, bu Lua çok kapsamlı değildir.")
    client.color_log(255, 255, 255, "%100 performans almak için ufak bir miktar ile sahip olabilirsiniz.")
    client.color_log(70, 130, 180, "Sadece discord.gg/softai üzerinden alışveriş yapın ve olası bir sorunda oraya başvurun.")
    client.color_log(255, 255, 255, "\n")
    
    -- English
    client.color_log(0, 0, 255, "▌ ")
    client.color_log(255, 255, 255, "English:")
    client.color_log(255, 255, 255, "This Lua is a completely free version and cannot be purchased.")
    client.color_log(255, 255, 255, "The current code is about 8% as functional as the paid version.")
    client.color_log(255, 255, 255, "The AI service is VDS-based, and your game data is stored there.")
    client.color_log(255, 255, 255, "Therefore, this Lua is not very comprehensive.")
    client.color_log(255, 255, 255, "To get 100% performance, you can acquire it for a small fee.")
    client.color_log(70, 130, 180, "Only make purchases through discord.gg/softai and contact them in case of any issues.")
    client.color_log(255, 255, 255, "\n")
    
    -- Russian
    client.color_log(255, 215, 0, "▌ ")
    client.color_log(255, 255, 255, "Русский:")
    client.color_log(255, 255, 255, "Этот Lua — полностью бесплатная версия, её нельзя купить.")
    client.color_log(255, 255, 255, "Текущий код функционален примерно на 8% от платной версии.")
    client.color_log(255, 255, 255, "Сервис искусственного интеллекта работает на VDS, и ваши игровые данные сохраняются там.")
    client.color_log(255, 255, 255, "Поэтому этот Lua не является очень масштабным.")
    client.color_log(255, 255, 255, "Для получения 100% производительности можно приобрести за небольшую сумму.")
    client.color_log(70, 130, 180, "Покупки можно делать только через discord.gg/softai, и в случае проблем обращайтесь туда.")
    client.color_log(255, 255, 255, "\n")
    
    -- Alt çizgi
    client.color_log(255, 255, 255, "╔════════════════════════════════════════════════════════════╗")
    client.color_log(255, 255, 255, "╚════════════════════════════════════════════════════════════╝")
end

-- Script yüklendiğinde mesajı göster
print_welcome_message()

-- Temel menü öğeleri
local menu = {
    enable = ui.new_checkbox("RAGE", "Other", "Soft.AI Free"),
    resolver = ui.new_checkbox("RAGE", "Other", "Basic Resolver"),
    antiaim = ui.new_checkbox("AA", "Anti-aimbot angles", "Basic Anti-aim"),
    ai_assist = ui.new_checkbox("RAGE", "Other", "AI Assist")
}

-- Basit resolver sistemi
local resolver_data = {}

local function init_resolver_data(player)
    if not resolver_data[player] then
        resolver_data[player] = {
            missed_shots = 0,
            hit_shots = 0,
            last_angle = 0
        }
    end
end

local function basic_resolver(player)
    if not ui.get(menu.resolver) then return end
    
    init_resolver_data(player)
    local data = resolver_data[player]
    
    local yaw = entity.get_prop(player, "m_angEyeAngles[1]")
    if not yaw then return end
    
    -- Basit resolver mantığı
    local resolver_angle = 0
    if data.missed_shots > 2 then
        resolver_angle = 58
    elseif data.missed_shots > 1 then
        resolver_angle = -58
    end
    
    entity.set_prop(player, "m_angEyeAngles[1]", yaw + resolver_angle)
    data.last_angle = resolver_angle
end

-- Basit anti-aim sistemi
local function basic_antiaim()
    if not ui.get(menu.antiaim) then return end
    
    ui.set(ui.reference("AA", "Anti-aimbot angles", "Enabled"), true)
    ui.set(ui.reference("AA", "Anti-aimbot angles", "Pitch"), "Down")
    ui.set(ui.reference("AA", "Anti-aimbot angles", "Yaw base"), "At targets")
    ui.set(ui.reference("AA", "Anti-aimbot angles", "Yaw"), "180")
    ui.set(ui.reference("AA", "Anti-aimbot angles", "Yaw jitter"), "Random")
    ui.set(ui.reference("AA", "Anti-aimbot angles", "Body yaw"), "Static")
end

-- Basit watermark
local function render_watermark()
    local screen = {client.screen_size()}
    local text = "Soft.AI Free"
    
    -- Gölge efekti için siyah arka plan
    renderer.text(screen[1]/2 + 1, screen[2] - 19, 0, 0, 0, 255, "cb", 0, text)
    renderer.text(screen[1]/2 - 1, screen[2] - 21, 0, 0, 0, 255, "cb", 0, text)
    
    -- Ana metin (beyaz, bold)
    renderer.text(screen[1]/2, screen[2] - 20, 255, 255, 255, 255, "cb", 0, text)
end

-- Basit yapay zeka desteği
local function ai_assist()
    if not ui.get(menu.ai_assist) then return end
    
    local local_player = entity.get_local_player()
    if not local_player then return end
    
    local players = entity.get_players(true)
    local closest_enemy = nil
    local closest_distance = 999999
    
    -- En yakın düşmanı bul
    for i = 1, #players do
        local player = players[i]
        local origin = {entity.get_prop(player, "m_vecOrigin")}
        local my_origin = {entity.get_prop(local_player, "m_vecOrigin")}
        if origin and my_origin then
            local distance = math.sqrt((origin[1] - my_origin[1])^2 + (origin[2] - my_origin[2])^2 + (origin[3] - my_origin[3])^2)
            if distance < closest_distance then
                closest_enemy = player
                closest_distance = distance
            end
        end
    end
    
    if closest_enemy then
        -- Düşmanın hareketini tahmin et
        local velocity = {entity.get_prop(closest_enemy, "m_vecVelocity")}
        local position = {entity.get_prop(closest_enemy, "m_vecOrigin")}
        
        if velocity and position then
            -- Basit tahmin
            local predicted_x = position[1] + velocity[1] * 0.2
            local predicted_y = position[2] + velocity[2] * 0.2
            local predicted_z = position[3] + velocity[3] * 0.2
            
            -- Tahmin edilen konumu göster
            local predicted_screen_x, predicted_screen_y = renderer.world_to_screen(predicted_x, predicted_y, predicted_z)
            if predicted_screen_x and predicted_screen_y then
                -- Tahmin çemberi
                renderer.circle_outline(predicted_screen_x, predicted_screen_y, 255, 0, 0, 255, 10, 0, 1, 2)
                
                -- Tahmin noktası
                renderer.circle(predicted_screen_x, predicted_screen_y, 255, 255, 255, 255, 3, 0, 1)
                
                -- Mesafe bilgisi
                local distance_text = string.format("%.1f", closest_distance)
                renderer.text(predicted_screen_x, predicted_screen_y - 20, 255, 255, 255, 255, "c", 0, distance_text)
            end
        end
    end
end

-- Event callback'leri
client.set_event_callback("setup_command", function(cmd)
    if not ui.get(menu.enable) then return end
    
    -- Resolver
    local players = entity.get_players(true)
    for i = 1, #players do
        basic_resolver(players[i])
    end
    
    -- Anti-aim
    basic_antiaim()
    
    -- AI Assist
    ai_assist()
end)

client.set_event_callback("aim_miss", function(e)
    if not ui.get(menu.enable) or not ui.get(menu.resolver) then return end
    
    local data = resolver_data[e.target]
    if data then
        data.missed_shots = data.missed_shots + 1
    end
end)

client.set_event_callback("aim_hit", function(e)
    if not ui.get(menu.enable) or not ui.get(menu.resolver) then return end
    
    local data = resolver_data[e.target]
    if data then
        data.hit_shots = data.hit_shots + 1
        data.missed_shots = 0
    end
end)

client.set_event_callback("paint", function()
    render_watermark()
end)

-- Menü görünürlük kontrolü
local function handle_menu_visibility()
    local enabled = ui.get(menu.enable)
    ui.set_visible(menu.resolver, enabled)
    ui.set_visible(menu.antiaim, enabled)
    ui.set_visible(menu.ai_assist, enabled)
end

ui.set_callback(menu.enable, handle_menu_visibility)
handle_menu_visibility()
 