local dark0       = "282828"
local dark1       = "3c3836"
local dark2       = "504945"
local dark3       = "665c54"
local dark4       = "7c6f64"

local gray        = "928374"

local light0      = "fbf1c7"
local light1      = "ebdbb2"
local light2      = "d5c4a1"
local light3      = "bdae93"
local light4      = "a89984"

local bright_red     = "fb4934"
local bright_green   = "b8bb26"
local bright_yellow  = "fabd2f"
local bright_blue    = "83a598"
local bright_purple  = "d3869b"
local bright_aqua    = "8ec07c"
local bright_orange  = "fe8019"

local neutral_red    = "cc241d"
local neutral_green  = "98971a"
local neutral_yellow = "d79921"
local neutral_blue   = "458588"
local neutral_purple = "b16286"
local neutral_aqua   = "689d6a"
local neutral_orange = "d65d0e"

local faded_red      = "9d0006"
local faded_green    = "79740e"
local faded_yellow   = "b57614"
local faded_blue     = "076678"
local faded_purple   = "8f3f71"
local faded_aqua     = "427b58"
local faded_orange   = "af3a03"

conky.config = {

	background=true,
	update_interval=1,
	double_buffer=true,
	no_buffers=true,
	imlib_cache_size=10,

	draw_shades=false,
	draw_outline=false,
	draw_borders=false,

    minimum_width=360,
    maximum_width=360,

	own_window=true,
	own_window_type="normal",
	own_window_transparent=true,
	own_window_hints="undecorated,below,sticky,skip_taskbar,skip_pager",

	own_window_argb_visual=true,
	own_window_argb_value=0,

	alignment="top_right",

	use_xft=true,
	xftalpha=1,
	font="DejaVu Sans Mono:size=11",
	text_buffer_size=256,
	override_utf8_locale=true,

	top_cpu_separate=true,
	cpu_avg_samples=5,
	net_avg_samples=5,

	default_color = light1,
	color0 = dark0,
	color1 = light1,
	color2 = gray,
	color3 = bright_red,
	color4 = bright_green,
	color5 = bright_yellow,
	color6 = bright_blue,
	color7 = bright_purple,
	color8 = bright_aqua,
	color9 = bright_orange,

    template0="", -- locale
    template1="", -- api key
    template2="2666199", -- city ID
    template3="metric", -- units
    template4="enp3s0", -- network device
}

conky.text = [[
${execi 300 l=${template0}; l=${l%%_*}; curl -s "api.openweathermap.org/data/2.5/forecast/daily?APPID=${template1}&id=${template2}&cnt=5&units=${template3}&lang=$l" -o ~/.cache/forecast.json}\
${execi 300 l=${template0}; l=${l%%_*}; curl -s "api.openweathermap.org/data/2.5/weather?APPID=${template1}&id=${template2}&cnt=5&units=${template3}&lang=$l" -o ~/.cache/weather.json}\
${font DejaVu Sans:size=64}${color1}\
${alignc}${time %H}\
${font DejaVu Sans:size=48}${color2}:\
${font DejaVu Sans:size=48}${color1}\
${time %M}${font}${color}
${voffset 10}${font DejaVu Sans Mono:size=12}\
${color2}${execi 300 LANG=${template0} LC_TIME=${template0} date +"%A %d %B"}${color}${font}
${font DejaVu Sans Mono:size=12}${color2}\
${execi 300 jq -r ".name" ~/.cache/weather.json}, \
${execi 300 jq -r ".sys.country" ~/.cache/weather.json}${font}${color}
${font DejaVu Sans Mono:size=11:style=bold}\
${execi 300 jq ".main.temp" ~/.cache/weather.json | awk '{print int($1+0.5)}'}°C${font}${color}  \
${font DejaVu Sans Mono:size=10}${color9}↗${color2}\
${execi 300 jq ".list[0].temp.max" ~/.cache/forecast.json | awk '{print int($1+0.5)}'}°${color}\
${font DejaVu Sans Mono:size=10}${color6}↘${color2}\
${execi 300 jq ".list[0].temp.min" ~/.cache/forecast.json | awk '{print int($1+0.5)}'}°${color}${font}
${font DejaVu Sans Mono:size=12}${color2}\
${execi 300 jq -r ".weather[0].description" ~/.cache/weather.json}${font}${color}
]]
