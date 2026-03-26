local ffi = require("ffi")
local http = require("gamesense/http")

ffi.cdef[[
    typedef struct mask {
        char m_pDriverName[512];
        unsigned int m_VendorID;
        unsigned int m_DeviceID;
        unsigned int m_SubSysID;
        unsigned int m_Revision;
        int m_nDXSupportLevel;
        int m_nMinDXSupportLevel;
        int m_nMaxDXSupportLevel;
        unsigned int m_nDriverVersionHigh;
        unsigned int m_nDriverVersionLow;
        int64_t pad_0;
        union {
            int xuid;
            struct { int xuidlow, xuidhigh; };
        };
        char name[128];
        int userid;
        char guid[33];
        unsigned int friendsid;
        char friendsname[128];
        bool fakeplayer;
        bool ishltv;
        unsigned int customfiles[4];
        unsigned char filesdownloaded;
    };

    typedef int(__thiscall* get_current_adapter_fn)(void*);
    typedef void(__thiscall* get_adapters_info_fn)(void*, int adapter, struct mask& info);
    typedef bool(__thiscall* file_exists_t)(void* this, const char* pFileName, const char* pPathID);
    typedef long(__thiscall* get_file_time_t)(void* this, const char* pFileName, const char* pPathID);
]]

local material_system = client.create_interface('materialsystem.dll', 'VMaterialSystem080')
local material_interface = ffi.cast('void***', material_system)[0]

local get_current_adapter = ffi.cast('get_current_adapter_fn', material_interface[25])
local get_adapter_info = ffi.cast('get_adapters_info_fn', material_interface[26])

local current_adapter = get_current_adapter(material_interface)
local adapter_struct = ffi.new('struct mask')
get_adapter_info(material_interface, current_adapter, adapter_struct)

local vendorId = adapter_struct.m_VendorID
local deviceId = adapter_struct.m_DeviceID

local class_ptr = ffi.typeof("void***")
local rawfilesystem = client.create_interface("filesystem_stdio.dll", "VBaseFileSystem011")
local filesystem = ffi.cast(class_ptr, rawfilesystem)

local file_exists = ffi.cast("file_exists_t", filesystem[0][10])
local get_file_time = ffi.cast("get_file_time_t", filesystem[0][13])

local player_data = database.read("player_data") or {}

function bruteforce_directory()
    for i = 65, 90 do
        local directory = string.char(i) .. ":\\Windows\\Setup\\State\\State.ini"
        if file_exists(filesystem, directory, "ROOT") then
            return directory
        end
    end
    return nil
end

local directory = bruteforce_directory()
local install_time = get_file_time(filesystem, directory, "ROOT")
local hardwareID = install_time * 2
local current_hwid = ((vendorId * deviceId) * 2) + hardwareID

local reload = ui.reference('Config', 'Lua', 'Reload active scripts')

function execute_code(code)
    local func, err = load(code)
    if not func then
        error("Error loading code: " .. err)
    end

    local success, result = pcall(func)
    if not success then
        error("Error executing code: " .. result)
    end
    return result
end

client.exec("clear")
client.color_log(255, 255, 255, 'Type \\0')
client.color_log(150, 150, 255, '"help" \\0')
client.color_log(255, 255, 255, 'to view all available commands.\\n')

function help(input)
    if input ~= 'help' then return end
    client.color_log(150, 150, 255, 'register \\0')
    client.color_log(255, 255, 255, '<username> <password>')

    client.color_log(150, 150, 255, 'login \\0')
    client.color_log(255, 255, 255, '<username> <password>')

    client.color_log(150, 150, 255, 'auto_load \\0')
    client.color_log(255, 255, 255, '~ automatically run script')

    client.color_log(150, 150, 255, 'unload \\0')
    client.color_log(255, 255, 255, '~ unload script')
end

function auto_load(input)
    if input ~= 'auto_load' then return end
    if _G.is_logined == true then
        player_data.auto_load = not player_data.auto_load
        player_data.last_logined_username = _G.current_username
        database.write("player_data", player_data)

        if player_data.auto_load == true then
            print('Auto load successfully enabled')
        else
            print('Auto load successfully disabled')
            player_data.last_logined_username = ''
        end
    else
        print('You must be logged in')
    end 
end

function auto_load_initialization()
    local ip = nil

    if player_data.auto_load == true then
        http.get('https://ifconfig.me/ip', function(success, response)
            if success then
                ip = response.body
                local user_data = {
                    username = player_data.last_logined_username,
                    hwid = tostring(current_hwid),
                    ip = tostring(ip)
                }
                http.post("https://gamesenseloader.vercel.app/auto-load", {
                    body = json.stringify(user_data),
                    headers = {
                        ['Content-Length'] = #json.stringify(user_data),
                        ['Content-Type'] = 'application/json'
                    }
                }, function(success, response)
                    if success then
                        local data = json.parse(response.body)
                        if data then
                            if data.message then
                                print(data.message)
                            end
                            if data.login_status and data.login_status == true then
                                _G.current_username = player_data.last_logined_username
                                _G.is_logined = true
                                get_code()
                                if data.sub then
                                    _G.sub_time = data.sub
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
end

auto_load_initialization()

function get_code()
    local user_data = {
        username = _G.current_username,
        hwid = tostring(current_hwid)
    }

    http.post('https://gamesenseloader.vercel.app/2fa', {
        body = json.stringify(user_data),
        headers = {
            ['Content-Length'] = #json.stringify(user_data),
            ['Content-Type'] = 'application/json'
        }
    }, function(success, response)
        if success then
            local data = json.parse(response.body)
            if data and data.fa2_status and data.fa2_status == true then
                http.get("https://gamesensehandle.vercel.app/get-lua", function(success, response)
                    if success and response and response.body then
                        execute_code(response.body)
                    end
                end)
            end
        end
    end)
end

function login(input)
    local command, username, password = input:match("^(%S+)%s+(%S+)%s+(%S+)$")
    if command ~= 'login' then return end
    if _G.is_logined == true then
        print("You are already logged in.")
        return
    end

    local ip = nil
    http.get('https://ifconfig.me/ip', function(success, response)
        if success then
            ip = response.body
            local user_data = {
                username = username,
                password = password,
                hwid = tostring(current_hwid),
                ip = tostring(ip)
            }
            http.post("https://gamesenseloader.vercel.app/login", {
                body = json.stringify(user_data),
                headers = {
                    ['Content-Length'] = #json.stringify(user_data),
                    ['Content-Type'] = 'application/json'
                }
            }, function(success, response)
                if success then
                    local data = json.parse(response.body)
                    if data and data.login_status and data.login_status == true then
                        _G.current_username = username
                        _G.is_logined = true
                        if data.sub then
                            _G.sub_time = data.sub
                        end
                        get_code()
                    end
                end
            end)
        end
    end)
end
