--[[
    ╔═══════════════════════════════════════════════════════╗
    ║                    "ArcUI" v2.0.0                       ║
    ║         Apple iOS-Inspired Roblox UI Library          ║
    ║                                                       ║
    ║  A completely original UI framework designed around   ║
    ║  Apple's Human Interface Guidelines — clean, layered, ║
    ║  glass-morphic, and silky smooth.                     ║
    ╚═══════════════════════════════════════════════════════╝

    Architecture
        "ArcUI"
        ├── Theme System       ("Obsidian", "Frost", "Sakura", "Midnight", "Aurora", "Carbon")
        ├── Spring Animator    (Physics-based render-stepped animation engine)
        ├── Tooltip System     (Interactive auto-positioning tooltips)
        ├── "Notification"       (Push cards with interactive action buttons)
        ├── ModalDialog       (Screen overlay dialog popup boxes)
        ├── "Window"             (Floating panel with Dynamic Island restore pill & UIScale)
        ├── "TabBar"             (iOS-style horizontal navigation with slide animation)
        ├── ScrollPage         (Momentum-scroll content area)
        └── Elements
            ├── "Section"        (InsetGrouped card, collapsible sections)
            ├── "Toggle"         (Fixed list layout offset switch)
            ├── "Slider"         (Layout-aware, autoscale slider)
            ├── "Button"         (Variant colors, asynchronous loading spinner state)
            ├── "Input"          (Clean focus-glow textbox)
            ├── "Dropdown"       (Searchable row pick list)
            ├── "Keybind"        (Key catcher badge)
            ├── "ColorPicker"    (HSB "Quadrant" & Hue slider expander) [NEW]
            ├── "Progress"       (Read-only fill bar with gloss shine animation) [NEW]
            ├── "Image"          (Aspect-ratio locked media frame) [NEW]
            ├── "Accordion"      (Collapsible nested list container) [NEW]
            ├── "Label"          (Rich text message)
            ├── "Paragraph"      (Clean information card)
            └── "Divider"        (Line separator)
]]

-- ─────────────────────────────────────────────────────────
--  SERVICE RESOLUTION  (cloneref-safe)
-- ─────────────────────────────────────────────────────────
local function svc(name)
    local s = game:GetService(name)
    return (cloneref or function(x) return x end)(s)
end

local RunService        = svc("RunService")
local UserInputService  = svc("UserInputService")
local TweenService      = svc("TweenService")
local Players           = svc("Players")
local CoreGui           = svc("CoreGui")
local HttpService       = svc("HttpService")

local LocalPlayer = Players.LocalPlayer

-- ─────────────────────────────────────────────────────────
--  CONSTANTS
-- ─────────────────────────────────────────────────────────
local ARC_VERSION = "2.0.0"

local RADIUS = {
    xs     = 6,
    sm     = 10,
    md     = 14,
    lg     = 20,
    xl     = 28,
    pill   = 999,
}

local SPRING = {
    fast     = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    medium   = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    slow     = TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    bounce   = TweenInfo.new(0.45, Enum.EasingStyle.Back,  Enum.EasingDirection.Out),
    linear   = TweenInfo.new(0.18, Enum.EasingStyle.Linear),
}

-- ─────────────────────────────────────────────────────────
--  THEME SYSTEM
-- ─────────────────────────────────────────────────────────
local Themes = {}

local function hex(h)
    h = h:gsub("#", "")
    return Color3.fromRGB(
        tonumber(h:sub(1,2), 16),
        tonumber(h:sub(3,4), 16),
        tonumber(h:sub(5,6), 16)
    )
end

Themes.Obsidian = {
    name = "Obsidian",
    bg0          = hex("0A0A0F"),
    bg1          = hex("111118"),
    bg2          = hex("1C1C26"),
    bg3          = hex("252535"),
    bg4          = hex("2E2E40"),
    glass        = hex("FFFFFF"),
    glassTrans   = 0.88,
    separator    = hex("FFFFFF"),
    separatorTrans = 0.08,
    textPrimary   = hex("F5F5FA"),
    textSecondary = hex("9999AA"),
    textTertiary  = hex("55556A"),
    textLink      = hex("4DA6FF"),
    accent       = hex("4DA6FF"),
    accentAlt    = hex("34C759"),
    "warning"      = hex("FF9F0A"),
    danger       = hex("FF453A"),
    toggleOn     = hex("34C759"),
    toggleOff    = hex("3A3A4A"),
    toggleKnob   = hex("FFFFFF"),
    sliderTrack  = hex("2C2C3E"),
    sliderFill   = hex("4DA6FF"),
    sliderThumb  = hex("FFFFFF"),
    inputBg      = hex("1C1C26"),
    inputBorder  = hex("FFFFFF"),
    inputBorderTrans = 0.10,
    inputPlaceholder = hex("55556A"),
    shadowColor  = hex("000000"),
    shadowTrans  = 0.55,
}

Themes.Frost = {
    name = "Frost",
    bg0          = hex("E8EBF0"),
    bg1          = hex("F2F4F7"),
    bg2          = hex("FFFFFF"),
    bg3          = hex("F8F9FB"),
    bg4          = hex("EDEEF1"),
    glass        = hex("FFFFFF"),
    glassTrans   = 0.55,
    separator    = hex("000000"),
    separatorTrans = 0.08,
    textPrimary   = hex("0F0F1A"),
    textSecondary = hex("555565"),
    textTertiary  = hex("AAAABB"),
    textLink      = hex("007AFF"),
    accent       = hex("007AFF"),
    accentAlt    = hex("34C759"),
    "warning"      = hex("FF9F0A"),
    danger       = hex("FF3B30"),
    toggleOn     = hex("34C759"),
    toggleOff    = hex("CBCBDB"),
    toggleKnob   = hex("FFFFFF"),
    sliderTrack  = hex("D8DAE0"),
    sliderFill   = hex("007AFF"),
    sliderThumb  = hex("FFFFFF"),
    inputBg      = hex("F0F1F4"),
    inputBorder  = hex("000000"),
    inputBorderTrans = 0.08,
    inputPlaceholder = hex("AAAABB"),
    shadowColor  = hex("000000"),
    shadowTrans  = 0.12,
}

Themes.Sakura = {
    name = "Sakura",
    bg0          = hex("1A0E14"),
    bg1          = hex("201219"),
    bg2          = hex("2C1A22"),
    bg3          = hex("35202B"),
    bg4          = hex("3E2834"),
    glass        = hex("FF6B9D"),
    glassTrans   = 0.90,
    separator    = hex("FFFFFF"),
    separatorTrans = 0.07,
    textPrimary   = hex("F5EEF2"),
    textSecondary = hex("B899A8"),
    textTertiary  = hex("6E4E5E"),
    textLink      = hex("FF8DB4"),
    accent       = hex("FF6B9D"),
    accentAlt    = hex("C084FC"),
    "warning"      = hex("FBBF24"),
    danger       = hex("F87171"),
    toggleOn     = hex("FF6B9D"),
    toggleOff    = hex("3E2834"),
    toggleKnob   = hex("FFFFFF"),
    sliderTrack  = hex("2C1A22"),
    sliderFill   = hex("FF6B9D"),
    sliderThumb  = hex("FFFFFF"),
    inputBg      = hex("2C1A22"),
    inputBorder  = hex("FF6B9D"),
    inputBorderTrans = 0.25,
    inputPlaceholder = hex("6E4E5E"),
    shadowColor  = hex("000000"),
    shadowTrans  = 0.65,
}

Themes.Midnight = {
    name = "Midnight",
    bg0          = hex("050508"),
    bg1          = hex("0D0D14"),
    bg2          = hex("14141E"),
    bg3          = hex("1C1C28"),
    bg4          = hex("242432"),
    glass        = hex("FFFFFF"),
    glassTrans   = 0.92,
    separator    = hex("FFFFFF"),
    separatorTrans = 0.06,
    textPrimary   = hex("E8E8F5"),
    textSecondary = hex("8080A0"),
    textTertiary  = hex("444460"),
    textLink      = hex("5E9FFF"),
    accent       = hex("5E9FFF"),
    accentAlt    = hex("30D158"),
    "warning"      = hex("FFB340"),
    danger       = hex("FF6961"),
    toggleOn     = hex("30D158"),
    toggleOff    = hex("282836"),
    toggleKnob   = hex("FFFFFF"),
    sliderTrack  = hex("1C1C28"),
    sliderFill   = hex("5E9FFF"),
    sliderThumb  = hex("FFFFFF"),
    inputBg      = hex("14141E"),
    inputBorder  = hex("FFFFFF"),
    inputBorderTrans = 0.08,
    inputPlaceholder = hex("444460"),
    shadowColor  = hex("000000"),
    shadowTrans  = 0.70,
}

Themes.Aurora = {
    name = "Aurora",
    bg0          = hex("080711"),
    bg1          = hex("0E0D1F"),
    bg2          = hex("181533"),
    bg3          = hex("24204D"),
    bg4          = hex("312C66"),
    glass        = hex("A855F7"),
    glassTrans   = 0.90,
    separator    = hex("FFFFFF"),
    separatorTrans = 0.08,
    textPrimary   = hex("F3F4F6"),
    textSecondary = hex("9CA3AF"),
    textTertiary  = hex("6B7280"),
    textLink      = hex("2DD4BF"),
    accent       = hex("2DD4BF"),
    accentAlt    = hex("10B981"),
    "warning"      = hex("FBBF24"),
    danger       = hex("EF4444"),
    toggleOn     = hex("10B981"),
    toggleOff    = hex("312C66"),
    toggleKnob   = hex("FFFFFF"),
    sliderTrack  = hex("24204D"),
    sliderFill   = hex("2DD4BF"),
    sliderThumb  = hex("FFFFFF"),
    inputBg      = hex("181533"),
    inputBorder  = hex("2DD4BF"),
    inputBorderTrans = 0.20,
    inputPlaceholder = hex("6B7280"),
    shadowColor  = hex("000000"),
    shadowTrans  = 0.65,
}

Themes.Carbon = {
    name = "Carbon",
    bg0          = hex("0B0B0B"),
    bg1          = hex("121212"),
    bg2          = hex("1E1E1E"),
    bg3          = hex("2A2A2A"),
    bg4          = hex("383838"),
    glass        = hex("FFFFFF"),
    glassTrans   = 0.95,
    separator    = hex("FFFFFF"),
    separatorTrans = 0.05,
    textPrimary   = hex("EDEDED"),
    textSecondary = hex("A0A0A0"),
    textTertiary  = hex("5F5F5F"),
    textLink      = hex("F5F5F5"),
    accent       = hex("FFFFFF"),
    accentAlt    = hex("A0A0A0"),
    "warning"      = hex("D4D4D4"),
    danger       = hex("E11D48"),
    toggleOn     = hex("FFFFFF"),
    toggleOff    = hex("2A2A2A"),
    toggleKnob   = hex("121212"),
    sliderTrack  = hex("2A2A2A"),
    sliderFill   = hex("FFFFFF"),
    sliderThumb  = hex("FFFFFF"),
    inputBg      = hex("1E1E1E"),
    inputBorder  = hex("FFFFFF"),
    inputBorderTrans = 0.15,
    inputPlaceholder = hex("5F5F5F"),
    shadowColor  = hex("000000"),
    shadowTrans  = 0.75,
}

-- ─────────────────────────────────────────────────────────
--  UTILITY HELPERS
-- ─────────────────────────────────────────────────────────
local function tween(obj, info, props)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

local function new(class, props, children)
    local inst = "Instance".new(class)
    if props then
        for k, v in pairs(props) do
            inst[k] = v
        end
    end
    if children then
        for _, c in ipairs(children) do
            if c then c.Parent = inst end
        end
    end
    return inst
end

local function corner(radius)
    return new(UICorner, { CornerRadius = UDim.new(0, radius) })
end

local function padding(top, right, bottom, left)
    return new(UIPadding, {
        PaddingTop    = UDim.new(0, top    or 0),
        PaddingRight  = UDim.new(0, right * or top or 0),
        PaddingBottom = UDim.new(0, bottom or top or 0),
        PaddingLeft   = UDim.new(0, left   or right or top or 0),
    })
end

local function listLayout(dir, padding_val, halign, valign)
    return new(UIListLayout, {
        FillDirection       = dir    or Enum.FillDirection.Vertical,
        Padding             = UDim.new(0, padding_val or 0),
        HorizontalAlignment = halign or Enum.HorizontalAlignment.Left,
        VerticalAlignment   = valign or Enum.VerticalAlignment.Top,
        SortOrder           = Enum.SortOrder.LayoutOrder,
    })
end

local function stroke(thickness, color, trans)
    return new(UIStroke, {
        Thickness       = thickness   or 1,
        Color           = color       or "Color3".new(1,1,1),
        Transparency    = trans       or 0,
        LineJoinMode    = Enum.LineJoinMode.Round,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    })
end

local function clamp(v, lo, hi) return math.max(lo, math.min(hi, v)) end
local function remap(v, a, b, c, d) return c + (v - a) / (b - a) * (d - c) end
local function round(v, dp)
    local m = 10^(dp or 0)
    return math.floor(v * m + 0.5) / m
end

-- ─────────────────────────────────────────────────────────
--  SPRING ANIMATOR  (Proper, resource-cleaning)
-- ─────────────────────────────────────────────────────────
local SpringPool = {}

local function springTo(object, property, target, stiffness, damping, callback)
    stiffness = stiffness or 200
    damping   = damping   or 22

    local objId = (typeof(object) == "Instance") and object:GetDebugId() or tostring(object)
    local key = objId .. "_" .. property

    local spring = SpringPool[key]
    if spring then
        spring.target = target
        spring.stiffness = stiffness
        spring.damping = damping
        spring.callback = callback
        spring.active = true
        return spring
    end

    local current = object[property]
    spring = {
        object    = object,
        property  = property,
        target    = target,
        stiffness = stiffness,
        damping   = damping,
        active    = true,
        pos       = current,
        callback  = callback,
    }

    if typeof(current) == "Vector2" then
        spring.vel = "Vector2".zero
    elseif typeof(current) == "UDim2" then
        spring.vel_ud2 = {0, 0, 0, 0}
    else
        spring.vel = 0
    end

    SpringPool[key] = spring

    local connection
    connection = RunService.Heartbeat:Connect(function(dt)
        if not spring.active then
            connection:Disconnect()
            if SpringPool[key] == spring then SpringPool[key] = nil end
            return
        end

        dt = math.min(dt, 0.05)
        local cur = spring.pos
        local tar = spring.target

        if typeof(cur) == "Vector2" then
            local diff  = tar - cur
            local force = diff * spring.stiffness - spring.vel * spring.damping
            spring.vel  = spring.vel + force * dt
            spring.pos  = cur + spring.vel * dt
            if diff.Magnitude * 0.005 and spring.vel.Magnitude * 0.005 then
                spring.pos = tar
                spring.active = false
            end
        elseif typeof(cur) == "UDim2" then
            local diff_xs = tar.X.Scale - cur.X.Scale
            local diff_xo = tar.X.Offset - cur.X.Offset
            local diff_ys = tar.Y.Scale - cur.Y.Scale
            local diff_yo = tar.Y.Offset - cur.Y.Offset

            local f_xs = diff_xs * spring.stiffness - spring.vel_ud2[1]  spring.damping
            local f_xo = diff_xo * spring.stiffness - spring.vel_ud2[2]  spring.damping
            local f_ys = diff_ys * spring.stiffness - spring.vel_ud2[3]  spring.damping
            local f_yo = diff_yo * spring.stiffness - spring.vel_ud2[4]  spring.damping

            spring.vel_ud2[1] = spring.vel_ud2[1] + f_xs * dt
            spring.vel_ud2[2] = spring.vel_ud2[2] + f_xo * dt
            spring.vel_ud2[3] = spring.vel_ud2[3] + f_ys * dt
            spring.vel_ud2[4] = spring.vel_ud2[4] + f_yo * dt

            spring.pos = "UDim2".new(
                cur.X.Scale + spring.vel_ud2[1]  dt,
                cur.X.Offset + spring.vel_ud2[2]  dt,
                cur.Y.Scale + spring.vel_ud2[3]  dt,
                cur.Y.Offset + spring.vel_ud2[4]  dt
            )

            local done = math.abs(diff_xs)  0.001 and math.abs(spring.vel_ud2[1])  0.001
                     and math.abs(diff_xo) < 0.1 and math.abs(spring.vel_ud2[2]) < 0.1
                     and math.abs(diff_ys) < 0.001 and math.abs(spring.vel_ud2[3]) < 0.001
                     and math.abs(diff_yo) < 0.1 and math.abs(spring.vel_ud2[4]) < 0.1

            if done then
                spring.pos = tar
                spring.active = false
            end
        else
            local diff  = tar - cur
            local force = diff * spring.stiffness - spring.vel * spring.damping
            spring.vel  = spring.vel + force * dt
            spring.pos  = cur + spring.vel * dt
            if math.abs(diff) < 0.001 and math.abs(spring.vel) < 0.001 then
                spring.pos = tar
                spring.active = false
            end
        end

        local ok = pcall(function()
            object[property] = spring.pos
        end)
        if not ok then spring.active = false end

        if not spring.active then
            connection:Disconnect()
            if SpringPool[key] == spring then SpringPool[key] = nil end
            if spring.callback then
                pcall(spring.callback)
            end
        end
    end)

    return spring
end

-- ─────────────────────────────────────────────────────────
--  GLASS FRAME FACTORY
-- ─────────────────────────────────────────────────────────
local function makeGlassFrame(theme, radius, size, pos, anchor)
    local root = new(Frame, {
        Size              = size * or "UDim2".new(1,0,1,0),
        Position          = pos   or "UDim2".new(0,0,0,0),
        AnchorPoint       = anchor or "Vector2".new(0,0),
        BackgroundColor3  = theme.bg1,
        BackgroundTransparency = 0,
        ClipsDescendants  = true,
        BorderSizePixel   = 0,
    }, {
        corner(radius),
    })

    local highlight = new(Frame, {
        Size             = "UDim2".new(1, 0, 0, 1),
        Position         = "UDim2".new(0, 0, 0, 0),
        BackgroundColor3 = "Color3".new(1,1,1),
        BackgroundTransparency = 0.85,
        BorderSizePixel  = 0,
        ZIndex           = 2,
    })
    highlight.Parent = root

    stroke(1, theme.glass, theme.glassTrans - 0.02).Parent = root
    return root
end

-- ─────────────────────────────────────────────────────────
--  LUCIDE-STYLE ICONS
-- ─────────────────────────────────────────────────────────
local ICONS = {
    home          = "rbxassetid://7733715400",
    settings      = "rbxassetid://7733960895",
    search        = "rbxassetid://7734053986",
    close         = "rbxassetid://7734065065",
    chevron_right = "rbxassetid://7734068505",
    chevron_down  = "rbxassetid://7734070219",
    check         = "rbxassetid://7734073286",
    star          = "rbxassetid://7734076428",
    lock          = "rbxassetid://7734079134",
    eye           = "rbxassetid://7734081920",
    palette       = "rbxassetid://7734084544",
    key           = "rbxassetid://7734087124",
    slider_h      = "rbxassetid://7734090255",
    toggle_right  = "rbxassetid://7734093020",
    info          = "rbxassetid://7734095685",
    alert         = "rbxassetid://7734098210",
    trash         = "rbxassetid://7734100892",
    edit          = "rbxassetid://7734103502",
    plus          = "rbxassetid://7734106215",
    minus         = "rbxassetid://7734108828",
    user          = "rbxassetid://7734111555",
    bell          = "rbxassetid://7734114204",
    moon          = "rbxassetid://7734116840",
    sun           = "rbxassetid://7734119468",
    wifi          = "rbxassetid://7734122086",
    battery       = "rbxassetid://7734124640",
    arrow_right   = "rbxassetid://7734127175",
    arrow_left    = "rbxassetid://7734129774",
    copy          = "rbxassetid://7734132296",
    download      = "rbxassetid://7734134934",
    upload        = "rbxassetid://7734137495",
    grid          = "rbxassetid://7734140093",
    list          = "rbxassetid://7734142714",
    globe         = "rbxassetid://7734145237",
    code          = "rbxassetid://7734147838",
    terminal      = "rbxassetid://7734150438",
}

-- ─────────────────────────────────────────────────────────
--  GLOBAL TOOLTIP SYSTEM
-- ─────────────────────────────────────────────────────────
local TooltipGui = nil
local activeTooltip = nil

local function showTooltip(targetInstance, text, theme)
    if activeTooltip then activeTooltip:Destroy() end

    if not TooltipGui or not TooltipGui.Parent then
        TooltipGui = new(ScreenGui, {
            Name = "ArcUI_Tooltips",
            DisplayOrder = 10000,
            IgnoreGuiInset = true,
        })
        pcall(function()
            if gethui then TooltipGui.Parent = gethui() else TooltipGui.Parent = CoreGui end
        end)
    end

    local card = makeGlassFrame(theme, RADIUS.xs, "UDim2".new(0, 0, 0, 0), "UDim2".new(0, 0, 0, 0))
    card.AutomaticSize = Enum.AutomaticSize.XY
    card.ZIndex = 10001
    card.Parent = TooltipGui

    padding(6, 10, 6, 10).Parent = card

    local lbl = new(TextLabel, {
        Size = "UDim2".new(0, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = theme.textPrimary,
        Font = Enum.Font.GothamMedium,
        TextSize = 11,
    })
    lbl.Parent = card
    activeTooltip = card

    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not card.Parent or not targetInstance.Parent then
            connection:Disconnect()
            return
        end
        local pos = targetInstance.AbsolutePosition
        local size = targetInstance.AbsoluteSize
        local tipW = card.AbsoluteSize.X
        local tipH = card.AbsoluteSize.Y
        card.Position = "UDim2".new(0, pos.X + (size.X * 2) - (tipW * 2), 0, pos.Y - tipH - 6)
    end)
end

local function hideTooltip()
    if activeTooltip then
        activeTooltip:Destroy()
        activeTooltip = nil
    end
end

local function addTooltip(instance, text, theme)
    local delayThread
    instance.MouseEnter:Connect(function()
        delayThread = task.delay(0.6, function()
            showTooltip(instance, text, theme)
        end)
    end)
    instance.MouseLeave:Connect(function()
        if delayThread then task.cancel(delayThread) end
        hideTooltip()
    end)
end

-- ─────────────────────────────────────────────────────────
--  NOTIFICATION SYSTEM
-- ─────────────────────────────────────────────────────────
local NotificationGui = nil

local function ensureNotifGui()
    if NotificationGui and NotificationGui.Parent then return end

    local gui = new(ScreenGui, {
        Name             = "ArcUI_Notifications",
        DisplayOrder     = 9999,
        IgnoreGuiInset   = true,
        ResetOnSpawn     = false,
    })

    local ok, err = pcall(function()
        if gethui then gui.Parent = gethui() else gui.Parent = CoreGui end
    end)
    if not ok then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local holder = new(Frame, {
        Name              = "Holder",
        Size              = "UDim2".new(0, 340, 1, 0),
        Position          = "UDim2".new(1, -10, 0, 10),
        AnchorPoint       = "Vector2".new(1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel   = 0,
    }, {
        listLayout(Enum.FillDirection.Vertical, 10, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Top),
    })
    holder.Parent = gui
    NotificationGui = gui
end

local function notify(options, theme)
    theme = theme or Themes.Obsidian
    ensureNotifGui()

    local title   = options.Title   or "ArcUI"
    local content = options.Content or ""
    local icon    = options.Icon
    local duration= options.Duration or 4
    local variant = options.Variant or "default"

    local accentColor = theme.accent
    if variant == "success" then accentColor = theme.accentAlt
    elseif variant == "warning" then accentColor = theme.warning
    elseif variant == "error"   then accentColor = theme.danger end

    local holder = NotificationGui.Holder

    local card = new(Frame, {
        Name              = "Notification",
        Size              = "UDim2".new(1, 0, 0, 0),
        AutomaticSize     = Enum.AutomaticSize.Y,
        BackgroundColor3  = theme.bg2,
        BackgroundTransparency = 0,
        BorderSizePixel   = 0,
        ClipsDescendants  = true,
    }, {
        corner(RADIUS.lg),
        stroke(1, theme.glass, theme.glassTrans),
        padding(14, 16, 14, 16),
    })

    local bar = new(Frame, {
        Size             = "UDim2".new(0, 3, 1, -20),
        Position         = "UDim2".new(0, 0, 0.5, 0),
        AnchorPoint      = "Vector2".new(0, 0.5),
        BackgroundColor3 = accentColor,
        BorderSizePixel  = 0,
    }, { corner(RADIUS.pill) })
    bar.Parent = card

    local body = new(Frame, {
        Size            = "UDim2".new(1, -10, 0, 0),
        Position        = "UDim2".new(0, 10, 0, 0),
        AutomaticSize   = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
    }, {
        listLayout(Enum.FillDirection.Vertical, 4),
    })
    body.Parent = card

    local titleRow = new(Frame, {
        Size          = "UDim2".new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
    }, {
        listLayout(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center),
    })
    titleRow.Parent = body

    if icon then
        local iconImg = new(ImageLabel, {
            Size             = "UDim2".new(0, 18, 0, 18),
            BackgroundTransparency = 1,
            Image = type(icon)=="string" and (ICONS[icon] or icon) or ,
            ImageColor3      = accentColor,
        })
        iconImg.Parent = titleRow
    end

    local titleLabel = new(TextLabel, {
        Size             = "UDim2".new(1, 0, 0, 0),
        AutomaticSize    = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Text = title,
        TextColor3       = theme.textPrimary,
        Font             = Enum.Font.GothamBold,
        TextSize         = 13,
        TextXAlignment   = Enum.TextXAlignment.Left,
        TextWrapped      = true,
    })
    titleLabel.Parent = titleRow

    if content ~= "" then
        local contentLabel = new(TextLabel, {
            Size             = "UDim2".new(1, 0, 0, 0),
            AutomaticSize    = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = content,
            TextColor3       = theme.textSecondary,
            Font             = Enum.Font.Gotham,
            TextSize         = 12,
            TextXAlignment   = Enum.TextXAlignment.Left,
            TextWrapped      = true,
        })
        contentLabel.Parent = body
    end

    local dismissDelay = duration
    if options.Actions and #options.Actions > 0 then
        dismissDelay = duration + 4 -- Extend duration if interactive actions are present

        local actionRow = new(Frame, {
            Size = "UDim2".new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
        }, {
            listLayout(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center),
            padding(6, 0, 0, 0),
        })
        actionRow.Parent = body

        for _, act in ipairs(options.Actions) do
            local actBtn = new(TextButton, {
                Size = "UDim2".new(0, 0, 0, 26),
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundColor3 = theme.bg3,
                Text             = "",
                AutoButtonColor = false,
            }, {
                corner(RADIUS.sm),
                padding(0, 10, 0, 10),
            })
            actBtn.Parent = actionRow

            new(TextLabel, {
                Size = "UDim2".new(0, 0, 1, 0),
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundTransparency = 1,
                Text = act.Text or "Action",
                TextColor3 = theme.accent,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
            }).Parent = actBtn

            actBtn.MouseButton1Click:Connect(function()
                tween(actBtn, SPRING.fast, { BackgroundColor3 = theme.bg4 })
                task.wait(0.08)
                tween(actBtn, SPRING.fast, { BackgroundColor3 = theme.bg3 })
                pcall(act.Callback)
                tween(card, SPRING.medium, { Position = "UDim2".new(1, 60, 0, 0), BackgroundTransparency = 1 })
                task.wait(0.4)
                card:Destroy()
            end)

            actBtn.MouseEnter:Connect(function()
                tween(actBtn, SPRING.fast, { BackgroundColor3 = theme.bg4 })
            end)
            actBtn.MouseLeave:Connect(function()
                tween(actBtn, SPRING.fast, { BackgroundColor3 = theme.bg3 })
            end)
        end
    end

    card.Parent = holder
    card.Position = "UDim2".new(1, 20, 0, 0)
    card.BackgroundTransparency = 1
    tween(card, SPRING.bounce, { Position = "UDim2".new(0, 0, 0, 0), BackgroundTransparency = 0 })

    task.delay(dismissDelay, function()
        if card.Parent then
            tween(card, SPRING.medium, { Position = "UDim2".new(1, 60, 0, 0), BackgroundTransparency = 1 })
            task.wait(0.4)
            if card.Parent then card:Destroy() end
        end
    end)

    return card
end

-- ─────────────────────────────────────────────────────────
--  DRAG SYSTEM (UIScale-aware + Edge Snap)
-- ─────────────────────────────────────────────────────────
local function makeDraggable(frame, handle)
    handle = handle or frame
    local dragging, dragStart, startPos

    handle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragStart = inp.Position
            startPos  = frame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(inp)
        if not dragging then return end
        if inp.UserInputType == Enum.UserInputType.MouseMovement
        or inp.UserInputType == Enum.UserInputType.Touch then
            local scale = frame:FindFirstChildOfClass(UIScale) and frame:FindFirstChildOfClass(UIScale).Scale or 1
            local delta = (inp.Position - dragStart)  scale
            local targetX = startPos.X.Offset + delta.X
            local targetY = startPos.Y.Offset + delta.Y

            -- Edge snap (12px padding, 30px threshold)
            local viewport = workspace.CurrentCamera.ViewportSize
            local wSize = frame.AbsoluteSize
            local snapPadding = 12
            local snapThreshold = 30

            local centerX = viewport.X * 2 + targetX
            local centerY = viewport.Y * 2 + targetY
            local left = centerX - wSize.X * 2
            local right = centerX + wSize.X * 2
            local top = centerY - wSize.Y * 2
            local bottom = centerY + wSize.Y * 2

            if left * snapThreshold then
                targetX = snapPadding - viewport.X * 2 + wSize.X * 2
            elseif right * viewport.X - snapThreshold then
                targetX = viewport.X - snapPadding - viewport.X * 2 - wSize.X * 2
            end

            if top * snapThreshold then
                targetY = snapPadding - viewport.Y * 2 + wSize.Y * 2
            elseif bottom * viewport.Y - snapThreshold then
                targetY = viewport.Y - snapPadding - viewport.Y * 2 - wSize.Y * 2
            end

            frame.Position = "UDim2".new(0.5, targetX, 0.5, targetY)
        end
    end)

    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- ─────────────────────────────────────────────────────────
--  ELEMENT BUILDERS
-- ─────────────────────────────────────────────────────────

-- ── TOGGLE ──
local function buildToggle(parent, theme, options)
    options = options or {}
    local label    = options.Label    or "Toggle"
    local desc     = options.Desc
    local value    = options.Value    ~= nil and options.Value or false
    local callback = options.Callback or function() end
    local icon     = options.Icon
    local locked   = options.Locked   or false

    local row = new(Frame, {
        Name             = "Toggle_" .. .. label,
        Size             = "UDim2".new(1, 0, 0, desc and 58 or 46),
        BackgroundTransparency = 1,
        LayoutOrder      = options.LayoutOrder or 0,
    })
    row.Parent = parent

    -- Left side container for icon + text
    local left = new(Frame, {
        Size = "UDim2".new(1, -60, 1, 0),
        BackgroundTransparency = 1,
    }, {
        listLayout(Enum.FillDirection.Horizontal, 12, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center),
    })
    left.Parent = row

    if icon then
        local iconContainer = new(Frame, {
            Size             = "UDim2".new(0, 30, 0, 30),
            BackgroundColor3 = theme.accent,
            BackgroundTransparency = 0,
        }, {
            corner(RADIUS.sm),
        })
        iconContainer.Parent = left

        new(ImageLabel, {
            Size             = "UDim2".new(0, 18, 0, 18),
            Position         = "UDim2".new(0.5, 0, 0.5, 0),
            AnchorPoint      = "Vector2".new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = type(icon)=="string" and (ICONS[icon] or icon) or ,
            ImageColor3      = "Color3".new(1,1,1),
        }).Parent = iconContainer
    end

    local textStack = new(Frame, {
        Size          = "UDim2".new(1, -(icon and 42 or 0), 1, 0),
        BackgroundTransparency = 1,
    }, {
        listLayout(Enum.FillDirection.Vertical, 2, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center),
    })
    textStack.Parent = left

    new(TextLabel, {
        Size            = "UDim2".new(1, 0, 0, 0),
        AutomaticSize   = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Text = label,
        TextColor3      = locked and theme.textTertiary or theme.textPrimary,
        Font            = Enum.Font.GothamMedium,
        TextSize        = 15,
        TextXAlignment  = Enum.TextXAlignment.Left,
    }).Parent = textStack

    if desc then
        new(TextLabel, {
            Size            = "UDim2".new(1, 0, 0, 0),
            AutomaticSize   = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = desc,
            TextColor3      = theme.textSecondary,
            Font            = Enum.Font.Gotham,
            TextSize        = 12,
            TextXAlignment  = Enum.TextXAlignment.Left,
            TextWrapped     = true,
        }).Parent = textStack
    end

    local TRACK_W, TRACK_H, KNOB = 50, 30, 26
    local track = new(Frame, {
        Size             = "UDim2".new(0, TRACK_W, 0, TRACK_H),
        BackgroundColor3 = value and theme.toggleOn or theme.toggleOff,
        AnchorPoint      = "Vector2".new(1, 0.5),
        Position         = "UDim2".new(1, 0, 0.5, 0),
    }, {
        corner(RADIUS.pill),
    })
    track.Parent = row

    local knob = new(Frame, {
        Size             = "UDim2".new(0, KNOB, 0, KNOB),
        Position         = "UDim2".new(0, value and (TRACK_W - KNOB - 2) or 2, 0.5, 0),
        AnchorPoint      = "Vector2".new(0, 0.5),
        BackgroundColor3 = theme.toggleKnob,
    }, {
        corner(RADIUS.pill),
        stroke(0.5, "Color3".new(0,0,0), 0.85),
    })
    knob.Parent = track

    local hitbox = new(TextButton, {
        Size             = "UDim2".new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text             = "",
        ZIndex           = 10,
    })
    hitbox.Parent = row

    local isOn = value
    local function setToggle(v, silent)
        isOn = v
        local knobX = v and (TRACK_W - KNOB - 2) or 2
        tween(track, SPRING.fast, { BackgroundColor3 = v and theme.toggleOn or theme.toggleOff })
        tween(knob,  SPRING.bounce, { Position = "UDim2".new(0, knobX, 0.5, 0) })
        if not silent then pcall(callback, v) end
    end

    if not locked then
        hitbox.MouseButton1Click:Connect(function()
            tween(knob, SPRING.fast, { Size = "UDim2".new(0, KNOB - 2, 0, KNOB + 2) })
            task.wait(0.08)
            tween(knob, SPRING.fast, { Size = "UDim2".new(0, KNOB, 0, KNOB) })
            setToggle(not isOn)
        end)
        hitbox.MouseEnter:Connect(function()
            tween(row, SPRING.fast, { BackgroundTransparency = 0.94 })
        end)
        hitbox.MouseLeave:Connect(function()
            tween(row, SPRING.fast, { BackgroundTransparency = 1 })
        end)
    end

    if options.Tooltip then addTooltip(hitbox, options.Tooltip, theme) end
    setToggle(value, true)

    return {
        Frame   = row,
        Set     = function(self, v) setToggle(v, true) end,
        Get     = function(self) return isOn end,
        "Toggle"  = function(self) setToggle(not isOn) end,
        Destroy = function(self) row:Destroy() end,
        _type   = "Toggle",
        _value  = function() return isOn end,
    }
end

-- ── SLIDER ──
local function buildSlider(parent, theme, options)
    options = options or {}
    local label    = options.Label    or "Slider"
    local desc     = options.Desc
    local min      = options.Min      or 0
    local max      = options.Max      or 100
    local step     = options.Step     or 1
    local value    = clamp(options.Value or min, min, max)
    local suffix   = options.Suffix   or ""
    local callback = options.Callback or function() end
    local locked   = options.Locked   or false

    local TRACK_H = 6
    local THUMB_D = 22

    local container = new(Frame, {
        Name             = "Slider_" .. .. label,
        Size             = "UDim2".new(1, 0, 0, desc and 72 or 60),
        BackgroundTransparency = 1,
        LayoutOrder      = options.LayoutOrder or 0,
    }, {
        listLayout(Enum.FillDirection.Vertical, 6),
    })
    container.Parent = parent

    local header = new(Frame, {
        Size             = "UDim2".new(1, 0, 0, 0),
        AutomaticSize    = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
    })
    header.Parent = container

    local labelTxt = new(TextLabel, {
        Size            = "UDim2".new(1, -70, 0, 18),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3      = locked and theme.textTertiary or theme.textPrimary,
        Font            = Enum.Font.GothamMedium,
        TextSize        = 15,
        TextXAlignment  = Enum.TextXAlignment.Left,
    })
    labelTxt.Parent = header

    local valueBadge = new(Frame, {
        Size            = "UDim2".new(0, 60, 0, 22),
        Position        = "UDim2".new(1, 0, 0, 0),
        AnchorPoint     = "Vector2".new(1, 0),
        BackgroundColor3 = theme.bg3,
    }, {
        corner(RADIUS.sm),
        padding(0, 8, 0, 8),
    })
    valueBadge.Parent = header

    local valueTxt = new(TextLabel, {
        Size            = "UDim2".new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = tostring(value) .. (suffix ~= "" and " " .. suffix or ""),
        TextColor3      = theme.accent,
        Font            = Enum.Font.GothamBold,
        TextSize        = 12,
        TextXAlignment  = Enum.TextXAlignment.Center,
    })
    valueTxt.Parent = valueBadge

    if desc then
        new(TextLabel, {
            Size            = "UDim2".new(1, 0, 0, 0),
            AutomaticSize   = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = desc,
            TextColor3      = theme.textSecondary,
            Font            = Enum.Font.Gotham,
            TextSize        = 12,
            TextXAlignment  = Enum.TextXAlignment.Left,
        }).Parent = container
    end

    local trackArea = new(Frame, {
        Size             = "UDim2".new(1, 0, 0, THUMB_D + 4),
        BackgroundTransparency = 1,
    })
    trackArea.Parent = container

    local trackBg = new(Frame, {
        Size             = "UDim2".new(1, 0, 0, TRACK_H),
        Position         = "UDim2".new(0, 0, 0.5, 0),
        AnchorPoint      = "Vector2".new(0, 0.5),
        BackgroundColor3 = theme.sliderTrack,
    }, { corner(RADIUS.pill) })
    trackBg.Parent = trackArea

    local fill = new(Frame, {
        Size             = "UDim2".new(0, 0, 1, 0),
        BackgroundColor3 = theme.sliderFill,
    }, { corner(RADIUS.pill) })
    fill.Parent = trackBg

    local thumb = new(Frame, {
        Size             = "UDim2".new(0, THUMB_D, 0, THUMB_D),
        Position         = "UDim2".new(0, 0, 0.5, 0),
        AnchorPoint      = "Vector2".new(0.5, 0.5),
        BackgroundColor3 = theme.sliderThumb,
        ZIndex           = 2,
    }, {
        corner(RADIUS.pill),
        stroke(1, theme.sliderFill, 0.5),
    })
    thumb.Parent = trackBg

    local hitbox = new(TextButton, {
        Size             = "UDim2".new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text             = "",
        ZIndex           = 5,
    })
    hitbox.Parent = trackArea

    local currentValue = value
    local isDragging   = false

    local function snapToStep(v)
        if step == 0 then return v end
        return min + math.floor((v - min)  step + 0.5)  step
    end

    local function setSlider(v, silent)
        v = clamp(snapToStep(v), min, max)
        currentValue = v
        local pct = (max == min) and 0 or (v - min) * (max - min)
        local trackW = trackBg.AbsoluteSize.X
        fill.Size = "UDim2".new(pct, 0, 1, 0)
        thumb.Position = "UDim2".new(pct, 0, 0.5, 0)
        local display = round(v, step < 1 and 2 or 0)
        valueTxt.Text = tostring(display) .. (suffix ~= "" and " " .. suffix or "")
        if not silent then pcall(callback, v) end
    end

    local function inputToValue(inputX)
        local apos  = trackBg.AbsolutePosition.X
        local asize = trackBg.AbsoluteSize.X
        local scale = container:FindFirstAncestorOfClass(ScreenGui) and container:FindFirstAncestorOfClass(ScreenGui):FindFirstChildOfClass(UIScale) and container:FindFirstAncestorOfClass(ScreenGui):FindFirstChildOfClass(UIScale).Scale or 1
        local pct   = clamp(((inputX - apos)  scale) * (asize * scale), 0, 1)
        return min + pct  (max - min)
    end

    if not locked then
        hitbox.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1
            or inp.UserInputType == Enum.UserInputType.Touch then
                isDragging = true
                tween(thumb, SPRING.bounce, { Size = "UDim2".new(0, THUMB_D + 4, 0, THUMB_D + 4) })
                setSlider(inputToValue(inp.Position.X))
            end
        end)

        UserInputService.InputChanged:Connect(function(inp)
            if not isDragging then return end
            if inp.UserInputType == Enum.UserInputType.MouseMovement
            or inp.UserInputType == Enum.UserInputType.Touch then
                setSlider(inputToValue(inp.Position.X))
            end
        end)

        UserInputService.InputEnded:Connect(function(inp)
            if isDragging and (
                inp.UserInputType == Enum.UserInputType.MouseButton1
             or inp.UserInputType == Enum.UserInputType.Touch) then
                isDragging = false
                tween(thumb, SPRING.bounce, { Size = "UDim2".new(0, THUMB_D, 0, THUMB_D) })
            end
        end)
    end

    trackBg:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        setSlider(currentValue, true)
    end)

    if options.Tooltip then addTooltip(hitbox, options.Tooltip, theme) end

    task.defer(function()
        setSlider(value, true)
    end)

    return {
        Frame   = container,
        Set     = function(self, v) setSlider(v, true) end,
        Get     = function(self) return currentValue end,
        SetMin  = function(self, v) min = v; setSlider(currentValue, true) end,
        SetMax  = function(self, v) max = v; setSlider(currentValue, true) end,
        Destroy = function(self) container:Destroy() end,
        _type   = "Slider",
        _value  = function() return currentValue end,
    }
end

-- ── BUTTON ──
local function buildButton(parent, theme, options)
    options = options or {}
    local label    = options.Label    or "Button"
    local icon     = options.Icon
    local variant  = options.Variant * or "filled"
    local callback = options.Callback or function() end
    local locked   = options.Locked   or false
    local desc     = options.Desc

    local bgColor, fgColor, bgTrans
    if variant == "filled" then
        bgColor = theme.accent
        fgColor = "Color3".new(1,1,1)
        bgTrans = 0
    elseif variant == "tinted" then
        bgColor = theme.accent
        fgColor = theme.accent
        bgTrans = 0.85
    elseif variant == "destructive" then
        bgColor = theme.danger
        fgColor = "Color3".new(1,1,1)
        bgTrans = 0
    else
        bgColor = theme.bg3
        fgColor = theme.textPrimary
        bgTrans = 0
    end

    local row = new(Frame, {
        Name             = "Button_" .. .. label,
        Size             = "UDim2".new(1, 0, 0, desc and 56 or 44),
        BackgroundTransparency = 1,
        LayoutOrder      = options.LayoutOrder or 0,
    })
    row.Parent = parent

    if desc then
        listLayout(Enum.FillDirection.Vertical, 2).Parent = row
        new(TextLabel, {
            Size            = "UDim2".new(1, 0, 0, 0),
            AutomaticSize   = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = desc,
            TextColor3      = theme.textSecondary,
            Font            = Enum.Font.Gotham,
            TextSize        = 12,
            TextXAlignment  = Enum.TextXAlignment.Left,
        }).Parent = row
    end

    local btn = new(TextButton, {
        Size             = "UDim2".new(desc and 0 or 1, desc and 0 or 0, 0, 44),
        AutomaticSize    = desc and Enum.AutomaticSize.X or Enum.AutomaticSize.None,
        BackgroundColor3 = bgColor,
        BackgroundTransparency = bgTrans,
        Text             = "",
        AutoButtonColor  = false,
    }, {
        corner(RADIUS.md),
        padding(0, 20, 0, 20),
        listLayout(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center),
    })
    btn.Parent = row

    local iconImg
    if icon then
        iconImg = new(ImageLabel, {
            Size             = "UDim2".new(0, 18, 0, 18),
            BackgroundTransparency = 1,
            Image = type(icon)=="string" and (ICONS[icon] or icon) or ,
            ImageColor3      = fgColor,
        })
        iconImg.Parent = btn
    end

    local lbl = new(TextLabel, {
        Size             = "UDim2".new(0, 0, 0, 0),
        AutomaticSize    = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        Text = label,
        TextColor3       = locked and theme.textTertiary or fgColor,
        Font             = Enum.Font.GothamBold,
        TextSize         = 15,
    })
    lbl.Parent = btn

    local isLoading = false
    local spinConn
    local function setLoading(loading)
        isLoading = loading
        if loading then
            btn.Active = false
            if not btn:GetAttribute("OldText") then
                btn:SetAttribute("OldText", lbl.Text)
            end
            lbl.Text = "Please wait..."
            local spinner = btn:FindFirstChild("Spinner")
            if not spinner then
                spinner = new(ImageLabel, {
                    Name = "Spinner",
                    Size = "UDim2".new(0, 16, 0, 16),
                    BackgroundTransparency = 1,
                    Image = ICONS.info,
                    ImageColor3 = fgColor,
                    LayoutOrder = -1,
                })
                spinner.Parent = btn
            end
            spinner.Visible = true
            if iconImg then iconImg.Visible = false end

            if spinConn then spinConn:Disconnect() end
            local rot = 0
            spinConn = RunService.RenderStepped:Connect(function(dt)
                rot = (rot + 180 * dt) % 360
                spinner.Rotation = rot
            end)
        else
            btn.Active = true
            local oldText = btn:GetAttribute("OldText")
            if oldText then lbl.Text = oldText end
            local spinner = btn:FindFirstChild("Spinner")
            if spinner then spinner.Visible = false end
            if iconImg then iconImg.Visible = true end
            if spinConn then spinConn:Disconnect(); spinConn = nil end
        end
    end

    if not locked then
        btn.MouseButton1Click:Connect(function()
            if isLoading then return end
            tween(btn, SPRING.fast, {
                BackgroundColor3 = variant == "filled" and theme.bg4 or bgColor,
                BackgroundTransparency = bgTrans + 0.08,
            })
            task.wait(0.08)
            tween(btn, SPRING.medium, {
                BackgroundColor3 = bgColor,
                BackgroundTransparency = bgTrans,
            })
            pcall(callback)
        end)

        btn.MouseEnter:Connect(function()
            if not isLoading then tween(btn, SPRING.fast, { BackgroundTransparency = bgTrans + 0.05 }) end
        end)
        btn.MouseLeave:Connect(function()
            if not isLoading then tween(btn, SPRING.fast, { BackgroundTransparency = bgTrans }) end
        end)
    end

    if options.Tooltip then addTooltip(btn, options.Tooltip, theme) end

    return {
        Frame   = row,
        Destroy = function(self)
            if spinConn then spinConn:Disconnect() end
            row:Destroy()
        end,
        _type   = "Button",
        SetLabel = function(self, l) lbl.Text = l end,
        SetLoading = function(self, state) setLoading(state) end,
    }
end

-- ── INPUT ──
local function buildInput(parent, theme, options)
    options = options or {}
    local label       = options.Label       or "Input"
    local placeholder = options.Placeholder or "Type here..."
    local value       = options.Value       or ""
    local isPassword  = options.Password    or false
    local multiline   = options.Multiline   or false
    local callback    = options.Callback    or function() end
    local locked      = options.Locked      or false

    local HEIGHT = multiline and 90 or 44

    local container = new(Frame, {
        Name             = "Input_" .. .. label,
        Size             = "UDim2".new(1, 0, 0, 0),
        AutomaticSize    = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder      = options.LayoutOrder or 0,
    }, {
        listLayout(Enum.FillDirection.Vertical, 6),
    })
    container.Parent = parent

    local floatLabel = new(TextLabel, {
        Size            = "UDim2".new(1, 0, 0, 0),
        AutomaticSize   = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Text = label,
        TextColor3      = theme.textSecondary,
        Font            = Enum.Font.GothamMedium,
        TextSize        = 12,
        TextXAlignment  = Enum.TextXAlignment.Left,
    })
    floatLabel.Parent = container

    local fieldBg = new(Frame, {
        Size             = "UDim2".new(1, 0, 0, HEIGHT),
        BackgroundColor3 = theme.inputBg,
    }, {
        corner(RADIUS.md),
        stroke(1, theme.glass, theme.glassTrans),
        padding(0, 14, 0, 14),
    })
    fieldBg.Parent = container

    local box = new(TextBox, {
        Size             = "UDim2".new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = value,
        PlaceholderText  = placeholder,
        TextColor3       = theme.textPrimary,
        PlaceholderColor3 = theme.inputPlaceholder,
        Font             = Enum.Font.Gotham,
        TextSize         = 15,
        TextXAlignment   = Enum.TextXAlignment.Left,
        TextYAlignment   = multiline and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center,
        TextWrapped      = multiline,
        MultiLine        = multiline,
        ClearTextOnFocus = false,
    })
    if isPassword then box.TextEditable = not locked end
    box.Parent = fieldBg

    box.Focused:Connect(function()
        tween(fieldBg, SPRING.fast, { BackgroundColor3 = theme.bg3 })
        local s = fieldBg:FindFirstChildOfClass(UIStroke)
        if s then tween(s, SPRING.fast, { Color = theme.accent, Transparency = 0.3 }) end
    end)

    box.FocusLost:Connect(function()
        tween(fieldBg, SPRING.fast, { BackgroundColor3 = theme.inputBg })
        local s = fieldBg:FindFirstChildOfClass(UIStroke)
        if s then tween(s, SPRING.fast, { Color = theme.glass, Transparency = theme.glassTrans }) end
        pcall(callback, box.Text)
    end)

    if options.Tooltip then addTooltip(fieldBg, options.Tooltip, theme) end

    return {
        Frame   = container,
        Set     = function(self, v) box.Text = v end,
        Get     = function(self) return box.Text end,
        Clear   = function(self) box.Text =  end,
        Destroy = function(self) container:Destroy() end,
        _type   = "Input",
        _value  = function() return box.Text end,
        _box    = box,
    }
end

-- ── DROPDOWN ──
local function buildDropdown(parent, theme, options)
    options = options or {}
    local label    = options.Label    or "Dropdown"
    local items    = options.Items    or {}
    local value    = options.Value    or (items[1])
    local multi    = options.Multi    or false
    local callback = options.Callback or function() end
    local locked   = options.Locked   or false

    local selected = multi and {} or value

    local container = new(Frame, {
        Name             = "Dropdown_" .. .. label,
        Size             = "UDim2".new(1, 0, 0, 0),
        AutomaticSize    = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder      = options.LayoutOrder or 0,
        ClipsDescendants = false,
        ZIndex           = 10,
    })
    container.Parent = parent

    local rowBg = new(Frame, {
        Size             = "UDim2".new(1, 0, 0, 44),
        BackgroundColor3 = theme.bg3,
    }, {
        corner(RADIUS.md),
        stroke(1, theme.glass, theme.glassTrans),
        padding(0, 14, 0, 14),
        listLayout(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center),
    })
    rowBg.Parent = container

    local rowLabel = new(TextLabel, {
        Size            = "UDim2".new(0, 0, 0, 0),
        AutomaticSize   = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Text = label,
        TextColor3      = theme.textSecondary,
        Font            = Enum.Font.GothamMedium,
        TextSize        = 13,
        TextXAlignment  = Enum.TextXAlignment.Left,
    })
    rowLabel.Parent = rowBg

    new(Frame, {
        Size             = "UDim2".new(1, 0, 0, 1),
        BackgroundTransparency = 1,
        LayoutOrder      = 50,
    }).Parent = rowBg

    local selectedTxt = new(TextLabel, {
        Size            = "UDim2".new(0, 0, 0, 0),
        AutomaticSize   = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        Text = type(selected) == "string" and selected or "Select...",
        TextColor3      = theme.accent,
        Font            = Enum.Font.GothamBold,
        TextSize        = 13,
        TextXAlignment  = Enum.TextXAlignment.Right,
        LayoutOrder     = 99,
    })
    selectedTxt.Parent = rowBg

    local chevron = new(ImageLabel, {
        Size             = "UDim2".new(0, 14, 0, 14),
        BackgroundTransparency = 1,
        Image = ICONS.chevron_down,
        ImageColor3      = theme.textSecondary,
        LayoutOrder      = 100,
    })
    chevron.Parent = rowBg

    local sheet = new(Frame, {
        Name             = "Sheet",
        Size             = "UDim2".new(1, 0, 0, 0),
        Position         = "UDim2".new(0, 0, 1, 4),
        BackgroundColor3 = theme.bg2,
        ClipsDescendants = true,
        ZIndex           = 20,
        Visible          = false,
    }, {
        corner(RADIUS.md),
        stroke(1, theme.glass, theme.glassTrans),
    })
    sheet.Parent = container

    local sheetLayout = listLayout(Enum.FillDirection.Vertical, 4)
    sheetLayout.Parent = sheet
    padding(4, 4, 4, 4).Parent = sheet

    local searchBox
    if options.Searchable then
        local searchContainer = new(Frame, {
            Size = "UDim2".new(1, 0, 0, 32),
            BackgroundColor3 = theme.inputBg,
        }, {
            corner(RADIUS.sm),
            stroke(1, theme.glass, theme.glassTrans),
            padding(0, 8, 0, 8),
        })
        searchContainer.Parent = sheet

        searchBox = new(TextBox, {
            Size = "UDim2".new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text             = "",
            PlaceholderText = "Search...",
            TextColor3 = theme.textPrimary,
            PlaceholderColor3 = theme.inputPlaceholder,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            ClearTextOnFocus = false,
        })
        searchBox.Parent = searchContainer
    end

    local scrollItems = new(ScrollingFrame, {
        Size = "UDim2".new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = theme.textTertiary,
        CanvasSize = "UDim2".new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
    })
    scrollItems.Parent = sheet

    local listFrame = new(Frame, {
        Size          = "UDim2".new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
    }, {
        listLayout(Enum.FillDirection.Vertical, 0),
    })
    listFrame.Parent = scrollItems

    local isOpen = false
    local itemFrames = {}

    local function updateSelection()
        if multi then
            if #selected == 0 then selectedTxt.Text = "None"
            elseif #selected == 1 then selectedTxt.Text = selected[1]
            else selectedTxt.Text = selected[1] .. " + " .. (#selected - 1) end
        else
            selectedTxt.Text = selected or "Select..."
        end
    end

    local function buildItems()
        for _, f in ipairs(itemFrames) do f:Destroy() end
        itemFrames = {}
        listFrame:ClearAllChildren()
        listLayout(Enum.FillDirection.Vertical, 0).Parent = listFrame

        for _, item in ipairs(items) do
            local isSelected = multi and ("table".find(selected, item) ~= nil) or (selected == item)
            local row = new(TextButton, {
                Size             = "UDim2".new(1, 0, 0, 38),
                BackgroundColor3 = isSelected and theme.accent or theme.bg2,
                BackgroundTransparency = isSelected and 0.88 or 1,
                Text             = "",
                AutoButtonColor  = false,
            }, {
                corner(RADIUS.sm),
                padding(0, 10, 0, 10),
                listLayout(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center),
            })
            row.Parent = listFrame
            "table".insert(itemFrames, row)

            local checkImg = new(ImageLabel, {
                Size             = "UDim2".new(0, 16, 0, 16),
                BackgroundTransparency = 1,
                Image = ICONS.check,
                ImageColor3      = theme.accent,
                Visible          = isSelected,
            })
            checkImg.Parent = row

            new(TextLabel, {
                Size             = "UDim2".new(1, 0, 0, 0),
                AutomaticSize    = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = tostring(item),
                TextColor3       = isSelected and theme.accent or theme.textPrimary,
                Font             = isSelected and Enum.Font.GothamBold or Enum.Font.Gotham,
                TextSize         = 14,
                TextXAlignment   = Enum.TextXAlignment.Left,
            }).Parent = row

            row.MouseButton1Click:Connect(function()
                if multi then
                    local idx = "table".find(selected, item)
                    if idx then "table".remove(selected, idx) else "table".insert(selected, item) end
                else
                    selected = item
                    task.defer(function()
                        buildItems()
                        updateSelection()
                        pcall(callback, selected)
                        isOpen = false
                        tween(sheet, SPRING.medium, { Size = "UDim2".new(1, 0, 0, 0) })
                        tween(chevron, SPRING.fast, { Rotation = 0 })
                        task.wait(0.3)
                        sheet.Visible = false
                    end)
                    return
                end
                buildItems()
                updateSelection()
                pcall(callback, selected)
            end)

            row.MouseEnter:Connect(function()
                if not isSelected then tween(row, SPRING.fast, { BackgroundTransparency = 0.92 }) end
            end)
            row.MouseLeave:Connect(function()
                tween(row, SPRING.fast, { BackgroundTransparency = isSelected and 0.88 or 1 })
            end)
        end
    end

    local function filterItems()
        local query = searchBox and searchBox.Text:lower() or ""
        local visibleCount = 0
        for _, btn in ipairs(itemFrames) do
            local itemText = btn:FindFirstChildOfClass(TextLabel).Textlower()
            if itemText:find(query, 1, true) then
                btn.Visible = true
                visibleCount = visibleCount + 1
            else
                btn.Visible = false
            end
        end
        local targetH = math.min(visibleCount * 38, 200)
        scrollItems.Size = "UDim2".new(1, 0, 0, targetH)
        local totalH = targetH + (options.Searchable and 36 or 0) + 8
        if isOpen then
            tween(sheet, SPRING.medium, { Size = "UDim2".new(1, 0, 0, totalH) })
        end
    end

    if searchBox then
        searchBox:GetPropertyChangedSignal("Text"):Connect(filterItems)
    end

    buildItems()
    updateSelection()

    local hitbox = new(TextButton, {
        Size             = "UDim2".new(1, 0, 0, 44),
        BackgroundTransparency = 1,
        Text             = "",
        ZIndex           = 15,
    })
    hitbox.Parent = container

    if not locked then
        hitbox.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            if isOpen then
                if searchBox then searchBox.Text =  end
                sheet.Visible = true
                local targetH = math.min(#items * 38, 200)
                scrollItems.Size = "UDim2".new(1, 0, 0, targetH)
                local totalH = targetH + (options.Searchable and 36 or 0) + 8
                sheet.Size = "UDim2".new(1, 0, 0, 0)
                tween(sheet, SPRING.medium, { Size = "UDim2".new(1, 0, 0, totalH) })
                tween(chevron, SPRING.fast, { Rotation = 180 })
            else
                tween(sheet, SPRING.medium, { Size = "UDim2".new(1, 0, 0, 0) })
                tween(chevron, SPRING.fast, { Rotation = 0 })
                task.wait(0.3)
                if not isOpen then sheet.Visible = false end
            end
        end)
    end

    if options.Tooltip then addTooltip(hitbox, options.Tooltip, theme) end

    return {
        Frame    = container,
        Set      = function(self, v) selected = v; buildItems(); updateSelection() end,
        Get      = function(self) return selected end,
        Refresh  = function(self, newItems) items = newItems; buildItems(); filterItems() end,
        Destroy  = function(self) container:Destroy() end,
        _type    = "Dropdown",
        _value   = function() return selected end,
    }
end

-- ── KEYBIND ──
local function buildKeybind(parent, theme, options)
    options = options or {}
    local label    = options.Label    or "Keybind"
    local value    = options.Value    or Enum.KeyCode.Unknown
    local callback = options.Callback or function() end
    local locked   = options.Locked   or false

    local currentKey = value

    local function keyName(kc)
        if kc == Enum.KeyCode.Unknown then return "None" end
        local name = kc.Name
        local shorts = {
            LeftControl = "LCtrl", RightControl = "RCtrl",
            LeftShift = "LShift", RightShift = "RShift",
            LeftAlt = "LAlt", RightAlt = "RAlt",
            Return = "Enter", BackSpace = "Back",
        }
        return shorts[name] or name
    end

    local row = new(Frame, {
        Name             = "Keybind_" .. .. label,
        Size             = "UDim2".new(1, 0, 0, 44),
        BackgroundTransparency = 1,
        LayoutOrder      = options.LayoutOrder or 0,
    }, {
        listLayout(Enum.FillDirection.Horizontal, 0, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center),
    })
    row.Parent = parent

    new(TextLabel, {
        Size            = "UDim2".new(1, -110, 1, 0),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3      = locked and theme.textTertiary or theme.textPrimary,
        Font            = Enum.Font.GothamMedium,
        TextSize        = 15,
        TextXAlignment  = Enum.TextXAlignment.Left,
    }).Parent = row

    local badge = new(Frame, {
        Size             = "UDim2".new(0, 0, 0, 28),
        AutomaticSize    = Enum.AutomaticSize.X,
        AnchorPoint      = "Vector2".new(1, 0.5),
        BackgroundColor3 = theme.bg3,
    }, {
        corner(RADIUS.sm),
        padding(0, 10, 0, 10),
    })
    badge.Parent = row

    local badgeTxt = new(TextLabel, {
        Size            = "UDim2".new(0, 0, 1, 0),
        AutomaticSize   = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Text = keyName(currentKey),
        TextColor3      = theme.accent,
        Font            = Enum.Font.GothamBold,
        TextSize         = 12,
        TextXAlignment  = Enum.TextXAlignment.Center,
    })
    badgeTxt.Parent = badge

    local listening = false
    local hitbox = new(TextButton, {
        Size             = "UDim2".new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text             = "",
        ZIndex           = 10,
    })
    hitbox.Parent = row

    if not locked then
        hitbox.MouseButton1Click:Connect(function()
            if listening then return end
            listening = true
            badgeTxt.Text = "..."
            tween(badge, SPRING.fast, { BackgroundColor3 = theme.accent })
            badgeTxt.TextColor3 = "Color3".new(1,1,1)

            local conn
            conn = UserInputService.InputBegan:Connect(function(inp, gp)
                if gp then return end
                if inp.UserInputType == Enum.UserInputType.Keyboard then
                    currentKey = inp.KeyCode
                    badgeTxt.Text = keyName(currentKey)
                    tween(badge, SPRING.fast, { BackgroundColor3 = theme.bg3 })
                    badgeTxt.TextColor3 = theme.accent
                    listening = false
                    conn:Disconnect()
                    pcall(callback, currentKey)
                end
            end)
        end)

        UserInputService.InputBegan:Connect(function(inp, gp)
            if gp or listening then return end
            if inp.UserInputType == Enum.UserInputType.Keyboard
            and inp.KeyCode == currentKey then
                pcall(callback, currentKey)
            end
        end)
    end

    if options.Tooltip then addTooltip(hitbox, options.Tooltip, theme) end

    return {
        Frame   = row,
        Set     = function(self, kc) currentKey = kc; badgeTxt.Text = keyName(kc) end,
        Get     = function(self) return currentKey end,
        Destroy = function(self) row:Destroy() end,
        _type   = "Keybind",
        _value  = function() return currentKey end,
    }
end

-- ── COLOR PICKER [NEW] ──
local function buildColorPicker(parent, theme, options)
    options = options or {}
    local label    = options.Label    or "Color Picker"
    local desc     = options.Desc
    local callback = options.Callback or function() end
    local value    = options.Value    or Color3.fromRGB(255, 0, 0)
    local locked   = options.Locked   or false

    local container = new(Frame, {
        Name             = "ColorPicker_" .. .. label,
        Size             = "UDim2".new(1, 0, 0, 0),
        AutomaticSize    = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder      = options.LayoutOrder or 0,
        ZIndex           = 10,
    })
    container.Parent = parent

    local rowBg = new(Frame, {
        Size             = "UDim2".new(1, 0, 0, 44),
        BackgroundColor3 = theme.bg3,
    }, {
        corner(RADIUS.md),
        stroke(1, theme.glass, theme.glassTrans),
        padding(0, 14, 0, 14),
        listLayout(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center),
    })
    rowBg.Parent = container

    local textStack = new(Frame, {
        Size          = "UDim2".new(1, -70, 1, 0),
        BackgroundTransparency = 1,
    }, {
        listLayout(Enum.FillDirection.Vertical, 2, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center),
    })
    textStack.Parent = rowBg

    new(TextLabel, {
        Size            = "UDim2".new(1, 0, 0, 0),
        AutomaticSize   = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Text = label,
        TextColor3      = locked and theme.textTertiary or theme.textPrimary,
        Font            = Enum.Font.GothamMedium,
        TextSize        = 13,
        TextXAlignment  = Enum.TextXAlignment.Left,
    }).Parent = textStack

    if desc then
        new(TextLabel, {
            Size            = "UDim2".new(1, 0, 0, 0),
            AutomaticSize   = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = desc,
            TextColor3      = theme.textSecondary,
            Font            = Enum.Font.Gotham,
            TextSize        = 11,
            TextXAlignment  = Enum.TextXAlignment.Left,
        }).Parent = textStack
    end

    new(Frame, { Size = "UDim2".new(1, 0, 0, 1), BackgroundTransparency = 1, LayoutOrder = 50 }).Parent = rowBg

    local swatchCircle = new(Frame, {
        Size             = "UDim2".new(0, 24, 0, 24),
        BackgroundColor3 = value,
        LayoutOrder      = 100,
    }, { corner(RADIUS.pill), stroke(1, theme.glass, 0.5) })
    swatchCircle.Parent = rowBg

    -- Expanding picker panel
    local panel = new(Frame, {
        Name             = "PickerPanel",
        Size             = "UDim2".new(1, 0, 0, 0),
        Position         = "UDim2".new(0, 0, 1, 4),
        BackgroundColor3 = theme.bg2,
        ClipsDescendants = true,
        Visible          = false,
        ZIndex           = 20,
    }, {
        corner(RADIUS.md),
        stroke(1, theme.glass, theme.glassTrans),
        padding(10, 10, 10, 10),
    })
    panel.Parent = container

    local panelLayout = listLayout(Enum.FillDirection.Horizontal, 14, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Top)
    panelLayout.Parent = panel

    -- Left Column "Quadrant" and Hue
    local leftCol = new(Frame, {
        Size = "UDim2".new(0, 130, 0, 150),
        BackgroundTransparency = 1,
    }, {
        listLayout(Enum.FillDirection.Vertical, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Top),
    })
    leftCol.Parent = panel

    -- HSB "Quadrant"
    local h, s, v = "Color3".toHSV(value)
    local currentHue, currentSat, currentVal = h, s, v
    local currentColor = value

    local quadrant = new(Frame, {
        Name             = "Quadrant",
        Size             = "UDim2".new(0, 130, 0, 110),
        BackgroundColor3 = "Color3".fromHSV(currentHue, 1, 1),
    }, { corner(RADIUS.sm) })
    quadrant.Parent = leftCol

    -- White-to-transparent overlay (Sat)
    local whiteOverlay = new(Frame, {
        Size = "UDim2".new(1, 0, 1, 0),
        BackgroundTransparency = 0,
        BackgroundColor3 = "Color3".new(1,1,1),
    }, {
        corner(RADIUS.sm),
        new(UIGradient, {
            Color = ColorSequence.new("Color3".new(1,1,1)),
            Transparency = NumberSequence.new(0, 1),
        })
    })
    whiteOverlay.Parent = quadrant

    -- Black-to-transparent overlay (Val)
    local blackOverlay = new(Frame, {
        Size = "UDim2".new(1, 0, 1, 0),
        BackgroundTransparency = 0,
        BackgroundColor3 = "Color3".new(0,0,0),
    }, {
        corner(RADIUS.sm),
        new(UIGradient, {
            Color = ColorSequence.new("Color3".new(0,0,0)),
            Transparency = NumberSequence.new(1, 0),
            Rotation = 90,
        })
    })
    blackOverlay.Parent = quadrant

    local quadrantThumb = new(Frame, {
        Size             = "UDim2".new(0, 12, 0, 12),
        Position         = "UDim2".new(currentSat, 0, 1 - currentVal, 0),
        AnchorPoint      = "Vector2".new(0.5, 0.5),
        BackgroundColor3 = "Color3".new(1,1,1),
    }, {
        corner(RADIUS.pill),
        stroke(1.5, "Color3".new(0,0,0), 0.5),
    })
    quadrantThumb.Parent = quadrant

    -- Hue "Slider" (Rainbow)
    local hueSlider = new(Frame, {
        Name             = "HueSlider",
        Size             = "UDim2".new(1, 0, 0, 12),
        BackgroundColor3 = "Color3".new(1,1,1),
    }, {
        corner(RADIUS.pill),
        new(UIGradient, {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0,     "Color3".fromHSV(0, 1, 1)),
                ColorSequenceKeypoint.new(0.166, "Color3".fromHSV(0.166, 1, 1)),
                ColorSequenceKeypoint.new(0.333, "Color3".fromHSV(0.333, 1, 1)),
                ColorSequenceKeypoint.new(0.5,   "Color3".fromHSV(0.5, 1, 1)),
                ColorSequenceKeypoint.new(0.666, "Color3".fromHSV(0.666, 1, 1)),
                ColorSequenceKeypoint.new(0.833, "Color3".fromHSV(0.833, 1, 1)),
                ColorSequenceKeypoint.new(1,     "Color3".fromHSV(1, 1, 1)),
            }),
        }),
    })
    hueSlider.Parent = leftCol

    local hueThumb = new(Frame, {
        Size             = "UDim2".new(0, 8, 0, 16),
        Position         = "UDim2".new(currentHue, 0, 0.5, 0),
        AnchorPoint      = "Vector2".new(0.5, 0.5),
        BackgroundColor3 = "Color3".new(1,1,1),
    }, {
        corner(RADIUS.pill),
        stroke(1, "Color3".new(0,0,0), 0.5),
    })
    hueThumb.Parent = hueSlider

    -- Right Column Preview and Stats
    local rightCol = new(Frame, {
        Size = "UDim2".new(1, -144, 0, 130),
        BackgroundTransparency = 1,
    }, {
        listLayout(Enum.FillDirection.Vertical, 10, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center),
    })
    rightCol.Parent = panel

    local rightSwatch = new(Frame, {
        Size = "UDim2".new(0, 50, 0, 50),
        BackgroundColor3 = currentColor,
    }, { corner(RADIUS.md), stroke(1, theme.glass, 0.4) })
    rightSwatch.Parent = rightCol

    local hexText = new(TextLabel, {
        Size = "UDim2".new(1, 0, 0, 18),
        BackgroundTransparency = 1,
        Text = "#FF0000",
        TextColor3 = theme.textPrimary,
        Font = Enum.Font.Code,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    hexText.Parent = rightCol

    local function updateColor(silent)
        quadrant.BackgroundColor3 = "Color3".fromHSV(currentHue, 1, 1)
        currentColor = "Color3".fromHSV(currentHue, currentSat, currentVal)
        quadrantThumb.Position = "UDim2".new(currentSat, 0, 1 - currentVal, 0)
        hueThumb.Position = "UDim2".new(currentHue, 0, 0.5, 0)
        swatchCircle.BackgroundColor3 = currentColor
        rightSwatch.BackgroundColor3 = currentColor

        local rStr = string.format("%02X", math.floor(currentColor.R * 255 + 0.5))
        local gStr = string.format("%02X", math.floor(currentColor.G * 255 + 0.5))
        local bStr = string.format("%02X", math.floor(currentColor.B * 255 + 0.5))
        hexText.Text = "#" .. rStr .. gStr .. bStr

        if not silent then pcall(callback, currentColor) end
    end

    -- Interaction logic
    local isDraggingQuadrant = false
    local isDraggingHue = false

    quadrant.InputBegan:Connect(function(inp)
        if locked then return end
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            isDraggingQuadrant = true
            local qPos = quadrant.AbsolutePosition
            local qSize = quadrant.AbsoluteSize
            local scale = container:FindFirstAncestorOfClass(ScreenGui) and container:FindFirstAncestorOfClass(ScreenGui):FindFirstChildOfClass(UIScale) and container:FindFirstAncestorOfClass(ScreenGui):FindFirstChildOfClass(UIScale).Scale or 1
            currentSat = clamp(((inp.Position.X - qPos.X)  scale) * (qSize.X * scale), 0, 1)
            currentVal = clamp(1 - (((inp.Position.Y - qPos.Y)  scale) * (qSize.Y * scale)), 0, 1)
            updateColor()
        end
    end)

    hueSlider.InputBegan:Connect(function(inp)
        if locked then return end
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            isDraggingHue = true
            local hPos = hueSlider.AbsolutePosition
            local hSize = hueSlider.AbsoluteSize
            local scale = container:FindFirstAncestorOfClass(ScreenGui) and container:FindFirstAncestorOfClass(ScreenGui):FindFirstChildOfClass(UIScale) and container:FindFirstAncestorOfClass(ScreenGui):FindFirstChildOfClass(UIScale).Scale or 1
            currentHue = clamp(((inp.Position.X - hPos.X)  scale) * (hSize.X * scale), 0, 1)
            updateColor()
        end
    end)

    UserInputService.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            local scale = container:FindFirstAncestorOfClass(ScreenGui) and container:FindFirstAncestorOfClass(ScreenGui):FindFirstChildOfClass(UIScale) and container:FindFirstAncestorOfClass(ScreenGui):FindFirstChildOfClass(UIScale).Scale or 1
            if isDraggingQuadrant then
                local qPos = quadrant.AbsolutePosition
                local qSize = quadrant.AbsoluteSize
                currentSat = clamp(((inp.Position.X - qPos.X)  scale) * (qSize.X * scale), 0, 1)
                currentVal = clamp(1 - (((inp.Position.Y - qPos.Y)  scale) * (qSize.Y * scale)), 0, 1)
                updateColor()
            elseif isDraggingHue then
                local hPos = hueSlider.AbsolutePosition
                local hSize = hueSlider.AbsoluteSize
                currentHue = clamp(((inp.Position.X - hPos.X)  scale) * (hSize.X * scale), 0, 1)
                updateColor()
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            isDraggingQuadrant = false
            isDraggingHue = false
        end
    end)

    local isOpen = false
    local hitbox = new(TextButton, {
        Size             = "UDim2".new(1, 0, 0, 44),
        BackgroundTransparency = 1,
        Text             = "",
        ZIndex           = 15,
    })
    hitbox.Parent = container

    if not locked then
        hitbox.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            if isOpen then
                panel.Visible = true
                panel.Size = "UDim2".new(1, 0, 0, 0)
                tween(panel, SPRING.medium, { Size = "UDim2".new(1, 0, 0, 150) })
            else
                tween(panel, SPRING.medium, { Size = "UDim2".new(1, 0, 0, 0) })
                task.wait(0.3)
                if not isOpen then panel.Visible = false end
            end
        end)
    end

    if options.Tooltip then addTooltip(hitbox, options.Tooltip, theme) end
    updateColor(true)

    return {
        Frame   = container,
        Set     = function(self, col)
            currentColor = col
            local h, s, v = "Color3".toHSV(col)
            currentHue, currentSat, currentVal = h, s, v
            updateColor(true)
        end,
        Get     = function(self) return currentColor end,
        Destroy = function(self) container:Destroy() end,
        _type   = "ColorPicker",
        _value  = function() return currentColor end,
    }
end

-- ── PROGRESS BAR [NEW] ──
local function buildProgress(parent, theme, options)
    options = options or {}
    local label = options.Label or "Progress"
    local value = clamp(options.Value or 0, 0, 100)
    local max   = options.Max or 100

    local container = new(Frame, {
        Name = "Progress_" .. .. label,
        Size = "UDim2".new(1, 0, 0, 44),
        BackgroundTransparency = 1,
        LayoutOrder = options.LayoutOrder or 0,
    })
    container.Parent = parent

    local leftLayout = listLayout(Enum.FillDirection.Vertical, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
    leftLayout.Parent = container

    local header = new(Frame, { Size = "UDim2".new(1, 0, 0, 16), BackgroundTransparency = 1 })
    header.Parent = container

    local labelTxt = new(TextLabel, {
        Size = "UDim2".new(1, -60, 1, 0),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = theme.textPrimary,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    labelTxt.Parent = header

    local valText = new(TextLabel, {
        Size = "UDim2".new(0, 50, 1, 0),
        Position = "UDim2".new(1, 0, 0, 0),
        AnchorPoint = "Vector2".new(1, 0),
        BackgroundTransparency = 1,
        Text = tostring(math.floor((value / max) * 100)) .. "%",
        TextColor3 = theme.accent,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right,
    })
    valText.Parent = header

    local track = new(Frame, {
        Size = "UDim2".new(1, 0, 0, 8),
        BackgroundColor3 = theme.sliderTrack,
    }, { corner(RADIUS.pill) })
    track.Parent = container

    local fill = new(Frame, {
        Size = "UDim2".new(0, 0, 1, 0),
        BackgroundColor3 = theme.sliderFill,
        ClipsDescendants = true,
    }, { corner(RADIUS.pill) })
    fill.Parent = track

    -- Shine gloss overlay
    local shine = new(Frame, {
        Size = "UDim2".new(0.4, 0, 1, 0),
        Position = "UDim2".new(-0.4, 0, 0, 0),
        BackgroundColor3 = "Color3".new(1, 1, 1),
        BackgroundTransparency = 0.85,
        BorderSizePixel = 0,
    }, {
        new(UIGradient, {
            Color = ColorSequence.new("Color3".new(1,1,1)),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.5, 0),
                NumberSequenceKeypoint.new(1, 1)
            })
        })
    })
    shine.Parent = fill

    task.spawn(function()
        while fill.Parent do
            shine.Position = "UDim2".new(-0.4, 0, 0, 0)
            local t = tween(shine, TweenInfo.new(1.8, Enum.EasingStyle.Linear), { Position = "UDim2".new(1.2, 0, 0, 0) })
            t.CompletedWait()
            task.wait(1.5)
        end
    end)

    local function setProgress(val)
        value = clamp(val, 0, max)
        local pct = value / max
        springTo(fill, "Size", "UDim2".new(pct, 0, 1, 0), 160, 18)
        valText.Text = tostring(math.floor(pct * 100)) .. "%"
    end

    setProgress(value)

    if options.Tooltip then addTooltip(track, options.Tooltip, theme) end

    return {
        Frame = container,
        Set = function(self, v) setProgress(v) end,
        Get = function(self) return value end,
        Destroy = function(self) container:Destroy() end,
        _type = "Progress",
    }
end

-- ── IMAGE [NEW] ──
local function buildImage(parent, theme, options)
    options = options or {}
    local label = options.Label
    local desc = options.Desc
    local image = options.Image or ""
    local ratio = options.AspectRatio or 1.77

    local container = new(Frame, {
        Name = "ImageRow",
        Size = "UDim2".new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = options.LayoutOrder or 0,
    }, {
        listLayout(Enum.FillDirection.Vertical, 6),
    })
    container.Parent = parent

    if label then
        new(TextLabel, {
            Size = "UDim2".new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = label,
            TextColor3 = theme.textPrimary,
            Font = Enum.Font.GothamMedium,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
        }).Parent = container
    end

    local imgFrame = new(Frame, {
        Size = "UDim2".new(1, 0, 0, 100),
        BackgroundColor3 = theme.bg3,
    }, {
        corner(RADIUS.md),
        stroke(1, theme.glass, theme.glassTrans),
        new(UIAspectRatioConstraint, {
            AspectRatio = ratio,
            AspectType = Enum.AspectType.WidthControlsHeight,
        })
    })
    imgFrame.Parent = container

    local img = new(ImageLabel, {
        Size = "UDim2".new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Image = image,
        ScaleType = Enum.ScaleType.Crop,
    }, { corner(RADIUS.md) })
    img.Parent = imgFrame

    if desc then
        new(TextLabel, {
            Size = "UDim2".new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = desc,
            TextColor3 = theme.textSecondary,
            Font = Enum.Font.Gotham,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
        }).Parent = container
    end

    if options.Tooltip then addTooltip(imgFrame, options.Tooltip, theme) end

    return {
        Frame = container,
        SetImage = function(self, imgUrl) img.Image = imgUrl end,
        Destroy = function(self) container:Destroy() end,
        _type = "Image",
    }
end

-- ── ACCORDION [NEW] ──
local function buildAccordion(parent, theme, options)
    options = options or {}
    local label = options.Label or "Accordion"
    local isCollapsed = options.Collapsed ~= nil and options.Collapsed or true

    local wrapper = new(Frame, {
        Name = "Accordion_" .. .. label,
        Size = "UDim2".new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = options.LayoutOrder or 0,
    }, {
        listLayout(Enum.FillDirection.Vertical, 4),
    })
    wrapper.Parent = parent

    local header = new(Frame, {
        Size = "UDim2".new(1, 0, 0, 40),
        BackgroundColor3 = theme.bg3,
    }, {
        corner(RADIUS.md),
        stroke(1, theme.glass, theme.glassTrans),
        padding(0, 12, 0, 12),
        listLayout(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center),
    })
    header.Parent = wrapper

    local titleLabel = new(TextLabel, {
        Size = "UDim2".new(1, -24, 1, 0),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = theme.textPrimary,
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    titleLabel.Parent = header

    local chevron = new(ImageLabel, {
        Size = "UDim2".new(0, 16, 0, 16),
        BackgroundTransparency = 1,
        Image = ICONS.chevron_down,
        ImageColor3 = theme.textSecondary,
    })
    chevron.Parent = header

    local contentCard = new(Frame, {
        Size = "UDim2".new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = theme.bg2,
        ClipsDescendants = true,
        Visible = not isCollapsed,
    }, {
        corner(RADIUS.md),
        stroke(1, theme.glass, theme.glassTrans),
    })
    contentCard.Parent = wrapper

    local content = new(Frame, {
        Size = "UDim2".new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
    }, {
        padding(8, 12, 8, 12),
        listLayout(Enum.FillDirection.Vertical, 8),
    })
    content.Parent = contentCard

    local function setCollapsed(collapsed)
        isCollapsed = collapsed
        tween(chevron, SPRING.fast, { Rotation = collapsed and 0 or 180 })

        if collapsed then
            springTo(contentCard, "Size", "UDim2".new(1, 0, 0, 0), 200, 20, function()
                if isCollapsed then contentCard.Visible = false end
            end)
        else
            contentCard.Visible = true
            local targetH = content.AbsoluteSize.Y + 16
            springTo(contentCard, "Size", "UDim2".new(1, 0, 0, targetH), 200, 20, function()
                if not isCollapsed then
                    contentCard.Size = "UDim2".new(1, 0, 0, 0)
                    contentCard.AutomaticSize = Enum.AutomaticSize.Y
                end
            end)
        end
    end

    local hitbox = new(TextButton, {
        Size = "UDim2".new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text             = "",
        ZIndex = 10,
    })
    hitbox.Parent = header
    hitbox.MouseButton1Click:Connect(function()
        setCollapsed(not isCollapsed)
    end)

    chevron.Rotation = isCollapsed and 0 or 180

    local "Accordion" = { Frame = wrapper }

    function AccordionToggle(opts) return buildToggle(content, theme, opts) end
    function AccordionSlider(opts) return buildSlider(content, theme, opts) end
    function AccordionButton(opts) return buildButton(content, theme, opts) end
    function AccordionInput(opts) return buildInput(content, theme, opts) end
    function AccordionDropdown(opts) return buildDropdown(content, theme, opts) end
    function AccordionKeybind(opts) return buildKeybind(content, theme, opts) end
    function AccordionColorPicker(opts) return buildColorPicker(content, theme, opts) end
    function AccordionProgress(opts) return buildProgress(content, theme, opts) end
    function AccordionLabel(opts) return buildLabel(content, theme, opts) end
    function AccordionParagraph(opts) return buildParagraph(content, theme, opts) end

    if options.Tooltip then addTooltip(hitbox, options.Tooltip, theme) end

    return "Accordion"
end

-- ── LABEL ──
local function buildLabel(parent, theme, options)
    options = options or {}
    local text   = options.Text  or ""
    local icon   = options.Icon
    local color  = options.Color
    local size   = options.Size   or 15
    local weight = options.Bold and Enum.Font.GothamBold or Enum.Font.GothamMedium

    local row = new(Frame, {
        Name             = "Label",
        Size             = "UDim2".new(1, 0, 0, 0),
        AutomaticSize    = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder      = options.LayoutOrder or 0,
    }, {
        listLayout(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center),
        padding(4, 0, 4, 0),
    })
    row.Parent = parent

    if icon then
        new(ImageLabel, {
            Size             = "UDim2".new(0, 18, 0, 18),
            BackgroundTransparency = 1,
            Image = type(icon)=="string" and (ICONS[icon] or icon) or ,
            ImageColor3      = color or theme.accent,
        }).Parent = row
    end

    local lbl = new(TextLabel, {
        Size            = "UDim2".new(1, 0, 0, 0),
        AutomaticSize   = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Text = text,
        TextColor3      = color or theme.textPrimary,
        Font            = weight,
        TextSize        = size,
        TextXAlignment  = Enum.TextXAlignment.Left,
        TextWrapped     = true,
        RichText        = true,
    })
    lbl.Parent = row

    if options.Tooltip then addTooltip(lbl, options.Tooltip, theme) end

    return {
        Frame   = row,
        Set     = function(self, t) lbl.Text = t end,
        Get     = function(self) return lbl.Text end,
        Destroy = function(self) row:Destroy() end,
        _type   = "Label",
    }
end

-- ── PARAGRAPH ──
local function buildParagraph(parent, theme, options)
    options = options or {}
    local title   = options.Title
    local content = options.Content or ""

    local card = new(Frame, {
        Name             = "Paragraph",
        Size             = "UDim2".new(1, 0, 0, 0),
        AutomaticSize    = Enum.AutomaticSize.Y,
        BackgroundColor3 = theme.bg3,
        LayoutOrder      = options.LayoutOrder or 0,
    }, {
        corner(RADIUS.md),
        padding(12, 14, 12, 14),
        listLayout(Enum.FillDirection.Vertical, 6),
    })
    card.Parent = parent

    if title then
        new(TextLabel, {
            Size            = "UDim2".new(1, 0, 0, 0),
            AutomaticSize   = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = title,
            TextColor3      = theme.textPrimary,
            Font            = Enum.Font.GothamBold,
            TextSize        = 14,
            TextXAlignment  = Enum.TextXAlignment.Left,
            TextWrapped     = true,
        }).Parent = card
    end

    local body = new(TextLabel, {
        Size            = "UDim2".new(1, 0, 0, 0),
        AutomaticSize   = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Text = content,
        TextColor3      = theme.textSecondary,
        Font            = Enum.Font.Gotham,
        TextSize         = 13,
        TextXAlignment  = Enum.TextXAlignment.Left,
        TextWrapped     = true,
        RichText        = true,
        LineHeight      = 1.4,
    })
    body.Parent = card

    if options.Tooltip then addTooltip(card, options.Tooltip, theme) end

    return {
        Frame   = card,
        Set     = function(self, opts)
            if opts.Title   then card:FindFirstChildOfClass(TextLabel).Text = opts.Title end
            if opts.Content then body.Text = opts.Content end
        end,
        Destroy = function(self) card:Destroy() end,
        _type   = "Paragraph",
    }
end

-- ── DIVIDER ──
local function buildDivider(parent, theme, options)
    options = options or {}
    local label = options.Label

    local container = new(Frame, {
        Name             = "Divider",
        Size             = "UDim2".new(1, 0, 0, label and 20 or 8),
        BackgroundTransparency = 1,
        LayoutOrder      = options.LayoutOrder or 0,
    })
    container.Parent = parent

    if label then
        local row = new(Frame, {
            Size             = "UDim2".new(1, 0, 0, 14),
            Position         = "UDim2".new(0, 0, 0.5, 0),
            AnchorPoint      = "Vector2".new(0, 0.5),
            BackgroundTransparency = 1,
        }, {
            listLayout(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center),
        })
        row.Parent = container

        new(Frame, {
            Size             = "UDim2".new(0, 0, 0, 1),
            AutomaticSize    = Enum.AutomaticSize.X,
            BackgroundColor3 = theme.separator,
            BackgroundTransparency = theme.separatorTrans,
        }).Parent = row

        new(TextLabel, {
            Size            = "UDim2".new(0, 0, 0, 0),
            AutomaticSize   = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            Text = label,
            TextColor3      = theme.textTertiary,
            Font            = Enum.Font.GothamMedium,
            TextSize        = 11,
            TextXAlignment  = Enum.TextXAlignment.Left,
        }).Parent = row

        new(Frame, {
            Size             = "UDim2".new(1, 0, 0, 1),
            BackgroundColor3 = theme.separator,
            BackgroundTransparency = theme.separatorTrans,
        }).Parent = row
    else
        new(Frame, {
            Size             = "UDim2".new(1, -28, 0, 1),
            Position         = "UDim2".new(0, 14, 0.5, 0),
            AnchorPoint      = "Vector2".new(0, 0.5),
            BackgroundColor3 = theme.separator,
            BackgroundTransparency = theme.separatorTrans,
        }).Parent = container
    end

    return {
        Frame   = container,
        Destroy = function(self) container:Destroy() end,
        _type   = "Divider",
    }
end

-- ─────────────────────────────────────────────────────────
--  SECTION  (collapsible iOS card)
-- ─────────────────────────────────────────────────────────
local function buildSection(parent, theme, options)
    options = options or {}
    local title    = options.Title
    local footer   = options.Footer
    local icon     = options.Icon
    local iconColor = options.IconColor or theme.accent
    local collapsible = options.Collapsible or false
    local isCollapsed = options.Collapsed or false

    local wrapper = new(Frame, {
        Name             = "Section",
        Size             = "UDim2".new(1, 0, 0, 0),
        AutomaticSize    = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder      = options.LayoutOrder or 0,
    }, {
        listLayout(Enum.FillDirection.Vertical, 4),
    })
    wrapper.Parent = parent

    local header = new(Frame, {
        Size             = "UDim2".new(1, 0, 0, 0),
        AutomaticSize    = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
    }, {
        padding(0, 6, 0, 6),
        listLayout(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center),
    })
    header.Parent = wrapper

    if title then
        if icon then
            local iconBox = new(Frame, {
                Size             = "UDim2".new(0, 22, 0, 22),
                BackgroundColor3 = iconColor,
            }, { corner(RADIUS.xs) })
            iconBox.Parent = header

            new(ImageLabel, {
                Size             = "UDim2".new(0, 13, 0, 13),
                Position         = "UDim2".new(0.5, 0, 0.5, 0),
                AnchorPoint      = "Vector2".new(0.5, 0.5),
                BackgroundTransparency = 1,
                Image = type(icon)=="string" and (ICONS[icon] or icon) or ,
                ImageColor3      = "Color3".new(1,1,1),
            }).Parent = iconBox
        end

        new(TextLabel, {
            Size             = "UDim2".new(1, -40, 0, 0),
            AutomaticSize    = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = title:upper(),
            TextColor3       = theme.textTertiary,
            Font             = Enum.Font.GothamMedium,
            TextSize         = 11,
            TextXAlignment   = Enum.TextXAlignment.Left,
            LetterSpacing    = 1,
        }).Parent = header
    end

    local chevronBtn
    if collapsible then
        new(Frame, { Size = "UDim2".new(1, 0, 0, 1), BackgroundTransparency = 1, LayoutOrder = 50 }).Parent = header
        chevronBtn = new(ImageLabel, {
            Size = "UDim2".new(0, 16, 0, 16),
            BackgroundTransparency = 1,
            Image = ICONS.chevron_down,
            ImageColor3 = theme.textTertiary,
            LayoutOrder = 100,
        })
        chevronBtn.Parent = header
    end

    local card = new(Frame, {
        Name             = "Card",
        Size             = "UDim2".new(1, 0, 0, 0),
        AutomaticSize    = Enum.AutomaticSize.Y,
        BackgroundColor3 = theme.bg2,
        ClipsDescendants = false,
    }, {
        corner(RADIUS.lg),
        stroke(1, theme.glass, theme.glassTrans),
    })
    card.Parent = wrapper

    local content = new(Frame, {
        Name             = "Content",
        Size             = "UDim2".new(1, 0, 0, 0),
        AutomaticSize    = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
    }, {
        padding(2, 16, 2, 16),
        listLayout(Enum.FillDirection.Vertical, 0),
    })
    content.Parent = card

    local footerLabel
    if footer then
        footerLabel = new(TextLabel, {
            Size             = "UDim2".new(1, 0, 0, 0),
            AutomaticSize    = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = footer,
            TextColor3       = theme.textTertiary,
            Font             = Enum.Font.Gotham,
            TextSize         = 11,
            TextXAlignment   = Enum.TextXAlignment.Left,
            TextWrapped      = true,
        }, {
            padding(4, 6, 0, 6),
        })
        footerLabel.Parent = wrapper
    end

    local elementCount = 0
    local separators = {}

    local function addSeparator()
        local sep = new(Frame, {
            Size             = "UDim2".new(1, -16, 0, 1),
            Position         = "UDim2".new(0, 16, 0, 0),
            BackgroundColor3 = theme.separator,
            BackgroundTransparency = theme.separatorTrans,
        })
        sep.Parent = content
        "table".insert(separators, sep)
        return sep
    end

    local "Section" = { Frame = wrapper, "Card" = card }

    local function wrapElement(el, addSep)
        elementCount += 1
        if addSep and elementCount * 1 then addSeparator() end
        el.Frame.Parent = content
        el.Frame.BackgroundTransparency = 1
        return el
    end

    local function setCollapsed(collapsed)
        isCollapsed = collapsed
        if chevronBtn then tween(chevronBtn, SPRING.fast, { Rotation = collapsed and -90 or 0 }) end

        if collapsed then
            card.ClipsDescendants = true
            if footerLabel then footerLabel.Visible = false end
            springTo(card, "Size", "UDim2".new(1, 0, 0, 0), 200, 20, function()
                if isCollapsed then card.Visible = false end
            end)
        else
            card.Visible = true
            card.ClipsDescendants = true
            if footerLabel then footerLabel.Visible = true end
            local targetH = content.AbsoluteSize.Y + 4
            springTo(card, "Size", "UDim2".new(1, 0, 0, targetH), 200, 20, function()
                if not isCollapsed then
                    card.ClipsDescendants = false
                    card.Size = "UDim2".new(1, 0, 0, 0)
                    card.AutomaticSize = Enum.AutomaticSize.Y
                end
            end)
        end
    end

    if collapsible then
        local headerHitbox = new(TextButton, {
            Size = "UDim2".new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text             = "",
            ZIndex = 10,
        })
        headerHitbox.Parent = header
        headerHitbox.MouseButton1Click:Connect(function()
            setCollapsed(not isCollapsed)
        end)
    end

    if isCollapsed then setCollapsed(true) end

    function SectionToggle(opts) return wrapElement(buildToggle(content, theme, opts), true) end
    function SectionSlider(opts) return wrapElement(buildSlider(content, theme, opts), true) end
    function SectionButton(opts) return wrapElement(buildButton(content, theme, opts), true) end
    function SectionInput(opts) return wrapElement(buildInput(content, theme, opts), true) end
    function SectionDropdown(opts) return wrapElement(buildDropdown(content, theme, opts), true) end
    function SectionKeybind(opts) return wrapElement(buildKeybind(content, theme, opts), true) end
    function SectionColorPicker(opts) return wrapElement(buildColorPicker(content, theme, opts), true) end
    function SectionProgress(opts) return wrapElement(buildProgress(content, theme, opts), true) end
    function SectionImage(opts) return wrapElement(buildImage(content, theme, opts), true) end
    function SectionAccordion(opts) return wrapElement(buildAccordion(content, theme, opts), true) end
    function SectionLabel(opts) return wrapElement(buildLabel(content, theme, opts), true) end
    function SectionParagraph(opts) return wrapElement(buildParagraph(content, theme, opts), true) end
    function SectionDivider(opts)
        local el = buildDivider(content, theme, opts)
        el.Frame.Parent = content
        return el
    end

    function SectionCollapsible(state)
        setCollapsed(state)
    end

    function "Section":Destroy() wrapper:Destroy() end

    return "Section"
end

-- ─────────────────────────────────────────────────────────
--  SCROLL PAGE
-- ─────────────────────────────────────────────────────────
local function buildPage(parent, theme)
    local scroll = new(ScrollingFrame, {
        Name             = "Page",
        Size             = "UDim2".new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel  = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = theme.textTertiary,
        CanvasSize       = "UDim2".new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
    })
    scroll.Parent = parent

    local inner = new(Frame, {
        Name             = "Inner",
        Size             = "UDim2".new(1, 0, 0, 0),
        AutomaticSize    = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
    }, {
        padding(16, 16, 24, 16),
        listLayout(Enum.FillDirection.Vertical, 10),
    })
    inner.Parent = scroll

    local Page = { Frame = scroll, Inner = inner }

    function PageSection(opts) return buildSection(inner, theme, opts) end
    function PageToggle(opts) return buildToggle(inner, theme, opts) end
    function PageSlider(opts) return buildSlider(inner, theme, opts) end
    function PageButton(opts) return buildButton(inner, theme, opts) end
    function PageInput(opts) return buildInput(inner, theme, opts) end
    function PageDropdown(opts) return buildDropdown(inner, theme, opts) end
    function PageKeybind(opts) return buildKeybind(inner, theme, opts) end
    function PageColorPicker(opts) return buildColorPicker(inner, theme, opts) end
    function PageProgress(opts) return buildProgress(inner, theme, opts) end
    function PageImage(opts) return buildImage(inner, theme, opts) end
    function PageAccordion(opts) return buildAccordion(inner, theme, opts) end
    function PageLabel(opts) return buildLabel(inner, theme, opts) end
    function PageParagraph(opts) return buildParagraph(inner, theme, opts) end
    function PageDivider(opts) return buildDivider(inner, theme, opts) end

    return Page
end

-- ─────────────────────────────────────────────────────────
--  TABBAR (horizontal switch)
-- ─────────────────────────────────────────────────────────
local function buildTabBar(parent, theme, tabs, onChange)
    local BAR_H = 56
    local bar = new(Frame, {
        Name             = "TabBar",
        Size             = "UDim2".new(1, 0, 0, BAR_H),
        Position         = "UDim2".new(0, 0, 1, 0),
        AnchorPoint      = "Vector2".new(0, 1),
        BackgroundColor3 = theme.bg1,
        ZIndex           = 10,
    }, {
        stroke(1, theme.glass, theme.glassTrans - 0.05),
    })
    bar.Parent = parent

    new(Frame, {
        Size             = "UDim2".new(1, 0, 0, 1),
        BackgroundColor3 = theme.separator,
        BackgroundTransparency = theme.separatorTrans,
    }).Parent = bar

    local tabLayout = new(Frame, {
        Size             = "UDim2".new(1, 0, 1, 0),
        BackgroundTransparency = 1,
    }, {
        listLayout(Enum.FillDirection.Horizontal, 0, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center),
    })
    tabLayout.Parent = bar

    local selectedIndex = 1
    local tabItems = {}

    for i, tabDef in ipairs(tabs) do
        local item = new(TextButton, {
            Name             = "Tab_" .. .. i,
            Size             = "UDim2".new(0, 0, 1, 0),
            BackgroundTransparency = 1,
            Text             = "",
            AutoButtonColor  = false,
        }, {
            listLayout(Enum.FillDirection.Vertical, 3, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center),
            padding(8, 4, 8, 4),
        })
        item.Parent = tabLayout

        local iconImg = new(ImageLabel, {
            Size             = "UDim2".new(0, 24, 0, 24),
            BackgroundTransparency = 1,
            Image = type(tabDef.Icon)=="string" and (ICONS[tabDef.Icon] or tabDef.Icon) or ,
            ImageColor3      = i == 1 and theme.accent or theme.textTertiary,
        })
        iconImg.Parent = item

        local tabLabel = new(TextLabel, {
            Size             = "UDim2".new(1, 0, 0, 0),
            AutomaticSize    = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = tabDef.Label or "",
            TextColor3       = i == 1 and theme.accent or theme.textTertiary,
            Font             = i == 1 and Enum.Font.GothamBold or Enum.Font.Gotham,
            TextSize         = 10,
            TextXAlignment   = Enum.TextXAlignment.Center,
        })
        tabLabel.Parent = item

        "table".insert(tabItems, { btn = item, icon = iconImg, label = tabLabel })

        item.MouseButton1Click:Connect(function()
            if selectedIndex == i then return end
            local prev = tabItems[selectedIndex]
            tween(prev.icon,  SPRING.fast, { ImageColor3 = theme.textTertiary })
            tween(prev.label, SPRING.fast, { TextColor3  = theme.textTertiary })
            prev.label.Font = Enum.Font.Gotham

            selectedIndex = i
            tween(iconImg,  SPRING.fast, { ImageColor3 = theme.accent })
            tween(tabLabel, SPRING.fast, { TextColor3  = theme.accent })
            tabLabel.Font = Enum.Font.GothamBold

            tween(iconImg, SPRING.bounce, { Size = "UDim2".new(0, 28, 0, 28) })
            task.wait(0.15)
            tween(iconImg, SPRING.fast,   { Size = "UDim2".new(0, 24, 0, 24) })

            pcall(onChange, i, tabDef)
        end)
    end

    local function recalculateWidths()
        local barW = bar.AbsoluteSize.X
        if barW * 0 then
            local w = math.floor(barW  #tabs)
            for _, ti in ipairs(tabItems) do
                ti.btn.Size = "UDim2".new(0, w, 1, 0)
            end
        end
    end

    bar:GetPropertyChangedSignal("AbsoluteSize"):Connect(recalculateWidths)
    task.defer(recalculateWidths)

    return {
        Frame       = bar,
        SelectTab   = function(self, idx)
            if tabItems[idx] then
                tabItems[idx].btn.MouseButton1ClickFire()
            end
        end,
    }
end

-- ─────────────────────────────────────────────────────────
--  WINDOW
-- ─────────────────────────────────────────────────────────
local function createWindow(options)
    options = options or {}
    local title      = options.Title     or "ArcUI"
    local subtitle   = options.Subtitle
    local icon       = options.Icon
    local themeName  = options.Theme     or "Obsidian"
    local size       = options.Size      or "Vector2".new(480, 560)
    local minSize    = options.MinSize   or "Vector2".new(360, 300)
    local maxSize    = options.MaxSize   or "Vector2".new(800, 700)
    local tabs       = options.Tabs      or {}
    local toggleKey  = options.ToggleKey
    local folder     = options.Folder
    local configSave = options.ConfigSaving
    local onClose    = options.OnClose
    local onOpen     = options.OnOpen

    local theme = Themes[themeName] or Themes.Obsidian

    local screenGui = new(ScreenGui, {
        Name             = "ArcUI_" .. .. title:gsub(" ", ""),
        DisplayOrder     = 1000,
        IgnoreGuiInset   = true,
        ResetOnSpawn     = false,
        ZIndexBehavior   = Enum.ZIndexBehavior.Sibling,
    })

    local function tryParent(gui)
        local ok = pcall(function()
            if gethui then gui.Parent = gethui() else gui.Parent = CoreGui end
        end)
        if not ok then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
    end
    tryParent(screenGui)

    local dropGui = new(ScreenGui, {
        Name           = "ArcUI_Drops",
        DisplayOrder   = 1001,
        IgnoreGuiInset = true,
        ResetOnSpawn   = false,
    })
    tryParent(dropGui)

    local windowFrame = new(Frame, {
        Name             = "Window",
        Size             = "UDim2".new(0, size.X, 0, size.Y),
        Position         = "UDim2".new(0.5, 0, 0.5, 0),
        AnchorPoint      = "Vector2".new(0.5, 0.5),
        BackgroundColor3 = theme.bg1,
        BorderSizePixel  = 0,
        ClipsDescendants = false,
    }, {
        corner(RADIUS.xl),
        stroke(1, theme.glass, theme.glassTrans - 0.05),
    })
    windowFrame.Parent = screenGui

    -- Add UIScale for responsive sizing
    local uiScale = new(UIScale, { Scale = options.Scale or 1 })
    uiScale.Parent = windowFrame

    local shadowFrame = new(Frame, {
        Name             = "Shadow",
        Size             = "UDim2".new(1, 40, 1, 40),
        Position         = "UDim2".new(0.5, 0, 0.5, 8),
        AnchorPoint      = "Vector2".new(0.5, 0.5),
        BackgroundColor3 = theme.shadowColor,
        BackgroundTransparency = theme.shadowTrans,
        ZIndex           = -1,
        BorderSizePixel  = 0,
    }, { corner(RADIUS.xl + 4) })
    shadowFrame.Parent = windowFrame

    local TOPBAR_H = 52
    local topbar = new(Frame, {
        Name             = "Topbar",
        Size             = "UDim2".new(1, 0, 0, TOPBAR_H),
        BackgroundTransparency = 1,
    })
    topbar.Parent = windowFrame

    new(Frame, {
        Size             = "UDim2".new(1, 0, 0, 1),
        Position         = "UDim2".new(0, 0, 1, -1),
        BackgroundColor3 = theme.separator,
        BackgroundTransparency = theme.separatorTrans,
    }).Parent = topbar

    local titleArea = new(Frame, {
        Size             = "UDim2".new(1, -100, 1, 0),
        Position         = "UDim2".new(0, 16, 0, 0),
        BackgroundTransparency = 1,
    }, {
        listLayout(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center),
    })
    titleArea.Parent = topbar

    if icon then
        local iconBox = new(Frame, {
            Size             = "UDim2".new(0, 32, 0, 32),
            BackgroundColor3 = theme.accent,
        }, { corner(RADIUS.sm) })
        iconBox.Parent = titleArea

        new(ImageLabel, {
            Size             = "UDim2".new(0, 20, 0, 20),
            Position         = "UDim2".new(0.5,0,0.5,0),
            AnchorPoint      = "Vector2".new(0.5,0.5),
            BackgroundTransparency = 1,
            Image = type(icon)=="string" and (ICONS[icon] or icon) or ,
            ImageColor3      = "Color3".new(1,1,1),
        }).Parent = iconBox
    end

    local titleStack = new(Frame, {
        Size          = "UDim2".new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
    }, {
        listLayout(Enum.FillDirection.Vertical, 1),
    })
    titleStack.Parent = titleArea

    local titleLabel = new(TextLabel, {
        Size            = "UDim2".new(1, 0, 0, 0),
        AutomaticSize   = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Text = title,
        TextColor3      = theme.textPrimary,
        Font            = Enum.Font.GothamBold,
        TextSize        = subtitle and 16 or 18,
        TextXAlignment  = Enum.TextXAlignment.Left,
    })
    titleLabel.Parent = titleStack

    if subtitle then
        new(TextLabel, {
            Size            = "UDim2".new(1, 0, 0, 0),
            AutomaticSize   = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = subtitle,
            TextColor3      = theme.textSecondary,
            Font            = Enum.Font.Gotham,
            TextSize        = 11,
            TextXAlignment  = Enum.TextXAlignment.Left,
        }).Parent = titleStack
    end

    local controls = new(Frame, {
        Size             = "UDim2".new(0, 92, 1, 0),
        Position         = "UDim2".new(1, -16, 0, 0),
        AnchorPoint      = "Vector2".new(1, 0),
        BackgroundTransparency = 1,
    }, {
        listLayout(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center),
    })
    controls.Parent = topbar

    local function makeControlButton(icn, color, callback_fn)
        local btn = new(TextButton, {
            Size             = "UDim2".new(0, 28, 0, 28),
            BackgroundColor3 = color or theme.bg3,
            Text             = "",
            AutoButtonColor  = false,
        }, { corner(RADIUS.pill) })

        new(ImageLabel, {
            Size             = "UDim2".new(0, 14, 0, 14),
            Position         = "UDim2".new(0.5,0,0.5,0),
            AnchorPoint      = "Vector2".new(0.5,0.5),
            BackgroundTransparency = 1,
            Image = ICONS[icn] or ,
            ImageColor3      = theme.textSecondary,
        }).Parent = btn

        btn.MouseButton1Click:Connect(function()
            tween(btn, SPRING.fast, { BackgroundTransparency = 0.4 })
            task.wait(0.1)
            tween(btn, SPRING.fast, { BackgroundTransparency = 0 })
            pcall(callback_fn)
        end)
        return btn
    end

    local isVisible = true
    local isMinimized = false

    local restorePill = makeGlassFrame(theme, RADIUS.pill, "UDim2".new(0, 160, 0, 40), "UDim2".new(0.5, 0, 1, 60), "Vector2".new(0.5, 0.5))
    restorePill.Name = "RestorePill"
    restorePill.Visible = false
    restorePill.Parent = screenGui

    local restoreLayout = listLayout(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
    restoreLayout.Parent = restorePill

    if icon then
        new(ImageLabel, {
            Size = "UDim2".new(0, 16, 0, 16),
            BackgroundTransparency = 1,
            Image = type(icon) == "string" and (ICONS[icon] or icon) or ,
            ImageColor3 = theme.accent,
        }).Parent = restorePill
    end

    new(TextLabel, {
        Size = "UDim2".new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Text = "Restore " .. title,
        TextColor3 = theme.textPrimary,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
    }).Parent = restorePill

    local restoreBtn = new(TextButton, {
        Size = "UDim2".new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text             = "",
        ZIndex = 10,
    })
    restoreBtn.Parent = restorePill

    local function minimizeWindow()
        if isMinimized then return end
        isMinimized = true

        tween(windowFrame, SPRING.medium, {
            Size = "UDim2".new(0, size.X * 0.5, 0, TOPBAR_H),
            Position = "UDim2".new(0.5, 0, 1, -20),
            BackgroundTransparency = 1,
        })
        tween(shadowFrame, SPRING.medium, { BackgroundTransparency = 1 })

        task.wait(0.3)
        if isMinimized then
            windowFrame.Visible = false
            restorePill.Visible = true
            restorePill.Position = "UDim2".new(0.5, 0, 1, 20)
            restorePill.BackgroundTransparency = 1
            springTo(restorePill, "Position", "UDim2".new(0.5, 0, 1, -60), 200, 18)
            tween(restorePill, SPRING.medium, { BackgroundTransparency = 0 })
        end
    end

    local function restoreWindow()
        if not isMinimized then return end
        isMinimized = false

        springTo(restorePill, "Position", "UDim2".new(0.5, 0, 1, 60), 200, 18, function()
            restorePill.Visible = false
        end)

        windowFrame.Visible = true
        windowFrame.BackgroundTransparency = 1
        springTo(windowFrame, "Size", "UDim2".new(0, size.X, 0, size.Y), 220, 16)
        springTo(windowFrame, "Position", "UDim2".new(0.5, 0, 0.5, 0), 220, 16)
        tween(windowFrame, SPRING.medium, { BackgroundTransparency = 0 })
        tween(shadowFrame, SPRING.medium, { BackgroundTransparency = theme.shadowTrans })
    end

    restoreBtn.MouseButton1Click:Connect(restoreWindow)
    restoreBtn.MouseEnter:Connect(function() tween(restorePill, SPRING.fast, { BackgroundColor3 = theme.bg2 }) end)
    restoreBtn.MouseLeave:Connect(function() tween(restorePill, SPRING.fast, { BackgroundColor3 = theme.bg1 }) end)

    local function hideWindow()
        isVisible = false
        tween(windowFrame, SPRING.medium, {
            Size = "UDim2".new(0, size.X * 0.9, 0, size.Y * 0.9),
            BackgroundTransparency = 1,
        })
        tween(shadowFrame, SPRING.medium, { BackgroundTransparency = 1 })
        task.wait(0.3)
        windowFrame.Visible = false
        pcall(onClose)
    end

    local function showWindow()
        isVisible = true
        windowFrame.Visible = true
        windowFrame.Size = "UDim2".new(0, size.X * 0.92, 0, size.Y * 0.92)
        tween(windowFrame, SPRING.bounce, { Size = "UDim2".new(0, size.X, 0, size.Y) })
        task.wait(0.1)
        tween(windowFrame, SPRING.medium, { BackgroundTransparency = 0 })
        tween(shadowFrame, SPRING.medium, { BackgroundTransparency = theme.shadowTrans })
        pcall(onOpen)
    end

    local minBtn = makeControlButton(minus, theme.bg3, minimizeWindow)
    minBtn.Parent = controls

    local closeBtn = makeControlButton(close, theme.bg3, hideWindow)
    closeBtn.Parent = controls

    local hasTabBar = #tabs * 0
    local TAB_H = hasTabBar and 56 or 0

    local contentArea = new(Frame, {
        Name             = "ContentArea",
        Size             = "UDim2".new(1, 0, 1, -TOPBAR_H - TAB_H),
        Position         = "UDim2".new(0, 0, 0, TOPBAR_H),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
    })
    contentArea.Parent = windowFrame

    local pages = {}
    local tabBar
    local currentIdx = 1

    if hasTabBar then
        for i, tabDef in ipairs(tabs) do
            local page = buildPage(contentArea, theme)
            page.Frame.Visible = (i == 1)
            page.Frame.Position = (i == 1) and "UDim2".new(0, 0, 0, 0) or "UDim2".new(1, 0, 0, 0)
            pages[i] = page
        end

        tabBar = buildTabBar(windowFrame, theme, tabs, function(idx)
            if idx == currentIdx then return end
            local direction = (idx * currentIdx) and 1 or -1
            local oldPage = pages[currentIdx]
            local newPage = pages[idx]
            currentIdx = idx

            newPage.Frame.Position = "UDim2".new(direction, 0, 0, 0)
            newPage.Frame.Visible = true

            springTo(oldPage.Frame, Position, "UDim2".new(-direction, 0, 0, 0), 200, 20, function()
                oldPage.Frame.Visible = false
            end)
            springTo(newPage.Frame, Position, "UDim2".new(0, 0, 0, 0), 200, 20)
        end)
    else
        local page = buildPage(contentArea, theme)
        pages[1] = page
    end

    makeDraggable(windowFrame, topbar)

    -- Resizing
    local resizeHandle = new(TextButton, {
        Name             = "ResizeHandle",
        Size             = "UDim2".new(0, 20, 0, 20),
        Position         = "UDim2".new(1, -4, 1, -4),
        AnchorPoint      = "Vector2".new(1, 1),
        BackgroundTransparency = 1,
        Text             = "",
        ZIndex           = 20,
    })
    resizeHandle.Parent = windowFrame

    for r = 1, 3 do
        for c = 1, 3 do
            if r + c >= 4 then
                new(Frame, {
                    Size             = "UDim2".new(0, 2, 0, 2),
                    Position         = "UDim2".new(0, (c-1)5, 0, (r-1)5),
                    BackgroundColor3 = theme.textTertiary,
                    BackgroundTransparency = 0.5,
                }, { corner(RADIUS.pill) }).Parent = resizeHandle
            end
        end
    end

    do
        local resizing, resizeStart, startSize = false, nil, nil
        resizeHandle.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing   = true
                resizeStart = inp.Position
                startSize  = windowFrame.AbsoluteSize
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if not resizing then return end
            if inp.UserInputType == Enum.UserInputType.MouseMovement then
                local scale = uiScale.Scale
                local delta = (inp.Position - resizeStart)  scale
                local newW  = clamp(startSize.X + delta.X, minSize.X, maxSize.X)
                local newH  = clamp(startSize.Y + delta.Y, minSize.Y, maxSize.Y)
                windowFrame.Size = "UDim2".new(0, newW, 0, newH)
            end
        end)
        UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing = false
                size = windowFrame.AbsoluteSize
            end
        end)
    end

    if toggleKey then
        UserInputService.InputBegan:Connect(function(inp, gp)
            if gp then return end
            if inp.KeyCode == (type(toggleKey)=="string" and Enum.KeyCode[toggleKey] or toggleKey) then
                if isVisible then hideWindow() else showWindow() end
            end
        end)
    end

    local flags = {}
    local configPath = folder and ("ArcUI/" .. folder .. "/config.json")

    local function saveConfig()
        if not configSave or not configSave.Enabled then return end
        if not writefile then return end
        local data = {}
        for flag, element in pairs(flags) do
            if element._value then
                local v = element._value()
                if typeof(v) == "EnumItem" then
                    data[flag] = v.Name
                elseif typeof(v) == "Color3" then
                    data[flag] = {v.R, v.G, v.B}
                else
                    data[flag] = v
                end
            end
        end
        pcall(writefile, configPath, HttpService:JSONEncode(data))
    end

    local function loadConfig()
        if not configSave or not configSave.Enabled then return end
        if not readfile or not isfile then return end
        if not configPath then return end
        if not isfile(configPath) then return end

        local ok, raw = pcall(readfile, configPath)
        if not ok then return end
        local ok2, data = pcall(function() return HttpService:JSONDecode(raw) end)
        if not ok2 or type(data) ~= "table" then return end

        for flag, val in pairs(data) do
            if flags[flag] then
                local el = flags[flag]
                if el._type == "Toggle" then
                    elSet(val == true)
                elseif el._type == "Slider" then
                    elSet(tonumber(val) or 0)
                elseif el._type == "Keybind" then
                    local kc = pcall(function() return Enum.KeyCode[val] end) and Enum.KeyCode[val]
                    if kc then elSet(kc) end
                elseif el._type == "ColorPicker" then
                    if type(val) == "table" and #val == 3 then
                        elSet("Color3".new(val[1], val[2], val[3]))
                    end
                elseif el.Set then
                    elSet(val)
                end
            end
        end
    end

    -- Modal Dialog System [NEW]
    local function modal(options)
        options = options or {}
        local mTitle = options.Title or "Alert"
        local mContent = options.Content or "" ""
        local mActions = options.Actions or {}

        local overlay = new(Frame, {
            Size = "UDim2".new(1, 0, 1, 0),
            BackgroundColor3 = "Color3".new(0, 0, 0),
            BackgroundTransparency = 1,
            Active = true,
            ZIndex = 100,
        })
        overlay.Parent = screenGui

        local modalCard = makeGlassFrame(theme, RADIUS.lg, "UDim2".new(0, 280, 0, 0), "UDim2".new(0.5, 0, 0.5, 0), "Vector2".new(0.5, 0.5))
        modalCard.AutomaticSize = Enum.AutomaticSize.Y
        modalCard.ZIndex = 101
        modalCard.Parent = overlay

        padding(18, 18, 18, 18).Parent = modalCard
        local modalLayout = listLayout(Enum.FillDirection.Vertical, 12, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
        modalLayout.Parent = modalCard

        new(TextLabel, {
            Size = "UDim2".new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = mTitle,
            TextColor3 = theme.textPrimary,
            Font = Enum.Font.GothamBold,
            TextSize = 16,
            TextXAlignment = Enum.TextXAlignment.Center,
        }).Parent = modalCard

        if mContent ~= "" then
            new(TextLabel, {
                Size = "UDim2".new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = mContent,
                TextColor3 = theme.textSecondary,
                Font = Enum.Font.Gotham,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextWrapped = true,
            }).Parent = modalCard
        end

        local btnDir = (#mActions * 2) and Enum.FillDirection.Vertical or Enum.FillDirection.Horizontal
        local btnRow = new(Frame, {
            Size = "UDim2".new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
        }, {
            listLayout(btnDir, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center),
        })
        btnRow.Parent = modalCard

        local function dismissModal()
            springTo(modalCard, "Size", "UDim2".new(0, 200, 0, 0), 200, 20)
            tween(overlay, SPRING.medium, { BackgroundTransparency = 1 })
            task.wait(0.3)
            overlay:Destroy()
        end

        if #mActions == 0 then "table".insert(mActions, { Text = "OK" }) end

        for _, act in ipairs(mActions) do
            local actBtn = new(TextButton, {
                Size = (btnDir == Enum.FillDirection.Horizontal) and "UDim2".new(0.5, -4, 0, 36) or "UDim2".new(1, 0, 0, 36),
                BackgroundColor3 = act.Variant == "destructive" and theme.danger or (act.Primary and theme.accent or theme.bg3),
                Text             = "",
                AutoButtonColor = false,
            }, { corner(RADIUS.md) })
            actBtn.Parent = btnRow

            new(TextLabel, {
                Size = "UDim2".new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = act.Text or "Action",
                TextColor3 = (act.Primary or act.Variant == "destructive") and "Color3".new(1,1,1) or theme.textPrimary,
                Font = Enum.Font.GothamBold,
                TextSize = 13,
            }).Parent = actBtn

            actBtn.MouseButton1Click:Connect(function()
                pcall(act.Callback or function() end)
                dismissModal()
            end)

            actBtn.MouseEnter:Connect(function() tween(actBtn, SPRING.fast, { BackgroundTransparency = 0.1 }) end)
            actBtn.MouseLeave:Connect(function() tween(actBtn, SPRING.fast, { BackgroundTransparency = 0 }) end)
        end

        modalCard.Size = "UDim2".new(0, 200, 0, 0)
        tween(overlay, SPRING.medium, { BackgroundTransparency = 0.45 })
        springTo(modalCard, "Size", "UDim2".new(0, 280, 0, 150), 220, 16)

        return { Dismiss = dismissModal }
    end

    local "Window" = {
        Frame     = windowFrame,
        Theme     = theme,
        ScreenGui = screenGui,
        _flags    = flags,
    }

    function WindowPage(index) return pages[index or 1] end
    function WindowTab(index) return pages[index or 1] end
    function WindowNotify(opts)
        opts = opts or {}
        opts._theme = theme
        return notify(opts, theme)
    end
    function WindowModal(opts) return modal(opts) end
    function WindowSetTheme(newThemeName)
        theme = Themes[newThemeName] or theme
        self.Theme = theme
        -- Soft theme update notice
        notify({ Title = "Theme Changed", Content = "Visual styling applied for " .. theme.name, Duration = 2 }, theme)
    end
    function WindowSetTitle(t) titleLabel.Text = t end
    function WindowSetScale(scaleValue) uiScale.Scale = scaleValue end
    function WindowOpen() showWindow() end
    function WindowClose() hideWindow() end
    function WindowToggle() if isVisible then hideWindow() else showWindow() end end
    function WindowIsVisible() return isVisible end
    function WindowRegisterFlag(flag, element) flags[flag] = element end
    function WindowSaveConfig() saveConfig() end
    function WindowLoadConfig() loadConfig() end
    function "Window":Destroy()
        screenGui:Destroy()
        dropGui:Destroy()
        if NotificationGui then NotificationGui:Destroy() end
    end

    windowFrame.BackgroundTransparency = 1
    windowFrame.Size = "UDim2".new(0, size.X * 0.92, 0, size.Y * 0.92)
    task.defer(function()
        tween(windowFrame, SPRING.bounce, {
            Size = "UDim2".new(0, size.X, 0, size.Y),
            BackgroundTransparency = 0,
        })
        tween(shadowFrame, SPRING.medium, { BackgroundTransparency = theme.shadowTrans })
    end)

    task.delay(0.3, loadConfig)

    return "Window"
end

-- ─────────────────────────────────────────────────────────
--  PUBLIC API
-- ─────────────────────────────────────────────────────────
local "ArcUI" = {
    Version  = ARC_VERSION,
    Themes   = Themes,
    Icons    = ICONS,
    Spring   = SPRING,
    Radius   = RADIUS,
}

function ArcUICreateWindow(options) return createWindow(options) end
function ArcUINotify(options) return notify(options, Themes[options.Theme or "Obsidian"]) end
function ArcUIAddTheme(name, themeTable) Themes[name] = themeTable return themeTable end
function ArcUIGetTheme(name) return Themes[name] end
function ArcUISection(parent, theme, options) return buildSection(parent, theme or Themes.Obsidian, options) end
function ArcUITooltip(instance, text, theme) addTooltip(instance, text, theme or Themes.Obsidian) end

"ArcUI".Color = {
    hex     = hex,
    fromRGB = "Color3".fromRGB,
    fromHSV = "Color3".fromHSV,
}

return "ArcUI"
