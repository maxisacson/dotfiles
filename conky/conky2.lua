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

	alignment="bottom_right",

	use_xft=true,
	xftalpha=1,
	font="DejaVu Sans Mono:size=11",
	text_buffer_size=256,
	override_utf8_locale=true,

	top_cpu_separate=true,
	cpu_avg_samples=2,

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
    template4="/", -- mount point
}

conky.text = [[
${color1}CPU0${goto 50}${color0}${cpubar cpu1 12,200} ${color1}${cpu cpu1}%
${color1}CPU1${goto 50}${color0}${cpubar cpu2 12,200} ${color1}${cpu cpu2}%
${color1}CPU2${goto 50}${color0}${cpubar cpu3 12,200} ${color1}${cpu cpu3}%
${color1}CPU3${goto 50}${color0}${cpubar cpu4 12,200} ${color1}${cpu cpu4}%
${voffset 10}${color1} MEM${goto 50}${color0}${membar 12,200} ${color1}${memperc}%
${goto 50}${color1}${font DejaVu Sans Mono:size=11:style=bold}\
${mem}${color2} ${font}/ ${memmax}${color}
${voffset 10}${color1}SWAP${goto 50}${color0}${swapbar 12,200} ${color1}${swapperc}%
${goto 50}${color1}${font DejaVu Sans Mono:size=11:style=bold}\
${swap}${color2} ${font}/ ${swapmax}${color}

${color2}$nodename${color}
${color2}$sysname $kernel $machine${color}
${color2}Uptime: ${color1}${uptime}${color}${font}
${color2}Load: ${font DejaVu Sans Mono:size=11:style=bold}\
${color1}${loadavg 1} ${font}${color4}${loadavg 2} ${color5}${loadavg 3}${color}

${font DejaVu Sans Mono:size=11}\
${color2}╾╼${color} CPU ${color2}╾╼╾────╼${color} MEM ${color2}╾────╼${color}${font}
${font DejaVu Sans Mono:size=11:style=bold}\
${top cpu 1}%${goto 90}${top mem 1}%${goto 165}${top mem_res 1}${goto 250}${color5}${top name 1}${color}${font}
${top cpu 2}%${goto 90}${top mem 2}%${goto 165}${top mem_res 2}${goto 250}${color5}${top name 2}${color}
${top cpu 3}%${goto 90}${top mem 3}%${goto 165}${top mem_res 3}${goto 250}${color5}${top name 3}${color}
${top cpu 4}%${goto 90}${top mem 4}%${goto 165}${top mem_res 4}${goto 250}${color5}${top name 4}${color}
${top cpu 5}%${goto 90}${top mem 5}%${goto 165}${top mem_res 5}${goto 250}${color5}${top name 5}${color}
${color2}╾────────────────────────╼${color}
${template4}\
${font DejaVu Sans Mono:size=11:style=bold}\
${goto 50}${color}${fs_free ${template4}}${color}${font} \
${color2}${fs_used ${template4}} / ${color2}${fs_size ${template4}} \
${fs_used_perc ${template4}}%${color}
]]
