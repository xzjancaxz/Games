oundInstance == nil then
		v_u_139 = p138
	else
		error((("[%*]: Can\'t change parent for bound Replica"):format(script.Name)))
		v_u_139 = p138
	end
	while p138 ~= nil do
		p138 = p138.Parent
		if p138 == p137 then
			error((("[%*]: Can\'t set descendant Replica as parent"):format(script.Name)))
		end
	end
	local v_u_140 = p137.Parent
	if v_u_140 ~= v_u_139 then
		p137.Parent = v_u_139
		if v_u_140 ~= nil then
			v_u_140.Children[p137] = nil
		end
		v_u_139.Children[p137] = true
		local function v145(p141)
			-- upvalues: (copy) v_u_140, (copy) v_u_139
			local v142 = p141.Id
			local v143 = tostring(v142)
			if v_u_140 ~= nil and v_u_140.creation ~= nil then
				v_u_140.creation[v143] = nil
			end
			if v_u_139.creation ~= nil then
				local v144 = p141.self_creation
				v144[4] = p141.Parent.Id
				v_u_139.creation[v143] = v144
			end
			p141.creation = v_u_139.creation
			p141.replication = v_u_139.replication
		end
		local v146 = p137.Id
		local v147 = tostring(v146)
		if v_u_140 ~= nil and v_u_140.creation ~= nil then
			v_u_140.creation[v147] = nil
		end
		if v_u_139.creation ~= nil then
			local v148 = p137.self_creation
			v148[4] = p137.Parent.Id
			v_u_139.creation[v147] = v148
		end
		p137.creation = v_u_139.creation
		p137.replication = v_u_139.replication
		for v149 in pairs(p137.Children) do
			v_u_38(v149, v145)
		end
		local v150 = p137.Id
		local v151 = v_u_139.Id
		local v_u_152 = v_u_139.creation
		local v153 = v_u_7
		if v_u_140 ~= nil and v_u_140.replication ~= nil then
			if v_u_140.replication.ALL == true then
				v153 = v_u_12
			else
				v153 = v_u_140.replication
			end
		end
		local v154 = v_u_7
		if v_u_139 ~= nil and v_u_139.replication ~= nil then
			if v_u_139.replication.ALL == true then
				v154 = v_u_12
			else
				v154 = v_u_139.replication
			end
		end
		if v_u_140 ~= nil and (v_u_140.replication ~= nil and (v_u_139.replication ~= v_u_140.replication and v154 ~= v_u_12)) then
			for v155 in pairs(v153) do
				if v154[v155] == nil then
					v_u_27:FireClient(v155, v150)
				end
			end
		end
		if v_u_139.replication ~= nil then
			local v156 = nil
			for v157 in pairs(v154) do
				if v153[v157] == true then
					v_u_24:FireClient(v157, v150, v151)
				else
					if v156 == nil then
						local v_u_158 = {}
						local function v162(p159)
							-- upvalues: (ref) v_u_158, (copy) v_u_152
							local v160 = p159.Id
							local v161 = tostring(v160)
							v_u_158[v161] = v_u_152[v161]
						end
						local v163 = p137.Id
						local v164 = tostring(v163)
						v_u_158[v164] = v_u_152[v164]
						v156 = v_u_158
						for v165 in pairs(p137.Children) do
							v_u_38(v165, v162)
						end
					end
					v_u_25:FireClient(v157, v156, v150)
				end
			end
		end
	end
end
function v_u_63.BindToInstance(p166, p167)
	-- upvalues: (copy) v_u_34, (copy) v_u_12, (copy) v_u_26
	if typeof(p167) ~= "Instance" then
		error((("[%*]: \"instance\" argument is not an Instance (%*)"):format(script.Name, (tostring(p167)))))
	end
	if p166.Parent ~= nil then
		error((("[%*]: Can\'t bind Replica parented to another Replica"):format(script.Name)))
	end
	if p166.BoundInstance ~= nil then
		error((("[%*]: Can\'t change Replica bind to another Instance"):format(script.Name)))
	end
	if p167:IsA("Model") == true and (p167.ModelStreamingMode == Enum.ModelStreamingMode.Default or p167.ModelStreamingMode == Enum.ModelStreamingMode.Nonatomic) then
		warn(("[%*]: Bound Replica to a model that has inproper \"ModelStreamingMode\" setup; Traceback:\n"):format(script.Name) .. debug.traceback())
	end
	local v168 = v_u_34:Clone()
	v168.Value = p166.Id
	p166.Tags.Bind = true
	p166.BoundInstance = p167
	p166.bind_value = v168
	v168.Parent = p167
	local v169 = p166.Id
	if p166.replication ~= nil then
		if p166.replication.ALL == true then
			for v170 in pairs(v_u_12) do
				v_u_26:FireClient(v170, v169)
			end
			return
		end
		for v171 in pairs(p166.replication) do
			v_u_26:FireClient(v171, v169)
		end
	end
end
function v_u_63.Replicate(p172)
	-- upvalues: (copy) v_u_14, (copy) v_u_12, (copy) v_u_25, (copy) v_u_16, (copy) v_u_15
	if p172.Parent ~= nil then
		error((("[%*]: Can\'t selectively replicate Replica parented to another Replica"):format(script.Name)))
	end
	if p172.creation == nil then
		GenerateCreation(p172)
		v_u_14[p172] = true
	elseif p172.replication.ALL == true then
		return
	end
	local v173 = p172.creation
	local v174 = p172.replication
	for v175 in pairs(v_u_12) do
		if v174[v175] == nil then
			v_u_25:FireClient(v175, v173)
		else
			v_u_16[v175][p172] = nil
		end
	end
	table.clear(v174)
	v174.ALL = true
	v_u_15[p172] = true
end
function v_u_63.DontReplicate(p176)
	-- upvalues: (copy) v_u_15, (copy) v_u_12, (copy) v_u_27, (copy) v_u_16
	if p176.Parent ~= nil then
		error((("[%*]: Can\'t selectively replicate Replica parented to another Replica"):format(script.Name)))
	end
	local v177 = p176.replication
	if v177 ~= nil and next(v177) ~= nil then
		v_u_15[p176] = nil
		local v178 = p176.Id
		if v177.ALL == true then
			for v179 in pairs(v_u_12) do
				v_u_27:FireClient(v179, v178)
			end
		else
			for v180 in pairs(v177) do
				v_u_27:FireClient(v180, v178)
				v_u_16[v180][p176] = nil
			end
		end
		table.clear(v177)
	end
end
function v_u_63.Subscribe(p181, p182)
	-- upvalues: (copy) v_u_14, (copy) v_u_12, (copy) v_u_16, (copy) v_u_25
	if p181.Parent ~= nil then
		error((("[%*]: Can\'t selectively replicate Replica parented to another Replica"):format(script.Name)))
	end
	if p181.creation == nil then
		GenerateCreation(p181)
		v_u_14[p181] = true
	elseif p181.replication.ALL == true then
		error((("[%*]: \"Subscribe()\" is locked after calling \"Replicate()\""):format(script.Name)))
	end
	if v_u_12[p182] == nil then
		warn(("[%*]: Called \"Subscribe()\" on a non-ready player; Traceback:\n"):format(script.Name) .. debug.traceback())
		return
	else
		local v183 = p181.creation
		local v184 = p181.replication
		if v184[p182] == nil then
			v184[p182] = true
			v_u_16[p182][p181] = true
			v_u_25:FireClient(p182, v183)
		end
	end
end
function v_u_63.Unsubscribe(p185, p186)
	-- upvalues: (copy) v_u_16, (copy) v_u_27
	if p185.Parent ~= nil then
		error((("[%*]: Can\'t selectively replicate Replica parented to another Replica"):format(script.Name)))
	end
	local v187 = p185.replication
	if v187 ~= nil then
		if v187.ALL == true then
			error((("[%*]: \"Unsubscribe()\" is locked after calling \"Replicate()\""):format(script.Name)))
		end
		if v187[p186] ~= nil then
			v187[p186] = nil
			v_u_16[p186][p185] = nil
			v_u_27:FireClient(p186, p185.Id)
		end
	end
end
function v_u_63.Identify(p188)
	local v189 = ""
	local v190 = true
	for v191, v192 in pairs(p188.Tags) do
		v189 = v189 .. ("%*%*=%*"):format(v190 == true and "" or ";", tostring(v191), (tostring(v192)))
		v190 = false
	end
	return ("[Id:%*;Token:%*;Tags:{%*}]"):format(p188.Id, p188.Token, v189)
end
function v_u_63.IsActive(p193)
	return p193.Maid:IsActive()
end
local function v_u_198(p194)
	-- upvalues: (copy) v_u_198, (copy) v_u_13, (copy) v_u_6, (copy) v_u_65
	for v195 in pairs(p194.Children) do
		v_u_198(v195)
	end
	local v196 = p194.Id
	v_u_13[v196] = nil
	p194.Maid:Unlock(v_u_6)
	p194.Maid:Cleanup()
	if p194.BoundInstance ~= nil then
		p194.BoundInstance = nil
		p194.bind_value:Destroy()
		p194.bind_value = nil
	end
	if p194.creation ~= nil then
		p194.creation[tostring(v196)] = nil
	end
	local v197 = v_u_65
	setmetatable(p194, v197)
end
function v_u_63.Destroy(p199)
	-- upvalues: (copy) v_u_13, (copy) v_u_14, (copy) v_u_12, (copy) v_u_27, (copy) v_u_16, (copy) v_u_15, (copy) v_u_198
	local v200 = p199.Id
	if v_u_13[v200] ~= nil then
		local v201 = v_u_14[p199] == true
		if p199.replication ~= nil then
			if p199.replication.ALL == true then
				for v202 in pairs(v_u_12) do
					v_u_27:FireClient(v202, v200)
				end
			else
				for v203 in pairs(p199.replication) do
					v_u_27:FireClient(v203, v200)
					if v201 == true then
						v_u_16[v203][p199] = nil
					end
				end
			end
		end
		v_u_14[p199] = nil
		v_u_15[p199] = nil
		if p199.Parent ~= nil then
			p199.Parent.Children[p199] = nil
		end
		v_u_198(p199)
	end
end
local v204 = {
	["Identify"] = true,
	["Destroy"] = true
}
for v_u_205, v206 in pairs(v_u_63) do
	if v_u_205 ~= "__index" then
		if v204[v_u_205] == true then
			v_u_65[v_u_205] = v206
		else
			v_u_65[v_u_205] = function(p207)
				-- upvalues: (copy) v_u_205
				error((("[%*]: Tried to call method \"%*\" for a destroyed replica; %*"):format(script.Name, v_u_205, (p207:Identify()))))
			end
		end
	end
end
v_u_17.OnServerEvent:Connect(function(p208)
	-- upvalues: (copy) v_u_12, (copy) v_u_10, (copy) v_u_15, (copy) v_u_25, (copy) v_u_17, (copy) v_u_16, (copy) v_u_63
	if v_u_12[p208] == nil or p208:IsDescendantOf(v_u_10) ~= true then
		local v209 = {}
		for v210 in pairs(v_u_15) do
			local v211 = v210.creation
			table.insert(v209, v211)
		end
		v_u_25:FireClient(p208, v209)
		v_u_17:FireClient(p208)
		v_u_12[p208] = true
		v_u_16[p208] = {}
		v_u_63.NewReadyPlayer:Fire(p208)
	end
end)
local function v215(p212, p213, ...)
	-- upvalues: (copy) v_u_12, (copy) v_u_11, (copy) v_u_13
	if v_u_12[p212] ~= nil and (v_u_11:CheckRate(p212) ~= false and type(p213) == "number") then
		local v214 = v_u_13[p213]
		if v214 ~= nil and (v214.replication ~= nil and (v214.replication.ALL == true or v214.replication[p212] ~= nil)) then
			v214.OnServerEvent:Fire(p212, ...)
		end
	end
end
v_u_23.OnServerEvent:Connect(v215)
v_u_28.OnServerEvent:Connect(v215)
v_u_10.PlayerRemoving:Connect(function(p216)
	-- upvalues: (copy) v_u_12, (copy) v_u_16, (copy) v_u_63
	if v_u_12[p216] ~= nil then
		for v217 in pairs(v_u_16[p216]) do
			v217.replication[p216] = nil
		end
		v_u_12[p216] = nil
		v_u_16[p216] = nil
		v_u_63.RemovingReadyPlayer:Fire(p216)
	end
end)
return v_u_63]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[server]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3170"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["dependencies"] = {},
	["package"] = {
		["description"] = "Replica is a Roblox server to client state replication solution by LM-loleris",
		["name"] = "aykut92/replica",
		["realm"] = "shared",
		["registry"] = "https://github.com/UpliftGames/wally-index",
		["version"] = "0.1.7"
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[wally]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="3171"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Shared]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3172"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = nil
local function v_u_4(p2, ...)
	-- upvalues: (ref) v_u_1
	local v3 = v_u_1
	v_u_1 = nil
	p2(...)
	v_u_1 = v3
end
local function v_u_5(...)
	-- upvalues: (copy) v_u_4
	v_u_4(...)
	while true do
		v_u_4(coroutine.yield())
	end
end
local function v_u_10(p6, ...)
	local v7 = typeof(p6)
	if v7 == "function" then
		p6(...)
		return
	elseif v7 == "RBXScriptConnection" then
		p6:Disconnect()
		return
	elseif v7 == "Instance" then
		p6:Destroy()
	elseif v7 == "table" then
		local v8 = p6.Destroy
		if type(v8) == "function" then
			p6:Destroy()
			return
		end
		local v9 = p6.Disconnect
		if type(v9) == "function" then
			p6:Disconnect()
		end
	end
end
local function v_u_12(...)
	-- upvalues: (ref) v_u_1, (copy) v_u_5, (copy) v_u_10
	if not v_u_1 then
		v_u_1 = coroutine.create(v_u_5)
	end
	local v11 = v_u_1
	task.spawn(assert(v11), v_u_10, ...)
end
local v_u_13 = {}
v_u_13.__index = v_u_13
function v_u_13.New(p14, p15)
	-- upvalues: (copy) v_u_13
	local v16 = {
		["maid"] = p14,
		["object"] = p15
	}
	local v17 = v_u_13
	setmetatable(v16, v17)
	return v16
end
function v_u_13.Destroy(p18)
	p18.maid.tokens[p18] = nil
end
function v_u_13.Cleanup(p19, ...)
	-- upvalues: (copy) v_u_12
	if p19.object ~= nil then
		p19.maid.tokens[p19] = nil
		v_u_12(p19.object, ...)
		p19.object = nil
	end
end
local v_u_20 = {}
v_u_20.__index = v_u_20
function v_u_20.New(p21)
	-- upvalues: (copy) v_u_20
	local v22 = {
		["tokens"] = {},
		["is_cleaned"] = false,
		["key"] = p21
	}
	local v23 = v_u_20
	setmetatable(v22, v23)
	return v22
end
function v_u_20.IsActive(p24)
	return not p24.is_cleaned
end
function v_u_20.Add(p25, p26)
	-- upvalues: (copy) v_u_12, (copy) v_u_13
	if p25.is_cleaned == true then
		v_u_12(p26)
	end
	local v27 = typeof(p26)
	if v27 == "table" then
		local v28 = p26.Destroy
		if type(v28) ~= "function" then
			local v29 = p26.Disconnect
			if type(v29) ~= "function" then
				error((("[%*]: Received table as cleanup object, but couldn\'t detect a :Destroy() or :Disconnect() method"):format(script.Name)))
			end
		end
	elseif v27 ~= "function" and (v27 ~= "RBXScriptConnection" and v27 ~= "Instance") then
		error((("[%*]: Cleanup of type \"%*\" not supported"):format(script.Name, v27)))
	end
	local v30 = v_u_13.New(p25, p26)
	p25.tokens[v30] = true
	return v30
end
function v_u_20.Cleanup(p31, ...)
	if p31.key ~= nil then
		error((("[%*]: \"Cleanup()\" is locked for this Maid"):format(script.Name)))
	end
	p31.is_cleaned = true
	for v32 in pairs(p31.tokens) do
		v32:Cleanup(...)
	end
end
function v_u_20.Unlock(p33, p34)
	if p33.key ~= nil and p33.key ~= p34 then
		error((("[%*]: Invalid lock key"):format(script.Name)))
	end
	p33.key = nil
end
return v_u_20]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Maid]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3173"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local v_u_2 = {}
local v_u_3 = {}
local v_u_4 = {}
v_u_4.__index = v_u_4
function v_u_4.New(p5, p6)
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	if p5 <= 0 then
		error("[RateLimit]: Invalid rate")
	end
	local v7 = {
		["sources"] = {},
		["rate_period"] = 1 / p5,
		["is_full_wait"] = p6 == true
	}
	local v8 = v_u_4
	setmetatable(v7, v8)
	v_u_3[v7] = true
	return v7
end
function v_u_4.CheckRate(p9, p10)
	-- upvalues: (copy) v_u_2
	local v11 = p9.sources
	local v12 = os.clock()
	local v13 = p10 == nil and "nil" or p10
	local v14 = v11[v13]
	if v14 == nil then
		if typeof(v13) == "Instance" and (v13:IsA("Player") and v_u_2[v13] == nil) then
			return false
		end
		v11[v13] = v12 + p9.rate_period
		return true
	end
	if p9.is_full_wait == true then
		if v14 > v12 then
			return false
		end
		v11[v13] = v12 + p9.rate_period
		return true
	end
	local v15 = v14 + p9.rate_period
	local v16 = math.max(v12, v15)
	if v16 - v12 >= 1 then
		return false
	end
	v11[v13] = v16
	return true
end
function v_u_4.CleanSource(p17, p18)
	p17.sources[p18] = nil
end
function v_u_4.Cleanup(p19)
	p19.sources = {}
end
function v_u_4.Destroy(p20)
	-- upvalues: (copy) v_u_3
	v_u_3[p20] = nil
end
for _, v21 in ipairs(v1:GetPlayers()) do
	v_u_2[v21] = true
end
v1.PlayerAdded:Connect(function(p22)
	-- upvalues: (copy) v_u_2
	v_u_2[p22] = true
end)
v1.PlayerRemoving:Connect(function(p23)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	v_u_2[p23] = nil
	for v24 in pairs(v_u_3) do
		v24.sources[p23] = nil
	end
end)
return v_u_4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RateLimit]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3174"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("RunService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v3 = v1:IsStudio()
local v_u_4 = v1:IsServer()
local v_u_5 = {}
local v_u_6 = nil
local v_u_7
if v_u_4 == true then
	v_u_7 = v_u_2:FindFirstChild("RemoteEvents")
	if v_u_7 == nil then
		v_u_7 = Instance.new("Folder")
		v_u_7.Name = "RemoteEvents"
		v_u_7.Parent = v_u_2
	elseif v3 == true then
		warn((("[%*]: ReplicatedStorage \"RemoteEvents\" container was already defined"):format(script.Name)))
	end
else
	v_u_7 = v_u_2:FindFirstChild("RemoteEvents")
	if v_u_7 == nil then
		local v_u_8 = Instance.new("BindableEvent")
		task.spawn(function()
			-- upvalues: (ref) v_u_7, (copy) v_u_2, (ref) v_u_8
			while task.wait() do
				v_u_7 = v_u_2:FindFirstChild("RemoteEvents")
				if v_u_7 ~= nil then
					v_u_8:Fire()
					return
				end
			end
		end)
		v_u_6 = v_u_8
	end
end
local v_u_9 = {}
v_u_9.__index = v_u_9
function v_u_9.New(p10)
	-- upvalues: (copy) v_u_9
	local v11 = v_u_9
	return setmetatable({
		["fn"] = p10,
		["is_disconnected"] = false,
		["real_connection"] = nil
	}, v11)
end
function v_u_9.Disconnect(p12)
	p12.is_disconnected = true
	if p12.real_connection ~= nil then
		p12.real_connection:Disconnect()
	end
end
local v_u_13 = {}
v_u_13.__index = v_u_13
function v_u_13.New(p_u_14, p15)
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (ref) v_u_7, (copy) v_u_9, (copy) v_u_13, (ref) v_u_6
	if type(p_u_14) ~= "string" then
		error((("[%*]: name must be a string"):format(script.Name)))
	end
	if v_u_4 == true then
		if v_u_5[p_u_14] ~= nil then
			error((("[%*]: RemoteEvent %* was already defined"):format(script.Name, p_u_14)))
		end
		v_u_5[p_u_14] = true
		local v16 = Instance.new(p15 == true and "UnreliableRemoteEvent" or "RemoteEvent")
		v16.Name = p_u_14
		v16.Parent = v_u_7
		return v16
	end
	local v_u_17 = v_u_7
	if v_u_17 then
		v_u_17 = v_u_7:FindFirstChild(p_u_14)
	end
	if v_u_17 ~= nil then
		return v_u_17
	end
	local v_u_18 = {}
	local v22 = {
		["OnClientEvent"] = {
			["Connect"] = function(_, p19)
				-- upvalues: (ref) v_u_17, (ref) v_u_9, (ref) v_u_18
				if v_u_17 ~= nil then
					return v_u_17.OnClientEvent:Connect(p19)
				end
				local v20 = v_u_9.New(p19)
				local v21 = v_u_18
				table.insert(v21, v20)
				return v20
			end
		},
		["OnServerEvent"] = {
			["Connect"] = function()
				error((("[%*]: Can\'t connect to \"OnServerEvent\" client-side"):format(script.Name)))
			end
		},
		["RemoteEvent"] = nil
	}
	local v23 = v_u_13
	local v_u_24 = setmetatable(v22, v23)
	local function v_u_27()
		-- upvalues: (ref) v_u_17, (ref) v_u_7, (copy) p_u_14, (ref) v_u_18, (copy) v_u_24
		local v25 = os.clock()
		while true do
			v_u_17 = v_u_7:FindFirstChild(p_u_14)
			if v_u_17 ~= nil then
				break
			end
			if v25 ~= nil and os.clock() - v25 > 20 then
				warn((("[%*]: RemoteEvent \"%*\" hasn\'t been defined server-side"):format(script.Name, p_u_14)))
				v25 = nil
			end
			task.wait()
		end
		for _, v26 in ipairs(v_u_18) do
			if v26.is_disconnected == false then
				v26.real_connection = v_u_17.OnClientEvent:Connect(v26.fn)
			end
		end
		v_u_24.RemoteEvent = v_u_17
		v_u_18 = nil
	end
	if v_u_7 == nil then
		local v_u_28 = nil
		v_u_28 = v_u_6.Event:Connect(function()
			-- upvalues: (ref) v_u_28, (copy) v_u_27
			v_u_28:Disconnect()
			v_u_27()
		end)
	else
		task.spawn(v_u_27)
	end
	return v_u_24
end
function v_u_13.FireServer(p29, ...)
	if p29.RemoteEvent ~= nil then
		p29.RemoteEvent:FireServer(...)
	end
end
function v_u_13.FireClient(_)
	error((("[%*]: Can\'t use \"FireClient\" client-side"):format(script.Name)))
end
function v_u_13.FireAllClients(_)
	error((("[%*]: Can\'t use \"FireAllClients\" client-side"):format(script.Name)))
end
return v_u_13]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Remote]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3175"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = nil
local function v_u_4(p2, ...)
	-- upvalues: (ref) v_u_1
	local v3 = v_u_1
	v_u_1 = nil
	p2(...)
	v_u_1 = v3
end
local function v_u_5(...)
	-- upvalues: (copy) v_u_4
	v_u_4(...)
	while true do
		v_u_4(coroutine.yield())
	end
end
local v_u_6 = {}
v_u_6.__index = v_u_6
local v_u_7 = {}
v_u_7.__index = v_u_7
function v_u_6.Disconnect(p8)
	if p8.is_connected == false then
		return
	else
		local v9 = p8.signal
		p8.is_connected = false
		v9.listener_count = v9.listener_count - 1
		if v9.head == p8 then
			v9.head = p8.next
		else
			local v10 = v9.head
			while v10 ~= nil and v10.next ~= p8 do
				v10 = v10.next
			end
			if v10 ~= nil then
				v10.next = p8.next
			end
		end
	end
end
function v_u_7.New()
	-- upvalues: (copy) v_u_7
	local v11 = {
		["head"] = nil,
		["listener_count"] = 0
	}
	local v12 = v_u_7
	setmetatable(v11, v12)
	return v11
end
function v_u_7.Connect(p13, p14)
	-- upvalues: (copy) v_u_6
	if type(p14) ~= "function" then
		error((("[%*]: \"listener\" must be a function; Received %*"):format(script.Name, (typeof(p14)))))
	end
	local v15 = {
		["listener"] = p14,
		["signal"] = p13,
		["next"] = p13.head,
		["is_connected"] = true
	}
	local v16 = v_u_6
	setmetatable(v15, v16)
	p13.head = v15
	p13.listener_count = p13.listener_count + 1
	return v15
end
function v_u_7.GetListenerCount(p17)
	return p17.listener_count
end
function v_u_7.Fire(p18, ...)
	-- upvalues: (ref) v_u_1, (copy) v_u_5
	local v19 = p18.head
	while v19 ~= nil do
		if v19.is_connected == true then
			if not v_u_1 then
				v_u_1 = coroutine.create(v_u_5)
			end
			task.spawn(v_u_1, v19.listener, ...)
		end
		v19 = v19.next
	end
end
function v_u_7.Wait(p20)
	local v_u_21 = coroutine.running()
	local v_u_22 = nil
	v_u_22 = p20:Connect(function(...)
		-- upvalues: (ref) v_u_22, (copy) v_u_21
		v_u_22:Disconnect()
		task.spawn(v_u_21, ...)
	end)
	return coroutine.yield()
end
function v_u_7.FireUntil(p23, p_u_24, ...)
	if type(p_u_24) ~= "function" then
		error((("[%*]: \"continue_callback\" must be a function; Received %*"):format(script.Name, (typeof(p_u_24)))))
	end
	local v_u_25 = table.pack(...)
	local v26 = p23.head
	local v_u_27 = {}
	while v26 ~= nil do
		table.insert(v_u_27, v26)
		v26 = v26.next
	end
	task.spawn(function()
		-- upvalues: (copy) v_u_27, (copy) v_u_25, (copy) p_u_24
		for _, v28 in ipairs(v_u_27) do
			if v28.is_connected == true then
				local v29 = v_u_25
				v28.listener(table.unpack(v29))
				if p_u_24() ~= true then
					return
				end
			end
		end
	end)
end
return table.freeze({
	["New"] = v_u_7.New
})]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Signal]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item></Item><Item class="Folder" referent="3176"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[sleitnick_signal@2.0.3]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3177"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = nil
local function v_u_4(p2, ...)
	-- upvalues: (ref) v_u_1
	local v3 = v_u_1
	v_u_1 = nil
	p2(...)
	v_u_1 = v3
end
local function v_u_5(...)
	-- upvalues: (copy) v_u_4
	v_u_4(...)
	while true do
		v_u_4(coroutine.yield())
	end
end
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6.Disconnect(p7)
	if p7.Connected then
		p7.Connected = false
		if p7._signal._handlerListHead == p7 then
			p7._signal._handlerListHead = p7._next
		else
			local v8 = p7._signal._handlerListHead
			while v8 and v8._next ~= p7 do
				v8 = v8._next
			end
			if v8 then
				v8._next = p7._next
			end
		end
	else
		return
	end
end
v_u_6.Destroy = v_u_6.Disconnect
setmetatable(v_u_6, {
	["__index"] = function(_, p9)
		error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p9))), 2)
	end,
	["__newindex"] = function(_, p10, _)
		error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p10))), 2)
	end
})
local v_u_11 = {}
v_u_11.__index = v_u_11
function v_u_11.new()
	-- upvalues: (copy) v_u_11
	local v12 = v_u_11
	return setmetatable({
		["_handlerListHead"] = false,
		["_proxyHandler"] = nil,
		["_yieldedThreads"] = nil
	}, v12)
end
function v_u_11.Wrap(p13)
	-- upvalues: (copy) v_u_11
	local v14 = typeof(p13) == "RBXScriptSignal"
	local v15 = "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(p13)
	assert(v14, v15)
	local v_u_16 = v_u_11.new()
	v_u_16._proxyHandler = p13:Connect(function(...)
		-- upvalues: (copy) v_u_16
		v_u_16:Fire(...)
	end)
	return v_u_16
end
function v_u_11.Is(p17)
	-- upvalues: (copy) v_u_11
	local v18
	if type(p17) == "table" then
		v18 = getmetatable(p17) == v_u_11
	else
		v18 = false
	end
	return v18
end
function v_u_11.Connect(p19, p20)
	-- upvalues: (copy) v_u_6
	local v21 = v_u_6
	local v22 = setmetatable({
		["Connected"] = true,
		["_signal"] = p19,
		["_fn"] = p20,
		["_next"] = false
	}, v21)
	if not p19._handlerListHead then
		p19._handlerListHead = v22
		return v22
	end
	v22._next = p19._handlerListHead
	p19._handlerListHead = v22
	return v22
end
function v_u_11.ConnectOnce(p23, p24)
	return p23:Once(p24)
end
function v_u_11.Once(p25, p_u_26)
	local v_u_27 = nil
	local v_u_28 = false
	v_u_27 = p25:Connect(function(...)
		-- upvalues: (ref) v_u_28, (ref) v_u_27, (copy) p_u_26
		if not v_u_28 then
			v_u_28 = true
			v_u_27:Disconnect()
			p_u_26(...)
		end
	end)
	return v_u_27
end
function v_u_11.GetConnections(p29)
	local v30 = p29._handlerListHead
	local v31 = {}
	while v30 do
		table.insert(v31, v30)
		v30 = v30._next
	end
	return v31
end
function v_u_11.DisconnectAll(p32)
	local v33 = p32._handlerListHead
	while v33 do
		v33.Connected = false
		v33 = v33._next
	end
	p32._handlerListHead = false
	local v34 = rawget(p32, "_yieldedThreads")
	if v34 then
		for v35 in v34 do
			if coroutine.status(v35) == "suspended" then
				warn(debug.traceback(v35, "signal disconnected; yielded thread cancelled", 2))
				task.cancel(v35)
			end
		end
		table.clear(p32._yieldedThreads)
	end
end
function v_u_11.Fire(p36, ...)
	-- upvalues: (ref) v_u_1, (copy) v_u_5
	local v37 = p36._handlerListHead
	while v37 do
		if v37.Connected then
			if not v_u_1 then
				v_u_1 = coroutine.create(v_u_5)
			end
			task.spawn(v_u_1, v37._fn, ...)
		end
		v37 = v37._next
	end
end
function v_u_11.FireDeferred(p38, ...)
	local v_u_39 = p38._handlerListHead
	while v_u_39 do
		task.defer(function(...)
			-- upvalues: (copy) v_u_39
			if v_u_39.Connected then
				v_u_39._fn(...)
			end
		end, ...)
		v_u_39 = v_u_39._next
	end
end
function v_u_11.Wait(p40)
	local v_u_41 = rawget(p40, "_yieldedThreads")
	if not v_u_41 then
		v_u_41 = {}
		rawset(p40, "_yieldedThreads", v_u_41)
	end
	local v_u_42 = coroutine.running()
	v_u_41[v_u_42] = true
	p40:Once(function(...)
		-- upvalues: (ref) v_u_41, (copy) v_u_42
		v_u_41[v_u_42] = nil
		if coroutine.status(v_u_42) == "suspended" then
			task.spawn(v_u_42, ...)
		end
	end)
	return coroutine.yield()
end
function v_u_11.Destroy(p43)
	p43:DisconnectAll()
	local v44 = rawget(p43, "_proxyHandler")
	if v44 then
		v44:Disconnect()
	end
end
setmetatable(v_u_11, {
	["__index"] = function(_, p45)
		error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p45))), 2)
	end,
	["__newindex"] = function(_, p46, _)
		error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p46))), 2)
	end
})
return table.freeze({
	["new"] = v_u_11.new,
	["Wrap"] = v_u_11.Wrap,
	["Is"] = v_u_11.Is
})]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[signal]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3178"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ServerScriptService")
require(v1.TestRunner.Test)
local function v_u_6(p2, p3)
	local v4 = os.clock()
	local v5 = p3 or 10
	while not p2() do
		if v5 < os.clock() - v4 then
			return false
		end
		task.wait()
	end
	return true
end
return function(p_u_7)
	-- upvalues: (copy) v_u_6
	local v_u_8 = require(script.Parent)
	local v_u_9 = nil
	p_u_7:BeforeEach(function()
		-- upvalues: (ref) v_u_9, (copy) v_u_8
		v_u_9 = v_u_8.new()
	end)
	p_u_7:AfterEach(function()
		-- upvalues: (ref) v_u_9
		v_u_9:Destroy()
	end)
	p_u_7:Describe("Constructor", function()
		-- upvalues: (copy) p_u_7, (copy) v_u_8, (ref) v_u_9, (ref) v_u_6
		p_u_7:Test("should create a new signal and fire it", function()
			-- upvalues: (ref) p_u_7, (ref) v_u_8, (ref) v_u_9
			p_u_7:Expect(v_u_8.Is(v_u_9)):ToBe(true)
			task.defer(function()
				-- upvalues: (ref) v_u_9
				v_u_9:Fire(10, 20)
			end)
			local v10, v11 = v_u_9:Wait()
			p_u_7:Expect(v10):ToBe(10)
			p_u_7:Expect(v11):ToBe(20)
		end)
		p_u_7:Test("should create a proxy signal and connect to it", function()
			-- upvalues: (ref) v_u_8, (ref) p_u_7, (ref) v_u_6
			local v12 = v_u_8.Wrap(game:GetService("RunService").Heartbeat)
			p_u_7:Expect(v_u_8.Is(v12)):ToBe(true)
			local v_u_13 = false
			v12:Connect(function()
				-- upvalues: (ref) v_u_13
				v_u_13 = true
			end)
			p_u_7:Expect(v_u_6(function()
				-- upvalues: (ref) v_u_13
				return v_u_13
			end, 2)):ToBe(true)
			v12:Destroy()
		end)
	end)
	p_u_7:Describe("FireDeferred", function()
		-- upvalues: (copy) p_u_7, (ref) v_u_9, (ref) v_u_6
		p_u_7:Test("should be able to fire primitive argument", function()
			-- upvalues: (ref) v_u_9, (ref) p_u_7, (ref) v_u_6
			local v_u_14 = nil
			v_u_9:Connect(function(p15)
				-- upvalues: (ref) v_u_14
				v_u_14 = p15
			end)
			v_u_9:FireDeferred(10)
			p_u_7:Expect(v_u_6(function()
				-- upvalues: (ref) v_u_14
				return v_u_14 == 10
			end, 1)):ToBe(true)
		end)
		p_u_7:Test("should be able to fire a reference based argument", function()
			-- upvalues: (ref) v_u_9, (ref) p_u_7, (ref) v_u_6
			local v_u_16 = { 10, 20 }
			local v_u_17 = nil
			v_u_9:Connect(function(p18)
				-- upvalues: (ref) v_u_17
				v_u_17 = p18
			end)
			v_u_9:FireDeferred(v_u_16)
			p_u_7:Expect(v_u_6(function()
				-- upvalues: (copy) v_u_16, (ref) v_u_17
				return v_u_16 == v_u_17
			end, 1)):ToBe(true)
		end)
	end)
	p_u_7:Describe("Fire", function()
		-- upvalues: (copy) p_u_7, (ref) v_u_9
		p_u_7:Test("should be able to fire primitive argument", function()
			-- upvalues: (ref) v_u_9, (ref) p_u_7
			local v_u_19 = nil
			v_u_9:Connect(function(p20)
				-- upvalues: (ref) v_u_19
				v_u_19 = p20
			end)
			v_u_9:Fire(10)
			p_u_7:Expect(v_u_19):ToBe(10)
		end)
		p_u_7:Test("should be able to fire a reference based argument", function()
			-- upvalues: (ref) v_u_9, (ref) p_u_7
			local v21 = { 10, 20 }
			local v_u_22 = nil
			v_u_9:Connect(function(p23)
				-- upvalues: (ref) v_u_22
				v_u_22 = p23
			end)
			v_u_9:Fire(v21)
			p_u_7:Expect(v_u_22):ToBe(v21)
		end)
	end)
	p_u_7:Describe("ConnectOnce", function()
		-- upvalues: (copy) p_u_7, (ref) v_u_9
		p_u_7:Test("should only capture first fire", function()
			-- upvalues: (ref) v_u_9, (ref) p_u_7
			local v_u_24 = nil
			local v26 = v_u_9:ConnectOnce(function(p25)
				-- upvalues: (ref) v_u_24
				v_u_24 = p25
			end)
			p_u_7:Expect(v26.Connected):ToBe(true)
			v_u_9:Fire(10)
			p_u_7:Expect(v26.Connected):ToBe(false)
			v_u_9:Fire(20)
			p_u_7:Expect(v_u_24):ToBe(10)
		end)
	end)
	p_u_7:Describe("Wait", function()
		-- upvalues: (copy) p_u_7, (ref) v_u_9
		p_u_7:Test("should be able to wait for a signal to fire", function()
			-- upvalues: (ref) v_u_9, (ref) p_u_7
			task.defer(function()
				-- upvalues: (ref) v_u_9
				v_u_9:Fire(10, 20, 30)
			end)
			local v27, v28, v29 = v_u_9:Wait()
			p_u_7:Expect(v27):ToBe(10)
			p_u_7:Expect(v28):ToBe(20)
			p_u_7:Expect(v29):ToBe(30)
		end)
	end)
	p_u_7:Describe("DisconnectAll", function()
		-- upvalues: (copy) p_u_7, (ref) v_u_9
		p_u_7:Test("should disconnect all connections", function()
			-- upvalues: (ref) v_u_9, (ref) p_u_7
			v_u_9:Connect(function() end)
			v_u_9:Connect(function() end)
			p_u_7:Expect(#(nil or v_u_9):GetConnections()):ToBe(2)
			v_u_9:DisconnectAll()
			p_u_7:Expect(#(nil or v_u_9):GetConnections()):ToBe(0)
		end)
	end)
	p_u_7:Describe("Disconnect", function()
		-- upvalues: (copy) p_u_7, (ref) v_u_9, (ref) v_u_6
		p_u_7:Test("should disconnect connection", function()
			-- upvalues: (ref) v_u_9, (ref) p_u_7
			local v30 = v_u_9:Connect(function() end)
			p_u_7:Expect(#(nil or v_u_9):GetConnections()):ToBe(1)
			v30:Disconnect()
			p_u_7:Expect(#(nil or v_u_9):GetConnections()):ToBe(0)
		end)
		p_u_7:Test("should still work if connections disconnected while firing", function()
			-- upvalues: (ref) v_u_9, (ref) p_u_7
			local v_u_31 = 0
			local v_u_32 = nil
			v_u_9:Connect(function()
				-- upvalues: (ref) v_u_31
				v_u_31 = v_u_31 + 1
			end)
			v_u_32 = v_u_9:Connect(function()
				-- upvalues: (ref) v_u_32, (ref) v_u_31
				v_u_32:Disconnect()
				v_u_31 = v_u_31 + 1
			end)
			v_u_9:Connect(function()
				-- upvalues: (ref) v_u_31
				v_u_31 = v_u_31 + 1
			end)
			v_u_9:Fire()
			p_u_7:Expect(v_u_31):ToBe(3)
		end)
		p_u_7:Test("should still work if connections disconnected while firing deferred", function()
			-- upvalues: (ref) v_u_9, (ref) p_u_7, (ref) v_u_6
			local v_u_33 = 0
			local v_u_34 = nil
			v_u_9:Connect(function()
				-- upvalues: (ref) v_u_33
				v_u_33 = v_u_33 + 1
			end)
			v_u_34 = v_u_9:Connect(function()
				-- upvalues: (ref) v_u_34, (ref) v_u_33
				v_u_34:Disconnect()
				v_u_33 = v_u_33 + 1
			end)
			v_u_9:Connect(function()
				-- upvalues: (ref) v_u_33
				v_u_33 = v_u_33 + 1
			end)
			v_u_9:FireDeferred()
			p_u_7:Expect(v_u_6(function()
				-- upvalues: (ref) v_u_33
				return v_u_33 == 3
			end)):ToBe(true)
		end)
	end)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[init.test]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3179"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["package"] = {
		["authors"] = { "Stephen Leitnick" },
		["description"] = "Signal class",
		["exclude"] = { "node_modules", "package.json", "**/*.ts" },
		["license"] = "MIT",
		["name"] = "sleitnick/signal",
		["realm"] = "shared",
		["registry"] = "https://github.com/UpliftGames/wally-index",
		["version"] = "2.0.3"
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[wally]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3180"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[colbert2677_lootplan@1.0.0]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3181"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Single"] = require(script.SingleLootPlan),
	["Multi"] = require(script.MultiLootPlan)
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[lootplan]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3182"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {
	["prototype"] = {}
}
v_u_1.__index = v_u_1.prototype
function v_u_1.new(p2, p3)
	-- upvalues: (copy) v_u_1
	local v4 = typeof(p2) == "number"
	local v5 = (typeof(p3) ~= "number" or p3 < 0) and 0 or p3
	local v6 = {}
	local v7
	if typeof(p2) == "number" then
		v7 = Random.new(p2)
	else
		v7 = Random.new()
	end
	v6.Randomiser = v7
	v6.Loot = {}
	while v4 == true and v5 > 0 do
		v6.Randomiser:NextNumber()
		v5 = v5 - 1
	end
	local v8 = v_u_1
	setmetatable(v6, v8)
	return v6
end
function v_u_1.prototype.GetChance(p9, p10)
	local v11 = p9.Loot[p10]
	if not v11 then
		error("No loot with name \"" .. p10 .. "\"")
	end
	return v11.Chance
end
function v_u_1.prototype.Add(p12, p13, p14)
	local v15 = typeof(p13) == "string"
	assert(v15, "A string is expected for Add arg #1")
	p12.Loot[p13] = {
		["Name"] = p13,
		["Chance"] = p14
	}
end
function v_u_1.prototype.BatchAdd(p16, p17)
	for v18, v19 in p17 do
		p16:Add(v18, v19)
	end
end
function v_u_1.prototype.Remove(p20, p21)
	p20.Loot[p21] = nil
end
function v_u_1.prototype.BatchRemove(p22, p23)
	for _, v24 in p23 do
		p22:Remove(v24)
	end
end
function v_u_1.prototype.ChangeChance(p25, p26, p27)
	local v28 = p25.Loot[p26]
	if not v28 then
		error("No loot with name \"" .. p26 .. "\"")
	end
	v28.Chance = p27
end
function v_u_1.prototype.BatchChangeChance(p29, p30)
	for v31, v32 in p30 do
		p29:ChangeChance(v31, v32)
	end
end
function v_u_1.prototype.IncreaseChance(p33, p34, p35)
	if p35 > 0 then
		local v36 = p33.Loot[p34]
		if not v36 then
			error("No loot with name \"" .. p34 .. "\"")
		end
		v36.Chance = v36.Chance + p35
	end
end
function v_u_1.prototype.BatchIncreaseChance(p37, p38)
	for v39, v40 in p38 do
		p37:IncreaseChance(v39, v40)
	end
end
function v_u_1.prototype.DecreaseChance(p41, p42, p43)
	if p43 > 0 then
		local v44 = p41.Loot[p42]
		if not v44 then
			error("No loot with name \"" .. p42 .. "\"")
		end
		v44.Chance = v44.Chance - p43
	end
end
function v_u_1.prototype.BatchDecreaseChance(p45, p46)
	for v47, v48 in p46 do
		p45:DecreaseChance(v47, v48)
	end
end
function v_u_1.prototype.Roll(p49, p50, p51)
	local v52 = (typeof(p50) ~= "number" or p50 <= 0) and 1 or p50
	local v53 = (typeof(p51) ~= "number" or p51 <= 0) and 1 or p51
	local v54 = {}
	while v52 > 0 do
		for v55, v56 in p49.Loot do
			if p49.Randomiser:NextNumber() < v56.Chance / 100 * v53 then
				if not v54[v55] then
					v54[v55] = 0
				end
				v54[v55] = v54[v55] + 1
			end
		end
		v52 = v52 - 1
	end
	return v54
end
function v_u_1.prototype.Destroy(p57)
	table.clear(p57)
	table.freeze(p57)
end
return v_u_1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MultiLootPlan]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3183"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {
	["prototype"] = {}
}
v_u_1.__index = v_u_1.prototype
function v_u_1.new(p2, p3)
	-- upvalues: (copy) v_u_1
	local v4 = typeof(p2) == "number"
	local v5 = (typeof(p3) ~= "number" or p3 < 0) and 0 or p3
	local v6 = {}
	local v7
	if typeof(p2) == "number" then
		v7 = Random.new(p2)
	else
		v7 = Random.new()
	end
	v6.Randomiser = v7
	v6.Loot = {}
	v6.LootList = {}
	v6.LootCount = 0
	v6.TotalChance = 0
	v6._ListUpdated = true
	while v4 == true and v5 > 0 do
		v6.Randomiser:NextNumber()
		v5 = v5 - 1
	end
	local v8 = v_u_1
	setmetatable(v6, v8)
	return v6
end
function v_u_1.prototype._UpdateLootList(p9)
	if p9._ListUpdated ~= true then
		p9._ListUpdated = true
		table.clear(p9.LootList)
		for _, v10 in p9.Loot do
			local v11 = p9.LootList
			table.insert(v11, v10)
		end
		table.sort(p9.LootList, function(p12, p13)
			return p12.Weight < p13.Weight
		end)
	end
end
function v_u_1.prototype.GetWeight(p14, p15)
	local v16 = p14.Loot[p15]
	if not v16 then
		error("No loot with name \"" .. p15 .. "\"")
	end
	return v16.Weight
end
function v_u_1.prototype.GetChance(p17, p18)
	local v19 = p17.Loot[p18]
	if not v19 then
		error("No loot with name \"" .. p18 .. "\"")
	end
	return v19.Weight / p17.TotalChance * 100
end
function v_u_1.prototype.Add(p20, p21, p22)
	local v23 = typeof(p21) == "string"
	assert(v23, "A string is expected for Add arg #1")
	p20.Loot[p21] = {
		["Name"] = p21,
		["Weight"] = p22
	}
	p20.LootCount = p20.LootCount + 1
	p20.TotalChance = p20.TotalChance + p22
	p20._ListUpdated = false
end
function v_u_1.prototype.BatchAdd(p24, p25)
	for v26, v27 in p25 do
		p24:Add(v26, v27)
	end
end
function v_u_1.prototype.Remove(p28, p29)
	local v30 = p28.Loot[p29]
	if v30 then
		p28.TotalChance = p28.TotalChance - v30.Weight
		p28.LootCount = p28.LootCount - 1
		p28.Loot[p29] = nil
		p28._ListUpdated = false
	end
end
function v_u_1.prototype.BatchRemove(p31, p32)
	for _, v33 in p32 do
		p31:Remove(v33)
	end
end
function v_u_1.prototype.ChangeWeight(p34, p35, p36)
	local v37 = p34.Loot[p35]
	if not v37 then
		error("No loot with name \"" .. p35 .. "\"")
	end
	p34.TotalChance = p34.TotalChance + (p36 - v37.Weight)
	v37.Weight = p36
	p34._ListUpdated = false
end
function v_u_1.prototype.BatchChangeWeight(p38, p39)
	for v40, v41 in p39 do
		p38:ChangeWeight(v40, v41)
	end
end
function v_u_1.prototype.IncreaseWeight(p42, p43, p44)
	if p44 > 0 then
		p42:ChangeWeight(p43, p42:GetWeight(p43) + p44)
	end
end
function v_u_1.prototype.BatchIncreaseWeight(p45, p46)
	for v47, v48 in p46 do
		p45:IncreaseWeight(v47, v48)
	end
end
function v_u_1.prototype.DecreaseWeight(p49, p50, p51)
	if p51 > 0 then
		p49:ChangeWeight(p50, p49:GetWeight(p50) - p51)
	end
end
function v_u_1.prototype.BatchDecreaseWeight(p52, p53)
	for v54, v55 in p53 do
		p52:DecreaseWeight(v54, v55)
	end
end
function v_u_1.prototype.Roll(p56, p57)
	local v58 = (typeof(p57) ~= "number" or p57 <= 0) and 1 or p57
	p56:_UpdateLootList()
	if v58 >= 1 then
		local v59 = p56.Randomiser:NextNumber()
		local v60 = 0
		for _, v61 in p56.LootList do
			local v62 = v61.Weight * v58
			if v59 < (v62 + v60) / p56.TotalChance then
				return v61.Name
			end
			v60 = v60 + v62
		end
	else
		local v63 = 1 / v58
		local v64 = p56.Randomiser:NextNumber()
		local v65 = 0
		for v66 = p56.LootCount, 1, -1 do
			local v67 = p56.LootList[v66]
			local v68 = v67.Weight * v63
			if v64 < (v68 + v65) / p56.TotalChance then
				return v67.Name
			end
			v65 = v65 + v68
		end
	end
end
function v_u_1.prototype.Destroy(p69)
	table.clear(p69)
	table.freeze(p69)
end
return v_u_1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SingleLootPlan]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3184"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["dependencies"] = {},
	["package"] = {
		["authors"] = { "dogwarrior24", "colbert2677" },
		["description"] = "Old and modified version of dogwarrior24\'s LootPlan module uploaded to Wally. The package at this scope is no longer maintained.",
		["license"] = "MIT",
		["name"] = "colbert2677/lootplan",
		["realm"] = "shared",
		["registry"] = "https://github.com/UpliftGames/wally-index",
		["version"] = "1.0.0"
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[wally]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3185"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[coatmol_bytenet-max@0.1.9]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3186"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("RunService")
local v2 = require(script.process.client)
local v3 = require(script.dataTypes.array)
local v4 = require(script.dataTypes.bool)
local v5 = require(script.dataTypes.buff)
local v6 = require(script.dataTypes.color3)
local v7 = require(script.dataTypes.cframe)
local v8 = require(script.dataTypes.float32)
local v9 = require(script.dataTypes.float64)
local v10 = require(script.dataTypes.inst)
local v11 = require(script.dataTypes.int16)
local v12 = require(script.dataTypes.int32)
local v13 = require(script.dataTypes.int8)
local v14 = require(script.dataTypes.map)
local v15 = require(script.dataTypes.nothing)
local v16 = require(script.dataTypes.optional)
local v17 = require(script.dataTypes.string)
local v18 = require(script.dataTypes.struct)
local v19 = require(script.dataTypes.uint16)
local v20 = require(script.dataTypes.uint32)
local v21 = require(script.dataTypes.uint8)
local v22 = require(script.dataTypes.unknown)
local v23 = require(script.dataTypes.vec2)
local v24 = require(script.dataTypes.vec3)
local v25 = require(script.namespaces.namespace)
local v26 = require(script.packets.definePacket)
local v27 = require(script.queries.defineQuery)
local v28 = require(script.process.server)
local v29 = require(script.replicated.values)
require(script.types)
v29.start()
if v1:IsServer() then
	v28.start()
else
	v2.start()
end
local v30 = {
	["definePacket"] = v26,
	["defineQuery"] = v27,
	["defineNamespace"] = v25,
	["array"] = v3,
	["bool"] = v4(),
	["optional"] = v16,
	["uint8"] = v21(),
	["uint16"] = v19(),
	["uint32"] = v20(),
	["int8"] = v13(),
	["int16"] = v11(),
	["int32"] = v12(),
	["float32"] = v8(),
	["float64"] = v9(),
	["color3"] = v6(),
	["cframe"] = v7(),
	["string"] = v17(),
	["vec2"] = v23(),
	["vec3"] = v24(),
	["buff"] = v5(),
	["struct"] = v18,
	["map"] = v14,
	["inst"] = v10(),
	["unknown"] = v22(),
	["nothing"] = v15(),
	["playerName"] = v17(),
	["playerIdentifier"] = v21()
}
return table.freeze(v30)]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[bytenet-max]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3187"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return nil]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[types]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="3188"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[dataTypes]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3189"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.u16
return function(p3)
	-- upvalues: (copy) v_u_2
	local v_u_4 = p3.write
	local v_u_5 = p3.read
	return {
		["read"] = function(p6, p7)
			-- upvalues: (copy) v_u_5
			local v8 = buffer.readu16(p6, p7)
			local v9 = p7 + 2
			local v10 = {}
			for _ = 1, v8 do
				local v11, v12 = v_u_5(p6, v9)
				table.insert(v10, v11)
				v9 = v9 + v12
			end
			return v10, v9 - p7
		end,
		["write"] = function(p13)
			-- upvalues: (ref) v_u_2, (copy) v_u_4
			local v14 = #p13
			v_u_2(v14)
			for v15 = 1, v14 do
				v_u_4(p13[v15])
			end
		end
	}
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[array]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3190"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_4 = {
	["read"] = function(p2, p3)
		return buffer.readu8(p2, p3) == 1, 1
	end,
	["write"] = v1.bool
}
return function()
	-- upvalues: (copy) v_u_4
	return v_u_4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[bool]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3191"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.u16
local v_u_3 = v1.copy
local v_u_4 = v1.dyn_alloc
local v_u_11 = {
	["read"] = function(p5, p6)
		local v7 = buffer.readu16(p5, p6)
		local v8 = buffer.create(v7)
		buffer.copy(v8, 0, p5, p6 + 2, v7)
		return v8, v7 + 2
	end,
	["write"] = function(p9)
		-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_3
		local v10 = buffer.len(p9)
		v_u_2(v10)
		v_u_4(v10)
		v_u_3(p9)
	end
}
return function()
	-- upvalues: (copy) v_u_11
	return v_u_11
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[buff]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3192"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.f32NoAlloc
local v_u_3 = v1.alloc
local v_u_24 = {
	["read"] = function(p4, p5)
		local v6 = buffer.readf32(p4, p5)
		local v7 = p5 + 4
		local v8 = buffer.readf32(p4, v7)
		local v9 = p5 + 8
		local v10 = buffer.readf32(p4, v9)
		local v11 = p5 + 12
		local v12 = buffer.readf32(p4, v11)
		local v13 = p5 + 16
		local v14 = buffer.readf32(p4, v13)
		local v15 = p5 + 20
		local v16 = buffer.readf32(p4, v15)
		return CFrame.new(v6, v8, v10) * CFrame.Angles(v12, v14, v16), 24
	end,
	["write"] = function(p17)
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		local v18 = p17.X
		local v19 = p17.Y
		local v20 = p17.Z
		local v21, v22, v23 = p17:ToEulerAnglesXYZ()
		v_u_3(24)
		v_u_2(v18)
		v_u_2(v19)
		v_u_2(v20)
		v_u_2(v21)
		v_u_2(v22)
		v_u_2(v23)
	end
}
return function()
	-- upvalues: (copy) v_u_24
	return v_u_24
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[cframe]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3193"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.u8NoAlloc
local v_u_3 = v1.alloc
local v_u_12 = {
	["write"] = function(p4)
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		v_u_3(3)
		v_u_2(p4.R * 255)
		v_u_2(p4.G * 255)
		v_u_2(p4.B * 255)
	end,
	["read"] = function(p5, p6)
		local v7 = Color3.fromRGB
		local v8 = buffer.readu8(p5, p6)
		local v9 = p6 + 1
		local v10 = buffer.readu8(p5, v9)
		local v11 = p6 + 2
		return v7(v8, v10, (buffer.readu8(p5, v11))), 3
	end
}
return function()
	-- upvalues: (copy) v_u_12
	return v_u_12
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[color3]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3194"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_4 = {
	["write"] = v1.f32,
	["read"] = function(p2, p3)
		return buffer.readf32(p2, p3), 4
	end
}
return function()
	-- upvalues: (copy) v_u_4
	return v_u_4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[float32]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3195"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_4 = {
	["write"] = v1.f64,
	["read"] = function(p2, p3)
		return buffer.readf64(p2, p3), 8
	end
}
return function()
	-- upvalues: (copy) v_u_4
	return v_u_4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[float64]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3196"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
local v_u_2 = require(script.Parent.Parent.process.readRefs)
require(script.Parent.Parent.types)
local v_u_3 = v1.reference
local v_u_4 = v1.alloc
return function()
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_2
	return {
		["write"] = function(p5)
			-- upvalues: (ref) v_u_4, (ref) v_u_3
			v_u_4(1)
			v_u_3(p5)
		end,
		["read"] = function(p6, p7)
			-- upvalues: (ref) v_u_2
			local v8 = v_u_2.get()
			if v8 then
				local v9 = v8[buffer.readu8(p6, p7)]
				if typeof(v9) == "Instance" then
					return v9, 1
				else
					return nil, 1
				end
			else
				return nil, 1
			end
		end
	}
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[inst]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3197"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_4 = {
	["write"] = v1.i16,
	["read"] = function(p2, p3)
		return buffer.readi16(p2, p3), 2
	end
}
return function()
	-- upvalues: (copy) v_u_4
	return v_u_4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[int16]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3198"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_4 = {
	["write"] = v1.i32,
	["read"] = function(p2, p3)
		return buffer.readi32(p2, p3), 4
	end
}
return function()
	-- upvalues: (copy) v_u_4
	return v_u_4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[int32]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3199"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_4 = {
	["write"] = v1.i8,
	["read"] = function(p2, p3)
		return buffer.readi8(p2, p3), 1
	end
}
return function()
	-- upvalues: (copy) v_u_4
	return v_u_4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[int8]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3200"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.u16
return function(p_u_3, p_u_4)
	-- upvalues: (copy) v_u_2
	local v_u_5 = p_u_3.write
	local v_u_6 = p_u_4.write
	return {
		["read"] = function(p7, p8)
			-- upvalues: (copy) p_u_3, (copy) p_u_4
			local v9 = buffer.readu16(p7, p8)
			local v10 = p8 + 2
			local v11 = {}
			for _ = 1, v9 do
				local v12, v13 = p_u_3.read(p7, v10)
				local v14 = v10 + v13
				local v15, v16 = p_u_4.read(p7, v14)
				v10 = v14 + v16
				v11[v12] = v15
			end
			return v11, v10 - p8
		end,
		["write"] = function(p17)
			-- upvalues: (ref) v_u_2, (copy) v_u_5, (copy) v_u_6
			local v18 = 0
			for _ in p17 do
				v18 = v18 + 1
			end
			v_u_2(v18)
			for v19, v20 in p17 do
				v_u_5(v19)
				v_u_6(v20)
			end
		end
	}
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[map]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3201"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.types)
local v_u_1 = {
	["write"] = function() end,
	["read"] = function()
		return nil, 0
	end
}
return function()
	-- upvalues: (copy) v_u_1
	return v_u_1
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[nothing]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3202"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.bool
return function(p3)
	-- upvalues: (copy) v_u_2
	local v_u_4 = p3.read
	local v_u_5 = p3.write
	return {
		["read"] = function(p6, p7)
			-- upvalues: (copy) v_u_4
			if buffer.readu8(p6, p7) == 0 then
				return nil, 1
			end
			local v8, v9 = v_u_4(p6, p7 + 1)
			return v8, v9 + 1
		end,
		["write"] = function(p10)
			-- upvalues: (ref) v_u_2, (copy) v_u_5
			local v11 = p10 ~= nil
			v_u_2(v11)
			if v11 then
				v_u_5(p10)
			end
		end
	}
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[optional]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3203"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.u16
local v_u_3 = v1.writestring
local v_u_4 = v1.dyn_alloc
local v_u_10 = {
	["read"] = function(p5, p6)
		local v7 = buffer.readu16(p5, p6)
		return buffer.readstring(p5, p6 + 2, v7), v7 + 2
	end,
	["write"] = function(p8)
		-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_3
		local v9 = string.len(p8)
		v_u_2(v9)
		v_u_4(v9)
		v_u_3(p8)
	end
}
return function()
	-- upvalues: (copy) v_u_10
	return v_u_10
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[string]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3204"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("RunService")
local v_u_2 = require(script.Parent.Parent.namespaces.namespaceDependencies)
local v_u_3 = require(script.Parent.Parent.replicated.values)
require(script.Parent.Parent.types)
local v_u_4 = v1:IsServer() and "server" or "client"
return function(p_u_5)
	-- upvalues: (copy) v_u_4, (copy) v_u_2, (copy) v_u_3
	local v_u_6 = {}
	local v_u_7 = {}
	if v_u_4 == "server" then
		local v8 = 0
		local v9 = {}
		for v10 in p_u_5 do
			v8 = v8 + 1
			v9[v10] = v8
			v_u_6[v8] = p_u_5[v10]
			v_u_7[v8] = v10
		end
		v_u_2.add(v9)
	elseif v_u_4 == "client" then
		v_u_2.add(p_u_5)
		local v11 = v_u_2.currentName()
		for v12, v13 in v_u_3.access(v11):read().structs[v_u_2.currentLength()] do
			v_u_6[v13] = p_u_5[v12]
			v_u_7[v13] = v12
		end
	end
	return {
		["read"] = function(p14, p15)
			-- upvalues: (copy) p_u_5, (copy) v_u_6, (copy) v_u_7
			local v16 = table.clone(p_u_5)
			local v17 = p15
			for v18, v19 in v_u_6 do
				local v20, v21 = v19.read(p14, p15)
				v16[v_u_7[v18]] = v20
				p15 = p15 + v21
			end
			return v16, p15 - v17
		end,
		["write"] = function(p22)
			-- upvalues: (copy) v_u_6, (copy) v_u_7
			for v23, v24 in v_u_6 do
				v24.write(p22[v_u_7[v23]])
			end
		end
	}
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[struct]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3205"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_4 = {
	["write"] = v1.u16,
	["read"] = function(p2, p3)
		return buffer.readu16(p2, p3), 2
	end
}
return function()
	-- upvalues: (copy) v_u_4
	return v_u_4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[uint16]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3206"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_4 = {
	["write"] = v1.u32,
	["read"] = function(p2, p3)
		return buffer.readu32(p2, p3), 4
	end
}
return function()
	-- upvalues: (copy) v_u_4
	return v_u_4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[uint32]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3207"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.types)
local v_u_3 = {
	["write"] = require(script.Parent.Parent.process.bufferWriter).u8,
	["read"] = function(p1, p2)
		return buffer.readu8(p1, p2), 1
	end
}
return function()
	-- upvalues: (copy) v_u_3
	return v_u_3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[uint8]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3208"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
local v_u_2 = require(script.Parent.Parent.process.readRefs)
require(script.Parent.Parent.types)
local v_u_3 = v1.reference
local v_u_4 = v1.alloc
return function()
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_2
	return {
		["write"] = function(p5)
			-- upvalues: (ref) v_u_4, (ref) v_u_3
			v_u_4(1)
			v_u_3(p5)
		end,
		["read"] = function(p6, p7)
			-- upvalues: (ref) v_u_2
			local v8 = v_u_2.get()
			if v8 then
				return v8[buffer.readu8(p6, p7)], 1
			else
				return nil, 1
			end
		end
	}
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[unknown]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3209"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.f32NoAlloc
local v_u_3 = v1.alloc
local v_u_10 = {
	["read"] = function(p4, p5)
		local v6 = Vector2.new
		local v7 = buffer.readf32(p4, p5)
		local v8 = p5 + 4
		return v6(v7, (buffer.readf32(p4, v8))), 8
	end,
	["write"] = function(p9)
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		v_u_3(8)
		v_u_2(p9.X)
		v_u_2(p9.Y)
	end
}
return function()
	-- upvalues: (copy) v_u_10
	return v_u_10
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[vec2]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3210"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.f32NoAlloc
local v_u_3 = v1.alloc
local v_u_12 = {
	["read"] = function(p4, p5)
		local v6 = buffer.readf32(p4, p5)
		local v7 = p5 + 4
		local v8 = buffer.readf32(p4, v7)
		local v9 = p5 + 8
		local v10 = buffer.readf32(p4, v9)
		return Vector3.new(v6, v8, v10), 12
	end,
	["write"] = function(p11)
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		v_u_3(12)
		v_u_2(p11.X)
		v_u_2(p11.Y)
		v_u_2(p11.Z)
	end
}
return function()
	-- upvalues: (copy) v_u_12
	return v_u_12
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[vec3]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3211"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[namespaces]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3212"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("RunService")
local v_u_2 = require(script.Parent.Parent.replicated.values)
require(script.Parent.Parent.types)
local v_u_3 = require(script.Parent.namespaceDependencies)
local v_u_4 = require(script.Parent.packetIDs)
local v_u_5 = require(script.Parent.queryIDs)
local v_u_6 = v1:IsServer() and "server" or "client"
local v_u_7 = 0
local v_u_8 = 0
return function(p9, p10)
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_6, (ref) v_u_7, (copy) v_u_4, (ref) v_u_8, (copy) v_u_5
	local v11 = v_u_2.access(p9)
	v_u_3.start(p9)
	local v12 = p10()
	local v13 = v12.packets or {}
	local v14 = v12.queries or {}
	local v15 = v_u_3.empty()
	local v16 = {}
	local v17 = {}
	if v_u_6 == "server" then
		local v18 = {
			["structs"] = {},
			["packets"] = {},
			["queries"] = {}
		}
		for v19 in v13 do
			v_u_7 = v_u_7 + 1
			v18.packets[v19] = v_u_7
			v16[v19] = v13[v19](v_u_7)
			v_u_4.set(v_u_7, v16[v19])
		end
		for v20 in v14 do
			v_u_8 = v_u_8 + 1
			v18.queries[v20] = v_u_8
			v17[v20] = v14[v20](v_u_8)
			v_u_5.set(v_u_8, v17[v20])
		end
		for v21, v22 in v15 do
			v18.structs[v21] = v22
		end
		v11:write(v18)
	elseif v_u_6 == "client" then
		local v23 = v11:read()
		for v24, v25 in v13 do
			v16[v24] = v25(v23.packets[v24])
			v_u_4.set(v23.packets[v24], v16[v24])
		end
		for v26, v27 in v14 do
			v17[v26] = v27(v23.queries[v26])
			v_u_5.set(v23.queries[v26], v17[v26])
		end
	end
	return {
		["packets"] = v16,
		["queries"] = v17
	}
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[namespace]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3213"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = nil
local v_u_2 = nil
return {
	["start"] = function(p3)
		-- upvalues: (ref) v_u_1, (ref) v_u_2
		v_u_1 = {}
		v_u_2 = p3
	end,
	["add"] = function(p4)
		-- upvalues: (ref) v_u_1
		if v_u_1 then
			local v5 = v_u_1
			table.insert(v5, p4)
		end
	end,
	["currentLength"] = function()
		-- upvalues: (ref) v_u_1
		return v_u_1 and #v_u_1 or 0
	end,
	["currentName"] = function()
		-- upvalues: (ref) v_u_2
		return v_u_2
	end,
	["empty"] = function()
		-- upvalues: (ref) v_u_1
		if v_u_1 == nil then
			return {}
		end
		local v6 = v_u_1
		v_u_1 = nil
		return v6
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[namespaceDependencies]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3214"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
return {
	["set"] = function(p2, p3)
		-- upvalues: (copy) v_u_1
		v_u_1[p2] = p3
	end,
	["ref"] = function()
		-- upvalues: (copy) v_u_1
		return v_u_1
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[packetIDs]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3215"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
return {
	["set"] = function(p2, p3)
		-- upvalues: (copy) v_u_1
		v_u_1[p2] = p3
	end,
	["ref"] = function()
		-- upvalues: (copy) v_u_1
		return v_u_1
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[queryIDs]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3216"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[packets]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3217"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.types)
local v_u_1 = require(script.Parent.packet)
return function(p_u_2)
	-- upvalues: (copy) v_u_1
	return function(p3)
		-- upvalues: (ref) v_u_1, (copy) p_u_2
		return v_u_1(p_u_2, p3)
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[definePacket]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3218"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("RunService")
require(script.Parent.Parent.types)
local v_u_3 = require(script.Parent.Parent.process.client)
local v_u_4 = require(script.Parent.Parent.process.server)
local v_u_5 = v2:IsServer() and "server" or "client"
return function(p6, p_u_7)
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_5, (copy) v_u_1
	local v8 = p6.reliabilityType or "reliable"
	local v_u_9 = {}
	local v_u_10
	if v8 == "reliable" then
		v_u_10 = v_u_4.sendPlayerReliable
	else
		v_u_10 = v_u_4.sendPlayerUnreliable
	end
	local v_u_11
	if v8 == "reliable" then
		v_u_11 = v_u_4.sendAllReliable
	else
		v_u_11 = v_u_4.sendAllUnreliable
	end
	local v_u_12
	if v8 == "reliable" then
		v_u_12 = v_u_3.sendReliable
	else
		v_u_12 = v_u_3.sendUnreliable
	end
	local v_u_13 = p6.value.write
	local v_u_14 = {}
	local v16 = {
		["__index"] = function(p15)
			-- upvalues: (ref) v_u_5
			if (p15 == "sendTo" or (p15 == "sendToAllExcept" or p15 == "sendToAll")) and v_u_5 == "client" then
				error("You cannot use sendTo, sendToAllExcept, or sendToAll on the client")
			elseif p15 == "send" and v_u_5 == "server" then
				error("You cannot use send on the server")
			end
		end
	}
	setmetatable(v_u_14, v16)
	v_u_14.reader = p6.value.read
	if v_u_5 == "server" then
		function v_u_14.sendToList(p17, p18)
			-- upvalues: (copy) v_u_10, (copy) p_u_7, (copy) v_u_13
			for _, v19 in p18 do
				v_u_10(v19, p_u_7, v_u_13, p17)
			end
		end
		function v_u_14.sendTo(p20, p21)
			-- upvalues: (copy) v_u_10, (copy) p_u_7, (copy) v_u_13
			v_u_10(p21, p_u_7, v_u_13, p20)
		end
		function v_u_14.sendToAllExcept(p22, p23)
			-- upvalues: (ref) v_u_1, (copy) v_u_10, (copy) p_u_7, (copy) v_u_13
			for _, v24 in v_u_1:GetPlayers() do
				if v24 ~= p23 then
					v_u_10(v24, p_u_7, v_u_13, p22)
				end
			end
		end
		function v_u_14.sendToAll(p25)
			-- upvalues: (copy) v_u_11, (copy) p_u_7, (copy) v_u_13
			v_u_11(p_u_7, v_u_13, p25)
		end
	elseif v_u_5 == "client" then
		function v_u_14.send(p26)
			-- upvalues: (copy) v_u_12, (copy) p_u_7, (copy) v_u_13
			v_u_12(p_u_7, v_u_13, p26)
		end
	end
	function v_u_14.wait()
		-- upvalues: (copy) v_u_9
		local v_u_27 = nil
		local v_u_28 = coroutine.running()
		local v29 = v_u_9
		local function v32(p30, p31)
			-- upvalues: (copy) v_u_28, (ref) v_u_9, (ref) v_u_27
			task.spawn(v_u_28, p30, p31)
			table.remove(v_u_9, v_u_27)
		end
		table.insert(v29, v32)
		v_u_27 = #v_u_9
		return coroutine.yield()
	end
	function v_u_14.listen(p_u_33)
		-- upvalues: (copy) v_u_9, (copy) v_u_14
		local v34 = v_u_9
		table.insert(v34, p_u_33)
		return function()
			-- upvalues: (ref) v_u_14, (copy) p_u_33
			v_u_14.disconnect(p_u_33)
		end
	end
	function v_u_14.disconnectAll()
		-- upvalues: (copy) v_u_9
		table.clear(v_u_9)
	end
	function v_u_14.disconnect(p35)
		-- upvalues: (copy) v_u_9
		table.remove(v_u_9, table.find(v_u_9, p35))
	end
	function v_u_14.listenOnce(p36)
		-- upvalues: (copy) v_u_9
		local v37 = v_u_9
		table.insert(v37, {
			["OnceCallback"] = p36
		})
	end
	function v_u_14.getListeners()
		-- upvalues: (copy) v_u_9
		return v_u_9
	end
	return v_u_14
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[packet]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3219"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[process]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3220"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.types)
local v_u_1 = nil
local v_u_2 = nil
local v_u_3 = nil
local v_u_4 = nil
local v_u_5 = nil
return {
	["alloc"] = function(p6)
		-- upvalues: (ref) v_u_3, (ref) v_u_2, (ref) v_u_4
		if v_u_2 <= v_u_3 + p6 then
			local v7 = v_u_2 * 1.5
			v_u_2 = math.floor(v7)
			local v8 = buffer.create(v_u_2)
			buffer.copy(v8, 0, v_u_4)
			v_u_4 = v8
		end
	end,
	["dyn_alloc"] = function(p9)
		-- upvalues: (ref) v_u_3, (ref) v_u_2, (ref) v_u_4
		while v_u_2 <= v_u_3 + p9 do
			local v10 = v_u_2 * 1.5
			v_u_2 = math.floor(v10)
		end
		local v11 = buffer.create(v_u_2)
		buffer.copy(v11, 0, v_u_4)
		v_u_4 = v11
	end,
	["u8NoAlloc"] = function(p12)
		-- upvalues: (ref) v_u_4, (ref) v_u_3
		local v13 = v_u_4
		local v14 = v_u_3
		buffer.writeu8(v13, v14, p12)
		v_u_3 = v_u_3 + 1
	end,
	["u8"] = function(p15)
		-- upvalues: (ref) v_u_3, (ref) v_u_2, (ref) v_u_4
		if v_u_2 <= v_u_3 + 1 then
			local v16 = v_u_2 * 1.5
			v_u_2 = math.floor(v16)
			local v17 = buffer.create(v_u_2)
			buffer.copy(v17, 0, v_u_4)
			v_u_4 = v17
		end
		local v18 = v_u_4
		local v19 = v_u_3
		buffer.writeu8(v18, v19, p15)
		v_u_3 = v_u_3 + 1
	end,
	["i8"] = function(p20)
		-- upvalues: (ref) v_u_3, (ref) v_u_2, (ref) v_u_4
		if v_u_2 <= v_u_3 + 1 then
			local v21 = v_u_2 * 1.5
			v_u_2 = math.floor(v21)
			local v22 = buffer.create(v_u_2)
			buffer.copy(v22, 0, v_u_4)
			v_u_4 = v22
		end
		local v23 = v_u_4
		local v24 = v_u_3
		buffer.writei8(v23, v24, p20)
		v_u_3 = v_u_3 + 1
	end,
	["reference"] = function(p25)
		-- upvalues: (ref) v_u_5, (ref) v_u_4, (ref) v_u_3
		local v26 = v_u_5
		table.insert(v26, p25)
		local v27 = #v_u_5
		local v28 = v_u_4
		local v29 = v_u_3
		buffer.writeu8(v28, v29, v27)
		v_u_3 = v_u_3 + 1
	end,
	["u16"] = function(p30)
		-- upvalues: (ref) v_u_3, (ref) v_u_2, (ref) v_u_4
		if v_u_2 <= v_u_3 + 2 then
			local v31 = v_u_2 * 1.5
			v_u_2 = math.floor(v31)
			local v32 = buffer.create(v_u_2)
			buffer.copy(v32, 0, v_u_4)
			v_u_4 = v32
		end
		local v33 = v_u_4
		local v34 = v_u_3
		buffer.writeu16(v33, v34, p30)
		v_u_3 = v_u_3 + 2
	end,
	["i16"] = function(p35)
		-- upvalues: (ref) v_u_3, (ref) v_u_2, (ref) v_u_4
		if v_u_2 <= v_u_3 + 2 then
			local v36 = v_u_2 * 1.5
			v_u_2 = math.floor(v36)
			local v37 = buffer.create(v_u_2)
			buffer.copy(v37, 0, v_u_4)
			v_u_4 = v37
		end
		local v38 = v_u_4
		local v39 = v_u_3
		buffer.writeu16(v38, v39, p35)
		v_u_3 = v_u_3 + 2
	end,
	["u32"] = function(p40)
		-- upvalues: (ref) v_u_3, (ref) v_u_2, (ref) v_u_4
		if v_u_2 <= v_u_3 + 4 then
			local v41 = v_u_2 * 1.5
			v_u_2 = math.floor(v41)
			local v42 = buffer.create(v_u_2)
			buffer.copy(v42, 0, v_u_4)
			v_u_4 = v42
		end
		local v43 = v_u_4
		local v44 = v_u_3
		buffer.writeu32(v43, v44, p40)
		v_u_3 = v_u_3 + 4
	end,
	["writestring"] = function(p45)
		-- upvalues: (ref) v_u_4, (ref) v_u_3
		buffer.writestring(v_u_4, v_u_3, p45)
		v_u_3 = v_u_3 + string.len(p45)
	end,
	["i32"] = function(p46)
		-- upvalues: (ref) v_u_3, (ref) v_u_2, (ref) v_u_4
		if v_u_2 <= v_u_3 + 4 then
			local v47 = v_u_2 * 1.5
			v_u_2 = math.floor(v47)
			local v48 = buffer.create(v_u_2)
			buffer.copy(v48, 0, v_u_4)
			v_u_4 = v48
		end
		local v49 = v_u_4
		local v50 = v_u_3
		buffer.writei32(v49, v50, p46)
		v_u_3 = v_u_3 + 4
	end,
	["f32NoAlloc"] = function(p51)
		-- upvalues: (ref) v_u_4, (ref) v_u_3
		local v52 = v_u_4
		local v53 = v_u_3
		buffer.writef32(v52, v53, p51)
		v_u_3 = v_u_3 + 4
	end,
	["f64NoAlloc"] = function(p54)
		-- upvalues: (ref) v_u_4, (ref) v_u_3
		local v55 = v_u_4
		local v56 = v_u_3
		buffer.writef64(v55, v56, p54)
		v_u_3 = v_u_3 + 4
	end,
	["f32"] = function(p57)
		-- upvalues: (ref) v_u_3, (ref) v_u_2, (ref) v_u_4
		if v_u_2 <= v_u_3 + 4 then
			local v58 = v_u_2 * 1.5
			v_u_2 = math.floor(v58)
			local v59 = buffer.create(v_u_2)
			buffer.copy(v59, 0, v_u_4)
			v_u_4 = v59
		end
		local v60 = v_u_4
		local v61 = v_u_3
		buffer.writef32(v60, v61, p57)
		v_u_3 = v_u_3 + 4
	end,
	["f64"] = function(p62)
		-- upvalues: (ref) v_u_3, (ref) v_u_2, (ref) v_u_4
		if v_u_2 <= v_u_3 + 8 then
			local v63 = v_u_2 * 1.5
			v_u_2 = math.floor(v63)
			local v64 = buffer.create(v_u_2)
			buffer.copy(v64, 0, v_u_4)
			v_u_4 = v64
		end
		local v65 = v_u_4
		local v66 = v_u_3
		buffer.writef64(v65, v66, p62)
		v_u_3 = v_u_3 + 8
	end,
	["copy"] = function(p67)
		-- upvalues: (ref) v_u_4, (ref) v_u_3
		buffer.copy(v_u_4, v_u_3, p67)
		v_u_3 = v_u_3 + buffer.len(p67)
	end,
	["bool"] = function(p68)
		-- upvalues: (ref) v_u_3, (ref) v_u_2, (ref) v_u_4
		if v_u_2 <= v_u_3 + 1 then
			local v69 = v_u_2 * 1.5
			v_u_2 = math.floor(v69)
			local v70 = buffer.create(v_u_2)
			buffer.copy(v70, 0, v_u_4)
			v_u_4 = v70
		end
		local v71 = v_u_4
		local v72 = v_u_3
		buffer.writeu8(v71, v72, p68 and 1 or 0)
		v_u_3 = v_u_3 + 1
	end,
	["load"] = function(p73)
		-- upvalues: (ref) v_u_1, (ref) v_u_2, (ref) v_u_3, (ref) v_u_5, (ref) v_u_4
		v_u_1 = p73
		v_u_2 = p73.size
		v_u_3 = p73.cursor
		v_u_5 = p73.references
		v_u_4 = p73.buff
	end,
	["export"] = function()
		-- upvalues: (ref) v_u_1, (ref) v_u_2, (ref) v_u_3, (ref) v_u_5, (ref) v_u_4
		v_u_1.size = v_u_2
		v_u_1.cursor = v_u_3
		v_u_1.references = v_u_5
		v_u_1.buff = v_u_4
		return v_u_1
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[bufferWriter]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3221"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
require(script.Parent.Parent.types)
local v_u_3 = require(script.Parent.read)
local v_u_4 = require(script.Parent.bufferWriter)
local v_u_5 = v_u_4.alloc
local v_u_6 = v_u_4.u8
local v_u_7 = v_u_4.load
local function v_u_10(p8, p9)
	-- upvalues: (copy) v_u_3
	v_u_3(p8, p9)
end
local function v_u_11()
	return {
		["cursor"] = 0,
		["size"] = 256,
		["references"] = {},
		["buff"] = buffer.create(256)
	}
end
local v_u_12 = v_u_11()
local v_u_13 = v_u_11()
local v_u_14 = {}
return {
	["sendReliable"] = function(p15, p16, p17)
		-- upvalues: (ref) v_u_12, (copy) v_u_7, (copy) v_u_5, (copy) v_u_6, (copy) v_u_4
		v_u_12 = v_u_7(v_u_12)
		v_u_5(1)
		v_u_6(p15)
		p16(p17)
		v_u_12 = v_u_4.export()
	end,
	["sendUnreliable"] = function(p18, p19, p20)
		-- upvalues: (ref) v_u_13, (copy) v_u_7, (copy) v_u_5, (copy) v_u_6, (copy) v_u_4
		v_u_13 = v_u_7(v_u_13)
		v_u_5(1)
		v_u_6(p18)
		p19(p20)
		v_u_13 = v_u_4.export()
	end,
	["invoke"] = function(p21, p22, p23)
		-- upvalues: (copy) v_u_11, (copy) v_u_7, (copy) v_u_5, (copy) v_u_6, (copy) v_u_4, (copy) v_u_14, (copy) v_u_3
		v_u_7((v_u_11()))
		v_u_5(1)
		v_u_6(p21)
		p22(p23)
		local v_u_24 = {
			["ready"] = false,
			["response"] = {},
			["data"] = v_u_4.export(),
			["id"] = p21
		}
		local v25 = v_u_14
		table.insert(v25, v_u_24)
		local v_u_26 = coroutine.running()
		task.spawn(function()
			-- upvalues: (copy) v_u_24, (copy) v_u_26
			while not v_u_24.ready do
				task.wait()
			end
			coroutine.resume(v_u_26)
		end)
		coroutine.yield()
		return v_u_3(v_u_24.response.dumpBuffer, v_u_24.response.reference, nil, "query")
	end,
	["start"] = function()
		-- upvalues: (copy) v_u_1, (copy) v_u_10, (copy) v_u_2, (ref) v_u_12, (ref) v_u_13, (copy) v_u_14
		local v_u_27 = v_u_1:WaitForChild("ByteNetReliable")
		v_u_27.OnClientEvent:Connect(v_u_10)
		local v_u_28 = v_u_1:WaitForChild("ByteNetUnreliable")
		v_u_28.OnClientEvent:Connect(v_u_10)
		local v_u_29 = v_u_1:WaitForChild("ByteNetQuery")
		v_u_2.Heartbeat:Connect(function()
			-- upvalues: (ref) v_u_12, (copy) v_u_27, (ref) v_u_13, (copy) v_u_28, (ref) v_u_14, (copy) v_u_29
			if v_u_12.cursor > 0 then
				local v30 = v_u_12
				local v31 = v30.cursor
				local v32 = buffer.create(v31)
				buffer.copy(v32, 0, v30.buff, 0, v31)
				local v33
				if #v30.references > 0 then
					v33 = v30.references
				else
					v33 = nil
				end
				v_u_27:FireServer(v32, v33)
				v_u_12.cursor = 0
				table.clear(v_u_12.references)
			end
			if v_u_13.cursor > 0 then
				local v34 = v_u_13
				local v35 = v34.cursor
				local v36 = buffer.create(v35)
				buffer.copy(v36, 0, v34.buff, 0, v35)
				local v37
				if #v34.references > 0 then
					v37 = v34.references
				else
					v37 = nil
				end
				v_u_28:FireServer(v36, v37)
				v_u_13.cursor = 0
				table.clear(v_u_13.references)
			end
			for v_u_38 = #v_u_14, 1, -1 do
				task.spawn(function()
					-- upvalues: (ref) v_u_14, (copy) v_u_38, (ref) v_u_29
					local v39 = v_u_14[v_u_38]
					table.remove(v_u_14, v_u_38)
					if v39.data.cursor > 0 then
						local v40 = v39.data
						local v41 = v40.cursor
						local v42 = buffer.create(v41)
						buffer.copy(v42, 0, v40.buff, 0, v41)
						local v43
						if #v40.references > 0 then
							v43 = v40.references
						else
							v43 = nil
						end
						local v44, v45 = v_u_29:InvokeServer(v42, v43, v39.id)
						v39.ready = true
						v39.response = {
							["dumpBuffer"] = v44,
							["reference"] = v45
						}
						v39.data.cursor = 0
						table.clear(v39.data.references)
					end
				end)
			end
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[client]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3222"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("RunService")
local v2 = require(script.Parent.Parent.namespaces.packetIDs)
local v3 = require(script.Parent.Parent.namespaces.queryIDs)
local v_u_4 = require(script.Parent.readRefs)
require(script.Parent.Parent.types)
local v_u_5 = require(script.Parent.bufferWriter)
local v_u_6 = v_u_5.alloc
local v_u_7 = v_u_5.u8
local v_u_8 = v_u_5.load
local v_u_9 = v2.ref()
local v_u_10 = v3.ref()
local v_u_11 = nil
local function v_u_14(p12, ...)
	-- upvalues: (ref) v_u_11
	local v13 = v_u_11
	v_u_11 = nil
	p12(...)
	v_u_11 = v13
end
local function v_u_15()
	-- upvalues: (copy) v_u_14
	while true do
		v_u_14(coroutine.yield())
	end
end
local function v_u_19(p16, p17, p18, ...)
	-- upvalues: (ref) v_u_11, (copy) v_u_15
	if v_u_11 == nil then
		v_u_11 = coroutine.create(v_u_15)
		coroutine.resume(v_u_11)
	end
	task.spawn(v_u_11, p16, ...)
	if p17 then
		p18.disconnect(p16)
	end
end
local function v_u_25(p_u_20, p21, p22, ...)
	-- upvalues: (ref) v_u_11, (copy) v_u_15
	local v_u_23 = nil
	local v24 = tick()
	if v_u_11 == nil then
		v_u_11 = coroutine.create(v_u_15)
		coroutine.resume(v_u_11)
	end
	task.spawn(v_u_11, function(...)
		-- upvalues: (ref) v_u_23, (copy) p_u_20
		v_u_23 = p_u_20(...)
	end, ...)
	repeat
		task.wait()
	until v_u_23 or tick() - v24 > 10
	if not v_u_23 then
		warn("queryResult hung for 10 seconds, returning null.")
	end
	if p21 then
		p22.disconnect(p_u_20)
	end
	return v_u_23
end
local function v_u_26()
	return {
		["cursor"] = 0,
		["size"] = 256,
		["references"] = {},
		["buff"] = buffer.create(256)
	}
end
return function(p27, p28, p29, p30, p31)
	-- upvalues: (copy) v_u_4, (copy) v_u_9, (copy) v_u_10, (copy) v_u_1, (copy) v_u_19, (copy) v_u_25, (copy) v_u_26, (copy) v_u_8, (copy) v_u_6, (copy) v_u_7, (copy) v_u_5
	local v32 = buffer.len(p27)
	v_u_4.set(p28)
	local v33 = 0
	local v34 = p30 or "packet"
	while v33 < v32 do
		local v35 = nil
		if v34 == "packet" then
			v35 = v_u_9[buffer.readu8(p27, v33)]
		elseif v34 == "query" then
			v35 = v_u_10[buffer.readu8(p27, v33)]
		else
			error("readType not valid.")
		end
		if not v35 then
			error("No readable entity found for ID: " .. buffer.readu8(p27, v33) .. " for type: " .. v34)
		end
		local v36 = v33 + 1
		local v37 = nil
		local v38 = nil
		if v34 == "query" then
			if v_u_1:IsServer() then
				v37, v38 = v35.requestReader(p27, v36)
			elseif v_u_1:IsClient() then
				v37, v38 = v35.responseReader(p27, v36)
			end
		elseif v34 == "packet" then
			v37, v38 = v35.reader(p27, v36)
		end
		v33 = v36 + v38
		if v34 == "packet" then
			for _, v39 in v35.getListeners() do
				if typeof(v39) == "table" then
					v_u_19(v39.OnceCallback, true, v35, v37, p29)
				elseif typeof(v39) == "function" then
					v_u_19(v39, false, v35, v37, p29)
				else
					error("Listener type not recognised for packet: " .. typeof(v39))
				end
			end
		elseif v34 == "query" then
			if v_u_1:IsServer() then
				for _, v40 in v35.getListeners() do
					local v41 = nil
					if typeof(v40) == "table" then
						v41 = v_u_25(v40.OnceCallback, true, v35, v37, p29)
					elseif typeof(v40) == "function" then
						v41 = v_u_25(v40, false, v35, v37, p29)
					else
						error("Listener type not recognised for query: " .. typeof(v40))
					end
					v_u_8((v_u_26()))
					v_u_6(1)
					v_u_7(p31)
					v35.responseWriter(v41)
					local v42 = v_u_5.export()
					if v42.cursor > 0 then
						local v43 = v42.cursor
						local v44 = buffer.create(v43)
						buffer.copy(v44, 0, v42.buff, 0, v43)
						if #v42.references > 0 then
							return v44, v42.references
						else
							return v44, nil
						end
					end
				end
			elseif v_u_1:IsClient() then
				return v37
			end
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[read]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3223"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = nil
return {
	["set"] = function(p2)
		-- upvalues: (ref) v_u_1
		v_u_1 = p2
	end,
	["get"] = function()
		-- upvalues: (ref) v_u_1
		return v_u_1
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[readRefs]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3224"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
require(script.Parent.Parent.types)
local v_u_4 = require(script.Parent.read)
local v_u_5 = require(script.Parent.bufferWriter)
local v_u_6 = v_u_5.alloc
local v_u_7 = v_u_5.u8
local v_u_8 = v_u_5.load
local v_u_9 = {}
local v_u_10 = {}
local function v_u_11()
	return {
		["cursor"] = 0,
		["size"] = 256,
		["references"] = {},
		["buff"] = buffer.create(256)
	}
end
local v_u_12 = v_u_11()
local v_u_13 = v_u_11()
local function v_u_17(p14, p15, p16)
	-- upvalues: (copy) v_u_4
	if typeof(p15) == "buffer" then
		v_u_4(p15, p16, p14)
	end
end
local function v_u_24(p18, p19, p20, p21)
	-- upvalues: (copy) v_u_4
	if typeof(p19) == "buffer" then
		local v22, v23 = v_u_4(p19, p20, p18, "query", p21)
		return v22, v23
	end
	warn("Only buffer types accepted.")
end
local function v_u_26(p25)
	-- upvalues: (copy) v_u_9, (copy) v_u_11, (copy) v_u_10
	if not v_u_9[p25] then
		v_u_9[p25] = v_u_11()
	end
	if not v_u_10[p25] then
		v_u_10[p25] = v_u_11()
	end
end
return {
	["sendAllReliable"] = function(p27, p28, p29)
		-- upvalues: (copy) v_u_8, (ref) v_u_12, (copy) v_u_6, (copy) v_u_7, (copy) v_u_5
		v_u_8(v_u_12)
		v_u_6(1)
		v_u_7(p27)
		p28(p29)
		v_u_12 = v_u_5.export()
	end,
	["sendAllUnreliable"] = function(p30, p31, p32)
		-- upvalues: (copy) v_u_8, (ref) v_u_13, (copy) v_u_11, (copy) v_u_6, (copy) v_u_7, (copy) v_u_5
		v_u_8(v_u_13 or v_u_11())
		v_u_6(1)
		v_u_7(p30)
		p31(p32)
		v_u_13 = v_u_5.export()
	end,
	["sendPlayerReliable"] = function(p33, p34, p35, p36)
		-- upvalues: (copy) v_u_8, (copy) v_u_9, (copy) v_u_11, (copy) v_u_6, (copy) v_u_7, (copy) v_u_5
		v_u_8(v_u_9[p33] or v_u_11())
		v_u_6(1)
		v_u_7(p34)
		p35(p36)
		v_u_9[p33] = v_u_5.export()
	end,
	["sendPlayerUnreliable"] = function(p37, p38, p39, p40)
		-- upvalues: (copy) v_u_8, (copy) v_u_10, (copy) v_u_6, (copy) v_u_7, (copy) v_u_5
		v_u_8(v_u_10[p37])
		v_u_6(1)
		v_u_7(p38)
		p39(p40)
		v_u_10[p37] = v_u_5.export()
	end,
	["start"] = function()
		-- upvalues: (copy) v_u_17, (copy) v_u_2, (copy) v_u_24, (copy) v_u_1, (copy) v_u_9, (copy) v_u_11, (copy) v_u_10, (copy) v_u_26, (copy) v_u_3, (ref) v_u_12, (ref) v_u_13
		local v_u_41 = Instance.new("RemoteEvent")
		v_u_41.Name = "ByteNetReliable"
		v_u_41.OnServerEvent:Connect(v_u_17)
		v_u_41.Parent = v_u_2
		local v_u_42 = Instance.new("UnreliableRemoteEvent")
		v_u_42.Name = "ByteNetUnreliable"
		v_u_42.OnServerEvent:Connect(v_u_17)
		v_u_42.Parent = v_u_2
		local v43 = Instance.new("RemoteFunction")
		v43.Name = "ByteNetQuery"
		v43.OnServerInvoke = v_u_24
		v43.Parent = v_u_2
		for _, v44 in v_u_1:GetPlayers() do
			if not v_u_9[v44] then
				v_u_9[v44] = v_u_11()
			end
			if not v_u_10[v44] then
				v_u_10[v44] = v_u_11()
			end
		end
		v_u_1.PlayerAdded:Connect(v_u_26)
		v_u_3.Heartbeat:Connect(function()
			-- upvalues: (ref) v_u_12, (copy) v_u_41, (ref) v_u_13, (copy) v_u_42, (ref) v_u_1, (ref) v_u_9, (ref) v_u_10
			if v_u_12.cursor > 0 then
				local v45 = v_u_12
				local v46 = v45.cursor
				local v47 = buffer.create(v46)
				buffer.copy(v47, 0, v45.buff, 0, v46)
				local v48
				if #v45.references > 0 then
					v48 = v45.references
				else
					v48 = nil
				end
				v_u_41:FireAllClients(v47, v48)
				v_u_12.cursor = 0
				table.clear(v_u_12.references)
			end
			if v_u_13.cursor > 0 then
				local v49 = v_u_13
				local v50 = v49.cursor
				local v51 = buffer.create(v50)
				buffer.copy(v51, 0, v49.buff, 0, v50)
				local v52
				if #v49.references > 0 then
					v52 = v49.references
				else
					v52 = nil
				end
				v_u_42:FireAllClients(v51, v52)
				v_u_13.cursor = 0
				table.clear(v_u_13.references)
			end
			for _, v53 in v_u_1:GetPlayers() do
				if v_u_9[v53].cursor > 0 then
					local v54 = v_u_9[v53]
					local v55 = v54.cursor
					local v56 = buffer.create(v55)
					buffer.copy(v56, 0, v54.buff, 0, v55)
					local v57
					if #v54.references > 0 then
						v57 = v54.references
					else
						v57 = nil
					end
					v_u_41:FireClient(v53, v56, v57)
					v_u_9[v53].cursor = 0
					table.clear(v_u_9[v53].references)
				end
				if v_u_10[v53].cursor > 0 then
					local v58 = v_u_10[v53]
					local v59 = v58.cursor
					local v60 = buffer.create(v59)
					buffer.copy(v60, 0, v58.buff, 0, v59)
					local v61
					if #v58.references > 0 then
						v61 = v58.references
					else
						v61 = nil
					end
					v_u_42:FireClient(v53, v60, v61)
					v_u_10[v53].cursor = 0
					table.clear(v_u_10[v53].references)
				end
			end
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[server]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3225"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[queries]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3226"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.types)
local v_u_1 = require(script.Parent.query)
return function(p_u_2)
	-- upvalues: (copy) v_u_1
	return function(p3)
		-- upvalues: (ref) v_u_1, (copy) p_u_2
		return v_u_1(p_u_2, p3)
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[defineQuery]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3227"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

game:GetService("Players")
local v1 = game:GetService("RunService")
require(script.Parent.Parent.types)
local v_u_2 = require(script.Parent.Parent.process.client)
require(script.Parent.Parent.process.server)
local v_u_3 = v1:IsServer() and "server" or "client"
return function(p4, p_u_5)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v_u_6 = {}
	local v_u_7 = v_u_2.invoke
	local v_u_8 = p4.request.write
	local _ = p4.response.write
	local v_u_9 = {
		["requestReader"] = p4.request.read,
		["responseReader"] = p4.response.read,
		["responseWriter"] = p4.response.write
	}
	if v_u_3 == "client" then
		function v_u_9.invoke(p10)
			-- upvalues: (copy) v_u_7, (copy) p_u_5, (copy) v_u_8
			return v_u_7(p_u_5, v_u_8, p10)
		end
	end
	function v_u_9.wait()
		-- upvalues: (copy) v_u_6
		local v_u_11 = nil
		local v_u_12 = coroutine.running()
		local v13 = v_u_6
		local function v16(p14, p15)
			-- upvalues: (copy) v_u_12, (ref) v_u_6, (ref) v_u_11
			print(p14)
			task.spawn(v_u_12, p14, p15)
			table.remove(v_u_6, v_u_11)
		end
		table.insert(v13, v16)
		v_u_11 = #v_u_6
		return coroutine.yield()
	end
	function v_u_9.listen(p_u_17)
		-- upvalues: (copy) v_u_6, (copy) v_u_9
		local v18 = v_u_6
		table.insert(v18, p_u_17)
		return function()
			-- upvalues: (ref) v_u_9, (copy) p_u_17
			v_u_9.disconnect(p_u_17)
		end
	end
	function v_u_9.disconnectAll()
		-- upvalues: (copy) v_u_6
		table.clear(v_u_6)
	end
	function v_u_9.disconnect(p19)
		-- upvalues: (copy) v_u_6
		table.remove(v_u_6, table.find(v_u_6, p19))
	end
	function v_u_9.listenOnce(p20)
		-- upvalues: (copy) v_u_6
		local v21 = v_u_6
		table.insert(v21, {
			["OnceCallback"] = p20
		})
	end
	function v_u_9.getListeners()
		-- upvalues: (copy) v_u_6
		return v_u_6
	end
	return v_u_9
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[query]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3228"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[replicated]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3229"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("HttpService")
local v_u_2 = game:GetService("RunService"):IsServer() and "server" or "client"
local v3 = {}
local v_u_4 = {
	["__index"] = v3
}
function v3.write(p5, p6)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v7 = v_u_2 == "server"
	assert(v7, "cannot write to replicatdvalue on client")
	p5._luauData = p6
	p5._value.Value = v_u_1:JSONEncode(p6)
end
function v3.read(p8)
	return p8._luauData
end
return function(p9)
	-- upvalues: (copy) v_u_4, (copy) v_u_2, (copy) v_u_1
	local v10 = v_u_4
	local v_u_11 = setmetatable({}, v10)
	v_u_11._luauData = {}
	v_u_11._value = p9
	if v_u_2 == "client" then
		v_u_11._luauData = table.freeze(v_u_1:JSONDecode(p9.Value))
		p9.Changed:Connect(function(p12)
			-- upvalues: (copy) v_u_11, (ref) v_u_1
			if p12 then
				v_u_11._luauData = table.freeze(v_u_1:JSONDecode(p12))
			end
		end)
	end
	return v_u_11
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[replicatedValue]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3230"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v_u_3 = require(script.Parent.replicatedValue)
local v_u_4 = v2:IsServer() and "server" or "client"
local v_u_5 = nil
local v_u_6 = {}
return {
	["start"] = function()
		-- upvalues: (copy) v_u_4, (copy) v_u_1, (ref) v_u_5
		if v_u_4 == "server" then
			local v7 = Instance.new("Folder")
			v7.Name = "BytenetStorage"
			v7.Parent = v_u_1
			v_u_5 = v7
		elseif v_u_4 == "client" then
			v_u_5 = v_u_1:WaitForChild("BytenetStorage")
		end
	end,
	["access"] = function(p8)
		-- upvalues: (copy) v_u_6, (copy) v_u_4, (ref) v_u_5, (copy) v_u_3
		if v_u_6[p8] then
			return v_u_6[p8]
		end
		if v_u_4 == "client" then
			local v9 = v_u_5:FindFirstChild(p8)
			if v9 and v9:IsA("StringValue") then
				local v10 = v_u_3(v9)
				v_u_6[p8] = v10
				return v10
			end
		elseif v_u_4 == "server" then
			local v11 = Instance.new("StringValue")
			v11.Name = p8
			v11.Parent = v_u_5
			local v12 = v_u_3(v11)
			v_u_6[p8] = v12
			return v12
		end
		return v_u_6[p8]
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[values]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item></Item><Item class="Folder" referent="3231"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[sleitnick_table-util@1.2.1]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3232"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
local v_u_2 = game:GetService("HttpService")
local v_u_3 = Random.new()
local function v_u_24(p4, p5)
	-- upvalues: (copy) v_u_24
	local v6 = type(p4) == "table"
	assert(v6, "First argument must be a table")
	local v7 = type(p5) == "table"
	assert(v7, "Second argument must be a table")
	local v8 = table.clone(p4)
	for v9, v10 in pairs(v8) do
		local v11 = p5[v9]
		if v11 == nil then
			v8[v9] = nil
		elseif type(v10) == type(v11) then
			if type(v10) == "table" then
				v8[v9] = v_u_24(v10, v11)
			end
		elseif type(v11) == "table" then
			local function v_u_16(p12)
				-- upvalues: (copy) v_u_16
				local v13 = table.clone(p12)
				for v14, v15 in v13 do
					if type(v15) == "table" then
						v13[v14] = v_u_16(v15)
					end
				end
				return v13
			end
			v8[v9] = v_u_16(v11)
		else
			v8[v9] = v11
		end
	end
	for v17, v18 in pairs(p5) do
		if v8[v17] == nil then
			if type(v18) == "table" then
				local function v_u_23(p19)
					-- upvalues: (copy) v_u_23
					local v20 = table.clone(p19)
					for v21, v22 in v20 do
						if type(v22) == "table" then
							v20[v21] = v_u_23(v22)
						end
					end
					return v20
				end
				v8[v17] = v_u_23(v18)
			else
				v8[v17] = v18
			end
		end
	end
	return v8
end
local function v_u_43(p25, p26)
	-- upvalues: (copy) v_u_43
	local v27 = type(p25) == "table"
	assert(v27, "First argument must be a table")
	local v28 = type(p26) == "table"
	assert(v28, "Second argument must be a table")
	local v29 = table.clone(p25)
	for v30, v31 in p26 do
		local v32 = p25[v30]
		if v32 == nil then
			if type(v31) == "table" then
				local function v_u_37(p33)
					-- upvalues: (copy) v_u_37
					local v34 = table.clone(p33)
					for v35, v36 in v34 do
						if type(v36) == "table" then
							v34[v35] = v_u_37(v36)
						end
					end
					return v34
				end
				v29[v30] = v_u_37(v31)
			else
				v29[v30] = v31
			end
		elseif type(v32) == "table" then
			if type(v31) == "table" then
				v29[v30] = v_u_43(v32, v31)
			else
				local function v_u_42(p38)
					-- upvalues: (copy) v_u_42
					local v39 = table.clone(p38)
					for v40, v41 in v39 do
						if type(v41) == "table" then
							v39[v40] = v_u_42(v41)
						end
					end
					return v39
				end
				v29[v30] = v_u_42(v32)
			end
		end
	end
	return v29
end
local function v_u_51(p44, p45)
	local v46 = type(p44) == "table"
	assert(v46, "First argument must be a table")
	local v47 = type(p45) == "function"
	assert(v47, "Second argument must be a function")
	local v48 = table.create(#p44)
	for v49, v50 in p44 do
		v48[v49] = p45(v50, v49, p44)
	end
	return v48
end
function v1.Copy(p52, p53)
	if not p53 then
		return table.clone(p52)
	end
	local function v_u_58(p54)
		-- upvalues: (copy) v_u_58
		local v55 = table.clone(p54)
		for v56, v57 in v55 do
			if type(v57) == "table" then
				v55[v56] = v_u_58(v57)
			end
		end
		return v55
	end
	return v_u_58(p52)
end
v1.Sync = v_u_24
v1.Reconcile = v_u_43
function v1.SwapRemove(p59, p60)
	local v61 = #p59
	p59[p60] = p59[v61]
	p59[v61] = nil
end
function v1.SwapRemoveFirstValue(p62, p63)
	local v64 = table.find(p62, p63)
	if v64 then
		local v65 = #p62
		p62[v64] = p62[v65]
		p62[v65] = nil
	end
	return v64
end
v1.Map = v_u_51
function v1.Filter(p66, p67)
	local v68 = type(p66) == "table"
	assert(v68, "First argument must be a table")
	local v69 = type(p67) == "function"
	assert(v69, "Second argument must be a function")
	local v70 = table.create(#p66)
	if #p66 <= 0 then
		for v71, v72 in p66 do
			if p67(v72, v71, p66) then
				v70[v71] = v72
			end
		end
		return v70
	end
	local v73 = 0
	for v74, v75 in p66 do
		if p67(v75, v74, p66) then
			v73 = v73 + 1
			v70[v73] = v75
		end
	end
	return v70
end
function v1.Reduce(p76, p77, p78)
	local v79 = type(p76) == "table"
	assert(v79, "First argument must be a table")
	local v80 = type(p77) == "function"
	assert(v80, "Second argument must be a function")
	if #p76 > 0 then
		local v81
		if p78 == nil then
			p78 = p76[1]
			v81 = 2
		else
			v81 = 1
		end
		for v82 = v81, #p76 do
			p78 = p77(p78, p76[v82], v82, p76)
		end
		return p78
	else
		local v83
		if p78 == nil then
			v83 = next(p76)
			p78 = v83
		else
			v83 = nil
		end
		for v84, v85 in next, p76, v83 do
			p78 = p77(p78, v85, v84, p76)
		end
		return p78
	end
end
function v1.Assign(p86, ...)
	local v87 = table.clone(p86)
	for _, v88 in { ... } do
		for v89, v90 in v88 do
			v87[v89] = v90
		end
	end
	return v87
end
function v1.Extend(p91, p92)
	local v93 = table.clone(p91)
	for _, v94 in p92 do
		table.insert(v93, v94)
	end
	return v93
end
function v1.Reverse(p95)
	local v96 = #p95
	local v97 = table.create(v96)
	for v98 = 1, v96 do
		v97[v98] = p95[v96 - v98 + 1]
	end
	return v97
end
function v1.Shuffle(p99, p100)
	-- upvalues: (copy) v_u_3
	local v101 = type(p99) == "table"
	assert(v101, "First argument must be a table")
	local v102 = table.clone(p99)
	if typeof(p100) ~= "Random" then
		p100 = v_u_3
	end
	for v103 = #p99, 2, -1 do
		local v104 = p100:NextInteger(1, v103)
		local v105 = v102[v104]
		local v106 = v102[v103]
		v102[v103] = v105
		v102[v104] = v106
	end
	return v102
end
function v1.Sample(p107, p108, p109)
	-- upvalues: (copy) v_u_3
	local v110 = type(p107) == "table"
	assert(v110, "First argument must be a table")
	local v111 = type(p108) == "number"
	assert(v111, "Second argument must be a number")
	local v112 = #p107
	if v112 == 0 then
		return {}
	end
	local v113 = table.clone(p107)
	local v114 = table.create(p108)
	if typeof(p109) ~= "Random" then
		p109 = v_u_3
	end
	local v115 = math.clamp(p108, 1, v112)
	for v116 = 1, v115 do
		local v117 = p109:NextInteger(v116, v112)
		local v118 = v113[v117]
		local v119 = v113[v116]
		v113[v116] = v118
		v113[v117] = v119
	end
	table.move(v113, 1, v115, 1, v114)
	return v114
end
function v1.Flat(p120, p121)
	local v_u_122 = type(p121) ~= "number" and 1 or p121
	local v_u_123 = table.create(#p120)
	local function v_u_128(p124, p125)
		-- upvalues: (copy) v_u_122, (copy) v_u_128, (copy) v_u_123
		for _, v126 in p124 do
			if type(v126) == "table" and p125 < v_u_122 then
				v_u_128(v126, p125 + 1)
			else
				local v127 = v_u_123
				table.insert(v127, v126)
			end
		end
	end
	v_u_128(p120, 0)
	return v_u_123
end
function v1.FlatMap(p129, p130)
	-- upvalues: (copy) v_u_51
	local v131 = v_u_51(p129, p130)
	local v_u_132 = table.create(#v131)
	local v_u_133 = 1
	local function v_u_138(p134, p135)
		-- upvalues: (copy) v_u_133, (copy) v_u_138, (copy) v_u_132
		for _, v136 in p134 do
			if type(v136) == "table" and p135 < v_u_133 then
				v_u_138(v136, p135 + 1)
			else
				local v137 = v_u_132
				table.insert(v137, v136)
			end
		end
	end
	v_u_138(v131, 0)
	return v_u_132
end
function v1.Keys(p139)
	local v140 = table.create(#p139)
	for v141 in p139 do
		table.insert(v140, v141)
	end
	return v140
end
function v1.Values(p142)
	local v143 = table.create(#p142)
	for _, v144 in p142 do
		table.insert(v143, v144)
	end
	return v143
end
function v1.Find(p145, p146)
	for v147, v148 in p145 do
		if p146(v148, v147, p145) then
			return v148, v147
		end
	end
	return nil, nil
end
function v1.Every(p149, p150)
	for v151, v152 in p149 do
		if not p150(v152, v151, p149) then
			return false
		end
	end
	return true
end
function v1.Some(p153, p154)
	for v155, v156 in p153 do
		if p154(v156, v155, p153) then
			return true
		end
	end
	return false
end
function v1.Truncate(p157, p158)
	local v159 = #p157
	local v160 = math.clamp(p158, 1, v159)
	if v160 == v159 then
		return table.clone(p157)
	else
		return table.move(p157, 1, v160, 1, table.create(v160))
	end
end
function v1.Zip(...)
	local v161 = select("#", ...) > 0
	assert(v161, "Must supply at least 1 table")
	local function v169(p162, p163)
		local v164 = p163 + 1
		local v165 = {}
		for v166, v167 in p162 do
			local v168 = v167[v164]
			if v168 == nil then
				return nil, nil
			end
			v165[v166] = v168
		end
		return v164, v165
	end
	local function v176(p170, p171)
		local v172 = {}
		for v173, v174 in p170 do
			local v175 = next(v174, p171)
			if v175 == nil then
				return nil, nil
			end
			v172[v173] = v175
		end
		return p171, v172
	end
	local v177 = { ... }
	if #v177[1] > 0 then
		return v169, v177, 0
	else
		return v176, v177, nil
	end
end
function v1.Lock(p178)
	local function v_u_182(p179)
		-- upvalues: (copy) v_u_182
		for v180, v181 in pairs(p179) do
			if type(v181) == "table" then
				p179[v180] = v_u_182(v181)
			end
		end
		return table.freeze(p179)
	end
	return v_u_182(p178)
end
function v1.IsEmpty(p183)
	return next(p183) == nil
end
function v1.EncodeJSON(p184)
	-- upvalues: (copy) v_u_2
	return v_u_2:JSONEncode(p184)
end
function v1.DecodeJSON(p185)
	-- upvalues: (copy) v_u_2
	return v_u_2:JSONDecode(p185)
end
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[table-util]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3233"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function()
	local v_u_1 = require(script.Parent)
	describe("Copy (Deep)", function()
		-- upvalues: (copy) v_u_1
		it("should create a deep table copy", function()
			-- upvalues: (ref) v_u_1
			local v2 = {}
			local v3 = {}
			local v4 = {
				["c"] = {
					["d"] = 32
				}
			}
			v3.b = v4
			v2.a = v3
			local v5 = v_u_1.Copy(v2, true)
			expect(v2).never.to.equal(v5)
			expect(v2.a).never.to.equal(v5.a)
			expect(v5.a.b.c.d).to.equal(v2.a.b.c.d)
		end)
	end)
	describe("Copy (Shallow)", function()
		-- upvalues: (copy) v_u_1
		it("should create a shallow dictionary copy", function()
			-- upvalues: (ref) v_u_1
			local v6 = {}
			local v7 = {}
			local v8 = {
				["c"] = {
					["d"] = 32
				}
			}
			v7.b = v8
			v6.a = v7
			local v9 = v_u_1.Copy(v6)
			expect(v9).never.to.equal(v6)
			expect(v9.a).to.equal(v6.a)
			expect(v9.a.b.c.d).to.equal(v6.a.b.c.d)
		end)
		it("should create a shallow array copy", function()
			-- upvalues: (ref) v_u_1
			local v10 = {
				10,
				20,
				30,
				40
			}
			local v11 = v_u_1.Copy(v10)
			expect(v11).never.to.equal(v10)
			for v12, v13 in ipairs(v10) do
				expect(v11[v12]).to.equal(v13)
			end
		end)
	end)
	describe("Sync", function()
		-- upvalues: (copy) v_u_1
		it("should sync tables", function()
			-- upvalues: (ref) v_u_1
			local v14 = {
				["a"] = 32,
				["b"] = 64,
				["c"] = 128,
				["e"] = {
					["h"] = 1
				}
			}
			local v15 = {
				["a"] = 32,
				["b"] = 10,
				["d"] = 1,
				["e"] = {
					["h"] = 2,
					["n"] = 2
				},
				["f"] = {
					["x"] = 10
				}
			}
			local v16 = v_u_1.Sync(v15, v14)
			expect(v16.a).to.equal(v14.a)
			expect(v16.b).to.equal(10)
			expect(v16.c).to.equal(v14.c)
			expect(v16.d).never.to.be.ok()
			expect(v16.e.h).to.equal(2)
			expect(v16.e.n).never.to.be.ok()
			expect(v16.f).never.to.be.ok()
		end)
	end)
	describe("Reconcile", function()
		-- upvalues: (copy) v_u_1
		it("should reconcile table", function()
			-- upvalues: (ref) v_u_1
			local v17 = {
				["kills"] = 0,
				["deaths"] = 0,
				["xp"] = 10,
				["stuff"] = {},
				["stuff2"] = "abc",
				["stuff3"] = { "data" }
			}
			local v18 = {
				["kills"] = 10,
				["deaths"] = 4,
				["stuff"] = { "abc", "xyz" },
				["extra"] = 5,
				["stuff2"] = {
					["abc"] = 10
				},
				["stuff3"] = true
			}
			local v19 = v_u_1.Reconcile(v18, v17)
			expect(v19).never.to.equal(v18)
			expect(v19).never.to.equal(v17)
			expect(v19.kills).to.equal(10)
			expect(v19.deaths).to.equal(4)
			expect(v19.xp).to.equal(10)
			expect(v19.stuff[1]).to.equal("abc")
			expect(v19.stuff[2]).to.equal("xyz")
			expect(v19.extra).to.equal(5)
			local v20 = expect
			local v21 = v19.stuff2
			v20((type(v21))).to.equal("table")
			expect(v19.stuff2).never.to.equal(v18.stuff2)
			expect(v19.stuff2.abc).to.equal(10)
			local v22 = expect
			local v23 = v19.stuff3
			v22((type(v23))).to.equal("boolean")
			expect(v19.stuff3).to.equal(true)
		end)
	end)
	describe("SwapRemove", function()
		-- upvalues: (copy) v_u_1
		it("should swap remove index", function()
			-- upvalues: (ref) v_u_1
			local v24 = {
				1,
				2,
				3,
				4,
				5
			}
			v_u_1.SwapRemove(v24, 3)
			expect(#v24).to.equal(4)
			expect(v24[3]).to.equal(5)
		end)
	end)
	describe("SwapRemoveFirstValue", function()
		-- upvalues: (copy) v_u_1
		it("should swap remove first value given", function()
			-- upvalues: (ref) v_u_1
			local v25 = {
				"hello",
				"world",
				"goodbye",
				"planet"
			}
			v_u_1.SwapRemoveFirstValue(v25, "world")
			expect(#v25).to.equal(3)
			expect(v25[2]).to.equal("planet")
		end)
	end)
	describe("Map", function()
		-- upvalues: (copy) v_u_1
		it("should map table", function()
			-- upvalues: (ref) v_u_1
			local v27 = v_u_1.Map({
				{
					["FirstName"] = "John",
					["LastName"] = "Doe"
				},
				{
					["FirstName"] = "Jane",
					["LastName"] = "Smith"
				}
			}, function(p26)
				return p26.FirstName .. " " .. p26.LastName
			end)
			expect(v27[1]).to.equal("John Doe")
			expect(v27[2]).to.equal("Jane Smith")
		end)
	end)
	describe("Filter", function()
		-- upvalues: (copy) v_u_1
		it("should filter table", function()
			-- upvalues: (ref) v_u_1
			local v30 = v_u_1.Filter({
				10,
				20,
				30,
				40,
				50,
				60,
				70,
				80,
				90
			}, function(p28)
				local v29
				if p28 >= 30 then
					v29 = p28 <= 60
				else
					v29 = false
				end
				return v29
			end)
			expect(#v30).to.equal(4)
			expect(v30[1]).to.equal(30)
			expect(v30[#v30]).to.equal(60)
		end)
	end)
	describe("Reduce", function()
		-- upvalues: (copy) v_u_1
		it("should reduce table with numbers", function()
			-- upvalues: (ref) v_u_1
			local v33 = v_u_1.Reduce({
				1,
				2,
				3,
				4,
				5
			}, function(p31, p32)
				return p31 + p32
			end)
			expect(v33).to.equal(15)
		end)
		it("should reduce table", function()
			-- upvalues: (ref) v_u_1
			local v36 = v_u_1.Reduce({
				{
					["Score"] = 10
				},
				{
					["Score"] = 20
				},
				{
					["Score"] = 30
				}
			}, function(p34, p35)
				return p34 + p35.Score
			end, 0)
			expect(v36).to.equal(60)
		end)
		it("should reduce table with initial value", function()
			-- upvalues: (ref) v_u_1
			local v39 = v_u_1.Reduce({
				{
					["Score"] = 10
				},
				{
					["Score"] = 20
				},
				{
					["Score"] = 30
				}
			}, function(p37, p38)
				return p37 + p38.Score
			end, 40)
			expect(v39).to.equal(100)
		end)
		it("should reduce functions", function()
			-- upvalues: (ref) v_u_1
			local v45 = v_u_1.Reduce({ function(p40)
					return p40 * p40
				end, function(p41)
					return p41 * 2
				end }, function(p_u_42, p_u_43)
				return function(p44)
					-- upvalues: (copy) p_u_42, (copy) p_u_43
					return p_u_42(p_u_43(p44))
				end
			end)(10)
			expect(v45).to.equal(400)
		end)
	end)
	describe("Assign", function()
		-- upvalues: (copy) v_u_1
		it("should assign tables", function()
			-- upvalues: (ref) v_u_1
			local v46 = v_u_1.Assign({
				["a"] = 32,
				["x"] = 100
			}, {
				["b"] = 64,
				["c"] = 128
			}, {
				["a"] = 10,
				["c"] = 100,
				["d"] = 200
			})
			expect(v46.a).to.equal(10)
			expect(v46.b).to.equal(64)
			expect(v46.c).to.equal(100)
			expect(v46.d).to.equal(200)
			expect(v46.x).to.equal(100)
		end)
	end)
	describe("Extend", function()
		-- upvalues: (copy) v_u_1
		it("should extend tables", function()
			-- upvalues: (ref) v_u_1
			local v47 = v_u_1.Extend({ "a", "b", "c" }, { "d", "e", "f" })
			expect(table.concat(v47)).to.equal("abcdef")
		end)
	end)
	describe("Reverse", function()
		-- upvalues: (copy) v_u_1
		it("should create a table in reverse", function()
			-- upvalues: (ref) v_u_1
			local v48 = v_u_1.Reverse({ 1, 2, 3 })
			expect(table.concat(v48)).to.equal("321")
		end)
	end)
	describe("Shuffle", function()
		-- upvalues: (copy) v_u_1
		it("should shuffle a table", function()
			-- upvalues: (ref) v_u_1
			local v_u_49 = {
				1,
				2,
				3,
				4,
				5
			}
			expect(function()
				-- upvalues: (ref) v_u_1, (copy) v_u_49
				v_u_1.Shuffle(v_u_49)
			end).never.to.throw()
		end)
	end)
	describe("Sample", function()
		-- upvalues: (copy) v_u_1
		it("should sample a table", function()
			-- upvalues: (ref) v_u_1
			local v50 = v_u_1.Sample({
				1,
				2,
				3,
				4,
				5
			}, 3)
			expect(#v50).to.equal(3)
		end)
	end)
	describe("Flat", function()
		-- upvalues: (copy) v_u_1
		it("should flatten table", function()
			-- upvalues: (ref) v_u_1
			local v51 = v_u_1.Flat({
				1,
				2,
				3,
				{
					4,
					5,
					{ 6, 7 }
				}
			}, 3)
			expect(table.concat(v51)).to.equal("1234567")
		end)
	end)
	describe("FlatMap", function()
		-- upvalues: (copy) v_u_1
		it("should map and flatten table", function()
			-- upvalues: (ref) v_u_1
			local v53 = v_u_1.FlatMap({
				1,
				2,
				3,
				4,
				5,
				6,
				7
			}, function(p52)
				return { p52, p52 * 2 }
			end)
			expect(table.concat(v53)).to.equal("12243648510612714")
		end)
	end)
	describe("Keys", function()
		-- upvalues: (copy) v_u_1
		it("should give all keys of table", function()
			-- upvalues: (ref) v_u_1
			local v54 = v_u_1.Keys({
				["a"] = 1,
				["b"] = 2,
				["c"] = 3
			})
			expect(#v54).to.equal(3)
			expect(table.find(v54, "a")).to.be.ok()
			expect(table.find(v54, "b")).to.be.ok()
			expect(table.find(v54, "c")).to.be.ok()
		end)
	end)
	describe("Values", function()
		-- upvalues: (copy) v_u_1
		it("should give all values of table", function()
			-- upvalues: (ref) v_u_1
			local v55 = v_u_1.Values({
				["a"] = 1,
				["b"] = 2,
				["c"] = 3
			})
			expect(#v55).to.equal(3)
			expect(table.find(v55, 1)).to.be.ok()
			expect(table.find(v55, 2)).to.be.ok()
			expect(table.find(v55, 3)).to.be.ok()
		end)
	end)
	describe("Find", function()
		-- upvalues: (copy) v_u_1
		it("should find item in array", function()
			-- upvalues: (ref) v_u_1
			local v57, v58 = v_u_1.Find({ 10, 20, 30 }, function(p56)
				return p56 == 20
			end)
			expect(v57).to.be.ok()
			expect(v58).to.equal(2)
			expect(v57).to.equal(20)
		end)
		it("should find item in dictionary", function()
			-- upvalues: (ref) v_u_1
			local v60, v61 = v_u_1.Find({
				{
					["Score"] = 10
				},
				{
					["Score"] = 20
				},
				{
					["Score"] = 30
				}
			}, function(p59)
				return p59.Score == 20
			end)
			expect(v60).to.be.ok()
			expect(v61).to.equal(2)
			expect(v60.Score).to.equal(20)
		end)
	end)
	describe("Every", function()
		-- upvalues: (copy) v_u_1
		it("should see every value is above 20", function()
			-- upvalues: (ref) v_u_1
			local v63 = v_u_1.Every({ 21, 40, 200 }, function(p62)
				return p62 > 20
			end)
			expect(v63).to.equal(true)
		end)
		it("should see every value is not above 20", function()
			-- upvalues: (ref) v_u_1
			local v65 = v_u_1.Every({ 20, 40, 200 }, function(p64)
				return p64 > 20
			end)
			expect(v65).never.to.equal(true)
		end)
	end)
	describe("Some", function()
		-- upvalues: (copy) v_u_1
		it("should see some value is above 20", function()
			-- upvalues: (ref) v_u_1
			local v67 = v_u_1.Some({ 5, 40, 1 }, function(p66)
				return p66 > 20
			end)
			expect(v67).to.equal(true)
		end)
		it("should see some value is not above 20", function()
			-- upvalues: (ref) v_u_1
			local v69 = v_u_1.Some({ 5, 15, 1 }, function(p68)
				return p68 > 20
			end)
			expect(v69).never.to.equal(true)
		end)
	end)
	describe("Truncate", function()
		-- upvalues: (copy) v_u_1
		it("should truncate an array", function()
			-- upvalues: (ref) v_u_1
			local v70 = {
				1,
				2,
				3,
				4,
				5
			}
			local v71 = v_u_1.Truncate(v70, 3)
			expect(#v71).to.equal(3)
			expect(v71[1]).to.equal(v70[1])
			expect(v71[2]).to.equal(v70[2])
			expect(v71[3]).to.equal(v70[3])
		end)
		it("should truncate an array with out of bounds sizes", function()
			-- upvalues: (ref) v_u_1
			local v_u_72 = {
				1,
				2,
				3,
				4,
				5
			}
			expect(function()
				-- upvalues: (ref) v_u_1, (copy) v_u_72
				v_u_1.Truncate(v_u_72, -1)
			end).to.never.throw()
			expect(function()
				-- upvalues: (ref) v_u_1, (copy) v_u_72
				v_u_1.Truncate(v_u_72, #v_u_72 + 1)
			end).to.never.throw()
			local v73 = v_u_1.Truncate(v_u_72, #v_u_72 + 10)
			expect(#v73).to.equal(#v_u_72)
			expect(v73).to.never.equal(v_u_72)
		end)
	end)
	describe("Lock", function()
		-- upvalues: (copy) v_u_1
		it("should lock a table", function()
			-- upvalues: (ref) v_u_1
			local v_u_74 = {}
			local v75 = {
				["xyz"] = {
					["num"] = 32
				}
			}
			v_u_74.abc = v75
			expect(function()
				-- upvalues: (copy) v_u_74
				v_u_74.abc.xyz.num = 64
			end).never.to.throw()
			local v76 = v_u_1.Lock(v_u_74)
			expect(v_u_74.abc.xyz.num).to.equal(64)
			expect(v_u_74).to.equal(v76)
			expect(function()
				-- upvalues: (copy) v_u_74
				v_u_74.abc.xyz.num = 10
			end).to.throw()
		end)
	end)
	describe("Zip", function()
		-- upvalues: (copy) v_u_1
		it("should zip arrays together", function()
			-- upvalues: (ref) v_u_1
			local v77 = {
				1,
				2,
				3,
				4,
				5
			}
			local v78 = {
				9,
				8,
				7,
				6,
				5
			}
			local v79 = {
				1,
				1,
				1,
				1,
				1
			}
			local v80 = 0
			for v81, v82 in v_u_1.Zip(v77, v78, v79) do
				expect(v82[1]).to.equal(v77[v81])
				expect(v82[2]).to.equal(v78[v81])
				expect(v82[3]).to.equal(v79[v81])
				v80 = v81
			end
			local v83 = expect(v80).to.equal
			local v84 = #v77
			local v85 = #v78
			local v86 = #v79
			v83((math.min(v84, v85, v86)))
		end)
		it("should zip arrays of different lengths together", function()
			-- upvalues: (ref) v_u_1
			local v87 = {
				1,
				2,
				3,
				4,
				5
			}
			local v88 = {
				9,
				8,
				7,
				6
			}
			local v89 = { 1, 1, 1 }
			local v90 = 0
			for v91, v92 in v_u_1.Zip(v87, v88, v89) do
				expect(v92[1]).to.equal(v87[v91])
				expect(v92[2]).to.equal(v88[v91])
				expect(v92[3]).to.equal(v89[v91])
				v90 = v91
			end
			local v93 = expect(v90).to.equal
			local v94 = #v87
			local v95 = #v88
			local v96 = #v89
			v93((math.min(v94, v95, v96)))
		end)
		it("should zip maps together", function()
			-- upvalues: (ref) v_u_1
			local v97 = {
				["a"] = 10,
				["b"] = 20,
				["c"] = 30
			}
			local v98 = {
				["a"] = 100,
				["b"] = 200,
				["c"] = 300
			}
			local v99 = {
				["a"] = 3000,
				["b"] = 2000,
				["c"] = 3000
			}
			for v100, v101 in v_u_1.Zip(v97, v98, v99) do
				expect(v101[1]).to.equal(v97[v100])
				expect(v101[2]).to.equal(v98[v100])
				expect(v101[3]).to.equal(v99[v100])
			end
		end)
		it("should zip maps of different keys together", function()
			-- upvalues: (ref) v_u_1
			local v102 = {
				["a"] = 10,
				["b"] = 20,
				["c"] = 30,
				["d"] = 40
			}
			local v103 = {
				["a"] = 100,
				["b"] = 200,
				["c"] = 300,
				["z"] = 10
			}
			local v104 = {
				["a"] = 3000,
				["b"] = 2000,
				["c"] = 3000,
				["x"] = 0
			}
			for v105, v106 in v_u_1.Zip(v102, v103, v104) do
				expect(v106[1]).to.equal(v102[v105])
				expect(v106[2]).to.equal(v103[v105])
				expect(v106[3]).to.equal(v104[v105])
			end
		end)
	end)
	describe("IsEmpty", function()
		-- upvalues: (copy) v_u_1
		it("should detect that table is empty", function()
			-- upvalues: (ref) v_u_1
			local v107 = v_u_1.IsEmpty({})
			expect(v107).to.equal(true)
		end)
		it("should detect that array is not empty", function()
			-- upvalues: (ref) v_u_1
			local v108 = v_u_1.IsEmpty({ 10, 20, 30 })
			expect(v108).to.equal(false)
		end)
		it("should detect that dictionary is not empty", function()
			-- upvalues: (ref) v_u_1
			local v109 = v_u_1.IsEmpty({
				["a"] = 10,
				["b"] = 20,
				["c"] = 30
			})
			expect(v109).to.equal(false)
		end)
	end)
	describe("JSON", function()
		-- upvalues: (copy) v_u_1
		it("should encode json", function()
			-- upvalues: (ref) v_u_1
			local v110 = v_u_1.EncodeJSON({
				["hello"] = "world"
			})
			expect(v110).to.equal("{\"hello\":\"world\"}")
		end)
		it("should decode json", function()
			-- upvalues: (ref) v_u_1
			local v111 = v_u_1.DecodeJSON("{\"hello\":\"world\"}")
			expect(v111).to.be.a("table")
			expect(v111.hello).to.equal("world")
		end)
	end)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[init.spec]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3234"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["package"] = {
		["authors"] = { "Stephen Leitnick" },
		["description"] = "Table utility functions",
		["license"] = "MIT",
		["name"] = "sleitnick/table-util",
		["realm"] = "shared",
		["registry"] = "https://github.com/UpliftGames/wally-index",
		["version"] = "1.2.1"
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[wally]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3235"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[csqrl_colour-utils@1.4.1]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3236"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Util.DeprecateWarnOnce)
local v2 = require(script.GetContrastRatioCompat)
local v3 = require(script.WCAG)
local v4 = {
	["Darken"] = require(script.Darken),
	["Desaturate"] = require(script.Desaturate),
	["Emphasize"] = require(script.Emphasize),
	["GetLuminance"] = require(script.GetLuminance),
	["GetPerceivedBrightness"] = require(script.GetPerceivedBrightness),
	["Invert"] = require(script.Invert),
	["isDark"] = require(script.isDark),
	["isLight"] = require(script.isLight),
	["Lighten"] = require(script.Lighten),
	["Rotate"] = require(script.Rotate),
	["Saturate"] = require(script.Saturate),
	["APCA"] = require(script.APCA),
	["Blend"] = require(script.Blend),
	["Blind"] = require(script.Blind),
	["Hex"] = require(script.Hex),
	["HSL"] = require(script.HSL),
	["Int"] = require(script.Int),
	["LAB"] = require(script.LAB),
	["LCH"] = require(script.LCH),
	["Palette"] = require(script.Palette),
	["WCAG"] = v3
}
v4.Emphasise = v1(v4.Emphasize)("ColorUtils.Emphasise", "ColorUtils.Emphasize")
v4.GetContrastingColor = v1(v3.GetContrastingColor)("ColorUtils.GetContrastingColor", "WCAG.GetContrastingColor")
v4.GetContrastingColour = v1(v4.GetContrastingColor)("ColorUtils.GetContrastingColour", "WCAG.GetContrastingColor")
v4.GetContrastRatio = v1(v2)("ColorUtils.GetContrastRatio", "WCAG.GetContrastRatio")
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[colour-utils]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3237"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["GetContrastRatio"] = require(script.GetContrastRatio)
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[APCA]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3238"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["SRGB_TRC"] = 2.4,
	["NORM_BG_EXP"] = 0.56,
	["NORM_FG_EXP"] = 0.57,
	["REV_BG_EXP"] = 0.62,
	["REV_FG_EXP"] = 0.65,
	["SCALE_BOW"] = 1.14,
	["SCALE_WOB"] = 1.14,
	["RED_COEF"] = 0.212,
	["GREEN_COEF"] = 0.715,
	["BLUE_COEF"] = 0.072,
	["BLK_THRS"] = 0.022,
	["BLK_CLMP"] = 1.414,
	["LOW_BOW_THRS"] = 0.036,
	["LOW_WOB_THRS"] = 0.036,
	["LOW_BOW_FACT"] = 27.785,
	["LOW_WOB_FACT"] = 27.785,
	["LOW_BOW_OFFS"] = 0.027,
	["LOW_WOB_OFFS"] = 0.027,
	["LOW_CLIP"] = 0.001,
	["MIN_DELTA_Y"] = 0.0005
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Const]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3239"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Const)
local v_u_3 = v1.prepTypeOf("GetContrastRatioAPCA")
local v_u_4 = math.abs
return function(p5, p6)
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_4
	v_u_3("foreground", "Color3", p5)
	v_u_3("background", "Color3", p6)
	local v7 = p5.R ^ v_u_2.SRGB_TRC * v_u_2.RED_COEF + p5.G ^ v_u_2.SRGB_TRC * v_u_2.GREEN_COEF + p5.B ^ v_u_2.SRGB_TRC * v_u_2.BLUE_COEF
	if v_u_2.BLK_THRS >= v7 then
		v7 = v7 + v_u_4(v7 - v_u_2.BLK_THRS) ^ v_u_2.BLK_CLMP
	end
	local v8 = p6.R ^ v_u_2.SRGB_TRC * v_u_2.RED_COEF + p6.G ^ v_u_2.SRGB_TRC * v_u_2.GREEN_COEF + p6.B ^ v_u_2.SRGB_TRC * v_u_2.BLUE_COEF
	if v_u_2.BLK_THRS >= v8 then
		v8 = v8 + v_u_4(v8 - v_u_2.BLK_THRS) ^ v_u_2.BLK_CLMP
	end
	if v_u_4(v8 - v7) < v_u_2.MIN_DELTA_Y then
		return 0
	end
	local v9
	if v7 < v8 then
		local v10 = (v8 ^ v_u_2.NORM_BG_EXP - v7 ^ v_u_2.NORM_FG_EXP) * v_u_2.SCALE_BOW
		if v10 < v_u_2.LOW_CLIP then
			v9 = 0
		elseif v10 < v_u_2.LOW_BOW_THRS then
			v9 = v10 - v10 * v_u_2.LOW_BOW_FACT * v_u_2.LOW_BOW_OFFS
		else
			v9 = v10 - v_u_2.LOW_BOW_OFFS
		end
	else
		local v11 = (v8 ^ v_u_2.REV_BG_EXP - v7 ^ v_u_2.REV_FG_EXP) * v_u_2.SCALE_WOB
		if -v_u_2.LOW_CLIP < v11 then
			v9 = 0
		elseif -v_u_2.LOW_WOB_THRS < v11 then
			v9 = v11 - v11 * v_u_2.LOW_WOB_FACT * v_u_2.LOW_WOB_OFFS
		else
			v9 = v11 + v_u_2.LOW_WOB_OFFS
		end
	end
	return v9 * 100
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GetContrastRatio]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3240"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Multiply"] = require(script.Multiply),
	["Screen"] = require(script.Screen),
	["Overlay"] = require(script.Overlay),
	["Dodge"] = require(script.Dodge),
	["Burn"] = require(script.Burn),
	["Transparency"] = require(script.Transparency)
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Blend]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3241"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent._Filter)
local v_u_2 = bit32.lshift
local v_u_3 = math.clamp
local v_u_4 = math.max
return v1("Burn", function(p5, p6)
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_4
	local v7 = v_u_3(p5 * 255, 0, 255)
	local v8 = p6 * 255
	return v7 == 0 and v7 and v7 or v_u_4(0, 255 - v_u_2(255 - v8, 8) / v7)
end)]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Burn]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3242"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent._Filter)
local v_u_2 = bit32.lshift
local v_u_3 = math.clamp
local v_u_4 = math.min
return v1("Dodge", function(p5, p6)
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_4
	local v7 = v_u_3(p5 * 255, 0, 255)
	local v8 = p6 * 255
	return v7 == 255 and v7 and v7 or v_u_4(255, v_u_2(v8, 8) / (255 - v7))
end)]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Dodge]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3243"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return require(script.Parent._Filter)("Multiply", function(p1, p2)
	return p2 * 255 * (p1 * 255) / 255
end)]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Multiply]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3244"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return require(script.Parent._Filter)("Overlay", function(p1, p2)
	local v3 = p1 * 255
	local v4 = p2 * 255
	return v3 < 128 and v4 * 2 * v3 / 255 or 255 - (255 - v3) * 2 * (255 - v4) / 255
end)]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Overlay]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3245"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent._Filter)
local v_u_2 = bit32.rshift
return v1("Screen", function(p3, p4)
	-- upvalues: (copy) v_u_2
	return 255 - v_u_2((255 - p4 * 255) * (255 - p3 * 255), 8)
end)]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Screen]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3246"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2, p3)
	local v4 = 1 - p3
	local v5 = p2.R * v4 + p1.R * p3
	local v6 = p2.G * v4 + p1.G * p3
	local v7 = p2.B * v4 + p1.B * p3
	return Color3.new(v5, v6, v7)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Transparency]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3247"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Parent.Util.ClampColor)
return function(p3, p_u_4)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v_u_5 = v_u_1.prepTypeOf(p3)
	return function(p6, p7)
		-- upvalues: (copy) v_u_5, (copy) p_u_4, (ref) v_u_2
		v_u_5("background", "Color3", p6)
		v_u_5("foreground", "Color3", p7)
		return v_u_2((Color3.fromRGB(p_u_4(p6.R, p7.R), p_u_4(p6.G, p7.G), p_u_4(p6.B, p7.B))))
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[_Filter]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3248"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Enum"] = require(script.Enum),
	["Simulate"] = require(script.Simulate)
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Blind]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3249"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Blind"] = {
		["Trichromacy"] = 0,
		["Protanopia"] = 1,
		["Protanomaly"] = 2,
		["Deuteranopia"] = 3,
		["Deuteranomaly"] = 4,
		["Tritanopia"] = 5,
		["Tritanomaly"] = 6,
		["Achromatopsia"] = 7,
		["Achromatomaly"] = 8
	},
	["Group"] = {
		["Trichroma"] = 0,
		["Protan"] = 1,
		["Deutan"] = 2,
		["Tritan"] = 3,
		["Achroma"] = 4
	}
}
v1.Blind.None = v1.Blind.Trichromacy
v1.Blind.LowRed = v1.Blind.Protanomaly
v1.Blind.LowGreen = v1.Blind.Deuteranomaly
v1.Blind.LowBlue = v1.Blind.Tritanomaly
v1.Blind.LowColor = v1.Blind.Achromatomaly
v1.Blind.NoRed = v1.Blind.Protanopia
v1.Blind.NoGreen = v1.Blind.Deuteranopia
v1.Blind.NoBlue = v1.Blind.Tritanopia
v1.Blind.NoColor = v1.Blind.Achromatopsia
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Enum]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3250"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Configs)
local v_u_2 = require(script.Parent.Enum)
local function v_u_14(p3)
	-- upvalues: (copy) v_u_1
	local v4 = v_u_1.Matrix.RGB_XYZ
	local v5 = p3.R
	local v6 = p3.G
	local v7 = p3.B
	local v8
	if v5 > 0.04 then
		v8 = ((v5 + 0.055) / 1.055) ^ 2.4
	else
		v8 = v5 / 12.92
	end
	local v9
	if v6 > 0.04 then
		v9 = ((v6 + 0.055) / 1.055) ^ 2.4
	else
		v9 = v6 / 12.92
	end
	local v10
	if v7 > 0.04 then
		v10 = ((v7 + 0.055) / 1.055) ^ 2.4
	else
		v10 = v7 / 12.92
	end
	local v11 = v8 * v4[1] + v9 * v4[4] + v10 * v4[7]
	local v12 = v8 * v4[2] + v9 * v4[5] + v10 * v4[8]
	local v13 = v8 * v4[3] + v9 * v4[6] + v10 * v4[9]
	return Vector3.new(v11, v12, v13)
end
local function v_u_17(p15)
	local v16 = p15.X + p15.Y + p15.Z
	return v16 == 0 and {
		["X"] = 0,
		["y"] = 0,
		["Y"] = p15.Y
	} or {
		["X"] = p15.X / v16,
		["y"] = p15.Y / v16,
		["Y"] = p15.Y
	}
end
local function v_u_23(p18, p19, p20)
	local v21 = type(p20) ~= "number" and 1.75 or p20
	local v22 = v21 + 1
	return Color3.new((v21 * p19.R + p18.R) / v22, (v21 * p19.G + p18.G) / v22, (v21 * p19.B + p18.B) / v22)
end
return function(p24, p25)
	-- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_23, (copy) v_u_17, (copy) v_u_14
	local v26 = typeof(p24) == "Color3"
	assert(v26, "Color must be a Color3")
	local v27 = typeof(p25) == "number"
	assert(v27, "Blinder must be a number (see Enums.Blind)")
	local v28 = v_u_1.Groups[p25]
	local v29 = v_u_1.Anomalised[p25]
	if v28 == v_u_2.Group.Trichroma then
		return p24
	elseif v28 == v_u_2.Group.Achroma then
		local v30 = p24.R * 0.213 + p24.G * 0.715 + p24.B * 0.072
		local v31 = Color3.new(v30, v30, v30)
		if v29 then
			return v_u_23(p24, v31)
		else
			return v31
		end
	else
		local v32 = v_u_1.Blinder[v28]
		local v33 = v_u_17((v_u_14(p24)))
		local v34 = (v33.y - v32.Y) / (v33.X - v32.X)
		local v35 = v33.y - v33.X * v34
		local v36 = (v32.YI - v35) / (v34 - v32.M)
		local v37 = v34 * v36 + v35
		local v38 = {
			["X"] = v36 * v33.Y / v37,
			["Y"] = v33.Y,
			["Z"] = (1 - (v36 + v37)) * v33.Y / v37
		}
		local v39 = v33.Y * 0.313 / 0.329
		local v40 = v33.Y * 0.358 / 0.329 - v38.Z
		local v41 = v39 - v38.X
		local v42 = v_u_1.Matrix.XYZ_RGB
		local v43 = v41 * v42[1] + 0 * v42[4] + v40 * v42[7]
		local v44 = v41 * v42[2] + 0 * v42[5] + v40 * v42[8]
		local v45 = v41 * v42[3] + 0 * v42[6] + v40 * v42[9]
		v38.R = v38.X * v42[1] + v38.Y * v42[4] + v38.Z * v42[7]
		v38.G = v38.X * v42[2] + v38.Y * v42[5] + v38.Z * v42[8]
		v38.B = v38.X * v42[3] + v38.Y * v42[6] + v38.Z * v42[9]
		local v46 = ((v38.R < 0 and 0 or 1) - v38.R) / v43
		local v47 = ((v38.G < 0 and 0 or 1) - v38.G) / v44
		local v48 = ((v38.B < 0 and 0 or 1) - v38.B) / v45
		local v49 = (v46 > 1 or v46 < 0) and 0 or v46
		local v50 = (v47 > 1 or v47 < 0) and 0 or v47
		local v51 = (v48 > 1 or v48 < 0) and 0 or v48
		if v50 >= v49 then
			v49 = v50
		end
		if v49 >= v51 then
			v51 = v49
		end
		v38.R = v38.R + v51 * v43
		v38.G = v38.G + v51 * v44
		v38.B = v38.B + v51 * v45
		v38.R = 255 * (v38.R <= 0 and 0 or (v38.R >= 1 and 1 or v38.R ^ (1 / v_u_1.Gamma_Correct)))
		v38.G = 255 * (v38.G <= 0 and 0 or (v38.G >= 1 and 1 or v38.G ^ (1 / v_u_1.Gamma_Correct)))
		v38.B = 255 * (v38.B <= 0 and 0 or (v38.B >= 1 and 1 or v38.B ^ (1 / v_u_1.Gamma_Correct)))
		local v52 = Color3.fromRGB(v38.R or 0, v38.G or 0, v38.B or 0)
		if v29 then
			return v_u_23(p24, v52)
		else
			return v52
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Simulate]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3251"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.Enum)
local v2 = {
	[v1.Blind.Protanomaly] = true,
	[v1.Blind.Deuteranomaly] = true,
	[v1.Blind.Tritanomaly] = true,
	[v1.Blind.Achromatomaly] = true
}
local v3 = {
	[v1.Blind.Trichromacy] = v1.Group.Trichroma,
	[v1.Blind.Protanopia] = v1.Group.Protan,
	[v1.Blind.Protanomaly] = v1.Group.Protan,
	[v1.Blind.Deuteranopia] = v1.Group.Deutan,
	[v1.Blind.Deuteranomaly] = v1.Group.Deutan,
	[v1.Blind.Tritanopia] = v1.Group.Tritan,
	[v1.Blind.Tritanomaly] = v1.Group.Tritan,
	[v1.Blind.Achromatopsia] = v1.Group.Achroma,
	[v1.Blind.Achromatomaly] = v1.Group.Achroma
}
local v4 = {
	[v1.Group.Protan] = {
		["X"] = 0.747,
		["Y"] = 0.254,
		["M"] = 1.273,
		["YI"] = -0.074
	},
	[v1.Group.Deutan] = {
		["X"] = 1.4,
		["Y"] = -0.4,
		["M"] = 0.968,
		["YI"] = 0.003
	},
	[v1.Group.Tritan] = {
		["X"] = 0.175,
		["Y"] = 0,
		["M"] = 0.063,
		["YI"] = 0.292
	}
}
local v5 = {
	["Anomalised"] = v2,
	["Groups"] = v3,
	["Gamma_Correct"] = 2.2,
	["Matrix"] = {
		["XYZ_RGB"] = {
			3.241,
			-0.969,
			0.056,
			-1.537,
			1.876,
			-0.204,
			-0.499,
			0.042,
			1.057
		},
		["RGB_XYZ"] = {
			0.412,
			0.213,
			0.019,
			0.358,
			0.715,
			0.119,
			0.18,
			0.072,
			0.95
		}
	},
	["Blinder"] = v4
}
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Configs]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="ModuleScript" referent="3252"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Util.Assert).prepTypeOf("Darken")
local v_u_2 = require(script.Parent.Util.ClampColor)
return function(p3, p4)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	v_u_1("color", "Color3", p3)
	v_u_1("coefficient", "number", p4)
	return v_u_2(p3:Lerp(Color3.new(), p4))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Darken]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3253"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Saturate)
local v_u_3 = v1.prepTypeOf("Saturate")
return function(p4, p5)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	v_u_3("color", "Color3", p4)
	v_u_3("coefficient", "number", p5)
	return v_u_2(p4, -p5)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Desaturate]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3254"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Darken)
local v_u_2 = require(script.Parent.GetLuminance)
local v_u_3 = require(script.Parent.Lighten)
return function(p4, p5, p6)
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_3
	return (type(p6) == "number" and p6 and p6 or 0.5) < v_u_2(p4) and v_u_1(p4, p5) or v_u_3(p4, p5)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Emphasize]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3255"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.APCA.GetContrastRatio)
local v_u_2 = false
return function(p3, p4)
	-- upvalues: (copy) v_u_1, (ref) v_u_2
	local v5 = v_u_1(p3, p4)
	local v6 = math.abs(v5)
	if not v_u_2 then
		v_u_2 = true
		warn("ColorUtils.GetContrastRatio is providing a compatibility layer for APCA.GetContrastRatio. To continue using the old behavior, use WCAG.GetContrastRatio instead.")
	end
	return v6 / 100 * 21
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GetContrastRatioCompat]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3256"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Util.Assert).prepTypeOf("GetLuminance")
return function(p2)
	-- upvalues: (copy) v_u_1
	v_u_1("color", "Color3", p2)
	local v3 = p2.R
	local v4 = v3 <= 0.03928 and v3 / 12.92 or ((v3 + 0.055) / 1.055) ^ 2.4
	local v5 = p2.G
	local v6 = v5 <= 0.03928 and v5 / 12.92 or ((v5 + 0.055) / 1.055) ^ 2.4
	local v7 = p2.B
	local v8 = v7 <= 0.03928 and v7 / 12.92 or ((v7 + 0.055) / 1.055) ^ 2.4
	return v4 * 0.2126 + v6 * 0.7152 + v8 * 0.0722
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GetLuminance]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3257"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Util.Assert).prepTypeOf("GetPerceivedBrightness")
return function(p2)
	-- upvalues: (copy) v_u_1
	v_u_1("color", "Color3", p2)
	local v3 = p2.R * 255
	local v4 = p2.G * 255
	local v5 = p2.B * 255
	return (v3 * 299 + v4 * 587 + v5 * 114) / 1000 / 255
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GetPerceivedBrightness]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3258"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Util.Assert)
local v_u_2 = math.round
local v_u_3 = math.floor
local v_u_4 = math.clamp
local v_u_5 = math.min
local v_u_6 = math.max
local v_u_7 = math.abs
return {
	["fromHSL"] = function(p8)
		-- upvalues: (copy) v_u_1, (copy) v_u_7, (copy) v_u_3, (copy) v_u_5
		v_u_1.typeOf("FromHSL", "hsl", "table", p8)
		v_u_1.typeOf("FromHSL", "hsl.H", "number", p8.H)
		v_u_1.typeOf("FromHSL", "hsl.S", "number", p8.S)
		v_u_1.typeOf("FromHSL", "hsl.L", "number", p8.L)
		local v9 = p8.S / 100
		local v10 = p8.L / 100
		local v11 = (1 - v_u_7(v10 * 2 - 1)) * v9
		local v12 = v11 * (1 - v_u_7(p8.H / 60 % 2 - 1))
		local v13 = v10 - v11 / 2
		local v14 = 0
		local v15 = 0
		local v16 = 0
		if p8.H >= 0 and p8.H < 60 then
			v15 = v12
			v12 = 0
		elseif p8.H >= 60 and p8.H < 120 then
			v15 = v11
			v11 = v12
			v12 = 0
		elseif p8.H >= 120 and p8.H < 180 then
			v15 = v11
			v11 = 0
		elseif p8.H >= 180 and p8.H < 240 then
			v15 = v12
			v12 = v11
			v11 = 0
		elseif p8.H >= 240 and p8.H < 300 then
			local v17 = v12
			v12 = v11
			v11 = v17
			v15 = 0
		elseif p8.H >= 300 and p8.H < 360 then
			v15 = 0
		else
			v12 = v16
			v11 = v14
		end
		local v18 = v_u_5(v_u_3((v11 + v13) * 255), 255)
		local v19 = v_u_5(v_u_3((v15 + v13) * 255), 255)
		local v20 = v_u_5(v_u_3((v12 + v13) * 255), 255)
		return Color3.fromRGB(v18, v19, v20)
	end,
	["toHSL"] = function(p21)
		-- upvalues: (copy) v_u_1, (copy) v_u_5, (copy) v_u_6, (copy) v_u_7, (copy) v_u_2, (copy) v_u_4
		v_u_1.typeOf("ToHSL", "color", "Color3", p21)
		local v22 = v_u_5(p21.R, p21.G, p21.B)
		local v23 = v_u_6(p21.R, p21.G, p21.B)
		local v24 = v23 - v22
		local v25 = (v23 + v22) / 2
		local v26 = v24 == 0 and 0 or v24 / (1 - v_u_7(v25 * 2 - 1))
		local v27
		if v24 == 0 then
			v27 = 0
		elseif v23 == p21.R then
			v27 = (p21.G - p21.B) / v24 % 6
		elseif v23 == p21.G then
			v27 = (p21.B - p21.R) / v24 + 2
		else
			v27 = (p21.R - p21.G) / v24 + 4
		end
		local v28 = v_u_2(v27 * 60)
		if v28 < 0 then
			v28 = v28 + 360
		end
		return {
			["H"] = v28,
			["S"] = v_u_4(v_u_7((v_u_2(v26 * 100))), 0, 100),
			["L"] = v_u_4(v_u_7((v_u_2(v25 * 100))), 0, 100)
		}
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[HSL]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3259"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Util.ClampColor)
local v_u_3 = require(script.Parent.Blend.Transparency)
local v_u_4 = string.sub
local v_u_5 = string.gsub
local v_u_6 = string.format
local v_u_7 = string.rep
local v_u_8 = string.split
local v_u_9 = Color3.new()
local function v_u_20(p10)
	-- upvalues: (copy) v_u_1, (copy) v_u_5, (copy) v_u_8, (copy) v_u_7, (copy) v_u_6, (copy) v_u_4, (copy) v_u_2
	v_u_1.typeOf("FromHex", "hex", "string", p10)
	local v11 = v_u_5(p10, "[^A-Fa-f0-9]", "")
	if #v11 == 3 then
		local v12 = v_u_8(v11, "")
		v11 = ""
		for _, v13 in ipairs(v12) do
			v11 = v11 .. v_u_7(v13, 2)
		end
	elseif #v11 < 6 then
		v11 = v_u_6("%s%s", v11, v_u_7(v11, 6 - #v11))
	end
	local v14 = v_u_4(v11, 1, 2)
	local v15 = tonumber(v14, 16)
	local v16 = v_u_4(v11, 3, 4)
	local v17 = tonumber(v16, 16)
	local v18 = v_u_4(v11, 5, 6)
	local v19 = tonumber(v18, 16)
	return v_u_2(Color3.fromRGB(v15, v17, v19))
end
return {
	["fromHex"] = v_u_20,
	["fromHexRGBA"] = function(p21, p22)
		-- upvalues: (copy) v_u_1, (copy) v_u_5, (copy) v_u_20, (copy) v_u_4, (copy) v_u_3, (copy) v_u_9
		v_u_1.typeOf("FromHexRGBA", "hex", "string", p21)
		local v23 = v_u_5(p21, "[^A-Fa-f0-9]", "")
		if #v23 < 8 then
			return v_u_20(v23)
		end
		local v24 = v_u_4(v23, -2)
		local v25 = 1 - tonumber(v24, 16) / 255
		return v_u_3(v_u_20((v_u_4(v23, 1, -3))), p22 or v_u_9, v25)
	end,
	["toHex"] = function(p26)
		-- upvalues: (copy) v_u_1, (copy) v_u_6
		v_u_1.typeOf("ToHex", "color", "Color3", p26)
		return v_u_6("%.2x%.2x%.2x", p26.R * 255, p26.G * 255, p26.B * 255)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Hex]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3260"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Util.ClampColor)
local v_u_3 = math.floor
local v_u_4 = bit32.rshift
local v_u_5 = bit32.lshift
local v_u_6 = bit32.band
return {
	["fromInt"] = function(p7)
		-- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_4, (copy) v_u_6, (copy) v_u_2
		v_u_1.typeOf("FromInt", "int", "number", p7)
		local v8 = v_u_3(p7)
		local v9 = v_u_6(v_u_4(v8, 16), 255)
		local v10 = v_u_6(v_u_4(v8, 8), 255)
		local v11 = v_u_6(v8, 255)
		return v_u_2(Color3.fromRGB(v9, v10, v11))
	end,
	["toInt"] = function(p12)
		-- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_5
		v_u_1.typeOf("ToInt", "color", "Color3", p12)
		return v_u_5(v_u_5(v_u_3(p12.R * 255), 8) + v_u_3(p12.G * 255), 8) + v_u_3(p12.B * 255)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Int]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3261"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Util.ClampColor)
local v_u_3 = v1.prepTypeOf("Invert")
return function(p4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	v_u_3("color", "Color3", p4)
	return v_u_2((Color3.new(1 - p4.R, 1 - p4.G, 1 - p4.B)))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Invert]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3262"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Constants)
return {
	["fromLAB"] = require(script.FromLAB),
	["toLAB"] = require(script.ToLAB),
	["Lerp"] = require(script.Lerp)
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LAB]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3263"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Kn"] = 18,
	["Xn"] = 0.95047,
	["Yn"] = 1,
	["Zn"] = 1.08883,
	["t0"] = 0.137931034,
	["t1"] = 0.206896552,
	["t2"] = 0.12841855,
	["t3"] = 0.008856452
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Constants]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3264"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Parent.Util.isNaN)
local v_u_3 = require(script.Parent.Constants)
return function(p4)
	-- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_3
	v_u_1.typeOf("FromLAB", "lab", "table", p4)
	v_u_1.typeOf("FromLAB", "lab.L", "number", p4.L)
	v_u_1.typeOf("FromLAB", "lab.A", "number", p4.A)
	v_u_1.typeOf("FromLAB", "lab.B", "number", p4.B)
	local v5 = (p4.L + 16) / 116
	local v6
	if v_u_2(p4.A) then
		v6 = v5
	else
		v6 = v5 + p4.A / 500
	end
	local v7
	if v_u_2(p4.B) then
		v7 = v5
	else
		v7 = v5 - p4.B / 200
	end
	local v8 = v_u_3.Yn
	local v9
	if v_u_3.t1 < v5 then
		v9 = v5 ^ 3
	else
		v9 = v_u_3.t2 * (v5 - v_u_3.t0)
	end
	local v10 = v8 * v9
	local v11 = v_u_3.Xn
	local v12
	if v_u_3.t1 < v6 then
		v12 = v6 ^ 3
	else
		v12 = v_u_3.t2 * (v6 - v_u_3.t0)
	end
	local v13 = v11 * v12
	local v14 = v_u_3.Zn
	local v15
	if v_u_3.t1 < v7 then
		v15 = v7 ^ 3
	else
		v15 = v_u_3.t2 * (v7 - v_u_3.t0)
	end
	local v16 = v14 * v15
	local v17 = 3.2404542 * v13 - 1.5371385 * v10 - 0.4985314 * v16
	local v18
	if v17 <= 0.00304 then
		v18 = v17 * 12.92
	else
		v18 = v17 ^ 0.4166666666666667 * 1.055 - 0.055
	end
	local v19 = v18 * 255
	local v20 = -0.969266 * v13 + 1.8760108 * v10 + 0.041556 * v16
	local v21
	if v20 <= 0.00304 then
		v21 = v20 * 12.92
	else
		v21 = v20 ^ 0.4166666666666667 * 1.055 - 0.055
	end
	local v22 = v21 * 255
	local v23 = 0.0556434 * v13 - 0.2040259 * v10 + 1.0572252 * v16
	local v24
	if v23 <= 0.00304 then
		v24 = v23 * 12.92
	else
		v24 = v23 ^ 0.4166666666666667 * 1.055 - 0.055
	end
	local v25 = v24 * 255
	return Color3.fromRGB(v19, v22, v25)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[FromLAB]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3265"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.FromLAB)
local v_u_2 = require(script.Parent.ToLAB)
return function(p3, p4, p5)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v6 = typeof(p3) == "Color3"
	local v7 = ("Lerp(...): Expected \"from\" to be a Color3, got %*"):format((typeof(p3)))
	assert(v6, v7)
	local v8 = typeof(p4) == "Color3"
	local v9 = ("Lerp(...): Expected \"to\" to be a Color3, got %*"):format((typeof(p4)))
	assert(v8, v9)
	local v10 = typeof(p5) == "number"
	local v11 = ("Lerp(...): Expected \"alpha\" to be a number, got %*"):format((typeof(p5)))
	assert(v10, v11)
	local v12 = v_u_2(p3)
	local v13 = v_u_2(p4)
	return v_u_1({
		["L"] = v12.L * (1 - p5) + v13.L * p5,
		["A"] = v12.A * (1 - p5) + v13.A * p5,
		["B"] = v12.B * (1 - p5) + v13.B * p5
	})
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Lerp]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3266"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Constants)
local function v_u_16(p3)
	-- upvalues: (copy) v_u_2
	local v4 = p3.R
	local v5
	if v4 <= 0.04045 then
		v5 = v4 / 12.92
	else
		v5 = ((v4 + 0.055) / 1.055) ^ 2.4
	end
	local v6 = p3.G
	local v7
	if v6 <= 0.04045 then
		v7 = v6 / 12.92
	else
		v7 = ((v6 + 0.055) / 1.055) ^ 2.4
	end
	local v8 = p3.B
	local v9
	if v8 <= 0.04045 then
		v9 = v8 / 12.92
	else
		v9 = ((v8 + 0.055) / 1.055) ^ 2.4
	end
	local v10 = (v5 * 0.4124564 + v7 * 0.3575761 + v9 * 0.1804375) / v_u_2.Xn
	local v11
	if v_u_2.t3 < v10 then
		v11 = v10 ^ 0.3333333333333333
	else
		v11 = v10 / v_u_2.t2 + v_u_2.t0
	end
	local v12 = (v5 * 0.2126729 + v7 * 0.7151522 + v9 * 0.072175) / v_u_2.Yn
	local v13
	if v_u_2.t3 < v12 then
		v13 = v12 ^ 0.3333333333333333
	else
		v13 = v12 / v_u_2.t2 + v_u_2.t0
	end
	local v14 = (v5 * 0.0193339 + v7 * 0.119192 + v9 * 0.9503041) / v_u_2.Zn
	local v15
	if v_u_2.t3 < v14 then
		v15 = v14 ^ 0.3333333333333333
	else
		v15 = v14 / v_u_2.t2 + v_u_2.t0
	end
	return Vector3.new(v11, v13, v15)
end
return function(p17)
	-- upvalues: (copy) v_u_1, (copy) v_u_16
	v_u_1.typeOf("ToLAB", "color", "Color3", p17)
	local v18 = v_u_16(p17)
	local v19 = v18.Y * 116 - 16
	return {
		["L"] = v19 < 0 and 0 or v19,
		["A"] = (v18.X - v18.Y) * 500,
		["B"] = (v18.Y - v18.Z) * 200
	}
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ToLAB]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3267"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Constants)
return {
	["toLCH"] = require(script.ToLCH),
	["fromLCH"] = require(script.FromLCH)
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LCH]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3268"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["DEG_RAD"] = 0.017453292519943295,
	["RAD_DEG"] = 57.29577951308232,
	["NaN"] = (0 / 0)
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Constants]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3269"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Parent.Util.isNaN)
local v_u_3 = require(script.Parent.Constants)
local v_u_4 = require(script.Parent.Parent.LAB)
local v_u_5 = math.sin
local v_u_6 = math.cos
local function v_u_8(p7)
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_6, (copy) v_u_5
	if v_u_2(p7.H) then
		p7.H = 0
	end
	p7.H = p7.H * v_u_3.DEG_RAD
	return {
		["L"] = p7.L,
		["A"] = v_u_6(p7.H) * p7.C,
		["B"] = v_u_5(p7.H) * p7.C
	}
end
return function(p9)
	-- upvalues: (copy) v_u_1, (copy) v_u_8, (copy) v_u_4
	v_u_1.typeOf("FromLCH", "lch", "table", p9)
	v_u_1.typeOf("FromLCH", "lch.L", "number", p9.L)
	v_u_1.typeOf("FromLCH", "lch.C", "number", p9.C)
	v_u_1.typeOf("FromLCH", "lch.H", "number", p9.H)
	local v10 = v_u_8(p9)
	return v_u_4.fromLAB(v10)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[FromLCH]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3270"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Parent.LAB)
local v_u_3 = require(script.Parent.Constants)
local v_u_4 = math.round
local v_u_5 = math.atan2
local v_u_6 = math.sqrt
local function v_u_10(p7)
	-- upvalues: (copy) v_u_6, (copy) v_u_5, (copy) v_u_3, (copy) v_u_4
	local v8 = v_u_6(p7.A ^ 2 + p7.B ^ 2)
	local v9 = (v_u_5(p7.B, p7.A) * v_u_3.RAD_DEG + 360) % 360
	if v_u_4(v8 * 10000) == 0 then
		v9 = v_u_3.NaN
	end
	return {
		["L"] = p7.L,
		["C"] = v8,
		["H"] = v9
	}
end
return function(p11)
	-- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_10
	v_u_1.typeOf("ToLCH", "color", "Color3", p11)
	return v_u_10((v_u_2.toLAB(p11)))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ToLCH]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3271"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Util.Assert).prepTypeOf("Lighten")
local v_u_2 = require(script.Parent.Util.ClampColor)
return function(p3, p4)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	v_u_1("color", "Color3", p3)
	v_u_1("coefficient", "number", p4)
	return v_u_2(p3:Lerp(Color3.new(1, 1, 1), p4))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Lighten]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3272"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Analogous"] = require(script.Analogous),
	["Complementary"] = require(script.Complementary),
	["Monochromatic"] = require(script.Monochromatic),
	["Nearest"] = require(script.Nearest),
	["SplitComplementary"] = require(script.SplitComplementary),
	["Tailwind"] = require(script.Tailwind),
	["Tetradic"] = require(script.Tetradic),
	["Triadic"] = require(script.Triadic),
	["Vibrant"] = require(script.Vibrant)
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Palette]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3273"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Parent.Rotate)
require(script.Parent.Parent.Util.Types)
local v_u_3 = v1.prepTypeOf("Analogous")
return function(p4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	v_u_3("base", "Color3", p4)
	return { v_u_2(p4, -30), v_u_2(p4, 30) }
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Analogous]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3274"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Parent.Rotate)
require(script.Parent.Parent.Util.Types)
local v_u_3 = v1.prepTypeOf("Complementary")
return function(p4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	v_u_3("base", "Color3", p4)
	return { v_u_2(p4, 180) }
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Complementary]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3275"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.Util.Assert)
local v_u_2 = v1.prepTypeOf("Monochromatic")
local v_u_3 = v1.prepEvalArg("Monochromatic")
local v_u_4 = table.insert
local v_u_5 = math.floor
local v_u_6 = table.sort
return function(p7, p8)
	-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_3, (copy) v_u_4, (copy) v_u_6
	local v9 = p8 or 3
	v_u_2("base", "Color3", p7)
	v_u_2("swatches", "number", v9)
	local v10 = v_u_5(v9)
	v_u_3("swatches", "be greater than 0", v10 > 0, v10)
	local v11, v12, v13 = p7:ToHSV()
	local v14 = 1 / v10
	local v15 = {}
	for _ = 1, v10 do
		v_u_4(v15, Color3.fromHSV(v11, v12, v13))
		v13 = (v13 + v14) % 1
	end
	v_u_6(v15, function(p16, p17)
		return select(3, p16:ToHSV()) < select(3, p17:ToHSV())
	end)
	return v15
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Monochromatic]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3276"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	local v3 = typeof(p1) == "Color3"
	local v4 = ("Nearest(...): Expected \"to\" to be a Color3, got \"%*\" (%*)"):format(p1, (typeof(p1)))
	assert(v3, v4)
	local v5 = (1 / 0)
	local v6 = false
	local v7 = nil
	for v8, v9 in p2 do
		if typeof(v9) == "Color3" then
			local v10 = (v9.R - p1.R) ^ 2 + (v9.G - p1.G) ^ 2 + (v9.B - p1.B) ^ 2
			local v11 = math.sqrt(v10)
			if v11 < v5 then
				v7 = v9
				v5 = v11
			end
		elseif v6 == false then
			warn((("Nearest(...): Expected \"colors\" to be an array of Color3, got \"%*\" (%*) at index #%*"):format(v9, typeof(v9), v8)))
			v6 = true
		end
	end
	return v7
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Nearest]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3277"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Parent.Rotate)
require(script.Parent.Parent.Util.Types)
local v_u_3 = v1.prepTypeOf("SplitComplementary")
return function(p4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	v_u_3("base", "Color3", p4)
	return { v_u_2(p4, 150), v_u_2(p4, 210) }
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SplitComplementary]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3278"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Util.Array)
local v2 = require(script.Parent.Parent.Util.Assert)
require(script.Parent.Parent.Util.Types)
local v_u_3 = require(script.Parent.Parent.HSL)
local v_u_4 = require(script.Parent.Parent.Saturate)
local v_u_5 = v2.prepTypeOf("Tailwind")
local v_u_6 = table.find
local v_u_7 = math.abs
local v_u_8 = {
	0.32,
	0.16,
	0.08,
	0.04,
	0,
	0,
	0.04,
	0.08,
	0.16,
	0.32,
	0.84
}
local v_u_9 = {
	0.95,
	0.85,
	0.75,
	0.65,
	0.55,
	0.45,
	0.35,
	0.25,
	0.15,
	0.1,
	0.05
}
return function(p10)
	-- upvalues: (copy) v_u_5, (copy) v_u_3, (copy) v_u_1, (copy) v_u_9, (copy) v_u_7, (copy) v_u_6, (copy) v_u_8, (copy) v_u_4
	v_u_5("base", "Color3", p10)
	local v_u_11 = v_u_3.toHSL(p10)
	local v_u_12 = v_u_11.L / 100
	local v_u_15 = v_u_6(v_u_9, (v_u_1.reduce(v_u_9, function(p13, p14)
		-- upvalues: (copy) v_u_12, (ref) v_u_7
		if v_u_7(p14 - v_u_12) < v_u_7(p13 - v_u_12) then
			return p14
		else
			return p13
		end
	end)))
	local v_u_19 = v_u_1.map(v_u_1.map(v_u_9, function(p16)
		-- upvalues: (ref) v_u_3, (copy) v_u_11
		return v_u_3.fromHSL({
			["H"] = v_u_11.H,
			["S"] = v_u_11.S,
			["L"] = p16 * 100
		})
	end), function(p17, p18)
		-- upvalues: (ref) v_u_8, (copy) v_u_15, (ref) v_u_4
		return v_u_4(p17, v_u_8[p18] - v_u_8[v_u_15])
	end)
	return v_u_1.reduce(v_u_19, function(p20, p21, p22)
		-- upvalues: (copy) v_u_19
		local v23 = p22 == 1 and 50 or (p22 - 1) * 100
		if p22 == #v_u_19 then
			v23 = v23 - 50
		end
		p20[v23] = p21
		return p20
	end, {})
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Tailwind]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3279"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Parent.Rotate)
require(script.Parent.Parent.Util.Types)
local v_u_3 = v1.prepTypeOf("Tetradic")
return function(p4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	v_u_3("base", "Color3", p4)
	return { v_u_2(p4, -180), v_u_2(p4, -120), v_u_2(p4, -300) }
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Tetradic]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3280"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Parent.Rotate)
require(script.Parent.Parent.Util.Types)
local v_u_3 = v1.prepTypeOf("Triadic")
return function(p4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	v_u_3("base", "Color3", p4)
	return { v_u_2(p4, 120), v_u_2(p4, 240) }
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Triadic]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3281"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Parent.GetLuminance)
local v_u_3 = require(script.Parent.Parent.Util.Schema)
require(script.Parent.Parent.Util.Types)
local v_u_4 = v1.prepArrayOf("Vibrant")
local v_u_5 = math.abs
local v_u_6 = math.sqrt
local v_u_7 = Color3.toHSV
local v_u_8 = {
	["TargetLuminance"] = 0.49,
	["TargetSaturation"] = 1,
	["TargetValue"] = 0.8
}
return function(p9, p10)
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_8, (copy) v_u_7, (copy) v_u_2, (copy) v_u_5, (copy) v_u_6
	v_u_4("swatches", "Color3", p9)
	local v11 = v_u_3.Loose(v_u_8, p10)
	local v12 = (1 / 0)
	local v13 = nil
	for _, v14 in ipairs(p9) do
		local _, v15, v16 = v_u_7(v14)
		local v17 = v_u_2(v14)
		local v18 = v_u_5(v15 - v11.TargetSaturation)
		local v19 = v_u_5(v16 - v11.TargetValue)
		local v20 = v_u_5(v17 - v11.TargetLuminance)
		local v21 = v_u_6(v18 ^ 2 + v19 ^ 2 + v20 ^ 2)
		if v21 < v12 then
			v13 = v14
			v12 = v21
		end
	end
	return v13
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Vibrant]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3282"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Util.ClampColor)
local v_u_3 = v1.prepTypeOf("Rotate")
local v_u_4 = math.clamp
return function(p5, p6)
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_2
	v_u_3("color", "Color3", p5)
	v_u_3("angle", "number", p6)
	local v7, v8, v9 = p5:ToHSV()
	local v10 = v_u_4((v7 + p6 / 360) % 1, 0, 1)
	return v_u_2((Color3.fromHSV(v10, v8, v9)))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Rotate]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3283"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Util.Assert)
local v_u_2 = require(script.Parent.Util.ClampColor)
local v_u_3 = v1.prepTypeOf("Saturate")
local v_u_4 = math.clamp
return function(p5, p6)
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_4
	v_u_3("color", "Color3", p5)
	v_u_3("coefficient", "number", p6)
	local v7, v8, v9 = p5:ToHSV()
	local v10 = v8 + v8 * p6
	return v_u_2(Color3.fromHSV(v7, v_u_4(v10, 0, 1), v9))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Saturate]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3284"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Array"] = require(script.Array),
	["Assert"] = require(script.Assert),
	["BasicallyIdentical"] = require(script.BasicallyIdentical),
	["ClampColor"] = require(script.ClampColor),
	["isNaN"] = require(script.isNaN),
	["Schema"] = require(script.Schema),
	["Types"] = require(script.Types)
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Util]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3285"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = table.insert
return {
	["map"] = function(p2, p3)
		-- upvalues: (copy) v_u_1
		local v4 = {}
		for v5, v6 in ipairs(p2) do
			local v7 = p3(v6, v5)
			if v7 ~= nil then
				v_u_1(v4, v7)
			end
		end
		return v4
	end,
	["reduce"] = function(p8, p9, p10)
		local v11
		if p10 then
			v11 = 1
		else
			p10 = p8[1]
			v11 = 2
		end
		for v12 = v11, #p8 do
			p10 = p9(p10, p8[v12], v12)
		end
		return p10
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Array]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3286"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
local v_u_2 = string.format
v_u_1.TYPE = {
	["INVALID_TYPE"] = "%s(...): The `%s` argument must be a %s, but you passed %q (%s)",
	["INVALID_ARRAY"] = "%s(...): The `%s` argument must be an array of %s, but you passed %q (%s) at index #%d",
	["INVALID_EVAL_ARG"] = "%s(...): The `%s` argument must %s, but you passed %q (%s)"
}
function v_u_1.typeOf(p3, p4, p5, p6)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v7 = v_u_2(v_u_1.TYPE.INVALID_TYPE, p3, p4, p5, tostring(p6), (typeof(p6)))
	if typeof(p6) ~= p5 then
		error(v7, 3)
	end
	return p6
end
function v_u_1.evalArg(p8, p9, p10, p11, p12)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v13 = v_u_2(v_u_1.TYPE.INVALID_EVAL_ARG, p8, p9, p10, tostring(p12), (typeof(p12)))
	if p11 ~= true then
		error(v13, 3)
	end
	return p12
end
function v_u_1.arrayOf(p14, p15, p16, p17)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	v_u_1.typeOf("Assert.arrayOf", "array", "table", p17)
	for v18, v19 in ipairs(p17) do
		if typeof(v19) ~= p16 then
			local v20 = v_u_2(v_u_1.TYPE.INVALID_ARRAY, p14, p15, p16, tostring(v19), typeof(v19), v18)
			error(v20, 3)
		end
	end
	return nil
end
function v_u_1.prepTypeOf(p_u_21)
	-- upvalues: (copy) v_u_1
	return function(p22, p23, p24)
		-- upvalues: (ref) v_u_1, (copy) p_u_21
		return v_u_1.typeOf(p_u_21, p22, p23, p24)
	end
end
function v_u_1.prepEvalArg(p_u_25)
	-- upvalues: (copy) v_u_1
	return function(p26, p27, p28, p29)
		-- upvalues: (ref) v_u_1, (copy) p_u_25
		return v_u_1.evalArg(p_u_25, p26, p27, p28, p29)
	end
end
function v_u_1.prepArrayOf(p_u_30)
	-- upvalues: (copy) v_u_1
	return function(p31, p32, p33)
		-- upvalues: (ref) v_u_1, (copy) p_u_30
		return v_u_1.arrayOf(p_u_30, p31, p32, p33)
	end
end
return v_u_1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Assert]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3287"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = string.format
local v_u_2 = math.abs
return function(p3, p4, p5)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v6 = type(p5) ~= "number" and 0.005 or p5
	local v7 = typeof(p3) == "Color3"
	assert(v7, "\"Base\" is not a Color3")
	local v8 = typeof(p4) == "Color3"
	assert(v8, "\"Compare\" is not a Color3")
	local v9 = v_u_2(p3.R - p4.R)
	local v10 = v_u_2(p3.G - p4.G)
	local v11 = v_u_2(p3.B - p4.B)
	local v12
	if v9 <= v6 and v10 <= v6 then
		v12 = v11 <= v6
	else
		v12 = false
	end
	if not v12 then
		local v13 = {}
		if v6 < v9 then
			local v14 = v_u_1
			local v15 = v_u_2(v6 - v9)
			local v16 = tostring(v15)
			table.insert(v13, v14("R was out by %.3g", v16))
		end
		if v6 < v10 then
			local v17 = v_u_1
			local v18 = v_u_2(v6 - v10)
			local v19 = tostring(v18)
			table.insert(v13, v17("G was out by %.3g", v19))
		end
		if v6 < v11 then
			local v20 = v_u_1
			local v21 = v_u_2(v6 - v11)
			local v22 = tostring(v21)
			table.insert(v13, v20("B was out by %.3g", v22))
		end
		error(v_u_1("Expected %s (%s) to be within %s, got %s (%s) instead; %s", string.format("Color3<%.3g, %.3g, %.3g> \"#%s\"", p3.R * 255, p3.G * 255, p3.B * 255, p3:ToHex()), typeof(p3), tostring(v6), string.format("Color3<%.3g, %.3g, %.3g> \"#%s\"", p4.R * 255, p4.G * 255, p4.B * 255, p4:ToHex()), typeof(p4), table.concat(v13, ", ")), 2)
	end
	return v12
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BasicallyIdentical]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3288"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = math.clamp
return function(p2)
	-- upvalues: (copy) v_u_1
	local v3 = v_u_1(p2.R, 0, 1)
	local v4 = v_u_1(p2.G, 0, 1)
	local v5 = v_u_1(p2.B, 0, 1)
	return Color3.new(v3, v4, v5)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ClampColor]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3289"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p_u_1)
	return function(p_u_2, p_u_3, p_u_4)
		-- upvalues: (copy) p_u_1
		local v_u_5 = false
		return function(...)
			-- upvalues: (ref) v_u_5, (copy) p_u_4, (copy) p_u_2, (copy) p_u_3, (ref) p_u_1
			if not v_u_5 then
				local v6 = p_u_4 and (" and will be removed in %*"):format(p_u_4) or ""
				v_u_5 = true
				warn((("%* is deprecated%*. Please use %* instead."):format(p_u_2, v6, p_u_3)))
			end
			return p_u_1(...)
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[DeprecateWarnOnce]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3290"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Loose"] = function(p1, p2)
		if type(p2) ~= "table" then
			return p1
		end
		local v3 = {}
		for v4, v5 in pairs(p1) do
			v3[v4] = p2[v4] or v5
		end
		return v3
	end,
	["Strict"] = function(p6, p7)
		if type(p7) ~= "table" then
			return p6
		end
		local v8 = {}
		for v9, v10 in pairs(p6) do
			local v11 = p7[v9]
			if typeof(v11) == typeof(v10) then
				v8[v9] = p7[v9]
			else
				v8[v9] = v10
			end
		end
		return v8
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Schema]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3291"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return nil]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Types]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3292"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	return p1 ~= p1
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[isNaN]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3293"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["GetContrastingColor"] = require(script.GetContrastingColor),
	["GetContrastRatio"] = require(script.GetContrastRatio)
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WCAG]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3294"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Util.Assert).prepTypeOf("GetContrastRatio")
local v_u_2 = require(script.Parent.Parent.GetLuminance)
local v_u_3 = math.max
local v_u_4 = math.min
return function(p5, p6)
	-- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_3, (copy) v_u_4
	v_u_1("foreground", "Color3", p5)
	v_u_1("background", "Color3", p6)
	local v7 = v_u_2(p5)
	local v8 = v_u_2(p6)
	return (v_u_3(v7, v8) + 0.05) / (v_u_4(v7, v8) + 0.05)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GetContrastRatio]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3295"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Util.Assert).prepTypeOf("GetContrastingColor")
local v_u_2 = require(script.Parent.Parent.Darken)
local v_u_3 = require(script.Parent.GetContrastRatio)
local v_u_4 = require(script.Parent.Parent.Lighten)
local v_u_5 = require(script.Parent.Parent.isDark)
return function(p6, p7, p8)
	-- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_5, (copy) v_u_4, (copy) v_u_2
	v_u_1("foreground", "Color3", p6)
	v_u_1("background", "Color3", p7)
	local v9 = type(p8) ~= "number" and 4.5 or p8
	local v10 = v_u_3(p6, p7)
	if v9 <= v10 then
		return p6
	elseif v_u_5(p7) then
		return v_u_4(p6, (v9 - v10) / v9)
	else
		return v_u_2(p6, (v9 - v10) / v9)
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GetContrastingColor]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3296"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Util.Assert).prepTypeOf("isDark")
local v_u_2 = require(script.Parent.GetLuminance)
return function(p3)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	v_u_1("color", "Color3", p3)
	return v_u_2(p3) < 0.5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[isDark]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3297"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Util.Assert).prepTypeOf("isLight")
local v_u_2 = require(script.Parent.isDark)
return function(p3)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	v_u_1("color", "Color3", p3)
	return not v_u_2(p3)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[isLight]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3298"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[virtualbutfake_topbarplus@3.0.5]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3299"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

game:GetService("LocalizationService")
local v_u_1 = game:GetService("UserInputService")
game:GetService("RunService")
game:GetService("TextService")
local v_u_2 = game:GetService("StarterGui")
local v3 = game:GetService("GuiService")
local v4 = game:GetService("Players")
local v_u_5 = script
local v6 = require(v_u_5.Reference)
local v7 = v6.getObject()
local v8
if v7 then
	v8 = v7.Value
else
	v8 = v7
end
if v8 and v8 ~= v_u_5 then
	return require(v8)
end
if not v7 then
	v6.addToReplicatedStorage()
end
local v_u_9 = require(v_u_5.Packages.GoodSignal)
local v_u_10 = require(v_u_5.Packages.Janitor)
local v_u_11 = require(v_u_5.Utility)
local v_u_12 = require(v_u_5.Features.Themes)
local v13 = require(v_u_5.Features.Gamepad)
local v14 = require(v_u_5.Features.Overflow)
local v_u_15 = {}
v_u_15.__index = v_u_15
local v16 = v4.LocalPlayer
local v17 = v_u_5.Features.Themes
local v18 = v16:WaitForChild("PlayerGui")
local v_u_19 = {}
local v_u_20 = v_u_9.new()
local v_u_21 = v_u_5.Elements
local v_u_22 = 0
if v3.TopbarInset.Height == 0 then
	v3:GetPropertyChangedSignal("TopbarInset"):Wait()
end
v_u_15.baseDisplayOrderChanged = v_u_9.new()
v_u_15.baseDisplayOrder = 10
v_u_15.baseTheme = require(v17.Default)
v_u_15.isOldTopbar = v3.TopbarInset.Height == 36
v_u_15.iconsDictionary = v_u_19
v_u_15.container = require(v_u_21.Container)(v_u_15)
v_u_15.topbarEnabled = true
v_u_15.iconAdded = v_u_9.new()
v_u_15.iconRemoved = v_u_9.new()
v_u_15.iconChanged = v_u_9.new()
function v_u_15.getIcons()
	-- upvalues: (copy) v_u_15
	return v_u_15.iconsDictionary
end
function v_u_15.getIconByUID(p23)
	-- upvalues: (copy) v_u_15
	local v24 = v_u_15.iconsDictionary[p23]
	if v24 then
		return v24
	end
end
function v_u_15.getIcon(p25)
	-- upvalues: (copy) v_u_15, (copy) v_u_19
	local v26 = v_u_15.getIconByUID(p25)
	if v26 then
		return v26
	end
	for _, v27 in pairs(v_u_19) do
		if v27.name == p25 then
			return v27
		end
	end
end
function v_u_15.setTopbarEnabled(p28, p29)
	-- upvalues: (copy) v_u_15
	if typeof(p28) ~= "boolean" then
		p28 = v_u_15.topbarEnabled
	end
	if not p29 then
		v_u_15.topbarEnabled = p28
	end
	for _, v30 in pairs(v_u_15.container) do
		v30.Enabled = p28
	end
end
function v_u_15.modifyBaseTheme(p31)
	-- upvalues: (copy) v_u_12, (copy) v_u_15, (copy) v_u_19
	local v32 = v_u_12.getModifications(p31)
	for _, v33 in pairs(v32) do
		for _, v34 in pairs(v_u_15.baseTheme) do
			v_u_12.merge(v34, v33)
		end
	end
	for _, v35 in pairs(v_u_19) do
		v35:setTheme(v_u_15.baseTheme)
	end
end
function v_u_15.setDisplayOrder(p36)
	-- upvalues: (copy) v_u_15
	v_u_15.baseDisplayOrder = p36
	v_u_15.baseDisplayOrderChanged:Fire(p36)
end
task.defer(v13.start, v_u_15)
task.defer(v14.start, v_u_15)
for _, v37 in pairs(v_u_15.container) do
	v37.Parent = v18
end
if v_u_15.isOldTopbar then
	v_u_15.modifyBaseTheme(require(v17.Classic))
end
function v_u_15.new()
	-- upvalues: (copy) v_u_15, (copy) v_u_10, (copy) v_u_11, (copy) v_u_19, (copy) v_u_9, (copy) v_u_5, (copy) v_u_21, (ref) v_u_22, (copy) v_u_1, (copy) v_u_20, (copy) v_u_2
	local v_u_38 = {}
	local v39 = v_u_15
	setmetatable(v_u_38, v39)
	local v40 = v_u_10.new()
	v_u_38.janitor = v40
	v_u_38.themesJanitor = v40:add(v_u_10.new())
	v_u_38.singleClickJanitor = v40:add(v_u_10.new())
	v_u_38.captionJanitor = v40:add(v_u_10.new())
	v_u_38.joinJanitor = v40:add(v_u_10.new())
	v_u_38.menuJanitor = v40:add(v_u_10.new())
	v_u_38.dropdownJanitor = v40:add(v_u_10.new())
	local v_u_41 = v_u_11.generateUID()
	v_u_19[v_u_41] = v_u_38
	v40:add(function()
		-- upvalues: (ref) v_u_19, (copy) v_u_41
		v_u_19[v_u_41] = nil
	end)
	v_u_38.selected = v40:add(v_u_9.new())
	v_u_38.deselected = v40:add(v_u_9.new())
	v_u_38.toggled = v40:add(v_u_9.new())
	v_u_38.viewingStarted = v40:add(v_u_9.new())
	v_u_38.viewingEnded = v40:add(v_u_9.new())
	v_u_38.stateChanged = v40:add(v_u_9.new())
	v_u_38.notified = v40:add(v_u_9.new())
	v_u_38.noticeStarted = v40:add(v_u_9.new())
	v_u_38.noticeChanged = v40:add(v_u_9.new())
	v_u_38.endNotices = v40:add(v_u_9.new())
	v_u_38.toggleKeyAdded = v40:add(v_u_9.new())
	v_u_38.fakeToggleKeyChanged = v40:add(v_u_9.new())
	v_u_38.alignmentChanged = v40:add(v_u_9.new())
	v_u_38.updateSize = v40:add(v_u_9.new())
	v_u_38.resizingComplete = v40:add(v_u_9.new())
	v_u_38.joinedParent = v40:add(v_u_9.new())
	v_u_38.menuSet = v40:add(v_u_9.new())
	v_u_38.dropdownSet = v40:add(v_u_9.new())
	v_u_38.updateMenu = v40:add(v_u_9.new())
	v_u_38.startMenuUpdate = v40:add(v_u_9.new())
	v_u_38.childThemeModified = v40:add(v_u_9.new())
	v_u_38.indicatorSet = v40:add(v_u_9.new())
	v_u_38.dropdownChildAdded = v40:add(v_u_9.new())
	v_u_38.menuChildAdded = v40:add(v_u_9.new())
	v_u_38.iconModule = v_u_5
	v_u_38.UID = v_u_41
	v_u_38.isEnabled = true
	v_u_38.isSelected = false
	v_u_38.isViewing = false
	v_u_38.joinedFrame = false
	v_u_38.parentIconUID = false
	v_u_38.deselectWhenOtherIconSelected = true
	v_u_38.totalNotices = 0
	v_u_38.activeState = "Deselected"
	v_u_38.alignment = ""
	v_u_38.originalAlignment = ""
	v_u_38.appliedTheme = {}
	v_u_38.appearance = {}
	v_u_38.cachedInstances = {}
	v_u_38.cachedNamesToInstances = {}
	v_u_38.cachedCollectives = {}
	v_u_38.bindedToggleKeys = {}
	v_u_38.customBehaviours = {}
	v_u_38.toggleItems = {}
	v_u_38.bindedEvents = {}
	v_u_38.notices = {}
	v_u_38.menuIcons = {}
	v_u_38.dropdownIcons = {}
	v_u_38.childIconsDict = {}
	v_u_38.isOldTopbar = v_u_15.isOldTopbar
	v_u_38.creationTime = os.clock()
	v_u_38.widget = v40:add(require(v_u_21.Widget)(v_u_38, v_u_15))
	v_u_38:setAlignment()
	v_u_22 = v_u_22 + 1
	v_u_38:setOrder(v_u_22)
	v_u_38:setTheme(v_u_15.baseTheme)
	local v42 = v_u_38:getInstance("ClickRegion")
	local v_u_43 = false
	local v_u_44 = false
	v42.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_43, (ref) v_u_44, (copy) v_u_38
		if v_u_43 then
			return
		else
			v_u_44 = true
			task.delay(0.01, function()
				-- upvalues: (ref) v_u_44
				v_u_44 = false
			end)
			if v_u_38.locked then
				return
			elseif v_u_38.isSelected then
				v_u_38:deselect("User", v_u_38)
			else
				v_u_38:select("User", v_u_38)
			end
		end
	end)
	v42.TouchTap:Connect(function()
		-- upvalues: (ref) v_u_44, (ref) v_u_43, (copy) v_u_38
		if v_u_44 then
			return
		else
			v_u_43 = true
			task.delay(0.01, function()
				-- upvalues: (ref) v_u_43
				v_u_43 = false
			end)
			if v_u_38.locked then
				return
			elseif v_u_38.isSelected then
				v_u_38:deselect("User", v_u_38)
			else
				v_u_38:select("User", v_u_38)
			end
		end
	end)
	v40:add(v_u_1.InputBegan:Connect(function(p45, p46)
		-- upvalues: (copy) v_u_38
		if not v_u_38.locked then
			if v_u_38.bindedToggleKeys[p45.KeyCode] and not p46 then
				if v_u_38.locked then
					return
				end
				if v_u_38.isSelected then
					v_u_38:deselect("User", v_u_38)
					return
				end
				v_u_38:select("User", v_u_38)
			end
		end
	end))
	local function v47()
		-- upvalues: (copy) v_u_38
		if not v_u_38.locked then
			v_u_38.isViewing = false
			v_u_38.viewingEnded:Fire(true)
			v_u_38:setState(nil, "User", v_u_38)
		end
	end
	v_u_38.joinedParent:Connect(function()
		-- upvalues: (copy) v_u_38
		if v_u_38.isViewing then
			if v_u_38.locked then
				return
			end
			v_u_38.isViewing = false
			v_u_38.viewingEnded:Fire(true)
			v_u_38:setState(nil, "User", v_u_38)
		end
	end)
	v42.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_1, (copy) v_u_38
		local v48 = not v_u_1.KeyboardEnabled
		if not v_u_38.locked then
			v_u_38.isViewing = true
			v_u_38.viewingStarted:Fire(true)
			if not v48 then
				v_u_38:setState("Viewing", "User", v_u_38)
			end
		end
	end)
	local v_u_49 = 0
	v40:add(v_u_1.TouchEnded:Connect(v47))
	v42.MouseLeave:Connect(v47)
	v42.SelectionGained:Connect(function(p50)
		-- upvalues: (copy) v_u_38
		if not v_u_38.locked then
			v_u_38.isViewing = true
			v_u_38.viewingStarted:Fire(true)
			if not p50 then
				v_u_38:setState("Viewing", "User", v_u_38)
			end
		end
	end)
	v42.SelectionLost:Connect(v47)
	v42.MouseButton1Down:Connect(function()
		-- upvalues: (copy) v_u_38, (ref) v_u_1, (ref) v_u_49
		if not v_u_38.locked and v_u_1.TouchEnabled then
			v_u_49 = v_u_49 + 1
			local v_u_51 = v_u_49
			task.delay(0.2, function()
				-- upvalues: (copy) v_u_51, (ref) v_u_49, (ref) v_u_38
				if v_u_51 == v_u_49 then
					if v_u_38.locked then
						return
					end
					v_u_38.isViewing = true
					v_u_38.viewingStarted:Fire(true)
					v_u_38:setState("Viewing", "User", v_u_38)
				end
			end)
		end
	end)
	v42.MouseButton1Up:Connect(function()
		-- upvalues: (ref) v_u_49
		v_u_49 = v_u_49 + 1
	end)
	local v_u_52 = v_u_38:getInstance("IconOverlay")
	v_u_38.viewingStarted:Connect(function()
		-- upvalues: (copy) v_u_52, (copy) v_u_38
		v_u_52.Visible = not v_u_38.overlayDisabled
	end)
	v_u_38.viewingEnded:Connect(function()
		-- upvalues: (copy) v_u_52
		v_u_52.Visible = false
	end)
	v40:add(v_u_20:Connect(function(p53)
		-- upvalues: (copy) v_u_38
		if p53 ~= v_u_38 and (v_u_38.deselectWhenOtherIconSelected and p53.deselectWhenOtherIconSelected) then
			v_u_38:deselect("AutoDeselect", p53)
		end
	end))
	local v54 = debug.info(2, "s")
	local v55 = string.split(v54, ".")
	local v56 = game
	local v57 = nil
	for _, v58 in pairs(v55) do
		v56 = v56:FindFirstChild(v58)
		if not v56 then
			break
		end
		if v56:IsA("ScreenGui") then
			v57 = v56
		end
	end
	if v56 and (v57 and v57.ResetOnSpawn == true) then
		v_u_11.localPlayerRespawned(function()
			-- upvalues: (copy) v_u_38
			v_u_38:destroy()
		end)
	end
	v_u_38:getInstance("NoticeLabel")
	v_u_38.toggled:Connect(function(p59)
		-- upvalues: (copy) v_u_38, (ref) v_u_15
		v_u_38.noticeChanged:Fire(v_u_38.totalNotices)
		for v60, _ in pairs(v_u_38.childIconsDict) do
			local v61 = v_u_15.getIconByUID(v60)
			v61.noticeChanged:Fire(v61.totalNotices)
			if not p59 and v61.isSelected then
				for _, _ in pairs(v61.childIconsDict) do
					v61:deselect("HideParentFeature", v_u_38)
				end
			end
		end
	end)
	v_u_38.selected:Connect(function()
		-- upvalues: (copy) v_u_38, (ref) v_u_2
		if #v_u_38.dropdownIcons > 0 then
			if v_u_2:GetCore("ChatActive") and v_u_38.alignment ~= "Right" then
				v_u_38.chatWasPreviouslyActive = true
				v_u_2:SetCore("ChatActive", false)
			end
			if v_u_2:GetCoreGuiEnabled("PlayerList") and v_u_38.alignment ~= "Left" then
				v_u_38.playerlistWasPreviouslyActive = true
				v_u_2:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
			end
		end
	end)
	v_u_38.deselected:Connect(function()
		-- upvalues: (copy) v_u_38, (ref) v_u_2
		if v_u_38.chatWasPreviouslyActive then
			v_u_38.chatWasPreviouslyActive = nil
			v_u_2:SetCore("ChatActive", true)
		end
		if v_u_38.playerlistWasPreviouslyActive then
			v_u_38.playerlistWasPreviouslyActive = nil
			v_u_2:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
		end
	end)
	task.delay(0.1, function()
		-- upvalues: (copy) v_u_38
		if v_u_38.activeState == "Deselected" then
			v_u_38.stateChanged:Fire("Deselected")
			v_u_38:refresh()
		end
	end)
	v_u_15.iconAdded:Fire(v_u_38)
	return v_u_38
end
function v_u_15.setName(p62, p63)
	p62.widget.Name = p63
	p62.name = p63
	return p62
end
function v_u_15.setState(p64, p65, p66, p67)
	-- upvalues: (copy) v_u_11, (copy) v_u_20
	local v68 = p65 or (p64.isSelected and "Selected" or "Deselected")
	local v69 = v_u_11.formatStateName(v68)
	if p64.activeState ~= v69 then
		local v70 = p64.isSelected
		p64.activeState = v69
		if v69 == "Deselected" then
			p64.isSelected = false
			if v70 then
				p64.toggled:Fire(false, p66, p67)
				p64.deselected:Fire(p66, p67)
			end
			p64:_setToggleItemsVisible(false, p66, p67)
		elseif v69 == "Selected" then
			p64.isSelected = true
			if not v70 then
				p64.toggled:Fire(true, p66, p67)
				p64.selected:Fire(p66, p67)
				v_u_20:Fire(p64, p66, p67)
			end
			p64:_setToggleItemsVisible(true, p66, p67)
		end
		p64.stateChanged:Fire(v69, p66, p67)
	end
end
function v_u_15.getInstance(p_u_71, p_u_72)
	-- upvalues: (copy) v_u_12
	local v73 = p_u_71.cachedNamesToInstances[p_u_72]
	if v73 then
		return v73
	end
	local function v_u_77(p_u_74, p_u_75)
		-- upvalues: (copy) p_u_71
		if not p_u_71.cachedInstances[p_u_75] then
			local v76 = p_u_75:GetAttribute("Collective")
			if v76 then
				v76 = p_u_71.cachedCollectives[v76]
			end
			if v76 then
				table.insert(v76, p_u_75)
			end
			p_u_71.cachedNamesToInstances[p_u_74] = p_u_75
			p_u_71.cachedInstances[p_u_75] = true
			p_u_75.Destroying:Once(function()
				-- upvalues: (ref) p_u_71, (copy) p_u_74, (copy) p_u_75
				p_u_71.cachedNamesToInstances[p_u_74] = nil
				p_u_71.cachedInstances[p_u_75] = nil
			end)
		end
	end
	local v78 = p_u_71.widget
	v_u_77("Widget", v78)
	if p_u_72 == "Widget" then
		return v78
	end
	local v_u_79 = nil
	local function v_u_85(p80)
		-- upvalues: (copy) p_u_71, (ref) v_u_12, (copy) v_u_85, (copy) v_u_77, (copy) p_u_72, (ref) v_u_79
		for _, v81 in pairs(p80:GetChildren()) do
			local v82 = v81:GetAttribute("WidgetUID")
			if not v82 or v82 == p_u_71.UID then
				local v83 = v_u_12.getRealInstance(v81) or v81
				v_u_85(v83)
				if v83:IsA("GuiBase") or (v83:IsA("UIBase") or v83:IsA("ValueBase")) then
					local v84 = v83.Name
					v_u_77(v84, v83)
					if v84 == p_u_72 then
						v_u_79 = v83
					end
				end
			end
		end
	end
	v_u_85(v78)
	return v_u_79
end
function v_u_15.getCollective(p86, p87)
	local v88 = p86.cachedCollectives[p87]
	if v88 then
		return v88
	end
	local v89 = {}
	for v90, _ in pairs(p86.cachedInstances) do
		if v90:GetAttribute("Collective") == p87 then
			table.insert(v89, v90)
		end
	end
	p86.cachedCollectives[p87] = v89
	return v89
end
function v_u_15.getInstanceOrCollective(p91, p92)
	local v93 = {}
	local v94 = p91:getInstance(p92)
	if v94 then
		table.insert(v93, v94)
	end
	if #v93 == 0 then
		v93 = p91:getCollective(p92)
	end
	return v93
end
function v_u_15.getStateGroup(p95, p96)
	local v97 = p96 or p95.activeState
	local v98 = p95.appearance[v97]
	if not v98 then
		v98 = {}
		p95.appearance[v97] = v98
	end
	return v98
end
function v_u_15.refreshAppearance(p99, p100, p101)
	-- upvalues: (copy) v_u_12
	v_u_12.refresh(p99, p100, p101)
	return p99
end
function v_u_15.refresh(p102)
	p102:refreshAppearance(p102.widget)
	p102.updateSize:Fire()
	return p102
end
function v_u_15.updateParent(p103)
	-- upvalues: (copy) v_u_15
	local v104 = v_u_15.getIconByUID(p103.parentIconUID)
	if v104 then
		v104.updateSize:Fire()
	end
end
function v_u_15.setBehaviour(p105, p106, p107, p108, p109)
	local v110 = p106 .. "-" .. p107
	p105.customBehaviours[v110] = p108
	if p109 then
		local v111 = p105:getInstanceOrCollective(p106)
		for _, v112 in pairs(v111) do
			p105:refreshAppearance(v112, p107)
		end
	end
end
function v_u_15.modifyTheme(p113, p114, p115)
	-- upvalues: (copy) v_u_12
	return p113, v_u_12.modify(p113, p114, p115)
end
function v_u_15.modifyChildTheme(p116, p117, p118)
	-- upvalues: (copy) v_u_15
	p116.childModifications = p117
	p116.childModificationsUID = p118
	for v119, _ in pairs(p116.childIconsDict) do
		v_u_15.getIconByUID(v119):modifyTheme(p117, p118)
	end
	p116.childThemeModified:Fire()
	return p116
end
function v_u_15.removeModification(p120, p121)
	-- upvalues: (copy) v_u_12
	v_u_12.remove(p120, p121)
	return p120
end
function v_u_15.removeModificationWith(p122, p123, p124, p125)
	-- upvalues: (copy) v_u_12
	v_u_12.removeWith(p122, p123, p124, p125)
	return p122
end
function v_u_15.setTheme(p126, p127)
	-- upvalues: (copy) v_u_12
	v_u_12.set(p126, p127)
	return p126
end
function v_u_15.setEnabled(p128, p129)
	p128.isEnabled = p129
	p128.widget.Visible = p129
	p128:updateParent()
	return p128
end
function v_u_15.select(p130, p131, p132)
	p130:setState("Selected", p131, p132)
	return p130
end
function v_u_15.deselect(p133, p134, p135)
	p133:setState("Deselected", p134, p135)
	return p133
end
function v_u_15.notify(p136, p137, p138)
	-- upvalues: (copy) v_u_21, (copy) v_u_15
	if not p136.notice then
		p136.notice = require(v_u_21.Notice)(p136, v_u_15)
	end
	p136.noticeStarted:Fire(p137, p138)
	return p136
end
function v_u_15.clearNotices(p139)
	p139.endNotices:Fire()
	return p139
end
function v_u_15.disableOverlay(p140, p141)
	p140.overlayDisabled = p141
	return p140
end
v_u_15.disableStateOverlay = v_u_15.disableOverlay
function v_u_15.setImage(p142, p143, p144)
	p142:modifyTheme({
		"IconImage",
		"Image",
		p143,
		p144
	})
	return p142
end
function v_u_15.setLabel(p145, p146, p147)
	p145:modifyTheme({
		"IconLabel",
		"Text",
		p146,
		p147
	})
	return p145
end
function v_u_15.setOrder(p148, p149, p150)
	p148:modifyTheme({
		"Widget",
		"LayoutOrder",
		p149,
		p150
	})
	return p148
end
function v_u_15.setCornerRadius(p151, p152, p153)
	p151:modifyTheme({
		"IconCorners",
		"CornerRadius",
		p152,
		p153
	})
	return p151
end
function v_u_15.align(p154, p155, p156)
	-- upvalues: (copy) v_u_15
	local v157 = tostring(p155):lower()
	local v158 = (v157 == "mid" or v157 == "centre") and "center" or v157
	local v159 = v158 ~= "left" and (v158 ~= "center" and v158 ~= "right") and "left" or v158
	local v160 = v159 == "center" and v_u_15.container.TopbarCentered or v_u_15.container.TopbarStandard
	local v161 = v160.Holders
	local v162 = string.upper((string.sub(v159, 1, 1))) .. string.sub(v159, 2)
	if not p156 then
		p154.originalAlignment = v162
	end
	local v163 = p154.joinedFrame
	local v164 = v161[v162]
	p154.screenGui = v160
	p154.alignmentHolder = v164
	if not p154.isDestroyed then
		p154.widget.Parent = v163 or v164
	end
	p154.alignment = v162
	p154.alignmentChanged:Fire(v162)
	v_u_15.iconChanged:Fire(p154)
	return p154
end
v_u_15.setAlignment = v_u_15.align
function v_u_15.setLeft(p165)
	p165:setAlignment("Left")
	return p165
end
function v_u_15.setMid(p166)
	p166:setAlignment("Center")
	return p166
end
function v_u_15.setRight(p167)
	p167:setAlignment("Right")
	return p167
end
function v_u_15.setWidth(p168, p169, p170)
	p168:modifyTheme({
		"Widget",
		"Size",
		UDim2.fromOffset(p169, p168.widget.Size.Y.Offset),
		p170
	})
	p168:modifyTheme({
		"Widget",
		"DesiredWidth",
		p169,
		p170
	})
	return p168
end
function v_u_15.setImageScale(p171, p172, p173)
	p171:modifyTheme({
		"IconImageScale",
		"Value",
		p172,
		p173
	})
	return p171
end
function v_u_15.setImageRatio(p174, p175, p176)
	p174:modifyTheme({
		"IconImageRatio",
		"AspectRatio",
		p175,
		p176
	})
	return p174
end
function v_u_15.setTextSize(p177, p178, p179)
	p177:modifyTheme({
		"IconLabel",
		"TextSize",
		p178,
		p179
	})
	return p177
end
function v_u_15.setTextFont(p180, p181, p182, p183, p184)
	local v185 = p182 or Enum.FontWeight.Regular
	local v186 = p183 or Enum.FontStyle.Normal
	local v187 = nil
	local v188 = typeof(p181)
	if v188 == "number" then
		v187 = Font.fromId(p181, v185, v186)
	elseif v188 == "EnumItem" then
		v187 = Font.fromEnum(p181)
	elseif v188 == "string" and not p181:match("rbxasset") then
		v187 = Font.fromName(p181, v185, v186)
	end
	p180:modifyTheme({
		"IconLabel",
		"FontFace",
		v187 or Font.new(p181, v185, v186),
		p184
	})
	return p180
end
function v_u_15.bindToggleItem(p189, p190)
	if not (p190:IsA("GuiObject") or p190:IsA("LayerCollector")) then
		error("Toggle item must be a GuiObject or LayerCollector!")
	end
	p189.toggleItems[p190] = true
	p189:_updateSelectionInstances()
	return p189
end
function v_u_15.unbindToggleItem(p191, p192)
	p191.toggleItems[p192] = nil
	p191:_updateSelectionInstances()
	return p191
end
function v_u_15._updateSelectionInstances(p193)
	for v194, _ in pairs(p193.toggleItems) do
		local v195 = {}
		for _, v196 in pairs(v194:GetDescendants()) do
			if (v196:IsA("TextButton") or v196:IsA("ImageButton")) and v196.Active then
				table.insert(v195, v196)
			end
		end
		p193.toggleItems[v194] = v195
	end
end
function v_u_15._setToggleItemsVisible(p197, p198, _, p199)
	for v200, _ in pairs(p197.toggleItems) do
		if not p199 or (p199 == p197 or p199.toggleItems[v200] == nil) then
			v200[v200:IsA("LayerCollector") and "Enabled" or "Visible"] = p198
		end
	end
end
function v_u_15.bindEvent(p_u_201, p202, p_u_203)
	local v204 = p_u_201[p202]
	local v205
	if v204 then
		if typeof(v204) == "table" then
			v205 = v204.Connect
		else
			v205 = false
		end
	else
		v205 = v204
	end
	assert(v205, "argument[1] must be a valid topbarplus icon event name!")
	local v206 = typeof(p_u_203) == "function"
	assert(v206, "argument[2] must be a function!")
	p_u_201.bindedEvents[p202] = v204:Connect(function(...)
		-- upvalues: (copy) p_u_203, (copy) p_u_201
		p_u_203(p_u_201, ...)
	end)
	return p_u_201
end
function v_u_15.unbindEvent(p207, p208)
	local v209 = p207.bindedEvents[p208]
	if v209 then
		v209:Disconnect()
		p207.bindedEvents[p208] = nil
	end
	return p207
end
function v_u_15.bindToggleKey(p210, p211)
	local v212 = typeof(p211) == "EnumItem"
	assert(v212, "argument[1] must be a KeyCode EnumItem!")
	p210.bindedToggleKeys[p211] = true
	p210.toggleKeyAdded:Fire(p211)
	p210:setCaption("_hotkey_")
	return p210
end
function v_u_15.unbindToggleKey(p213, p214)
	local v215 = typeof(p214) == "EnumItem"
	assert(v215, "argument[1] must be a KeyCode EnumItem!")
	p213.bindedToggleKeys[p214] = nil
	return p213
end
function v_u_15.call(p_u_216, p_u_217, ...)
	local v_u_218 = table.pack(...)
	task.spawn(function()
		-- upvalues: (copy) p_u_217, (copy) p_u_216, (copy) v_u_218
		local v219 = v_u_218
		p_u_217(p_u_216, table.unpack(v219))
	end)
	return p_u_216
end
function v_u_15.addToJanitor(p220, p221, p222, p223)
	p220.janitor:add(p221, p222, p223)
	return p220
end
function v_u_15.lock(p224)
	p224:getInstance("ClickRegion").Visible = false
	p224.locked = true
	return p224
end
function v_u_15.unlock(p225)
	p225:getInstance("ClickRegion").Visible = true
	p225.locked = false
	return p225
end
function v_u_15.debounce(p226, p227)
	p226:lock()
	task.wait(p227)
	p226:unlock()
	return p226
end
function v_u_15.autoDeselect(p228, p229)
	p228.deselectWhenOtherIconSelected = p229 == nil and true or p229
	return p228
end
function v_u_15.oneClick(p_u_230, p231)
	local v232 = p_u_230.singleClickJanitor
	v232:clean()
	if p231 or p231 == nil then
		v232:add(p_u_230.selected:Connect(function()
			-- upvalues: (copy) p_u_230
			p_u_230:deselect("OneClick", p_u_230)
		end))
	end
	p_u_230.oneClickEnabled = true
	return p_u_230
end
function v_u_15.setCaption(p233, p234)
	-- upvalues: (copy) v_u_21
	if p234 == "_hotkey_" and p233.captionText then
		return p233
	end
	local v235 = p233.captionJanitor
	p233.captionJanitor:clean()
	if not p234 or p234 == "" then
		p233.caption = nil
		p233.captionText = nil
		return p233
	end
	local v236 = v235:add(require(v_u_21.Caption)(p233))
	v236:SetAttribute("CaptionText", p234)
	p233.caption = v236
	p233.captionText = p234
	return p233
end
function v_u_15.setCaptionHint(p237, p238)
	local v239 = typeof(p238) == "EnumItem"
	assert(v239, "argument[1] must be a KeyCode EnumItem!")
	p237.fakeToggleKey = p238
	p237.fakeToggleKeyChanged:Fire(p238)
	p237:setCaption("_hotkey_")
	return p237
end
function v_u_15.leave(p240)
	p240.joinJanitor:clean()
	return p240
end
function v_u_15.joinMenu(p241, p242)
	-- upvalues: (copy) v_u_11
	v_u_11.joinFeature(p241, p242, p242.menuIcons, p242:getInstance("Menu"))
	p242.menuChildAdded:Fire(p241)
	return p241
end
function v_u_15.setMenu(p243, p244)
	p243.menuSet:Fire(p244)
	return p243
end
function v_u_15.setFrozenMenu(p245, p246)
	p245:freezeMenu(p246)
	p245:setMenu(p246)
end
function v_u_15.freezeMenu(p_u_247)
	p_u_247:select("FrozenMenu", p_u_247)
	p_u_247:bindEvent("deselected", function(p248)
		-- upvalues: (copy) p_u_247
		p248:select("FrozenMenu", p_u_247)
	end)
	p_u_247:modifyTheme({ "IconSpot", "Visible", false })
end
function v_u_15.joinDropdown(p249, p250)
	-- upvalues: (copy) v_u_11
	p250:getDropdown()
	v_u_11.joinFeature(p249, p250, p250.dropdownIcons, p250:getInstance("DropdownScroller"))
	p250.dropdownChildAdded:Fire(p249)
	return p249
end
function v_u_15.getDropdown(p251)
	-- upvalues: (copy) v_u_21
	local v252 = p251.dropdown
	if not v252 then
		v252 = require(v_u_21.Dropdown)(p251)
		p251.dropdown = v252
		p251:clipOutside(v252)
	end
	return v252
end
function v_u_15.setDropdown(p253, p254)
	p253:getDropdown()
	p253.dropdownSet:Fire(p254)
	return p253
end
function v_u_15.clipOutside(p255, p256)
	-- upvalues: (copy) v_u_11
	local v257 = v_u_11.clipOutside(p255, p256)
	p255:refreshAppearance(p256)
	return p255, v257
end
function v_u_15.setIndicator(p258, p259)
	-- upvalues: (copy) v_u_21, (copy) v_u_15
	if not p258.indicator then
		p258.indicator = p258.janitor:add(require(v_u_21.Indicator)(p258, v_u_15))
	end
	p258.indicatorSet:Fire(p259)
end
function v_u_15.destroy(p260)
	-- upvalues: (copy) v_u_15
	if not p260.isDestroyed then
		p260:clearNotices()
		if p260.parentIconUID then
			p260:leave()
		end
		p260.isDestroyed = true
		p260.janitor:clean()
		v_u_15.iconRemoved:Fire(p260)
	end
end
v_u_15.Destroy = v_u_15.destroy
return v_u_15]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[topbarplus]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3300"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_3 = {
	["objectName"] = "TopbarPlusReference",
	["addToReplicatedStorage"] = function()
		-- upvalues: (copy) v_u_1, (copy) v_u_3
		if v_u_1:FindFirstChild(v_u_3.objectName) then
			return false
		end
		local v2 = Instance.new("ObjectValue")
		v2.Name = v_u_3.objectName
		v2.Value = script.Parent
		v2.Parent = v_u_1
		return v2
	end,
	["getObject"] = function()
		-- upvalues: (copy) v_u_1, (copy) v_u_3
		return v_u_1:FindFirstChild(v_u_3.objectName) or false
	end
}
return v_u_3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Reference]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3301"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
local v_u_2 = game:GetService("Players").LocalPlayer
function v_u_1.createStagger(p3, p_u_4, p_u_5)
	local v_u_6 = false
	local v_u_7 = false
	local v_u_8 = (not p3 or p3 == 0) and 0.01 or p3
	local function v_u_12(...)
		-- upvalues: (ref) v_u_6, (ref) v_u_7, (copy) p_u_5, (ref) v_u_8, (copy) p_u_4, (copy) v_u_12
		if v_u_6 then
			v_u_7 = true
		else
			local v_u_9 = table.pack(...)
			v_u_6 = true
			v_u_7 = false
			task.spawn(function()
				-- upvalues: (ref) p_u_5, (ref) v_u_8, (ref) p_u_4, (copy) v_u_9
				if p_u_5 then
					task.wait(v_u_8)
				end
				local v10 = v_u_9
				p_u_4(table.unpack(v10))
			end)
			task.delay(v_u_8, function()
				-- upvalues: (ref) v_u_6, (ref) v_u_7, (ref) v_u_12, (copy) v_u_9
				v_u_6 = false
				if v_u_7 then
					local v11 = v_u_9
					v_u_12(table.unpack(v11))
				end
			end)
		end
	end
	return v_u_12
end
function v_u_1.round(p13)
	local v14 = p13 + 0.5
	return math.floor(v14)
end
function v_u_1.reverseTable(p15)
	local v16 = #p15 / 2
	for v17 = 1, math.floor(v16) do
		local v18 = #p15 - v17 + 1
		local v19 = p15[v18]
		local v20 = p15[v17]
		p15[v17] = v19
		p15[v18] = v20
	end
end
function v_u_1.copyTable(p21)
	-- upvalues: (copy) v_u_1
	local v22 = type(p21) == "table"
	assert(v22, "First argument must be a table")
	local v23 = table.create(#p21)
	for v24, v25 in pairs(p21) do
		if type(v25) == "table" then
			v23[v24] = v_u_1.copyTable(v25)
		else
			v23[v24] = v25
		end
	end
	return v23
end
local v_u_26 = {
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z",
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"0",
	"<",
	">",
	"?",
	"@",
	"{",
	"}",
	"[",
	"]",
	"!",
	"(",
	")",
	"=",
	"+",
	"~",
	"#"
}
function v_u_1.generateUID(p27)
	-- upvalues: (copy) v_u_26
	local v28 = v_u_26
	local v29 = #v28
	local v30 = ""
	for _ = 1, p27 or 8 do
		v30 = v30 .. v28[math.random(1, v29)]
	end
	return v30
end
local v_u_31 = {}
function v_u_1.setVisible(p_u_32, p33, p34)
	-- upvalues: (copy) v_u_31
	local v35 = v_u_31[p_u_32]
	if not v35 then
		v35 = {}
		v_u_31[p_u_32] = v35
		p_u_32.Destroying:Once(function()
			-- upvalues: (ref) v_u_31, (copy) p_u_32
			v_u_31[p_u_32] = nil
		end)
	end
	if p33 then
		v35[p34] = nil
	else
		v35[p34] = true
	end
	if p33 then
		for _, _ in pairs(v35) do
			p33 = false
			break
		end
	end
	p_u_32.Visible = p33
end
function v_u_1.formatStateName(p36)
	return string.upper((string.sub(p36, 1, 1))) .. string.lower((string.sub(p36, 2)))
end
function v_u_1.localPlayerRespawned(p37)
	-- upvalues: (copy) v_u_2
	v_u_2.CharacterRemoving:Connect(p37)
end
function v_u_1.getClippedContainer(p38)
	local v39 = p38:FindFirstChild("ClippedContainer")
	if not v39 then
		v39 = Instance.new("Folder")
		v39.Name = "ClippedContainer"
		v39.Parent = p38
	end
	return v39
end
local v_u_40 = require(script.Parent.Packages.Janitor)
local v_u_41 = game:GetService("GuiService")
function v_u_1.clipOutside(p_u_42, p_u_43)
	-- upvalues: (copy) v_u_40, (copy) v_u_1, (copy) v_u_41
	local v_u_44 = p_u_42.janitor:add(v_u_40.new())
	p_u_43.Destroying:Once(function()
		-- upvalues: (copy) v_u_44
		v_u_44:Destroy()
	end)
	p_u_42.janitor:add(p_u_43)
	local v_u_45 = p_u_43.Parent
	local v_u_46 = v_u_44:add(Instance.new("Frame"))
	v_u_46:SetAttribute("IsAClippedClone", true)
	v_u_46.Name = p_u_43.Name
	v_u_46.AnchorPoint = p_u_43.AnchorPoint
	v_u_46.Size = p_u_43.Size
	v_u_46.Position = p_u_43.Position
	v_u_46.BackgroundTransparency = 1
	v_u_46.LayoutOrder = p_u_43.LayoutOrder
	v_u_46.Parent = v_u_45
	local v47 = Instance.new("ObjectValue")
	v47.Name = "OriginalInstance"
	v47.Value = p_u_43
	v47.Parent = v_u_46
	local v48 = v47:Clone()
	p_u_43:SetAttribute("HasAClippedClone", true)
	v48.Name = "ClippedClone"
	v48.Value = v_u_46
	v48.Parent = p_u_43
	local v_u_49 = nil
	local function v51()
		-- upvalues: (copy) v_u_45, (ref) v_u_49, (copy) p_u_43, (ref) v_u_1
		local v50 = v_u_45:FindFirstAncestorWhichIsA("ScreenGui")
		if not string.match(v50.Name, "Clipped") then
			v50 = v50.Parent[v50.Name .. "Clipped"]
		end
		v_u_49 = v50
		p_u_43.AnchorPoint = Vector2.new(0, 0)
		p_u_43.Parent = v_u_1.getClippedContainer(v_u_49)
	end
	v_u_44:add(p_u_42.alignmentChanged:Connect(v51))
	v51()
	local v_u_52 = v_u_49
	for _, v53 in pairs(p_u_43:GetChildren()) do
		if v53:IsA("UIAspectRatioConstraint") then
			v53:Clone().Parent = v_u_46
		end
	end
	local v_u_54 = p_u_42.widget
	local v_u_55 = false
	local v_u_56 = p_u_43:GetAttribute("IgnoreVisibilityUpdater")
	local function v58()
		-- upvalues: (copy) v_u_56, (copy) v_u_54, (ref) v_u_55, (ref) v_u_1, (copy) p_u_43
		if not v_u_56 then
			local v57 = v_u_54.Visible
			if v_u_55 then
				v57 = false
			end
			v_u_1.setVisible(p_u_43, v57, "ClipHandler")
		end
	end
	v_u_44:add(v_u_54:GetPropertyChangedSignal("Visible"):Connect(v58))
	local v_u_59 = nil
	local v_u_60 = require(p_u_42.iconModule)
	local function v_u_74()
		-- upvalues: (copy) p_u_42, (copy) p_u_43, (copy) v_u_60, (ref) v_u_55, (copy) v_u_56, (copy) v_u_54, (ref) v_u_1, (ref) v_u_59, (copy) v_u_74, (copy) v_u_44
		task.defer(function()
			-- upvalues: (ref) p_u_42, (ref) p_u_43, (ref) v_u_60, (ref) v_u_55, (ref) v_u_56, (ref) v_u_54, (ref) v_u_1, (ref) v_u_59, (ref) v_u_74, (ref) v_u_44
			local v61 = nil
			local v62 = p_u_42.UID
			local v63
			if p_u_43:GetAttribute("ClipToJoinedParent") then
				v63 = v62
				for _ = 1, 10 do
					local v64 = v_u_60.getIconByUID(v62)
					if not v64 then
						break
					end
					local v65 = v64.joinedFrame
					v62 = v64.parentIconUID
					if not v65 then
						break
					end
					v61 = v65
				end
			else
				v63 = v62
			end
			if v61 then
				local v66 = p_u_43.AbsolutePosition
				local v67 = p_u_43.AbsoluteSize / 2
				local v68 = v61.AbsolutePosition
				local v69 = v61.AbsoluteSize
				local v70 = v66 + v67
				local v71 = v70.X < v68.X or (v70.X > v68.X + v69.X or (v70.Y < v68.Y or v70.Y > v68.Y + v69.Y))
				if v71 ~= v_u_55 then
					v_u_55 = v71
					if not v_u_56 then
						local v72 = v_u_54.Visible
						if v_u_55 then
							v72 = false
						end
						v_u_1.setVisible(p_u_43, v72, "ClipHandler")
					end
				end
				if v61:IsA("ScrollingFrame") and v_u_59 ~= v61 then
					v_u_59 = v61
					v_u_44:add(v61:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function()
						-- upvalues: (ref) v_u_74
						v_u_74()
					end), "Disconnect", "TrackUtilityScroller-" .. v63)
				end
				return
			else
				v_u_55 = false
				if not v_u_56 then
					local v73 = v_u_54.Visible
					if v_u_55 then
						v73 = false
					end
					v_u_1.setVisible(p_u_43, v73, "ClipHandler")
				end
			end
		end)
	end
	local v_u_75 = workspace.CurrentCamera
	local v_u_76 = p_u_43:GetAttribute("AdditionalOffsetX") or 0
	local function v105(p_u_77)
		-- upvalues: (copy) v_u_46, (copy) v_u_75, (copy) p_u_43, (ref) v_u_41, (ref) v_u_52, (copy) p_u_42, (copy) v_u_76, (copy) v_u_60, (ref) v_u_55, (copy) v_u_56, (copy) v_u_54, (ref) v_u_1, (ref) v_u_59, (copy) v_u_74, (copy) v_u_44
		local v_u_78 = "Absolute" .. p_u_77
		local function v102()
			-- upvalues: (ref) v_u_46, (copy) v_u_78, (copy) p_u_77, (ref) v_u_75, (ref) p_u_43, (ref) v_u_41, (ref) v_u_52, (ref) p_u_42, (ref) v_u_76, (ref) v_u_60, (ref) v_u_55, (ref) v_u_56, (ref) v_u_54, (ref) v_u_1, (ref) v_u_59, (ref) v_u_74, (ref) v_u_44
			local v79 = v_u_46[v_u_78]
			local v80 = UDim2.fromOffset(v79.X, v79.Y)
			if p_u_77 == "Position" then
				local v81 = v_u_75.ViewportSize.X - p_u_43.AbsoluteSize.X - 4
				local v82 = v80.X.Offset
				if v82 < 4 then
					v81 = 4
				elseif v81 >= v82 then
					v81 = v82
				end
				local v83 = UDim2.fromOffset(v81, v80.Y.Offset)
				local v84 = v_u_41.TopbarInset
				local v85 = workspace.CurrentCamera.ViewportSize.X
				local v86 = v_u_52.AbsoluteSize.X
				local v87 = v_u_52.AbsolutePosition.X
				local _ = v87 - v84.Min.X
				if not p_u_42.isOldTopbar then
					v87 = v85 - v86 - 0
				end
				local v88 = v87 - v_u_76
				v80 = v83 + UDim2.fromOffset(-v88, v84.Height)
				task.defer(function()
					-- upvalues: (ref) p_u_42, (ref) p_u_43, (ref) v_u_60, (ref) v_u_55, (ref) v_u_56, (ref) v_u_54, (ref) v_u_1, (ref) v_u_59, (ref) v_u_74, (ref) v_u_44
					local v89 = nil
					local v90 = p_u_42.UID
					local v91
					if p_u_43:GetAttribute("ClipToJoinedParent") then
						v91 = v90
						for _ = 1, 10 do
							local v92 = v_u_60.getIconByUID(v90)
							if not v92 then
								break
							end
							local v93 = v92.joinedFrame
							v90 = v92.parentIconUID
							if not v93 then
								break
							end
							v89 = v93
						end
					else
						v91 = v90
					end
					if v89 then
						local v94 = p_u_43.AbsolutePosition
						local v95 = p_u_43.AbsoluteSize / 2
						local v96 = v89.AbsolutePosition
						local v97 = v89.AbsoluteSize
						local v98 = v94 + v95
						local v99 = v98.X < v96.X or (v98.X > v96.X + v97.X or (v98.Y < v96.Y or v98.Y > v96.Y + v97.Y))
						if v99 ~= v_u_55 then
							v_u_55 = v99
							if not v_u_56 then
								local v100 = v_u_54.Visible
								if v_u_55 then
									v100 = false
								end
								v_u_1.setVisible(p_u_43, v100, "ClipHandler")
							end
						end
						if v89:IsA("ScrollingFrame") and v_u_59 ~= v89 then
							v_u_59 = v89
							v_u_44:add(v89:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function()
								-- upvalues: (ref) v_u_74
								v_u_74()
							end), "Disconnect", "TrackUtilityScroller-" .. v91)
						end
						return
					else
						v_u_55 = false
						if not v_u_56 then
							local v101 = v_u_54.Visible
							if v_u_55 then
								v101 = false
							end
							v_u_1.setVisible(p_u_43, v101, "ClipHandler")
						end
					end
				end)
			end
			p_u_43[p_u_77] = v80
		end
		local v103 = v_u_1.createStagger(0.01, v102)
		v_u_44:add(v_u_46:GetPropertyChangedSignal(v_u_78):Connect(v103))
		local v104 = v_u_1.createStagger(0.5, v102, true)
		v_u_44:add(v_u_46:GetPropertyChangedSignal(v_u_78):Connect(v104))
	end
	task.delay(0.1, v_u_74)
	task.defer(function()
		-- upvalues: (copy) p_u_42, (copy) p_u_43, (copy) v_u_60, (ref) v_u_55, (copy) v_u_56, (copy) v_u_54, (ref) v_u_1, (ref) v_u_59, (copy) v_u_74, (copy) v_u_44
		local v106 = nil
		local v107 = p_u_42.UID
		local v108
		if p_u_43:GetAttribute("ClipToJoinedParent") then
			v108 = v107
			for _ = 1, 10 do
				local v109 = v_u_60.getIconByUID(v107)
				if not v109 then
					break
				end
				local v110 = v109.joinedFrame
				v107 = v109.parentIconUID
				if not v110 then
					break
				end
				v106 = v110
			end
		else
			v108 = v107
		end
		if v106 then
			local v111 = p_u_43.AbsolutePosition
			local v112 = p_u_43.AbsoluteSize / 2
			local v113 = v106.AbsolutePosition
			local v114 = v106.AbsoluteSize
			local v115 = v111 + v112
			local v116 = v115.X < v113.X or (v115.X > v113.X + v114.X or (v115.Y < v113.Y or v115.Y > v113.Y + v114.Y))
			if v116 ~= v_u_55 then
				v_u_55 = v116
				if not v_u_56 then
					local v117 = v_u_54.Visible
					if v_u_55 then
						v117 = false
					end
					v_u_1.setVisible(p_u_43, v117, "ClipHandler")
				end
			end
			if v106:IsA("ScrollingFrame") and v_u_59 ~= v106 then
				v_u_59 = v106
				v_u_44:add(v106:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function()
					-- upvalues: (ref) v_u_74
					v_u_74()
				end), "Disconnect", "TrackUtilityScroller-" .. v108)
			end
			return
		else
			v_u_55 = false
			if not v_u_56 then
				local v118 = v_u_54.Visible
				if v_u_55 then
					v118 = false
				end
				v_u_1.setVisible(p_u_43, v118, "ClipHandler")
			end
		end
	end)
	if not v_u_56 then
		local v119 = v_u_54.Visible
		if v_u_55 then
			v119 = false
		end
		v_u_1.setVisible(p_u_43, v119, "ClipHandler")
	end
	v105("Position")
	v_u_44:add(p_u_43:GetPropertyChangedSignal("Visible"):Connect(function() end))
	if p_u_43:GetAttribute("TrackCloneSize") then
		v105("Size")
	else
		v_u_44:add(p_u_43:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			-- upvalues: (copy) p_u_43, (copy) v_u_46
			local v120 = p_u_43.AbsoluteSize
			v_u_46.Size = UDim2.fromOffset(v120.X, v120.Y)
		end))
	end
	return v_u_46
end
function v_u_1.joinFeature(p_u_121, p_u_122, p_u_123, p124)
	local v125 = p_u_121.joinJanitor
	v125:clean()
	if p124 then
		p_u_121.parentIconUID = p_u_122.UID
		p_u_121.joinedFrame = p124
		v125:add(p_u_122.alignmentChanged:Connect(function()
			-- upvalues: (copy) p_u_122, (copy) p_u_121
			local v126 = p_u_122.alignment
			p_u_121:setAlignment(v126 == "Center" and "Left" or v126, true)
		end))
		local v127 = p_u_122.alignment
		p_u_121:setAlignment(v127 == "Center" and "Left" or v127, true)
		p_u_121:modifyTheme({ "IconButton", "BackgroundTransparency", 1 }, "JoinModification")
		p_u_121:modifyTheme({ "ClickRegion", "Active", false }, "JoinModification")
		if p_u_122.childModifications then
			task.defer(function()
				-- upvalues: (copy) p_u_121, (copy) p_u_122
				p_u_121:modifyTheme(p_u_122.childModifications, p_u_122.childModificationsUID)
			end)
		end
		local v_u_128 = p_u_121:getInstance("ClickRegion")
		local function v129()
			-- upvalues: (copy) v_u_128, (copy) p_u_122
			v_u_128.Selectable = p_u_122.isSelected
		end
		v125:add(p_u_122.toggled:Connect(v129))
		task.defer(v129)
		v125:add(function()
			-- upvalues: (copy) v_u_128
			v_u_128.Selectable = true
		end)
		local v_u_130 = p_u_121.UID
		table.insert(p_u_123, v_u_130)
		p_u_122:autoDeselect(false)
		p_u_122.childIconsDict[v_u_130] = true
		if not p_u_122.isEnabled then
			p_u_122:setEnabled(true)
		end
		p_u_121.joinedParent:Fire(p_u_122)
		v125:add(function()
			-- upvalues: (copy) p_u_121, (copy) p_u_123, (copy) v_u_130, (copy) p_u_122
			if not p_u_121.joinedFrame then
				return
			end
			for v131, v132 in pairs(p_u_123) do
				if v132 == v_u_130 then
					table.remove(p_u_123, v131)
					break
				end
			end
			local v133 = require(p_u_121.iconModule).getIconByUID(p_u_121.parentIconUID)
			if v133 then
				p_u_121:setAlignment(p_u_121.originalAlignment)
				p_u_121.parentIconUID = false
				p_u_121.joinedFrame = false
				p_u_121:setBehaviour("IconButton", "BackgroundTransparency", nil, true)
				p_u_121:removeModification("JoinModification")
				local v134 = true
				local v135 = v133.childIconsDict
				v135[v_u_130] = nil
				for _, _ in pairs(v135) do
					v134 = false
					break
				end
				if v134 and not v133.isAnOverflow then
					v133:setEnabled(false)
				end
				local v136 = p_u_122.alignment
				p_u_121:setAlignment(v136 == "Center" and "Left" or v136, true)
			end
		end)
	else
		p_u_121:leave()
	end
end
return v_u_1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Utility]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3302"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return "v3.0.2"]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VERSION]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="3303"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Elements]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3304"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p_u_1)
	local v_u_2 = p_u_1:getInstance("ClickRegion")
	local v_u_3 = Instance.new("CanvasGroup")
	v_u_3.Name = "Caption"
	v_u_3.AnchorPoint = Vector2.new(0.5, 0)
	v_u_3.BackgroundTransparency = 1
	v_u_3.BorderSizePixel = 0
	v_u_3.GroupTransparency = 1
	v_u_3.Position = UDim2.fromOffset(0, 0)
	v_u_3.Visible = true
	v_u_3.ZIndex = 30
	v_u_3.Parent = v_u_2
	local v_u_4 = Instance.new("Frame")
	v_u_4.Name = "Box"
	v_u_4.AutomaticSize = Enum.AutomaticSize.XY
	v_u_4.BackgroundColor3 = Color3.fromRGB(101, 102, 104)
	v_u_4.Position = UDim2.fromOffset(4, 7)
	v_u_4.ZIndex = 12
	v_u_4.Parent = v_u_3
	local v5 = Instance.new("TextLabel")
	v5.Name = "Header"
	v5.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	v5.Text = "Caption"
	v5.TextColor3 = Color3.fromRGB(255, 255, 255)
	v5.TextSize = 14
	v5.TextTruncate = Enum.TextTruncate.None
	v5.TextWrapped = false
	v5.TextXAlignment = Enum.TextXAlignment.Left
	v5.AutomaticSize = Enum.AutomaticSize.X
	v5.BackgroundTransparency = 1
	v5.LayoutOrder = 1
	v5.Size = UDim2.fromOffset(0, 16)
	v5.ZIndex = 18
	v5.Parent = v_u_4
	local v6 = Instance.new("UIListLayout")
	v6.Name = "Layout"
	v6.Padding = UDim.new(0, 8)
	v6.SortOrder = Enum.SortOrder.LayoutOrder
	v6.Parent = v_u_4
	local v7 = Instance.new("UICorner")
	v7.Name = "CaptionCorner"
	v7.Parent = v_u_4
	local v8 = Instance.new("UIPadding")
	v8.Name = "Padding"
	v8.PaddingBottom = UDim.new(0, 12)
	v8.PaddingLeft = UDim.new(0, 12)
	v8.PaddingRight = UDim.new(0, 12)
	v8.PaddingTop = UDim.new(0, 12)
	v8.Parent = v_u_4
	local v_u_9 = Instance.new("Frame")
	v_u_9.Name = "Hotkeys"
	v_u_9.AutomaticSize = Enum.AutomaticSize.Y
	v_u_9.BackgroundTransparency = 1
	v_u_9.LayoutOrder = 3
	v_u_9.Size = UDim2.fromScale(1, 0)
	v_u_9.Visible = false
	v_u_9.Parent = v_u_4
	local v10 = Instance.new("UIListLayout")
	v10.Name = "Layout1"
	v10.Padding = UDim.new(0, 6)
	v10.FillDirection = Enum.FillDirection.Vertical
	v10.HorizontalAlignment = Enum.HorizontalAlignment.Center
	v10.HorizontalFlex = Enum.UIFlexAlignment.None
	v10.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
	v10.VerticalFlex = Enum.UIFlexAlignment.None
	v10.SortOrder = Enum.SortOrder.LayoutOrder
	v10.Parent = v_u_9
	local v11 = Instance.new("ImageLabel")
	v11.Name = "Key1"
	v11.Image = "rbxasset://textures/ui/Controls/key_single.png"
	v11.ImageTransparency = 0.7
	v11.ScaleType = Enum.ScaleType.Slice
	v11.SliceCenter = Rect.new(5, 5, 23, 24)
	v11.AutomaticSize = Enum.AutomaticSize.X
	v11.BackgroundTransparency = 1
	v11.LayoutOrder = 1
	v11.Size = UDim2.fromOffset(0, 30)
	v11.ZIndex = 15
	v11.Parent = v_u_9
	local v12 = Instance.new("UIPadding")
	v12.Name = "Inset"
	v12.PaddingLeft = UDim.new(0, 8)
	v12.PaddingRight = UDim.new(0, 8)
	v12.Parent = v11
	local v_u_13 = Instance.new("TextLabel")
	v_u_13.AutoLocalize = false
	v_u_13.Name = "LabelContent"
	v_u_13.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	v_u_13.Text = ""
	v_u_13.TextColor3 = Color3.fromRGB(189, 190, 190)
	v_u_13.TextSize = 14
	v_u_13.AutomaticSize = Enum.AutomaticSize.X
	v_u_13.BackgroundTransparency = 1
	v_u_13.Position = UDim2.fromOffset(0, -1)
	v_u_13.Size = UDim2.fromScale(1, 1)
	v_u_13.ZIndex = 16
	v_u_13.Parent = v11
	local v_u_14 = Instance.new("ImageLabel")
	v_u_14.Name = "Caret"
	v_u_14.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_1x_1.png"
	v_u_14.ImageColor3 = Color3.fromRGB(101, 102, 104)
	v_u_14.ImageRectOffset = Vector2.new(260, 440)
	v_u_14.ImageRectSize = Vector2.new(16, 8)
	v_u_14.AnchorPoint = Vector2.new(0, 0.5)
	v_u_14.BackgroundTransparency = 1
	v_u_14.Position = UDim2.new(0, 0, 0, 4)
	v_u_14.Rotation = 180
	v_u_14.Size = UDim2.fromOffset(16, 8)
	v_u_14.ZIndex = 12
	v_u_14.Parent = v_u_3
	local v_u_15 = Instance.new("ImageLabel")
	v_u_15.Name = "DropShadow"
	v_u_15.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_1x_1.png"
	v_u_15.ImageColor3 = Color3.fromRGB(0, 0, 0)
	v_u_15.ImageRectOffset = Vector2.new(217, 486)
	v_u_15.ImageRectSize = Vector2.new(25, 25)
	v_u_15.ImageTransparency = 0.45
	v_u_15.ScaleType = Enum.ScaleType.Slice
	v_u_15.SliceCenter = Rect.new(12, 12, 13, 13)
	v_u_15.BackgroundTransparency = 1
	v_u_15.Position = UDim2.fromOffset(0, 5)
	v_u_15.Size = UDim2.new(1, 0, 0, 48)
	v_u_15.Parent = v_u_3
	v_u_4:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) v_u_15, (copy) v_u_4
		v_u_15.Size = UDim2.new(1, 0, 0, v_u_4.AbsoluteSize.Y + 8)
	end)
	local v16 = p_u_1.captionJanitor
	local _, v_u_17 = p_u_1:clipOutside(v_u_3)
	v_u_17.AutomaticSize = Enum.AutomaticSize.None
	v16:add(v_u_3:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) v_u_3, (copy) v_u_17
		local v18 = v_u_3.AbsoluteSize
		v_u_17.Size = UDim2.fromOffset(v18.X, v18.Y)
	end))
	local v19 = v_u_3.AbsoluteSize
	v_u_17.Size = UDim2.fromOffset(v19.X, v19.Y)
	local v_u_20 = false
	local v_u_21 = v_u_3.Box.Header
	local v_u_22 = game:GetService("UserInputService")
	local function v27(p23)
		-- upvalues: (copy) v_u_22, (copy) v_u_3, (copy) p_u_1, (copy) v_u_21, (copy) v_u_13, (copy) v_u_9
		local v24 = v_u_22.KeyboardEnabled
		local v25 = v_u_3:GetAttribute("CaptionText") or ""
		local v26 = v25 == "_hotkey_"
		if v24 or not v26 then
			v_u_21.Text = v25
			v_u_21.Visible = not v26
			if p23 then
				v_u_13.Text = p23.Name
				v_u_9.Visible = true
			end
			if not v24 then
				v_u_9.Visible = false
			end
		else
			p_u_1:setCaption()
		end
	end
	v_u_3:GetAttributeChangedSignal("CaptionText"):Connect(v27)
	local v28 = Enum.EasingStyle.Quad
	local v_u_29 = TweenInfo.new(0.2, v28, Enum.EasingDirection.In)
	local v_u_30 = TweenInfo.new(0.2, v28, Enum.EasingDirection.Out)
	local v_u_31 = game:GetService("TweenService")
	local v_u_32 = game:GetService("RunService")
	local function v_u_47(p33)
		-- upvalues: (ref) v_u_20, (copy) v_u_14, (copy) v_u_3, (copy) v_u_2, (copy) v_u_17, (copy) v_u_29, (copy) v_u_30, (copy) v_u_31, (copy) v_u_32
		if v_u_20 then
			if p33 == nil then
				p33 = v_u_20
			end
			local v34 = not p33
			if v34 == nil then
				v34 = v_u_20
			end
			local v35 = UDim2.new(0.5, 0, 1, v34 and 10 or 2)
			local v36
			if p33 == nil then
				v36 = v_u_20
			else
				v36 = p33
			end
			local v37 = UDim2.new(0.5, 0, 1, v36 and 10 or 2)
			if p33 then
				local v38 = v_u_14.Position.Y.Offset
				v_u_14.Position = UDim2.fromOffset(0, v38)
				v_u_3.AutomaticSize = Enum.AutomaticSize.XY
				v_u_3.Size = UDim2.fromOffset(32, 53)
			else
				local v39 = v_u_3.AbsoluteSize
				v_u_3.AutomaticSize = Enum.AutomaticSize.Y
				v_u_3.Size = UDim2.fromOffset(v39.X, v39.Y)
			end
			local v_u_40 = nil
			local function v44()
				-- upvalues: (ref) v_u_2, (ref) v_u_3, (ref) v_u_14, (ref) v_u_40
				local v41 = v_u_2.AbsolutePosition.X - v_u_3.AbsolutePosition.X + v_u_2.AbsoluteSize.X / 2 - v_u_14.AbsoluteSize.X / 2
				local v42 = v_u_14.Position.Y.Offset
				local v43 = UDim2.fromOffset(v41, v42)
				if v_u_40 ~= v41 then
					v_u_40 = v41
					v_u_14.Position = UDim2.fromOffset(0, v42)
					task.wait()
				end
				v_u_14.Position = v43
			end
			v_u_17.Position = v35
			v44()
			local v45 = v_u_31:Create(v_u_17, p33 and v_u_29 or v_u_30, {
				["Position"] = v37
			})
			local v_u_46 = v_u_32.Heartbeat:Connect(v44)
			v45:Play()
			v45.Completed:Once(function()
				-- upvalues: (copy) v_u_46
				v_u_46:Disconnect()
			end)
		end
	end
	v16:add(v_u_2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) v_u_47
		v_u_47()
	end))
	v_u_47(false)
	v16:add(p_u_1.toggleKeyAdded:Connect(v27))
	for v48, _ in pairs(p_u_1.bindedToggleKeys) do
		local v49 = v_u_22.KeyboardEnabled
		local v50 = v_u_3:GetAttribute("CaptionText") or ""
		local v51 = v50 == "_hotkey_"
		if v49 or not v51 then
			v_u_21.Text = v50
			v_u_21.Visible = not v51
			if v48 then
				v_u_13.Text = v48.Name
				v_u_9.Visible = true
			end
			if not v49 then
				v_u_9.Visible = false
			end
		else
			p_u_1:setCaption()
		end
		break
	end
	v16:add(p_u_1.fakeToggleKeyChanged:Connect(v27))
	local v52 = p_u_1.fakeToggleKey
	if v52 then
		local v53 = v_u_22.KeyboardEnabled
		local v54 = v_u_3:GetAttribute("CaptionText") or ""
		local v55 = v54 == "_hotkey_"
		if v53 or not v55 then
			v_u_21.Text = v54
			v_u_21.Visible = not v55
			if v52 then
				v_u_13.Text = v52.Name
				v_u_9.Visible = true
			end
			if not v53 then
				v_u_9.Visible = false
			end
		else
			p_u_1:setCaption()
		end
	end
	local function v_u_61(p56)
		-- upvalues: (ref) v_u_20, (copy) p_u_1, (copy) v_u_29, (copy) v_u_30, (copy) v_u_31, (copy) v_u_3, (copy) v_u_47, (copy) v_u_22, (copy) v_u_21, (copy) v_u_9
		if v_u_20 == p56 then
			return
		else
			local v57 = p_u_1.joinedFrame
			if v57 and string.match(v57.Name, "Dropdown") then
				p56 = false
			end
			v_u_20 = p56
			v_u_31:Create(v_u_3, p56 and v_u_29 or v_u_30, {
				["GroupTransparency"] = p56 and 0 or 1
			}):Play()
			v_u_47()
			local v58 = v_u_22.KeyboardEnabled
			local v59 = v_u_3:GetAttribute("CaptionText") or ""
			local v60 = v59 == "_hotkey_"
			if v58 or not v60 then
				v_u_21.Text = v59
				v_u_21.Visible = not v60
				if not v58 then
					v_u_9.Visible = false
				end
			else
				p_u_1:setCaption()
			end
		end
	end
	local v_u_62 = require(p_u_1.iconModule)
	v16:add(p_u_1.stateChanged:Connect(function(p63)
		-- upvalues: (copy) v_u_62, (copy) p_u_1, (copy) v_u_61
		if p63 == "Viewing" then
			local v64 = v_u_62.captionLastClosedClock
			local v65 = (v64 and os.clock() - v64 or 999) < 0.3 and 0 or 0.5
			task.delay(v65, function()
				-- upvalues: (ref) p_u_1, (ref) v_u_61
				if p_u_1.activeState == "Viewing" then
					v_u_61(true)
				end
			end)
		else
			v_u_62.captionLastClosedClock = os.clock()
			v_u_61(false)
		end
	end))
	return v_u_3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Caption]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3305"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p_u_1)
	local v2 = game:GetService("GuiService")
	local v3 = p_u_1.isOldTopbar
	local v4 = {}
	local v5 = v2:GetGuiInset()
	local v6 = v2:IsTenFootInterface()
	local v7 = v6 and 10 or (v3 and 12 or v5.Y - 46)
	local v_u_8 = Instance.new("ScreenGui")
	v_u_8:SetAttribute("StartInset", v7)
	v_u_8.Name = "TopbarStandard"
	v_u_8.Enabled = true
	v_u_8.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	v_u_8.IgnoreGuiInset = true
	v_u_8.ResetOnSpawn = false
	v_u_8.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
	v4[v_u_8.Name] = v_u_8
	v_u_8.DisplayOrder = p_u_1.baseDisplayOrder
	p_u_1.baseDisplayOrderChanged:Connect(function()
		-- upvalues: (copy) v_u_8, (copy) p_u_1
		v_u_8.DisplayOrder = p_u_1.baseDisplayOrder
	end)
	local v9 = Instance.new("Frame")
	local v10 = v3 and 2 or 0
	local v_u_11
	if v6 then
		v10 = v10 + 13
		v_u_11 = 50
	else
		v_u_11 = -2
	end
	v9.Name = "Holders"
	v9.BackgroundTransparency = 1
	v9.Position = UDim2.new(0, 0, 0, v10)
	v9.Size = UDim2.new(1, 0, 1, v_u_11)
	v9.Visible = true
	v9.ZIndex = 1
	v9.Parent = v_u_8
	local v_u_12 = v_u_8:Clone()
	local v_u_13 = v_u_12.Holders
	local v_u_14 = game:GetService("GuiService")
	local function v15()
		-- upvalues: (copy) v_u_13, (copy) v_u_14, (ref) v_u_11
		v_u_13.Size = UDim2.new(1, 0, 0, v_u_14.TopbarInset.Height + v_u_11)
	end
	v_u_12.Name = "TopbarCentered"
	v_u_12.ScreenInsets = Enum.ScreenInsets.None
	p_u_1.baseDisplayOrderChanged:Connect(function()
		-- upvalues: (copy) v_u_12, (copy) p_u_1
		v_u_12.DisplayOrder = p_u_1.baseDisplayOrder
	end)
	v4[v_u_12.Name] = v_u_12
	v_u_14:GetPropertyChangedSignal("TopbarInset"):Connect(v15)
	v_u_13.Size = UDim2.new(1, 0, 0, v_u_14.TopbarInset.Height + v_u_11)
	local v_u_16 = v_u_8:Clone()
	v_u_16.Name = v_u_16.Name .. "Clipped"
	v_u_16.DisplayOrder = v_u_16.DisplayOrder + 1
	p_u_1.baseDisplayOrderChanged:Connect(function()
		-- upvalues: (copy) v_u_16, (copy) p_u_1
		v_u_16.DisplayOrder = p_u_1.baseDisplayOrder + 1
	end)
	v4[v_u_16.Name] = v_u_16
	local v_u_17 = v_u_12:Clone()
	v_u_17.Name = v_u_17.Name .. "Clipped"
	v_u_17.DisplayOrder = v_u_17.DisplayOrder + 1
	p_u_1.baseDisplayOrderChanged:Connect(function()
		-- upvalues: (copy) v_u_17, (copy) p_u_1
		v_u_17.DisplayOrder = p_u_1.baseDisplayOrder + 1
	end)
	v4[v_u_17.Name] = v_u_17
	if v3 then
		task.defer(function()
			-- upvalues: (copy) v_u_14, (copy) p_u_1
			local function v18()
				-- upvalues: (ref) v_u_14, (ref) p_u_1
				if v_u_14.MenuIsOpen then
					p_u_1.setTopbarEnabled(false, true)
				else
					p_u_1.setTopbarEnabled()
				end
			end
			v_u_14:GetPropertyChangedSignal("MenuIsOpen"):Connect(v18)
			if v_u_14.MenuIsOpen then
				p_u_1.setTopbarEnabled(false, true)
			else
				p_u_1.setTopbarEnabled()
			end
		end)
	end
	local v19 = Instance.new("ScrollingFrame")
	v19:SetAttribute("IsAHolder", true)
	v19.Name = "Left"
	v19.Position = UDim2.fromOffset(v7, 0)
	v19.Size = UDim2.new(1, -24, 1, 0)
	v19.BackgroundTransparency = 1
	v19.Visible = true
	v19.ZIndex = 1
	v19.Active = false
	v19.ClipsDescendants = true
	v19.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	v19.CanvasSize = UDim2.new(0, 0, 1, -1)
	v19.AutomaticCanvasSize = Enum.AutomaticSize.X
	v19.ScrollingDirection = Enum.ScrollingDirection.X
	v19.ScrollBarThickness = 0
	v19.BorderSizePixel = 0
	v19.Selectable = false
	v19.ScrollingEnabled = false
	v19.ElasticBehavior = Enum.ElasticBehavior.Never
	v19.Parent = v9
	local v20 = Instance.new("UIListLayout")
	v20.Padding = UDim.new(0, v7)
	v20.FillDirection = Enum.FillDirection.Horizontal
	v20.SortOrder = Enum.SortOrder.LayoutOrder
	v20.VerticalAlignment = Enum.VerticalAlignment.Bottom
	v20.HorizontalAlignment = Enum.HorizontalAlignment.Left
	v20.Parent = v19
	local v21 = v19:Clone()
	v21.ScrollingEnabled = false
	v21.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	v21.Name = "Center"
	v21.Parent = v_u_13
	local v22 = v19:Clone()
	v22.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	v22.Name = "Right"
	v22.AnchorPoint = Vector2.new(1, 0)
	v22.Position = UDim2.new(1, -12, 0, 0)
	v22.Parent = v9
	return v4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Container]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3306"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p_u_1)
	local v_u_2 = Instance.new("Frame")
	v_u_2.Name = "Dropdown"
	v_u_2.AutomaticSize = Enum.AutomaticSize.XY
	v_u_2.BackgroundTransparency = 1
	v_u_2.BorderSizePixel = 0
	v_u_2.AnchorPoint = Vector2.new(0.5, 0)
	v_u_2.Position = UDim2.new(0.5, 0, 1, 10)
	v_u_2.ZIndex = -2
	v_u_2.ClipsDescendants = true
	v_u_2.Parent = p_u_1.widget
	local v3 = Instance.new("UICorner")
	v3.Name = "DropdownCorner"
	v3.CornerRadius = UDim.new(0, 10)
	v3.Parent = v_u_2
	local v_u_4 = Instance.new("ScrollingFrame")
	v_u_4.Name = "DropdownScroller"
	v_u_4.AutomaticSize = Enum.AutomaticSize.X
	v_u_4.BackgroundTransparency = 1
	v_u_4.BorderSizePixel = 0
	v_u_4.AnchorPoint = Vector2.new(0, 0)
	v_u_4.Position = UDim2.new(0, 0, 0, 0)
	v_u_4.ZIndex = -1
	v_u_4.ClipsDescendants = true
	v_u_4.Visible = true
	v_u_4.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	v_u_4.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
	v_u_4.Active = false
	v_u_4.ScrollingEnabled = true
	v_u_4.AutomaticCanvasSize = Enum.AutomaticSize.Y
	v_u_4.ScrollBarThickness = 5
	v_u_4.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
	v_u_4.ScrollBarImageTransparency = 0.8
	v_u_4.CanvasSize = UDim2.new(0, 0, 0, 0)
	v_u_4.Selectable = false
	v_u_4.Active = true
	v_u_4.Parent = v_u_2
	local v_u_5 = Instance.new("UIPadding")
	v_u_5.Name = "DropdownPadding"
	v_u_5.PaddingTop = UDim.new(0, 8)
	v_u_5.PaddingBottom = UDim.new(0, 8)
	v_u_5.Parent = v_u_4
	local v6 = Instance.new("UIListLayout")
	v6.Name = "DropdownList"
	v6.FillDirection = Enum.FillDirection.Vertical
	v6.SortOrder = Enum.SortOrder.LayoutOrder
	v6.HorizontalAlignment = Enum.HorizontalAlignment.Center
	v6.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly
	v6.Parent = v_u_4
	local v7 = p_u_1.dropdownJanitor
	local v_u_8 = require(p_u_1.iconModule)
	p_u_1.dropdownChildAdded:Connect(function(p_u_9)
		local _, v_u_10 = p_u_9:modifyTheme({
			{ "Widget", "BorderSize", 0 },
			{ "IconCorners", "CornerRadius", UDim.new(0, 4) },
			{ "Widget", "MinimumWidth", 190 },
			{ "Widget", "MinimumHeight", 56 },
			{ "IconLabel", "TextSize", 19 },
			{ "PaddingLeft", "Size", UDim2.fromOffset(25, 0) },
			{ "Notice", "Position", UDim2.new(1, -24, 0, 5) },
			{ "ContentsList", "HorizontalAlignment", Enum.HorizontalAlignment.Left },
			{ "Selection", "Size", UDim2.new(1, -8, 1, -8) },
			{ "Selection", "Position", UDim2.new(0, 4, 0, 4) }
		})
		task.defer(function()
			-- upvalues: (copy) p_u_9, (copy) v_u_10
			p_u_9.joinJanitor:add(function()
				-- upvalues: (ref) p_u_9, (ref) v_u_10
				p_u_9:removeModification(v_u_10)
			end)
		end)
	end)
	p_u_1.dropdownSet:Connect(function(p11)
		-- upvalues: (copy) p_u_1, (copy) v_u_8
		for _, v12 in pairs(p_u_1.dropdownIcons) do
			v_u_8.getIconByUID(v12):destroy()
		end
		local _ = #p11
		if type(p11) == "table" then
			for _, v13 in pairs(p11) do
				v13:joinDropdown(p_u_1)
			end
		end
	end)
	local v_u_14 = require(script.Parent.Parent.Utility)
	v7:add(p_u_1.toggled:Connect(function()
		-- upvalues: (copy) v_u_14, (copy) v_u_2, (copy) p_u_1
		v_u_14.setVisible(v_u_2, p_u_1.isSelected, "InternalDropdown")
	end))
	v_u_14.setVisible(v_u_2, p_u_1.isSelected, "InternalDropdown")
	local v_u_15 = 0
	local v_u_16 = false
	local function v_u_32()
		-- upvalues: (ref) v_u_15, (ref) v_u_16, (copy) v_u_32, (copy) v_u_2, (copy) v_u_4, (copy) v_u_8, (copy) p_u_1, (copy) v_u_5
		v_u_15 = v_u_15 + 1
		if v_u_16 then
			return
		end
		local v_u_17 = v_u_15
		v_u_16 = true
		task.defer(function()
			-- upvalues: (ref) v_u_16, (ref) v_u_15, (copy) v_u_17, (ref) v_u_32
			v_u_16 = false
			if v_u_15 ~= v_u_17 then
				v_u_32()
			end
		end)
		local v18 = v_u_2:GetAttribute("MaxIcons")
		if not v18 then
			return
		end
		local v19 = {}
		for _, v20 in pairs(v_u_4:GetChildren()) do
			if v20:IsA("GuiObject") then
				local v21 = { v20, v20.AbsolutePosition.Y }
				table.insert(v19, v21)
			end
		end
		table.sort(v19, function(p22, p23)
			return p22[2] < p23[2]
		end)
		local v24 = 0
		local v25 = false
		for v26 = 1, v18 do
			local v27 = v19[v26]
			if not v27 then
				break
			end
			local v28 = v27[1]
			v24 = v24 + v28.AbsoluteSize.Y
			local v29 = v28:GetAttribute("WidgetUID")
			if v29 then
				v29 = v_u_8.getIconByUID(v29)
			end
			if v29 then
				local v30
				if v25 then
					v30 = nil
				else
					v30 = p_u_1:getInstance("ClickRegion")
					v25 = true
				end
				v29:getInstance("ClickRegion").NextSelectionUp = v30
			end
		end
		local v31 = v24 + v_u_5.PaddingTop.Offset + v_u_5.PaddingBottom.Offset
		v_u_4.Size = UDim2.fromOffset(0, v31)
	end
	v7:add(v_u_4:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(v_u_32))
	v7:add(v_u_4.ChildAdded:Connect(v_u_32))
	v7:add(v_u_4.ChildRemoved:Connect(v_u_32))
	v7:add(v_u_2:GetAttributeChangedSignal("MaxIcons"):Connect(v_u_32))
	v7:add(p_u_1.childThemeModified:Connect(v_u_32))
	v_u_32()
	return v_u_2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Dropdown]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3307"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p_u_1, _)
	local v_u_2 = p_u_1.widget
	local v3 = p_u_1:getInstance("Contents")
	local v_u_4 = Instance.new("Frame")
	v_u_4.Name = "Indicator"
	v_u_4.LayoutOrder = 9999999
	v_u_4.ZIndex = 6
	v_u_4.Size = UDim2.new(0, 42, 0, 42)
	v_u_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	v_u_4.BackgroundTransparency = 1
	v_u_4.Position = UDim2.new(1, 0, 0.5, 0)
	v_u_4.BorderSizePixel = 0
	v_u_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	v_u_4.Parent = v3
	local v_u_5 = Instance.new("Frame")
	v_u_5.Name = "IndicatorButton"
	v_u_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	v_u_5.AnchorPoint = Vector2.new(0.5, 0.5)
	v_u_5.BorderSizePixel = 0
	v_u_5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	v_u_5.Parent = v_u_4
	local v_u_6 = game:GetService("GuiService")
	local v_u_7 = game:GetService("GamepadService")
	local v_u_8 = p_u_1:getInstance("ClickRegion")
	local function v9()
		-- upvalues: (copy) v_u_6, (copy) v_u_8, (copy) v_u_5
		if v_u_6.SelectedObject == v_u_8 then
			v_u_5.BackgroundTransparency = 1
			v_u_5.Position = UDim2.new(0.5, -2, 0.5, 0)
			v_u_5.Size = UDim2.fromScale(1.2, 1.2)
		else
			v_u_5.BackgroundTransparency = 0.75
			v_u_5.Position = UDim2.new(0.5, 2, 0.5, 0)
			v_u_5.Size = UDim2.fromScale(1, 1)
		end
	end
	p_u_1.janitor:add(v_u_6:GetPropertyChangedSignal("SelectedObject"):Connect(v9))
	v9()
	local v_u_10 = Instance.new("ImageLabel")
	v_u_10.LayoutOrder = 2
	v_u_10.ZIndex = 15
	v_u_10.AnchorPoint = Vector2.new(0.5, 0.5)
	v_u_10.Size = UDim2.new(0.5, 0, 0.5, 0)
	v_u_10.BackgroundTransparency = 1
	v_u_10.Position = UDim2.new(0.5, 0, 0.5, 0)
	v_u_10.Image = "rbxasset://textures/ui/Controls/XboxController/DPadUp@2x.png"
	v_u_10.Parent = v_u_5
	local v11 = Instance.new("UICorner")
	v11.CornerRadius = UDim.new(1, 0)
	v11.Parent = v_u_5
	local v_u_12 = game:GetService("UserInputService")
	local function v_u_14(p13)
		-- upvalues: (copy) v_u_4, (copy) v_u_7, (copy) p_u_1
		if p13 == nil then
			p13 = v_u_4.Visible
		end
		if v_u_7.GamepadCursorEnabled then
			p13 = false
		end
		if p13 then
			p_u_1:modifyTheme({ "PaddingRight", "Size", UDim2.new(0, 0, 1, 0) }, "IndicatorPadding")
		elseif v_u_4.Visible then
			p_u_1:removeModification("IndicatorPadding")
		end
		p_u_1:modifyTheme({ "Indicator", "Visible", p13 })
		p_u_1.updateSize:Fire()
	end
	p_u_1.janitor:add(v_u_7:GetPropertyChangedSignal("GamepadCursorEnabled"):Connect(v_u_14))
	p_u_1.indicatorSet:Connect(function(p15)
		-- upvalues: (copy) v_u_10, (copy) v_u_12, (copy) v_u_14
		local v16
		if p15 then
			v_u_10.Image = v_u_12:GetImageForKeyCode(p15)
			v16 = true
		else
			v16 = false
		end
		v_u_14(v16)
	end)
	v_u_2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) v_u_2, (copy) v_u_4
		local v17 = v_u_2.AbsoluteSize.Y * 0.96
		v_u_4.Size = UDim2.new(0, v17, 0, v17)
	end)
	local v18 = v_u_2.AbsoluteSize.Y * 0.96
	v_u_4.Size = UDim2.new(0, v18, 0, v18)
	return v_u_4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Indicator]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3308"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p_u_1)
	local v_u_2 = Instance.new("ScrollingFrame")
	v_u_2.Name = "Menu"
	v_u_2.BackgroundTransparency = 1
	v_u_2.Visible = true
	v_u_2.ZIndex = 1
	v_u_2.Size = UDim2.fromScale(1, 1)
	v_u_2.ClipsDescendants = true
	v_u_2.TopImage = ""
	v_u_2.BottomImage = ""
	v_u_2.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
	v_u_2.CanvasSize = UDim2.new(0, 0, 1, -1)
	v_u_2.ScrollingEnabled = true
	v_u_2.ScrollingDirection = Enum.ScrollingDirection.X
	v_u_2.ZIndex = 20
	v_u_2.ScrollBarThickness = 3
	v_u_2.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
	v_u_2.ScrollBarImageTransparency = 0.8
	v_u_2.BorderSizePixel = 0
	v_u_2.Selectable = false
	local v_u_3 = require(p_u_1.iconModule)
	local v_u_4 = v_u_3.container.TopbarStandard:FindFirstChild("UIListLayout", true):Clone()
	v_u_4.Name = "MenuUIListLayout"
	v_u_4.VerticalAlignment = Enum.VerticalAlignment.Center
	v_u_4.Parent = v_u_2
	local v5 = Instance.new("Frame")
	v5.Name = "MenuGap"
	v5.BackgroundTransparency = 1
	v5.Visible = false
	v5.AnchorPoint = Vector2.new(0, 0.5)
	v5.ZIndex = 5
	v5.Parent = v_u_2
	local v_u_6 = false
	local v_u_7 = require(script.Parent.Parent.Features.Themes)
	local function v32()
		-- upvalues: (copy) p_u_1, (ref) v_u_6, (copy) v_u_2, (copy) v_u_7, (copy) v_u_4
		local v_u_8 = p_u_1.menuJanitor
		local v9 = #p_u_1.menuIcons
		if v_u_6 then
			if v9 <= 0 then
				v_u_8:clean()
				v_u_6 = false
			end
		else
			v_u_6 = true
			v_u_8:add(p_u_1.toggled:Connect(function()
				-- upvalues: (ref) p_u_1
				if #p_u_1.menuIcons > 0 then
					p_u_1.updateSize:Fire()
				end
			end))
			local _, v_u_10 = p_u_1:modifyTheme({
				{ "Menu", "Active", true }
			})
			task.defer(function()
				-- upvalues: (copy) v_u_8, (ref) p_u_1, (copy) v_u_10
				v_u_8:add(function()
					-- upvalues: (ref) p_u_1, (ref) v_u_10
					p_u_1:removeModification(v_u_10)
				end)
			end)
			local v_u_11 = v_u_2.AbsoluteCanvasSize.X
			local function v14()
				-- upvalues: (ref) p_u_1, (ref) v_u_2, (ref) v_u_11
				if p_u_1.alignment == "Right" then
					local v12 = v_u_2.AbsoluteCanvasSize.X
					local v13 = v_u_11 - v12
					v_u_11 = v12
					v_u_2.CanvasPosition = Vector2.new(v_u_2.CanvasPosition.X - v13, 0)
				end
			end
			v_u_8:add(p_u_1.selected:Connect(v14))
			v_u_8:add(v_u_2:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(v14))
			local v15 = p_u_1:getStateGroup()
			if v_u_7.getThemeValue(v15, "IconImage", "Image", "Deselected") == v_u_7.getThemeValue(v15, "IconImage", "Image", "Selected") then
				local v16 = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Light, Enum.FontStyle.Normal)
				p_u_1:removeModificationWith("IconLabel", "Text", "Viewing")
				p_u_1:removeModificationWith("IconLabel", "Image", "Viewing")
				p_u_1:modifyTheme({
					{
						"IconLabel",
						"FontFace",
						v16,
						"Selected"
					},
					{
						"IconLabel",
						"Text",
						"X",
						"Selected"
					},
					{
						"IconLabel",
						"TextSize",
						20,
						"Selected"
					},
					{
						"IconLabel",
						"TextStrokeTransparency",
						0.8,
						"Selected"
					},
					{
						"IconImage",
						"Image",
						"",
						"Selected"
					}
				})
			end
			local v_u_17 = p_u_1:getInstance("IconSpot")
			local v_u_18 = p_u_1:getInstance("MenuGap")
			local function v19()
				-- upvalues: (ref) p_u_1, (copy) v_u_17, (copy) v_u_18
				if p_u_1.alignment == "Right" then
					v_u_17.LayoutOrder = 99999
					v_u_18.LayoutOrder = 99998
				else
					v_u_17.LayoutOrder = -99999
					v_u_18.LayoutOrder = -99998
				end
			end
			v_u_8:add(p_u_1.alignmentChanged:Connect(v19))
			if p_u_1.alignment == "Right" then
				v_u_17.LayoutOrder = 99999
				v_u_18.LayoutOrder = 99998
			else
				v_u_17.LayoutOrder = -99999
				v_u_18.LayoutOrder = -99998
			end
			v_u_2:GetAttributeChangedSignal("MenuCanvasWidth"):Connect(function()
				-- upvalues: (ref) v_u_2
				local v20 = v_u_2:GetAttribute("MenuCanvasWidth")
				local v21 = v_u_2.CanvasSize.Y
				v_u_2.CanvasSize = UDim2.new(0, v20, v21.Scale, v21.Offset)
			end)
			v_u_8:add(p_u_1.updateMenu:Connect(function()
				-- upvalues: (ref) v_u_2, (ref) v_u_4
				local v22 = v_u_2:GetAttribute("MaxIcons")
				if not v22 then
					return
				end
				local v23 = {}
				for _, v24 in pairs(v_u_2:GetChildren()) do
					if v24:GetAttribute("WidgetUID") and v24.Visible then
						local v25 = { v24, v24.AbsolutePosition.X }
						table.insert(v23, v25)
					end
				end
				table.sort(v23, function(p26, p27)
					return p26[2] < p27[2]
				end)
				local v28 = 0
				for v29 = 1, v22 do
					local v30 = v23[v29]
					if not v30 then
						break
					end
					v28 = v28 + (v30[1].AbsoluteSize.X + v_u_4.Padding.Offset)
				end
				v_u_2:SetAttribute("MenuWidth", v28)
			end))
			local function v31()
				-- upvalues: (ref) p_u_1
				task.delay(0.1, function()
					-- upvalues: (ref) p_u_1
					p_u_1.startMenuUpdate:Fire()
				end)
			end
			local _ = p_u_1:getInstance("IconButton").AbsoluteSize.X
			v_u_8:add(v_u_2.ChildAdded:Connect(v31))
			v_u_8:add(v_u_2.ChildRemoved:Connect(v31))
			v_u_8:add(v_u_2:GetAttributeChangedSignal("MaxIcons"):Connect(v31))
			v_u_8:add(v_u_2:GetAttributeChangedSignal("MaxWidth"):Connect(v31))
			task.delay(0.1, function()
				-- upvalues: (ref) p_u_1
				p_u_1.startMenuUpdate:Fire()
			end)
		end
	end
	p_u_1.menuChildAdded:Connect(v32)
	p_u_1.menuSet:Connect(function(p33)
		-- upvalues: (copy) p_u_1, (copy) v_u_3
		for _, v34 in pairs(p_u_1.menuIcons) do
			v_u_3.getIconByUID(v34):destroy()
		end
		local _ = #p33
		if type(p33) == "table" then
			for _, v35 in pairs(p33) do
				v35:joinMenu(p_u_1)
			end
		end
	end)
	return v_u_2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Menu]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3309"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p_u_1, p_u_2)
	local v_u_3 = Instance.new("Frame")
	v_u_3.Name = "Notice"
	v_u_3.ZIndex = 25
	v_u_3.AutomaticSize = Enum.AutomaticSize.X
	v_u_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	v_u_3.BorderSizePixel = 0
	v_u_3.BackgroundTransparency = 0.1
	v_u_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v_u_3.Visible = false
	v_u_3.Parent = p_u_1.widget
	local v4 = Instance.new("UICorner")
	v4.CornerRadius = UDim.new(1, 0)
	v4.Parent = v_u_3
	Instance.new("UIStroke").Parent = v_u_3
	local v_u_5 = Instance.new("TextLabel")
	v_u_5.Name = "NoticeLabel"
	v_u_5.ZIndex = 26
	v_u_5.AnchorPoint = Vector2.new(0.5, 0.5)
	v_u_5.AutomaticSize = Enum.AutomaticSize.X
	v_u_5.Size = UDim2.new(1, 0, 1, 0)
	v_u_5.BackgroundTransparency = 1
	v_u_5.Position = UDim2.new(0.5, 0, 0.515, 0)
	v_u_5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	v_u_5.FontSize = Enum.FontSize.Size14
	v_u_5.TextColor3 = Color3.fromRGB(0, 0, 0)
	v_u_5.Text = "1"
	v_u_5.TextWrapped = true
	v_u_5.TextWrap = true
	v_u_5.Font = Enum.Font.Arial
	v_u_5.Parent = v_u_3
	local v6 = script.Parent.Parent
	local v7 = v6.Packages
	local v_u_8 = require(v7.Janitor)
	local v_u_9 = require(v7.GoodSignal)
	local v_u_10 = require(v6.Utility)
	p_u_1.noticeChanged:Connect(function(p11)
		-- upvalues: (copy) v_u_5, (copy) p_u_2, (copy) p_u_1, (copy) v_u_10, (copy) v_u_3
		if p11 then
			local v12 = p11 > 99
			v_u_5.Text = v12 and "99+" or p11
			if v12 then
				v_u_5.TextSize = 11
			end
			local v13 = p11 >= 1
			local v14 = p_u_2.getIconByUID(p_u_1.parentIconUID)
			local v15 = #p_u_1.dropdownIcons > 0 and true or #p_u_1.menuIcons > 0
			if p_u_1.isSelected and v15 then
				v13 = false
			elseif v14 and not v14.isSelected then
				v13 = false
			end
			v_u_10.setVisible(v_u_3, v13, "NoticeHandler")
		end
	end)
	p_u_1.noticeStarted:Connect(function(p16, p17)
		-- upvalues: (copy) p_u_1, (copy) p_u_2, (copy) v_u_8, (copy) v_u_9, (copy) v_u_10
		local v18 = p16 or p_u_1.deselected
		local v19 = p_u_2.getIconByUID(p_u_1.parentIconUID)
		if v19 then
			v19:notify(v18)
		end
		local v_u_20 = p_u_1.janitor:add(v_u_8.new())
		local v_u_21 = v_u_20:add(v_u_9.new())
		v_u_20:add(p_u_1.endNotices:Connect(function()
			-- upvalues: (copy) v_u_21
			v_u_21:Fire()
		end))
		v_u_20:add(v18:Connect(function()
			-- upvalues: (copy) v_u_21
			v_u_21:Fire()
		end))
		local v_u_22 = p17 or v_u_10.generateUID()
		p_u_1.notices[v_u_22] = {
			["completeSignal"] = v_u_21,
			["clearNoticeEvent"] = v18
		}
		p_u_1:getInstance("NoticeLabel")
		p_u_1.notified:Fire(v_u_22)
		local v23 = p_u_1
		v23.totalNotices = v23.totalNotices + 1
		p_u_1.noticeChanged:Fire(p_u_1.totalNotices)
		v_u_21:Once(function()
			-- upvalues: (copy) v_u_20, (ref) p_u_1, (ref) v_u_22
			v_u_20:destroy()
			local v24 = p_u_1
			v24.totalNotices = v24.totalNotices - 1
			p_u_1.notices[v_u_22] = nil
			p_u_1.noticeChanged:Fire(p_u_1.totalNotices)
		end)
	end)
	v_u_3:SetAttribute("ClipToJoinedParent", true)
	p_u_1:clipOutside(v_u_3)
	return v_u_3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Notice]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3310"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(_)
	local v1 = Instance.new("Frame")
	v1.Name = "SelectionContainer"
	v1.Visible = false
	local v_u_2 = Instance.new("Frame")
	v_u_2.Name = "Selection"
	v_u_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v_u_2.BackgroundTransparency = 1
	v_u_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	v_u_2.BorderSizePixel = 0
	v_u_2.Parent = v1
	local v3 = Instance.new("UIStroke")
	v3.Name = "UIStroke"
	v3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	v3.Color = Color3.fromRGB(255, 255, 255)
	v3.Thickness = 3
	v3.Parent = v_u_2
	local v_u_4 = Instance.new("UIGradient")
	v_u_4.Name = "SelectionGradient"
	v_u_4.Parent = v3
	local v5 = Instance.new("UICorner")
	v5:SetAttribute("Collective", "IconCorners")
	v5.Name = "UICorner"
	v5.CornerRadius = UDim.new(1, 0)
	v5.Parent = v_u_2
	local v6 = game:GetService("RunService")
	local v_u_7 = game:GetService("GuiService")
	local v_u_8 = 1
	v_u_2:GetAttributeChangedSignal("RotationSpeed"):Connect(function()
		-- upvalues: (ref) v_u_8, (copy) v_u_2
		v_u_8 = v_u_2:GetAttribute("RotationSpeed")
	end)
	v6.Heartbeat:Connect(function()
		-- upvalues: (copy) v_u_7, (copy) v_u_4, (ref) v_u_8
		if v_u_7.SelectedObject then
			v_u_4.Rotation = os.clock() * v_u_8 * 100 % 360
		end
	end)
	return v1
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Selection]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3311"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p_u_1, p_u_2)
	local v_u_3 = Instance.new("Frame")
	v_u_3:SetAttribute("WidgetUID", p_u_1.UID)
	v_u_3.Name = "Widget"
	v_u_3.BackgroundTransparency = 1
	v_u_3.Visible = true
	v_u_3.ZIndex = 20
	v_u_3.Active = false
	v_u_3.ClipsDescendants = true
	local v_u_4 = Instance.new("Frame")
	v_u_4.Name = "IconButton"
	v_u_4.Visible = true
	v_u_4.ZIndex = 2
	v_u_4.BorderSizePixel = 0
	v_u_4.Parent = v_u_3
	v_u_4.ClipsDescendants = true
	v_u_4.Active = false
	p_u_1.deselected:Connect(function()
		-- upvalues: (copy) v_u_4
		v_u_4.ClipsDescendants = true
	end)
	p_u_1.selected:Connect(function()
		-- upvalues: (copy) p_u_1, (copy) v_u_4
		task.defer(function()
			-- upvalues: (ref) p_u_1, (ref) v_u_4
			p_u_1.resizingComplete:Once(function()
				-- upvalues: (ref) p_u_1, (ref) v_u_4
				if p_u_1.isSelected then
					v_u_4.ClipsDescendants = false
				end
			end)
		end)
	end)
	local v5 = Instance.new("UICorner")
	v5:SetAttribute("Collective", "IconCorners")
	v5.Parent = v_u_4
	local v_u_6 = require(script.Parent.Menu)(p_u_1)
	local v_u_7 = v_u_6.MenuUIListLayout
	local v_u_8 = v_u_6.MenuGap
	v_u_6.Parent = v_u_4
	local v_u_9 = Instance.new("Frame")
	v_u_9.Name = "IconSpot"
	v_u_9.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
	v_u_9.BackgroundTransparency = 0.9
	v_u_9.Visible = true
	v_u_9.AnchorPoint = Vector2.new(0, 0.5)
	v_u_9.ZIndex = 5
	v_u_9.Parent = v_u_6
	v5:Clone().Parent = v_u_9
	local v10 = v_u_9:Clone()
	v10.Name = "IconOverlay"
	v10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v10.ZIndex = v_u_9.ZIndex + 1
	v10.Size = UDim2.new(1, 0, 1, 0)
	v10.Position = UDim2.new(0, 0, 0, 0)
	v10.AnchorPoint = Vector2.new(0, 0)
	v10.Visible = false
	v10.Parent = v_u_9
	local v_u_11 = Instance.new("TextButton")
	v_u_11:SetAttribute("CorrespondingIconUID", p_u_1.UID)
	v_u_11.Name = "ClickRegion"
	v_u_11.BackgroundTransparency = 1
	v_u_11.Visible = true
	v_u_11.Text = ""
	v_u_11.ZIndex = 20
	v_u_11.Selectable = true
	v_u_11.SelectionGroup = true
	v_u_11.Parent = v_u_9
	require(script.Parent.Parent.Features.Gamepad).registerButton(v_u_11)
	v5:Clone().Parent = v_u_11
	local v_u_12 = Instance.new("Frame")
	v_u_12.Name = "Contents"
	v_u_12.BackgroundTransparency = 1
	v_u_12.Size = UDim2.fromScale(1, 1)
	v_u_12.Parent = v_u_9
	local v_u_13 = Instance.new("UIListLayout")
	v_u_13.Name = "ContentsList"
	v_u_13.FillDirection = Enum.FillDirection.Horizontal
	v_u_13.VerticalAlignment = Enum.VerticalAlignment.Center
	v_u_13.SortOrder = Enum.SortOrder.LayoutOrder
	v_u_13.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
	v_u_13.Padding = UDim.new(0, 3)
	v_u_13.Parent = v_u_12
	local v_u_14 = Instance.new("Frame")
	v_u_14.Name = "PaddingLeft"
	v_u_14.LayoutOrder = 1
	v_u_14.ZIndex = 5
	v_u_14.BorderColor3 = Color3.fromRGB(0, 0, 0)
	v_u_14.BackgroundTransparency = 1
	v_u_14.BorderSizePixel = 0
	v_u_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v_u_14.Parent = v_u_12
	local v_u_15 = Instance.new("Frame")
	v_u_15.Name = "PaddingCenter"
	v_u_15.LayoutOrder = 3
	v_u_15.ZIndex = 5
	v_u_15.Size = UDim2.new(0, 0, 1, 0)
	v_u_15.BorderColor3 = Color3.fromRGB(0, 0, 0)
	v_u_15.BackgroundTransparency = 1
	v_u_15.BorderSizePixel = 0
	v_u_15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v_u_15.Parent = v_u_12
	local v_u_16 = Instance.new("Frame")
	v_u_16.Name = "PaddingRight"
	v_u_16.LayoutOrder = 5
	v_u_16.ZIndex = 5
	v_u_16.BorderColor3 = Color3.fromRGB(0, 0, 0)
	v_u_16.BackgroundTransparency = 1
	v_u_16.BorderSizePixel = 0
	v_u_16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v_u_16.Parent = v_u_12
	local v_u_17 = Instance.new("Frame")
	v_u_17.Name = "IconLabelContainer"
	v_u_17.LayoutOrder = 4
	v_u_17.ZIndex = 3
	v_u_17.AnchorPoint = Vector2.new(0, 0.5)
	v_u_17.Size = UDim2.new(0, 0, 0.5, 0)
	v_u_17.BackgroundTransparency = 1
	v_u_17.Position = UDim2.new(0.5, 0, 0.5, 0)
	v_u_17.Parent = v_u_12
	local v_u_18 = Instance.new("TextLabel")
	local v_u_19 = workspace.CurrentCamera.ViewportSize.X + 200
	v_u_18.Name = "IconLabel"
	v_u_18.LayoutOrder = 4
	v_u_18.ZIndex = 15
	v_u_18.AnchorPoint = Vector2.new(0, 0)
	v_u_18.Size = UDim2.new(0, v_u_19, 1, 0)
	v_u_18.ClipsDescendants = false
	v_u_18.BackgroundTransparency = 1
	v_u_18.Position = UDim2.fromScale(0, 0)
	v_u_18.RichText = true
	v_u_18.TextColor3 = Color3.fromRGB(255, 255, 255)
	v_u_18.TextXAlignment = Enum.TextXAlignment.Left
	v_u_18.Text = ""
	v_u_18.TextWrapped = true
	v_u_18.TextWrap = true
	v_u_18.TextScaled = false
	v_u_18.Active = false
	v_u_18.AutoLocalize = true
	v_u_18.Parent = v_u_17
	local v_u_20 = Instance.new("ImageLabel")
	v_u_20.Name = "IconImage"
	v_u_20.LayoutOrder = 2
	v_u_20.ZIndex = 15
	v_u_20.AnchorPoint = Vector2.new(0, 0.5)
	v_u_20.Size = UDim2.new(0, 0, 0.5, 0)
	v_u_20.BackgroundTransparency = 1
	v_u_20.Position = UDim2.new(0, 11, 0.5, 0)
	v_u_20.ScaleType = Enum.ScaleType.Stretch
	v_u_20.Active = false
	v_u_20.Parent = v_u_12
	local v21 = v5:Clone()
	v21:SetAttribute("Collective", nil)
	v21.CornerRadius = UDim.new(0, 0)
	v21.Name = "IconImageCorner"
	v21.Parent = v_u_20
	local v_u_22 = game:GetService("TweenService")
	local v_u_23 = 0
	local function v61(_)
		-- upvalues: (copy) p_u_1, (copy) v_u_18, (copy) v_u_20, (copy) v_u_17, (copy) v_u_14, (copy) v_u_15, (copy) v_u_16, (copy) v_u_4, (copy) v_u_13, (copy) v_u_12, (copy) v_u_3, (copy) v_u_19, (copy) v_u_6, (copy) v_u_9, (copy) v_u_7, (copy) v_u_8, (copy) v_u_22, (copy) v_u_11, (ref) v_u_23, (copy) p_u_2
		task.defer(function()
			-- upvalues: (ref) p_u_1, (ref) v_u_18, (ref) v_u_20, (ref) v_u_17, (ref) v_u_14, (ref) v_u_15, (ref) v_u_16, (ref) v_u_4, (ref) v_u_13, (ref) v_u_12, (ref) v_u_3, (ref) v_u_19, (ref) v_u_6, (ref) v_u_9, (ref) v_u_7, (ref) v_u_8, (ref) v_u_22, (ref) v_u_11, (ref) v_u_23, (ref) p_u_2
			local v24 = p_u_1.indicator
			if v24 then
				v24 = v24.Visible
			end
			local v25 = v24 or v_u_18.Text ~= ""
			local v26
			if v_u_20.Image == "" then
				v26 = false
			else
				v26 = v_u_20.Image ~= nil
			end
			local _ = Enum.HorizontalAlignment.Center
			local v27 = UDim2.fromScale(1, 1)
			if v26 and not v25 then
				v_u_17.Visible = false
				v_u_20.Visible = true
				v_u_14.Visible = false
				v_u_15.Visible = false
				v_u_16.Visible = false
			elseif v26 or not v25 then
				if v26 and v25 then
					v_u_17.Visible = true
					v_u_20.Visible = true
					v_u_14.Visible = true
					v_u_15.Visible = not v24
					v_u_16.Visible = not v24
					local _ = Enum.HorizontalAlignment.Left
				end
			else
				v_u_17.Visible = true
				v_u_20.Visible = false
				v_u_14.Visible = true
				v_u_15.Visible = false
				v_u_16.Visible = true
			end
			v_u_4.Size = v27
			local v28 = v_u_13.Padding.Offset
			local v29 = v_u_18.TextBounds.X
			v_u_17.Size = UDim2.new(0, v29, v_u_18.Size.Y.Scale, 0)
			local v30 = v28
			for _, v31 in pairs(v_u_12:GetChildren()) do
				if v31:IsA("GuiObject") and v31.Visible == true then
					v30 = v30 + ((v31:GetAttribute("TargetWidth") or v31.AbsoluteSize.X) + v28)
				end
			end
			local v32 = v_u_3:GetAttribute("MinimumWidth")
			local v33 = v_u_3:GetAttribute("MinimumHeight")
			local v34 = v_u_3:GetAttribute("BorderSize")
			local v35 = v_u_19
			local v36 = math.clamp(v30, v32, v35)
			local v37 = 0
			local v38 = #p_u_1.menuIcons > 0
			if v38 then
				v38 = p_u_1.isSelected
			end
			if v38 then
				for _, v39 in pairs(v_u_6:GetChildren()) do
					if v39 ~= v_u_9 and (v39:IsA("GuiObject") and v39.Visible) then
						v37 = v37 + ((v39:GetAttribute("TargetWidth") or v39.AbsoluteSize.X) + v_u_7.Padding.Offset)
					end
				end
				if not v_u_9.Visible then
					local v40 = v_u_9
					v36 = v36 - ((v40:GetAttribute("TargetWidth") or v40.AbsoluteSize.X) + v_u_7.Padding.Offset * 2 + v34)
				end
				v37 = v37 - v34 * 0.5
				v36 = v36 + (v37 - v34 * 0.75)
			end
			local v41 = v_u_8
			if v38 then
				v38 = v_u_9.Visible
			end
			v41.Visible = v38
			local v42 = v_u_3:GetAttribute("DesiredWidth")
			if v42 then
				if v36 >= v42 then
					v42 = v36
				end
			else
				v42 = v36
			end
			p_u_1.updateMenu:Fire()
			local v43 = v42 - v37
			local v44 = math.max(v43, v32) - v34 * 2
			local v45 = v_u_6:GetAttribute("MenuWidth")
			if v45 then
				v45 = v45 + v44 + v_u_7.Padding.Offset + 10
			end
			if v45 then
				local v46 = v_u_6:GetAttribute("MaxWidth")
				if v46 then
					v45 = math.max(v46, v32)
				end
				v_u_6:SetAttribute("MenuCanvasWidth", v42)
				if v45 >= v42 then
					v45 = v42
				end
			else
				v45 = v42
			end
			local v47 = Enum.EasingStyle.Quint
			local v48 = Enum.EasingDirection.Out
			local v49 = v_u_9
			local v50 = v49:GetAttribute("TargetWidth") or v49.AbsoluteSize.X
			local v51 = v_u_9.AbsoluteSize.X
			local v52 = math.max(v44, v50, v51)
			local v53 = v_u_3
			local v54 = v53:GetAttribute("TargetWidth") or v53.AbsoluteSize.X
			local v55 = v_u_3.AbsoluteSize.X
			local v56 = math.max(v45, v54, v55)
			local v57 = TweenInfo.new(v52 / 750, v47, v48)
			local v58 = TweenInfo.new(v56 / 750, v47, v48)
			v_u_22:Create(v_u_9, v57, {
				["Position"] = UDim2.new(0, v34, 0.5, 0),
				["Size"] = UDim2.new(0, v44, 1, -v34 * 2)
			}):Play()
			v_u_22:Create(v_u_11, v57, {
				["Size"] = UDim2.new(0, v44, 1, 0)
			}):Play()
			local v59 = UDim2.fromOffset(v45, v33)
			if v_u_3.Size.Y.Offset ~= v33 then
				v_u_3.Size = v59
			end
			v_u_3:SetAttribute("TargetWidth", v59.X.Offset)
			v_u_22:Create(v_u_3, v58, {
				["Size"] = v59
			}):Play()
			v_u_23 = v_u_23 + 1
			for v60 = 1, v58.Time * 100 do
				task.delay(v60 / 100, function()
					-- upvalues: (ref) p_u_2, (ref) p_u_1
					p_u_2.iconChanged:Fire(p_u_1)
				end)
			end
			task.delay(v58.Time - 0.2, function()
				-- upvalues: (ref) v_u_23, (ref) p_u_1
				v_u_23 = v_u_23 - 1
				task.defer(function()
					-- upvalues: (ref) v_u_23, (ref) p_u_1
					if v_u_23 == 0 then
						p_u_1.resizingComplete:Fire()
					end
				end)
			end)
			p_u_1:updateParent()
		end)
	end
	local v_u_62 = require(script.Parent.Parent.Utility).createStagger(0.01, v61)
	local v_u_63 = true
	p_u_1:setBehaviour("IconLabel", "Text", v_u_62)
	p_u_1:setBehaviour("IconLabel", "FontFace", function(p64)
		-- upvalues: (copy) v_u_18, (copy) v_u_62, (ref) v_u_63
		if v_u_18.FontFace ~= p64 then
			task.spawn(function()
				-- upvalues: (ref) v_u_62, (ref) v_u_63
				v_u_62()
				if v_u_63 then
					v_u_63 = false
					for _ = 1, 10 do
						task.wait(1)
						v_u_62()
					end
				end
			end)
		end
	end)
	local function v68()
		-- upvalues: (copy) v_u_3, (copy) p_u_1, (copy) v_u_9, (copy) v_u_6, (copy) v_u_8, (copy) v_u_7, (copy) v_u_62
		task.defer(function()
			-- upvalues: (ref) v_u_3, (ref) p_u_1, (ref) v_u_9, (ref) v_u_6, (ref) v_u_8, (ref) v_u_7, (ref) v_u_62
			local v65 = v_u_3:GetAttribute("BorderSize")
			local v66 = p_u_1.alignment
			local v67
			if v_u_9.Visible == false then
				v67 = 0
			elseif v66 == "Right" then
				v67 = -v65 or v65
			else
				v67 = v65
			end
			v_u_6.Position = UDim2.new(0, v67, 0, 0)
			v_u_8.Size = UDim2.fromOffset(v65, 0)
			v_u_7.Padding = UDim.new(0, 0)
			v_u_62()
		end)
	end
	p_u_1:setBehaviour("Widget", "BorderSize", v68)
	p_u_1:setBehaviour("IconSpot", "Visible", v68)
	p_u_1.startMenuUpdate:Connect(v_u_62)
	p_u_1.updateSize:Connect(v_u_62)
	p_u_1:setBehaviour("ContentsList", "HorizontalAlignment", v_u_62)
	p_u_1:setBehaviour("Widget", "Visible", v_u_62)
	p_u_1:setBehaviour("Widget", "DesiredWidth", v_u_62)
	p_u_1:setBehaviour("Widget", "MinimumWidth", v_u_62)
	p_u_1:setBehaviour("Widget", "MinimumHeight", v_u_62)
	p_u_1:setBehaviour("Indicator", "Visible", v_u_62)
	p_u_1:setBehaviour("IconImageRatio", "AspectRatio", v_u_62)
	p_u_1:setBehaviour("IconImage", "Image", function(p69)
		-- upvalues: (copy) v_u_20, (copy) v_u_62
		local v70 = tonumber(p69) and "http://www.roblox.com/asset/?id=" .. p69 or (p69 or "")
		if v_u_20.Image ~= v70 then
			v_u_62()
		end
		return v70
	end)
	p_u_1.alignmentChanged:Connect(function(p71)
		-- upvalues: (copy) v_u_7, (copy) v_u_3, (copy) p_u_1, (copy) v_u_9, (copy) v_u_6, (copy) v_u_8, (copy) v_u_62
		local v72 = p71 == "Center" and "Left" or p71
		v_u_7.HorizontalAlignment = Enum.HorizontalAlignment[v72]
		task.defer(function()
			-- upvalues: (ref) v_u_3, (ref) p_u_1, (ref) v_u_9, (ref) v_u_6, (ref) v_u_8, (ref) v_u_7, (ref) v_u_62
			local v73 = v_u_3:GetAttribute("BorderSize")
			local v74 = p_u_1.alignment
			local v75
			if v_u_9.Visible == false then
				v75 = 0
			elseif v74 == "Right" then
				v75 = -v73 or v73
			else
				v75 = v73
			end
			v_u_6.Position = UDim2.new(0, v75, 0, 0)
			v_u_8.Size = UDim2.fromOffset(v73, 0)
			v_u_7.Padding = UDim.new(0, 0)
			v_u_62()
		end)
	end)
	local v_u_76 = Instance.new("NumberValue")
	v_u_76.Name = "IconImageScale"
	v_u_76.Parent = v_u_20
	v_u_76:GetPropertyChangedSignal("Value"):Connect(function()
		-- upvalues: (copy) v_u_20, (copy) v_u_76
		v_u_20.Size = UDim2.new(v_u_76.Value, 0, v_u_76.Value, 0)
	end)
	local v77 = Instance.new("UIAspectRatioConstraint")
	v77.Name = "IconImageRatio"
	v77.AspectType = Enum.AspectType.FitWithinMaxSize
	v77.DominantAxis = Enum.DominantAxis.Height
	v77.Parent = v_u_20
	local v78 = Instance.new("UIGradient")
	v78.Name = "IconGradient"
	v78.Enabled = true
	v78.Parent = v_u_4
	local v79 = Instance.new("UIGradient")
	v79.Name = "IconSpotGradient"
	v79.Enabled = true
	v79.Parent = v_u_9
	return v_u_3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Widget]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3312"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Features]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3313"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("GamepadService")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("GuiService")
local v_u_4 = {}
local v_u_5 = nil
function v_u_4.start(p6)
	-- upvalues: (ref) v_u_5, (copy) v_u_3, (copy) v_u_2, (copy) v_u_4, (copy) v_u_1
	v_u_5 = p6
	v_u_5.highlightKey = Enum.KeyCode.DPadUp
	v_u_5.highlightIcon = false
	task.delay(1, function()
		-- upvalues: (ref) v_u_5, (ref) v_u_3, (ref) v_u_2, (ref) v_u_4, (ref) v_u_1
		local v_u_7 = v_u_5.iconsDictionary
		local v_u_8 = nil
		local v_u_9 = false
		local v_u_10 = false
		require(script.Parent.Parent.Utility)
		local v_u_11 = require(script.Parent.Parent.Elements.Selection)
		local function v_u_18()
			-- upvalues: (ref) v_u_3, (copy) v_u_7, (ref) v_u_2, (copy) v_u_11, (ref) v_u_5, (ref) v_u_8, (ref) v_u_10, (ref) v_u_9, (ref) v_u_4
			local v12 = v_u_3.SelectedObject
			if v12 then
				v12 = v12:GetAttribute("CorrespondingIconUID")
			end
			if v12 then
				v12 = v_u_7[v12]
			end
			local v13 = v_u_2.GamepadEnabled
			if v12 then
				if v13 then
					local v14 = v12:getInstance("ClickRegion")
					local v15 = v12.selection
					if not v15 then
						v15 = v12.janitor:add(v_u_11(v_u_5))
						v15:SetAttribute("IgnoreVisibilityUpdater", true)
						v15.Parent = v12.widget
						v12.selection = v15
						v12:refreshAppearance(v15)
					end
					v14.SelectionImageObject = v15.Selection
				end
				if v_u_8 and v_u_8 ~= v12 then
					v_u_8:setIndicator()
				end
				local v16
				if v13 and not (v_u_10 or v12.parentIconUID) then
					v16 = Enum.KeyCode.ButtonB
				else
					v16 = nil
				end
				v_u_8 = v12
				v_u_5.lastHighlightedIcon = v12
				v12:setIndicator(v16)
			else
				local v17
				if v13 and not v_u_9 then
					v17 = v_u_5.highlightKey
				else
					v17 = nil
				end
				if not v_u_8 then
					v_u_8 = v_u_4.getIconToHighlight()
				end
				if v17 == v_u_5.highlightKey then
					v_u_9 = true
				end
				if v_u_8 then
					v_u_8:setIndicator(v17)
				end
			end
		end
		v_u_3:GetPropertyChangedSignal("SelectedObject"):Connect(v_u_18)
		local function v19()
			-- upvalues: (ref) v_u_2, (ref) v_u_9, (ref) v_u_10, (copy) v_u_18
			if not v_u_2.GamepadEnabled then
				v_u_9 = false
				v_u_10 = false
			end
			v_u_18()
		end
		v_u_2:GetPropertyChangedSignal("GamepadEnabled"):Connect(v19)
		if not v_u_2.GamepadEnabled then
			v_u_9 = false
			v_u_10 = false
		end
		v_u_18()
		v_u_2.InputBegan:Connect(function(p20, _)
			-- upvalues: (ref) v_u_3, (copy) v_u_7, (ref) v_u_5, (ref) v_u_4, (ref) v_u_1
			if p20.UserInputType == Enum.UserInputType.MouseButton1 then
				local v21 = v_u_3.SelectedObject
				if v21 then
					v21 = v21:GetAttribute("CorrespondingIconUID")
				end
				if v21 then
					v21 = v_u_7[v21]
				end
				if v21 then
					v_u_3.SelectedObject = nil
				end
				return
			elseif p20.KeyCode == v_u_5.highlightKey then
				local v22 = v_u_4.getIconToHighlight()
				if v22 then
					if v_u_1.GamepadCursorEnabled then
						task.wait(0.2)
						v_u_1:DisableGamepadCursor()
					end
					v_u_3.SelectedObject = v22:getInstance("ClickRegion")
				end
			end
		end)
	end)
end
function v_u_4.getIconToHighlight()
	-- upvalues: (ref) v_u_5
	local v23 = v_u_5.iconsDictionary
	local v24 = v_u_5.highlightIcon or v_u_5.lastHighlightedIcon
	if not v24 then
		local v25 = nil
		for _, v26 in pairs(v23) do
			if not v26.parentIconUID and (not v25 or v26.widget.AbsolutePosition.X < v25) then
				v25 = v26.widget.AbsolutePosition.X
				v24 = v26
			end
		end
	end
	return v24
end
function v_u_4.registerButton(p_u_27)
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_3
	local v_u_28 = false
	p_u_27.InputBegan:Connect(function(_)
		-- upvalues: (ref) v_u_28
		v_u_28 = true
		task.wait()
		task.wait()
		v_u_28 = false
	end)
	local v_u_32 = v_u_2.InputBegan:Connect(function(p29)
		-- upvalues: (ref) v_u_28, (ref) v_u_1, (ref) v_u_3, (copy) p_u_27
		task.wait()
		if p29.KeyCode == Enum.KeyCode.ButtonA and v_u_28 then
			task.wait(0.2)
			v_u_1:DisableGamepadCursor()
			v_u_3.SelectedObject = p_u_27
		else
			local v30 = v_u_3.SelectedObject == p_u_27
			local v31 = p29.KeyCode.Name
			if table.find({ "ButtonB", "ButtonSelect" }, v31) and (v30 and (v31 ~= "ButtonSelect" or v_u_1.GamepadCursorEnabled)) then
				v_u_3.SelectedObject = nil
			end
		end
	end)
	p_u_27.Destroying:Once(function()
		-- upvalues: (copy) v_u_32
		v_u_32:Disconnect()
	end)
end
return v_u_4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Gamepad]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3314"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
local v_u_2 = {}
local v_u_3 = {}
local v_u_4 = nil
local v_u_5 = workspace.CurrentCamera
local v_u_6 = {}
local v_u_7 = {}
local v_u_8 = require(script.Parent.Parent.Utility)
local v_u_9 = nil
function v_u_1.start(p10)
	-- upvalues: (ref) v_u_9, (ref) v_u_4, (copy) v_u_2, (copy) v_u_8, (copy) v_u_1, (copy) v_u_5
	v_u_9 = p10
	v_u_4 = v_u_9.iconsDictionary
	local v11 = nil
	for _, v12 in pairs(v_u_9.container) do
		if v11 == nil then
			if v12.ScreenInsets == Enum.ScreenInsets.TopbarSafeInsets then
				v11 = v12
			end
		end
		for _, v13 in pairs(v12.Holders:GetChildren()) do
			if v13:GetAttribute("IsAHolder") then
				v_u_2[v13.Name] = v13
			end
		end
	end
	local v_u_14 = false
	local v_u_16 = v_u_8.createStagger(0.1, function(p15)
		-- upvalues: (ref) v_u_14, (ref) v_u_1
		if v_u_14 then
			if not p15 then
				v_u_1.updateAvailableIcons("Center")
			end
			v_u_1.updateBoundary("Left")
			v_u_1.updateBoundary("Right")
		end
	end)
	task.delay(1, function()
		-- upvalues: (ref) v_u_14, (copy) v_u_16
		v_u_14 = true
		v_u_16()
	end)
	v_u_9.iconAdded:Connect(v_u_16)
	v_u_9.iconRemoved:Connect(v_u_16)
	v_u_9.iconChanged:Connect(v_u_16)
	v_u_5:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		-- upvalues: (copy) v_u_16
		v_u_16(true)
	end)
	v11:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) v_u_16
		v_u_16(true)
	end)
end
function v_u_1.getWidth(p17, _)
	local v18 = p17.widget
	return v18:GetAttribute("TargetWidth") or v18.AbsoluteSize.X
end
function v_u_1.getAvailableIcons(p19)
	-- upvalues: (copy) v_u_3, (copy) v_u_1
	return v_u_3[p19] or v_u_1.updateAvailableIcons(p19)
end
function v_u_1.updateAvailableIcons(p20)
	-- upvalues: (copy) v_u_2, (ref) v_u_4, (copy) v_u_7, (copy) v_u_3
	local _ = v_u_2[p20].UIListLayout
	local v21 = {}
	local v22 = 0
	for _, v23 in pairs(v_u_4) do
		local v24 = v23.parentIconUID
		local v25 = not v24 or v_u_7[v24]
		local v26 = v_u_7[v23.UID]
		if v25 and (v23.alignment == p20 and not v26) then
			table.insert(v21, v23)
			v22 = v22 + 1
		end
	end
	if v22 <= 0 then
		return {}
	end
	table.sort(v21, function(p27, p28)
		local v29 = p27.widget.LayoutOrder
		local v30 = p28.widget.LayoutOrder
		local v31 = p27.parentIconUID
		local v32 = p28.parentIconUID
		if v31 == v32 then
			if v29 < v30 then
				return true
			elseif v30 < v29 then
				return false
			else
				return p27.widget.AbsolutePosition.X < p28.widget.AbsolutePosition.X
			end
		else
			if v32 then
				return false
			end
			if v31 then
				return true
			end
			return
		end
	end)
	v_u_3[p20] = v21
	return v21
end
function v_u_1.getRealXPositions(p33, p34)
	-- upvalues: (copy) v_u_2, (copy) v_u_8, (copy) v_u_1
	local v35 = p33 == "Left"
	local v36 = v_u_2[p33]
	local v37 = v36.AbsolutePosition.X
	local v38 = v36.AbsoluteSize.X
	local v39 = v36.UIListLayout.Padding.Offset
	local v40 = v35 and v37 and v37 or v37 + v38
	local v41 = {}
	if v35 then
		v_u_8.reverseTable(p34)
	end
	for v42 = #p34, 1, -1 do
		local v43 = p34[v42]
		local v44 = v_u_1.getWidth(v43)
		if not v35 then
			v40 = v40 - v44
		end
		v41[v43.UID] = v40
		if v35 then
			v40 = v40 + v44
		end
		v40 = v40 + (v35 and v39 and v39 or -v39)
	end
	return v41
end
function v_u_1.updateBoundary(p45)
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_6, (ref) v_u_9, (copy) v_u_7, (copy) v_u_8
	local v46 = v_u_2[p45]
	local v47 = v46.UIListLayout
	local v48 = v46.AbsolutePosition.X
	local v49 = v46.AbsoluteSize.X
	local v50 = v47.Padding.Offset
	local v51 = v47.Padding.Offset
	local v52 = v_u_1.updateAvailableIcons(p45)
	local v53 = 0
	local v54 = 0
	for _, v55 in pairs(v52) do
		v53 = v53 + (v_u_1.getWidth(v55) + v51)
		v54 = v54 + 1
	end
	if v54 > 0 then
		local v56 = p45 == "Central"
		local v57 = p45 == "Left"
		local v58 = not v57
		local v59 = v_u_6[p45]
		if not v59 and (not v56 and #v52 > 0) then
			v59 = v_u_9.new()
			v59:setImage(6069276526, "Deselected")
			v59:setName("Overflow" .. p45)
			v59:setOrder(v57 and -9999999 or 9999999)
			v59:setAlignment(p45)
			v59:autoDeselect(false)
			v59.isAnOverflow = true
			v59:select("OverflowStart", v59)
			v59:setEnabled(false)
			v_u_6[p45] = v59
			v_u_7[v59.UID] = true
		end
		local v60 = p45 == "Left" and "Right" or "Left"
		local v61 = v_u_1.updateAvailableIcons(v60)
		local v62 = v57 and v61[1]
		if not v62 then
			if v58 then
				v62 = v61[#v61]
			else
				v62 = v58
			end
		end
		local v63 = v_u_6[v60]
		local v64
		if v57 then
			v64 = v48 + v49 or v48
		else
			v64 = v48
		end
		if v62 then
			local _ = v62.widget
			local v65 = v_u_1.getRealXPositions(v60, v61)[v62.UID]
			local v66 = v_u_1.getWidth(v62)
			v64 = v57 and v65 - v50 or v65 + v66 + v50
		end
		local v67 = v_u_1.getAvailableIcons("Center")
		local v68 = v67[v57 and 1 or #v67]
		if v68 and not v68.hasRelocatedInOverflow then
			local v69 = v57 and v52[#v52]
			if not v69 then
				if v58 then
					v69 = v52[1]
				else
					v69 = v58
				end
			end
			local v70 = v68.widget.AbsolutePosition.X
			local v71 = v69.widget.AbsolutePosition.X
			local v72 = v_u_1.getWidth(v69)
			local v73 = v57 and v70 - v50 or v70 + v_u_1.getWidth(v68) + v50
			if v57 then
				v71 = v71 + v72 or v71
			end
			if v57 then
				if v73 < v71 then
					v68:align("Left")
					v68.hasRelocatedInOverflow = true
				end
			elseif v58 and v71 < v73 then
				v68:align("Right")
				v68.hasRelocatedInOverflow = true
			end
		end
		if v59 then
			local v74 = v59:getInstance("Menu")
			local v75 = v48 + v49
			if v74 and v63 then
				local v76 = v63.widget.AbsolutePosition.X
				local v77 = v_u_1.getWidth(v63)
				local v78 = v57 and v76 - v50 or v76 + v77 + v50
				local v79 = v63:getInstance("Menu")
				local v80 = v74.AbsoluteCanvasSize.X >= v79.AbsoluteCanvasSize.X
				local v81 = v48 + v49 / 2
				local v82 = v57 and v81 - v50 / 2 or v81 + v50 / 2
				if v80 then
					v82 = v78
				end
				v49 = v57 and v82 - v48 or v75 - v82
			end
			local v83
			if v74 then
				v83 = v74:GetAttribute("MaxWidth")
			else
				v83 = v74
			end
			local v84 = v_u_8.round(v49)
			if v74 and v83 ~= v84 then
				v74:SetAttribute("MaxWidth", v84)
			end
		end
		local v85 = v_u_1.getRealXPositions(p45, v52)
		local v86 = false
		for v87 = #v52, 1, -1 do
			local v88 = v52[v87]
			local v89 = v_u_1.getWidth(v88)
			local v90 = v85[v88.UID]
			if v57 and v64 <= v90 + v89 or v58 and v90 <= v64 then
				v86 = true
			end
		end
		for v91 = #v52, 1, -1 do
			local v92 = v52[v91]
			if not v_u_7[v92.UID] then
				if v86 and not v92.parentIconUID then
					v92:joinMenu(v59)
				elseif not v86 and v92.parentIconUID then
					v92:leave()
				end
			end
		end
		if v59.isEnabled ~= v86 then
			v59:setEnabled(v86)
		end
		if v59.isEnabled and not v59.overflowAlreadyOpened then
			v59.overflowAlreadyOpened = true
			v59:select()
		end
	end
end
return v_u_1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Overflow]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3315"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
local v_u_2 = require(script.Parent.Parent.Utility)
local v_u_3 = require(script.Default)
function v_u_1.getThemeValue(p4, p5, p6, _)
	if p4 then
		for _, v7 in pairs(p4) do
			local v8, v9, v10 = unpack(v7)
			if p5 == v8 and p6 == v9 then
				return v10
			end
		end
	end
end
function v_u_1.getInstanceValue(p_u_11, p_u_12)
	local v13, v14 = pcall(function()
		-- upvalues: (copy) p_u_11, (copy) p_u_12
		return p_u_11[p_u_12]
	end)
	if not v13 then
		v14 = p_u_11:GetAttribute(p_u_12)
	end
	return v14
end
function v_u_1.getRealInstance(p15)
	if p15:GetAttribute("IsAClippedClone") then
		local v16 = p15:FindFirstChild("OriginalInstance")
		if v16 then
			return v16.Value
		end
	end
end
function v_u_1.getClippedClone(p17)
	if p17:GetAttribute("HasAClippedClone") then
		local v18 = p17:FindFirstChild("ClippedClone")
		if v18 then
			return v18.Value
		end
	end
end
function v_u_1.refresh(p19, p20, p21)
	-- upvalues: (copy) v_u_1
	if p21 then
		local v22 = p19:getStateGroup()
		local v23 = v_u_1.getThemeValue(v22, p20.Name, p21) or v_u_1.getInstanceValue(p20, p21)
		v_u_1.apply(p19, p20, p21, v23, true)
		return
	else
		local v24 = p19:getStateGroup()
		if v24 then
			local v25 = {
				[p20.Name] = p20
			}
			for _, v26 in pairs(p20:GetDescendants()) do
				local v27 = v26:GetAttribute("Collective")
				if v27 then
					v25[v27] = v26
				end
				v25[v26.Name] = v26
			end
			for _, v28 in pairs(v24) do
				local v29, v30, v31 = unpack(v28)
				local v32 = v25[v29]
				if v32 then
					v_u_1.apply(p19, v32.Name, v30, v31, true)
				end
			end
		end
	end
end
function v_u_1.apply(p33, p34, p_u_35, p36, p37)
	-- upvalues: (copy) v_u_1
	if not p33.isDestroyed then
		local v38
		if typeof(p34) == "Instance" then
			local v39 = p34.Name
			p34 = v39
			v38 = { p34 }
		else
			v38 = p33:getInstanceOrCollective(p34)
		end
		local v40 = p34 .. "-" .. p_u_35
		local v41 = p33.customBehaviours[v40]
		for _, v42 in pairs(v38) do
			local v43 = v_u_1.getClippedClone(v42)
			if v43 then
				table.insert(v38, v43)
			end
		end
		for _, v_u_44 in pairs(v38) do
			if p_u_35 ~= "Position" or not v_u_1.getClippedClone(v_u_44) then
				if (p_u_35 ~= "Size" or not v_u_1.getRealInstance(v_u_44)) and (p37 or p36 ~= v_u_1.getInstanceValue(v_u_44, p_u_35)) then
					local v_u_45
					if v41 then
						v_u_45 = v41(p36, v_u_44, p_u_35)
						if v_u_45 == nil then
							v_u_45 = p36
						end
					else
						v_u_45 = p36
					end
					if not pcall(function()
						-- upvalues: (copy) v_u_44, (copy) p_u_35, (ref) v_u_45
						v_u_44[p_u_35] = v_u_45
					end) then
						v_u_44:SetAttribute(p_u_35, v_u_45)
					end
				end
			end
		end
	end
end
function v_u_1.getModifications(p46)
	local v47 = p46[1]
	return typeof(v47) ~= "table" and { p46 } or p46
end
function v_u_1.merge(p48, p49, p50)
	-- upvalues: (copy) v_u_1
	local v51, v52, v53, v54 = table.unpack(p49)
	local v55, v56, _, v57 = table.unpack(p48)
	if v51 ~= v55 or (v52 ~= v56 or not v_u_1.statesMatch(v54, v57)) then
		return false
	end
	p48[3] = v53
	if p50 then
		p50(p48)
	end
	return true
end
function v_u_1.modify(p_u_58, p_u_59, p_u_60)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	task.spawn(function()
		-- upvalues: (ref) p_u_60, (ref) v_u_2, (ref) p_u_59, (ref) v_u_1, (copy) p_u_58
		p_u_60 = p_u_60 or v_u_2.generateUID()
		p_u_59 = v_u_1.getModifications(p_u_59)
		for _, v_u_61 in pairs(p_u_59) do
			local v_u_62, v_u_63, v_u_64, v65 = table.unpack(v_u_61)
			if v65 == nil then
				v_u_1.modify(p_u_58, {
					v_u_62,
					v_u_63,
					v_u_64,
					"Selected"
				}, p_u_60)
				v_u_1.modify(p_u_58, {
					v_u_62,
					v_u_63,
					v_u_64,
					"Viewing"
				}, p_u_60)
			end
			local v_u_66 = v_u_2.formatStateName(v65 or "Deselected")
			local v_u_67 = p_u_58:getStateGroup(v_u_66);
			(function()
				-- upvalues: (copy) v_u_67, (ref) v_u_1, (copy) v_u_61, (ref) p_u_60, (copy) v_u_66, (ref) p_u_58, (copy) v_u_62, (copy) v_u_63, (copy) v_u_64
				for _, v68 in pairs(v_u_67) do
					if v_u_1.merge(v68, v_u_61, function(p69)
						-- upvalues: (ref) p_u_60, (ref) v_u_66, (ref) p_u_58, (ref) v_u_1, (ref) v_u_62, (ref) v_u_63, (ref) v_u_64
						p69[5] = p_u_60
						if v_u_66 == p_u_58.activeState then
							v_u_1.apply(p_u_58, v_u_62, v_u_63, v_u_64)
						end
					end) then
						return
					end
				end
				local v70 = {
					v_u_62,
					v_u_63,
					v_u_64,
					v_u_66,
					p_u_60
				}
				local v71 = v_u_67
				table.insert(v71, v70)
				if v_u_66 == p_u_58.activeState then
					v_u_1.apply(p_u_58, v_u_62, v_u_63, v_u_64)
				end
			end)()
		end
	end)
	return p_u_60
end
function v_u_1.remove(p72, p73)
	-- upvalues: (copy) v_u_1
	for _, v74 in pairs(p72.appearance) do
		for v75 = #v74, 1, -1 do
			if v74[v75][5] == p73 then
				table.remove(v74, v75)
			end
		end
	end
	v_u_1.rebuild(p72)
end
function v_u_1.removeWith(p76, p77, p78, p79)
	-- upvalues: (copy) v_u_1
	for v80, v81 in pairs(p76.appearance) do
		if p79 == v80 or not p79 then
			for v82 = #v81, 1, -1 do
				local v83 = v81[v82]
				local v84 = v83[1]
				local v85 = v83[2]
				if v84 == p77 and v85 == p78 then
					table.remove(v81, v82)
				end
			end
		end
	end
	v_u_1.rebuild(p76)
end
function v_u_1.change(p86)
	-- upvalues: (copy) v_u_1
	local v87 = p86:getStateGroup()
	for _, v88 in pairs(v87) do
		local v89, v90, v91 = unpack(v88)
		v_u_1.apply(p86, v89, v90, v91)
	end
end
function v_u_1.set(p_u_92, p93)
	-- upvalues: (copy) v_u_1
	local v94 = p_u_92.themesJanitor
	v94:clean()
	v94:add(p_u_92.stateChanged:Connect(function()
		-- upvalues: (ref) v_u_1, (copy) p_u_92
		v_u_1.change(p_u_92)
	end))
	if typeof(p93) == "Instance" and p93:IsA("ModuleScript") then
		p93 = require(p93)
	end
	p_u_92.appliedTheme = p93
	v_u_1.rebuild(p_u_92)
end
function v_u_1.statesMatch(p95, p96)
	local v97
	if p95 then
		v97 = string.lower(p95)
	else
		v97 = p95
	end
	local v98
	if p96 then
		v98 = string.lower(p96)
	else
		v98 = p96
	end
	return v97 == v98 or not p95 or not p96
end
function v_u_1.rebuild(p_u_99)
	-- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_3
	local v_u_100 = p_u_99.appliedTheme
	local v_u_101 = { "Deselected", "Selected", "Viewing" }
	(function()
		-- upvalues: (copy) v_u_101, (ref) v_u_1, (ref) v_u_2, (ref) v_u_3, (copy) v_u_100, (copy) p_u_99
		for _, v102 in pairs(v_u_101) do
			local v_u_103 = {}
			local function v111(p104, p105)
				-- upvalues: (ref) v_u_1, (ref) v_u_2, (copy) v_u_103
				if p104 then
					for _, v106 in pairs(p104) do
						local v107 = v106[5]
						local v108 = v106[4]
						if v_u_1.statesMatch(p105, v108) then
							local v109 = v106[1] .. "-" .. v106[2]
							local v110 = v_u_2.copyTable(v106)
							v110[5] = v107
							v_u_103[v109] = v110
						end
					end
				end
			end
			if v102 == "Selected" then
				v111(v_u_3, "Deselected")
			end
			v111(v_u_3, "Empty")
			v111(v_u_3, v102)
			if v_u_100 ~= v_u_3 then
				if v102 == "Selected" then
					v111(v_u_100, "Deselected")
				end
				v111(v_u_3, "Empty")
				v111(v_u_100, v102)
			end
			local v112 = {}
			local v113 = p_u_99.appearance[v102]
			if v113 then
				for _, v114 in pairs(v113) do
					local v115 = v114[5]
					if v115 ~= nil then
						local v116 = {
							v114[1],
							v114[2],
							v114[3],
							v102,
							v115
						}
						table.insert(v112, v116)
					end
				end
			end
			v111(v112, v102)
			local v117 = {}
			for _, v118 in pairs(v_u_103) do
				table.insert(v117, v118)
			end
			p_u_99.appearance[v102] = v117
		end
		v_u_1.change(p_u_99)
	end)()
end
return v_u_1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Themes]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3316"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	{ "Selection", "Size", UDim2.new(1, -6, 1, -5) },
	{ "Selection", "Position", UDim2.new(0, 3, 0, 3) },
	{
		"Widget",
		"MinimumWidth",
		32,
		"Deselected"
	},
	{
		"Widget",
		"MinimumHeight",
		32,
		"Deselected"
	},
	{
		"Widget",
		"BorderSize",
		0,
		"Deselected"
	},
	{
		"IconCorners",
		"CornerRadius",
		UDim.new(0, 9),
		"Deselected"
	},
	{
		"IconButton",
		"BackgroundTransparency",
		0.5,
		"Deselected"
	},
	{
		"IconLabel",
		"TextSize",
		14,
		"Deselected"
	},
	{
		"Dropdown",
		"BackgroundTransparency",
		0.5,
		"Deselected"
	},
	{
		"Notice",
		"Position",
		UDim2.new(1, -12, 0, -3),
		"Deselected"
	},
	{
		"Notice",
		"Size",
		UDim2.new(0, 15, 0, 15),
		"Deselected"
	},
	{
		"NoticeLabel",
		"TextSize",
		11,
		"Deselected"
	},
	{
		"IconSpot",
		"BackgroundColor3",
		Color3.fromRGB(0, 0, 0),
		"Selected"
	},
	{
		"IconSpot",
		"BackgroundTransparency",
		0.702,
		"Selected"
	},
	{
		"IconSpotGradient",
		"Enabled",
		false,
		"Selected"
	},
	{
		"IconOverlay",
		"BackgroundTransparency",
		0.97,
		"Selected"
	}
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Classic]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3317"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	{ "IconCorners", "CornerRadius", UDim.new(1, 0) },
	{ "Selection", "RotationSpeed", 1 },
	{ "Selection", "Size", UDim2.new(1, 0, 1, 1) },
	{ "Selection", "Position", UDim2.new(0, 0, 0, 0) },
	{ "SelectionGradient", "Color", ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(86, 86, 86)) }) },
	{
		"IconImage",
		"Image",
		"",
		"Deselected"
	},
	{
		"IconLabel",
		"Text",
		"",
		"Deselected"
	},
	{
		"IconLabel",
		"Position",
		UDim2.fromOffset(0, 0),
		"Deselected"
	},
	{
		"Widget",
		"MinimumWidth",
		44,
		"Deselected"
	},
	{
		"Widget",
		"MinimumHeight",
		44,
		"Deselected"
	},
	{
		"Widget",
		"BorderSize",
		4,
		"Deselected"
	},
	{
		"IconButton",
		"BackgroundColor3",
		Color3.fromRGB(0, 0, 0),
		"Deselected"
	},
	{
		"IconButton",
		"BackgroundTransparency",
		0.3,
		"Deselected"
	},
	{
		"IconImageScale",
		"Value",
		0.5,
		"Deselected"
	},
	{
		"IconImageCorner",
		"CornerRadius",
		UDim.new(0, 0),
		"Deselected"
	},
	{
		"IconImage",
		"ImageColor3",
		Color3.fromRGB(255, 255, 255),
		"Deselected"
	},
	{
		"IconImage",
		"ImageTransparency",
		0,
		"Deselected"
	},
	{
		"IconLabel",
		"FontFace",
		Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
		"Deselected"
	},
	{
		"IconLabel",
		"TextSize",
		16,
		"Deselected"
	},
	{
		"IconSpot",
		"BackgroundTransparency",
		1,
		"Deselected"
	},
	{
		"IconOverlay",
		"BackgroundTransparency",
		0.925,
		"Deselected"
	},
	{
		"IconSpotGradient",
		"Enabled",
		false,
		"Deselected"
	},
	{
		"IconGradient",
		"Enabled",
		false,
		"Deselected"
	},
	{
		"ClickRegion",
		"Active",
		true,
		"Deselected"
	},
	{
		"Menu",
		"Active",
		false,
		"Deselected"
	},
	{
		"ContentsList",
		"HorizontalAlignment",
		Enum.HorizontalAlignment.Center,
		"Deselected"
	},
	{
		"Dropdown",
		"BackgroundColor3",
		Color3.fromRGB(0, 0, 0),
		"Deselected"
	},
	{
		"Dropdown",
		"BackgroundTransparency",
		0.3,
		"Deselected"
	},
	{
		"Dropdown",
		"MaxIcons",
		4,
		"Deselected"
	},
	{
		"Menu",
		"MaxIcons",
		4,
		"Deselected"
	},
	{
		"Notice",
		"Position",
		UDim2.new(1, -12, 0, -1),
		"Deselected"
	},
	{
		"Notice",
		"Size",
		UDim2.new(0, 20, 0, 20),
		"Deselected"
	},
	{
		"NoticeLabel",
		"TextSize",
		13,
		"Deselected"
	},
	{
		"PaddingLeft",
		"Size",
		UDim2.new(0, 9, 1, 0),
		"Deselected"
	},
	{
		"PaddingRight",
		"Size",
		UDim2.new(0, 11, 1, 0),
		"Deselected"
	},
	{
		"IconSpot",
		"BackgroundTransparency",
		0.7,
		"Selected"
	},
	{
		"IconSpot",
		"BackgroundColor3",
		Color3.fromRGB(255, 255, 255),
		"Selected"
	},
	{
		"IconSpotGradient",
		"Enabled",
		true,
		"Selected"
	},
	{
		"IconSpotGradient",
		"Rotation",
		45,
		"Selected"
	},
	{
		"IconSpotGradient",
		"Color",
		ColorSequence.new(Color3.fromRGB(96, 98, 100), Color3.fromRGB(77, 78, 80)),
		"Selected"
	}
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Default]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3318"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Packages]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3319"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = nil
local function v_u_4(p2, ...)
	-- upvalues: (ref) v_u_1
	local v3 = v_u_1
	v_u_1 = nil
	p2(...)
	v_u_1 = v3
end
local function v_u_5()
	-- upvalues: (copy) v_u_4
	while true do
		v_u_4(coroutine.yield())
	end
end
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6.new(p7, p8)
	-- upvalues: (copy) v_u_6
	local v9 = v_u_6
	return setmetatable({
		["_connected"] = true,
		["_signal"] = p7,
		["_fn"] = p8,
		["_next"] = false
	}, v9)
end
function v_u_6.Disconnect(p10)
	p10._connected = false
	if p10._signal._handlerListHead == p10 then
		p10._signal._handlerListHead = p10._next
	else
		local v11 = p10._signal._handlerListHead
		while v11 and v11._next ~= p10 do
			v11 = v11._next
		end
		if v11 then
			v11._next = p10._next
		end
	end
end
v_u_6.Destroy = v_u_6.Disconnect
setmetatable(v_u_6, {
	["__index"] = function(_, p12)
		error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p12))), 2)
	end,
	["__newindex"] = function(_, p13, _)
		error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p13))), 2)
	end
})
local v_u_14 = {}
v_u_14.__index = v_u_14
function v_u_14.new()
	-- upvalues: (copy) v_u_14
	local v15 = v_u_14
	return setmetatable({
		["_handlerListHead"] = false
	}, v15)
end
function v_u_14.Connect(p16, p17)
	-- upvalues: (copy) v_u_6
	local v18 = v_u_6.new(p16, p17)
	if not p16._handlerListHead then
		p16._handlerListHead = v18
		return v18
	end
	v18._next = p16._handlerListHead
	p16._handlerListHead = v18
	return v18
end
function v_u_14.DisconnectAll(p19)
	p19._handlerListHead = false
end
v_u_14.Destroy = v_u_14.DisconnectAll
function v_u_14.Fire(p20, ...)
	-- upvalues: (ref) v_u_1, (copy) v_u_5
	local v21 = p20._handlerListHead
	while v21 do
		if v21._connected then
			if not v_u_1 then
				v_u_1 = coroutine.create(v_u_5)
				coroutine.resume(v_u_1)
			end
			task.spawn(v_u_1, v21._fn, ...)
		end
		v21 = v21._next
	end
end
function v_u_14.Wait(p22)
	local v_u_23 = coroutine.running()
	local v_u_24 = nil
	v_u_24 = p22:Connect(function(...)
		-- upvalues: (ref) v_u_24, (copy) v_u_23
		v_u_24:Disconnect()
		task.spawn(v_u_23, ...)
	end)
	return coroutine.yield()
end
function v_u_14.Once(p25, p_u_26)
	local v_u_27 = nil
	v_u_27 = p25:Connect(function(...)
		-- upvalues: (ref) v_u_27, (copy) p_u_26
		if v_u_27._connected then
			v_u_27:Disconnect()
		end
		p_u_26(...)
	end)
	return v_u_27
end
setmetatable(v_u_14, {
	["__index"] = function(_, p28)
		error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p28))), 2)
	end,
	["__newindex"] = function(_, p29, _)
		error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p29))), 2)
	end
})
return v_u_14]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GoodSignal]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3320"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("RunService")
local v_u_2 = v_u_1.Heartbeat
local v_u_3 = newproxy(true)
getmetatable(v_u_3).__tostring = function()
	return "IndicesReference"
end
local v_u_4 = newproxy(true)
getmetatable(v_u_4).__tostring = function()
	return "LinkToInstanceIndex"
end
local v_u_5 = {
	["IGNORE_MEMORY_DEBUG"] = true,
	["ClassName"] = "Janitor",
	["__index"] = {
		["CurrentlyCleaning"] = true,
		[v_u_3] = nil
	}
}
local v_u_6 = {
	["function"] = true,
	["Promise"] = "cancel",
	["RBXScriptConnection"] = "Disconnect"
}
function v_u_5.new()
	-- upvalues: (copy) v_u_3, (copy) v_u_5
	local v7 = {
		["CurrentlyCleaning"] = false,
		[v_u_3] = nil
	}
	local v8 = v_u_5
	return setmetatable(v7, v8)
end
function v_u_5.Is(p9)
	-- upvalues: (copy) v_u_5
	local v10
	if type(p9) == "table" then
		v10 = getmetatable(p9) == v_u_5
	else
		v10 = false
	end
	return v10
end
v_u_5.is = v_u_5.Is
function v_u_5.__index.Add(p11, p12, p13, p14)
	-- upvalues: (copy) v_u_3, (copy) v_u_6
	if p14 then
		p11:Remove(p14)
		local v15 = p11[v_u_3]
		if not v15 then
			v15 = {}
			p11[v_u_3] = v15
		end
		v15[p14] = p12
	end
	local v16 = typeof(p12)
	local v17 = p13 or (v_u_6[v16 == "table" and string.match(tostring(p12), "Promise") and "Promise" or v16] or "Destroy")
	if type(p12) ~= "function" and not p12[v17] then
		warn(string.format("Object %s doesn\'t have method %s, are you sure you want to add it? Traceback: %s", tostring(p12), tostring(v17), debug.traceback(nil, 2)))
	end
	p11[p12] = { v17, (debug.traceback("")) }
	return p12
end
v_u_5.__index.Give = v_u_5.__index.Add
function v_u_5.__index.AddPromise(p18, p_u_19)
	-- upvalues: (copy) v_u_1
	local v20
	if v_u_1:IsRunning() then
		v20 = require(game:GetService("ReplicatedStorage").Framework).modules.Promise
	else
		v20 = nil
	end
	if not v20 then
		return p_u_19
	end
	if not v20.is(p_u_19) then
		error(string.format("Invalid argument #1 to \'Janitor:AddPromise\' (Promise expected, got %s (%s))", typeof(p_u_19), (tostring(p_u_19))))
	end
	if p_u_19:getStatus() ~= v20.Status.Started then
		return p_u_19
	end
	local v21 = newproxy(false)
	local v24 = p18:Add(v20.new(function(p22, _, p23)
		-- upvalues: (copy) p_u_19
		if not p23(function()
			-- upvalues: (ref) p_u_19
			p_u_19:cancel()
		end) then
			p22(p_u_19)
		end
	end), "cancel", v21)
	v24:finallyCall(p18.Remove, p18, v21)
	return v24
end
v_u_5.__index.GivePromise = v_u_5.__index.AddPromise
function v_u_5.__index.AddObject(p25, p26)
	-- upvalues: (copy) v_u_1
	local v27 = newproxy(false)
	local v28
	if v_u_1:IsRunning() then
		v28 = require(game:GetService("ReplicatedStorage").Framework).modules.Promise
	else
		v28 = nil
	end
	if not (v28 and v28.is(p26)) then
		return p25:Add(p26, false, v27), v27
	end
	if p26:getStatus() ~= v28.Status.Started then
		return p26
	end
	local v29 = p25:Add(v28.resolve(p26), "cancel", v27)
	v29:finallyCall(p25.Remove, p25, v27)
	return v29, v27
end
v_u_5.__index.GiveObject = v_u_5.__index.AddObject
function v_u_5.__index.Remove(p30, p31)
	-- upvalues: (copy) v_u_3
	local v32 = p30[v_u_3]
	local v33 = v32 and v32[p31]
	if v33 then
		local v34 = p30[v33]
		if v34 then
			v34 = v34[1]
		end
		if v34 then
			if v34 == true then
				v33()
			else
				local v35 = v33[v34]
				if v35 then
					v35(v33)
				end
			end
			p30[v33] = nil
		end
		v32[p31] = nil
	end
	return p30
end
function v_u_5.__index.Get(p36, p37)
	-- upvalues: (copy) v_u_3
	local v38 = p36[v_u_3]
	if v38 then
		return v38[p37]
	end
end
function v_u_5.__index.Cleanup(p39)
	-- upvalues: (copy) v_u_3
	if not p39.CurrentlyCleaning then
		p39.CurrentlyCleaning = nil
		for v40, v41 in next, p39 do
			if v40 ~= v_u_3 then
				local v42 = type(v40)
				if v42 == "string" or v42 == "number" then
					p39[v40] = nil
				else
					local v43 = v41[1]
					local v44 = v41[2]
					if v43 == true then
						local v45, v46 = pcall(v40)
						if not v45 then
							local v47 = debug.traceback("", 3)
							warn("-------- Janitor Error --------" .. "\n" .. tostring(v46) .. "\n" .. v47 .. "" .. v44)
						end
					else
						local v48 = v40[v43]
						if v48 then
							local v49, v50 = pcall(v48, v40)
							local v51
							if typeof(v40) == "Instance" then
								v51 = v48 == "Destroy"
							else
								v51 = false
							end
							if not (v49 or v51) then
								local v52 = debug.traceback("", 3)
								warn("-------- Janitor Error --------" .. "\n" .. tostring(v50) .. "\n" .. v52 .. "" .. v44)
							end
						end
					end
					p39[v40] = nil
				end
			end
		end
		local v53 = p39[v_u_3]
		if v53 then
			for v54 in next, v53 do
				v53[v54] = nil
			end
			p39[v_u_3] = {}
		end
		p39.CurrentlyCleaning = false
	end
end
v_u_5.__index.Clean = v_u_5.__index.Cleanup
function v_u_5.__index.Destroy(p55)
	p55:Cleanup()
end
v_u_5.__call = v_u_5.__index.Cleanup
local v_u_56 = {
	["Connected"] = true
}
v_u_56.__index = v_u_56
function v_u_56.Disconnect(p57)
	if p57.Connected then
		p57.Connected = false
		p57.Connection:Disconnect()
	end
end
function v_u_56.__tostring(p58)
	local v59 = p58.Connected
	return "Disconnect<" .. tostring(v59) .. ">"
end
function v_u_5.__index.LinkToInstance(p_u_60, p61, p62)
	-- upvalues: (copy) v_u_4, (copy) v_u_56, (copy) v_u_2
	local v_u_63 = nil
	local v64 = p62 and newproxy(false) or v_u_4
	local v_u_65 = p61.Parent == nil
	local v66 = v_u_56
	local v_u_67 = setmetatable({}, v66)
	local function v69(_, p68)
		-- upvalues: (copy) v_u_67, (ref) v_u_65, (ref) v_u_2, (ref) v_u_63, (copy) p_u_60
		v_u_65 = v_u_67.Connected and p68 == nil
		if v_u_65 then
			coroutine.wrap(function()
				-- upvalues: (ref) v_u_2, (ref) v_u_67, (ref) v_u_63, (ref) p_u_60, (ref) v_u_65
				v_u_2:Wait()
				if v_u_67.Connected then
					if v_u_63.Connected then
						while v_u_65 and (v_u_63.Connected and v_u_67.Connected) do
							v_u_2:Wait()
						end
						if v_u_67.Connected and v_u_65 then
							p_u_60:Cleanup()
						end
					else
						p_u_60:Cleanup()
					end
				else
					return
				end
			end)()
		end
	end
	local v_u_70 = p61.AncestryChanged:Connect(v69)
	v_u_67.Connection = v_u_70
	if v_u_65 then
		local v71 = p61.Parent
		if v_u_67.Connected then
			if v71 == nil then
				v_u_65 = true
			else
				v_u_65 = false
			end
			if v_u_65 then
				coroutine.wrap(function()
					-- upvalues: (ref) v_u_2, (copy) v_u_67, (ref) v_u_70, (copy) p_u_60, (ref) v_u_65
					v_u_2:Wait()
					if v_u_67.Connected then
						if v_u_70.Connected then
							while v_u_65 and (v_u_70.Connected and v_u_67.Connected) do
								v_u_2:Wait()
							end
							if v_u_67.Connected and v_u_65 then
								p_u_60:Cleanup()
							end
						else
							p_u_60:Cleanup()
						end
					else
						return
					end
				end)()
			end
		end
	end
	return p_u_60:Add(v_u_67, "Disconnect", v64)
end
function v_u_5.__index.LinkToInstances(p72, ...)
	-- upvalues: (copy) v_u_5
	local v73 = v_u_5.new()
	for _, v74 in ipairs({ ... }) do
		v73:Add(p72:LinkToInstance(v74, true), "Disconnect")
	end
	return v73
end
for v75, v76 in next, v_u_5.__index do
	local v77 = string.lower(v75)
	local v78 = string.sub(v77, 1, 1) .. string.sub(v75, 2)
	v_u_5.__index[v78] = v76
end
return v_u_5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Janitor]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item></Item><Item class="Folder" referent="3321"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[qvgk_zoneplus@3.2.1]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3322"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local v_u_2 = game:GetService("RunService")
local v_u_3 = v_u_2.Heartbeat
local v_u_4 = v_u_2:IsClient()
if v_u_4 then
	v_u_4 = v1.LocalPlayer
end
game:GetService("ReplicatedStorage")
local v_u_5 = game:GetService("HttpService")
local v_u_6 = require(script.Enum).enums
local v_u_7 = require(script.Janitor)
local v_u_8 = require(script.Signal)
local v9 = require(script.ZonePlusReference)
local v10 = v9.getObject()
local v11 = script.ZoneController
local v_u_12 = v11.Tracker
local v_u_13 = v11.CollectiveWorldModel
local v_u_14 = require(v11)
local v15 = game:GetService("RunService"):IsClient() and "Client" or "Server"
local v16
if v10 then
	v16 = v10:FindFirstChild(v15)
else
	v16 = v10
end
if v16 then
	return require(v10.Value)
end
local v_u_17 = {}
v_u_17.__index = v_u_17
if not v16 then
	v9.addToReplicatedStorage()
end
v_u_17.enum = v_u_6
function v_u_17.new(p18)
	-- upvalues: (copy) v_u_17, (copy) v_u_6, (copy) v_u_7, (copy) v_u_5, (copy) v_u_14, (copy) v_u_8, (copy) v_u_4
	local v_u_19 = {}
	local v20 = v_u_17
	setmetatable(v_u_19, v20)
	local v21 = typeof(p18)
	if v21 ~= "table" and v21 ~= "Instance" then
		error("The zone container must be a model, folder, basepart or table!")
	end
	v_u_19.accuracy = v_u_6.Accuracy.High
	v_u_19.autoUpdate = true
	v_u_19.respectUpdateQueue = true
	local v22 = v_u_7.new()
	v_u_19.janitor = v22
	v_u_19._updateConnections = v22:add(v_u_7.new(), "destroy")
	v_u_19.container = p18
	v_u_19.zoneParts = {}
	v_u_19.overlapParams = {}
	v_u_19.region = nil
	v_u_19.volume = nil
	v_u_19.boundMin = nil
	v_u_19.boundMax = nil
	v_u_19.recommendedMaxParts = nil
	v_u_19.zoneId = v_u_5:GenerateGUID()
	v_u_19.activeTriggers = {}
	v_u_19.occupants = {}
	v_u_19.trackingTouchedTriggers = {}
	v_u_19.enterDetection = v_u_6.Detection.Centre
	v_u_19.exitDetection = v_u_6.Detection.Centre
	v_u_19._currentEnterDetection = nil
	v_u_19._currentExitDetection = nil
	v_u_19.totalPartVolume = 0
	v_u_19.allZonePartsAreBlocks = true
	v_u_19.trackedItems = {}
	v_u_19.settingsGroupName = nil
	v_u_19.worldModel = workspace
	v_u_19.onItemDetails = {}
	v_u_19.itemsToUntrack = {}
	v_u_14.updateDetection(v_u_19)
	v_u_19.updated = v22:add(v_u_8.new(), "destroy")
	local v23 = {
		"player",
		"part",
		"localPlayer",
		"item"
	}
	local v24 = { "entered", "exited" }
	for _, v_u_25 in pairs(v23) do
		local v_u_26 = 0
		local v_u_27 = 0
		for _, v28 in pairs(v24) do
			local v29 = v22:add(v_u_8.new(true), "destroy")
			local v_u_30 = v28:sub(1, 1):upper() .. v28:sub(2)
			v_u_19[v_u_25 .. v_u_30] = v29
			v29.connectionsChanged:Connect(function(p31)
				-- upvalues: (copy) v_u_25, (ref) v_u_4, (copy) v_u_30, (ref) v_u_26, (ref) v_u_27, (ref) v_u_14, (copy) v_u_19
				if v_u_25 == "localPlayer" and (not v_u_4 and p31 == 1) then
					error(("Can only connect to \'localPlayer%s\' on the client!"):format(v_u_30))
				end
				v_u_26 = v_u_27
				v_u_27 = v_u_27 + p31
				if v_u_26 == 0 and v_u_27 > 0 then
					v_u_14._registerConnection(v_u_19, v_u_25, v_u_30)
				elseif v_u_26 > 0 and v_u_27 == 0 then
					v_u_14._deregisterConnection(v_u_19, v_u_25)
				end
			end)
		end
	end
	v_u_17.touchedConnectionActions = {}
	for _, v32 in pairs(v23) do
		local v_u_33 = v_u_19[("_%sTouchedZone"):format(v32)]
		if v_u_33 then
			v_u_19.trackingTouchedTriggers[v32] = {}
			v_u_17.touchedConnectionActions[v32] = function(p34)
				-- upvalues: (copy) v_u_33, (copy) v_u_19
				v_u_33(v_u_19, p34)
			end
		end
	end
	v_u_19:_update()
	v_u_14._registerZone(v_u_19)
	v22:add(function()
		-- upvalues: (ref) v_u_14, (copy) v_u_19
		v_u_14._deregisterZone(v_u_19)
	end, true)
	return v_u_19
end
function v_u_17.fromRegion(p35, p36)
	-- upvalues: (copy) v_u_17
	local v_u_37 = Instance.new("Model")
	local function v_u_43(p38, p39)
		-- upvalues: (copy) v_u_43, (copy) v_u_37
		if p39.X > 2024 or (p39.Y > 2024 or p39.Z > 2024) then
			local v40 = p39 * 0.25
			local v41 = p39 * 0.5
			v_u_43(p38 * CFrame.new(-v40.X, -v40.Y, -v40.Z), v41)
			v_u_43(p38 * CFrame.new(-v40.X, -v40.Y, v40.Z), v41)
			v_u_43(p38 * CFrame.new(-v40.X, v40.Y, -v40.Z), v41)
			v_u_43(p38 * CFrame.new(-v40.X, v40.Y, v40.Z), v41)
			v_u_43(p38 * CFrame.new(v40.X, -v40.Y, -v40.Z), v41)
			v_u_43(p38 * CFrame.new(v40.X, -v40.Y, v40.Z), v41)
			v_u_43(p38 * CFrame.new(v40.X, v40.Y, -v40.Z), v41)
			v_u_43(p38 * CFrame.new(v40.X, v40.Y, v40.Z), v41)
		else
			local v42 = Instance.new("Part")
			v42.CFrame = p38
			v42.Size = p39
			v42.Anchored = true
			v42.Parent = v_u_37
		end
	end
	v_u_43(p35, p36)
	local v44 = v_u_17.new(v_u_37)
	v44:relocate()
	return v44
end
function v_u_17._calculateRegion(_, p45, p46)
	local v47 = {
		["Min"] = {},
		["Max"] = {}
	}
	for v_u_48, v49 in pairs(v47) do
		v49.Values = {}
		function v49.parseCheck(p50, p51)
			-- upvalues: (copy) v_u_48
			if v_u_48 == "Min" then
				return p50 <= p51
			end
			if v_u_48 == "Max" then
				return p51 <= p50
			end
		end
		function v49.parse(p52, p53)
			for v54, v55 in pairs(p53) do
				local v56 = p52.Values[v54] or v55
				if p52.parseCheck(v55, v56) then
					p52.Values[v54] = v55
				end
			end
		end
	end
	for _, v57 in pairs(p45) do
		local v58 = v57.Size * 0.5
		local v59 = {
			v57.CFrame * CFrame.new(-v58.X, -v58.Y, -v58.Z),
			v57.CFrame * CFrame.new(-v58.X, -v58.Y, v58.Z),
			v57.CFrame * CFrame.new(-v58.X, v58.Y, -v58.Z),
			v57.CFrame * CFrame.new(-v58.X, v58.Y, v58.Z),
			v57.CFrame * CFrame.new(v58.X, -v58.Y, -v58.Z),
			v57.CFrame * CFrame.new(v58.X, -v58.Y, v58.Z),
			v57.CFrame * CFrame.new(v58.X, v58.Y, -v58.Z),
			v57.CFrame * CFrame.new(v58.X, v58.Y, v58.Z)
		}
		for _, v60 in pairs(v59) do
			local v61, v62, v63 = v60:GetComponents()
			local v64 = { v61, v62, v63 }
			v47.Min:parse(v64)
			v47.Max:parse(v64)
		end
	end
	local v65 = {}
	local v66 = {}
	for v67, v68 in pairs(v47) do
		for _, v72 in pairs(v68.Values) do
			local v70 = v67 == "Min" and v66 and v66 or v65
			if not p46 then
				local v71 = (v72 + (v67 == "Min" and -2 or 2) + 2) / 4
				local v72 = math.floor(v71) * 4
			end
			table.insert(v70, v72)
		end
	end
	local v73 = unpack
	local v74 = Vector3.new(v73(v66))
	local v75 = unpack
	local v76 = Vector3.new(v75(v65))
	return Region3.new(v74, v76), v74, v76
end
function v_u_17._displayBounds(p77)
	if not p77.displayBoundParts then
		p77.displayBoundParts = true
		local v78 = {
			["BoundMin"] = p77.boundMin,
			["BoundMax"] = p77.boundMax
		}
		for v79, v80 in pairs(v78) do
			local v81 = Instance.new("Part")
			v81.Anchored = true
			v81.CanCollide = false
			v81.Transparency = 0.5
			v81.Size = Vector3.new(1, 1, 1)
			v81.Color = Color3.fromRGB(255, 0, 0)
			v81.CFrame = CFrame.new(v80)
			v81.Name = v79
			v81.Parent = workspace
			p77.janitor:add(v81, "Destroy")
		end
	end
end
function v_u_17._update(p_u_82)
	-- upvalues: (copy) v_u_2
	local v83 = p_u_82.container
	local v84 = {}
	local v_u_85 = 0
	p_u_82._updateConnections:clean()
	local v86 = typeof(v83)
	local v87 = {}
	if v86 == "table" then
		for _, v88 in pairs(v83) do
			if v88:IsA("BasePart") then
				table.insert(v84, v88)
			end
		end
	elseif v86 == "Instance" then
		if v83:IsA("BasePart") then
			table.insert(v84, v83)
		else
			table.insert(v87, v83)
			for _, v89 in pairs(v83:GetDescendants()) do
				if v89:IsA("BasePart") then
					table.insert(v84, v89)
				else
					table.insert(v87, v89)
				end
			end
		end
	end
	p_u_82.zoneParts = v84
	p_u_82.overlapParams = {}
	local v90 = true
	for _, v_u_91 in pairs(v84) do
		local _, v92 = pcall(function()
			-- upvalues: (copy) v_u_91
			return v_u_91.Shape.Name
		end)
		if v92 ~= "Block" then
			v90 = false
		end
	end
	p_u_82.allZonePartsAreBlocks = v90
	local v93 = OverlapParams.new()
	v93.FilterType = Enum.RaycastFilterType.Whitelist
	v93.MaxParts = #v84
	v93.FilterDescendantsInstances = v84
	p_u_82.overlapParams.zonePartsWhitelist = v93
	local v94 = OverlapParams.new()
	v94.FilterType = Enum.RaycastFilterType.Blacklist
	v94.FilterDescendantsInstances = v84
	p_u_82.overlapParams.zonePartsIgnorelist = v94
	local function v97()
		-- upvalues: (copy) p_u_82, (ref) v_u_85, (ref) v_u_2
		if p_u_82.autoUpdate then
			local v_u_95 = os.clock()
			if p_u_82.respectUpdateQueue then
				v_u_85 = v_u_85 + 1
				v_u_95 = v_u_95 + 0.1
			end
			local v_u_96 = nil
			v_u_96 = v_u_2.Heartbeat:Connect(function()
				-- upvalues: (ref) v_u_95, (ref) v_u_96, (ref) p_u_82, (ref) v_u_85
				if v_u_95 <= os.clock() then
					v_u_96:Disconnect()
					if p_u_82.respectUpdateQueue then
						v_u_85 = v_u_85 - 1
					end
					if v_u_85 == 0 and p_u_82.zoneId then
						p_u_82:_update()
					end
				end
			end)
		end
	end
	local v98 = { "Size", "Position" }
	for _, v_u_99 in pairs(v84) do
		for _, v100 in pairs(v98) do
			p_u_82._updateConnections:add(v_u_99:GetPropertyChangedSignal(v100):Connect(v97), "Disconnect")
		end
		if v_u_99.CollisionGroupId ~= 0 then
			error("Zone parts must belong to the \'Default\' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
		end
		p_u_82._updateConnections:add(v_u_99:GetPropertyChangedSignal("CollisionGroupId"):Connect(function()
			-- upvalues: (copy) v_u_99
			if v_u_99.CollisionGroupId ~= 0 then
				error("Zone parts must belong to the \'Default\' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
			end
		end), "Disconnect")
	end
	local v101 = { "ChildAdded", "ChildRemoved" }
	for _, _ in pairs(v87) do
		for _, v102 in pairs(v101) do
			p_u_82._updateConnections:add(p_u_82.container[v102]:Connect(function(p103)
				-- upvalues: (copy) p_u_82, (ref) v_u_85, (ref) v_u_2
				if p103:IsA("BasePart") and p_u_82.autoUpdate then
					local v_u_104 = os.clock()
					if p_u_82.respectUpdateQueue then
						v_u_85 = v_u_85 + 1
						v_u_104 = v_u_104 + 0.1
					end
					local v_u_105 = nil
					v_u_105 = v_u_2.Heartbeat:Connect(function()
						-- upvalues: (ref) v_u_104, (ref) v_u_105, (ref) p_u_82, (ref) v_u_85
						if v_u_104 <= os.clock() then
							v_u_105:Disconnect()
							if p_u_82.respectUpdateQueue then
								v_u_85 = v_u_85 - 1
							end
							if v_u_85 == 0 and p_u_82.zoneId then
								p_u_82:_update()
							end
						end
					end)
				end
			end), "Disconnect")
		end
	end
	local v106, v107, v108 = p_u_82:_calculateRegion(v84)
	local v109, _, _ = p_u_82:_calculateRegion(v84, true)
	p_u_82.region = v106
	p_u_82.exactRegion = v109
	p_u_82.boundMin = v107
	p_u_82.boundMax = v108
	local v110 = v106.Size
	p_u_82.volume = v110.X * v110.Y * v110.Z
	p_u_82:_updateTouchedConnections()
	p_u_82.updated:Fire()
end
function v_u_17._updateOccupants(p111, p112, p113)
	local v114 = p111.occupants[p112]
	if not v114 then
		v114 = {}
		p111.occupants[p112] = v114
	end
	local v115 = {}
	for v116, v117 in pairs(v114) do
		local v118 = p113[v116]
		if v118 == nil or v118 ~= v117 then
			v114[v116] = nil
			if not v115.exited then
				v115.exited = {}
			end
			local v119 = v115.exited
			table.insert(v119, v116)
		end
	end
	for v120, _ in pairs(p113) do
		if v114[v120] == nil then
			v114[v120] = v120:IsA("Player") and (v120.Character or true) or true
			if not v115.entered then
				v115.entered = {}
			end
			local v121 = v115.entered
			table.insert(v121, v120)
		end
	end
	return v115
end
function v_u_17._formTouchedConnection(p122, p123)
	-- upvalues: (copy) v_u_7
	local v124 = "_touchedJanitor" .. p123
	local v125 = p122[v124]
	if v125 then
		v125:clean()
	else
		p122[v124] = p122.janitor:add(v_u_7.new(), "destroy")
	end
	p122:_updateTouchedConnection(p123)
end
function v_u_17._updateTouchedConnection(p126, p127)
	local v128 = p126["_touchedJanitor" .. p127]
	if v128 then
		for _, v129 in pairs(p126.zoneParts) do
			v128:add(v129.Touched:Connect(p126.touchedConnectionActions[p127], p126), "Disconnect")
		end
	end
end
function v_u_17._updateTouchedConnections(p130)
	for v131, _ in pairs(p130.touchedConnectionActions) do
		local v132 = p130["_touchedJanitor" .. v131]
		if v132 then
			v132:cleanup()
			p130:_updateTouchedConnection(v131)
		end
	end
end
function v_u_17._disconnectTouchedConnection(p133, p134)
	local v135 = "_touchedJanitor" .. p134
	local v136 = p133[v135]
	if v136 then
		v136:cleanup()
		p133[v135] = nil
	end
end
function v_u_17._partTouchedZone(p_u_137, p_u_138)
	-- upvalues: (copy) v_u_7, (copy) v_u_3, (copy) v_u_6
	local v_u_139 = p_u_137.trackingTouchedTriggers.part
	if not v_u_139[p_u_138] then
		local v_u_140 = 0
		local v_u_141 = false
		local v_u_142 = p_u_138.Position
		local v_u_143 = os.clock()
		local v_u_144 = p_u_137.janitor:add(v_u_7.new(), "destroy")
		v_u_139[p_u_138] = v_u_144
		if not ({
			["Seat"] = true,
			["VehicleSeat"] = true
		})[p_u_138.ClassName] and ({
			["HumanoidRootPart"] = true
		})[p_u_138.Name] then
			p_u_138.CanTouch = false
		end
		local v145 = p_u_138.Size.X * p_u_138.Size.Y * p_u_138.Size.Z * 100000
		local v_u_146 = math.round(v145) * 0.00001
		p_u_137.totalPartVolume = p_u_137.totalPartVolume + v_u_146
		v_u_144:add(v_u_3:Connect(function()
			-- upvalues: (ref) v_u_140, (ref) v_u_6, (copy) p_u_137, (copy) p_u_138, (ref) v_u_141, (ref) v_u_142, (ref) v_u_143, (copy) v_u_144
			local v147 = os.clock()
			if v_u_140 <= v147 then
				local v148 = v_u_6.Accuracy.getProperty(p_u_137.accuracy)
				v_u_140 = v147 + v148
				local v149 = p_u_137:findPoint(p_u_138.CFrame) or p_u_137:findPart(p_u_138)
				if v_u_141 then
					if not v149 then
						v_u_141 = false
						v_u_142 = p_u_138.Position
						v_u_143 = os.clock()
						p_u_137.partExited:Fire(p_u_138)
					end
				else
					if v149 then
						v_u_141 = true
						p_u_137.partEntered:Fire(p_u_138)
						return
					end
					if (p_u_138.Position - v_u_142).Magnitude > 1.5 and v148 <= v147 - v_u_143 then
						v_u_144:cleanup()
						return
					end
				end
			end
		end), "Disconnect")
		v_u_144:add(function()
			-- upvalues: (copy) v_u_139, (copy) p_u_138, (copy) p_u_137, (copy) v_u_146
			v_u_139[p_u_138] = nil
			p_u_138.CanTouch = true
			local v150 = p_u_137
			local v151 = (p_u_137.totalPartVolume - v_u_146) * 100000
			v150.totalPartVolume = math.round(v151) * 0.00001
		end, true)
	end
end
local v_u_155 = {
	["Ball"] = function(p152)
		return "GetPartBoundsInRadius", { p152.Position, p152.Size.X }
	end,
	["Block"] = function(p153)
		return "GetPartBoundsInBox", { p153.CFrame, p153.Size }
	end,
	["Other"] = function(p154)
		return "GetPartsInPart", { p154 }
	end
}
function v_u_17._getRegionConstructor(p156, p_u_157, p158)
	-- upvalues: (copy) v_u_155
	local v159, v160 = pcall(function()
		-- upvalues: (copy) p_u_157
		return p_u_157.Shape.Name
	end)
	local v161 = nil
	local v162 = nil
	if v159 and p156.allZonePartsAreBlocks then
		local v163 = v_u_155[v160]
		if v163 then
			v161, v162 = v163(p_u_157)
		end
	end
	if not v161 then
		v161, v162 = v_u_155.Other(p_u_157)
	end
	if p158 then
		table.insert(v162, p158)
	end
	return v161, v162
end
function v_u_17.findLocalPlayer(p164)
	-- upvalues: (copy) v_u_4
	if not v_u_4 then
		error("Can only call \'findLocalPlayer\' on the client!")
	end
	return p164:findPlayer(v_u_4)
end
function v_u_17._find(p165, p166, p167)
	-- upvalues: (copy) v_u_14
	v_u_14.updateDetection(p165)
	local v168 = v_u_14.trackers[p166]
	local v169 = v_u_14.getTouchingZones(p167, false, p165._currentEnterDetection, v168)
	for _, v170 in pairs(v169) do
		if v170 == p165 then
			return true
		end
	end
	return false
end
function v_u_17.findPlayer(p171, p172)
	local v173 = p172.Character
	if v173 then
		v173 = v173:FindFirstChildOfClass("Humanoid")
	end
	if v173 then
		return p171:_find("player", p172.Character)
	else
		return false
	end
end
function v_u_17.findItem(p174, p175)
	return p174:_find("item", p175)
end
function v_u_17.findPart(p176, p177)
	local v178, v179 = p176:_getRegionConstructor(p177, p176.overlapParams.zonePartsWhitelist)
	local v180 = p176.worldModel[v178](p176.worldModel, unpack(v179))
	if #v180 > 0 then
		return true, v180
	else
		return false
	end
end
function v_u_17.getCheckerPart(p181)
	-- upvalues: (copy) v_u_14
	local v182 = p181.checkerPart
	if not v182 then
		v182 = p181.janitor:add(Instance.new("Part"), "Destroy")
		v182.Size = Vector3.new(0.1, 0.1, 0.1)
		v182.Name = "ZonePlusCheckerPart"
		v182.Anchored = true
		v182.Transparency = 1
		v182.CanCollide = false
		p181.checkerPart = v182
	end
	local v183 = p181.worldModel
	if v183 == workspace then
		v183 = v_u_14.getWorkspaceContainer()
	end
	if v182.Parent ~= v183 then
		v182.Parent = v183
	end
	return v182
end
function v_u_17.findPoint(p184, p185)
	if typeof(p185) == "Vector3" then
		p185 = CFrame.new(p185)
	end
	local v186 = p184:getCheckerPart()
	v186.CFrame = p185
	local v187, v188 = p184:_getRegionConstructor(v186, p184.overlapParams.zonePartsWhitelist)
	local v189 = p184.worldModel[v187](p184.worldModel, unpack(v188))
	if #v189 > 0 then
		return true, v189
	else
		return false
	end
end
function v_u_17._getAll(p190, p191)
	-- upvalues: (copy) v_u_14
	v_u_14.updateDetection(p190)
	local v192 = {}
	local v193 = v_u_14._getZonesAndItems(p191, {
		["self"] = true
	}, p190.volume, false, p190._currentEnterDetection)[p190]
	if v193 then
		for v194, _ in pairs(v193) do
			table.insert(v192, v194)
		end
	end
	return v192
end
function v_u_17.getPlayers(p195)
	return p195:_getAll("player")
end
function v_u_17.getItems(p196)
	return p196:_getAll("item")
end
function v_u_17.getParts(p197)
	local v198 = {}
	if p197.activeTriggers.part then
		local v199 = p197.trackingTouchedTriggers.part
		for v200, _ in pairs(v199) do
			table.insert(v198, v200)
		end
		return v198
	else
		local v201 = p197.worldModel:GetPartBoundsInBox(p197.region.CFrame, p197.region.Size, p197.overlapParams.zonePartsIgnorelist)
		for _, v202 in pairs(v201) do
			if p197:findPart(v202) then
				table.insert(v198, v202)
			end
		end
		return v198
	end
end
function v_u_17.getRandomPoint(p203)
	local v204 = p203.exactRegion
	local v205 = v204.Size
	local v206 = v204.CFrame
	local v207 = Random.new()
	local v208 = nil
	repeat
		local v209 = v206 * CFrame.new(v207:NextNumber(-v205.X / 2, v205.X / 2), v207:NextNumber(-v205.Y / 2, v205.Y / 2), v207:NextNumber(-v205.Z / 2, v205.Z / 2))
		local v210, v211 = p203:findPoint(v209)
		v208 = v210 and true or v208
	until v208
	return v209.Position, v211
end
function v_u_17.setAccuracy(p212, p213)
	-- upvalues: (copy) v_u_6
	local v214 = tonumber(p213)
	if v214 then
		if not v_u_6.Accuracy.getName(v214) then
			error(("%s is an invalid enumId!"):format(v214))
		end
	else
		v214 = v_u_6.Accuracy[p213]
		if not v214 then
			error(("\'%s\' is an invalid enumName!"):format(p213))
		end
	end
	p212.accuracy = v214
end
function v_u_17.setDetection(p215, p216)
	-- upvalues: (copy) v_u_6
	local v217 = tonumber(p216)
	if v217 then
		if not v_u_6.Detection.getName(v217) then
			error(("%s is an invalid enumId!"):format(v217))
		end
	else
		v217 = v_u_6.Detection[p216]
		if not v217 then
			error(("\'%s\' is an invalid enumName!"):format(p216))
		end
	end
	p215.enterDetection = v217
	p215.exitDetection = v217
end
function v_u_17.trackItem(p_u_218, p_u_219)
	-- upvalues: (copy) v_u_7, (copy) v_u_12
	local v220 = p_u_219:IsA("BasePart")
	local v221
	if v220 then
		v221 = false
	else
		v221 = p_u_219:FindFirstChildOfClass("Humanoid")
		if v221 then
			v221 = p_u_219:FindFirstChild("HumanoidRootPart")
		end
	end
	assert(v220 or v221, "Only BaseParts or Characters/NPCs can be tracked!")
	if not p_u_218.trackedItems[p_u_219] then
		if p_u_218.itemsToUntrack[p_u_219] then
			p_u_218.itemsToUntrack[p_u_219] = nil
		end
		local v222 = p_u_218.janitor:add(v_u_7.new(), "destroy")
		local v223 = {
			["janitor"] = v222,
			["item"] = p_u_219,
			["isBasePart"] = v220,
			["isCharacter"] = v221
		}
		p_u_218.trackedItems[p_u_219] = v223
		v222:add(p_u_219.AncestryChanged:Connect(function()
			-- upvalues: (copy) p_u_219, (copy) p_u_218
			if not p_u_219:IsDescendantOf(game) then
				p_u_218:untrackItem(p_u_219)
			end
		end), "Disconnect")
		require(v_u_12).itemAdded:Fire(v223)
	end
end
function v_u_17.untrackItem(p224, p225)
	-- upvalues: (copy) v_u_12
	local v226 = p224.trackedItems[p225]
	if v226 then
		v226.janitor:destroy()
	end
	p224.trackedItems[p225] = nil
	require(v_u_12).itemRemoved:Fire(v226)
end
function v_u_17.bindToGroup(p227, p228)
	-- upvalues: (copy) v_u_14
	p227:unbindFromGroup()
	(v_u_14.getGroup(p228) or v_u_14.setGroup(p228))._memberZones[p227.zoneId] = p227
	p227.settingsGroupName = p228
end
function v_u_17.unbindFromGroup(p229)
	-- upvalues: (copy) v_u_14
	if p229.settingsGroupName then
		local v230 = v_u_14.getGroup(p229.settingsGroupName)
		if v230 then
			v230._memberZones[p229.zoneId] = nil
		end
		p229.settingsGroupName = nil
	end
end
function v_u_17.relocate(p231)
	-- upvalues: (copy) v_u_13
	if not p231.hasRelocated then
		local v232 = require(v_u_13).setupWorldModel(p231)
		p231.worldModel = v232
		p231.hasRelocated = true
		local v233 = p231.container
		if typeof(v233) == "table" then
			v233 = Instance.new("Folder")
			for _, v234 in pairs(p231.zoneParts) do
				v234.Parent = v233
			end
		end
		p231.relocationContainer = p231.janitor:add(v233, "Destroy", "RelocationContainer")
		v233.Parent = v232
	end
end
function v_u_17._onItemCallback(p_u_235, p236, p237, p_u_238, p_u_239)
	local v240 = p_u_235.onItemDetails[p_u_238]
	if not v240 then
		v240 = {}
		p_u_235.onItemDetails[p_u_238] = v240
	end
	if #v240 == 0 then
		p_u_235.itemsToUntrack[p_u_238] = true
	end
	table.insert(v240, p_u_238)
	p_u_235:trackItem(p_u_238)
	if p_u_235:findItem(p_u_238) == p237 then
		p_u_239()
		if p_u_235.itemsToUntrack[p_u_238] then
			p_u_235.itemsToUntrack[p_u_238] = nil
			p_u_235:untrackItem(p_u_238)
			return
		end
	else
		local v_u_241 = nil
		v_u_241 = p_u_235[p236]:Connect(function(p242)
			-- upvalues: (ref) v_u_241, (copy) p_u_238, (copy) p_u_239, (copy) p_u_235
			if v_u_241 and p242 == p_u_238 then
				v_u_241:Disconnect()
				v_u_241 = nil
				p_u_239()
				if p_u_235.itemsToUntrack[p_u_238] then
					p_u_235.itemsToUntrack[p_u_238] = nil
					p_u_235:untrackItem(p_u_238)
				end
			end
		end)
	end
end
function v_u_17.onItemEnter(p243, ...)
	p243:_onItemCallback("itemEntered", true, ...)
end
function v_u_17.onItemExit(p244, ...)
	p244:_onItemCallback("itemExited", false, ...)
end
function v_u_17.destroy(p245)
	p245:unbindFromGroup()
	p245.janitor:destroy()
end
v_u_17.Destroy = v_u_17.destroy
return v_u_17]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[zoneplus]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3323"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
local v_u_2 = {}
v1.enums = v_u_2
function v1.createEnum(p3, p_u_4)
	-- upvalues: (copy) v_u_2
	local v5 = typeof(p3) == "string"
	assert(v5, "bad argument #1 - enums must be created using a string name!")
	local v6 = typeof(p_u_4) == "table"
	assert(v6, "bad argument #2 - enums must be created using a table!")
	local v7 = not v_u_2[p3]
	assert(v7, ("enum \'%s\' already exists!"):format(p3))
	local v_u_8 = {}
	local v_u_9 = {}
	local v_u_10 = {}
	local v11 = {}
	local v_u_21 = {
		["getName"] = function(p12)
			-- upvalues: (copy) v_u_9, (copy) v_u_10, (copy) p_u_4
			local v13 = tostring(p12)
			local v14 = v_u_9[v13] or v_u_10[v13]
			if v14 then
				return p_u_4[v14][1]
			end
		end,
		["getValue"] = function(p15)
			-- upvalues: (copy) v_u_8, (copy) v_u_10, (copy) p_u_4
			local v16 = tostring(p15)
			local v17 = v_u_8[v16] or v_u_10[v16]
			if v17 then
				return p_u_4[v17][2]
			end
		end,
		["getProperty"] = function(p18)
			-- upvalues: (copy) v_u_8, (copy) v_u_9, (copy) p_u_4
			local v19 = tostring(p18)
			local v20 = v_u_8[v19] or v_u_9[v19]
			if v20 then
				return p_u_4[v20][3]
			end
		end
	}
	for v22, v23 in pairs(p_u_4) do
		local v24 = typeof(v23) == "table"
		assert(v24, ("bad argument #2.%s - details must only be comprised of tables!"):format(v22))
		local v25 = v23[1]
		local v26 = typeof(v25) == "string"
		assert(v26, ("bad argument #2.%s.1 - detail name must be a string!"):format(v22))
		local v27 = not v_u_8[v25]
		local v28 = typeof(v27)
		assert(v28, ("bad argument #2.%s.1 - the detail name \'%s\' already exists!"):format(v22, v25))
		local v29 = not v_u_21[v25]
		local v30 = typeof(v29)
		assert(v30, ("bad argument #2.%s.1 - that name is reserved."):format(v22, v25))
		v_u_8[tostring(v25)] = v22
		local v31 = v23[2]
		local v32 = tostring(v31)
		local v33 = not v_u_9[v32]
		local v34 = typeof(v33)
		assert(v34, ("bad argument #2.%s.2 - the detail value \'%s\' already exists!"):format(v22, v32))
		v_u_9[v32] = v22
		local v35 = v23[3]
		if v35 then
			local v36 = not v_u_10[v35]
			local v37 = typeof(v36)
			local v38 = tostring(v35)
			assert(v37, ("bad argument #2.%s.3 - the detail property \'%s\' already exists!"):format(v22, v38))
			v_u_10[tostring(v35)] = v22
		end
		v11[v25] = v31
		setmetatable(v11, {
			["__index"] = function(_, p39)
				-- upvalues: (copy) v_u_21
				return v_u_21[p39]
			end
		})
	end
	v_u_2[p3] = v11
	return v11
end
function v1.getEnums()
	-- upvalues: (copy) v_u_2
	return v_u_2
end
local v40 = v1.createEnum
for _, v41 in pairs(script:GetChildren()) do
	if v41:IsA("ModuleScript") then
		local v42 = require(v41)
		v40(v41.Name, v42)
	end
end
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Enum]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3324"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	{ "Low", 1, 1 },
	{ "Medium", 2, 0.5 },
	{ "High", 3, 0.1 },
	{ "Precise", 4, 0 }
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Accuracy]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3325"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	{ "WholeBody", 1 },
	{ "Centre", 2 }
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Detection]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3326"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("RunService").Heartbeat
local v_u_2 = newproxy(true)
getmetatable(v_u_2).__tostring = function()
	return "IndicesReference"
end
local v_u_3 = newproxy(true)
getmetatable(v_u_3).__tostring = function()
	return "LinkToInstanceIndex"
end
local v_u_4 = {
	["ClassName"] = "Janitor",
	["__index"] = {
		["CurrentlyCleaning"] = true,
		[v_u_2] = nil
	}
}
local v_u_5 = {
	["function"] = true,
	["RBXScriptConnection"] = "Disconnect"
}
function v_u_4.new()
	-- upvalues: (copy) v_u_2, (copy) v_u_4
	local v6 = {
		["CurrentlyCleaning"] = false,
		[v_u_2] = nil
	}
	local v7 = v_u_4
	return setmetatable(v6, v7)
end
function v_u_4.Is(p8)
	-- upvalues: (copy) v_u_4
	local v9
	if type(p8) == "table" then
		v9 = getmetatable(p8) == v_u_4
	else
		v9 = false
	end
	return v9
end
v_u_4.is = v_u_4.Is
function v_u_4.__index.Add(p10, p11, p12, p13)
	-- upvalues: (copy) v_u_2, (copy) v_u_5
	if p13 == nil then
		p13 = newproxy(false)
	end
	if p13 then
		p10:Remove(p13)
		local v14 = p10[v_u_2]
		if not v14 then
			v14 = {}
			p10[v_u_2] = v14
		end
		v14[p13] = p11
	end
	local v15 = p12 or (v_u_5[typeof(p11)] or "Destroy")
	if type(p11) ~= "function" and not p11[v15] then
		warn(string.format("Object %s doesn\'t have method %s, are you sure you want to add it? Traceback: %s", tostring(p11), tostring(v15), debug.traceback(nil, 2)))
	end
	p10[p11] = v15
	return p11, p13
end
v_u_4.__index.Give = v_u_4.__index.Add
function v_u_4.__index.AddObject(p16, p17)
	local v18 = newproxy(false)
	return p16:Add(p17, false, v18), v18
end
v_u_4.__index.GiveObject = v_u_4.__index.AddObject
function v_u_4.__index.Remove(p19, p20)
	-- upvalues: (copy) v_u_2
	local v21 = p19[v_u_2]
	local v22 = v21 and v21[p20]
	if v22 then
		local v23 = p19[v22]
		if v23 then
			if v23 == true then
				v22()
			else
				local v24 = v22[v23]
				if v24 then
					v24(v22)
				end
			end
			p19[v22] = nil
		end
		v21[p20] = nil
	end
	return p19
end
function v_u_4.__index.Get(p25, p26)
	-- upvalues: (copy) v_u_2
	local v27 = p25[v_u_2]
	if v27 then
		return v27[p26]
	end
end
function v_u_4.__index.Cleanup(p28)
	-- upvalues: (copy) v_u_2
	if not p28.CurrentlyCleaning then
		p28.CurrentlyCleaning = nil
		for v29, v30 in next, p28 do
			if v29 ~= v_u_2 then
				local v31 = type(v29)
				if v31 == "string" or v31 == "number" then
					p28[v29] = nil
				else
					if v30 == true then
						v29()
					else
						local v32 = v29[v30]
						if v32 then
							v32(v29)
						end
					end
					p28[v29] = nil
				end
			end
		end
		local v33 = p28[v_u_2]
		if v33 then
			for v34 in next, v33 do
				v33[v34] = nil
			end
			p28[v_u_2] = {}
		end
		p28.CurrentlyCleaning = false
	end
end
v_u_4.__index.Clean = v_u_4.__index.Cleanup
function v_u_4.__index.Destroy(p35)
	p35:Cleanup()
end
v_u_4.__call = v_u_4.__index.Cleanup
local v_u_36 = {
	["Connected"] = true
}
v_u_36.__index = v_u_36
function v_u_36.Disconnect(p37)
	if p37.Connected then
		p37.Connected = false
		p37.Connection:Disconnect()
	end
end
function v_u_36.__tostring(p38)
	local v39 = p38.Connected
	return "Disconnect<" .. tostring(v39) .. ">"
end
function v_u_4.__index.LinkToInstance(p_u_40, p41, p42)
	-- upvalues: (copy) v_u_3, (copy) v_u_36, (copy) v_u_1
	local v_u_43 = nil
	local v44 = p42 and newproxy(false) or v_u_3
	local v_u_45 = p41.Parent == nil
	local v46 = v_u_36
	local v_u_47 = setmetatable({}, v46)
	local function v49(_, p48)
		-- upvalues: (copy) v_u_47, (ref) v_u_45, (ref) v_u_1, (ref) v_u_43, (copy) p_u_40
		v_u_45 = v_u_47.Connected and p48 == nil
		if v_u_45 then
			coroutine.wrap(function()
				-- upvalues: (ref) v_u_1, (ref) v_u_47, (ref) v_u_43, (ref) p_u_40, (ref) v_u_45
				v_u_1:Wait()
				if v_u_47.Connected then
					if v_u_43.Connected then
						while v_u_45 and (v_u_43.Connected and v_u_47.Connected) do
							v_u_1:Wait()
						end
						if v_u_47.Connected and v_u_45 then
							p_u_40:Cleanup()
						end
					else
						p_u_40:Cleanup()
					end
				else
					return
				end
			end)()
		end
	end
	local v_u_50 = p41.AncestryChanged:Connect(v49)
	v_u_47.Connection = v_u_50
	if v_u_45 then
		local v51 = p41.Parent
		if v_u_47.Connected then
			if v51 == nil then
				v_u_45 = true
			else
				v_u_45 = false
			end
			if v_u_45 then
				coroutine.wrap(function()
					-- upvalues: (ref) v_u_1, (copy) v_u_47, (ref) v_u_50, (copy) p_u_40, (ref) v_u_45
					v_u_1:Wait()
					if v_u_47.Connected then
						if v_u_50.Connected then
							while v_u_45 and (v_u_50.Connected and v_u_47.Connected) do
								v_u_1:Wait()
							end
							if v_u_47.Connected and v_u_45 then
								p_u_40:Cleanup()
							end
						else
							p_u_40:Cleanup()
						end
					else
						return
					end
				end)()
			end
		end
	end
	return p_u_40:Add(v_u_47, "Disconnect", v44)
end
function v_u_4.__index.LinkToInstances(p52, ...)
	-- upvalues: (copy) v_u_4
	local v53 = v_u_4.new()
	for _, v54 in ipairs({ ... }) do
		v53:Add(p52:LinkToInstance(v54, true), "Disconnect")
	end
	return v53
end
for v55, v56 in next, v_u_4.__index do
	local v57 = string.lower(v55)
	local v58 = string.sub(v57, 1, 1) .. string.sub(v55, 2)
	v_u_4.__index[v58] = v56
end
return v_u_4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Janitor]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3327"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("HttpService")
local v_u_2 = game:GetService("RunService").Heartbeat
local v_u_3 = {}
v_u_3.__index = v_u_3
v_u_3.ClassName = "Signal"
v_u_3.totalConnections = 0
function v_u_3.new(p4)
	-- upvalues: (copy) v_u_3
	local v5 = v_u_3
	local v6 = setmetatable({}, v5)
	if p4 then
		v6.connectionsChanged = v_u_3.new()
	end
	v6.connections = {}
	v6.totalConnections = 0
	v6.waiting = {}
	v6.totalWaiting = 0
	return v6
end
function v_u_3.Fire(p7, ...)
	for _, v8 in pairs(p7.connections) do
		task.spawn(v8.Handler, ...)
	end
	if p7.totalWaiting > 0 then
		local v9 = table.pack(...)
		for v10, _ in pairs(p7.waiting) do
			p7.waiting[v10] = v9
		end
	end
end
v_u_3.fire = v_u_3.Fire
function v_u_3.Connect(p_u_11, p12)
	-- upvalues: (copy) v_u_1
	if type(p12) ~= "function" then
		error(("connect(%s)"):format((typeof(p12))), 2)
	end
	local v_u_13 = v_u_1:GenerateGUID(false)
	local v_u_14 = {
		["Connected"] = true,
		["ConnectionId"] = v_u_13,
		["Handler"] = p12
	}
	p_u_11.connections[v_u_13] = v_u_14
	function v_u_14.Disconnect(_)
		-- upvalues: (copy) p_u_11, (copy) v_u_13, (copy) v_u_14
		p_u_11.connections[v_u_13] = nil
		v_u_14.Connected = false
		local v15 = p_u_11
		v15.totalConnections = v15.totalConnections - 1
		if p_u_11.connectionsChanged then
			p_u_11.connectionsChanged:Fire(-1)
		end
	end
	v_u_14.Destroy = v_u_14.Disconnect
	v_u_14.destroy = v_u_14.Disconnect
	v_u_14.disconnect = v_u_14.Disconnect
	p_u_11.totalConnections = p_u_11.totalConnections + 1
	if p_u_11.connectionsChanged then
		p_u_11.connectionsChanged:Fire(1)
	end
	return v_u_14
end
v_u_3.connect = v_u_3.Connect
function v_u_3.Wait(p16)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v17 = v_u_1:GenerateGUID(false)
	p16.waiting[v17] = true
	p16.totalWaiting = p16.totalWaiting + 1
	repeat
		v_u_2:Wait()
	until p16.waiting[v17] ~= true
	p16.totalWaiting = p16.totalWaiting - 1
	local v18 = p16.waiting[v17]
	p16.waiting[v17] = nil
	return unpack(v18)
end
v_u_3.wait = v_u_3.Wait
function v_u_3.Destroy(p19)
	if p19.bindableEvent then
		p19.bindableEvent:Destroy()
		p19.bindableEvent = nil
	end
	if p19.connectionsChanged then
		p19.connectionsChanged:Fire(-p19.totalConnections)
		p19.connectionsChanged:Destroy()
		p19.connectionsChanged = nil
	end
	p19.totalConnections = 0
	for v20, _ in pairs(p19.connections) do
		p19.connections[v20] = nil
	end
end
v_u_3.destroy = v_u_3.Destroy
v_u_3.Disconnect = v_u_3.Destroy
v_u_3.disconnect = v_u_3.Destroy
return v_u_3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[OldSignal]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3328"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = nil
local function v_u_4(p2, ...)
	-- upvalues: (ref) v_u_1
	local v3 = v_u_1
	v_u_1 = nil
	p2(...)
	v_u_1 = v3
end
local function v_u_5(...)
	-- upvalues: (copy) v_u_4
	v_u_4(...)
	while true do
		v_u_4(coroutine.yield())
	end
end
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6.new(p7, p8)
	-- upvalues: (copy) v_u_6
	local v9 = v_u_6
	return setmetatable({
		["_connected"] = true,
		["_signal"] = p7,
		["_fn"] = p8,
		["_next"] = false
	}, v9)
end
function v_u_6.Disconnect(p10)
	local v11 = p10._connected
	assert(v11, "Can\'t disconnect a connection twice.", 2)
	p10._connected = false
	local v12 = p10._signal
	if v12._handlerListHead == p10 then
		v12._handlerListHead = p10._next
	else
		local v13 = v12._handlerListHead
		while v13 and v13._next ~= p10 do
			v13 = v13._next
		end
		if v13 then
			v13._next = p10._next
		end
	end
	if v12.connectionsChanged then
		v12.totalConnections = v12.totalConnections - 1
		v12.connectionsChanged:Fire(-1)
	end
end
setmetatable(v_u_6, {
	["__index"] = function(_, p14)
		error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p14))), 2)
	end,
	["__newindex"] = function(_, p15, _)
		error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p15))), 2)
	end
})
local v_u_16 = {}
v_u_16.__index = v_u_16
function v_u_16.new(p17)
	-- upvalues: (copy) v_u_16
	local v18 = v_u_16
	local v19 = setmetatable({
		["_handlerListHead"] = false
	}, v18)
	if p17 then
		v19.totalConnections = 0
		v19.connectionsChanged = v_u_16.new()
	end
	return v19
end
function v_u_16.Connect(p20, p21)
	-- upvalues: (copy) v_u_6
	local v22 = v_u_6.new(p20, p21)
	if p20._handlerListHead then
		v22._next = p20._handlerListHead
		p20._handlerListHead = v22
	else
		p20._handlerListHead = v22
	end
	if p20.connectionsChanged then
		p20.totalConnections = p20.totalConnections + 1
		p20.connectionsChanged:Fire(1)
	end
	return v22
end
function v_u_16.DisconnectAll(p23)
	p23._handlerListHead = false
	if p23.connectionsChanged then
		p23.connectionsChanged:Fire(-p23.totalConnections)
		p23.connectionsChanged:Destroy()
		p23.connectionsChanged = nil
		p23.totalConnections = 0
	end
end
v_u_16.Destroy = v_u_16.DisconnectAll
v_u_16.destroy = v_u_16.DisconnectAll
function v_u_16.Fire(p24, ...)
	-- upvalues: (ref) v_u_1, (copy) v_u_5
	local v25 = p24._handlerListHead
	while v25 do
		if v25._connected then
			if not v_u_1 then
				v_u_1 = coroutine.create(v_u_5)
			end
			task.spawn(v_u_1, v25._fn, ...)
		end
		v25 = v25._next
	end
end
function v_u_16.Wait(p26)
	local v_u_27 = coroutine.running()
	local v_u_28 = nil
	v_u_28 = p26:Connect(function(...)
		-- upvalues: (ref) v_u_28, (copy) v_u_27
		v_u_28:Disconnect()
		task.spawn(v_u_27, ...)
	end)
	return coroutine.yield()
end
return v_u_16]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Signal]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3329"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VERSION]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3330"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Janitor)
local v2 = require(script.Parent.Enum)
require(script.Parent.Signal)
local v_u_3 = require(script.Tracker)
local v_u_4 = require(script.CollectiveWorldModel)
local v_u_5 = v2.enums
local v_u_6 = game:GetService("Players")
local v_u_7 = {}
local v_u_8 = 0
local v_u_9 = {}
local v_u_10 = {}
local v_u_11 = {}
local v_u_12 = {}
local v_u_13 = {}
local v_u_14 = {}
local v_u_15 = 0
local v16 = game:GetService("RunService")
local v_u_17 = v16.Heartbeat
local v_u_18 = {}
local v_u_19 = v16:IsClient()
if v_u_19 then
	v_u_19 = v_u_6.LocalPlayer
end
local v_u_20 = {}
local v_u_21 = {
	["player"] = v_u_3.new("player"),
	["item"] = v_u_3.new("item")
}
v_u_20.trackers = v_u_21
local v_u_32 = {
	["player"] = function(p22)
		-- upvalues: (copy) v_u_20, (copy) v_u_7, (ref) v_u_8
		return v_u_20._getZonesAndItems("player", v_u_7, v_u_8, true, p22)
	end,
	["localPlayer"] = function(p23)
		-- upvalues: (copy) v_u_19, (copy) v_u_20, (copy) v_u_21
		local v24 = {}
		local v25 = v_u_19.Character
		if not v25 then
			return v24
		end
		local v26 = v_u_20.getTouchingZones(v25, true, p23, v_u_21.player)
		for _, v27 in pairs(v26) do
			if v27.activeTriggers.localPlayer then
				local v28 = v_u_19
				local v29 = v24[v27]
				if not v29 then
					v29 = {}
					v24[v27] = v29
				end
				local v30 = v28:IsA("Player")
				if v30 then
					v30 = v28.Character
				end
				v29[v28] = v30 or true
			end
		end
		return v24
	end,
	["item"] = function(p31)
		-- upvalues: (copy) v_u_20, (copy) v_u_7, (ref) v_u_8
		return v_u_20._getZonesAndItems("item", v_u_7, v_u_8, true, p31)
	end
}
function v_u_20._registerZone(p33)
	-- upvalues: (copy) v_u_10, (copy) v_u_1, (copy) v_u_20
	v_u_10[p33] = true
	local v34 = p33.janitor:add(v_u_1.new(), "destroy")
	p33._registeredJanitor = v34
	v34:add(p33.updated:Connect(function()
		-- upvalues: (ref) v_u_20
		v_u_20._updateZoneDetails()
	end), "Disconnect")
	v_u_20._updateZoneDetails()
end
function v_u_20._deregisterZone(p35)
	-- upvalues: (copy) v_u_10, (copy) v_u_20
	v_u_10[p35] = nil
	p35._registeredJanitor:destroy()
	p35._registeredJanitor = nil
	v_u_20._updateZoneDetails()
end
function v_u_20._registerConnection(p36, p37)
	-- upvalues: (ref) v_u_15, (copy) v_u_7, (copy) v_u_20, (copy) v_u_9, (copy) v_u_32
	local v38 = p36.activeTriggers
	local v39 = 0
	for _, _ in pairs(v38) do
		v39 = v39 + 1
	end
	v_u_15 = v_u_15 + 1
	if v39 == 0 then
		v_u_7[p36] = true
		v_u_20._updateZoneDetails()
	end
	local v40 = v_u_9[p37]
	v_u_9[p37] = v40 and v40 + 1 or 1
	p36.activeTriggers[p37] = true
	if p36.touchedConnectionActions[p37] then
		p36:_formTouchedConnection(p37)
	end
	if v_u_32[p37] then
		v_u_20._formHeartbeat(p37)
	end
end
function v_u_20.updateDetection(p41)
	-- upvalues: (copy) v_u_3, (copy) v_u_5
	for v42, v43 in pairs({
		["enterDetection"] = "_currentEnterDetection",
		["exitDetection"] = "_currentExitDetection"
	}) do
		local v44 = p41[v42]
		local v45 = v_u_3.getCombinedTotalVolumes()
		if v44 == v_u_5.Detection.Automatic then
			if v45 > 729000 then
				v44 = v_u_5.Detection.Centre
			else
				v44 = v_u_5.Detection.WholeBody
			end
		end
		p41[v43] = v44
	end
end
function v_u_20._formHeartbeat(p_u_46)
	-- upvalues: (copy) v_u_18, (copy) v_u_17, (copy) v_u_7, (copy) v_u_20, (copy) v_u_32, (copy) v_u_5
	if not v_u_18[p_u_46] then
		local v_u_47 = 0
		v_u_18[p_u_46] = v_u_17:Connect(function()
			-- upvalues: (ref) v_u_47, (ref) v_u_7, (copy) p_u_46, (ref) v_u_20, (ref) v_u_32, (ref) v_u_5
			local v48 = os.clock()
			if v_u_47 <= v48 then
				local v49 = nil
				local v50 = nil
				for v51, _ in pairs(v_u_7) do
					if v51.activeTriggers[p_u_46] then
						local v52 = v51.accuracy
						if v49 ~= nil and v52 >= v49 then
							v52 = v49
						end
						v_u_20.updateDetection(v51)
						local v53 = v51._currentEnterDetection
						if v50 == nil or v53 < v50 then
							v50 = v53
							v49 = v52
						else
							v49 = v52
						end
					end
				end
				local v54 = v_u_32[p_u_46](v50)
				local v55 = {}
				local v56 = {}
				for v57, v58 in pairs(v54) do
					local v59 = v57.settingsGroupName
					if v59 then
						v59 = v_u_20.getGroup(v57.settingsGroupName)
					end
					if v59 and v59.onlyEnterOnceExitedAll == true then
						for v60, _ in pairs(v58) do
							local v61 = v55[v57.settingsGroupName]
							if not v61 then
								v61 = {}
								v55[v57.settingsGroupName] = v61
							end
							v61[v60] = v57
						end
						v56[v57] = v58
					end
				end
				for v62, v63 in pairs(v56) do
					local v64 = v55[v62.settingsGroupName]
					if v64 then
						for v65, _ in pairs(v63) do
							local v66 = v64[v65]
							if v66 and v66 ~= v62 then
								v63[v65] = nil
							end
						end
					end
				end
				local v67 = {
					{},
					{}
				}
				for v68, _ in pairs(v_u_7) do
					if v68.activeTriggers[p_u_46] then
						local v69 = v68.accuracy
						local v70 = v54[v68] or {}
						local v71 = false
						for _, _ in pairs(v70) do
							v71 = true
							break
						end
						if v71 then
							if v49 >= v69 then
								v69 = v49
							end
						else
							v69 = v49
						end
						local v72 = v68:_updateOccupants(p_u_46, v70)
						v67[1][v68] = v72.exited
						v67[2][v68] = v72.entered
						v49 = v69
					end
				end
				local v73 = { "Exited", "Entered" }
				for v74, v75 in pairs(v67) do
					local v76 = p_u_46 .. v73[v74]
					for v77, v78 in pairs(v75) do
						local v79 = v77[v76]
						if v79 then
							for _, v80 in pairs(v78) do
								v79:Fire(v80)
							end
						end
					end
				end
				v_u_47 = v48 + v_u_5.Accuracy.getProperty(v49)
			end
		end)
	end
end
function v_u_20._deregisterConnection(p81, p82)
	-- upvalues: (ref) v_u_15, (copy) v_u_9, (copy) v_u_18, (copy) v_u_7, (copy) v_u_20
	v_u_15 = v_u_15 - 1
	if v_u_9[p82] == 1 then
		v_u_9[p82] = nil
		local v83 = v_u_18[p82]
		if v83 then
			v_u_18[p82] = nil
			v83:Disconnect()
		end
	else
		local v84 = v_u_9
		v84[p82] = v84[p82] - 1
	end
	p81.activeTriggers[p82] = nil
	local v85 = p81.activeTriggers
	local v86 = 0
	for _, _ in pairs(v85) do
		v86 = v86 + 1
	end
	if v86 == 0 then
		v_u_7[p81] = nil
		v_u_20._updateZoneDetails()
	end
	if p81.touchedConnectionActions[p82] then
		p81:_disconnectTouchedConnection(p82)
	end
end
function v_u_20._updateZoneDetails()
	-- upvalues: (ref) v_u_11, (ref) v_u_12, (ref) v_u_13, (ref) v_u_14, (ref) v_u_8, (copy) v_u_10, (copy) v_u_7
	v_u_11 = {}
	v_u_12 = {}
	v_u_13 = {}
	v_u_14 = {}
	v_u_8 = 0
	for v87, _ in pairs(v_u_10) do
		local v88 = v_u_7[v87]
		if v88 then
			v_u_8 = v_u_8 + v87.volume
		end
		for _, v89 in pairs(v87.zoneParts) do
			if v88 then
				local v90 = v_u_11
				table.insert(v90, v89)
				v_u_12[v89] = v87
			end
			local v91 = v_u_13
			table.insert(v91, v89)
			v_u_14[v89] = v87
		end
	end
end
function v_u_20._getZonesAndItems(p92, p93, p94, p95, p96)
	-- upvalues: (copy) v_u_21, (copy) v_u_20, (copy) v_u_6, (copy) v_u_4
	if not p94 then
		for v97, _ in pairs(p93) do
			p94 = p94 + v97.volume
		end
	end
	local v98 = {}
	local v99 = v_u_21[p92]
	if v99.totalVolume < p94 then
		for _, v100 in pairs(v99.items) do
			local v101 = v_u_20.getTouchingZones(v100, p95, p96, v99)
			for _, v102 in pairs(v101) do
				if not p95 or v102.activeTriggers[p92] then
					local v103
					if p92 == "player" then
						v103 = v_u_6:GetPlayerFromCharacter(v100)
					else
						v103 = v100
					end
					if v103 then
						local v104 = v98[v102]
						if not v104 then
							v104 = {}
							v98[v102] = v104
						end
						local v105 = v103:IsA("Player")
						if v105 then
							v105 = v103.Character
						end
						v104[v103] = v105 or true
					end
				end
			end
		end
		return v98
	else
		for v106, _ in pairs(p93) do
			if not p95 or v106.activeTriggers[p92] then
				local v107 = v_u_4:GetPartBoundsInBox(v106.region.CFrame, v106.region.Size, v99.whitelistParams)
				local v108 = {}
				for _, v109 in pairs(v107) do
					local v110 = v99.partToItem[v109]
					if not v108[v110] then
						v108[v110] = true
					end
				end
				for v111, _ in pairs(v108) do
					if p92 == "player" then
						local v112 = v_u_6:GetPlayerFromCharacter(v111)
						if v106:findPlayer(v112) then
							local v113 = v98[v106]
							if not v113 then
								v113 = {}
								v98[v106] = v113
							end
							local v114 = v112:IsA("Player")
							if v114 then
								v114 = v112.Character
							end
							v113[v112] = v114 or true
						end
					elseif v106:findItem(v111) then
						local v115 = v98[v106]
						if not v115 then
							v115 = {}
							v98[v106] = v115
						end
						local v116 = v111:IsA("Player")
						if v116 then
							v116 = v111.Character
						end
						v115[v111] = v116 or true
					end
				end
			end
		end
		return v98
	end
end
function v_u_20.getZones()
	-- upvalues: (copy) v_u_10
	local v117 = {}
	for v118, _ in pairs(v_u_10) do
		table.insert(v117, v118)
	end
	return v117
end
function v_u_20.getTouchingZones(p119, p120, p121, p122)
	-- upvalues: (copy) v_u_5, (copy) v_u_3, (ref) v_u_11, (ref) v_u_13, (ref) v_u_12, (ref) v_u_14, (copy) v_u_4
	local v123
	if p122 then
		v123 = p122.exitDetections[p119]
		p122.exitDetections[p119] = nil
	else
		v123 = nil
	end
	local v124 = v123 or p121
	local v125 = nil
	local v126 = nil
	local v127 = p119:IsA("BasePart")
	local v128 = not v127
	local v129 = {}
	if v127 then
		v125 = p119.Size
		v126 = p119.CFrame
		table.insert(v129, p119)
	elseif v124 == v_u_5.Detection.WholeBody then
		v125, v126 = v_u_3.getCharacterSize(p119)
		v129 = p119:GetChildren()
	else
		local v130 = p119:FindFirstChild("HumanoidRootPart")
		if v130 then
			v125 = v130.Size
			v126 = v130.CFrame
			table.insert(v129, v130)
		end
	end
	if not (v125 and v126) then
		return {}
	end
	local v131 = p120 and v_u_11 or v_u_13
	local v132 = p120 and v_u_12 or v_u_14
	local v133 = OverlapParams.new()
	v133.FilterType = Enum.RaycastFilterType.Whitelist
	v133.MaxParts = #v131
	v133.FilterDescendantsInstances = v131
	local v134 = v_u_4:GetPartBoundsInBox(v126, v125, v133)
	local v135 = {}
	local v136 = {}
	local v137 = {}
	for _, v138 in pairs(v134) do
		local v139 = v132[v138]
		if v139 and v139.allZonePartsAreBlocks then
			v135[v139] = true
			v136[v138] = v139
		else
			table.insert(v137, v138)
		end
	end
	local v140 = #v137
	local v141 = 0
	if v140 > 0 then
		local v142 = OverlapParams.new()
		v142.FilterType = Enum.RaycastFilterType.Whitelist
		v142.MaxParts = v140
		v142.FilterDescendantsInstances = v137
		for _, v143 in pairs(v129) do
			local v144 = false
			if v143:IsA("BasePart") and not (v128 and v_u_3.bodyPartsToIgnore[v143.Name]) then
				local v145 = v_u_4:GetPartsInPart(v143, v142)
				for _, v146 in pairs(v145) do
					if not v136[v146] then
						local v147 = v132[v146]
						if v147 then
							v135[v147] = true
							v136[v146] = v147
							v141 = v141 + 1
						end
						if v141 == v140 then
							v144 = true
							break
						end
					end
				end
				if v144 then
					break
				end
			end
		end
	end
	local v148 = nil
	local v149 = {}
	for v150, _ in pairs(v135) do
		if v148 == nil or v150._currentExitDetection < v148 then
			v148 = v150._currentExitDetection
		end
		table.insert(v149, v150)
	end
	if v148 and p122 then
		p122.exitDetections[p119] = v148
	end
	return v149, v136
end
local v_u_151 = {}
function v_u_20.setGroup(p152, p153)
	-- upvalues: (copy) v_u_151
	local v154 = v_u_151[p152]
	if not v154 then
		v154 = {}
		v_u_151[p152] = v154
	end
	v154.onlyEnterOnceExitedAll = true
	v154._name = p152
	v154._memberZones = {}
	if typeof(p153) == "table" then
		for v155, v156 in pairs(p153) do
			v154[v155] = v156
		end
	end
	return v154
end
function v_u_20.getGroup(p157)
	-- upvalues: (copy) v_u_151
	return v_u_151[p157]
end
local v_u_158 = nil
local v_u_159 = string.format("ZonePlus%sContainer", v16:IsClient() and "Client" or "Server")
function v_u_20.getWorkspaceContainer()
	-- upvalues: (ref) v_u_158, (copy) v_u_159
	local v160 = v_u_158 or workspace:FindFirstChild(v_u_159)
	if not v160 then
		v160 = Instance.new("Folder")
		v160.Name = v_u_159
		v160.Parent = workspace
		v_u_158 = v160
	end
	return v160
end
return v_u_20]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ZoneController]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3331"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
local v_u_2 = nil
local v_u_3 = game:GetService("RunService")
function v1.setupWorldModel(_)
	-- upvalues: (ref) v_u_2, (copy) v_u_3
	if v_u_2 then
		return v_u_2
	end
	local v4 = v_u_3:IsClient() and "ReplicatedStorage" or "ServerStorage"
	v_u_2 = Instance.new("WorldModel")
	v_u_2.Name = "ZonePlusWorldModel"
	v_u_2.Parent = game:GetService(v4)
	return v_u_2
end
function v1._getCombinedResults(_, p5, ...)
	-- upvalues: (ref) v_u_2
	local v6 = workspace[p5](workspace, ...)
	if v_u_2 then
		local v7 = v_u_2[p5](v_u_2, ...)
		for _, v8 in pairs(v7) do
			table.insert(v6, v8)
		end
	end
	return v6
end
function v1.GetPartBoundsInBox(p9, p10, p11, p12)
	return p9:_getCombinedResults("GetPartBoundsInBox", p10, p11, p12)
end
function v1.GetPartBoundsInRadius(p13, p14, p15, p16)
	return p13:_getCombinedResults("GetPartBoundsInRadius", p14, p15, p16)
end
function v1.GetPartsInPart(p17, p18, p19)
	return p17:_getCombinedResults("GetPartsInPart", p18, p19)
end
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CollectiveWorldModel]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3332"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local _ = game:GetService("RunService").Heartbeat
local v2 = require(script.Parent.Parent.Signal)
local v_u_3 = require(script.Parent.Parent.Janitor)
local v_u_4 = {}
v_u_4.__index = v_u_4
local v_u_5 = {}
v_u_4.trackers = v_u_5
v_u_4.itemAdded = v2.new()
v_u_4.itemRemoved = v2.new()
v_u_4.bodyPartsToIgnore = {
	["UpperTorso"] = true,
	["LowerTorso"] = true,
	["Torso"] = true,
	["LeftHand"] = true,
	["RightHand"] = true,
	["LeftFoot"] = true,
	["RightFoot"] = true
}
function v_u_4.getCombinedTotalVolumes()
	-- upvalues: (copy) v_u_5
	local v6 = 0
	for v7, _ in pairs(v_u_5) do
		v6 = v6 + v7.totalVolume
	end
	return v6
end
function v_u_4.getCharacterSize(p8)
	local v9
	if p8 then
		v9 = p8:FindFirstChild("Head")
	else
		v9 = p8
	end
	if p8 then
		p8 = p8:FindFirstChild("HumanoidRootPart")
	end
	if not (p8 and v9) then
		return nil
	end
	if not v9:IsA("BasePart") then
		v9 = p8
	end
	local v10 = v9.Size.Y
	local v11 = p8.Size
	return v11 * Vector3.new(2, 2, 1) + Vector3.new(0, v10, 0), p8.CFrame * CFrame.new(0, v10 / 2 - v11.Y / 2, 0)
end
function v_u_4.new(p12)
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_1, (copy) v_u_5
	local v_u_13 = {}
	local v14 = v_u_4
	setmetatable(v_u_13, v14)
	v_u_13.name = p12
	v_u_13.totalVolume = 0
	v_u_13.parts = {}
	v_u_13.partToItem = {}
	v_u_13.items = {}
	v_u_13.whitelistParams = nil
	v_u_13.characters = {}
	v_u_13.baseParts = {}
	v_u_13.exitDetections = {}
	v_u_13.janitor = v_u_3.new()
	if p12 == "player" then
		local function v_u_18()
			-- upvalues: (ref) v_u_1, (copy) v_u_13
			local v15 = {}
			for _, v16 in pairs(v_u_1:GetPlayers()) do
				local v17 = v16.Character
				if v17 then
					v15[v17] = true
				end
			end
			v_u_13.characters = v15
		end
		local function v25(p19)
			-- upvalues: (copy) v_u_18, (copy) v_u_13
			local function v23(p20)
				-- upvalues: (ref) v_u_18, (ref) v_u_13
				local v21 = p20:WaitForChild("Humanoid", 3)
				if v21 then
					v_u_18()
					v_u_13:update()
					for _, v22 in pairs(v21:GetChildren()) do
						if v22:IsA("NumberValue") then
							v22.Changed:Connect(function()
								-- upvalues: (ref) v_u_13
								v_u_13:update()
							end)
						end
					end
				end
			end
			if p19.Character then
				v23(p19.Character)
			end
			p19.CharacterAdded:Connect(v23)
			p19.CharacterRemoving:Connect(function(p24)
				-- upvalues: (ref) v_u_13
				v_u_13.exitDetections[p24] = nil
			end)
		end
		v_u_1.PlayerAdded:Connect(v25)
		for _, v26 in pairs(v_u_1:GetPlayers()) do
			v25(v26)
		end
		v_u_1.PlayerRemoving:Connect(function(_)
			-- upvalues: (copy) v_u_18, (copy) v_u_13
			v_u_18()
			v_u_13:update()
		end)
	elseif p12 == "item" then
		v_u_4.itemAdded:Connect(function(p27)
			-- upvalues: (copy) v_u_13
			if p27.isCharacter then
				v_u_13.characters[p27.item] = true
			elseif p27.isBasePart then
				v_u_13.baseParts[p27.item] = true
			end
			v_u_13:update()
		end)
		v_u_4.itemRemoved:Connect(function(p28)
			-- upvalues: (copy) v_u_13
			v_u_13.exitDetections[p28.item] = nil
			if p28.isCharacter then
				v_u_13.characters[p28.item] = nil
			elseif p28.isBasePart then
				v_u_13.baseParts[p28.item] = nil
			end
			v_u_13:update()
		end)
	end
	v_u_5[v_u_13] = true
	task.defer(v_u_13.update, v_u_13)
	return v_u_13
end
function v_u_4._preventMultiFrameUpdates(p_u_29, p_u_30, ...)
	p_u_29._preventMultiDetails = p_u_29._preventMultiDetails or {}
	local v_u_31 = p_u_29._preventMultiDetails[p_u_30]
	if not v_u_31 then
		v_u_31 = {
			["calling"] = false,
			["callsThisFrame"] = 0,
			["updatedThisFrame"] = false
		}
		p_u_29._preventMultiDetails[p_u_30] = v_u_31
	end
	v_u_31.callsThisFrame = v_u_31.callsThisFrame + 1
	if v_u_31.callsThisFrame ~= 1 then
		return true
	end
	local v_u_32 = table.pack(...)
	task.defer(function()
		-- upvalues: (ref) v_u_31, (copy) p_u_29, (copy) p_u_30, (copy) v_u_32
		local v33 = v_u_31.callsThisFrame
		v_u_31.callsThisFrame = 0
		if v33 > 1 then
			local v34 = v_u_32
			p_u_29[p_u_30](p_u_29, unpack(v34))
		end
	end)
	return false
end
function v_u_4.update(p_u_35)
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	if not p_u_35:_preventMultiFrameUpdates("update") then
		p_u_35.totalVolume = 0
		p_u_35.parts = {}
		p_u_35.partToItem = {}
		p_u_35.items = {}
		for v_u_36, _ in pairs(p_u_35.characters) do
			local v37 = v_u_4.getCharacterSize(v_u_36)
			if v37 then
				local v38 = v37.X * v37.Y * v37.Z
				p_u_35.totalVolume = p_u_35.totalVolume + v38
				local v39 = p_u_35.janitor:add(v_u_3.new(), "destroy", "trackCharacterParts-" .. p_u_35.name)
				local v_u_40 = v39
				for _, v_u_41 in pairs(v_u_36:GetChildren()) do
					if v_u_41:IsA("BasePart") and not v_u_4.bodyPartsToIgnore[v_u_41.Name] then
						p_u_35.partToItem[v_u_41] = v_u_36
						local v42 = p_u_35.parts
						table.insert(v42, v_u_41)
						v_u_40:add(v_u_41.AncestryChanged:Connect(function()
							-- upvalues: (copy) v_u_41, (ref) v_u_40, (copy) p_u_35
							if not v_u_41:IsDescendantOf(game) and (v_u_41.Parent == nil and v_u_40 ~= nil) then
								v_u_40:destroy()
								v_u_40 = nil
								p_u_35:update()
							end
						end), "Disconnect")
					end
				end
				v_u_40:add(v_u_36.AncestryChanged:Connect(function()
					-- upvalues: (copy) v_u_36, (ref) v_u_40, (copy) p_u_35
					if not v_u_36:IsDescendantOf(game) and (v_u_36.Parent == nil and v_u_40 ~= nil) then
						v_u_40:destroy()
						v_u_40 = nil
						p_u_35:update()
					end
				end), "Disconnect")
				local v43 = p_u_35.items
				table.insert(v43, v_u_36)
			end
		end
		for v44, _ in pairs(p_u_35.baseParts) do
			local v45 = v44.Size
			local v46 = v45.X * v45.Y * v45.Z
			p_u_35.totalVolume = p_u_35.totalVolume + v46
			p_u_35.partToItem[v44] = v44
			local v47 = p_u_35.parts
			table.insert(v47, v44)
			local v48 = p_u_35.items
			table.insert(v48, v44)
		end
		p_u_35.whitelistParams = OverlapParams.new()
		p_u_35.whitelistParams.FilterType = Enum.RaycastFilterType.Whitelist
		p_u_35.whitelistParams.MaxParts = #p_u_35.parts
		p_u_35.whitelistParams.FilterDescendantsInstances = p_u_35.parts
	end
end
return v_u_4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Tracker]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3333"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("ReplicatedStorage")
return {
	["addToReplicatedStorage"] = function()
		-- upvalues: (copy) v_u_1
		if v_u_1:FindFirstChild(script.Name) then
			return false
		end
		local v2 = Instance.new("ObjectValue")
		v2.Name = script.Name
		v2.Value = script.Parent
		v2.Parent = v_u_1
		local v3 = Instance.new("BoolValue")
		v3.Name = game:GetService("RunService"):IsClient() and "Client" or "Server"
		v3.Value = true
		v3.Parent = v2
		return v2
	end,
	["getObject"] = function()
		-- upvalues: (copy) v_u_1
		return v_u_1:FindFirstChild(script.Name) or false
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ZonePlusReference]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3334"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[pepeeltoro41_ui-labs@2.4.2]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3335"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Controls.PrimitiveControls)
local v2 = require(script.Controls.DatatypeControls)
local v3 = require(script.Controls.AdvancedControls)
local v4 = require(script.StoryCreators)
local v5 = require(script.Controls.ControlUtils)
local v6 = require(script.Controls.ControlConversion)
local v7 = require(script.Utils)
local v8 = require(script.Environment)
require(script.Types)
return {
	["_version"] = require(script.Version),
	["Boolean"] = v1.Boolean,
	["Number"] = v1.Number,
	["String"] = v1.String,
	["Choose"] = v3.Choose,
	["EnumList"] = v3.EnumList,
	["Object"] = v3.Object,
	["RGBA"] = v3.RGBA,
	["Slider"] = v3.Slider,
	["Primitive"] = v1.Primitive,
	["Advanced"] = v3,
	["Datatype"] = v2,
	["ListenControl"] = v7.ListenControl,
	["CreateControlStates"] = v7.CreateControlStates,
	["UpdateControlStates"] = v7.UpdateControlStates,
	["ControlGroup"] = v5.ControlGroup,
	["Ordered"] = v5.Ordered,
	["ConvertControl"] = v6.ConvertControl,
	["CreateGenericStory"] = v4.CreateGenericStory,
	["CreateReactStory"] = v4.CreateReactStory,
	["CreateRoactStory"] = v4.CreateRoactStory,
	["CreateFusionStory"] = v4.CreateFusionStory,
	["CreateIrisStory"] = v4.CreateIrisStory,
	["CreateVideStory"] = v4.CreateVideStory,
	["Environment"] = v8
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ui-labs]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3336"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("UserInputService")
local v_u_2 = {
	["EnvGlobalInjectionKey"] = "__hotreload_env_global_injection__"
}
function SearchInEnv(p3, p4)
	-- upvalues: (copy) v_u_2
	local v5 = v_u_2.GetEnvGlobalInjection()
	if v5 then
		p4 = v5[p3] or p4
	end
	return p4
end
function v_u_2.GetEnvGlobalInjection()
	-- upvalues: (copy) v_u_2
	return getfenv()[v_u_2.EnvGlobalInjectionKey]
end
function v_u_2.IsStory()
	-- upvalues: (copy) v_u_2
	return v_u_2.GetEnvGlobalInjection() ~= nil
end
function UserInputFallback(p6)
	-- upvalues: (copy) v_u_1
	if not p6 then
		return v_u_1
	end
	if p6 == v_u_1 then
		return v_u_1
	end
	local v7 = table.clone(p6)
	local v10 = {
		["__index"] = function(_, p8)
			-- upvalues: (ref) v_u_1
			local v_u_9 = v_u_1[p8]
			return typeof(v_u_9) == "function" and function(_, ...)
				-- upvalues: (copy) v_u_9, (ref) v_u_1
				return v_u_9(v_u_1, ...)
			end or v_u_9
		end
	}
	return setmetatable(v7, v10)
end
v_u_2.Unmount = SearchInEnv("Unmount", function() end)
v_u_2.Reload = SearchInEnv("Reload", function() end)
v_u_2.CreateSnapshot = SearchInEnv("CreateSnapshot", function() end)
v_u_2.SetStoryHolder = SearchInEnv("SetStoryHolder", function() end)
function v_u_2.GetJanitor()
	return SearchInEnv("StoryJanitor")
end
v_u_2.InputListener = SearchInEnv("InputListener", nil)
v_u_2.UserInput = UserInputFallback(SearchInEnv("InputListener", v_u_1))
v_u_2.EnvironmentUID = SearchInEnv("EnvironmentUID", "")
v_u_2.PreviewUID = SearchInEnv("PreviewUID", "")
v_u_2.OriginalG = SearchInEnv("OriginalG", _G)
v_u_2.PluginWidget = SearchInEnv("PluginWidget", nil)
v_u_2.Plugin = SearchInEnv("Plugin", plugin)
return v_u_2]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Environment]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3337"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
require(script.Parent.Types)
function v1.CreateRoactStory(p2, p3)
	local v4 = {
		["use"] = "roact",
		["story"] = p3
	}
	for v5, v6 in pairs(p2) do
		v4[v5] = v6
	end
	return v4
end
function v1.CreateReactStory(p7, p8)
	local v9 = {
		["use"] = "react",
		["story"] = p8
	}
	for v10, v11 in pairs(p7) do
		v9[v10] = v11
	end
	return v9
end
function v1.CreateFusionStory(p12, p13)
	local v14 = {
		["use"] = "fusion",
		["story"] = p13
	}
	for v15, v16 in pairs(p12) do
		v14[v15] = v16
	end
	return v14
end
function v1.CreateIrisStory(p17, p18)
	local v19 = {
		["use"] = "iris",
		["story"] = p18
	}
	for v20, v21 in pairs(p17) do
		v19[v20] = v21
	end
	return v19
end
function v1.CreateVideStory(p22, p23)
	local v24 = {
		["use"] = "Vide",
		["story"] = p23
	}
	for v25, v26 in pairs(p22) do
		v24[v25] = v26
	end
	return v24
end
function v1.CreateGenericStory(p27, p28)
	local v29 = {
		["render"] = p28
	}
	for v30, v31 in pairs(p27) do
		v29[v30] = v31
	end
	return v29
end
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[StoryCreators]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3338"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return nil]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Types]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3339"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
require(script.Parent.Types)
function v_u_1.ListenControl(p2, p3)
	local v4 = p2.__old
	local v5 = p2.__new
	if v4 ~= v5 then
		p3(v5)
	end
end
function v_u_1.CreateControlStates(p6, p7, p8)
	-- upvalues: (copy) v_u_1
	local v9 = {}
	for v10, v11 in pairs(p6) do
		local v12 = p7[v10]
		if v11.EntryType == "ControlGroup" then
			v9[v10] = v_u_1.CreateControlStates(v11.Controls, v12, p8)
		else
			v9[v10] = p8(v12)
		end
	end
	return v9
end
function v_u_1.UpdateControlStates(p13, p14, p15, p16)
	-- upvalues: (copy) v_u_1
	for v17, v18 in pairs(p14) do
		local v19 = p15[v17]
		if v18.EntryType == "ControlGroup" then
			v_u_1.UpdateControlStates(p13[v17], v18.Controls, v19, p16)
		else
			p16(p13[v17], v19)
		end
	end
end
return v_u_1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Utils]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3340"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return "2.4.2"]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Version]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="3341"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ControlTypings]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="3342"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Controls]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3343"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Utils).CreateBaseControl
return {
	["Choose"] = function(p2, p3)
		-- upvalues: (copy) v_u_1
		if #p2 <= 0 then
			error("UI-Labs: Array given in a Choose control is empty")
		end
		if p3 and #p2 < p3 then
			error((("UI-Labs: Def index (%*) given for the array is outside of the array size (%*)"):format(p3, #p2)))
		end
		local v4 = v_u_1("Choose", p2[p3 or 1])
		v4.List = p2
		v4.DefIndex = p3 or 1
		return v4
	end,
	["EnumList"] = function(p5, p6)
		-- upvalues: (copy) v_u_1
		if p5[p6] == nil then
			error((("UI-Labs: Key given for the EnumList list (%*) does not exist in the list"):format(p6)))
		end
		local v7 = v_u_1("EnumList", p5[p6])
		v7.List = p5
		v7.DefIndex = p6
		return v7
	end,
	["RGBA"] = function(p8, p9)
		-- upvalues: (copy) v_u_1
		return v_u_1("RGBA", {
			["Color"] = p8,
			["Transparency"] = p9 or 0
		})
	end,
	["Slider"] = function(p10, p11, p12, p13)
		-- upvalues: (copy) v_u_1
		if p12 <= p11 then
			error((("UI-Labs: Max slider value (%*) must be greater than the Min value (%*)"):format(p12, p11)))
		end
		local v14 = v_u_1("Slider", p10)
		v14.Min = p11
		v14.Max = p12
		v14.Step = p13
		return v14
	end,
	["Object"] = function(p15, p16, p17)
		-- upvalues: (copy) v_u_1
		local v18 = v_u_1("Object", p16)
		v18.ClassName = p15 or "Instance"
		v18.Predicator = p17
		return v18
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AdvancedControls]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3344"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.PrimitiveControls).Primitive
local v_u_2 = require(script.Parent.DatatypeControls)
local v3 = {}
local function v_u_8(p4, p5)
	-- upvalues: (copy) v_u_1
	local v6 = v_u_1[p5]
	local v7 = ("UI-Labs: Primitive (%*) can\'t be converted to a control"):format(p5)
	assert(v6, v7)
	return v6(p4)
end
local function v_u_13(p9, p10)
	-- upvalues: (copy) v_u_2
	local v11 = v_u_2[p10]
	local v12 = ("UI-Labs: Datatype (%*) can\'t be converted to a control"):format(p10)
	assert(v11, v12)
	return v11(p9)
end
function v3.ConvertControl(p14)
	-- upvalues: (copy) v_u_1, (copy) v_u_8, (copy) v_u_2, (copy) v_u_13
	local v15 = typeof(p14)
	if v15 == "table" then
		return p14
	end
	if v_u_1[v15] then
		return v_u_8(p14, v15)
	end
	if v_u_2[v15] then
		return v_u_13(p14, v15)
	end
	error((("UI-Labs: Control (%*) is not a valid control"):format(p14)))
end
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ControlConversion]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3345"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.ControlConversion)
return {
	["ControlGroup"] = function(p2)
		return {
			["EntryType"] = "ControlGroup",
			["Controls"] = p2
		}
	end,
	["Ordered"] = function(p3, p4)
		-- upvalues: (copy) v_u_1
		local v5 = v_u_1.ConvertControl(p3)
		v5.Order = p4
		return v5
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ControlUtils]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3346"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Utils).CreateBaseControl
return {
	["Color3"] = function(p2)
		-- upvalues: (copy) v_u_1
		local v3 = Color3.new
		local v4 = p2.R
		local v5 = math.clamp(v4, 0, 1)
		local v6 = p2.G
		local v7 = math.clamp(v6, 0, 1)
		local v8 = p2.B
		return v_u_1("Color3", (v3(v5, v7, (math.clamp(v8, 0, 1)))))
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[DatatypeControls]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3347"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Utils).CreateBaseControl
local v13 = {
	["String"] = function(p2, p3)
		-- upvalues: (copy) v_u_1
		local v4 = v_u_1("String", p2)
		v4.Filters = p3
		return v4
	end,
	["Number"] = function(p5, p6, p7, p8, p9, p10)
		-- upvalues: (copy) v_u_1
		local v11 = v_u_1("Number", p5)
		v11.Min = p6
		v11.Max = p7
		v11.Step = p8
		v11.Dragger = p9 == nil and true or p9
		v11.Sensibility = p10 or p5 * 10
		return v11
	end,
	["Boolean"] = function(p12)
		-- upvalues: (copy) v_u_1
		return v_u_1("Boolean", p12)
	end
}
v13.Primitive = {
	["string"] = v13.String,
	["number"] = v13.Number,
	["boolean"] = v13.Boolean
}
return v13]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PrimitiveControls]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3348"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["CreateBaseControl"] = function(p1, p2)
		return {
			["EntryType"] = "Control",
			["Type"] = p1,
			["ControlValue"] = p2
		}
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Utils]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3349"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Libraries]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="3350"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Typing]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3351"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[sleitnick_observers@0.3.4]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3352"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["observeTag"] = require(script.observeTag),
	["observeAttribute"] = require(script.observeAttribute),
	["observeProperty"] = require(script.observeProperty),
	["observePlayer"] = require(script.observePlayer),
	["observeCharacter"] = require(script.observeCharacter)
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[observers]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3353"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local function v_u_1(_)
	return true
end
return function(p_u_2, p_u_3, p_u_4, p_u_5)
	-- upvalues: (copy) v_u_1
	local v_u_6 = nil
	local v_u_7 = nil
	local v_u_8 = 0
	if p_u_5 == nil then
		p_u_5 = v_u_1
	end
	local function v_u_12()
		-- upvalues: (ref) v_u_6, (ref) v_u_8, (copy) p_u_2, (copy) p_u_3, (copy) p_u_5, (copy) p_u_4, (ref) v_u_7
		if v_u_6 ~= nil then
			task.spawn(v_u_6)
			v_u_6 = nil
		end
		v_u_8 = v_u_8 + 1
		local v_u_9 = v_u_8
		local v_u_10 = p_u_2:GetAttribute(p_u_3)
		if v_u_10 ~= nil and p_u_5(v_u_10) then
			task.spawn(function()
				-- upvalues: (ref) p_u_4, (copy) v_u_10, (copy) v_u_9, (ref) v_u_8, (ref) v_u_7, (ref) v_u_6
				local v11 = p_u_4(v_u_10)
				if v_u_9 == v_u_8 and v_u_7.Connected then
					v_u_6 = v11
				else
					task.spawn(v11)
				end
			end)
		end
	end
	local v_u_13 = p_u_2:GetAttributeChangedSignal(p_u_3):Connect(v_u_12)
	task.defer(function()
		-- upvalues: (ref) v_u_13, (copy) v_u_12
		if v_u_13.Connected then
			v_u_12()
		end
	end)
	return function()
		-- upvalues: (ref) v_u_13, (ref) v_u_6
		v_u_13:Disconnect()
		if v_u_6 ~= nil then
			task.spawn(v_u_6)
			v_u_6 = nil
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[observeAttribute]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3354"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.observePlayer)
return function(p_u_2)
	-- upvalues: (copy) v_u_1
	return v_u_1(function(p_u_3)
		-- upvalues: (copy) p_u_2
		local v_u_4 = nil
		local v_u_5 = nil
		local function v_u_11(p_u_6)
			-- upvalues: (ref) p_u_2, (copy) p_u_3, (ref) v_u_5, (ref) v_u_4
			local v_u_7 = nil
			task.defer(function()
				-- upvalues: (ref) p_u_2, (ref) p_u_3, (copy) p_u_6, (ref) v_u_5, (ref) v_u_7, (ref) v_u_4
				local v8 = p_u_2(p_u_3, p_u_6)
				if typeof(v8) == "function" then
					if v_u_5.Connected and p_u_6.Parent then
						v_u_7 = v8
						v_u_4 = v8
						return
					end
					task.spawn(v8)
				end
			end)
			local v_u_9 = nil
			v_u_9 = p_u_6.AncestryChanged:Connect(function(_, p10)
				-- upvalues: (ref) v_u_9, (ref) v_u_7, (ref) v_u_4
				if p10 == nil and v_u_9.Connected then
					v_u_9:Disconnect()
					if v_u_7 ~= nil then
						task.spawn(v_u_7)
						if v_u_4 == v_u_7 then
							v_u_4 = nil
						end
						v_u_7 = nil
					end
				end
			end)
		end
		v_u_5 = p_u_3.CharacterAdded:Connect(v_u_11)
		task.defer(function()
			-- upvalues: (copy) p_u_3, (ref) v_u_5, (copy) v_u_11
			if p_u_3.Character and v_u_5.Connected then
				task.spawn(v_u_11, p_u_3.Character)
			end
		end)
		return function()
			-- upvalues: (ref) v_u_5, (ref) v_u_4
			v_u_5:Disconnect()
			if v_u_4 ~= nil then
				task.spawn(v_u_4)
				v_u_4 = nil
			end
		end
	end)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[observeCharacter]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3355"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
return function(p_u_2)
	-- upvalues: (copy) v_u_1
	local v_u_3 = nil
	local v_u_4 = {}
	local function v_u_7(p_u_5)
		-- upvalues: (ref) v_u_3, (copy) p_u_2, (copy) v_u_4
		if v_u_3.Connected then
			task.spawn(function()
				-- upvalues: (ref) p_u_2, (copy) p_u_5, (ref) v_u_3, (ref) v_u_4
				local v6 = p_u_2(p_u_5)
				if typeof(v6) == "function" then
					if v_u_3.Connected and p_u_5.Parent then
						v_u_4[p_u_5] = v6
						return
					end
					task.spawn(v6)
				end
			end)
		end
	end
	v_u_3 = v_u_1.PlayerAdded:Connect(v_u_7)
	local v_u_10 = v_u_1.PlayerRemoving:Connect(function(p8)
		-- upvalues: (copy) v_u_4
		local v9 = v_u_4[p8]
		v_u_4[p8] = nil
		if typeof(v9) == "function" then
			task.spawn(v9)
		end
	end)
	task.defer(function()
		-- upvalues: (ref) v_u_3, (ref) v_u_1, (copy) v_u_7
		if v_u_3.Connected then
			for _, v11 in v_u_1:GetPlayers() do
				task.spawn(v_u_7, v11)
			end
		end
	end)
	return function()
		-- upvalues: (ref) v_u_3, (ref) v_u_10, (copy) v_u_4
		v_u_3:Disconnect()
		v_u_10:Disconnect()
		local v12 = next(v_u_4)
		while v12 do
			local v13 = v_u_4[v12]
			v_u_4[v12] = nil
			if typeof(v13) == "function" then
				task.spawn(v13)
			end
			v12 = next(v_u_4)
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[observePlayer]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3356"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p_u_1, p_u_2, p_u_3)
	local v_u_4 = nil
	local v_u_5 = nil
	local v_u_6 = 0
	local function v10()
		-- upvalues: (ref) v_u_4, (ref) v_u_6, (copy) p_u_1, (copy) p_u_2, (copy) p_u_3, (ref) v_u_5
		if v_u_4 ~= nil then
			task.spawn(v_u_4)
			v_u_4 = nil
		end
		v_u_6 = v_u_6 + 1
		local v_u_7 = v_u_6
		local v_u_8 = p_u_1[p_u_2]
		task.spawn(function()
			-- upvalues: (ref) p_u_3, (copy) v_u_8, (copy) v_u_7, (ref) v_u_6, (ref) v_u_5, (ref) v_u_4
			local v9 = p_u_3(v_u_8)
			if v_u_7 == v_u_6 and v_u_5.Connected then
				v_u_4 = v9
			else
				task.spawn(v9)
			end
		end)
	end
	v_u_5 = p_u_1:GetPropertyChangedSignal(p_u_2):Connect(v10)
	task.defer(function()
		-- upvalues: (ref) v_u_5, (ref) v_u_4, (ref) v_u_6, (copy) p_u_1, (copy) p_u_2, (copy) p_u_3
		if v_u_5.Connected then
			if v_u_4 ~= nil then
				task.spawn(v_u_4)
				v_u_4 = nil
			end
			v_u_6 = v_u_6 + 1
			local v_u_11 = v_u_6
			local v_u_12 = p_u_1[p_u_2]
			task.spawn(function()
				-- upvalues: (ref) p_u_3, (copy) v_u_12, (copy) v_u_11, (ref) v_u_6, (ref) v_u_5, (ref) v_u_4
				local v13 = p_u_3(v_u_12)
				if v_u_11 == v_u_6 and v_u_5.Connected then
					v_u_4 = v13
				else
					task.spawn(v13)
				end
			end)
		end
	end)
	return function()
		-- upvalues: (ref) v_u_5, (ref) v_u_4
		v_u_5:Disconnect()
		if v_u_4 ~= nil then
			task.spawn(v_u_4)
			v_u_4 = nil
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[observeProperty]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3357"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("CollectionService")
function observeTag(p_u_2, p_u_3, p_u_4)
	-- upvalues: (copy) v_u_1
	local v_u_5 = {}
	local v_u_6 = {}
	local v_u_7 = nil
	local function v_u_32(p_u_8)
		-- upvalues: (ref) v_u_7, (copy) v_u_5, (copy) v_u_6, (copy) p_u_4, (copy) p_u_3, (copy) p_u_2
		if not v_u_7.Connected then
			return
		end
		if v_u_5[p_u_8] ~= nil then
			return
		end
		v_u_5[p_u_8] = "__dead__"
		v_u_6[p_u_8] = p_u_8.AncestryChanged:Connect(function()
			-- upvalues: (copy) p_u_8, (ref) p_u_4, (ref) v_u_5, (ref) p_u_3, (ref) p_u_2
			local v_u_9 = p_u_8
			local v10
			if p_u_4 == nil then
				v10 = true
				::l3::
				if v10 then
					if v_u_5[v_u_9] == "__dead__" then
						v_u_5[v_u_9] = "__inflight__"
						task.defer(function()
							-- upvalues: (ref) v_u_5, (copy) v_u_9, (ref) p_u_3, (ref) p_u_2
							if v_u_5[v_u_9] == "__inflight__" then
								local v14, v15 = xpcall(function(p11)
									-- upvalues: (ref) p_u_3
									local v12 = p_u_3(p11)
									if v12 ~= nil then
										local v13 = typeof(v12) == "function"
										assert(v13, "callback must return a function or nil")
									end
									return v12
								end, debug.traceback, v_u_9)
								if v14 then
									if v_u_5[v_u_9] == "__inflight__" then
										v_u_5[v_u_9] = v15
									elseif v15 ~= nil then
										task.spawn(v15)
										return
									end
								else
									local v16 = string.split(v15, "\n")[1]
									local v17 = string.find(v16, ": ")
									local v18 = not v17 and "" or v16:sub(v17 + 1)
									warn((("error while calling observeTag(\"%*\") callback:%*\n%*"):format(p_u_2, v18, v15)))
								end
							else
								return
							end
						end)
						return
					end
				else
					local v19 = v_u_5[v_u_9]
					v_u_5[v_u_9] = "__dead__"
					if typeof(v19) == "function" then
						task.spawn(v19)
					end
				end
				return
			else
				for _, v20 in p_u_4 do
					if v_u_9:IsDescendantOf(v20) then
						v10 = true
						goto l3
					end
				end
				v10 = false
				goto l3
			end
		end)
		local v21
		if p_u_4 == nil then
			v21 = true
			::l7::
			if v21 then
				if v_u_5[p_u_8] == "__dead__" then
					v_u_5[p_u_8] = "__inflight__"
					task.defer(function()
						-- upvalues: (ref) v_u_5, (copy) p_u_8, (ref) p_u_3, (ref) p_u_2
						if v_u_5[p_u_8] == "__inflight__" then
							local v25, v26 = xpcall(function(p22)
								-- upvalues: (ref) p_u_3
								local v23 = p_u_3(p22)
								if v23 ~= nil then
									local v24 = typeof(v23) == "function"
									assert(v24, "callback must return a function or nil")
								end
								return v23
							end, debug.traceback, p_u_8)
							if v25 then
								if v_u_5[p_u_8] == "__inflight__" then
									v_u_5[p_u_8] = v26
								elseif v26 ~= nil then
									task.spawn(v26)
									return
								end
							else
								local v27 = string.split(v26, "\n")[1]
								local v28 = string.find(v27, ": ")
								local v29 = not v28 and "" or v27:sub(v28 + 1)
								warn((("error while calling observeTag(\"%*\") callback:%*\n%*"):format(p_u_2, v29, v26)))
							end
						else
							return
						end
					end)
					return
				end
			else
				local v30 = v_u_5[p_u_8]
				v_u_5[p_u_8] = "__dead__"
				if typeof(v30) == "function" then
					task.spawn(v30)
				end
			end
			return
		else
			for _, v31 in p_u_4 do
				if p_u_8:IsDescendantOf(v31) then
					v21 = true
					goto l7
				end
			end
			v21 = false
			goto l7
		end
	end
	v_u_7 = v_u_1:GetInstanceAddedSignal(p_u_2):Connect(v_u_32)
	local v_u_36 = v_u_1:GetInstanceRemovedSignal(p_u_2):Connect(function(p33)
		-- upvalues: (copy) v_u_5, (copy) v_u_6
		local v34 = v_u_5[p33]
		v_u_5[p33] = "__dead__"
		if typeof(v34) == "function" then
			task.spawn(v34)
		end
		local v35 = v_u_6[p33]
		if v35 then
			v35:Disconnect()
			v_u_6[p33] = nil
		end
		v_u_5[p33] = nil
	end)
	task.defer(function()
		-- upvalues: (ref) v_u_7, (ref) v_u_1, (copy) p_u_2, (copy) v_u_32
		if v_u_7.Connected then
			for _, v37 in v_u_1:GetTagged(p_u_2) do
				task.spawn(v_u_32, v37)
			end
		end
	end)
	return function()
		-- upvalues: (ref) v_u_7, (ref) v_u_36, (copy) v_u_5, (copy) v_u_6
		v_u_7:Disconnect()
		v_u_36:Disconnect()
		local v38 = next(v_u_5)
		while v38 do
			local v39 = v_u_5[v38]
			v_u_5[v38] = "__dead__"
			if typeof(v39) == "function" then
				task.spawn(v39)
			end
			local v40 = v_u_6[v38]
			if v40 then
				v40:Disconnect()
				v_u_6[v38] = nil
			end
			v_u_5[v38] = nil
			v38 = next(v_u_5)
		end
	end
end
return observeTag]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[observeTag]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3358"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[sleitnick_trove@1.8.0]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3359"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("RunService")
local v_u_2 = newproxy()
local v_u_3 = newproxy()
local v_u_4 = table.freeze({
	"Destroy",
	"Disconnect",
	"destroy",
	"disconnect"
})
local function v_u_10(p5, p6)
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_4
	local v7 = typeof(p5)
	if v7 == "function" then
		return v_u_2
	end
	if v7 == "thread" then
		return v_u_3
	end
	if p6 then
		return p6
	end
	if v7 == "Instance" then
		return "Destroy"
	end
	if v7 == "RBXScriptConnection" then
		return "Disconnect"
	end
	if v7 == "table" then
		for _, v8 in v_u_4 do
			local v9 = p5[v8]
			if typeof(v9) == "function" then
				return v8
			end
		end
	end
	error(("failed to get cleanup function for object %*: %*"):format(v7, p5), 3)
end
local v_u_11 = {}
v_u_11.__index = v_u_11
function v_u_11.new()
	-- upvalues: (copy) v_u_11
	local v12 = v_u_11
	local v13 = setmetatable({}, v12)
	v13._objects = {}
	v13._cleaning = false
	return v13
end
function v_u_11.Add(p14, p15, p16)
	-- upvalues: (copy) v_u_10
	if p14._cleaning then
		error("cannot call trove:Add() while cleaning", 2)
	end
	local v17 = v_u_10(p15, p16)
	local v18 = p14._objects
	table.insert(v18, { p15, v17 })
	return p15
end
function v_u_11.Clone(p19, p20)
	if p19._cleaning then
		error("cannot call trove:Clone() while cleaning", 2)
	end
	return p19:Add(p20:Clone())
end
function v_u_11.Construct(p21, p22, ...)
	if p21._cleaning then
		error("Cannot call trove:Construct() while cleaning", 2)
	end
	local v23 = nil
	local v24 = type(p22)
	if v24 == "table" then
		v23 = p22.new(...)
	elseif v24 == "function" then
		v23 = p22(...)
	end
	return p21:Add(v23)
end
function v_u_11.Connect(p25, p26, p27)
	if p25._cleaning then
		error("Cannot call trove:Connect() while cleaning", 2)
	end
	if typeof(p26) == "RBXScriptSignal" then
		::l4::
		return p25:Add(p26:Connect(p27))
	else
		if typeof(p26) == "table" then
			local v28 = p26.Connect
			if typeof(v28) == "function" then
				local v29 = p26.Once
				if typeof(v29) == "function" then
					goto l4
				end
			end
		end
		error("did not receive a signal as an argument", 3)
		goto l4
	end
end
function v_u_11.Once(p_u_30, p31, p_u_32)
	if p_u_30._cleaning then
		error("Cannot call trove:Connect() while cleaning", 2)
	end
	if typeof(p31) == "RBXScriptSignal" then
		::l4::
		local v_u_33 = nil
		v_u_33 = p31:Once(function(...)
			-- upvalues: (copy) p_u_32, (copy) p_u_30, (ref) v_u_33
			p_u_32(...)
			p_u_30:Pop(v_u_33)
		end)
		return p_u_30:Add(v_u_33)
	else
		if typeof(p31) == "table" then
			local v34 = p31.Connect
			if typeof(v34) == "function" then
				local v35 = p31.Once
				if typeof(v35) == "function" then
					goto l4
				end
			end
		end
		error("did not receive a signal as an argument", 3)
		goto l4
	end
end
function v_u_11.BindToRenderStep(p36, p_u_37, p38, p39)
	-- upvalues: (copy) v_u_1
	if p36._cleaning then
		error("cannot call trove:BindToRenderStep() while cleaning", 2)
	end
	v_u_1:BindToRenderStep(p_u_37, p38, p39)
	p36:Add(function()
		-- upvalues: (ref) v_u_1, (copy) p_u_37
		v_u_1:UnbindFromRenderStep(p_u_37)
	end)
end
function v_u_11.AddPromise(p_u_40, p_u_41)
	if p_u_40._cleaning then
		error("cannot call trove:AddPromise() while cleaning", 2)
	end
	if typeof(p_u_41) == "table" then
		local v42 = p_u_41.getStatus
		if typeof(v42) == "function" then
			local v43 = p_u_41.finally
			if typeof(v43) == "function" then
				local v44 = p_u_41.cancel
				if typeof(v44) == "function" then
					::l7::
					if p_u_41:getStatus() == "Started" then
						p_u_41:finally(function()
							-- upvalues: (copy) p_u_40, (copy) p_u_41
							if not p_u_40._cleaning then
								p_u_40:_findAndRemoveFromObjects(p_u_41, false)
							end
						end)
						p_u_40:Add(p_u_41, "cancel")
					end
					return p_u_41
				end
			end
		end
	end
	error("did not receive a promise as an argument", 3)
	goto l7
end
function v_u_11.Remove(p45, p46)
	if p45._cleaning then
		error("cannot call trove:Remove() while cleaning", 2)
	end
	return p45:_findAndRemoveFromObjects(p46, true)
end
function v_u_11.Pop(p47, p48)
	if p47._cleaning then
		error("cannot call trove:Pop() while cleaning", 2)
	end
	return p47:_findAndRemoveFromObjects(p48, false)
end
function v_u_11.Extend(p49)
	-- upvalues: (copy) v_u_11
	if p49._cleaning then
		error("cannot call trove:Extend() while cleaning", 2)
	end
	return p49:Construct(v_u_11)
end
function v_u_11.Clean(p50)
	if not p50._cleaning then
		p50._cleaning = true
		for _, v51 in p50._objects do
			p50:_cleanupObject(v51[1], v51[2])
		end
		table.clear(p50._objects)
		p50._cleaning = false
	end
end
function v_u_11.WrapClean(p_u_52)
	return function()
		-- upvalues: (copy) p_u_52
		p_u_52:Clean()
	end
end
function v_u_11._findAndRemoveFromObjects(p53, p54, p55)
	local v56 = p53._objects
	for v57, v58 in v56 do
		if v58[1] == p54 then
			local v59 = #v56
			v56[v57] = v56[v59]
			v56[v59] = nil
			if p55 then
				p53:_cleanupObject(v58[1], v58[2])
			end
			return true
		end
	end
	return false
end
function v_u_11._cleanupObject(_, p60, p61)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	if p61 == v_u_2 then
		task.spawn(p60)
		return
	elseif p61 == v_u_3 then
		pcall(task.cancel, p60)
	else
		p60[p61](p60)
	end
end
function v_u_11.AttachToInstance(p_u_62, p63)
	if p_u_62._cleaning then
		error("cannot call trove:AttachToInstance() while cleaning", 2)
	elseif not p63:IsDescendantOf(game) then
		error("instance is not a descendant of the game hierarchy", 2)
	end
	return p_u_62:Connect(p63.Destroying, function()
		-- upvalues: (copy) p_u_62
		p_u_62:Destroy()
	end)
end
function v_u_11.Destroy(p64)
	p64:Clean()
end
return {
	["new"] = v_u_11.new
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[trove]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3360"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ServerScriptService")
require(v1.TestRunner.Test)
return function(p_u_2)
	local v_u_3 = require(script.Parent)
	p_u_2:Describe("Trove", function()
		-- upvalues: (copy) p_u_2, (copy) v_u_3
		local v_u_4 = nil
		p_u_2:BeforeEach(function()
			-- upvalues: (ref) v_u_4, (ref) v_u_3
			v_u_4 = v_u_3.new()
		end)
		p_u_2:AfterEach(function()
			-- upvalues: (ref) v_u_4
			if v_u_4 then
				v_u_4:Destroy()
				v_u_4 = nil
			end
		end)
		p_u_2:Test("should add and clean up roblox instance", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local v5 = Instance.new("Part")
			v5.Parent = workspace
			v_u_4:Add(v5)
			v_u_4:Destroy()
			p_u_2:Expect(v5.Parent):ToBeNil()
		end)
		p_u_2:Test("should add and clean up roblox connection", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local v6 = workspace.Changed:Connect(function() end)
			v_u_4:Add(v6)
			v_u_4:Destroy()
			p_u_2:Expect(v6.Connected):ToBe(false)
		end)
		p_u_2:Test("should add and clean up a table with a destroy method", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local v8 = {
				["Destroyed"] = false,
				["Destroy"] = function(p7)
					p7.Destroyed = true
				end
			}
			v_u_4:Add(v8)
			v_u_4:Destroy()
			p_u_2:Expect(v8.Destroyed):ToBe(true)
		end)
		p_u_2:Test("should add and clean up a table with a disconnect method", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local v10 = {
				["Connected"] = true,
				["Disconnect"] = function(p9)
					p9.Connected = false
				end
			}
			v_u_4:Add(v10)
			v_u_4:Destroy()
			p_u_2:Expect(v10.Connected):ToBe(false)
		end)
		p_u_2:Test("should add and clean up a function", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local v_u_11 = false
			v_u_4:Add(function()
				-- upvalues: (ref) v_u_11
				v_u_11 = true
			end)
			v_u_4:Destroy()
			p_u_2:Expect(v_u_11):ToBe(true)
		end)
		p_u_2:Test("should allow a custom cleanup method", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local v13 = {
				["Cleaned"] = false,
				["Cleanup"] = function(p12)
					p12.Cleaned = true
				end
			}
			v_u_4:Add(v13, "Cleanup")
			v_u_4:Destroy()
			p_u_2:Expect(v13.Cleaned):ToBe(true)
		end)
		p_u_2:Test("should return the object passed to add", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local v14 = Instance.new("Part")
			local v15 = v_u_4:Add(v14)
			p_u_2:Expect(v14):ToBe(v15)
			v_u_4:Destroy()
		end)
		p_u_2:Test("should fail to add object without proper cleanup method", function()
			-- upvalues: (ref) p_u_2, (ref) v_u_4
			local v_u_16 = {}
			p_u_2:Expect(function()
				-- upvalues: (ref) v_u_4, (copy) v_u_16
				v_u_4:Add(v_u_16)
			end):ToThrow()
		end)
		p_u_2:Test("should construct an object and add it", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local v_u_17 = {}
			v_u_17.__index = v_u_17
			function v_u_17.new(p18)
				-- upvalues: (copy) v_u_17
				local v19 = v_u_17
				local v20 = setmetatable({}, v19)
				v20._msg = p18
				v20._destroyed = false
				return v20
			end
			function v_u_17.Destroy(p21)
				p21._destroyed = true
			end
			local v22 = v_u_4:Construct(v_u_17, "abc")
			p_u_2:Expect((typeof(v22))):ToBe("table")
			p_u_2:Expect((getmetatable(v22))):ToBe(v_u_17)
			p_u_2:Expect(v22._msg):ToBe("abc")
			p_u_2:Expect(v22._destroyed):ToBe(false)
			v_u_4:Destroy()
			p_u_2:Expect(v22._destroyed):ToBe(true)
		end)
		p_u_2:Test("should connect to a signal", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local v23 = v_u_4:Connect(workspace.Changed, function() end)
			p_u_2:Expect((typeof(v23))):ToBe("RBXScriptConnection")
			p_u_2:Expect(v23.Connected):ToBe(true)
			v_u_4:Destroy()
			p_u_2:Expect(v23.Connected):ToBe(false)
		end)
		p_u_2:Test("should remove an object", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local v24 = v_u_4:Connect(workspace.Changed, function() end)
			p_u_2:Expect(v_u_4:Remove(v24)):ToBe(true)
			p_u_2:Expect(v24.Connected):ToBe(false)
		end)
		p_u_2:Test("should not remove an object not in the trove", function()
			-- upvalues: (ref) p_u_2, (ref) v_u_4
			local v25 = workspace.Changed:Connect(function() end)
			p_u_2:Expect(v_u_4:Remove(v25)):ToBe(false)
			p_u_2:Expect(v25.Connected):ToBe(true)
			v25:Disconnect()
		end)
		p_u_2:Test("should attach to instance", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local v26 = Instance.new("Part")
			v26.Parent = workspace
			local v27 = v_u_4:AttachToInstance(v26)
			p_u_2:Expect(v27.Connected):ToBe(true)
			v26:Destroy()
			p_u_2:Expect(v27.Connected):ToBe(false)
		end)
		p_u_2:Test("should fail to attach to instance not in hierarchy", function()
			-- upvalues: (ref) p_u_2, (ref) v_u_4
			local v_u_28 = Instance.new("Part")
			p_u_2:Expect(function()
				-- upvalues: (ref) v_u_4, (copy) v_u_28
				v_u_4:AttachToInstance(v_u_28)
			end):ToThrow()
		end)
		p_u_2:Test("should extend itself", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local v29 = v_u_4:Extend()
			local v_u_30 = false
			v29:Add(function()
				-- upvalues: (ref) v_u_30
				v_u_30 = true
			end)
			p_u_2:Expect((typeof(v29))):ToBe("table")
			local v31 = v_u_4
			p_u_2:Expect((getmetatable(v29))):ToBe((getmetatable(v31)))
			v_u_4:Clean()
			p_u_2:Expect(v_u_30):ToBe(true)
		end)
		p_u_2:Test("should clone an instance", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local v32 = v_u_4:Construct(Instance.new, "Part")
			v32.Name = "TroveCloneTest"
			local v33 = v_u_4:Clone(v32)
			p_u_2:Expect((typeof(v33))):ToBe("Instance")
			p_u_2:Expect(v33):Not():ToBe(v32)
			p_u_2:Expect(v33.Name):ToBe("TroveCloneTest")
			p_u_2:Expect(v32.Name):ToBe(v33.Name)
		end)
		p_u_2:Test("should clean up a thread", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local v34 = coroutine.create(function() end)
			v_u_4:Add(v34)
			p_u_2:Expect(coroutine.status(v34)):ToBe("suspended")
			v_u_4:Clean()
			p_u_2:Expect(coroutine.status(v34)):ToBe("dead")
		end)
		p_u_2:Test("should not allow objects added during cleanup", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local v_u_35 = false
			v_u_4:Add(function()
				-- upvalues: (ref) v_u_4, (ref) v_u_35
				v_u_4:Add(function() end)
				v_u_35 = true
			end)
			v_u_4:Clean()
			p_u_2:Expect(v_u_35):ToBe(false)
		end)
		p_u_2:Test("should not allow objects to be removed during cleanup", function()
			-- upvalues: (ref) v_u_4, (ref) p_u_2
			local function v_u_36() end
			local v_u_37 = false
			v_u_4:Add(v_u_36)
			v_u_4:Add(function()
				-- upvalues: (ref) v_u_4, (copy) v_u_36, (ref) v_u_37
				v_u_4:Remove(v_u_36)
				v_u_37 = true
			end)
			p_u_2:Expect(v_u_37):ToBe(false)
		end)
	end)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[init.test]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3361"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["package"] = {
		["authors"] = { "Stephen Leitnick" },
		["description"] = "Trove class for tracking and cleaning up objects",
		["license"] = "MIT",
		["name"] = "sleitnick/trove",
		["realm"] = "shared",
		["registry"] = "https://github.com/UpliftGames/wally-index",
		["version"] = "1.8.0"
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[wally]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3362"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[sleitnick_option@1.0.5]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3363"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
v_u_1.__index = v_u_1
function v_u_1._new(p2)
	-- upvalues: (copy) v_u_1
	local v3 = {
		["ClassName"] = "Option",
		["_v"] = p2,
		["_s"] = p2 ~= nil
	}
	local v4 = v_u_1
	return setmetatable(v3, v4)
end
function v_u_1.Some(p5)
	-- upvalues: (copy) v_u_1
	local v6 = p5 ~= nil
	assert(v6, "Option.Some() value cannot be nil")
	return v_u_1._new(p5)
end
function v_u_1.Wrap(p7)
	-- upvalues: (copy) v_u_1
	if p7 == nil then
		return v_u_1.None
	else
		return v_u_1.Some(p7)
	end
end
function v_u_1.Is(p8)
	-- upvalues: (copy) v_u_1
	local v9
	if type(p8) == "table" then
		v9 = getmetatable(p8) == v_u_1
	else
		v9 = false
	end
	return v9
end
function v_u_1.Assert(p10)
	-- upvalues: (copy) v_u_1
	local v11 = v_u_1.Is(p10)
	assert(v11, "Result was not of type Option")
end
function v_u_1.Deserialize(p12)
	-- upvalues: (copy) v_u_1
	local v13
	if type(p12) == "table" then
		v13 = p12.ClassName == "Option"
	else
		v13 = false
	end
	assert(v13, "Invalid data for deserializing Option")
	return p12.Value == nil and v_u_1.None or v_u_1.Some(p12.Value)
end
function v_u_1.Serialize(p14)
	return {
		["ClassName"] = p14.ClassName,
		["Value"] = p14._v
	}
end
function v_u_1.Match(p15, p16)
	local v17 = p16.Some
	local v18 = p16.None
	local v19 = type(v17) == "function"
	assert(v19, "Missing \'Some\' match")
	local v20 = type(v18) == "function"
	assert(v20, "Missing \'None\' match")
	if p15:IsSome() then
		return v17(p15:Unwrap())
	else
		return v18()
	end
end
function v_u_1.IsSome(p21)
	return p21._s
end
function v_u_1.IsNone(p22)
	return not p22._s
end
function v_u_1.Expect(p23, p24)
	local v25 = p23:IsSome()
	assert(v25, p24)
	return p23._v
end
function v_u_1.ExpectNone(p26, p27)
	local v28 = p26:IsNone()
	assert(v28, p27)
end
function v_u_1.Unwrap(p29)
	return p29:Expect("Cannot unwrap option of None type")
end
function v_u_1.UnwrapOr(p30, p31)
	if p30:IsSome() then
		return p30:Unwrap()
	else
		return p31
	end
end
function v_u_1.UnwrapOrElse(p32, p33)
	if p32:IsSome() then
		return p32:Unwrap()
	else
		return p33()
	end
end
function v_u_1.And(p34, p35)
	-- upvalues: (copy) v_u_1
	if p34:IsSome() then
		return p35
	else
		return v_u_1.None
	end
end
function v_u_1.AndThen(p36, p37)
	-- upvalues: (copy) v_u_1
	if not p36:IsSome() then
		return v_u_1.None
	end
	local v38 = p37(p36:Unwrap())
	v_u_1.Assert(v38)
	return v38
end
function v_u_1.Or(p39, p40)
	if p39:IsSome() then
		return p39
	else
		return p40
	end
end
function v_u_1.OrElse(p41, p42)
	-- upvalues: (copy) v_u_1
	if p41:IsSome() then
		return p41
	end
	local v43 = p42()
	v_u_1.Assert(v43)
	return v43
end
function v_u_1.XOr(p44, p45)
	-- upvalues: (copy) v_u_1
	local v46 = p44:IsSome()
	if v46 == p45:IsSome() then
		return v_u_1.None
	elseif v46 then
		return p44
	else
		return p45
	end
end
function v_u_1.Filter(p47, p48)
	-- upvalues: (copy) v_u_1
	if p47:IsNone() or not p48(p47._v) then
		return v_u_1.None
	else
		return p47
	end
end
function v_u_1.Contains(p49, p50)
	local v51 = p49:IsSome()
	if v51 then
		v51 = p49._v == p50
	end
	return v51
end
function v_u_1.__tostring(p52)
	if not p52:IsSome() then
		return "Option<None>"
	end
	local v53 = p52._v
	return "Option<" .. typeof(v53) .. ">"
end
function v_u_1.__eq(p54, p55)
	-- upvalues: (copy) v_u_1
	if v_u_1.Is(p55) then
		if p54:IsSome() and p55:IsSome() then
			return p54:Unwrap() == p55:Unwrap()
		end
		if p54:IsNone() and p55:IsNone() then
			return true
		end
	end
	return false
end
v_u_1.None = v_u_1._new()
return v_u_1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[option]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3364"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function()
	local v_u_1 = require(script.Parent)
	describe("Some", function()
		-- upvalues: (copy) v_u_1
		it("should create some option", function()
			-- upvalues: (ref) v_u_1
			local v2 = v_u_1.Some(true)
			expect(v2:IsSome()).to.equal(true)
		end)
		it("should fail to create some option with nil", function()
			-- upvalues: (ref) v_u_1
			expect(function()
				-- upvalues: (ref) v_u_1
				v_u_1.Some(nil)
			end).to.throw()
		end)
		it("should not be none", function()
			-- upvalues: (ref) v_u_1
			local v3 = v_u_1.Some(10)
			expect(v3:IsNone()).to.equal(false)
		end)
	end)
	describe("None", function()
		-- upvalues: (copy) v_u_1
		it("should be able to reference none", function()
			-- upvalues: (ref) v_u_1
			expect(function()
				-- upvalues: (ref) v_u_1
				local _ = v_u_1.None
			end).never.to.throw()
		end)
		it("should be able to check if none", function()
			-- upvalues: (ref) v_u_1
			local v4 = v_u_1.None
			expect(v4:IsNone()).to.equal(true)
		end)
		it("should be able to check if not some", function()
			-- upvalues: (ref) v_u_1
			local v5 = v_u_1.None
			expect(v5:IsSome()).to.equal(false)
		end)
	end)
	describe("Equality", function()
		-- upvalues: (copy) v_u_1
		it("should equal the same some from same options", function()
			-- upvalues: (ref) v_u_1
			local v6 = v_u_1.Some(32)
			expect(v6).to.equal(v6)
		end)
		it("should equal the same some from different options", function()
			-- upvalues: (ref) v_u_1
			local v7 = v_u_1.Some(32)
			local v8 = v_u_1.Some(32)
			expect(v7).to.equal(v8)
		end)
	end)
	describe("Assert", function()
		-- upvalues: (copy) v_u_1
		it("should assert that a some option is an option", function()
			-- upvalues: (ref) v_u_1
			expect(v_u_1.Is(v_u_1.Some(10))).to.equal(true)
		end)
		it("should assert that a none option is an option", function()
			-- upvalues: (ref) v_u_1
			expect(v_u_1.Is(v_u_1.None)).to.equal(true)
		end)
		it("should assert that a non-option is not an option", function()
			-- upvalues: (ref) v_u_1
			expect(v_u_1.Is(10)).to.equal(false)
			expect(v_u_1.Is(true)).to.equal(false)
			expect(v_u_1.Is(false)).to.equal(false)
			expect(v_u_1.Is("Test")).to.equal(false)
			expect(v_u_1.Is({})).to.equal(false)
			expect(v_u_1.Is(function() end)).to.equal(false)
			expect(v_u_1.Is(coroutine.create(function() end))).to.equal(false)
			expect(v_u_1.Is(v_u_1)).to.equal(false)
		end)
	end)
	describe("Unwrap", function()
		-- upvalues: (copy) v_u_1
		it("should unwrap a some option", function()
			-- upvalues: (ref) v_u_1
			local v_u_9 = v_u_1.Some(10)
			expect(function()
				-- upvalues: (copy) v_u_9
				v_u_9:Unwrap()
			end).never.to.throw()
			expect(v_u_9:Unwrap()).to.equal(10)
		end)
		it("should fail to unwrap a none option", function()
			-- upvalues: (ref) v_u_1
			local v_u_10 = v_u_1.None
			expect(function()
				-- upvalues: (copy) v_u_10
				v_u_10:Unwrap()
			end).to.throw()
		end)
	end)
	describe("Expect", function()
		-- upvalues: (copy) v_u_1
		it("should expect a some option", function()
			-- upvalues: (ref) v_u_1
			local v_u_11 = v_u_1.Some(10)
			expect(function()
				-- upvalues: (copy) v_u_11
				v_u_11:Expect("Expecting some value")
			end).never.to.throw()
			expect(v_u_11:Unwrap()).to.equal(10)
		end)
		it("should fail when expecting on a none option", function()
			-- upvalues: (ref) v_u_1
			local v_u_12 = v_u_1.None
			expect(function()
				-- upvalues: (copy) v_u_12
				v_u_12:Expect("Expecting some value")
			end).to.throw()
		end)
	end)
	describe("ExpectNone", function()
		-- upvalues: (copy) v_u_1
		it("should fail to expect a none option", function()
			-- upvalues: (ref) v_u_1
			local v_u_13 = v_u_1.Some(10)
			expect(function()
				-- upvalues: (copy) v_u_13
				v_u_13:ExpectNone("Expecting some value")
			end).to.throw()
		end)
		it("should expect a none option", function()
			-- upvalues: (ref) v_u_1
			local v_u_14 = v_u_1.None
			expect(function()
				-- upvalues: (copy) v_u_14
				v_u_14:ExpectNone("Expecting some value")
			end).never.to.throw()
		end)
	end)
	describe("UnwrapOr", function()
		-- upvalues: (copy) v_u_1
		it("should unwrap a some option", function()
			-- upvalues: (ref) v_u_1
			local v15 = v_u_1.Some(10)
			expect(v15:UnwrapOr(20)).to.equal(10)
		end)
		it("should unwrap a none option", function()
			-- upvalues: (ref) v_u_1
			local v16 = v_u_1.None
			expect(v16:UnwrapOr(20)).to.equal(20)
		end)
	end)
	describe("UnwrapOrElse", function()
		-- upvalues: (copy) v_u_1
		it("should unwrap a some option", function()
			-- upvalues: (ref) v_u_1
			local v17 = v_u_1.Some(10):UnwrapOrElse(function()
				return 30
			end)
			expect(v17).to.equal(10)
		end)
		it("should unwrap a none option", function()
			-- upvalues: (ref) v_u_1
			local v18 = v_u_1.None:UnwrapOrElse(function()
				return 30
			end)
			expect(v18).to.equal(30)
		end)
	end)
	describe("And", function()
		-- upvalues: (copy) v_u_1
		it("should return the second option with and when both are some", function()
			-- upvalues: (ref) v_u_1
			local v19 = v_u_1.Some(1)
			local v20 = v_u_1.Some(2)
			expect(v19:And(v20)).to.equal(v20)
		end)
		it("should return none when first option is some and second option is none", function()
			-- upvalues: (ref) v_u_1
			local v21 = v_u_1.Some(1)
			local v22 = v_u_1.None
			expect(v21:And(v22):IsNone()).to.equal(true)
		end)
		it("should return none when first option is none and second option is some", function()
			-- upvalues: (ref) v_u_1
			local v23 = v_u_1.None
			local v24 = v_u_1.Some(2)
			expect(v23:And(v24):IsNone()).to.equal(true)
		end)
		it("should return none when both options are none", function()
			-- upvalues: (ref) v_u_1
			local v25 = v_u_1.None
			local v26 = v_u_1.None
			expect(v25:And(v26):IsNone()).to.equal(true)
		end)
	end)
	describe("AndThen", function()
		-- upvalues: (copy) v_u_1
		it("should pass the some value to the predicate", function()
			-- upvalues: (ref) v_u_1
			v_u_1.Some(32):AndThen(function(p27)
				-- upvalues: (ref) v_u_1
				expect(p27).to.equal(32)
				return v_u_1.None
			end)
		end)
		it("should throw if an option is not returned from predicate", function()
			-- upvalues: (ref) v_u_1
			local v_u_28 = v_u_1.Some(32)
			expect(function()
				-- upvalues: (copy) v_u_28
				v_u_28:AndThen(function() end)
			end).to.throw()
		end)
		it("should return none if the option is none", function()
			-- upvalues: (ref) v_u_1
			local v29 = v_u_1.None
			expect(v29:AndThen(function()
				-- upvalues: (ref) v_u_1
				return v_u_1.Some(10)
			end):IsNone()).to.equal(true)
		end)
		it("should return option of predicate if option is some", function()
			-- upvalues: (ref) v_u_1
			local v30 = v_u_1.Some(32):AndThen(function()
				-- upvalues: (ref) v_u_1
				return v_u_1.Some(10)
			end)
			expect(v30:IsSome()).to.equal(true)
			expect(v30:Unwrap()).to.equal(10)
		end)
	end)
	describe("Or", function()
		-- upvalues: (copy) v_u_1
		it("should return the first option if it is some", function()
			-- upvalues: (ref) v_u_1
			local v31 = v_u_1.Some(10)
			local v32 = v_u_1.Some(20)
			expect(v31:Or(v32)).to.equal(v31)
		end)
		it("should return the second option if the first one is none", function()
			-- upvalues: (ref) v_u_1
			local v33 = v_u_1.None
			local v34 = v_u_1.Some(20)
			expect(v33:Or(v34)).to.equal(v34)
		end)
	end)
	describe("OrElse", function()
		-- upvalues: (copy) v_u_1
		it("should return the first option if it is some", function()
			-- upvalues: (ref) v_u_1
			local v35 = v_u_1.Some(10)
			local v_u_36 = v_u_1.Some(20)
			expect(v35:OrElse(function()
				-- upvalues: (copy) v_u_36
				return v_u_36
			end)).to.equal(v35)
		end)
		it("should return the second option if the first one is none", function()
			-- upvalues: (ref) v_u_1
			local v37 = v_u_1.None
			local v_u_38 = v_u_1.Some(20)
			expect(v37:OrElse(function()
				-- upvalues: (copy) v_u_38
				return v_u_38
			end)).to.equal(v_u_38)
		end)
		it("should throw if the predicate does not return an option", function()
			-- upvalues: (ref) v_u_1
			local v_u_39 = v_u_1.None
			expect(function()
				-- upvalues: (copy) v_u_39
				v_u_39:OrElse(function() end)
			end).to.throw()
		end)
	end)
	describe("XOr", function()
		-- upvalues: (copy) v_u_1
		it("should return first option if first option is some and second option is none", function()
			-- upvalues: (ref) v_u_1
			local v40 = v_u_1.Some(1)
			local v41 = v_u_1.None
			expect(v40:XOr(v41)).to.equal(v40)
		end)
		it("should return second option if first option is none and second option is some", function()
			-- upvalues: (ref) v_u_1
			local v42 = v_u_1.None
			local v43 = v_u_1.Some(2)
			expect(v42:XOr(v43)).to.equal(v43)
		end)
		it("should return none if first and second option are some", function()
			-- upvalues: (ref) v_u_1
			local v44 = v_u_1.Some(1)
			local v45 = v_u_1.Some(2)
			expect(v44:XOr(v45)).to.equal(v_u_1.None)
		end)
		it("should return none if first and second option are none", function()
			-- upvalues: (ref) v_u_1
			local v46 = v_u_1.None
			local v47 = v_u_1.None
			expect(v46:XOr(v47)).to.equal(v_u_1.None)
		end)
	end)
	describe("Filter", function()
		-- upvalues: (copy) v_u_1
		it("should return none if option is none", function()
			-- upvalues: (ref) v_u_1
			local v48 = v_u_1.None
			expect(v48:Filter(function() end)).to.equal(v_u_1.None)
		end)
		it("should return none if option is some but fails predicate", function()
			-- upvalues: (ref) v_u_1
			local v49 = v_u_1.Some(10)
			expect(v49:Filter(function(_)
				return false
			end)).to.equal(v_u_1.None)
		end)
		it("should return self if option is some and passes predicate", function()
			-- upvalues: (ref) v_u_1
			local v50 = v_u_1.Some(10)
			expect(v50:Filter(function(_)
				return true
			end)).to.equal(v50)
		end)
	end)
	describe("Contains", function()
		-- upvalues: (copy) v_u_1
		it("should return true if some option contains the given value", function()
			-- upvalues: (ref) v_u_1
			local v51 = v_u_1.Some(32)
			expect(v51:Contains(32)).to.equal(true)
		end)
		it("should return false if some option does not contain the given value", function()
			-- upvalues: (ref) v_u_1
			local v52 = v_u_1.Some(32)
			expect(v52:Contains(64)).to.equal(false)
		end)
		it("should return false if option is none", function()
			-- upvalues: (ref) v_u_1
			local v53 = v_u_1.None
			expect(v53:Contains(64)).to.equal(false)
		end)
	end)
	describe("ToString", function()
		-- upvalues: (copy) v_u_1
		it("should return string of none option", function()
			-- upvalues: (ref) v_u_1
			local v54 = v_u_1.None
			expect((tostring(v54))).to.equal("Option<None>")
		end)
		it("should return string of some option with type", function()
			-- upvalues: (ref) v_u_1
			local v55 = {
				10,
				true,
				false,
				"test",
				{},
				function() end,
				coroutine.create(function() end),
				workspace
			}
			for _, v56 in ipairs(v55) do
				local v57 = ("Option<%s>"):format((typeof(v56)))
				local v58 = expect
				local v59 = v_u_1.Some
				v58((tostring(v59(v56)))).to.equal(v57)
			end
		end)
	end)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[init.spec]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3365"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["package"] = {
		["authors"] = { "Stephen Leitnick" },
		["description"] = "Represent optional values in Lua",
		["license"] = "MIT",
		["name"] = "sleitnick/option",
		["realm"] = "shared",
		["registry"] = "https://github.com/UpliftGames/wally-index",
		["version"] = "1.0.5"
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[wally]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3366"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[sleitnick_signal@1.5.0]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3367"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = nil
local function v_u_4(p2, ...)
	-- upvalues: (ref) v_u_1
	local v3 = v_u_1
	v_u_1 = nil
	p2(...)
	v_u_1 = v3
end
local function v_u_5(...)
	-- upvalues: (copy) v_u_4
	v_u_4(...)
	while true do
		v_u_4(coroutine.yield())
	end
end
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6.new(p7, p8)
	-- upvalues: (copy) v_u_6
	local v9 = v_u_6
	return setmetatable({
		["Connected"] = true,
		["_signal"] = p7,
		["_fn"] = p8,
		["_next"] = false
	}, v9)
end
function v_u_6.Disconnect(p10)
	if p10.Connected then
		p10.Connected = false
		if p10._signal._handlerListHead == p10 then
			p10._signal._handlerListHead = p10._next
		else
			local v11 = p10._signal._handlerListHead
			while v11 and v11._next ~= p10 do
				v11 = v11._next
			end
			if v11 then
				v11._next = p10._next
			end
		end
	else
		return
	end
end
v_u_6.Destroy = v_u_6.Disconnect
setmetatable(v_u_6, {
	["__index"] = function(_, p12)
		error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p12))), 2)
	end,
	["__newindex"] = function(_, p13, _)
		error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p13))), 2)
	end
})
local v_u_14 = {}
v_u_14.__index = v_u_14
function v_u_14.new()
	-- upvalues: (copy) v_u_14
	local v15 = v_u_14
	return setmetatable({
		["_handlerListHead"] = false,
		["_proxyHandler"] = nil
	}, v15)
end
function v_u_14.Wrap(p16)
	-- upvalues: (copy) v_u_14
	local v17 = typeof(p16) == "RBXScriptSignal"
	local v18 = "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(p16)
	assert(v17, v18)
	local v_u_19 = v_u_14.new()
	v_u_19._proxyHandler = p16:Connect(function(...)
		-- upvalues: (copy) v_u_19
		v_u_19:Fire(...)
	end)
	return v_u_19
end
function v_u_14.Is(p20)
	-- upvalues: (copy) v_u_14
	local v21
	if type(p20) == "table" then
		v21 = getmetatable(p20) == v_u_14
	else
		v21 = false
	end
	return v21
end
function v_u_14.Connect(p22, p23)
	-- upvalues: (copy) v_u_6
	local v24 = v_u_6.new(p22, p23)
	if not p22._handlerListHead then
		p22._handlerListHead = v24
		return v24
	end
	v24._next = p22._handlerListHead
	p22._handlerListHead = v24
	return v24
end
function v_u_14.ConnectOnce(p25, p26)
	return p25:Once(p26)
end
function v_u_14.Once(p27, p_u_28)
	local v_u_29 = nil
	local v_u_30 = false
	v_u_29 = p27:Connect(function(...)
		-- upvalues: (ref) v_u_30, (ref) v_u_29, (copy) p_u_28
		if not v_u_30 then
			v_u_30 = true
			v_u_29:Disconnect()
			p_u_28(...)
		end
	end)
	return v_u_29
end
function v_u_14.GetConnections(p31)
	local v32 = p31._handlerListHead
	local v33 = {}
	while v32 do
		table.insert(v33, v32)
		v32 = v32._next
	end
	return v33
end
function v_u_14.DisconnectAll(p34)
	local v35 = p34._handlerListHead
	while v35 do
		v35.Connected = false
		v35 = v35._next
	end
	p34._handlerListHead = false
end
function v_u_14.Fire(p36, ...)
	-- upvalues: (ref) v_u_1, (copy) v_u_5
	local v37 = p36._handlerListHead
	while v37 do
		if v37.Connected then
			if not v_u_1 then
				v_u_1 = coroutine.create(v_u_5)
			end
			task.spawn(v_u_1, v37._fn, ...)
		end
		v37 = v37._next
	end
end
function v_u_14.FireDeferred(p38, ...)
	local v39 = p38._handlerListHead
	while v39 do
		task.defer(v39._fn, ...)
		v39 = v39._next
	end
end
function v_u_14.Wait(p40)
	local v_u_41 = coroutine.running()
	local v_u_42 = nil
	local v_u_43 = false
	v_u_42 = p40:Connect(function(...)
		-- upvalues: (ref) v_u_43, (ref) v_u_42, (copy) v_u_41
		if not v_u_43 then
			v_u_43 = true
			v_u_42:Disconnect()
			task.spawn(v_u_41, ...)
		end
	end)
	return coroutine.yield()
end
function v_u_14.Destroy(p44)
	p44:DisconnectAll()
	local v45 = rawget(p44, "_proxyHandler")
	if v45 then
		v45:Disconnect()
	end
end
setmetatable(v_u_14, {
	["__index"] = function(_, p46)
		error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p46))), 2)
	end,
	["__newindex"] = function(_, p47, _)
		error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p47))), 2)
	end
})
return {
	["new"] = v_u_14.new,
	["Wrap"] = v_u_14.Wrap,
	["Is"] = v_u_14.Is
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[signal]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3368"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local function v_u_5(p1, p2)
	local v3 = os.clock()
	local v4 = p2 or 10
	while not p1() do
		if v4 < os.clock() - v3 then
			return false
		end
		task.wait()
	end
	return true
end
return function()
	-- upvalues: (copy) v_u_5
	local v_u_6 = require(script.Parent)
	local v_u_7 = nil
	beforeEach(function()
		-- upvalues: (ref) v_u_7, (copy) v_u_6
		v_u_7 = v_u_6.new()
	end)
	afterEach(function()
		-- upvalues: (ref) v_u_7
		v_u_7:Destroy()
	end)
	describe("Constructor", function()
		-- upvalues: (copy) v_u_6, (ref) v_u_7, (ref) v_u_5
		it("should create a new signal and fire it", function()
			-- upvalues: (ref) v_u_6, (ref) v_u_7
			expect(v_u_6.Is(v_u_7)).to.equal(true)
			task.defer(function()
				-- upvalues: (ref) v_u_7
				v_u_7:Fire(10, 20)
			end)
			local v8, v9 = v_u_7:Wait()
			expect(v8).to.equal(10)
			expect(v9).to.equal(20)
		end)
		it("should create a proxy signal and connect to it", function()
			-- upvalues: (ref) v_u_6, (ref) v_u_5
			local v10 = v_u_6.Wrap(game:GetService("RunService").Heartbeat)
			expect(v_u_6.Is(v10)).to.equal(true)
			local v_u_11 = false
			v10:Connect(function()
				-- upvalues: (ref) v_u_11
				v_u_11 = true
			end)
			expect(v_u_5(function()
				-- upvalues: (ref) v_u_11
				return v_u_11
			end, 2)).to.equal(true)
			v10:Destroy()
		end)
	end)
	describe("FireDeferred", function()
		-- upvalues: (ref) v_u_7, (ref) v_u_5
		it("should be able to fire primitive argument", function()
			-- upvalues: (ref) v_u_7, (ref) v_u_5
			local v_u_12 = nil
			v_u_7:Connect(function(p13)
				-- upvalues: (ref) v_u_12
				v_u_12 = p13
			end)
			v_u_7:FireDeferred(10)
			expect(v_u_5(function()
				-- upvalues: (ref) v_u_12
				return v_u_12 == 10
			end, 1)).to.equal(true)
		end)
		it("should be able to fire a reference based argument", function()
			-- upvalues: (ref) v_u_7, (ref) v_u_5
			local v_u_14 = { 10, 20 }
			local v_u_15 = nil
			v_u_7:Connect(function(p16)
				-- upvalues: (ref) v_u_15
				v_u_15 = p16
			end)
			v_u_7:FireDeferred(v_u_14)
			expect(v_u_5(function()
				-- upvalues: (copy) v_u_14, (ref) v_u_15
				return v_u_14 == v_u_15
			end, 1)).to.equal(true)
		end)
	end)
	describe("Fire", function()
		-- upvalues: (ref) v_u_7
		it("should be able to fire primitive argument", function()
			-- upvalues: (ref) v_u_7
			local v_u_17 = nil
			v_u_7:Connect(function(p18)
				-- upvalues: (ref) v_u_17
				v_u_17 = p18
			end)
			v_u_7:Fire(10)
			expect(v_u_17).to.equal(10)
		end)
		it("should be able to fire a reference based argument", function()
			-- upvalues: (ref) v_u_7
			local v19 = { 10, 20 }
			local v_u_20 = nil
			v_u_7:Connect(function(p21)
				-- upvalues: (ref) v_u_20
				v_u_20 = p21
			end)
			v_u_7:Fire(v19)
			expect(v_u_20).to.equal(v19)
		end)
	end)
	describe("ConnectOnce", function()
		-- upvalues: (ref) v_u_7
		it("should only capture first fire", function()
			-- upvalues: (ref) v_u_7
			local v_u_22 = nil
			local v24 = v_u_7:ConnectOnce(function(p23)
				-- upvalues: (ref) v_u_22
				v_u_22 = p23
			end)
			expect(v24.Connected).to.equal(true)
			v_u_7:Fire(10)
			expect(v24.Connected).to.equal(false)
			v_u_7:Fire(20)
			expect(v_u_22).to.equal(10)
		end)
	end)
	describe("Wait", function()
		-- upvalues: (ref) v_u_7
		it("should be able to wait for a signal to fire", function()
			-- upvalues: (ref) v_u_7
			task.defer(function()
				-- upvalues: (ref) v_u_7
				v_u_7:Fire(10, 20, 30)
			end)
			local v25, v26, v27 = v_u_7:Wait()
			expect(v25).to.equal(10)
			expect(v26).to.equal(20)
			expect(v27).to.equal(30)
		end)
	end)
	describe("DisconnectAll", function()
		-- upvalues: (ref) v_u_7
		it("should disconnect all connections", function()
			-- upvalues: (ref) v_u_7
			v_u_7:Connect(function() end)
			v_u_7:Connect(function() end)
			expect(#(nil or v_u_7):GetConnections()).to.equal(2)
			v_u_7:DisconnectAll()
			expect(#(nil or v_u_7):GetConnections()).to.equal(0)
		end)
	end)
	describe("Disconnect", function()
		-- upvalues: (ref) v_u_7, (ref) v_u_5
		it("should disconnect connection", function()
			-- upvalues: (ref) v_u_7
			local v28 = v_u_7:Connect(function() end)
			expect(#(nil or v_u_7):GetConnections()).to.equal(1)
			v28:Disconnect()
			expect(#(nil or v_u_7):GetConnections()).to.equal(0)
		end)
		it("should still work if connections disconnected while firing", function()
			-- upvalues: (ref) v_u_7
			local v_u_29 = 0
			local v_u_30 = nil
			v_u_7:Connect(function()
				-- upvalues: (ref) v_u_29
				v_u_29 = v_u_29 + 1
			end)
			v_u_30 = v_u_7:Connect(function()
				-- upvalues: (ref) v_u_30, (ref) v_u_29
				v_u_30:Disconnect()
				v_u_29 = v_u_29 + 1
			end)
			v_u_7:Connect(function()
				-- upvalues: (ref) v_u_29
				v_u_29 = v_u_29 + 1
			end)
			v_u_7:Fire()
			expect(v_u_29).to.equal(3)
		end)
		it("should still work if connections disconnected while firing deferred", function()
			-- upvalues: (ref) v_u_7, (ref) v_u_5
			local v_u_31 = 0
			local v_u_32 = nil
			v_u_7:Connect(function()
				-- upvalues: (ref) v_u_31
				v_u_31 = v_u_31 + 1
			end)
			v_u_32 = v_u_7:Connect(function()
				-- upvalues: (ref) v_u_32, (ref) v_u_31
				v_u_32:Disconnect()
				v_u_31 = v_u_31 + 1
			end)
			v_u_7:Connect(function()
				-- upvalues: (ref) v_u_31
				v_u_31 = v_u_31 + 1
			end)
			v_u_7:FireDeferred()
			expect(v_u_5(function()
				-- upvalues: (ref) v_u_31
				return v_u_31 == 3
			end)).to.equal(true)
		end)
	end)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[init.spec]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3369"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["package"] = {
		["authors"] = { "Stephen Leitnick" },
		["description"] = "Signal class",
		["license"] = "MIT",
		["name"] = "sleitnick/signal",
		["realm"] = "shared",
		["registry"] = "https://github.com/UpliftGames/wally-index",
		["version"] = "1.5.0"
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[wally]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3370"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[elttob_fusion@0.3.0]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3371"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Types)
local v1 = require(script.External)
local v2 = require(script.RobloxExternal)
v1.setExternalProvider(v2)
local v3 = table.freeze
local v4 = {
	["version"] = {
		["major"] = 0,
		["minor"] = 3,
		["isRelease"] = true
	},
	["Contextual"] = require(script.Utility.Contextual),
	["Safe"] = require(script.Utility.Safe),
	["cleanup"] = require(script.Memory.legacyCleanup),
	["deriveScope"] = require(script.Memory.deriveScope),
	["doCleanup"] = require(script.Memory.doCleanup),
	["innerScope"] = require(script.Memory.innerScope),
	["scoped"] = require(script.Memory.scoped),
	["Observer"] = require(script.Graph.Observer),
	["Computed"] = require(script.State.Computed),
	["ForKeys"] = require(script.State.ForKeys),
	["ForPairs"] = require(script.State.ForPairs),
	["ForValues"] = require(script.State.ForValues),
	["peek"] = require(script.State.peek),
	["Value"] = require(script.State.Value),
	["Attribute"] = require(script.Instances.Attribute),
	["AttributeChange"] = require(script.Instances.AttributeChange),
	["AttributeOut"] = require(script.Instances.AttributeOut),
	["Child"] = require(script.Instances.Child),
	["Children"] = require(script.Instances.Children),
	["Hydrate"] = require(script.Instances.Hydrate),
	["New"] = require(script.Instances.New),
	["OnChange"] = require(script.Instances.OnChange),
	["OnEvent"] = require(script.Instances.OnEvent),
	["Out"] = require(script.Instances.Out),
	["Tween"] = require(script.Animation.Tween),
	["Spring"] = require(script.Animation.Spring)
}
return v3(v4)]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[fusion]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3372"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent
local v_u_2 = require(v1.Logging.formatError)
require(v1.Types)
local v_u_3 = {
	["safetyTimerMultiplier"] = 1
}
local v_u_4 = {}
local v_u_5 = nil
local v_u_6 = 0
function v_u_3.setExternalProvider(p7)
	-- upvalues: (ref) v_u_5
	local v8 = v_u_5
	if v8 ~= nil then
		v8.stopScheduler()
	end
	v_u_5 = p7
	if p7 ~= nil then
		p7.startScheduler()
	end
	return v8
end
function v_u_3.isTimeCritical()
	return false
end
function v_u_3.doTaskImmediate(p9)
	-- upvalues: (ref) v_u_5, (copy) v_u_3
	if v_u_5 == nil then
		v_u_3.logError("noTaskScheduler")
	else
		v_u_5.doTaskImmediate(p9)
	end
end
function v_u_3.doTaskDeferred(p10)
	-- upvalues: (ref) v_u_5, (copy) v_u_3
	if v_u_5 == nil then
		v_u_3.logError("noTaskScheduler")
	else
		v_u_5.doTaskDeferred(p10)
	end
end
function v_u_3.logError(p11, p12, ...)
	-- upvalues: (copy) v_u_2, (ref) v_u_5
	error(v_u_2(v_u_5, p11, p12, ...), 0)
end
function v_u_3.logErrorNonFatal(p13, p14, ...)
	-- upvalues: (copy) v_u_2, (ref) v_u_5
	local v15 = v_u_2(v_u_5, p13, p14, ...)
	if v_u_5 == nil then
		print(v15)
	else
		v_u_5.logErrorNonFatal(v15)
	end
end
function v_u_3.logWarn(p16, ...)
	-- upvalues: (copy) v_u_2, (ref) v_u_5
	local v17 = v_u_2(v_u_5, p16, debug.traceback(nil, 2), ...)
	if v_u_5 == nil then
		print(v17)
	else
		v_u_5.logWarn(v17)
	end
end
function v_u_3.bindToUpdateStep(p18)
	-- upvalues: (copy) v_u_4
	local v_u_19 = {}
	v_u_4[v_u_19] = p18
	return function()
		-- upvalues: (ref) v_u_4, (copy) v_u_19
		v_u_4[v_u_19] = nil
	end
end
function v_u_3.performUpdateStep(p20)
	-- upvalues: (ref) v_u_6, (copy) v_u_4
	v_u_6 = p20
	for _, v21 in v_u_4 do
		v21(p20)
	end
end
function v_u_3.lastUpdateStep()
	-- upvalues: (ref) v_u_6
	return v_u_6
end
return v_u_3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[External]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3373"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent
require(v1.Types)
local v_u_2 = nil
return {
	["setDebugger"] = function(p3)
		-- upvalues: (ref) v_u_2
		local v4 = v_u_2
		if v4 ~= nil then
			v4.stopDebugging()
		end
		v_u_2 = p3
		if p3 ~= nil then
			p3.startDebugging()
		end
		return v4
	end,
	["trackScope"] = function(p5)
		-- upvalues: (ref) v_u_2
		if v_u_2 ~= nil then
			v_u_2.trackScope(p5)
		end
	end,
	["untrackScope"] = function(p6)
		-- upvalues: (ref) v_u_2
		if v_u_2 ~= nil then
			v_u_2.trackScope(p6)
		end
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ExternalDebug]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3374"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("RunService")
local v_u_2 = game:GetService("HttpService")
local v3 = script.Parent
local v_u_4 = require(v3.External)
local v8 = {
	["policies"] = {
		["allowWebLinks"] = v_u_1:IsStudio()
	},
	["doTaskImmediate"] = function(p5)
		task.spawn(p5)
	end,
	["doTaskDeferred"] = function(p6)
		task.defer(p6)
	end,
	["logErrorNonFatal"] = function(p7)
		task.spawn(error, p7, 0)
	end,
	["logWarn"] = warn
}
local function v_u_9()
	-- upvalues: (copy) v_u_4
	v_u_4.performUpdateStep(os.clock())
end
local v_u_10 = nil
function v8.startScheduler()
	-- upvalues: (ref) v_u_10, (copy) v_u_1, (copy) v_u_2, (copy) v_u_9
	if v_u_10 == nil then
		if v_u_1:IsClient() then
			local v_u_11 = "FusionUpdateStep_" .. v_u_2:GenerateGUID()
			v_u_1:BindToRenderStep(v_u_11, Enum.RenderPriority.First.Value, v_u_9)
			v_u_10 = function()
				-- upvalues: (ref) v_u_1, (copy) v_u_11
				v_u_1:UnbindFromRenderStep(v_u_11)
			end
		else
			local v_u_12 = v_u_1.Heartbeat:Connect(v_u_9)
			v_u_10 = function()
				-- upvalues: (copy) v_u_12
				v_u_12:Disconnect()
			end
		end
	else
		return
	end
end
function v8.stopScheduler()
	-- upvalues: (ref) v_u_10
	if v_u_10 ~= nil then
		v_u_10()
		v_u_10 = nil
	end
end
return v8]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RobloxExternal]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3375"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return nil]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Types]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="3376"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Animation]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3377"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Graph.change)
local v_u_4 = require(v1.Utility.nicknames)
local v_u_5 = {
	["type"] = "State",
	["kind"] = "ExternalTime",
	["timeliness"] = "lazy",
	["dependencySet"] = table.freeze({}),
	["_EXTREMELY_DANGEROUS_usedAsValue"] = v_u_2.lastUpdateStep()
}
local v_u_6 = table.freeze({
	["__index"] = v_u_5
})
local v_u_7 = {}
function v_u_5._evaluate(_)
	return true
end
v_u_2.bindToUpdateStep(function(_)
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_7, (copy) v_u_3
	v_u_5._EXTREMELY_DANGEROUS_usedAsValue = v_u_2.lastUpdateStep()
	for _, v8 in v_u_7 do
		v_u_3(v8)
	end
end)
return function(p9)
	-- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_4
	local v10 = {
		["createdAt"] = os.clock(),
		["dependentSet"] = {},
		["lastChange"] = nil,
		["scope"] = p9,
		["validity"] = "invalid"
	}
	local v11 = v_u_6
	local v_u_12 = setmetatable(v10, v11)
	local function v14()
		-- upvalues: (copy) v_u_12, (ref) v_u_7
		v_u_12.scope = nil
		local v13 = table.find(v_u_7, v_u_12)
		if v13 ~= nil then
			table.remove(v_u_7, v13)
		end
	end
	v_u_12.oldestTask = v14
	v_u_4[v_u_12.oldestTask] = "ExternalTime"
	table.insert(p9, v14)
	local v15 = v_u_7
	table.insert(v15, v_u_12)
	return v_u_12
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ExternalTime]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3378"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.checkLifetime)
local v_u_4 = require(v1.Graph.depend)
local v_u_5 = require(v1.Graph.change)
local v_u_6 = require(v1.Graph.evaluate)
local v_u_7 = require(v1.State.castToState)
local v_u_8 = require(v1.State.peek)
local v_u_9 = require(v1.Animation.ExternalTime)
local v_u_10 = require(v1.Animation.Stopwatch)
local v_u_11 = require(v1.Animation.packType)
local v_u_12 = require(v1.Animation.unpackType)
local v_u_13 = require(v1.Animation.springCoefficients)
local v_u_14 = require(v1.Utility.nicknames)
local v15 = {
	["type"] = "State",
	["kind"] = "Spring",
	["timeliness"] = "eager"
}
local v_u_16 = table.freeze({
	["__index"] = v15
})
function v15.addVelocity(p17, p18)
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_12, (copy) v_u_5
	v_u_6(p17, false)
	local v19 = typeof(p18)
	if v19 ~= p17._activeType then
		v_u_2.logError("springTypeMismatch", nil, v19, p17._activeType)
	end
	local v20 = v_u_12(p18, v19)
	for v21, v22 in p17._activeLatestV do
		v20[v21] = v20[v21] + v22
	end
	p17._activeStartP = table.clone(p17._activeLatestP)
	p17._activeStartV = v20
	p17._stopwatch:zero()
	p17._stopwatch:unpause()
	v_u_5(p17)
end
function v15.get(_)
	-- upvalues: (copy) v_u_2
	return v_u_2.logError("stateGetWasRemoved")
end
function v15.setPosition(p23, p24)
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_12, (copy) v_u_5
	v_u_6(p23, false)
	local v25 = typeof(p24)
	if v25 ~= p23._activeType then
		v_u_2.logError("springTypeMismatch", nil, v25, p23._activeType)
	end
	p23._activeStartP = v_u_12(p24, v25)
	p23._activeStartV = table.clone(p23._activeLatestV)
	p23._stopwatch:zero()
	p23._stopwatch:unpause()
	v_u_5(p23)
end
function v15.setVelocity(p26, p27)
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_12, (copy) v_u_5
	v_u_6(p26, false)
	local v28 = typeof(p27)
	if v28 ~= p26._activeType then
		v_u_2.logError("springTypeMismatch", nil, v28, p26._activeType)
	end
	p26._activeStartP = table.clone(p26._activeLatestP)
	p26._activeStartV = v_u_12(p27, v28)
	p26._stopwatch:zero()
	p26._stopwatch:unpause()
	v_u_5(p26)
end
function v15._evaluate(p29)
	-- upvalues: (copy) v_u_7, (copy) v_u_8, (copy) v_u_2, (copy) v_u_4, (copy) v_u_13, (copy) v_u_11, (copy) v_u_12
	local v30 = v_u_7(p29._goal)
	if v30 == nil then
		p29._EXTREMELY_DANGEROUS_usedAsValue = p29._goal
		return false
	end
	local v31 = v_u_8(v30)
	if v31 ~= v31 then
		v_u_2.logWarn("springNanGoal")
		return false
	end
	local v32 = typeof(v31)
	local v33 = v32 ~= p29._activeType
	local v34 = p29._stopwatch
	local v35 = v_u_8(v34)
	v_u_4(p29, v34)
	local v36 = p29._EXTREMELY_DANGEROUS_usedAsValue
	local v37
	if v33 then
		v37 = v31
	elseif v35 <= 0 then
		v37 = v36
	else
		local v38, v39, v40, v41 = v_u_13(v35, p29._activeDamping, p29._activeSpeed)
		local v42 = false
		for v43 = 1, p29._activeNumSprings do
			local v44 = p29._activeStartP[v43]
			local v45 = p29._activeTargetP[v43]
			local v46 = p29._activeStartV[v43]
			local v47 = v44 - v45
			local v48 = v47 * v38 + v46 * v39
			local v49 = v47 * v40 + v46 * v41
			if v48 ~= v48 or v49 ~= v49 then
				v_u_2.logWarn("springNanMotion")
				v48 = 0
				v49 = 0
			end
			v42 = (math.abs(v48) > 0.00001 or math.abs(v49) > 0.00001) and true or v42
			local v50 = v48 + v45
			p29._activeLatestP[v43] = v50
			p29._activeLatestV[v43] = v49
		end
		if not v42 then
			for v51 = 1, p29._activeNumSprings do
				p29._activeLatestP[v51] = p29._activeTargetP[v51]
			end
		end
		v37 = v_u_11(p29._activeLatestP, p29._activeType)
	end
	local v52 = v_u_8(p29._speed)
	local v53 = v_u_8(p29._damping)
	if v33 or (v31 ~= p29._activeGoal or (v52 ~= p29._activeSpeed or v53 ~= p29._activeDamping)) then
		p29._activeTargetP = v_u_12(v31, v32)
		p29._activeNumSprings = #p29._activeTargetP
		if v33 then
			p29._activeStartP = table.clone(p29._activeTargetP)
			p29._activeLatestP = table.clone(p29._activeTargetP)
			p29._activeStartV = table.create(p29._activeNumSprings, 0)
			p29._activeLatestV = table.create(p29._activeNumSprings, 0)
		else
			p29._activeStartP = table.clone(p29._activeLatestP)
			p29._activeStartV = table.clone(p29._activeLatestV)
		end
		p29._activeType = v32
		p29._activeGoal = v31
		p29._activeDamping = v53
		p29._activeSpeed = v52
		v34:zero()
		v34:unpause()
	end
	p29._EXTREMELY_DANGEROUS_usedAsValue = v37
	return v36 ~= v37
end
table.freeze(v15)
return function(p54, p55, p56, p57)
	-- upvalues: (copy) v_u_7, (copy) v_u_2, (copy) v_u_10, (copy) v_u_9, (copy) v_u_8, (copy) v_u_16, (copy) v_u_14, (copy) v_u_3, (copy) v_u_6
	local v58 = os.clock()
	if typeof(p54) ~= "table" or v_u_7(p54) ~= nil then
		v_u_2.logError("scopeMissing", nil, "Springs", "myScope:Spring(goalState, speed, damping)")
	end
	local v59 = v_u_7(p55)
	local v60
	if v59 == nil then
		v60 = nil
	else
		v60 = v_u_10(p54, v_u_9(p54))
		v60:unpause()
	end
	local v61 = p56 or 10
	local v62 = p57 or 1
	local v63 = {
		["createdAt"] = v58,
		["dependencySet"] = {},
		["dependentSet"] = {},
		["lastChange"] = nil,
		["scope"] = p54,
		["validity"] = "invalid",
		["_activeDamping"] = -1,
		["_activeGoal"] = nil,
		["_activeLatestP"] = {},
		["_activeLatestV"] = {},
		["_activeNumSprings"] = 0,
		["_activeSpeed"] = -1,
		["_activeStartP"] = {},
		["_activeStartV"] = {},
		["_activeTargetP"] = {},
		["_activeType"] = "",
		["_damping"] = v62,
		["_EXTREMELY_DANGEROUS_usedAsValue"] = v_u_8(p55),
		["_goal"] = p55,
		["_speed"] = v61,
		["_stopwatch"] = v60
	}
	local v64 = v_u_16
	local v_u_65 = setmetatable(v63, v64)
	local function v67()
		-- upvalues: (copy) v_u_65
		v_u_65.scope = nil
		for v66 in pairs(v_u_65.dependencySet) do
			v66.dependentSet[v_u_65] = nil
		end
	end
	v_u_65.oldestTask = v67
	v_u_14[v_u_65.oldestTask] = "Spring"
	table.insert(p54, v67)
	if v59 ~= nil then
		v_u_3.bOutlivesA(p54, v_u_65.oldestTask, v59.scope, v59.oldestTask, v_u_3.formatters.animationGoal)
	end
	local v68 = v_u_7(v61)
	if v68 ~= nil then
		v_u_3.bOutlivesA(p54, v_u_65.oldestTask, v68.scope, v68.oldestTask, v_u_3.formatters.parameter, "speed")
	end
	local v69 = v_u_7(v62)
	if v69 ~= nil then
		v_u_3.bOutlivesA(p54, v_u_65.oldestTask, v69.scope, v69.oldestTask, v_u_3.formatters.parameter, "damping")
	end
	v_u_6(v_u_65, true)
	return v_u_65
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Spring]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3379"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.Memory.checkLifetime)
local v_u_3 = require(v1.Graph.depend)
local v_u_4 = require(v1.Graph.change)
local v_u_5 = require(v1.State.peek)
local v_u_6 = require(v1.Utility.nicknames)
local v7 = {
	["type"] = "State",
	["kind"] = "Stopwatch",
	["timeliness"] = "lazy"
}
local v_u_8 = table.freeze({
	["__index"] = v7
})
function v7.zero(p9)
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	local v10 = v_u_5(p9._timer)
	if v10 ~= p9._measureTimeSince then
		p9._measureTimeSince = v10
		p9._EXTREMELY_DANGEROUS_usedAsValue = 0
		v_u_4(p9)
	end
end
function v7.pause(p11)
	-- upvalues: (copy) v_u_4
	if p11._playing == true then
		p11._playing = false
		v_u_4(p11)
	end
end
function v7.unpause(p12)
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	if p12._playing == false then
		p12._playing = true
		p12._measureTimeSince = v_u_5(p12._timer) - p12._EXTREMELY_DANGEROUS_usedAsValue
		v_u_4(p12)
	end
end
function v7._evaluate(p13)
	-- upvalues: (copy) v_u_3, (copy) v_u_5
	if not p13._playing then
		return false
	end
	v_u_3(p13, p13._timer)
	local v14 = v_u_5(p13._timer)
	local v15 = p13._EXTREMELY_DANGEROUS_usedAsValue
	local v16 = v14 - p13._measureTimeSince
	p13._EXTREMELY_DANGEROUS_usedAsValue = v16
	return v15 ~= v16
end
table.freeze(v7)
return function(p17, p18)
	-- upvalues: (copy) v_u_8, (copy) v_u_6, (copy) v_u_2, (copy) v_u_3
	local v19 = {
		["awake"] = true,
		["createdAt"] = os.clock(),
		["dependencySet"] = {},
		["dependentSet"] = {},
		["lastChange"] = nil,
		["scope"] = p17,
		["validity"] = "invalid",
		["_EXTREMELY_DANGEROUS_usedAsValue"] = 0,
		["_measureTimeSince"] = 0,
		["_playing"] = false,
		["_timer"] = p18
	}
	local v20 = v_u_8
	local v_u_21 = setmetatable(v19, v20)
	local function v22()
		-- upvalues: (copy) v_u_21
		v_u_21.scope = nil
	end
	v_u_21.oldestTask = v22
	v_u_6[v_u_21.oldestTask] = "Stopwatch"
	table.insert(p17, v22)
	v_u_2.bOutlivesA(p17, v_u_21.oldestTask, p18.scope, p18.oldestTask, v_u_2.formatters.parameter, "timer")
	v_u_3(v_u_21, p18)
	return v_u_21
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Stopwatch]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3380"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.checkLifetime)
local v_u_4 = require(v1.Graph.depend)
local v_u_5 = require(v1.Graph.evaluate)
local v_u_6 = require(v1.State.castToState)
local v_u_7 = require(v1.State.peek)
local v_u_8 = require(v1.Animation.ExternalTime)
local v_u_9 = require(v1.Animation.Stopwatch)
local v_u_10 = require(v1.Animation.lerpType)
local v_u_11 = require(v1.Animation.getTweenRatio)
local v_u_12 = require(v1.Animation.getTweenDuration)
local v_u_13 = require(v1.Utility.nicknames)
local v14 = {
	["type"] = "State",
	["kind"] = "Tween",
	["timeliness"] = "eager"
}
local v_u_15 = table.freeze({
	["__index"] = v14
})
function v14.get(_)
	-- upvalues: (copy) v_u_2
	return v_u_2.logError("stateGetWasRemoved")
end
function v14._evaluate(p16)
	-- upvalues: (copy) v_u_6, (copy) v_u_4, (copy) v_u_7, (copy) v_u_2, (copy) v_u_12, (copy) v_u_11, (copy) v_u_10
	local v17 = v_u_6(p16._goal)
	if v17 == nil then
		p16._EXTREMELY_DANGEROUS_usedAsValue = p16._goal
		return false
	end
	v_u_4(p16, v17)
	local v18 = v_u_7(v17)
	if v18 ~= v18 then
		v_u_2.logWarn("tweenNanGoal")
		return false
	end
	local v19 = p16._stopwatch
	local v20 = v_u_7(p16._tweenInfo)
	if p16._activeTo ~= v18 or p16._activeElapsed < p16._activeDuration and p16._activeTweenInfo ~= v20 then
		p16._activeDuration = v_u_12(v20)
		p16._activeFrom = p16._EXTREMELY_DANGEROUS_usedAsValue
		p16._activeTo = v18
		p16._activeTweenInfo = v20
		v19:zero()
		v19:unpause()
	end
	v_u_4(p16, v19)
	p16._activeElapsed = v_u_7(v19)
	if p16._activeFrom ~= p16._activeTo and p16._activeElapsed < p16._activeDuration then
		local v21 = p16._activeTo
		local v22 = typeof(v21)
		local v23 = p16._activeFrom
		if v22 == typeof(v23) then
			::l12::
			local v24 = v_u_11(v20, p16._activeElapsed)
			local v25 = p16._EXTREMELY_DANGEROUS_usedAsValue
			local v26 = v_u_10(p16._activeFrom, p16._activeTo, v24)
			if v26 ~= v26 then
				v_u_2.logWarn("tweenNanMotion")
				v26 = p16._activeTo
			end
			p16._EXTREMELY_DANGEROUS_usedAsValue = v26
			return v25 ~= v26
		end
	end
	p16._activeFrom = p16._activeTo
	p16._activeElapsed = p16._activeDuration
	v19:pause()
	goto l12
end
table.freeze(v14)
return function(p27, p28, p29)
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_9, (copy) v_u_8, (copy) v_u_7, (copy) v_u_15, (copy) v_u_13, (copy) v_u_3, (copy) v_u_5
	local v30 = os.clock()
	if v_u_6(p27) then
		v_u_2.logError("scopeMissing", nil, "Tweens", "myScope:Tween(goalState, tweenInfo)")
	end
	local v31 = v_u_6(p28)
	local v32
	if v31 == nil then
		v32 = nil
	else
		v32 = v_u_9(p27, v_u_8(p27))
	end
	local v33 = {
		["createdAt"] = v30,
		["dependencySet"] = {},
		["dependentSet"] = {},
		["lastChange"] = nil,
		["scope"] = p27,
		["validity"] = "invalid",
		["_activeDuration"] = nil,
		["_activeElapsed"] = nil,
		["_activeFrom"] = nil,
		["_activeTo"] = nil,
		["_activeTweenInfo"] = nil,
		["_EXTREMELY_DANGEROUS_usedAsValue"] = v_u_7(p28),
		["_goal"] = p28,
		["_stopwatch"] = v32,
		["_tweenInfo"] = p29 or TweenInfo.new()
	}
	local v34 = v_u_15
	local v_u_35 = setmetatable(v33, v34)
	local function v37()
		-- upvalues: (copy) v_u_35
		v_u_35.scope = nil
		for v36 in pairs(v_u_35.dependencySet) do
			v36.dependentSet[v_u_35] = nil
		end
	end
	v_u_35.oldestTask = v37
	v_u_13[v_u_35.oldestTask] = "Tween"
	table.insert(p27, v37)
	if v31 ~= nil then
		v_u_3.bOutlivesA(p27, v_u_35.oldestTask, v31.scope, v31.oldestTask, v_u_3.formatters.animationGoal)
	end
	local v38 = v_u_6(p29)
	if v38 ~= nil then
		v_u_3.bOutlivesA(p27, v_u_35.oldestTask, v38.scope, v38.oldestTask, v_u_3.formatters.parameter, "tween info")
	end
	v_u_5(v_u_35, true)
	return v_u_35
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Tween]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3381"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

game:GetService("TweenService")
return function(p1)
	if p1.RepeatCount <= -1 then
		return (1 / 0)
	end
	local v2 = p1.DelayTime + p1.Time
	if p1.Reverses then
		v2 = v2 + p1.Time
	end
	return v2 * (p1.RepeatCount + 1)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[getTweenDuration]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3382"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("TweenService")
return function(p2, p3)
	-- upvalues: (copy) v_u_1
	local v4 = p2.DelayTime
	local v5 = p2.Time
	local v6 = p2.Reverses
	local v7 = 1 + p2.RepeatCount
	local v8 = p2.EasingStyle
	local v9 = p2.EasingDirection
	local v10 = v4 + v5
	if v6 then
		v10 = v10 + v5
	end
	if p3 == (1 / 0) then
		return 1
	end
	if v10 * v7 <= p3 and p2.RepeatCount > -1 then
		return 1
	end
	local v11 = p3 % v10
	if v11 <= v4 then
		return 0
	end
	local v12 = (v11 - v4) / v5
	if v12 > 1 then
		v12 = 2 - v12
	end
	return v_u_1:GetValue(v12, v8, v9)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[getTweenRatio]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3383"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.Colour.Oklab)
return function(p3, p4, p5)
	-- upvalues: (copy) v_u_2
	local v6 = typeof(p3)
	if typeof(p4) == v6 then
		if v6 == "number" then
			return (p4 - p3) * p5 + p3
		end
		if v6 == "CFrame" then
			return p3:Lerp(p4, p5)
		end
		if v6 == "Color3" then
			local v7 = v_u_2.fromSRGB(p3)
			local v8 = v_u_2.fromSRGB(p4)
			return v_u_2.toSRGB(v7:Lerp(v8, p5), false)
		end
		if v6 == "ColorSequenceKeypoint" then
			local v9 = v_u_2.fromSRGB(p3.Value)
			local v10 = v_u_2.fromSRGB(p4.Value)
			return ColorSequenceKeypoint.new((p4.Time - p3.Time) * p5 + p3.Time, v_u_2.toSRGB(v9:Lerp(v10, p5), false))
		end
		if v6 == "DateTime" then
			return DateTime.fromUnixTimestampMillis((p4.UnixTimestampMillis - p3.UnixTimestampMillis) * p5 + p3.UnixTimestampMillis)
		end
		if v6 == "NumberRange" then
			return NumberRange.new((p4.Min - p3.Min) * p5 + p3.Min, (p4.Max - p3.Max) * p5 + p3.Max)
		end
		if v6 == "NumberSequenceKeypoint" then
			return NumberSequenceKeypoint.new((p4.Time - p3.Time) * p5 + p3.Time, (p4.Value - p3.Value) * p5 + p3.Value, (p4.Envelope - p3.Envelope) * p5 + p3.Envelope)
		end
		if v6 == "PhysicalProperties" then
			return PhysicalProperties.new((p4.Density - p3.Density) * p5 + p3.Density, (p4.Friction - p3.Friction) * p5 + p3.Friction, (p4.Elasticity - p3.Elasticity) * p5 + p3.Elasticity, (p4.FrictionWeight - p3.FrictionWeight) * p5 + p3.FrictionWeight, (p4.ElasticityWeight - p3.ElasticityWeight) * p5 + p3.ElasticityWeight)
		end
		if v6 == "Ray" then
			return Ray.new(p3.Origin:Lerp(p4.Origin, p5), p3.Direction:Lerp(p4.Direction, p5))
		end
		if v6 == "Rect" then
			return Rect.new(p3.Min:Lerp(p4.Min, p5), p3.Max:Lerp(p4.Max, p5))
		end
		if v6 == "Region3" then
			local v11 = p3.CFrame.Position:Lerp(p4.CFrame.Position, p5)
			local v12 = p3.Size:Lerp(p4.Size, p5) / 2
			return Region3.new(v11 - v12, v11 + v12)
		end
		if v6 == "Region3int16" then
			return Region3int16.new(Vector3int16.new((p4.Min.X - p3.Min.X) * p5 + p3.Min.X, (p4.Min.Y - p3.Min.Y) * p5 + p3.Min.Y, (p4.Min.Z - p3.Min.Z) * p5 + p3.Min.Z), Vector3int16.new((p4.Max.X - p3.Max.X) * p5 + p3.Max.X, (p4.Max.Y - p3.Max.Y) * p5 + p3.Max.Y, (p4.Max.Z - p3.Max.Z) * p5 + p3.Max.Z))
		end
		if v6 == "UDim" then
			return UDim.new((p4.Scale - p3.Scale) * p5 + p3.Scale, (p4.Offset - p3.Offset) * p5 + p3.Offset)
		end
		if v6 == "UDim2" then
			return p3:Lerp(p4, p5)
		end
		if v6 == "Vector2" then
			return p3:Lerp(p4, p5)
		end
		if v6 == "Vector2int16" then
			return Vector2int16.new((p4.X - p3.X) * p5 + p3.X, (p4.Y - p3.Y) * p5 + p3.Y)
		end
		if v6 == "Vector3" then
			return p3:Lerp(p4, p5)
		end
		if v6 == "Vector3int16" then
			return Vector3int16.new((p4.X - p3.X) * p5 + p3.X, (p4.Y - p3.Y) * p5 + p3.Y, (p4.Z - p3.Z) * p5 + p3.Z)
		end
	end
	if p5 < 0.5 then
		return p3
	else
		return p4
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[lerpType]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3384"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.Colour.Oklab)
return function(p3, p4)
	-- upvalues: (copy) v_u_2
	if p4 == "number" then
		return p3[1]
	elseif p4 == "CFrame" then
		local v5 = CFrame.new(p3[1], p3[2], p3[3])
		local v6 = CFrame.fromAxisAngle
		local v7 = p3[4]
		local v8 = p3[5]
		local v9 = p3[6]
		return v5 * v6(Vector3.new(v7, v8, v9).Unit, p3[7])
	elseif p4 == "Color3" then
		local v10 = v_u_2.toSRGB
		local v11 = p3[1]
		local v12 = p3[2]
		local v13 = p3[3]
		return v10(Vector3.new(v11, v12, v13), false)
	elseif p4 == "ColorSequenceKeypoint" then
		local v14 = ColorSequenceKeypoint.new
		local v15 = p3[4]
		local v16 = v_u_2.toSRGB
		local v17 = p3[1]
		local v18 = p3[2]
		local v19 = p3[3]
		return v14(v15, v16(Vector3.new(v17, v18, v19), false))
	elseif p4 == "DateTime" then
		return DateTime.fromUnixTimestampMillis(p3[1])
	elseif p4 == "NumberRange" then
		return NumberRange.new(p3[1], p3[2])
	elseif p4 == "NumberSequenceKeypoint" then
		return NumberSequenceKeypoint.new(p3[2], p3[1], p3[3])
	elseif p4 == "PhysicalProperties" then
		return PhysicalProperties.new(p3[1], p3[2], p3[3], p3[4], p3[5])
	elseif p4 == "Ray" then
		local v20 = Ray.new
		local v21 = p3[1]
		local v22 = p3[2]
		local v23 = p3[3]
		local v24 = Vector3.new(v21, v22, v23)
		local v25 = p3[4]
		local v26 = p3[5]
		local v27 = p3[6]
		return v20(v24, (Vector3.new(v25, v26, v27)))
	elseif p4 == "Rect" then
		return Rect.new(p3[1], p3[2], p3[3], p3[4])
	elseif p4 == "Region3" then
		local v28 = p3[1]
		local v29 = p3[2]
		local v30 = p3[3]
		local v31 = Vector3.new(v28, v29, v30)
		local v32 = p3[4] / 2
		local v33 = p3[5] / 2
		local v34 = p3[6] / 2
		local v35 = Vector3.new(v32, v33, v34)
		return Region3.new(v31 - v35, v31 + v35)
	elseif p4 == "Region3int16" then
		return Region3int16.new(Vector3int16.new(p3[1], p3[2], p3[3]), Vector3int16.new(p3[4], p3[5], p3[6]))
	elseif p4 == "UDim" then
		return UDim.new(p3[1], p3[2])
	elseif p4 == "UDim2" then
		return UDim2.new(p3[1], p3[2], p3[3], p3[4])
	elseif p4 == "Vector2" then
		return Vector2.new(p3[1], p3[2])
	elseif p4 == "Vector2int16" then
		return Vector2int16.new(p3[1], p3[2])
	elseif p4 == "Vector3" then
		local v36 = p3[1]
		local v37 = p3[2]
		local v38 = p3[3]
		return Vector3.new(v36, v37, v38)
	elseif p4 == "Vector3int16" then
		return Vector3int16.new(p3[1], p3[2], p3[3])
	else
		return nil
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[packType]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3385"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2, p3)
	if p1 == 0 or p3 == 0 then
		return 1, 0, 0, 1
	end
	if p2 > 1 then
		local v4 = p2 ^ 2 - 1
		local v5 = math.sqrt(v4)
		local v6 = -0.5 / (v5 * p3)
		local v7 = p3 * (v5 + p2) * -1
		local v8 = p3 * (v5 - p2)
		local v9 = p1 * v7
		local v10 = math.exp(v9)
		local v11 = p1 * v8
		local v12 = math.exp(v11)
		return (v12 * v7 - v10 * v8) * v6, (v10 - v12) * v6 / p3, (v12 - v10) * v6 * p3, (v10 * v7 - v12 * v8) * v6
	end
	if p2 == 1 then
		local v13 = p1 * p3
		local v14 = v13 * -1
		local v15 = math.exp(v14)
		return v15 * (v13 + 1), v15 * p1, v15 * (v14 * p3), v15 * (v14 + 1)
	end
	local v16 = 1 - p2 ^ 2
	local v17 = p3 * math.sqrt(v16)
	local v18 = 1 / v17
	local v19 = p1 * -1 * p3 * p2
	local v20 = math.exp(v19)
	local v21 = v17 * p1
	local v22 = math.sin(v21)
	local v23 = v17 * p1
	local v24 = math.cos(v23)
	local v25 = v20 * v22
	local v26 = v20 * v24
	local v27 = v25 * p3 * p2 * v18
	return v27 + v26, v25 * v18, (v25 * v17 + p3 * p2 * v27) * -1, v26 - v27
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[springCoefficients]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3386"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.Colour.Oklab)
return function(p3, p4)
	-- upvalues: (copy) v_u_2
	if p4 == "number" then
		return { p3 }
	end
	if p4 == "CFrame" then
		local v5, v6 = p3:ToAxisAngle()
		return {
			p3.X,
			p3.Y,
			p3.Z,
			v5.X,
			v5.Y,
			v5.Z,
			v6
		}
	end
	if p4 == "Color3" then
		local v7 = v_u_2.fromSRGB(p3)
		return { v7.X, v7.Y, v7.Z }
	end
	if p4 ~= "ColorSequenceKeypoint" then
		return p4 == "DateTime" and { p3.UnixTimestampMillis } or (p4 == "NumberRange" and { p3.Min, p3.Max } or (p4 == "NumberSequenceKeypoint" and { p3.Value, p3.Time, p3.Envelope } or (p4 == "PhysicalProperties" and {
			p3.Density,
			p3.Friction,
			p3.Elasticity,
			p3.FrictionWeight,
			p3.ElasticityWeight
		} or (p4 == "Ray" and {
			p3.Origin.X,
			p3.Origin.Y,
			p3.Origin.Z,
			p3.Direction.X,
			p3.Direction.Y,
			p3.Direction.Z
		} or (p4 == "Rect" and {
			p3.Min.X,
			p3.Min.Y,
			p3.Max.X,
			p3.Max.Y
		} or (p4 == "Region3" and {
			p3.CFrame.X,
			p3.CFrame.Y,
			p3.CFrame.Z,
			p3.Size.X,
			p3.Size.Y,
			p3.Size.Z
		} or (p4 == "Region3int16" and {
			p3.Min.X,
			p3.Min.Y,
			p3.Min.Z,
			p3.Max.X,
			p3.Max.Y,
			p3.Max.Z
		} or (p4 == "UDim" and { p3.Scale, p3.Offset } or (p4 == "UDim2" and {
			p3.X.Scale,
			p3.X.Offset,
			p3.Y.Scale,
			p3.Y.Offset
		} or (p4 == "Vector2" and { p3.X, p3.Y } or (p4 == "Vector2int16" and { p3.X, p3.Y } or (p4 == "Vector3" and { p3.X, p3.Y, p3.Z } or (p4 == "Vector3int16" and { p3.X, p3.Y, p3.Z } or {})))))))))))))
	end
	local v8 = v_u_2.fromSRGB(p3.Value)
	return {
		v8.X,
		v8.Y,
		v8.Z,
		p3.Time
	}
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[unpackType]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3387"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Colour]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3388"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.sRGB)
local v_u_26 = {
	["fromLinear"] = function(p2)
		local v3 = p2.R * 0.4122214708 + p2.G * 0.5363325363 + p2.B * 0.0514459929
		local v4 = p2.R * 0.2119034982 + p2.G * 0.6806995451 + p2.B * 0.1073969566
		local v5 = p2.R * 0.0883024619 + p2.G * 0.2817188376 + p2.B * 0.6299787005
		local v6 = v3 ^ 0.3333333333333333
		local v7 = v4 ^ 0.3333333333333333
		local v8 = v5 ^ 0.3333333333333333
		local v9 = v6 * 0.2104542553 + v7 * 0.793617785 - v8 * 0.0040720468
		local v10 = v6 * 1.9779984951 - v7 * 2.428592205 + v8 * 0.4505937099
		local v11 = v6 * 0.0259040371 + v7 * 0.7827717662 - v8 * 0.808675766
		return Vector3.new(v9, v10, v11)
	end,
	["fromSRGB"] = function(p12)
		-- upvalues: (copy) v_u_26, (copy) v_u_1
		return v_u_26.fromLinear(v_u_1.toLinear(p12))
	end,
	["toLinear"] = function(p13, p14)
		local v15 = p13.X + p13.Y * 0.3963377774 + p13.Z * 0.2158037573
		local v16 = p13.X - p13.Y * 0.1055613458 - p13.Z * 0.0638541728
		local v17 = p13.X - p13.Y * 0.0894841775 - p13.Z * 1.291485548
		local v18 = v15 ^ 3
		local v19 = v16 ^ 3
		local v20 = v17 ^ 3
		local v21 = v18 * 4.0767416621 - v19 * 3.3077115913 + v20 * 0.2309699292
		local v22 = v18 * -1.2684380046 + v19 * 2.6097574011 - v20 * 0.3413193965
		local v23 = v18 * -0.0041960863 - v19 * 0.7034186147 + v20 * 1.707614701
		if not p14 then
			v21 = math.clamp(v21, 0, 1)
			v22 = math.clamp(v22, 0, 1)
			v23 = math.clamp(v23, 0, 1)
		end
		return Color3.new(v21, v22, v23)
	end,
	["toSRGB"] = function(p24, p25)
		-- upvalues: (copy) v_u_1, (copy) v_u_26
		return v_u_1.fromLinear(v_u_26.toLinear(p24, p25))
	end
}
return v_u_26]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Oklab]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3389"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["fromLinear"] = function(p1)
		local v2 = Color3.new
		local v3 = p1.R
		local v4
		if v3 >= 0.04045 then
			v4 = ((v3 + 0.055) / 1.055) ^ 2.4
		else
			v4 = v3 / 12.92
		end
		local v5 = p1.G
		local v6
		if v5 >= 0.04045 then
			v6 = ((v5 + 0.055) / 1.055) ^ 2.4
		else
			v6 = v5 / 12.92
		end
		local v7 = p1.B
		local v8
		if v7 >= 0.04045 then
			v8 = ((v7 + 0.055) / 1.055) ^ 2.4
		else
			v8 = v7 / 12.92
		end
		return v2(v4, v6, v8)
	end,
	["toLinear"] = function(p9)
		local v10 = Color3.new
		local v11 = p9.R
		local v12
		if v11 >= 0.0031308 then
			v12 = v11 ^ 0.4166666666666667 * 1.055 - 0.055
		else
			v12 = v11 * 12.92
		end
		local v13 = p9.G
		local v14
		if v13 >= 0.0031308 then
			v14 = v13 ^ 0.4166666666666667 * 1.055 - 0.055
		else
			v14 = v13 * 12.92
		end
		local v15 = p9.B
		local v16
		if v15 >= 0.0031308 then
			v16 = v15 ^ 0.4166666666666667 * 1.055 - 0.055
		else
			v16 = v15 * 12.92
		end
		return v10(v12, v14, v16)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[sRGB]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3390"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Graph]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3391"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.checkLifetime)
local v_u_4 = require(v1.Graph.castToGraph)
local v_u_5 = require(v1.Graph.depend)
local v_u_6 = require(v1.Graph.evaluate)
local v_u_7 = require(v1.Utility.nicknames)
local v8 = {
	["type"] = "Observer",
	["timeliness"] = "eager",
	["dependentSet"] = table.freeze({})
}
local v_u_9 = table.freeze({
	["__index"] = v8
})
function v8.onBind(p10, p11)
	-- upvalues: (copy) v_u_2
	v_u_2.doTaskImmediate(p11)
	return p10:onChange(p11)
end
function v8.onChange(p_u_12, p13)
	local v_u_14 = table.freeze({})
	p_u_12._changeListeners[v_u_14] = p13
	return function()
		-- upvalues: (copy) p_u_12, (copy) v_u_14
		p_u_12._changeListeners[v_u_14] = nil
	end
end
function v8._evaluate(p15)
	-- upvalues: (copy) v_u_5, (copy) v_u_2
	if p15._watchingGraph ~= nil then
		v_u_5(p15, p15._watchingGraph)
	end
	for _, v16 in p15._changeListeners do
		v_u_2.doTaskImmediate(v16)
	end
	return true
end
table.freeze(v8)
return function(p17, p18)
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_9, (copy) v_u_7, (copy) v_u_3, (copy) v_u_6
	local v19 = os.clock()
	if p18 == nil then
		v_u_2.logError("scopeMissing", nil, "Observers", "myScope:Observer(watching)")
	end
	local v20 = {
		["scope"] = p17,
		["createdAt"] = v19,
		["dependencySet"] = {},
		["lastChange"] = nil,
		["validity"] = "invalid",
		["_watchingGraph"] = v_u_4(p18),
		["_changeListeners"] = {}
	}
	local v21 = v_u_9
	local v_u_22 = setmetatable(v20, v21)
	local function v24()
		-- upvalues: (copy) v_u_22
		v_u_22.scope = nil
		for v23 in pairs(v_u_22.dependencySet) do
			v23.dependentSet[v_u_22] = nil
		end
	end
	v_u_22.oldestTask = v24
	v_u_7[v_u_22.oldestTask] = "Observer"
	table.insert(p17, v24)
	if v_u_22._watchingGraph ~= nil then
		v_u_3.bOutlivesA(p17, v_u_22.oldestTask, v_u_22._watchingGraph.scope, v_u_22._watchingGraph.oldestTask, v_u_3.formatters.observer)
	end
	v_u_6(v_u_22, true)
	return v_u_22
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Observer]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3392"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
return function(p2)
	if typeof(p2) == "table" then
		local v3 = p2.validity
		if typeof(v3) == "string" then
			local v4 = p2.timeliness
			if typeof(v4) == "string" then
				local v5 = p2.dependencySet
				if typeof(v5) == "table" then
					local v6 = p2.dependentSet
					if typeof(v6) == "table" then
						return p2
					end
				end
			end
		end
	end
	return nil
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[castToGraph]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3393"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Graph.evaluate)
return function(p4)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	if p4.validity == "busy" then
		return v_u_2.logError("infiniteLoop")
	end
	if v_u_3(p4, true) then
		local v5 = os.clock() + 1 * v_u_2.safetyTimerMultiplier
		local v6 = { p4 }
		local v7 = {}
		local v8 = {}
		while v5 >= os.clock() do
			local v9 = true
			for _, v10 in v6 do
				for v11 in v10.dependentSet do
					if v11.validity == "valid" then
						table.insert(v7, v11)
						table.insert(v8, v11)
						v9 = false
					elseif v11.validity == "busy" then
						return v_u_2.logError("infiniteLoop")
					end
				end
			end
			table.clear(v6)
			if v9 then
				local v12 = {}
				for _, v13 in v7 do
					v13.validity = "invalid"
					if v13.timeliness == "eager" then
						table.insert(v12, v13)
					end
				end
				table.sort(v12, function(p14, p15)
					return p14.createdAt < p15.createdAt
				end)
				for _, v16 in v12 do
					v_u_3(v16, false)
				end
				return
			end
			local v17 = v8
			v8 = v6
			v6 = v17
		end
		return v_u_2.logError("infiniteLoop")
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[change]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3394"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Graph.evaluate)
local v_u_4 = require(v1.Utility.nameOf)
return function(p5, p6)
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_4
	v_u_3(p6, false)
	if table.isfrozen(p5.dependencySet) or table.isfrozen(p6.dependentSet) then
		v_u_2.logError("cannotDepend", nil, v_u_4(p5, "Dependent"), v_u_4(p6, "dependency"))
	end
	p6.dependentSet[p5] = true
	p5.dependencySet[p6] = true
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[depend]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3395"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local function v_u_10(p3, p4)
	-- upvalues: (copy) v_u_2, (copy) v_u_10
	if p3.validity == "busy" then
		return v_u_2.logError("infiniteLoop")
	end
	local v5 = p3.lastChange == nil
	if not v5 and (p3.validity ~= "invalid" and not p4) then
		return false
	end
	local v6 = v5 or p4
	if not v6 then
		for v7 in p3.dependencySet do
			v_u_10(v7, false)
			if v7.lastChange > p3.lastChange then
				v6 = true
				break
			end
		end
	end
	local v8
	if v6 then
		for v9 in p3.dependencySet do
			v9.dependentSet[p3] = nil
			p3.dependencySet[v9] = nil
		end
		p3.validity = "busy"
		v8 = p3:_evaluate() or v5
	else
		v8 = false
	end
	if v8 then
		p3.lastChange = os.clock()
	end
	p3.validity = "valid"
	return v8
end
return v_u_10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[evaluate]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3396"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Instances]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3397"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.Memory.checkLifetime)
local v_u_3 = require(v1.Graph.Observer)
local v_u_4 = require(v1.State.castToState)
local v_u_5 = require(v1.State.peek)
local v_u_6 = {}
return function(p_u_7)
	-- upvalues: (copy) v_u_6, (copy) v_u_4, (copy) v_u_2, (copy) v_u_3, (copy) v_u_5
	local v8 = v_u_6[p_u_7]
	if v8 == nil then
		v8 = {
			["type"] = "SpecialKey",
			["kind"] = "Attribute",
			["stage"] = "self",
			["apply"] = function(_, p9, p_u_10, p_u_11)
				-- upvalues: (ref) v_u_4, (ref) v_u_2, (copy) p_u_7, (ref) v_u_3, (ref) v_u_5
				if v_u_4(p_u_10) then
					v_u_2.bOutlivesA(p9, p_u_11, p_u_10.scope, p_u_10.oldestTask, v_u_2.formatters.boundAttribute, p_u_7)
					v_u_3(p9, p_u_10):onBind(function()
						-- upvalues: (copy) p_u_11, (ref) p_u_7, (ref) v_u_5, (copy) p_u_10
						p_u_11:SetAttribute(p_u_7, v_u_5(p_u_10))
					end)
				else
					p_u_11:SetAttribute(p_u_7, p_u_10)
				end
			end
		}
		v_u_6[p_u_7] = v8
	end
	return v8
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Attribute]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3398"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = {}
return function(p_u_4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v5 = v_u_3[p_u_4]
	if v5 == nil then
		v5 = {
			["type"] = "SpecialKey",
			["kind"] = "AttributeChange",
			["stage"] = "observer",
			["apply"] = function(_, p6, p_u_7, p_u_8)
				-- upvalues: (ref) v_u_2, (copy) p_u_4
				if typeof(p_u_7) ~= "function" then
					v_u_2.logError("invalidAttributeChangeHandler", nil, p_u_4)
				end
				local v9 = p_u_8:GetAttributeChangedSignal(p_u_4)
				local function v10()
					-- upvalues: (copy) p_u_7, (copy) p_u_8, (ref) p_u_4
					p_u_7(p_u_8:GetAttribute(p_u_4))
				end
				table.insert(p6, v9:Connect(v10))
			end
		}
		v_u_3[p_u_4] = v5
	end
	return v5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AttributeChange]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3399"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.checkLifetime)
local v_u_4 = require(v1.State.castToState)
local v_u_5 = {}
return function(p_u_6)
	-- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) v_u_2, (copy) v_u_3
	local v7 = v_u_5[p_u_6]
	if v7 == nil then
		v7 = {
			["type"] = "SpecialKey",
			["kind"] = "AttributeOut",
			["stage"] = "observer",
			["apply"] = function(_, p8, p_u_9, p_u_10)
				-- upvalues: (copy) p_u_6, (ref) v_u_4, (ref) v_u_2, (ref) v_u_3
				local v11 = p_u_10:GetAttributeChangedSignal(p_u_6)
				if not v_u_4(p_u_9) then
					v_u_2.logError("invalidAttributeOutType")
				end
				if p_u_9.kind ~= "Value" then
					v_u_2.logError("invalidAttributeOutType")
				end
				v_u_3.bOutlivesA(p8, p_u_10, p_u_9.scope, p_u_9.oldestTask, v_u_3.formatters.attributeOutputsTo, p_u_6)
				p_u_9:set(p_u_10:GetAttribute(p_u_6))
				local function v12()
					-- upvalues: (copy) p_u_9, (copy) p_u_10, (ref) p_u_6
					p_u_9:set(p_u_10:GetAttribute(p_u_6))
				end
				table.insert(p8, v11:Connect(v12))
			end
		}
		v_u_5[p_u_6] = v7
	end
	return v7
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AttributeOut]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3400"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
return function(p2)
	return p2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Child]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3401"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Graph.Observer)
local v_u_4 = require(v1.State.peek)
local v_u_5 = require(v1.State.castToState)
local v_u_6 = require(v1.Memory.doCleanup)
return {
	["type"] = "SpecialKey",
	["kind"] = "Children",
	["stage"] = "descendants",
	["apply"] = function(_, p7, p_u_8, p_u_9)
		-- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) v_u_3, (copy) v_u_2, (copy) v_u_6
		local v_u_10 = {}
		local v_u_11 = {}
		local v_u_12 = {}
		local v_u_13 = {}
		local function v_u_28()
			-- upvalues: (ref) v_u_11, (ref) v_u_10, (ref) v_u_13, (ref) v_u_12, (copy) p_u_9, (ref) v_u_5, (ref) v_u_4, (ref) v_u_3, (copy) v_u_28, (ref) v_u_2, (ref) p_u_8, (ref) v_u_6
			local v14 = v_u_11
			v_u_11 = v_u_10
			v_u_10 = v14
			local v15 = v_u_13
			v_u_13 = v_u_12
			v_u_12 = v15
			local function v_u_25(p16, p17)
				-- upvalues: (ref) v_u_10, (ref) v_u_11, (ref) p_u_9, (ref) v_u_5, (ref) v_u_4, (copy) v_u_25, (ref) v_u_13, (ref) v_u_3, (ref) v_u_28, (ref) v_u_12, (ref) v_u_2
				local v18 = typeof(p16)
				if v18 == "Instance" then
					v_u_10[p16] = true
					if v_u_11[p16] == nil then
						p16.Parent = p_u_9
					else
						v_u_11[p16] = nil
					end
				elseif v_u_5(p16) then
					local v19 = v_u_4(p16)
					if v19 ~= nil then
						v_u_25(v19, p17)
					end
					local v20 = v_u_13[p16]
					if v20 == nil then
						v20 = {}
						v_u_3(v20, p16):onChange(v_u_28)
					else
						v_u_13[p16] = nil
					end
					v_u_12[p16] = v20
					return
				elseif v18 == "table" then
					for v21, v22 in pairs(p16) do
						local v23 = typeof(v21)
						local v24 = nil
						if v23 == "string" then
							v24 = v21
						elseif v23 == "number" and p17 ~= nil then
							v24 = p17 .. "_" .. v21
						end
						v_u_25(v22, v24)
					end
				else
					v_u_2.logWarn("unrecognisedChildType", v18)
				end
			end
			if p_u_8 ~= nil then
				v_u_25(p_u_8)
			end
			for v26 in pairs(v_u_11) do
				v26.Parent = nil
			end
			table.clear(v_u_11)
			for _, v27 in pairs(v_u_13) do
				v_u_6(v27)
			end
			table.clear(v_u_13)
		end
		table.insert(p7, function()
			-- upvalues: (ref) p_u_8, (copy) v_u_28
			p_u_8 = nil
			v_u_28()
		end)
		v_u_28()
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Children]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3402"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Instances.applyInstanceProps)
return function(p_u_4, p_u_5)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	if p_u_5 == nil then
		v_u_2.logError("scopeMissing", nil, "instances using Hydrate", "myScope:Hydrate (instance) { ... }")
	end
	return function(p6)
		-- upvalues: (copy) p_u_4, (copy) p_u_5, (ref) v_u_3
		local v7 = p_u_4
		local v8 = p_u_5
		table.insert(v7, v8)
		v_u_3(p_u_4, p6, p_u_5)
		return p_u_5
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Hydrate]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3403"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Instances.defaultProps)
local v_u_4 = require(v1.Instances.applyInstanceProps)
return function(p_u_5, p_u_6)
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_4
	if p_u_6 == nil then
		v_u_2.logError("scopeMissing", nil, "instances using New", "myScope:New \"" .. p_u_5 .. "\" { ... }")
	end
	return function(p7)
		-- upvalues: (copy) p_u_6, (ref) v_u_2, (ref) v_u_3, (copy) p_u_5, (ref) v_u_4
		local v8, v9 = pcall(Instance.new, p_u_6)
		if not v8 then
			v_u_2.logError("cannotCreateClass", nil, p_u_6)
		end
		local v10 = v_u_3[p_u_6]
		if v10 ~= nil then
			for v11, v12 in pairs(v10) do
				v9[v11] = v12
			end
		end
		local v13 = p_u_5
		table.insert(v13, v9)
		v_u_4(p_u_5, p7, v9)
		return v9
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[New]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3404"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = {}
return function(p_u_4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v5 = v_u_3[p_u_4]
	if v5 == nil then
		v5 = {
			["type"] = "SpecialKey",
			["kind"] = "OnChange",
			["stage"] = "observer",
			["apply"] = function(_, p6, p_u_7, p_u_8)
				-- upvalues: (copy) p_u_4, (ref) v_u_2
				local v9, v10 = pcall(p_u_8.GetPropertyChangedSignal, p_u_8, p_u_4)
				if v9 then
					if typeof(p_u_7) == "function" then
						local function v11()
							-- upvalues: (copy) p_u_7, (copy) p_u_8, (ref) p_u_4
							p_u_7(p_u_8[p_u_4])
						end
						table.insert(p6, v10:Connect(v11))
					else
						v_u_2.logError("invalidChangeHandler", nil, p_u_4)
					end
				else
					v_u_2.logError("cannotConnectChange", nil, p_u_8.ClassName, p_u_4)
					return
				end
			end
		}
		v_u_3[p_u_4] = v5
	end
	return v5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[OnChange]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3405"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = {}
local function v_u_6(p4, p5)
	return p4[p5]
end
return function(p_u_7)
	-- upvalues: (copy) v_u_3, (copy) v_u_6, (copy) v_u_2
	local v8 = v_u_3[p_u_7]
	if v8 == nil then
		v8 = {
			["type"] = "SpecialKey",
			["kind"] = "OnEvent",
			["stage"] = "observer",
			["apply"] = function(_, p9, p10, p11)
				-- upvalues: (ref) v_u_6, (copy) p_u_7, (ref) v_u_2
				local v12, v13 = pcall(v_u_6, p11, p_u_7)
				if v12 and typeof(v13) == "RBXScriptSignal" then
					if typeof(p10) == "function" then
						table.insert(p9, v13:Connect(p10))
					else
						v_u_2.logError("invalidEventHandler", nil, p_u_7)
					end
				else
					v_u_2.logError("cannotConnectEvent", nil, p11.ClassName, p_u_7)
					return
				end
			end
		}
		v_u_3[p_u_7] = v8
	end
	return v8
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[OnEvent]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3406"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.checkLifetime)
local v_u_4 = require(v1.State.castToState)
local v_u_5 = {}
return function(p_u_6)
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_4, (copy) v_u_3
	local v7 = v_u_5[p_u_6]
	if v7 == nil then
		v7 = {
			["type"] = "SpecialKey",
			["kind"] = "Out",
			["stage"] = "observer",
			["apply"] = function(_, p8, p_u_9, p_u_10)
				-- upvalues: (copy) p_u_6, (ref) v_u_2, (ref) v_u_4, (ref) v_u_3
				local v11, v12 = pcall(p_u_10.GetPropertyChangedSignal, p_u_10, p_u_6)
				if not v11 then
					v_u_2.logError("invalidOutProperty", nil, p_u_10.ClassName, p_u_6)
				end
				if not v_u_4(p_u_9) then
					v_u_2.logError("invalidOutType")
				end
				if p_u_9.kind ~= "Value" then
					v_u_2.logError("invalidOutType")
				end
				v_u_3.bOutlivesA(p8, p_u_10, p_u_9.scope, p_u_9.oldestTask, v_u_3.formatters.propertyOutputsTo, p_u_6)
				p_u_9:set(p_u_10[p_u_6])
				local function v13()
					-- upvalues: (copy) p_u_9, (copy) p_u_10, (ref) p_u_6
					p_u_9:set(p_u_10[p_u_6])
				end
				table.insert(p8, v12:Connect(v13))
			end
		}
		v_u_5[p_u_6] = v7
	end
	return v7
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Out]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3407"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Logging.parseError)
local v_u_4 = require(v1.Memory.checkLifetime)
local v_u_5 = require(v1.Graph.Observer)
local v_u_6 = require(v1.State.castToState)
local v_u_7 = require(v1.State.peek)
local v_u_8 = require(v1.Utility.xtypeof)
local function v_u_12(p9, p10, p11)
	p9[p10] = p11
end
local function v_u_15(p13, p14)
	p13[p14] = p13[p14]
end
local function v_u_24(p16, p17, p18)
	-- upvalues: (copy) v_u_12, (copy) v_u_3, (copy) v_u_15, (copy) v_u_2
	local v19, v20 = xpcall(v_u_12, v_u_3, p16, p17, p18)
	if not v19 then
		if not pcall(v_u_15, p16, p17) then
			v_u_2.logErrorNonFatal("cannotAssignProperty", nil, p16.ClassName, p17)
			return
		end
		local v21 = typeof(p18)
		local v22 = p16[p17]
		local v23 = typeof(v22)
		if v21 == v23 then
			v_u_2.logErrorNonFatal("propertySetError", v20)
			return
		end
		v_u_2.logErrorNonFatal("invalidPropertyType", nil, p16.ClassName, p17, v23, v21)
	end
end
local function v_u_29(p25, p_u_26, p_u_27, p_u_28)
	-- upvalues: (copy) v_u_6, (copy) v_u_4, (copy) v_u_5, (copy) v_u_24, (copy) v_u_7
	if v_u_6(p_u_28) then
		v_u_4.bOutlivesA(p25, p_u_26, p_u_28.scope, p_u_28.oldestTask, v_u_4.formatters.boundProperty, p_u_27)
		v_u_5(p25, p_u_28):onBind(function()
			-- upvalues: (ref) v_u_24, (copy) p_u_26, (copy) p_u_27, (ref) v_u_7, (copy) p_u_28
			v_u_24(p_u_26, p_u_27, v_u_7(p_u_28))
		end)
	else
		v_u_24(p_u_26, p_u_27, p_u_28)
	end
end
return function(p30, p31, p32)
	-- upvalues: (copy) v_u_8, (copy) v_u_29, (copy) v_u_2
	local v33 = {
		["self"] = {},
		["descendants"] = {},
		["ancestor"] = {},
		["observer"] = {}
	}
	for v34, v35 in pairs(p31) do
		local v36 = v_u_8(v34)
		if v36 == "string" then
			if v34 ~= "Parent" then
				v_u_29(p30, p32, v34, v35)
			end
		elseif v36 == "SpecialKey" then
			local v37 = v34.stage
			local v38 = v33[v37]
			if v38 == nil then
				v_u_2.logError("unrecognisedPropertyStage", nil, v37)
			else
				v38[v34] = v35
			end
		else
			v_u_2.logError("unrecognisedPropertyKey", nil, v36)
		end
	end
	for v39, v40 in pairs(v33.self) do
		v39:apply(p30, v40, p32)
	end
	for v41, v42 in pairs(v33.descendants) do
		v41:apply(p30, v42, p32)
	end
	if p31.Parent ~= nil then
		v_u_29(p30, p32, "Parent", p31.Parent)
	end
	for v43, v44 in pairs(v33.ancestor) do
		v43:apply(p30, v44, p32)
	end
	for v45, v46 in pairs(v33.observer) do
		v45:apply(p30, v46, p32)
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[applyInstanceProps]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3408"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["ScreenGui"] = {
		["ResetOnSpawn"] = false,
		["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
	},
	["BillboardGui"] = {
		["ResetOnSpawn"] = false,
		["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling,
		["Active"] = true
	},
	["SurfaceGui"] = {
		["ResetOnSpawn"] = false,
		["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling,
		["SizingMode"] = Enum.SurfaceGuiSizingMode.PixelsPerStud,
		["PixelsPerStud"] = 50
	},
	["Frame"] = {
		["BackgroundColor3"] = Color3.new(1, 1, 1),
		["BorderColor3"] = Color3.new(0, 0, 0),
		["BorderSizePixel"] = 0
	},
	["ScrollingFrame"] = {
		["BackgroundColor3"] = Color3.new(1, 1, 1),
		["BorderColor3"] = Color3.new(0, 0, 0),
		["BorderSizePixel"] = 0,
		["ScrollBarImageColor3"] = Color3.new(0, 0, 0)
	},
	["TextLabel"] = {
		["BackgroundColor3"] = Color3.new(1, 1, 1),
		["BorderColor3"] = Color3.new(0, 0, 0),
		["BorderSizePixel"] = 0,
		["Font"] = Enum.Font.SourceSans,
		["Text"] = "",
		["TextColor3"] = Color3.new(0, 0, 0),
		["TextSize"] = 14
	},
	["TextButton"] = {
		["BackgroundColor3"] = Color3.new(1, 1, 1),
		["BorderColor3"] = Color3.new(0, 0, 0),
		["BorderSizePixel"] = 0,
		["AutoButtonColor"] = false,
		["Font"] = Enum.Font.SourceSans,
		["Text"] = "",
		["TextColor3"] = Color3.new(0, 0, 0),
		["TextSize"] = 14
	},
	["TextBox"] = {
		["BackgroundColor3"] = Color3.new(1, 1, 1),
		["BorderColor3"] = Color3.new(0, 0, 0),
		["BorderSizePixel"] = 0,
		["ClearTextOnFocus"] = false,
		["Font"] = Enum.Font.SourceSans,
		["Text"] = "",
		["TextColor3"] = Color3.new(0, 0, 0),
		["TextSize"] = 14
	},
	["ImageLabel"] = {
		["BackgroundColor3"] = Color3.new(1, 1, 1),
		["BorderColor3"] = Color3.new(0, 0, 0),
		["BorderSizePixel"] = 0
	},
	["ImageButton"] = {
		["BackgroundColor3"] = Color3.new(1, 1, 1),
		["BorderColor3"] = Color3.new(0, 0, 0),
		["BorderSizePixel"] = 0,
		["AutoButtonColor"] = false
	},
	["ViewportFrame"] = {
		["BackgroundColor3"] = Color3.new(1, 1, 1),
		["BorderColor3"] = Color3.new(0, 0, 0),
		["BorderSizePixel"] = 0
	},
	["VideoFrame"] = {
		["BackgroundColor3"] = Color3.new(1, 1, 1),
		["BorderColor3"] = Color3.new(0, 0, 0),
		["BorderSizePixel"] = 0
	},
	["CanvasGroup"] = {
		["BackgroundColor3"] = Color3.new(1, 1, 1),
		["BorderColor3"] = Color3.new(0, 0, 0),
		["BorderSizePixel"] = 0
	},
	["SpawnLocation"] = {
		["Duration"] = 0
	},
	["BoxHandleAdornment"] = {
		["ZIndex"] = 0
	},
	["ConeHandleAdornment"] = {
		["ZIndex"] = 0
	},
	["CylinderHandleAdornment"] = {
		["ZIndex"] = 0
	},
	["ImageHandleAdornment"] = {
		["ZIndex"] = 0
	},
	["LineHandleAdornment"] = {
		["ZIndex"] = 0
	},
	["SphereHandleAdornment"] = {
		["ZIndex"] = 0
	},
	["WireframeHandleAdornment"] = {
		["ZIndex"] = 0
	},
	["Part"] = {
		["Anchored"] = true,
		["Size"] = Vector3.new(1, 1, 1),
		["FrontSurface"] = Enum.SurfaceType.Smooth,
		["BackSurface"] = Enum.SurfaceType.Smooth,
		["LeftSurface"] = Enum.SurfaceType.Smooth,
		["RightSurface"] = Enum.SurfaceType.Smooth,
		["TopSurface"] = Enum.SurfaceType.Smooth,
		["BottomSurface"] = Enum.SurfaceType.Smooth
	},
	["TrussPart"] = {
		["Anchored"] = true,
		["Size"] = Vector3.new(2, 2, 2),
		["FrontSurface"] = Enum.SurfaceType.Smooth,
		["BackSurface"] = Enum.SurfaceType.Smooth,
		["LeftSurface"] = Enum.SurfaceType.Smooth,
		["RightSurface"] = Enum.SurfaceType.Smooth,
		["TopSurface"] = Enum.SurfaceType.Smooth,
		["BottomSurface"] = Enum.SurfaceType.Smooth
	},
	["MeshPart"] = {
		["Anchored"] = true,
		["Size"] = Vector3.new(1, 1, 1),
		["FrontSurface"] = Enum.SurfaceType.Smooth,
		["BackSurface"] = Enum.SurfaceType.Smooth,
		["LeftSurface"] = Enum.SurfaceType.Smooth,
		["RightSurface"] = Enum.SurfaceType.Smooth,
		["TopSurface"] = Enum.SurfaceType.Smooth,
		["BottomSurface"] = Enum.SurfaceType.Smooth
	},
	["CornerWedgePart"] = {
		["Anchored"] = true,
		["Size"] = Vector3.new(1, 1, 1),
		["FrontSurface"] = Enum.SurfaceType.Smooth,
		["BackSurface"] = Enum.SurfaceType.Smooth,
		["LeftSurface"] = Enum.SurfaceType.Smooth,
		["RightSurface"] = Enum.SurfaceType.Smooth,
		["TopSurface"] = Enum.SurfaceType.Smooth,
		["BottomSurface"] = Enum.SurfaceType.Smooth
	},
	["VehicleSeat"] = {
		["Anchored"] = true,
		["Size"] = Vector3.new(1, 1, 1),
		["FrontSurface"] = Enum.SurfaceType.Smooth,
		["BackSurface"] = Enum.SurfaceType.Smooth,
		["LeftSurface"] = Enum.SurfaceType.Smooth,
		["RightSurface"] = Enum.SurfaceType.Smooth,
		["TopSurface"] = Enum.SurfaceType.Smooth,
		["BottomSurface"] = Enum.SurfaceType.Smooth
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[defaultProps]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3409"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Logging]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3410"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.Logging.messages)
return function(p3, p4, p5, ...)
	-- upvalues: (copy) v_u_2
	local v6
	if typeof(p5) == "table" then
		v6 = p5
	else
		v6 = nil
	end
	if typeof(p5) == "table" then
		p5 = p5.trace
	end
	local v7 = v_u_2[p4]
	local v8
	if v7 == nil then
		v8 = "unknownMessage"
		v7 = v_u_2[v8]
	else
		v8 = p4
	end
	local v9 = v7:format(...)
	local v10
	if v6 == nil then
		v10 = v9:gsub("ERROR_MESSAGE", p4)
	else
		v10 = v9:gsub("ERROR_MESSAGE", v6.message)
		if v6.context ~= nil then
			v10 = v10 .. (" (%*)"):format(v6.context)
		end
	end
	local v11 = ("[Fusion] %* \nID: %*"):format(v10, v8)
	if p3 ~= nil and p3.policies.allowWebLinks then
		v11 = v11 .. ("\nLearn more: https://elttob.uk/Fusion/0.3/api-reference/general/errors/#%*"):format((v8:lower()))
	end
	if p5 ~= nil then
		v11 = v11 .. (" \n---- Stack trace ----\n%*"):format(p5)
	end
	return v11:gsub("\n", "\n    ")
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[formatError]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3411"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["callbackError"] = "Error in callback:\nERROR_MESSAGE",
	["cannotAssignProperty"] = "The class type \'%s\' has no assignable property \'%s\'.",
	["cannotConnectChange"] = "The %s class doesn\'t have a property called \'%s\'.",
	["cannotConnectEvent"] = "The %s class doesn\'t have an event called \'%s\'.",
	["cannotCreateClass"] = "Can\'t create a new instance of class \'%s\'.",
	["cannotDepend"] = "%s can\'t depend on %s.",
	["cleanupWasRenamed"] = "`Fusion.cleanup` was renamed to `Fusion.doCleanup`. This will be an error in future versions of Fusion.",
	["destroyedTwice"] = "`doCleanup()` was given something that it is already cleaning up. Unclear how to proceed.",
	["destructorRedundant"] = "%s destructors no longer do anything. If you wish to run code on destroy, `table.insert` a function into the `scope` argument. See discussion #292 on GitHub for advice.",
	["forKeyCollision"] = "The key \'%s\' was returned multiple times simultaneously, which is not allowed in `For` objects.",
	["infiniteLoop"] = "Detected an infinite loop. Consider adding an explicit breakpoint to your code to prevent a cyclic dependency.",
	["invalidAttributeChangeHandler"] = "The change handler for the \'%s\' attribute must be a function.",
	["invalidAttributeOutType"] = "[AttributeOut] properties must be given Value objects.",
	["invalidChangeHandler"] = "The change handler for the \'%s\' property must be a function.",
	["invalidEventHandler"] = "The handler for the \'%s\' event must be a function.",
	["invalidOutProperty"] = "The %s class doesn\'t have a property called \'%s\'.",
	["invalidOutType"] = "[Out] properties must be given Value objects.",
	["invalidPropertyType"] = "\'%s.%s\' expected a \'%s\' type, but got a \'%s\' type.",
	["invalidRefType"] = "Instance refs must be Value objects.",
	["invalidSpringDamping"] = "The damping ratio for a spring must be >= 0. (damping was %.2f)",
	["invalidSpringSpeed"] = "The speed of a spring must be >= 0. (speed was %.2f)",
	["mergeConflict"] = "Multiple definitions for \'%s\' found while merging.",
	["mistypedSpringDamping"] = "The damping ratio for a spring must be a number. (got a %s)",
	["mistypedSpringSpeed"] = "The speed of a spring must be a number. (got a %s)",
	["mistypedTweenInfo"] = "The tween info of a tween must be a TweenInfo. (got a %s)",
	["noTaskScheduler"] = "Fusion is not connected to an external task scheduler.",
	["poisonedScope"] = "Attempted to use a scope after it\'s been destroyed; %s",
	["possiblyOutlives"] = "%s will be destroyed before %s; %s. To fix this, review the order they\'re created in, and what scopes they belong to. See discussion #292 on GitHub for advice.",
	["propertySetError"] = "Error setting property:\nERROR_MESSAGE",
	["scopeMissing"] = "To create %s, provide a scope. (e.g. `%s`). See discussion #292 on GitHub for advice.",
	["springNanGoal"] = "A spring was given a NaN goal, so some simulation has been skipped. Ensure no springs have NaN goals.",
	["springNanMotion"] = "A spring encountered NaN during motion, so has snapped to the goal position. Ensure no springs have NaN positions or velocities.",
	["springTypeMismatch"] = "The type \'%s\' doesn\'t match the spring\'s type \'%s\'.",
	["stateGetWasRemoved"] = "`StateObject:get()` has been replaced by `use()` and `peek()` - see discussion #217 on GitHub.",
	["tweenNanGoal"] = "A tween was given a NaN goal, so some animation has been skipped. Ensure no tweens have NaN goals.",
	["tweenNanMotion"] = "A tween encountered NaN during motion, so has snapped to the goal. Ensure no tweens have NaN in their tween infos.",
	["unknownMessage"] = "Unknown error:\nERROR_MESSAGE",
	["unrecognisedChildType"] = "\'%s\' type children aren\'t accepted by `[Children]`.",
	["unrecognisedPropertyKey"] = "\'%s\' keys aren\'t accepted in property tables.",
	["unrecognisedPropertyStage"] = "\'%s\' isn\'t a valid stage for a special key to be applied at.",
	["useAfterDestroy"] = "%s is no longer valid - it was destroyed before %s. See discussion #292 on GitHub for advice."
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[messages]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3412"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
return function(p2)
	return {
		["type"] = "Error",
		["raw"] = p2,
		["message"] = p2:gsub("^.+:%d+:%s*", ""),
		["trace"] = debug.traceback(nil, 2)
	}
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[parseError]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3413"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Memory]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3414"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.whichLivesLonger)
local v_u_4 = require(v1.Utility.nameOf)
local v5 = {
	["formatters"] = {}
}
function v5.formatters.useFunction(p6, p7)
	-- upvalues: (copy) v_u_4
	local v8 = v_u_4(p6, "object")
	return ("The use()-d %*"):format((v_u_4(p7, "object"))), ("the %*"):format(v8)
end
function v5.formatters.boundProperty(p9, p10, p11)
	-- upvalues: (copy) v_u_4
	local v12 = p9.Name
	return ("The %* (bound to the %* property)"):format(v_u_4(p10, "value"), p11), ("the %* instance"):format(v12)
end
function v5.formatters.boundAttribute(p13, p14, p15)
	-- upvalues: (copy) v_u_4
	local v16 = p13.Name
	return ("The %* (bound to the %* attribute)"):format(v_u_4(p14, "value"), p15), ("the %* instance"):format(v16)
end
function v5.formatters.propertyOutputsTo(p17, p18, p19)
	-- upvalues: (copy) v_u_4
	local v20 = p17.Name
	return ("The %* (which the %* property outputs to)"):format(v_u_4(p18, "object"), p19), ("the %* instance"):format(v20)
end
function v5.formatters.attributeOutputsTo(p21, p22, p23)
	-- upvalues: (copy) v_u_4
	local v24 = p21.Name
	return ("The %* (which the %* attribute outputs to)"):format(v_u_4(p22, "object"), p23), ("the %* instance"):format(v24)
end
function v5.formatters.refOutputsTo(p25, p26)
	-- upvalues: (copy) v_u_4
	local v27 = p25.Name
	return ("The %* (which the Ref key outputs to)"):format((v_u_4(p26, "object"))), ("the %* instance"):format(v27)
end
function v5.formatters.animationGoal(p28, p29)
	-- upvalues: (copy) v_u_4
	local v30 = v_u_4(p28, "object")
	return ("The goal %*"):format((v_u_4(p29, "object"))), ("the %* that is following it"):format(v30)
end
function v5.formatters.parameter(p31, p32, p33)
	-- upvalues: (copy) v_u_4
	local v34 = v_u_4(p31, "object")
	local v35 = v_u_4(p32, "object")
	if p33 == false then
		return ("The %* parameter"):format(v35), ("the %* that it was used for"):format(v34)
	else
		return ("The %* representing the %* parameter"):format(v35, p33), ("the %* that it was used for"):format(v34)
	end
end
function v5.formatters.observer(p36, p37)
	-- upvalues: (copy) v_u_4
	local v38 = v_u_4(p36, "object")
	return ("The watched %*"):format((v_u_4(p37, "object"))), ("the %* that\'s observing it for changes"):format(v38)
end
function v5.bOutlivesA(p39, p40, p41, p42, p43, ...)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	if p41 == nil then
		v_u_2.logError("useAfterDestroy", nil, p43(p40, p42, ...))
	elseif v_u_3(p39, p40, p41, p42) == "definitely-a" then
		local v44, v45 = p43(p40, p42, ...)
		v_u_2.logWarn("possiblyOutlives", v44, v45, p39 == p41 and "they\'re in the same scope, but the latter is destroyed too quickly" or "the latter is in a different scope that gets destroyed too quickly")
	end
end
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[checkLifetime]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3415"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.ExternalDebug)
local v_u_3 = require(v1.Memory.deriveScopeImpl)
return function(...)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v4 = v_u_3(...)
	v_u_2.trackScope(v4)
	return v4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[deriveScope]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3416"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.Utility.merge)
local v_u_3 = require(v1.Memory.scopePool)
return function(p4, p5, ...)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v6 = getmetatable(p4)
	if p5 ~= nil then
		v6 = table.clone(v6)
		v6.__index = v_u_2(true, {}, v6.__index, v_u_2(false, {}, p5, ...))
	end
	local v7 = v_u_3.reuseAny() or {}
	return setmetatable(v7, v6)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[deriveScopeImpl]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3417"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.scopePool)
local v_u_4 = require(v1.Memory.poisonScope)
local v_u_5 = {}
local function v_u_10(p6)
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_10, (copy) v_u_3, (copy) v_u_4
	if v_u_5[p6] then
		return v_u_2.logError("destroyedTwice")
	end
	v_u_5[p6] = true
	if typeof(p6) == "Instance" then
		p6:Destroy()
	elseif typeof(p6) == "RBXScriptConnection" then
		p6:Disconnect()
	elseif typeof(p6) == "function" then
		p6()
	elseif typeof(p6) == "table" then
		local v7 = p6.destroy
		if typeof(v7) == "function" then
			p6:destroy()
		else
			local v8 = p6.Destroy
			if typeof(v8) == "function" then
				p6:Destroy()
			elseif p6[1] ~= nil then
				for v9 = #p6, 1, -1 do
					v_u_10(p6[v9])
					p6[v9] = nil
				end
				if v_u_2.isTimeCritical() then
					v_u_3.giveIfEmpty(p6)
				else
					v_u_4(p6, "`doCleanup()` was previously called on this scope. Ensure you are not reusing scopes after cleanup.")
				end
			end
		end
	end
	v_u_5[p6] = nil
end
return v_u_10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[doCleanup]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3418"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.ExternalDebug)
local v_u_3 = require(v1.Memory.deriveScopeImpl)
return function(p_u_4, ...)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v_u_5 = v_u_3(p_u_4, ...)
	table.insert(p_u_4, v_u_5)
	table.insert(v_u_5, function()
		-- upvalues: (copy) p_u_4, (copy) v_u_5
		local v6 = table.find(p_u_4, v_u_5)
		if v6 ~= nil then
			table.remove(p_u_4, v6)
		end
	end)
	v_u_2.trackScope(v_u_5)
	return v_u_5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[innerScope]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3419"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.doCleanup)
return function(p4)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	v_u_2.logWarn("cleanupWasRenamed")
	return v_u_3(p4)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[legacyCleanup]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3420"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	return typeof(p1) == "Instance"
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[needsDestruction]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3421"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
return function(p3, p_u_4)
	-- upvalues: (copy) v_u_2
	local v5 = getmetatable(p3)
	if typeof(v5) ~= "table" or not v5._FUSION_POISONED then
		table.clear(p3)
		local v6 = {
			["_FUSION_POISONED"] = true,
			["__index"] = function()
				-- upvalues: (ref) v_u_2, (copy) p_u_4
				v_u_2.logError("poisonedScope", nil, p_u_4)
			end,
			["__newindex"] = function()
				-- upvalues: (ref) v_u_2, (copy) p_u_4
				v_u_2.logError("poisonedScope", nil, p_u_4)
			end
		}
		setmetatable(p3, v6)
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[poisonScope]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3422"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.Memory.poisonScope)
local v_u_3 = require(v1.ExternalDebug)
local v_u_4 = {}
local v_u_5 = 0
return {
	["giveIfEmpty"] = function(p6)
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		if next(p6) ~= nil then
			return p6
		end
		v_u_3.untrackScope(p6)
		v_u_2(p6, "previously passed to the internal scope pool, which indicates a Fusion bug.")
		return nil
	end,
	["clearAndGive"] = function(p7)
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		v_u_3.untrackScope(p7)
		table.clear(p7)
		v_u_2(p7, "previously passed to the internal scope pool, which indicates a Fusion bug.")
	end,
	["reuseAny"] = function()
		-- upvalues: (ref) v_u_5, (copy) v_u_4
		if v_u_5 == 0 then
			return nil
		end
		local v8 = v_u_4[v_u_5]
		v_u_5 = v_u_5 - 1
		return v8
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[scopePool]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3423"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.ExternalDebug)
local v_u_3 = require(v1.Utility.merge)
local v_u_4 = require(v1.Memory.scopePool)
return function(...)
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_2
	local v5 = v_u_4.reuseAny() or {}
	local v6 = {
		["__index"] = v_u_3(false, {}, ...)
	}
	local v7 = setmetatable(v5, v6)
	v_u_2.trackScope(v7)
	return v7
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[scoped]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3424"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local function v_u_13(p3, p4)
	local v5 = 2
	local v6 = { p3, p4 }
	local v7 = {}
	local v8 = 0
	local v9 = {}
	while v5 > 0 do
		for _, v10 in v6 do
			v7[v10] = true
			for _, v11 in ipairs(v10) do
				if v11 == p3 then
					return "definitely-b"
				end
				if v11 == p4 then
					return "definitely-a"
				end
				if typeof(v11) == "table" and (v11[1] ~= nil and v7[v10] == nil) then
					v8 = v8 + 1
					v9[v8] = v11
				end
			end
		end
		table.clear(v6)
		v5 = v8
		local v12 = v9
		v9 = v6
		v6 = v12
		v8 = 0
	end
	return "unsure"
end
return function(p14, p15, p16, p17)
	-- upvalues: (copy) v_u_2, (copy) v_u_13
	if v_u_2.isTimeCritical() then
		return "unsure"
	end
	if p14 ~= p16 then
		return v_u_13(p14, p16)
	end
	for v18 = #p14, 1, -1 do
		local v19 = p14[v18]
		if v19 == p15 then
			return "definitely-b"
		end
		if v19 == p17 then
			return "definitely-a"
		end
	end
	return "unsure"
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[whichLivesLonger]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3425"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[State]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3426"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Logging.parseError)
local v_u_4 = require(v1.Utility.isSimilar)
local v_u_5 = require(v1.Utility.never)
local v_u_6 = require(v1.Graph.depend)
local v_u_7 = require(v1.State.castToState)
local v_u_8 = require(v1.State.peek)
local v_u_9 = require(v1.Memory.doCleanup)
local v_u_10 = require(v1.Memory.deriveScope)
local v_u_11 = require(v1.Memory.checkLifetime)
local v_u_12 = require(v1.Memory.scopePool)
local v_u_13 = require(v1.Utility.nicknames)
local v14 = {
	["type"] = "State",
	["kind"] = "Computed",
	["timeliness"] = "lazy"
}
local v_u_15 = table.freeze({
	["__index"] = v14
})
function v14.get(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_5
	v_u_2.logError("stateGetWasRemoved")
	return v_u_5()
end
function v14._evaluate(p_u_16)
	-- upvalues: (copy) v_u_10, (copy) v_u_7, (copy) v_u_11, (copy) v_u_6, (copy) v_u_8, (copy) v_u_3, (copy) v_u_12, (copy) v_u_4, (copy) v_u_9, (copy) v_u_2
	if p_u_16.scope == nil then
		return false
	end
	local v_u_17 = p_u_16.scope
	local v18 = v_u_10(v_u_17)
	local function v21(p19)
		-- upvalues: (ref) v_u_7, (ref) v_u_11, (copy) v_u_17, (copy) p_u_16, (ref) v_u_6, (ref) v_u_8
		local v20 = v_u_7(p19)
		if v20 ~= nil then
			v_u_11.bOutlivesA(v_u_17, p_u_16.oldestTask, v20.scope, v20.oldestTask, v_u_11.formatters.useFunction)
			v_u_6(p_u_16, v20)
		end
		return v_u_8(p19)
	end
	local v22, v23 = xpcall(p_u_16._processor, v_u_3, v21, v18)
	local v24 = v_u_12.giveIfEmpty(v18)
	if not v22 then
		if v24 ~= nil then
			v_u_9(v24)
		end
		v_u_2.logErrorNonFatal("callbackError", v23)
		return false
	end
	local v25 = v_u_4(p_u_16._EXTREMELY_DANGEROUS_usedAsValue, v23)
	if p_u_16._innerScope ~= nil then
		v_u_9(p_u_16._innerScope)
	end
	p_u_16._innerScope = v24
	p_u_16._EXTREMELY_DANGEROUS_usedAsValue = v23
	return not v25
end
table.freeze(v14)
return function(p26, p27, p28)
	-- upvalues: (copy) v_u_2, (copy) v_u_15, (copy) v_u_9, (copy) v_u_13
	local v29 = os.clock()
	if typeof(p26) == "function" then
		v_u_2.logError("scopeMissing", nil, "Computeds", "myScope:Computed(function(use, scope) ... end)")
	elseif p28 ~= nil then
		v_u_2.logWarn("destructorRedundant", "Computed")
	end
	local v30 = v_u_15
	local v_u_31 = setmetatable({
		["createdAt"] = v29,
		["dependencySet"] = {},
		["dependentSet"] = {},
		["lastChange"] = nil,
		["scope"] = p26,
		["validity"] = "invalid",
		["_EXTREMELY_DANGEROUS_usedAsValue"] = nil,
		["_innerScope"] = nil,
		["_processor"] = p27
	}, v30)
	local function v33()
		-- upvalues: (copy) v_u_31, (ref) v_u_9
		v_u_31.scope = nil
		for v32 in pairs(v_u_31.dependencySet) do
			v32.dependentSet[v_u_31] = nil
		end
		if v_u_31._innerScope ~= nil then
			v_u_9(v_u_31._innerScope)
		end
	end
	v_u_31.oldestTask = v33
	v_u_13[v_u_31.oldestTask] = "Computed"
	table.insert(p26, v33)
	return v_u_31
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Computed]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3427"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Graph.depend)
local v_u_4 = require(v1.State.peek)
local v_u_5 = require(v1.State.castToState)
require(v1.State.For.ForTypes)
local v_u_6 = require(v1.Utility.never)
local v_u_7 = require(v1.Utility.nicknames)
local v_u_8 = require(v1.State.For.Disassembly)
local v9 = {
	["type"] = "State",
	["kind"] = "For",
	["timeliness"] = "lazy"
}
local v_u_10 = table.freeze({
	["__index"] = v9
})
function v9.get(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_6
	v_u_2.logError("stateGetWasRemoved")
	return v_u_6()
end
function v9._evaluate(p_u_11)
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_4
	if p_u_11.scope == nil then
		return false
	end
	local _ = p_u_11.scope
	v_u_3(p_u_11, p_u_11._disassembly)
	table.clear(p_u_11._EXTREMELY_DANGEROUS_usedAsValue)
	p_u_11._disassembly:populate(function(p12)
		-- upvalues: (ref) v_u_5, (ref) v_u_3, (copy) p_u_11, (ref) v_u_4
		local v13 = v_u_5(p12)
		if v13 ~= nil then
			v_u_3(p_u_11, v13)
		end
		return v_u_4(p12)
	end, p_u_11._EXTREMELY_DANGEROUS_usedAsValue)
	return true
end
table.freeze(v9)
return function(p14, p15, p16)
	-- upvalues: (copy) v_u_8, (copy) v_u_10, (copy) v_u_7
	local v17 = {
		["createdAt"] = os.clock(),
		["dependencySet"] = {},
		["dependentSet"] = {},
		["scope"] = p14,
		["validity"] = "invalid",
		["_EXTREMELY_DANGEROUS_usedAsValue"] = {},
		["_disassembly"] = v_u_8(p14, p15, p16)
	}
	local v18 = v_u_10
	local v_u_19 = setmetatable(v17, v18)
	local function v21()
		-- upvalues: (copy) v_u_19
		v_u_19.scope = nil
		for v20 in pairs(v_u_19.dependencySet) do
			v20.dependentSet[v_u_19] = nil
		end
	end
	v_u_19.oldestTask = v21
	v_u_7[v_u_19.oldestTask] = "For"
	table.insert(p14, v21)
	return v_u_19
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[For]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3428"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Graph.depend)
local v_u_4 = require(v1.State.peek)
local v_u_5 = require(v1.State.castToState)
require(v1.State.For.ForTypes)
local v_u_6 = require(v1.Memory.doCleanup)
local v_u_7 = require(v1.Memory.deriveScope)
local v_u_8 = require(v1.Memory.scopePool)
local v_u_9 = require(v1.Utility.nameOf)
local v_u_10 = require(v1.Utility.nicknames)
local v11 = {
	["type"] = "Graph",
	["kind"] = "For.Disassembly",
	["timeliness"] = "lazy"
}
local v_u_12 = table.freeze({
	["__index"] = v11
})
function v11.populate(p13, p14, p15)
	-- upvalues: (copy) v_u_2
	local v16 = (1 / 0)
	local v17 = (-1 / 0)
	local v18 = false
	for v19 in p13._subObjects do
		local v20, v21 = v19:useOutputPair(p14)
		if v20 == nil or v21 == nil then
			v18 = true
		elseif p15[v20] == nil then
			p15[v20] = v21
			if typeof(v20) == "number" then
				v16 = math.min(v16, v20)
				v17 = math.max(v17, v20)
			end
		else
			v_u_2.logErrorNonFatal("forKeyCollision", nil, (tostring(v20)))
		end
	end
	if v18 and v16 < v17 then
		for v22 = v16, v17 do
			local v23 = p15[v22]
			if v23 ~= nil then
				p15[v22] = nil
				p15[v16] = v23
				v16 = v16 + 1
			end
		end
	end
end
function v11._evaluate(p24)
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_9, (copy) v_u_3, (copy) v_u_4, (copy) v_u_6, (copy) v_u_7, (copy) v_u_8
	local v25 = p24.scope
	local v26 = v_u_5(p24._inputTable)
	if v26 ~= nil then
		if v26.scope == nil then
			v_u_2.logError("useAfterDestroy", nil, ("The input %*"):format((v_u_9(v26, "table"))), "the For object that is watching it")
		end
		v_u_3(p24, v26)
	end
	local v27 = {}
	for v28, v29 in v_u_4(p24._inputTable) do
		v27[v28] = v29
	end
	local v30 = {}
	for v31 in p24._subObjects do
		local v32 = false
		local v33 = v31.inputKey
		local v34 = v31.inputValue
		local v35 = nil
		if v31.roamKeys or v27[v33] == nil then
			for v36, v37 in v27 do
				v32 = true
				if v31.roamValues or v37 == v34 then
					v35 = v36
					break
				end
				v35 = v36
			end
		else
			v35 = v33
			v32 = true
		end
		if v32 then
			local v38 = v27[v35]
			v30[v31] = true
			if v35 ~= v33 then
				v31.inputKey = v35
				v31:invalidateInputKey()
			end
			if v38 ~= v34 then
				v31.inputValue = v38
				v31:invalidateInputValue()
			end
			v27[v35] = nil
		elseif v31.maybeScope ~= nil then
			v_u_6(v31.maybeScope)
			v31.maybeScope = nil
		end
	end
	for v39, v40 in v27 do
		local v41 = p24._constructor(v_u_7(v25), v39, v40)
		if v41.maybeScope ~= nil then
			v41.maybeScope = v_u_8.giveIfEmpty(v41.maybeScope)
		end
		v30[v41] = true
	end
	p24._subObjects = v30
	return true
end
table.freeze(v11)
return function(p42, p43, p44)
	-- upvalues: (copy) v_u_12, (copy) v_u_6, (copy) v_u_10
	local v45 = {
		["createdAt"] = os.clock(),
		["dependencySet"] = {},
		["dependentSet"] = {},
		["scope"] = p42,
		["validity"] = "invalid",
		["_inputTable"] = p43,
		["_constructor"] = p44,
		["_subObjects"] = {}
	}
	local v46 = v_u_12
	local v_u_47 = setmetatable(v45, v46)
	local function v50()
		-- upvalues: (copy) v_u_47, (ref) v_u_6
		v_u_47.scope = nil
		for v48 in pairs(v_u_47.dependencySet) do
			v48.dependentSet[v_u_47] = nil
		end
		for v49 in v_u_47._subObjects do
			if v49.maybeScope ~= nil then
				v_u_6(v49.maybeScope)
				v49.maybeScope = nil
			end
		end
	end
	v_u_47.oldestTask = v50
	v_u_10[v_u_47.oldestTask] = "For (internal disassembler)"
	table.insert(p42, v50)
	return v_u_47
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Disassembly]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3429"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent.Parent
require(v1.Types)
return nil]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ForTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3430"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.doCleanup)
local v_u_4 = require(v1.State.For)
local v_u_5 = require(v1.State.Value)
local v_u_6 = require(v1.State.Computed)
require(v1.State.For.ForTypes)
local v_u_7 = require(v1.Logging.parseError)
local v_u_11 = {
	["__index"] = {
		["roamKeys"] = false,
		["roamValues"] = true,
		["invalidateInputKey"] = function(p8)
			p8._inputKeyState:set(p8.inputKey)
		end,
		["invalidateInputValue"] = function(_) end,
		["useOutputPair"] = function(p9, p10)
			return p10(p9._outputKeyState), p9.inputValue
		end
	}
}
local function v_u_23(p12, p13, p14, p15)
	-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_7, (copy) v_u_2, (copy) v_u_3, (copy) v_u_11
	local v_u_16 = {
		["maybeScope"] = p12,
		["inputKey"] = p13,
		["inputValue"] = p14,
		["_inputKeyState"] = v_u_5(p12, p13),
		["_processor"] = p15
	}
	v_u_16._outputKeyState = v_u_6(p12, function(p17, p18)
		-- upvalues: (copy) v_u_16, (ref) v_u_7, (ref) v_u_2, (ref) v_u_3
		local v19 = p17(v_u_16._inputKeyState)
		local v20, v21 = xpcall(v_u_16._processor, v_u_7, p17, p18, v19)
		if v20 then
			return v21
		end
		v21.context = ("while processing key %*"):format((tostring(v19)))
		v_u_2.logErrorNonFatal("callbackError", v21)
		v_u_3(p18)
		table.clear(p18)
		return nil
	end)
	local v22 = v_u_11
	return setmetatable(v_u_16, v22)
end
return function(p24, p25, p_u_26, p27)
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_23
	if typeof(p25) == "function" then
		v_u_2.logError("scopeMissing", nil, "ForKeys", "myScope:ForKeys(inputTable, function(scope, use, key) ... end)")
	elseif p27 ~= nil then
		v_u_2.logWarn("destructorRedundant", "ForKeys")
	end
	return v_u_4(p24, p25, function(p28, p29, p30)
		-- upvalues: (ref) v_u_23, (copy) p_u_26
		return v_u_23(p28, p29, p30, p_u_26)
	end)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ForKeys]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3431"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.State.For)
local v_u_4 = require(v1.State.Value)
local v_u_5 = require(v1.State.Computed)
require(v1.State.For.ForTypes)
local v_u_6 = require(v1.Logging.parseError)
local v_u_7 = require(v1.Memory.doCleanup)
local v_u_13 = {
	["__index"] = {
		["roamKeys"] = false,
		["roamValues"] = false,
		["invalidateInputKey"] = function(p8)
			p8._inputKeyState:set(p8.inputKey)
		end,
		["invalidateInputValue"] = function(p9)
			p9._inputValueState:set(p9.inputValue)
		end,
		["useOutputPair"] = function(p10, p11)
			local v12 = p11(p10._outputPairState)
			return v12.key, v12.value
		end
	}
}
local function v_u_27(p14, p15, p16, p17)
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_2, (copy) v_u_7, (copy) v_u_13
	local v_u_18 = {
		["maybeScope"] = p14,
		["inputKey"] = p15,
		["inputValue"] = p16,
		["_inputKeyState"] = v_u_4(p14, p15),
		["_inputValueState"] = v_u_4(p14, p16),
		["_processor"] = p17
	}
	v_u_18._outputPairState = v_u_5(p14, function(p19, p20)
		-- upvalues: (copy) v_u_18, (ref) v_u_6, (ref) v_u_2, (ref) v_u_7
		local v21 = p19(v_u_18._inputKeyState)
		local v22 = p19(v_u_18._inputValueState)
		local v23, v24, v25 = xpcall(v_u_18._processor, v_u_6, p19, p20, v21, v22)
		if v23 then
			return {
				["key"] = v24,
				["value"] = v25
			}
		end
		v24.context = ("while processing key %* and value %*"):format(tostring(v22), (tostring(v22)))
		v_u_2.logErrorNonFatal("callbackError", v24)
		v_u_7(p20)
		table.clear(p20)
		return {
			["key"] = nil,
			["value"] = nil
		}
	end)
	local v26 = v_u_13
	return setmetatable(v_u_18, v26)
end
return function(p28, p29, p_u_30, p31)
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_27
	if typeof(p29) == "function" then
		v_u_2.logError("scopeMissing", nil, "ForPairs", "myScope:ForPairs(inputTable, function(scope, use, key, value) ... end)")
	elseif p31 ~= nil then
		v_u_2.logWarn("destructorRedundant", "ForPairs")
	end
	return v_u_3(p28, p29, function(p32, p33, p34)
		-- upvalues: (ref) v_u_27, (copy) p_u_30
		return v_u_27(p32, p33, p34, p_u_30)
	end)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ForPairs]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3432"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.State.For)
local v_u_4 = require(v1.State.Value)
local v_u_5 = require(v1.State.Computed)
require(v1.State.For.ForTypes)
local v_u_6 = require(v1.Logging.parseError)
local v_u_7 = require(v1.Memory.doCleanup)
local v_u_11 = {
	["__index"] = {
		["roamKeys"] = true,
		["roamValues"] = false,
		["invalidateInputKey"] = function(_) end,
		["invalidateInputValue"] = function(p8)
			p8._inputValueState:set(p8.inputValue)
		end,
		["useOutputPair"] = function(p9, p10)
			return p9.inputKey, p10(p9._outputValueState)
		end
	}
}
local function v_u_23(p12, p13, p14, p15)
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_2, (copy) v_u_7, (copy) v_u_11
	local v_u_16 = {
		["maybeScope"] = p12,
		["inputKey"] = p13,
		["inputValue"] = p14,
		["_inputValueState"] = v_u_4(p12, p14),
		["_processor"] = p15
	}
	v_u_16._outputValueState = v_u_5(p12, function(p17, p18)
		-- upvalues: (copy) v_u_16, (ref) v_u_6, (ref) v_u_2, (ref) v_u_7
		local v19 = p17(v_u_16._inputValueState)
		local v20, v21 = xpcall(v_u_16._processor, v_u_6, p17, p18, v19)
		if v20 then
			return v21
		end
		v21.context = ("while processing value %*"):format((tostring(v19)))
		v_u_2.logErrorNonFatal("callbackError", v21)
		v_u_7(p18)
		table.clear(p18)
		return nil
	end)
	local v22 = v_u_11
	return setmetatable(v_u_16, v22)
end
return function(p24, p25, p_u_26, p27)
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_23
	if typeof(p25) == "function" then
		v_u_2.logError("scopeMissing", nil, "ForValues", "myScope:ForValues(inputTable, function(scope, use, value) ... end)")
	elseif p27 ~= nil then
		v_u_2.logWarn("destructorRedundant", "ForValues")
	end
	return v_u_3(p24, p25, function(p28, p29, p30)
		-- upvalues: (ref) v_u_23, (copy) p_u_26
		return v_u_23(p28, p29, p30, p_u_26)
	end)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ForValues]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3433"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Graph.change)
local v_u_4 = require(v1.Utility.isSimilar)
local v_u_5 = require(v1.Utility.never)
local v_u_6 = require(v1.Utility.nicknames)
local v7 = {
	["type"] = "State",
	["kind"] = "Value",
	["timeliness"] = "lazy",
	["dependencySet"] = table.freeze({})
}
local v_u_8 = table.freeze({
	["__index"] = v7
})
function v7.get(_, _)
	-- upvalues: (copy) v_u_2, (copy) v_u_5
	v_u_2.logError("stateGetWasRemoved")
	return v_u_5()
end
function v7.set(p9, p10)
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	if not v_u_4(p9._EXTREMELY_DANGEROUS_usedAsValue, p10) then
		p9._EXTREMELY_DANGEROUS_usedAsValue = p10
		v_u_3(p9)
	end
	return p10
end
function v7._evaluate(_)
	return true
end
table.freeze(v7)
return function(p11, p12)
	-- upvalues: (copy) v_u_2, (copy) v_u_8, (copy) v_u_6
	local v13 = os.clock()
	if p12 == nil and (typeof(p11) ~= "table" or p11[1] == nil and next(p11) ~= nil) then
		v_u_2.logError("scopeMissing", nil, "Value", "myScope:Value(initialValue)")
	end
	local v14 = {
		["createdAt"] = v13,
		["dependentSet"] = {},
		["lastChange"] = os.clock(),
		["scope"] = p11,
		["validity"] = "valid",
		["_EXTREMELY_DANGEROUS_usedAsValue"] = p12
	}
	local v15 = v_u_8
	local v_u_16 = setmetatable(v14, v15)
	local function v17()
		-- upvalues: (copy) v_u_16
		v_u_16.scope = nil
	end
	v_u_16.oldestTask = v17
	v_u_6[v_u_16.oldestTask] = "Value"
	table.insert(p11, v17)
	return v_u_16
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Value]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3434"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
return function(p2)
	if typeof(p2) == "table" and p2.type == "State" then
		return p2
	else
		return nil
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[castToState]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3435"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.State.castToState)
local v_u_3 = require(v1.Graph.evaluate)
return function(p4)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v5 = v_u_2(p4)
	if v5 == nil then
		return p4
	end
	v_u_3(v5, false)
	return v5._EXTREMELY_DANGEROUS_usedAsValue
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[peek]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3436"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return nil]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[updateAll]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3437"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Utility]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3438"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Logging.parseError)
local v4 = {
	["type"] = "Contextual"
}
local v_u_5 = table.freeze({
	["__index"] = v4
})
local v_u_6 = table.freeze({
	["__mode"] = "k"
})
function v4.now(p7)
	local v8 = coroutine.running()
	local v9 = p7._valuesNow[v8]
	if typeof(v9) == "table" then
		return v9.value
	else
		return p7._defaultValue
	end
end
function v4.is(p_u_10, p_u_11)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	return {
		["during"] = function(_, p12, ...)
			-- upvalues: (copy) p_u_10, (copy) p_u_11, (ref) v_u_3, (ref) v_u_2
			local v13 = coroutine.running()
			local v14 = p_u_10._valuesNow[v13]
			local v15 = {
				["value"] = p_u_11
			}
			p_u_10._valuesNow[v13] = v15
			local v16, v17 = xpcall(p12, v_u_3, ...)
			p_u_10._valuesNow[v13] = v14
			if not v16 then
				v_u_2.logError("callbackError", v17)
			end
			return v17
		end
	}
end
table.freeze(v4)
return function(p18)
	-- upvalues: (copy) v_u_6, (copy) v_u_5
	local v19 = {}
	local v20 = v_u_6
	v19._valuesNow = setmetatable({}, v20)
	v19._defaultValue = p18
	local v21 = v_u_5
	return setmetatable(v19, v21)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Contextual]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3439"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = script.Parent.Parent
return function(p1)
	local _, v2 = xpcall(p1.try, p1.fallback)
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Safe]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3440"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	local v3 = typeof(p1)
	local v4 = v3 == "table"
	local v5 = v3 == "userdata"
	local v6
	if v4 or v5 then
		if v3 == typeof(p2) and (v5 or (table.isfrozen(p1) or getmetatable(p1) ~= nil)) then
			return p1 == p2
		end
		v6 = false
	elseif p1 == p2 then
		v6 = true
	else
		if p1 ~= p1 then
			return p2 ~= p2
		end
		v6 = false
	end
	return v6
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[isSimilar]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3441"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.External)
return function(p3, p4, ...)
	-- upvalues: (copy) v_u_2
	local v5 = { ... }
	if #v5 < 1 then
		return p4
	end
	for _, v6 in v5 do
		for v7, v8 in v6 do
			if p4[v7] == nil then
				p4[v7] = v8
			elseif not p3 then
				v_u_2.logError("mergeConflict", nil, (tostring(v7)))
			end
		end
	end
	return p4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[merge]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3442"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.Utility.nicknames)
return function(p3, p4)
	-- upvalues: (copy) v_u_2
	local v5 = v_u_2[p3]
	if typeof(v5) == "string" then
		return v5
	end
	if typeof(p3) == "table" then
		local v6 = p3.name
		if typeof(v6) == "string" then
			return p3.name
		end
		local v7 = p3.kind
		if typeof(v7) == "string" then
			return p3.kind
		end
		local v8 = p3.type
		if typeof(v8) == "string" then
			return p3.type
		end
	end
	return p4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[nameOf]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3443"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function()
	error("This codepath should not be reachable")
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[never]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3444"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return setmetatable({}, {
	["__mode"] = "k"
})]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[nicknames]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3445"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	local v2 = typeof(p1)
	if v2 == "table" then
		local v3 = p1.type
		if typeof(v3) == "string" then
			return p1.type
		end
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[xtypeof]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item></Item><Item class="Folder" referent="3446"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[sirmallard_iris@2.5.0]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3447"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Types)
local v_u_1 = {}
local v_u_2 = require(script.Internal)(v_u_1)
v_u_1.Disabled = false
v_u_1.Args = {}
v_u_1.Events = {}
function v_u_1.Init(p3, p_u_4, p5)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v6 = v_u_2._shutdown == false
	assert(v6, "Iris.Init() cannot be called once shutdown.")
	local v7 = v_u_2._started == false and true or p5 == true
	assert(v7, "Iris.Init() can only be called once.")
	if v_u_2._started then
		return v_u_1
	end
	if p3 == nil then
		p3 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
	end
	if p_u_4 == nil then
		p_u_4 = game:GetService("RunService").Heartbeat
	end
	v_u_2.parentInstance = p3
	v_u_2._started = true
	v_u_2._generateRootInstance()
	v_u_2._generateSelectionImageObject()
	for _, v8 in v_u_2._initFunctions do
		v8()
	end
	task.spawn(function()
		-- upvalues: (ref) p_u_4, (ref) v_u_2
		local v9 = p_u_4
		if typeof(v9) == "function" then
			while v_u_2._started do
				local v10 = p_u_4()
				v_u_2._cycle(v10)
			end
		elseif p_u_4 ~= nil and p_u_4 ~= false then
			v_u_2._eventConnection = p_u_4:Connect(function(...)
				-- upvalues: (ref) v_u_2
				v_u_2._cycle(...)
			end)
		end
	end)
	return v_u_1
end
function v_u_1.Shutdown()
	-- upvalues: (copy) v_u_2
	v_u_2._started = false
	v_u_2._shutdown = true
	if v_u_2._eventConnection then
		v_u_2._eventConnection:Disconnect()
	end
	v_u_2._eventConnection = nil
	if v_u_2._rootWidget then
		if v_u_2._rootWidget.Instance then
			v_u_2._widgets.Root.Discard(v_u_2._rootWidget)
		end
		v_u_2._rootInstance = nil
	end
	if v_u_2.SelectionImageObject then
		v_u_2.SelectionImageObject:Destroy()
	end
	for _, v11 in v_u_2._connections do
		v11:Disconnect()
	end
end
function v_u_1.Connect(_, p12)
	-- upvalues: (copy) v_u_2
	if v_u_2._started == false then
		warn("Iris:Connect() was called before calling Iris.Init(); always initialise Iris first.")
	end
	local v_u_13 = #v_u_2._connectedFunctions + 1
	v_u_2._connectedFunctions[v_u_13] = p12
	return function()
		-- upvalues: (ref) v_u_2, (copy) v_u_13
		v_u_2._connectedFunctions[v_u_13] = nil
	end
end
function v_u_1.Append(p14)
	-- upvalues: (copy) v_u_2
	local v15 = v_u_2._GetParentWidget()
	local v16
	if v_u_2._config.Parent then
		v16 = v_u_2._config.Parent
	else
		v16 = v_u_2._widgets[v15.type].ChildAdded(v15, {
			["type"] = "userInstance"
		})
	end
	p14.Parent = v16
end
function v_u_1.End()
	-- upvalues: (copy) v_u_2
	if v_u_2._stackIndex == 1 then
		error("Too many calls to Iris.End().", 2)
	end
	v_u_2._IDStack[v_u_2._stackIndex] = nil
	local v17 = v_u_2
	v17._stackIndex = v17._stackIndex - 1
end
function v_u_1.ForceRefresh()
	-- upvalues: (copy) v_u_2
	v_u_2._globalRefreshRequested = true
end
function v_u_1.UpdateGlobalConfig(p18)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	for v19, v20 in p18 do
		v_u_2._rootConfig[v19] = v20
	end
	v_u_1.ForceRefresh()
end
function v_u_1.PushConfig(p21)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v22 = v_u_1.State(-1)
	if v22.value == -1 then
		v22:set(p21)
	elseif v_u_2._deepCompare(v22:get(), p21) == false then
		v22:set(p21)
		v_u_2._refreshStack[v_u_2._refreshLevel] = true
		local v23 = v_u_2
		v23._refreshCounter = v23._refreshCounter + 1
	end
	local v24 = v_u_2
	v24._refreshLevel = v24._refreshLevel + 1
	local v25 = v_u_2
	local v26 = {
		["__index"] = v_u_2._config
	}
	v25._config = setmetatable(p21, v26)
end
function v_u_1.PopConfig()
	-- upvalues: (copy) v_u_2
	local v27 = v_u_2
	v27._refreshLevel = v27._refreshLevel - 1
	if v_u_2._refreshStack[v_u_2._refreshLevel] == true then
		local v28 = v_u_2
		v28._refreshCounter = v28._refreshCounter - 1
		v_u_2._refreshStack[v_u_2._refreshLevel] = nil
	end
	local v29 = v_u_2
	local v30 = v_u_2._config
	v29._config = getmetatable(v30).__index
end
v_u_1.TemplateConfig = require(script.config)
v_u_1.UpdateGlobalConfig(v_u_1.TemplateConfig.colorDark)
v_u_1.UpdateGlobalConfig(v_u_1.TemplateConfig.sizeDefault)
v_u_1.UpdateGlobalConfig(v_u_1.TemplateConfig.utilityDefault)
v_u_2._globalRefreshRequested = false
function v_u_1.PushId(p31)
	-- upvalues: (copy) v_u_2
	local v32 = typeof(p31) == "string"
	assert(v32, "The ID argument to Iris.PushId() to be a string.")
	v_u_2._newID = true
	local v33 = v_u_2._pushedIds
	table.insert(v33, p31)
end
function v_u_1.PopId()
	-- upvalues: (copy) v_u_2
	if #v_u_2._pushedIds ~= 0 then
		table.remove(v_u_2._pushedIds)
	end
end
function v_u_1.SetNextWidgetID(p34)
	-- upvalues: (copy) v_u_2
	v_u_2._nextWidgetId = p34
end
function v_u_1.State(p35)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v36 = v_u_2._getID(2)
	if v_u_2._states[v36] then
		return v_u_2._states[v36]
	end
	v_u_2._states[v36] = {
		["ID"] = v36,
		["value"] = p35,
		["lastChangeTick"] = v_u_1.Internal._cycleTick,
		["ConnectedWidgets"] = {},
		["ConnectedFunctions"] = {}
	}
	local v37 = v_u_2._states[v36]
	local v38 = v_u_2.StateClass
	setmetatable(v37, v38)
	return v_u_2._states[v36]
end
function v_u_1.WeakState(p39)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v40 = v_u_2._getID(2)
	if v_u_2._states[v40] then
		if next(v_u_2._states[v40].ConnectedWidgets) ~= nil then
			return v_u_2._states[v40]
		end
		v_u_2._states[v40] = nil
	end
	v_u_2._states[v40] = {
		["ID"] = v40,
		["value"] = p39,
		["lastChangeTick"] = v_u_1.Internal._cycleTick,
		["ConnectedWidgets"] = {},
		["ConnectedFunctions"] = {}
	}
	local v41 = v_u_2._states[v40]
	local v42 = v_u_2.StateClass
	setmetatable(v41, v42)
	return v_u_2._states[v40]
end
function v_u_1.VariableState(p43, p44)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v45 = v_u_2._getID(2)
	local v46 = v_u_2._states[v45]
	if v46 then
		if p43 ~= v46.value then
			v46:set(p43)
		end
		return v46
	end
	local v47 = {
		["ID"] = v45,
		["value"] = p43,
		["lastChangeTick"] = v_u_1.Internal._cycleTick,
		["ConnectedWidgets"] = {},
		["ConnectedFunctions"] = {}
	}
	local v48 = v_u_2.StateClass
	setmetatable(v47, v48)
	v_u_2._states[v45] = v47
	v47:onChange(p44)
	return v47
end
function v_u_1.TableState(p_u_49, p_u_50, p_u_51)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v52 = p_u_49[p_u_50]
	local v53 = v_u_2._getID(2)
	local v54 = v_u_2._states[v53]
	if v54 then
		if v52 ~= v54.value then
			v54:set(v52)
		end
		return v54
	end
	local v_u_55 = {
		["ID"] = v53,
		["value"] = v52,
		["lastChangeTick"] = v_u_1.Internal._cycleTick,
		["ConnectedWidgets"] = {},
		["ConnectedFunctions"] = {}
	}
	local v56 = v_u_2.StateClass
	setmetatable(v_u_55, v56)
	v_u_2._states[v53] = v_u_55
	v_u_55:onChange(function()
		-- upvalues: (copy) p_u_51, (copy) v_u_55, (copy) p_u_49, (copy) p_u_50
		if p_u_51 == nil then
			p_u_49[p_u_50] = v_u_55.value
		elseif p_u_51(v_u_55.value) then
			p_u_49[p_u_50] = v_u_55.value
			return
		end
	end)
	return v_u_55
end
function v_u_1.ComputedState(p57, p_u_58)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v_u_59 = v_u_2._getID(2)
	if v_u_2._states[v_u_59] then
		return v_u_2._states[v_u_59]
	end
	v_u_2._states[v_u_59] = {
		["ID"] = v_u_59,
		["value"] = p_u_58(p57.value),
		["lastChangeTick"] = v_u_1.Internal._cycleTick,
		["ConnectedWidgets"] = {},
		["ConnectedFunctions"] = {}
	}
	p57:onChange(function(p60)
		-- upvalues: (ref) v_u_2, (copy) v_u_59, (copy) p_u_58
		v_u_2._states[v_u_59]:set(p_u_58(p60))
	end)
	local v61 = v_u_2._states[v_u_59]
	local v62 = v_u_2.StateClass
	setmetatable(v61, v62)
	return v_u_2._states[v_u_59]
end
v_u_1.ShowDemoWindow = require(script.demoWindow)(v_u_1)
require(script.widgets)(v_u_2)
require(script.API)(v_u_1)
return v_u_1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[iris]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3448"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Types)
return function(p_u_1)
	local v_u_2 = "Window"
	function p_u_1.Window(p3, p4)
		-- upvalues: (copy) p_u_1, (copy) v_u_2
		return p_u_1.Internal._Insert(v_u_2, p3, p4)
	end
	p_u_1.SetFocusedWindow = p_u_1.Internal.SetFocusedWindow
	local v_u_5 = "Tooltip"
	function p_u_1.Tooltip(p6, p7)
		-- upvalues: (copy) p_u_1, (copy) v_u_5
		return p_u_1.Internal._Insert(v_u_5, p6, p7)
	end
	local v_u_8 = "MenuBar"
	function p_u_1.MenuBar(p9, p10)
		-- upvalues: (copy) p_u_1, (copy) v_u_8
		return p_u_1.Internal._Insert(v_u_8, p9, p10)
	end
	local v_u_11 = "Menu"
	function p_u_1.Menu(p12, p13)
		-- upvalues: (copy) p_u_1, (copy) v_u_11
		return p_u_1.Internal._Insert(v_u_11, p12, p13)
	end
	local v_u_14 = "MenuItem"
	function p_u_1.MenuItem(p15, p16)
		-- upvalues: (copy) p_u_1, (copy) v_u_14
		return p_u_1.Internal._Insert(v_u_14, p15, p16)
	end
	local v_u_17 = "MenuToggle"
	function p_u_1.MenuToggle(p18, p19)
		-- upvalues: (copy) p_u_1, (copy) v_u_17
		return p_u_1.Internal._Insert(v_u_17, p18, p19)
	end
	local v_u_20 = "Separator"
	function p_u_1.Separator(p21, p22)
		-- upvalues: (copy) p_u_1, (copy) v_u_20
		return p_u_1.Internal._Insert(v_u_20, p21, p22)
	end
	local v_u_23 = "Indent"
	function p_u_1.Indent(p24, p25)
		-- upvalues: (copy) p_u_1, (copy) v_u_23
		return p_u_1.Internal._Insert(v_u_23, p24, p25)
	end
	local v_u_26 = "SameLine"
	function p_u_1.SameLine(p27, p28)
		-- upvalues: (copy) p_u_1, (copy) v_u_26
		return p_u_1.Internal._Insert(v_u_26, p27, p28)
	end
	local v_u_29 = "Group"
	function p_u_1.Group(p30, p31)
		-- upvalues: (copy) p_u_1, (copy) v_u_29
		return p_u_1.Internal._Insert(v_u_29, p30, p31)
	end
	local v_u_32 = "Text"
	function p_u_1.Text(p33, p34)
		-- upvalues: (copy) p_u_1, (copy) v_u_32
		return p_u_1.Internal._Insert(v_u_32, p33, p34)
	end
	function p_u_1.TextWrapped(p35)
		-- upvalues: (copy) p_u_1
		p35[2] = true
		return p_u_1.Internal._Insert("Text", p35)
	end
	function p_u_1.TextColored(p36)
		-- upvalues: (copy) p_u_1
		p36[3] = p36[2]
		p36[2] = nil
		return p_u_1.Internal._Insert("Text", p36)
	end
	local v_u_37 = "SeparatorText"
	function p_u_1.SeparatorText(p38, p39)
		-- upvalues: (copy) p_u_1, (copy) v_u_37
		return p_u_1.Internal._Insert(v_u_37, p38, p39)
	end
	local v_u_40 = "InputText"
	function p_u_1.InputText(p41, p42)
		-- upvalues: (copy) p_u_1, (copy) v_u_40
		return p_u_1.Internal._Insert(v_u_40, p41, p42)
	end
	local v_u_43 = "Button"
	function p_u_1.Button(p44, p45)
		-- upvalues: (copy) p_u_1, (copy) v_u_43
		return p_u_1.Internal._Insert(v_u_43, p44, p45)
	end
	local v_u_46 = "SmallButton"
	function p_u_1.SmallButton(p47, p48)
		-- upvalues: (copy) p_u_1, (copy) v_u_46
		return p_u_1.Internal._Insert(v_u_46, p47, p48)
	end
	local v_u_49 = "Checkbox"
	function p_u_1.Checkbox(p50, p51)
		-- upvalues: (copy) p_u_1, (copy) v_u_49
		return p_u_1.Internal._Insert(v_u_49, p50, p51)
	end
	local v_u_52 = "RadioButton"
	function p_u_1.RadioButton(p53, p54)
		-- upvalues: (copy) p_u_1, (copy) v_u_52
		return p_u_1.Internal._Insert(v_u_52, p53, p54)
	end
	local v_u_55 = "Image"
	function p_u_1.Image(p56, p57)
		-- upvalues: (copy) p_u_1, (copy) v_u_55
		return p_u_1.Internal._Insert(v_u_55, p56, p57)
	end
	local v_u_58 = "ImageButton"
	function p_u_1.ImageButton(p59, p60)
		-- upvalues: (copy) p_u_1, (copy) v_u_58
		return p_u_1.Internal._Insert(v_u_58, p59, p60)
	end
	local v_u_61 = "Tree"
	function p_u_1.Tree(p62, p63)
		-- upvalues: (copy) p_u_1, (copy) v_u_61
		return p_u_1.Internal._Insert(v_u_61, p62, p63)
	end
	local v_u_64 = "CollapsingHeader"
	function p_u_1.CollapsingHeader(p65, p66)
		-- upvalues: (copy) p_u_1, (copy) v_u_64
		return p_u_1.Internal._Insert(v_u_64, p65, p66)
	end
	local v_u_67 = "TabBar"
	function p_u_1.TabBar(p68, p69)
		-- upvalues: (copy) p_u_1, (copy) v_u_67
		return p_u_1.Internal._Insert(v_u_67, p68, p69)
	end
	local v_u_70 = "Tab"
	function p_u_1.Tab(p71, p72)
		-- upvalues: (copy) p_u_1, (copy) v_u_70
		return p_u_1.Internal._Insert(v_u_70, p71, p72)
	end
	local v_u_73 = "InputNum"
	function p_u_1.InputNum(p74, p75)
		-- upvalues: (copy) p_u_1, (copy) v_u_73
		return p_u_1.Internal._Insert(v_u_73, p74, p75)
	end
	local v_u_76 = "InputVector2"
	function p_u_1.InputVector2(p77, p78)
		-- upvalues: (copy) p_u_1, (copy) v_u_76
		return p_u_1.Internal._Insert(v_u_76, p77, p78)
	end
	local v_u_79 = "InputVector3"
	function p_u_1.InputVector3(p80, p81)
		-- upvalues: (copy) p_u_1, (copy) v_u_79
		return p_u_1.Internal._Insert(v_u_79, p80, p81)
	end
	local v_u_82 = "InputUDim"
	function p_u_1.InputUDim(p83, p84)
		-- upvalues: (copy) p_u_1, (copy) v_u_82
		return p_u_1.Internal._Insert(v_u_82, p83, p84)
	end
	local v_u_85 = "InputUDim2"
	function p_u_1.InputUDim2(p86, p87)
		-- upvalues: (copy) p_u_1, (copy) v_u_85
		return p_u_1.Internal._Insert(v_u_85, p86, p87)
	end
	local v_u_88 = "InputRect"
	function p_u_1.InputRect(p89, p90)
		-- upvalues: (copy) p_u_1, (copy) v_u_88
		return p_u_1.Internal._Insert(v_u_88, p89, p90)
	end
	local v_u_91 = "DragNum"
	function p_u_1.DragNum(p92, p93)
		-- upvalues: (copy) p_u_1, (copy) v_u_91
		return p_u_1.Internal._Insert(v_u_91, p92, p93)
	end
	local v_u_94 = "DragVector2"
	function p_u_1.DragVector2(p95, p96)
		-- upvalues: (copy) p_u_1, (copy) v_u_94
		return p_u_1.Internal._Insert(v_u_94, p95, p96)
	end
	local v_u_97 = "DragVector3"
	function p_u_1.DragVector3(p98, p99)
		-- upvalues: (copy) p_u_1, (copy) v_u_97
		return p_u_1.Internal._Insert(v_u_97, p98, p99)
	end
	local v_u_100 = "DragUDim"
	function p_u_1.DragUDim(p101, p102)
		-- upvalues: (copy) p_u_1, (copy) v_u_100
		return p_u_1.Internal._Insert(v_u_100, p101, p102)
	end
	local v_u_103 = "DragUDim2"
	function p_u_1.DragUDim2(p104, p105)
		-- upvalues: (copy) p_u_1, (copy) v_u_103
		return p_u_1.Internal._Insert(v_u_103, p104, p105)
	end
	local v_u_106 = "DragRect"
	function p_u_1.DragRect(p107, p108)
		-- upvalues: (copy) p_u_1, (copy) v_u_106
		return p_u_1.Internal._Insert(v_u_106, p107, p108)
	end
	local v_u_109 = "InputColor3"
	function p_u_1.InputColor3(p110, p111)
		-- upvalues: (copy) p_u_1, (copy) v_u_109
		return p_u_1.Internal._Insert(v_u_109, p110, p111)
	end
	local v_u_112 = "InputColor4"
	function p_u_1.InputColor4(p113, p114)
		-- upvalues: (copy) p_u_1, (copy) v_u_112
		return p_u_1.Internal._Insert(v_u_112, p113, p114)
	end
	local v_u_115 = "SliderNum"
	function p_u_1.SliderNum(p116, p117)
		-- upvalues: (copy) p_u_1, (copy) v_u_115
		return p_u_1.Internal._Insert(v_u_115, p116, p117)
	end
	local v_u_118 = "SliderVector2"
	function p_u_1.SliderVector2(p119, p120)
		-- upvalues: (copy) p_u_1, (copy) v_u_118
		return p_u_1.Internal._Insert(v_u_118, p119, p120)
	end
	local v_u_121 = "SliderVector3"
	function p_u_1.SliderVector3(p122, p123)
		-- upvalues: (copy) p_u_1, (copy) v_u_121
		return p_u_1.Internal._Insert(v_u_121, p122, p123)
	end
	local v_u_124 = "SliderUDim"
	function p_u_1.SliderUDim(p125, p126)
		-- upvalues: (copy) p_u_1, (copy) v_u_124
		return p_u_1.Internal._Insert(v_u_124, p125, p126)
	end
	local v_u_127 = "SliderUDim2"
	function p_u_1.SliderUDim2(p128, p129)
		-- upvalues: (copy) p_u_1, (copy) v_u_127
		return p_u_1.Internal._Insert(v_u_127, p128, p129)
	end
	local v_u_130 = "SliderRect"
	function p_u_1.SliderRect(p131, p132)
		-- upvalues: (copy) p_u_1, (copy) v_u_130
		return p_u_1.Internal._Insert(v_u_130, p131, p132)
	end
	local v_u_133 = "Selectable"
	function p_u_1.Selectable(p134, p135)
		-- upvalues: (copy) p_u_1, (copy) v_u_133
		return p_u_1.Internal._Insert(v_u_133, p134, p135)
	end
	local v_u_136 = "Combo"
	function p_u_1.Combo(p137, p138)
		-- upvalues: (copy) p_u_1, (copy) v_u_136
		return p_u_1.Internal._Insert(v_u_136, p137, p138)
	end
	function p_u_1.ComboArray(p139, p140, p141)
		-- upvalues: (copy) p_u_1
		if p140 == nil then
			p140 = p_u_1.State(p141[1])
		end
		local v142 = p_u_1.Internal._Insert("Combo", p139, p140)
		local v143 = v142.state.index
		for _, v144 in p141 do
			p_u_1.Internal._Insert("Selectable", { v144, v144 }, {
				["index"] = v143
			})
		end
		p_u_1.End()
		return v142
	end
	function p_u_1.ComboEnum(p145, p146, p147)
		-- upvalues: (copy) p_u_1
		if p146 == nil then
			p146 = p_u_1.State(p147:GetEnumItems()[1])
		end
		local v148 = p_u_1.Internal._Insert("Combo", p145, p146)
		local v149 = v148.state.index
		for _, v150 in p147:GetEnumItems() do
			p_u_1.Internal._Insert("Selectable", { v150.Name, v150 }, {
				["index"] = v149
			})
		end
		p_u_1.End()
		return v148
	end
	p_u_1.InputEnum = p_u_1.ComboEnum
	local v_u_151 = "ProgressBar"
	function p_u_1.ProgressBar(p152, p153)
		-- upvalues: (copy) p_u_1, (copy) v_u_151
		return p_u_1.Internal._Insert(v_u_151, p152, p153)
	end
	local v_u_154 = "PlotLines"
	function p_u_1.PlotLines(p155, p156)
		-- upvalues: (copy) p_u_1, (copy) v_u_154
		return p_u_1.Internal._Insert(v_u_154, p155, p156)
	end
	local v_u_157 = "PlotHistogram"
	function p_u_1.PlotHistogram(p158, p159)
		-- upvalues: (copy) p_u_1, (copy) v_u_157
		return p_u_1.Internal._Insert(v_u_157, p158, p159)
	end
	local v_u_160 = "Table"
	function p_u_1.Table(p161, p162)
		-- upvalues: (copy) p_u_1, (copy) v_u_160
		return p_u_1.Internal._Insert(v_u_160, p161, p162)
	end
	function p_u_1.NextColumn()
		-- upvalues: (copy) p_u_1
		local v163 = p_u_1.Internal._GetParentWidget()
		local v164 = v163 ~= nil
		assert(v164, "Iris.NextColumn() can only called when directly within a table.")
		if v163._columnIndex == v163.arguments.NumColumns then
			v163._columnIndex = 1
			v163._rowIndex = v163._rowIndex + 1
		else
			v163._columnIndex = v163._columnIndex + 1
		end
		return v163._columnIndex
	end
	function p_u_1.NextRow()
		-- upvalues: (copy) p_u_1
		local v165 = p_u_1.Internal._GetParentWidget()
		local v166 = v165 ~= nil
		assert(v166, "Iris.NextRow() can only called when directly within a table.")
		v165._columnIndex = 1
		v165._rowIndex = v165._rowIndex + 1
		return v165._rowIndex
	end
	function p_u_1.SetColumnIndex(p167)
		-- upvalues: (copy) p_u_1
		local v168 = p_u_1.Internal._GetParentWidget()
		local v169 = v168 ~= nil
		assert(v169, "Iris.SetColumnIndex() can only called when directly within a table.")
		local v170
		if p167 >= 1 then
			v170 = p167 <= v168.arguments.NumColumns
		else
			v170 = false
		end
		local v171 = ("The index must be between 1 and %*, inclusive."):format(v168.arguments.NumColumns)
		assert(v170, v171)
		v168._columnIndex = p167
	end
	function p_u_1.SetRowIndex(p172)
		-- upvalues: (copy) p_u_1
		local v173 = p_u_1.Internal._GetParentWidget()
		local v174 = v173 ~= nil
		assert(v174, "Iris.SetRowIndex() can only called when directly within a table.")
		local v175 = p172 >= 1
		assert(v175, "The index must be greater or equal to 1.")
		v173._rowIndex = p172
	end
	function p_u_1.NextHeaderColumn()
		-- upvalues: (copy) p_u_1
		local v176 = p_u_1.Internal._GetParentWidget()
		local v177 = v176 ~= nil
		assert(v177, "Iris.NextHeaderColumn() can only called when directly within a table.")
		v176._rowIndex = 0
		v176._columnIndex = v176._columnIndex % v176.arguments.NumColumns + 1
		return v176._columnIndex
	end
	function p_u_1.SetHeaderColumnIndex(p178)
		-- upvalues: (copy) p_u_1
		local v179 = p_u_1.Internal._GetParentWidget()
		local v180 = v179 ~= nil
		assert(v180, "Iris.SetHeaderColumnIndex() can only called when directly within a table.")
		local v181
		if p178 >= 1 then
			v181 = p178 <= v179.arguments.NumColumns
		else
			v181 = false
		end
		local v182 = ("The index must be between 1 and %*, inclusive."):format(v179.arguments.NumColumns)
		assert(v181, v182)
		v179._rowIndex = 0
		v179._columnIndex = p178
	end
	function p_u_1.SetColumnWidth(p183, p184)
		-- upvalues: (copy) p_u_1
		local v185 = p_u_1.Internal._GetParentWidget()
		local v186 = v185 ~= nil
		assert(v186, "Iris.SetColumnWidth() can only called when directly within a table.")
		local v187
		if p183 >= 1 then
			v187 = p183 <= v185.arguments.NumColumns
		else
			v187 = false
		end
		local v188 = ("The index must be between 1 and %*, inclusive."):format(v185.arguments.NumColumns)
		assert(v187, v188)
		local v189 = v185.state.widths.value[p183]
		v185.state.widths.value[p183] = p184
		v185.state.widths:set(v185.state.widths.value, p184 ~= v189)
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[API]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3449"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("HttpService")
require(script.Parent.Types)
return function(p_u_2)
	-- upvalues: (copy) v_u_1
	local v_u_3 = {
		["_version"] = " 2.5.0 ",
		["_started"] = false,
		["_shutdown"] = false,
		["_cycleTick"] = 0,
		["_deltaTime"] = 0,
		["_globalRefreshRequested"] = false,
		["_refreshCounter"] = 0,
		["_refreshLevel"] = 1,
		["_refreshStack"] = table.create(16),
		["_widgets"] = {},
		["_stackIndex"] = 1,
		["_rootInstance"] = nil
	}
	v_u_3._rootWidget = {
		["ID"] = "R",
		["type"] = "Root",
		["Instance"] = v_u_3._rootInstance,
		["ZIndex"] = 0,
		["ZOffset"] = 0
	}
	v_u_3._lastWidget = v_u_3._rootWidget
	v_u_3._rootConfig = {}
	v_u_3._config = v_u_3._rootConfig
	v_u_3._IDStack = { "R" }
	v_u_3._usedIDs = {}
	v_u_3._pushedIds = {}
	v_u_3._newID = false
	v_u_3._nextWidgetId = nil
	v_u_3._states = {}
	v_u_3._postCycleCallbacks = {}
	v_u_3._connectedFunctions = {}
	v_u_3._connections = {}
	v_u_3._initFunctions = {}
	v_u_3._fullErrorTracebacks = game:GetService("RunService"):IsStudio()
	v_u_3._cycleCoroutine = coroutine.create(function()
		-- upvalues: (copy) v_u_3
		while v_u_3._started do
			for _, v4 in v_u_3._connectedFunctions do
				debug.profilebegin("Iris/Connection")
				local v5, v6 = pcall(v4)
				debug.profileend()
				if not v5 then
					v_u_3._stackIndex = 1
					coroutine.yield(false, v6)
				end
			end
			coroutine.yield(true)
		end
	end)
	local v7 = {}
	v7.__index = v7
	function v7.get(p8)
		return p8.value
	end
	function v7.set(p9, p10, p11)
		-- upvalues: (copy) p_u_2, (copy) v_u_3
		if p10 == p9.value and p11 ~= true then
			return p9.value
		end
		p9.value = p10
		p9.lastChangeTick = p_u_2.Internal._cycleTick
		for _, v12 in p9.ConnectedWidgets do
			if v12.lastCycleTick ~= -1 then
				v_u_3._widgets[v12.type].UpdateState(v12)
			end
		end
		for _, v13 in p9.ConnectedFunctions do
			v13(p10)
		end
		return p9.value
	end
	function v7.onChange(p_u_14, p15)
		local v_u_16 = #p_u_14.ConnectedFunctions + 1
		p_u_14.ConnectedFunctions[v_u_16] = p15
		return function()
			-- upvalues: (copy) p_u_14, (copy) v_u_16
			p_u_14.ConnectedFunctions[v_u_16] = nil
		end
	end
	function v7.changed(p17)
		-- upvalues: (copy) v_u_3
		return p17.lastChangeTick + 1 == v_u_3._cycleTick
	end
	v_u_3.StateClass = v7
	function v_u_3._cycle(p18)
		-- upvalues: (copy) p_u_2, (copy) v_u_3
		if not p_u_2.Disabled then
			v_u_3._rootWidget.lastCycleTick = v_u_3._cycleTick
			if v_u_3._rootInstance == nil or v_u_3._rootInstance.Parent == nil then
				p_u_2.ForceRefresh()
			end
			for _, v19 in v_u_3._lastVDOM do
				if v19.lastCycleTick ~= v_u_3._cycleTick and v19.lastCycleTick ~= -1 then
					v_u_3._DiscardWidget(v19)
				end
			end
			local v20 = v_u_3._lastVDOM
			setmetatable(v20, {
				["__mode"] = "kv"
			})
			v_u_3._lastVDOM = v_u_3._VDOM
			v_u_3._VDOM = v_u_3._generateEmptyVDOM()
			task.spawn(function()
				-- upvalues: (ref) v_u_3
				for _, v21 in v_u_3._postCycleCallbacks do
					v21()
				end
			end)
			if v_u_3._globalRefreshRequested then
				v_u_3._generateSelectionImageObject()
				v_u_3._globalRefreshRequested = false
				for _, v22 in v_u_3._lastVDOM do
					v_u_3._DiscardWidget(v22)
				end
				v_u_3._generateRootInstance()
				v_u_3._lastVDOM = v_u_3._generateEmptyVDOM()
			end
			local v23 = v_u_3
			v23._cycleTick = v23._cycleTick + 1
			v_u_3._deltaTime = p18
			table.clear(v_u_3._usedIDs)
			if (v_u_3.parentInstance:IsA("GuiBase2d") or v_u_3.parentInstance:IsA("CoreGui") or (v_u_3.parentInstance:IsA("PluginGui") or v_u_3.parentInstance:IsA("PlayerGui"))) == false then
				error("The Iris parent instance will not display any GUIs.")
			end
			if v_u_3._fullErrorTracebacks then
				for _, v24 in v_u_3._connectedFunctions do
					v24()
				end
			else
				local v25 = coroutine.status(v_u_3._cycleCoroutine)
				if v25 == "suspended" then
					local _, v26, v27 = coroutine.resume(v_u_3._cycleCoroutine)
					if v26 == false then
						error(v27, 0)
					end
				elseif v25 == "running" then
					error("Iris cycleCoroutine took to long to yield. Connected functions should not yield.")
				else
					error("unrecoverable state")
				end
			end
			if v_u_3._stackIndex ~= 1 then
				v_u_3._stackIndex = 1
				error("Too few calls to Iris.End().", 0)
			end
			if #v_u_3._pushedIds ~= 0 then
				error("Too few calls to Iris.PopId().", 0)
			end
		end
	end
	function v_u_3._NoOp() end
	function v_u_3.WidgetConstructor(p28, p29)
		-- upvalues: (copy) v_u_3, (copy) p_u_2
		local v30 = {
			["All"] = {
				["Required"] = {
					"Generate",
					"Discard",
					"Update",
					"Args",
					"Events",
					"hasChildren",
					"hasState"
				},
				["Optional"] = {}
			},
			["IfState"] = {
				["Required"] = { "GenerateState", "UpdateState" },
				["Optional"] = {}
			},
			["IfChildren"] = {
				["Required"] = { "ChildAdded" },
				["Optional"] = { "ChildDiscarded" }
			}
		}
		local v31 = {}
		for _, v32 in v30.All.Required do
			local v33 = p29[v32] ~= nil
			local v34 = ("field %* is missing from widget %*, it is required for all widgets"):format(v32, p28)
			assert(v33, v34)
			v31[v32] = p29[v32]
		end
		for _, v35 in v30.All.Optional do
			if p29[v35] == nil then
				v31[v35] = v_u_3._NoOp
			else
				v31[v35] = p29[v35]
			end
		end
		if p29.hasState then
			for _, v36 in v30.IfState.Required do
				local v37 = p29[v36] ~= nil
				local v38 = ("field %* is missing from widget %*, it is required for all widgets with state"):format(v36, p28)
				assert(v37, v38)
				v31[v36] = p29[v36]
			end
			for _, v39 in v30.IfState.Optional do
				if p29[v39] == nil then
					v31[v39] = v_u_3._NoOp
				else
					v31[v39] = p29[v39]
				end
			end
		end
		if p29.hasChildren then
			for _, v40 in v30.IfChildren.Required do
				local v41 = p29[v40] ~= nil
				local v42 = ("field %* is missing from widget %*, it is required for all widgets with children"):format(v40, p28)
				assert(v41, v42)
				v31[v40] = p29[v40]
			end
			for _, v43 in v30.IfChildren.Optional do
				if p29[v43] == nil then
					v31[v43] = v_u_3._NoOp
				else
					v31[v43] = p29[v43]
				end
			end
		end
		v_u_3._widgets[p28] = v31
		p_u_2.Args[p28] = v31.Args
		local v44 = {}
		for v45, v46 in v31.Args do
			v44[v46] = v45
		end
		v31.ArgNames = v44
		for v_u_47, _ in v31.Events do
			if p_u_2.Events[v_u_47] == nil then
				p_u_2.Events[v_u_47] = function()
					-- upvalues: (ref) v_u_3, (copy) v_u_47
					return v_u_3._EventCall(v_u_3._lastWidget, v_u_47)
				end
			end
		end
	end
	function v_u_3._Insert(p48, p49, p50)
		-- upvalues: (copy) v_u_3
		local v51 = v_u_3._getID(3)
		local v52 = v_u_3._widgets[p48]
		if v_u_3._VDOM[v51] then
			return v_u_3._ContinueWidget(v51, p48)
		end
		local v53 = {}
		if p49 ~= nil then
			for v54, v55 in type(p49) ~= "table" and { p49 } or p49 do
				local v56 = v54 > 0
				local v57 = ("Widget Arguments must be a positive number, not %* of type %* for %*."):format(v54, typeof(v54), v55)
				assert(v56, v57)
				v53[v52.ArgNames[v54]] = v55
			end
		end
		table.freeze(v53)
		local v58 = v_u_3._lastVDOM[v51]
		if v58 and (p48 == v58.type and v_u_3._refreshCounter > 0) then
			v_u_3._DiscardWidget(v58)
			v58 = nil
		end
		if v58 == nil then
			v58 = v_u_3._GenNewWidget(p48, v53, p50, v51)
		end
		local v59 = v58.parentWidget
		if v58.type ~= "Window" and v58.type ~= "Tooltip" then
			if v58.ZIndex ~= v59.ZOffset then
				v59.ZUpdate = true
			end
			if v59.ZUpdate then
				v58.ZIndex = v59.ZOffset
				if v58.Instance then
					v58.Instance.ZIndex = v58.ZIndex
					v58.Instance.LayoutOrder = v58.ZIndex
				end
			end
		end
		if v59.type == "Table" then
			v59._rowCycles[v59._rowIndex] = v_u_3._cycleTick
		end
		if v_u_3._deepCompare(v58.providedArguments, v53) == false then
			v58.arguments = v_u_3._deepCopy(v53)
			v58.providedArguments = v53
			v52.Update(v58)
		end
		v58.lastCycleTick = v_u_3._cycleTick
		v59.ZOffset = v59.ZOffset + 1
		if v52.hasChildren then
			v58.ZOffset = 0
			v58.ZUpdate = false
			local v60 = v_u_3
			v60._stackIndex = v60._stackIndex + 1
			v_u_3._IDStack[v_u_3._stackIndex] = v58.ID
		end
		v_u_3._VDOM[v51] = v58
		v_u_3._lastWidget = v58
		return v58
	end
	function v_u_3._GenNewWidget(p61, p62, p63, p64)
		-- upvalues: (copy) v_u_3, (ref) v_u_1
		local v65 = v_u_3._IDStack[v_u_3._stackIndex]
		local v66 = v_u_3._VDOM[v65]
		local v67 = v_u_3._widgets[p61]
		local v_u_68 = {}
		setmetatable(v_u_68, v_u_68)
		v_u_68.ID = p64
		v_u_68.type = p61
		v_u_68.parentWidget = v66
		v_u_68.trackedEvents = {}
		v_u_68.UID = v_u_1:GenerateGUID(false):sub(0, 8)
		v_u_68.ZIndex = v66.ZOffset
		v_u_68.Instance = v67.Generate(v_u_68)
		local v69 = v_u_68.parentWidget
		if v_u_3._config.Parent then
			v_u_68.Instance.Parent = v_u_3._config.Parent
		else
			v_u_68.Instance.Parent = v_u_3._widgets[v69.type].ChildAdded(v69, v_u_68)
		end
		v_u_68.providedArguments = p62
		v_u_68.arguments = v_u_3._deepCopy(p62)
		v67.Update(v_u_68)
		local v70
		if v67.hasState then
			if p63 then
				for v71, v72 in p63 do
					if type(v72) ~= "table" or getmetatable(v72) ~= v_u_3.StateClass then
						p63[v71] = v_u_3._widgetState(v_u_68, v71, v72)
					end
					p63[v71].lastChangeTick = v_u_3._cycleTick
				end
				v_u_68.state = p63
				for _, v73 in p63 do
					v73.ConnectedWidgets[v_u_68.ID] = v_u_68
				end
			else
				v_u_68.state = {}
			end
			v67.GenerateState(v_u_68)
			v67.UpdateState(v_u_68)
			v_u_68.stateMT = {}
			local v74 = v_u_68.state
			local v75 = v_u_68.stateMT
			setmetatable(v74, v75)
			v_u_68.__index = v_u_68.state
			v70 = v_u_68.stateMT
		else
			v70 = v_u_68
		end
		function v70.__index(_, p_u_76)
			-- upvalues: (ref) v_u_3, (copy) v_u_68
			return function()
				-- upvalues: (ref) v_u_3, (ref) v_u_68, (copy) p_u_76
				return v_u_3._EventCall(v_u_68, p_u_76)
			end
		end
		return v_u_68
	end
	function v_u_3._ContinueWidget(p77, p78)
		-- upvalues: (copy) v_u_3
		local v79 = v_u_3._widgets[p78]
		local v80 = v_u_3._VDOM[p77]
		if v79.hasChildren then
			local v81 = v_u_3
			v81._stackIndex = v81._stackIndex + 1
			v_u_3._IDStack[v_u_3._stackIndex] = v80.ID
		end
		v_u_3._lastWidget = v80
		return v80
	end
	function v_u_3._DiscardWidget(p82)
		-- upvalues: (copy) v_u_3
		local v83 = p82.parentWidget
		if v83 then
			v_u_3._widgets[v83.type].ChildDiscarded(v83, p82)
		end
		v_u_3._widgets[p82.type].Discard(p82)
		p82.lastCycleTick = -1
	end
	function v_u_3._widgetState(p84, p85, p86)
		-- upvalues: (copy) v_u_3
		local v87 = p84.ID .. p85
		if v_u_3._states[v87] then
			v_u_3._states[v87].ConnectedWidgets[p84.ID] = p84
			v_u_3._states[v87].lastChangeTick = v_u_3._cycleTick
			return v_u_3._states[v87]
		end
		local v88 = v_u_3._states
		local v89 = {
			["ID"] = v87,
			["value"] = p86,
			["lastChangeTick"] = v_u_3._cycleTick,
			["ConnectedWidgets"] = {
				[p84.ID] = p84
			},
			["ConnectedFunctions"] = {}
		}
		v88[v87] = v89
		local v90 = v_u_3._states[v87]
		local v91 = v_u_3.StateClass
		setmetatable(v90, v91)
		return v_u_3._states[v87]
	end
	function v_u_3._EventCall(p92, p93)
		-- upvalues: (copy) v_u_3
		local v94 = v_u_3._widgets[p92.type].Events[p93]
		local v95 = v94 ~= nil
		local v96 = ("widget %* has no event of name %*"):format(p92.type, p93)
		assert(v95, v96)
		if p92.trackedEvents[p93] == nil then
			v94.Init(p92)
			p92.trackedEvents[p93] = true
		end
		return v94.Get(p92)
	end
	function v_u_3._GetParentWidget()
		-- upvalues: (copy) v_u_3
		return v_u_3._VDOM[v_u_3._IDStack[v_u_3._stackIndex]]
	end
	function v_u_3._generateEmptyVDOM()
		-- upvalues: (copy) v_u_3
		return {
			["R"] = v_u_3._rootWidget
		}
	end
	function v_u_3._generateRootInstance()
		-- upvalues: (copy) v_u_3
		v_u_3._rootInstance = v_u_3._widgets.Root.Generate(v_u_3._widgets.Root)
		v_u_3._rootInstance.Parent = v_u_3.parentInstance
		v_u_3._rootWidget.Instance = v_u_3._rootInstance
	end
	function v_u_3._generateSelectionImageObject()
		-- upvalues: (copy) v_u_3
		if v_u_3.SelectionImageObject then
			v_u_3.SelectionImageObject:Destroy()
		end
		local v97 = Instance.new("Frame")
		v97.Position = UDim2.fromOffset(-1, -1)
		v97.Size = UDim2.new(1, 2, 1, 2)
		v97.BackgroundColor3 = v_u_3._config.SelectionImageObjectColor
		v97.BackgroundTransparency = v_u_3._config.SelectionImageObjectTransparency
		v97.BorderSizePixel = 0
		local v98 = Instance.new("UIStroke")
		v98.Thickness = 1
		v98.Color = v_u_3._config.SelectionImageObjectBorderColor
		v98.Transparency = v_u_3._config.SelectionImageObjectBorderTransparency
		v98.LineJoinMode = Enum.LineJoinMode.Round
		v98.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		v98.Parent = v97
		local v99 = Instance.new("UICorner")
		v99.CornerRadius = UDim.new(0, 2)
		v99.Parent = v97
		v_u_3.SelectionImageObject = v97
	end
	function v_u_3._getID(p100)
		-- upvalues: (copy) v_u_3
		if v_u_3._nextWidgetId then
			local v101 = v_u_3._nextWidgetId
			v_u_3._nextWidgetId = nil
			return v101
		end
		local v102 = 1 + (p100 or 1)
		local v103 = debug.info(v102, "l")
		local v104 = ""
		while v103 ~= -1 and v103 ~= nil do
			v104 = v104 .. "+" .. v103
			v102 = v102 + 1
			v103 = debug.info(v102, "l")
		end
		local v105 = v_u_3._usedIDs[v104]
		local v106
		if v105 then
			local v107 = v_u_3._usedIDs
			v107[v104] = v107[v104] + 1
			v106 = v105 + 1
		else
			v_u_3._usedIDs[v104] = 1
			v106 = 1
		end
		if #v_u_3._pushedIds == 0 then
			return v104 .. ":" .. v106
		end
		if not v_u_3._newID then
			return v104 .. ":" .. v106 .. ":" .. table.concat(v_u_3._pushedIds, "\\")
		end
		v_u_3._newID = false
		return v104 .. "::" .. table.concat(v_u_3._pushedIds, "\\")
	end
	function v_u_3._deepCompare(p108, p109)
		-- upvalues: (copy) v_u_3
		for v110, v111 in p108 do
			local v112 = p109[v110]
			if type(v111) == "table" then
				if not v112 or type(v112) ~= "table" then
					return false
				end
				if v_u_3._deepCompare(v111, v112) == false then
					return false
				end
			elseif type(v111) ~= type(v112) or v111 ~= v112 then
				return false
			end
		end
		return true
	end
	function v_u_3._deepCopy(p113)
		-- upvalues: (copy) v_u_3
		local v114 = table.clone(p113)
		for v115, v116 in pairs(p113) do
			if type(v116) == "table" then
				v114[v115] = v_u_3._deepCopy(v116)
			end
		end
		return v114
	end
	v_u_3._lastVDOM = v_u_3._generateEmptyVDOM()
	v_u_3._VDOM = v_u_3._generateEmptyVDOM()
	p_u_2.Internal = v_u_3
	p_u_2._config = v_u_3._config
	return v_u_3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Internal]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3450"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Types)
return {}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PubTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3451"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.WidgetTypes)
return {}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Types]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3452"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WidgetTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3453"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["colorDark"] = {
		["TextColor"] = Color3.fromRGB(255, 255, 255),
		["TextTransparency"] = 0,
		["TextDisabledColor"] = Color3.fromRGB(128, 128, 128),
		["TextDisabledTransparency"] = 0,
		["BorderColor"] = Color3.fromRGB(110, 110, 125),
		["BorderTransparency"] = 0.5,
		["BorderActiveColor"] = Color3.fromRGB(160, 160, 175),
		["BorderActiveTransparency"] = 0.3,
		["WindowBgColor"] = Color3.fromRGB(15, 15, 15),
		["WindowBgTransparency"] = 0.06,
		["PopupBgColor"] = Color3.fromRGB(20, 20, 20),
		["PopupBgTransparency"] = 0.06,
		["ScrollbarGrabColor"] = Color3.fromRGB(79, 79, 79),
		["ScrollbarGrabTransparency"] = 0,
		["TitleBgColor"] = Color3.fromRGB(10, 10, 10),
		["TitleBgTransparency"] = 0,
		["TitleBgActiveColor"] = Color3.fromRGB(41, 74, 122),
		["TitleBgActiveTransparency"] = 0,
		["TitleBgCollapsedColor"] = Color3.fromRGB(0, 0, 0),
		["TitleBgCollapsedTransparency"] = 0.5,
		["MenubarBgColor"] = Color3.fromRGB(36, 36, 36),
		["MenubarBgTransparency"] = 0,
		["FrameBgColor"] = Color3.fromRGB(41, 74, 122),
		["FrameBgTransparency"] = 0.46,
		["FrameBgHoveredColor"] = Color3.fromRGB(66, 150, 250),
		["FrameBgHoveredTransparency"] = 0.46,
		["FrameBgActiveColor"] = Color3.fromRGB(66, 150, 250),
		["FrameBgActiveTransparency"] = 0.33,
		["ButtonColor"] = Color3.fromRGB(66, 150, 250),
		["ButtonTransparency"] = 0.6,
		["ButtonHoveredColor"] = Color3.fromRGB(66, 150, 250),
		["ButtonHoveredTransparency"] = 0,
		["ButtonActiveColor"] = Color3.fromRGB(15, 135, 250),
		["ButtonActiveTransparency"] = 0,
		["ImageColor"] = Color3.fromRGB(255, 255, 255),
		["ImageTransparency"] = 0,
		["SliderGrabColor"] = Color3.fromRGB(66, 150, 250),
		["SliderGrabTransparency"] = 0,
		["SliderGrabActiveColor"] = Color3.fromRGB(117, 138, 204),
		["SliderGrabActiveTransparency"] = 0,
		["HeaderColor"] = Color3.fromRGB(66, 150, 250),
		["HeaderTransparency"] = 0.69,
		["HeaderHoveredColor"] = Color3.fromRGB(66, 150, 250),
		["HeaderHoveredTransparency"] = 0.2,
		["HeaderActiveColor"] = Color3.fromRGB(66, 150, 250),
		["HeaderActiveTransparency"] = 0,
		["TabColor"] = Color3.fromRGB(46, 89, 148),
		["TabTransparency"] = 0.14,
		["TabHoveredColor"] = Color3.fromRGB(66, 150, 250),
		["TabHoveredTransparency"] = 0.2,
		["TabActiveColor"] = Color3.fromRGB(51, 105, 173),
		["TabActiveTransparency"] = 0,
		["SelectionImageObjectColor"] = Color3.fromRGB(255, 255, 255),
		["SelectionImageObjectTransparency"] = 0.8,
		["SelectionImageObjectBorderColor"] = Color3.fromRGB(255, 255, 255),
		["SelectionImageObjectBorderTransparency"] = 0,
		["TableBorderStrongColor"] = Color3.fromRGB(79, 79, 89),
		["TableBorderStrongTransparency"] = 0,
		["TableBorderLightColor"] = Color3.fromRGB(59, 59, 64),
		["TableBorderLightTransparency"] = 0,
		["TableRowBgColor"] = Color3.fromRGB(0, 0, 0),
		["TableRowBgTransparency"] = 1,
		["TableRowBgAltColor"] = Color3.fromRGB(255, 255, 255),
		["TableRowBgAltTransparency"] = 0.94,
		["TableHeaderColor"] = Color3.fromRGB(48, 48, 51),
		["TableHeaderTransparency"] = 0,
		["NavWindowingHighlightColor"] = Color3.fromRGB(255, 255, 255),
		["NavWindowingHighlightTransparency"] = 0.3,
		["NavWindowingDimBgColor"] = Color3.fromRGB(204, 204, 204),
		["NavWindowingDimBgTransparency"] = 0.65,
		["SeparatorColor"] = Color3.fromRGB(110, 110, 128),
		["SeparatorTransparency"] = 0.5,
		["CheckMarkColor"] = Color3.fromRGB(66, 150, 250),
		["CheckMarkTransparency"] = 0,
		["PlotLinesColor"] = Color3.fromRGB(156, 156, 156),
		["PlotLinesTransparency"] = 0,
		["PlotLinesHoveredColor"] = Color3.fromRGB(255, 110, 89),
		["PlotLinesHoveredTransparency"] = 0,
		["PlotHistogramColor"] = Color3.fromRGB(230, 179, 0),
		["PlotHistogramTransparency"] = 0,
		["PlotHistogramHoveredColor"] = Color3.fromRGB(255, 153, 0),
		["PlotHistogramHoveredTransparency"] = 0,
		["ResizeGripColor"] = Color3.fromRGB(66, 150, 250),
		["ResizeGripTransparency"] = 0.8,
		["ResizeGripHoveredColor"] = Color3.fromRGB(66, 150, 250),
		["ResizeGripHoveredTransparency"] = 0.33,
		["ResizeGripActiveColor"] = Color3.fromRGB(66, 150, 250),
		["ResizeGripActiveTransparency"] = 0.05
	},
	["colorLight"] = {
		["TextColor"] = Color3.fromRGB(0, 0, 0),
		["TextTransparency"] = 0,
		["TextDisabledColor"] = Color3.fromRGB(153, 153, 153),
		["TextDisabledTransparency"] = 0,
		["BorderColor"] = Color3.fromRGB(64, 64, 64),
		["BorderActiveColor"] = Color3.fromRGB(64, 64, 64),
		["BorderTransparency"] = 0.5,
		["BorderActiveTransparency"] = 0.2,
		["WindowBgColor"] = Color3.fromRGB(240, 240, 240),
		["WindowBgTransparency"] = 0,
		["PopupBgColor"] = Color3.fromRGB(255, 255, 255),
		["PopupBgTransparency"] = 0.02,
		["TitleBgColor"] = Color3.fromRGB(245, 245, 245),
		["TitleBgTransparency"] = 0,
		["TitleBgActiveColor"] = Color3.fromRGB(209, 209, 209),
		["TitleBgActiveTransparency"] = 0,
		["TitleBgCollapsedColor"] = Color3.fromRGB(255, 255, 255),
		["TitleBgCollapsedTransparency"] = 0.5,
		["MenubarBgColor"] = Color3.fromRGB(219, 219, 219),
		["MenubarBgTransparency"] = 0,
		["ScrollbarGrabColor"] = Color3.fromRGB(176, 176, 176),
		["ScrollbarGrabTransparency"] = 0.2,
		["FrameBgColor"] = Color3.fromRGB(255, 255, 255),
		["FrameBgTransparency"] = 0.6,
		["FrameBgHoveredColor"] = Color3.fromRGB(66, 150, 250),
		["FrameBgHoveredTransparency"] = 0.6,
		["FrameBgActiveColor"] = Color3.fromRGB(66, 150, 250),
		["FrameBgActiveTransparency"] = 0.33,
		["ButtonColor"] = Color3.fromRGB(66, 150, 250),
		["ButtonTransparency"] = 0.6,
		["ButtonHoveredColor"] = Color3.fromRGB(66, 150, 250),
		["ButtonHoveredTransparency"] = 0,
		["ButtonActiveColor"] = Color3.fromRGB(15, 135, 250),
		["ButtonActiveTransparency"] = 0,
		["ImageColor"] = Color3.fromRGB(255, 255, 255),
		["ImageTransparency"] = 0,
		["HeaderColor"] = Color3.fromRGB(66, 150, 250),
		["HeaderTransparency"] = 0.31,
		["HeaderHoveredColor"] = Color3.fromRGB(66, 150, 250),
		["HeaderHoveredTransparency"] = 0.2,
		["HeaderActiveColor"] = Color3.fromRGB(66, 150, 250),
		["HeaderActiveTransparency"] = 0,
		["TabColor"] = Color3.fromRGB(195, 203, 213),
		["TabTransparency"] = 0.07,
		["TabHoveredColor"] = Color3.fromRGB(66, 150, 250),
		["TabHoveredTransparency"] = 0.2,
		["TabActiveColor"] = Color3.fromRGB(152, 186, 255),
		["TabActiveTransparency"] = 0,
		["SliderGrabColor"] = Color3.fromRGB(61, 133, 224),
		["SliderGrabTransparency"] = 0,
		["SliderGrabActiveColor"] = Color3.fromRGB(66, 150, 250),
		["SliderGrabActiveTransparency"] = 0,
		["SelectionImageObjectColor"] = Color3.fromRGB(0, 0, 0),
		["SelectionImageObjectTransparency"] = 0.8,
		["SelectionImageObjectBorderColor"] = Color3.fromRGB(0, 0, 0),
		["SelectionImageObjectBorderTransparency"] = 0,
		["TableBorderStrongColor"] = Color3.fromRGB(145, 145, 163),
		["TableBorderStrongTransparency"] = 0,
		["TableBorderLightColor"] = Color3.fromRGB(173, 173, 189),
		["TableBorderLightTransparency"] = 0,
		["TableRowBgColor"] = Color3.fromRGB(0, 0, 0),
		["TableRowBgTransparency"] = 1,
		["TableRowBgAltColor"] = Color3.fromRGB(77, 77, 77),
		["TableRowBgAltTransparency"] = 0.91,
		["TableHeaderColor"] = Color3.fromRGB(199, 222, 250),
		["TableHeaderTransparency"] = 0,
		["NavWindowingHighlightColor"] = Color3.fromRGB(179, 179, 179),
		["NavWindowingHighlightTransparency"] = 0.3,
		["NavWindowingDimBgColor"] = Color3.fromRGB(51, 51, 51),
		["NavWindowingDimBgTransparency"] = 0.8,
		["SeparatorColor"] = Color3.fromRGB(99, 99, 99),
		["SeparatorTransparency"] = 0.38,
		["CheckMarkColor"] = Color3.fromRGB(66, 150, 250),
		["CheckMarkTransparency"] = 0,
		["PlotLinesColor"] = Color3.fromRGB(99, 99, 99),
		["PlotLinesTransparency"] = 0,
		["PlotLinesHoveredColor"] = Color3.fromRGB(255, 110, 89),
		["PlotLinesHoveredTransparency"] = 0,
		["PlotHistogramColor"] = Color3.fromRGB(230, 179, 0),
		["PlotHistogramTransparency"] = 0,
		["PlotHistogramHoveredColor"] = Color3.fromRGB(255, 153, 0),
		["PlotHistogramHoveredTransparency"] = 0,
		["ResizeGripColor"] = Color3.fromRGB(89, 89, 89),
		["ResizeGripTransparency"] = 0.83,
		["ResizeGripHoveredColor"] = Color3.fromRGB(66, 150, 250),
		["ResizeGripHoveredTransparency"] = 0.33,
		["ResizeGripActiveColor"] = Color3.fromRGB(66, 150, 250),
		["ResizeGripActiveTransparency"] = 0.05
	},
	["sizeDefault"] = {
		["ItemWidth"] = UDim.new(1, 0),
		["ContentWidth"] = UDim.new(0.65, 0),
		["ContentHeight"] = UDim.new(0, 0),
		["WindowPadding"] = Vector2.new(8, 8),
		["WindowResizePadding"] = Vector2.new(6, 6),
		["FramePadding"] = Vector2.new(4, 3),
		["ItemSpacing"] = Vector2.new(8, 4),
		["ItemInnerSpacing"] = Vector2.new(4, 4),
		["CellPadding"] = Vector2.new(4, 2),
		["DisplaySafeAreaPadding"] = Vector2.new(0, 0),
		["SeparatorTextPadding"] = Vector2.new(20, 3),
		["IndentSpacing"] = 21,
		["TextFont"] = Font.fromEnum(Enum.Font.Code),
		["TextSize"] = 13,
		["FrameBorderSize"] = 0,
		["FrameRounding"] = 0,
		["GrabRounding"] = 0,
		["WindowRounding"] = 0,
		["WindowBorderSize"] = 1,
		["WindowTitleAlign"] = Enum.LeftRight.Left,
		["PopupBorderSize"] = 1,
		["PopupRounding"] = 0,
		["ScrollbarSize"] = 7,
		["GrabMinSize"] = 10,
		["SeparatorTextBorderSize"] = 3,
		["ImageBorderSize"] = 2
	},
	["sizeClear"] = {
		["ItemWidth"] = UDim.new(1, 0),
		["ContentWidth"] = UDim.new(0.65, 0),
		["ContentHeight"] = UDim.new(0, 0),
		["WindowPadding"] = Vector2.new(12, 8),
		["WindowResizePadding"] = Vector2.new(8, 8),
		["FramePadding"] = Vector2.new(6, 4),
		["ItemSpacing"] = Vector2.new(8, 8),
		["ItemInnerSpacing"] = Vector2.new(8, 8),
		["CellPadding"] = Vector2.new(4, 4),
		["DisplaySafeAreaPadding"] = Vector2.new(8, 8),
		["SeparatorTextPadding"] = Vector2.new(24, 6),
		["IndentSpacing"] = 25,
		["TextFont"] = Font.fromEnum(Enum.Font.Ubuntu),
		["TextSize"] = 15,
		["FrameBorderSize"] = 1,
		["FrameRounding"] = 4,
		["GrabRounding"] = 4,
		["WindowRounding"] = 4,
		["WindowBorderSize"] = 1,
		["WindowTitleAlign"] = Enum.LeftRight.Center,
		["PopupBorderSize"] = 1,
		["PopupRounding"] = 4,
		["ScrollbarSize"] = 9,
		["GrabMinSize"] = 14,
		["SeparatorTextBorderSize"] = 4,
		["ImageBorderSize"] = 4
	},
	["utilityDefault"] = {
		["UseScreenGUIs"] = true,
		["IgnoreGuiInset"] = false,
		["Parent"] = nil,
		["RichText"] = false,
		["TextWrapped"] = false,
		["DisplayOrderOffset"] = 127,
		["ZIndexOffset"] = 0,
		["MouseDoubleClickTime"] = 0.3,
		["MouseDoubleClickMaxDist"] = 6,
		["HoverColor"] = Color3.fromRGB(255, 255, 0),
		["HoverTransparency"] = 0.1
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[config]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3454"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Types)
return function(p_u_1)
	local v_u_2 = p_u_1.State(true)
	local v_u_3 = p_u_1.State(false)
	local v_u_4 = p_u_1.State(false)
	local v_u_5 = p_u_1.State(false)
	local v_u_6 = p_u_1.State(false)
	local v_u_7 = p_u_1.State(false)
	local v_u_8 = p_u_1.State(false)
	local function v_u_11(p9)
		-- upvalues: (copy) p_u_1
		p_u_1.PushConfig({
			["TextColor"] = p_u_1._config.TextDisabledColor
		})
		local v10 = p_u_1.Text({ "(?)" })
		p_u_1.PopConfig()
		p_u_1.PushConfig({
			["ContentWidth"] = UDim.new(0, 350)
		})
		if v10.hovered() then
			p_u_1.Tooltip({ p9 })
		end
		p_u_1.PopConfig()
	end
	local v_u_93 = {
		["Basic"] = function()
			-- upvalues: (copy) p_u_1
			p_u_1.Tree({ "Basic" })
			p_u_1.SeparatorText({ "Basic" })
			local v12 = p_u_1.State(1)
			p_u_1.Button({ "Button" })
			p_u_1.SmallButton({ "SmallButton" })
			p_u_1.Text({ "Text" })
			p_u_1.TextWrapped({ string.rep("Text Wrapped ", 5) })
			p_u_1.TextColored({ "Colored Text", Color3.fromRGB(255, 128, 0) })
			p_u_1.Text({
				"Rich Text: <b>bold text</b> <i>italic text</i> <u>underline text</u> <s>strikethrough text</s> <font color= \"rgb(240, 40, 10)\">red text</font> <font size=\"32\">bigger text</font>",
				true,
				nil,
				true
			})
			p_u_1.SameLine()
			p_u_1.RadioButton({ "Index \'1\'", 1 }, {
				["index"] = v12
			})
			p_u_1.RadioButton({ "Index \'two\'", "two" }, {
				["index"] = v12
			})
			if p_u_1.RadioButton({ "Index \'false\'", false }, {
				["index"] = v12
			}).active() == false and p_u_1.SmallButton({ "Select last" }).clicked() then
				v12:set(false)
			end
			p_u_1.End()
			local v13 = p_u_1.Text
			local v14 = {}
			local v15 = v12.value
			__set_list(v14, 1, {"The Index is: " .. tostring(v15)})
			v13(v14)
			p_u_1.SeparatorText({ "Inputs" })
			p_u_1.InputNum({})
			p_u_1.DragNum({})
			p_u_1.SliderNum({})
			p_u_1.End()
		end,
		["Image"] = function()
			-- upvalues: (copy) p_u_1
			p_u_1.Tree({ "Image" })
			p_u_1.SeparatorText({ "Image Controls" })
			local v16 = p_u_1.State("rbxasset://textures/ui/common/robux.png")
			local v17 = p_u_1.State(UDim2.fromOffset(100, 100))
			local v18 = p_u_1.State(Rect.new(0, 0, 0, 0))
			local v19 = p_u_1.State(Enum.ScaleType.Stretch)
			local v20 = p_u_1.State(false)
			local v22 = p_u_1.ComputedState(v20, function(p21)
				return p21 and Enum.ResamplerMode.Pixelated or Enum.ResamplerMode.Default
			end)
			local v23 = p_u_1.State(p_u_1._config.ImageColor)
			local v24 = p_u_1.State(p_u_1._config.ImageTransparency)
			p_u_1.InputColor4({ "Image Tint" }, {
				["color"] = v23,
				["transparency"] = v24
			})
			p_u_1.Combo({ "Asset" }, {
				["index"] = v16
			})
			p_u_1.Selectable({ "Robux Small", "rbxasset://textures/ui/common/robux.png" }, {
				["index"] = v16
			})
			p_u_1.Selectable({ "Robux Large", "rbxasset://textures//ui/common/robux@3x.png" }, {
				["index"] = v16
			})
			p_u_1.Selectable({ "Loading Texture", "rbxasset://textures//loading/darkLoadingTexture.png" }, {
				["index"] = v16
			})
			p_u_1.Selectable({ "Hue-Saturation Gradient", "rbxasset://textures//TagEditor/huesatgradient.png" }, {
				["index"] = v16
			})
			p_u_1.Selectable({ "famfamfam.png (WHY?)", "rbxasset://textures//TagEditor/famfamfam.png" }, {
				["index"] = v16
			})
			p_u_1.End()
			p_u_1.SliderUDim2({
				"Image Size",
				nil,
				nil,
				UDim2.new(1, 240, 1, 240)
			}, {
				["number"] = v17
			})
			p_u_1.SliderRect({
				"Image Rect",
				nil,
				nil,
				Rect.new(256, 256, 256, 256)
			}, {
				["number"] = v18
			})
			p_u_1.Combo({ "Scale Type" }, {
				["index"] = v19
			})
			p_u_1.Selectable({ "Stretch", Enum.ScaleType.Stretch }, {
				["index"] = v19
			})
			p_u_1.Selectable({ "Fit", Enum.ScaleType.Fit }, {
				["index"] = v19
			})
			p_u_1.Selectable({ "Crop", Enum.ScaleType.Crop }, {
				["index"] = v19
			})
			p_u_1.End()
			p_u_1.Checkbox({ "Pixelated" }, {
				["isChecked"] = v20
			})
			p_u_1.PushConfig({
				["ImageColor"] = v23:get(),
				["ImageTransparency"] = v24:get()
			})
			p_u_1.Image({
				v16:get(),
				v17:get(),
				v18:get(),
				v19:get(),
				v22:get()
			})
			p_u_1.PopConfig()
			p_u_1.SeparatorText({ "Tile" })
			local v25 = p_u_1.State(UDim2.fromScale(0.5, 0.5))
			p_u_1.SliderUDim2({
				"Tile Size",
				nil,
				nil,
				UDim2.new(1, 240, 1, 240)
			}, {
				["number"] = v25
			})
			p_u_1.PushConfig({
				["ImageColor"] = v23:get(),
				["ImageTransparency"] = v24:get()
			})
			p_u_1.Image({
				"rbxasset://textures/grid2.png",
				v17:get(),
				nil,
				Enum.ScaleType.Tile,
				v22:get(),
				v25:get()
			})
			p_u_1.PopConfig()
			p_u_1.SeparatorText({ "Slice" })
			local v26 = p_u_1.State(1)
			p_u_1.SliderNum({
				"Image Slice Scale",
				0.1,
				0.1,
				5
			}, {
				["number"] = v26
			})
			p_u_1.PushConfig({
				["ImageColor"] = v23:get(),
				["ImageTransparency"] = v24:get()
			})
			p_u_1.Image({
				"rbxasset://textures/ui/chatBubble_blue_notify_bkg.png",
				v17:get(),
				nil,
				Enum.ScaleType.Slice,
				v22:get(),
				nil,
				Rect.new(12, 12, 56, 56),
				1
			}, v26:get())
			p_u_1.PopConfig()
			p_u_1.SeparatorText({ "Image Button" })
			local v27 = p_u_1.State(0)
			p_u_1.SameLine()
			p_u_1.PushConfig({
				["ImageColor"] = v23:get(),
				["ImageTransparency"] = v24:get()
			})
			if p_u_1.ImageButton({ "rbxasset://textures/AvatarCompatibilityPreviewer/add.png", UDim2.fromOffset(20, 20) }).clicked() then
				v27:set(v27.value + 1)
			end
			p_u_1.PopConfig()
			p_u_1.Text({ (("Click count: %*"):format(v27.value)) })
			p_u_1.End()
			p_u_1.End()
		end,
		["Selectable"] = function()
			-- upvalues: (copy) p_u_1
			p_u_1.Tree({ "Selectable" })
			local v28 = p_u_1.State(2)
			p_u_1.Selectable({ "Selectable #1", 1 }, {
				["index"] = v28
			})
			p_u_1.Selectable({ "Selectable #2", 2 }, {
				["index"] = v28
			})
			if p_u_1.Selectable({ "Double click Selectable", 3, true }, {
				["index"] = v28
			}).doubleClicked() then
				v28:set(3)
			end
			p_u_1.Selectable({ "Impossible to select", 4, true }, {
				["index"] = v28
			})
			if p_u_1.Button({ "Select last" }).clicked() then
				v28:set(4)
			end
			p_u_1.Selectable({ "Independent Selectable" })
			p_u_1.End()
		end,
		["Combo"] = function()
			-- upvalues: (copy) p_u_1
			p_u_1.Tree({ "Combo" })
			p_u_1.PushConfig({
				["ContentWidth"] = UDim.new(1, -200)
			})
			local v29 = p_u_1.State("No Selection")
			p_u_1.SameLine()
			local v30 = p_u_1.Checkbox({ "No Preview" })
			local v31 = p_u_1.Checkbox({ "No Button" })
			if v30.checked() and v31.isChecked.value == true then
				v31.isChecked:set(false)
			end
			if v31.checked() and v30.isChecked.value == true then
				v30.isChecked:set(false)
			end
			p_u_1.End()
			p_u_1.Combo({ "Basic Usage", v31.isChecked:get(), v30.isChecked:get() }, {
				["index"] = v29
			})
			p_u_1.Selectable({ "Select 1", "One" }, {
				["index"] = v29
			})
			p_u_1.Selectable({ "Select 2", "Two" }, {
				["index"] = v29
			})
			p_u_1.Selectable({ "Select 3", "Three" }, {
				["index"] = v29
			})
			p_u_1.End()
			p_u_1.ComboArray({ "Using ComboArray" }, {
				["index"] = "No Selection"
			}, { "Red", "Green", "Blue" })
			local v32 = {}
			for v33 = 1, 50 do
				local v34 = tostring(v33)
				table.insert(v32, v34)
			end
			p_u_1.ComboArray({ "Height Test" }, {
				["index"] = "1"
			}, v32)
			local v35 = p_u_1.State("7 AM")
			p_u_1.Combo({ "Combo with Inner widgets" }, {
				["index"] = v35
			})
			p_u_1.Tree({ "Morning Shifts" })
			p_u_1.Selectable({ "Shift at 7 AM", "7 AM" }, {
				["index"] = v35
			})
			p_u_1.Selectable({ "Shift at 11 AM", "11 AM" }, {
				["index"] = v35
			})
			p_u_1.Selectable({ "Shift at 3 PM", "3 PM" }, {
				["index"] = v35
			})
			p_u_1.End()
			p_u_1.Tree({ "Night Shifts" })
			p_u_1.Selectable({ "Shift at 6 PM", "6 PM" }, {
				["index"] = v35
			})
			p_u_1.Selectable({ "Shift at 9 PM", "9 PM" }, {
				["index"] = v35
			})
			p_u_1.End()
			p_u_1.End()
			local v36 = p_u_1.ComboEnum({ "Using ComboEnum" }, {
				["index"] = Enum.UserInputState.Begin
			}, Enum.UserInputState)
			p_u_1.Text({ "Selected: " .. v36.index:get().Name })
			p_u_1.PopConfig()
			p_u_1.End()
		end,
		["Tree"] = function()
			-- upvalues: (copy) p_u_1, (copy) v_u_11
			p_u_1.Tree({ "Trees" })
			p_u_1.Tree({ "Tree using SpanAvailWidth", true })
			v_u_11("SpanAvailWidth determines if the Tree is selectable from its entire with, or only the text area")
			p_u_1.End()
			local v37 = p_u_1.Tree({ "Tree with Children" })
			p_u_1.Text({ "Im inside the first tree!" })
			p_u_1.Button({ "Im a button inside the first tree!" })
			p_u_1.Tree({ "Im a tree inside the first tree!" })
			p_u_1.Text({ "I am the innermost text!" })
			p_u_1.End()
			p_u_1.End()
			p_u_1.Checkbox({ "Toggle above tree" }, {
				["isChecked"] = v37.state.isUncollapsed
			})
			p_u_1.End()
		end,
		["CollapsingHeader"] = function()
			-- upvalues: (copy) p_u_1
			p_u_1.Tree({ "Collapsing Headers" })
			p_u_1.CollapsingHeader({ "A header" })
			p_u_1.Text({ "This is under the first header!" })
			p_u_1.End()
			local v38 = p_u_1.State(false)
			p_u_1.CollapsingHeader({ "Another header" }, {
				["isUncollapsed"] = v38
			})
			if p_u_1.Button({ "Shhh... secret button!" }).clicked() then
				v38:set(true)
			end
			p_u_1.End()
			p_u_1.End()
		end,
		["Group"] = function()
			-- upvalues: (copy) p_u_1
			p_u_1.Tree({ "Groups" })
			p_u_1.SameLine()
			p_u_1.Group()
			p_u_1.Text({ "I am in group A" })
			p_u_1.Button({ "Im also in A" })
			p_u_1.End()
			p_u_1.Separator()
			p_u_1.Group()
			p_u_1.Text({ "I am in group B" })
			p_u_1.Button({ "Im also in B" })
			p_u_1.Button({ "Also group B" })
			p_u_1.End()
			p_u_1.End()
			p_u_1.End()
		end,
		["Tab"] = function()
			-- upvalues: (copy) p_u_1
			p_u_1.Tree({ "Tabs" })
			p_u_1.Tree({ "Simple" })
			p_u_1.TabBar()
			p_u_1.Tab({ "Apples" })
			p_u_1.Text({ "Who loves apples?" })
			p_u_1.End()
			p_u_1.Tab({ "Broccoli" })
			p_u_1.Text({ "And what about broccoli?" })
			p_u_1.End()
			p_u_1.Tab({ "Carrots" })
			p_u_1.Text({ "But carrots are the best." })
			p_u_1.End()
			p_u_1.End()
			p_u_1.Separator()
			p_u_1.Text({ "Very important questions." })
			p_u_1.End()
			p_u_1.Tree({ "Closable" })
			local v39 = p_u_1.State(true)
			local v40 = p_u_1.State(true)
			local v41 = p_u_1.State(true)
			p_u_1.TabBar()
			p_u_1.Tab({ "\240\159\141\142", true }, {
				["isOpened"] = v39
			})
			p_u_1.Text({ "Who loves apples?" })
			if p_u_1.Button({ "I don\'t like apples." }).clicked() then
				v39:set(false)
			end
			p_u_1.End()
			p_u_1.Tab({ "\240\159\165\166", true }, {
				["isOpened"] = v40
			})
			p_u_1.Text({ "And what about broccoli?" })
			if p_u_1.Button({ "Not for me." }).clicked() then
				v40:set(false)
			end
			p_u_1.End()
			p_u_1.Tab({ "\240\159\165\149", true }, {
				["isOpened"] = v41
			})
			p_u_1.Text({ "But carrots are the best." })
			if p_u_1.Button({ "I disagree with you." }).clicked() then
				v41:set(false)
			end
			p_u_1.End()
			p_u_1.End()
			p_u_1.Separator()
			if p_u_1.Button({ "Actually, let me reconsider it." }).clicked() then
				v39:set(true)
				v40:set(true)
				v41:set(true)
			end
			p_u_1.End()
			p_u_1.End()
		end,
		["Indent"] = function()
			-- upvalues: (copy) p_u_1
			p_u_1.Tree({ "Indents" })
			p_u_1.Text({ "Not Indented" })
			p_u_1.Indent()
			p_u_1.Text({ "Indented" })
			p_u_1.Indent({ 7 })
			p_u_1.Text({ "Indented by 7 more pixels" })
			p_u_1.End()
			p_u_1.Indent({ -7 })
			p_u_1.Text({ "Indented by 7 less pixels" })
			p_u_1.End()
			p_u_1.End()
			p_u_1.End()
		end,
		["Input"] = function()
			-- upvalues: (copy) p_u_1, (copy) v_u_11
			p_u_1.Tree({ "Input" })
			local v42 = p_u_1.State(false)
			local v43 = p_u_1.State(false)
			local v44 = p_u_1.State(0)
			local v45 = p_u_1.State(100)
			local v46 = p_u_1.State(1)
			local v47 = p_u_1.State("%d")
			p_u_1.PushConfig({
				["ContentWidth"] = UDim.new(1, -120)
			})
			local v48 = p_u_1.InputNum({
				[p_u_1.Args.InputNum.Text] = "Input Number",
				[p_u_1.Args.InputNum.NoButtons] = v43.value,
				[p_u_1.Args.InputNum.Min] = v44.value,
				[p_u_1.Args.InputNum.Max] = v45.value,
				[p_u_1.Args.InputNum.Increment] = v46.value,
				[p_u_1.Args.InputNum.Format] = { v47.value }
			})
			p_u_1.PopConfig()
			p_u_1.Text({ "The Value is: " .. v48.number.value })
			if p_u_1.Button({ "Randomize Number" }).clicked() then
				v48.number:set(math.random(1, 99))
			end
			local v49 = p_u_1.Checkbox({ "NoField" }, {
				["isChecked"] = v42
			})
			local v50 = p_u_1.Checkbox({ "NoButtons" }, {
				["isChecked"] = v43
			})
			if v49.checked() and v50.isChecked.value == true then
				v50.isChecked:set(false)
			end
			if v50.checked() and v49.isChecked.value == true then
				v49.isChecked:set(false)
			end
			p_u_1.PushConfig({
				["ContentWidth"] = UDim.new(1, -120)
			})
			p_u_1.InputVector2({ "InputVector2" })
			p_u_1.InputVector3({ "InputVector3" })
			p_u_1.InputUDim({ "InputUDim" })
			p_u_1.InputUDim2({ "InputUDim2" })
			local v51 = p_u_1.State(false)
			local v52 = p_u_1.State(false)
			local v53 = p_u_1.State(Color3.new())
			local v54 = p_u_1.State(0)
			p_u_1.SliderNum({
				"Transparency",
				0.01,
				0,
				1
			}, {
				["number"] = v54
			})
			p_u_1.InputColor3({ "InputColor3", v51:get(), v52:get() }, {
				["color"] = v53
			})
			p_u_1.InputColor4({ "InputColor4", v51:get(), v52:get() }, {
				["color"] = v53,
				["transparency"] = v54
			})
			p_u_1.SameLine()
			p_u_1.Text({ v53:get():ToHex() })
			p_u_1.Checkbox({ "Use Floats" }, {
				["isChecked"] = v51
			})
			p_u_1.Checkbox({ "Use HSV" }, {
				["isChecked"] = v52
			})
			p_u_1.End()
			p_u_1.PopConfig()
			p_u_1.Separator()
			p_u_1.SameLine()
			p_u_1.Text({ "Slider Numbers" })
			v_u_11("ctrl + click slider number widgets to input a number")
			p_u_1.End()
			p_u_1.PushConfig({
				["ContentWidth"] = UDim.new(1, -120)
			})
			p_u_1.SliderNum({
				"Slide Int",
				1,
				1,
				8
			})
			p_u_1.SliderNum({
				"Slide Float",
				0.01,
				0,
				100
			})
			p_u_1.SliderNum({
				"Small Numbers",
				0.001,
				-2,
				1,
				"%f radians"
			})
			p_u_1.SliderNum({
				"Odd Ranges",
				0.001,
				-3.141592653589793,
				3.141592653589793,
				"%f radians"
			})
			p_u_1.SliderNum({
				"Big Numbers",
				10000,
				100000,
				10000000
			})
			p_u_1.SliderNum({
				"Few Numbers",
				1,
				0,
				3
			})
			p_u_1.PopConfig()
			p_u_1.Separator()
			p_u_1.SameLine()
			p_u_1.Text({ "Drag Numbers" })
			v_u_11("ctrl + click or double click drag number widgets to input a number, hold shift/alt while dragging to increase/decrease speed")
			p_u_1.End()
			p_u_1.PushConfig({
				["ContentWidth"] = UDim.new(1, -120)
			})
			p_u_1.DragNum({ "Drag Int" })
			p_u_1.DragNum({
				"Slide Float",
				0.001,
				-10,
				10
			})
			p_u_1.DragNum({
				"Percentage",
				1,
				0,
				100,
				"%d %%"
			})
			p_u_1.PopConfig()
			p_u_1.End()
		end,
		["InputText"] = function()
			-- upvalues: (copy) p_u_1
			p_u_1.Tree({ "Input Text" })
			local v55 = p_u_1.InputText({ "Input Text Test", "Input Text here" })
			p_u_1.Text({ "The text is: " .. v55.text.value })
			p_u_1.End()
		end,
		["MultiInput"] = function()
			-- upvalues: (copy) p_u_1
			p_u_1.Tree({ "Multi-Component Input" })
			local v56 = p_u_1.State(Vector2.new())
			local v57 = p_u_1.State((Vector3.new()))
			local v58 = p_u_1.State(UDim.new())
			local v59 = p_u_1.State(UDim2.new())
			local v60 = p_u_1.State(Color3.new())
			local v61 = p_u_1.State(Rect.new(0, 0, 0, 0))
			p_u_1.SeparatorText({ "Input" })
			p_u_1.InputVector2({}, {
				["number"] = v56
			})
			p_u_1.InputVector3({}, {
				["number"] = v57
			})
			p_u_1.InputUDim({}, {
				["number"] = v58
			})
			p_u_1.InputUDim2({}, {
				["number"] = v59
			})
			p_u_1.InputRect({}, {
				["number"] = v61
			})
			p_u_1.SeparatorText({ "Drag" })
			p_u_1.DragVector2({}, {
				["number"] = v56
			})
			p_u_1.DragVector3({}, {
				["number"] = v57
			})
			p_u_1.DragUDim({}, {
				["number"] = v58
			})
			p_u_1.DragUDim2({}, {
				["number"] = v59
			})
			p_u_1.DragRect({}, {
				["number"] = v61
			})
			p_u_1.SeparatorText({ "Slider" })
			p_u_1.SliderVector2({}, {
				["number"] = v56
			})
			p_u_1.SliderVector3({}, {
				["number"] = v57
			})
			p_u_1.SliderUDim({}, {
				["number"] = v58
			})
			p_u_1.SliderUDim2({}, {
				["number"] = v59
			})
			p_u_1.SliderRect({}, {
				["number"] = v61
			})
			p_u_1.SeparatorText({ "Color" })
			p_u_1.InputColor3({}, {
				["color"] = v60
			})
			p_u_1.InputColor4({}, {
				["color"] = v60
			})
			p_u_1.End()
		end,
		["Tooltip"] = function()
			-- upvalues: (copy) p_u_1
			p_u_1.PushConfig({
				["ContentWidth"] = UDim.new(0, 250)
			})
			p_u_1.Tree({ "Tooltip" })
			if p_u_1.Text({ "Hover over me to reveal a tooltip" }).hovered() then
				p_u_1.Tooltip({ "I am some helpful tooltip text" })
			end
			local v62 = p_u_1.State("Hello ")
			local v63 = p_u_1.State(1)
			if p_u_1.InputNum({
				"# of repeat",
				1,
				1,
				50
			}, {
				["number"] = v63
			}).numberChanged() then
				v62:set(string.rep("Hello ", v63:get()))
			end
			if p_u_1.Checkbox({ "Show dynamic text tooltip" }).state.isChecked.value then
				p_u_1.Tooltip({ v62:get() })
			end
			p_u_1.End()
			p_u_1.PopConfig()
		end,
		["Plotting"] = function()
			-- upvalues: (copy) p_u_1
			p_u_1.Tree({ "Plotting" })
			p_u_1.SeparatorText({ "Progress" })
			local v64 = os.clock() * 15
			local v65 = p_u_1.State(0)
			local v66 = v64 % 100 - 50
			local v67 = math.abs(v66) - 7.5
			v65:set(math.clamp(v67, 0, 35) / 35)
			p_u_1.ProgressBar({ "Progress Bar" }, {
				["progress"] = v65
			})
			local v68 = p_u_1.ProgressBar
			local v69 = {}
			local v70 = v65:get() * 1753
			__set_list(v69, 1, {"Progress Bar", (("%*/1753"):format((math.floor(v70))))})
			v68(v69, {
				["progress"] = v65
			})
			p_u_1.SeparatorText({ "Graphs" })
			local v71 = p_u_1.State({
				0.5,
				0.8,
				0.2,
				0.9,
				0.1,
				0.6,
				0.4,
				0.7,
				0.3,
				0
			})
			p_u_1.PlotHistogram({
				"Histogram",
				100,
				0,
				1,
				"random"
			}, {
				["values"] = v71
			})
			p_u_1.PlotLines({
				"Lines",
				100,
				0,
				1,
				"random"
			}, {
				["values"] = v71
			})
			local v72 = p_u_1.State("Cos")
			local v73 = p_u_1.State(37)
			local v74 = p_u_1.State(0)
			local v75 = p_u_1.State({})
			local v76 = p_u_1.State(0)
			local v77 = p_u_1.Checkbox({ "Animate" })
			local v78 = p_u_1.ComboArray({ "Plotting Function" }, {
				["index"] = v72
			}, {
				"Sin",
				"Cos",
				"Tan",
				"Saw"
			})
			local v79 = p_u_1.SliderNum({
				"Samples",
				1,
				1,
				145,
				"%d samples"
			}, {
				["number"] = v73
			})
			if p_u_1.SliderNum({
				"Baseline",
				0.1,
				-1,
				1
			}, {
				["number"] = v74
			}).numberChanged() then
				v75:set(v75.value, true)
			end
			if v77.state.isChecked.value or (v78.closed() or (v79.numberChanged() or #v75.value == 0)) then
				if v77.state.isChecked.value then
					v76:set(v76.value + p_u_1.Internal._deltaTime)
				end
				local v80 = v76.value * 30
				local v81 = math.floor(v80) - 1
				local v82 = v72.value
				table.clear(v75.value)
				for v83 = 1, v73.value do
					if v82 == "Sin" then
						local v84 = v75.value
						local v85 = (v83 + v81) * 5
						local v86 = math.rad(v85)
						v84[v83] = math.sin(v86)
					elseif v82 == "Cos" then
						local v87 = v75.value
						local v88 = (v83 + v81) * 5
						local v89 = math.rad(v88)
						v87[v83] = math.cos(v89)
					elseif v82 == "Tan" then
						local v90 = v75.value
						local v91 = (v83 + v81) * 5
						local v92 = math.rad(v91)
						v90[v83] = math.tan(v92)
					elseif v82 == "Saw" then
						v75.value[v83] = v83 % 2 == v81 % 2 and 1 or -1
					end
				end
				v75:set(v75.value, true)
			end
			p_u_1.PlotHistogram({
				"Histogram",
				100,
				-1,
				1,
				"",
				v74:get()
			}, {
				["values"] = v75
			})
			p_u_1.PlotLines({
				"Lines",
				100,
				-1,
				1
			}, {
				["values"] = v75
			})
			p_u_1.End()
		end
	}
	local v_u_94 = {
		"Basic",
		"Image",
		"Selectable",
		"Combo",
		"Tree",
		"CollapsingHeader",
		"Group",
		"Tab",
		"Indent",
		"Input",
		"MultiInput",
		"InputText",
		"Tooltip",
		"Plotting"
	}
	local function v_u_95()
		-- upvalues: (copy) p_u_1, (copy) v_u_95
		if p_u_1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
			v_u_95()
		end
		p_u_1.End()
	end
	local function v_u_98(p96)
		-- upvalues: (copy) p_u_1, (copy) v_u_98
		p_u_1.Window({ "Recursive Window" }, {
			["size"] = p_u_1.State(Vector2.new(175, 100)),
			["isOpened"] = p96
		})
		local v97 = p_u_1.Checkbox({ "Recurse Again" })
		p_u_1.End()
		if v97.isChecked.value then
			v_u_98(v97.isChecked)
		end
	end
	local function v_u_134()
		-- upvalues: (copy) p_u_1, (copy) v_u_4, (copy) v_u_11
		local v99 = {
			["isOpened"] = v_u_4
		}
		local v100 = p_u_1.Window({ "Runtime Info" }, v99)
		local v101 = p_u_1.Internal._lastVDOM
		local v102 = p_u_1.Internal._states
		local v103 = p_u_1.State(3)
		local v104 = p_u_1.State(0)
		local v105 = p_u_1.State(os.clock())
		p_u_1.SameLine()
		p_u_1.InputNum({
			[p_u_1.Args.InputNum.Text] = "",
			[p_u_1.Args.InputNum.Format] = "%d Seconds",
			[p_u_1.Args.InputNum.Max] = 10
		}, {
			["number"] = v103
		})
		if p_u_1.Button({ "Disable" }).clicked() then
			p_u_1.Disabled = true
			task.delay(v103:get(), function()
				-- upvalues: (ref) p_u_1
				p_u_1.Disabled = false
			end)
		end
		p_u_1.End()
		local v106 = os.clock()
		local v107 = v106 - v105.value
		v104.value = v104.value + (v107 - v104.value) * 0.2
		v105.value = v106
		p_u_1.Text({ string.format("Average %.3f ms/frame (%.1f FPS)", v104.value * 1000, 1 / v104.value) })
		p_u_1.Text({ string.format("Window Position: (%d, %d), Window Size: (%d, %d)", v100.position.value.X, v100.position.value.Y, v100.size.value.X, v100.size.value.Y) })
		p_u_1.SameLine()
		p_u_1.Text({ "Enter an ID to learn more about it." })
		v_u_11("every widget and state has an ID which Iris tracks to remember which widget is which. below lists all widgets and states, with their respective IDs")
		p_u_1.End()
		p_u_1.PushConfig({
			["ItemWidth"] = UDim.new(1, -150)
		})
		local v108 = p_u_1.InputText({ "ID field" }, {
			["text"] = p_u_1.State(v100.ID)
		}).state.text.value
		p_u_1.PopConfig()
		p_u_1.Indent()
		local v109 = v101[v108]
		local v110 = v102[v108]
		if v109 then
			p_u_1.Table({ 1 })
			p_u_1.Text({ string.format("The ID, \"%s\", is a widget", v108) })
			p_u_1.NextRow()
			p_u_1.Text({ string.format("Widget is type: %s", v109.type) })
			p_u_1.NextRow()
			p_u_1.Tree({ "Widget has Args:" }, {
				["isUncollapsed"] = p_u_1.State(true)
			})
			for v111, v112 in v109.arguments do
				p_u_1.Text({ v111 .. " - " .. tostring(v112) })
			end
			p_u_1.End()
			p_u_1.NextRow()
			if v109.state then
				p_u_1.Tree({ "Widget has State:" }, {
					["isUncollapsed"] = p_u_1.State(true)
				})
				for v113, v114 in v109.state do
					local v115 = p_u_1.Text
					local v116 = {}
					local v117 = v114.value
					__set_list(v116, 1, {v113 .. " - " .. tostring(v117)})
					v115(v116)
				end
				p_u_1.End()
			end
			p_u_1.End()
		elseif v110 then
			p_u_1.Table({ 1 })
			p_u_1.Text({ string.format("The ID, \"%s\", is a state", v108) })
			p_u_1.NextRow()
			local v118 = p_u_1.Text
			local v119 = {}
			local v120 = string.format
			local v121 = v110.value
			local v122 = typeof(v121)
			local v123 = v110.value
			__set_list(v119, 1, {v120("Value is type: %s, Value = %s", v122, (tostring(v123)))})
			v118(v119)
			p_u_1.NextRow()
			p_u_1.Tree({ "state has connected widgets:" }, {
				["isUncollapsed"] = p_u_1.State(true)
			})
			for v124, v125 in v110.ConnectedWidgets do
				p_u_1.Text({ v124 .. " - " .. v125.type })
			end
			p_u_1.End()
			p_u_1.NextRow()
			p_u_1.Text({ string.format("state has: %d connected functions", #v110.ConnectedFunctions) })
			p_u_1.End()
		else
			p_u_1.Text({ string.format("The ID, \"%s\", is not a state or widget", v108) })
		end
		p_u_1.End()
		if p_u_1.Tree({ "Widgets" }).state.isUncollapsed.value then
			local v126 = 0
			local v127 = ""
			for _, v128 in v101 do
				v126 = v126 + 1
				v127 = v127 .. "\n" .. v128.ID .. " - " .. v128.type
			end
			p_u_1.Text({ "Number of Widgets: " .. v126 })
			p_u_1.Text({ v127 })
		end
		p_u_1.End()
		if p_u_1.Tree({ "States" }).state.isUncollapsed.value then
			local v129 = 0
			local v130 = ""
			for v131, v132 in v102 do
				v129 = v129 + 1
				local v133 = v132.value
				v130 = v130 .. "\n" .. v131 .. " - " .. tostring(v133)
			end
			p_u_1.Text({ "Number of States: " .. v129 })
			p_u_1.Text({ v130 })
		end
		p_u_1.End()
		p_u_1.End()
	end
	local function v_u_136()
		-- upvalues: (copy) p_u_1, (copy) v_u_8
		local v135 = {
			["isOpened"] = v_u_8
		}
		p_u_1.Window({ "Debug Panel" }, v135)
		p_u_1.CollapsingHeader({ "Widgets" })
		p_u_1.SeparatorText({ "GuiService" })
		p_u_1.Text({ (("GuiOffset: %*"):format(p_u_1.Internal._utility.GuiOffset)) })
		p_u_1.Text({ (("MouseOffset: %*"):format(p_u_1.Internal._utility.MouseOffset)) })
		p_u_1.SeparatorText({ "UserInputService" })
		p_u_1.Text({ (("MousePosition: %*"):format((p_u_1.Internal._utility.UserInputService:GetMouseLocation()))) })
		p_u_1.Text({ (("MouseLocation: %*"):format((p_u_1.Internal._utility.getMouseLocation()))) })
		p_u_1.Text({ (("Left Control: %*"):format((p_u_1.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)))) })
		p_u_1.Text({ (("Right Control: %*"):format((p_u_1.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)))) })
		p_u_1.End()
		p_u_1.End()
	end
	local function v_u_137()
		-- upvalues: (copy) p_u_1, (copy) v_u_137
		if p_u_1.Menu({ "Recursive" }).state.isOpened.value then
			p_u_1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl })
			p_u_1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
			p_u_1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
			p_u_1.Separator()
			p_u_1.MenuToggle({ "Autosave" })
			p_u_1.MenuToggle({ "Checked" })
			p_u_1.Separator()
			p_u_1.Menu({ "Options" })
			p_u_1.MenuItem({ "Red" })
			p_u_1.MenuItem({ "Yellow" })
			p_u_1.MenuItem({ "Green" })
			p_u_1.MenuItem({ "Blue" })
			p_u_1.Separator()
			v_u_137()
			p_u_1.End()
		end
		p_u_1.End()
	end
	local function v_u_144()
		-- upvalues: (copy) p_u_1, (copy) v_u_137, (copy) v_u_2, (copy) v_u_3, (copy) v_u_6, (copy) v_u_7, (copy) v_u_4, (copy) v_u_5, (copy) v_u_8
		p_u_1.MenuBar()
		p_u_1.Menu({ "File" })
		p_u_1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl })
		p_u_1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
		p_u_1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
		v_u_137()
		if p_u_1.MenuItem({ "Quit", Enum.KeyCode.Q, Enum.ModifierKey.Alt }).clicked() then
			v_u_2:set(false)
		end
		p_u_1.End()
		p_u_1.Menu({ "Examples" })
		local v138 = {
			["isChecked"] = v_u_3
		}
		p_u_1.MenuToggle({ "Recursive Window" }, v138)
		local v139 = {
			["isChecked"] = v_u_6
		}
		p_u_1.MenuToggle({ "Windowless" }, v139)
		local v140 = {
			["isChecked"] = v_u_7
		}
		p_u_1.MenuToggle({ "Main Menu Bar" }, v140)
		p_u_1.End()
		p_u_1.Menu({ "Tools" })
		local v141 = {
			["isChecked"] = v_u_4
		}
		p_u_1.MenuToggle({ "Runtime Info" }, v141)
		local v142 = {
			["isChecked"] = v_u_5
		}
		p_u_1.MenuToggle({ "Style Editor" }, v142)
		local v143 = {
			["isChecked"] = v_u_8
		}
		p_u_1.MenuToggle({ "Debug Panel" }, v143)
		p_u_1.End()
		p_u_1.End()
	end
	local function v_u_172()
		-- upvalues: (copy) p_u_1, (copy) v_u_11, (copy) v_u_5
		local v166 = {
			{ "Sizing", function()
					-- upvalues: (ref) p_u_1, (ref) v_u_11
					local v_u_145 = p_u_1.State({})
					p_u_1.SameLine()
					if p_u_1.Button({ "Update" }).clicked() then
						p_u_1.UpdateGlobalConfig(v_u_145.value)
						v_u_145:set({})
					end
					v_u_11("Update the global config with these changes.")
					p_u_1.End()
					local function v149(p146, p147)
						-- upvalues: (ref) p_u_1, (copy) v_u_145
						local v148 = p_u_1[p146](p147, {
							["number"] = p_u_1.WeakState(p_u_1._config[p147[1]])
						})
						if v148.numberChanged() then
							v_u_145.value[p147[1]] = v148.number:get()
						end
					end
					local function v152(p150)
						-- upvalues: (ref) p_u_1, (copy) v_u_145
						local v151 = p_u_1.Checkbox(p150, {
							["isChecked"] = p_u_1.WeakState(p_u_1._config[p150[1]])
						})
						if v151.checked() or v151.unchecked() then
							v_u_145.value[p150[1]] = v151.isChecked:get()
						end
					end
					p_u_1.SeparatorText({ "Main" })
					v149("SliderVector2", {
						"WindowPadding",
						nil,
						Vector2.zero,
						Vector2.new(20, 20)
					})
					v149("SliderVector2", {
						"WindowResizePadding",
						nil,
						Vector2.zero,
						Vector2.new(20, 20)
					})
					v149("SliderVector2", {
						"FramePadding",
						nil,
						Vector2.zero,
						Vector2.new(20, 20)
					})
					v149("SliderVector2", {
						"ItemSpacing",
						nil,
						Vector2.zero,
						Vector2.new(20, 20)
					})
					v149("SliderVector2", {
						"ItemInnerSpacing",
						nil,
						Vector2.zero,
						Vector2.new(20, 20)
					})
					v149("SliderVector2", {
						"CellPadding",
						nil,
						Vector2.zero,
						Vector2.new(20, 20)
					})
					v149("SliderNum", {
						"IndentSpacing",
						1,
						0,
						36
					})
					v149("SliderNum", {
						"ScrollbarSize",
						1,
						0,
						20
					})
					v149("SliderNum", {
						"GrabMinSize",
						1,
						0,
						20
					})
					p_u_1.SeparatorText({ "Borders & Rounding" })
					v149("SliderNum", {
						"FrameBorderSize",
						0.1,
						0,
						1
					})
					v149("SliderNum", {
						"WindowBorderSize",
						0.1,
						0,
						1
					})
					v149("SliderNum", {
						"PopupBorderSize",
						0.1,
						0,
						1
					})
					v149("SliderNum", {
						"SeparatorTextBorderSize",
						1,
						0,
						20
					})
					v149("SliderNum", {
						"FrameRounding",
						1,
						0,
						12
					})
					v149("SliderNum", {
						"GrabRounding",
						1,
						0,
						12
					})
					v149("SliderNum", {
						"PopupRounding",
						1,
						0,
						12
					})
					p_u_1.SeparatorText({ "Widgets" })
					v149("SliderVector2", {
						"DisplaySafeAreaPadding",
						nil,
						Vector2.zero,
						Vector2.new(20, 20)
					})
					v149("SliderVector2", {
						"SeparatorTextPadding",
						nil,
						Vector2.zero,
						Vector2.new(36, 36)
					})
					v149("SliderUDim", {
						"ItemWidth",
						nil,
						UDim.new(),
						UDim.new(1, 200)
					})
					v149("SliderUDim", {
						"ContentWidth",
						nil,
						UDim.new(),
						UDim.new(1, 200)
					})
					v149("SliderNum", {
						"ImageBorderSize",
						1,
						0,
						12
					})
					local v153 = p_u_1.ComboEnum({ "WindowTitleAlign" }, {
						["index"] = p_u_1.WeakState(p_u_1._config.WindowTitleAlign)
					}, Enum.LeftRight)
					if v153.closed() then
						v_u_145.value.WindowTitleAlign = v153.index:get()
					end
					v152({ "RichText" })
					v152({ "TextWrapped" })
					p_u_1.SeparatorText({ "Config" })
					v152({ "UseScreenGUIs" })
					v149("DragNum", { "DisplayOrderOffset", 1, 0 })
					v149("DragNum", { "ZIndexOffset", 1, 0 })
					v149("SliderNum", {
						"MouseDoubleClickTime",
						0.1,
						0,
						5
					})
					v149("SliderNum", {
						"MouseDoubleClickMaxDist",
						0.1,
						0,
						20
					})
				end },
			{ "Colors", function()
					-- upvalues: (ref) p_u_1, (ref) v_u_11
					local v154 = p_u_1.State({})
					p_u_1.SameLine()
					if p_u_1.Button({ "Update" }).clicked() then
						p_u_1.UpdateGlobalConfig(v154.value)
						v154:set({})
					end
					v_u_11("Update the global config with these changes.")
					p_u_1.End()
					for _, v155 in {
						"Text",
						"TextDisabled",
						"WindowBg",
						"PopupBg",
						"Border",
						"BorderActive",
						"ScrollbarGrab",
						"TitleBg",
						"TitleBgActive",
						"TitleBgCollapsed",
						"MenubarBg",
						"FrameBg",
						"FrameBgHovered",
						"FrameBgActive",
						"Button",
						"ButtonHovered",
						"ButtonActive",
						"Image",
						"SliderGrab",
						"SliderGrabActive",
						"Header",
						"HeaderHovered",
						"HeaderActive",
						"SelectionImageObject",
						"SelectionImageObjectBorder",
						"TableBorderStrong",
						"TableBorderLight",
						"TableRowBg",
						"TableRowBgAlt",
						"NavWindowingHighlight",
						"NavWindowingDimBg",
						"Separator",
						"CheckMark"
					} do
						local v156 = p_u_1.InputColor4({ v155 }, {
							["color"] = p_u_1.WeakState(p_u_1._config[v155 .. "Color"]),
							["transparency"] = p_u_1.WeakState(p_u_1._config[v155 .. "Transparency"])
						})
						if v156.numberChanged() then
							v154.value[v155 .. "Color"] = v156.color:get()
							v154.value[v155 .. "Transparency"] = v156.transparency:get()
						end
					end
				end },
			{ "Fonts", function()
					-- upvalues: (ref) p_u_1, (ref) v_u_11
					local v157 = p_u_1.State({})
					p_u_1.SameLine()
					if p_u_1.Button({ "Update" }).clicked() then
						p_u_1.UpdateGlobalConfig(v157.value)
						v157:set({})
					end
					v_u_11("Update the global config with these changes.")
					p_u_1.End()
					local v158 = {
						["Code (default)"] = Font.fromEnum(Enum.Font.Code),
						["Ubuntu (template)"] = Font.fromEnum(Enum.Font.Ubuntu),
						["Arial"] = Font.fromEnum(Enum.Font.Arial),
						["Highway"] = Font.fromEnum(Enum.Font.Highway),
						["Roboto"] = Font.fromEnum(Enum.Font.Roboto),
						["Roboto Mono"] = Font.fromEnum(Enum.Font.RobotoMono),
						["Noto Sans"] = Font.new("rbxassetid://12187370747"),
						["Builder Sans"] = Font.fromEnum(Enum.Font.BuilderSans),
						["Builder Mono"] = Font.new("rbxassetid://16658246179"),
						["Sono"] = Font.new("rbxassetid://12187374537")
					}
					p_u_1.Text({ (("Current Font: %* Weight: %* Style: %*"):format(p_u_1._config.TextFont.Family, p_u_1._config.TextFont.Weight, p_u_1._config.TextFont.Style)) })
					p_u_1.SeparatorText({ "Size" })
					local v159 = p_u_1.SliderNum({
						"Font Size",
						1,
						4,
						20
					}, {
						["number"] = p_u_1.WeakState(p_u_1._config.TextSize)
					})
					if v159.numberChanged() then
						v157.value.TextSize = v159.state.number:get()
					end
					p_u_1.SeparatorText({ "Properties" })
					local v160 = p_u_1.WeakState(p_u_1._config.TextFont.Family)
					local v161 = p_u_1.ComboEnum({ "Font Weight" }, {
						["index"] = p_u_1.WeakState(p_u_1._config.TextFont.Weight)
					}, Enum.FontWeight)
					local v162 = p_u_1.ComboEnum({ "Font Style" }, {
						["index"] = p_u_1.WeakState(p_u_1._config.TextFont.Style)
					}, Enum.FontStyle)
					p_u_1.SeparatorText({ "Fonts" })
					for v163, v164 in v158 do
						local v165 = Font.new(v164.Family, v161.state.index.value, v162.state.index.value)
						p_u_1.SameLine()
						p_u_1.PushConfig({
							["TextFont"] = v165
						})
						if p_u_1.Selectable({ ("%* | \"The quick brown fox jumps over the lazy dog.\""):format(v163), v165.Family }, {
							["index"] = v160
						}).selected() then
							v157.value.TextFont = v165
						end
						p_u_1.PopConfig()
						p_u_1.End()
					end
				end }
		}
		local v167 = {
			["isOpened"] = v_u_5
		}
		p_u_1.Window({ "Style Editor" }, v167)
		p_u_1.Text({ "Customize the look of Iris in realtime." })
		local v168 = p_u_1.State("Dark Theme")
		if p_u_1.ComboArray({ "Theme" }, {
			["index"] = v168
		}, { "Dark Theme", "Light Theme" }).closed() then
			if v168.value == "Dark Theme" then
				p_u_1.UpdateGlobalConfig(p_u_1.TemplateConfig.colorDark)
			elseif v168.value == "Light Theme" then
				p_u_1.UpdateGlobalConfig(p_u_1.TemplateConfig.colorLight)
			end
		end
		local v169 = p_u_1.State("Classic Size")
		if p_u_1.ComboArray({ "Size" }, {
			["index"] = v169
		}, { "Classic Size", "Larger Size" }).closed() then
			if v169.value == "Classic Size" then
				p_u_1.UpdateGlobalConfig(p_u_1.TemplateConfig.sizeDefault)
			elseif v169.value == "Larger Size" then
				p_u_1.UpdateGlobalConfig(p_u_1.TemplateConfig.sizeClear)
			end
		end
		p_u_1.SameLine()
		if p_u_1.Button({ "Revert" }).clicked() then
			p_u_1.UpdateGlobalConfig(p_u_1.TemplateConfig.colorDark)
			p_u_1.UpdateGlobalConfig(p_u_1.TemplateConfig.sizeDefault)
			v168:set("Dark Theme")
			v169:set("Classic Size")
		end
		v_u_11("Reset Iris to the default theme and size.")
		p_u_1.End()
		p_u_1.TabBar()
		for v170, v171 in ipairs(v166) do
			p_u_1.Tab({ v171[1] })
			v166[v170][2]()
			p_u_1.End()
		end
		p_u_1.End()
		p_u_1.Separator()
		p_u_1.End()
	end
	local function v_u_185()
		-- upvalues: (copy) p_u_1
		p_u_1.CollapsingHeader({ "Widget Event Interactivity" })
		local v173 = p_u_1.State(0)
		if p_u_1.Button({ "Click to increase Number" }).clicked() then
			v173:set(v173:get() + 1)
		end
		p_u_1.Text({ "The Number is: " .. v173:get() })
		p_u_1.Separator()
		local v174 = p_u_1.State(false)
		local v175 = p_u_1.State("clicked")
		p_u_1.SameLine()
		p_u_1.RadioButton({ "clicked", "clicked" }, {
			["index"] = v175
		})
		p_u_1.RadioButton({ "rightClicked", "rightClicked" }, {
			["index"] = v175
		})
		p_u_1.RadioButton({ "doubleClicked", "doubleClicked" }, {
			["index"] = v175
		})
		p_u_1.RadioButton({ "ctrlClicked", "ctrlClicked" }, {
			["index"] = v175
		})
		p_u_1.End()
		p_u_1.SameLine()
		if p_u_1.Button({ v175:get() .. " to reveal text" })[v175:get()]() then
			v174:set(not v174:get())
		end
		if v174:get() then
			p_u_1.Text({ "Here i am!" })
		end
		p_u_1.End()
		p_u_1.Separator()
		local v176 = p_u_1.State(0)
		p_u_1.SameLine()
		if p_u_1.Button({ "Click to show text for 20 frames" }).clicked() then
			v176:set(20)
		end
		if v176:get() > 0 then
			p_u_1.Text({ "Here i am!" })
		end
		p_u_1.End()
		local v177 = v176:get() - 1
		v176:set((math.max(0, v177)))
		p_u_1.Text({ "Text Timer: " .. v176:get() })
		local v178 = p_u_1.Checkbox({ "Event-tracked checkbox" })
		p_u_1.Indent()
		local v179 = p_u_1.Text
		local v180 = {}
		local v181 = v178.unchecked
		__set_list(v180, 1, {"unchecked: " .. tostring(v181())})
		v179(v180)
		local v182 = p_u_1.Text
		local v183 = {}
		local v184 = v178.checked
		__set_list(v183, 1, {"checked: " .. tostring(v184())})
		v182(v183)
		p_u_1.End()
		p_u_1.SameLine()
		if p_u_1.Button({ "Hover over me" }).hovered() then
			p_u_1.Text({ "The button is hovered" })
		end
		p_u_1.End()
		p_u_1.End()
	end
	local function v_u_195()
		-- upvalues: (copy) p_u_1
		p_u_1.CollapsingHeader({ "Widget State Interactivity" })
		local v186 = p_u_1.Checkbox({ "Widget-Generated State" })
		p_u_1.Text({ (("isChecked: %*\n"):format(v186.state.isChecked.value)) })
		local v187 = {
			["isChecked"] = p_u_1.State(false)
		}
		local v188 = p_u_1.Checkbox({ "User-Generated State" }, v187)
		p_u_1.Text({ (("isChecked: %*\n"):format(v188.state.isChecked.value)) })
		local v189 = p_u_1.Checkbox({ "Widget Coupled State" })
		local v190 = p_u_1.Checkbox({ "Coupled to above Checkbox" }, {
			["isChecked"] = v189.state.isChecked
		})
		p_u_1.Text({ (("isChecked: %*\n"):format(v190.state.isChecked.value)) })
		local v191 = p_u_1.State(false)
		p_u_1.Checkbox({ "Widget and Code Coupled State" }, {
			["isChecked"] = v191
		})
		if p_u_1.Button({ "Click to toggle above checkbox" }).clicked() then
			v191:set(not v191:get())
		end
		p_u_1.Text({ (("isChecked: %*\n"):format(v191.value)) })
		local v192 = p_u_1.State(true)
		local v194 = p_u_1.ComputedState(v192, function(p193)
			return not p193
		end)
		p_u_1.Checkbox({ "ComputedState (dynamic coupling)" }, {
			["isChecked"] = v192
		})
		p_u_1.Checkbox({ "Inverted of above checkbox" }, {
			["isChecked"] = v194
		})
		p_u_1.Text({ (("isChecked: %*\n"):format(v194.value)) })
		p_u_1.End()
	end
	local function v_u_200()
		-- upvalues: (copy) p_u_1, (copy) v_u_11
		p_u_1.CollapsingHeader({ "Dynamic Styles" })
		local v196 = p_u_1.State(0)
		p_u_1.SameLine()
		if p_u_1.Button({ "Change Color" }).clicked() then
			v196:set(math.random())
		end
		local v197 = p_u_1.Text
		local v198 = {}
		local v199 = v196:get() * 255
		__set_list(v198, 1, {"Hue: " .. math.floor(v199)})
		v197(v198)
		v_u_11("Using PushConfig with a changing value, this can be done with any config field")
		p_u_1.End()
		p_u_1.PushConfig({
			["TextColor"] = Color3.fromHSV(v196:get(), 1, 1)
		})
		p_u_1.Text({ "Text with a unique and changable color" })
		p_u_1.PopConfig()
		p_u_1.End()
	end
	local function v_u_255()
		-- upvalues: (copy) p_u_1, (copy) v_u_11
		local v201 = p_u_1.State(false)
		p_u_1.CollapsingHeader({ "Tables & Columns" }, {
			["isUncollapsed"] = v201
		})
		if v201.value == false then
			p_u_1.End()
		else
			p_u_1.Tree({ "Basic" })
			p_u_1.SameLine()
			p_u_1.Text({ "Table using NextColumn syntax:" })
			v_u_11("calling Iris.NextColumn() in the inner loop,\nwhich automatically goes to the next row at the end.")
			p_u_1.End()
			p_u_1.Table({ 3 })
			for v202 = 1, 4 do
				for v203 = 1, 3 do
					p_u_1.Text({ (("Row: %*, Column: %*"):format(v202, v203)) })
					p_u_1.NextColumn()
				end
			end
			p_u_1.End()
			p_u_1.Text({ "" })
			p_u_1.SameLine()
			p_u_1.Text({ "Table using NextColumn and NextRow syntax:" })
			v_u_11("Calling Iris.NextColumn() in the inner loop and Iris.NextRow() in the outer loop,\nto acehieve a visually identical result. Technically they are not the same.")
			p_u_1.End()
			p_u_1.Table({ 3 })
			for v204 = 1, 4 do
				for v205 = 1, 3 do
					p_u_1.Text({ (("Row: %*, Column: %*"):format(v204, v205)) })
					p_u_1.NextColumn()
				end
				p_u_1.NextRow()
			end
			p_u_1.End()
			p_u_1.End()
			p_u_1.Tree({ "Headers, borders and backgrounds" })
			local v206 = p_u_1.State(0)
			local v207 = p_u_1.State(false)
			local v208 = p_u_1.State(false)
			local v209 = p_u_1.State(true)
			local v210 = p_u_1.State(true)
			p_u_1.Checkbox({ "Table header row" }, {
				["isChecked"] = v207
			})
			p_u_1.Checkbox({ "Table row backgrounds" }, {
				["isChecked"] = v208
			})
			p_u_1.Checkbox({ "Table outer border" }, {
				["isChecked"] = v209
			})
			p_u_1.Checkbox({ "Table inner borders" }, {
				["isChecked"] = v210
			})
			p_u_1.SameLine()
			p_u_1.Text({ "Cell contents" })
			p_u_1.RadioButton({ "Text", 0 }, {
				["index"] = v206
			})
			p_u_1.RadioButton({ "Fill button", 1 }, {
				["index"] = v206
			})
			p_u_1.End()
			p_u_1.Table({
				3,
				v207.value,
				v208.value,
				v209.value,
				v210.value
			})
			p_u_1.SetHeaderColumnIndex(1)
			for v211 = 0, 4 do
				for v212 = 1, 3 do
					if v206.value == 0 then
						p_u_1.Text({ (("Cell (%*, %*)"):format(v212, v211)) })
					else
						p_u_1.Button({ ("Cell (%*, %*)"):format(v212, v211), UDim2.fromScale(1, 0) })
					end
					p_u_1.NextColumn()
				end
			end
			p_u_1.End()
			p_u_1.End()
			p_u_1.Tree({ "Sizing" })
			local v213 = p_u_1.State(false)
			local v214 = p_u_1.State(false)
			p_u_1.Checkbox({ "Resizable" }, {
				["isChecked"] = v213
			})
			p_u_1.Checkbox({ "Limit Table Width" }, {
				["isChecked"] = v214
			})
			p_u_1.SeparatorText({ "stretch, equal" })
			p_u_1.Table({
				3,
				false,
				true,
				true,
				true,
				v213.value
			})
			for _ = 1, 3 do
				for _ = 1, 3 do
					p_u_1.Text({ "stretch" })
					p_u_1.NextColumn()
				end
			end
			p_u_1.End()
			p_u_1.Table({
				3,
				false,
				true,
				true,
				true,
				v213.value
			})
			for _ = 1, 3 do
				for v215 = 1, 3 do
					local v216 = p_u_1.Text
					local v217 = {}
					local v218 = string.rep
					local v219 = v215 + 64
					__set_list(v217, 1, {v218(string.char(v219), v215 * 4)})
					v216(v217)
					p_u_1.NextColumn()
				end
			end
			p_u_1.End()
			p_u_1.SeparatorText({ "stretch, proportional" })
			p_u_1.Table({
				3,
				false,
				true,
				true,
				true,
				v213.value,
				false,
				true
			})
			for _ = 1, 3 do
				for _ = 1, 3 do
					p_u_1.Text({ "stretch" })
					p_u_1.NextColumn()
				end
			end
			p_u_1.End()
			p_u_1.Table({
				3,
				false,
				true,
				true,
				true,
				v213.value,
				false,
				true
			})
			for _ = 1, 3 do
				for v220 = 1, 3 do
					local v221 = p_u_1.Text
					local v222 = {}
					local v223 = string.rep
					local v224 = v220 + 64
					__set_list(v222, 1, {v223(string.char(v224), v220 * 4)})
					v221(v222)
					p_u_1.NextColumn()
				end
			end
			p_u_1.End()
			p_u_1.SeparatorText({ "fixed, equal" })
			p_u_1.Table({
				3,
				false,
				true,
				true,
				true,
				v213.value,
				true,
				false,
				v214.value
			})
			for _ = 1, 3 do
				for _ = 1, 3 do
					p_u_1.Text({ "fixed" })
					p_u_1.NextColumn()
				end
			end
			p_u_1.End()
			p_u_1.Table({
				3,
				false,
				true,
				true,
				true,
				v213.value,
				true,
				false,
				v214.value
			})
			for _ = 1, 3 do
				for v225 = 1, 3 do
					local v226 = p_u_1.Text
					local v227 = {}
					local v228 = string.rep
					local v229 = v225 + 64
					__set_list(v227, 1, {v228(string.char(v229), v225 * 4)})
					v226(v227)
					p_u_1.NextColumn()
				end
			end
			p_u_1.End()
			p_u_1.SeparatorText({ "fixed, proportional" })
			p_u_1.Table({
				3,
				false,
				true,
				true,
				true,
				v213.value,
				true,
				true,
				v214.value
			})
			for _ = 1, 3 do
				for _ = 1, 3 do
					p_u_1.Text({ "fixed" })
					p_u_1.NextColumn()
				end
			end
			p_u_1.End()
			p_u_1.Table({
				3,
				false,
				true,
				true,
				true,
				v213.value,
				true,
				true,
				v214.value
			})
			for _ = 1, 3 do
				for v230 = 1, 3 do
					local v231 = p_u_1.Text
					local v232 = {}
					local v233 = string.rep
					local v234 = v230 + 64
					__set_list(v232, 1, {v233(string.char(v234), v230 * 4)})
					v231(v232)
					p_u_1.NextColumn()
				end
			end
			p_u_1.End()
			p_u_1.End()
			p_u_1.Tree({ "Resizable" })
			local v235 = p_u_1.State(4)
			local v236 = p_u_1.State(3)
			local v237 = p_u_1.State(false)
			local v238 = p_u_1.State(true)
			local v239 = p_u_1.State(true)
			local v240 = p_u_1.State(true)
			local v241 = p_u_1.State(true)
			local v242 = p_u_1.State(false)
			local v243 = p_u_1.State(false)
			local v244 = p_u_1.State(false)
			local v245 = p_u_1.State(false)
			local v246 = p_u_1.State(false)
			local v_u_247 = p_u_1.State(table.create(10, 100))
			p_u_1.SliderNum({
				"Num Columns",
				1,
				1,
				10
			}, {
				["number"] = v235
			})
			p_u_1.SliderNum({
				"Number of rows",
				1,
				0,
				100
			}, {
				["number"] = v236
			})
			p_u_1.SameLine()
			p_u_1.RadioButton({ "Buttons", true }, {
				["index"] = v237
			})
			p_u_1.RadioButton({ "Text", false }, {
				["index"] = v237
			})
			p_u_1.End()
			p_u_1.Table({ 3 })
			p_u_1.Checkbox({ "Show Header Row" }, {
				["isChecked"] = v238
			})
			p_u_1.NextColumn()
			p_u_1.Checkbox({ "Show Row Backgrounds" }, {
				["isChecked"] = v239
			})
			p_u_1.NextColumn()
			p_u_1.Checkbox({ "Show Outer Border" }, {
				["isChecked"] = v240
			})
			p_u_1.NextColumn()
			p_u_1.Checkbox({ "Show Inner Border" }, {
				["isChecked"] = v241
			})
			p_u_1.NextColumn()
			p_u_1.Checkbox({ "Resizable" }, {
				["isChecked"] = v242
			})
			p_u_1.NextColumn()
			p_u_1.Checkbox({ "Fixed Width" }, {
				["isChecked"] = v243
			})
			p_u_1.NextColumn()
			p_u_1.Checkbox({ "Proportional Width" }, {
				["isChecked"] = v244
			})
			p_u_1.NextColumn()
			p_u_1.Checkbox({ "Limit Table Width" }, {
				["isChecked"] = v245
			})
			p_u_1.NextColumn()
			p_u_1.Checkbox({ "Add extra" }, {
				["isChecked"] = v246
			})
			p_u_1.NextColumn()
			p_u_1.End()
			for v_u_248 = 1, v235.value do
				local v249 = v243.value == true and 1 or 0.05
				local v250 = v243.value == true and 2 or 0.05
				local v251 = v243.value == true and 480 or 1
				p_u_1.SliderNum({
					("Column %* Width"):format(v_u_248),
					v249,
					v250,
					v251
				}, {
					["number"] = p_u_1.TableState(v_u_247.value, v_u_248, function(p252)
						-- upvalues: (copy) v_u_247, (copy) v_u_248
						v_u_247.value[v_u_248] = p252
						v_u_247:set(v_u_247.value, true)
						return false
					end)
				})
			end
			p_u_1.PushConfig({
				["NumColumns"] = v235.value
			})
			p_u_1.Table({
				v235.value,
				v238.value,
				v239.value,
				v240.value,
				v241.value,
				v242.value,
				v243.value,
				v244.value,
				v245.value
			}, {
				["widths"] = v_u_247
			})
			p_u_1.SetHeaderColumnIndex(1)
			for v253 = 0, v236:get() do
				for v254 = 1, v235.value do
					if v253 == 0 then
						if v237.value then
							p_u_1.Button({ (("H: %*"):format(v254)) })
						else
							p_u_1.Text({ (("H: %*"):format(v254)) })
						end
					elseif v237.value then
						p_u_1.Button({ (("R: %*, C: %*"):format(v253, v254)) })
						p_u_1.Button({ string.rep("...", v254) })
					else
						p_u_1.Text({ (("R: %*, C: %*"):format(v253, v254)) })
						p_u_1.Text({ string.rep("...", v254) })
					end
					p_u_1.NextColumn()
				end
			end
			if v246.value then
				p_u_1.Text({ "A really long piece of text!" })
			end
			p_u_1.End()
			p_u_1.PopConfig()
			p_u_1.End()
			p_u_1.End()
		end
	end
	local function v_u_266()
		-- upvalues: (copy) p_u_1, (copy) v_u_11
		p_u_1.CollapsingHeader({ "Widget Layout" })
		p_u_1.Tree({ "Widget Alignment" })
		p_u_1.Text({ "Iris.SameLine has optional argument supporting horizontal and vertical alignments." })
		p_u_1.Text({ "This allows widgets to be place anywhere on the line." })
		p_u_1.Separator()
		p_u_1.SameLine()
		p_u_1.Text({ "By default child widgets will be aligned to the left." })
		v_u_11("Iris.SameLine()\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()")
		p_u_1.End()
		p_u_1.SameLine()
		p_u_1.Button({ "Button A" })
		p_u_1.Button({ "Button B" })
		p_u_1.End()
		p_u_1.SameLine()
		p_u_1.Text({ "But can be aligned to the center." })
		v_u_11("Iris.SameLine({ nil, nil, Enum.HorizontalAlignment.Center })\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()")
		p_u_1.End()
		p_u_1.SameLine({ nil, nil, Enum.HorizontalAlignment.Center })
		p_u_1.Button({ "Button A" })
		p_u_1.Button({ "Button B" })
		p_u_1.End()
		p_u_1.SameLine()
		p_u_1.Text({ "Or right." })
		v_u_11("Iris.SameLine({ nil, nil, Enum.HorizontalAlignment.Right })\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()")
		p_u_1.End()
		p_u_1.SameLine({ nil, nil, Enum.HorizontalAlignment.Right })
		p_u_1.Button({ "Button A" })
		p_u_1.Button({ "Button B" })
		p_u_1.End()
		p_u_1.Separator()
		p_u_1.SameLine()
		p_u_1.Text({ "You can also specify the padding." })
		v_u_11("Iris.SameLine({ 0, nil, Enum.HorizontalAlignment.Center })\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()")
		p_u_1.End()
		p_u_1.SameLine({ 0, nil, Enum.HorizontalAlignment.Center })
		p_u_1.Button({ "Button A" })
		p_u_1.Button({ "Button B" })
		p_u_1.End()
		p_u_1.End()
		p_u_1.Tree({ "Widget Sizing" })
		p_u_1.Text({ "Nearly all widgets are the minimum size of the content." })
		p_u_1.Text({ "For example, text and button widgets will be the size of the text labels." })
		p_u_1.Text({ "Some widgets, such as the Image and Button have Size arguments will will set the size of them." })
		p_u_1.Separator()
		p_u_1.SameLine()
		p_u_1.Text({ "The button takes up the full screen-width." })
		v_u_11("Iris.Button({ \"Button\", UDim2.fromScale(1, 0) })")
		p_u_1.End()
		p_u_1.Button({ "Button", UDim2.fromScale(1, 0) })
		p_u_1.SameLine()
		p_u_1.Text({ "The button takes up half the screen-width." })
		v_u_11("Iris.Button({ \"Button\", UDim2.fromScale(0.5, 0) })")
		p_u_1.End()
		p_u_1.Button({ "Button", UDim2.fromScale(0.5, 0) })
		p_u_1.SameLine()
		p_u_1.Text({ "Combining with SameLine, the buttons can fill the screen width." })
		v_u_11("The button will still be larger that the text size.")
		p_u_1.End()
		local v256 = p_u_1.State(2)
		p_u_1.SliderNum({
			"Number of Buttons",
			1,
			1,
			8
		}, {
			["number"] = v256
		})
		p_u_1.SameLine({ 0, nil, Enum.HorizontalAlignment.Center })
		for v257 = 1, v256.value do
			p_u_1.Button({ ("Button %*"):format(v257), UDim2.fromScale(1 / v256.value, 0) })
		end
		p_u_1.End()
		p_u_1.End()
		p_u_1.Tree({ "Content Width" })
		local v258 = p_u_1.State(50)
		local v259 = p_u_1.State(Enum.Axis.X)
		p_u_1.Text({ "The Content Width is a size property which determines the width of input fields." })
		p_u_1.SameLine()
		p_u_1.Text({ "By default the value is UDim.new(0.65, 0)" })
		v_u_11("This is the default value from Dear ImGui.\nIt is 65% of the window width.")
		p_u_1.End()
		p_u_1.Text({ "This works well, but sometimes we know how wide elements are going to be and want to maximise the space." })
		p_u_1.Text({ "Therefore, we can use Iris.PushConfig() to change the width" })
		p_u_1.Separator()
		p_u_1.SameLine()
		p_u_1.Text({ "Content Width = 150 pixels" })
		v_u_11("UDim.new(0, 150)")
		p_u_1.End()
		p_u_1.PushConfig({
			["ContentWidth"] = UDim.new(0, 150)
		})
		p_u_1.DragNum({
			"number",
			1,
			0,
			100
		}, {
			["number"] = v258
		})
		p_u_1.InputEnum({ "axis" }, {
			["index"] = v259
		}, Enum.Axis)
		p_u_1.PopConfig()
		p_u_1.SameLine()
		p_u_1.Text({ "Content Width = 50% window width" })
		v_u_11("UDim.new(0.5, 0)")
		p_u_1.End()
		p_u_1.PushConfig({
			["ContentWidth"] = UDim.new(0.5, 0)
		})
		p_u_1.DragNum({
			"number",
			1,
			0,
			100
		}, {
			["number"] = v258
		})
		p_u_1.InputEnum({ "axis" }, {
			["index"] = v259
		}, Enum.Axis)
		p_u_1.PopConfig()
		p_u_1.SameLine()
		p_u_1.Text({ "Content Width = -150 pixels from the right side" })
		v_u_11("UDim.new(1, -150)")
		p_u_1.End()
		p_u_1.PushConfig({
			["ContentWidth"] = UDim.new(1, -150)
		})
		p_u_1.DragNum({
			"number",
			1,
			0,
			100
		}, {
			["number"] = v258
		})
		p_u_1.InputEnum({ "axis" }, {
			["index"] = v259
		}, Enum.Axis)
		p_u_1.PopConfig()
		p_u_1.End()
		p_u_1.Tree({ "Content Height" })
		local v260 = p_u_1.State("a single line")
		local v261 = p_u_1.State(50)
		local v262 = p_u_1.State(Enum.Axis.X)
		local v263 = p_u_1.State(0)
		local v264 = os.clock() * 15 % 100 - 50
		local v265 = math.abs(v264) - 7.5
		v263:set(math.clamp(v265, 0, 35) / 35)
		p_u_1.Text({ "The Content Height is a size property that determines the minimum size of certain widgets." })
		p_u_1.Text({ "By default the value is UDim.new(0, 0), so there is no minimum height." })
		p_u_1.Text({ "We use Iris.PushConfig() to change this value." })
		p_u_1.Separator()
		p_u_1.SameLine()
		p_u_1.Text({ "Content Height = 0 pixels" })
		v_u_11("UDim.new(0, 0)")
		p_u_1.End()
		p_u_1.InputText({ "text" }, {
			["text"] = v260
		})
		p_u_1.ProgressBar({ "progress" }, {
			["progress"] = v263
		})
		p_u_1.DragNum({
			"number",
			1,
			0,
			100
		}, {
			["number"] = v261
		})
		p_u_1.ComboEnum({ "axis" }, {
			["index"] = v262
		}, Enum.Axis)
		p_u_1.SameLine()
		p_u_1.Text({ "Content Height = 60 pixels" })
		v_u_11("UDim.new(0, 60)")
		p_u_1.End()
		p_u_1.PushConfig({
			["ContentHeight"] = UDim.new(0, 60)
		})
		p_u_1.InputText({
			"text",
			nil,
			nil,
			true
		}, {
			["text"] = v260
		})
		p_u_1.ProgressBar({ "progress" }, {
			["progress"] = v263
		})
		p_u_1.DragNum({
			"number",
			1,
			0,
			100
		}, {
			["number"] = v261
		})
		p_u_1.ComboEnum({ "axis" }, {
			["index"] = v262
		}, Enum.Axis)
		p_u_1.PopConfig()
		p_u_1.Text({ "This property can be used to force the height of a text box." })
		p_u_1.Text({ "Just make sure you enable the MultiLine argument." })
		p_u_1.End()
		p_u_1.End()
	end
	local function v_u_267()
		-- upvalues: (copy) p_u_1, (copy) v_u_11
		p_u_1.PushConfig({
			["ItemWidth"] = UDim.new(0, 150)
		})
		p_u_1.SameLine()
		p_u_1.TextWrapped({ "Windowless widgets" })
		v_u_11("Widgets which are placed outside of a window will appear on the top left side of the screen.")
		p_u_1.End()
		p_u_1.Button({})
		p_u_1.Tree({})
		p_u_1.InputText({})
		p_u_1.End()
		p_u_1.PopConfig()
	end
	return function()
		-- upvalues: (copy) p_u_1, (copy) v_u_2, (copy) v_u_144, (copy) v_u_185, (copy) v_u_195, (copy) v_u_95, (copy) v_u_200, (copy) v_u_94, (copy) v_u_93, (copy) v_u_255, (copy) v_u_266, (copy) v_u_3, (copy) v_u_98, (copy) v_u_4, (copy) v_u_134, (copy) v_u_8, (copy) v_u_136, (copy) v_u_5, (ref) v_u_172, (copy) v_u_6, (copy) v_u_267, (copy) v_u_7
		local v268 = p_u_1.State(false)
		local v269 = p_u_1.State(false)
		local v270 = p_u_1.State(false)
		local v271 = p_u_1.State(true)
		local v272 = p_u_1.State(false)
		local v273 = p_u_1.State(false)
		local v274 = p_u_1.State(false)
		local v275 = p_u_1.State(false)
		local v276 = p_u_1.State(false)
		if v_u_2.value ~= false then
			debug.profilebegin("Iris/Demo/Window")
			local v277 = p_u_1.Window({
				[p_u_1.Args.Window.Title] = "Iris Demo Window",
				[p_u_1.Args.Window.NoTitleBar] = v268.value,
				[p_u_1.Args.Window.NoBackground] = v269.value,
				[p_u_1.Args.Window.NoCollapse] = v270.value,
				[p_u_1.Args.Window.NoClose] = v271.value,
				[p_u_1.Args.Window.NoMove] = v272.value,
				[p_u_1.Args.Window.NoScrollbar] = v273.value,
				[p_u_1.Args.Window.NoResize] = v274.value,
				[p_u_1.Args.Window.NoNav] = v275.value,
				[p_u_1.Args.Window.NoMenu] = v276.value
			}, {
				["size"] = p_u_1.State(Vector2.new(600, 550)),
				["position"] = p_u_1.State(Vector2.new(100, 25)),
				["isOpened"] = v_u_2
			})
			if v277.state.isUncollapsed.value and v277.state.isOpened.value then
				debug.profilebegin("Iris/Demo/MenuBar")
				v_u_144()
				debug.profileend()
				p_u_1.Text({ "Iris says hello. (" .. p_u_1.Internal._version .. ")" })
				debug.profilebegin("Iris/Demo/Options")
				p_u_1.CollapsingHeader({ "Window Options" })
				p_u_1.Table({
					3,
					false,
					false,
					false
				})
				p_u_1.Checkbox({ "NoTitleBar" }, {
					["isChecked"] = v268
				})
				p_u_1.NextColumn()
				p_u_1.Checkbox({ "NoBackground" }, {
					["isChecked"] = v269
				})
				p_u_1.NextColumn()
				p_u_1.Checkbox({ "NoCollapse" }, {
					["isChecked"] = v270
				})
				p_u_1.NextColumn()
				p_u_1.Checkbox({ "NoClose" }, {
					["isChecked"] = v271
				})
				p_u_1.NextColumn()
				p_u_1.Checkbox({ "NoMove" }, {
					["isChecked"] = v272
				})
				p_u_1.NextColumn()
				p_u_1.Checkbox({ "NoScrollbar" }, {
					["isChecked"] = v273
				})
				p_u_1.NextColumn()
				p_u_1.Checkbox({ "NoResize" }, {
					["isChecked"] = v274
				})
				p_u_1.NextColumn()
				p_u_1.Checkbox({ "NoNav" }, {
					["isChecked"] = v275
				})
				p_u_1.NextColumn()
				p_u_1.Checkbox({ "NoMenu" }, {
					["isChecked"] = v276
				})
				p_u_1.NextColumn()
				p_u_1.End()
				p_u_1.End()
				debug.profileend()
				debug.profilebegin("Iris/Demo/Events")
				v_u_185()
				debug.profileend()
				debug.profilebegin("Iris/Demo/States")
				v_u_195()
				debug.profileend()
				debug.profilebegin("Iris/Demo/Recursive")
				p_u_1.CollapsingHeader({ "Recursive Tree" })
				if p_u_1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
					v_u_95()
				end
				p_u_1.End()
				p_u_1.End()
				debug.profileend()
				debug.profilebegin("Iris/Demo/Style")
				v_u_200()
				debug.profileend()
				p_u_1.Separator()
				debug.profilebegin("Iris/Demo/Widgets")
				p_u_1.CollapsingHeader({ "Widgets" })
				for _, v278 in v_u_94 do
					debug.profilebegin((("Iris/Demo/Widgets/%*"):format(v278)))
					v_u_93[v278]()
					debug.profileend()
				end
				p_u_1.End()
				debug.profileend()
				debug.profilebegin("Iris/Demo/Tables")
				v_u_255()
				debug.profileend()
				debug.profilebegin("Iris/Demo/Layout")
				v_u_266()
				debug.profileend()
			end
			p_u_1.End()
			debug.profileend()
			if v_u_3.value then
				v_u_98(v_u_3)
			end
			if v_u_4.value then
				v_u_134()
			end
			if v_u_8.value then
				v_u_136()
			end
			if v_u_5.value then
				v_u_172()
			end
			if v_u_6.value then
				v_u_267()
			end
			if v_u_7.value then
				v_u_144()
			end
			return v277
		end
		local v279 = {
			["isChecked"] = v_u_2
		}
		p_u_1.Checkbox({ "Open main window" }, v279)
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[demoWindow]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3455"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Types)
local v_u_1 = {}
return function(p_u_2)
	-- upvalues: (copy) v_u_1
	v_u_1.GuiService = game:GetService("GuiService")
	v_u_1.RunService = game:GetService("RunService")
	v_u_1.UserInputService = game:GetService("UserInputService")
	v_u_1.ContextActionService = game:GetService("ContextActionService")
	v_u_1.TextService = game:GetService("TextService")
	v_u_1.ICONS = {
		["BLANK_SQUARE"] = "rbxasset://textures/SurfacesDefault.png",
		["RIGHT_POINTING_TRIANGLE"] = "rbxasset://textures/DeveloperFramework/button_arrow_right.png",
		["DOWN_POINTING_TRIANGLE"] = "rbxasset://textures/DeveloperFramework/button_arrow_down.png",
		["MULTIPLICATION_SIGN"] = "rbxasset://textures/AnimationEditor/icon_close.png",
		["BOTTOM_RIGHT_CORNER"] = "rbxasset://textures/ui/InspectMenu/gr-item-selector-triangle.png",
		["CHECK_MARK"] = "rbxasset://textures/AnimationEditor/icon_checkmark.png",
		["BORDER"] = "rbxasset://textures/ui/InspectMenu/gr-item-selector.png",
		["ALPHA_BACKGROUND_TEXTURE"] = "rbxasset://textures/meshPartFallback.png",
		["UNKNOWN_TEXTURE"] = "rbxasset://textures/ui/GuiImagePlaceholder.png"
	}
	v_u_1.IS_STUDIO = v_u_1.RunService:IsStudio()
	function v_u_1.getTime()
		-- upvalues: (ref) v_u_1
		if v_u_1.IS_STUDIO then
			return os.clock()
		else
			return time()
		end
	end
	local v3 = v_u_1
	local v4
	if p_u_2._config.IgnoreGuiInset then
		v4 = -v_u_1.GuiService:GetGuiInset()
	else
		v4 = Vector2.zero
	end
	v3.GuiOffset = v4
	local v5 = v_u_1
	local v6
	if p_u_2._config.IgnoreGuiInset then
		v6 = Vector2.zero
	else
		v6 = v_u_1.GuiService:GetGuiInset()
	end
	v5.MouseOffset = v6
	local v_u_7 = nil
	v_u_7 = v_u_1.GuiService:GetPropertyChangedSignal("TopbarInset"):Once(function()
		-- upvalues: (ref) v_u_1, (copy) p_u_2, (ref) v_u_7
		local v8 = v_u_1
		local v9
		if p_u_2._config.IgnoreGuiInset then
			v9 = Vector2.zero
		else
			v9 = v_u_1.GuiService:GetGuiInset()
		end
		v8.MouseOffset = v9
		local v10 = v_u_1
		local v11
		if p_u_2._config.IgnoreGuiInset then
			v11 = -v_u_1.GuiService:GetGuiInset()
		else
			v11 = Vector2.zero
		end
		v10.GuiOffset = v11
		v_u_7:Disconnect()
	end)
	task.delay(5, function()
		-- upvalues: (ref) v_u_7
		v_u_7:Disconnect()
	end)
	function v_u_1.getMouseLocation()
		-- upvalues: (ref) v_u_1
		return v_u_1.UserInputService:GetMouseLocation() - v_u_1.MouseOffset
	end
	function v_u_1.isPosInsideRect(p12, p13, p14)
		local v15
		if p12.X >= p13.X and (p12.X <= p14.X and p12.Y >= p13.Y) then
			v15 = p12.Y <= p14.Y
		else
			v15 = false
		end
		return v15
	end
	function v_u_1.findBestWindowPosForPopup(p16, p17, p18, p19)
		local v20
		if p16.X + p17.X + 20 > p19.X then
			if p16.Y + p17.Y + 20 > p19.Y then
				v20 = p16 + Vector2.new(0, -(20 + p17.Y))
			else
				v20 = p16 + Vector2.new(0, 20)
			end
		else
			v20 = p16 + Vector2.new(20)
		end
		local v21 = Vector2.new
		local v22 = v20.X + p17.X
		local v23 = p19.X
		local v24 = math.min(v22, v23) - p17.X
		local v25 = p18.X
		local v26 = math.max(v24, v25)
		local v27 = v20.Y + p17.Y
		local v28 = p19.Y
		local v29 = math.min(v27, v28) - p17.Y
		local v30 = p18.Y
		return v21(v26, (math.max(v29, v30)))
	end
	function v_u_1.getScreenSizeForWindow(p31)
		if p31.Instance:IsA("GuiBase2d") then
			return p31.Instance.AbsoluteSize
		else
			local v32 = p31.Instance.Parent
			if v32:IsA("GuiBase2d") then
				return v32.AbsoluteSize
			elseif v32.Parent:IsA("GuiBase2d") then
				return v32.AbsoluteSize
			else
				return workspace.CurrentCamera.ViewportSize
			end
		end
	end
	function v_u_1.extend(p33, p34)
		local v35 = table.clone(p33)
		for v36, v37 in p34 do
			v35[v36] = v37
		end
		return v35
	end
	function v_u_1.UIPadding(p38, p39)
		local v40 = Instance.new("UIPadding")
		v40.PaddingLeft = UDim.new(0, p39.X)
		v40.PaddingRight = UDim.new(0, p39.X)
		v40.PaddingTop = UDim.new(0, p39.Y)
		v40.PaddingBottom = UDim.new(0, p39.Y)
		v40.Parent = p38
		return v40
	end
	function v_u_1.UIListLayout(p41, p42, p43)
		local v44 = Instance.new("UIListLayout")
		v44.SortOrder = Enum.SortOrder.LayoutOrder
		v44.Padding = p43
		v44.FillDirection = p42
		v44.Parent = p41
		return v44
	end
	function v_u_1.UIStroke(p45, p46, p47, p48)
		local v49 = Instance.new("UIStroke")
		v49.Thickness = p46
		v49.Color = p47
		v49.Transparency = p48
		v49.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		v49.LineJoinMode = Enum.LineJoinMode.Round
		v49.Parent = p45
		return v49
	end
	function v_u_1.UICorner(p50, p51)
		local v52 = Instance.new("UICorner")
		v52.CornerRadius = UDim.new(p51 and 0 or 1, p51 or 0)
		v52.Parent = p50
		return v52
	end
	function v_u_1.UISizeConstraint(p53, p54, p55)
		local v56 = Instance.new("UISizeConstraint")
		v56.MinSize = p54 or v56.MinSize
		v56.MaxSize = p55 or v56.MaxSize
		v56.Parent = p53
		return v56
	end
	function v_u_1.applyTextStyle(p57)
		-- upvalues: (copy) p_u_2
		p57.FontFace = p_u_2._config.TextFont
		p57.TextSize = p_u_2._config.TextSize
		p57.TextColor3 = p_u_2._config.TextColor
		p57.TextTransparency = p_u_2._config.TextTransparency
		p57.TextXAlignment = Enum.TextXAlignment.Left
		p57.TextYAlignment = Enum.TextYAlignment.Center
		p57.RichText = p_u_2._config.RichText
		p57.TextWrapped = p_u_2._config.TextWrapped
		p57.AutoLocalize = false
	end
	function v_u_1.applyInteractionHighlights(p_u_58, p59, p_u_60, p_u_61)
		-- upvalues: (ref) v_u_1, (copy) p_u_2
		local v_u_62 = false
		v_u_1.applyMouseEnter(p59, function()
			-- upvalues: (copy) p_u_60, (copy) p_u_58, (copy) p_u_61, (ref) v_u_62
			p_u_60[p_u_58 .. "Color3"] = p_u_61.HoveredColor
			p_u_60[p_u_58 .. "Transparency"] = p_u_61.HoveredTransparency
			v_u_62 = false
		end)
		v_u_1.applyMouseLeave(p59, function()
			-- upvalues: (copy) p_u_60, (copy) p_u_58, (copy) p_u_61, (ref) v_u_62
			p_u_60[p_u_58 .. "Color3"] = p_u_61.Color
			p_u_60[p_u_58 .. "Transparency"] = p_u_61.Transparency
			v_u_62 = true
		end)
		v_u_1.applyInputBegan(p59, function(p63)
			-- upvalues: (copy) p_u_60, (copy) p_u_58, (copy) p_u_61
			if p63.UserInputType == Enum.UserInputType.MouseButton1 or p63.UserInputType == Enum.UserInputType.Gamepad1 then
				p_u_60[p_u_58 .. "Color3"] = p_u_61.ActiveColor
				p_u_60[p_u_58 .. "Transparency"] = p_u_61.ActiveTransparency
			end
		end)
		v_u_1.applyInputEnded(p59, function(p64)
			-- upvalues: (ref) v_u_62, (copy) p_u_60, (copy) p_u_58, (copy) p_u_61
			if (p64.UserInputType == Enum.UserInputType.MouseButton1 or p64.UserInputType == Enum.UserInputType.Gamepad1) and not v_u_62 then
				if p64.UserInputType == Enum.UserInputType.MouseButton1 then
					p_u_60[p_u_58 .. "Color3"] = p_u_61.HoveredColor
					p_u_60[p_u_58 .. "Transparency"] = p_u_61.HoveredTransparency
				end
				if p64.UserInputType == Enum.UserInputType.Gamepad1 then
					p_u_60[p_u_58 .. "Color3"] = p_u_61.Color
					p_u_60[p_u_58 .. "Transparency"] = p_u_61.Transparency
				end
			end
		end)
		p59.SelectionImageObject = p_u_2.SelectionImageObject
	end
	function v_u_1.applyInteractionHighlightsWithMultiHighlightee(p_u_65, p66, p_u_67)
		-- upvalues: (ref) v_u_1, (copy) p_u_2
		local v_u_68 = false
		v_u_1.applyMouseEnter(p66, function()
			-- upvalues: (copy) p_u_67, (copy) p_u_65, (ref) v_u_68
			for _, v69 in p_u_67 do
				v69[1][p_u_65 .. "Color3"] = v69[2].HoveredColor
				v69[1][p_u_65 .. "Transparency"] = v69[2].HoveredTransparency
				v_u_68 = false
			end
		end)
		v_u_1.applyMouseLeave(p66, function()
			-- upvalues: (copy) p_u_67, (copy) p_u_65, (ref) v_u_68
			for _, v70 in p_u_67 do
				v70[1][p_u_65 .. "Color3"] = v70[2].Color
				v70[1][p_u_65 .. "Transparency"] = v70[2].Transparency
				v_u_68 = true
			end
		end)
		v_u_1.applyInputBegan(p66, function(p71)
			-- upvalues: (copy) p_u_67, (copy) p_u_65
			if p71.UserInputType == Enum.UserInputType.MouseButton1 or p71.UserInputType == Enum.UserInputType.Gamepad1 then
				for _, v72 in p_u_67 do
					v72[1][p_u_65 .. "Color3"] = v72[2].ActiveColor
					v72[1][p_u_65 .. "Transparency"] = v72[2].ActiveTransparency
				end
			end
		end)
		v_u_1.applyInputEnded(p66, function(p73)
			-- upvalues: (ref) v_u_68, (copy) p_u_67, (copy) p_u_65
			if (p73.UserInputType == Enum.UserInputType.MouseButton1 or p73.UserInputType == Enum.UserInputType.Gamepad1) and not v_u_68 then
				for _, v74 in p_u_67 do
					if p73.UserInputType == Enum.UserInputType.MouseButton1 then
						v74[1][p_u_65 .. "Color3"] = v74[2].HoveredColor
						v74[1][p_u_65 .. "Transparency"] = v74[2].HoveredTransparency
					end
					if p73.UserInputType == Enum.UserInputType.Gamepad1 then
						v74[1][p_u_65 .. "Color3"] = v74[2].Color
						v74[1][p_u_65 .. "Transparency"] = v74[2].Transparency
					end
				end
			end
		end)
		p66.SelectionImageObject = p_u_2.SelectionImageObject
	end
	function v_u_1.applyFrameStyle(p75, p76, p77)
		-- upvalues: (copy) p_u_2, (ref) v_u_1
		local v78 = p_u_2._config.FrameBorderSize
		local v79 = p_u_2._config.FrameRounding
		p75.BorderSizePixel = 0
		if v78 > 0 then
			v_u_1.UIStroke(p75, v78, p_u_2._config.BorderColor, p_u_2._config.BorderTransparency)
		end
		if v79 > 0 and not p77 then
			v_u_1.UICorner(p75, v79)
		end
		if not p76 then
			v_u_1.UIPadding(p75, p_u_2._config.FramePadding)
		end
	end
	function v_u_1.applyButtonClick(p80, p_u_81)
		p80.MouseButton1Click:Connect(function()
			-- upvalues: (copy) p_u_81
			p_u_81()
		end)
	end
	function v_u_1.applyButtonDown(p82, p_u_83)
		-- upvalues: (ref) v_u_1
		p82.MouseButton1Down:Connect(function(p84, p85)
			-- upvalues: (ref) v_u_1, (copy) p_u_83
			local v86 = Vector2.new(p84, p85) - v_u_1.MouseOffset
			p_u_83(v86.X, v86.Y)
		end)
	end
	function v_u_1.applyMouseEnter(p87, p_u_88)
		-- upvalues: (ref) v_u_1
		p87.MouseEnter:Connect(function(p89, p90)
			-- upvalues: (ref) v_u_1, (copy) p_u_88
			local v91 = Vector2.new(p89, p90) - v_u_1.MouseOffset
			p_u_88(v91.X, v91.Y)
		end)
	end
	function v_u_1.applyMouseMoved(p92, p_u_93)
		-- upvalues: (ref) v_u_1
		p92.MouseMoved:Connect(function(p94, p95)
			-- upvalues: (ref) v_u_1, (copy) p_u_93
			local v96 = Vector2.new(p94, p95) - v_u_1.MouseOffset
			p_u_93(v96.X, v96.Y)
		end)
	end
	function v_u_1.applyMouseLeave(p97, p_u_98)
		-- upvalues: (ref) v_u_1
		p97.MouseLeave:Connect(function(p99, p100)
			-- upvalues: (ref) v_u_1, (copy) p_u_98
			local v101 = Vector2.new(p99, p100) - v_u_1.MouseOffset
			p_u_98(v101.X, v101.Y)
		end)
	end
	function v_u_1.applyInputBegan(p102, p_u_103)
		p102.InputBegan:Connect(function(...)
			-- upvalues: (copy) p_u_103
			p_u_103(...)
		end)
	end
	function v_u_1.applyInputEnded(p104, p_u_105)
		p104.InputEnded:Connect(function(...)
			-- upvalues: (copy) p_u_105
			p_u_105(...)
		end)
	end
	function v_u_1.discardState(p106)
		for _, v107 in p106.state do
			v107.ConnectedWidgets[p106.ID] = nil
		end
	end
	function v_u_1.registerEvent(p_u_108, p_u_109)
		-- upvalues: (copy) p_u_2, (ref) v_u_1
		local v110 = p_u_2._initFunctions
		local function v114()
			-- upvalues: (ref) p_u_2, (ref) v_u_1, (copy) p_u_108, (copy) p_u_109
			local v111 = p_u_2._connections
			local v112 = v_u_1.UserInputService[p_u_108]
			local v113 = p_u_109
			table.insert(v111, v112:Connect(v113))
		end
		table.insert(v110, v114)
	end
	v_u_1.EVENTS = {
		["hover"] = function(p_u_115)
			-- upvalues: (ref) v_u_1
			return {
				["Init"] = function(p_u_116)
					-- upvalues: (copy) p_u_115, (ref) v_u_1
					local v117 = p_u_115(p_u_116)
					v_u_1.applyMouseEnter(v117, function()
						-- upvalues: (copy) p_u_116
						p_u_116.isHoveredEvent = true
					end)
					v_u_1.applyMouseLeave(v117, function()
						-- upvalues: (copy) p_u_116
						p_u_116.isHoveredEvent = false
					end)
					p_u_116.isHoveredEvent = false
				end,
				["Get"] = function(p118)
					return p118.isHoveredEvent
				end
			}
		end,
		["click"] = function(p_u_119)
			-- upvalues: (ref) v_u_1, (copy) p_u_2
			return {
				["Init"] = function(p_u_120)
					-- upvalues: (copy) p_u_119, (ref) v_u_1, (ref) p_u_2
					local v121 = p_u_119(p_u_120)
					p_u_120.lastClickedTick = -1
					v_u_1.applyButtonClick(v121, function()
						-- upvalues: (copy) p_u_120, (ref) p_u_2
						p_u_120.lastClickedTick = p_u_2._cycleTick + 1
					end)
				end,
				["Get"] = function(p122)
					-- upvalues: (ref) p_u_2
					return p122.lastClickedTick == p_u_2._cycleTick
				end
			}
		end,
		["rightClick"] = function(p_u_123)
			-- upvalues: (copy) p_u_2
			return {
				["Init"] = function(p_u_124)
					-- upvalues: (copy) p_u_123, (ref) p_u_2
					local v125 = p_u_123(p_u_124)
					p_u_124.lastRightClickedTick = -1
					v125.MouseButton2Click:Connect(function()
						-- upvalues: (copy) p_u_124, (ref) p_u_2
						p_u_124.lastRightClickedTick = p_u_2._cycleTick + 1
					end)
				end,
				["Get"] = function(p126)
					-- upvalues: (ref) p_u_2
					return p126.lastRightClickedTick == p_u_2._cycleTick
				end
			}
		end,
		["doubleClick"] = function(p_u_127)
			-- upvalues: (ref) v_u_1, (copy) p_u_2
			return {
				["Init"] = function(p_u_128)
					-- upvalues: (copy) p_u_127, (ref) v_u_1, (ref) p_u_2
					local v129 = p_u_127(p_u_128)
					p_u_128.lastClickedTime = -1
					p_u_128.lastClickedPosition = Vector2.zero
					p_u_128.lastDoubleClickedTick = -1
					v_u_1.applyButtonDown(v129, function(p130, p131)
						-- upvalues: (ref) v_u_1, (copy) p_u_128, (ref) p_u_2
						local v132 = v_u_1.getTime()
						if v132 - p_u_128.lastClickedTime < p_u_2._config.MouseDoubleClickTime and (Vector2.new(p130, p131) - p_u_128.lastClickedPosition).Magnitude < p_u_2._config.MouseDoubleClickMaxDist then
							p_u_128.lastDoubleClickedTick = p_u_2._cycleTick + 1
						else
							p_u_128.lastClickedTime = v132
							p_u_128.lastClickedPosition = Vector2.new(p130, p131)
						end
					end)
				end,
				["Get"] = function(p133)
					-- upvalues: (ref) p_u_2
					return p133.lastDoubleClickedTick == p_u_2._cycleTick
				end
			}
		end,
		["ctrlClick"] = function(p_u_134)
			-- upvalues: (ref) v_u_1, (copy) p_u_2
			return {
				["Init"] = function(p_u_135)
					-- upvalues: (copy) p_u_134, (ref) v_u_1, (ref) p_u_2
					local v136 = p_u_134(p_u_135)
					p_u_135.lastCtrlClickedTick = -1
					v_u_1.applyButtonClick(v136, function()
						-- upvalues: (ref) v_u_1, (copy) p_u_135, (ref) p_u_2
						if v_u_1.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or v_u_1.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
							p_u_135.lastCtrlClickedTick = p_u_2._cycleTick + 1
						end
					end)
				end,
				["Get"] = function(p137)
					-- upvalues: (ref) p_u_2
					return p137.lastCtrlClickedTick == p_u_2._cycleTick
				end
			}
		end
	}
	p_u_2._utility = v_u_1
	require(script.Root)(p_u_2, v_u_1)
	require(script.Window)(p_u_2, v_u_1)
	require(script.Menu)(p_u_2, v_u_1)
	require(script.Format)(p_u_2, v_u_1)
	require(script.Text)(p_u_2, v_u_1)
	require(script.Button)(p_u_2, v_u_1)
	require(script.Checkbox)(p_u_2, v_u_1)
	require(script.RadioButton)(p_u_2, v_u_1)
	require(script.Image)(p_u_2, v_u_1)
	require(script.Tree)(p_u_2, v_u_1)
	require(script.Tab)(p_u_2, v_u_1)
	require(script.Input)(p_u_2, v_u_1)
	require(script.Combo)(p_u_2, v_u_1)
	require(script.Plot)(p_u_2, v_u_1)
	require(script.Table)(p_u_2, v_u_1)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[widgets]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3456"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p_u_1, p_u_2)
	local v_u_13 = {
		["hasState"] = false,
		["hasChildren"] = false,
		["Args"] = {
			["Text"] = 1,
			["Size"] = 2
		},
		["Events"] = {
			["clicked"] = p_u_2.EVENTS.click(function(p3)
				return p3.Instance
			end),
			["rightClicked"] = p_u_2.EVENTS.rightClick(function(p4)
				return p4.Instance
			end),
			["doubleClicked"] = p_u_2.EVENTS.doubleClick(function(p5)
				return p5.Instance
			end),
			["ctrlClicked"] = p_u_2.EVENTS.ctrlClick(function(p6)
				return p6.Instance
			end),
			["hovered"] = p_u_2.EVENTS.hover(function(p7)
				return p7.Instance
			end)
		},
		["Generate"] = function(p8)
			-- upvalues: (copy) p_u_1, (copy) p_u_2
			local v9 = Instance.new("TextButton")
			v9.Size = UDim2.fromOffset(0, 0)
			v9.BackgroundColor3 = p_u_1._config.ButtonColor
			v9.BackgroundTransparency = p_u_1._config.ButtonTransparency
			v9.AutoButtonColor = false
			v9.AutomaticSize = Enum.AutomaticSize.XY
			p_u_2.applyTextStyle(v9)
			v9.TextXAlignment = Enum.TextXAlignment.Center
			p_u_2.applyFrameStyle(v9)
			p_u_2.applyInteractionHighlights("Background", v9, v9, {
				["Color"] = p_u_1._config.ButtonColor,
				["Transparency"] = p_u_1._config.ButtonTransparency,
				["HoveredColor"] = p_u_1._config.ButtonHoveredColor,
				["HoveredTransparency"] = p_u_1._config.ButtonHoveredTransparency,
				["ActiveColor"] = p_u_1._config.ButtonActiveColor,
				["ActiveTransparency"] = p_u_1._config.ButtonActiveTransparency
			})
			v9.ZIndex = p8.ZIndex
			v9.LayoutOrder = p8.ZIndex
			return v9
		end,
		["Update"] = function(p10)
			local v11 = p10.Instance
			v11.Text = p10.arguments.Text or "Button"
			v11.Size = p10.arguments.Size or UDim2.fromOffset(0, 0)
		end,
		["Discard"] = function(p12)
			p12.Instance:Destroy()
		end
	}
	p_u_2.abstractButton = v_u_13
	p_u_1.WidgetConstructor("Button", p_u_2.extend(v_u_13, {
		["Generate"] = function(p14)
			-- upvalues: (copy) v_u_13
			local v15 = v_u_13.Generate(p14)
			v15.Name = "Iris_Button"
			return v15
		end
	}))
	p_u_1.WidgetConstructor("SmallButton", p_u_2.extend(v_u_13, {
		["Generate"] = function(p16)
			-- upvalues: (copy) v_u_13
			local v17 = v_u_13.Generate(p16)
			v17.Name = "Iris_SmallButton"
			local v18 = v17.UIPadding
			v18.PaddingLeft = UDim.new(0, 2)
			v18.PaddingRight = UDim.new(0, 2)
			v18.PaddingTop = UDim.new(0, 0)
			v18.PaddingBottom = UDim.new(0, 0)
			return v17
		end
	}))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Button]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3457"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p_u_1, p_u_2)
	local v3 = p_u_1.WidgetConstructor
	local v4 = {
		["hasState"] = true,
		["hasChildren"] = false,
		["Args"] = {
			["Text"] = 1
		}
	}
	local v8 = {
		["checked"] = {
			["Init"] = function(_) end,
			["Get"] = function(p5)
				-- upvalues: (copy) p_u_1
				return p5.lastCheckedTick == p_u_1._cycleTick
			end
		},
		["unchecked"] = {
			["Init"] = function(_) end,
			["Get"] = function(p6)
				-- upvalues: (copy) p_u_1
				return p6.lastUncheckedTick == p_u_1._cycleTick
			end
		},
		["hovered"] = p_u_2.EVENTS.hover(function(p7)
			return p7.Instance
		end)
	}
	v4.Events = v8
	function v4.Generate(p_u_9)
		-- upvalues: (copy) p_u_2, (copy) p_u_1
		local v10 = Instance.new("TextButton")
		v10.Name = "Iris_Checkbox"
		v10.AutomaticSize = Enum.AutomaticSize.XY
		v10.Size = UDim2.fromOffset(0, 0)
		v10.BackgroundTransparency = 1
		v10.BorderSizePixel = 0
		v10.Text = ""
		v10.AutoButtonColor = false
		v10.ZIndex = p_u_9.ZIndex
		v10.LayoutOrder = p_u_9.ZIndex
		p_u_2.UIListLayout(v10, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
		local v11 = p_u_1._config.TextSize + 2 * p_u_1._config.FramePadding.Y
		local v12 = Instance.new("Frame")
		v12.Name = "Box"
		v12.Size = UDim2.fromOffset(v11, v11)
		v12.BackgroundColor3 = p_u_1._config.FrameBgColor
		v12.BackgroundTransparency = p_u_1._config.FrameBgTransparency
		p_u_2.applyFrameStyle(v12, true)
		local v13 = p_u_2.UIPadding
		local v14 = Vector2.new
		local v15 = v11 / 10
		local v16 = math.floor(v15)
		local v17 = v11 / 10
		v13(v12, v14(v16, (math.floor(v17))))
		p_u_2.applyInteractionHighlights("Background", v10, v12, {
			["Color"] = p_u_1._config.FrameBgColor,
			["Transparency"] = p_u_1._config.FrameBgTransparency,
			["HoveredColor"] = p_u_1._config.FrameBgHoveredColor,
			["HoveredTransparency"] = p_u_1._config.FrameBgHoveredTransparency,
			["ActiveColor"] = p_u_1._config.FrameBgActiveColor,
			["ActiveTransparency"] = p_u_1._config.FrameBgActiveTransparency
		})
		v12.Parent = v10
		local v18 = Instance.new("ImageLabel")
		v18.Name = "Checkmark"
		v18.Size = UDim2.fromScale(1, 1)
		v18.BackgroundTransparency = 1
		v18.ImageColor3 = p_u_1._config.CheckMarkColor
		v18.ImageTransparency = p_u_1._config.CheckMarkTransparency
		v18.ScaleType = Enum.ScaleType.Fit
		v18.Parent = v12
		p_u_2.applyButtonClick(v10, function()
			-- upvalues: (copy) p_u_9
			local v19 = p_u_9.state.isChecked.value
			p_u_9.state.isChecked:set(not v19)
		end)
		local v20 = Instance.new("TextLabel")
		v20.Name = "TextLabel"
		v20.AutomaticSize = Enum.AutomaticSize.XY
		v20.BackgroundTransparency = 1
		v20.BorderSizePixel = 0
		v20.LayoutOrder = 1
		p_u_2.applyTextStyle(v20)
		v20.Parent = v10
		return v10
	end
	function v4.Update(p21)
		p21.Instance.TextLabel.Text = p21.arguments.Text or "Checkbox"
	end
	function v4.Discard(p22)
		-- upvalues: (copy) p_u_2
		p22.Instance:Destroy()
		p_u_2.discardState(p22)
	end
	function v4.GenerateState(p23)
		-- upvalues: (copy) p_u_1
		if p23.state.isChecked == nil then
			p23.state.isChecked = p_u_1._widgetState(p23, "checked", false)
		end
	end
	function v4.UpdateState(p24)
		-- upvalues: (copy) p_u_2, (copy) p_u_1
		local v25 = p24.Instance.Box.Checkmark
		if p24.state.isChecked.value then
			v25.Image = p_u_2.ICONS.CHECK_MARK
			p24.lastCheckedTick = p_u_1._cycleTick + 1
		else
			v25.Image = ""
			p24.lastUncheckedTick = p_u_1._cycleTick + 1
		end
	end
	v3("Checkbox", v4)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Checkbox]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3458"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p_u_1, p_u_2)
	local v3 = p_u_1.WidgetConstructor
	local v4 = {
		["hasState"] = true,
		["hasChildren"] = false,
		["Args"] = {
			["Text"] = 1,
			["Index"] = 2,
			["NoClick"] = 3
		}
	}
	local v13 = {
		["selected"] = {
			["Init"] = function(_) end,
			["Get"] = function(p5)
				-- upvalues: (copy) p_u_1
				return p5.lastSelectedTick == p_u_1._cycleTick
			end
		},
		["unselected"] = {
			["Init"] = function(_) end,
			["Get"] = function(p6)
				-- upvalues: (copy) p_u_1
				return p6.lastUnselectedTick == p_u_1._cycleTick
			end
		},
		["active"] = {
			["Init"] = function(_) end,
			["Get"] = function(p7)
				return p7.state.index.value == p7.arguments.Index
			end
		},
		["clicked"] = p_u_2.EVENTS.click(function(p8)
			return p8.Instance.SelectableButton
		end),
		["rightClicked"] = p_u_2.EVENTS.rightClick(function(p9)
			return p9.Instance.SelectableButton
		end),
		["doubleClicked"] = p_u_2.EVENTS.doubleClick(function(p10)
			return p10.Instance.SelectableButton
		end),
		["ctrlClicked"] = p_u_2.EVENTS.ctrlClick(function(p11)
			return p11.Instance.SelectableButton
		end),
		["hovered"] = p_u_2.EVENTS.hover(function(p12)
			return p12.Instance.SelectableButton
		end)
	}
	v4.Events = v13
	function v4.Generate(p_u_14)
		-- upvalues: (copy) p_u_1, (copy) p_u_2
		local v15 = Instance.new("Frame")
		v15.Name = "Iris_Selectable"
		v15.Size = UDim2.new(p_u_1._config.ItemWidth, UDim.new(0, p_u_1._config.TextSize + 2 * p_u_1._config.FramePadding.Y - p_u_1._config.ItemSpacing.Y))
		v15.BackgroundTransparency = 1
		v15.BorderSizePixel = 0
		v15.ZIndex = 0
		v15.LayoutOrder = p_u_14.ZIndex
		local v16 = Instance.new("TextButton")
		v16.Name = "SelectableButton"
		v16.Size = UDim2.new(1, 0, 0, p_u_1._config.TextSize + 2 * p_u_1._config.FramePadding.Y)
		local v17 = UDim2.fromOffset
		local v18 = p_u_1._config.ItemSpacing.Y
		v16.Position = v17(0, -bit32.rshift(v18, 1))
		v16.BackgroundColor3 = p_u_1._config.HeaderColor
		v16.ClipsDescendants = true
		p_u_2.applyFrameStyle(v16)
		p_u_2.applyTextStyle(v16)
		p_u_2.UISizeConstraint(v16, Vector2.xAxis)
		p_u_14.ButtonColors = {
			["Color"] = p_u_1._config.HeaderColor,
			["Transparency"] = 1,
			["HoveredColor"] = p_u_1._config.HeaderHoveredColor,
			["HoveredTransparency"] = p_u_1._config.HeaderHoveredTransparency,
			["ActiveColor"] = p_u_1._config.HeaderActiveColor,
			["ActiveTransparency"] = p_u_1._config.HeaderActiveTransparency
		}
		p_u_2.applyInteractionHighlights("Background", v16, v16, p_u_14.ButtonColors)
		p_u_2.applyButtonClick(v16, function()
			-- upvalues: (copy) p_u_14
			if p_u_14.arguments.NoClick ~= true then
				local v19 = p_u_14.state.index.value
				if type(v19) == "boolean" then
					p_u_14.state.index:set(not p_u_14.state.index.value)
					return
				end
				p_u_14.state.index:set(p_u_14.arguments.Index)
			end
		end)
		v16.Parent = v15
		return v15
	end
	function v4.Update(p20)
		p20.Instance.SelectableButton.Text = p20.arguments.Text or "Selectable"
	end
	function v4.Discard(p21)
		-- upvalues: (copy) p_u_2
		p21.Instance:Destroy()
		p_u_2.discardState(p21)
	end
	function v4.GenerateState(p22)
		-- upvalues: (copy) p_u_1
		if p22.state.index == nil then
			if p22.arguments.Index ~= nil then
				error("A shared state index is required for Iris.Selectables() with an Index argument.", 5)
			end
			p22.state.index = p_u_1._widgetState(p22, "index", false)
		end
	end
	function v4.UpdateState(p23)
		-- upvalues: (copy) p_u_1
		local v24 = p23.Instance.SelectableButton
		if p23.state.index.value == (p23.arguments.Index or true) then
			p23.ButtonColors.Transparency = p_u_1._config.HeaderTransparency
			v24.BackgroundTransparency = p_u_1._config.HeaderTransparency
			p23.lastSelectedTick = p_u_1._cycleTick + 1
		else
			p23.ButtonColors.Transparency = 1
			v24.BackgroundTransparency = 1
			p23.lastUnselectedTick = p_u_1._cycleTick + 1
		end
	end
	v3("Selectable", v4)
	local v_u_25 = false
	local v_u_26 = -1
	local v_u_27 = nil
	local v_u_28 = 0
	local function v_u_43(p29)
		-- upvalues: (copy) p_u_2, (copy) p_u_1, (ref) v_u_28
		local v30 = p29.Instance.PreviewContainer
		local v31 = p29.ChildContainer
		local v32 = v30.AbsolutePosition - p_u_2.GuiOffset
		local v33 = v30.AbsoluteSize
		local v34 = p_u_1._config.PopupBorderSize
		local v35 = v31.Parent.AbsoluteSize
		local v36 = p29.UIListLayout.AbsoluteContentSize.Y
		v_u_28 = v36
		local v37 = v36 + 2 * p_u_1._config.WindowPadding.Y
		local v38 = v32.X
		local v39 = v32.Y + v33.Y + v34
		local v40 = Vector2.zero
		local v41 = v35.Y - v39
		if v41 < v37 and v35.Y / 2 < v39 then
			v39 = v32.Y - v34
			v40 = Vector2.yAxis
			v41 = v39
		end
		v31.AnchorPoint = v40
		v31.Position = UDim2.fromOffset(v38, v39)
		local v42 = math.min(v37, v41)
		v31.Size = UDim2.fromOffset(v30.AbsoluteSize.X, v42)
	end
	local v44 = p_u_1._postCycleCallbacks
	local function v45()
		-- upvalues: (ref) v_u_25, (ref) v_u_27, (ref) v_u_28, (copy) v_u_43
		if v_u_25 and (v_u_27 and v_u_27.UIListLayout.AbsoluteContentSize.Y ~= v_u_28) then
			v_u_43(v_u_27)
		end
	end
	table.insert(v44, v45)
	local function v54(p46)
		-- upvalues: (copy) p_u_1, (ref) v_u_25, (ref) v_u_27, (ref) v_u_26, (copy) p_u_2
		if p_u_1._started then
			if p46.UserInputType == Enum.UserInputType.MouseButton1 or (p46.UserInputType == Enum.UserInputType.MouseButton2 or (p46.UserInputType == Enum.UserInputType.Touch or p46.UserInputType == Enum.UserInputType.MouseWheel)) then
				if v_u_25 == false or not v_u_27 then
					return
				elseif v_u_26 == p_u_1._cycleTick then
					return
				else
					local v47 = p_u_2.getMouseLocation()
					local v48 = v_u_27.Instance.PreviewContainer
					local v49 = v_u_27.ChildContainer
					local v50 = v48.AbsolutePosition - p_u_2.GuiOffset
					local v51 = v48.AbsolutePosition - p_u_2.GuiOffset + v48.AbsoluteSize
					if p_u_2.isPosInsideRect(v47, v50, v51) then
						return
					else
						local v52 = v49.AbsolutePosition - p_u_2.GuiOffset
						local v53 = v49.AbsolutePosition - p_u_2.GuiOffset + v49.AbsoluteSize
						if not p_u_2.isPosInsideRect(v47, v52, v53) then
							v_u_27.state.isOpened:set(false)
						end
					end
				end
			else
				return
			end
		else
			return
		end
	end
	p_u_2.registerEvent("InputBegan", v54)
	p_u_2.registerEvent("InputChanged", v54)
	local v55 = p_u_1.WidgetConstructor
	local v56 = {
		["hasState"] = true,
		["hasChildren"] = true,
		["Args"] = {
			["Text"] = 1,
			["NoButton"] = 2,
			["NoPreview"] = 3
		}
	}
	local v62 = {
		["opened"] = {
			["Init"] = function(_) end,
			["Get"] = function(p57)
				-- upvalues: (copy) p_u_1
				return p57.lastOpenedTick == p_u_1._cycleTick
			end
		},
		["closed"] = {
			["Init"] = function(_) end,
			["Get"] = function(p58)
				-- upvalues: (copy) p_u_1
				return p58.lastClosedTick == p_u_1._cycleTick
			end
		},
		["changed"] = {
			["Init"] = function(_) end,
			["Get"] = function(p59)
				-- upvalues: (copy) p_u_1
				return p59.lastChangedTick == p_u_1._cycleTick
			end
		},
		["clicked"] = p_u_2.EVENTS.click(function(p60)
			return p60.Instance.PreviewContainer
		end),
		["hovered"] = p_u_2.EVENTS.hover(function(p61)
			return p61.Instance
		end)
	}
	v56.Events = v62
	function v56.Generate(p_u_63)
		-- upvalues: (copy) p_u_1, (copy) p_u_2, (ref) v_u_25, (ref) v_u_27
		local v64 = p_u_1._config.TextSize + 2 * p_u_1._config.FramePadding.Y
		local v65 = Instance.new("Frame")
		v65.Name = "Iris_Combo"
		v65.Size = UDim2.new(p_u_1._config.ItemWidth, UDim.new())
		v65.AutomaticSize = Enum.AutomaticSize.Y
		v65.BackgroundTransparency = 1
		v65.BorderSizePixel = 0
		v65.LayoutOrder = p_u_63.ZIndex
		p_u_2.UIListLayout(v65, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
		local v66 = Instance.new("TextButton")
		v66.Name = "PreviewContainer"
		v66.Size = UDim2.new(p_u_1._config.ContentWidth, UDim.new(0, 0))
		v66.AutomaticSize = Enum.AutomaticSize.Y
		v66.BackgroundTransparency = 1
		v66.Text = ""
		v66.ZIndex = p_u_63.ZIndex + 2
		v66.AutoButtonColor = false
		p_u_2.applyFrameStyle(v66, true)
		p_u_2.UIListLayout(v66, Enum.FillDirection.Horizontal, UDim.new(0, 0))
		p_u_2.UISizeConstraint(v66, Vector2.new(v64))
		v66.Parent = v65
		local v67 = Instance.new("TextLabel")
		v67.Name = "PreviewLabel"
		v67.Size = UDim2.new(UDim.new(1, 0), p_u_1._config.ContentHeight)
		v67.AutomaticSize = Enum.AutomaticSize.Y
		v67.BackgroundColor3 = p_u_1._config.FrameBgColor
		v67.BackgroundTransparency = p_u_1._config.FrameBgTransparency
		v67.BorderSizePixel = 0
		v67.ClipsDescendants = true
		p_u_2.applyTextStyle(v67)
		p_u_2.UIPadding(v67, p_u_1._config.FramePadding)
		v67.Parent = v66
		local v68 = Instance.new("TextLabel")
		v68.Name = "DropdownButton"
		local v69 = UDim2.new
		local v70 = p_u_1._config.ContentHeight.Scale
		local v71 = p_u_1._config.ContentHeight.Offset
		v68.Size = v69(0, v64, v70, (math.max(v71, v64)))
		v68.BorderSizePixel = 0
		v68.BackgroundColor3 = p_u_1._config.ButtonColor
		v68.BackgroundTransparency = p_u_1._config.ButtonTransparency
		v68.Text = ""
		local v72 = v64 * 0.2
		local v73 = v64 - math.round(v72) * 2
		local v74 = Instance.new("ImageLabel")
		v74.Name = "Dropdown"
		v74.AnchorPoint = Vector2.new(0.5, 0.5)
		v74.Size = UDim2.fromOffset(v73, v73)
		v74.Position = UDim2.fromScale(0.5, 0.5)
		v74.BackgroundTransparency = 1
		v74.BorderSizePixel = 0
		v74.ImageColor3 = p_u_1._config.TextColor
		v74.ImageTransparency = p_u_1._config.TextTransparency
		v74.Parent = v68
		v68.Parent = v66
		p_u_2.applyInteractionHighlightsWithMultiHighlightee("Background", v66, {
			{
				v67,
				{
					["Color"] = p_u_1._config.FrameBgColor,
					["Transparency"] = p_u_1._config.FrameBgTransparency,
					["HoveredColor"] = p_u_1._config.FrameBgHoveredColor,
					["HoveredTransparency"] = p_u_1._config.FrameBgHoveredTransparency,
					["ActiveColor"] = p_u_1._config.FrameBgActiveColor,
					["ActiveTransparency"] = p_u_1._config.FrameBgActiveTransparency
				}
			},
			{
				v68,
				{
					["Color"] = p_u_1._config.ButtonColor,
					["Transparency"] = p_u_1._config.ButtonTransparency,
					["HoveredColor"] = p_u_1._config.ButtonHoveredColor,
					["HoveredTransparency"] = p_u_1._config.ButtonHoveredTransparency,
					["ActiveColor"] = p_u_1._config.ButtonHoveredColor,
					["ActiveTransparency"] = p_u_1._config.ButtonHoveredTransparency
				}
			}
		})
		p_u_2.applyButtonClick(v66, function()
			-- upvalues: (ref) v_u_25, (ref) v_u_27, (copy) p_u_63
			if not v_u_25 or v_u_27 == p_u_63 then
				p_u_63.state.isOpened:set(not p_u_63.state.isOpened.value)
			end
		end)
		local v75 = Instance.new("TextLabel")
		v75.Name = "TextLabel"
		v75.Size = UDim2.fromOffset(0, v64)
		v75.AutomaticSize = Enum.AutomaticSize.X
		v75.BackgroundTransparency = 1
		v75.BorderSizePixel = 0
		p_u_2.applyTextStyle(v75)
		v75.Parent = v65
		local v76 = Instance.new("ScrollingFrame")
		v76.Name = "ComboContainer"
		v76.BackgroundColor3 = p_u_1._config.PopupBgColor
		v76.BackgroundTransparency = p_u_1._config.PopupBgTransparency
		v76.BorderSizePixel = 0
		v76.AutomaticCanvasSize = Enum.AutomaticSize.Y
		v76.ScrollBarImageTransparency = p_u_1._config.ScrollbarGrabTransparency
		v76.ScrollBarImageColor3 = p_u_1._config.ScrollbarGrabColor
		v76.ScrollBarThickness = p_u_1._config.ScrollbarSize
		v76.CanvasSize = UDim2.fromScale(0, 0)
		v76.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
		v76.TopImage = p_u_2.ICONS.BLANK_SQUARE
		v76.MidImage = p_u_2.ICONS.BLANK_SQUARE
		v76.BottomImage = p_u_2.ICONS.BLANK_SQUARE
		v76.ClipsDescendants = true
		p_u_2.UIStroke(v76, p_u_1._config.WindowBorderSize, p_u_1._config.BorderColor, p_u_1._config.BorderTransparency)
		p_u_2.UIPadding(v76, Vector2.new(2, p_u_1._config.WindowPadding.Y))
		p_u_2.UISizeConstraint(v76, Vector2.new(100))
		local v77 = p_u_2.UIListLayout(v76, Enum.FillDirection.Vertical, UDim.new(0, p_u_1._config.ItemSpacing.Y))
		v77.VerticalAlignment = Enum.VerticalAlignment.Top
		local v78 = p_u_1._rootInstance
		if v78 then
			v78 = p_u_1._rootInstance:WaitForChild("PopupScreenGui")
		end
		v76.Parent = v78
		p_u_63.ChildContainer = v76
		p_u_63.UIListLayout = v77
		return v65
	end
	function v56.Update(p79)
		-- upvalues: (copy) p_u_1
		local v80 = p79.Instance
		local v81 = v80.PreviewContainer
		local v82 = v81.PreviewLabel
		local v83 = v81.DropdownButton
		v80.TextLabel.Text = p79.arguments.Text or "Combo"
		if p79.arguments.NoButton then
			v83.Visible = false
			v82.Size = UDim2.new(UDim.new(1, 0), v82.Size.Height)
		else
			v83.Visible = true
			local v84 = p_u_1._config.TextSize + 2 * p_u_1._config.FramePadding.Y
			v82.Size = UDim2.new(UDim.new(1, -v84), v82.Size.Height)
		end
		if p79.arguments.NoPreview then
			v82.Visible = false
			v81.Size = UDim2.new(0, 0, 0, 0)
			v81.AutomaticSize = Enum.AutomaticSize.XY
		else
			v82.Visible = true
			v81.Size = UDim2.new(p_u_1._config.ContentWidth, p_u_1._config.ContentHeight)
			v81.AutomaticSize = Enum.AutomaticSize.Y
		end
	end
	function v56.ChildAdded(p85, _)
		-- upvalues: (copy) v_u_43
		v_u_43(p85)
		return p85.ChildContainer
	end
	function v56.GenerateState(p_u_86)
		-- upvalues: (copy) p_u_1
		if p_u_86.state.index == nil then
			p_u_86.state.index = p_u_1._widgetState(p_u_86, "index", "No Selection")
		end
		if p_u_86.state.isOpened == nil then
			p_u_86.state.isOpened = p_u_1._widgetState(p_u_86, "isOpened", false)
		end
		p_u_86.state.index:onChange(function()
			-- upvalues: (copy) p_u_86, (ref) p_u_1
			p_u_86.lastChangedTick = p_u_1._cycleTick + 1
			if p_u_86.state.isOpened.value then
				p_u_86.state.isOpened:set(false)
			end
		end)
	end
	function v56.UpdateState(p87)
		-- upvalues: (ref) v_u_25, (ref) v_u_27, (ref) v_u_26, (copy) p_u_1, (copy) p_u_2, (copy) v_u_43
		local v88 = p87.Instance
		local v89 = p87.ChildContainer
		local v90 = v88.PreviewContainer
		local v91 = v90.PreviewLabel
		local v92 = v90.DropdownButton.Dropdown
		if p87.state.isOpened.value then
			v_u_25 = true
			v_u_27 = p87
			v_u_26 = p_u_1._cycleTick
			p87.lastOpenedTick = p_u_1._cycleTick + 1
			v92.Image = p_u_2.ICONS.RIGHT_POINTING_TRIANGLE
			v89.Visible = true
			v_u_43(p87)
		else
			if v_u_25 then
				v_u_25 = false
				v_u_27 = nil
				p87.lastClosedTick = p_u_1._cycleTick + 1
			end
			v92.Image = p_u_2.ICONS.DOWN_POINTING_TRIANGLE
			v89.Visible = false
		end
		local v93 = p87.state.index.value
		local v94
		if typeof(v93) == "EnumItem" then
			v94 = v93.Name
		else
			v94 = tostring(v93)
		end
		v91.Text = v94
	end
	function v56.Discard(p95)
		-- upvalues: (ref) v_u_27, (ref) v_u_25, (copy) p_u_2
		if v_u_27 and v_u_27 == p95 then
			v_u_27 = nil
			v_u_25 = false
		end
		p95.Instance:Destroy()
		p95.ChildContainer:Destroy()
		p_u_2.discardState(p95)
	end
	v55("Combo", v56)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Combo]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3459"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p_u_1, p_u_2)
	p_u_1.WidgetConstructor("Separator", {
		["hasState"] = false,
		["hasChildren"] = false,
		["Args"] = {},
		["Events"] = {},
		["Generate"] = function(p3)
			-- upvalues: (copy) p_u_1, (copy) p_u_2
			local v4 = Instance.new("Frame")
			v4.Name = "Iris_Separator"
			v4.BackgroundColor3 = p_u_1._config.SeparatorColor
			v4.BackgroundTransparency = p_u_1._config.SeparatorTransparency
			v4.BorderSizePixel = 0
			if p3.parentWidget.type == "SameLine" then
				v4.Size = UDim2.new(0, 1, p_u_1._config.ItemWidth.Scale, p_u_1._config.ItemWidth.Offset)
			else
				v4.Size = UDim2.new(p_u_1._config.ItemWidth.Scale, p_u_1._config.ItemWidth.Offset, 0, 1)
			end
			v4.LayoutOrder = p3.ZIndex
			p_u_2.UIListLayout(v4, Enum.FillDirection.Vertical, UDim.new(0, 0))
			return v4
		end,
		["Update"] = function(_) end,
		["Discard"] = function(p5)
			p5.Instance:Destroy()
		end
	})
	local v13 = {
		["hasState"] = false,
		["hasChildren"] = true,
		["Args"] = {
			["Width"] = 1
		},
		["Events"] = {},
		["Generate"] = function(p6)
			-- upvalues: (copy) p_u_1, (copy) p_u_2
			local v7 = Instance.new("Frame")
			v7.Name = "Iris_Indent"
			v7.BackgroundTransparency = 1
			v7.BorderSizePixel = 0
			v7.Size = UDim2.new(p_u_1._config.ItemWidth, UDim.new())
			v7.AutomaticSize = Enum.AutomaticSize.Y
			v7.LayoutOrder = p6.ZIndex
			p_u_2.UIListLayout(v7, Enum.FillDirection.Vertical, UDim.new(0, p_u_1._config.ItemSpacing.Y))
			p_u_2.UIPadding(v7, Vector2.zero)
			return v7
		end,
		["Update"] = function(p8)
			-- upvalues: (copy) p_u_1
			local v9 = p8.Instance
			local v10
			if p8.arguments.Width then
				v10 = p8.arguments.Width
			else
				v10 = p_u_1._config.IndentSpacing
			end
			v9.UIPadding.PaddingLeft = UDim.new(0, v10)
		end,
		["Discard"] = function(p11)
			p11.Instance:Destroy()
		end,
		["ChildAdded"] = function(p12, _)
			return p12.Instance
		end
	}
	p_u_1.WidgetConstructor("Indent", v13)
	local v21 = {
		["hasState"] = false,
		["hasChildren"] = true,
		["Args"] = {
			["Width"] = 1,
			["VerticalAlignment"] = 2,
			["HorizontalAlignment"] = 3
		},
		["Events"] = {},
		["Generate"] = function(p14)
			-- upvalues: (copy) p_u_1, (copy) p_u_2
			local v15 = Instance.new("Frame")
			v15.Name = "Iris_SameLine"
			v15.BackgroundTransparency = 1
			v15.BorderSizePixel = 0
			v15.Size = UDim2.new(p_u_1._config.ItemWidth, UDim.new())
			v15.AutomaticSize = Enum.AutomaticSize.Y
			v15.LayoutOrder = p14.ZIndex
			p_u_2.UIListLayout(v15, Enum.FillDirection.Horizontal, UDim.new(0, 0))
			return v15
		end,
		["Update"] = function(p16)
			-- upvalues: (copy) p_u_1
			local v17 = p16.Instance.UIListLayout
			local v18
			if p16.arguments.Width then
				v18 = p16.arguments.Width
			else
				v18 = p_u_1._config.ItemSpacing.X
			end
			v17.Padding = UDim.new(0, v18)
			if p16.arguments.VerticalAlignment then
				v17.VerticalAlignment = p16.arguments.VerticalAlignment
			else
				v17.VerticalAlignment = Enum.VerticalAlignment.Top
			end
			if p16.arguments.HorizontalAlignment then
				v17.HorizontalAlignment = p16.arguments.HorizontalAlignment
			else
				v17.HorizontalAlignment = Enum.HorizontalAlignment.Left
			end
		end,
		["Discard"] = function(p19)
			p19.Instance:Destroy()
		end,
		["ChildAdded"] = function(p20, _)
			return p20.Instance
		end
	}
	p_u_1.WidgetConstructor("SameLine", v21)
	p_u_1.WidgetConstructor("Group", {
		["hasState"] = false,
		["hasChildren"] = true,
		["Args"] = {},
		["Events"] = {},
		["Generate"] = function(p22)
			-- upvalues: (copy) p_u_2, (copy) p_u_1
			local v23 = Instance.new("Frame")
			v23.Name = "Iris_Group"
			v23.AutomaticSize = Enum.AutomaticSize.XY
			v23.Size = UDim2.fromOffset(0, 0)
			v23.BackgroundTransparency = 1
			v23.BorderSizePixel = 0
			v23.LayoutOrder = p22.ZIndex
			v23.ClipsDescendants = false
			p_u_2.UIListLayout(v23, Enum.FillDirection.Vertical, UDim.new(0, p_u_1._config.ItemSpacing.Y))
			return v23
		end,
		["Update"] = function(_) end,
		["Discard"] = function(p24)
			p24.Instance:Destroy()
		end,
		["ChildAdded"] = function(p25, _)
			return p25.Instance
		end
	})
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Format]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3460"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p_u_1, p_u_2)
	local v4 = {
		["hasState"] = false,
		["hasChildren"] = false,
		["Args"] = {
			["Image"] = 1,
			["Size"] = 2,
			["Rect"] = 3,
			["ScaleType"] = 4,
			["ResampleMode"] = 5,
			["TileSize"] = 6,
			["SliceCenter"] = 7,
			["SliceScale"] = 8
		},
		["Discard"] = function(p3)
			p3.Instance:Destroy()
		end
	}
	local v5 = p_u_1.WidgetConstructor
	local v6 = p_u_2.extend
	local v12 = {
		["Events"] = {
			["hovered"] = p_u_2.EVENTS.hover(function(p7)
				return p7.Instance
			end)
		},
		["Generate"] = function(p8)
			-- upvalues: (copy) p_u_1, (copy) p_u_2
			local v9 = Instance.new("ImageLabel")
			v9.Name = "Iris_Image"
			v9.BackgroundTransparency = 1
			v9.BorderSizePixel = 0
			v9.ImageColor3 = p_u_1._config.ImageColor
			v9.ImageTransparency = p_u_1._config.ImageTransparency
			v9.LayoutOrder = p8.ZIndex
			p_u_2.applyFrameStyle(v9, true)
			return v9
		end,
		["Update"] = function(p10)
			-- upvalues: (copy) p_u_2
			local v11 = p10.Instance
			v11.Image = p10.arguments.Image or p_u_2.ICONS.UNKNOWN_TEXTURE
			v11.Size = p10.arguments.Size
			if p10.arguments.ScaleType then
				v11.ScaleType = p10.arguments.ScaleType
				if p10.arguments.ScaleType == Enum.ScaleType.Tile and p10.arguments.TileSize then
					v11.TileSize = p10.arguments.TileSize
				elseif p10.arguments.ScaleType == Enum.ScaleType.Slice then
					if p10.arguments.SliceCenter then
						v11.SliceCenter = p10.arguments.SliceCenter
					end
					if p10.arguments.SliceScale then
						v11.SliceScale = p10.arguments.SliceScale
					end
				end
			end
			if p10.arguments.Rect then
				v11.ImageRectOffset = p10.arguments.Rect.Min
				v11.ImageRectSize = Vector2.new(p10.arguments.Rect.Width, p10.arguments.Rect.Height)
			end
			if p10.arguments.ResampleMode then
				v11.ResampleMode = p10.arguments.ResampleMode
			end
		end
	}
	v5("Image", v6(v4, v12))
	local v13 = p_u_1.WidgetConstructor
	local v14 = p_u_2.extend
	local v25 = {
		["Events"] = {
			["clicked"] = p_u_2.EVENTS.click(function(p15)
				return p15.Instance
			end),
			["rightClicked"] = p_u_2.EVENTS.rightClick(function(p16)
				return p16.Instance
			end),
			["doubleClicked"] = p_u_2.EVENTS.doubleClick(function(p17)
				return p17.Instance
			end),
			["ctrlClicked"] = p_u_2.EVENTS.ctrlClick(function(p18)
				return p18.Instance
			end),
			["hovered"] = p_u_2.EVENTS.hover(function(p19)
				return p19.Instance
			end)
		},
		["Generate"] = function(p20)
			-- upvalues: (copy) p_u_1, (copy) p_u_2
			local v21 = Instance.new("ImageButton")
			v21.Name = "Iris_ImageButton"
			v21.AutomaticSize = Enum.AutomaticSize.XY
			v21.BackgroundColor3 = p_u_1._config.FrameBgColor
			v21.BackgroundTransparency = p_u_1._config.FrameBgTransparency
			v21.BorderSizePixel = 0
			v21.Image = ""
			v21.ImageTransparency = 1
			v21.LayoutOrder = p20.ZIndex
			v21.AutoButtonColor = false
			p_u_2.applyFrameStyle(v21, true)
			p_u_2.UIPadding(v21, Vector2.new(p_u_1._config.ImageBorderSize, p_u_1._config.ImageBorderSize))
			local v22 = Instance.new("ImageLabel")
			v22.Name = "ImageLabel"
			v22.BackgroundTransparency = 1
			v22.BorderSizePixel = 0
			v22.ImageColor3 = p_u_1._config.ImageColor
			v22.ImageTransparency = p_u_1._config.ImageTransparency
			v22.Parent = v21
			p_u_2.applyInteractionHighlights("Background", v21, v21, {
				["Color"] = p_u_1._config.FrameBgColor,
				["Transparency"] = p_u_1._config.FrameBgTransparency,
				["HoveredColor"] = p_u_1._config.FrameBgHoveredColor,
				["HoveredTransparency"] = p_u_1._config.FrameBgHoveredTransparency,
				["ActiveColor"] = p_u_1._config.FrameBgActiveColor,
				["ActiveTransparency"] = p_u_1._config.FrameBgActiveTransparency
			})
			return v21
		end,
		["Update"] = function(p23)
			-- upvalues: (copy) p_u_2
			local v24 = p23.Instance.ImageLabel
			v24.Image = p23.arguments.Image or p_u_2.ICONS.UNKNOWN_TEXTURE
			v24.Size = p23.arguments.Size
			if p23.arguments.ScaleType then
				v24.ScaleType = p23.arguments.ScaleType
				if p23.arguments.ScaleType == Enum.ScaleType.Tile and p23.arguments.TileSize then
					v24.TileSize = p23.arguments.TileSize
				elseif p23.arguments.ScaleType == Enum.ScaleType.Slice then
					if p23.arguments.SliceCenter then
						v24.SliceCenter = p23.arguments.SliceCenter
					end
					if p23.arguments.SliceScale then
						v24.SliceScale = p23.arguments.SliceScale
					end
				end
			end
			if p23.arguments.Rect then
				v24.ImageRectOffset = p23.arguments.Rect.Min
				v24.ImageRectSize = Vector2.new(p23.arguments.Rect.Width, p23.arguments.Rect.Height)
			end
			if p23.arguments.ResampleMode then
				v24.ResampleMode = p23.arguments.ResampleMode
			end
		end
	}
	v13("ImageButton", v14(v4, v25))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Image]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3461"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p_u_1, p_u_2)
	local v_u_4 = {
		["Init"] = function(_) end,
		["Get"] = function(p3)
			-- upvalues: (copy) p_u_1
			return p3.lastNumberChangedTick == p_u_1._cycleTick
		end
	}
	local function v_u_10(p5, p6, p7)
		local v8 = typeof(p5)
		if v8 == "number" then
			return p5
		end
		if v8 == "Vector2" then
			if p6 == 1 then
				return p5.X
			end
			if p6 == 2 then
				return p5.Y
			end
		elseif v8 == "Vector3" then
			if p6 == 1 then
				return p5.X
			end
			if p6 == 2 then
				return p5.Y
			end
			if p6 == 3 then
				return p5.Z
			end
		elseif v8 == "UDim" then
			if p6 == 1 then
				return p5.Scale
			end
			if p6 == 2 then
				return p5.Offset
			end
		elseif v8 == "UDim2" then
			if p6 == 1 then
				return p5.X.Scale
			end
			if p6 == 2 then
				return p5.X.Offset
			end
			if p6 == 3 then
				return p5.Y.Scale
			end
			if p6 == 4 then
				return p5.Y.Offset
			end
		elseif v8 == "Color3" then
			local v9 = p7.UseHSV and { p5:ToHSV() } or { p5.R, p5.G, p5.B }
			if p6 == 1 then
				return v9[1]
			end
			if p6 == 2 then
				return v9[2]
			end
			if p6 == 3 then
				return v9[3]
			end
		elseif v8 == "Rect" then
			if p6 == 1 then
				return p5.Min.X
			end
			if p6 == 2 then
				return p5.Min.Y
			end
			if p6 == 3 then
				return p5.Max.X
			end
			if p6 == 4 then
				return p5.Max.Y
			end
		elseif v8 == "table" then
			return p5[p6]
		end
		error((("Incorrect datatype or value: %* %* %*."):format(p5, typeof(p5), p6)))
	end
	local function v_u_24(p11, p12, p13, p14)
		if typeof(p11) == "number" then
			return p13
		end
		if typeof(p11) == "Vector2" then
			if p12 == 1 then
				return Vector2.new(p13, p11.Y)
			end
			if p12 == 2 then
				return Vector2.new(p11.X, p13)
			end
		elseif typeof(p11) == "Vector3" then
			if p12 == 1 then
				local v15 = p11.Y
				local v16 = p11.Z
				return Vector3.new(p13, v15, v16)
			end
			if p12 == 2 then
				local v17 = p11.X
				local v18 = p11.Z
				return Vector3.new(v17, p13, v18)
			end
			if p12 == 3 then
				local v19 = p11.X
				local v20 = p11.Y
				return Vector3.new(v19, v20, p13)
			end
		elseif typeof(p11) == "UDim" then
			if p12 == 1 then
				return UDim.new(p13, p11.Offset)
			end
			if p12 == 2 then
				return UDim.new(p11.Scale, p13)
			end
		elseif typeof(p11) == "UDim2" then
			if p12 == 1 then
				return UDim2.new(UDim.new(p13, p11.X.Offset), p11.Y)
			end
			if p12 == 2 then
				return UDim2.new(UDim.new(p11.X.Scale, p13), p11.Y)
			end
			if p12 == 3 then
				return UDim2.new(p11.X, UDim.new(p13, p11.Y.Offset))
			end
			if p12 == 4 then
				return UDim2.new(p11.X, UDim.new(p11.Y.Scale, p13))
			end
		elseif typeof(p11) == "Rect" then
			if p12 == 1 then
				return Rect.new(Vector2.new(p13, p11.Min.Y), p11.Max)
			end
			if p12 == 2 then
				return Rect.new(Vector2.new(p11.Min.X, p13), p11.Max)
			end
			if p12 == 3 then
				return Rect.new(p11.Min, Vector2.new(p13, p11.Max.Y))
			end
			if p12 == 4 then
				return Rect.new(p11.Min, Vector2.new(p11.Max.X, p13))
			end
		elseif typeof(p11) == "Color3" then
			if p14.UseHSV then
				local v21, v22, v23 = p11:ToHSV()
				if p12 == 1 then
					return Color3.fromHSV(p13, v22, v23)
				end
				if p12 == 2 then
					return Color3.fromHSV(v21, p13, v23)
				end
				if p12 == 3 then
					return Color3.fromHSV(v21, v22, p13)
				end
			end
			if p12 == 1 then
				return Color3.new(p13, p11.G, p11.B)
			end
			if p12 == 2 then
				return Color3.new(p11.R, p13, p11.B)
			end
			if p12 == 3 then
				return Color3.new(p11.R, p11.G, p13)
			end
		end
		error((("Incorrect datatype or value %* %* %*."):format(p11, typeof(p11), p12)))
	end
	local v_u_25 = {
		["Num"] = { 1 },
		["Vector2"] = { 1, 1 },
		["Vector3"] = { 1, 1, 1 },
		["UDim"] = { 0.01, 1 },
		["UDim2"] = {
			0.01,
			1,
			0.01,
			1
		},
		["Color3"] = { 1, 1, 1 },
		["Color4"] = {
			1,
			1,
			1,
			1
		},
		["Rect"] = {
			1,
			1,
			1,
			1
		}
	}
	local v_u_26 = {
		["Num"] = { 0 },
		["Vector2"] = { 0, 0 },
		["Vector3"] = { 0, 0, 0 },
		["UDim"] = { 0, 0 },
		["UDim2"] = {
			0,
			0,
			0,
			0
		},
		["Rect"] = {
			0,
			0,
			0,
			0
		}
	}
	local v_u_27 = {
		["Num"] = { 100 },
		["Vector2"] = { 100, 100 },
		["Vector3"] = { 100, 100, 100 },
		["UDim"] = { 1, 960 },
		["UDim2"] = {
			1,
			960,
			1,
			960
		},
		["Rect"] = {
			960,
			960,
			960,
			960
		}
	}
	local v_u_28 = {
		["Num"] = { "" },
		["Vector2"] = { "X: ", "Y: " },
		["Vector3"] = { "X: ", "Y: ", "Z: " },
		["UDim"] = { "", "" },
		["UDim2"] = {
			"",
			"",
			"",
			""
		},
		["Color3_RGB"] = { "R: ", "G: ", "B: " },
		["Color3_HSV"] = { "H: ", "S: ", "V: " },
		["Color4_RGB"] = {
			"R: ",
			"G: ",
			"B: ",
			"T: "
		},
		["Color4_HSV"] = {
			"H: ",
			"S: ",
			"V: ",
			"T: "
		},
		["Rect"] = {
			"X: ",
			"Y: ",
			"X: ",
			"Y: "
		}
	}
	local v_u_29 = {
		["Num"] = { 0 },
		["Vector2"] = { 0, 0 },
		["Vector3"] = { 0, 0, 0 },
		["UDim"] = { 3, 0 },
		["UDim2"] = {
			3,
			0,
			3,
			0
		},
		["Color3"] = { 0, 0, 0 },
		["Color4"] = {
			0,
			0,
			0,
			0
		},
		["Rect"] = {
			0,
			0,
			0,
			0
		}
	}
	local function v_u_53(p_u_30, p31, p32)
		-- upvalues: (copy) p_u_2, (copy) p_u_1, (copy) v_u_10
		local v33 = p_u_2.abstractButton.Generate(p_u_30)
		v33.Name = "SubButton"
		v33.ZIndex = 5
		v33.LayoutOrder = 5
		v33.TextXAlignment = Enum.TextXAlignment.Center
		v33.Text = "-"
		v33.Size = UDim2.fromOffset(p_u_1._config.TextSize + 2 * p_u_1._config.FramePadding.Y, p_u_1._config.TextSize)
		v33.Parent = p31
		p_u_2.applyButtonClick(v33, function()
			-- upvalues: (ref) p_u_2, (copy) p_u_30, (ref) v_u_10, (ref) p_u_1
			local v34 = p_u_2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p_u_2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
			local v35 = (p_u_30.arguments.Increment and v_u_10(p_u_30.arguments.Increment, 1, p_u_30.arguments) or 1) * (v34 and 100 or 1)
			local v36 = p_u_30.state.number.value - v35
			if p_u_30.arguments.Min ~= nil then
				local v37 = v_u_10
				local v38 = p_u_30.arguments.Min
				local v39 = p_u_30.arguments
				v36 = math.max(v36, v37(v38, 1, v39))
			end
			if p_u_30.arguments.Max ~= nil then
				local v40 = v_u_10
				local v41 = p_u_30.arguments.Max
				local v42 = p_u_30.arguments
				v36 = math.min(v36, v40(v41, 1, v42))
			end
			p_u_30.state.number:set(v36)
			p_u_30.lastNumberChangedTick = p_u_1._cycleTick + 1
		end)
		local v43 = p_u_2.abstractButton.Generate(p_u_30)
		v43.Name = "AddButton"
		v43.ZIndex = 6
		v43.LayoutOrder = 6
		v43.TextXAlignment = Enum.TextXAlignment.Center
		v43.Text = "+"
		v43.Size = UDim2.fromOffset(p_u_1._config.TextSize + 2 * p_u_1._config.FramePadding.Y, p_u_1._config.TextSize)
		v43.Parent = p31
		p_u_2.applyButtonClick(v43, function()
			-- upvalues: (ref) p_u_2, (copy) p_u_30, (ref) v_u_10, (ref) p_u_1
			local v44 = p_u_2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p_u_2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
			local v45 = (p_u_30.arguments.Increment and v_u_10(p_u_30.arguments.Increment, 1, p_u_30.arguments) or 1) * (v44 and 100 or 1)
			local v46 = p_u_30.state.number.value + v45
			if p_u_30.arguments.Min ~= nil then
				local v47 = v_u_10
				local v48 = p_u_30.arguments.Min
				local v49 = p_u_30.arguments
				v46 = math.max(v46, v47(v48, 1, v49))
			end
			if p_u_30.arguments.Max ~= nil then
				local v50 = v_u_10
				local v51 = p_u_30.arguments.Max
				local v52 = p_u_30.arguments
				v46 = math.min(v46, v50(v51, 1, v52))
			end
			p_u_30.state.number:set(v46)
			p_u_30.lastNumberChangedTick = p_u_1._cycleTick + 1
		end)
		return 2 * p_u_1._config.ItemInnerSpacing.X + p32 * 2
	end
	local function v107(p_u_54, p_u_55, p_u_56)
		-- upvalues: (copy) v_u_4, (copy) p_u_2, (copy) p_u_1, (copy) v_u_53, (copy) v_u_10, (copy) v_u_24, (copy) v_u_29, (copy) v_u_28
		local v106 = {
			["hasState"] = true,
			["hasChildren"] = false,
			["Args"] = {
				["Text"] = 1,
				["Increment"] = 2,
				["Min"] = 3,
				["Max"] = 4,
				["Format"] = 5
			},
			["Events"] = {
				["numberChanged"] = v_u_4,
				["hovered"] = p_u_2.EVENTS.hover(function(p57)
					return p57.Instance
				end)
			},
			["Generate"] = function(p_u_58)
				-- upvalues: (copy) p_u_54, (ref) p_u_1, (ref) p_u_2, (copy) p_u_55, (ref) v_u_53, (ref) v_u_10, (ref) v_u_24
				local v59 = Instance.new("Frame")
				v59.Name = "Iris_Input" .. p_u_54
				v59.Size = UDim2.new(p_u_1._config.ItemWidth, UDim.new())
				v59.BackgroundTransparency = 1
				v59.BorderSizePixel = 0
				v59.LayoutOrder = p_u_58.ZIndex
				v59.AutomaticSize = Enum.AutomaticSize.Y
				p_u_2.UIListLayout(v59, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
				local v60 = p_u_1._config.TextSize + 2 * p_u_1._config.FramePadding.Y
				local v61 = p_u_55 ~= 1 and 0 or v_u_53(p_u_58, v59, v60)
				local v62 = UDim.new(p_u_1._config.ContentWidth.Scale / p_u_55, (p_u_1._config.ContentWidth.Offset - p_u_1._config.ItemInnerSpacing.X * (p_u_55 - 1) - v61) / p_u_55)
				local v63 = UDim.new(v62.Scale * (p_u_55 - 1), v62.Offset * (p_u_55 - 1) + p_u_1._config.ItemInnerSpacing.X * (p_u_55 - 1) + v61)
				local v64 = p_u_1._config.ContentWidth - v63
				for v_u_65 = 1, p_u_55 do
					local v_u_66 = Instance.new("TextBox")
					v_u_66.Name = "InputField" .. tostring(v_u_65)
					v_u_66.LayoutOrder = v_u_65
					if v_u_65 == p_u_55 then
						v_u_66.Size = UDim2.new(v64, p_u_1._config.ContentHeight)
					else
						v_u_66.Size = UDim2.new(v62, p_u_1._config.ContentHeight)
					end
					v_u_66.AutomaticSize = Enum.AutomaticSize.Y
					v_u_66.BackgroundColor3 = p_u_1._config.FrameBgColor
					v_u_66.BackgroundTransparency = p_u_1._config.FrameBgTransparency
					v_u_66.ClearTextOnFocus = false
					v_u_66.TextTruncate = Enum.TextTruncate.AtEnd
					v_u_66.ClipsDescendants = true
					p_u_2.applyFrameStyle(v_u_66)
					p_u_2.applyTextStyle(v_u_66)
					p_u_2.UISizeConstraint(v_u_66, Vector2.xAxis)
					v_u_66.Parent = v59
					v_u_66.FocusLost:Connect(function()
						-- upvalues: (copy) v_u_66, (copy) p_u_58, (ref) v_u_10, (copy) v_u_65, (ref) v_u_24, (ref) p_u_1
						local v67 = v_u_66.Text
						local v68 = tonumber(v67:match("-?%d*%.?%d*"))
						if v68 ~= nil then
							if p_u_58.arguments.Min ~= nil then
								local v69 = v_u_10
								local v70 = p_u_58.arguments.Min
								local v71 = v_u_65
								local v72 = p_u_58.arguments
								v68 = math.max(v68, v69(v70, v71, v72))
							end
							if p_u_58.arguments.Max ~= nil then
								local v73 = v_u_10
								local v74 = p_u_58.arguments.Max
								local v75 = v_u_65
								local v76 = p_u_58.arguments
								v68 = math.min(v68, v73(v74, v75, v76))
							end
							if p_u_58.arguments.Increment then
								local v77 = v68 / v_u_10(p_u_58.arguments.Increment, v_u_65, p_u_58.arguments)
								v68 = math.round(v77) * v_u_10(p_u_58.arguments.Increment, v_u_65, p_u_58.arguments)
							end
							p_u_58.state.number:set(v_u_24(p_u_58.state.number.value, v_u_65, v68, p_u_58.arguments))
							p_u_58.lastNumberChangedTick = p_u_1._cycleTick + 1
						end
						local v78 = p_u_58.arguments.Format[v_u_65] or p_u_58.arguments.Format[1]
						if p_u_58.arguments.Prefix then
							v78 = p_u_58.arguments.Prefix[v_u_65] .. v78
						end
						v_u_66.Text = string.format(v78, v_u_10(p_u_58.state.number.value, v_u_65, p_u_58.arguments))
						p_u_58.state.editingText:set(0)
					end)
					v_u_66.Focused:Connect(function()
						-- upvalues: (copy) v_u_66, (copy) p_u_58, (copy) v_u_65
						v_u_66.CursorPosition = #v_u_66.Text + 1
						v_u_66.SelectionStart = 1
						p_u_58.state.editingText:set(v_u_65)
					end)
				end
				local v79 = Instance.new("TextLabel")
				v79.Name = "TextLabel"
				v79.BackgroundTransparency = 1
				v79.BorderSizePixel = 0
				v79.LayoutOrder = 7
				v79.AutomaticSize = Enum.AutomaticSize.XY
				p_u_2.applyTextStyle(v79)
				v79.Parent = v59
				return v59
			end,
			["Update"] = function(p80)
				-- upvalues: (copy) p_u_54, (copy) p_u_55, (ref) p_u_1, (ref) v_u_29, (ref) v_u_10, (ref) v_u_28
				local v81 = p80.Instance
				v81.TextLabel.Text = p80.arguments.Text or ("Input %*"):format(p_u_54)
				if p_u_55 == 1 then
					v81.SubButton.Visible = not p80.arguments.NoButtons
					v81.AddButton.Visible = not p80.arguments.NoButtons
					local v82 = p80.arguments.NoButtons and 0 or 2 * p_u_1._config.ItemInnerSpacing.X + 2 * (p_u_1._config.TextSize + 2 * p_u_1._config.FramePadding.Y)
					v81.InputField1.Size = UDim2.new(UDim.new(p_u_1._config.ContentWidth.Scale, p_u_1._config.ContentWidth.Offset - v82), p_u_1._config.ContentHeight)
				end
				if p80.arguments.Format then
					local v83 = p80.arguments.Format
					if typeof(v83) ~= "table" then
						p80.arguments.Format = { p80.arguments.Format }
						return
					end
				end
				if not p80.arguments.Format then
					local v84 = {}
					for v85 = 1, p_u_55 do
						local v86 = v_u_29[p_u_54][v85]
						if p80.arguments.Increment then
							local v87 = v_u_10(p80.arguments.Increment, v85, p80.arguments)
							local v88 = v87 == 0 and 1 or v87
							local v89 = -math.log10(v88)
							local v90 = math.ceil(v89)
							v86 = math.max(v86, v90, v86)
						end
						if p80.arguments.Max then
							local v91 = v_u_10(p80.arguments.Max, v85, p80.arguments)
							local v92 = v91 == 0 and 1 or v91
							local v93 = -math.log10(v92)
							local v94 = math.ceil(v93)
							v86 = math.max(v86, v94, v86)
						end
						if p80.arguments.Min then
							local v95 = v_u_10(p80.arguments.Min, v85, p80.arguments)
							local v96 = v95 == 0 and 1 or v95
							local v97 = -math.log10(v96)
							local v98 = math.ceil(v97)
							v86 = math.max(v86, v98, v86)
						end
						if v86 > 0 then
							v84[v85] = ("%%.%*f"):format(v86)
						else
							v84[v85] = "%d"
						end
					end
					p80.arguments.Format = v84
					p80.arguments.Prefix = v_u_28[p_u_54]
				end
			end,
			["Discard"] = function(p99)
				-- upvalues: (ref) p_u_2
				p99.Instance:Destroy()
				p_u_2.discardState(p99)
			end,
			["GenerateState"] = function(p100)
				-- upvalues: (ref) p_u_1, (copy) p_u_56
				if p100.state.number == nil then
					p100.state.number = p_u_1._widgetState(p100, "number", p_u_56)
				end
				if p100.state.editingText == nil then
					p100.state.editingText = p_u_1._widgetState(p100, "editingText", 0)
				end
			end,
			["UpdateState"] = function(p101)
				-- upvalues: (copy) p_u_55, (ref) v_u_10
				local v102 = p101.Instance
				for v103 = 1, p_u_55 do
					local v104 = v102:FindFirstChild("InputField" .. tostring(v103))
					local v105 = p101.arguments.Format[v103] or p101.arguments.Format[1]
					if p101.arguments.Prefix then
						v105 = p101.arguments.Prefix[v103] .. v105
					end
					v104.Text = string.format(v105, v_u_10(p101.state.number.value, v103, p101.arguments))
				end
			end
		}
		return v106
	end
	local v_u_108 = 0
	local v_u_109 = false
	local v_u_110 = nil
	local v_u_111 = 0
	local v_u_112 = ""
	local function v_u_127()
		-- upvalues: (copy) p_u_2, (ref) v_u_108, (ref) v_u_109, (ref) v_u_110, (ref) v_u_112, (ref) v_u_111, (copy) v_u_10, (copy) v_u_25, (copy) v_u_24, (copy) p_u_1
		local v113 = p_u_2.getMouseLocation().X
		local v114 = v113 - v_u_108
		v_u_108 = v113
		if v_u_109 == false then
			return
		elseif v_u_110 ~= nil then
			local v115 = v_u_110.state.number
			if v_u_112 == "Color3" or v_u_112 == "Color4" then
				local v116 = v_u_110
				v115 = v116.state.color
				if v_u_111 == 4 then
					v115 = v116.state.transparency
				end
			end
			local v117 = (v_u_110.arguments.Increment and v_u_10(v_u_110.arguments.Increment, v_u_111, v_u_110.arguments) or v_u_25[v_u_112][v_u_111]) * ((p_u_2.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or p_u_2.UserInputService:IsKeyDown(Enum.KeyCode.RightShift)) and 10 or 1) * ((p_u_2.UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or p_u_2.UserInputService:IsKeyDown(Enum.KeyCode.RightAlt)) and 0.1 or 1) * ((v_u_112 == "Color3" or v_u_112 == "Color4") and 5 or 1)
			local v118 = v_u_10(v115.value, v_u_111, v_u_110.arguments) + v114 * v117
			if v_u_110.arguments.Min ~= nil then
				local v119 = v_u_10
				local v120 = v_u_110.arguments.Min
				local v121 = v_u_111
				local v122 = v_u_110.arguments
				v118 = math.max(v118, v119(v120, v121, v122))
			end
			if v_u_110.arguments.Max ~= nil then
				local v123 = v_u_10
				local v124 = v_u_110.arguments.Max
				local v125 = v_u_111
				local v126 = v_u_110.arguments
				v118 = math.min(v118, v123(v124, v125, v126))
			end
			v115:set(v_u_24(v115.value, v_u_111, v118, v_u_110.arguments))
			v_u_110.lastNumberChangedTick = p_u_1._cycleTick + 1
		end
	end
	local function v_u_136(p128, p129, p130, p131, p132)
		-- upvalues: (copy) p_u_2, (copy) p_u_1, (ref) v_u_109, (ref) v_u_110, (ref) v_u_111, (ref) v_u_112, (copy) v_u_127
		local v133 = p_u_2.getTime()
		local v134 = v133 - p128.lastClickedTime < p_u_1._config.MouseDoubleClickTime
		local v135 = p_u_2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p_u_2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
		if v134 and (Vector2.new(p131, p132) - p128.lastClickedPosition).Magnitude < p_u_1._config.MouseDoubleClickMaxDist or v135 then
			p128.state.editingText:set(p130)
		else
			p128.lastClickedTime = v133
			p128.lastClickedPosition = Vector2.new(p131, p132)
			v_u_109 = true
			v_u_110 = p128
			v_u_111 = p130
			v_u_112 = p129
			v_u_127()
		end
	end
	p_u_2.registerEvent("InputChanged", function()
		-- upvalues: (copy) p_u_1, (copy) v_u_127
		if p_u_1._started then
			v_u_127()
		end
	end)
	p_u_2.registerEvent("InputEnded", function(p137)
		-- upvalues: (copy) p_u_1, (ref) v_u_109, (ref) v_u_110, (ref) v_u_111
		if p_u_1._started then
			if p137.UserInputType == Enum.UserInputType.MouseButton1 and v_u_109 then
				v_u_109 = false
				v_u_110 = nil
				v_u_111 = 0
			end
		end
	end)
	local function v_u_202(p_u_138, p_u_139, p_u_140)
		-- upvalues: (copy) v_u_4, (copy) p_u_2, (copy) p_u_1, (copy) v_u_10, (copy) v_u_24, (copy) v_u_136, (copy) v_u_29, (copy) v_u_28
		local v201 = {
			["hasState"] = true,
			["hasChildren"] = false,
			["Args"] = {
				["Text"] = 1,
				["Increment"] = 2,
				["Min"] = 3,
				["Max"] = 4,
				["Format"] = 5
			},
			["Events"] = {
				["numberChanged"] = v_u_4,
				["hovered"] = p_u_2.EVENTS.hover(function(p141)
					return p141.Instance
				end)
			},
			["Generate"] = function(p_u_142)
				-- upvalues: (copy) p_u_138, (ref) p_u_1, (ref) p_u_2, (copy) p_u_139, (ref) v_u_10, (ref) v_u_24, (ref) v_u_136
				p_u_142.lastClickedTime = -1
				p_u_142.lastClickedPosition = Vector2.zero
				local v143 = Instance.new("Frame")
				v143.Name = "Iris_Drag" .. p_u_138
				v143.Size = UDim2.new(p_u_1._config.ItemWidth, UDim.new())
				v143.BackgroundTransparency = 1
				v143.BorderSizePixel = 0
				v143.LayoutOrder = p_u_142.ZIndex
				v143.AutomaticSize = Enum.AutomaticSize.Y
				p_u_2.UIListLayout(v143, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
				local v144 = 0
				local v145 = p_u_1._config.TextSize + 2 * p_u_1._config.FramePadding.Y
				if p_u_138 == "Color3" or p_u_138 == "Color4" then
					v144 = v144 + (p_u_1._config.ItemInnerSpacing.X + v145)
					local v146 = Instance.new("ImageLabel")
					v146.Name = "ColorBox"
					v146.BorderSizePixel = 0
					v146.Size = UDim2.fromOffset(v145, v145)
					v146.LayoutOrder = 5
					v146.Image = p_u_2.ICONS.ALPHA_BACKGROUND_TEXTURE
					v146.ImageTransparency = 1
					p_u_2.applyFrameStyle(v146, true)
					v146.Parent = v143
				end
				local v147 = UDim.new(p_u_1._config.ContentWidth.Scale / p_u_139, (p_u_1._config.ContentWidth.Offset - p_u_1._config.ItemInnerSpacing.X * (p_u_139 - 1) - v144) / p_u_139)
				local v148 = UDim.new(v147.Scale * (p_u_139 - 1), v147.Offset * (p_u_139 - 1) + p_u_1._config.ItemInnerSpacing.X * (p_u_139 - 1) + v144)
				local v149 = p_u_1._config.ContentWidth - v148
				for v_u_150 = 1, p_u_139 do
					local v151 = Instance.new("TextButton")
					v151.Name = "DragField" .. tostring(v_u_150)
					v151.LayoutOrder = v_u_150
					if v_u_150 == p_u_139 then
						v151.Size = UDim2.new(v149, p_u_1._config.ContentHeight)
					else
						v151.Size = UDim2.new(v147, p_u_1._config.ContentHeight)
					end
					v151.AutomaticSize = Enum.AutomaticSize.Y
					v151.BackgroundColor3 = p_u_1._config.FrameBgColor
					v151.BackgroundTransparency = p_u_1._config.FrameBgTransparency
					v151.AutoButtonColor = false
					v151.Text = ""
					v151.ClipsDescendants = true
					p_u_2.applyFrameStyle(v151)
					p_u_2.applyTextStyle(v151)
					p_u_2.UISizeConstraint(v151, Vector2.xAxis)
					v151.TextXAlignment = Enum.TextXAlignment.Center
					v151.Parent = v143
					p_u_2.applyInteractionHighlights("Background", v151, v151, {
						["Color"] = p_u_1._config.FrameBgColor,
						["Transparency"] = p_u_1._config.FrameBgTransparency,
						["HoveredColor"] = p_u_1._config.FrameBgHoveredColor,
						["HoveredTransparency"] = p_u_1._config.FrameBgHoveredTransparency,
						["ActiveColor"] = p_u_1._config.FrameBgActiveColor,
						["ActiveTransparency"] = p_u_1._config.FrameBgActiveTransparency
					})
					local v_u_152 = Instance.new("TextBox")
					v_u_152.Name = "InputField"
					v_u_152.Size = UDim2.new(1, 0, 1, 0)
					v_u_152.BackgroundTransparency = 1
					v_u_152.ClearTextOnFocus = false
					v_u_152.TextTruncate = Enum.TextTruncate.AtEnd
					v_u_152.ClipsDescendants = true
					v_u_152.Visible = false
					p_u_2.applyFrameStyle(v_u_152, true)
					p_u_2.applyTextStyle(v_u_152)
					v_u_152.Parent = v151
					v_u_152.FocusLost:Connect(function()
						-- upvalues: (copy) v_u_152, (copy) p_u_142, (ref) p_u_138, (copy) v_u_150, (ref) v_u_10, (ref) v_u_24, (ref) p_u_1
						local v153 = v_u_152.Text
						local v154 = tonumber(v153:match("-?%d*%.?%d*"))
						local v155 = p_u_142.state.number
						local v156 = p_u_142
						if p_u_138 == "Color4" and v_u_150 == 4 then
							v155 = v156.state.transparency
						elseif p_u_138 == "Color3" or p_u_138 == "Color4" then
							v155 = v156.state.color
						end
						if v154 ~= nil then
							if p_u_138 == "Color3" or p_u_138 == "Color4" and not v156.arguments.UseFloats then
								v154 = v154 / 255
							end
							if p_u_142.arguments.Min ~= nil then
								local v157 = v_u_10
								local v158 = p_u_142.arguments.Min
								local v159 = v_u_150
								local v160 = p_u_142.arguments
								v154 = math.max(v154, v157(v158, v159, v160))
							end
							if p_u_142.arguments.Max ~= nil then
								local v161 = v_u_10
								local v162 = p_u_142.arguments.Max
								local v163 = v_u_150
								local v164 = p_u_142.arguments
								v154 = math.min(v154, v161(v162, v163, v164))
							end
							if p_u_142.arguments.Increment then
								local v165 = v154 / v_u_10(p_u_142.arguments.Increment, v_u_150, p_u_142.arguments)
								v154 = math.round(v165) * v_u_10(p_u_142.arguments.Increment, v_u_150, p_u_142.arguments)
							end
							v155:set(v_u_24(v155.value, v_u_150, v154, p_u_142.arguments))
							p_u_142.lastNumberChangedTick = p_u_1._cycleTick + 1
						end
						local v166 = v_u_10(v155.value, v_u_150, p_u_142.arguments)
						if p_u_138 == "Color3" or p_u_138 == "Color4" and not v156.arguments.UseFloats then
							local v167 = v166 * 255
							v166 = math.round(v167)
						end
						local v168 = p_u_142.arguments.Format[v_u_150] or p_u_142.arguments.Format[1]
						if p_u_142.arguments.Prefix then
							v168 = p_u_142.arguments.Prefix[v_u_150] .. v168
						end
						v_u_152.Text = string.format(v168, v166)
						p_u_142.state.editingText:set(0)
						v_u_152:ReleaseFocus(true)
					end)
					v_u_152.Focused:Connect(function()
						-- upvalues: (copy) v_u_152, (copy) p_u_142, (copy) v_u_150
						v_u_152.CursorPosition = #v_u_152.Text + 1
						v_u_152.SelectionStart = 1
						p_u_142.state.editingText:set(v_u_150)
					end)
					p_u_2.applyButtonDown(v151, function(p169, p170)
						-- upvalues: (ref) v_u_136, (copy) p_u_142, (ref) p_u_138, (copy) v_u_150
						v_u_136(p_u_142, p_u_138, v_u_150, p169, p170)
					end)
				end
				local v171 = Instance.new("TextLabel")
				v171.Name = "TextLabel"
				v171.BackgroundTransparency = 1
				v171.BorderSizePixel = 0
				v171.LayoutOrder = 6
				v171.AutomaticSize = Enum.AutomaticSize.XY
				p_u_2.applyTextStyle(v171)
				v171.Parent = v143
				return v143
			end,
			["Update"] = function(p172)
				-- upvalues: (copy) p_u_138, (copy) p_u_139, (ref) v_u_29, (ref) v_u_10, (ref) v_u_28
				p172.Instance.TextLabel.Text = p172.arguments.Text or ("Drag %*"):format(p_u_138)
				if p172.arguments.Format then
					local v173 = p172.arguments.Format
					if typeof(v173) ~= "table" then
						p172.arguments.Format = { p172.arguments.Format }
						return
					end
				end
				if not p172.arguments.Format then
					local v174 = {}
					for v175 = 1, p_u_139 do
						local v176 = v_u_29[p_u_138][v175]
						if p172.arguments.Increment then
							local v177 = v_u_10(p172.arguments.Increment, v175, p172.arguments)
							local v178 = v177 == 0 and 1 or v177
							local v179 = -math.log10(v178)
							local v180 = math.ceil(v179)
							v176 = math.max(v176, v180, v176)
						end
						if p172.arguments.Max then
							local v181 = v_u_10(p172.arguments.Max, v175, p172.arguments)
							local v182 = v181 == 0 and 1 or v181
							local v183 = -math.log10(v182)
							local v184 = math.ceil(v183)
							v176 = math.max(v176, v184, v176)
						end
						if p172.arguments.Min then
							local v185 = v_u_10(p172.arguments.Min, v175, p172.arguments)
							local v186 = v185 == 0 and 1 or v185
							local v187 = -math.log10(v186)
							local v188 = math.ceil(v187)
							v176 = math.max(v176, v188, v176)
						end
						if v176 > 0 then
							v174[v175] = ("%%.%*f"):format(v176)
						else
							v174[v175] = "%d"
						end
					end
					p172.arguments.Format = v174
					p172.arguments.Prefix = v_u_28[p_u_138]
				end
			end,
			["Discard"] = function(p189)
				-- upvalues: (ref) p_u_2
				p189.Instance:Destroy()
				p_u_2.discardState(p189)
			end,
			["GenerateState"] = function(p190)
				-- upvalues: (ref) p_u_1, (copy) p_u_140
				if p190.state.number == nil then
					p190.state.number = p_u_1._widgetState(p190, "number", p_u_140)
				end
				if p190.state.editingText == nil then
					p190.state.editingText = p_u_1._widgetState(p190, "editingText", false)
				end
			end,
			["UpdateState"] = function(p191)
				-- upvalues: (copy) p_u_139, (copy) p_u_138, (ref) v_u_10, (ref) p_u_1
				local v192 = p191.Instance
				for v193 = 1, p_u_139 do
					local v194 = p191.state.number
					if p_u_138 == "Color3" or p_u_138 == "Color4" then
						v194 = p191.state.color
						if v193 == 4 then
							v194 = p191.state.transparency
						end
					end
					local v195 = v192:FindFirstChild("DragField" .. tostring(v193))
					local v196 = v195.InputField
					local v197 = v_u_10(v194.value, v193, p191.arguments)
					if (p_u_138 == "Color3" or p_u_138 == "Color4") and not p191.arguments.UseFloats then
						local v198 = v197 * 255
						v197 = math.round(v198)
					end
					local v199 = p191.arguments.Format[v193] or p191.arguments.Format[1]
					if p191.arguments.Prefix then
						v199 = p191.arguments.Prefix[v193] .. v199
					end
					v195.Text = string.format(v199, v197)
					v196.Text = tostring(v197)
					if p191.state.editingText.value == v193 then
						v196.Visible = true
						v196:CaptureFocus()
						v195.TextTransparency = 1
					else
						v196.Visible = false
						v195.TextTransparency = p_u_1._config.TextTransparency
					end
				end
				if p_u_138 == "Color3" or p_u_138 == "Color4" then
					local v200 = v192.ColorBox
					v200.BackgroundColor3 = p191.state.color.value
					if p_u_138 == "Color4" then
						v200.ImageTransparency = 1 - p191.state.transparency.value
					end
				end
			end
		}
		return v201
	end
	local function v210(p_u_203, ...)
		-- upvalues: (ref) v_u_202, (copy) p_u_2, (copy) v_u_28, (copy) p_u_1
		local v_u_204 = { ... }
		local v205 = v_u_202(p_u_203, p_u_203 == "Color4" and 4 or 3, v_u_204[1])
		local v209 = {
			["Args"] = {
				["Text"] = 1,
				["UseFloats"] = 2,
				["UseHSV"] = 3,
				["Format"] = 4
			},
			["Update"] = function(p206)
				-- upvalues: (copy) p_u_203, (ref) v_u_28, (ref) p_u_1
				p206.Instance.TextLabel.Text = p206.arguments.Text or ("Drag %*"):format(p_u_203)
				if p206.arguments.Format then
					local v207 = p206.arguments.Format
					if typeof(v207) ~= "table" then
						p206.arguments.Format = { p206.arguments.Format }
						::l6::
						p206.arguments.Min = {
							0,
							0,
							0,
							0
						}
						p206.arguments.Max = {
							1,
							1,
							1,
							1
						}
						p206.arguments.Increment = {
							0.001,
							0.001,
							0.001,
							0.001
						}
						if p206.state then
							p206.state.color.lastChangeTick = p_u_1._cycleTick
							if p_u_203 == "Color4" then
								p206.state.transparency.lastChangeTick = p_u_1._cycleTick
							end
							p_u_1._widgets[p206.type].UpdateState(p206)
						end
						return
					end
				end
				if not p206.arguments.Format then
					if p206.arguments.UseFloats then
						p206.arguments.Format = { "%.3f" }
					else
						p206.arguments.Format = { "%d" }
					end
					p206.arguments.Prefix = v_u_28[p_u_203 .. (p206.arguments.UseHSV and "_HSV" or "_RGB")]
				end
				goto l6
			end,
			["GenerateState"] = function(p208)
				-- upvalues: (ref) p_u_1, (copy) v_u_204, (copy) p_u_203
				if p208.state.color == nil then
					p208.state.color = p_u_1._widgetState(p208, "color", v_u_204[1])
				end
				if p_u_203 == "Color4" and p208.state.transparency == nil then
					p208.state.transparency = p_u_1._widgetState(p208, "transparency", v_u_204[2])
				end
				if p208.state.editingText == nil then
					p208.state.editingText = p_u_1._widgetState(p208, "editingText", false)
				end
			end
		}
		return p_u_2.extend(v205, v209)
	end
	local v_u_211 = false
	local v_u_212 = nil
	local v_u_213 = 0
	local v_u_214 = ""
	local function v_u_227()
		-- upvalues: (ref) v_u_211, (ref) v_u_212, (ref) v_u_213, (copy) v_u_10, (copy) v_u_25, (ref) v_u_214, (copy) v_u_26, (copy) v_u_27, (copy) p_u_2, (copy) v_u_24, (copy) p_u_1
		if v_u_211 == false then
			return
		elseif v_u_212 ~= nil then
			local v215 = v_u_213
			local v216 = v_u_212.Instance:FindFirstChild("SliderField" .. tostring(v215))
			local v217 = v216.GrabBar
			local v218 = v_u_212.arguments.Increment and v_u_10(v_u_212.arguments.Increment, v_u_213, v_u_212.arguments) or v_u_25[v_u_214][v_u_213]
			local v219 = v_u_212.arguments.Min and v_u_10(v_u_212.arguments.Min, v_u_213, v_u_212.arguments) or v_u_26[v_u_214][v_u_213]
			local v220 = v_u_212.arguments.Max and v_u_10(v_u_212.arguments.Max, v_u_213, v_u_212.arguments) or v_u_27[v_u_214][v_u_213]
			local v221 = v217.AbsoluteSize.X
			local v222 = (p_u_2.getMouseLocation().X - (v216.AbsolutePosition.X - p_u_2.GuiOffset.X + v221 / 2)) / (v216.AbsoluteSize.X - v221)
			local v223 = (v220 - v219) / v218
			local v224 = v222 * math.floor(v223)
			local v225 = math.round(v224) * v218 + v219
			local v226 = math.clamp(v225, v219, v220)
			v_u_212.state.number:set(v_u_24(v_u_212.state.number.value, v_u_213, v226, v_u_212.arguments))
			v_u_212.lastNumberChangedTick = p_u_1._cycleTick + 1
		end
	end
	local function v_u_231(p228, p229, p230)
		-- upvalues: (copy) p_u_2, (ref) v_u_211, (ref) v_u_212, (ref) v_u_213, (ref) v_u_214, (copy) v_u_227
		if p_u_2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p_u_2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
			p228.state.editingText:set(p230)
		else
			v_u_211 = true
			v_u_212 = p228
			v_u_213 = p230
			v_u_214 = p229
			v_u_227()
		end
	end
	p_u_2.registerEvent("InputChanged", function()
		-- upvalues: (copy) p_u_1, (copy) v_u_227
		if p_u_1._started then
			v_u_227()
		end
	end)
	p_u_2.registerEvent("InputEnded", function(p232)
		-- upvalues: (copy) p_u_1, (ref) v_u_211, (ref) v_u_212, (ref) v_u_213, (ref) v_u_214
		if p_u_1._started then
			if p232.UserInputType == Enum.UserInputType.MouseButton1 and v_u_211 then
				v_u_211 = false
				v_u_212 = nil
				v_u_213 = 0
				v_u_214 = ""
			end
		end
	end)
	local function v310(p_u_233, p_u_234, p_u_235)
		-- upvalues: (copy) v_u_4, (copy) p_u_2, (copy) p_u_1, (copy) v_u_10, (copy) v_u_24, (copy) v_u_231, (copy) v_u_29, (copy) v_u_28, (copy) v_u_25, (copy) v_u_26, (copy) v_u_27
		local v309 = {
			["hasState"] = true,
			["hasChildren"] = false,
			["Args"] = {
				["Text"] = 1,
				["Increment"] = 2,
				["Min"] = 3,
				["Max"] = 4,
				["Format"] = 5
			},
			["Events"] = {
				["numberChanged"] = v_u_4,
				["hovered"] = p_u_2.EVENTS.hover(function(p236)
					return p236.Instance
				end)
			},
			["Generate"] = function(p_u_237)
				-- upvalues: (copy) p_u_233, (ref) p_u_1, (ref) p_u_2, (copy) p_u_234, (ref) v_u_10, (ref) v_u_24, (ref) v_u_231
				local v238 = Instance.new("Frame")
				v238.Name = "Iris_Slider" .. p_u_233
				v238.Size = UDim2.new(p_u_1._config.ItemWidth, UDim.new())
				v238.BackgroundTransparency = 1
				v238.BorderSizePixel = 0
				v238.LayoutOrder = p_u_237.ZIndex
				v238.AutomaticSize = Enum.AutomaticSize.Y
				p_u_2.UIListLayout(v238, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
				local v239 = UDim.new(p_u_1._config.ContentWidth.Scale / p_u_234, (p_u_1._config.ContentWidth.Offset - p_u_1._config.ItemInnerSpacing.X * (p_u_234 - 1)) / p_u_234)
				local v240 = UDim.new(v239.Scale * (p_u_234 - 1), v239.Offset * (p_u_234 - 1) + p_u_1._config.ItemInnerSpacing.X * (p_u_234 - 1))
				local v241 = p_u_1._config.ContentWidth - v240
				for v_u_242 = 1, p_u_234 do
					local v243 = Instance.new("TextButton")
					v243.Name = "SliderField" .. tostring(v_u_242)
					v243.LayoutOrder = v_u_242
					if v_u_242 == p_u_234 then
						v243.Size = UDim2.new(v241, p_u_1._config.ContentHeight)
					else
						v243.Size = UDim2.new(v239, p_u_1._config.ContentHeight)
					end
					v243.AutomaticSize = Enum.AutomaticSize.Y
					v243.BackgroundColor3 = p_u_1._config.FrameBgColor
					v243.BackgroundTransparency = p_u_1._config.FrameBgTransparency
					v243.AutoButtonColor = false
					v243.Text = ""
					v243.ClipsDescendants = true
					p_u_2.applyFrameStyle(v243)
					p_u_2.applyTextStyle(v243)
					p_u_2.UISizeConstraint(v243, Vector2.xAxis)
					v243.Parent = v238
					local v244 = Instance.new("TextLabel")
					v244.Name = "OverlayText"
					v244.Size = UDim2.fromScale(1, 1)
					v244.BackgroundTransparency = 1
					v244.BorderSizePixel = 0
					v244.ZIndex = 10
					v244.ClipsDescendants = true
					p_u_2.applyTextStyle(v244)
					v244.TextXAlignment = Enum.TextXAlignment.Center
					v244.Parent = v243
					p_u_2.applyInteractionHighlights("Background", v243, v243, {
						["Color"] = p_u_1._config.FrameBgColor,
						["Transparency"] = p_u_1._config.FrameBgTransparency,
						["HoveredColor"] = p_u_1._config.FrameBgHoveredColor,
						["HoveredTransparency"] = p_u_1._config.FrameBgHoveredTransparency,
						["ActiveColor"] = p_u_1._config.FrameBgActiveColor,
						["ActiveTransparency"] = p_u_1._config.FrameBgActiveTransparency
					})
					local v_u_245 = Instance.new("TextBox")
					v_u_245.Name = "InputField"
					v_u_245.Size = UDim2.new(1, 0, 1, 0)
					v_u_245.BackgroundTransparency = 1
					v_u_245.ClearTextOnFocus = false
					v_u_245.TextTruncate = Enum.TextTruncate.AtEnd
					v_u_245.ClipsDescendants = true
					v_u_245.Visible = false
					p_u_2.applyFrameStyle(v_u_245, true)
					p_u_2.applyTextStyle(v_u_245)
					v_u_245.Parent = v243
					v_u_245.FocusLost:Connect(function()
						-- upvalues: (copy) v_u_245, (copy) p_u_237, (ref) v_u_10, (copy) v_u_242, (ref) v_u_24, (ref) p_u_1
						local v246 = v_u_245.Text
						local v247 = tonumber(v246:match("-?%d*%.?%d*"))
						if v247 ~= nil then
							if p_u_237.arguments.Min ~= nil then
								local v248 = v_u_10
								local v249 = p_u_237.arguments.Min
								local v250 = v_u_242
								local v251 = p_u_237.arguments
								v247 = math.max(v247, v248(v249, v250, v251))
							end
							if p_u_237.arguments.Max ~= nil then
								local v252 = v_u_10
								local v253 = p_u_237.arguments.Max
								local v254 = v_u_242
								local v255 = p_u_237.arguments
								v247 = math.min(v247, v252(v253, v254, v255))
							end
							if p_u_237.arguments.Increment then
								local v256 = v247 / v_u_10(p_u_237.arguments.Increment, v_u_242, p_u_237.arguments)
								v247 = math.round(v256) * v_u_10(p_u_237.arguments.Increment, v_u_242, p_u_237.arguments)
							end
							p_u_237.state.number:set(v_u_24(p_u_237.state.number.value, v_u_242, v247, p_u_237.arguments))
							p_u_237.lastNumberChangedTick = p_u_1._cycleTick + 1
						end
						local v257 = p_u_237.arguments.Format[v_u_242] or p_u_237.arguments.Format[1]
						if p_u_237.arguments.Prefix then
							v257 = p_u_237.arguments.Prefix[v_u_242] .. v257
						end
						v_u_245.Text = string.format(v257, v_u_10(p_u_237.state.number.value, v_u_242, p_u_237.arguments))
						p_u_237.state.editingText:set(0)
						v_u_245:ReleaseFocus(true)
					end)
					v_u_245.Focused:Connect(function()
						-- upvalues: (copy) v_u_245, (copy) p_u_237, (copy) v_u_242
						v_u_245.CursorPosition = #v_u_245.Text + 1
						v_u_245.SelectionStart = 1
						p_u_237.state.editingText:set(v_u_242)
					end)
					p_u_2.applyButtonDown(v243, function()
						-- upvalues: (ref) v_u_231, (copy) p_u_237, (ref) p_u_233, (copy) v_u_242
						v_u_231(p_u_237, p_u_233, v_u_242)
					end)
					local v258 = Instance.new("Frame")
					v258.Name = "GrabBar"
					v258.ZIndex = 5
					v258.AnchorPoint = Vector2.new(0.5, 0.5)
					v258.Position = UDim2.new(0, 0, 0.5, 0)
					v258.BorderSizePixel = 0
					v258.BackgroundColor3 = p_u_1._config.SliderGrabColor
					v258.Transparency = p_u_1._config.SliderGrabTransparency
					if p_u_1._config.GrabRounding > 0 then
						p_u_2.UICorner(v258, p_u_1._config.GrabRounding)
					end
					p_u_2.UISizeConstraint(v258, Vector2.new(p_u_1._config.GrabMinSize, 0))
					v258.Parent = v243
				end
				local v259 = Instance.new("TextLabel")
				v259.Name = "TextLabel"
				v259.BackgroundTransparency = 1
				v259.BorderSizePixel = 0
				v259.LayoutOrder = 5
				v259.AutomaticSize = Enum.AutomaticSize.XY
				p_u_2.applyTextStyle(v259)
				v259.Parent = v238
				return v238
			end,
			["Update"] = function(p_u_260)
				-- upvalues: (copy) p_u_233, (copy) p_u_234, (ref) v_u_29, (ref) v_u_10, (ref) v_u_28, (ref) v_u_25, (ref) v_u_26, (ref) v_u_27, (ref) p_u_1
				local v261 = p_u_260.Instance
				v261.TextLabel.Text = p_u_260.arguments.Text or ("Slider %*"):format(p_u_233)
				if p_u_260.arguments.Format then
					local v262 = p_u_260.arguments.Format
					if typeof(v262) ~= "table" then
						p_u_260.arguments.Format = { p_u_260.arguments.Format }
						::l6::
						for v263 = 1, p_u_234 do
							local v264 = v261:FindFirstChild("SliderField" .. tostring(v263)).GrabBar
							local v265 = p_u_260.arguments.Increment and v_u_10(p_u_260.arguments.Increment, v263, p_u_260.arguments) or v_u_25[p_u_233][v263]
							local v266 = p_u_260.arguments.Min and v_u_10(p_u_260.arguments.Min, v263, p_u_260.arguments) or v_u_26[p_u_233][v263]
							local v267 = ((p_u_260.arguments.Max and v_u_10(p_u_260.arguments.Max, v263, p_u_260.arguments) or v_u_27[p_u_233][v263]) + 1 - v266) / v265
							local v268 = 1 / math.floor(v267)
							v264.Size = UDim2.new(v268, 0, 1, 0)
						end
						local v_u_269 = #p_u_1._postCycleCallbacks + 1
						local v_u_270 = p_u_1._cycleTick + 1
						p_u_1._postCycleCallbacks[v_u_269] = function()
							-- upvalues: (ref) p_u_1, (copy) v_u_270, (copy) p_u_260, (ref) p_u_233, (copy) v_u_269
							if v_u_270 <= p_u_1._cycleTick then
								if p_u_260.lastCycleTick ~= -1 then
									p_u_260.state.number.lastChangeTick = p_u_1._cycleTick
									p_u_1._widgets[("Slider%*"):format(p_u_233)].UpdateState(p_u_260)
								end
								p_u_1._postCycleCallbacks[v_u_269] = nil
							end
						end
						return
					end
				end
				if not p_u_260.arguments.Format then
					local v271 = {}
					for v272 = 1, p_u_234 do
						local v273 = v_u_29[p_u_233][v272]
						if p_u_260.arguments.Increment then
							local v274 = v_u_10(p_u_260.arguments.Increment, v272, p_u_260.arguments)
							local v275 = v274 == 0 and 1 or v274
							local v276 = -math.log10(v275)
							local v277 = math.ceil(v276)
							v273 = math.max(v273, v277, v273)
						end
						if p_u_260.arguments.Max then
							local v278 = v_u_10(p_u_260.arguments.Max, v272, p_u_260.arguments)
							local v279 = v278 == 0 and 1 or v278
							local v280 = -math.log10(v279)
							local v281 = math.ceil(v280)
							v273 = math.max(v273, v281, v273)
						end
						if p_u_260.arguments.Min then
							local v282 = v_u_10(p_u_260.arguments.Min, v272, p_u_260.arguments)
							local v283 = v282 == 0 and 1 or v282
							local v284 = -math.log10(v283)
							local v285 = math.ceil(v284)
							v273 = math.max(v273, v285, v273)
						end
						if v273 > 0 then
							v271[v272] = ("%%.%*f"):format(v273)
						else
							v271[v272] = "%d"
						end
					end
					p_u_260.arguments.Format = v271
					p_u_260.arguments.Prefix = v_u_28[p_u_233]
				end
				goto l6
			end,
			["Discard"] = function(p286)
				-- upvalues: (ref) p_u_2
				p286.Instance:Destroy()
				p_u_2.discardState(p286)
			end,
			["GenerateState"] = function(p287)
				-- upvalues: (ref) p_u_1, (copy) p_u_235
				if p287.state.number == nil then
					p287.state.number = p_u_1._widgetState(p287, "number", p_u_235)
				end
				if p287.state.editingText == nil then
					p287.state.editingText = p_u_1._widgetState(p287, "editingText", false)
				end
			end,
			["UpdateState"] = function(p288)
				-- upvalues: (copy) p_u_234, (ref) v_u_10, (ref) v_u_25, (copy) p_u_233, (ref) v_u_26, (ref) v_u_27
				local v289 = p288.Instance
				for v290 = 1, p_u_234 do
					local v291 = v289:FindFirstChild("SliderField" .. tostring(v290))
					local v292 = v291.InputField
					local v293 = v291.OverlayText
					local v294 = v291.GrabBar
					local v295 = v_u_10(p288.state.number.value, v290, p288.arguments)
					local v296 = p288.arguments.Format[v290] or p288.arguments.Format[1]
					if p288.arguments.Prefix then
						v296 = p288.arguments.Prefix[v290] .. v296
					end
					v293.Text = string.format(v296, v295)
					v292.Text = tostring(v295)
					local v297 = p288.arguments.Increment and v_u_10(p288.arguments.Increment, v290, p288.arguments) or v_u_25[p_u_233][v290]
					local v298 = p288.arguments.Min and v_u_10(p288.arguments.Min, v290, p288.arguments) or v_u_26[p_u_233][v290]
					local v299 = p288.arguments.Max and v_u_10(p288.arguments.Max, v290, p288.arguments) or v_u_27[p_u_233][v290]
					local v300 = v291.AbsoluteSize.X
					local v301 = v300 - v294.AbsoluteSize.X
					local v302 = (v295 - v298) / (v299 - v298)
					local v303 = (v299 - v298) / v297
					local v304 = math.floor(v303)
					local v305 = v302 * v304
					local v306 = math.floor(v305) / v304
					local v307 = math.clamp(v306, 0, 1)
					local v308 = v301 / v300 * v307 + (1 - v301 / v300) / 2
					v294.Position = UDim2.new(v308, 0, 0.5, 0)
					if p288.state.editingText.value == v290 then
						v292.Visible = true
						v293.Visible = false
						v294.Visible = false
						v292:CaptureFocus()
					else
						v292.Visible = false
						v293.Visible = true
						v294.Visible = true
					end
				end
			end
		}
		return v309
	end
	local v311 = v107("Num", 1, 0)
	v311.Args.NoButtons = 6
	p_u_1.WidgetConstructor("InputNum", v311)
	p_u_1.WidgetConstructor("InputVector2", v107("Vector2", 2, Vector2.zero))
	p_u_1.WidgetConstructor("InputVector3", v107("Vector3", 3, Vector3.new(0, 0, 0)))
	p_u_1.WidgetConstructor("InputUDim", v107("UDim", 2, UDim.new()))
	p_u_1.WidgetConstructor("InputUDim2", v107("UDim2", 4, UDim2.new()))
	p_u_1.WidgetConstructor("InputRect", v107("Rect", 4, Rect.new(0, 0, 0, 0)))
	p_u_1.WidgetConstructor("DragNum", v_u_202("Num", 1, 0))
	p_u_1.WidgetConstructor("DragVector2", v_u_202("Vector2", 2, Vector2.zero))
	p_u_1.WidgetConstructor("DragVector3", v_u_202("Vector3", 3, Vector3.new(0, 0, 0)))
	p_u_1.WidgetConstructor("DragUDim", v_u_202("UDim", 2, UDim.new()))
	p_u_1.WidgetConstructor("DragUDim2", v_u_202("UDim2", 4, UDim2.new()))
	p_u_1.WidgetConstructor("DragRect", v_u_202("Rect", 4, Rect.new(0, 0, 0, 0)))
	p_u_1.WidgetConstructor("InputColor3", v210("Color3", Color3.fromRGB(0, 0, 0)))
	p_u_1.WidgetConstructor("InputColor4", v210("Color4", Color3.fromRGB(0, 0, 0), 0))
	p_u_1.WidgetConstructor("SliderNum", v310("Num", 1, 0))
	p_u_1.WidgetConstructor("SliderVector2", v310("Vector2", 2, Vector2.zero))
	p_u_1.WidgetConstructor("SliderVector3", v310("Vector3", 3, Vector3.new(0, 0, 0)))
	p_u_1.WidgetConstructor("SliderUDim", v310("UDim", 2, UDim.new()))
	p_u_1.WidgetConstructor("SliderUDim2", v310("UDim2", 4, UDim2.new()))
	p_u_1.WidgetConstructor("SliderRect", v310("Rect", 4, Rect.new(0, 0, 0, 0)))
	local v312 = p_u_1.WidgetConstructor
	local v313 = {
		["hasState"] = true,
		["hasChildren"] = false,
		["Args"] = {
			["Text"] = 1,
			["TextHint"] = 2,
			["ReadOnly"] = 3,
			["MultiLine"] = 4
		}
	}
	local v317 = {
		["textChanged"] = {
			["Init"] = function(p314)
				p314.lastTextChangedTick = 0
			end,
			["Get"] = function(p315)
				-- upvalues: (copy) p_u_1
				return p315.lastTextChangedTick == p_u_1._cycleTick
			end
		},
		["hovered"] = p_u_2.EVENTS.hover(function(p316)
			return p316.Instance
		end)
	}
	v313.Events = v317
	function v313.Generate(p_u_318)
		-- upvalues: (copy) p_u_1, (copy) p_u_2
		local v319 = Instance.new("Frame")
		v319.Name = "Iris_InputText"
		v319.AutomaticSize = Enum.AutomaticSize.Y
		v319.Size = UDim2.new(p_u_1._config.ItemWidth, UDim.new())
		v319.BackgroundTransparency = 1
		v319.BorderSizePixel = 0
		v319.ZIndex = p_u_318.ZIndex
		v319.LayoutOrder = p_u_318.ZIndex
		p_u_2.UIListLayout(v319, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
		local v_u_320 = Instance.new("TextBox")
		v_u_320.Name = "InputField"
		v_u_320.Size = UDim2.new(p_u_1._config.ContentWidth, p_u_1._config.ContentHeight)
		v_u_320.AutomaticSize = Enum.AutomaticSize.Y
		v_u_320.BackgroundColor3 = p_u_1._config.FrameBgColor
		v_u_320.BackgroundTransparency = p_u_1._config.FrameBgTransparency
		v_u_320.Text = ""
		v_u_320.TextYAlignment = Enum.TextYAlignment.Top
		v_u_320.PlaceholderColor3 = p_u_1._config.TextDisabledColor
		v_u_320.ClearTextOnFocus = false
		v_u_320.ClipsDescendants = true
		p_u_2.applyFrameStyle(v_u_320)
		p_u_2.applyTextStyle(v_u_320)
		p_u_2.UISizeConstraint(v_u_320, Vector2.xAxis)
		v_u_320.Parent = v319
		v_u_320.FocusLost:Connect(function()
			-- upvalues: (copy) p_u_318, (copy) v_u_320, (ref) p_u_1
			p_u_318.state.text:set(v_u_320.Text)
			p_u_318.lastTextChangedTick = p_u_1._cycleTick + 1
		end)
		local v321 = p_u_1._config.TextSize + 2 * p_u_1._config.FramePadding.Y
		local v322 = Instance.new("TextLabel")
		v322.Name = "TextLabel"
		v322.Size = UDim2.fromOffset(0, v321)
		v322.AutomaticSize = Enum.AutomaticSize.X
		v322.BackgroundTransparency = 1
		v322.BorderSizePixel = 0
		v322.LayoutOrder = 1
		p_u_2.applyTextStyle(v322)
		v322.Parent = v319
		return v319
	end
	function v313.Update(p323)
		local v324 = p323.Instance
		local v325 = v324.TextLabel
		local v326 = v324.InputField
		v325.Text = p323.arguments.Text or "Input Text"
		v326.PlaceholderText = p323.arguments.TextHint or ""
		v326.TextEditable = not p323.arguments.ReadOnly
		v326.MultiLine = p323.arguments.MultiLine or false
	end
	function v313.Discard(p327)
		-- upvalues: (copy) p_u_2
		p327.Instance:Destroy()
		p_u_2.discardState(p327)
	end
	function v313.GenerateState(p328)
		-- upvalues: (copy) p_u_1
		if p328.state.text == nil then
			p328.state.text = p_u_1._widgetState(p328, "text", "")
		end
	end
	function v313.UpdateState(p329)
		p329.Instance.InputField.Text = p329.state.text.value
	end
	v312("InputText", v313)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Input]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3462"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p_u_1, p_u_2)
	local v_u_3 = false
	local v_u_4 = nil
	local v_u_5 = {}
	local function v_u_9(p6)
		-- upvalues: (copy) v_u_5, (copy) p_u_1, (ref) v_u_3, (ref) v_u_4
		for v7 = #v_u_5, p6 and p6 + 1 or 1, -1 do
			local v8 = v_u_5[v7]
			v8.state.isOpened:set(false)
			v8.Instance.BackgroundColor3 = p_u_1._config.HeaderColor
			v8.Instance.BackgroundTransparency = 1
			table.remove(v_u_5, v7)
		end
		if #v_u_5 == 0 then
			v_u_3 = false
			v_u_4 = nil
		end
	end
	local function v_u_22(p10)
		-- upvalues: (copy) p_u_2, (copy) p_u_1
		local v11 = p10.parentWidget.type == "Menu"
		local v12 = p10.Instance
		local v13 = p10.ChildContainer
		v13.Size = UDim2.fromOffset(v12.AbsoluteSize.X, 0)
		if v13.Parent ~= nil then
			local v14 = v12.AbsolutePosition - p_u_2.GuiOffset
			local v15 = v12.AbsoluteSize
			local v16 = v13.AbsoluteSize
			local v17 = p_u_1._config.PopupBorderSize
			local v18 = v13.Parent.AbsoluteSize
			local v19 = v14.X
			local v20 = Vector2.zero
			if v11 then
				if v14.X + v16.X > v18.X then
					v20 = Vector2.xAxis
				else
					v19 = v14.X + v15.X
				end
			end
			local v21
			if v14.Y + v16.Y > v18.Y then
				v21 = v14.Y - v17 + (v11 and v15.Y or 0)
				v20 = v20 + Vector2.yAxis
			else
				v21 = v14.Y + v17 + (v11 and 0 or v15.Y)
			end
			v13.Position = UDim2.fromOffset(v19, v21)
			v13.AnchorPoint = v20
		end
	end
	p_u_2.registerEvent("InputBegan", function(p23)
		-- upvalues: (copy) p_u_1, (ref) v_u_3, (ref) v_u_4, (copy) p_u_2, (copy) v_u_5, (copy) v_u_9
		if not p_u_1._started then
			return
		end
		if p23.UserInputType ~= Enum.UserInputType.MouseButton1 and p23.UserInputType ~= Enum.UserInputType.MouseButton2 then
			return
		end
		if v_u_3 == false then
			return
		end
		if v_u_4 == nil then
			return
		end
		local v24 = p_u_2.getMouseLocation()
		local v25 = false
		for _, v26 in v_u_5 do
			for _, v27 in { v26.ChildContainer, v26.Instance } do
				local v28 = v27.AbsolutePosition - p_u_2.GuiOffset
				local v29 = v28 + v27.AbsoluteSize
				if p_u_2.isPosInsideRect(v24, v28, v29) then
					v25 = true
					break
				end
			end
			if v25 then
				break
			end
		end
		if not v25 then
			v_u_9()
		end
	end)
	p_u_1.WidgetConstructor("MenuBar", {
		["hasState"] = false,
		["hasChildren"] = true,
		["Args"] = {},
		["Events"] = {},
		["Generate"] = function(p30)
			-- upvalues: (copy) p_u_1, (copy) p_u_2
			local v31 = Instance.new("Frame")
			v31.Name = "Iris_MenuBar"
			v31.Size = UDim2.fromScale(1, 0)
			v31.AutomaticSize = Enum.AutomaticSize.Y
			v31.BackgroundColor3 = p_u_1._config.MenubarBgColor
			v31.BackgroundTransparency = p_u_1._config.MenubarBgTransparency
			v31.BorderSizePixel = 0
			v31.LayoutOrder = p30.ZIndex
			v31.ClipsDescendants = true
			p_u_2.UIPadding(v31, Vector2.new(p_u_1._config.WindowPadding.X, 1))
			p_u_2.UIListLayout(v31, Enum.FillDirection.Horizontal, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Center
			p_u_2.applyFrameStyle(v31, true, true)
			return v31
		end,
		["Update"] = function(_) end,
		["ChildAdded"] = function(p32, _)
			return p32.Instance
		end,
		["Discard"] = function(p33)
			p33.Instance:Destroy()
		end
	})
	local v34 = p_u_1.WidgetConstructor
	local v35 = {
		["hasState"] = true,
		["hasChildren"] = true,
		["Args"] = {
			["Text"] = 1
		}
	}
	local v40 = {
		["clicked"] = p_u_2.EVENTS.click(function(p36)
			return p36.Instance
		end),
		["hovered"] = p_u_2.EVENTS.hover(function(p37)
			return p37.Instance
		end),
		["opened"] = {
			["Init"] = function(_) end,
			["Get"] = function(p38)
				-- upvalues: (copy) p_u_1
				return p38.lastOpenedTick == p_u_1._cycleTick
			end
		},
		["closed"] = {
			["Init"] = function(_) end,
			["Get"] = function(p39)
				-- upvalues: (copy) p_u_1
				return p39.lastClosedTick == p_u_1._cycleTick
			end
		}
	}
	v35.Events = v40
	function v35.Generate(p_u_41)
		-- upvalues: (copy) p_u_1, (copy) p_u_2, (copy) v_u_5, (ref) v_u_3, (ref) v_u_4, (copy) v_u_9
		p_u_41.ButtonColors = {
			["Color"] = p_u_1._config.HeaderColor,
			["Transparency"] = 1,
			["HoveredColor"] = p_u_1._config.HeaderHoveredColor,
			["HoveredTransparency"] = p_u_1._config.HeaderHoveredTransparency,
			["ActiveColor"] = p_u_1._config.HeaderHoveredColor,
			["ActiveTransparency"] = p_u_1._config.HeaderHoveredTransparency
		}
		local v42
		if p_u_41.parentWidget.type == "Menu" then
			v42 = Instance.new("TextButton")
			v42.Name = "Menu"
			v42.BackgroundColor3 = p_u_1._config.HeaderColor
			v42.BackgroundTransparency = 1
			v42.BorderSizePixel = 0
			v42.Size = UDim2.fromScale(1, 0)
			v42.Text = ""
			v42.AutomaticSize = Enum.AutomaticSize.Y
			v42.LayoutOrder = p_u_41.ZIndex
			v42.AutoButtonColor = false
			local v43 = p_u_2.UIPadding(v42, p_u_1._config.FramePadding)
			v43.PaddingTop = v43.PaddingTop - UDim.new(0, 1)
			p_u_2.UIListLayout(v42, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local v44 = Instance.new("TextLabel")
			v44.Name = "TextLabel"
			v44.BackgroundTransparency = 1
			v44.BorderSizePixel = 0
			v44.AutomaticSize = Enum.AutomaticSize.XY
			p_u_2.applyTextStyle(v44)
			v44.Parent = v42
			local v45 = p_u_1._config.TextSize + 2 * p_u_1._config.FramePadding.Y
			local v46 = v45 * 0.2
			local v47 = v45 - math.round(v46) * 2
			local v48 = Instance.new("ImageLabel")
			v48.Name = "Icon"
			v48.Size = UDim2.fromOffset(v47, v47)
			v48.BackgroundTransparency = 1
			v48.BorderSizePixel = 0
			v48.ImageColor3 = p_u_1._config.TextColor
			v48.ImageTransparency = p_u_1._config.TextTransparency
			v48.Image = p_u_2.ICONS.RIGHT_POINTING_TRIANGLE
			v48.LayoutOrder = 1
			v48.Parent = v42
		else
			v42 = Instance.new("TextButton")
			v42.Name = "Menu"
			v42.AutomaticSize = Enum.AutomaticSize.XY
			v42.Size = UDim2.fromScale(0, 0)
			v42.BackgroundColor3 = p_u_1._config.HeaderColor
			v42.BackgroundTransparency = 1
			v42.BorderSizePixel = 0
			v42.Text = ""
			v42.LayoutOrder = p_u_41.ZIndex
			v42.AutoButtonColor = false
			v42.ClipsDescendants = true
			p_u_2.applyTextStyle(v42)
			p_u_2.UIPadding(v42, Vector2.new(p_u_1._config.ItemSpacing.X, p_u_1._config.FramePadding.Y))
		end
		p_u_2.applyInteractionHighlights("Background", v42, v42, p_u_41.ButtonColors)
		p_u_2.applyButtonClick(v42, function()
			-- upvalues: (ref) v_u_5, (copy) p_u_41, (ref) v_u_3, (ref) v_u_4
			local v49 = #v_u_5 > 1 and true or not p_u_41.state.isOpened.value
			p_u_41.state.isOpened:set(v49)
			v_u_3 = v49
			v_u_4 = v49 and p_u_41 or nil
			if #v_u_5 <= 1 then
				if v49 then
					local v50 = v_u_5
					local v51 = p_u_41
					table.insert(v50, v51)
					return
				end
				table.remove(v_u_5)
			end
		end)
		p_u_2.applyMouseEnter(v42, function()
			-- upvalues: (ref) v_u_3, (ref) v_u_4, (copy) p_u_41, (ref) v_u_5, (ref) v_u_9
			if v_u_3 and (v_u_4 and v_u_4 ~= p_u_41) then
				local v52 = p_u_41.parentWidget
				v_u_9((table.find(v_u_5, v52)))
				p_u_41.state.isOpened:set(true)
				v_u_4 = p_u_41
				v_u_3 = true
				local v53 = v_u_5
				local v54 = p_u_41
				table.insert(v53, v54)
			end
		end)
		local v55 = Instance.new("ScrollingFrame")
		v55.Name = "MenuContainer"
		v55.BackgroundColor3 = p_u_1._config.PopupBgColor
		v55.BackgroundTransparency = p_u_1._config.PopupBgTransparency
		v55.BorderSizePixel = 0
		v55.Size = UDim2.fromOffset(0, 0)
		v55.AutomaticSize = Enum.AutomaticSize.XY
		v55.AutomaticCanvasSize = Enum.AutomaticSize.Y
		v55.ScrollBarImageTransparency = p_u_1._config.ScrollbarGrabTransparency
		v55.ScrollBarImageColor3 = p_u_1._config.ScrollbarGrabColor
		v55.ScrollBarThickness = p_u_1._config.ScrollbarSize
		v55.CanvasSize = UDim2.fromScale(0, 0)
		v55.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
		v55.TopImage = p_u_2.ICONS.BLANK_SQUARE
		v55.MidImage = p_u_2.ICONS.BLANK_SQUARE
		v55.BottomImage = p_u_2.ICONS.BLANK_SQUARE
		v55.ZIndex = 6
		v55.LayoutOrder = 6
		v55.ClipsDescendants = true
		p_u_2.UIStroke(v55, p_u_1._config.WindowBorderSize, p_u_1._config.BorderColor, p_u_1._config.BorderTransparency)
		p_u_2.UIPadding(v55, Vector2.new(2, p_u_1._config.WindowPadding.Y - p_u_1._config.ItemSpacing.Y))
		p_u_2.UIListLayout(v55, Enum.FillDirection.Vertical, UDim.new(0, 1)).VerticalAlignment = Enum.VerticalAlignment.Top
		local v56 = p_u_1._rootInstance
		if v56 then
			v56 = p_u_1._rootInstance:FindFirstChild("PopupScreenGui")
		end
		v55.Parent = v56
		p_u_41.ChildContainer = v55
		return v42
	end
	function v35.Update(p57)
		local v58 = p57.Instance
		if p57.parentWidget.type == "Menu" then
			v58 = v58.TextLabel
		end
		v58.Text = p57.arguments.Text or "Menu"
	end
	function v35.ChildAdded(p59, _)
		-- upvalues: (copy) v_u_22
		v_u_22(p59)
		return p59.ChildContainer
	end
	function v35.ChildDiscarded(p60, _)
		-- upvalues: (copy) v_u_22
		v_u_22(p60)
	end
	function v35.GenerateState(p61)
		-- upvalues: (copy) p_u_1
		if p61.state.isOpened == nil then
			p61.state.isOpened = p_u_1._widgetState(p61, "isOpened", false)
		end
	end
	function v35.UpdateState(p62)
		-- upvalues: (copy) p_u_1, (copy) v_u_22
		local v63 = p62.ChildContainer
		if p62.state.isOpened.value then
			p62.lastOpenedTick = p_u_1._cycleTick + 1
			p62.ButtonColors.Transparency = p_u_1._config.HeaderTransparency
			v63.Visible = true
			v_u_22(p62)
		else
			p62.lastClosedTick = p_u_1._cycleTick + 1
			p62.ButtonColors.Transparency = 1
			v63.Visible = false
		end
	end
	function v35.Discard(p64)
		-- upvalues: (ref) v_u_3, (copy) v_u_5, (copy) v_u_9, (ref) v_u_4, (copy) p_u_2
		if v_u_3 then
			local v65 = p64.parentWidget
			local v66 = table.find(v_u_5, v65)
			if v66 then
				v_u_9(v66)
				if #v_u_5 ~= 0 then
					v_u_4 = v65
					v_u_3 = true
				end
			end
		end
		p64.Instance:Destroy()
		p64.ChildContainer:Destroy()
		p_u_2.discardState(p64)
	end
	v34("Menu", v35)
	local v67 = p_u_1.WidgetConstructor
	local v81 = {
		["hasState"] = false,
		["hasChildren"] = false,
		["Args"] = {
			["Text"] = 1,
			["KeyCode"] = 2,
			["ModifierKey"] = 3
		},
		["Events"] = {
			["clicked"] = p_u_2.EVENTS.click(function(p68)
				return p68.Instance
			end),
			["hovered"] = p_u_2.EVENTS.hover(function(p69)
				return p69.Instance
			end)
		},
		["Generate"] = function(p_u_70)
			-- upvalues: (copy) p_u_2, (copy) p_u_1, (copy) v_u_9, (ref) v_u_3, (ref) v_u_4, (copy) v_u_5
			local v71 = Instance.new("TextButton")
			v71.Name = "MenuItem"
			v71.BackgroundTransparency = 1
			v71.BorderSizePixel = 0
			v71.Size = UDim2.fromScale(1, 0)
			v71.Text = ""
			v71.AutomaticSize = Enum.AutomaticSize.Y
			v71.LayoutOrder = p_u_70.ZIndex
			v71.AutoButtonColor = false
			local v72 = p_u_2.UIPadding(v71, p_u_1._config.FramePadding)
			v72.PaddingTop = v72.PaddingTop - UDim.new(0, 1)
			p_u_2.UIListLayout(v71, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X))
			p_u_2.applyInteractionHighlights("Background", v71, v71, {
				["Color"] = p_u_1._config.HeaderColor,
				["Transparency"] = 1,
				["HoveredColor"] = p_u_1._config.HeaderHoveredColor,
				["HoveredTransparency"] = p_u_1._config.HeaderHoveredTransparency,
				["ActiveColor"] = p_u_1._config.HeaderHoveredColor,
				["ActiveTransparency"] = p_u_1._config.HeaderHoveredTransparency
			})
			p_u_2.applyButtonClick(v71, function()
				-- upvalues: (ref) v_u_9
				v_u_9()
			end)
			p_u_2.applyMouseEnter(v71, function()
				-- upvalues: (copy) p_u_70, (ref) v_u_3, (ref) v_u_4, (ref) v_u_5, (ref) v_u_9
				local v73 = p_u_70.parentWidget
				if v_u_3 and (v_u_4 and v_u_4 ~= v73) then
					v_u_9((table.find(v_u_5, v73)))
					v_u_4 = v73
					v_u_3 = true
				end
			end)
			local v74 = Instance.new("TextLabel")
			v74.Name = "TextLabel"
			v74.BackgroundTransparency = 1
			v74.BorderSizePixel = 0
			v74.AutomaticSize = Enum.AutomaticSize.XY
			p_u_2.applyTextStyle(v74)
			v74.Parent = v71
			local v75 = Instance.new("TextLabel")
			v75.Name = "Shortcut"
			v75.BackgroundTransparency = 1
			v75.BorderSizePixel = 0
			v75.LayoutOrder = 1
			v75.AutomaticSize = Enum.AutomaticSize.XY
			p_u_2.applyTextStyle(v75)
			v75.Text = ""
			v75.TextColor3 = p_u_1._config.TextDisabledColor
			v75.TextTransparency = p_u_1._config.TextDisabledTransparency
			v75.Parent = v71
			return v71
		end,
		["Update"] = function(p76)
			local v77 = p76.Instance
			local v78 = v77.TextLabel
			local v79 = v77.Shortcut
			v78.Text = p76.arguments.Text
			if p76.arguments.KeyCode then
				if p76.arguments.ModifierKey then
					v79.Text = p76.arguments.ModifierKey.Name .. " + " .. p76.arguments.KeyCode.Name
					return
				end
				v79.Text = p76.arguments.KeyCode.Name
			end
		end,
		["Discard"] = function(p80)
			p80.Instance:Destroy()
		end
	}
	v67("MenuItem", v81)
	local v82 = p_u_1.WidgetConstructor
	local v83 = {
		["hasState"] = true,
		["hasChildren"] = false,
		["Args"] = {
			["Text"] = 1,
			["KeyCode"] = 2,
			["ModifierKey"] = 3
		}
	}
	local v87 = {
		["checked"] = {
			["Init"] = function(_) end,
			["Get"] = function(p84)
				-- upvalues: (copy) p_u_1
				return p84.lastCheckedTick == p_u_1._cycleTick
			end
		},
		["unchecked"] = {
			["Init"] = function(_) end,
			["Get"] = function(p85)
				-- upvalues: (copy) p_u_1
				return p85.lastUncheckedTick == p_u_1._cycleTick
			end
		},
		["hovered"] = p_u_2.EVENTS.hover(function(p86)
			return p86.Instance
		end)
	}
	v83.Events = v87
	function v83.Generate(p_u_88)
		-- upvalues: (copy) p_u_2, (copy) p_u_1, (copy) v_u_9, (ref) v_u_3, (ref) v_u_4, (copy) v_u_5
		local v89 = Instance.new("TextButton")
		v89.Name = "MenuItem"
		v89.BackgroundTransparency = 1
		v89.BorderSizePixel = 0
		v89.Size = UDim2.fromScale(1, 0)
		v89.Text = ""
		v89.AutomaticSize = Enum.AutomaticSize.Y
		v89.LayoutOrder = p_u_88.ZIndex
		v89.AutoButtonColor = false
		local v90 = p_u_2.UIPadding(v89, p_u_1._config.FramePadding)
		v90.PaddingTop = v90.PaddingTop - UDim.new(0, 1)
		p_u_2.UIListLayout(v89, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
		p_u_2.applyInteractionHighlights("Background", v89, v89, {
			["Color"] = p_u_1._config.HeaderColor,
			["Transparency"] = 1,
			["HoveredColor"] = p_u_1._config.HeaderHoveredColor,
			["HoveredTransparency"] = p_u_1._config.HeaderHoveredTransparency,
			["ActiveColor"] = p_u_1._config.HeaderHoveredColor,
			["ActiveTransparency"] = p_u_1._config.HeaderHoveredTransparency
		})
		p_u_2.applyButtonClick(v89, function()
			-- upvalues: (copy) p_u_88, (ref) v_u_9
			local v91 = p_u_88.state.isChecked.value
			p_u_88.state.isChecked:set(not v91)
			v_u_9()
		end)
		p_u_2.applyMouseEnter(v89, function()
			-- upvalues: (copy) p_u_88, (ref) v_u_3, (ref) v_u_4, (ref) v_u_5, (ref) v_u_9
			local v92 = p_u_88.parentWidget
			if v_u_3 and (v_u_4 and v_u_4 ~= v92) then
				v_u_9((table.find(v_u_5, v92)))
				v_u_4 = v92
				v_u_3 = true
			end
		end)
		local v93 = Instance.new("TextLabel")
		v93.Name = "TextLabel"
		v93.BackgroundTransparency = 1
		v93.BorderSizePixel = 0
		v93.AutomaticSize = Enum.AutomaticSize.XY
		p_u_2.applyTextStyle(v93)
		v93.Parent = v89
		local v94 = Instance.new("TextLabel")
		v94.Name = "Shortcut"
		v94.BackgroundTransparency = 1
		v94.BorderSizePixel = 0
		v94.LayoutOrder = 1
		v94.AutomaticSize = Enum.AutomaticSize.XY
		p_u_2.applyTextStyle(v94)
		v94.Text = ""
		v94.TextColor3 = p_u_1._config.TextDisabledColor
		v94.TextTransparency = p_u_1._config.TextDisabledTransparency
		v94.Parent = v89
		local v95 = p_u_1._config.TextSize + 2 * p_u_1._config.FramePadding.Y
		local v96 = v95 * 0.2
		local v97 = v95 - math.round(v96) * 2
		local v98 = Instance.new("ImageLabel")
		v98.Name = "Icon"
		v98.Size = UDim2.fromOffset(v97, v97)
		v98.BackgroundTransparency = 1
		v98.BorderSizePixel = 0
		v98.ImageColor3 = p_u_1._config.TextColor
		v98.ImageTransparency = p_u_1._config.TextTransparency
		v98.Image = p_u_2.ICONS.CHECK_MARK
		v98.LayoutOrder = 2
		v98.Parent = v89
		return v89
	end
	function v83.GenerateState(p99)
		-- upvalues: (copy) p_u_1
		if p99.state.isChecked == nil then
			p99.state.isChecked = p_u_1._widgetState(p99, "isChecked", false)
		end
	end
	function v83.Update(p100)
		local v101 = p100.Instance
		local v102 = v101.TextLabel
		local v103 = v101.Shortcut
		v102.Text = p100.arguments.Text
		if p100.arguments.KeyCode then
			if p100.arguments.ModifierKey then
				v103.Text = p100.arguments.ModifierKey.Name .. " + " .. p100.arguments.KeyCode.Name
				return
			end
			v103.Text = p100.arguments.KeyCode.Name
		end
	end
	function v83.UpdateState(p104)
		-- upvalues: (copy) p_u_2, (copy) p_u_1
		local v105 = p104.Instance.Icon
		if p104.state.isChecked.value then
			v105.Image = p_u_2.ICONS.CHECK_MARK
			p104.lastCheckedTick = p_u_1._cycleTick + 1
		else
			v105.Image = ""
			p104.lastUncheckedTick = p_u_1._cycleTick + 1
		end
	end
	function v83.Discard(p106)
		-- upvalues: (copy) p_u_2
		p106.Instance:Destroy()
		p_u_2.discardState(p106)
	end
	v82("MenuToggle", v83)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Menu]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3463"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p_u_1, p_u_2)
	local v3 = p_u_1.WidgetConstructor
	local v4 = {
		["hasState"] = true,
		["hasChildren"] = false,
		["Args"] = {
			["Text"] = 1,
			["Format"] = 2
		}
	}
	local v7 = {
		["hovered"] = p_u_2.EVENTS.hover(function(p5)
			return p5.Instance
		end),
		["changed"] = {
			["Init"] = function(_) end,
			["Get"] = function(p6)
				-- upvalues: (copy) p_u_1
				return p6.lastChangedTick == p_u_1._cycleTick
			end
		}
	}
	v4.Events = v7
	function v4.Generate(p8)
		-- upvalues: (copy) p_u_1, (copy) p_u_2
		local v9 = Instance.new("Frame")
		v9.Name = "Iris_ProgressBar"
		v9.Size = UDim2.new(p_u_1._config.ItemWidth, UDim.new())
		v9.BackgroundTransparency = 1
		v9.AutomaticSize = Enum.AutomaticSize.Y
		v9.LayoutOrder = p8.ZIndex
		p_u_2.UIListLayout(v9, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
		local v10 = Instance.new("Frame")
		v10.Name = "Bar"
		v10.Size = UDim2.new(p_u_1._config.ContentWidth, p_u_1._config.ContentHeight)
		v10.BackgroundColor3 = p_u_1._config.FrameBgColor
		v10.BackgroundTransparency = p_u_1._config.FrameBgTransparency
		v10.BorderSizePixel = 0
		v10.AutomaticSize = Enum.AutomaticSize.Y
		v10.ClipsDescendants = true
		p_u_2.applyFrameStyle(v10, true)
		v10.Parent = v9
		local v11 = Instance.new("TextLabel")
		v11.Name = "Progress"
		v11.AutomaticSize = Enum.AutomaticSize.Y
		v11.Size = UDim2.new(UDim.new(0, 0), p_u_1._config.ContentHeight)
		v11.BackgroundColor3 = p_u_1._config.PlotHistogramColor
		v11.BackgroundTransparency = p_u_1._config.PlotHistogramTransparency
		v11.BorderSizePixel = 0
		p_u_2.applyTextStyle(v11)
		p_u_2.UIPadding(v11, p_u_1._config.FramePadding)
		p_u_2.UICorner(v11, p_u_1._config.FrameRounding)
		v11.Text = ""
		v11.Parent = v10
		local v12 = Instance.new("TextLabel")
		v12.Name = "Value"
		v12.AutomaticSize = Enum.AutomaticSize.XY
		v12.Size = UDim2.new(UDim.new(0, 0), p_u_1._config.ContentHeight)
		v12.BackgroundTransparency = 1
		v12.BorderSizePixel = 0
		v12.ZIndex = 1
		p_u_2.applyTextStyle(v12)
		p_u_2.UIPadding(v12, p_u_1._config.FramePadding)
		v12.Parent = v10
		local v13 = Instance.new("TextLabel")
		v13.Name = "TextLabel"
		v13.AutomaticSize = Enum.AutomaticSize.XY
		v13.AnchorPoint = Vector2.new(0, 0.5)
		v13.BackgroundTransparency = 1
		v13.BorderSizePixel = 0
		v13.LayoutOrder = 1
		p_u_2.applyTextStyle(v13)
		p_u_2.UIPadding(v12, p_u_1._config.FramePadding)
		v13.Parent = v9
		return v9
	end
	function v4.GenerateState(p14)
		-- upvalues: (copy) p_u_1
		if p14.state.progress == nil then
			p14.state.progress = p_u_1._widgetState(p14, "Progress", 0)
		end
	end
	function v4.Update(p15)
		local v16 = p15.Instance
		local v17 = v16.TextLabel
		local v18 = v16.Bar.Value
		if p15.arguments.Format ~= nil then
			local v19 = p15.arguments.Format
			if typeof(v19) == "string" then
				v18.Text = p15.arguments.Format
			end
		end
		v17.Text = p15.arguments.Text or "Progress Bar"
	end
	function v4.UpdateState(p20)
		-- upvalues: (copy) p_u_1
		local v21 = p20.Instance.Bar
		local v22 = v21.Progress
		local v23 = v21.Value
		local v24 = p20.state.progress.value
		local v25 = math.clamp(v24, 0, 1)
		local v26 = v21.AbsoluteSize.X
		if v23.AbsoluteSize.X > v26 * (1 - v25) then
			v23.AnchorPoint = Vector2.xAxis
			v23.Position = UDim2.fromScale(1, 0)
		else
			v23.AnchorPoint = Vector2.zero
			v23.Position = UDim2.new(v25, 0, 0, 0)
		end
		v22.Size = UDim2.new(UDim.new(v25, 0), v22.Size.Height)
		if p20.arguments.Format ~= nil then
			local v27 = p20.arguments.Format
			if typeof(v27) == "string" then
				v23.Text = p20.arguments.Format
				::l7::
				p20.lastChangedTick = p_u_1._cycleTick + 1
				return
			end
		end
		v23.Text = string.format("%d%%", v25 * 100)
		goto l7
	end
	function v4.Discard(p28)
		-- upvalues: (copy) p_u_2
		p28.Instance:Destroy()
		p_u_2.discardState(p28)
	end
	v3("ProgressBar", v4)
	local function v_u_39(p29, p30)
		-- upvalues: (copy) p_u_2, (copy) p_u_1
		local v31 = p29.Instance.Background.Plot
		local v32 = p_u_2.getMouseLocation()
		local v33 = v31.AbsolutePosition - p_u_2.GuiOffset
		local v34 = (v32.X - v33.X) / v31.AbsoluteSize.X * #p29.Lines
		local v35 = math.ceil(v34)
		local v36 = p29.Lines[v35]
		if v36 then
			if v36 ~= p29.HoveredLine and (not p30 and p29.HoveredLine) then
				p29.HoveredLine.BackgroundColor3 = p_u_1._config.PlotLinesColor
				p29.HoveredLine.BackgroundTransparency = p_u_1._config.PlotLinesTransparency
				p29.HoveredLine = false
				p29.state.hovered:set(nil)
			end
			local v37 = p29.state.values.value[v35]
			local v38 = p29.state.values.value[v35 + 1]
			if v37 and v38 then
				if math.floor(v37) == v37 and math.floor(v38) == v38 then
					p29.Tooltip.Text = ("%d: %d\n%d: %d"):format(v35, v37, v35 + 1, v38)
				else
					p29.Tooltip.Text = ("%d: %.3f\n%d: %.3f"):format(v35, v37, v35 + 1, v38)
				end
			end
			p29.HoveredLine = v36
			v36.BackgroundColor3 = p_u_1._config.PlotLinesHoveredColor
			v36.BackgroundTransparency = p_u_1._config.PlotLinesHoveredTransparency
			if p30 then
				p29.state.hovered.value = { v37, v38 }
				return
			end
			p29.state.hovered:set({ v37, v38 })
		end
	end
	local v40 = p_u_1.WidgetConstructor
	local v80 = {
		["hasState"] = true,
		["hasChildren"] = false,
		["Args"] = {
			["Text"] = 1,
			["Height"] = 2,
			["Min"] = 3,
			["Max"] = 4,
			["TextOverlay"] = 5
		},
		["Events"] = {
			["hovered"] = p_u_2.EVENTS.hover(function(p41)
				return p41.Instance
			end)
		},
		["Generate"] = function(p_u_42)
			-- upvalues: (copy) p_u_1, (copy) p_u_2, (copy) v_u_39
			local v43 = Instance.new("Frame")
			v43.Name = "Iris_PlotLines"
			v43.Size = UDim2.new(p_u_1._config.ItemWidth, UDim.new())
			v43.BackgroundTransparency = 1
			v43.BorderSizePixel = 0
			v43.ZIndex = p_u_42.ZIndex
			v43.LayoutOrder = p_u_42.ZIndex
			p_u_2.UIListLayout(v43, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local v44 = Instance.new("Frame")
			v44.Name = "Background"
			v44.Size = UDim2.new(p_u_1._config.ContentWidth, UDim.new(1, 0))
			v44.BackgroundColor3 = p_u_1._config.FrameBgColor
			v44.BackgroundTransparency = p_u_1._config.FrameBgTransparency
			p_u_2.applyFrameStyle(v44)
			v44.Parent = v43
			local v45 = Instance.new("Frame")
			v45.Name = "Plot"
			v45.Size = UDim2.fromScale(1, 1)
			v45.BackgroundTransparency = 1
			v45.BorderSizePixel = 0
			v45.ClipsDescendants = true
			v45:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				-- upvalues: (copy) p_u_42, (ref) p_u_1
				p_u_42.state.values.lastChangeTick = p_u_1._cycleTick
				p_u_1._widgets.PlotLines.UpdateState(p_u_42)
			end)
			local v46 = Instance.new("TextLabel")
			v46.Name = "OverlayText"
			v46.AutomaticSize = Enum.AutomaticSize.XY
			v46.AnchorPoint = Vector2.new(0.5, 0)
			v46.Size = UDim2.fromOffset(0, 0)
			v46.Position = UDim2.fromScale(0.5, 0)
			v46.BackgroundTransparency = 1
			v46.BorderSizePixel = 0
			v46.ZIndex = 2
			p_u_2.applyTextStyle(v46)
			v46.Parent = v45
			local v47 = Instance.new("TextLabel")
			v47.Name = "Iris_Tooltip"
			v47.AutomaticSize = Enum.AutomaticSize.XY
			v47.Size = UDim2.fromOffset(0, 0)
			v47.BackgroundColor3 = p_u_1._config.PopupBgColor
			v47.BackgroundTransparency = p_u_1._config.PopupBgTransparency
			v47.BorderSizePixel = 0
			v47.Visible = false
			p_u_2.applyTextStyle(v47)
			p_u_2.UIStroke(v47, p_u_1._config.PopupBorderSize, p_u_1._config.BorderActiveColor, p_u_1._config.BorderActiveTransparency)
			p_u_2.UIPadding(v47, p_u_1._config.WindowPadding)
			if p_u_1._config.PopupRounding > 0 then
				p_u_2.UICorner(v47, p_u_1._config.PopupRounding)
			end
			local v48 = p_u_1._rootInstance
			if v48 then
				v48 = p_u_1._rootInstance:FindFirstChild("PopupScreenGui")
			end
			if v48 then
				v48 = v48:FindFirstChild("TooltipContainer")
			end
			v47.Parent = v48
			p_u_42.Tooltip = v47
			p_u_2.applyMouseMoved(v45, function()
				-- upvalues: (ref) v_u_39, (copy) p_u_42
				v_u_39(p_u_42)
			end)
			p_u_2.applyMouseLeave(v45, function()
				-- upvalues: (copy) p_u_42, (ref) p_u_1
				local v49 = p_u_42
				if v49.HoveredLine then
					v49.HoveredLine.BackgroundColor3 = p_u_1._config.PlotLinesColor
					v49.HoveredLine.BackgroundTransparency = p_u_1._config.PlotLinesTransparency
					v49.HoveredLine = false
					v49.state.hovered:set(nil)
				end
			end)
			v45.Parent = v44
			p_u_42.Lines = {}
			p_u_42.HoveredLine = false
			local v50 = Instance.new("TextLabel")
			v50.Name = "TextLabel"
			v50.AutomaticSize = Enum.AutomaticSize.XY
			v50.Size = UDim2.fromOffset(0, 0)
			v50.BackgroundTransparency = 1
			v50.BorderSizePixel = 0
			v50.ZIndex = p_u_42.ZIndex + 3
			v50.LayoutOrder = p_u_42.ZIndex + 3
			p_u_2.applyTextStyle(v50)
			v50.Parent = v43
			return v43
		end,
		["GenerateState"] = function(p51)
			-- upvalues: (copy) p_u_1
			if p51.state.values == nil then
				p51.state.values = p_u_1._widgetState(p51, "values", { 0, 1 })
			end
			if p51.state.hovered == nil then
				p51.state.hovered = p_u_1._widgetState(p51, "hovered", nil)
			end
		end,
		["Update"] = function(p52)
			local v53 = p52.Instance
			local v54 = v53.TextLabel
			local v55 = v53.Background.Plot.OverlayText
			v54.Text = p52.arguments.Text or "Plot Lines"
			v55.Text = p52.arguments.TextOverlay or ""
			v53.Size = UDim2.new(1, 0, 0, p52.arguments.Height or 0)
		end,
		["UpdateState"] = function(p56)
			-- upvalues: (copy) p_u_1, (copy) v_u_39
			if p56.state.hovered.lastChangeTick == p_u_1._cycleTick then
				if p56.state.hovered.value then
					p56.Tooltip.Visible = true
				else
					p56.Tooltip.Visible = false
				end
			end
			if p56.state.values.lastChangeTick == p_u_1._cycleTick then
				local v57 = p56.Instance.Background.Plot
				local v58 = p56.state.values.value
				local v59 = #v58 - 1
				local v60 = #p56.Lines
				local v61 = p56.arguments.Min or (1 / 0)
				local v62 = p56.arguments.Max or (-1 / 0)
				if v61 == nil or v62 == nil then
					for _, v63 in v58 do
						v61 = math.min(v61, v63)
						v62 = math.max(v62, v63)
					end
				end
				if v60 < v59 then
					for v64 = v60 + 1, v59 do
						local v65 = p56.Lines
						local v66 = Instance.new("Frame")
						v66.Name = tostring(v64)
						v66.AnchorPoint = Vector2.new(0.5, 0.5)
						v66.BackgroundColor3 = p_u_1._config.PlotLinesColor
						v66.BackgroundTransparency = p_u_1._config.PlotLinesTransparency
						v66.BorderSizePixel = 0
						v66.Parent = v57
						table.insert(v65, v66)
					end
				elseif v59 < v60 then
					for _ = v59 + 1, v60 do
						local v67 = table.remove(p56.Lines)
						if v67 then
							v67:Destroy()
						end
					end
				end
				local v68 = v62 - v61
				local v69 = v57.AbsoluteSize
				for v70 = 1, v59 do
					local v71 = v58[v70]
					local v72 = v58[v70 + 1]
					local v73 = v69 * Vector2.new((v70 - 1) / v59, (v62 - v71) / v68)
					local v74 = v69 * Vector2.new(v70 / v59, (v62 - v72) / v68)
					local v75 = (v73 + v74) / 2
					p56.Lines[v70].Size = UDim2.fromOffset((v74 - v73).Magnitude + 1, 1)
					p56.Lines[v70].Position = UDim2.fromOffset(v75.X, v75.Y)
					local v76 = p56.Lines[v70]
					local v77 = v74.Y - v73.Y
					local v78 = v74.X - v73.X
					v76.Rotation = math.atan2(v77, v78) * 57.29577951308232
				end
				if p56.HoveredLine then
					v_u_39(p56, true)
				end
			end
		end,
		["Discard"] = function(p79)
			-- upvalues: (copy) p_u_2
			p79.Instance:Destroy()
			p79.Tooltip:Destroy()
			p_u_2.discardState(p79)
		end
	}
	v40("PlotLines", v80)
	local function v_u_92(p81, p82)
		-- upvalues: (copy) p_u_2, (copy) p_u_1
		local v83 = p81.Instance.Background.Plot
		local v84 = p_u_2.getMouseLocation()
		local v85 = v83.AbsolutePosition - p_u_2.GuiOffset
		local v86 = (v84.X - v85.X) / v83.AbsoluteSize.X * #p81.Blocks
		local v87 = math.ceil(v86)
		local v88 = p81.Blocks[v87]
		if v88 then
			if v88 ~= p81.HoveredBlock and (not p82 and p81.HoveredBlock) then
				p81.HoveredBlock.BackgroundColor3 = p_u_1._config.PlotHistogramColor
				p81.HoveredBlock.BackgroundTransparency = p_u_1._config.PlotHistogramTransparency
				p81.HoveredBlock = false
				p81.state.hovered:set(nil)
			end
			local v89 = p81.state.values.value[v87]
			if v89 then
				local v90 = p81.Tooltip
				local v91
				if math.floor(v89) == v89 then
					v91 = ("%d: %d"):format(v87, v89)
				else
					v91 = ("%d: %.3f"):format(v87, v89)
				end
				v90.Text = v91
			end
			p81.HoveredBlock = v88
			v88.BackgroundColor3 = p_u_1._config.PlotHistogramHoveredColor
			v88.BackgroundTransparency = p_u_1._config.PlotHistogramHoveredTransparency
			if p82 then
				p81.state.hovered.value = v89
				return
			end
			p81.state.hovered:set(v89)
		end
	end
	local v93 = p_u_1.WidgetConstructor
	local v127 = {
		["hasState"] = true,
		["hasChildren"] = false,
		["Args"] = {
			["Text"] = 1,
			["Height"] = 2,
			["Min"] = 3,
			["Max"] = 4,
			["TextOverlay"] = 5,
			["BaseLine"] = 6
		},
		["Events"] = {
			["hovered"] = p_u_2.EVENTS.hover(function(p94)
				return p94.Instance
			end)
		},
		["Generate"] = function(p_u_95)
			-- upvalues: (copy) p_u_1, (copy) p_u_2, (copy) v_u_92
			local v96 = Instance.new("Frame")
			v96.Name = "Iris_PlotHistogram"
			v96.Size = UDim2.new(p_u_1._config.ItemWidth, UDim.new())
			v96.BackgroundTransparency = 1
			v96.BorderSizePixel = 0
			v96.ZIndex = p_u_95.ZIndex
			v96.LayoutOrder = p_u_95.ZIndex
			p_u_2.UIListLayout(v96, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			local v97 = Instance.new("Frame")
			v97.Name = "Background"
			v97.Size = UDim2.new(p_u_1._config.ContentWidth, UDim.new(1, 0))
			v97.BackgroundColor3 = p_u_1._config.FrameBgColor
			v97.BackgroundTransparency = p_u_1._config.FrameBgTransparency
			p_u_2.applyFrameStyle(v97)
			v97.UIPadding.PaddingRight = UDim.new(0, p_u_1._config.FramePadding.X - 1)
			v97.Parent = v96
			local v98 = Instance.new("Frame")
			v98.Name = "Plot"
			v98.Size = UDim2.fromScale(1, 1)
			v98.BackgroundTransparency = 1
			v98.BorderSizePixel = 0
			v98.ClipsDescendants = true
			local v99 = Instance.new("TextLabel")
			v99.Name = "OverlayText"
			v99.AutomaticSize = Enum.AutomaticSize.XY
			v99.AnchorPoint = Vector2.new(0.5, 0)
			v99.Size = UDim2.fromOffset(0, 0)
			v99.Position = UDim2.fromScale(0.5, 0)
			v99.BackgroundTransparency = 1
			v99.BorderSizePixel = 0
			v99.ZIndex = 2
			p_u_2.applyTextStyle(v99)
			v99.Parent = v98
			local v100 = Instance.new("TextLabel")
			v100.Name = "Iris_Tooltip"
			v100.AutomaticSize = Enum.AutomaticSize.XY
			v100.Size = UDim2.fromOffset(0, 0)
			v100.BackgroundColor3 = p_u_1._config.PopupBgColor
			v100.BackgroundTransparency = p_u_1._config.PopupBgTransparency
			v100.BorderSizePixel = 0
			v100.Visible = false
			p_u_2.applyTextStyle(v100)
			p_u_2.UIStroke(v100, p_u_1._config.PopupBorderSize, p_u_1._config.BorderActiveColor, p_u_1._config.BorderActiveTransparency)
			p_u_2.UIPadding(v100, p_u_1._config.WindowPadding)
			if p_u_1._config.PopupRounding > 0 then
				p_u_2.UICorner(v100, p_u_1._config.PopupRounding)
			end
			local v101 = p_u_1._rootInstance
			if v101 then
				v101 = p_u_1._rootInstance:FindFirstChild("PopupScreenGui")
			end
			if v101 then
				v101 = v101:FindFirstChild("TooltipContainer")
			end
			v100.Parent = v101
			p_u_95.Tooltip = v100
			p_u_2.applyMouseMoved(v98, function()
				-- upvalues: (ref) v_u_92, (copy) p_u_95
				v_u_92(p_u_95)
			end)
			p_u_2.applyMouseLeave(v98, function()
				-- upvalues: (copy) p_u_95, (ref) p_u_1
				local v102 = p_u_95
				if v102.HoveredBlock then
					v102.HoveredBlock.BackgroundColor3 = p_u_1._config.PlotHistogramColor
					v102.HoveredBlock.BackgroundTransparency = p_u_1._config.PlotHistogramTransparency
					v102.HoveredBlock = false
					v102.state.hovered:set(nil)
				end
			end)
			v98.Parent = v97
			p_u_95.Blocks = {}
			p_u_95.HoveredBlock = false
			local v103 = Instance.new("TextLabel")
			v103.Name = "TextLabel"
			v103.AutomaticSize = Enum.AutomaticSize.XY
			v103.Size = UDim2.fromOffset(0, 0)
			v103.BackgroundTransparency = 1
			v103.BorderSizePixel = 0
			v103.ZIndex = p_u_95.ZIndex + 3
			v103.LayoutOrder = p_u_95.ZIndex + 3
			p_u_2.applyTextStyle(v103)
			v103.Parent = v96
			return v96
		end,
		["GenerateState"] = function(p104)
			-- upvalues: (copy) p_u_1
			if p104.state.values == nil then
				p104.state.values = p_u_1._widgetState(p104, "values", { 1 })
			end
			if p104.state.hovered == nil then
				p104.state.hovered = p_u_1._widgetState(p104, "hovered", nil)
			end
		end,
		["Update"] = function(p105)
			local v106 = p105.Instance
			local v107 = v106.TextLabel
			local v108 = v106.Background.Plot.OverlayText
			v107.Text = p105.arguments.Text or "Plot Histogram"
			v108.Text = p105.arguments.TextOverlay or ""
			v106.Size = UDim2.new(1, 0, 0, p105.arguments.Height or 0)
		end,
		["UpdateState"] = function(p109)
			-- upvalues: (copy) p_u_1, (copy) v_u_92
			if p109.state.hovered.lastChangeTick == p_u_1._cycleTick then
				if p109.state.hovered.value then
					p109.Tooltip.Visible = true
				else
					p109.Tooltip.Visible = false
				end
			end
			if p109.state.values.lastChangeTick == p_u_1._cycleTick then
				local v110 = p109.Instance.Background.Plot
				local v111 = p109.state.values.value
				local v112 = #v111
				local v113 = #p109.Blocks
				local v114 = p109.arguments.Min or (1 / 0)
				local v115 = p109.arguments.Max or (-1 / 0)
				local v116 = p109.arguments.BaseLine or 0
				if v114 == nil or v115 == nil then
					for _, v117 in v111 do
						v114 = math.min(v114 or v117, v117)
						v115 = math.max(v115 or v117, v117)
					end
				end
				if v113 < v112 then
					for v118 = v113 + 1, v112 do
						local v119 = p109.Blocks
						local v120 = Instance.new("Frame")
						v120.Name = tostring(v118)
						v120.BackgroundColor3 = p_u_1._config.PlotHistogramColor
						v120.BackgroundTransparency = p_u_1._config.PlotHistogramTransparency
						v120.BorderSizePixel = 0
						v120.Parent = v110
						table.insert(v119, v120)
					end
				elseif v112 < v113 then
					for _ = v112 + 1, v113 do
						local v121 = table.remove(p109.Blocks)
						if v121 then
							v121:Destroy()
						end
					end
				end
				local v122 = v115 - v114
				local v123 = UDim.new(1 / v112, -1)
				for v124 = 1, v112 do
					local v125 = v111[v124]
					if v125 >= 0 then
						p109.Blocks[v124].Size = UDim2.new(v123, UDim.new((v125 - v116) / v122))
						p109.Blocks[v124].Position = UDim2.fromScale((v124 - 1) / v112, (v115 - v125) / v122)
					else
						p109.Blocks[v124].Size = UDim2.new(v123, UDim.new((v116 - v125) / v122))
						p109.Blocks[v124].Position = UDim2.fromScale((v124 - 1) / v112, (v115 - v116) / v122)
					end
				end
				if p109.HoveredBlock then
					v_u_92(p109, true)
				end
			end
		end,
		["Discard"] = function(p126)
			-- upvalues: (copy) p_u_2
			p126.Instance:Destroy()
			p126.Tooltip:Destroy()
			p_u_2.discardState(p126)
		end
	}
	v93("PlotHistogram", v127)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Plot]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3464"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p_u_1, p_u_2)
	local v3 = p_u_1.WidgetConstructor
	local v4 = {
		["hasState"] = true,
		["hasChildren"] = false,
		["Args"] = {
			["Text"] = 1,
			["Index"] = 2
		}
	}
	local v9 = {
		["selected"] = {
			["Init"] = function(_) end,
			["Get"] = function(p5)
				-- upvalues: (copy) p_u_1
				return p5.lastSelectedTick == p_u_1._cycleTick
			end
		},
		["unselected"] = {
			["Init"] = function(_) end,
			["Get"] = function(p6)
				-- upvalues: (copy) p_u_1
				return p6.lastUnselectedTick == p_u_1._cycleTick
			end
		},
		["active"] = {
			["Init"] = function(_) end,
			["Get"] = function(p7)
				return p7.state.index.value == p7.arguments.Index
			end
		},
		["hovered"] = p_u_2.EVENTS.hover(function(p8)
			return p8.Instance
		end)
	}
	v4.Events = v9
	function v4.Generate(p_u_10)
		-- upvalues: (copy) p_u_2, (copy) p_u_1
		local v11 = Instance.new("TextButton")
		v11.Name = "Iris_RadioButton"
		v11.AutomaticSize = Enum.AutomaticSize.XY
		v11.Size = UDim2.fromOffset(0, 0)
		v11.BackgroundTransparency = 1
		v11.BorderSizePixel = 0
		v11.Text = ""
		v11.LayoutOrder = p_u_10.ZIndex
		v11.AutoButtonColor = false
		v11.ZIndex = p_u_10.ZIndex
		v11.LayoutOrder = p_u_10.ZIndex
		p_u_2.UIListLayout(v11, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
		local v12 = p_u_1._config.TextSize + 2 * (p_u_1._config.FramePadding.Y - 1)
		local v13 = Instance.new("Frame")
		v13.Name = "Button"
		v13.Size = UDim2.fromOffset(v12, v12)
		v13.Parent = v11
		v13.BackgroundColor3 = p_u_1._config.FrameBgColor
		v13.BackgroundTransparency = p_u_1._config.FrameBgTransparency
		p_u_2.UICorner(v13)
		local v14 = p_u_2.UIPadding
		local v15 = Vector2.new
		local v16 = v12 / 5
		local v17 = math.floor(v16)
		local v18 = math.max(1, v17)
		local v19 = v12 / 5
		local v20 = math.floor(v19)
		v14(v13, v15(v18, (math.max(1, v20))))
		local v21 = Instance.new("Frame")
		v21.Name = "Circle"
		v21.Size = UDim2.fromScale(1, 1)
		v21.Parent = v13
		v21.BackgroundColor3 = p_u_1._config.CheckMarkColor
		v21.BackgroundTransparency = p_u_1._config.CheckMarkTransparency
		p_u_2.UICorner(v21)
		p_u_2.applyInteractionHighlights("Background", v11, v13, {
			["Color"] = p_u_1._config.FrameBgColor,
			["Transparency"] = p_u_1._config.FrameBgTransparency,
			["HoveredColor"] = p_u_1._config.FrameBgHoveredColor,
			["HoveredTransparency"] = p_u_1._config.FrameBgHoveredTransparency,
			["ActiveColor"] = p_u_1._config.FrameBgActiveColor,
			["ActiveTransparency"] = p_u_1._config.FrameBgActiveTransparency
		})
		p_u_2.applyButtonClick(v11, function()
			-- upvalues: (copy) p_u_10
			p_u_10.state.index:set(p_u_10.arguments.Index)
		end)
		local v22 = Instance.new("TextLabel")
		v22.Name = "TextLabel"
		v22.AutomaticSize = Enum.AutomaticSize.XY
		v22.BackgroundTransparency = 1
		v22.BorderSizePixel = 0
		v22.LayoutOrder = 1
		p_u_2.applyTextStyle(v22)
		v22.Parent = v11
		return v11
	end
	function v4.Update(p23)
		-- upvalues: (copy) p_u_1
		p23.Instance.TextLabel.Text = p23.arguments.Text or "Radio Button"
		if p23.state then
			p23.state.index.lastChangeTick = p_u_1._cycleTick
			p_u_1._widgets[p23.type].UpdateState(p23)
		end
	end
	function v4.Discard(p24)
		-- upvalues: (copy) p_u_2
		p24.Instance:Destroy()
		p_u_2.discardState(p24)
	end
	function v4.GenerateState(p25)
		-- upvalues: (copy) p_u_1
		if p25.state.index == nil then
			p25.state.index = p_u_1._widgetState(p25, "index", p25.arguments.Index)
		end
	end
	function v4.UpdateState(p26)
		-- upvalues: (copy) p_u_1
		local v27 = p26.Instance.Button.Circle
		if p26.state.index.value == p26.arguments.Index then
			v27.BackgroundTransparency = p_u_1._config.CheckMarkTransparency
			p26.lastSelectedTick = p_u_1._cycleTick + 1
		else
			v27.BackgroundTransparency = 1
			p26.lastUnselectedTick = p_u_1._cycleTick + 1
		end
	end
	v3("RadioButton", v4)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RadioButton]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3465"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p_u_1, p_u_2)
	local v_u_3 = 0
	local v18 = {
		["hasState"] = false,
		["hasChildren"] = true,
		["Args"] = {},
		["Events"] = {},
		["Generate"] = function(_)
			-- upvalues: (copy) p_u_1, (copy) p_u_2
			local v4 = Instance.new("Folder")
			v4.Name = "Iris_Root"
			local v5
			if p_u_1._config.UseScreenGUIs then
				v5 = Instance.new("ScreenGui")
				v5.ResetOnSpawn = false
				v5.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				v5.DisplayOrder = p_u_1._config.DisplayOrderOffset
				v5.IgnoreGuiInset = p_u_1._config.IgnoreGuiInset
			else
				v5 = Instance.new("Frame")
				v5.AnchorPoint = Vector2.new(0.5, 0.5)
				v5.Position = UDim2.new(0.5, 0, 0.5, 0)
				v5.Size = UDim2.new(1, 0, 1, 0)
				v5.BackgroundTransparency = 1
				v5.ZIndex = p_u_1._config.DisplayOrderOffset
			end
			v5.Name = "PseudoWindowScreenGui"
			v5.Parent = v4
			local v6
			if p_u_1._config.UseScreenGUIs then
				v6 = Instance.new("ScreenGui")
				v6.ResetOnSpawn = false
				v6.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				v6.DisplayOrder = p_u_1._config.DisplayOrderOffset + 1024
				v6.IgnoreGuiInset = p_u_1._config.IgnoreGuiInset
			else
				v6 = Instance.new("Frame")
				v6.AnchorPoint = Vector2.new(0.5, 0.5)
				v6.Position = UDim2.new(0.5, 0, 0.5, 0)
				v6.Size = UDim2.new(1, 0, 1, 0)
				v6.BackgroundTransparency = 1
				v6.ZIndex = p_u_1._config.DisplayOrderOffset + 1024
			end
			v6.Name = "PopupScreenGui"
			v6.Parent = v4
			local v7 = Instance.new("Frame")
			v7.Name = "TooltipContainer"
			v7.AutomaticSize = Enum.AutomaticSize.XY
			v7.Size = UDim2.fromOffset(0, 0)
			v7.BackgroundTransparency = 1
			v7.BorderSizePixel = 0
			p_u_2.UIListLayout(v7, Enum.FillDirection.Vertical, UDim.new(0, p_u_1._config.PopupBorderSize))
			v7.Parent = v6
			local v8 = Instance.new("Frame")
			v8.Name = "MenuBarContainer"
			v8.AutomaticSize = Enum.AutomaticSize.Y
			v8.Size = UDim2.fromScale(1, 0)
			v8.BackgroundTransparency = 1
			v8.BorderSizePixel = 0
			v8.Parent = v6
			local v9 = Instance.new("Frame")
			v9.Name = "PseudoWindow"
			v9.Size = UDim2.new(0, 0, 0, 0)
			v9.Position = UDim2.fromOffset(0, 22)
			v9.AutomaticSize = Enum.AutomaticSize.XY
			v9.BackgroundTransparency = p_u_1._config.WindowBgTransparency
			v9.BackgroundColor3 = p_u_1._config.WindowBgColor
			v9.BorderSizePixel = p_u_1._config.WindowBorderSize
			v9.BorderColor3 = p_u_1._config.BorderColor
			v9.Selectable = false
			v9.SelectionGroup = true
			v9.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
			v9.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
			v9.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
			v9.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
			v9.Visible = false
			p_u_2.UIPadding(v9, p_u_1._config.WindowPadding)
			p_u_2.UIListLayout(v9, Enum.FillDirection.Vertical, UDim.new(0, p_u_1._config.ItemSpacing.Y))
			v9.Parent = v5
			return v4
		end,
		["Update"] = function(p10)
			-- upvalues: (ref) v_u_3
			if v_u_3 > 0 then
				p10.Instance.PseudoWindowScreenGui.PseudoWindow.Visible = true
			end
		end,
		["Discard"] = function(p11)
			-- upvalues: (ref) v_u_3
			v_u_3 = 0
			p11.Instance:Destroy()
		end,
		["ChildAdded"] = function(p12, p13)
			-- upvalues: (ref) v_u_3
			local v14 = p12.Instance
			if p13.type == "Window" then
				return p12.Instance
			end
			if p13.type == "Tooltip" then
				return v14.PopupScreenGui.TooltipContainer
			end
			if p13.type == "MenuBar" then
				return v14.PopupScreenGui.MenuBarContainer
			end
			local v15 = v14.PseudoWindowScreenGui.PseudoWindow
			v_u_3 = v_u_3 + 1
			v15.Visible = true
			return v15
		end,
		["ChildDiscarded"] = function(p16, p17)
			-- upvalues: (ref) v_u_3
			if p17.type ~= "Window" and (p17.type ~= "Tooltip" and p17.type ~= "MenuBar") then
				v_u_3 = v_u_3 - 1
				if v_u_3 == 0 then
					p16.Instance.PseudoWindowScreenGui.PseudoWindow.Visible = false
				end
			end
		end
	}
	p_u_1.WidgetConstructor("Root", v18)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Root]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3466"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p_u_1, p_u_2)
	local function v_u_7(p3, p4)
		if p3.state.index.value == p4 then
			for v5 = p4 - 1, 1, -1 do
				if p3.Tabs[v5].state.isOpened.value == true then
					p3.state.index:set(v5)
					return
				end
			end
			for v6 = p4, #p3.Tabs do
				if p3.Tabs[v6].state.isOpened.value == true then
					p3.state.index:set(v6)
					return
				end
			end
			p3.state.index:set(0)
		end
	end
	p_u_1.WidgetConstructor("TabBar", {
		["hasState"] = true,
		["hasChildren"] = true,
		["Args"] = {},
		["Events"] = {},
		["Generate"] = function(p8)
			-- upvalues: (copy) p_u_2, (copy) p_u_1
			local v9 = Instance.new("Frame")
			v9.Name = "Iris_TabBar"
			v9.AutomaticSize = Enum.AutomaticSize.Y
			v9.Size = UDim2.fromScale(1, 0)
			v9.BackgroundTransparency = 1
			v9.BorderSizePixel = 0
			v9.LayoutOrder = p8.ZIndex
			p_u_2.UIListLayout(v9, Enum.FillDirection.Vertical, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Bottom
			local v10 = Instance.new("Frame")
			v10.Name = "Bar"
			v10.AutomaticSize = Enum.AutomaticSize.Y
			v10.Size = UDim2.fromScale(1, 0)
			v10.BackgroundTransparency = 1
			v10.BorderSizePixel = 0
			p_u_2.UIListLayout(v10, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X))
			v10.Parent = v9
			local v11 = Instance.new("Frame")
			v11.Name = "Underline"
			v11.Size = UDim2.new(1, 0, 0, 1)
			v11.BackgroundColor3 = p_u_1._config.TabActiveColor
			v11.BackgroundTransparency = p_u_1._config.TabActiveTransparency
			v11.BorderSizePixel = 0
			v11.LayoutOrder = 1
			v11.Parent = v9
			local v12 = Instance.new("Frame")
			v12.Name = "TabContainer"
			v12.AutomaticSize = Enum.AutomaticSize.Y
			v12.Size = UDim2.fromScale(1, 0)
			v12.BackgroundTransparency = 1
			v12.BorderSizePixel = 0
			v12.LayoutOrder = 2
			v12.ClipsDescendants = true
			v12.Parent = v9
			p8.ChildContainer = v12
			p8.Tabs = {}
			return v9
		end,
		["Update"] = function(_) end,
		["ChildAdded"] = function(p13, p14)
			local v15 = p14.type == "Tab"
			assert(v15, "Only Iris.Tab can be parented to Iris.TabBar.")
			local v16 = p13.Instance
			p14.ChildContainer.Parent = p13.ChildContainer
			p14.Index = #p13.Tabs + 1
			p13.state.index.ConnectedWidgets[p14.ID] = p14
			local v17 = p13.Tabs
			table.insert(v17, p14)
			return v16.Bar
		end,
		["ChildDiscarded"] = function(p18, p19)
			-- upvalues: (copy) v_u_7
			local v20 = p19.Index
			table.remove(p18.Tabs, v20)
			for v21 = v20, #p18.Tabs do
				p18.Tabs[v21].Index = v21
			end
			v_u_7(p18, v20)
		end,
		["GenerateState"] = function(p22)
			-- upvalues: (copy) p_u_1
			if p22.state.index == nil then
				p22.state.index = p_u_1._widgetState(p22, "index", 1)
			end
		end,
		["UpdateState"] = function(_) end,
		["Discard"] = function(p23)
			p23.Instance:Destroy()
		end
	})
	local v24 = p_u_1.WidgetConstructor
	local v25 = {
		["hasState"] = true,
		["hasChildren"] = true,
		["Args"] = {
			["Text"] = 1,
			["Hideable"] = 2
		}
	}
	local v33 = {
		["clicked"] = p_u_2.EVENTS.click(function(p26)
			return p26.Instance
		end),
		["hovered"] = p_u_2.EVENTS.hover(function(p27)
			return p27.Instance
		end),
		["selected"] = {
			["Init"] = function(_) end,
			["Get"] = function(p28)
				-- upvalues: (copy) p_u_1
				return p28.lastSelectedTick == p_u_1._cycleTick
			end
		},
		["unselected"] = {
			["Init"] = function(_) end,
			["Get"] = function(p29)
				-- upvalues: (copy) p_u_1
				return p29.lastUnselectedTick == p_u_1._cycleTick
			end
		},
		["active"] = {
			["Init"] = function(_) end,
			["Get"] = function(p30)
				return p30.state.index.value == p30.Index
			end
		},
		["opened"] = {
			["Init"] = function(_) end,
			["Get"] = function(p31)
				-- upvalues: (copy) p_u_1
				return p31.lastOpenedTick == p_u_1._cycleTick
			end
		},
		["closed"] = {
			["Init"] = function(_) end,
			["Get"] = function(p32)
				-- upvalues: (copy) p_u_1
				return p32.lastClosedTick == p_u_1._cycleTick
			end
		}
	}
	v25.Events = v33
	function v25.Generate(p_u_34)
		-- upvalues: (copy) p_u_1, (copy) p_u_2, (copy) v_u_7
		local v35 = Instance.new("TextButton")
		v35.Name = "Iris_Tab"
		v35.AutomaticSize = Enum.AutomaticSize.XY
		v35.BackgroundColor3 = p_u_1._config.TabColor
		v35.BackgroundTransparency = p_u_1._config.TabTransparency
		v35.BorderSizePixel = 0
		v35.Text = ""
		v35.AutoButtonColor = false
		p_u_34.ButtonColors = {
			["Color"] = p_u_1._config.TabColor,
			["Transparency"] = p_u_1._config.TabTransparency,
			["HoveredColor"] = p_u_1._config.TabHoveredColor,
			["HoveredTransparency"] = p_u_1._config.TabHoveredTransparency,
			["ActiveColor"] = p_u_1._config.TabActiveColor,
			["ActiveTransparency"] = p_u_1._config.TabActiveTransparency
		}
		p_u_2.UIPadding(v35, Vector2.new(p_u_1._config.FramePadding.X, 0))
		p_u_2.applyFrameStyle(v35, true, true)
		p_u_2.UIListLayout(v35, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
		p_u_2.applyInteractionHighlights("Background", v35, v35, p_u_34.ButtonColors)
		p_u_2.applyButtonClick(v35, function()
			-- upvalues: (copy) p_u_34
			p_u_34.state.index:set(p_u_34.Index)
		end)
		local v36 = Instance.new("TextLabel")
		v36.Name = "TextLabel"
		v36.AutomaticSize = Enum.AutomaticSize.XY
		v36.BackgroundTransparency = 1
		v36.BorderSizePixel = 0
		p_u_2.applyTextStyle(v36)
		p_u_2.UIPadding(v36, Vector2.new(0, p_u_1._config.FramePadding.Y))
		v36.Parent = v35
		local v37 = p_u_1._config.TextSize + (p_u_1._config.FramePadding.Y - 1) * 2
		local v38 = Instance.new("TextButton")
		v38.Name = "CloseButton"
		v38.BackgroundTransparency = 1
		v38.BorderSizePixel = 0
		v38.LayoutOrder = 1
		v38.Size = UDim2.fromOffset(v37, v37)
		v38.Text = ""
		v38.AutoButtonColor = false
		p_u_2.UICorner(v38)
		p_u_2.applyButtonClick(v38, function()
			-- upvalues: (copy) p_u_34, (ref) v_u_7
			p_u_34.state.isOpened:set(false)
			v_u_7(p_u_34.parentWidget, p_u_34.Index)
		end)
		p_u_2.applyInteractionHighlights("Background", v38, v38, {
			["Color"] = p_u_1._config.TabColor,
			["Transparency"] = 1,
			["HoveredColor"] = p_u_1._config.ButtonHoveredColor,
			["HoveredTransparency"] = p_u_1._config.ButtonHoveredTransparency,
			["ActiveColor"] = p_u_1._config.ButtonActiveColor,
			["ActiveTransparency"] = p_u_1._config.ButtonActiveTransparency
		})
		v38.Parent = v35
		local v39 = Instance.new("ImageLabel")
		v39.Name = "Icon"
		v39.AnchorPoint = Vector2.new(0.5, 0.5)
		v39.BackgroundTransparency = 1
		v39.BorderSizePixel = 0
		v39.Image = p_u_2.ICONS.MULTIPLICATION_SIGN
		v39.ImageTransparency = 1
		v39.Position = UDim2.fromScale(0.5, 0.5)
		local v40 = UDim2.fromOffset
		local v41 = v37 * 0.7
		local v42 = math