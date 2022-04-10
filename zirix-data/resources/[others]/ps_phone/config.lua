Config = {}

Config.Token         = ""
Config.LicenseKey    = ""
Config.RepeatTimeout = 2000
Config.CallRepeats   = 10
Config.OpenPhone     = "k"
Config.Webhook       = "https://discord.com/api/webhooks/845799272301723688/fk50gWl2pWOa-GMRazp4C4Nuh3Eiw_Az_YV-F5d99zwGlQZeZWifkRNOYMnJbJzuf6Fj"
Config.WebhookBank   = ""
Config.Field         = "files[]"
Config.VerifyItem    = true
Config.ItemPhone     = "celular-pro","celular"
Config.CallSystem    = "tokovoip" --tokovoip | mumblevoip | saltychat | pmavoice
Config.CheckLife     = 101
Config.IPAddress     = "http://127.0.0.1/"
Config.Permission    = "admin.permissao" -- Grupo de Permisssão para adicionar verificado
Config.NotifyAll     = true -- Ativar notificaçõpes globais no servidor
Config.AllPostsInsta = true -- Ativar todos os post dos instagram
Config.UseMoving     = true -- Usar o celular e andar
Config.NameVRPPlayer = "vrp_player" -- nome da vrp_player somente usado nas bases Summerz
Config.TablePlayerDB = "vrp_user_data" -- nome da vrp_user_data mudar somente se salvar em outro local
Config.Locale        = "br"
Config.ButtonDisable = { --https://docs.fivem.net/docs/game-references/controls/
    0,
    1,
    2,
    22, 
    24, 
    26, 
    36, 
    37, 
    60, 
    62, 
    106,
    114,
    121,
    140,
    141,
    142,
    199,
    245,
    257,
    263,
    264,
    309,
    331,
}

Config.HelpList = {
    ['policia'] = {
        name        = "Emergência",
        description = "LSPD",
        text        = "Chame uma Unidade movél",
        message     = "Descreva a situação:",
        emergency   = true,
        staff       = false,
        image       = "https://i.lcpdfrusercontent.com/screenshots/monthly_2020_07/271590_20200630222342_1.png.a17364b16fdc65230dace2ac5c95e808.png",
        style       = "top: 15px;",
        groups      = {
            "policia.permissao"
        }
    },
    ['ems'] = {
        name        = "Emergência",
        description = "Chame uma unidade móvel",
        text        = "Chame uma Unidade movél",
        message    = "Descreva a situação:",
        emergency   = true,
        staff       = false,
        image       = "https://gtapolicemods.com/uploads/monthly_2020_11/Rambulance.png.d24e5be1cafdffe6786dd1f8dcd64678.png",
        style       = "top: 230px;",
        groups      = {
            "ems.permissao"
        }
    },
    ['mecanico'] = {
        name        = "Los Santos Customs",
        description = "Chame um Mecânico(a)",
        text        = "Chame um profissional mais próximo",
        message     = "Descreva seu problema:",
        emergency   = false,
        staff       = false,
        image       = "https://img.gta5-mods.com/q75/images/legion-square-car-show-map-editor-menyoo/2b001e-3.jpg",
        style       = "top: 460px;",
        groups      = {
            "chamadosmec.permissao"
        }
    }
}

Config.NewsPermission = {
    "manager.permissao",
    "wazel.permissao"
}

Config.NewsAdvert = {
    title       = "Anuncie Aqui",
    description = "Anuncie seu serviço da cidade conosco da WAZEL",
    image       = "https://img.gta5-mods.com/q75/images/benny-s-tow-trucks-and-sast-tow-truck/4bcf6b-Screenshot(168).png"
}

Config.Client = {
    phone = "000-000",
    disabledApps = {}
}

Config.checkItemPhone = function(source, user_id, item)
    if checkIteminInvetory(user_id, item, 1) then
        return true
    else
        sendnotify(source,"negado",_("dont_have_cell"),5000)
        return false
    end
end

return Config