--[[
Copyright © 2015, Mykezero
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of <addon name> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <your name> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]--

_addon.name = 'HST'
_addon.author = 'Mykezero'
_addon.version = '1.0.0.0'
_addon.command = 'hst'
_addon.language = 'english'

require('luau')
require('tables')


local defaults = {}
defaults.threshold = 0
defaults.script = "default.txt"
defaults.runonce = true
defaults.hasrun = false

---------------------------------------------------------------------------------------------------
-- func: addon command
-- desc:
---------------------------------------------------------------------------------------------------
windower.register_event('addon command',function(...)
	-- Parse arguments
	args = {...}

	print(#args)

	if (#args >= 1) then
		defaults.threshold = args[1]
		print("Threshold Trigger: " .. defaults.threshold)
	end

	if (#args >= 2) then
		defaults.script = args[2]
		print("Script: " .. defaults.script)
	end

	if (#args >= 3) then
		defaults.runonce = boolify(args[3])
		print("Run Once: " .. args[3])
	end
end)

---------------------------------------------------------------------------------------------------
-- func: boolify
-- desc: string to bool
---------------------------------------------------------------------------------------------------
function boolify(message)
	return (message == 'true') and true or false
end

---------------------------------------------------------------------------------------------------
-- func: target change
-- desc: reset hasrun on changed target.
---------------------------------------------------------------------------------------------------
windower.register_event('target change', function(index)
	defaults.hasrun = false
end)

---------------------------------------------------------------------------------------------------
-- func: prerender
-- desc:
---------------------------------------------------------------------------------------------------
windower.register_event('prerender', function()
	local mob = windower.ffxi.get_mob_by_target('t')

	-- Don't execute command if it has run once already.
	if defaults.runonce and defaults.hasrun then return end

	if (mob and (mob.hpp < tonumber(defaults.threshold))) then
		if windower.file_exists(windower.addon_path .. defaults.script) then
			windower.send_command('exec ../addons/hst/' .. defaults.script)
			defaults.hasrun = true
		end
	end
end)
