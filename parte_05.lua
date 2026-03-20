 "Attack Speed",
			["order"] = 6,
			["attr"] = v_u_8.PetAttackSpeed
		},
		{
			["name"] = "Agility",
			["order"] = 7,
			["attr"] = v_u_8.PetAgility
		},
		{
			["name"] = "Coin Bonus",
			["order"] = 8,
			["attr"] = v_u_8.PetCoinMultiplier
		},
		{
			["name"] = "Crit Chance",
			["order"] = 9,
			["attr"] = v_u_8.PetCritChance
		}
	}
	local v_u_37 = {}
	for _, v38 in v_u_36 do
		local v39 = v35:Clone()
		v39.Visible = true
		v39.LayoutOrder = v38.order
		v39.Title.Text = v38.name
		v39.Value.Text = "--"
		v39.Parent = v32
		v_u_37[v38.name] = v39
	end
	local function v_u_50(p40)
		-- upvalues: (ref) v_u_31, (ref) v_u_3, (ref) v_u_15, (ref) v_u_4, (ref) v_u_2, (ref) v_u_8, (ref) v_u_13
		local v41 = v_u_31[p40]
		if not v41 then
			return "--"
		end
		local v42 = v_u_3[v41]
		if not v42 then
			return "--"
		end
		local v43 = v_u_15.get(v41)
		local v44 = v42.Format
		local v45 = tostring(v44(v43))
		local v46 = v_u_4[p40]
		local v47 = v_u_2:getValue({ "Candy", "PetAttributes", p40 }) or 0
		if v47 <= 0 or not v46 then
			return v45
		end
		local v48 = v46.CalculateValue(v47)
		if p40 == v_u_8.PetAttackSpeed then
			return ("%* (-%*s)"):format(v45, (v_u_13.decimal(v48, 2)))
		end
		if p40 == v_u_8.PetCoinMultiplier then
			return ("%* (x%*)"):format(v45, (v_u_13.decimal(v48, 2)))
		end
		if p40 == v_u_8.PetDamage or p40 == v_u_8.PetCritChance then
			return ("%* (+%*%%)"):format(v45, (v_u_13.decimal(v48 * 100, 1)))
		end
		local v49 = v42.Format
		return ("%* (+%*)"):format(v45, (tostring(v49(v48))))
	end
	local function v_u_68()
		-- upvalues: (ref) v_u_2, (copy) v_u_37, (ref) v_u_10, (ref) v_u_9, (ref) v_u_13, (ref) v_u_6, (copy) v_u_36, (copy) v_u_50
		if v_u_2:getValue({ "Candy", "Pet" }) then
			local v51 = v_u_2:getValue({ "Candy", "PetLevel" }) or 0
			local v52 = v_u_2:getValue({ "Candy", "PetXP" }) or 0
			if v_u_10.PET_LEVEL_CAP <= v51 then
				v_u_37.Level.Value.Text = ("Lv. %* (MAX)"):format(v51)
			else
				local v53 = v_u_9(v51 + 1)
				v_u_37.Level.Value.Text = ("Lv. %* (%*/%* XP)"):format(v51, v_u_13.abbreviateComma(v52), (v_u_13.abbreviateComma(v53)))
			end
			local v54 = v_u_2:getValue({ "Candy", "PetObtainedTime" })
			if v54 then
				local v55 = os.time() - v54
				local v56 = v55 / 86400
				local v57 = math.floor(v56)
				local v58 = v55 % 86400 / 3600
				local v59 = math.floor(v58)
				local v60 = v55 % 3600 / 60
				local v61 = math.floor(v60)
				if v57 > 0 then
					v_u_37.Age.Value.Text = ("%*d %*h"):format(v57, v59)
				elseif v59 > 0 then
					v_u_37.Age.Value.Text = ("%*h %*m"):format(v59, v61)
				else
					v_u_37.Age.Value.Text = ("%*m"):format((math.max(v61, 1)))
				end
			else
				v_u_37.Age.Value.Text = "Unknown"
			end
			local v62 = {}
			for _, v63 in v_u_2:getValue({ "Candy", "RaceSlots" }) or {} do
				local v64 = v_u_6.Races[v63]
				if v64 then
					local v65 = v64.Name
					table.insert(v62, v65)
				end
			end
			v_u_37.Race.Value.Text = #v62 > 0 and table.concat(v62, ", ") or "None"
			for _, v66 in v_u_36 do
				if v66.attr then
					v_u_37[v66.name].Value.Text = v_u_50(v66.attr)
				end
			end
		else
			for _, v67 in v_u_37 do
				v67.Value.Text = "--"
			end
		end
	end
	v_u_27 = v_u_68
	local function v_u_77()
		-- upvalues: (ref) v_u_26, (ref) v_u_2, (ref) v_u_5, (copy) v_u_33, (ref) v_u_17
		v_u_26:Cleanup()
		local v69 = v_u_2:getValue({ "Candy", "Pet" })
		if v69 then
			local v70 = v_u_5.Pets[v69]
			if v70 and v70.Model then
				local v_u_71 = v_u_26:Add(v70.Model:Clone())
				v_u_71:PivotTo(CFrame.new(0, 0, 0))
				v_u_71.Parent = v_u_33
				local v72 = v_u_26:Add(Instance.new("Part"))
				v72.Color = Color3.new(0.372549, 0.372549, 0.372549)
				v72.Size = Vector3.new(500, 1, 500)
				v72.Material = Enum.Material.SmoothPlastic
				local v73 = -(v70.Model:GetExtentsSize().Y / 2) - 1
				v72.Position = Vector3.new(0, v73, 0)
				v72.Parent = v_u_33
				local v74 = Instance.new("Texture")
				v74.Texture = "rbxassetid://6372755229"
				v74.Face = Enum.NormalId.Top
				v74.Transparency = 0.8
				v74.StudsPerTileU = 4
				v74.StudsPerTileV = 4
				v74.Parent = v72
				local v75 = v_u_26:Add(Instance.new("Camera"))
				v75.CFrame = CFrame.new(Vector3.new(2, 0, -6), Vector3.new(0, 0, 0))
				v75.Parent = v_u_33
				v_u_33.CurrentCamera = v75
				v_u_26:Add(task.spawn(function()
					-- upvalues: (copy) v_u_71, (ref) v_u_17
					local v76 = CFrame.new(0, 0, 0)
					while v_u_71.Parent do
						v_u_17.target(v_u_71, 0.3, 2, {
							["Pivot"] = v76 + Vector3.new(0, 1, 0)
						})
						task.wait(0.2)
						v_u_17.target(v_u_71, 0.3, 2, {
							["Pivot"] = v76
						})
						task.wait(0.5)
					end
				end))
			end
		else
			return
		end
	end
	v_u_34.Activated:Connect(function()
		-- upvalues: (ref) v_u_2, (ref) v_u_23
		local v78 = (v_u_2:getValue({ "Candy", "PetMode" }) or "Attack") == "Attack" and "Follow" or "Attack"
		v_u_23.fire(v78)
	end)
	v_u_2:onSet({ "Candy", "Pet" }, function()
		-- upvalues: (copy) v_u_77, (copy) v_u_68, (ref) v_u_2, (copy) v_u_34
		v_u_77()
		v_u_68()
		local v79 = v_u_2:getValue({ "Candy", "PetMode" }) or "Attack"
		v_u_34.Title.Text = v79
	end)
	v_u_2:onSet({ "Candy", "PetLevel" }, function()
		-- upvalues: (copy) v_u_68
		v_u_68()
	end)
	v_u_2:onSet({ "Candy", "PetXP" }, function()
		-- upvalues: (copy) v_u_68
		v_u_68()
	end)
	v_u_2:onSet({ "Candy", "PetMode" }, function()
		-- upvalues: (ref) v_u_2, (copy) v_u_34
		local v80 = v_u_2:getValue({ "Candy", "PetMode" }) or "Attack"
		v_u_34.Title.Text = v80
	end)
	v_u_2:onChange(function(_, p81)
		-- upvalues: (copy) v_u_68
		if p81[1] == "Candy" and p81[2] == "RaceSlots" then
			v_u_68()
		end
	end)
	v_u_77()
	v_u_68()
	local v82 = v_u_2:getValue({ "Candy", "PetMode" }) or "Attack"
	v_u_34.Title.Text = v82
end
function v18.setupUpgradeSlimePage(_)
	-- upvalues: (copy) v_u_20, (copy) v_u_25, (copy) v_u_14, (copy) v_u_11, (copy) v_u_4, (copy) v_u_24, (copy) v_u_2, (ref) v_u_28, (ref) v_u_27
	local v83 = v_u_20.Upgrades
	local v_u_84 = v83.UpgradePoints.Title
	local v85 = v83.Template
	v83.UpgradePoints.Reset.Activated:Connect(function()
		-- upvalues: (ref) v_u_25, (ref) v_u_14, (ref) v_u_11
		local v86, v87 = v_u_25.invoke()
		if not v86 and v87 == "PROMPT_PURCHASE" then
			v_u_14.PromptProduct(v_u_11.ResetTickets[1])
		end
	end)
	v85.Visible = false
	local v88 = {}
	for v89, v90 in v_u_4 do
		table.insert(v88, {
			["type"] = v89,
			["data"] = v90
		})
	end
	table.sort(v88, function(p91, p92)
		return p91.data.Order < p92.data.Order
	end)
	local v_u_93 = {}
	for _, v94 in v88 do
		local v_u_95 = v94.type
		local v96 = v94.data
		local v97 = v85:Clone()
		v97.Visible = true
		v97.LayoutOrder = v96.Order
		v97.Title.Text = v96.Name
		v97.Parent = v83
		v97.Select.Activated:Connect(function()
			-- upvalues: (ref) v_u_24, (copy) v_u_95
			v_u_24.invoke(v_u_95)
		end)
		v_u_93[v_u_95] = v97
	end
	local function v_u_103()
		-- upvalues: (ref) v_u_2, (copy) v_u_93, (ref) v_u_4
		local v98 = v_u_2:getValue({ "Candy", "PetAttributes" }) or {}
		for v99, v100 in v_u_93 do
			local v101 = v98[v99] or 0
			local v102 = v_u_4[v99].MaxLevel
			v100.Level.Text = ("Lv. %*/%*"):format(v101, v102)
		end
	end
	v_u_28 = function()
		-- upvalues: (ref) v_u_2, (copy) v_u_84
		v_u_84.Text = ("%* Upgrade Points"):format(v_u_2:getValue({ "Candy", "PetAttributeTokens" }) or 0)
	end
	v_u_2:onSet({ "Candy", "PetAttributeTokens" }, function()
		-- upvalues: (ref) v_u_2, (copy) v_u_84
		v_u_84.Text = ("%* Upgrade Points"):format(v_u_2:getValue({ "Candy", "PetAttributeTokens" }) or 0)
	end)
	v_u_2:onChange(function(_, p104)
		-- upvalues: (copy) v_u_103, (ref) v_u_27
		if p104[1] == "Candy" and p104[2] == "PetAttributes" then
			v_u_103()
			if v_u_27 then
				v_u_27()
			end
		end
	end)
	v_u_103()
	v_u_84.Text = ("%* Upgrade Points"):format(v_u_2:getValue({ "Candy", "PetAttributeTokens" }) or 0)
end
function v18.setupTabs(_)
	-- upvalues: (copy) v_u_19, (copy) v_u_20
	for _, v_u_105 in v_u_19.Header.Menus:GetChildren() do
		if v_u_105:IsA("GuiButton") then
			v_u_105.Activated:Connect(function()
				-- upvalues: (ref) v_u_20, (copy) v_u_105
				for _, v106 in v_u_20:GetChildren() do
					if v106:IsA("ScrollingFrame") then
						v106.Visible = v106.Name == v_u_105.Name
					end
				end
			end)
		end
	end
end
function v18.init(p107)
	p107:setupMainSlimePage()
	p107:setupUpgradeSlimePage()
	p107:setupTabs()
end
return v18]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MySlime]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3786"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Config.CurrencyData)
local v_u_4 = require(v1.Config.GamepassData)
local v_u_5 = require(v1.Config.GloopCraftData)
local v_u_6 = require(v1.Config.GloopData)
local v_u_7 = require(v1.Enums.CurrencyTypes)
local v_u_8 = require(v1.Enums.Gamepasses)
local v_u_9 = require(v1.Enums.Products)
local v_u_10 = require(v1.Utility.Format)
local v_u_11 = require(v1.Utility.GamepassUtil)
local v_u_12 = require(v1.Utility.Marketplace)
local v13 = require(v1.Utility.Network)
local v_u_14 = require(v1.Utility.Notify)
local v_u_15 = require(v1.Utility.PlayerListUtil)
local v_u_16 = require(v1.Utility.Spring)
local v_u_17 = require(v1.Utility.Time)
local v18 = require(v1.Utility.UI)
local v_u_19 = Color3.fromRGB(85, 255, 85)
local v_u_20 = Color3.fromRGB(255, 85, 85)
local v21 = {}
local v_u_22 = v18:get("Gui", "GloopCrafting").Container
local v_u_23 = v_u_22.Container
local v_u_24 = v_u_22.Progress
local v_u_25 = v_u_22.Passes
local v_u_26 = v_u_22.Position
local v_u_27 = v_u_26 + UDim2.fromScale(0, 0.2)
local v_u_28 = v13.remoteFunction("GloopCraftServiceStart")
local v_u_29 = v13.remoteFunction("GloopCraftServiceClaim")
local v_u_30 = v13.remoteFunction("GiftEvent")
local v_u_31 = { v_u_8.BulkGloopCraft, v_u_8.CraftSpeed2x }
local v_u_32 = nil
local v_u_33 = {}
local v_u_34 = 1
local v_u_35 = {}
local v_u_36 = {}
local v_u_37 = nil
local v_u_38 = {}
local function v_u_43()
	-- upvalues: (copy) v_u_11, (copy) v_u_8, (copy) v_u_33, (ref) v_u_32
	local v39 = {}
	if v_u_11.has(v_u_8.BulkGloopCraft) then
		for v40, v41 in v_u_33 do
			if v41 then
				table.insert(v39, v40)
			end
		end
		return v39
	else
		if v_u_32 then
			local v42 = v_u_32
			table.insert(v39, v42)
		end
		return v39
	end
end
local function v_u_57()
	-- upvalues: (copy) v_u_36, (ref) v_u_37, (copy) v_u_43, (copy) v_u_5, (ref) v_u_34, (copy) v_u_10, (copy) v_u_2, (copy) v_u_19, (copy) v_u_20, (copy) v_u_7, (copy) v_u_23
	for _, v44 in v_u_36 do
		v44.Visible = false
	end
	if v_u_37 then
		v_u_37.Visible = false
	end
	local v45 = 0
	local v46 = {}
	for _, v47 in v_u_43() do
		local v48 = v_u_5[v47]
		v45 = v45 + v48.ShardCost * v_u_34
		v46[v48.InputGloop] = (v46[v48.InputGloop] or 0) + v48.InputAmount * v_u_34
	end
	for v49, v50 in v_u_36 do
		if v46[v49] then
			v50.Visible = true
			v50.Title.Text = ("x%*"):format((v_u_10.abbreviateComma(v46[v49], 999999)))
			local v51 = v_u_2:getValue({ "Gloop", v49 }) or 0
			local v52 = v50.Title
			local v53
			if v46[v49] <= v51 then
				v53 = v_u_19
			else
				v53 = v_u_20
			end
			v52.TextColor3 = v53
		end
	end
	if v_u_37 and v45 > 0 then
		v_u_37.Visible = true
		v_u_37.Title.Text = ("x%*"):format((v_u_10.abbreviateComma(v45, 999999)))
		local v54 = v_u_2:getValue({ "Currency", v_u_7.Shards }) or 0
		local v55 = v_u_37.Title
		local v56
		if v45 <= v54 then
			v56 = v_u_19
		else
			v56 = v_u_20
		end
		v55.TextColor3 = v56
	end
	v_u_23.Buttons.Craft.Title.Text = ("Craft (%*)"):format(v_u_34)
end
local function v_u_61()
	-- upvalues: (copy) v_u_35, (copy) v_u_11, (copy) v_u_8, (copy) v_u_33, (ref) v_u_32, (copy) v_u_57
	for v58, v59 in v_u_35 do
		local v60
		if v_u_11.has(v_u_8.BulkGloopCraft) then
			v60 = v_u_33[v58] == true
		else
			v60 = v_u_32 == v58
		end
		v59.Success.Visible = v60
	end
	v_u_57()
end
local function v_u_68()
	-- upvalues: (copy) v_u_2, (copy) v_u_38, (copy) v_u_24, (copy) v_u_17
	local v62 = v_u_2:getValue({ "GloopCraft" }) or {}
	for _, v63 in v_u_38 do
		v63.Visible = false
	end
	local v64 = 0
	local v65 = false
	for v66, v67 in v62 do
		v65 = true
		if v_u_38[v66] then
			v_u_38[v66].Visible = true
			v_u_38[v66].Title.Text = ("x%*"):format(v67.Amount)
		end
		if v64 < v67.Timer then
			v64 = v67.Timer
		end
	end
	v_u_24.Visible = v65
	if v65 then
		v_u_24.Timer.Text = v64 > 0 and (v_u_17.format(v64) or "Ready!") or "Ready!"
		v_u_24.Buttons.Skip.Visible = v64 > 0
	end
end
function v21.open(_)
	-- upvalues: (copy) v_u_16, (copy) v_u_22, (copy) v_u_26
	local v69 = {
		["Position"] = v_u_26,
		["Visible"] = true
	}
	v_u_16.target(v_u_22, 0.8, 5, v69)
end
function v21.close(_)
	-- upvalues: (copy) v_u_16, (copy) v_u_22, (copy) v_u_27
	local v70 = {
		["Position"] = v_u_27,
		["Visible"] = false
	}
	v_u_16.target(v_u_22, 0.8, 5, v70)
end
function v21.loadSelectGloops(_)
	-- upvalues: (copy) v_u_23, (copy) v_u_5, (copy) v_u_6, (copy) v_u_35, (copy) v_u_11, (copy) v_u_8, (copy) v_u_33, (ref) v_u_32, (copy) v_u_61
	local v71 = v_u_23.SelectGloop.Template
	local v72 = {}
	for v73, v74 in v_u_5 do
		local v75 = {
			["type"] = v73,
			["order"] = v74.Order
		}
		table.insert(v72, v75)
	end
	table.sort(v72, function(p76, p77)
		return p76.order < p77.order
	end)
	for _, v78 in v72 do
		local v_u_79 = v78.type
		local v80 = v_u_6[v_u_79]
		local v81 = v71:Clone()
		v81.Visible = true
		v81.Name = v_u_79
		v81.LayoutOrder = v78.order
		v81.Parent = v_u_23.SelectGloop
		v81.ImageLabel.Image = v80.Icon
		v81.Title.Text = v80.Name
		v81.Success.Visible = false
		v_u_35[v_u_79] = v81
		v81.Activated:Connect(function()
			-- upvalues: (ref) v_u_11, (ref) v_u_8, (ref) v_u_33, (copy) v_u_79, (ref) v_u_32, (ref) v_u_61
			if v_u_11.has(v_u_8.BulkGloopCraft) then
				v_u_33[v_u_79] = not v_u_33[v_u_79]
				if not v_u_33[v_u_79] then
					v_u_33[v_u_79] = nil
				end
			elseif v_u_32 == v_u_79 then
				v_u_32 = nil
			else
				v_u_32 = v_u_79
			end
			v_u_61()
		end)
	end
	v71:Destroy()
end
function v21.loadCostTemplates(_)
	-- upvalues: (copy) v_u_23, (copy) v_u_6, (copy) v_u_36, (copy) v_u_3, (copy) v_u_7, (ref) v_u_37
	local v82 = v_u_23.CraftingCost.Template
	for v83, v84 in v_u_6 do
		local v85 = v82:Clone()
		v85.Visible = false
		v85.Name = v83
		v85.Parent = v_u_23.CraftingCost
		v85.ImageLabel.Image = v84.Icon
		v85.Title.Text = "x0"
		v_u_36[v83] = v85
	end
	local v86 = v_u_3[v_u_7.Shards]
	local v87 = v82:Clone()
	v87.Visible = false
	v87.Name = "Shards"
	v87.Parent = v_u_23.CraftingCost
	v87.ImageLabel.Image = v86.Icon
	v87.Title.Text = "x0"
	v_u_37 = v87
	v82:Destroy()
end
function v21.loadProgressTemplates(_)
	-- upvalues: (copy) v_u_24, (copy) v_u_6, (copy) v_u_5, (copy) v_u_38
	local v88 = v_u_24.SelectGloop.Template
	for v89, v90 in v_u_6 do
		if v_u_5[v89] then
			local v91 = v88:Clone()
			v91.Visible = false
			v91.Name = v89
			v91.Parent = v_u_24.SelectGloop
			v91.ImageLabel.Image = v90.Icon
			v91.Title.Text = "x0"
			v91.LayoutOrder = v_u_5[v89].Order
			v_u_38[v89] = v91
		end
	end
	v88:Destroy()
end
function v21.loadGamepasses(_)
	-- upvalues: (copy) v_u_25, (copy) v_u_31, (copy) v_u_4, (copy) v_u_11, (copy) v_u_9, (copy) v_u_12, (copy) v_u_10, (copy) v_u_15, (copy) v_u_30, (copy) v_u_14
	local v92 = v_u_25.Template
	for _, v_u_93 in v_u_31 do
		local v_u_94 = v_u_4[v_u_93]
		if v_u_94 then
			local v_u_95 = v92:Clone()
			v_u_95.LayoutOrder = v_u_94.Order or 99
			v_u_95.Visible = true
			v_u_95.Parent = v92.Parent
			v_u_95.Name = tostring(v_u_93)
			v_u_95.Title.Text = v_u_94.Name
			v_u_95.Desc.Text = v_u_94.Description
			v_u_95.Icon.Image = v_u_94.Icon
			v_u_95.Faded_Icon.Image = v_u_95.Icon.Image
			v_u_95.UIGradient.Color = v_u_94.Gradient or ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 220, 95)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 160, 50)) })
			if v_u_94.Rotation then
				v_u_95.UIGradient.Rotation = v_u_94.Rotation
			end
			if v_u_94.Animated then
				v_u_95.UIGradient:AddTag("Gradient")
			end
			local v_u_96 = false
			v_u_11.observe(v_u_94.ID, function(p97)
				-- upvalues: (ref) v_u_96, (copy) v_u_95
				if p97 then
					v_u_96 = true
					v_u_95.Buttons.Robux.Price.Text = "Owned"
				end
			end)
			v_u_95.Buttons.Gift.Visible = v_u_9.Gamepasses[v_u_93] ~= nil
			v_u_12.ObserveGamepass(v_u_94.ID, function(p98)
				-- upvalues: (copy) v_u_95, (ref) v_u_96, (ref) v_u_10
				v_u_95.Visible = p98.IsForSale
				v_u_95.Desc.Text = p98.Description
				v_u_95.Title.Text = p98.Name
				v_u_95.Icon.Image = ("rbxassetid://%*"):format(p98.IconImageAssetId)
				v_u_95.Faded_Icon.Image = v_u_95.Icon.Image
				if not v_u_96 then
					v_u_95.Buttons.Robux.Price.Text = v_u_10.robux((("%*"):format((v_u_10.comma(p98.PriceInRobux)))))
				end
			end)
			v_u_95.Buttons.Robux.Activated:Connect(function()
				-- upvalues: (ref) v_u_96, (ref) v_u_12, (copy) v_u_94
				if not v_u_96 then
					v_u_12.PromptGamepass(v_u_94.ID)
				end
			end)
			v_u_95.Buttons.Gift.Activated:Connect(function()
				-- upvalues: (ref) v_u_15, (ref) v_u_11, (copy) v_u_94, (ref) v_u_30, (copy) v_u_93, (ref) v_u_14
				v_u_15.open(function(p99)
					-- upvalues: (ref) v_u_11, (ref) v_u_94, (ref) v_u_30, (ref) v_u_93, (ref) v_u_14
					local v100 = v_u_11.fetch(p99)
					if v100 and table.find(v100, v_u_94.ID) then
						return false, "Player already owns this gamepass!"
					end
					local v101, v102 = v_u_30.invoke(p99, v_u_93)
					if v101 then
						return true
					end
					v_u_14.Notify({
						["Message"] = v102,
						["Type"] = v_u_14.Types.Error
					})
					return false, v102
				end)
			end)
		end
	end
	v92:Destroy()
end
function v21.setupButtons(_)
	-- upvalues: (copy) v_u_23, (ref) v_u_34, (copy) v_u_57, (copy) v_u_43, (copy) v_u_14, (copy) v_u_28, (copy) v_u_24, (copy) v_u_12, (copy) v_u_9, (copy) v_u_2, (copy) v_u_29
	v_u_23.Buttons.Left.Activated:Connect(function()
		-- upvalues: (ref) v_u_34, (ref) v_u_57
		local v103 = v_u_34 - 1
		v_u_34 = math.max(1, v103)
		v_u_57()
	end)
	v_u_23.Buttons.Right.Activated:Connect(function()
		-- upvalues: (ref) v_u_34, (ref) v_u_57
		v_u_34 = v_u_34 + 1
		v_u_57()
	end)
	v_u_23.Buttons.Craft.Activated:Connect(function()
		-- upvalues: (ref) v_u_43, (ref) v_u_14, (ref) v_u_28, (ref) v_u_34
		local v104 = v_u_43()
		if #v104 == 0 then
			v_u_14.Notify({
				["Message"] = "Select a gloop type to craft!",
				["Type"] = v_u_14.Types.Error
			})
		else
			for _, v105 in v104 do
				local v106, v107 = v_u_28.invoke(v105, v_u_34)
				v_u_14.Notify({
					["Message"] = v107,
					["Type"] = v106 and v_u_14.Types.Success or v_u_14.Types.Error
				})
			end
		end
	end)
	v_u_24.Buttons.Skip.Activated:Connect(function()
		-- upvalues: (ref) v_u_12, (ref) v_u_9
		v_u_12.PromptProduct(v_u_9.SkipGloopCraftTimer)
	end)
	v_u_24.Buttons.Claim.Activated:Connect(function()
		-- upvalues: (ref) v_u_2, (ref) v_u_12, (ref) v_u_9, (ref) v_u_29, (ref) v_u_14
		local v108 = false
		for _, v109 in v_u_2:getValue({ "GloopCraft" }) or {} do
			if v109.Timer > 0 then
				v108 = true
				break
			end
		end
		if v108 then
			v_u_12.PromptProduct(v_u_9.SkipGloopCraftTimer)
		else
			local v110, v111 = v_u_29.invoke()
			v_u_14.Notify({
				["Message"] = v111,
				["Type"] = v110 and v_u_14.Types.Success or v_u_14.Types.Error
			})
		end
	end)
end
function v21.setupObservers(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_68, (copy) v_u_57
	v_u_2:onChange(function(_, p112, _, _)
		-- upvalues: (ref) v_u_68, (ref) v_u_57
		if p112[1] == "GloopCraft" then
			v_u_68()
		elseif p112[1] == "Currency" or p112[1] == "Gloop" then
			v_u_57()
		end
	end)
	v_u_68()
end
function v21.init(p113)
	p113:loadSelectGloops()
	p113:loadCostTemplates()
	p113:loadProgressTemplates()
	p113:loadGamepasses()
	p113:setupButtons()
	p113:setupObservers()
end
return v21]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GloopCrafting]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3787"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("GuiService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Config.CurrencyData)
local v_u_4 = require(v2.Config.PetAttributeData)
local v_u_5 = require(v2.Config.PetSlimeData)
local v_u_6 = require(v2.Config.RarityData)
local v_u_7 = require(v2.Config.ShardsPackData)
local v_u_8 = require(v2.Enums.CurrencyTypes)
local v9 = require(v2.Enums.PetAttributeTypes)
local v_u_10 = require(v2.Enums.Products)
local v_u_11 = require(v2.Client.Gameplay.Candy.PetRollController)
local v_u_12 = require(v2.Utility.Format)
local v_u_13 = require(v2.Utility.Marketplace)
local v14 = require(v2.Utility.Network)
local v_u_15 = require(v2.Utility.Notify)
local v_u_16 = require(v2.Utility.Spring)
local v_u_17 = require(v2.Utility.UI)
local v18 = {}
local v_u_19 = v_u_17:get("Gui", "RollAPet")
local v_u_20 = v_u_19.Container
local v_u_21 = v_u_20.Position
local v_u_22 = v_u_21 + UDim2.fromScale(0, 0.5)
local v_u_23 = v14.remoteFunction("PetRollService/RequestRoll")
local v_u_24 = v14.remoteFunction("PetRollService/RecoverRoll")
local v_u_25 = nil
local v_u_26 = nil
local v_u_27 = nil
local v_u_28 = nil
local v_u_29 = {}
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = {}
local v_u_33 = {}
local v_u_34 = false
local v_u_35 = {
	[v9.PetAttackSpeed] = "PetAttackSpeed",
	[v9.PetDamage] = "PetDamagePercent",
	[v9.PetAgility] = "PetAgility",
	[v9.PetCoinMultiplier] = "PetCoinMultiplier",
	[v9.PetRange] = "PetRange",
	[v9.PetCritChance] = "PetCritChance"
}
local function v_u_38(p36, p37)
	if p36 == "PetAttackSpeed" then
		if p37 == 0 then
			return "0s", false
		else
			return string.format("-%.2fs", p37), true
		end
	elseif p36 == "PetDamagePercent" or p36 == "PetCritChance" then
		if p37 == 0 then
			return "0%", false
		else
			return string.format("+%.1f%%", p37 * 100), true
		end
	elseif p36 == "PetCoinMultiplier" then
		if p37 <= 1 then
			return "x1.00", false
		else
			return string.format("x%.2f", p37), true
		end
	elseif p36 == "PetAgility" then
		if p37 == 0 then
			return "0", false
		else
			return string.format("+%d", p37), true
		end
	elseif p36 == "PetRange" then
		if p37 == 0 then
			return "0", false
		else
			return string.format("+%.1f", p37), true
		end
	else
		return tostring(p37), p37 ~= 0
	end
end
local function v_u_57(p39, p40)
	-- upvalues: (ref) v_u_26, (copy) v_u_6, (ref) v_u_30, (ref) v_u_31, (copy) v_u_29, (copy) v_u_35, (copy) v_u_38, (copy) v_u_1, (copy) v_u_19
	if v_u_26 then
		local v41 = v_u_6[p40.Rarity]
		v_u_30.Text = p40.Name
		v_u_30.TextColor3 = v41.Color
		v_u_31.Color = v41.Color
		for v42, v43 in v_u_29 do
			local v44 = v_u_35[v42]
			if v44 then
				local v45, v46 = v_u_38(v44, p40.BaseStats and (p40.BaseStats[v44] or 0) or 0)
				v43.Text = v45
				local v47
				if v46 then
					v47 = Color3.fromRGB(80, 255, 80)
				else
					v47 = Color3.fromRGB(90, 90, 110)
				end
				v43.TextColor3 = v47
			end
		end
		local v48 = v_u_1:GetGuiInset()
		local v49 = p39.AbsolutePosition
		local v50 = p39.AbsoluteSize
		local v51 = v_u_19.AbsoluteSize.Y
		local v52 = v49.X + v50.X + 8
		local v53 = v49.Y - v48.Y
		local v54 = v_u_26.AbsoluteSize.Y
		if v54 > 0 then
			local v55 = v51 - v54 - 8
			local v56 = math.max(0, v55)
			v53 = math.clamp(v53, 0, v56)
		end
		v_u_26.Position = UDim2.fromOffset(v52, v53)
		v_u_26.Visible = true
	end
end
function v18.open(_)
	-- upvalues: (copy) v_u_17, (copy) v_u_11, (copy) v_u_20, (copy) v_u_5, (copy) v_u_3, (copy) v_u_8, (copy) v_u_12, (copy) v_u_16, (copy) v_u_21, (ref) v_u_25, (ref) v_u_27
	v_u_17:setHUD({})
	local v58 = v_u_11:getPendingRecoveryPet()
	local v59 = v_u_20.Frame.Purchase
	if v58 then
		v59.ImageLabel.Visible = false
		v59.TextLabel.Text = "Recover"
	else
		v59.ImageLabel.Visible = true
		local v60 = v_u_5.RollCost
		local v61 = v_u_3[v_u_8.Shards]
		v59.ImageLabel.Image = v61.Icon
		v59.TextLabel.Text = v_u_12.abbreviateComma(v60)
	end
	local v62 = {
		["Position"] = v_u_21,
		["Visible"] = true
	}
	v_u_16.target(v_u_20, 0.8, 5, v62)
	if v_u_25 then
		local v63 = {
			["Position"] = v_u_27,
			["Visible"] = true
		}
		v_u_16.target(v_u_25, 0.8, 5, v63)
	end
end
function v18.close(_)
	-- upvalues: (copy) v_u_16, (copy) v_u_20, (copy) v_u_22, (ref) v_u_25, (ref) v_u_28, (ref) v_u_26
	local v64 = {
		["Position"] = v_u_22,
		["Visible"] = false
	}
	v_u_16.target(v_u_20, 0.8, 5, v64)
	if v_u_25 then
		local v65 = {
			["Position"] = v_u_28,
			["Visible"] = false
		}
		v_u_16.target(v_u_25, 0.8, 5, v65)
		if v_u_26 then
			v_u_26.Visible = false
		end
	end
end
function v18.setupShards(_)
	-- upvalues: (copy) v_u_20, (copy) v_u_10, (copy) v_u_7, (copy) v_u_12, (copy) v_u_13
	for _, v_u_66 in v_u_20.Products.Shards:GetChildren() do
		if v_u_66:IsA("Frame") then
			local v67 = v_u_66.Name
			local v68 = tonumber(v67)
			local v_u_69 = v_u_10.Shards[v68]
			local v70 = v_u_7[v_u_69]
			v_u_66.TextLabel.Text = ("%* Shards"):format((v_u_12.comma(v70)))
			v_u_66.Purchase.Activated:Connect(function()
				-- upvalues: (ref) v_u_13, (copy) v_u_69
				v_u_13.PromptProduct(v_u_69)
			end)
			v_u_13.ObserveProduct(v_u_69, function(p71)
				-- upvalues: (copy) v_u_66, (ref) v_u_12
				v_u_66.Purchase.Price.Text = ("%*"):format((v_u_12.robux(v_u_12.comma(p71.PriceInRobux))))
			end)
		end
	end
end
function v18.setupTooltip(_)
	-- upvalues: (copy) v_u_19, (copy) v_u_4, (copy) v_u_29, (ref) v_u_26, (ref) v_u_30, (ref) v_u_31
	local v72 = Instance.new("Frame")
	v72.Name = "PetTooltip"
	v72.Size = UDim2.new(0.15, 0, 0, 0)
	v72.AutomaticSize = Enum.AutomaticSize.Y
	v72.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
	v72.BackgroundTransparency = 0.05
	v72.BorderSizePixel = 0
	v72.Visible = false
	v72.ZIndex = 20
	v72.Parent = v_u_19
	local v73 = Instance.new("UICorner")
	v73.CornerRadius = UDim.new(0, 18)
	v73.Parent = v72
	local v74 = Instance.new("UIStroke")
	v74.Name = "RarityStroke"
	v74.Thickness = 3.5
	v74.Color = Color3.fromRGB(255, 255, 255)
	v74.Parent = v72
	local v75 = Instance.new("UIPadding")
	v75.PaddingTop = UDim.new(0, 14)
	v75.PaddingBottom = UDim.new(0, 14)
	v75.PaddingLeft = UDim.new(0, 14)
	v75.PaddingRight = UDim.new(0, 14)
	v75.Parent = v72
	local v76 = Instance.new("UIListLayout")
	v76.SortOrder = Enum.SortOrder.LayoutOrder
	v76.Padding = UDim.new(0, 5)
	v76.Parent = v72
	local v77 = Instance.new("TextLabel")
	v77.Name = "Header"
	v77.Size = UDim2.new(1, 0, 0, 24)
	v77.BackgroundTransparency = 1
	v77.Font = Enum.Font.FredokaOne
	v77.TextSize = 18
	v77.TextXAlignment = Enum.TextXAlignment.Center
	v77.TextColor3 = Color3.fromRGB(255, 255, 255)
	v77.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	v77.TextStrokeTransparency = 0.5
	v77.LayoutOrder = 0
	v77.ZIndex = 20
	v77.Parent = v72
	local v78 = Instance.new("Frame")
	v78.Name = "Separator"
	v78.Size = UDim2.new(1, 0, 0, 3)
	v78.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	v78.BorderSizePixel = 0
	v78.LayoutOrder = 1
	v78.ZIndex = 20
	v78.Parent = v72
	local v79 = Instance.new("UICorner")
	v79.CornerRadius = UDim.new(0, 2)
	v79.Parent = v78
	local v80 = Instance.new("TextLabel")
	v80.Name = "StatsLabel"
	v80.Size = UDim2.new(1, 0, 0, 18)
	v80.BackgroundTransparency = 1
	v80.Text = "BASE STATS"
	v80.Font = Enum.Font.FredokaOne
	v80.TextSize = 13
	v80.TextXAlignment = Enum.TextXAlignment.Left
	v80.TextColor3 = Color3.fromRGB(180, 180, 200)
	v80.LayoutOrder = 2
	v80.ZIndex = 20
	v80.Parent = v72
	local v81 = {}
	for v82, v83 in v_u_4 do
		table.insert(v81, {
			["type"] = v82,
			["data"] = v83
		})
	end
	table.sort(v81, function(p84, p85)
		return p84.data.Order < p85.data.Order
	end)
	for v86, v87 in v81 do
		local v88 = Instance.new("Frame")
		v88.Name = v87.type
		v88.Size = UDim2.new(1, 0, 0, 24)
		v88.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
		v88.BorderSizePixel = 0
		v88.LayoutOrder = 10 + v86
		v88.ZIndex = 20
		v88.Parent = v72
		local v89 = Instance.new("UICorner")
		v89.CornerRadius = UDim.new(0, 8)
		v89.Parent = v88
		local v90 = Instance.new("UIPadding")
		v90.PaddingLeft = UDim.new(0, 6)
		v90.PaddingRight = UDim.new(0, 6)
		v90.Parent = v88
		local v91 = Instance.new("ImageLabel")
		v91.Size = UDim2.fromOffset(16, 16)
		v91.Position = UDim2.new(0, 0, 0.5, 0)
		v91.AnchorPoint = Vector2.new(0, 0.5)
		v91.BackgroundTransparency = 1
		v91.Image = v87.data.Icon
		v91.ZIndex = 21
		v91.Parent = v88
		local v92 = Instance.new("TextLabel")
		v92.Size = UDim2.new(0.5, -20, 1, 0)
		v92.Position = UDim2.new(0, 20, 0, 0)
		v92.BackgroundTransparency = 1
		v92.Text = v87.data.Name
		v92.Font = Enum.Font.GothamBold
		v92.TextSize = 12
		v92.TextXAlignment = Enum.TextXAlignment.Left
		v92.TextColor3 = Color3.fromRGB(220, 220, 240)
		v92.ZIndex = 21
		v92.Parent = v88
		local v93 = Instance.new("TextLabel")
		v93.Name = "Value"
		v93.Size = UDim2.new(0.5, 0, 1, 0)
		v93.Position = UDim2.new(0.5, 0, 0, 0)
		v93.BackgroundTransparency = 1
		v93.Font = Enum.Font.FredokaOne
		v93.TextSize = 13
		v93.TextXAlignment = Enum.TextXAlignment.Right
		v93.TextColor3 = Color3.fromRGB(90, 90, 110)
		v93.ZIndex = 21
		v93.Parent = v88
		v_u_29[v87.type] = v93
	end
	v_u_26 = v72
	v_u_30 = v77
	v_u_31 = v74
end
function v18.setupCatalog(p94)
	-- upvalues: (copy) v_u_19, (ref) v_u_27, (ref) v_u_28, (copy) v_u_5, (copy) v_u_6, (copy) v_u_16, (copy) v_u_33, (copy) v_u_32, (copy) v_u_57, (ref) v_u_26, (ref) v_u_25
	p94:setupTooltip()
	local v95 = Instance.new("Frame")
	v95.Name = "PetCatalog"
	v95.Size = UDim2.fromScale(0.19, 0.72)
	v95.AnchorPoint = Vector2.new(0, 0.5)
	v95.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
	v95.BackgroundTransparency = 0.05
	v95.BorderSizePixel = 0
	v95.ZIndex = 5
	v95.Visible = false
	v95.Parent = v_u_19
	v_u_27 = UDim2.fromScale(0.01, 0.5)
	v_u_28 = UDim2.fromScale(-0.2, 0.5)
	v95.Position = v_u_28
	local v96 = Instance.new("UICorner")
	v96.CornerRadius = UDim.new(0, 18)
	v96.Parent = v95
	local v97 = Instance.new("UIStroke")
	v97.Thickness = 3.5
	v97.Color = Color3.fromRGB(80, 80, 120)
	v97.Parent = v95
	local v98 = Instance.new("TextLabel")
	v98.Name = "Title"
	v98.Size = UDim2.fromScale(1, 0.06)
	v98.Position = UDim2.fromScale(0, 0.01)
	v98.BackgroundTransparency = 1
	v98.Text = "Pet Chances"
	v98.Font = Enum.Font.FredokaOne
	v98.TextScaled = true
	v98.TextColor3 = Color3.fromRGB(255, 255, 255)
	v98.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	v98.TextStrokeTransparency = 0.5
	v98.ZIndex = 6
	v98.Parent = v95
	local v99 = Instance.new("UITextSizeConstraint")
	v99.MaxTextSize = 22
	v99.MinTextSize = 12
	v99.Parent = v98
	local v100 = Instance.new("ScrollingFrame")
	v100.Name = "Scroll"
	v100.Size = UDim2.fromScale(0.97, 0.91)
	v100.Position = UDim2.fromScale(0.015, 0.08)
	v100.BackgroundTransparency = 1
	v100.BorderSizePixel = 0
	v100.ScrollBarThickness = 5
	v100.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 120)
	v100.CanvasSize = UDim2.new(0, 0, 0, 0)
	v100.AutomaticCanvasSize = Enum.AutomaticSize.Y
	v100.ZIndex = 5
	v100.Parent = v95
	local v101 = Instance.new("UIPadding")
	v101.PaddingTop = UDim.new(0, 6)
	v101.PaddingBottom = UDim.new(0, 6)
	v101.PaddingLeft = UDim.new(0, 6)
	v101.PaddingRight = UDim.new(0, 6)
	v101.Parent = v100
	local v102 = Instance.new("UIListLayout")
	v102.SortOrder = Enum.SortOrder.LayoutOrder
	v102.Padding = UDim.new(0, 6)
	v102.HorizontalAlignment = Enum.HorizontalAlignment.Center
	v102.Parent = v100
	local v103 = v_u_5.TotalWeight
	for _, v_u_104 in v_u_5.OrderedPets do
		local v_u_105 = v_u_5.Pets[v_u_104]
		local v106 = v_u_6[v_u_105.Rarity]
		local v107 = v_u_105.Weight / v103 * 100
		local v_u_108 = Instance.new("Frame")
		v_u_108.Name = v_u_104
		v_u_108.Size = UDim2.new(1, 0, 0, 72)
		v_u_108.LayoutOrder = v_u_105.Order
		v_u_108.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
		v_u_108.BackgroundTransparency = 0
		v_u_108.BorderSizePixel = 0
		v_u_108.ZIndex = 5
		v_u_108.Parent = v100
		local v109 = Instance.new("UICorner")
		v109.CornerRadius = UDim.new(0, 14)
		v109.Parent = v_u_108
		local v_u_110 = Instance.new("UIStroke")
		v_u_110.Thickness = 3
		v_u_110.Color = v106.Color
		v_u_110.Transparency = 0.3
		v_u_110.Parent = v_u_108
		local v_u_111 = Instance.new("UIScale")
		v_u_111.Scale = 1
		v_u_111.Parent = v_u_108
		local v_u_112 = Instance.new("Frame")
		v_u_112.Name = "Glow"
		v_u_112.Size = UDim2.fromScale(0.9, 0.9)
		v_u_112.SizeConstraint = Enum.SizeConstraint.RelativeYY
		v_u_112.Position = UDim2.fromScale(0.04, 0.5)
		v_u_112.AnchorPoint = Vector2.new(0, 0.5)
		v_u_112.BackgroundColor3 = v_u_105.Color
		v_u_112.BackgroundTransparency = 0.6
		v_u_112.ZIndex = 5
		v_u_112.Parent = v_u_108
		local v113 = Instance.new("UICorner")
		v113.CornerRadius = UDim.new(1, 0)
		v113.Parent = v_u_112
		local v114 = Instance.new("ViewportFrame")
		v114.Name = "Viewport"
		v114.Size = UDim2.fromScale(0.82, 0.82)
		v114.SizeConstraint = Enum.SizeConstraint.RelativeYY
		v114.Position = UDim2.fromScale(0.04, 0.5)
		v114.AnchorPoint = Vector2.new(0, 0.5)
		v114.BackgroundTransparency = 1
		v114.Ambient = Color3.fromRGB(200, 200, 200)
		v114.LightColor = Color3.fromRGB(255, 255, 255)
		v114.LightDirection = Vector3.new(-1, -1, -1)
		v114.ZIndex = 6
		v114.Parent = v_u_108
		if v_u_105.Model then
			local v_u_115 = v_u_105.Model:Clone()
			local v_u_116 = CFrame.new(0, 0, 1) * CFrame.Angles(0, -0.3490658503988659, 0)
			v_u_115:PivotTo(v_u_116)
			v_u_115.Parent = v114
			local v117 = Instance.new("Camera")
			v117.CFrame = CFrame.new(Vector3.new(1.5, 0.3, -3), Vector3.new(0, 0, 1))
			v117.Parent = v114
			v114.CurrentCamera = v117
			task.spawn(function()
				-- upvalues: (copy) v_u_116, (copy) v_u_115, (ref) v_u_16
				local v118 = v_u_116
				while v_u_115.Parent do
					v_u_16.target(v_u_115, 0.3, 2, {
						["Pivot"] = v118 + Vector3.new(0, 0.5, 0)
					})
					task.wait(0.3)
					v_u_16.target(v_u_115, 0.3, 2, {
						["Pivot"] = v118
					})
					task.wait(0.6)
				end
			end)
		end
		local v119 = Instance.new("TextLabel")
		v119.Name = "PetName"
		v119.Size = UDim2.fromScale(0.36, 0.38)
		v119.Position = UDim2.fromScale(0.3, 0.08)
		v119.BackgroundTransparency = 1
		v119.Text = v_u_105.Name
		v119.Font = Enum.Font.FredokaOne
		v119.TextScaled = true
		v119.TextXAlignment = Enum.TextXAlignment.Left
		v119.TextColor3 = Color3.fromRGB(255, 255, 255)
		v119.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		v119.TextStrokeTransparency = 0.5
		v119.TextTruncate = Enum.TextTruncate.AtEnd
		v119.ZIndex = 6
		v119.Parent = v_u_108
		local v120 = Instance.new("UITextSizeConstraint")
		v120.MaxTextSize = 16
		v120.MinTextSize = 9
		v120.Parent = v119
		local v121 = Instance.new("TextLabel")
		v121.Name = "Rarity"
		v121.Size = UDim2.fromScale(0.36, 0.28)
		v121.Position = UDim2.fromScale(0.3, 0.55)
		v121.BackgroundTransparency = 1
		v121.Text = v106.Name
		v121.Font = Enum.Font.FredokaOne
		v121.TextScaled = true
		v121.TextXAlignment = Enum.TextXAlignment.Left
		v121.TextColor3 = v106.Color
		v121.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		v121.TextStrokeTransparency = 0.5
		v121.ZIndex = 6
		v121.Parent = v_u_108
		local v122 = Instance.new("UITextSizeConstraint")
		v122.MaxTextSize = 13
		v122.MinTextSize = 8
		v122.Parent = v121
		local v123 = Instance.new("TextLabel")
		v123.Name = "Chance"
		v123.Size = UDim2.fromScale(0.32, 0.5)
		v123.Position = UDim2.fromScale(0.96, 0.5)
		v123.AnchorPoint = Vector2.new(1, 0.5)
		v123.BackgroundTransparency = 1
		v123.Font = Enum.Font.FredokaOne
		v123.TextScaled = true
		v123.TextXAlignment = Enum.TextXAlignment.Right
		v123.TextColor3 = Color3.fromRGB(255, 220, 50)
		v123.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		v123.TextStrokeTransparency = 0.5
		v123.ZIndex = 6
		v123.Parent = v_u_108
		local v124 = Instance.new("UITextSizeConstraint")
		v124.MaxTextSize = 17
		v124.MinTextSize = 10
		v124.Parent = v123
		if v107 >= 1 then
			v123.Text = string.format("%.1f%%", v107)
		elseif v107 >= 0.01 then
			v123.Text = string.format("%.2f%%", v107)
		else
			v123.Text = string.format("%.3f%%", v107)
		end
		local v_u_125 = Instance.new("ImageLabel")
		v_u_125.Name = "Checkmark"
		v_u_125.Size = UDim2.fromOffset(24, 24)
		v_u_125.Position = UDim2.new(1, -6, 0, 6)
		v_u_125.AnchorPoint = Vector2.new(1, 0)
		v_u_125.BackgroundTransparency = 1
		v_u_125.Image = "rbxassetid://6031094678"
		v_u_125.ImageColor3 = Color3.fromRGB(80, 255, 80)
		v_u_125.ZIndex = 8
		v_u_125.Visible = false
		v_u_125.Parent = v_u_108
		v_u_33[v_u_104] = v_u_125
		local v126 = Instance.new("TextButton")
		v126.Name = "ClickOverlay"
		v126.Size = UDim2.fromScale(1, 1)
		v126.BackgroundTransparency = 1
		v126.Text = ""
		v126.ZIndex = 7
		v126.Parent = v_u_108
		v126.Activated:Connect(function()
			-- upvalues: (ref) v_u_32, (copy) v_u_104, (copy) v_u_125
			if v_u_32[v_u_104] then
				v_u_32[v_u_104] = nil
				v_u_125.Visible = false
			else
				v_u_32[v_u_104] = true
				v_u_125.Visible = true
			end
		end)
		v126.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u_16, (copy) v_u_111, (copy) v_u_108, (copy) v_u_110, (copy) v_u_112, (ref) v_u_57, (copy) v_u_105
			v_u_16.target(v_u_111, 0.5, 6, {
				["Scale"] = 1.04
			})
			v_u_16.target(v_u_108, 0.6, 8, {
				["BackgroundColor3"] = Color3.fromRGB(45, 45, 65)
			})
			v_u_16.target(v_u_110, 0.6, 8, {
				["Transparency"] = 0
			})
			v_u_16.target(v_u_112, 0.5, 6, {
				["BackgroundTransparency"] = 0.35
			})
			v_u_57(v_u_108, v_u_105)
		end)
		v126.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_16, (copy) v_u_111, (copy) v_u_108, (copy) v_u_110, (copy) v_u_112, (ref) v_u_26
			v_u_16.target(v_u_111, 0.7, 5, {
				["Scale"] = 1
			})
			v_u_16.target(v_u_108, 0.6, 5, {
				["BackgroundColor3"] = Color3.fromRGB(30, 30, 45)
			})
			v_u_16.target(v_u_110, 0.6, 5, {
				["Transparency"] = 0.3
			})
			v_u_16.target(v_u_112, 0.7, 5, {
				["BackgroundTransparency"] = 0.6
			})
			if v_u_26 then
				v_u_26.Visible = false
			end
		end)
	end
	v_u_25 = v95
end
function v18.init(p127)
	-- upvalues: (copy) v_u_5, (copy) v_u_3, (copy) v_u_8, (copy) v_u_20, (copy) v_u_12, (copy) v_u_11, (copy) v_u_17, (copy) v_u_24, (copy) v_u_23, (copy) v_u_15, (copy) v_u_32, (ref) v_u_34
	local v128 = v_u_5.RollCost
	local v129 = v_u_3[v_u_8.Shards]
	v_u_20.Frame.Purchase.ImageLabel.Image = v129.Icon
	v_u_20.Frame.Purchase.TextLabel.Text = v_u_12.abbreviateComma(v128)
	v_u_20.Frame.Purchase.Activated:Connect(function()
		-- upvalues: (ref) v_u_11, (ref) v_u_17, (ref) v_u_24, (ref) v_u_23, (ref) v_u_15
		local v130 = v_u_11:getPendingRecoveryPet()
		v_u_17:hideAll()
		local v131, v132
		if v130 then
			v_u_11:clearPendingRecoveryPet()
			v131, v132 = v_u_24.invoke()
		else
			v131, v132 = v_u_23.invoke()
		end
		if not v131 then
			v_u_17:showAll()
			v_u_15.Notify({
				["Message"] = v132,
				["Type"] = v_u_15.Types.Error
			})
		end
	end)
	v_u_20.Frame.Auto.Activated:Connect(function()
		-- upvalues: (ref) v_u_32, (ref) v_u_15, (ref) v_u_34, (ref) v_u_17, (ref) v_u_23
		if next(v_u_32) then
			v_u_34 = true
			v_u_17:hideAll()
			local v133, v134 = v_u_23.invoke()
			if not v133 then
				v_u_34 = false
				v_u_17:showAll()
				v_u_15.Notify({
					["Message"] = v134,
					["Type"] = v_u_15.Types.Error
				})
			end
		else
			v_u_15.Notify({
				["Message"] = "Select at least one pet to auto-roll for!",
				["Type"] = v_u_15.Types.Error
			})
		end
	end)
	p127:setupShards()
	p127:setupCatalog()
end
function v18.isAutoActive()
	-- upvalues: (ref) v_u_34
	return v_u_34
end
function v18.getAutoTargets()
	-- upvalues: (copy) v_u_32
	return v_u_32
end
function v18.stopAuto()
	-- upvalues: (ref) v_u_34
	v_u_34 = false
end
return v18]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RollAPet]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3788"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Config.CandyData)
local v4 = require(v1.Utility.Network)
local v_u_5 = require(v1.Utility.Spring)
local v_u_6 = require(v1.Utility.UI)
local v7 = {}
local v_u_8 = v4.remoteEvent("CandySlimeService/TeleportToZone")
local v_u_9 = v_u_6:get("Gui", "CandyTeleport").Container
local v_u_10 = v_u_9.Container.ScrollingFrame
local v_u_11 = v_u_10.Template
local v_u_12 = v_u_9.Position
local v_u_13 = v_u_12 + UDim2.fromScale(0, 0.2)
function v7.open(_)
	-- upvalues: (copy) v_u_5, (copy) v_u_9, (copy) v_u_12
	local v14 = {
		["Position"] = v_u_12,
		["Visible"] = true
	}
	v_u_5.target(v_u_9, 0.8, 5, v14)
end
function v7.close(_)
	-- upvalues: (copy) v_u_5, (copy) v_u_9, (copy) v_u_13
	local v15 = {
		["Position"] = v_u_13,
		["Visible"] = false
	}
	v_u_5.target(v_u_9, 0.8, 5, v15)
end
function v7.setup(_) end
function v7.init(_)
	-- upvalues: (copy) v_u_3, (copy) v_u_11, (copy) v_u_10, (copy) v_u_2, (copy) v_u_8, (copy) v_u_6
	for v_u_16, _ in v_u_3.Zones do
		local v_u_17 = v_u_11:Clone()
		v_u_17.Visible = true
		v_u_17.LayoutOrder = v_u_16
		v_u_17.Parent = v_u_10
		v_u_17.Container.Title.Text = ("Zone %*"):format(v_u_16)
		local v_u_18 = v_u_16 > 1
		v_u_17.Container.Locked.Visible = v_u_18
		if v_u_16 > 1 then
			v_u_2:onSet({ "Candy", "UnlockedZones", (tostring(v_u_16)) }, function(p19)
				-- upvalues: (ref) v_u_18, (copy) v_u_17
				v_u_18 = p19 ~= true
				v_u_17.Container.Locked.Visible = v_u_18
			end)
		end
		v_u_17.Container.Teleport.Activated:Connect(function()
			-- upvalues: (ref) v_u_18, (ref) v_u_8, (copy) v_u_16, (ref) v_u_6
			if not v_u_18 then
				v_u_8.fire(v_u_16)
				if v_u_6.Current == script.Name then
					v_u_6:close(script.Name)
				end
			end
		end)
	end
	v_u_11:Destroy()
end
return v7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CandyTeleport]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3789"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Hud]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3790"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Client.Currency.CurrencyController)
local v_u_4 = require(v2.Client.Data.DataController)
local v_u_5 = require(v2.Client.Gameplay.Sllimes.AutoSlimeController)
local v_u_6 = require(v2.Config.CurrencyData)
local v_u_7 = require(v2.Config.WorldData)
local v_u_8 = require(v2.Functions.IsInGroup)
local v_u_9 = require(v2.Utility.Format)
local v10 = require(v2.Utility.Network)
local v_u_11 = require(v2.Utility.Spring)
local v_u_12 = require(v2.Utility.UI)
local v_u_13 = require(v2.Utility.WorldUtil)
local v_u_14 = require(v2.Utility.ZoneUtil)
local v15 = {}
local v_u_16 = v_u_12:get("Huds", "Left").Container
local v_u_17 = v_u_16.Position
local v_u_18 = v_u_17 - UDim2.fromScale(1, 0)
local v_u_19 = v10.remoteEvent("AutoToggleEvent")
function v15.open(_)
	-- upvalues: (copy) v_u_11, (copy) v_u_16, (copy) v_u_17
	local v20 = {
		["Position"] = v_u_17,
		["Visible"] = true
	}
	v_u_11.target(v_u_16, 0.8, 5, v20)
end
function v15.close(_)
	-- upvalues: (copy) v_u_11, (copy) v_u_16, (copy) v_u_18
	local v21 = {
		["Position"] = v_u_18,
		["Visible"] = false
	}
	v_u_11.target(v_u_16, 0.8, 5, v21)
end
function v15.setupCurrency(_)
	-- upvalues: (copy) v_u_16, (copy) v_u_6, (copy) v_u_3, (copy) v_u_9, (copy) v_u_11, (copy) v_u_13, (copy) v_u_7
	local v22 = v_u_16.Currency.Template
	local v_u_23 = {}
	for v24, v25 in v_u_6 do
		if not v25.HideOnHUD then
			local v_u_26 = v22:Clone()
			v_u_26.Visible = true
			v_u_26.Icon.Image = v25.Icon
			v_u_26.LayoutOrder = v25.Order or 999
			v_u_26.Amount.Text = "0"
			v_u_26.Name = v24
			v_u_26.Parent = v_u_16.Currency
			v_u_26:AddTag("CurrencyHUD")
			v_u_3:observe(v24, function(p27)
				-- upvalues: (copy) v_u_26, (ref) v_u_9, (ref) v_u_11
				v_u_26.Amount.Text = v_u_9.abbreviateComma(p27, 999999)
				v_u_11.stop(v_u_26.Icon)
				v_u_26.Icon.Rotation = -15
				v_u_11.target(v_u_26.Icon, 0.3, 5, {
					["Rotation"] = 0
				})
			end)
			v_u_23[v24] = v_u_26
		end
	end
	v_u_13.observe(function(p28)
		-- upvalues: (ref) v_u_7, (copy) v_u_23
		local v29 = v_u_7[p28]
		if v29 then
			for v30, v31 in v_u_23 do
				v31.Visible = table.find(v29.Currencies, v30) ~= nil
			end
		end
	end)
	v22:Destroy()
end
function v15.setupAuto(_)
	-- upvalues: (copy) v_u_16, (copy) v_u_8, (copy) v_u_1, (copy) v_u_12, (copy) v_u_19, (copy) v_u_4, (copy) v_u_5, (copy) v_u_14
	local v_u_32 = v_u_16.Row3.AutoFarm
	v_u_32.Activated:Connect(function()
		-- upvalues: (ref) v_u_8, (ref) v_u_1, (ref) v_u_12, (ref) v_u_19
		if v_u_8(v_u_1.LocalPlayer) then
			v_u_19.fire("Slime")
		else
			v_u_12:open("Group")
		end
	end)
	v_u_4:onSet({ "Auto", "Slime" }, function(p33)
		-- upvalues: (copy) v_u_32, (ref) v_u_5
		v_u_32.Frame.Noti.BackgroundColor3 = p33 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 85, 127)
		if p33 then
			if not v_u_5:isActive() then
				v_u_5:start()
				return
			end
		else
			v_u_5:stop()
		end
	end)
	v_u_14.observe("SLIME_ZONE", function()
		-- upvalues: (ref) v_u_5, (ref) v_u_19
		return function()
			-- upvalues: (ref) v_u_5, (ref) v_u_19
			if v_u_5:isActive() then
				v_u_19.fire("Slime", false)
			end
		end
	end)
end
function v15.setupMySlime(_)
	-- upvalues: (copy) v_u_16, (copy) v_u_4
	local v_u_34 = v_u_16.Row3.MySlime
	v_u_34.Visible = false
	v_u_4:onSet({ "Candy", "Pet" }, function(p35)
		-- upvalues: (copy) v_u_34
		v_u_34.Visible = p35 ~= nil
	end)
end
function v15.init(p36)
	p36:setupCurrency()
	p36:setupAuto()
	p36:setupMySlime()
end
return v15]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Left]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3791"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Utility.Spring)
local v3 = {}
local v_u_4 = require(v1.Utility.UI):get("Huds", "Top").Container
local v_u_5 = v_u_4.Position
local v_u_6 = v_u_5 - UDim2.fromScale(0, 1)
function v3.open(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_5
	local v7 = {
		["Position"] = v_u_5,
		["Visible"] = true
	}
	v_u_2.target(v_u_4, 0.8, 5, v7)
end
function v3.close(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_6
	local v8 = {
		["Position"] = v_u_6,
		["Visible"] = false
	}
	v_u_2.target(v_u_4, 0.8, 5, v8)
end
function v3.init(_) end
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Top]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3792"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Utility.Spring)
local v3 = {}
local v_u_4 = require(v1.Utility.UI):get("Huds", "BottomLeft").Container
v_u_4.Template.Visible = false
local v_u_5 = v_u_4.Position
local v_u_6 = v_u_5 - UDim2.fromScale(1, 1)
function v3.open(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_5
	local v7 = {
		["Position"] = v_u_5,
		["Visible"] = true
	}
	v_u_2.target(v_u_4, 0.8, 5, v7)
end
function v3.close(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_6
	local v8 = {
		["Position"] = v_u_6,
		["Visible"] = false
	}
	v_u_2.target(v_u_4, 0.8, 5, v8)
end
function v3.init(_) end
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BottomLeft]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3793"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = require(v2.Client.Data.DataController)
local v_u_5 = require(v2.Client.Gameplay.Skills.SkillController)
local v_u_6 = require(v2.Config.SkillData)
local v_u_7 = require(v2.Packages.Observers)
local v_u_8 = require(v2.Utility.Format)
local v_u_9 = require(v2.Utility.Network)
local v_u_10 = require(v2.Utility.Spring)
local v11 = {}
local v_u_12 = require(v2.Utility.UI):get("Huds", "Bottom").Container
local v_u_13 = v_u_12.Template
v_u_13.Visible = false
local v_u_14 = v_u_12.Position
local v_u_15 = v_u_14 + UDim2.fromScale(0, 1)
local v_u_16 = {}
function v11.open(_)
	-- upvalues: (copy) v_u_10, (copy) v_u_12, (copy) v_u_14
	local v17 = {
		["Position"] = v_u_14,
		["Visible"] = true
	}
	v_u_10.target(v_u_12, 0.8, 5, v17)
end
function v11.close(_)
	-- upvalues: (copy) v_u_10, (copy) v_u_12, (copy) v_u_15
	local v18 = {
		["Position"] = v_u_15,
		["Visible"] = false
	}
	v_u_10.target(v_u_12, 0.8, 5, v18)
end
function v11.create(_, p_u_19, p20)
	-- upvalues: (copy) v_u_16, (copy) v_u_13, (copy) v_u_12, (copy) v_u_9, (copy) v_u_4, (copy) v_u_8, (copy) v_u_3
	if not v_u_16[p_u_19] then
		local v_u_21 = v_u_13:Clone()
		v_u_21.Icon.Image = p20.Icon or ""
		v_u_21.Visible = true
		v_u_21.LayoutOrder = p20.Order or 99
		v_u_21.Parent = v_u_12
		if p20.Tooltip then
			for v22, v23 in p20.Tooltip do
				v_u_21:SetAttribute(v22, v23)
			end
			v_u_21:AddTag("tooltip")
		end
		local v_u_24 = false
		if p20.Tooltip and p20.Tooltip.ItemType == "AmuletPassive" then
			local v_u_25 = v_u_9.remoteEvent("AmuletService/TogglePassive")
			v_u_21.Activated:Connect(function()
				-- upvalues: (copy) v_u_25, (copy) p_u_19
				v_u_25.fire(p_u_19)
			end)
			v_u_4:onSet({ "Amulet", "DisabledPassives", p_u_19 }, function(p26)
				-- upvalues: (ref) v_u_24, (copy) v_u_21
				v_u_24 = p26 == true
				v_u_21.Icon.ImageColor3 = v_u_24 and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(255, 255, 255)
				v_u_21.Overlay.Title.Text = v_u_24 and "Disabled" or "..."
			end)
		end
		local v_u_27 = Instance.new("NumberValue")
		v_u_27.Changed:Connect(function(p28)
			-- upvalues: (ref) v_u_24, (copy) v_u_21, (ref) v_u_8
			if not v_u_24 then
				v_u_21.Overlay.Title.Text = v_u_8.decimal(p28, 1) .. "s"
			end
		end)
		v_u_16[p_u_19] = {
			["show"] = function(_)
				-- upvalues: (copy) v_u_21
				v_u_21.Visible = true
			end,
			["hide"] = function(_)
				-- upvalues: (copy) v_u_21
				v_u_21.Visible = false
			end,
			["setText"] = function(_, p29)
				-- upvalues: (ref) v_u_24, (copy) v_u_21
				if not v_u_24 then
					v_u_21.Overlay.Title.Text = p29
				end
			end,
			["setProgress"] = function(_, p30)
				-- upvalues: (copy) v_u_21
				v_u_21.Overlay.UIGradient.Offset = Vector2.new(0, -p30)
			end,
			["startTimer"] = function(_, p31)
				-- upvalues: (copy) v_u_21, (copy) v_u_27, (ref) v_u_3
				local v32 = p31 - workspace:GetServerTimeNow()
				v_u_21.Overlay.UIGradient.Offset = Vector2.new(0, -1)
				v_u_27.Value = v32
				local v33 = TweenInfo.new(v32, Enum.EasingStyle.Linear)
				v_u_3:Create(v_u_21.Overlay.UIGradient, v33, {
					["Offset"] = Vector2.new(0, 0)
				}):Play()
				v_u_3:Create(v_u_27, v33, {
					["Value"] = 0
				}):Play()
			end
		}
	end
end
function v11.get(_, p34)
	-- upvalues: (copy) v_u_16
	return v_u_16[p34]
end
function v11.setupSkills(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_6, (copy) v_u_13, (copy) v_u_12, (copy) v_u_4, (copy) v_u_8, (copy) v_u_7, (copy) v_u_1, (copy) v_u_3, (copy) v_u_5
	local v_u_35 = v_u_9.remoteEvent("SkillService/Toggle")
	local v_u_36 = {}
	for v_u_37, v38 in v_u_6 do
		local v_u_39 = v_u_13:Clone()
		v_u_39.Icon.Image = v38.Icon
		v_u_39.LayoutOrder = v38.Order
		v_u_39.Parent = v_u_12
		v_u_39.Activated:Connect(function()
			-- upvalues: (copy) v_u_35, (copy) v_u_37
			v_u_35.fire(v_u_37)
		end)
		v_u_4:onSet({ "Skills", "Disabled", v_u_37 }, function(p40)
			-- upvalues: (copy) v_u_39
			v_u_39.Icon.ImageColor3 = p40 and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(255, 255, 255)
			v_u_39.Overlay.Title.Text = p40 and "Disabled" or "..."
		end)
		local v_u_41 = Instance.new("NumberValue")
		v_u_41.Changed:Connect(function(p42)
			-- upvalues: (copy) v_u_39, (ref) v_u_8
			if v_u_39.Overlay.Title.Text ~= "Disabled" then
				v_u_39.Overlay.Title.Text = v_u_8.decimal(p42, 1) .. "s"
			end
		end)
		v_u_7.observeAttribute(v_u_1.LocalPlayer, string.lower((("skill_%*"):format(v_u_37))), function(p43)
			-- upvalues: (copy) v_u_39, (copy) v_u_41, (ref) v_u_3
			if p43 then
				local v44 = p43 - workspace:GetServerTimeNow()
				v_u_39.Overlay.UIGradient.Offset = Vector2.new(0, -1)
				v_u_41.Value = v44
				local v45 = TweenInfo.new(v44, Enum.EasingStyle.Linear)
				v_u_3:Create(v_u_39.Overlay.UIGradient, v45, {
					["Offset"] = Vector2.new(0, 0)
				}):Play()
				v_u_3:Create(v_u_41, v45, {
					["Value"] = 0
				}):Play()
			end
		end)
		v_u_36[v_u_37] = v_u_39
	end
	for v46, v47 in v_u_36 do
		v47.Visible = v_u_5:isUnlocked(v46)
	end
	v_u_5.OnUnlocked:Connect(function(p48)
		-- upvalues: (copy) v_u_36
		if v_u_36[p48] then
			v_u_36[p48].Visible = true
		end
	end)
	v_u_5.OnReset:Connect(function()
		-- upvalues: (copy) v_u_36, (ref) v_u_5
		for v49, v50 in v_u_36 do
			v50.Visible = v_u_5:isUnlocked(v49)
		end
	end)
end
function v11.init(p51)
	p51:setupSkills()
end
return v11]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Bottom]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3794"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Enums.Products)
local v_u_4 = require(v1.Utility.Format)
local v_u_5 = require(v1.Utility.Marketplace)
local v_u_6 = require(v1.Utility.Time)
local v_u_7 = require(v1.Utility.Spring)
local v8 = {}
local v_u_9 = require(v1.Utility.UI):get("Huds", "Right").Container
local v_u_10 = v_u_9.Position
local v_u_11 = v_u_10 + UDim2.fromScale(1, 0)
function v8.open(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_9, (copy) v_u_10
	local v12 = {
		["Position"] = v_u_10,
		["Visible"] = true
	}
	v_u_7.target(v_u_9, 0.8, 5, v12)
end
function v8.close(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_9, (copy) v_u_11
	local v13 = {
		["Position"] = v_u_11,
		["Visible"] = false
	}
	v_u_7.target(v_u_9, 0.8, 5, v13)
end
function v8.setupStarterPack(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_5, (copy) v_u_3, (copy) v_u_4, (copy) v_u_2, (copy) v_u_6
	local v_u_14 = v_u_9.Packs.StarterPack
	local v_u_15 = v_u_14.Timer
	v_u_14.Price.Text = "..."
	v_u_5.ObserveProduct(v_u_3.StarterPack, function(p16)
		-- upvalues: (copy) v_u_14, (ref) v_u_4
		v_u_14.Price.Text = v_u_4.robux(v_u_4.abbreviate(p16.PriceInRobux))
	end)
	v_u_14.Activated:Connect(function()
		-- upvalues: (ref) v_u_5, (ref) v_u_3
		v_u_5.PromptProduct(v_u_3.StarterPack)
	end)
	v_u_2:onSet({ "StarterPack" }, function(p17)
		-- upvalues: (copy) v_u_14, (copy) v_u_15, (ref) v_u_6
		if type(p17) == "number" and p17 > 0 then
			v_u_14.Visible = true
			v_u_15.Text = v_u_6.format(p17)
		else
			v_u_14.Visible = false
		end
	end)
end
function v8.init(p18)
	p18:setupStarterPack()
end
return v8]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Right]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3795"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Utility.Spring)
local v4 = {}
local v_u_5 = require(v1.Utility.UI):get("Huds", "Hearts").Container
local v_u_6 = v_u_5.Position
local v_u_7 = v_u_6 + UDim2.fromScale(0, 0.5)
local v_u_8 = {}
function v4.open(p9)
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_6
	local v10 = {
		["Position"] = v_u_6,
		["Visible"] = true
	}
	v_u_3.target(v_u_5, 0.8, 5, v10)
	p9:popup()
end
function v4.close(_)
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_7
	local v11 = {
		["Position"] = v_u_7,
		["Visible"] = false
	}
	v_u_3.target(v_u_5, 0.8, 5, v11)
end
function v4.popup(_)
	-- upvalues: (copy) v_u_8, (copy) v_u_3
	for _, v12 in v_u_8 do
		v12.Icon.Position = UDim2.fromScale(0.5, 1.5)
		v_u_3.target(v12.Icon, 1, 1 - v12.LayoutOrder / 10, {
			["Position"] = UDim2.fromScale(0.5, 0.5)
		})
	end
end
function v4.updateHearts(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_8, (copy) v_u_5, (copy) v_u_3
	local v13 = v_u_2:getValue({ "IceBoss", "Hearts" }) or 3
	local v14 = v_u_2:getValue({ "IceBoss", "MaxHearts" }) or 3
	if #v_u_8 < v14 then
		for _, v15 in v_u_8 do
			v15:Destroy()
		end
		table.clear(v_u_8)
		for v16 = 1, v14 do
			local v17 = v_u_5.Template:Clone()
			v17.LayoutOrder = v16
			v17.Name = v16
			v17.Visible = true
			v17.Icon.ImageColor3 = Color3.new(1, 1, 1)
			v17.Parent = v_u_5
			v17.Icon.Position = UDim2.fromScale(0.5, 1.5)
			v_u_3.target(v17.Icon, 1, 3 - v16 / 50, {
				["Position"] = UDim2.fromScale(0.5, 0.5)
			})
			local v18 = v_u_8
			table.insert(v18, v17)
		end
	end
	for v19 = 1, v14 do
		local v20 = v19 <= v13
		local v21 = v_u_8[v19]
		if v21 then
			v21.Icon.ImageColor3 = v20 and Color3.new(1, 1, 1) or Color3.new()
			if not v20 then
				v21.Icon.Rotation = 15
				v_u_3.target(v21.Icon, 0.3, 5, {
					["Rotation"] = 0
				})
			end
		end
	end
end
function v4.init(p_u_22)
	-- upvalues: (copy) v_u_2
	v_u_2:onSet({ "IceBoss", "Hearts" }, function(_)
		-- upvalues: (copy) p_u_22
		p_u_22:updateHearts()
	end)
	v_u_2:onSet({ "IceBoss", "MaxHearts" }, function(_)
		-- upvalues: (copy) p_u_22
		p_u_22:updateHearts()
	end)
end
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Hearts]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3796"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Lighting")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = require(v2.Client.Currency.CurrencyController)
local v_u_5 = require(v2.Client.Data.DataController)
local v_u_6 = require(v2.Config.MultiplierData)
local v_u_7 = require(v2.Config.PetSlimeData)
local v_u_8 = require(v2.Config.RarityData)
local v_u_9 = require(v2.Config.SlimeRaceData)
local v_u_10 = require(v2.Enums.CurrencyTypes)
local v_u_11 = require(v2.Enums.MultiplierTypes)
local v_u_12 = require(v2.Enums.Products)
local v_u_13 = require(v2.Utility.Format)
local v14 = require(v2.Packages.Janitor)
local v_u_15 = require(v2.Utility.Marketplace)
local v16 = require(v2.Utility.Network)
local v_u_17 = require(v2.Utility.Notify)
local v_u_18 = require(v2.Utility.PlayerListUtil)
local v_u_19 = require(v2.Packages.Observers)
local v_u_20 = require(v2.Utility.Sound)
local v_u_21 = require(v2.Utility.Spring)
local v_u_22 = require(v2.Utility.UI)
local v23 = {}
local v_u_24 = v_u_22:get("Huds", "SlimeRace")
local v_u_25 = v_u_24.Container
local v_u_26 = v_u_25.Bottom
local v_u_27 = v_u_25.RaceChances
local v_u_28 = v_u_25.RaceStats.RaceStats
local v_u_29 = v_u_25.Top
local v_u_30 = v_u_25.Position
local v_u_31 = v_u_30 + UDim2.fromScale(0, 0.2)
local v_u_32 = v16.remoteFunction("GiftEvent")
local v_u_33 = v16.remoteFunction("SlimeRaceService/Roll")
local v_u_34 = v16.remoteEvent("SlimeRaceService/SelectSlot")
local v_u_35 = v16.remoteFunction("SlimeRaceService/UnlockSlot")
local v_u_36 = v16.remoteEvent("SlimeRaceService/RollResult")
local v_u_37 = false
local v_u_38 = false
local v_u_39 = v14.new()
local v_u_40 = nil
local v_u_41 = nil
local v_u_42 = workspace.CurrentCamera
local v_u_43 = CFrame.Angles(0, 3.141592653589793, 0)
local v_u_44 = CFrame.new(0, -0.5, -6)
local v_u_45 = CFrame.new(0, -2, -6.5)
local v_u_46 = CFrame.new(0, -0.2, -5.5)
local v_u_47 = v_u_44
local v_u_48 = 0
local v_u_49 = nil
local function v_u_55()
	-- upvalues: (copy) v_u_39, (ref) v_u_40, (ref) v_u_41, (copy) v_u_5, (copy) v_u_7, (copy) v_u_3, (copy) v_u_42, (ref) v_u_47, (ref) v_u_48, (copy) v_u_43, (copy) v_u_9
	v_u_39:Cleanup()
	v_u_40 = nil
	v_u_41 = nil
	local v50 = v_u_5:getValue({ "Candy", "Pet" })
	if v50 then
		local v51 = v_u_7.Pets[v50]
		if v51 and v51.Model then
			local v_u_52 = v_u_39:Add(v51.Model:Clone())
			for _, v53 in v_u_52:GetDescendants() do
				if v53:IsA("BasePart") then
					v53.CastShadow = false
				end
			end
			v_u_52:ScaleTo(0.6)
			v_u_52.Parent = workspace
			local v54 = v_u_39:Add(Instance.new("SurfaceLight"))
			v54.Brightness = 2
			v54.Range = 8
			v54.Color = Color3.new(1, 1, 1)
			v54.Face = Enum.NormalId.Front
			if v_u_52.PrimaryPart then
				v54.Parent = v_u_52.PrimaryPart
			end
			v_u_39:Add(v_u_3.RenderStepped:Connect(function()
				-- upvalues: (copy) v_u_52, (ref) v_u_42, (ref) v_u_47, (ref) v_u_48, (ref) v_u_43
				if v_u_52.Parent then
					v_u_52:PivotTo(v_u_42.CFrame * v_u_47 * CFrame.Angles(0, v_u_48, 0) * v_u_43)
				end
			end))
			v_u_9.captureOriginals(v_u_52)
			v_u_40 = v_u_52
			v_u_41 = v54
			return v_u_52, v54
		end
	end
end
function v23.open(p56)
	-- upvalues: (ref) v_u_37, (ref) v_u_38, (copy) v_u_22, (ref) v_u_49, (copy) v_u_21, (copy) v_u_24, (copy) v_u_25, (copy) v_u_30, (copy) v_u_27, (copy) v_u_26, (copy) v_u_29, (copy) v_u_28, (copy) v_u_55, (ref) v_u_40, (copy) v_u_5, (copy) v_u_9
	if not (v_u_37 or v_u_38) then
		v_u_37 = true
		v_u_22:hideAll()
		if v_u_49 then
			v_u_21.target(v_u_49, 1, 5, {
				["FarIntensity"] = 1,
				["FocusDistance"] = 0,
				["InFocusRadius"] = 3,
				["NearIntensity"] = 0
			})
		end
		v_u_24.Enabled = true
		local v57 = {
			["Position"] = v_u_30,
			["Visible"] = true
		}
		v_u_21.target(v_u_25, 0.8, 5, v57)
		v_u_21.target(v_u_27, 0.8, 5, {
			["Position"] = UDim2.fromScale(0.851, 0.5)
		})
		v_u_21.target(v_u_26, 0.8, 5, {
			["Position"] = UDim2.fromScale(0.514, 0.84)
		})
		v_u_21.target(v_u_29, 0.8, 5, {
			["Position"] = UDim2.fromScale(0.513, 0.11)
		})
		v_u_21.target(v_u_28.Parent, 0.8, 5, {
			["Position"] = UDim2.fromScale(0.048, 0.5)
		})
		v_u_55()
		local v58 = v_u_40 and (v_u_5:getValue({ "Candy", "RaceSlots" }) or {})[v_u_5:getValue({ "Candy", "RaceSelectedSlot" }) or "1"]
		if v58 then
			v_u_9.applyRaceTransform(v_u_40, v58)
		end
		p56:updateSlots()
		p56:updateRaceStats()
		p56:updateRollButton()
	end
end
function v23.close(_)
	-- upvalues: (ref) v_u_37, (ref) v_u_38, (copy) v_u_39, (ref) v_u_40, (ref) v_u_41, (ref) v_u_49, (copy) v_u_21, (copy) v_u_27, (copy) v_u_26, (copy) v_u_29, (copy) v_u_28, (copy) v_u_25, (copy) v_u_31, (copy) v_u_24, (copy) v_u_22
	if v_u_37 then
		if not v_u_38 then
			v_u_37 = false
			v_u_39:Cleanup()
			v_u_40 = nil
			v_u_41 = nil
			if v_u_49 then
				v_u_21.target(v_u_49, 1, 5, {
					["FarIntensity"] = 0,
					["FocusDistance"] = 0,
					["InFocusRadius"] = 200,
					["NearIntensity"] = 0
				})
			end
			v_u_21.target(v_u_27, 0.8, 5, {
				["Position"] = UDim2.fromScale(1.851, 0.5)
			})
			v_u_21.target(v_u_26, 0.8, 5, {
				["Position"] = UDim2.fromScale(0.514, 1.84)
			})
			v_u_21.target(v_u_29, 0.8, 5, {
				["Position"] = UDim2.fromScale(0.513, -0.11)
			})
			v_u_21.target(v_u_28.Parent, 0.8, 5, {
				["Position"] = UDim2.fromScale(-0.2, 0.5)
			})
			local v59 = {
				["Position"] = v_u_31,
				["Visible"] = false
			}
			v_u_21.target(v_u_25, 0.8, 5, v59)
			task.delay(0.3, function()
				-- upvalues: (ref) v_u_37, (ref) v_u_24, (ref) v_u_22
				if not v_u_37 then
					v_u_24.Enabled = false
					v_u_22:showAll()
				end
			end)
		end
	else
		return
	end
end
function v23.toggle(p60)
	-- upvalues: (ref) v_u_37
	if v_u_37 then
		p60:close()
	else
		p60:open()
	end
end
function v23.updateSlots(_)
	-- upvalues: (copy) v_u_5, (copy) v_u_28, (copy) v_u_9
	local v61 = v_u_5:getValue({ "Candy", "RaceSlots" }) or {}
	local v62 = v_u_5:getValue({ "Candy", "RaceSelectedSlot" }) or "1"
	local v63 = v_u_5:getValue({ "Candy", "RaceUnlockedSlots" }) or {
		["1"] = true
	}
	for v64 = 1, 3 do
		local v65 = tostring(v64)
		local v66 = v_u_28.Race_Slots.Container[v65]
		if v66 then
			local v67 = v61[v65]
			local v68 = v63[v65] == true
			local v69 = v62 == v65
			if v67 and v_u_9.Races[v67] then
				v66.Title.Text = v_u_9.Races[v67].Name
			else
				v66.Title.Text = "Empty"
			end
			v66.State.Visible = v69
			v66.Overlay.Visible = not v68
			if not v68 then
				local v70 = v_u_9.Slots[v64]
				if v70 then
					v66.Overlay.Level.Text = ("Lv. %*"):format(v70.RequiredLevel)
				end
			end
		end
	end
end
function v23.updateRaceStats(_)
	-- upvalues: (copy) v_u_28, (copy) v_u_5, (copy) v_u_29, (copy) v_u_9, (copy) v_u_8, (copy) v_u_11, (copy) v_u_6, (copy) v_u_13
	for _, v71 in v_u_28:GetChildren() do
		if v71.Name == "StatClone" then
			v71:Destroy()
		end
	end
	local v72 = (v_u_5:getValue({ "Candy", "RaceSlots" }) or {})[v_u_5:getValue({ "Candy", "RaceSelectedSlot" }) or "1"]
	v_u_28.Passive_Template.Visible = false
	if v72 then
		local v73 = v_u_9.Races[v72]
		if v73 then
			local v74 = v_u_8[v73.Rarity]
			v_u_29.Race.Text = v73.Name
			v_u_29.Race.TextColor3 = v74 and v74.Color or Color3.fromRGB(255, 255, 255)
			local v75 = {
				{
					["type"] = v_u_11.PetAttackSpeed,
					["name"] = "Attack Speed"
				},
				{
					["type"] = v_u_11.PetDamagePercent,
					["name"] = "Damage %"
				},
				{
					["type"] = v_u_11.PetAgility,
					["name"] = "Agility"
				},
				{
					["type"] = v_u_11.PetCoinMultiplier,
					["name"] = "Coin Bonus"
				},
				{
					["type"] = v_u_11.PetRange,
					["name"] = "Range"
				},
				{
					["type"] = v_u_11.PetCritChance,
					["name"] = "Crit Chance"
				}
			}
			local v76 = v_u_28.StatTemplate
			local v77 = 0
			for _, v78 in v75 do
				local v79 = v73.StatBoosts[v78.type]
				if v79 and (v78.type ~= v_u_11.PetCoinMultiplier or v79 ~= 1) and v79 ~= 0 then
					v77 = v77 + 1
					local v80 = v76:Clone()
					v80.Name = "StatClone"
					v80.Visible = true
					v80.LayoutOrder = v77
					v80.Title.Text = v78.name
					local v81 = v_u_6[v78.type]
					if v81 and v81.Format then
						v80.Value.Text = ("+%*"):format((v81.Format(v79)))
					else
						v80.Value.Text = ("+%*"):format((v_u_13.decimal(v79, 2)))
					end
					v80.Parent = v_u_28
				end
			end
			if v73.Passive then
				v_u_28.Passive_Template.Visible = true
				v_u_28.Passive_Template.Title.Text = v73.Passive.Name
				v_u_28.Passive_Template.Desc.Text = v73.Passive.Description
			end
		end
	else
		v_u_29.Race.Text = "No Race"
		v_u_29.Race.TextColor3 = Color3.fromRGB(200, 200, 200)
		return
	end
end
function v23.updateRollButton(_) end
function v23.playRollAnimation(p_u_82, p_u_83, p_u_84, _)
	-- upvalues: (ref) v_u_38, (copy) v_u_21, (copy) v_u_27, (copy) v_u_28, (copy) v_u_26, (ref) v_u_47, (copy) v_u_45, (ref) v_u_48, (ref) v_u_40, (copy) v_u_9, (copy) v_u_42, (ref) v_u_41, (copy) v_u_3, (copy) v_u_44, (copy) v_u_46, (copy) v_u_8, (copy) v_u_29, (copy) v_u_20
	v_u_38 = true
	v_u_21.target(v_u_27, 0.5, 5, {
		["Position"] = UDim2.fromScale(1.851, 0.5)
	})
	v_u_21.target(v_u_28.Parent, 0.5, 5, {
		["Position"] = UDim2.fromScale(-0.5, 0.5)
	})
	v_u_21.target(v_u_26, 0.5, 5, {
		["Position"] = UDim2.fromScale(0.514, 1.84)
	})
	v_u_47 = v_u_45
	v_u_48 = 0
	if v_u_40 then
		v_u_40:ScaleTo(0.35)
		v_u_9.resetTransform(v_u_40)
	end
	v_u_21.target(v_u_42, 3, 1, {
		["FieldOfView"] = 58
	})
	if v_u_41 then
		v_u_21.target(v_u_41, 0.5, 3, {
			["Brightness"] = 5,
			["Range"] = 12
		})
	end
	local v_u_85 = 0
	local v_u_86 = "cycling"
	local v_u_87 = 0
	local v_u_88 = #p_u_83
	local v_u_89 = nil
	local v_u_90 = nil
	v_u_90 = v_u_3.RenderStepped:Connect(function(p91)
		-- upvalues: (ref) v_u_86, (ref) v_u_87, (ref) v_u_90, (ref) v_u_21, (ref) v_u_42, (ref) v_u_47, (ref) v_u_44, (ref) v_u_48, (ref) v_u_40, (ref) v_u_41, (ref) v_u_27, (ref) v_u_28, (ref) v_u_26, (ref) v_u_38, (copy) p_u_82, (ref) v_u_46, (ref) v_u_8, (ref) v_u_9, (copy) p_u_84, (ref) v_u_85, (ref) v_u_45, (copy) v_u_88, (copy) p_u_83, (ref) v_u_29, (ref) v_u_89, (ref) v_u_20
		if v_u_86 == "done" then
			return
		elseif v_u_86 == "linger" then
			v_u_87 = v_u_87 + p91
			if v_u_87 >= 1.5 then
				v_u_86 = "done"
				v_u_90:Disconnect()
				v_u_21.target(v_u_42, 0.8, 5, {
					["FieldOfView"] = 70
				})
				v_u_47 = v_u_44
				v_u_48 = 0
				if v_u_40 then
					v_u_40:ScaleTo(0.6)
				end
				if v_u_41 then
					v_u_41.Color = Color3.new(1, 1, 1)
				end
				if v_u_41 then
					v_u_21.target(v_u_41, 0.8, 5, {
						["Brightness"] = 2,
						["Range"] = 8
					})
				end
				v_u_21.target(v_u_27, 0.8, 5, {
					["Position"] = UDim2.fromScale(0.851, 0.5)
				})
				v_u_21.target(v_u_28.Parent, 0.8, 5, {
					["Position"] = UDim2.fromScale(0.048, 0.5)
				})
				v_u_21.target(v_u_26, 0.8, 5, {
					["Position"] = UDim2.fromScale(0.514, 0.84)
				})
				v_u_38 = false
				p_u_82:updateSlots()
				p_u_82:updateRaceStats()
				p_u_82:updateRollButton()
			end
			return
		elseif v_u_86 == "reveal" then
			v_u_87 = v_u_87 + p91
			local v92 = v_u_87 / 0.7
			local v93 = math.clamp(v92, 0, 1)
			v_u_48 = (1 - (1 - v93) ^ 3) * 3.141592653589793 * 4
			v_u_47 = CFrame.new(v_u_46.Position)
			if v_u_40 then
				local v94
				if v93 < 0.25 then
					v94 = v93 / 0.25 * 0.45 + 0.85
				else
					v94 = (1 - (v93 - 0.25) / 0.75) * 0.45 + 0.85
				end
				v_u_40:ScaleTo(v94)
			end
			if v_u_87 < 0.15 and v_u_41 then
				v_u_41.Brightness = 10
				v_u_41.Color = v_u_8[v_u_9.Races[p_u_84].Rarity] and v_u_8[v_u_9.Races[p_u_84].Rarity].Color or Color3.new(1, 1, 1)
			elseif v_u_41 then
				v_u_21.target(v_u_41, 0.6, 4, {
					["Brightness"] = 4,
					["Color"] = Color3.new(1, 1, 1)
				})
			end
			if v_u_87 <= p91 and v_u_40 then
				v_u_9.applyRaceTransform(v_u_40, p_u_84)
			end
			if v_u_87 >= 0.7 then
				v_u_86 = "linger"
				v_u_87 = 0
				v_u_48 = 0
			end
		else
			v_u_85 = v_u_85 + p91
			local v95 = v_u_85 / 3.5
			local v96 = math.clamp(v95, 0, 1)
			local v97 = 1 - (1 - v96) ^ 3
			if v_u_40 then
				v_u_40:ScaleTo(v97 * 0.5 + 0.35)
			end
			local v98 = v_u_45.Position:Lerp(v_u_46.Position, v97)
			v_u_47 = CFrame.new(v98)
			local v99 = v_u_85 * 8
			v_u_48 = math.sin(v99) * 0.15 * (1 - v96)
			local v100 = v97 * (v_u_88 - 1)
			local v101 = math.floor(v100) + 1
			local v102 = v_u_88
			local v103 = p_u_83[math.clamp(v101, 1, v102)]
			local v104 = v_u_9.Races[v103]
			if v104 then
				v_u_29.Race.Text = v104.Name
				local v105 = v_u_8[v104.Rarity]
				if v105 then
					v_u_29.Race.TextColor3 = v105.Color
				end
				if v103 ~= v_u_89 and v_u_40 then
					v_u_89 = v103
					v_u_9.applyRaceTransform(v_u_40, v103)
					v_u_20.play("Reveal_Cycle", {
						["PlaybackSpeed"] = v96 * 0.6 + 0.8
					})
				end
			end
			if v96 >= 1 then
				v_u_20.play("RuneBuy")
				local v106 = v_u_9.Races[p_u_84]
				if v106 then
					v_u_29.Race.Text = v106.Name
					local v107 = v_u_8[v106.Rarity]
					if v107 then
						v_u_29.Race.TextColor3 = v107.Color
					end
				end
				v_u_86 = "reveal"
				v_u_87 = 0
			end
		end
	end)
end
function v23.setupRaceChances(_)
	-- upvalues: (copy) v_u_27, (copy) v_u_9, (copy) v_u_13, (copy) v_u_8
	local v108 = v_u_27.Template
	v108.Visible = false
	for v109, v110 in v_u_9.OrderedRaces do
		local v111 = v_u_9.Races[v110]
		if v111 then
			local v112 = v108:Clone()
			v112.Visible = true
			v112.LayoutOrder = v109
			v112.Title.Text = v111.Name
			v112.Value.Text = ("%*%%"):format((v_u_13.decimal(v111.Weight / v_u_9.TotalWeight * 100, 2)))
			local v113 = v_u_8[v111.Rarity]
			if v113 then
				v112.Title.TextColor3 = v113.Color
			end
			v112.Parent = v_u_27
		end
	end
end
function v23.setupSlotInteractions(_)
	-- upvalues: (copy) v_u_28, (ref) v_u_38, (copy) v_u_5, (copy) v_u_34, (copy) v_u_9, (copy) v_u_35, (copy) v_u_15
	for v_u_114 = 1, 3 do
		local v_u_115 = tostring(v_u_114)
		local v_u_116 = v_u_28.Race_Slots.Container[v_u_115]
		if v_u_116 then
			v_u_116.Activated:Connect(function()
				-- upvalues: (ref) v_u_38, (ref) v_u_5, (copy) v_u_115, (ref) v_u_34, (ref) v_u_9, (copy) v_u_114, (ref) v_u_35, (ref) v_u_15
				if v_u_38 then
					return
				elseif (v_u_5:getValue({ "Candy", "RaceUnlockedSlots" }) or {
					["1"] = true
				})[v_u_115] then
					v_u_34.fire(v_u_115)
				else
					local v117 = v_u_9.Slots[v_u_114]
					if v117 then
						if (v_u_5:getValue({ "Candy", "PetLevel" }) or 0) >= v117.RequiredLevel then
							v_u_35.invoke(v_u_115)
							return
						end
						if v117.ProductId then
							v_u_15.PromptProduct(v117.ProductId)
						end
					end
				end
			end)
			local v118 = v_u_9.Slots[v_u_114]
			if v118 and v118.ProductId then
				v_u_15.ObserveProduct(v118.ProductId, function(p119)
					-- upvalues: (copy) v_u_116
					if p119 and p119.PriceInRobux then
						v_u_116.Overlay.Price.Text = ("R$ %*"):format(p119.PriceInRobux)
					end
				end)
			end
		end
	end
end
function v23.setupButtons(_)
	-- upvalues: (copy) v_u_26, (ref) v_u_38, (copy) v_u_33
	v_u_26.Buy.Activated:Connect(function()
		-- upvalues: (ref) v_u_38, (ref) v_u_33
		if not v_u_38 then
			local v120, v121 = v_u_33.invoke()
			if not v120 then
				warn("[SlimeRace] " .. (v121 or "Failed to roll!"))
			end
		end
	end)
end
function v23.setupRerolls(_)
	-- upvalues: (copy) v_u_25, (copy) v_u_26, (ref) v_u_38, (copy) v_u_12, (copy) v_u_15, (copy) v_u_13, (copy) v_u_18, (copy) v_u_32, (copy) v_u_17
	local v_u_122 = v_u_25.Rerolls
	local v123 = v_u_122.Container
	v_u_122.Visible = false
	v_u_26.Unlock.Activated:Connect(function()
		-- upvalues: (ref) v_u_38, (copy) v_u_122
		if not v_u_38 then
			v_u_122.Visible = not v_u_122.Visible
		end
	end)
	v_u_122.Top.Close.Activated:Connect(function()
		-- upvalues: (copy) v_u_122
		v_u_122.Visible = false
	end)
	local function v132(p_u_124)
		-- upvalues: (ref) v_u_12, (ref) v_u_15, (ref) v_u_13, (ref) v_u_18, (ref) v_u_32, (ref) v_u_17
		local v125 = p_u_124.Name
		local v126 = tonumber(v125)
		local v_u_127 = v_u_12.RaceRerolls[v126]
		v_u_15.ObserveProduct(v_u_127, function(p128)
			-- upvalues: (copy) p_u_124, (ref) v_u_13
			p_u_124.Buttons.Robux.Price.Text = ("%*"):format((v_u_13.robux(v_u_13.comma(p128.PriceInRobux))))
		end)
		p_u_124.Buttons.Robux.Activated:Connect(function()
			-- upvalues: (ref) v_u_15, (copy) v_u_127
			v_u_15.PromptProduct(v_u_127)
		end)
		p_u_124.Buttons.Gift.Activated:Connect(function()
			-- upvalues: (ref) v_u_18, (ref) v_u_32, (copy) v_u_127, (ref) v_u_17
			v_u_18.open(function(p129)
				-- upvalues: (ref) v_u_32, (ref) v_u_127, (ref) v_u_17
				local v130, v131 = v_u_32.invoke(p129, v_u_127)
				if v130 then
					return true
				end
				v_u_17.Notify({
					["Message"] = v131,
					["Type"] = v_u_17.Types.Error
				})
				return false, v131
			end)
		end)
	end
	for _, v133 in v123.Top:GetChildren() do
		if v133:IsA("Frame") then
			v132(v133)
		end
	end
	for _, v134 in v123.Bottom:GetChildren() do
		if v134:IsA("Frame") then
			v132(v134)
		end
	end
end
function v23.init(p_u_135)
	-- upvalues: (ref) v_u_49, (copy) v_u_1, (copy) v_u_4, (copy) v_u_10, (copy) v_u_26, (copy) v_u_36, (copy) v_u_19, (ref) v_u_38, (copy) v_u_5, (ref) v_u_37, (copy) v_u_25, (copy) v_u_24
	p_u_135:setupRerolls()
	v_u_49 = Instance.new("DepthOfFieldEffect")
	v_u_49.FarIntensity = 0
	v_u_49.FocusDistance = 0
	v_u_49.InFocusRadius = 200
	v_u_49.NearIntensity = 0
	v_u_49.Parent = v_u_1
	p_u_135:setupRaceChances()
	p_u_135:setupSlotInteractions()
	p_u_135:setupButtons()
	v_u_4:observe(v_u_10.RaceRerolls, function(p136)
		-- upvalues: (ref) v_u_26
		v_u_26.Buy.Price.Text = ("Roll (%* Reroll%*)"):format(p136, p136 > 1 and "s" or "")
	end)
	v_u_36.listen(function(p137)
		-- upvalues: (copy) p_u_135
		if p137 and (p137.sequence and (p137.winner and p137.winnerIndex)) then
			p_u_135:playRollAnimation(p137.sequence, p137.winner, p137.winnerIndex)
		end
	end)
	v_u_19.observeTag("RollingRace", function(p138)
		-- upvalues: (copy) p_u_135, (ref) v_u_38
		local v139 = Instance.new("ProximityPrompt")
		v139.UIOffset = Vector2.new(0, 999999)
		v139.RequiresLineOfSight = false
		v139.Parent = p138
		v139.MaxActivationDistance = p138:GetAttribute("Range") or 10
		v139.PromptShown:Connect(function()
			-- upvalues: (ref) p_u_135
			p_u_135:open()
		end)
		v139.PromptHidden:Connect(function()
			-- upvalues: (ref) v_u_38, (ref) p_u_135
			if not v_u_38 then
				p_u_135:close()
			end
		end)
	end)
	v_u_5:onSet({ "Candy", "RaceSelectedSlot" }, function()
		-- upvalues: (ref) v_u_37, (copy) p_u_135
		if v_u_37 then
			p_u_135:updateSlots()
			p_u_135:updateRaceStats()
			p_u_135:updateRollButton()
		end
	end)
	v_u_5:onChange(function(_, p140)
		-- upvalues: (ref) v_u_37, (copy) p_u_135
		if p140[1] == "Candy" and (p140[2] == "RaceSlots" or p140[2] == "RaceUnlockedSlots") and v_u_37 then
			p_u_135:updateSlots()
			p_u_135:updateRaceStats()
			p_u_135:updateRollButton()
		end
	end)
	v_u_25.Visible = false
	v_u_24.Enabled = false
end
return v23]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeRace]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3797"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Currency.CurrencyController)
local v_u_3 = require(v1.Client.Data.DataController)
local v_u_4 = require(v1.Client.Gameplay.Candy.PetRollController)
local v_u_5 = require(v1.Config.PetSlimeData)
local v_u_6 = require(v1.Config.RarityData)
local v_u_7 = require(v1.Enums.CurrencyTypes)
local v_u_8 = require(v1.Utility.ConfirmationUtil)
local v9 = require(v1.Utility.Network)
local v_u_10 = require(v1.Utility.UI)
local v_u_11 = require(v1.Client.UI.UIController.Gui.RollAPet)
local v12 = {}
local v_u_13 = v_u_10:get("Persistent", "PetRollHUD")
local v_u_14 = v_u_13.Container
local v_u_15 = v_u_14.Keep
local v_u_16 = v_u_14.Replace
local v_u_17 = v_u_14.Roll
local v_u_18 = v_u_14.Skip
local v_u_19 = v_u_14.DisableAuto
local v_u_20 = {
	["KeepPet"] = v9.remoteFunction("PetRollService/KeepPet"),
	["ReplacePet"] = v9.remoteFunction("PetRollService/ReplacePet"),
	["RequestRoll"] = v9.remoteFunction("PetRollService/RequestRoll")
}
local v_u_21 = nil
local v_u_22 = false
local function v_u_25(_)
	-- upvalues: (copy) v_u_11, (copy) v_u_2, (copy) v_u_7, (copy) v_u_5, (ref) v_u_22, (copy) v_u_15, (copy) v_u_16, (copy) v_u_17, (copy) v_u_18, (copy) v_u_19, (copy) v_u_13, (copy) v_u_14, (copy) v_u_4, (copy) v_u_20, (ref) v_u_21
	if v_u_11.isAutoActive() then
		if v_u_2:get(v_u_7.Shards) < v_u_5.RollCost then
			v_u_11.stopAuto()
			v_u_22 = false
			v_u_15.Visible = true
			v_u_16.Visible = true
			v_u_17.Visible = v_u_2:get(v_u_7.Shards) >= v_u_5.RollCost
			v_u_18.Visible = false
			v_u_19.Visible = false
			v_u_13.Enabled = true
			v_u_14.Visible = true
			return
		else
			v_u_22 = true
			v_u_14.Visible = false
			v_u_13.Enabled = false
			if v_u_4._pendingCleanup then
				local v23, v24 = pcall(v_u_4._pendingCleanup)
				if not v23 then
					warn("[PetRollHUD] Cleanup error: " .. tostring(v24))
					v_u_4._pendingCleanup = nil
				end
			end
			if not v_u_20.RequestRoll.invoke() then
				v_u_11.stopAuto()
				v_u_22 = false
				if v_u_21 then
					v_u_15.Visible = true
					v_u_16.Visible = true
					v_u_17.Visible = v_u_2:get(v_u_7.Shards) >= v_u_5.RollCost
					v_u_18.Visible = false
					v_u_19.Visible = false
					v_u_13.Enabled = true
					v_u_14.Visible = true
				end
			end
		end
	else
		return
	end
end
function v12.open(p_u_26, p27)
	-- upvalues: (ref) v_u_21, (ref) v_u_22, (copy) v_u_3, (copy) v_u_20, (copy) v_u_11, (copy) v_u_15, (copy) v_u_16, (copy) v_u_2, (copy) v_u_7, (copy) v_u_17, (copy) v_u_5, (copy) v_u_18, (copy) v_u_19, (copy) v_u_13, (copy) v_u_14, (copy) v_u_25
	v_u_21 = p27
	v_u_22 = false
	if v_u_3:getValue({ "Candy", "Pet" }) then
		if v_u_11.isAutoActive() then
			if v_u_11.getAutoTargets()[p27] then
				v_u_11.stopAuto()
				v_u_15.Visible = true
				v_u_16.Visible = true
				v_u_17.Visible = v_u_2:get(v_u_7.Shards) >= v_u_5.RollCost
				v_u_18.Visible = false
				v_u_19.Visible = false
				v_u_19.Visible = false
				v_u_13.Enabled = true
				v_u_14.Visible = true
			else
				v_u_15.Visible = false
				v_u_16.Visible = false
				v_u_17.Visible = false
				v_u_18.Visible = false
				v_u_19.Visible = false
				v_u_19.Visible = true
				v_u_13.Enabled = true
				v_u_14.Visible = true
				task.defer(function()
					-- upvalues: (ref) v_u_25, (copy) p_u_26
					v_u_25(p_u_26)
				end)
			end
		else
			v_u_15.Visible = true
			v_u_16.Visible = true
			v_u_17.Visible = v_u_2:get(v_u_7.Shards) >= v_u_5.RollCost
			v_u_18.Visible = false
			v_u_19.Visible = false
			v_u_19.Visible = false
			v_u_13.Enabled = true
			v_u_14.Visible = true
			return
		end
	else
		v_u_20.ReplacePet.invoke()
		v_u_11.stopAuto()
		p_u_26:close()
		return
	end
end
function v12.close(_)
	-- upvalues: (ref) v_u_21, (ref) v_u_22, (copy) v_u_11, (copy) v_u_14, (copy) v_u_13, (copy) v_u_4, (copy) v_u_10
	v_u_21 = nil
	v_u_22 = false
	v_u_11.stopAuto()
	v_u_14.Visible = false
	v_u_13.Enabled = false
	if v_u_4._pendingCleanup then
		local v28, v29 = pcall(v_u_4._pendingCleanup)
		if not v28 then
			warn("[PetRollHUD] Cleanup error: " .. tostring(v29))
			v_u_4._pendingCleanup = nil
		end
	end
	v_u_10:showAll()
end
function v12.init(p_u_30)
	-- upvalues: (copy) v_u_14, (copy) v_u_13, (copy) v_u_18, (copy) v_u_4, (copy) v_u_19, (copy) v_u_11, (ref) v_u_22, (ref) v_u_21, (copy) v_u_15, (copy) v_u_16, (copy) v_u_2, (copy) v_u_7, (copy) v_u_17, (copy) v_u_5, (copy) v_u_20, (copy) v_u_8, (copy) v_u_10, (copy) v_u_3, (copy) v_u_6
	v_u_14.Visible = false
	v_u_13.Enabled = false
	v_u_18.Visible = false
	v_u_18.Activated:Connect(function()
		-- upvalues: (ref) v_u_4
		v_u_4:skipAnimation()
	end)
	v_u_19.Visible = false
	v_u_19.Activated:Connect(function()
		-- upvalues: (ref) v_u_11, (ref) v_u_22, (ref) v_u_19, (ref) v_u_21, (ref) v_u_15, (ref) v_u_16, (ref) v_u_2, (ref) v_u_7, (ref) v_u_17, (ref) v_u_5, (ref) v_u_18
		v_u_11.stopAuto()
		v_u_22 = false
		v_u_19.Visible = false
		if v_u_21 then
			v_u_15.Visible = true
			v_u_16.Visible = true
			v_u_17.Visible = v_u_2:get(v_u_7.Shards) >= v_u_5.RollCost
			v_u_18.Visible = false
			v_u_19.Visible = false
		end
	end)
	v_u_15.Activated:Connect(function()
		-- upvalues: (ref) v_u_22, (ref) v_u_21, (ref) v_u_20, (copy) p_u_30
		if not v_u_22 and v_u_21 then
			v_u_22 = true
			v_u_20.KeepPet.invoke()
			p_u_30:close()
		end
	end)
	v_u_16.Activated:Connect(function()
		-- upvalues: (ref) v_u_22, (ref) v_u_21, (ref) v_u_8, (ref) v_u_20, (copy) p_u_30
		if not v_u_22 and v_u_21 then
			local v31 = {
				["Title"] = "Are you sure you want to replace your current pet?",
				["YesCallback"] = function()
					-- upvalues: (ref) v_u_22, (ref) v_u_20, (ref) p_u_30
					if not v_u_22 then
						v_u_22 = true
						v_u_20.ReplacePet.invoke()
						p_u_30:close()
					end
				end
			}
			v_u_8.prompt(v31)
		end
	end)
	v_u_17.Activated:Connect(function()
		-- upvalues: (ref) v_u_22, (ref) v_u_21, (ref) v_u_14, (ref) v_u_13, (ref) v_u_4, (ref) v_u_20, (ref) v_u_15, (ref) v_u_16, (ref) v_u_2, (ref) v_u_7, (ref) v_u_17, (ref) v_u_5, (ref) v_u_18, (ref) v_u_19, (ref) v_u_10, (ref) v_u_3, (ref) v_u_6, (ref) v_u_8
		if v_u_22 or not v_u_21 then
			return
		else
			local v32 = v_u_3:getValue({ "Candy", "Pet" })
			local v33 = v_u_21
			local v34
			if v33 then
				local v35 = v_u_5.Pets[v33]
				if v35 then
					local v36 = v_u_6[v35.Rarity]
					v34 = not v36 and 0 or v36.Order
				else
					v34 = 0
				end
			else
				v34 = 0
			end
			local v37
			if v32 then
				local v38 = v_u_5.Pets[v32]
				if v38 then
					local v39 = v_u_6[v38.Rarity]
					v37 = not v39 and 0 or v39.Order
				else
					v37 = 0
				end
			else
				v37 = 0
			end
			if v37 < v34 then
				local v43 = {
					["Title"] = "This pet is better than your current one. Are you sure you don\'t want to replace it?",
					["YesCallback"] = function()
						-- upvalues: (ref) v_u_22, (ref) v_u_21, (ref) v_u_14, (ref) v_u_13, (ref) v_u_4, (ref) v_u_20, (ref) v_u_15, (ref) v_u_16, (ref) v_u_2, (ref) v_u_7, (ref) v_u_17, (ref) v_u_5, (ref) v_u_18, (ref) v_u_19, (ref) v_u_10
						if not v_u_22 then
							v_u_22 = true
							local v40 = v_u_21
							v_u_14.Visible = false
							v_u_13.Enabled = false
							if v_u_4._pendingCleanup then
								local v41, v42 = pcall(v_u_4._pendingCleanup)
								if not v41 then
									warn("[PetRollHUD] Cleanup error: " .. tostring(v42))
									v_u_4._pendingCleanup = nil
								end
							end
							if not v_u_20.RequestRoll.invoke() then
								v_u_21 = v40
								v_u_22 = false
								v_u_15.Visible = true
								v_u_16.Visible = true
								v_u_17.Visible = v_u_2:get(v_u_7.Shards) >= v_u_5.RollCost
								v_u_18.Visible = false
								v_u_19.Visible = false
								v_u_13.Enabled = true
								v_u_14.Visible = true
								v_u_10:showAll()
							end
						end
					end
				}
				v_u_8.prompt(v43)
			else
				v_u_22 = true
				local v44 = v_u_21
				v_u_14.Visible = false
				v_u_13.Enabled = false
				if v_u_4._pendingCleanup then
					local v45, v46 = pcall(v_u_4._pendingCleanup)
					if not v45 then
						warn("[PetRollHUD] Cleanup error: " .. tostring(v46))
						v_u_4._pendingCleanup = nil
					end
				end
				if not v_u_20.RequestRoll.invoke() then
					v_u_21 = v44
					v_u_22 = false
					v_u_15.Visible = true
					v_u_16.Visible = true
					v_u_17.Visible = v_u_2:get(v_u_7.Shards) >= v_u_5.RollCost
					v_u_18.Visible = false
					v_u_19.Visible = false
					v_u_13.Enabled = true
					v_u_14.Visible = true
					v_u_10:showAll()
				end
			end
		end
	end)
	v_u_2:observe(v_u_7.Shards, function()
		-- upvalues: (ref) v_u_21, (ref) v_u_2, (ref) v_u_7, (ref) v_u_17, (ref) v_u_5
		if v_u_21 then
			v_u_17.Visible = v_u_2:get(v_u_7.Shards) >= v_u_5.RollCost
		end
	end)
	v_u_4.AnimationStarted:Connect(function()
		-- upvalues: (ref) v_u_11, (ref) v_u_4, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) v_u_19, (ref) v_u_13, (ref) v_u_14
		if v_u_11.isAutoActive() then
			v_u_4:skipAnimation()
			v_u_15.Visible = false
			v_u_16.Visible = false
			v_u_17.Visible = false
			v_u_18.Visible = false
			v_u_19.Visible = false
			v_u_19.Visible = true
		else
			v_u_15.Visible = false
			v_u_16.Visible = false
			v_u_17.Visible = false
			v_u_18.Visible = true
			v_u_19.Visible = false
			v_u_19.Visible = false
		end
		v_u_13.Enabled = true
		v_u_14.Visible = true
	end)
	v_u_4.AnimationFinished:Connect(function(p47)
		-- upvalues: (copy) p_u_30
		p_u_30:open(p47)
	end)
end
return v12]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PetRollHUD]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="ModuleScript" referent="3798"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.Observers)
return {
	["init"] = function(_)
		-- upvalues: (copy) v_u_2
		for _, v3 in script:GetChildren() do
			if v3:IsA("ModuleScript") then
				v_u_2.observeTag(v3.Name, require(v3))
			end
		end
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UITagController]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3799"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Utility.Device)
local v_u_3 = {}
v_u_2:observe(function()
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	for v4 in v_u_3 do
		if v_u_2:get() == Enum.PreferredInput.Touch then
			v4.Scale = v4:GetAttribute("Max") or 1.5
		else
			v4.Scale = v4:GetAttribute("Min") or 1
		end
	end
end)
for v5 in v_u_3 do
	if v_u_2:get() == Enum.PreferredInput.Touch then
		v5.Scale = v5:GetAttribute("Max") or 1.5
	else
		v5.Scale = v5:GetAttribute("Min") or 1
	end
end
return function(p_u_6)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	v_u_3[p_u_6] = true
	if v_u_2:get() == Enum.PreferredInput.Touch then
		p_u_6.Scale = p_u_6:GetAttribute("Max") or 1.5
	else
		p_u_6.Scale = p_u_6:GetAttribute("Min") or 1
	end
	return function()
		-- upvalues: (ref) v_u_3, (copy) p_u_6
		v_u_3[p_u_6] = nil
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AutoScale]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3800"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Utility.Sound)
local v_u_3 = require(v1.Utility.Spring)
return function(p4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v_u_5 = p4:FindFirstChild("UIScale")
	if not v_u_5 then
		v_u_5 = Instance.new("UIScale")
		v_u_5.Parent = p4
	end
	local v_u_6 = v_u_5.Scale
	local v_u_7 = {}
	local v8 = p4.MouseEnter
	local function v9()
		-- upvalues: (ref) v_u_3, (ref) v_u_5, (copy) v_u_6
		v_u_3.target(v_u_5, 0.5, 3, {
			["Scale"] = v_u_6 * 1.03
		})
	end
	table.insert(v_u_7, v8:Connect(v9))
	local v10 = p4.MouseLeave
	local function v12()
		-- upvalues: (ref) v_u_3, (ref) v_u_5, (copy) v_u_6
		local v11 = {
			["Scale"] = v_u_6
		}
		v_u_3.target(v_u_5, 1, 5, v11)
	end
	table.insert(v_u_7, v10:Connect(v12))
	local v13 = p4.MouseButton1Down
	local function v14()
		-- upvalues: (ref) v_u_3, (ref) v_u_5, (copy) v_u_6
		v_u_3.target(v_u_5, 0.5, 7.5, {
			["Scale"] = v_u_6 * 0.98
		})
	end
	table.insert(v_u_7, v13:Connect(v14))
	local v15 = p4.MouseButton1Up
	local function v17()
		-- upvalues: (ref) v_u_3, (ref) v_u_5, (copy) v_u_6
		local v16 = {
			["Scale"] = v_u_6
		}
		v_u_3.target(v_u_5, 0.5, 7.5, v16)
	end
	table.insert(v_u_7, v15:Connect(v17))
	local v18 = p4.Activated
	local function v19()
		-- upvalues: (ref) v_u_2
		v_u_2.play("MenuClick")
	end
	table.insert(v_u_7, v18:Connect(v19))
	return function()
		-- upvalues: (copy) v_u_7
		for _, v20 in v_u_7 do
			v20:Disconnect()
		end
		table.clear(v_u_7)
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Button]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3801"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Utility.UI)
return function(p3)
	-- upvalues: (copy) v_u_2
	local v_u_4 = p3:FindFirstAncestorOfClass("ScreenGui")
	if v_u_4 then
		p3.Activated:Connect(function()
			-- upvalues: (ref) v_u_2, (copy) v_u_4
			if v_u_2.Current == v_u_4.Name then
				v_u_2:close(v_u_2.Current)
			end
		end)
		return function() end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CloseButton]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3802"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.CurrencyData)
local v_u_3 = require(v1.Utility.Format)
return function(p4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v5 = p4:GetAttribute("CurrencyType")
	local v6 = p4:GetAttribute("Cost")
	local v7 = v5 ~= nil
	local v8 = ("%* doesn\'t have \'CurrencyType\' Attribute!"):format((p4:GetFullName()))
	assert(v7, v8)
	local v9 = v6 ~= nil
	local v10 = ("%* doesn\'t have \'Cost\' Attribute!"):format((p4:GetFullName()))
	assert(v9, v10)
	p4.Amount.Text = v_u_3.abbreviateComma(v6)
	p4.Icon.Image = v_u_2[v5].Icon
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CurrencyBillboard]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3803"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.Colors)
local v_u_3 = require(v1.Client.Currency.CurrencyController)
local v_u_4 = require(v1.Enums.CurrencyTypes)
local v_u_5 = require(v1.Packages.Observers)
local v_u_6 = {}
local function v_u_11(p7)
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_2
	local v8 = p7:GetAttribute("Currency")
	local v9 = p7:GetAttribute("Cost")
	local v10 = p7:GetAttribute("Locked")
	if v9 and (v_u_3:get(v8 or v_u_4.Clouds) >= v9 and not v10) then
		p7.UIGradient.Color = v_u_2.Green.Gradient
		p7.UIStroke.Color = v_u_2.Green.Stroke
	else
		p7.UIGradient.Color = v_u_2.Grey.Gradient
		p7.UIStroke.Color = v_u_2.Grey.Stroke
	end
end
return function(p_u_12)
	-- upvalues: (copy) v_u_6, (copy) v_u_3, (copy) v_u_11, (copy) v_u_5
	local v_u_13 = p_u_12:GetAttribute("Currency")
	local v14 = v_u_13 ~= nil
	local v15 = ("%* doesn\'t have \'Currency\' Attribute!"):format((p_u_12:GetFullName()))
	assert(v14, v15)
	if not v_u_6[v_u_13] then
		v_u_6[v_u_13] = {}
		v_u_3:observe(v_u_13, function(_)
			-- upvalues: (copy) v_u_13, (ref) v_u_6, (ref) v_u_11
			for _, v16 in v_u_6[v_u_13] or {} do
				v_u_11(v16)
			end
		end)
	end
	local v17 = v_u_6[v_u_13]
	table.insert(v17, p_u_12)
	local v_u_18 = v_u_5.observeAttribute(p_u_12, "Cost", function()
		-- upvalues: (ref) v_u_11, (copy) p_u_12
		v_u_11(p_u_12)
	end)
	local v_u_19 = v_u_5.observeAttribute(p_u_12, "Locked", function()
		-- upvalues: (ref) v_u_11, (copy) p_u_12
		v_u_11(p_u_12)
	end)
	return function()
		-- upvalues: (copy) v_u_18, (copy) v_u_19, (ref) v_u_6, (copy) v_u_13, (copy) p_u_12
		v_u_18()
		v_u_19()
		local v20 = table.find(v_u_6[v_u_13], p_u_12)
		if v20 then
			table.remove(v_u_6[v_u_13], v20)
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CurrencyButton]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3804"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Currency.CurrencyController)
local v_u_3 = require(v1.Config.CurrencyData)
local v_u_4 = require(v1.Enums.CurrencyTypes)
local v_u_5 = require(v1.Utility.Format)
local v_u_6 = {}
local function v_u_11(p7)
	-- upvalues: (copy) v_u_4, (copy) v_u_2, (copy) v_u_3, (copy) v_u_5
	local v8 = p7:GetAttribute("Currency") or v_u_4.Coins
	local v9 = v_u_2:get(v8)
	local v10 = v_u_3[v8]
	if p7:GetAttribute("FullText") then
		p7.Text = ("%* %*"):format(v_u_5.abbreviateComma(v9), (v10.GetPrefix(v9)))
	else
		p7.Text = v_u_5.abbreviateComma(v9)
	end
end
return function(p_u_12)
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_11
	local v_u_13 = p_u_12:GetAttribute("Currency")
	local v14 = v_u_13 ~= nil
	local v15 = ("%* doesn\'t have \'Currency\' Attribute!"):format((p_u_12:GetFullName()))
	assert(v14, v15)
	if not v_u_6[v_u_13] then
		v_u_6[v_u_13] = {}
		v_u_2:observe(v_u_13, function(_)
			-- upvalues: (copy) v_u_13, (ref) v_u_6, (ref) v_u_11
			for _, v16 in v_u_6[v_u_13] or {} do
				v_u_11(v16)
			end
		end)
	end
	local v17 = v_u_6[v_u_13]
	table.insert(v17, p_u_12)
	v_u_11(p_u_12)
	return function()
		-- upvalues: (ref) v_u_6, (copy) v_u_13, (copy) p_u_12
		local v18 = table.find(v_u_6[v_u_13], p_u_12)
		if v18 then
			table.remove(v_u_6[v_u_13], v18)
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CurrencyValue]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3805"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
local function v_u_5(p2)
	local v3 = ""
	for _, v4 in p2.Keypoints do
		v3 = v3 .. string.format("%.3f,%.3f,%.3f,%.3f;", v4.Time, v4.Value.R, v4.Value.G, v4.Value.B)
	end
	return v3
end
local function v_u_23(p6, p7)
	local v8 = p6.colors
	local v9 = p6.length
	local v10 = {}
	local v11 = false
	for v12 = 1, p6.total + 1 do
		if #v10 >= 100 then
			break
		end
		local v13 = v8[v12] or v8[v12 - p6.total]
		local v14 = p7 + (v12 - 1) / p6.total
		if v14 > 1 then
			v14 = v14 - 1
		end
		v11 = (v14 == 0 or v14 == 1) and true or v11
		local v15 = ColorSequenceKeypoint.new
		local v16 = math.clamp(v14, 0, 1)
		table.insert(v10, v15(v16, v13))
	end
	if not v11 and #v10 + 2 <= 100 then
		local v17 = (1 - p7) / v9 + 1
		local v18 = v8[math.floor(v17)]:Lerp(v8[math.ceil(v17)] or v8[1], v17 % 1)
		local v19 = ColorSequenceKeypoint.new
		table.insert(v10, v19(0, v18))
		local v20 = ColorSequenceKeypoint.new
		table.insert(v10, v20(1, v18))
	end
	table.sort(v10, function(p21, p22)
		return p21.Time < p22.Time
	end)
	return ColorSequence.new(v10)
end
game:GetService("RunService").RenderStepped:Connect(function(_)
	-- upvalues: (copy) v_u_1, (copy) v_u_23
	local v_u_24 = tick() % 3 / 3
	for _, v_u_25 in v_u_1 do
		local v26, v27 = pcall(function(...)
			-- upvalues: (ref) v_u_23, (copy) v_u_25, (copy) v_u_24
			return v_u_23(v_u_25, v_u_24)
		end)
		if v26 then
			v_u_25.currentSequence = v27
		else
			for _, v28 in v_u_25.gradients do
				print(v28:GetFullName())
			end
			warn("Failed to calculate new gradient sequence:", v27)
		end
	end
	for _, v29 in v_u_1 do
		for _, v30 in v29.gradients do
			v30.Color = v29.currentSequence
		end
	end
end)
function get_colors(p31)
	local v32 = {}
	for _, v33 in pairs(p31.Keypoints) do
		local v34 = v33.Value
		table.insert(v32, v34)
	end
	return v32
end
return function(p_u_35)
	-- upvalues: (copy) v_u_5, (copy) v_u_1
	if p_u_35:IsA("UIGradient") then
		local v_u_36 = v_u_5(p_u_35.Color)
		if not v_u_1[v_u_36] then
			v_u_1[v_u_36] = {
				["total"] = #p_u_35.Color.Keypoints,
				["length"] = 1 / #p_u_35.Color.Keypoints,
				["colors"] = get_colors(p_u_35.Color),
				["currentSequence"] = p_u_35.Color,
				["gradients"] = {}
			}
		end
		local v37 = v_u_1[v_u_36].gradients
		table.insert(v37, p_u_35)
		local v_u_38
		if p_u_35:GetAttribute("Color") then
			v_u_38 = p_u_35:GetAttributeChangedSignal("Color"):Connect(function()
				-- upvalues: (copy) p_u_35
				p_u_35:RemoveTag(script.Name)
				task.defer(function()
					-- upvalues: (ref) p_u_35
					p_u_35:AddTag(script.Name)
				end)
			end)
		else
			v_u_38 = nil
		end
		return function()
			-- upvalues: (ref) v_u_38, (ref) v_u_1, (copy) v_u_36, (copy) p_u_35
			if v_u_38 then
				v_u_38:Disconnect()
				v_u_38 = nil
			end
			local v39 = v_u_1[v_u_36]
			if v39 then
				local v40 = table.find(v39.gradients, p_u_35)
				if v40 then
					table.remove(v39.gradients, v40)
				end
				if #v39.gradients <= 0 then
					v_u_1[v_u_36] = nil
				end
			end
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Gradient]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3806"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Utility.UI)
return function(p_u_3)
	-- upvalues: (copy) v_u_2
	p_u_3:AddTag("Button")
	p_u_3.Activated:Connect(function()
		-- upvalues: (copy) p_u_3, (ref) v_u_2
		if p_u_3:FindFirstChild("Notification") then
			p_u_3.Notification:Destroy()
		end
		v_u_2:open(p_u_3.Name)
	end)
	return function() end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MenuButton]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3807"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.MultiplierData)
local v_u_3 = require(v1.Enums.MultiplierTypes)
local v_u_4 = require(v1.Utility.Format)
local v_u_5 = require(v1.Utility.Multiplier)
local v_u_6 = {}
local v_u_11 = {
	["ValentineRuneBulk"] = {
		["multipliers"] = { v_u_3.ValentineRuneBulk, v_u_3.ValentineRuneBulkMultiplier },
		["value"] = function()
			-- upvalues: (copy) v_u_5, (copy) v_u_3
			local v7 = v_u_5.get(v_u_3.ValentineRuneBulk) * v_u_5.get(v_u_3.ValentineRuneBulkMultiplier)
			return math.floor(v7)
		end,
		["format"] = function(p8)
			-- upvalues: (copy) v_u_4
			return v_u_4.abbreviateComma((math.ceil(p8)))
		end
	},
	["ValentineRuneLuck"] = {
		["multipliers"] = { v_u_3.ValentineRuneLuck, v_u_3.ValentineRuneLuckMultiplier },
		["value"] = function()
			-- upvalues: (copy) v_u_5, (copy) v_u_3
			return v_u_5.get(v_u_3.ValentineRuneLuck) * v_u_5.get(v_u_3.ValentineRuneLuckMultiplier)
		end,
		["format"] = function(p9)
			local v10 = p9 * 100
			return ("%*%%"):format(math.floor(v10) / 100)
		end
	}
}
local function v_u_20(p_u_12, p13)
	-- upvalues: (copy) v_u_2, (copy) v_u_6, (copy) v_u_5
	local v_u_14 = v_u_2[p_u_12]
	local v15 = v_u_14 ~= nil
	local v16 = ("No multiplier data for type: %*"):format(p_u_12)
	assert(v15, v16)
	if not v_u_6[p_u_12] then
		v_u_6[p_u_12] = {}
		v_u_5.observe(p_u_12, function(p17)
			-- upvalues: (ref) v_u_6, (copy) p_u_12, (copy) v_u_14
			for _, v18 in v_u_6[p_u_12] do
				v18.Text = v_u_14.Format(p17)
			end
		end)
	end
	local v19 = v_u_6[p_u_12]
	table.insert(v19, p13)
	p13.Text = v_u_14.Format(v_u_5.get(p_u_12))
end
local function v_u_31(p_u_21, p22)
	-- upvalues: (copy) v_u_11, (copy) v_u_6, (copy) v_u_5
	local v_u_23 = v_u_11[p_u_21]
	local v24 = v_u_23 ~= nil
	local v25 = ("No custom multiplier data for type: %*"):format(p_u_21)
	assert(v24, v25)
	if not v_u_6[p_u_21] then
		v_u_6[p_u_21] = {}
		local function v28()
			-- upvalues: (copy) v_u_23, (ref) v_u_6, (copy) p_u_21
			local v26 = v_u_23.value()
			for _, v27 in v_u_6[p_u_21] do
				v27.Text = v_u_23.format(v26)
			end
		end
		for _, v29 in v_u_23.multipliers do
			v_u_5.observe(v29, v28)
		end
	end
	local v30 = v_u_6[p_u_21]
	table.insert(v30, p22)
	p22.Text = v_u_23.format(v_u_23.value())
end
return function(p_u_32)
	-- upvalues: (copy) v_u_11, (copy) v_u_20, (copy) v_u_31, (copy) v_u_6
	local v_u_33 = p_u_32:GetAttribute("Type")
	local v_u_34 = p_u_32:GetAttribute("Custom")
	if v_u_34 and not v_u_11[v_u_34] then
		error((("No custom multiplier data for type: %*"):format(v_u_34)))
	end
	if v_u_33 then
		v_u_20(v_u_33, p_u_32)
	else
		v_u_31(v_u_34, p_u_32)
	end
	return function()
		-- upvalues: (ref) v_u_6, (copy) v_u_33, (copy) v_u_34, (copy) p_u_32
		local v35 = v_u_6[v_u_33 or v_u_34] and table.find(v_u_6[v_u_33 or v_u_34], p_u_32)
		if v35 then
			table.remove(v_u_6[v_u_33 or v_u_34], v35)
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MultiplierValueText]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3808"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Utility.Spring)
local v_u_3 = {}
task.spawn(function()
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	while true do
		for _, v_u_4 in v_u_3 do
			if v_u_4.Visible then
				task.spawn(function()
					-- upvalues: (copy) v_u_4, (ref) v_u_2
					local v5 = v_u_4:GetAttribute("start_position") or v_u_4.Position
					local v6 = v_u_4:GetAttribute("target_position") or v5 - UDim2.fromScale(0, 0.1)
					v_u_2.target(v_u_4.UIScale, 1, 5, {
						["Scale"] = 1
					})
					v_u_2.target(v_u_4, 0.8, 5, {
						["Position"] = v6
					})
					task.wait(0.1)
					v_u_2.target(v_u_4, 0.8, 5, {
						["Rotation"] = 25
					})
					task.wait(0.05)
					v_u_2.target(v_u_4, 0.8, 5, {
						["Rotation"] = -25
					})
					task.wait(0.05)
					v_u_2.target(v_u_4, 0.8, 5, {
						["Rotation"] = 0
					})
					task.wait(0.05)
					v_u_2.target(v_u_4, 0.8, 5, {
						["Position"] = v5
					})
					v_u_2.target(v_u_4.UIScale, 1, 3, {
						["Scale"] = 0.8
					})
				end)
			end
		end
		task.wait(2)
	end
end)
return function(p_u_7)
	-- upvalues: (copy) v_u_3
	local v8 = p_u_7:GetAttribute("start_position") or p_u_7.Position
	local v9 = p_u_7:GetAttribute("target_position") or v8 - UDim2.fromScale(0, 0.1)
	if not p_u_7:FindFirstChild("UIScale") then
		Instance.new("UIScale").Parent = p_u_7
	end
	p_u_7:SetAttribute("start_position", v8)
	p_u_7:SetAttribute("target_position", v9)
	p_u_7.Position = v8
	local v10 = v_u_3
	table.insert(v10, p_u_7)
	return function()
		-- upvalues: (ref) v_u_3, (copy) p_u_7
		table.remove(v_u_3, table.find(v_u_3, p_u_7))
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Notification]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3809"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Utility.UI)
return function(p_u_3)
	-- upvalues: (copy) v_u_2
	local v_u_4 = Instance.new("ProximityPrompt")
	v_u_4.UIOffset = Vector2.new(0, 999999)
	v_u_4.RequiresLineOfSight = false
	v_u_4.Parent = p_u_3
	v_u_4.MaxActivationDistance = p_u_3:GetAttribute("Range") or 10
	v_u_4.PromptShown:Connect(function()
		-- upvalues: (ref) v_u_2, (copy) p_u_3
		v_u_2:open(p_u_3.Name)
	end)
	v_u_4.PromptHidden:Connect(function()
		-- upvalues: (ref) v_u_2, (copy) p_u_3
		if v_u_2.Current == p_u_3.Name then
			v_u_2:close(v_u_2.Current)
		end
	end)
	return function()
		-- upvalues: (copy) v_u_4
		if v_u_4 then
			v_u_4:Destroy()
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UIPart]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3810"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.DataController)
local v3 = require(v1.Config.Constants)
require(v1.Config.SkillData)
local v_u_4 = require(v1.Functions.CalculateSkillXP)
local v_u_5 = require(v1.Utility.Format)
local v_u_6 = v3.SKILL_LEVEL_CAP
return function(p7)
	-- upvalues: (copy) v_u_2, (copy) v_u_6, (copy) v_u_4, (copy) v_u_5
	local v_u_8 = p7.Progress
	local v_u_9 = v_u_8.Title
	local v_u_10 = p7.Level
	local function v14()
		-- upvalues: (ref) v_u_2, (copy) v_u_10, (ref) v_u_6, (copy) v_u_9, (copy) v_u_8, (ref) v_u_4, (ref) v_u_5
		local v11 = v_u_2:getValue({ "Skills", "XP" })
		local v12 = v_u_2:getValue({ "Skills", "Level" })
		v_u_10.Text = ("Level %*"):format(v12)
		if v_u_6 <= v12 then
			v_u_9.Text = "Max Level"
			v_u_8.UIGradient.Offset = Vector2.new(1, 0)
		else
			local v13 = v_u_4(v12 + 1)
			v_u_8.UIGradient.Offset = Vector2.new(v11 / v13, 0)
			v_u_9.Text = ("%* / %* XP (%* > %*)"):format(v_u_5.abbreviateComma(v11), v_u_5.abbreviateComma(v13), v12, v12 + 1)
		end
	end
	v_u_2:onSet({ "Skills", "XP" }, v14)
	v_u_2:onSet({ "Skills", "Level" }, v14)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SkillBillboard]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3811"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.CurrencyData)
local v_u_3 = require(v1.Config.RuneOpenData)
local v_u_4 = require(v1.Utility.Format)
return function(p5)
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_4
	local v6 = v_u_3[p5.Name]
	if v6 then
		local v7 = v_u_2[v6.CurrencyType]
		if v7 then
			p5.Icon.Image = v7.Icon
			p5.Amount.Text = v_u_4.abbreviateComma(v6.CurrencyCost)
			p5.Amount.TextColor3 = v7.Color
		end
	else
		return
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RuneCost]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3812"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("RunService")
local v_u_2 = {}
local v_u_3 = 0
local v_u_4 = {}
v1.RenderStepped:Connect(function(p5)
	-- upvalues: (ref) v_u_3, (copy) v_u_2, (ref) v_u_4
	v_u_3 = v_u_3 + 1.5707963267948966 * p5
	for v6 = 0, 15 do
		local v7 = Color3.fromRGB
		local v8 = 0.20943951023931953 * v6 + v_u_3
		local v9 = math.sin(v8) * 127 + 128
		local v10 = 0.20943951023931953 * v6 + 2.0943951023931953 + v_u_3
		local v11 = math.sin(v10) * 127 + 128
		local v12 = 0.20943951023931953 * v6 + 4.1887902047863905 + v_u_3
		local v13 = v7(v9, v11, math.sin(v12) * 127 + 128)
		for _, v14 in v_u_2 do
			if v14:IsA("Highlight") then
				v14.FillColor = v13
			elseif v14:IsA("BasePart") or v14:IsA("MeshPart") then
				v14.Color = v13
			end
		end
		local v15 = v_u_4
		local v16 = v6 + 1
		local v17 = ColorSequenceKeypoint.new
		local v18 = v6 / 15
		table.insert(v15, v16, v17(v18, v13))
	end
	v_u_4 = {}
	if v_u_3 >= 6.283185307179586 then
		v_u_3 = v_u_3 - 6.283185307179586
	end
end)
return function(p_u_19)
	-- upvalues: (copy) v_u_2
	local v20 = v_u_2
	table.insert(v20, p_u_19)
	return function()
		-- upvalues: (ref) v_u_2, (copy) p_u_19
		local v21 = table.find(v_u_2, p_u_19)
		if v21 then
			table.remove(v_u_2, v21)
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Rainbow]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3813"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Shime)
return function(p2)
	-- upvalues: (copy) v_u_1
	local v3 = p2:GetAttribute("TimeLength") or 1
	local v4 = p2:GetAttribute("DelayLength") or 2
	local v_u_5 = v_u_1.new(p2, v3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, false, math.random(v4, v4 * 1.5))
	v_u_5:Play()
	return function()
		-- upvalues: (copy) v_u_5
		v_u_5:Destroy()
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Shimmer]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3814"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("TweenService")
local function v_u_8(p3)
	local v4 = Color3.fromRGB(255, 255, 255)
	local v5
	if p3:IsA("ImageLabel") then
		v5 = p3
	else
		v5 = Instance.new("Frame")
		v5.Name = "ShimmerFrame"
		v5.BackgroundColor3 = v4
		v5.BackgroundTransparency = 0
		v5.ClipsDescendants = true
		v5.Size = UDim2.new(1, 0, 1, 0)
		v5.AnchorPoint = Vector2.new(0.5, 0.5)
		v5.Position = UDim2.new(0.5, 0, 0.5, 0)
		v5.BorderSizePixel = 0
		v5.Visible = false
		v5.ZIndex = p3.ZIndex + 15
		v5.Parent = p3
	end
	if v5 ~= p3 and p3:FindFirstChildOfClass("UICorner") then
		local v6 = Instance.new("UICorner")
		v6.CornerRadius = p3:FindFirstChildOfClass("UICorner").CornerRadius or 0
		v6.Parent = v5
	end
	local v7 = Instance.new("UIGradient")
	v7.Name = "ShimmerGradient"
	v7.Rotation = 15
	v7.Color = ColorSequence.new(Color3.new(1, 1, 1))
	v7.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.15, 1),
		NumberSequenceKeypoint.new(0.5, 0.55),
		NumberSequenceKeypoint.new(0.85, 1),
		NumberSequenceKeypoint.new(1, 1)
	})
	v7.Offset = Vector2.new(-1, 0)
	v7.Parent = v5
	return v5
end
v_u_1.IsPlaying = false
v_u_1.IsPaused = false
v_u_1.IsCompleted = false
function v_u_1.new(p9, p10, p11, p12, p13, p14, p15)
	-- upvalues: (copy) v_u_1, (copy) v_u_8, (copy) v_u_2
	local v16 = v_u_1
	local v_u_17 = setmetatable({}, v16)
	local v18 = p11 or Enum.EasingStyle.Linear
	local v19 = p12 or Enum.EasingDirection.InOut
	v_u_17._shimmer = v_u_8(p9)
	v_u_17._tween = v_u_2:Create(v_u_17._shimmer:WaitForChild("ShimmerGradient"), TweenInfo.new(p10 or 1, v18, v19, p13 or -1, p14 or false, p15 or 0), {
		["Offset"] = Vector2.new(1, 0)
	})
	v_u_17._tween.Completed:Connect(function()
		-- upvalues: (copy) v_u_17
		v_u_17:_TweenCompleted()
	end)
	return v_u_17
end
function v_u_1._TweenCompleted(p20)
	p20:Stop()
end
function v_u_1.Play(p21)
	p21.IsPlaying = true
	p21.IsPaused = false
	p21.IsCompleted = false
	p21._shimmer.Visible = true
	p21._tween:Play()
end
function v_u_1.Pause(p22)
	if not p22.IsCompleted then
		p22.IsPlaying = false
		p22.IsPaused = true
		p22._shimmer.Visible = true
		p22._tween:Pause()
	end
end
function v_u_1.Stop(p23)
	p23.IsPlaying = false
	p23.IsPaused = false
	p23.IsCompleted = true
	p23._tween:Cancel()
	p23._shimmer.Visible = false
end
function v_u_1.Destroy(p24)
	p24._shimmer:Destroy()
	p24._tween:Destroy()
	setmetatable(p24, nil)
end
return v_u_1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Shime]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3815"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
task.spawn(function()
	-- upvalues: (copy) v_u_1
	while true do
		for _, v2 in v_u_1 do
			v2.Rotation = v2.Rotation + (v2:GetAttribute("Speed") or 1)
		end
		task.wait(0.03)
	end
end)
return function(p_u_3)
	-- upvalues: (copy) v_u_1
	local v4 = v_u_1
	table.insert(v4, p_u_3)
	return function()
		-- upvalues: (ref) v_u_1, (copy) p_u_3
		table.remove(v_u_1, table.find(v_u_1, p_u_3))
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Rotate]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3816"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
game:GetService("RunService").Heartbeat:Connect(function(p2)
	-- upvalues: (copy) v_u_1
	for v3, v4 in pairs(v_u_1) do
		if v3.Parent then
			local v5 = v3:GetAttribute("SpinSpeed") or 90
			v4.cf = v4.cf * CFrame.Angles(0, math.rad(v5) * p2, 0)
			v3:SetAttribute("CurrentCFrame", v4.cf)
		else
			v_u_1[v3] = nil
		end
	end
end)
return function(p_u_6)
	-- upvalues: (copy) v_u_1
	local v_u_7 = p_u_6.CFrame
	p_u_6:SetAttribute("BaseCFrame", v_u_7)
	p_u_6:SetAttribute("CurrentCFrame", v_u_7)
	v_u_1[p_u_6] = {
		["cf"] = v_u_7
	}
	return function()
		-- upvalues: (ref) v_u_1, (copy) p_u_6, (copy) v_u_7
		v_u_1[p_u_6] = nil
		p_u_6:SetAttribute("CurrentCFrame", nil)
		p_u_6.CFrame = v_u_7
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Spin]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3817"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
game:GetService("RunService").Heartbeat:Connect(function(p2)
	-- upvalues: (copy) v_u_1
	for v3, v4 in pairs(v_u_1) do
		if v3.Parent then
			local v5 = v3:GetAttribute("BopHeight") or 1
			local v6 = v3:GetAttribute("BopSpeed") or 2
			v4.time = v4.time + p2 * v6
			local v7 = v4.time
			local v8 = math.sin(v7) * v5
			v3.CFrame = (v3:GetAttribute("CurrentCFrame") or (v3:GetAttribute("BaseCFrame") or v4.baseCFrame)) * CFrame.new(0, v8, 0)
		else
			v_u_1[v3] = nil
		end
	end
end)
return function(p_u_9)
	-- upvalues: (copy) v_u_1
	local v_u_10 = p_u_9.CFrame
	v_u_1[p_u_9] = {
		["baseCFrame"] = v_u_10,
		["time"] = math.random() * 3.141592653589793 * 2
	}
	return function()
		-- upvalues: (ref) v_u_1, (copy) p_u_9, (copy) v_u_10
		v_u_1[p_u_9] = nil
		p_u_9.CFrame = v_u_10
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Bob]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3818"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = workspace.CurrentCamera
local v_u_2 = Vector2.new(1920, 1080)
local v_u_3 = {}
local v_u_4 = {}
local function v9()
	-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_2, (copy) v_u_3
	for v5 in v_u_4 do
		local v6 = v_u_1.ViewportSize.Y / v_u_2.Y
		local v7 = v_u_3[v5] * v6
		local v8 = math.round(v7)
		v5.TextSize = math.max(1, v8)
	end
end
for v10 in v_u_4 do
	local v11 = v_u_1.ViewportSize.Y / v_u_2.Y
	local v12 = v_u_3[v10] * v11
	local v13 = math.round(v12)
	v10.TextSize = math.max(1, v13)
end
v_u_1:GetPropertyChangedSignal("ViewportSize"):Connect(v9)
return function(p_u_14)
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_1, (copy) v_u_2
	if p_u_14:IsA("TextLabel") then
		v_u_3[p_u_14] = p_u_14.TextSize
		v_u_4[p_u_14] = v_u_4
		local v15 = v_u_1.ViewportSize.Y / v_u_2.Y
		local v16 = v_u_3[p_u_14] * v15
		local v17 = math.round(v16)
		p_u_14.TextSize = math.max(1, v17)
		return function()
			-- upvalues: (ref) v_u_3, (copy) p_u_14, (ref) v_u_4
			v_u_3[p_u_14] = nil
			v_u_4[p_u_14] = nil
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AdjustTextSize]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3819"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Tooltips]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3820"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("GuiService")
local v2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local v4 = game:GetService("RunService")
local v_u_5 = game:GetService("UserInputService")
local v6 = require(v3.Packages.Observers)
local v7 = require(v3.Utility.UI)
local v8 = {}
local v_u_9 = {}
local v_u_10 = {
	["Size"] = {},
	["TextSize"] = {},
	["List"] = {},
	["Padding"] = {},
	["Full"] = {},
	["Stroke"] = {}
}
local v_u_11 = workspace.CurrentCamera
local v_u_12 = v2.LocalPlayer:GetMouse()
local v_u_13 = Vector2.new(1920, 1080)
local v_u_14 = v7:get("Persistent", "Tooltip").Main
v_u_14.Visible = false
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local function v_u_19()
	-- upvalues: (copy) v_u_14
	for _, v18 in v_u_14:GetChildren() do
		if v18:IsA("Frame") or v18:IsA("TextLabel") then
			v18.Visible = false
		end
	end
end
local function v_u_23(p20)
	-- upvalues: (copy) v_u_9, (ref) v_u_16, (copy) v_u_19, (ref) v_u_17, (copy) v_u_14, (ref) v_u_15
	local v21 = p20:GetAttribute("ItemType")
	if v21 then
		local v22 = v_u_9[v21]
		if v22 then
			if v_u_16 ~= p20 then
				v_u_19()
				if v_u_17 then
					v_u_17()
					v_u_17 = nil
				end
				v_u_17 = v22(v_u_14, p20)
			end
			v_u_16 = p20
			v_u_15 = v_u_14
			if v_u_15 then
				v_u_15.Visible = true
			end
		else
			return
		end
	else
		return
	end
end
local v_u_24 = v_u_15
local v_u_25 = v_u_17
local v_u_26 = v_u_16
local function v28()
	-- upvalues: (copy) v_u_14, (copy) v_u_10
	for _, v27 in v_u_14:GetDescendants() do
		if v27:IsA("TextLabel") then
			if not v27:GetAttribute("IgnoreText") then
				v_u_10.TextSize[v27] = v27.TextSize
				goto l4
			end
		else
			::l4::
			if v27:IsA("UIListLayout") then
				v_u_10.List[v27] = v27.Padding
			end
			if v27:IsA("UIPadding") then
				v_u_10.Padding[v27] = {
					["PaddingBottom"] = v27.PaddingBottom,
					["PaddingLeft"] = v27.PaddingLeft,
					["PaddingRight"] = v27.PaddingRight,
					["PaddingTop"] = v27.PaddingTop
				}
			end
			if v27:IsA("UIStroke") then
				v_u_10.Stroke[v27] = v27.Thickness
			end
			if v27:IsA("GuiObject") and v27.Size ~= UDim2.new() then
				if v27:GetAttribute("IgnoreResize") then
					v_u_10.Full[v27] = v27.Size
				else
					v_u_10.Size[v27] = v27.Size
				end
			end
		end
	end
end
local function v45()
	-- upvalues: (copy) v_u_11, (copy) v_u_13, (copy) v_u_10
	local v29 = v_u_11.ViewportSize.X / v_u_13.X
	local v30 = math.max(0.3, v29)
	local v31 = v_u_11.ViewportSize.Y / v_u_13.Y
	local v32 = math.min(v30, v31)
	for v33, v34 in v_u_10.Size do
		v33.Size = UDim2.fromOffset(v34.X.Offset * v32, v34.Y.Offset * v32)
	end
	for v35, v36 in v_u_10.TextSize do
		v35.TextSize = v36 * v32
		v35.TextScaled = false
	end
	for v37, v38 in v_u_10.List do
		v37.Padding = UDim.new(0, v38.Offset * v32)
	end
	for v39, v40 in v_u_10.Padding do
		for v41, v42 in v40 do
			v39[v41] = UDim.new(0, v42.Offset * v32)
		end
	end
	for v43, v44 in v_u_10.Full do
		v43.Size = UDim2.new(v44.X.Scale, v44.X.Offset * v32, v44.Y.Scale, v44.Y.Offset * v32)
	end
	for _, _ in v_u_10.Stroke do

	end
end
for _, v46 in script.Parent.ItemTypes:GetChildren() do
	if v46:IsA("ModuleScript") then
		v_u_9[v46.Name] = require(v46)
	end
end
v28()
v6.observeTag("tooltip", function(p_u_47)
	-- upvalues: (copy) v_u_23, (ref) v_u_26, (ref) v_u_25, (ref) v_u_24
	local v_u_48 = {}
	local v49 = { "MouseLeave", "SelectionLost", "AncestryChanged" }
	for _, v50 in { "MouseEnter", "SelectionGained" } do
		local v51 = p_u_47[v50]
		local function v52()
			-- upvalues: (ref) v_u_23, (copy) p_u_47
			v_u_23(p_u_47)
		end
		table.insert(v_u_48, v51:Connect(v52))
	end
	for _, v53 in v49 do
		local v54 = p_u_47[v53]
		local function v55()
			-- upvalues: (copy) p_u_47, (ref) v_u_26, (ref) v_u_25, (ref) v_u_24
			if v_u_26 == p_u_47 then
				if v_u_25 then
					v_u_25()
					v_u_25 = nil
				end
				if v_u_24 then
					v_u_24.Visible = false
				end
				v_u_26 = nil
				v_u_24 = nil
			end
		end
		table.insert(v_u_48, v54:Connect(v55))
	end
	return function()
		-- upvalues: (ref) v_u_48
		for _, v56 in v_u_48 do
			v56:Disconnect()
		end
		table.clear(v_u_48)
		v_u_48 = nil
	end
end)
v6.observeProperty(v_u_11, "ViewportSize", v45)
local v_u_57 = tick()
v4.Heartbeat:Connect(function(_)
	-- upvalues: (ref) v_u_24, (ref) v_u_57, (ref) v_u_26, (copy) v_u_1, (copy) v_u_12, (ref) v_u_25, (copy) v_u_5, (copy) v_u_11
	if v_u_24 then
		if tick() - v_u_57 > 1 then
			v_u_57 = tick()
			if v_u_26 then
				local v58 = v_u_26
				local v59
				if v58 then
					local v60 = v58.AbsolutePosition
					local v61 = v58.AbsoluteSize
					if v_u_1.SelectedObject == v58 then
						v59 = true
					elseif v_u_12.X >= v60.X and (v_u_12.X <= v60.X + v61.X and v_u_12.Y >= v60.Y) then
						v59 = v_u_12.Y <= v60.Y + v61.Y
					else
						v59 = false
					end
				else
					v59 = false
				end
				if not v59 then
					if v_u_26 == v_u_26 then
						if v_u_25 then
							v_u_25()
							v_u_25 = nil
						end
						if v_u_24 then
							v_u_24.Visible = false
						end
						v_u_26 = nil
						v_u_24 = nil
					end
				end
			end
		end
		local v62 = v_u_5:GetMouseLocation()
		local v63 = v_u_24
		local v64 = UDim2.fromOffset
		local v65 = v62.X + v_u_24.AbsoluteSize.X / 2 + 15
		local v66 = v_u_11.ViewportSize.X - v_u_24.AbsoluteSize.X / 2
		local v67 = math.clamp(v65, 0, v66)
		local v68 = v62.Y + v_u_24.AbsoluteSize.Y / 2 + 15
		local v69 = v_u_11.ViewportSize.Y - v_u_24.AbsoluteSize.Y / 2
		v63.Position = v64(v67, (math.clamp(v68, 0, v69)))
	end
end)
return v8]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TooltipController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3821"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

game:GetService("ReplicatedStorage")
return {
	["UpdateRarity"] = function(_, _) end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TooltipUtil]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="3822"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ItemTypes]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3823"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.MultiplierData)
return function(p3, p4)
	-- upvalues: (copy) v_u_2
	local v5 = p4:GetAttribute("Multiplier")
	if v5 then
		local v6 = v_u_2[v5]
		if v6 then
			local v7 = p4:GetAttribute("Current")
			local v8 = p4:GetAttribute("Previous")
			p3.Title.Text = v6.Name
			p3.Title.Visible = true
			p3.Desc.Visible = true
			local v9 = v6.FormatPerk or v6.Format
			if v7 and v8 then
				p3.Desc.Text = ("%* \226\134\146 %*"):format(v9(v8), (v9(v7)))
			elseif v7 then
				p3.Desc.Text = v9(v7)
			end
			p3.RaritySplitter.Visible = true
			return function() end
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MasteryPerk]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3824"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.RarityData)
return function(p_u_3, p_u_4)
	-- upvalues: (copy) v_u_2
	p_u_3.Title.Visible = p_u_4:GetAttribute("Title")
	p_u_3.Title.Text = p_u_4:GetAttribute("Title")
	p_u_3.Desc.Visible = p_u_4:GetAttribute("Description")
	p_u_3.Desc.Text = p_u_4:GetAttribute("Description") or ""
	p_u_3.RaritySplitter.Visible = p_u_3.Desc.Visible
	local v_u_5 = p_u_4:GetAttributeChangedSignal("Description"):Connect(function()
		-- upvalues: (copy) p_u_3, (copy) p_u_4
		p_u_3.Desc.Visible = p_u_4:GetAttribute("Description")
		p_u_3.Desc.Text = p_u_4:GetAttribute("Description") or ""
	end)
	local v6 = v_u_2[p_u_4:GetAttribute("Rarity")]
	if v6 then
		p_u_3.RaritySplitter.Visible = true
		p_u_3.Rarity.Text = v6.Name
		p_u_3.Rarity.UIGradient.Color = v6.Gradient
	end
	p_u_3.Passives.Visible = p_u_4:GetAttribute("Passives")
	p_u_3.Passives.Text = p_u_4:GetAttribute("Passives") or ""
	p_u_3.Perks.Visible = p_u_4:GetAttribute("Perks")
	p_u_3.Perks.Text = p_u_4:GetAttribute("Perks") or ""
	return function()
		-- upvalues: (ref) v_u_5
		if v_u_5 then
			v_u_5:Disconnect()
			v_u_5 = nil
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Perk]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3825"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.AmuletPassiveData)
return function(p3, p4)
	-- upvalues: (copy) v_u_2
	local v5 = v_u_2[p4:GetAttribute("Passive")]
	if v5 then
		p3.Title.Visible = true
		p3.Title.Text = v5.Name
		p3.Desc.Visible = v5.Description
		p3.Desc.Text = v5.Description or ""
		p3.RaritySplitter.Visible = p3.Desc.Visible
		return function() end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AmuletPassive]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3826"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.AmuletPerkData)
return function(p3, p4)
	-- upvalues: (copy) v_u_2
	local v5 = v_u_2[p4:GetAttribute("Perk")]
	if v5 then
		p3.Title.Visible = true
		p3.Title.Text = v5.Name
		p3.Desc.Visible = v5.Description ~= nil
		p3.Desc.Text = v5.Description or ""
		p3.RaritySplitter.Visible = p3.Desc.Visible
		return function() end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AmuletPerk]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item></Item><Item class="Folder" referent="3827"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Lighting]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3828"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Lighting")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = require(v2.Utility.WorldUtil)
local v5 = {}
local v_u_6 = v2:WaitForChild("Lighting")
function v5.clear(_)
	-- upvalues: (copy) v_u_1
	for _, v7 in v_u_1:GetChildren() do
		if not v7:GetAttribute("Ignore") then
			v7:Destroy()
		end
	end
end
function v5.update(p8, p9)
	-- upvalues: (copy) v_u_6, (copy) v_u_1, (copy) v_u_3
	local v10 = v_u_6:FindFirstChild(p9)
	if v10 then
		p8:clear()
		for _, v11 in v10:GetChildren() do
			v11:Clone().Parent = v_u_1
		end
		local v12 = {}
		for v13, v14 in v10:GetAttributes() do
			if v_u_1[v13] ~= v14 then
				v12[v13] = v14
			end
		end
		v_u_3:Create(v_u_1, TweenInfo.new(1), v12):Play()
	end
end
function v5.init(p_u_15)
	-- upvalues: (copy) v_u_4
	v_u_4.observe(function(p16, ...)
		-- upvalues: (copy) p_u_15
		p_u_15:update(p16)
	end)
end
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LightingController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3829"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Admin]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3830"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = require(v2.Config.Constants)
local v_u_6 = require(v2.Packages.Iris)
local v_u_7 = require(v2.Packages.Sift)
local v_u_8 = require(v2.Packages.Topbarplus)
local v9 = require(v2.Utility.Network)
local v10 = {}
local v_u_11 = {}
local v_u_12 = false
local v_u_13 = v9.remoteEvent("Admin")
local function v_u_14()
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_1
	return v_u_3:IsStudio() and true or (game.PlaceId == v_u_5.DEV_PLACE_ID and true or table.find({ 6515523, 90351039 }, v_u_1.LocalPlayer.UserId) ~= nil)
end
function v10.init(_)
	-- upvalues: (copy) v_u_14, (copy) v_u_8, (ref) v_u_12, (copy) v_u_11, (copy) v_u_7, (copy) v_u_6, (copy) v_u_1, (copy) v_u_13, (copy) v_u_4, (copy) v_u_3
	if v_u_14() then
		local v15 = v_u_8.new()
		v15:setLabel("Admin Panel")
		v15:setRight()
		v15:setOrder(-1)
		v15.toggled:Connect(function()
			-- upvalues: (ref) v_u_12
			v_u_12 = not v_u_12
		end)
		for _, v16 in script.Parent.Components:GetDescendants() do
			if v16:IsA("ModuleScript") then
				v_u_11[v16.Name] = require(v16)
			end
		end
		local v19 = v_u_7.Array.sort(v_u_7.Dictionary.keys(v_u_11), function(p17, p18)
			return string.len(p17) > string.len(p18)
		end)
		local v_u_20 = {}
		local v21 = 1
		for v22 = 1, #v19 do
			if v22 % 4 == 0 then
				v21 = v21 + 1
			end
			v_u_20[v21] = v_u_20[v21] or {}
			v_u_20[v21][v19[v22]] = v_u_11[v19[v22]]
		end
		v_u_6.Init()
		local v_u_23 = nil
		v_u_6:Connect(function()
			-- upvalues: (ref) v_u_12, (ref) v_u_6, (ref) v_u_1, (copy) v_u_20, (ref) v_u_23, (ref) v_u_11, (ref) v_u_13
			if v_u_12 then
				v_u_6.Window({
					"Admin Panel",
					nil,
					nil,
					nil,
					true
				})
				v_u_6.Text({ (("Welcome, %*!"):format(v_u_1.LocalPlayer.DisplayName)) })
				v_u_6.Separator()
				for _, v24 in v_u_20 do
					v_u_6.SameLine()
					for v_u_25, _ in v24 do
						if v_u_6.Button({ v_u_25 }).clicked() then
							if v_u_23 == v_u_25 then
								v_u_23 = nil
							else
								v_u_23 = nil
								task.defer(function()
									-- upvalues: (ref) v_u_23, (copy) v_u_25
									v_u_23 = v_u_25
								end)
							end
						end
					end
					v_u_6.End()
				end
				if v_u_23 then
					local v26 = v_u_11[v_u_23]
					debug.profilebegin((("Admin/%*"):format(v_u_23)))
					local v27 = {
						v_u_23,
						nil,
						nil,
						nil,
						true
					}
					v_u_6.Window(v27)
					v26({
						["fire"] = function(...)
							-- upvalues: (ref) v_u_13, (ref) v_u_23
							v_u_13.fire(v_u_23, ...)
						end
					})
					v_u_6.End()
					debug.profileend()
				end
				v_u_6.End()
			end
		end)
		local v_u_28 = v_u_1.LocalPlayer:GetMouse()
		v_u_28.TargetFilter = workspace:WaitForChild("Persistent", 99)
		v_u_4.InputBegan:Connect(function(p29, _)
			-- upvalues: (ref) v_u_12, (ref) v_u_3, (ref) v_u_4, (ref) v_u_1, (copy) v_u_28
			if p29.KeyCode == Enum.KeyCode.F2 or p29.KeyCode == Enum.KeyCode.Semicolon then
				v_u_12 = not v_u_12
			end
			local v30 = v_u_3:IsStudio() and (p29.UserInputType == Enum.UserInputType.MouseButton1 and (v_u_4:IsKeyDown(Enum.KeyCode.LeftControl) and v_u_1.LocalPlayer.Character))
			if v30 then
				v30:PivotTo(v_u_28.Hit + Vector3.new(0, 5, 0))
			end
		end)
	end
end
return v10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AdminController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="3831"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Components]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3832"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.Iris)
return function(p3)
	-- upvalues: (copy) v_u_2
	if v_u_2.Button({ "Rejoin" }).clicked() then
		p3.fire()
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AutoRejoin]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3833"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.MultiplierData)
local v_u_3 = require(v1.Packages.Iris)
local v4 = require(v1.Utility.Multiplier)
local v_u_5 = {}
for v_u_6, _ in v_u_2 do
	v4.observe(v_u_6, function(p7)
		-- upvalues: (copy) v_u_5, (copy) v_u_6
		v_u_5[v_u_6] = p7
	end)
end
return function(_)
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_5
	v_u_3.Text({ "View your buffs" })
	v_u_3.Separator()
	for v8, v9 in v_u_2 do
		local v10 = v_u_5[v8] or v9.Default
		v_u_3.Text({ (("%*: %*"):format(v9.Name, (v9.Format(v10)))) })
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Buffs]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3834"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Config.CurrencyData)
local v_u_4 = require(v2.Packages.Iris)
return function(p5)
	-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_3
	local v6 = v_u_4.State(v_u_1.LocalPlayer)
	local v7 = v_u_4.State("ALL")
	local v8 = v_u_4.State(0)
	v_u_4.Combo({ "Selected Player" }, {
		["index"] = v6
	})
	for _, v9 in v_u_1:GetPlayers() do
		v_u_4.Selectable({ v9.DisplayName, v9 }, {
			["index"] = v6
		})
	end
	v_u_4.End()
	v_u_4.Combo({ "Currency Name" }, {
		["index"] = v7
	})
	for v10, v11 in v_u_3 do
		v_u_4.Selectable({ v11.Name, v10 }, {
			["index"] = v7
		})
	end
	v_u_4.Selectable({ "ALL", "ALL" }, {
		["index"] = v7
	})
	v_u_4.End()
	v_u_4.InputNum({
		"Currency Amount",
		1,
		0,
		nil,
		nil,
		true
	}, {
		["number"] = v8
	})
	v_u_4.Separator()
	v_u_4.SameLine()
	if v_u_4.Button({ "Give Currency" }).clicked() then
		p5.fire("Give", v6:get(), v7:get(), v8:get())
	end
	if v_u_4.Button({ "Set Currency" }).clicked() then
		p5.fire("Set", v6:get(), v7:get(), v8:get())
	end
	v_u_4.End()
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Currency]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3835"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

game:GetService("Players")
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.Constants)
local v_u_3 = require(v1.Packages.Iris)
return function(p4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v5 = v_u_3.State(0)
	if typeof(v5:get()) ~= "number" then
		v5:set(0)
	end
	v_u_3.InputNum({
		"Friends",
		1,
		0,
		v_u_2.MAX_FRIENDS,
		nil,
		true
	}, {
		["number"] = v5
	})
	v_u_3.Separator()
	v_u_3.SameLine()
	if v_u_3.Button({ "Set Friends" }).clicked() then
		p4.fire(v5:get())
	end
	v_u_3.End()
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Friends]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3836"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Packages.Iris)
local v_u_4 = {}
for v5 in v_u_2:getValue({ "__Presets" }) or {} do
	table.insert(v_u_4, v5)
end
v_u_2:onChange(function(_, p6, _, _)
	-- upvalues: (ref) v_u_4, (copy) v_u_2
	if p6[1] == "__Presets" then
		v_u_4 = {}
		for v7 in v_u_2:getValue({ "__Presets" }) or {} do
			local v8 = v_u_4
			table.insert(v8, v7)
		end
	end
end)
return function(p9)
	-- upvalues: (copy) v_u_3, (ref) v_u_4
	v_u_3.Text({ "Load Preset" })
	v_u_3.Separator()
	local v10 = v_u_3.State("")
	v_u_3.Combo({ "Presets" }, {
		["index"] = v10
	})
	for _, v11 in v_u_4 do
		v_u_3.Selectable({ v11, v11 }, {
			["index"] = v10
		})
	end
	v_u_3.End()
	if v_u_3.Button({ "Load" }).clicked() then
		p9.fire("Load", v10:get())
	end
	if v_u_3.Button({ "Delete" }).clicked() then
		p9.fire("Delete", v10:get())
	end
	v_u_3.Text({ "Save Preset (5 MAX)" })
	v_u_3.Separator()
	local v12 = v_u_3.State("")
	v_u_3.InputText({ "Preset Name" }, {
		["text"] = v12
	})
	if v_u_3.Button({ "Save" }).clicked() then
		p9.fire("Save", v12:get())
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Presets]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3837"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.Iris)
return function(p3)
	-- upvalues: (copy) v_u_2
	v_u_2.Text({ "You will lose everything if u do this!" })
	v_u_2.Separator()
	if v_u_2.Button({ "Reset Data" }).clicked() then
		p3.fire()
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ResetData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3838"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Config.RuneData)
local v_u_4 = require(v2.Packages.Iris)
return function(p5)
	-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_3
	local v6 = v_u_4.State(v_u_1.LocalPlayer)
	local v7 = v_u_4.State("ALL")
	local v8 = v_u_4.State(0)
	v_u_4.Combo({ "Selected Player" }, {
		["index"] = v6
	})
	for _, v9 in v_u_1:GetPlayers() do
		v_u_4.Selectable({ v9.DisplayName, v9 }, {
			["index"] = v6
		})
	end
	v_u_4.End()
	v_u_4.Combo({ "Rune Name" }, {
		["index"] = v7
	})
	for v10, v11 in v_u_3 do
		v_u_4.Selectable({ v11.Name, v10 }, {
			["index"] = v7
		})
	end
	v_u_4.Selectable({ "ALL", "ALL" }, {
		["index"] = v7
	})
	v_u_4.End()
	v_u_4.InputNum({
		"Amount",
		1,
		0,
		nil,
		nil,
		true
	}, {
		["number"] = v8
	})
	v_u_4.Separator()
	v_u_4.SameLine()
	if v_u_4.Button({ "Give Rune" }).clicked() then
		p5.fire("Give", v6:get(), v7:get(), v8:get())
	end
	if v_u_4.Button({ "Set Rune" }).clicked() then
		p5.fire("Set", v6:get(), v7:get(), v8:get())
	end
	v_u_4.End()
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Runes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3839"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = require(v2.Client.Data.DataController)
local v_u_4 = require(v2.Config.StatisticsData)
local v_u_5 = require(v2.Packages.Iris)
local v6 = {}
local v_u_7 = {}
for v_u_8, v_u_9 in v_u_4 do
	v6[v_u_9.Category] = v6[v_u_9.Category] or {}
	local v10 = v6[v_u_9.Category]
	table.insert(v10, v_u_8)
	v3:onSet({ "Statistics", v_u_8 }, function(p11)
		-- upvalues: (copy) v_u_7, (copy) v_u_8, (copy) v_u_9
		v_u_7[v_u_8] = p11 or v_u_9.Default
	end)
end
return function(p12)
	-- upvalues: (copy) v_u_5, (copy) v_u_1, (copy) v_u_4
	local v13 = v_u_5.State(v_u_1.LocalPlayer)
	local v14 = v_u_5.State("ALL")
	local v15 = v_u_5.State(0)
	v_u_5.Combo({ "Selected Player" }, {
		["index"] = v13
	})
	for _, v16 in v_u_1:GetPlayers() do
		v_u_5.Selectable({ v16.DisplayName, v16 }, {
			["index"] = v13
		})
	end
	v_u_5.End()
	v_u_5.Combo({ "Statistic" }, {
		["index"] = v14
	})
	for v17, v18 in v_u_4 do
		if not v18.Multiplier then
			v_u_5.Selectable({ v18.Name, v17 }, {
				["index"] = v14
			})
		end
	end
	v_u_5.Selectable({ "ALL", "ALL" }, {
		["index"] = v14
	})
	v_u_5.End()
	v_u_5.InputNum({
		"Amount",
		1,
		0,
		nil,
		nil,
		true
	}, {
		["number"] = v15
	})
	v_u_5.Separator()
	v_u_5.SameLine()
	if v_u_5.Button({ "Set Statistic" }).clicked() then
		p12.fire(v13:get(), v14:get(), v15:get())
	end
	v_u_5.End()
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Statistics]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3840"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

game:GetService("Players")
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.Iris)
return function(p3)
	-- upvalues: (copy) v_u_2
	v_u_2.Text({ "Teleport" })
	v_u_2.Separator()
	for _, v4 in workspace.Persistent.Teleports:GetChildren() do
		v_u_2.Tree({ v4.Name })
		for _, v5 in v4:GetChildren() do
			if v_u_2.Button({ v5.Name }).clicked() then
				p3.fire((("%*/%*"):format(v4.Name, v5.Name)))
			end
		end
		v_u_2.End()
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Teleport]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3841"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Enums.TestingPresetTypes)
local v_u_3 = require(v1.Packages.Iris)
return function(p4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	v_u_3.Text({ "This is to help with testing, select a preset to quickly get setup" })
	v_u_3.Separator()
	for _, v5 in v_u_2 do
		if v_u_3.Button({ v5 }).clicked() then
			p4.fire(v5)
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Testing]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3842"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Client.Gameplay.Upgrades.UpgradeBoardController)
local v_u_3 = require(v1.Config.UpgradeBoardData)
local v_u_4 = require(v1.Packages.Iris)
local v_u_5 = {}
local v_u_6 = {}
for v7, v8 in v_u_3 do
	if not v_u_5[v8.Board] then
		v_u_5[v8.Board] = {}
	end
	local v9 = v_u_5[v8.Board]
	table.insert(v9, v7)
end
for v10 in v_u_3 do
	v_u_6[v10] = v_u_4.State(v2:getLevel(v10) or 0)
end
return function(p11)
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_3
	v_u_4.Text({ "Edit Upgrade Boards" })
	v_u_4.Separator()
	for v12, v13 in v_u_5 do
		v_u_4.Tree({ v12 })
		for _, v14 in v13 do
			v_u_4.SameLine()
			local v15 = v_u_6[v14]
			local v16 = v_u_3[v14]
			if v_u_4.Image({ v16.Icon, UDim2.fromOffset(16, 16) }).hovered() then
				v_u_4.Tooltip({ v16.Description })
			end
			v_u_4.Text({ v16.Name })
			if v_u_4.Button({ "Set" }).clicked() then
				p11.fire(v14, v15:get())
			end
			local v17 = v_u_4.SliderNum({
				"",
				1,
				0,
				v16.MaxLevel
			}, {
				["number"] = v15
			})
			if v17.numberChanged() then
				v15:set(v17.state.number.value)
			end
			v_u_4.End()
		end
		v_u_4.End()
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UpgradeBoard]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3843"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Config.SkillData)
local v_u_4 = require(v1.Functions.CalculateSkillXP)
local v_u_5 = require(v1.Packages.Iris)
local v_u_6 = 0
local v_u_7 = {}
for _, v8 in v_u_3 do
	v_u_6 = v_u_6 + v8.Cost
	for v_u_9, v10 in v8.Upgrades do
		v_u_7[v_u_9] = v_u_5.State(0)
		v2:onSet({ "Skills", "Upgrades", v_u_9 }, function(p11)
			-- upvalues: (copy) v_u_7, (copy) v_u_9
			v_u_7[v_u_9]:set(p11 or 0)
		end)
		for _, v12 in v10.Levels do
			v_u_6 = v_u_6 + v12.Cost
		end
	end
end
local v_u_13 = v_u_5.State(v2:getValue({ "Skills", "Level" }))
local v_u_14 = v_u_5.State(0)
local v_u_15 = 0
v2:onSet({ "Skills", "Level" }, function(p16)
	-- upvalues: (copy) v_u_13, (ref) v_u_15
	v_u_13:set(p16 or 0)
	v_u_15 = p16 or 0
end)
return function(p17)
	-- upvalues: (copy) v_u_5, (copy) v_u_13, (ref) v_u_6, (copy) v_u_14, (copy) v_u_4, (ref) v_u_15, (copy) v_u_3, (copy) v_u_7
	v_u_5.Text({ "Edit Skills" })
	v_u_5.Separator()
	v_u_5.SameLine()
	v_u_5.Text({ "Set Level" })
	if v_u_5.Button({ "Set" }).clicked() then
		p17.fire("Level", v_u_13:get())
	end
	local v18 = {
		["number"] = v_u_13
	}
	local v19 = v_u_5.SliderNum({
		"",
		1,
		0,
		v_u_6
	}, v18)
	if v19.numberChanged() then
		v_u_13:set(v19.state.number.value)
	end
	v_u_5.End()
	v_u_5.SameLine()
	v_u_5.Text({ "Add XP" })
	if v_u_5.Button({ "Add" }).clicked() then
		p17.fire("XP", v_u_14:get())
	end
	local v20 = v_u_4(v_u_15 + 1)
	local v21 = {
		["number"] = v_u_14
	}
	local v22 = v_u_5.SliderNum({
		"",
		1,
		0,
		v20
	}, v21)
	if v22.numberChanged() then
		v_u_14:set(v22.state.number.value)
	end
	v_u_5.End()
	for _, v23 in v_u_3 do
		v_u_5.Tree({ v23.Name })
		for v24, v25 in v23.Upgrades do
			v_u_5.SameLine()
			local v26 = v_u_7[v24]
			v_u_5.Image({ v23.Icon, UDim2.fromOffset(16, 16) })
			v_u_5.Text({ v24 })
			if v_u_5.Button({ "Set" }).clicked() then
				p17.fire("Upgrade", v24, v26:get())
			end
			local v27 = v_u_5.SliderNum({
				"",
				1,
				0,
				#v25.Levels
			}, {
				["number"] = v26
			})
			if v27.numberChanged() then
				v26:set(v27.state.number.value)
			end
			v_u_5.End()
		end
		v_u_5.End()
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Skills]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3844"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Config.GloopData)
local v_u_4 = require(v2.Packages.Iris)
return function(p5)
	-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_3
	local v6 = v_u_4.State(v_u_1.LocalPlayer)
	local v7 = v_u_4.State("ALL")
	local v8 = v_u_4.State(0)
	v_u_4.Combo({ "Selected Player" }, {
		["index"] = v6
	})
	for _, v9 in v_u_1:GetPlayers() do
		v_u_4.Selectable({ v9.DisplayName, v9 }, {
			["index"] = v6
		})
	end
	v_u_4.End()
	v_u_4.Combo({ "Gloop Name" }, {
		["index"] = v7
	})
	for v10, v11 in v_u_3 do
		v_u_4.Selectable({ v11.Name, v10 }, {
			["index"] = v7
		})
	end
	v_u_4.Selectable({ "ALL", "ALL" }, {
		["index"] = v7
	})
	v_u_4.End()
	v_u_4.InputNum({
		"Gloop Amount",
		1,
		0,
		nil,
		nil,
		true
	}, {
		["number"] = v8
	})
	v_u_4.Separator()
	v_u_4.SameLine()
	if v_u_4.Button({ "Give Gloop" }).clicked() then
		p5.fire("Give", v6:get(), v7:get(), v8:get())
	end
	if v_u_4.Button({ "Set Gloop" }).clicked() then
		p5.fire("Set", v6:get(), v7:get(), v8:get())
	end
	v_u_4.End()
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Gloop]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3845"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.Iris)
return function(p3)
	-- upvalues: (copy) v_u_2
	local v4 = v_u_2.State("")
	local v5 = v_u_2.State(0)
	local v6 = v_u_2.State(0)
	v_u_2.Text({ "Experience Event RSVP Prompt" })
	v_u_2.Separator()
	v_u_2.InputText({ "Event ID" }, {
		["text"] = v4
	})
	v_u_2.InputNum({
		"Start Time (Unix)",
		1,
		0,
		nil,
		nil,
		true
	}, {
		["number"] = v5
	})
	v_u_2.InputNum({
		"End Time (Unix)",
		1,
		0,
		nil,
		nil,
		true
	}, {
		["number"] = v6
	})
	v_u_2.Separator()
	v_u_2.SameLine()
	if v_u_2.Button({ "Set Event Config" }).clicked() then
		p3.fire("Set", {
			["EventId"] = v4:get(),
			["StartTime"] = v5:get(),
			["EndTime"] = v6:get()
		})
	end
	if v_u_2.Button({ "Clear Event Config" }).clicked() then
		p3.fire("Clear")
	end
	v_u_2.End()
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ExperiencePrompt]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3846"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.CurrencyData)
local v_u_3 = require(v1.Packages.Iris)
return function(p4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v5 = v_u_3.State(0)
	local v6 = v_u_3.State("")
	local v7 = v_u_3.State(0)
	v_u_3.InputNum({
		"User ID",
		1,
		0,
		nil,
		nil,
		true
	}, {
		["number"] = v5
	})
	v_u_3.Combo({ "Currency Name" }, {
		["index"] = v6
	})
	for v8, v9 in v_u_2 do
		v_u_3.Selectable({ v9.Name, v8 }, {
			["index"] = v6
		})
	end
	v_u_3.End()
	v_u_3.InputNum({
		"Amount",
		1,
		0,
		nil,
		nil,
		true
	}, {
		["number"] = v7
	})
	v_u_3.Separator()
	if v_u_3.Button({ "Send Currency" }).clicked() then
		p4.fire(v5:get(), v6:get(), v7:get())
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GiftCurrency]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3847"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Enums.PetSlimeTypes)
local v_u_3 = require(v1.Enums.SlimeRaceTypes)
local v_u_4 = require(v1.Packages.Iris)
return function(p5)
	-- upvalues: (copy) v_u_4, (copy) v_u_2, (copy) v_u_3
	local v6 = v_u_4.State(nil)
	local v7 = v_u_4.State("None")
	local v8 = v_u_4.State(1)
	v_u_4.Combo({ "Pet Type" }, {
		["index"] = v6
	})
	for _, v9 in v_u_2 do
		v_u_4.Selectable({ v9, v9 }, {
			["index"] = v6
		})
	end
	v_u_4.End()
	v_u_4.Combo({ "Race Type" }, {
		["index"] = v7
	})
	v_u_4.Selectable({ "None", "None" }, {
		["index"] = v7
	})
	for _, v10 in v_u_3 do
		v_u_4.Selectable({ v10, v10 }, {
			["index"] = v7
		})
	end
	v_u_4.End()
	v_u_4.InputNum({
		"Pet Level",
		1,
		0,
		nil,
		nil,
		true
	}, {
		["number"] = v8
	})
	v_u_4.Separator()
	if v_u_4.Button({ "Spawn Pet" }).clicked() and v6:get() then
		p5.fire(v6:get(), v7:get(), v8:get())
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Pets]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3848"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.CandyData)
local v_u_3 = require(v1.Packages.Iris)
return function(p4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	v_u_3.Text({ "Fill zone gate progress and unlock a specific candy zone." })
	v_u_3.Separator()
	for v5, v6 in v_u_2.Zones do
		local v7 = ("Zone %*"):format(v5)
		if v6.killsRequired > 0 then
			v7 = v7 .. (" (%* kills)"):format(v6.killsRequired)
		end
		if v_u_3.Button({ v7 }).clicked() then
			p4.fire(v5)
		end
	end
	v_u_3.Separator()
	if v_u_3.Button({ "Unlock All Zones" }).clicked() then
		p4.fire("all")
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CandyZones]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3849"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Perks]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3850"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("SocialService")
local v_u_4 = require(v2.Config.Constants)
local v_u_5 = require(v2.Enums.MultiplierTypes)
local v_u_6 = require(v2.Packages.Observers)
local v_u_7 = require(v2.Utility.Multiplier)
local v_u_8 = require(v2.Utility.PerkUtil)
return {
	["init"] = function(_)
		-- upvalues: (copy) v_u_8, (copy) v_u_3, (copy) v_u_1, (copy) v_u_6, (copy) v_u_4, (copy) v_u_7, (copy) v_u_5
		v_u_8:add("friend_", {
			["Icon"] = "rbxassetid://108433089797795",
			["Text"] = "+0%",
			["Order"] = -1,
			["Callback"] = function()
				-- upvalues: (ref) v_u_3, (ref) v_u_1
				local v9, v10 = pcall(function()
					-- upvalues: (ref) v_u_3, (ref) v_u_1
					return v_u_3:CanSendGameInviteAsync(v_u_1.LocalPlayer)
				end)
				if v9 and v10 then
					v_u_3:PromptGameInvite(v_u_1.LocalPlayer)
				end
			end
		})
		v_u_6.observeAttribute(v_u_1.LocalPlayer, "Friends", function(p11)
			-- upvalues: (ref) v_u_4, (ref) v_u_8
			local v12 = v_u_4.PERCENT_PER_FRIEND
			local v13 = v_u_4.MAX_FRIENDS
			local v14 = v12 * math.min(p11, v13) * 100
			local v15 = math.floor(v14) / 100
			local v16 = v_u_8
			local v17 = {
				["Icon"] = "rbxassetid://108433089797795",
				["Text"] = ("x%*"):format(v15),
				["Order"] = -1,
				["Tooltip"] = {
					["Title"] = "Friend Boost!",
					["Description"] = ("x%* Luck Boost!\nClick to invite!"):format(v15)
				}
			}
			v16:update("friend_", v17)
		end)
		v_u_7.assign(v_u_5.RuneLuckMultiplier, function()
			-- upvalues: (ref) v_u_1, (ref) v_u_4
			local v18 = v_u_1.LocalPlayer:GetAttribute("Friends")
			if v18 and v18 > 0 then
				return 1 + v18 * v_u_4.PERCENT_PER_FRIEND
			end
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[FriendController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3851"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("MarketplaceService")
local v_u_2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = require(v3.Config.Constants)
local v_u_5 = require(v3.Enums.MultiplierTypes)
local v_u_6 = require(v3.Packages.Observers)
local v_u_7 = require(v3.Utility.Multiplier)
local v_u_8 = require(v3.Utility.PerkUtil)
return {
	["init"] = function(_)
		-- upvalues: (copy) v_u_8, (copy) v_u_4, (copy) v_u_2, (copy) v_u_1, (copy) v_u_7, (copy) v_u_5, (copy) v_u_6
		local v9 = v_u_8
		local v10 = {
			["Icon"] = "rbxassetid://137621895282584",
			["Text"] = "+0%",
			["Order"] = -2,
			["Tooltip"] = {
				["Title"] = "Premium Boost!",
				["Description"] = ("Purchase to get +%*%% Luck Boost!"):format(v_u_4.PREMIUM_BOOST * 100)
			},
			["Callback"] = function()
				-- upvalues: (ref) v_u_2, (ref) v_u_1
				if v_u_2.LocalPlayer.MembershipType ~= Enum.MembershipType.Premium then
					v_u_1:PromptPremiumPurchase(v_u_2.LocalPlayer)
				end
			end
		}
		v9:add("premium_", v10)
		if v_u_2.LocalPlayer.MembershipType == Enum.MembershipType.Premium then
			local v11 = v_u_8
			local v12 = {
				["Icon"] = "rbxassetid://137621895282584",
				["Text"] = ("+%*%%"):format(v_u_4.PREMIUM_BOOST * 100),
				["Order"] = -2,
				["Tooltip"] = {
					["Title"] = "Premium Boost!",
					["Description"] = ("+%*%% Luck Boost!"):format(v_u_4.PREMIUM_BOOST * 100)
				}
			}
			v11:update("premium_", v12)
		end
		v_u_7.assign(v_u_5.RuneLuck, function()
			-- upvalues: (ref) v_u_2, (ref) v_u_4
			return v_u_2.LocalPlayer.MembershipType == Enum.MembershipType.Premium and v_u_4.PREMIUM_BOOST or nil
		end)
		v_u_6.observeAttribute(v_u_2.LocalPlayer, "Premium", function(p13)
			-- upvalues: (ref) v_u_8, (ref) v_u_4
			if p13 then
				local v14 = v_u_8
				local v15 = {
					["Icon"] = "rbxassetid://137621895282584",
					["Text"] = ("+%*%%"):format(v_u_4.PREMIUM_BOOST * 100),
					["Order"] = -2,
					["Tooltip"] = {
						["Title"] = "Premium Boost!",
						["Description"] = ("+%*%% Luck Boost!"):format(v_u_4.PREMIUM_BOOST * 100)
					}
				}
				v14:update("premium_", v15)
			end
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PremiumController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3852"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Misc]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3853"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Enums.MultiplierTypes)
local v3 = require(v1.Packages.Signal)
local v_u_4 = require(v1.Utility.Multiplier)
local v5 = require(v1.Utility.Network)
local v6 = {
	["OnTimerUpdated"] = v3.new(),
	["OnLuckUpdated"] = v3.new(),
	["Luck"] = 1,
	["Timer"] = 0
}
local v_u_7 = v5.remoteEvent("ServerLuckTimerUpdate")
local v_u_8 = v5.remoteEvent("ServerLuckUpdate")
local v_u_9 = v5.remoteFunction("ServerLuckInital")
function v6.observeTimer(p10, p11)
	p11(p10.Timer)
	return p10.OnTimerUpdated:Connect(p11)
end
function v6.observeLuck(p12, p13)
	p13(p12.Luck)
	return p12.OnLuckUpdated:Connect(p13)
end
function v6.init(p_u_14)
	-- upvalues: (copy) v_u_7, (copy) v_u_8, (copy) v_u_9, (copy) v_u_4, (copy) v_u_2
	v_u_7.listen(function(p15)
		-- upvalues: (copy) p_u_14
		p_u_14.Timer = p15
		p_u_14.OnTimerUpdated:Fire(p_u_14.Timer)
	end)
	v_u_8.listen(function(p16)
		-- upvalues: (copy) p_u_14
		p_u_14.Luck = p16
		p_u_14.OnLuckUpdated:Fire(p_u_14.Luck)
	end)
	local v17 = v_u_9.invoke()
	p_u_14.Luck = v17.Luck or 1
	p_u_14.Timer = v17.Timer or 0
	p_u_14.OnTimerUpdated:Fire(p_u_14.Timer)
	p_u_14.OnLuckUpdated:Fire(p_u_14.Luck)
	v_u_4.assign(v_u_2.RuneLuckMultiplier, function(_)
		-- upvalues: (copy) p_u_14
		return p_u_14.Luck
	end)
end
return v6]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ServerLuckController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3854"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["init"] = function(_) end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MultiplierProductController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3855"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = require(v1.Client.Data.DataController)
local v_u_4 = require(v1.Config.Constants)
local v_u_5 = require(v1.Config.OnboardingSteps)
local v_u_6 = require(v1.Enums.LockTypes)
local v_u_7 = require(v1.Utility.LockUtil)
local v_u_8 = require(v1.Utility.Sound)
local v_u_9 = require(v1.Utility.UI)
local v10 = {}
local v_u_11 = nil
local v_u_12 = false
local v_u_13 = nil
local v_u_14 = v_u_9:get("Persistent", "Onboarding")
function v10.update(_)
	-- upvalues: (copy) v_u_3, (ref) v_u_11, (copy) v_u_8, (ref) v_u_12, (copy) v_u_9, (copy) v_u_14, (copy) v_u_5
	local v15 = v_u_3:getValue({ "Onboarding", "Step" })
	local v16 = v_u_3:getValue({ "Onboarding", "Completed" })
	if v_u_11 then
		v_u_11()
		v_u_11 = nil
		v_u_8.play("OnboardingStepComplete")
	end
	if v16 then
		if not v_u_12 then
			v_u_12 = true
			v_u_9:unlock()
			v_u_9:setHUD()
			v_u_14.Enabled = false
		end
	else
		v_u_14.Enabled = true
		v_u_9:setHUD({})
		v_u_9:lock()
		if v_u_5[v15] and v_u_5[v15].Client then
			v_u_11 = v_u_5[v15]:Client()
		end
		return
	end
end
function v10.init(p_u_17)
	-- upvalues: (copy) v_u_7, (copy) v_u_6, (copy) v_u_3, (copy) v_u_2, (copy) v_u_4, (copy) v_u_14, (ref) v_u_13
	v_u_7.assign(v_u_6.Onboarding, function(_, _)
		-- upvalues: (ref) v_u_3
		return v_u_3:getValue({ "Onboarding", "Completed" }), "Please complete onboarding"
	end)
	if v_u_2:IsStudio() and v_u_4.DEBUG_MODE.ONBOARDING == false then
		v_u_14.Enabled = false
	else
		v_u_3:onSet({ "Onboarding", "Step" }, function(p18)
			-- upvalues: (ref) v_u_13, (copy) p_u_17
			if not v_u_13 then
				v_u_13 = p18
			end
			p_u_17:update()
		end)
		v_u_3:onSet({ "Onboarding", "Completed" }, function(p19)
			-- upvalues: (copy) p_u_17
			if p19 then
				p_u_17:update()
			end
		end)
	end
end
return v10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[OnboardingController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3856"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Debris")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = require(v2.Client.Data.DataController)
local v_u_5 = require(v2.Config.ItemData)
local v_u_6 = require(v2.Config.SecretTokenData)
local v_u_7 = require(v2.Packages.Observers)
local v8 = require(v2.Utility.Network)
require(v2.Utility.Spring)
local v9 = {}
local v_u_10 = v8.remoteEvent("SecretTokenClaimed")
local v_u_11 = {}
function v9.setup(_, p_u_12)
	-- upvalues: (copy) v_u_6, (copy) v_u_5, (copy) v_u_11, (copy) v_u_3, (copy) v_u_1, (copy) v_u_4
	local v_u_13 = p_u_12.Name
	local v_u_14 = v_u_6[v_u_13]
	if v_u_14 then
		local v15 = v_u_5[v_u_14.Reward.ItemType]
		if v15 then
			local v16 = v15[v_u_14.Reward.Key] or v15
			if v16 then
				for _, v17 in p_u_12:GetChildren() do
					if v17:IsA("Decal") then
						v17.Texture = v16.Icon
					end
				end
				p_u_12.Color = v16.Color or p_u_12.Color
				v_u_11[v_u_13] = {
					["hide"] = function()
						-- upvalues: (copy) p_u_12
						p_u_12.Transparency = 0.5
						for _, v18 in p_u_12:GetChildren() do
							if v18:IsA("Decal") then
								v18.Transparency = 0.5
							end
						end
					end,
					["show"] = function()
						-- upvalues: (copy) p_u_12
						p_u_12.Transparency = 0
						for _, v19 in p_u_12:GetChildren() do
							if v19:IsA("Decal") then
								v19.Transparency = 0
							end
						end
					end,
					["pickup"] = function(p20)
						-- upvalues: (copy) p_u_12, (ref) v_u_3, (ref) v_u_1
						local v21 = p_u_12:Clone()
						v21:RemoveTag("SecretToken")
						v21.Parent = workspace
						p20:hide()
						local v22 = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
						local v23 = v_u_3:Create(v21, v22, {
							["Size"] = v21.Size * 3,
							["Transparency"] = 1
						})
						for _, v24 in v21:GetChildren() do
							if v24:IsA("Decal") then
								v_u_3:Create(v24, v22, {
									["Transparency"] = 1
								}):Play()
							end
						end
						v23:Play()
						v_u_1:AddItem(v21, 2)
					end
				}
				local v_u_25 = nil
				v_u_4:onSet({ "SecretTokens", v_u_13 }, function(p26)
					-- upvalues: (ref) v_u_25, (copy) v_u_14, (ref) v_u_11, (copy) v_u_13
					if v_u_25 then
						task.cancel(v_u_25)
					end
					if p26 and v_u_14.OneTime then
						v_u_11[v_u_13].hide()
						return
					elseif p26 and v_u_14.Cooldown then
						local v27 = v_u_14.Cooldown - (workspace:GetServerTimeNow() - p26)
						v_u_11[v_u_13].hide()
						v_u_25 = task.delay(v27, function()
							-- upvalues: (ref) v_u_11, (ref) v_u_13
							v_u_11[v_u_13].show()
						end)
					else
						v_u_11[v_u_13].show()
					end
				end)
			else
				p_u_12:Destroy()
			end
		else
			p_u_12:Destroy()
			return
		end
	else
		p_u_12:Destroy()
		return
	end
end
function v9.init(p_u_28)
	-- upvalues: (copy) v_u_7, (copy) v_u_10, (copy) v_u_11
	v_u_7.observeTag("SecretToken", function(p29)
		-- upvalues: (copy) p_u_28
		p_u_28:setup(p29)
	end)
	v_u_10.listen(function(p30)
		-- upvalues: (ref) v_u_11
		if v_u_11[p30] then
			v_u_11[p30]:pickup()
		end
	end)
end
return v9]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SecretTokenController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3857"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("AvatarEditorService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = {}
local v_u_4 = require(v2.Packages.Topbarplus).new()
v_u_4:setRight()
v_u_4:setImage("rbxassetid://84163588806091")
v_u_4.selected:Connect(function()
	-- upvalues: (copy) v_u_1, (copy) v_u_4
	pcall(function(...)
		-- upvalues: (ref) v_u_1
		v_u_1:PromptSetFavorite(game.PlaceId, 1, true)
	end)
	v_u_4:deselect()
end)
function v3.init(_) end
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[FavouriteController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3858"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v_u_2 = require(v1.Enums.CurrencyTypes)
local v_u_3 = require(v1.Enums.LockTypes)
local v_u_4 = require(v1.Enums.MultiplierTypes)
local v_u_5 = require(v1.Utility.Format)
local v_u_6 = require(v1.Utility.LockUtil)
local v_u_7 = require(v1.Utility.Multiplier)
local v8 = require(v1.Utility.Network)
local v_u_9 = require(v1.Functions.NumberIndicator)
local v10 = require(v1.Functions.WaitFor)
local v_u_11 = require(v1.Utility.Spring)
local v12 = {}
local v_u_13 = v10(workspace, "Persistent", "CONFETTI_PART")
local v_u_14 = v10(v_u_13, "SurfaceGui")
local v_u_15 = v10(v_u_14, "Click")
local v_u_16 = v10(v_u_15, "UIScale")
local v_u_17 = v10(v_u_14, "Amount")
local v_u_18 = v8.remoteEvent("ConfettiClickEvent")
local v_u_19 = v8.remoteEvent("ConfettiVisualEvent")
TweenInfo.new(0.08, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v_u_20 = Color3.fromRGB(255, 215, 0)
local v_u_21 = Color3.fromRGB(81, 235, 255)
local function v_u_30(p22, p23)
	-- upvalues: (copy) v_u_13, (copy) v_u_9, (copy) v_u_2, (copy) v_u_5, (copy) v_u_20, (copy) v_u_21
	local v24 = v_u_13
	if v24:IsA("BasePart") then
		local v25 = v24.Position
		local v26 = math.random(-2, 2)
		local v27 = math.random(1, 3)
		local v28 = math.random
		local v29 = Vector3.new(v26, v27, v28(-2, 2))
		v_u_9({
			["Currency"] = v_u_2.Event1MConfetti,
			["Value"] = (p23 and "CRIT! +" or "+") .. v_u_5.abbreviateComma(p22),
			["StartPosition"] = v25 + Vector3.new(0, 3, 0) + v29,
			["EndPosition"] = v25 + Vector3.new(0, 7, 0) + v29,
			["Duration"] = p23 and 1.2 or 0.8,
			["Color"] = p23 and v_u_20 or v_u_21
		})
	end
end
function v12.init(_)
	-- upvalues: (copy) v_u_6, (copy) v_u_3, (copy) v_u_14, (copy) v_u_15, (copy) v_u_18, (copy) v_u_11, (copy) v_u_16, (copy) v_u_19, (copy) v_u_30, (copy) v_u_7, (copy) v_u_4, (copy) v_u_17, (copy) v_u_5
	local v31 = v_u_6.observe
	local v32 = {
		[v_u_3.Milestone] = {
			["value"] = "Confetti"
		}
	}
	v31(v32, function(p33)
		-- upvalues: (ref) v_u_14
		v_u_14.Enabled = not p33
	end)
	v_u_15.Activated:Connect(function()
		-- upvalues: (ref) v_u_18, (ref) v_u_11, (ref) v_u_16
		v_u_18.fire()
		v_u_11.stop(v_u_16)
		v_u_16.Scale = 0.9
		v_u_11.target(v_u_16, 0.5, 5, {
			["Scale"] = 1
		})
	end)
	v_u_19.listen(function(p34, p35)
		-- upvalues: (ref) v_u_30
		v_u_30(p34, p35)
	end)
	v_u_7.observe(v_u_4.ConfettiBaseValue, function()
		-- upvalues: (ref) v_u_7, (ref) v_u_4, (ref) v_u_17, (ref) v_u_5
		local v36 = v_u_7.get(v_u_4.ConfettiBaseValue) * v_u_7.get(v_u_4.ConfettiMultiplier)
		local v37 = math.floor(v36)
		v_u_17.Text = ("+%*"):format((v_u_5.abbreviateComma((math.max(v37, 1)))))
	end)
	v_u_7.observe(v_u_4.ConfettiMultiplier, function()
		-- upvalues: (ref) v_u_7, (ref) v_u_4, (ref) v_u_17, (ref) v_u_5
		local v38 = v_u_7.get(v_u_4.ConfettiBaseValue) * v_u_7.get(v_u_4.ConfettiMultiplier)
		local v39 = math.floor(v38)
		v_u_17.Text = ("+%*"):format((v_u_5.abbreviateComma((math.max(v39, 1)))))
	end)
end
return v12]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ConfettiController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3859"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Enums.LockTypes)
local v_u_3 = require(v1.Utility.Firework)
local v_u_4 = require(v1.Utility.LockUtil)
local v5 = require(v1.Utility.Network)
local v6 = require(v1.Functions.WaitFor)
local v7 = {}
local v8 = v6(workspace, "Persistent", "FIREWORK")
local v_u_9 = v6(v8, "LAUNCHERS")
local v_u_10 = v6(v8, "BUTTON")
local v_u_11 = v5.remoteFunction("FireworkBlessing/press")
local function v_u_13()
	-- upvalues: (copy) v_u_9, (copy) v_u_3
	for _, v12 in v_u_9:GetChildren() do
		if v12:IsA("BasePart") then
			v_u_3.launch(v12.CFrame, v12)
			task.wait(0.1)
		end
	end
end
function v7.init(_)
	-- upvalues: (copy) v_u_10, (copy) v_u_4, (copy) v_u_2, (copy) v_u_11, (copy) v_u_13
	local v_u_14 = Instance.new("ProximityPrompt")
	v_u_14.ActionText = "Launch"
	v_u_14.ObjectText = "Fireworks"
	v_u_14.HoldDuration = 0
	v_u_14.MaxActivationDistance = 10
	v_u_14.RequiresLineOfSight = false
	v_u_14.Enabled = false
	v_u_14.Parent = v_u_10
	local v15 = v_u_4.observe
	local v16 = {
		[v_u_2.Milestone] = {
			["value"] = "Firework"
		}
	}
	v15(v16, function(p17)
		-- upvalues: (copy) v_u_14
		v_u_14.Enabled = not p17
	end)
	v_u_14.Triggered:Connect(function()
		-- upvalues: (ref) v_u_11, (ref) v_u_13
		if v_u_11:invoke() then
			v_u_13()
		end
	end)
end
return v7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[FireworkController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3860"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("SocialService")
local v3 = {}
local v_u_4 = require(v1.Utility.Network).remoteEvent("ExperiencePrompt")
function v3.init(_)
	-- upvalues: (copy) v_u_4, (copy) v_u_2
	v_u_4.listen(function(p_u_5)
		-- upvalues: (ref) v_u_2
		local v6, v7 = pcall(function()
			-- upvalues: (ref) v_u_2, (copy) p_u_5
			return v_u_2:GetEventRsvpStatusAsync(p_u_5.EventId)
		end)
		if v6 and v7 ~= Enum.RsvpStatus.Going then
			pcall(function()
				-- upvalues: (ref) v_u_2, (copy) p_u_5
				v_u_2:PromptRsvpToEventAsync(p_u_5.EventId)
			end)
		end
	end)
end
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ExperiencePromptController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3861"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["init"] = function(_) end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ConfigController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3862"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Daily]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3863"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.DataController)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = require(v1.Utility.Multiplier)
local v_u_5 = require(v1.Utility.PerkUtil)
local v_u_6 = require(v1.Utility.UI)
local v7 = {}
local v_u_8 = 1
function v7.getLostDay(_)
	-- upvalues: (copy) v_u_2
	return v_u_2:getValue({ "Streak", "Lost" }) or 1
end
v_u_2:onSet({ "Streak", "Current" }, function(p9)
	-- upvalues: (ref) v_u_8, (copy) v_u_5
	v_u_8 = p9
	local v10 = v_u_5
	local v11 = 0
	local v12 = "+%*"
	local v13 = {}
	local v14 = "Streak"
	for v15 = 1, math.min(p9, 365) do
		if v15 % 7 == 0 then
			v11 = v11 + 10
		else
			v11 = v11 + 1
		end
	end
	v13.Text = v12:format(v11)
	v13.Icon = "rbxassetid://92458066679384"
	v13.Tooltip = {
		["Title"] = ("Daily Streak (%*)"):format(p9),
		["Description"] = "+1 Rune Bulk per day. \n+10 Rune Bulk every 7th day!"
	}
	v10:update(v14, v13)
end)
v_u_2:onSet({ "Streak", "Lost" }, function(p16)
	-- upvalues: (copy) v_u_6
	if p16 then
		v_u_6:queue("Streak")
	end
end)
v4.assign(v3.RuneBulk, function(_)
	-- upvalues: (ref) v_u_8
	local v17 = v_u_8
	local v18 = 0
	for v19 = 1, math.min(v17, 365) do
		if v19 % 7 == 0 then
			v18 = v18 + 10
		else
			v18 = v18 + 1
		end
	end
	return v18
end)
return v7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[StreakController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3864"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Leaderboard]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3865"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Config.Constants)
local v_u_4 = require(v2.Functions.WaitFor)
local v_u_5 = require(v2.Packages.Observers)
local v_u_6 = require(v2.Utility.Time)
local v7 = {}
local v8 = workspace:WaitForChild("Persistent")
local v_u_9 = v8:WaitForChild("HIGHESTROUND_LEADERBOARD_TIMER")
local v_u_10 = v8:WaitForChild("MOSTHEARTS_LEADERBOARD_TIMER")
local v_u_11 = v8:WaitForChild("MOSTBALLOONS_LEADERBOARD_TIMER")
local v_u_12 = DateTime.fromUniversalTime(2026, 2, 14, 0, 0, 0).UnixTimestamp
local v_u_13 = DateTime.fromUniversalTime(2026, 3, 8, 0, 0, 0).UnixTimestamp
function v7.init(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_3, (copy) v_u_6, (copy) v_u_10, (copy) v_u_12, (copy) v_u_11, (copy) v_u_13, (copy) v_u_4, (copy) v_u_1, (copy) v_u_5
	local v_u_14 = v_u_9:WaitForChild("SurfaceGui"):WaitForChild("Timer")
	task.spawn(function()
		-- upvalues: (ref) v_u_3, (copy) v_u_14, (ref) v_u_6
		while true do
			local v15 = workspace:GetServerTimeNow()
			local v16
			if v_u_3.DEBUG_MODE.WEEKLY_LB_TEST then
				v16 = v15 - v15 % 60
			else
				local v17 = v15 / v_u_3.DAILY_TIME
				v16 = v15 - ((math.floor(v17) + 4) % 7 - 5) % 7 * v_u_3.DAILY_TIME - v15 % v_u_3.DAILY_TIME
			end
			local v18 = v16 + v_u_3.WEEKLY_TIME - v15
			local v19 = math.max(0, v18)
			v_u_14.Text = v_u_6.format(v19)
			task.wait(1)
		end
	end)
	local v20 = v_u_10:WaitForChild("SurfaceGui")
	local v_u_21 = v20:WaitForChild("Timer")
	local v_u_22 = v20:WaitForChild("TopText")
	local v_u_23 = v20:WaitForChild("BottomText")
	task.spawn(function()
		-- upvalues: (ref) v_u_12, (copy) v_u_21, (ref) v_u_6, (copy) v_u_22, (copy) v_u_23
		local v24 = v_u_12 - DateTime.now().UnixTimestamp
		local v25 = math.floor(v24)
		if v25 > 0 then
			for v26 = math.floor(v25), 0, -1 do
				v_u_21.Text = v_u_6.formatToString(v26)
				task.wait(1)
			end
		end
		v_u_22.Text = "Leaderboard will no longer update!"
		v_u_21.Text = "Ended!"
		v_u_23.Text = "Leaderboard Ended on February 14, 2026"
	end)
	local v27 = v_u_11:WaitForChild("SurfaceGui")
	local v_u_28 = v27:WaitForChild("Timer")
	local v_u_29 = v27:WaitForChild("TopText")
	local v_u_30 = v27:WaitForChild("BottomText")
	v_u_30.Text = "Leaderboard Ends on March 8, 2026"
	task.spawn(function()
		-- upvalues: (ref) v_u_13, (copy) v_u_28, (ref) v_u_6, (copy) v_u_29, (copy) v_u_30
		local v31 = v_u_13 - DateTime.now().UnixTimestamp
		local v32 = math.floor(v31)
		if v32 > 0 then
			for v33 = math.floor(v32), 0, -1 do
				v_u_28.Text = v_u_6.formatToString(v33)
				task.wait(1)
			end
		end
		v_u_29.Text = "Leaderboard will no longer update!"
		v_u_28.Text = "Ended!"
		v_u_30.Text = "Leaderboard Ended on March 8, 2026"
	end)
	local v_u_34 = v_u_4(v_u_1.LocalPlayer, "PlayerGui")
	v_u_5.observeTag("Leaderboard", function(p35)
		-- upvalues: (copy) v_u_34
		p35.Adornee = p35.Parent
		p35.Parent = v_u_34
	end)
end
return v7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LeaderboardController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3866"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Config]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3867"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Blue"] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 229, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 164, 255)) }),
		["Stroke"] = Color3.fromRGB(36, 108, 159)
	},
	["Red"] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 44, 90)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
		["Stroke"] = Color3.fromRGB(154, 5, 13)
	},
	["Green"] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(179, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(13, 255, 0)) }),
		["Stroke"] = Color3.fromRGB(20, 126, 1)
	},
	["Purple"] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(222, 57, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(146, 56, 255)) }),
		["Stroke"] = Color3.fromRGB(108, 36, 159)
	},
	["Orange"] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 183, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 122, 61)) }),
		["Stroke"] = Color3.fromRGB(106, 52, 23)
	},
	["Yellow"] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 247, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 182, 12)) }),
		["Stroke"] = Color3.fromRGB(144, 105, 8)
	},
	["Rainbow"] = {
		["Gradient"] = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 127, 0)),
			ColorSequenceKeypoint.new(0.34, Color3.fromRGB(255, 255, 0)),
			ColorSequenceKeypoint.new(0.51, Color3.fromRGB(0, 255, 0)),
			ColorSequenceKeypoint.new(0.68, Color3.fromRGB(0, 0, 255)),
			ColorSequenceKeypoint.new(0.85, Color3.fromRGB(75, 0, 130)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(148, 0, 211))
		}),
		["Stroke"] = Color3.fromRGB(255, 255, 255)
	},
	["Grey"] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 200, 200)), ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 100)) }),
		["Stroke"] = Color3.fromRGB(50, 50, 50)
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Colors]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3868"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("RunService")
local v2 = {
	["GROUP_ID"] = 1021277016,
	["DEV_PLACE_ID"] = 78833908650412
}
v2.IS_DEV = v2.DEV_PLACE_ID == game.PlaceId
v2.ADMINS = { 6515523, 90351039 }
v2.DEBUG_MODE = {
	["LOADER"] = false,
	["MOCK"] = false,
	["UI"] = false,
	["MULTIPLIER"] = false,
	["ONBOARDING"] = true,
	["LOCKED"] = false,
	["WEEKLY_LB_TEST"] = false,
	["DISABLE_GAMEPASSES"] = true,
	["PRICE_CHECK"] = true
}
v2.STARTER_PACK_DURATION = 10
v2.SKILL_LEVEL_CAP = 999
v2.TOKEN_TIME_INTERVAL = 300
v2.PERCENT_PER_FRIEND = 0.05
v2.MAX_FRIENDS = 5
v2.PREMIUM_BOOST = 0.1
v2.AUTO_REJOIN_TIME = 1080
v2.REBIRTH_AMOUNT = 1000
v2.DAILY_TIME = 86400
v2.WEEKLY_TIME = 604800
v2.RUNE_SPEED_CAP = 0.1
v2.LUCKY_BLOCK_TIMER = 300
v2.COMBO_MULTIPLIER = 0.05
v2.GLOOP_CRAFT_TIME = 120
v2.FREE_SHARD_TIME = 43200
v2.PET_LEVEL_CAP = 200
if not v1:IsStudio() then
	v2.DEBUG_MODE = {}
end
return v2]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Constants]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3869"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v21 = {
	[v2.Tokens] = {
		["Name"] = "Tickets",
		["Icon"] = "rbxassetid://125936954620744",
		["Description"] = "Tickets",
		["Default"] = 0,
		["Order"] = 0,
		["Color"] = Color3.fromRGB(255, 215, 0),
		["IgnoreSuperRebirth"] = true,
		["GetPrefix"] = function(p4)
			return p4 > 1 and "Tickets" or "Ticket"
		end
	},
	[v2.Coins] = {
		["Name"] = "Coins",
		["Icon"] = "rbxassetid://70754291488761",
		["Description"] = "Coins",
		["Default"] = 0,
		["Order"] = 1,
		["Color"] = Color3.fromRGB(255, 223, 0),
		["multiplier"] = v3.CoinsMultiplier,
		["GetPrefix"] = function(p5)
			return p5 > 1 and "Coins" or "Coin"
		end
	},
	[v2.Rebirth] = {
		["Name"] = "Rebirths",
		["Icon"] = "rbxassetid://87974431889658",
		["Description"] = "Rebirths",
		["Default"] = 0,
		["Order"] = 2,
		["Color"] = Color3.fromRGB(255, 108, 223),
		["GetPrefix"] = function(p6)
			return p6 > 1 and "Rebirths" or "Rebirth"
		end
	},
	[v2.SkillPoints] = {
		["Name"] = "Skill Points",
		["Icon"] = "rbxassetid://117536958707712",
		["Description"] = "Skill Points",
		["Default"] = 0,
		["Order"] = 3,
		["Color"] = Color3.fromRGB(185, 100, 255),
		["IgnoreSuperRebirth"] = true,
		["GetPrefix"] = function(p7)
			return p7 > 1 and "Skill Points" or "Skill Point"
		end
	},
	[v2.Shards] = {
		["Name"] = "Shards",
		["Icon"] = "rbxassetid://129297197332278",
		["Description"] = "Shards",
		["Default"] = 0,
		["Order"] = 12,
		["Color"] = Color3.fromRGB(170, 66, 255),
		["IgnoreSuperRebirth"] = true,
		["GetPrefix"] = function(p8)
			return p8 > 1 and "Shards" or "Shard"
		end
	},
	[v2.FireCoins] = {
		["Name"] = "Fire Coins",
		["Icon"] = "rbxassetid://113801335212128",
		["Description"] = "Fire Coins",
		["Default"] = 0,
		["Order"] = 4,
		["Color"] = Color3.fromRGB(255, 85, 0),
		["multiplier"] = v3.FireCoinsMultiplier,
		["GetPrefix"] = function(p9)
			return p9 > 1 and "Fire Coins" or "Fire Coin"
		end
	},
	[v2.IceCoins] = {
		["Name"] = "Ice Coins",
		["Icon"] = "rbxassetid://94836897629836",
		["Description"] = "Ice Coins",
		["Default"] = 0,
		["Order"] = 6,
		["Color"] = Color3.fromRGB(0, 170, 255),
		["multiplier"] = v3.IceCoinsMultiplier,
		["GetPrefix"] = function(p10)
			return p10 > 1 and "Ice Coins" or "Ice Coin"
		end
	},
	[v2.GlowCoins] = {
		["Name"] = "Glow Coins",
		["Icon"] = "rbxassetid://85479817882405",
		["Description"] = "Glow Coins",
		["Default"] = 0,
		["Order"] = 7,
		["Color"] = Color3.fromRGB(79, 255, 72),
		["multiplier"] = v3.GlowCoinsMultiplier,
		["GetPrefix"] = function(p11)
			return p11 > 1 and "Glow Coins" or "Glow Coin"
		end
	},
	[v2.CandyCoins] = {
		["Name"] = "Candy Coins",
		["Icon"] = "rbxassetid://107119582007802",
		["Description"] = "Candy Coins",
		["Default"] = 0,
		["Order"] = 8,
		["Color"] = Color3.fromRGB(255, 105, 180),
		["multiplier"] = v3.CandyCoinsMultiplier,
		["GetPrefix"] = function(p12)
			return p12 > 1 and "Candy Coins" or "Candy Coin"
		end
	},
	[v2.SuperRebirth] = {
		["Name"] = "Super Rebirths",
		["Icon"] = "rbxassetid://128040547576532",
		["Description"] = "Super Rebirths",
		["Default"] = 0,
		["Order"] = 7,
		["Color"] = Color3.fromRGB(255, 50, 200),
		["IgnoreSuperRebirth"] = true,
		["GetPrefix"] = function(p13)
			return p13 > 1 and "Super Rebirths" or "Super Rebirth"
		end
	},
	[v2.Hearts] = {
		["Name"] = "Hearts",
		["Icon"] = "rbxassetid://96022333579405",
		["Description"] = "Hearts",
		["Default"] = 0,
		["Order"] = 8,
		["Color"] = Color3.fromRGB(255, 0, 0),
		["IgnoreSuperRebirth"] = true,
		["multiplier"] = v3.HeartsMultiplier,
		["GetPrefix"] = function(p14)
			return p14 > 1 and "Hearts" or "Heart"
		end
	},
	[v2.CrystalHearts] = {
		["Name"] = "Crystal Hearts",
		["Icon"] = "rbxassetid://125560393739137",
		["Description"] = "Crystal Hearts",
		["Default"] = 0,
		["Order"] = 9,
		["Color"] = Color3.fromRGB(255, 43, 43),
		["IgnoreSuperRebirth"] = true,
		["GetPrefix"] = function(p15)
			return p15 > 1 and "Crystal Hearts" or "Crystal Heart"
		end
	},
	[v2.SkillResetTickets] = {
		["Name"] = "Skill Reset Tickets",
		["Icon"] = "rbxassetid://71509793008093",
		["Description"] = "Skill Reset Tickets",
		["Default"] = 0,
		["Order"] = 10,
		["Color"] = Color3.fromRGB(185, 100, 255),
		["IgnoreSuperRebirth"] = true,
		["GetPrefix"] = function(p16)
			return p16 > 1 and "Skill Reset Tickets" or "Skill Reset Ticket"
		end
	},
	[v2.Event1MBalloon] = {
		["Name"] = "Balloons",
		["Icon"] = "rbxassetid://87434791157715",
		["Description"] = "Balloons",
		["Default"] = 0,
		["Order"] = 11,
		["Color"] = Color3.fromRGB(255, 67, 67),
		["IgnoreSuperRebirth"] = true,
		["multiplier"] = v3.Event1MBalloonsMultiplier,
		["GetPrefix"] = function(p17)
			return p17 > 1 and "Balloons" or "Balloon"
		end
	},
	[v2.Event1MStars] = {
		["Name"] = "Stars",
		["Icon"] = "rbxassetid://97582878086235",
		["Description"] = "Stars",
		["Default"] = 0,
		["Order"] = 9,
		["Color"] = Color3.fromRGB(255, 226, 62),
		["IgnoreSuperRebirth"] = true,
		["GetPrefix"] = function(p18)
			return p18 > 1 and "Stars" or "Star"
		end
	},
	[v2.Event1MConfetti] = {
		["Name"] = "Confetti",
		["Icon"] = "rbxassetid://122967445525805",
		["Description"] = "Confetti",
		["Default"] = 0,
		["Order"] = 10,
		["Color"] = Color3.fromRGB(81, 235, 255),
		["IgnoreSuperRebirth"] = true,
		["multiplier"] = v3.ConfettiMultiplier,
		["GetPrefix"] = function(p19)
			return p19 > 1 and "Confetti" or "Confetto"
		end
	},
	[v2.RaceRerolls] = {
		["Name"] = "Rerolls",
		["Icon"] = "rbxassetid://136775323736509",
		["Description"] = "Rerolls",
		["Default"] = 0,
		["Order"] = 10,
		["Color"] = Color3.fromRGB(255, 200, 81),
		["IgnoreSuperRebirth"] = true,
		["GetPrefix"] = function(p20)
			return p20 > 1 and "Rerolls" or "Reroll"
		end
	}
}
return v21]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CurrencyData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3870"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = {}
for _, v4 in script:GetDescendants() do
	if v4:IsA("ModuleScript") then
		local v5 = require(v4)
		v3[v5.ID] = v5
	end
end
for _, v6 in v2 do
	if not v3[v6] then
		warn((("GamepassData missing for gamepass ID %*"):format(v6)))
	end
end
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GamepassData]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3871"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "Ultra Luck",
	["ID"] = v2.UltraLuck,
	["Icon"] = "rbxassetid://0",
	["Description"] = "+1 Luck (+100%)",
	["Order"] = 6,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 236, 94)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 145, 35)) }),
	["Buffs"] = {
		{
			["type"] = v3.RuneLuck,
			["value"] = 1
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Ultra Luck]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3872"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "VIP",
	["ID"] = v2.VIP,
	["Icon"] = "rbxassetid://0",
	["Description"] = "1.2x Stats, +5 Walkspeed",
	["Order"] = 2,
	["Rotation"] = 90,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 237, 122)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 143, 14)) }),
	["Buffs"] = {
		{
			["type"] = v3.Walkspeed,
			["value"] = 5
		},
		{
			["type"] = v3.StatsMultiplier,
			["value"] = 1.2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VIP]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3873"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "Super Luck",
	["ID"] = v2.SuperLuck,
	["Icon"] = "rbxassetid://0",
	["Description"] = "+0.5 Luck (+50%)",
	["Order"] = 5,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(209, 84, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 41, 238)) }),
	["Buffs"] = {
		{
			["type"] = v3.RuneLuck,
			["value"] = 0.5
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Super Luck]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3874"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "OP Luck",
	["ID"] = v2.OPLuck,
	["Icon"] = "rbxassetid://0",
	["Description"] = "3x Rune Luck, +5% Rune Clone Chance",
	["Order"] = 3,
	["Gradient"] = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 90)),
		ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 178, 90)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(139, 255, 149)),
		ColorSequenceKeypoint.new(0.75, Color3.fromRGB(169, 251, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(224, 146, 255))
	}),
	["Rotation"] = 45,
	["Animated"] = true,
	["Buffs"] = {
		{
			["type"] = v3.RuneLuckMultiplier,
			["value"] = 3
		},
		{
			["type"] = v3.RuneCloneChance,
			["value"] = 0.05
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[OP Luck]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3875"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "Basic Luck",
	["ID"] = v2.BasicLuck,
	["Icon"] = "rbxassetid://0",
	["Description"] = "+0.2 Luck (+20%)",
	["Order"] = 4,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(117, 255, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 255, 65)) }),
	["Buffs"] = {
		{
			["type"] = v3.RuneLuck,
			["value"] = 0.2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Basic Luck]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3876"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "MVP",
	["ID"] = v2.MVP,
	["Icon"] = "rbxassetid://0",
	["Description"] = "1.3x Stats, +4 Rune Bulk and +7 Walkspeed",
	["Order"] = 1,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 102, 102)), ColorSequenceKeypoint.new(1, Color3.fromRGB(206, 30, 30)) }),
	["Buffs"] = {
		{
			["type"] = v3.RuneBulk,
			["value"] = 4
		},
		{
			["type"] = v3.Walkspeed,
			["value"] = 7
		},
		{
			["type"] = v3.StatsMultiplier,
			["value"] = 1.3
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MVP]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3877"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "Faster Runes",
	["ID"] = v2.FasterRunes,
	["Icon"] = "rbxassetid://0",
	["Description"] = "Open Runes Faster",
	["Order"] = 7,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(219, 102, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(186, 66, 255)) }),
	["Buffs"] = {
		{
			["type"] = v3.RuneOpenTimeMultiplier,
			["value"] = 2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Faster Runes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3878"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "2x Rune Clone",
	["ID"] = v2.RuneClone2x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "2x Rune Clone",
	["Order"] = 9,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(219, 102, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(186, 66, 255)) }),
	["Buffs"] = {
		{
			["type"] = v3.RuneCloneMultiplier,
			["value"] = 2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[2x Rune Clone]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3879"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "2x Rune Bulk",
	["ID"] = v2.RuneBulk2x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "2x Rune Bulk",
	["Order"] = 8,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(219, 102, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(186, 66, 255)) }),
	["Buffs"] = {
		{
			["type"] = v3.RuneBulkMultiplier,
			["value"] = 2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[2x Rune Bulk]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3880"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "2x Damage",
	["ID"] = v2.Damage2x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "2x Damage",
	["Order"] = 9,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(102, 255, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 151, 255)) }),
	["Buffs"] = {
		{
			["type"] = v3.DamageMultiplier,
			["value"] = 2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[2x Damage]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3881"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "Bigger Attack Range",
	["ID"] = v2.AttackRange2x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "1.2x Attack Range Increase",
	["Order"] = 9,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(102, 255, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 151, 255)) }),
	["Buffs"] = {
		{
			["type"] = v3.AttackRangeMultiplier,
			["value"] = 1.2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[2x Attack Range]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3882"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "2x Skill XP",
	["ID"] = v2.SkillXP2x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "2x Skill XP (stacks)",
	["Order"] = 18,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(219, 102, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(239, 66, 255)) }),
	["Buffs"] = {
		{
			["type"] = v3.SkillXP,
			["value"] = 2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[2x Skill XP]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3883"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "3x Skill XP",
	["ID"] = v2.SkillXP3x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "3x Skill XP (stacks)",
	["Order"] = 19,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(219, 102, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(239, 66, 255)) }),
	["Buffs"] = {
		{
			["type"] = v3.SkillXP,
			["value"] = 3
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[3x Skill XP]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3884"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "5x Skill XP",
	["ID"] = v2.SkillXP5x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "5x Skill XP (stacks)",
	["Order"] = 20,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(219, 102, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(239, 66, 255)) }),
	["Buffs"] = {
		{
			["type"] = v3.SkillXP,
			["value"] = 5
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[5x Skill XP]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3885"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "2x Shards",
	["ID"] = v2.Shards2x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "2x Shards",
	["Order"] = 10,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(168, 102, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(116, 66, 255)) }),
	["Buffs"] = {
		{
			["type"] = v3.ShardMultiplier,
			["value"] = 2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[2x Shards]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3886"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "2x Coins",
	["ID"] = v2.Coins2x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "2x Coins",
	["Order"] = 15,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 245, 102)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 195, 66)) }),
	["Buffs"] = {
		{
			["type"] = v3.CoinsMultiplier,
			["value"] = 2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[2x Coins]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3887"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "2x Fire Coins",
	["ID"] = v2.FireCoins2x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "2x Fire Coins",
	["Order"] = 16,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 114, 114)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 189, 66)) }),
	["Buffs"] = {
		{
			["type"] = v3.FireCoinsMultiplier,
			["value"] = 2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[2x Fire Coins]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3888"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "2x Ice Coins",
	["ID"] = v2.IceCoins2x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "2x Ice Coins",
	["Order"] = 17,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(102, 255, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 151, 255)) }),
	["Buffs"] = {
		{
			["type"] = v3.IceCoinsMultiplier,
			["value"] = 2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[2x Ice Coins]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3889"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "2x Super Rebirths",
	["ID"] = v2.SuperRebirth2x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "2x Super Rebirths",
	["Order"] = 16,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 245, 102)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 195, 66)) }),
	["Buffs"] = {
		{
			["type"] = v3.SuperRebirthMultiplier,
			["value"] = 2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[2x Super Rebirths]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3890"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "2x Glow Coins",
	["ID"] = v2.GlowCoins2x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "2x Glow Coins",
	["Order"] = 18,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(126, 255, 109)), ColorSequenceKeypoint.new(1, Color3.fromRGB(131, 255, 48)) }),
	["Buffs"] = {
		{
			["type"] = v3.GlowCoinsMultiplier,
			["value"] = 2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[2x Glow Coins]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3891"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "2x Gloop Rate",
	["ID"] = v2.GloopRate2x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "2x Gloop Rate",
	["Order"] = 24,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(126, 255, 109)), ColorSequenceKeypoint.new(1, Color3.fromRGB(131, 255, 48)) }),
	["Buffs"] = {
		{
			["type"] = v3.GloopCollectLuck,
			["value"] = 2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[2x Gloop Rate]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3892"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
return {
	["Name"] = "Bulk Gloop Craft",
	["ID"] = require(v1.Enums.Gamepasses).BulkGloopCraft,
	["Icon"] = "rbxassetid://0",
	["Description"] = "Craft multiple gloop types at once!",
	["Order"] = 25,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 30)) }),
	["Buffs"] = {},
	["Callback"] = function(_) end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Bulk Gloop Craft]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3893"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "2x Craft Speed",
	["ID"] = v2.CraftSpeed2x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "Halves gloop crafting time!",
	["Order"] = 26,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 255, 150)), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 200, 100)) }),
	["Buffs"] = {
		{
			["type"] = v3.GloopCraftSpeed,
			["value"] = 2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[2x Craft Speed]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3894"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "Pet Roll Luck",
	["ID"] = v2.PetRollLuck,
	["Icon"] = "rbxassetid://0",
	["Description"] = "+50% Pet Roll Luck",
	["Order"] = 27,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 50)) }),
	["Buffs"] = {
		{
			["type"] = v3.PetRollLuck,
			["value"] = 0.5
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Pet Roll Luck]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3895"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Gamepasses)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {
	["Name"] = "2x Candy Coins",
	["ID"] = v2.CandyCoins2x,
	["Icon"] = "rbxassetid://0",
	["Description"] = "2x Candy Coins",
	["Order"] = 16,
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 122, 204)), ColorSequenceKeypoint.new(1, Color3.fromRGB(217, 66, 255)) }),
	["Buffs"] = {
		{
			["type"] = v3.CandyCoinsMultiplier,
			["value"] = 2
		}
	},
	["Callback"] = function(_) end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[2x Candy Coins]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3896"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
for _, v2 in script:GetChildren() do
	if v2:IsA("ModuleScript") then
		for v3, v4 in require(v2) do
			v1[v3] = v4
		end
	end
end
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MultiplierData]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3897"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Format)
local v48 = {
	[v2.RuneBulk] = {
		["Name"] = "Rune Bulk",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["RuneTransform"] = function(p4)
			return p4
		end,
		["Calculate"] = function(p5, p6)
			return p5 + p6
		end,
		["Format"] = function(p7)
			return p7
		end
	},
	[v2.RuneOpenTime] = {
		["Name"] = "Rune Open Time",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://91181531852133",
		["RuneTransform"] = function(p8)
			return p8
		end,
		["Merge"] = function(p9, p10)
			return p9 + p10
		end,
		["Calculate"] = function(p11, p12)
			local v13 = p11 - p12
			return math.max(v13, 0.1)
		end,
		["Format"] = function(p14)
			-- upvalues: (copy) v_u_3
			return ("%*s"):format((v_u_3.decimal(p14)))
		end
	},
	[v2.RuneOpenTimeMultiplier] = {
		["Name"] = "Rune Open Time Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://91181531852133",
		["Calculate"] = function(p15, p16)
			return p15 * p16
		end,
		["Format"] = function(p17)
			-- upvalues: (copy) v_u_3
			if p17 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p17)))
			end
			local v18 = v_u_3.decimal
			local v19 = p17 * 100000
			return ("x%*"):format((v18(math.floor(v19) / 100000)))
		end
	},
	[v2.RuneLuck] = {
		["Name"] = "Rune Luck",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://124800928454437",
		["Color"] = Color3.fromRGB(119, 255, 114),
		["RuneTransform"] = function(p20)
			return p20
		end,
		["Calculate"] = function(p21, p22)
			return p21 + p22
		end,
		["Format"] = function(p23)
			-- upvalues: (copy) v_u_3
			local v24 = v_u_3.abbreviate
			local v25 = p23 * 1000
			return ("+%*"):format((v24(math.floor(v25) / 1000)))
		end
	},
	[v2.RuneLuckMultiplier] = {
		["Name"] = "Rune Luck Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://124800928454437",
		["Color"] = Color3.fromRGB(119, 255, 114),
		["Calculate"] = function(p26, p27)
			return p26 * p27
		end,
		["Format"] = function(p28)
			-- upvalues: (copy) v_u_3
			if p28 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p28)))
			end
			local v29 = v_u_3.decimal
			local v30 = p28 * 100000
			return ("x%*"):format((v29(math.floor(v30) / 100000)))
		end
	},
	[v2.RuneBulkMultiplier] = {
		["Name"] = "Rune Bulk Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p31, p32)
			return p31 * p32
		end,
		["Format"] = function(p33)
			-- upvalues: (copy) v_u_3
			if p33 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p33)))
			end
			local v34 = v_u_3.decimal
			local v35 = p33 * 100000
			return ("x%*"):format((v34(math.floor(v35) / 100000)))
		end
	},
	[v2.RuneCloneMultiplier] = {
		["Name"] = "Rune Clone Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Calculate"] = function(p36, p37)
			return p36 * p37
		end,
		["Format"] = function(p38)
			-- upvalues: (copy) v_u_3
			if p38 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p38)))
			end
			local v39 = v_u_3.decimal
			local v40 = p38 * 100000
			return ("x%*"):format((v39(math.floor(v40) / 100000)))
		end
	},
	[v2.RuneClone] = {
		["Name"] = "Rune Clone",
		["Default"] = 1,
		["Base"] = 0,
		["Calculate"] = function(p41, p42)
			return p41 + p42
		end,
		["Format"] = function(p43)
			-- upvalues: (copy) v_u_3
			return ("%*"):format((v_u_3.decimal(p43, 2)))
		end
	},
	[v2.RuneCloneChance] = {
		["Name"] = "Rune Clone Chance",
		["Default"] = 0,
		["Base"] = 0,
		["RuneTransform"] = function(p44)
			return p44
		end,
		["Calculate"] = function(p45, p46)
			return p45 + p46
		end,
		["Format"] = function(p47)
			-- upvalues: (copy) v_u_3
			return ("%*%%"):format((v_u_3.decimal(p47 * 100, 2)))
		end
	}
}
return v48]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RUNE_MULTIPLIER]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3898"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("StarterPlayer")
local v3 = require(v1.Enums.MultiplierTypes)
local v_u_4 = require(v1.Utility.Format)
local v70 = {
	[v3.Walkspeed] = {
		["Name"] = "Walkspeed",
		["Default"] = v2.CharacterWalkSpeed,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Color"] = Color3.fromRGB(77, 243, 255),
		["Calculate"] = function(p5, p6)
			return p5 + p6
		end,
		["Format"] = function(p7)
			return p7
		end
	},
	[v3.WalkspeedMultiplier] = {
		["Name"] = "Walkspeed Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Color"] = Color3.fromRGB(77, 243, 255),
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p8, p9)
			return p8 * p9
		end,
		["Format"] = function(p10)
			-- upvalues: (copy) v_u_4
			if p10 >= 1000 then
				return ("x%*"):format((v_u_4.abbreviate(p10)))
			end
			local v11 = v_u_4.decimal
			local v12 = p10 * 100000
			return ("x%*"):format((v11(math.floor(v12) / 100000)))
		end
	},
	[v3.RebirthMultiplier] = {
		["Name"] = "Rebirth Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Color"] = Color3.fromRGB(255, 111, 190),
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p13, p14)
			return p13 * p14
		end,
		["Format"] = function(p15)
			-- upvalues: (copy) v_u_4
			if p15 >= 1000 then
				return ("x%*"):format((v_u_4.abbreviate(p15)))
			end
			local v16 = v_u_4.decimal
			local v17 = p15 * 100000
			return ("x%*"):format((v16(math.floor(v17) / 100000)))
		end
	},
	[v3.Stats] = {
		["Name"] = "Stats",
		["Default"] = 1,
		["Base"] = 0,
		["Color"] = Color3.fromRGB(255, 89, 89),
		["Icon"] = "rbxassetid://137925169301833",
		["Calculate"] = function(p18, p19)
			return p18 + p19
		end,
		["Format"] = function(p20)
			-- upvalues: (copy) v_u_4
			return v_u_4.abbreviateComma(p20)
		end
	},
	[v3.StatsMultiplier] = {
		["Name"] = "Stats Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Color"] = Color3.fromRGB(255, 89, 89),
		["Icon"] = "rbxassetid://137925169301833",
		["Calculate"] = function(p21, p22)
			return p21 * p22
		end,
		["Format"] = function(p23)
			-- upvalues: (copy) v_u_4
			if p23 >= 1000 then
				return ("x%*"):format((v_u_4.abbreviate(p23)))
			end
			local v24 = v_u_4.decimal
			local v25 = p23 * 100000
			return ("x%*"):format((v24(math.floor(v25) / 100000)))
		end
	},
	[v3.CurrencyGain] = {
		["Name"] = "Currency Gain",
		["Default"] = 1,
		["Base"] = 0,
		["Color"] = Color3.fromRGB(255, 216, 89),
		["Icon"] = "rbxassetid://137925169301833",
		["Calculate"] = function(p26, p27)
			return p26 + p27
		end,
		["Format"] = function(p28)
			-- upvalues: (copy) v_u_4
			return v_u_4.abbreviateComma(p28)
		end
	},
	[v3.CurrencyGainMultiplier] = {
		["Name"] = "Currency Gain Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Color"] = Color3.fromRGB(255, 209, 82),
		["Icon"] = "rbxassetid://137925169301833",
		["Calculate"] = function(p29, p30)
			return p29 * p30
		end,
		["Format"] = function(p31)
			-- upvalues: (copy) v_u_4
			if p31 >= 1000 then
				return ("x%*"):format((v_u_4.abbreviate(p31)))
			end
			local v32 = v_u_4.decimal
			local v33 = p31 * 100000
			return ("x%*"):format((v32(math.floor(v33) / 100000)))
		end
	},
	[v3.SkillXP] = {
		["Name"] = "Skill XP",
		["Default"] = 0,
		["Base"] = 0,
		["Color"] = Color3.fromRGB(255, 215, 59),
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p34, p35)
			local v36 = p34 + p35
			return math.max(v36, 1)
		end,
		["Format"] = function(p37)
			-- upvalues: (copy) v_u_4
			if p37 >= 1000 then
				return ("%*"):format((v_u_4.abbreviate(p37)))
			end
			local v38 = v_u_4.decimal
			local v39 = p37 * 100000
			return ("%*"):format((v38(math.floor(v39) / 100000)))
		end
	},
	[v3.SkillXPMultiplier] = {
		["Name"] = "Skill XP Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Color"] = Color3.fromRGB(255, 215, 59),
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p40, p41)
			return p40 * p41
		end,
		["Format"] = function(p42)
			-- upvalues: (copy) v_u_4
			if p42 >= 1000 then
				return ("x%*"):format((v_u_4.abbreviate(p42)))
			end
			local v43 = v_u_4.decimal
			local v44 = p42 * 100000
			return ("x%*"):format((v43(math.floor(v44) / 100000)))
		end
	},
	[v3.GoldenChance] = {
		["Name"] = "Golden Slime Chance",
		["Default"] = 0,
		["Base"] = 0,
		["Color"] = Color3.fromRGB(255, 223, 91),
		["Icon"] = "rbxassetid://0000000000000000",
		["Calculate"] = function(p45, p46)
			return p45 + p46
		end,
		["Format"] = function(p47)
			-- upvalues: (copy) v_u_4
			return v_u_4.percentage(p47)
		end
	},
	[v3.DiamondChance] = {
		["Name"] = "Diamond Slime Chance",
		["Default"] = 0,
		["Base"] = 0,
		["Color"] = Color3.fromRGB(103, 232, 255),
		["Icon"] = "rbxassetid://0000000000000000",
		["Calculate"] = function(p48, p49)
			return p48 + p49
		end,
		["Format"] = function(p50)
			-- upvalues: (copy) v_u_4
			return v_u_4.percentage(p50)
		end
	},
	[v3.RainbowChance] = {
		["Name"] = "Rainbow Slime Chance",
		["Default"] = 0,
		["Base"] = 0,
		["Color"] = Color3.fromRGB(255, 255, 255),
		["Icon"] = "rbxassetid://0000000000000000",
		["Calculate"] = function(p51, p52)
			return p51 + p52
		end,
		["Format"] = function(p53)
			-- upvalues: (copy) v_u_4
			return v_u_4.percentage(p53)
		end
	},
	[v3.ShardDropChance] = {
		["Name"] = "Shard Drop Chance",
		["Default"] = 0.01,
		["Base"] = 0,
		["Color"] = Color3.fromRGB(150, 75, 255),
		["Icon"] = "rbxassetid://0000000000000000",
		["Calculate"] = function(p54, p55)
			return p54 + p55
		end,
		["Format"] = function(p56)
			-- upvalues: (copy) v_u_4
			return v_u_4.percentage(p56)
		end
	},
	[v3.ShardMultiplier] = {
		["Name"] = "Shard Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Color"] = Color3.fromRGB(150, 75, 255),
		["Icon"] = "rbxassetid://0000000000000000",
		["Calculate"] = function(p57, p58)
			return p57 * p58
		end,
		["Format"] = function(p59)
			-- upvalues: (copy) v_u_4
			if p59 >= 1000 then
				return ("x%*"):format((v_u_4.abbreviate(p59)))
			end
			local v60 = v_u_4.decimal
			local v61 = p59 * 100000
			return ("x%*"):format((v60(math.floor(v61) / 100000)))
		end
	},
	[v3.LuckyBlockDurationIncrease] = {
		["Name"] = "Lucky Block Duration Increase",
		["Default"] = 0,
		["Base"] = 0,
		["Color"] = Color3.fromRGB(255, 223, 91),
		["Icon"] = "rbxassetid://0000000000000000",
		["Calculate"] = function(p62, p63)
			return p62 + p63
		end,
		["Format"] = function(p64)
			-- upvalues: (copy) v_u_4
			return ("+%*s"):format((v_u_4.abbreviate(p64)))
		end
	},
	[v3.SuperRebirthMultiplier] = {
		["Name"] = "Super Rebirth Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Color"] = Color3.fromRGB(255, 108, 223),
		["Icon"] = "rbxassetid://128040547576532",
		["Calculate"] = function(p65, p66)
			return p65 * p66
		end,
		["Format"] = function(p67)
			-- upvalues: (copy) v_u_4
			if p67 >= 1000 then
				return ("x%*"):format((v_u_4.abbreviate(p67)))
			end
			local v68 = v_u_4.decimal
			local v69 = p67 * 100000
			return ("x%*"):format((v68(math.floor(v69) / 100000)))
		end
	}
}
return v70]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MISC_MULTIPLIER]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3899"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Format)
local v24 = {
	[v2.World1SpawnCap] = {
		["Name"] = "Earth Slime Cap",
		["Default"] = 2,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p4, p5)
			return p4 + p5
		end,
		["Format"] = function(p6)
			return p6
		end
	},
	[v2.World1SpawnRate] = {
		["Name"] = "Earth Slime Spawn Rate",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Merge"] = function(p7, p8)
			return p7 + p8
		end,
		["Calculate"] = function(p9, p10)
			local v11 = p9 - p10
			return math.max(v11, 0.1)
		end,
		["Format"] = function(p12)
			return p12 .. "s"
		end
	},
	[v2.World1SlimeLuck] = {
		["Name"] = "Earth Slime Luck",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://124800928454437",
		["Calculate"] = function(p13, p14)
			return p13 + p14
		end,
		["Format"] = function(p15)
			-- upvalues: (copy) v_u_3
			return v_u_3.percentage(p15)
		end
	},
	[v2.World1AttackRange] = {
		["Name"] = "Earth Attack Range",
		["Default"] = 6,
		["Base"] = 0,
		["Icon"] = "rbxassetid://78157289763375",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p16, p17)
			return p16 + p17
		end,
		["Format"] = function(p18)
			return p18
		end
	},
	[v2.CoinsMultiplier] = {
		["Name"] = "Coins Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://137385384245893",
		["Color"] = Color3.fromRGB(255, 223, 0),
		["Calculate"] = function(p19, p20)
			return p19 * p20
		end,
		["Format"] = function(p21)
			-- upvalues: (copy) v_u_3
			if p21 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p21)))
			end
			local v22 = v_u_3.decimal
			local v23 = p21 * 100000
			return ("x%*"):format((v22(math.floor(v23) / 100000)))
		end
	}
}
return v24]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[EARTH_MULTIPLIER]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3900"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Config.Constants)
local v3 = require(v1.Enums.MultiplierTypes)
local v_u_4 = require(v1.Utility.Format)
local v43 = {
	[v3.AttackRange] = {
		["Name"] = "Attack Range",
		["Default"] = 6,
		["Base"] = 0,
		["Icon"] = "rbxassetid://78157289763375",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p5, p6)
			return p5 + p6
		end,
		["Format"] = function(p7)
			return p7
		end
	},
	[v3.AttackRangeMultiplier] = {
		["Name"] = "Attack Range Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://78157289763375",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p8, p9)
			return p8 * p9
		end,
		["Format"] = function(p10)
			-- upvalues: (copy) v_u_4
			if p10 >= 1000 then
				return ("x%*"):format((v_u_4.abbreviate(p10)))
			end
			local v11 = v_u_4.decimal
			local v12 = p10 * 100000
			return ("x%*"):format((v11(math.floor(v12) / 100000)))
		end
	},
	[v3.AttackSpeed] = {
		["Name"] = "Attack Speed",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://83884379124762",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p13, p14)
			local v15 = p13 - p14
			return math.max(0.1, v15)
		end,
		["Format"] = function(p16)
			return p16 .. "s"
		end
	},
	[v3.AttackSpeedMultiplier] = {
		["Name"] = "Attack Speed Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://83884379124762",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p17, p18)
			return p17 * p18
		end,
		["Format"] = function(p19)
			-- upvalues: (copy) v_u_4
			if p19 >= 1000 then
				return ("x%*"):format((v_u_4.abbreviate(p19)))
			end
			local v20 = v_u_4.decimal
			local v21 = p19 * 100000
			return ("x%*"):format((v20(math.floor(v21) / 100000)))
		end
	},
	[v3.Damage] = {
		["Name"] = "Damage",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://106746371164727",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["RuneTransform"] = function(p22)
			return p22
		end,
		["Calculate"] = function(p23, p24)
			return p23 + p24
		end,
		["Format"] = function(p25)
			-- upvalues: (copy) v_u_4
			return ("%*"):format((v_u_4.abbreviateComma(p25)))
		end
	},
	[v3.DamageMultiplier] = {
		["Name"] = "Damage Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://106746371164727",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p26, p27)
			return p26 * p27
		end,
		["Format"] = function(p28)
			-- upvalues: (copy) v_u_4
			if p28 >= 1000 then
				return ("x%*"):format((v_u_4.abbreviate(p28)))
			end
			local v29 = v_u_4.decimal
			local v30 = p28 * 100000
			return ("x%*"):format((v29(math.floor(v30) / 100000)))
		end
	},
	[v3.CriticalHitChance] = {
		["Name"] = "Critical Hit Chance",
		["Default"] = 0.01,
		["Base"] = 0,
		["Icon"] = "rbxassetid://00000000",
		["Color"] = Color3.fromRGB(255, 188, 63),
		["RuneTransform"] = function(p31)
			return p31
		end,
		["Calculate"] = function(p32, p33)
			return p32 + p33
		end,
		["Format"] = function(p34)
			-- upvalues: (copy) v_u_4
			return ("%*%%"):format((v_u_4.decimal(p34 * 100, 2)))
		end
	},
	[v3.CriticalHitMultiplier] = {
		["Name"] = "Critical Hit Multiplier",
		["Default"] = 2,
		["Base"] = 1,
		["Icon"] = "rbxassetid://00000000000",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p35, p36)
			return p35 * p36
		end,
		["Format"] = function(p37)
			-- upvalues: (copy) v_u_4
			if p37 >= 1000 then
				return ("x%*"):format((v_u_4.abbreviate(p37)))
			end
			local v38 = v_u_4.decimal
			local v39 = p37 * 100000
			return ("x%*"):format((v38(math.floor(v39) / 100000)))
		end
	},
	[v3.ComboMultiplier] = {
		["Name"] = "Combo Multiplier",
		["Default"] = v2.COMBO_MULTIPLIER,
		["Base"] = 0,
		["Icon"] = "rbxassetid://00000000000",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p40, p41)
			return p40 + p41
		end,
		["Format"] = function(p42)
			return ("%*x"):format(1 + p42)
		end
	}
}
return v43]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ATTACK_MULTIPLIER]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3901"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v20 = {
	[v2.LightingStrikes] = {
		["Name"] = "Lighting Strikes",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Color"] = Color3.fromRGB(132, 206, 255),
		["Calculate"] = function(p3, p4)
			return p3 + p4
		end,
		["Format"] = function(p5)
			return p5
		end
	},
	[v2.LightingStrikeDamage] = {
		["Name"] = "Lighting Strike Damage",
		["Default"] = 0.1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Color"] = Color3.fromRGB(132, 206, 255),
		["Calculate"] = function(p6, p7)
			return p6 + p7
		end,
		["Format"] = function(p8)
			local v9 = p8 * 100
			return ("%*%%"):format(math.floor(v9) / 100)
		end
	},
	[v2.LightingStrikeCooldown] = {
		["Name"] = "Lighting Strike Cooldown",
		["Default"] = 5,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Color"] = Color3.fromRGB(132, 206, 255),
		["Merge"] = function(p10, p11)
			return p10 + p11
		end,
		["Calculate"] = function(p12, p13)
			return p12 - p13
		end,
		["Format"] = function(p14)
			local v15 = p14 * 100
			return ("%*s"):format(math.floor(v15) / 100)
		end
	},
	[v2.LightingDoubleStrikeChance] = {
		["Name"] = "Lighting Double Strike Chance",
		["Default"] = 0,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Color"] = Color3.fromRGB(132, 206, 255),
		["Calculate"] = function(p16, p17)
			return p16 + p17
		end,
		["Format"] = function(p18)
			local v19 = p18 * 10000
			return ("%*%%"):format(math.floor(v19) / 100)
		end
	}
}
return v20]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LIGHTING_SKILL_MULTIPLIER]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3902"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Format)
local v24 = {
	[v2.World2SpawnCap] = {
		["Name"] = "Lava Slime Cap",
		["Default"] = 2,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p4, p5)
			return p4 + p5
		end,
		["Format"] = function(p6)
			return p6
		end
	},
	[v2.World2SpawnRate] = {
		["Name"] = "Lava Slime Spawn Rate",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Merge"] = function(p7, p8)
			return p7 + p8
		end,
		["Calculate"] = function(p9, p10)
			local v11 = p9 - p10
			return math.max(v11, 0.1)
		end,
		["Format"] = function(p12)
			return p12 .. "s"
		end
	},
	[v2.World2SlimeLuck] = {
		["Name"] = "Lava Slime Luck",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://124800928454437",
		["Calculate"] = function(p13, p14)
			return p13 + p14
		end,
		["Format"] = function(p15)
			-- upvalues: (copy) v_u_3
			return v_u_3.percentage(p15)
		end
	},
	[v2.World2AttackRange] = {
		["Name"] = "Lava Attack Range",
		["Default"] = 6,
		["Base"] = 0,
		["Icon"] = "rbxassetid://78157289763375",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p16, p17)
			return p16 + p17
		end,
		["Format"] = function(p18)
			return p18
		end
	},
	[v2.FireCoinsMultiplier] = {
		["Name"] = "Lava Coins Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://113801335212128",
		["Color"] = Color3.fromRGB(255, 223, 0),
		["Calculate"] = function(p19, p20)
			return p19 * p20
		end,
		["Format"] = function(p21)
			-- upvalues: (copy) v_u_3
			if p21 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p21)))
			end
			local v22 = v_u_3.decimal
			local v23 = p21 * 100000
			return ("x%*"):format((v22(math.floor(v23) / 100000)))
		end
	}
}
return v24]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LAVA_MULTIPLIERS]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3903"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v20 = {
	[v2.ArrowFired] = {
		["Name"] = "Arrow Fired",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Color"] = Color3.fromRGB(255, 113, 113),
		["Calculate"] = function(p3, p4)
			return p3 + p4
		end,
		["Format"] = function(p5)
			return p5
		end
	},
	[v2.ArrowDamage] = {
		["Name"] = "Arrow Damage",
		["Default"] = 0.1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Color"] = Color3.fromRGB(255, 113, 113),
		["Calculate"] = function(p6, p7)
			return p6 + p7
		end,
		["Format"] = function(p8)
			local v9 = p8 * 100
			return ("%*%%"):format(math.floor(v9) / 100)
		end
	},
	[v2.ArrowCooldown] = {
		["Name"] = "Arrow Cooldown",
		["Default"] = 5,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Color"] = Color3.fromRGB(255, 113, 113),
		["Merge"] = function(p10, p11)
			return p10 + p11
		end,
		["Calculate"] = function(p12, p13)
			return p12 - p13
		end,
		["Format"] = function(p14)
			local v15 = p14 * 100
			return ("%*s"):format(math.floor(v15) / 100)
		end
	},
	[v2.ArrowRain] = {
		["Name"] = "Arrow Rain",
		["Default"] = 0,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Color"] = Color3.fromRGB(255, 113, 113),
		["Calculate"] = function(p16, p17)
			return p16 + p17
		end,
		["Format"] = function(p18)
			local v19 = p18 * 10000
			return ("%*%%"):format(math.floor(v19) / 100)
		end
	}
}
return v20]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ARROW_SKILL_MULTIPLIER]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3904"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Format)
local v42 = {
	[v2.World3SpawnCap] = {
		["Name"] = "Ice Slime Cap",
		["Default"] = 2,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p4, p5)
			return p4 + p5
		end,
		["Format"] = function(p6)
			return p6
		end
	},
	[v2.World3SpawnRate] = {
		["Name"] = "Ice Slime Spawn Rate",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Merge"] = function(p7, p8)
			return p7 + p8
		end,
		["Calculate"] = function(p9, p10)
			local v11 = p9 - p10
			return math.max(v11, 0.1)
		end,
		["Format"] = function(p12)
			return p12 .. "s"
		end
	},
	[v2.World3SlimeLuck] = {
		["Name"] = "Ice Slime Luck",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://124800928454437",
		["Calculate"] = function(p13, p14)
			return p13 + p14
		end,
		["Format"] = function(p15)
			-- upvalues: (copy) v_u_3
			return v_u_3.percentage(p15)
		end
	},
	[v2.World3AttackRange] = {
		["Name"] = "Ice Attack Range",
		["Default"] = 6,
		["Base"] = 0,
		["Icon"] = "rbxassetid://78157289763375",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p16, p17)
			return p16 + p17
		end,
		["Format"] = function(p18)
			return p18
		end
	},
	[v2.IceCoinsMultiplier] = {
		["Name"] = "Ice Coins Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://94836897629836",
		["Color"] = Color3.fromRGB(0, 170, 255),
		["Calculate"] = function(p19, p20)
			return p19 * p20
		end,
		["Format"] = function(p21)
			-- upvalues: (copy) v_u_3
			if p21 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p21)))
			end
			local v22 = v_u_3.decimal
			local v23 = p21 * 100000
			return ("x%*"):format((v22(math.floor(v23) / 100000)))
		end
	},
	[v2.IceWorldDuration] = {
		["Name"] = "Ice World Duration",
		["Default"] = 30,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p24, p25)
			return p24 + p25
		end,
		["Format"] = function(p26)
			local v27 = p26 * 100
			return ("%*s"):format(math.floor(v27) / 100)
		end
	},
	[v2.IceWorldDurationMultiplier] = {
		["Name"] = "Ice World Duration Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://113801336223486",
		["Color"] = Color3.fromRGB(0, 170, 255),
		["Calculate"] = function(p28, p29)
			return p28 * p29
		end,
		["Format"] = function(p30)
			-- upvalues: (copy) v_u_3
			if p30 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p30)))
			end
			local v31 = v_u_3.decimal
			local v32 = p30 * 100000
			return ("x%*"):format((v31(math.floor(v32) / 100000)))
		end
	},
	[v2.IceBonusTime] = {
		["Name"] = "Ice Bonus Time",
		["Default"] = 0,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p33, p34)
			return p33 + p34
		end,
		["Format"] = function(p35)
			local v36 = p35 * 100
			return ("+%*s"):format(math.floor(v36) / 100)
		end
	},
	[v2.AmuletCheaperCost] = {
		["Name"] = "Amulet Cheaper Cost",
		["Default"] = 0,
		["Base"] = 0,
		["Icon"] = "rbxassetid://148560973964222",
		["Calculate"] = function(p37, p38)
			return p37 + p38
		end,
		["Format"] = function(p39)
			-- upvalues: (copy) v_u_3
			local v40 = v_u_3.percentage
			local v41 = p39 * 100
			return v40(math.floor(v41) / 100)
		end
	}
}
return v42]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ICE_MULTIPLIERS]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3905"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v20 = {
	[v2.FreezeAmount] = {
		["Name"] = "Freeze Amount",
		["Default"] = 0.25,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Color"] = Color3.fromRGB(255, 113, 113),
		["Calculate"] = function(p3, p4)
			return p3 + p4
		end,
		["Format"] = function(p5)
			return p5
		end
	},
	[v2.FreezeDamage] = {
		["Name"] = "Freeze Damage",
		["Default"] = 0.1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Color"] = Color3.fromRGB(255, 113, 113),
		["Calculate"] = function(p6, p7)
			return p6 + p7
		end,
		["Format"] = function(p8)
			local v9 = p8 * 100
			return ("%*%%"):format(math.floor(v9) / 100)
		end
	},
	[v2.FreezeCooldown] = {
		["Name"] = "Freeze Cooldown",
		["Default"] = 10,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Color"] = Color3.fromRGB(255, 113, 113),
		["Merge"] = function(p10, p11)
			return p10 + p11
		end,
		["Calculate"] = function(p12, p13)
			return p12 - p13
		end,
		["Format"] = function(p14)
			local v15 = p14 * 100
			return ("%*s"):format(math.floor(v15) / 100)
		end
	},
	[v2.FreezeDoubleChance] = {
		["Name"] = "Freeze Double Chance",
		["Default"] = 0,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Color"] = Color3.fromRGB(255, 113, 113),
		["Calculate"] = function(p16, p17)
			return p16 + p17
		end,
		["Format"] = function(p18)
			local v19 = p18 * 10000
			return ("%*%%"):format(math.floor(v19) / 100)
		end
	}
}
return v20]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ICE_WIND_SKILL_MULTIPLIER]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3906"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Time)
local v19 = {
	[v2.IceBossCooldown] = {
		["Name"] = "Ice Boss Cooldown",
		["Default"] = 28800,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p4, p5)
			return p4 - p5
		end,
		["Format"] = function(p6)
			-- upvalues: (copy) v_u_3
			return ("%*"):format((v_u_3.format(p6)))
		end
	},
	[v2.IceBossCooldownPercentage] = {
		["Name"] = "Ice Boss Cooldown",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Merge"] = function(p7, p8)
			return p7 + p8
		end,
		["Calculate"] = function(p9, p10)
			return p9 - p10
		end,
		["Format"] = function(p11)
			local v12 = p11 * 100
			return ("-%*%%"):format((math.floor(v12)))
		end
	},
	[v2.FreeShardPercentage] = {
		["Name"] = "Free Shard Percentage",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Merge"] = function(p13, p14)
			return p13 + p14
		end,
		["Calculate"] = function(p15, p16)
			return p15 - p16
		end,
		["Format"] = function(p17)
			local v18 = p17 * 100
			return ("-%*%%"):format((math.floor(v18)))
		end
	}
}
return v19]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ICE_BOSS_MULTIPLIERS]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3907"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Format)
local v18 = {
	[v2.IceBossAttackRangeMultiplier] = {
		["Name"] = "Attack Range Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://0",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p4, p5)
			return p4 * p5
		end,
		["Format"] = function(p6)
			-- upvalues: (copy) v_u_3
			if p6 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p6)))
			end
			local v7 = v_u_3.decimal
			local v8 = p6 * 100000
			return ("x%*"):format((v7(math.floor(v8) / 100000)))
		end
	},
	[v2.IceBossAttackSpeed] = {
		["Name"] = "Attack Speed",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://0",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p9, p10)
			local v11 = p9 - p10
			return math.max(0.1, v11)
		end,
		["Format"] = function(p12)
			return p12 .. "s"
		end
	},
	[v2.IceBossAttackSpeedMultiplier] = {
		["Name"] = "Ice Boss Attack Speed Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://83884379124762",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p13, p14)
			return p13 * p14
		end,
		["Format"] = function(p15)
			-- upvalues: (copy) v_u_3
			if p15 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p15)))
			end
			local v16 = v_u_3.decimal
			local v17 = p15 * 100000
			return ("x%*"):format((v16(math.floor(v17) / 100000)))
		end
	}
}
return v18]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ICE_BOSS_ATTACK_MULTIPLIER]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3908"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Format)
local v62 = {
	[v2.ValentineSpawnCap] = {
		["Name"] = "Valentine Cap",
		["Default"] = 2,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p4, p5)
			return p4 + p5
		end,
		["Format"] = function(p6)
			return p6
		end
	},
	[v2.ValentineSpawnRate] = {
		["Name"] = "Valentine Spawn Rate",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Merge"] = function(p7, p8)
			return p7 + p8
		end,
		["Calculate"] = function(p9, p10)
			local v11 = p9 - p10
			return math.max(v11, 0.1)
		end,
		["Format"] = function(p12)
			return p12 .. "s"
		end
	},
	[v2.ValentineAttackSpeed] = {
		["Name"] = "Attack Speed",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://83884379124762",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p13, p14)
			local v15 = p13 - p14
			return math.max(0.1, v15)
		end,
		["Format"] = function(p16)
			return p16 .. "s"
		end
	},
	[v2.ValentineAttackSpeedMultiplier] = {
		["Name"] = "Attack Speed Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://83884379124762",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p17, p18)
			return p17 * p18
		end,
		["Format"] = function(p19)
			-- upvalues: (copy) v_u_3
			if p19 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p19)))
			end
			local v20 = v_u_3.decimal
			local v21 = p19 * 100000
			return ("x%*"):format((v20(math.floor(v21) / 100000)))
		end
	},
	[v2.ValentineAttackRange] = {
		["Name"] = "Valentine Attack Range",
		["Default"] = 5,
		["Base"] = 0,
		["Icon"] = "rbxassetid://78157289763375",
		["Calculate"] = function(p22, p23)
			return p22 + p23
		end,
		["Format"] = function(p24)
			return ("+%*"):format(p24)
		end
	},
	[v2.ValentineAttackRangeMultiplier] = {
		["Name"] = "Valentine Attack Range Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://78157289763375",
		["Calculate"] = function(p25, p26)
			return p25 * p26
		end,
		["Format"] = function(p27)
			-- upvalues: (copy) v_u_3
			if p27 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p27)))
			end
			local v28 = p27 * 100000
			return ("x%*"):format(math.floor(v28) / 100000)
		end
	},
	[v2.ValentineDamage] = {
		["Name"] = "Valentine Damage",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://137385384245893",
		["Calculate"] = function(p29, p30)
			return p29 + p30
		end,
		["Format"] = function(p31)
			-- upvalues: (copy) v_u_3
			return v_u_3.abbreviateComma(p31)
		end
	},
	[v2.ValentineDamageMultiplier] = {
		["Name"] = "Valentine Damage Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://137385384245893",
		["Calculate"] = function(p32, p33)
			return p32 * p33
		end,
		["Format"] = function(p34)
			-- upvalues: (copy) v_u_3
			if p34 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p34)))
			end
			local v35 = p34 * 100000
			return ("x%*"):format(math.floor(v35) / 100000)
		end
	},
	[v2.HeartsMultiplier] = {
		["Name"] = "Hearts Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://138183143153808",
		["Calculate"] = function(p36, p37)
			return p36 * p37
		end,
		["Format"] = function(p38)
			-- upvalues: (copy) v_u_3
			if p38 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p38)))
			end
			local v39 = p38 * 100000
			return ("x%*"):format(math.floor(v39) / 100000)
		end
	},
	[v2.ValentineTraitsLuck] = {
		["Name"] = "Valentine Traits Luck",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://138183143153808",
		["Calculate"] = function(p40, p41)
			return p40 + p41
		end,
		["Format"] = function(p42)
			local v43 = p42 * 10000
			return ("%*%%"):format(math.floor(v43) / 100)
		end
	},
	[v2.ValentineTraitsLuckMultiplier] = {
		["Name"] = "Valentine Traits Luck Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://138183143153808",
		["Calculate"] = function(p44, p45)
			return p44 * p45
		end,
		["Format"] = function(p46)
			-- upvalues: (copy) v_u_3
			if p46 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p46)))
			end
			local v47 = p46 * 100000
			return ("x%*"):format(math.floor(v47) / 100000)
		end
	},
	[v2.ValentineCrystalShards] = {
		["Name"] = "Valentine Crystal Shards",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://138183143153808",
		["Calculate"] = function(p48, p49)
			return p48 + p49
		end,
		["Format"] = function(p50)
			return p50
		end
	},
	[v2.ValentineCrystalShardMultiplier] = {
		["Name"] = "Valentine Crystal Shard Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://138183143153808",
		["Calculate"] = function(p51, p52)
			return p51 * p52
		end,
		["Format"] = function(p53)
			-- upvalues: (copy) v_u_3
			if p53 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p53)))
			end
			local v54 = p53 * 100000
			return ("x%*"):format(math.floor(v54) / 100000)
		end
	},
	[v2.ValentineCrystalShardDropChance] = {
		["Name"] = "Valentine Crystal Shard Drop Chance",
		["Default"] = 0.05,
		["Base"] = 0,
		["Icon"] = "rbxassetid://138183143153808",
		["RuneTransform"] = function(p55)
			return p55
		end,
		["Calculate"] = function(p56, p57)
			return p56 + p57
		end,
		["Format"] = function(p58)
			-- upvalues: (copy) v_u_3
			return v_u_3.percentage(p58)
		end
	},
	[v2.ValentineSlimeXP] = {
		["Name"] = "Valentine Slime XP",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://138183143153808",
		["Calculate"] = function(p59, p60)
			return p59 + p60
		end,
		["Format"] = function(p61)
			-- upvalues: (copy) v_u_3
			return v_u_3.abbreviateComma(p61)
		end
	}
}
return v62]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VALENTINE_MULTIPLIER]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3909"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Format)
local v33 = {
	[v2.ValentineRuneBulk] = {
		["Name"] = "Valentine Rune Bulk",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["RuneTransform"] = function(p4)
			return p4
		end,
		["Calculate"] = function(p5, p6)
			return p5 + p6
		end,
		["Format"] = function(p7)
			return p7
		end
	},
	[v2.ValentineRuneLuck] = {
		["Name"] = "Valentine Rune Luck",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://124800928454437",
		["Color"] = Color3.fromRGB(119, 255, 114),
		["RuneTransform"] = function(p8)
			return p8
		end,
		["Calculate"] = function(p9, p10)
			return p9 + p10
		end,
		["Format"] = function(p11)
			-- upvalues: (copy) v_u_3
			local v12 = v_u_3.abbreviate
			local v13 = p11 * 1000
			return ("+%*"):format((v12(math.floor(v13) / 1000)))
		end
	},
	[v2.ValentineRuneLuckMultiplier] = {
		["Name"] = "Valentine Rune Luck Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://124800928454437",
		["Color"] = Color3.fromRGB(119, 255, 114),
		["Calculate"] = function(p14, p15)
			return p14 * p15
		end,
		["Format"] = function(p16)
			-- upvalues: (copy) v_u_3
			if p16 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p16)))
			end
			local v17 = v_u_3.decimal
			local v18 = p16 * 100000
			return ("x%*"):format((v17(math.floor(v18) / 100000)))
		end
	},
	[v2.ValentineRuneBulkMultiplier] = {
		["Name"] = "Valentine Rune Bulk Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p19, p20)
			return p19 * p20
		end,
		["Format"] = function(p21)
			-- upvalues: (copy) v_u_3
			if p21 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p21)))
			end
			local v22 = v_u_3.decimal
			local v23 = p21 * 100000
			return ("x%*"):format((v22(math.floor(v23) / 100000)))
		end
	},
	[v2.ValentineRuneOpenTime] = {
		["Name"] = "Valentine Rune Open Time",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["RuneTransform"] = function(p24)
			return p24
		end,
		["Calculate"] = function(p25, p26)
			return p25 + p26
		end,
		["Format"] = function(p27)
			return p27
		end
	},
	[v2.ValentineRuneOpenTimeMultiplier] = {
		["Name"] = "Valentine Rune Open Time Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p28, p29)
			return p28 * p29
		end,
		["Format"] = function(p30)
			-- upvalues: (copy) v_u_3
			if p30 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p30)))
			end
			local v31 = v_u_3.decimal
			local v32 = p30 * 100000
			return ("x%*"):format((v31(math.floor(v32) / 100000)))
		end
	}
}
return v33]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VALENTINE_RUNE_MULTIPLIER]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3910"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Format)
local v31 = {
	[v2.World4SpawnCap] = {
		["Name"] = "Gloop Slime Cap",
		["Default"] = 2,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p4, p5)
			return p4 + p5
		end,
		["Format"] = function(p6)
			return p6
		end
	},
	[v2.World4SpawnRate] = {
		["Name"] = "Gloop Slime Spawn Rate",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Merge"] = function(p7, p8)
			return p7 + p8
		end,
		["Calculate"] = function(p9, p10)
			local v11 = p9 - p10
			return math.max(v11, 0.1)
		end,
		["Format"] = function(p12)
			return p12 .. "s"
		end
	},
	[v2.World4SlimeLuck] = {
		["Name"] = "Gloop Slime Luck",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://124800928454437",
		["Calculate"] = function(p13, p14)
			return p13 + p14
		end,
		["Format"] = function(p15)
			-- upvalues: (copy) v_u_3
			return v_u_3.percentage(p15)
		end
	},
	[v2.World4AttackRange] = {
		["Name"] = "Glow Attack Range",
		["Default"] = 6,
		["Base"] = 0,
		["Icon"] = "rbxassetid://78157289763375",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p16, p17)
			return p16 + p17
		end,
		["Format"] = function(p18)
			return p18
		end
	},
	[v2.GlowCoinsMultiplier] = {
		["Name"] = "Glow Coins Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://85479817882405",
		["Color"] = Color3.fromRGB(50, 255, 68),
		["Calculate"] = function(p19, p20)
			return p19 * p20
		end,
		["Format"] = function(p21)
			-- upvalues: (copy) v_u_3
			if p21 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p21)))
			end
			local v22 = v_u_3.decimal
			local v23 = p21 * 100000
			return ("x%*"):format((v22(math.floor(v23) / 100000)))
		end
	},
	[v2.GloopCollectLuck] = {
		["Name"] = "Gloop Collect Luck",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://124800928454437",
		["Color"] = Color3.fromRGB(82, 255, 125),
		["Calculate"] = function(p24, p25)
			return p24 + p25
		end,
		["Format"] = function(p26)
			local v27 = p26 * 10000
			return ("%*%%"):format(math.floor(v27) / 100)
		end
	},
	[v2.GloopCraftSpeed] = {
		["Name"] = "Gloop Craft Speed",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://124800928454437",
		["Color"] = Color3.fromRGB(82, 255, 125),
		["Calculate"] = function(p28, p29)
			return p28 * p29
		end,
		["Format"] = function(p30)
			return ("x%*"):format(p30)
		end
	}
}
return v31]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GLOOP_MULTIPLIERS]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3911"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Format)
local v64 = {
	[v2.Event1MSpawnCap] = {
		["Name"] = "1M Cap",
		["Default"] = 2,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p4, p5)
			return p4 + p5
		end,
		["Format"] = function(p6)
			return p6
		end
	},
	[v2.Event1MSpawnRate] = {
		["Name"] = "1M Spawn Rate",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://91181531852133",
		["Merge"] = function(p7, p8)
			return p7 + p8
		end,
		["Calculate"] = function(p9, p10)
			local v11 = p9 - p10
			return math.max(v11, 0.1)
		end,
		["Format"] = function(p12)
			return p12 .. "s"
		end
	},
	[v2.Event1MAttackSpeed] = {
		["Name"] = "1M Attack Speed",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://83884379124762",
		["Color"] = Color3.fromRGB(255, 215, 0),
		["Calculate"] = function(p13, p14)
			local v15 = p13 - p14
			return math.max(0.1, v15)
		end,
		["Format"] = function(p16)
			return p16 .. "s"
		end
	},
	[v2.Event1MAttackSpeedMultiplier] = {
		["Name"] = "1M Attack Speed Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://83884379124762",
		["Color"] = Color3.fromRGB(255, 215, 0),
		["Calculate"] = function(p17, p18)
			return p17 * p18
		end,
		["Format"] = function(p19)
			-- upvalues: (copy) v_u_3
			if p19 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p19)))
			end
			local v20 = v_u_3.decimal
			local v21 = p19 * 100000
			return ("x%*"):format((v20(math.floor(v21) / 100000)))
		end
	},
	[v2.Event1MAttackRange] = {
		["Name"] = "1M Attack Range",
		["Default"] = 5,
		["Base"] = 0,
		["Icon"] = "rbxassetid://78157289763375",
		["Calculate"] = function(p22, p23)
			return p22 + p23
		end,
		["Format"] = function(p24)
			return ("+%*"):format(p24)
		end
	},
	[v2.Event1MAttackRangeMultiplier] = {
		["Name"] = "1M Attack Range Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://78157289763375",
		["Calculate"] = function(p25, p26)
			return p25 * p26
		end,
		["Format"] = function(p27)
			-- upvalues: (copy) v_u_3
			if p27 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p27)))
			end
			local v28 = p27 * 100000
			return ("x%*"):format(math.floor(v28) / 100000)
		end
	},
	[v2.Event1MDamage] = {
		["Name"] = "1M Damage",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://106746371164727",
		["Calculate"] = function(p29, p30)
			return p29 + p30
		end,
		["Format"] = function(p31)
			-- upvalues: (copy) v_u_3
			return v_u_3.abbreviateComma(p31)
		end
	},
	[v2.Event1MDamageMultiplier] = {
		["Name"] = "1M Damage Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://106746371164727",
		["Calculate"] = function(p32, p33)
			return p32 * p33
		end,
		["Format"] = function(p34)
			-- upvalues: (copy) v_u_3
			if p34 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p34)))
			end
			local v35 = p34 * 100000
			return ("x%*"):format(math.floor(v35) / 100000)
		end
	},
	[v2.Event1MSlimeLuck] = {
		["Name"] = "1M Slime Luck",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://124800928454437",
		["Calculate"] = function(p36, p37)
			return p36 + p37
		end,
		["Format"] = function(p38)
			-- upvalues: (copy) v_u_3
			return v_u_3.percentage(p38)
		end
	},
	[v2.Event1MBalloonsMultiplier] = {
		["Name"] = "1M Balloons Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://70754291488761",
		["Calculate"] = function(p39, p40)
			return p39 * p40
		end,
		["Format"] = function(p41)
			-- upvalues: (copy) v_u_3
			if p41 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p41)))
			end
			local v42 = p41 * 100000
			return ("x%*"):format(math.floor(v42) / 100000)
		end
	},
	[v2.Event1MStarDropChance] = {
		["Name"] = "1M Star Drop Chance",
		["Default"] = 0.05,
		["Base"] = 0,
		["Icon"] = "rbxassetid://70754291488761",
		["RuneTransform"] = function(p43)
			return p43
		end,
		["Calculate"] = function(p44, p45)
			return p44 + p45
		end,
		["Format"] = function(p46)
			-- upvalues: (copy) v_u_3
			return v_u_3.percentage(p46)
		end
	},
	[v2.Event1MStars] = {
		["Name"] = "1M Stars",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://70754291488761",
		["Calculate"] = function(p47, p48)
			return p47 + p48
		end,
		["Format"] = function(p49)
			return p49
		end
	},
	[v2.Event1MStarMultiplier] = {
		["Name"] = "1M Star Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://70754291488761",
		["Calculate"] = function(p50, p51)
			return p50 * p51
		end,
		["Format"] = function(p52)
			-- upvalues: (copy) v_u_3
			if p52 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p52)))
			end
			local v53 = p52 * 100000
			return ("x%*"):format(math.floor(v53) / 100000)
		end
	},
	[v2.MillionaireTraitsLuck] = {
		["Name"] = "1M Traits Luck",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://124800928454437",
		["Color"] = Color3.fromRGB(255, 215, 0),
		["Calculate"] = function(p54, p55)
			return p54 + p55
		end,
		["Format"] = function(p56)
			-- upvalues: (copy) v_u_3
			local v57 = v_u_3.abbreviate
			local v58 = p56 * 1000
			return ("+%*"):format((v57(math.floor(v58) / 1000)))
		end
	},
	[v2.MillionaireTraitsLuckMultiplier] = {
		["Name"] = "1M Traits Luck Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://124800928454437",
		["Color"] = Color3.fromRGB(255, 215, 0),
		["Calculate"] = function(p59, p60)
			return p59 * p60
		end,
		["Format"] = function(p61)
			-- upvalues: (copy) v_u_3
			if p61 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p61)))
			end
			local v62 = v_u_3.decimal
			local v63 = p61 * 100000
			return ("x%*"):format((v62(math.floor(v63) / 100000)))
		end
	}
}
return v64]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[EVENT_1M_MULTIPLIER]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3912"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Format)
local v35 = {
	[v2.ConfettiMultiplier] = {
		["Name"] = "Confetti Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://122967445525805",
		["Color"] = Color3.fromRGB(81, 235, 255),
		["Calculate"] = function(p4, p5)
			return p4 * p5
		end,
		["Format"] = function(p6)
			-- upvalues: (copy) v_u_3
			if p6 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p6)))
			end
			local v7 = v_u_3.decimal
			local v8 = p6 * 100000
			return ("x%*"):format((v7(math.floor(v8) / 100000)))
		end
	},
	[v2.ConfettiBaseValue] = {
		["Name"] = "Confetti Base Value",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://122967445525805",
		["Color"] = Color3.fromRGB(81, 235, 255),
		["Calculate"] = function(p9, p10)
			return p9 + p10
		end,
		["Format"] = function(p11)
			-- upvalues: (copy) v_u_3
			return v_u_3.abbreviateComma(p11)
		end
	},
	[v2.ConfettiClickSpeed] = {
		["Name"] = "Click Cooldown",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://83884379124762",
		["Color"] = Color3.fromRGB(81, 235, 255),
		["Merge"] = function(p12, p13)
			return p12 + p13
		end,
		["Calculate"] = function(p14, p15)
			local v16 = p14 - p15
			return math.max(v16, 0.1)
		end,
		["Format"] = function(p17)
			return p17 .. "s"
		end
	},
	[v2.ConfettiAutoClick] = {
		["Name"] = "Auto Clicks/s",
		["Default"] = 0,
		["Base"] = 0,
		["Icon"] = "rbxassetid://122967445525805",
		["Color"] = Color3.fromRGB(81, 235, 255),
		["Calculate"] = function(p18, p19)
			return p18 + p19
		end,
		["Format"] = function(p20)
			-- upvalues: (copy) v_u_3
			return ("%*/s"):format((v_u_3.abbreviateComma(p20)))
		end
	},
	[v2.ConfettiAutoMultiplier] = {
		["Name"] = "Auto Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://122967445525805",
		["Color"] = Color3.fromRGB(81, 235, 255),
		["Calculate"] = function(p21, p22)
			return p21 * p22
		end,
		["Format"] = function(p23)
			-- upvalues: (copy) v_u_3
			if p23 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p23)))
			end
			local v24 = v_u_3.decimal
			local v25 = p23 * 100000
			return ("x%*"):format((v24(math.floor(v25) / 100000)))
		end
	},
	[v2.ConfettiCriticalChance] = {
		["Name"] = "Critical Click Chance",
		["Default"] = 0,
		["Base"] = 0,
		["Icon"] = "rbxassetid://122967445525805",
		["Color"] = Color3.fromRGB(255, 215, 0),
		["Calculate"] = function(p26, p27)
			local v28 = p26 + p27
			return math.min(v28, 1)
		end,
		["Format"] = function(p29)
			-- upvalues: (copy) v_u_3
			return v_u_3.percentage(p29)
		end
	},
	[v2.ConfettiCriticalMultiplier] = {
		["Name"] = "Critical Click Power",
		["Default"] = 2,
		["Base"] = 0,
		["Icon"] = "rbxassetid://122967445525805",
		["Color"] = Color3.fromRGB(255, 215, 0),
		["Calculate"] = function(p30, p31)
			return p30 + p31
		end,
		["Format"] = function(p32)
			-- upvalues: (copy) v_u_3
			local v33 = v_u_3.decimal
			local v34 = p32 * 100
			return ("x%*"):format((v33(math.floor(v34) / 100)))
		end
	}
}
return v35]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CONFETTI_MULTIPLIER]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3913"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Format)
local v33 = {
	[v2.Event1MRuneBulk] = {
		["Name"] = "1M Rune Bulk",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["RuneTransform"] = function(p4)
			return p4
		end,
		["Calculate"] = function(p5, p6)
			return p5 + p6
		end,
		["Format"] = function(p7)
			return p7
		end
	},
	[v2.Event1MRuneBulkMultiplier] = {
		["Name"] = "1M Rune Bulk Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p8, p9)
			return p8 * p9
		end,
		["Format"] = function(p10)
			-- upvalues: (copy) v_u_3
			if p10 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p10)))
			end
			local v11 = v_u_3.decimal
			local v12 = p10 * 100000
			return ("x%*"):format((v11(math.floor(v12) / 100000)))
		end
	},
	[v2.Event1MRuneLuck] = {
		["Name"] = "1M Rune Luck",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://124800928454437",
		["Color"] = Color3.fromRGB(255, 215, 0),
		["RuneTransform"] = function(p13)
			return p13
		end,
		["Calculate"] = function(p14, p15)
			return p14 + p15
		end,
		["Format"] = function(p16)
			-- upvalues: (copy) v_u_3
			local v17 = v_u_3.abbreviate
			local v18 = p16 * 1000
			return ("+%*"):format((v17(math.floor(v18) / 1000)))
		end
	},
	[v2.Event1MRuneLuckMultiplier] = {
		["Name"] = "1M Rune Luck Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://124800928454437",
		["Color"] = Color3.fromRGB(255, 215, 0),
		["Calculate"] = function(p19, p20)
			return p19 * p20
		end,
		["Format"] = function(p21)
			-- upvalues: (copy) v_u_3
			if p21 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p21)))
			end
			local v22 = v_u_3.decimal
			local v23 = p21 * 100000
			return ("x%*"):format((v22(math.floor(v23) / 100000)))
		end
	},
	[v2.Event1MRuneOpenTime] = {
		["Name"] = "1M Rune Open Time",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["RuneTransform"] = function(p24)
			return p24
		end,
		["Calculate"] = function(p25, p26)
			return p25 + p26
		end,
		["Format"] = function(p27)
			return p27
		end
	},
	[v2.Event1MRuneOpenTimeMultiplier] = {
		["Name"] = "1M Rune Open Time Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p28, p29)
			return p28 * p29
		end,
		["Format"] = function(p30)
			-- upvalues: (copy) v_u_3
			if p30 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p30)))
			end
			local v31 = v_u_3.decimal
			local v32 = p30 * 100000
			return ("x%*"):format((v31(math.floor(v32) / 100000)))
		end
	}
}
return v33]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[EVENT_1M_RUNE_MULTIPLIER]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3914"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Format)
local v25 = {
	[v2.World5SpawnCap] = {
		["Name"] = "Candy Slime Cap",
		["Default"] = 2,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Calculate"] = function(p4, p5)
			return p4 + p5
		end,
		["Format"] = function(p6)
			return p6
		end
	},
	[v2.World5SpawnRate] = {
		["Name"] = "Candy Slime Spawn Rate",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://92458066679384",
		["Merge"] = function(p7, p8)
			return p7 + p8
		end,
		["Calculate"] = function(p9, p10)
			local v11 = p9 - p10
			return math.max(v11, 0.1)
		end,
		["Format"] = function(p12)
			return p12 .. "s"
		end
	},
	[v2.World5SlimeLuck] = {
		["Name"] = "Candy Slime Luck",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://124800928454437",
		["Calculate"] = function(p13, p14)
			return p13 + p14
		end,
		["Format"] = function(p15)
			local v16 = p15 * 100
			return ("%*%%"):format((math.floor(v16)))
		end
	},
	[v2.World5AttackRange] = {
		["Name"] = "Candy Attack Range",
		["Default"] = 6,
		["Base"] = 0,
		["Icon"] = "rbxassetid://78157289763375",
		["Color"] = Color3.fromRGB(255, 132, 132),
		["Calculate"] = function(p17, p18)
			return p17 + p18
		end,
		["Format"] = function(p19)
			return p19
		end
	},
	[v2.CandyCoinsMultiplier] = {
		["Name"] = "Candy Coins Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://107119582007802",
		["Color"] = Color3.fromRGB(255, 105, 180),
		["Calculate"] = function(p20, p21)
			return p20 * p21
		end,
		["Format"] = function(p22)
			-- upvalues: (copy) v_u_3
			if p22 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p22)))
			end
			local v23 = v_u_3.decimal
			local v24 = p22 * 100000
			return ("x%*"):format((v23(math.floor(v24) / 100000)))
		end
	}
}
return v25]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CANDY_MULTIPLIERS]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3915"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Format)
local v66 = {
	[v2.PetAttackSpeed] = {
		["Name"] = "Pet Attack Speed",
		["Default"] = 2,
		["Base"] = 0,
		["Icon"] = "rbxassetid://83884379124762",
		["Color"] = Color3.fromRGB(255, 180, 100),
		["Merge"] = function(p4, p5)
			return p4 + p5
		end,
		["Calculate"] = function(p6, p7)
			local v8 = p6 - p7
			return math.max(0.3, v8)
		end,
		["Format"] = function(p9)
			return p9 .. "s"
		end
	},
	[v2.PetAttackSpeedMultiplier] = {
		["Name"] = "Pet Attack Speed Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://83884379124762",
		["Color"] = Color3.fromRGB(255, 180, 100),
		["Calculate"] = function(p10, p11)
			return p10 * p11
		end,
		["Format"] = function(p12)
			-- upvalues: (copy) v_u_3
			if p12 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p12)))
			end
			local v13 = v_u_3.decimal
			local v14 = p12 * 100000
			return ("x%*"):format((v13(math.floor(v14) / 100000)))
		end
	},
	[v2.PetDamagePercent] = {
		["Name"] = "Pet Damage %",
		["Default"] = 0.05,
		["Base"] = 0,
		["Icon"] = "rbxassetid://106746371164727",
		["Color"] = Color3.fromRGB(255, 100, 100),
		["Calculate"] = function(p15, p16)
			local v17 = p15 + p16
			return math.min(v17, 1)
		end,
		["Format"] = function(p18)
			-- upvalues: (copy) v_u_3
			return ("%*%%"):format((v_u_3.decimal(p18 * 100, 1)))
		end
	},
	[v2.PetDamagePercentMultiplier] = {
		["Name"] = "Pet Damage Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://106746371164727",
		["Color"] = Color3.fromRGB(255, 100, 100),
		["Calculate"] = function(p19, p20)
			return p19 * p20
		end,
		["Format"] = function(p21)
			-- upvalues: (copy) v_u_3
			if p21 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p21)))
			end
			local v22 = v_u_3.decimal
			local v23 = p21 * 100000
			return ("x%*"):format((v22(math.floor(v23) / 100000)))
		end
	},
	[v2.PetAgility] = {
		["Name"] = "Pet Agility",
		["Default"] = 12,
		["Base"] = 0,
		["Icon"] = "rbxassetid://83884379124762",
		["Color"] = Color3.fromRGB(100, 255, 180),
		["Calculate"] = function(p24, p25)
			return p24 + p25
		end,
		["Format"] = function(p26)
			-- upvalues: (copy) v_u_3
			return ("%* studs/s"):format((v_u_3.decimal(p26, 1)))
		end
	},
	[v2.PetAgilityMultiplier] = {
		["Name"] = "Pet Agility Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://83884379124762",
		["Color"] = Color3.fromRGB(100, 255, 180),
		["Calculate"] = function(p27, p28)
			return p27 * p28
		end,
		["Format"] = function(p29)
			-- upvalues: (copy) v_u_3
			if p29 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p29)))
			end
			local v30 = v_u_3.decimal
			local v31 = p29 * 100000
			return ("x%*"):format((v30(math.floor(v31) / 100000)))
		end
	},
	[v2.PetCoinMultiplier] = {
		["Name"] = "Pet Coin Bonus",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://106746371164727",
		["Color"] = Color3.fromRGB(255, 223, 0),
		["Calculate"] = function(p32, p33)
			return p32 * p33
		end,
		["Format"] = function(p34)
			-- upvalues: (copy) v_u_3
			if p34 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p34)))
			end
			local v35 = v_u_3.decimal
			local v36 = p34 * 100000
			return ("x%*"):format((v35(math.floor(v36) / 100000)))
		end
	},
	[v2.PetRange] = {
		["Name"] = "Pet Range",
		["Default"] = 4,
		["Base"] = 0,
		["Icon"] = "rbxassetid://78157289763375",
		["Color"] = Color3.fromRGB(180, 180, 255),
		["Calculate"] = function(p37, p38)
			return p37 + p38
		end,
		["Format"] = function(p39)
			return p39
		end
	},
	[v2.PetRangeMultiplier] = {
		["Name"] = "Pet Range Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://78157289763375",
		["Color"] = Color3.fromRGB(180, 180, 255),
		["Calculate"] = function(p40, p41)
			return p40 * p41
		end,
		["Format"] = function(p42)
			-- upvalues: (copy) v_u_3
			if p42 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p42)))
			end
			local v43 = v_u_3.decimal
			local v44 = p42 * 100000
			return ("x%*"):format((v43(math.floor(v44) / 100000)))
		end
	},
	[v2.PetCritChance] = {
		["Name"] = "Pet Critical Chance",
		["Default"] = 0.01,
		["Base"] = 0,
		["Icon"] = "rbxassetid://00000000",
		["Color"] = Color3.fromRGB(255, 188, 63),
		["Calculate"] = function(p45, p46)
			return p45 + p46
		end,
		["Format"] = function(p47)
			-- upvalues: (copy) v_u_3
			return ("%*%%"):format((v_u_3.decimal(p47 * 100, 2)))
		end
	},
	[v2.PetXP] = {
		["Name"] = "Pet XP",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://00000000",
		["Color"] = Color3.fromRGB(150, 255, 150),
		["Calculate"] = function(p48, p49)
			return p48 + p49
		end,
		["Format"] = function(p50)
			return ("+%*"):format(p50)
		end
	},
	[v2.PetXPMultiplier] = {
		["Name"] = "Pet XP Multiplier",
		["Default"] = 1,
		["Base"] = 1,
		["Icon"] = "rbxassetid://00000000",
		["Color"] = Color3.fromRGB(150, 255, 150),
		["Calculate"] = function(p51, p52)
			return p51 * p52
		end,
		["Format"] = function(p53)
			-- upvalues: (copy) v_u_3
			if p53 >= 1000 then
				return ("x%*"):format((v_u_3.abbreviate(p53)))
			end
			local v54 = v_u_3.decimal
			local v55 = p53 * 100000
			return ("x%*"):format((v54(math.floor(v55) / 100000)))
		end
	},
	[v2.PetRollLuck] = {
		["Name"] = "Pet Roll Luck",
		["Default"] = 1,
		["Base"] = 0,
		["Icon"] = "rbxassetid://00000000",
		["Color"] = Color3.fromRGB(255, 200, 100),
		["Calculate"] = function(p56, p57)
			return p56 + p57
		end,
		["Format"] = function(p58)
			-- upvalues: (copy) v_u_3
			local v59 = v_u_3.abbreviate
			local v60 = p58 * 1000
			return ("+%*"):format((v59(math.floor(v60) / 1000)))
		end
	},
	[v2.PetRaceLuck] = {
		["Name"] = "Pet Race Luck",
		["Default"] = 0,
		["Base"] = 0,
		["Icon"] = "rbxassetid://124800928454437",
		["Color"] = Color3.fromRGB(255, 180, 80),
		["Calculate"] = function(p61, p62)
			return p61 + p62
		end,
		["Format"] = function(p63)
			-- upvalues: (copy) v_u_3
			local v64 = v_u_3.decimal
			local v65 = p63 * 100
			return ("+%*"):format((v64(math.floor(v65) / 100)))
		end
	}
}
return v66]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PET_MULTIPLIERS]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3916"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.RarityTypes)
local v3 = {
	[v2.Common] = {
		["Name"] = "Common",
		["Order"] = 1,
		["Color"] = Color3.fromRGB(255, 255, 255),
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 180, 180)), ColorSequenceKeypoint.new(1, Color3.fromRGB(117, 117, 117)) })
	},
	[v2.Uncommon] = {
		["Name"] = "Uncommon",
		["Order"] = 2,
		["Color"] = Color3.fromRGB(30, 255, 0),
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(53, 245, 53)), ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 255, 0)) })
	},
	[v2.Rare] = {
		["Name"] = "Rare",
		["Order"] = 3,
		["Color"] = Color3.fromRGB(0, 112, 221),
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 252, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(57, 156, 255)) })
	},
	[v2.Epic] = {
		["Name"] = "Epic",
		["Order"] = 4,
		["Color"] = Color3.fromRGB(163, 53, 238),
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(207, 75, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 39, 255)) })
	},
	[v2.Legendary] = {
		["Name"] = "Legendary",
		["Order"] = 5,
		["Color"] = Color3.fromRGB(255, 128, 0),
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 142, 67)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 128, 0)) })
	},
	[v2.Mythical] = {
		["Name"] = "Mythical",
		["Order"] = 6,
		["Color"] = Color3.fromRGB(255, 0, 255),
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 88, 88)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 52, 52)) })
	},
	[v2.Secret] = {
		["Name"] = "Secret",
		["Order"] = 7,
		["Color"] = Color3.fromRGB(255, 215, 0),
		["Animated"] = true,
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
	}
}
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RarityData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3917"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
require(v1.Enums.LockTypes)
local v2 = require(v1.Enums.SettingCategoryTypes)
local v3 = require(v1.Enums.SettingTypes)
local v4 = {
	[v3.Music] = {
		["Name"] = "Music",
		["Description"] = "Toggle Music",
		["Default"] = true,
		["Order"] = 1,
		["Category"] = v2.Sound
	},
	[v3.SFX] = {
		["Name"] = "Sound Effects",
		["Description"] = "Toggle Sound Effects",
		["Default"] = true,
		["Order"] = 2,
		["Category"] = v2.Sound
	},
	[v3.RunePopup] = {
		["Name"] = "Rune Popups",
		["Description"] = "Toggle Rune Popups",
		["Default"] = true,
		["Order"] = 1,
		["Category"] = v2.UI
	},
	[v3.CurrencyPopup] = {
		["Name"] = "Currency Popups",
		["Description"] = "Toggle Currency Popups (On Screen)",
		["Default"] = true,
		["Order"] = 2,
		["Category"] = v2.UI
	},
	[v3.AutoCurrencyPopup] = {
		["Name"] = "Auto Currency Popups",
		["Description"] = "Toggle Auto Currency Popups (Top Right)",
		["Default"] = true,
		["Order"] = 3,
		["Category"] = v2.UI
	},
	[v3.RuneMessages] = {
		["Name"] = "Rune Messages",
		["Description"] = "Toggle Rune Messages",
		["Default"] = true,
		["Order"] = 4,
		["Category"] = v2.UI
	},
	[v3.GlobalMessages] = {
		["Name"] = "Global Messages",
		["Description"] = "Toggle Global Messages",
		["Default"] = true,
		["Order"] = 5,
		["Category"] = v2.UI
	},
	[v3.HideMaxedUpgrades] = {
		["Name"] = "Hide Maxed Upgrades",
		["Description"] = "Hide upgrades that are already maxed out",
		["Default"] = true,
		["Order"] = 6,
		["Category"] = v2.UI
	},
	[v3.HideLeaderboardTags] = {
		["Name"] = "Hide Leaderboard Tags",
		["Description"] = "Toggle visibility of leaderboard tags in chat",
		["Default"] = false,
		["Order"] = 7,
		["Category"] = v2.UI
	},
	[v3.TipMessages] = {
		["Name"] = "Tip Messages",
		["Description"] = "Toggle Tip Messages",
		["Default"] = true,
		["Order"] = 8,
		["Category"] = v2.UI
	},
	[v3.CameraShakes] = {
		["Name"] = "Enable Camera Shakes",
		["Description"] = "Toggle Camera Shakes",
		["Default"] = true,
		["Order"] = 0,
		["Category"] = v2.Gameplay
	},
	[v3.RuneLuck] = {
		["Name"] = "Rune Luck",
		["Description"] = "Toggle increased rune luck",
		["Default"] = true,
		["Order"] = 1,
		["Category"] = v2.Gameplay
	},
	[v3.BuyMaxUpgradeTree] = {
		["Name"] = "Buy Max Upgrade Tree",
		["Description"] = "Purchase the maximum affordable levels in one click",
		["Default"] = false,
		["Order"] = 2,
		["Category"] = v2.Gameplay
	},
	[v3.VFX] = {
		["Name"] = "Visual Effects",
		["Description"] = "Toggle Visual Effects",
		["Default"] = true,
		["Order"] = 2,
		["Category"] = v2.Performance
	},
	[v3.DamageIndicators] = {
		["Name"] = "Damage Indicators",
		["Description"] = "Toggle Damage Indicators",
		["Default"] = true,
		["Order"] = 3,
		["Category"] = v2.Performance
	},
	[v3.HideOtherPlayers] = {
		["Name"] = "Hide Other Players",
		["Description"] = "Toggle visibility of other players in the world",
		["Default"] = false,
		["Order"] = 1,
		["Category"] = v2.World
	},
	[v3.HideOtherPets] = {
		["Name"] = "Hide Other Pets",
		["Description"] = "Toggle visibility of other players\' pet slimes",
		["Default"] = false,
		["Order"] = 3,
		["Category"] = v2.World
	},
	[v3.ShowWorldCurrency] = {
		["Name"] = "Show World Currency",
		["Description"] = "Toggle visibility of world currency pickups",
		["Default"] = true,
		["Order"] = 2,
		["Category"] = v2.World
	},
	[v3.CandyZonePriority] = {
		["Name"] = "Candy Zone Priority",
		["Description"] = "Choose which candy zone slimes spawn in",
		["Default"] = "Auto",
		["Order"] = 4,
		["Category"] = v2.World,
		["Options"] = {
			"Auto",
			"1",
			"2",
			"3",
			"4",
			"5",
			"6"
		}
	}
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SettingData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3918"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.SettingCategoryTypes)
local v3 = {
	[v2.Sound] = {
		["Name"] = "Sounds",
		["Order"] = 1
	},
	[v2.World] = {
		["Name"] = "World",
		["Order"] = 2
	},
	[v2.Gameplay] = {
		["Name"] = "Gameplay",
		["Order"] = 3
	},
	[v2.UI] = {
		["Name"] = "UI",
		["Order"] = 4
	},
	[v2.Performance] = {
		["Name"] = "Performance",
		["Order"] = 5
	}
}
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SettingsCategoryData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3919"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(script.Parent.Colors)
local v3 = require(v1.Enums.StatisticCategoryType)
local v4 = {
	[v3.Gameplay] = {
		["Name"] = "Gameplay",
		["Order"] = 1,
		["Gradient"] = v2.Blue.Gradient
	},
	[v3.Currency] = {
		["Name"] = "Currency",
		["Order"] = 2,
		["Gradient"] = v2.Yellow.Gradient
	},
	[v3.Monetization] = {
		["Name"] = "Monetization",
		["Order"] = 3,
		["Gradient"] = v2.Green.Gradient
	},
	[v3.Runes] = {
		["Name"] = "Runes",
		["Order"] = 4,
		["Gradient"] = v2.Red.Gradient
	}
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[StatisticCategoryData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3920"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.LockTypes)
local v_u_3 = require(script.Parent.Constants)
local v_u_4 = require(v1.Enums.MultiplierTypes)
local v5 = require(v1.Enums.StatisticCategoryType)
local v6 = require(script.Parent.CurrencyData)
local v7 = require(script.Parent.RuneOpenData)
local v8 = require(v1.Enums.StatisticTypes)
local v9 = require(v1.Enums.WorldTypes)
local v_u_10 = require(v1.Utility.Format)
local v_u_11 = require(v1.Utility.Multiplier)
local v_u_12 = require(v1.Utility.Time)
local v16 = {
	[v8.Playtime] = {
		["Name"] = "Playtime",
		["Order"] = 1,
		["Category"] = v5.Gameplay,
		["Default"] = 0,
		["Format"] = function(p13)
			-- upvalues: (copy) v_u_12
			return v_u_12.format(p13)
		end
	},
	[v8.SlimesDefeated] = {
		["Name"] = "Slimes Defeated",
		["Order"] = 3,
		["Category"] = v5.Gameplay,
		["Default"] = 0,
		["Format"] = function(p14)
			-- upvalues: (copy) v_u_10
			return v_u_10.abbreviateComma((math.floor(p14)))
		end
	},
	[v8.RobuxSpent] = {
		["Name"] = "Robux Spent",
		["Order"] = 2,
		["Category"] = v5.Monetization,
		["Default"] = 0,
		["Format"] = function(p15)
			-- upvalues: (copy) v_u_10
			return v_u_10.robux(p15)
		end
	}
}
local v17 = v8.IceWorldHighestRound
local v18 = {
	["Name"] = "Ice World Highest Round",
	["Order"] = 5,
	["Category"] = v5.Gameplay,
	["Default"] = 0
}
local v19 = {
	[v2.World] = {
		["value"] = v9.ICE_WORLD
	}
}
v18.LockedData = v19
function v18.Format(p20)
	-- upvalues: (copy) v_u_10
	return v_u_10.abbreviateComma((math.floor(p20)))
end
v16[v17] = v18
v16[v8.RunesOpened] = {
	["Name"] = "Runes Opened",
	["Order"] = 19,
	["Category"] = v5.Runes,
	["Default"] = 0,
	["Format"] = function(p21)
		-- upvalues: (copy) v_u_10
		return v_u_10.abbreviateComma((math.floor(p21)))
	end
}
v16[v8.RuneLuck] = {
	["Name"] = "Rune Luck",
	["Order"] = 8,
	["Category"] = v5.Runes,
	["Updates"] = { v_u_4.RuneLuck, v_u_4.RuneLuckMultiplier },
	["GetFullValue"] = function()
		-- upvalues: (copy) v_u_11, (copy) v_u_4, (copy) v_u_3
		local v22 = v_u_11.get(v_u_4.RuneLuck)
		local v23 = v_u_11.get(v_u_4.RuneLuckMultiplier)
		if not v_u_3.IS_DEV then
			local v24 = v22 * v23 * 100
			return math.floor(v24) / 100
		end
		local v25 = v22 * 100
		local v26 = math.floor(v25) / 100
		local v27 = v23 * 100
		local v28 = math.floor(v27) / 100
		local v29 = v22 * v23 * 100
		return ("%* x %* = %*"):format(v26, v28, math.floor(v29) / 100)
	end,
	["GetValue"] = function(p30, p31)
		return p30 * p31
	end,
	["Default"] = 0,
	["Format"] = function(p32)
		-- upvalues: (copy) v_u_10
		local v33 = v_u_10.abbreviate
		local v34 = p32 * 1000
		return ("x%*"):format((v33(math.floor(v34) / 1000)))
	end
}
v16[v8.RuneBulk] = {
	["Name"] = "Rune Bulk",
	["Order"] = 9,
	["Category"] = v5.Runes,
	["Updates"] = {
		v_u_4.RuneBulk,
		v_u_4.RuneBulkMultiplier,
		v_u_4.RuneOpenTime,
		v_u_4.RuneOpenTimeMultiplier
	},
	["GetFullValue"] = function()
		-- upvalues: (copy) v_u_11, (copy) v_u_4, (copy) v_u_3
		local v35 = v_u_11.get(v_u_4.RuneBulk)
		local v36 = v_u_11.get(v_u_4.RuneBulkMultiplier)
		local v37 = v35 * v36
		local v38 = v_u_3.RUNE_SPEED_CAP
		local v39 = v_u_11.get(v_u_4.RuneOpenTime) / v_u_11.get(v_u_4.RuneOpenTimeMultiplier)
		local v40
		if v39 < v38 then
			local v41 = (v38 - v39) / 0.05
			v40 = math.floor(v41) * 0.001 + 1
		else
			v40 = 1
		end
		if v_u_3.IS_DEV then
			local v42 = v35 * v36 * 100
			return ("%* x %*(%*) = %*"):format(v35, v36, v40, math.floor(v42) / 100)
		else
			local v43 = v37 * v40
			return math.floor(v43)
		end
	end,
	["Default"] = 0,
	["Format"] = function(p44)
		-- upvalues: (copy) v_u_10
		return ("%*"):format((v_u_10.abbreviateComma((math.floor(p44)))))
	end
}
local v45 = v_u_4.RuneOpenTime
local v51 = {
	["Name"] = "Rune Open Time",
	["Order"] = 13,
	["Category"] = v5.Runes,
	["Multiplier"] = {
		["base"] = v_u_4.RuneOpenTime,
		["multiplier"] = v_u_4.RuneOpenTimeMultiplier
	},
	["GetValue"] = function(p46, p47)
		-- upvalues: (copy) v_u_3
		local v48 = p46 / p47
		local v49 = v_u_3.RUNE_SPEED_CAP
		return math.max(v48, v49)
	end,
	["Default"] = 0,
	["Format"] = function(p50)
		-- upvalues: (copy) v_u_10
		return ("%*s"):format((v_u_10.decimal(p50, 2)))
	end
}
v16[v45] = v51
local v52 = v_u_4.RuneCloneChance
local v54 = {
	["Name"] = "Rune Clone Chance",
	["Order"] = 14,
	["Category"] = v5.Runes,
	["Multiplier"] = {
		["base"] = v_u_4.RuneCloneChance
	},
	["Default"] = 0,
	["Format"] = function(p53)
		-- upvalues: (copy) v_u_10
		return ("%*%%"):format((v_u_10.decimal(p53 * 100, 2)))
	end
}
v16[v52] = v54
local v55 = v_u_4.RuneClone
local v57 = {
	["Name"] = "Rune Clone",
	["Order"] = 15,
	["Category"] = v5.Runes,
	["Multiplier"] = {
		["base"] = v_u_4.RuneClone,
		["multiplier"] = v_u_4.RuneCloneMultiplier
	},
	["Default"] = 0,
	["Format"] = function(p56)
		-- upvalues: (copy) v_u_10
		return ("%*"):format((v_u_10.abbreviateComma((math.floor(p56)))))
	end
}
v16[v55] = v57
v16.RunePerSecond = {
	["Name"] = "Runes Per Second",
	["Order"] = 16,
	["Category"] = v5.Runes,
	["Updates"] = {
		v_u_4.RuneBulk,
		v_u_4.RuneBulkMultiplier,
		v_u_4.RuneOpenTime,
		v_u_4.RuneOpenTimeMultiplier
	},
	["GetFullValue"] = function()
		-- upvalues: (copy) v_u_11, (copy) v_u_4, (copy) v_u_3
		local v58 = v_u_11.get(v_u_4.RuneBulk) * v_u_11.get(v_u_4.RuneBulkMultiplier)
		local v59 = v_u_3.RUNE_SPEED_CAP
		local v60 = v_u_11.get(v_u_4.RuneOpenTime) / v_u_11.get(v_u_4.RuneOpenTimeMultiplier)
		local v61
		if v60 < v59 then
			local v62 = (v59 - v60) / 0.05
			v61 = math.floor(v62) * 0.001 + 1
		else
			v61 = 1
		end
		local v63 = v58 * v61
		return math.floor(v63) / math.max(v60, v59)
	end,
	["Default"] = 0,
	["Format"] = function(p64)
		-- upvalues: (copy) v_u_10
		return ("%*"):format((v_u_10.abbreviateComma(p64)))
	end
}
v16[v8.IceBossDefeated] = {
	["Name"] = "Ice Boss Defeated",
	["Order"] = 20,
	["Category"] = v5.Gameplay,
	["Default"] = 0,
	["Format"] = function(p65)
		-- upvalues: (copy) v_u_10
		return v_u_10.abbreviateComma((math.floor(p65)))
	end
}
for v66, v_u_67 in v6 do
	v16[v8[("Total%*"):format(v66)]] = {
		["Name"] = ("Total %*"):format(v_u_67.Name),
		["Order"] = 10 + v_u_67.Order,
		["Category"] = v5.Currency,
		["Default"] = 0,
		["CanShow"] = function(_, p68)
			-- upvalues: (copy) v_u_67
			return v_u_67.Order <= 1 and true or p68 > 0
		end,
		["Format"] = function(p69)
			-- upvalues: (copy) v_u_10
			return v_u_10.abbreviateComma((math.floor(p69)))
		end
	}
end
for v70, v71 in v7 do
	v16[v8[("Rune%*Opened"):format(v70)]] = {
		["Name"] = ("%* Opened"):format(v71.Name),
		["Order"] = 30 + v71.Order,
		["Category"] = v5.Runes,
		["Default"] = 0,
		["Format"] = function(p72)
			-- upvalues: (copy) v_u_10
			return v_u_10.abbreviateComma((math.floor(p72)))
		end
	}
end
return v16]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[StatisticsData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3921"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v3 = {
	["global"] = {
		["Name"] = "\240\159\140\141 Global",
		["OnIncomingMessage"] = function(_, p1)
			local v2 = Instance.new("TextChatMessageProperties")
			if p1.TextSource then
				v2.Text = "You can\'t type in this chat!"
			end
			return v2
		end,
		["ShouldDeliverCallback"] = function()
			return false
		end
	}
}
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TextChannels]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3922"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
return {
	{
		["type"] = v2.SkillXPMultiplier,
		["value"] = 1.5,
		["text"] = "x1.5 Skill XP"
	},
	{
		["type"] = v2.RuneLuckMultiplier,
		["value"] = 1.5,
		["text"] = "x1.5 Rune Luck"
	},
	{
		["type"] = v2.RuneBulk,
		["value"] = 25,
		["text"] = "+25 Rune Bulk"
	},
	{
		["type"] = v2.ValentineTraitsLuckMultiplier,
		["value"] = 1.25,
		["text"] = "x1.25 Valentine Traits Luck"
	}
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WeekendBuffData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3923"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(script.Parent.CurrencyData)
local v3 = require(script.Parent.GloopData)
local v4 = require(script.Parent.PotionData)
local v5 = require(script.Parent.RuneData)
local v6 = require(script.Parent.RuneOpenData)
local v7 = require(script.Parent.TempBoostData)
local v8 = require(v1.Enums.ItemTypes)
local v9 = {
	[v8.Potions] = v4,
	[v8.Currency] = v2,
	[v8.RuneOpen] = v6,
	[v8.Runes] = v5,
	[v8.SkillXP] = {
		["Name"] = "Skill XP",
		["Icon"] = "rbxassetid://120218417094163",
		["Color"] = Color3.fromRGB(196, 61, 201)
	},
	[v8.TempBuffs] = v7,
	[v8.Gloop] = v3
}
return v9]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ItemData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3924"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = require(v1.Enums.RuneTypes)
local v5 = require(script.Parent.SimulationEngine)
local v_u_6 = require(script.Parent.UpgradeBoardData)
local v_u_7 = require(script.Parent.UpgradeTreeData)
local v8 = v5.createState
local v20 = {
	["world"] = "GLOW_WORLD",
	["boardLevels"] = (function(p9)
		-- upvalues: (copy) v_u_6
		local v10 = {}
		for v11, v12 in p9 do
			local v13 = v_u_6[v11]
			if v13 then
				local v14 = v13.MaxLevel
				v10[v11] = math.min(v12, v14)
			end
		end
		return v10
	end)({
		["REBIRTH_MULTIPLIER"] = 999,
		["DAMAGE_MULTIPLIER"] = 999,
		["COIN_MULTIPLIER_2"] = 999,
		["FIRE_COIN_MULTIPLIER_1"] = 999,
		["ICE_COIN_MULTIPLIER_1"] = 99999,
		["DAMAGE_MULTIPLIER_II"] = 9999,
		["SLIME_SPAWN_CAP"] = 999,
		["SLIME_SPAWN_SPEED"] = 999,
		["SLIME_LUCK"] = 999,
		["DAMAGE_INCREASE"] = 9999,
		["RANGE_INCREASE_1"] = 999,
		["COIN_MULTIPLIER"] = 999,
		["RUNE_BULK_1"] = 9999,
		["RUNE_LUCK"] = 19992,
		["RUNE_SPEED_MULTIPLIER_1"] = 9999,
		["SLIME_SPAWN_CAP_2"] = 9999,
		["SLIME_SPAWN_SPEED_2"] = 9999,
		["SLIME_LUCK_2"] = 99999,
		["RANGE_INCREASE_2"] = 99999,
		["DAMAGE_INCREASE_2"] = 9999,
		["FIRE_COIN_MULTIPLIER_2"] = 99999,
		["DAMAGE_INCREASE_3"] = 999999,
		["ICE_COIN_MULTIPLIER_2"] = 999999,
		["SLIME_SPAWN_SPEED_3"] = 24,
		["SLIME_DURATION_1"] = 999999,
		["SLIME_DURATION_2"] = 4,
		["DAMAGE_INCREASE_4"] = 10,
		["VALENTINE_SLIME_SPAWN_CAP"] = 9999,
		["VALENTINE_SLIME_SPAWN_CAP_2"] = 9999,
		["VALENTINE_SLIME_SPAWN_CAP_3"] = 9999,
		["VALENTINE_SLIME_SPAWN_SPEED"] = 9999,
		["VALENTINE_SLIME_SPAWN_SPEED_2"] = 9999,
		["VALENTINE_RANGE_INCREASE_1"] = 9999,
		["VALENTINE_DAMAGE_INCREASE"] = 9999,
		["VALENTINE_DAMAGE_INCREASE_2"] = 9999,
		["HEARTS_MULTIPLIER"] = 9999,
		["HEARTS_MULTIPLIER_2"] = 9999,
		["VALENTINE_RUNE_BULK"] = 9999,
		["VALENTINE_RUNE_BULK_2"] = 9999,
		["VALENTINE_RUNE_LUCK"] = 9999,
		["VALENTINE_RUNE_LUCK_II"] = 9999,
		["CRYSTAL_HEARTS_I"] = 9999,
		["CRYSTAL_HEARTS_DROP_CHANCE"] = 9999
	}),
	["treeNodes"] = (function()
		-- upvalues: (copy) v_u_7
		local v15 = {}
		for v16 = 1, 64 do
			local v17 = ("1-%*"):format(v16)
			v15[v17] = #v_u_7[v17].Levels
		end
		for v18 = 1, 16 do
			local v19 = ("2-%*"):format(v18)
			v15[v19] = #v_u_7[v19].Levels
		end
		return v15
	end)(),
	["runeAmounts"] = {
		[v4.Mud] = 5000000,
		[v4.Stone] = 5000000,
		[v4.Root] = 5000000,
		[v4.Moss] = 5000000,
		[v4.Fungal] = 5000000,
		[v4.Crystalroot] = 5000000,
		[v4.Ash] = 5000000,
		[v4.Ember] = 5000000,
		[v4.Flare] = 5000000,
		[v4.Pyroclast] = 5000000,
		[v4.Eruption] = 5000000,
		[v4.Primordial] = 5000000,
		[v4.Frostmark] = 5000000,
		[v4.Glacial] = 5000000,
		[v4.Permafrost] = 5000000,
		[v4.Cryostorm] = 5000000,
		[v4.Stormfrost] = 5000000,
		[v4.Frostbound] = 5000000,
		[v4.Wobble] = 21218,
		[v4.Sticky] = 2504,
		[v4.Bouncy] = 1020,
		[v4.Elastic] = 238,
		[v4.Prismatic] = 20,
		[v4.Kinetic] = 6406,
		[v4.Surge] = 723,
		[v4.Overdrive] = 328,
		[v4.Catalyst] = 32,
		[v4.Eternal] = 1
	}
}
local v21 = {
	["hall"] = {
		[v3.RuneBulk] = 1403,
		[v3.RuneLuckMultiplier] = 2.59,
		[v3.IceBossCooldownPercentage] = 0.14,
		[v3.RebirthMultiplier] = 2.81,
		[v3.SkillXPMultiplier] = 2.7,
		[v3.RebirthMultiplier] = 2.81,
		[v3.CurrencyGainMultiplier] = 2.24
	},
	["valentine"] = {
		[v3.ValentineRuneBulk] = 122,
		[v3.ValentineRuneLuckMultiplier] = 1.9,
		[v3.ValentineDamageMultiplier] = 1.65,
		[v3.HeartsMultiplier] = 1.19,
		[v3.ValentineTraitsLuckMultiplier] = 1.8,
		[v3.ValentineAttackRangeMultiplier] = 1.37,
		[v3.ValentineCrystalShardMultiplier] = 1.2
	}
}
v20.amulets = v21
v20.superRebirths = 13
v20.masteryTiers = {
	["PLAYTIME"] = 4,
	["COIN_COLLECTOR"] = 4,
	["FIRE_COIN_COLLECTOR"] = 4,
	["ICE_COIN_COLLECTOR"] = 4,
	["RUNES"] = 5,
	["SLIMES"] = 3
}
v20.potions = {}
v20.currencies = {
	[v2.Coins] = 152000000,
	[v2.FireCoins] = 7200000000,
	[v2.IceCoins] = 22400000000,
	[v2.Rebirth] = 991730,
	[v2.Shards] = 304
}
local v22 = v8(v20)
local v23, v24 = v5.simulate(v22, 3600, {
	["strategy"] = "bestValue",
	["logInterval"] = 300
})
print("=== LATE-GAME PRESET - 1 HOUR ===")
v5.printReport(v23, v24)
return {}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SimTest]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3925"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	1,
	10,
	100,
	1000,
	10000
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[IndexToGlobalRuneAmount]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3926"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Slimes")
local v2 = {}
for _, v3 in script:GetChildren() do
	if v3:IsA("ModuleScript") then
		for v4, v5 in require(v3) do
			v5.Model = v1:FindFirstChild(v4)
			if not v5.Model then
				error("Slime model not found for " .. v4)
			end
			v2[v4] = v5
		end
	end
end
return v2]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeData]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3927"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.SlimeTypes)
local v4 = require(v1.Enums.WorldTypes)
local v5 = {
	[v3.GreenSlime] = {
		["Name"] = "Green Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(0, 255, 0),
		["Size"] = 2.5,
		["Health"] = 5,
		["Order"] = 1,
		["World"] = v4.EARTH_WORLD,
		["Currency"] = v2.Coins
	},
	[v3.BlueSlime] = {
		["Name"] = "Blue Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(92, 250, 255),
		["Size"] = 2.55,
		["Health"] = 15,
		["Order"] = 2,
		["World"] = v4.EARTH_WORLD,
		["Currency"] = v2.Coins
	},
	[v3.RedSlime] = {
		["Name"] = "Red Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 0, 0),
		["Size"] = 2.6,
		["Health"] = 50,
		["Order"] = 3,
		["World"] = v4.EARTH_WORLD,
		["Currency"] = v2.Coins
	},
	[v3.PurpleSlime] = {
		["Name"] = "Purple Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(160, 77, 255),
		["Size"] = 2.65,
		["Health"] = 100,
		["Order"] = 4,
		["World"] = v4.EARTH_WORLD,
		["Currency"] = v2.Coins
	}
}
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[EARTH_SLIMES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3928"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.SlimeTypes)
local v4 = require(v1.Enums.WorldTypes)
local v5 = {
	[v3.GreySlime] = {
		["Name"] = "Grey Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(128, 128, 128),
		["Size"] = 2.5,
		["Health"] = 200,
		["Order"] = 1,
		["World"] = v4.LAVA_WORLD,
		["Currency"] = v2.FireCoins
	},
	[v3.OrangeSlime] = {
		["Name"] = "Orange Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 165, 0),
		["Size"] = 2.55,
		["Health"] = 400,
		["Order"] = 2,
		["World"] = v4.LAVA_WORLD,
		["Currency"] = v2.FireCoins
	},
	[v3.YellowSlime] = {
		["Name"] = "Yellow Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 255, 0),
		["Size"] = 2.6,
		["Health"] = 800,
		["Order"] = 3,
		["World"] = v4.LAVA_WORLD,
		["Currency"] = v2.FireCoins
	},
	[v3.BrightRedSlime] = {
		["Name"] = "Bright Red Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 0, 0),
		["Size"] = 2.65,
		["Health"] = 1200,
		["Order"] = 3,
		["World"] = v4.LAVA_WORLD,
		["Currency"] = v2.FireCoins
	},
	[v3.MagmaSlime] = {
		["Name"] = "Magma Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(190, 60, 60),
		["Size"] = 2.7,
		["Health"] = 2000,
		["Order"] = 4,
		["World"] = v4.LAVA_WORLD,
		["Currency"] = v2.FireCoins
	}
}
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LAVA_SLIMES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3929"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.SlimeTypes)
local v4 = require(v1.Enums.WorldTypes)
local v5 = {
	[v3.IceSlime] = {
		["Name"] = "Ice Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(164, 219, 255),
		["Size"] = 2.5,
		["Health"] = 2000,
		["Order"] = 1,
		["World"] = v4.ICE_WORLD,
		["Currency"] = v2.IceCoins
	},
	[v3.PurpleIceSlime] = {
		["Name"] = "Purple Ice Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(128, 0, 128),
		["Size"] = 2.55,
		["Health"] = 3500,
		["Order"] = 2,
		["World"] = v4.ICE_WORLD,
		["Currency"] = v2.IceCoins
	},
	[v3.PinkIceSlime] = {
		["Name"] = "Pink Ice Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 192, 203),
		["Size"] = 2.6,
		["Health"] = 7500,
		["Order"] = 3,
		["World"] = v4.ICE_WORLD,
		["Currency"] = v2.IceCoins
	},
	[v3.BlueIceSlime] = {
		["Name"] = "Blue Ice Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(0, 0, 255),
		["Size"] = 2.65,
		["Health"] = 8000,
		["Order"] = 4,
		["World"] = v4.ICE_WORLD,
		["Currency"] = v2.IceCoins
	},
	[v3.WhiteIceSlime] = {
		["Name"] = "White Ice Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 255, 255),
		["Size"] = 2.7,
		["Health"] = 15000,
		["Order"] = 5,
		["World"] = v4.ICE_WORLD,
		["Currency"] = v2.IceCoins
	}
}
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ICE_SLIMES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3930"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.SlimeTypes)
local v4 = require(v1.Enums.WorldTypes)
local v5 = {
	[v3.ValentineSlime1] = {
		["Name"] = "Valentine Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(234, 170, 255),
		["Size"] = 2.5,
		["Health"] = 5,
		["Order"] = 1,
		["World"] = v4.VALENTINE_WORLD,
		["Currency"] = v2.Hearts
	},
	[v3.ValentineSlime2] = {
		["Name"] = "Valentine Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 102, 181),
		["Size"] = 2.55,
		["Health"] = 50,
		["Order"] = 2,
		["World"] = v4.VALENTINE_WORLD,
		["Currency"] = v2.Hearts
	},
	[v3.ValentineSlime3] = {
		["Name"] = "Valentine Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(172, 70, 255),
		["Size"] = 2.6,
		["Health"] = 5000,
		["Order"] = 3,
		["World"] = v4.VALENTINE_WORLD,
		["Currency"] = v2.Hearts
	},
	[v3.ValentineSlime4] = {
		["Name"] = "Valentine Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 132, 101),
		["Size"] = 2.65,
		["Health"] = 100000,
		["Order"] = 4,
		["World"] = v4.VALENTINE_WORLD,
		["Currency"] = v2.Hearts
	},
	[v3.ValentineSlime5] = {
		["Name"] = "Valentine Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 105, 107),
		["Size"] = 2.65,
		["Health"] = 1000000,
		["Order"] = 5,
		["World"] = v4.VALENTINE_WORLD,
		["Currency"] = v2.Hearts
	}
}
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VALENTINE_SLIMES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3931"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.SlimeTypes)
local v4 = require(v1.Enums.WorldTypes)
local v5 = {
	[v3.GloopSlime1] = {
		["Name"] = "Glow Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(88, 255, 96),
		["Size"] = 2.5,
		["Health"] = 750000,
		["Order"] = 1,
		["World"] = v4.GLOW_WORLD,
		["Currency"] = v2.GlowCoins
	},
	[v3.GloopSlime2] = {
		["Name"] = "Glow Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(92, 255, 78),
		["Size"] = 2.55,
		["Health"] = 2500000,
		["Order"] = 2,
		["World"] = v4.GLOW_WORLD,
		["Currency"] = v2.GlowCoins
	},
	[v3.GloopSlime3] = {
		["Name"] = "Glow Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(114, 255, 138),
		["Size"] = 2.6,
		["Health"] = 10000000,
		["Order"] = 3,
		["World"] = v4.GLOW_WORLD,
		["Currency"] = v2.GlowCoins
	},
	[v3.GloopSlime4] = {
		["Name"] = "Glow Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(104, 255, 116),
		["Size"] = 2.65,
		["Health"] = 50000000,
		["Order"] = 4,
		["World"] = v4.GLOW_WORLD,
		["Currency"] = v2.GlowCoins
	},
	[v3.GloopSlime5] = {
		["Name"] = "Glow Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(0, 255, 34),
		["Size"] = 2.7,
		["Health"] = 100000000,
		["Order"] = 5,
		["World"] = v4.GLOW_WORLD,
		["Currency"] = v2.GlowCoins
	}
}
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GLOOP_SLIMES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3932"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.SlimeTypes)
local v4 = require(v1.Enums.WorldTypes)
local v5 = {
	[v3.Event1MSlime1] = {
		["Name"] = "Party Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 240, 150),
		["Size"] = 2.5,
		["Health"] = 8,
		["Order"] = 1,
		["World"] = v4.EVENT_1M_WORLD,
		["Currency"] = v2.Event1MBalloon
	},
	[v3.Event1MSlime2] = {
		["Name"] = "Party Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 215, 0),
		["Size"] = 2.55,
		["Health"] = 150,
		["Order"] = 2,
		["World"] = v4.EVENT_1M_WORLD,
		["Currency"] = v2.Event1MBalloon
	},
	[v3.Event1MSlime3] = {
		["Name"] = "Party Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 175, 0),
		["Size"] = 2.6,
		["Health"] = 25000,
		["Order"] = 3,
		["World"] = v4.EVENT_1M_WORLD,
		["Currency"] = v2.Event1MBalloon
	},
	[v3.Event1MSlime4] = {
		["Name"] = "Party Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 130, 0),
		["Size"] = 2.65,
		["Health"] = 2000000,
		["Order"] = 4,
		["World"] = v4.EVENT_1M_WORLD,
		["Currency"] = v2.Event1MBalloon
	},
	[v3.Event1MSlime5] = {
		["Name"] = "Party Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 255, 100),
		["Size"] = 2.7,
		["Health"] = 100000000,
		["Order"] = 5,
		["World"] = v4.EVENT_1M_WORLD,
		["Currency"] = v2.Event1MBalloon
	}
}
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[EVENT_1M_SLIMES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3933"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.SlimeTypes)
local v4 = require(v1.Enums.WorldTypes)
local v5 = {
	[v3.CandySlime1] = {
		["Name"] = "Candy Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 150, 200),
		["Size"] = 2.5,
		["Health"] = 150000000,
		["CurrencyAmount"] = 1000,
		["Order"] = 1,
		["World"] = v4.CANDY_WORLD,
		["Currency"] = v2.CandyCoins
	},
	[v3.CandySlime2] = {
		["Name"] = "Candy Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 120, 180),
		["Size"] = 2.55,
		["Health"] = 500000000,
		["CurrencyAmount"] = 10000,
		["Order"] = 2,
		["World"] = v4.CANDY_WORLD,
		["Currency"] = v2.CandyCoins
	},
	[v3.CandySlime3] = {
		["Name"] = "Candy Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(200, 100, 255),
		["Size"] = 2.6,
		["Health"] = 2000000000,
		["CurrencyAmount"] = 50000,
		["Order"] = 3,
		["World"] = v4.CANDY_WORLD,
		["Currency"] = v2.CandyCoins
	},
	[v3.CandySlime4] = {
		["Name"] = "Candy Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 80, 150),
		["Size"] = 2.65,
		["Health"] = 5000000000,
		["CurrencyAmount"] = 150000,
		["Order"] = 4,
		["World"] = v4.CANDY_WORLD,
		["Currency"] = v2.CandyCoins
	},
	[v3.CandySlime5] = {
		["Name"] = "Candy Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 50, 120),
		["Size"] = 2.7,
		["Health"] = 10000000000,
		["CurrencyAmount"] = 500000,
		["Order"] = 5,
		["World"] = v4.CANDY_WORLD,
		["Currency"] = v2.CandyCoins
	},
	[v3.CandySlime6] = {
		["Name"] = "Candy Slime",
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(220, 30, 90),
		["Size"] = 2.75,
		["Health"] = 25000000000,
		["CurrencyAmount"] = 1500000,
		["Order"] = 6,
		["World"] = v4.CANDY_WORLD,
		["Currency"] = v2.CandyCoins
	}
}
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CANDY_SLIMES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3934"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
for _, v2 in script:GetDescendants() do
	if v2:IsA("ModuleScript") then
		for v3, v4 in require(v2) do
			v4.Board = v2.Name
			if v1[v3] then
				error("Duplicate upgrade key found: " .. v3)
			end
			v1[v3] = v4
		end
	end
end
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UpgradeBoardData]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3935"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v17 = {
	["RANGE_INCREASE_1"] = {
		["Name"] = "Attack Range",
		["Icon"] = "rbxassetid://78157289763375",
		["Description"] = "Increases the range of your attacks!",
		["MaxLevel"] = 20,
		["Order"] = 1,
		["CurrencyType"] = v2.Coins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World1AttackRange,
		["Format"] = function(p4)
			return ("+%*"):format(p4)
		end,
		["CalculateMultiplier"] = function(_, p5)
			return p5 * 0.5
		end,
		["CalculateCost"] = function(_, p6)
			local v7 = 2.5 ^ p6 * 3
			return math.floor(v7)
		end
	},
	["DAMAGE_INCREASE"] = {
		["Name"] = "Damage",
		["Icon"] = "rbxassetid://106746371164727",
		["Description"] = "Increases your damage!",
		["MaxLevel"] = 50,
		["Order"] = 2,
		["CurrencyType"] = v2.Coins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Damage,
		["Format"] = function(p8)
			return ("+%*"):format(p8)
		end,
		["CalculateMultiplier"] = function(_, p9)
			return p9
		end,
		["CalculateCost"] = function(_, p10)
			local v11 = 1.5 ^ p10 * 3
			return math.floor(v11)
		end
	},
	["COIN_MULTIPLIER"] = {
		["Name"] = "Coin Multiplier",
		["Icon"] = "rbxassetid://137385384245893",
		["Description"] = "Increases the amount of coins you earn!",
		["MaxLevel"] = 8,
		["Order"] = 3,
		["CurrencyType"] = v2.Coins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.CoinsMultiplier,
		["Format"] = function(p12)
			local v13 = p12 * 100
			return ("x%*"):format(math.floor(v13) / 100)
		end,
		["CalculateMultiplier"] = function(_, p14)
			return p14 * 0.5 + 1
		end,
		["CalculateCost"] = function(_, p15)
			local v16 = 2.5 ^ p15 * 50
			return math.floor(v16)
		end
	}
}
return v17]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PLAYER_UPGRADES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3936"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v18 = {
	["SLIME_SPAWN_CAP"] = {
		["Name"] = "Slime Spawn Capacity",
		["Icon"] = "rbxassetid://140179584961588",
		["Description"] = "Increases the maximum number of slimes that can spawn!",
		["MaxLevel"] = 99,
		["Order"] = 1,
		["CurrencyType"] = v2.Coins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World1SpawnCap,
		["Format"] = function(p4)
			return ("+%*"):format(p4)
		end,
		["CalculateMultiplier"] = function(_, p5)
			return p5
		end,
		["CalculateCost"] = function(_, p6)
			local v7 = 1.125 ^ p6 * 3
			return math.floor(v7)
		end
	},
	["SLIME_SPAWN_SPEED"] = {
		["Name"] = "Slime Spawn Speed",
		["Icon"] = "rbxassetid://91181531852133",
		["Description"] = "Increases the speed at which slimes spawn!",
		["MaxLevel"] = 18,
		["Order"] = 2,
		["CurrencyType"] = v2.Coins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World1SpawnRate,
		["Format"] = function(p8)
			local v9 = p8 * 100
			return ("-%*"):format(math.floor(v9) / 100)
		end,
		["CalculateMultiplier"] = function(_, p10)
			return p10 * 0.05
		end,
		["CalculateCost"] = function(_, p11)
			local v12 = 1.96 ^ p11 * 3
			return math.floor(v12)
		end
	},
	["SLIME_LUCK"] = {
		["Name"] = "Slime Luck",
		["Icon"] = "rbxassetid://140179584961588",
		["Description"] = "Chance of spawning better slimes!",
		["MaxLevel"] = 10,
		["Order"] = 3,
		["CurrencyType"] = v2.Coins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World1SlimeLuck,
		["Format"] = function(p13)
			local v14 = p13 * 100
			return ("+%*%%"):format((math.floor(v14)))
		end,
		["CalculateMultiplier"] = function(_, p15)
			return p15 * 0.1
		end,
		["CalculateCost"] = function(_, p16)
			local v17 = 2 ^ p16 * 100
			return math.floor(v17)
		end
	}
}
return v18]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SLIME_UPGRADES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3937"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.LockTypes)
local v4 = require(v1.Enums.MultiplierTypes)
local v5 = require(v1.Enums.WorldTypes)
local v21 = {
	["REBIRTH_MULTIPLIER"] = {
		["Name"] = "Rebirth Multiplier I",
		["Icon"] = "rbxassetid://87974431889658",
		["Description"] = "Increases your rebirth multiplier!",
		["MaxLevel"] = 7,
		["Order"] = 1,
		["CurrencyType"] = v2.Rebirth,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v4.RebirthMultiplier,
		["Format"] = function(p6)
			local v7 = p6 * 100
			return ("x%*"):format(math.floor(v7) / 100)
		end,
		["CalculateMultiplier"] = function(_, p8)
			return 2 ^ p8
		end,
		["CalculateCost"] = function(_, p9)
			local v10 = 2.8 ^ p9 * 1
			return math.floor(v10)
		end
	},
	["DAMAGE_MULTIPLIER"] = {
		["Name"] = "Damage Multiplier I",
		["Icon"] = "rbxassetid://106746371164727",
		["Description"] = "Increases your damage!",
		["MaxLevel"] = 10,
		["Order"] = 1,
		["CurrencyType"] = v2.Rebirth,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v4.DamageMultiplier,
		["Format"] = function(p11)
			local v12 = p11 * 100
			return ("x%*"):format(math.floor(v12) / 100)
		end,
		["CalculateMultiplier"] = function(_, p13)
			return p13 * 0.1 + 1
		end,
		["CalculateCost"] = function(_, p14)
			local v15 = 3 ^ p14 * 1
			return math.floor(v15)
		end
	},
	["COIN_MULTIPLIER_2"] = {
		["Name"] = "Coin Multiplier",
		["Icon"] = "rbxassetid://137385384245893",
		["Description"] = "Increases the amount of coins you earn!",
		["MaxLevel"] = 8,
		["Order"] = 3,
		["CurrencyType"] = v2.Rebirth,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v4.CoinsMultiplier,
		["Format"] = function(p16)
			local v17 = p16 * 100
			return ("x%*"):format(math.floor(v17) / 100)
		end,
		["CalculateMultiplier"] = function(_, p18)
			return 2 ^ p18
		end,
		["CalculateCost"] = function(_, p19)
			local v20 = 4 ^ p19 * 1
			return math.floor(v20)
		end
	}
}
local v22 = {
	["Name"] = "Fire Coin Multiplier",
	["Icon"] = "rbxassetid://113801335212128",
	["Description"] = "Increases the amount of fire coins you earn!",
	["MaxLevel"] = 7,
	["Order"] = 6,
	["CurrencyType"] = v2.Rebirth,
	["MultiplierFunctionality"] = "Default",
	["MultiplierType"] = v4.FireCoinsMultiplier
}
local v23 = {
	[v3.World] = {
		["value"] = "LAVA_WORLD"
	}
}
v22.LockedData = v23
function v22.Format(p24)
	local v25 = p24 * 100
	return ("x%*"):format(math.floor(v25) / 100)
end
function v22.CalculateMultiplier(_, p26)
	return 2 ^ p26
end
function v22.CalculateCost(_, p27)
	local v28 = 4 ^ p27 * 10000
	return math.floor(v28)
end
v21.FIRE_COIN_MULTIPLIER_1 = v22
local v29 = {
	["Name"] = "Ice Coin Multiplier",
	["Icon"] = "rbxassetid://94836897629836",
	["Description"] = "Increases the amount of ice coins you earn!",
	["MaxLevel"] = 7,
	["Order"] = 7,
	["CurrencyType"] = v2.Rebirth,
	["MultiplierFunctionality"] = "Default",
	["MultiplierType"] = v4.IceCoinsMultiplier
}
local v30 = {
	[v3.World] = {
		["value"] = "ICE_WORLD"
	}
}
v29.LockedData = v30
function v29.Format(p31)
	local v32 = p31 * 100
	return ("x%*"):format(math.floor(v32) / 100)
end
function v29.CalculateMultiplier(_, p33)
	return 2 ^ p33
end
function v29.CalculateCost(_, p34)
	local v35 = 4 ^ p34 * 500000
	return math.floor(v35)
end
v21.ICE_COIN_MULTIPLIER_1 = v29
local v36 = {
	["Name"] = "Damage Multiplier II",
	["Icon"] = "rbxassetid://106746371164727",
	["Description"] = "Increases your damage!",
	["MaxLevel"] = 10,
	["Order"] = 8,
	["CurrencyType"] = v2.Rebirth,
	["MultiplierFunctionality"] = "Default",
	["MultiplierType"] = v4.DamageMultiplier
}
local v37 = {
	[v3.World] = {
		["value"] = "ICE_WORLD"
	}
}
v36.LockedData = v37
function v36.Format(p38)
	local v39 = p38 * 100
	return ("x%*"):format(math.floor(v39) / 100)
end
function v36.CalculateMultiplier(_, p40)
	return p40 * 0.1 + 1
end
function v36.CalculateCost(_, p41)
	local v42 = 2.5 ^ p41 * 1000000
	return math.floor(v42)
end
v21.DAMAGE_MULTIPLIER_II = v36
local v43 = {
	["Name"] = "Gloop Coin Multiplier",
	["Icon"] = "rbxassetid://85479817882405",
	["Description"] = "Increases your gloop coins!",
	["MaxLevel"] = 10,
	["Order"] = 8,
	["CurrencyType"] = v2.Rebirth,
	["MultiplierFunctionality"] = "Default",
	["MultiplierType"] = v4.GlowCoinsMultiplier
}
local v44 = {
	[v3.World] = {
		["value"] = v5.GLOW_WORLD
	}
}
v43.LockedData = v44
function v43.Format(p45)
	local v46 = p45 * 100
	return ("x%*"):format(math.floor(v46) / 100)
end
function v43.CalculateMultiplier(_, p47)
	return p47 * 0.1 + 1
end
function v43.CalculateCost(_, p48)
	local v49 = 2.5 ^ p48 * 100000000
	return math.floor(v49)
end
v21.GLOOP_COIN_MULTIPLIER = v43
local v50 = {
	["Name"] = "Candy Coin Multiplier",
	["Icon"] = "rbxassetid://107119582007802",
	["Description"] = "Increases your candy coins!",
	["MaxLevel"] = 10,
	["Order"] = 9,
	["CurrencyType"] = v2.Rebirth,
	["MultiplierFunctionality"] = "Default",
	["MultiplierType"] = v4.CandyCoinsMultiplier
}
local v51 = {
	[v3.World] = {
		["value"] = v5.CANDY_WORLD
	}
}
v50.LockedData = v51
function v50.Format(p52)
	local v53 = p52 * 100
	return ("x%*"):format(math.floor(v53) / 100)
end
function v50.CalculateMultiplier(_, p54)
	return p54 * 0.1 + 1
end
function v50.CalculateCost(_, p55)
	local v56 = 7.5 ^ p55 * 1000000000000
	return math.floor(v56)
end
v21.REBIRTH_CANDY_COIN_MULTIPLIER = v50
return v21]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[REBIRTH_UPGRADES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3938"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v18 = {
	["SLIME_SPAWN_CAP_2"] = {
		["Name"] = "Slime Spawn Capacity",
		["Icon"] = "rbxassetid://140179584961588",
		["Description"] = "Increases the maximum number of slimes that can spawn!",
		["MaxLevel"] = 99,
		["Order"] = 1,
		["CurrencyType"] = v2.FireCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World2SpawnCap,
		["Format"] = function(p4)
			return ("+%*"):format(p4)
		end,
		["CalculateMultiplier"] = function(_, p5)
			return p5
		end,
		["CalculateCost"] = function(_, p6)
			local v7 = 1.13 ^ p6 * 300
			return math.floor(v7)
		end
	},
	["SLIME_SPAWN_SPEED_2"] = {
		["Name"] = "Slime Spawn Speed",
		["Icon"] = "rbxassetid://91181531852133",
		["Description"] = "Increases the speed at which slimes spawn!",
		["MaxLevel"] = 18,
		["Order"] = 2,
		["CurrencyType"] = v2.FireCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World2SpawnRate,
		["Format"] = function(p8)
			local v9 = p8 * 100
			return ("-%*"):format(math.floor(v9) / 100)
		end,
		["CalculateMultiplier"] = function(_, p10)
			return p10 * 0.05
		end,
		["CalculateCost"] = function(_, p11)
			local v12 = 2.5 ^ p11 * 3
			return math.floor(v12)
		end
	},
	["SLIME_LUCK_2"] = {
		["Name"] = "Slime Luck",
		["Icon"] = "rbxassetid://140179584961588",
		["Description"] = "Chance of spawning better slimes!",
		["MaxLevel"] = 10,
		["Order"] = 3,
		["CurrencyType"] = v2.FireCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World2SlimeLuck,
		["Format"] = function(p13)
			local v14 = p13 * 100
			return ("+%*%%"):format((math.floor(v14)))
		end,
		["CalculateMultiplier"] = function(_, p15)
			return p15 * 0.1
		end,
		["CalculateCost"] = function(_, p16)
			local v17 = 2 ^ p16 * 2000
			return math.floor(v17)
		end
	}
}
return v18]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LAVA_SLIME_UPGRADES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3939"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v16 = {
	["RUNE_BULK_1"] = {
		["Name"] = "Rune Bulk I",
		["Icon"] = "rbxassetid://92458066679384",
		["Description"] = "Increases the amount of runes you can open at once!",
		["MaxLevel"] = 30,
		["Order"] = 1,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Shards,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.RuneBulk,
		["Format"] = function(p4)
			return ("+%*"):format(p4)
		end,
		["CalculateMultiplier"] = function(_, p5)
			return p5 * 5
		end,
		["CalculateCost"] = function(_, p6)
			local v7 = 1.5 ^ p6 * 1
			return math.floor(v7)
		end
	},
	["RUNE_LUCK"] = {
		["Name"] = "Rune Luck I",
		["Icon"] = "rbxassetid://92458066679384",
		["Description"] = "Increases your rune luck!",
		["MaxLevel"] = 30,
		["Order"] = 2,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Shards,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.RuneLuck,
		["Format"] = function(p8)
			return ("+%*"):format(p8)
		end,
		["CalculateMultiplier"] = function(_, p9)
			return p9 * 0.5
		end,
		["CalculateCost"] = function(_, p10)
			local v11 = 1.5 ^ p10 * 1
			return math.floor(v11)
		end
	},
	["RUNE_SPEED_MULTIPLIER_1"] = {
		["Name"] = "Rune Speed Multiplier I",
		["Icon"] = "rbxassetid://92458066679384",
		["Description"] = "Increases your rune speed multiplier!",
		["MaxLevel"] = 30,
		["Order"] = 3,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Shards,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.RuneOpenTimeMultiplier,
		["Format"] = function(p12)
			return ("x%*"):format(p12)
		end,
		["CalculateMultiplier"] = function(_, p13)
			return p13 * 0.01 + 1
		end,
		["CalculateCost"] = function(_, p14)
			local v15 = 1.5 ^ p14 * 1
			return math.floor(v15)
		end
	}
}
return v16]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[EARTH_RUNE_UPGRADES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3940"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v17 = {
	["RANGE_INCREASE_2"] = {
		["Name"] = "Attack Range",
		["Icon"] = "rbxassetid://78157289763375",
		["Description"] = "Increases the range of your attacks!",
		["MaxLevel"] = 20,
		["Order"] = 1,
		["CurrencyType"] = v2.FireCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World2AttackRange,
		["Format"] = function(p4)
			return ("+%*"):format(p4)
		end,
		["CalculateMultiplier"] = function(_, p5)
			return p5 * 0.5
		end,
		["CalculateCost"] = function(_, p6)
			local v7 = 4 ^ p6 * 700
			return math.floor(v7)
		end
	},
	["DAMAGE_INCREASE_2"] = {
		["Name"] = "Damage",
		["Icon"] = "rbxassetid://106746371164727",
		["Description"] = "Increases your damage!",
		["MaxLevel"] = 50,
		["Order"] = 2,
		["CurrencyType"] = v2.FireCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Damage,
		["Format"] = function(p8)
			return ("+%*"):format(p8)
		end,
		["CalculateMultiplier"] = function(_, p9)
			return p9
		end,
		["CalculateCost"] = function(_, p10)
			local v11 = 1.3 ^ p10 * 1500
			return math.floor(v11)
		end
	},
	["FIRE_COIN_MULTIPLIER_2"] = {
		["Name"] = "Fire Coin Multiplier",
		["Icon"] = "rbxassetid://113801335212128",
		["Description"] = "Increases the amount of fire coins you earn!",
		["MaxLevel"] = 8,
		["Order"] = 3,
		["CurrencyType"] = v2.FireCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.FireCoinsMultiplier,
		["Format"] = function(p12)
			local v13 = p12 * 100
			return ("x%*"):format(math.floor(v13) / 100)
		end,
		["CalculateMultiplier"] = function(_, p14)
			return p14 * 0.5 + 1
		end,
		["CalculateCost"] = function(_, p15)
			local v16 = 3.25 ^ p15 * 500
			return math.floor(v16)
		end
	}
}
return v17]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LAVA_PLAYER_UPGRADES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3941"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v36 = {
	["DAMAGE_INCREASE_3"] = {
		["Name"] = "Damage",
		["Icon"] = "rbxassetid://106746371164727",
		["Description"] = "Increases your damage!",
		["MaxLevel"] = 25,
		["Order"] = 1,
		["CurrencyType"] = v2.IceCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Damage,
		["Format"] = function(p4)
			return ("+%*"):format(p4)
		end,
		["CalculateMultiplier"] = function(_, p5)
			return p5
		end,
		["CalculateCost"] = function(_, p6)
			local v7 = 1.3 ^ p6 * 1500
			return math.floor(v7)
		end
	},
	["ICE_COIN_MULTIPLIER_2"] = {
		["Name"] = "Ice Coin Multiplier",
		["Icon"] = "rbxassetid://94836897629836",
		["Description"] = "Increases the amount of ice coins you earn!",
		["MaxLevel"] = 8,
		["Order"] = 2,
		["CurrencyType"] = v2.IceCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.IceCoinsMultiplier,
		["Format"] = function(p8)
			local v9 = p8 * 100
			return ("x%*"):format(math.floor(v9) / 100)
		end,
		["CalculateMultiplier"] = function(_, p10)
			return p10 * 0.5 + 1
		end,
		["CalculateCost"] = function(_, p11)
			local v12 = 3.25 ^ p11 * 1000
			return math.floor(v12)
		end
	},
	["SLIME_SPAWN_SPEED_3"] = {
		["Name"] = "Slime Spawn Speed",
		["Icon"] = "rbxassetid://91181531852133",
		["Description"] = "Increases the speed at which slimes spawn!",
		["MaxLevel"] = 38,
		["Order"] = 3,
		["CurrencyType"] = v2.IceCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World3SpawnRate,
		["Format"] = function(p13)
			local v14 = p13 * 1000
			return ("-%*s"):format(math.floor(v14) / 1000)
		end,
		["CalculateMultiplier"] = function(_, p15)
			return p15 * 0.025
		end,
		["CalculateCost"] = function(_, p16)
			local v17 = 2.5 ^ p16 * 3
			return math.floor(v17)
		end
	},
	["SLIME_DURATION_1"] = {
		["Name"] = "Increase Duration",
		["Icon"] = "rbxassetid://91181531852133",
		["Description"] = "Longer fighting duration!",
		["MaxLevel"] = 10,
		["Order"] = 4,
		["CurrencyType"] = v2.IceCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.IceWorldDuration,
		["Format"] = function(p18)
			local v19 = p18 * 100
			return ("+%*s"):format(math.floor(v19) / 100)
		end,
		["CalculateMultiplier"] = function(_, p20)
			return p20 * 5
		end,
		["CalculateCost"] = function(_, p21)
			local v22 = 2.5 ^ p21 * 3
			return math.floor(v22)
		end
	},
	["SLIME_DURATION_2"] = {
		["Name"] = "Increase Duration II",
		["Icon"] = "rbxassetid://91181531852133",
		["Description"] = "Longer fighting duration!",
		["MaxLevel"] = 10,
		["Order"] = 5,
		["CurrencyType"] = v2.IceCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.IceWorldDuration,
		["Format"] = function(p23)
			local v24 = p23 * 100
			return ("+%*s"):format(math.floor(v24) / 100)
		end,
		["CalculateMultiplier"] = function(_, p25)
			return p25 * 25
		end,
		["CalculateCost"] = function(_, p26)
			local v27 = 8 ^ p26 * 3000000
			return math.floor(v27)
		end
	},
	["DAMAGE_INCREASE_4"] = {
		["Name"] = "Damage II",
		["Icon"] = "rbxassetid://106746371164727",
		["Description"] = "Increases your damage!",
		["MaxLevel"] = 25,
		["Order"] = 6,
		["CurrencyType"] = v2.IceCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Damage,
		["Format"] = function(p28)
			return ("+%*"):format(p28)
		end,
		["CalculateMultiplier"] = function(_, p29)
			return p29
		end,
		["CalculateCost"] = function(_, p30)
			local v31 = 2.25 ^ p30 * 15000000
			return math.floor(v31)
		end
	},
	["RANGE_INCREASE_3"] = {
		["Name"] = "Attack Range",
		["Icon"] = "rbxassetid://78157289763375",
		["Description"] = "Increases the range of your attacks!",
		["MaxLevel"] = 20,
		["Order"] = 7,
		["CurrencyType"] = v2.IceCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World3AttackRange,
		["Format"] = function(p32)
			return ("+%*"):format(p32)
		end,
		["CalculateMultiplier"] = function(_, p33)
			return p33 * 0.5
		end,
		["CalculateCost"] = function(_, p34)
			local v35 = 2.5 ^ p34 * 500
			return math.floor(v35)
		end
	}
}
return v36]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ICE_WORLD_UPGRADES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3942"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v75 = {
	["VALENTINE_SLIME_SPAWN_CAP"] = {
		["Name"] = "Slime Spawn Capacity",
		["Icon"] = "rbxassetid://129741587638825",
		["Description"] = "Increases the maximum number of slimes that can spawn!",
		["MaxLevel"] = 50,
		["Order"] = 1,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ValentineSpawnCap,
		["Format"] = function(p4)
			return ("+%*"):format(p4)
		end,
		["CalculateMultiplier"] = function(_, p5)
			return p5
		end,
		["CalculateCost"] = function(_, p6)
			local v7 = 1.725 ^ p6 * 3
			return math.floor(v7)
		end
	},
	["VALENTINE_SLIME_SPAWN_CAP_2"] = {
		["Name"] = "Slime Spawn Capacity II",
		["Icon"] = "rbxassetid://129741587638825",
		["Description"] = "Increases the maximum number of slimes that can spawn!",
		["MaxLevel"] = 25,
		["Order"] = 15,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ValentineSpawnCap,
		["Format"] = function(p8)
			return ("+%*"):format(p8)
		end,
		["CalculateMultiplier"] = function(_, p9)
			return p9
		end,
		["CalculateCost"] = function(_, p10)
			local v11 = 3 ^ p10 * 1000000000000
			return math.floor(v11)
		end
	},
	["VALENTINE_SLIME_SPAWN_CAP_3"] = {
		["Name"] = "Slime Spawn Capacity III",
		["Icon"] = "rbxassetid://129741587638825",
		["Description"] = "Increases the maximum number of slimes that can spawn!",
		["MaxLevel"] = 15,
		["Order"] = 16,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ValentineSpawnCap,
		["Format"] = function(p12)
			return ("+%*"):format(p12)
		end,
		["CalculateMultiplier"] = function(_, p13)
			return p13
		end,
		["CalculateCost"] = function(_, p14)
			local v15 = 45 ^ p14 * 1.5e19
			return math.floor(v15)
		end
	},
	["VALENTINE_SLIME_SPAWN_SPEED"] = {
		["Name"] = "Slime Spawn Speed",
		["Icon"] = "rbxassetid://91181531852133",
		["Description"] = "Increases the speed at which slimes spawn!",
		["MaxLevel"] = 12,
		["Order"] = 2,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ValentineSpawnRate,
		["Format"] = function(p16)
			local v17 = p16 * 100
			return ("-%*"):format(math.floor(v17) / 100)
		end,
		["CalculateMultiplier"] = function(_, p18)
			return p18 * 0.05
		end,
		["CalculateCost"] = function(_, p19)
			local v20 = 2.25 ^ p19 * 3
			return math.floor(v20)
		end
	},
	["VALENTINE_SLIME_SPAWN_SPEED_2"] = {
		["Name"] = "Slime Spawn Speed II",
		["Icon"] = "rbxassetid://91181531852133",
		["Description"] = "Increases the speed at which slimes spawn!",
		["MaxLevel"] = 6,
		["Order"] = 17,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ValentineSpawnRate,
		["Format"] = function(p21)
			local v22 = p21 * 100
			return ("-%*"):format(math.floor(v22) / 100)
		end,
		["CalculateMultiplier"] = function(_, p23)
			return p23 * 0.05
		end,
		["CalculateCost"] = function(_, p24)
			local v25 = 20 ^ p24 * 5e18
			return math.floor(v25)
		end
	},
	["VALENTINE_RANGE_INCREASE_1"] = {
		["Name"] = "Attack Range",
		["Icon"] = "rbxassetid://78157289763375",
		["Description"] = "Increases the range of your attacks!",
		["MaxLevel"] = 10,
		["Order"] = 3,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ValentineAttackRange,
		["Format"] = function(p26)
			return ("+%*"):format(p26)
		end,
		["CalculateMultiplier"] = function(_, p27)
			return p27 * 0.5
		end,
		["CalculateCost"] = function(_, p28)
			local v29 = 2.5 ^ p28 * 3
			return math.floor(v29)
		end
	},
	["VALENTINE_DAMAGE_INCREASE"] = {
		["Name"] = "Damage",
		["Icon"] = "rbxassetid://106746371164727",
		["Description"] = "Increases your valentine damage!",
		["MaxLevel"] = 25,
		["Order"] = 4,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ValentineDamage,
		["Format"] = function(p30)
			return ("+%*"):format(p30)
		end,
		["CalculateMultiplier"] = function(_, p31)
			return p31
		end,
		["CalculateCost"] = function(_, p32)
			local v33 = 2.5 ^ p32 * 3
			return math.floor(v33)
		end
	},
	["VALENTINE_DAMAGE_INCREASE_2"] = {
		["Name"] = "Damage II",
		["Icon"] = "rbxassetid://106746371164727",
		["Description"] = "Increases your valentine damage!",
		["MaxLevel"] = 25,
		["Order"] = 17,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ValentineDamage,
		["Format"] = function(p34)
			return ("+%*"):format(p34)
		end,
		["CalculateMultiplier"] = function(_, p35)
			return p35
		end,
		["CalculateCost"] = function(_, p36)
			local v37 = 3 ^ p36 * 1e20
			return math.floor(v37)
		end
	},
	["HEARTS_MULTIPLIER"] = {
		["Name"] = "Hearts Multiplier",
		["Icon"] = "rbxassetid://96022333579405",
		["Description"] = "Increases the amount of hearts you earn!\nDoubles every 10 levels",
		["MaxLevel"] = 200,
		["Order"] = 5,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.HeartsMultiplier,
		["Format"] = function(p38)
			local v39 = p38 * 100
			return ("x%*"):format(math.floor(v39) / 100)
		end,
		["CalculateMultiplier"] = function(_, p40)
			local v41 = p40 * 0.25
			local v42 = p40 / 10
			return v41 * 2 ^ math.floor(v42) + 1
		end,
		["CalculateCost"] = function(_, p43)
			local v44 = 2.5 ^ p43 * 3
			return math.floor(v44)
		end
	},
	["HEARTS_MULTIPLIER_2"] = {
		["Name"] = "Hearts Multiplier II",
		["Icon"] = "rbxassetid://96022333579405",
		["Description"] = "Increases the amount of hearts you earn!",
		["MaxLevel"] = 8,
		["Order"] = 19,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.HeartsMultiplier,
		["Format"] = function(p45)
			local v46 = p45 * 100
			return ("x%*"):format(math.floor(v46) / 100)
		end,
		["CalculateMultiplier"] = function(_, p47)
			return p47 * 0.5 + 1
		end,
		["CalculateCost"] = function(_, p48)
			local v49 = 8 ^ p48 * 5e18
			return math.floor(v49)
		end
	},
	["VALENTINE_RUNE_BULK"] = {
		["Name"] = "Valentine Bulk",
		["Icon"] = "rbxassetid://92458066679384",
		["Description"] = "Increases the amount of valentine runes you open!",
		["MaxLevel"] = 25,
		["Order"] = 6,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ValentineRuneBulk,
		["Format"] = function(p50)
			return ("+%*"):format(p50)
		end,
		["CalculateMultiplier"] = function(_, p51)
			return p51
		end,
		["CalculateCost"] = function(_, p52)
			local v53 = 10 ^ (p52 - 1) * 1000
			return math.floor(v53)
		end
	},
	["VALENTINE_RUNE_BULK_2"] = {
		["Name"] = "Valentine Bulk II",
		["Icon"] = "rbxassetid://92458066679384",
		["Description"] = "Increases the amount of valentine runes you open!",
		["MaxLevel"] = 25,
		["Order"] = 8,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ValentineRuneBulk,
		["Format"] = function(p54)
			return ("+%*"):format(p54)
		end,
		["CalculateMultiplier"] = function(_, p55)
			return p55
		end,
		["CalculateCost"] = function(_, p56)
			local v57 = 12 ^ p56 * 1e23
			return math.floor(v57)
		end
	},
	["VALENTINE_RUNE_LUCK"] = {
		["Name"] = "Valentine Rune Luck",
		["Icon"] = "rbxassetid://124800928454437",
		["Description"] = "Increases luck for valentine runes!",
		["MaxLevel"] = 25,
		["Order"] = 7,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ValentineRuneLuck,
		["Format"] = function(p58)
			return ("+%*"):format(p58)
		end,
		["CalculateMultiplier"] = function(_, p59)
			return p59 * 0.25
		end,
		["CalculateCost"] = function(_, p60)
			local v61 = 10 ^ (p60 - 1) * 500
			return math.floor(v61)
		end
	},
	["VALENTINE_RUNE_LUCK_II"] = {
		["Name"] = "Valentine Rune Luck II",
		["Icon"] = "rbxassetid://124800928454437",
		["Description"] = "Increases luck for valentine runes!",
		["MaxLevel"] = 30,
		["Order"] = 8,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ValentineRuneLuck,
		["Format"] = function(p62)
			return ("+%*"):format(p62)
		end,
		["CalculateMultiplier"] = function(_, p63)
			return p63 * 0.5
		end,
		["CalculateCost"] = function(_, p64)
			local v65 = 8 ^ p64 * 1000000000000000
			return math.floor(v65)
		end
	},
	["CRYSTAL_HEARTS_I"] = {
		["Name"] = "Crystal Hearts",
		["Icon"] = "rbxassetid://125560393739137",
		["Description"] = "Increases the amount of crystal hearts you get!",
		["MaxLevel"] = 5,
		["Order"] = 9,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ValentineCrystalShards,
		["Format"] = function(p66)
			return ("+%*"):format(p66)
		end,
		["CalculateMultiplier"] = function(_, p67)
			return p67
		end,
		["CalculateCost"] = function(_, p68)
			local v69 = 10000 ^ p68 * 1000000000000000
			return math.floor(v69)
		end
	},
	["CRYSTAL_HEARTS_DROP_CHANCE"] = {
		["Name"] = "Crystal Hearts Drop Chance",
		["Icon"] = "rbxassetid://125560393739137",
		["Description"] = "Increases how often crystal hearts drop!",
		["MaxLevel"] = 12,
		["Order"] = 10,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Hearts,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ValentineCrystalShardDropChance,
		["Format"] = function(p70)
			local v71 = p70 * 1000
			return ("+%*%%"):format(math.floor(v71) / 10)
		end,
		["CalculateMultiplier"] = function(_, p72)
			return p72 * 0.005
		end,
		["CalculateCost"] = function(_, p73)
			local v74 = 10000 ^ p73 * 1000000000000
			return math.floor(v74)
		end
	}
}
return v75]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VALENTINE_UPGRADES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3943"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v62 = {
	["DAMAGE_INCREASE_5"] = {
		["Name"] = "Damage",
		["Icon"] = "rbxassetid://106746371164727",
		["Description"] = "Increases your damage!",
		["MaxLevel"] = 30,
		["Order"] = 1,
		["CurrencyType"] = v2.GlowCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Damage,
		["Format"] = function(p4)
			return ("+%*"):format(p4)
		end,
		["CalculateMultiplier"] = function(_, p5)
			return p5
		end,
		["CalculateCost"] = function(_, p6)
			local v7 = 1.35 ^ p6 * 2000000
			return math.floor(v7)
		end
	},
	["DAMAGE_INCREASE_6"] = {
		["Name"] = "Damage II",
		["Icon"] = "rbxassetid://106746371164727",
		["Description"] = "Increases your damage!",
		["MaxLevel"] = 25,
		["Order"] = 10,
		["CurrencyType"] = v2.GlowCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Damage,
		["Format"] = function(p8)
			return ("+%*"):format(p8)
		end,
		["CalculateMultiplier"] = function(_, p9)
			return p9
		end,
		["CalculateCost"] = function(_, p10)
			local v11 = 1.8 ^ p10 * 500000000
			return math.floor(v11)
		end
	},
	["GLOOP_SLIME_SPAWN_CAPACITY"] = {
		["Name"] = "Slime Spawn Capacity",
		["Icon"] = "rbxassetid://140179584961588",
		["Description"] = "Increases the maximum number of slimes that can spawn!",
		["MaxLevel"] = 75,
		["Order"] = 2,
		["CurrencyType"] = v2.GlowCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World4SpawnCap,
		["Format"] = function(p12)
			return ("+%*"):format(p12)
		end,
		["CalculateMultiplier"] = function(_, p13)
			return p13
		end,
		["CalculateCost"] = function(_, p14)
			local v15 = 1.18 ^ p14 * 1000000
			return math.floor(v15)
		end
	},
	["GLOOP_SLIME_SPAWN_CAPACITY_2"] = {
		["Name"] = "Slime Spawn Capacity II",
		["Icon"] = "rbxassetid://140179584961588",
		["Description"] = "Increases the maximum number of slimes that can spawn!",
		["MaxLevel"] = 50,
		["Order"] = 11,
		["CurrencyType"] = v2.GlowCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World4SpawnCap,
		["Format"] = function(p16)
			return ("+%*"):format(p16)
		end,
		["CalculateMultiplier"] = function(_, p17)
			return p17
		end,
		["CalculateCost"] = function(_, p18)
			local v19 = 1.35 ^ p18 * 1000000000
			return math.floor(v19)
		end
	},
	["GLOOP_SLIME_LUCK"] = {
		["Name"] = "Slime Luck",
		["Icon"] = "rbxassetid://140179584961588",
		["Description"] = "Chance of spawning better slimes!",
		["MaxLevel"] = 12,
		["Order"] = 3,
		["CurrencyType"] = v2.GlowCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World4SlimeLuck,
		["Format"] = function(p20)
			local v21 = p20 * 100
			return ("+%*%%"):format((math.floor(v21)))
		end,
		["CalculateMultiplier"] = function(_, p22)
			return p22 * 0.1
		end,
		["CalculateCost"] = function(_, p23)
			local v24 = 2.8 ^ p23 * 15000000
			return math.floor(v24)
		end
	},
	["SLIME_SPAWN_SPEED_4"] = {
		["Name"] = "Slime Spawn Speed",
		["Icon"] = "rbxassetid://91181531852133",
		["Description"] = "Increases the speed at which slimes spawn!",
		["MaxLevel"] = 38,
		["Order"] = 4,
		["CurrencyType"] = v2.GlowCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World4SpawnRate,
		["Format"] = function(p25)
			local v26 = p25 * 1000
			return ("-%*s"):format(math.floor(v26) / 1000)
		end,
		["CalculateMultiplier"] = function(_, p27)
			return p27 * 0.025
		end,
		["CalculateCost"] = function(_, p28)
			local v29 = 1.8 ^ p28 * 3000000
			return math.floor(v29)
		end
	},
	["SLIME_SPAWN_SPEED_5"] = {
		["Name"] = "Slime Spawn Speed II",
		["Icon"] = "rbxassetid://91181531852133",
		["Description"] = "Increases the speed at which slimes spawn!",
		["MaxLevel"] = 20,
		["Order"] = 12,
		["CurrencyType"] = v2.GlowCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World4SpawnRate,
		["Format"] = function(p30)
			local v31 = p30 * 1000
			return ("-%*s"):format(math.floor(v31) / 1000)
		end,
		["CalculateMultiplier"] = function(_, p32)
			return p32 * 0.025
		end,
		["CalculateCost"] = function(_, p33)
			local v34 = 3 ^ p33 * 2000000000
			return math.floor(v34)
		end
	},
	["GLOOP_COINS_MULTIPLIER_2"] = {
		["Name"] = "Glow Coin Multiplier",
		["Icon"] = "rbxassetid://85479817882405",
		["Description"] = "Increases the amount of glow coins you earn!",
		["MaxLevel"] = 10,
		["Order"] = 5,
		["CurrencyType"] = v2.GlowCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.GlowCoinsMultiplier,
		["Format"] = function(p35)
			local v36 = p35 * 100
			return ("x%*"):format(math.floor(v36) / 100)
		end,
		["CalculateMultiplier"] = function(_, p37)
			return p37 * 0.5 + 1
		end,
		["CalculateCost"] = function(_, p38)
			local v39 = 3.5 ^ p38 * 5000000
			return math.floor(v39)
		end
	},
	["GLOOP_COINS_MULTIPLIER_3"] = {
		["Name"] = "Glow Coin Multiplier II",
		["Icon"] = "rbxassetid://85479817882405",
		["Description"] = "Increases the amount of glow coins you earn!",
		["MaxLevel"] = 8,
		["Order"] = 13,
		["CurrencyType"] = v2.GlowCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.GlowCoinsMultiplier,
		["Format"] = function(p40)
			local v41 = p40 * 100
			return ("x%*"):format(math.floor(v41) / 100)
		end,
		["CalculateMultiplier"] = function(_, p42)
			return p42 * 0.5 + 1
		end,
		["CalculateCost"] = function(_, p43)
			local v44 = 5 ^ p43 * 5000000000
			return math.floor(v44)
		end
	},
	["GLOOP_DAMAGE_MULTIPLIER"] = {
		["Name"] = "Damage Multiplier",
		["Icon"] = "rbxassetid://106746371164727",
		["Description"] = "Multiplies your damage!",
		["MaxLevel"] = 15,
		["Order"] = 6,
		["CurrencyType"] = v2.GlowCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.DamageMultiplier,
		["Format"] = function(p45)
			local v46 = p45 * 100
			return ("x%*"):format(math.floor(v46) / 100)
		end,
		["CalculateMultiplier"] = function(_, p47)
			return p47 * 0.25 + 1
		end,
		["CalculateCost"] = function(_, p48)
			local v49 = 3 ^ p48 * 3000000
			return math.floor(v49)
		end
	},
	["GLOOP_ATTACK_RANGE"] = {
		["Name"] = "Attack Range",
		["Icon"] = "rbxassetid://78157289763375",
		["Description"] = "Increases your attack range!",
		["MaxLevel"] = 20,
		["Order"] = 7,
		["CurrencyType"] = v2.GlowCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World4AttackRange,
		["Format"] = function(p50)
			return ("+%*"):format(p50)
		end,
		["CalculateMultiplier"] = function(_, p51)
			return p51 * 0.5
		end,
		["CalculateCost"] = function(_, p52)
			local v53 = 2.5 ^ p52 * 5000000
			return math.floor(v53)
		end
	},
	["GLOOP_RUNE_BULK"] = {
		["Name"] = "Glow Rune Bulk",
		["Icon"] = "rbxassetid://92458066679384",
		["Description"] = "Increases the amount of glow runes you open!",
		["MaxLevel"] = 25,
		["Order"] = 8,
		["CurrencyType"] = v2.GlowCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.RuneBulk,
		["Format"] = function(p54)
			return ("+%*"):format(p54)
		end,
		["CalculateMultiplier"] = function(_, p55)
			return p55 * 5
		end,
		["CalculateCost"] = function(_, p56)
			local v57 = 2.5 ^ p56 * 10000000
			return math.floor(v57)
		end
	},
	["GLOOP_RUNE_LUCK"] = {
		["Name"] = "Glow Rune Luck",
		["Icon"] = "rbxassetid://124800928454437",
		["Description"] = "Increases luck for glow runes!",
		["MaxLevel"] = 30,
		["Order"] = 9,
		["CurrencyType"] = v2.GlowCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.RuneLuck,
		["Format"] = function(p58)
			return ("+%*"):format(p58)
		end,
		["CalculateMultiplier"] = function(_, p59)
			return p59 * 0.5
		end,
		["CalculateCost"] = function(_, p60)
			local v61 = 2.2 ^ p60 * 8000000
			return math.floor(v61)
		end
	}
}
return v62]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GLOW_WORLD_UPGRADES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3944"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v56 = {
	["EVENT_1M_SLIME_SPAWN_CAP"] = {
		["Name"] = "Slime Spawn Capacity",
		["Icon"] = "rbxassetid://129741587638825",
		["Description"] = "Increases the maximum number of slimes that can spawn!",
		["MaxLevel"] = 25,
		["Order"] = 1,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MBalloon,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MSpawnCap,
		["Format"] = function(p4)
			return ("+%*"):format(p4)
		end,
		["CalculateMultiplier"] = function(_, p5)
			return p5
		end,
		["CalculateCost"] = function(_, p6)
			local v7 = 1.8 ^ p6 * 6
			return math.floor(v7)
		end
	},
	["EVENT_1M_SLIME_SPAWN_CAP_2"] = {
		["Name"] = "Slime Spawn Capacity II",
		["Icon"] = "rbxassetid://129741587638825",
		["Description"] = "Increases the maximum number of slimes that can spawn!",
		["MaxLevel"] = 15,
		["Order"] = 11,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MBalloon,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MSpawnCap,
		["Format"] = function(p8)
			return ("+%*"):format(p8)
		end,
		["CalculateMultiplier"] = function(_, p9)
			return p9
		end,
		["CalculateCost"] = function(_, p10)
			local v11 = 3.25 ^ p10 * 3000000000000
			return math.floor(v11)
		end
	},
	["EVENT_1M_SLIME_SPAWN_SPEED"] = {
		["Name"] = "Slime Spawn Speed",
		["Icon"] = "rbxassetid://91181531852133",
		["Description"] = "Increases the speed at which slimes spawn!",
		["MaxLevel"] = 10,
		["Order"] = 2,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MBalloon,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MSpawnRate,
		["Format"] = function(p12)
			local v13 = p12 * 100
			return ("-%*"):format(math.floor(v13) / 100)
		end,
		["CalculateMultiplier"] = function(_, p14)
			return p14 * 0.05
		end,
		["CalculateCost"] = function(_, p15)
			local v16 = 2.25 ^ p15 * 6
			return math.floor(v16)
		end
	},
	["EVENT_1M_SLIME_SPAWN_SPEED_2"] = {
		["Name"] = "Slime Spawn Speed II",
		["Icon"] = "rbxassetid://91181531852133",
		["Description"] = "Increases the speed at which slimes spawn!",
		["MaxLevel"] = 5,
		["Order"] = 12,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MBalloon,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MSpawnRate,
		["Format"] = function(p17)
			local v18 = p17 * 100
			return ("-%*"):format(math.floor(v18) / 100)
		end,
		["CalculateMultiplier"] = function(_, p19)
			return p19 * 0.05
		end,
		["CalculateCost"] = function(_, p20)
			local v21 = 15 ^ p20 * 5e18
			return math.floor(v21)
		end
	},
	["EVENT_1M_SLIME_LUCK"] = {
		["Name"] = "Slime Luck",
		["Icon"] = "rbxassetid://124800928454437",
		["Description"] = "Chance of spawning better slimes!",
		["MaxLevel"] = 10,
		["Order"] = 3,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MBalloon,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MSlimeLuck,
		["Format"] = function(p22)
			local v23 = p22 * 100
			return ("+%*%%"):format((math.floor(v23)))
		end,
		["CalculateMultiplier"] = function(_, p24)
			return p24 * 0.1
		end,
		["CalculateCost"] = function(_, p25)
			local v26 = 3.5 ^ p25 * 30000000000000
			return math.floor(v26)
		end
	},
	["EVENT_1M_ATTACK_RANGE"] = {
		["Name"] = "Attack Range",
		["Icon"] = "rbxassetid://78157289763375",
		["Description"] = "Increases the range of your attacks!",
		["MaxLevel"] = 8,
		["Order"] = 3,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MBalloon,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MAttackRange,
		["Format"] = function(p27)
			return ("+%*"):format(p27)
		end,
		["CalculateMultiplier"] = function(_, p28)
			return p28 * 0.5
		end,
		["CalculateCost"] = function(_, p29)
			local v30 = 2.5 ^ p29 * 6
			return math.floor(v30)
		end
	},
	["EVENT_1M_DAMAGE"] = {
		["Name"] = "Damage",
		["Icon"] = "rbxassetid://106746371164727",
		["Description"] = "Increases your 1M event damage!",
		["MaxLevel"] = 20,
		["Order"] = 4,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MBalloon,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MDamage,
		["Format"] = function(p31)
			return ("+%*"):format(p31)
		end,
		["CalculateMultiplier"] = function(_, p32)
			return p32 * 2
		end,
		["CalculateCost"] = function(_, p33)
			local v34 = 2.5 ^ p33 * 6
			return math.floor(v34)
		end
	},
	["EVENT_1M_DAMAGE_2"] = {
		["Name"] = "Damage II",
		["Icon"] = "rbxassetid://106746371164727",
		["Description"] = "Increases your 1M event damage!",
		["MaxLevel"] = 20,
		["Order"] = 13,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MBalloon,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MDamage,
		["Format"] = function(p35)
			return ("+%*"):format(p35)
		end,
		["CalculateMultiplier"] = function(_, p36)
			return p36 * 5
		end,
		["CalculateCost"] = function(_, p37)
			local v38 = 3.25 ^ p37 * 3e20
			return math.floor(v38)
		end
	},
	["EVENT_1M_ATTACK_SPEED"] = {
		["Name"] = "Attack Speed",
		["Icon"] = "rbxassetid://83884379124762",
		["Description"] = "Increases your attack speed in the 1M event world!",
		["MaxLevel"] = 8,
		["Order"] = 5,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MBalloon,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MAttackSpeedMultiplier,
		["Format"] = function(p39)
			local v40 = p39 * 100
			return ("x%*"):format(math.floor(v40) / 100)
		end,
		["CalculateMultiplier"] = function(_, p41)
			return p41 * 0.1 + 1
		end,
		["CalculateCost"] = function(_, p42)
			local v43 = 2.75 ^ p42 * 6
			return math.floor(v43)
		end
	},
	["EVENT_1M_BALLOONS_MULTIPLIER"] = {
		["Name"] = "Balloon Multiplier",
		["Icon"] = "rbxassetid://87434791157715",
		["Description"] = "Increases the amount of 1M balloons you earn!\nDoubles every 10 levels",
		["MaxLevel"] = 60,
		["Order"] = 6,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MBalloon,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MBalloonsMultiplier,
		["Format"] = function(p44)
			local v45 = p44 * 100
			return ("x%*"):format(math.floor(v45) / 100)
		end,
		["CalculateMultiplier"] = function(_, p46)
			local v47 = p46 * 0.25
			local v48 = p46 / 10
			return v47 * 2 ^ math.floor(v48) + 1
		end,
		["CalculateCost"] = function(_, p49)
			local v50 = 2.5 ^ p49 * 15
			return math.floor(v50)
		end
	},
	["EVENT_1M_BALLOONS_MULTIPLIER_2"] = {
		["Name"] = "Balloon Multiplier II",
		["Icon"] = "rbxassetid://87434791157715",
		["Description"] = "Increases the amount of 1M balloons you earn!",
		["MaxLevel"] = 6,
		["Order"] = 14,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MBalloon,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MBalloonsMultiplier,
		["Format"] = function(p51)
			local v52 = p51 * 100
			return ("x%*"):format(math.floor(v52) / 100)
		end,
		["CalculateMultiplier"] = function(_, p53)
			return p53 * 0.5 + 1
		end,
		["CalculateCost"] = function(_, p54)
			local v55 = 6 ^ p54 * 3e19
			return math.floor(v55)
		end
	}
}
return v56]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[EVENT_1M_UPGRADES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3945"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v90 = {
	["CONFETTI_BASE_VALUE"] = {
		["Name"] = "Base Value",
		["Icon"] = "rbxassetid://122967445525805",
		["Description"] = "Increases the base confetti earned per click!",
		["MaxLevel"] = 35,
		["Order"] = 1,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ConfettiBaseValue,
		["Format"] = function(p4)
			return ("+%*"):format(p4)
		end,
		["CalculateMultiplier"] = function(_, p5)
			return p5 * 2
		end,
		["CalculateCost"] = function(_, p6)
			local v7 = 1.55 ^ p6 * 6
			return math.floor(v7)
		end
	},
	["CONFETTI_BASE_VALUE_2"] = {
		["Name"] = "Base Value II",
		["Icon"] = "rbxassetid://122967445525805",
		["Description"] = "Further increases the base confetti earned per click!",
		["MaxLevel"] = 20,
		["Order"] = 12,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ConfettiBaseValue,
		["Format"] = function(p8)
			return ("+%*"):format(p8)
		end,
		["CalculateMultiplier"] = function(_, p9)
			return p9 * 3
		end,
		["CalculateCost"] = function(_, p10)
			local v11 = 2.5 ^ p10 * 3000000000000
			return math.floor(v11)
		end
	},
	["CONFETTI_MULTIPLIER"] = {
		["Name"] = "Confetti Multiplier",
		["Icon"] = "rbxassetid://122967445525805",
		["Description"] = "Multiplies confetti earned per click!\nDoubles every 10 levels",
		["MaxLevel"] = 60,
		["Order"] = 2,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ConfettiMultiplier,
		["Format"] = function(p12)
			local v13 = p12 * 100
			return ("x%*"):format(math.floor(v13) / 100)
		end,
		["CalculateMultiplier"] = function(_, p14)
			local v15 = p14 * 0.25
			local v16 = p14 / 10
			return v15 * 2 ^ math.floor(v16) + 1
		end,
		["CalculateCost"] = function(_, p17)
			local v18 = 2.1 ^ p17 * 8
			return math.floor(v18)
		end
	},
	["CONFETTI_MULTIPLIER_2"] = {
		["Name"] = "Confetti Multiplier II",
		["Icon"] = "rbxassetid://122967445525805",
		["Description"] = "Further multiplies confetti earned!",
		["MaxLevel"] = 8,
		["Order"] = 13,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ConfettiMultiplier,
		["Format"] = function(p19)
			local v20 = p19 * 100
			return ("x%*"):format(math.floor(v20) / 100)
		end,
		["CalculateMultiplier"] = function(_, p21)
			return p21 * 0.5 + 1
		end,
		["CalculateCost"] = function(_, p22)
			local v23 = 4 ^ p22 * 3e18
			return math.floor(v23)
		end
	},
	["CONFETTI_CLICK_SPEED"] = {
		["Name"] = "Click Speed",
		["Icon"] = "rbxassetid://83884379124762",
		["Description"] = "Reduces the cooldown between clicks!",
		["MaxLevel"] = 15,
		["Order"] = 3,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ConfettiClickSpeed,
		["Format"] = function(p24)
			local v25 = p24 * 100
			return ("-%*s"):format(math.floor(v25) / 100)
		end,
		["CalculateMultiplier"] = function(_, p26)
			return p26 * 0.04
		end,
		["CalculateCost"] = function(_, p27)
			local v28 = 2.25 ^ p27 * 15
			return math.floor(v28)
		end
	},
	["CONFETTI_CLICK_SPEED_2"] = {
		["Name"] = "Click Speed II",
		["Icon"] = "rbxassetid://83884379124762",
		["Description"] = "Further reduces the cooldown between clicks!",
		["MaxLevel"] = 6,
		["Order"] = 14,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ConfettiClickSpeed,
		["Format"] = function(p29)
			local v30 = p29 * 100
			return ("-%*s"):format(math.floor(v30) / 100)
		end,
		["CalculateMultiplier"] = function(_, p31)
			return p31 * 0.03
		end,
		["CalculateCost"] = function(_, p32)
			local v33 = 8 ^ p32 * 3000000000000000
			return math.floor(v33)
		end
	},
	["CONFETTI_AUTO_CLICK"] = {
		["Name"] = "Auto Clicker",
		["Icon"] = "rbxassetid://122967445525805",
		["Description"] = "Automatically earns confetti every second!",
		["MaxLevel"] = 20,
		["Order"] = 4,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ConfettiAutoClick,
		["Format"] = function(p34)
			return ("+%*/s"):format(p34)
		end,
		["CalculateMultiplier"] = function(_, p35)
			return p35
		end,
		["CalculateCost"] = function(_, p36)
			local v37 = 3 ^ p36 * 60
			return math.floor(v37)
		end
	},
	["CONFETTI_AUTO_CLICK_2"] = {
		["Name"] = "Auto Clicker II",
		["Icon"] = "rbxassetid://122967445525805",
		["Description"] = "Further increases automatic confetti per second!",
		["MaxLevel"] = 12,
		["Order"] = 15,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ConfettiAutoClick,
		["Format"] = function(p38)
			return ("+%*/s"):format(p38)
		end,
		["CalculateMultiplier"] = function(_, p39)
			return p39 * 2
		end,
		["CalculateCost"] = function(_, p40)
			local v41 = 4 ^ p40 * 300000000000000
			return math.floor(v41)
		end
	},
	["CONFETTI_AUTO_MULTIPLIER"] = {
		["Name"] = "Auto Multiplier",
		["Icon"] = "rbxassetid://122967445525805",
		["Description"] = "Multiplies confetti earned from auto clicker!",
		["MaxLevel"] = 35,
		["Order"] = 5,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ConfettiAutoMultiplier,
		["Format"] = function(p42)
			local v43 = p42 * 100
			return ("x%*"):format(math.floor(v43) / 100)
		end,
		["CalculateMultiplier"] = function(_, p44)
			return p44 * 0.2 + 1
		end,
		["CalculateCost"] = function(_, p45)
			local v46 = 2.5 ^ p45 * 100
			return math.floor(v46)
		end
	},
	["CONFETTI_CRITICAL_CHANCE"] = {
		["Name"] = "Critical Click",
		["Icon"] = "rbxassetid://122967445525805",
		["Description"] = "Chance for a critical click that earns bonus confetti!",
		["MaxLevel"] = 10,
		["Order"] = 6,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ConfettiCriticalChance,
		["Format"] = function(p47)
			local v48 = p47 * 100
			return ("+%*%%"):format((math.floor(v48)))
		end,
		["CalculateMultiplier"] = function(_, p49)
			return p49 * 0.05
		end,
		["CalculateCost"] = function(_, p50)
			local v51 = 3.5 ^ p50 * 500
			return math.floor(v51)
		end
	},
	["CONFETTI_CRITICAL_MULTIPLIER"] = {
		["Name"] = "Critical Power",
		["Icon"] = "rbxassetid://122967445525805",
		["Description"] = "Increases the multiplier on critical clicks!",
		["MaxLevel"] = 10,
		["Order"] = 7,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.ConfettiCriticalMultiplier,
		["Format"] = function(p52)
			local v53 = p52 * 100
			return ("x%*"):format(math.floor(v53) / 100)
		end,
		["CalculateMultiplier"] = function(_, p54)
			return p54 * 0.5
		end,
		["CalculateCost"] = function(_, p55)
			local v56 = 3.75 ^ p55 * 5000
			return math.floor(v56)
		end
	},
	["CONFETTI_BALLOON_MULTI"] = {
		["Name"] = "Balloon Multiplier",
		["Icon"] = "rbxassetid://87434791157715",
		["Description"] = "Increases the amount of 1M balloons you earn!",
		["MaxLevel"] = 60,
		["Order"] = 8,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MBalloonsMultiplier,
		["Format"] = function(p57)
			local v58 = p57 * 100
			return ("x%*"):format(math.floor(v58) / 100)
		end,
		["CalculateMultiplier"] = function(_, p59)
			return p59 * 0.15 + 1
		end,
		["CalculateCost"] = function(_, p60)
			local v61 = 2.1 ^ p60 * 30
			return math.floor(v61)
		end
	},
	["CONFETTI_BALLOON_MULTI_2"] = {
		["Name"] = "Balloon Multiplier II",
		["Icon"] = "rbxassetid://87434791157715",
		["Description"] = "Further increases balloon earnings!",
		["MaxLevel"] = 6,
		["Order"] = 16,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MBalloonsMultiplier,
		["Format"] = function(p62)
			local v63 = p62 * 100
			return ("x%*"):format(math.floor(v63) / 100)
		end,
		["CalculateMultiplier"] = function(_, p64)
			return p64 * 0.5 + 1
		end,
		["CalculateCost"] = function(_, p65)
			local v66 = 6 ^ p65 * 3e16
			return math.floor(v66)
		end
	},
	["CONFETTI_SPAWN_CAP"] = {
		["Name"] = "Spawn Capacity",
		["Icon"] = "rbxassetid://129741587638825",
		["Description"] = "Increases the maximum number of 1M slimes that can spawn!",
		["MaxLevel"] = 18,
		["Order"] = 9,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MSpawnCap,
		["Format"] = function(p67)
			return ("+%*"):format(p67)
		end,
		["CalculateMultiplier"] = function(_, p68)
			return p68
		end,
		["CalculateCost"] = function(_, p69)
			local v70 = 2.5 ^ p69 * 30
			return math.floor(v70)
		end
	},
	["CONFETTI_SPAWN_SPEED"] = {
		["Name"] = "Spawn Speed",
		["Icon"] = "rbxassetid://91181531852133",
		["Description"] = "Increases the speed at which 1M slimes spawn!",
		["MaxLevel"] = 8,
		["Order"] = 10,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MSpawnRate,
		["Format"] = function(p71)
			local v72 = p71 * 100
			return ("-%*s"):format(math.floor(v72) / 100)
		end,
		["CalculateMultiplier"] = function(_, p73)
			return p73 * 0.03
		end,
		["CalculateCost"] = function(_, p74)
			local v75 = 3 ^ p74 * 250
			return math.floor(v75)
		end
	},
	["CONFETTI_DAMAGE"] = {
		["Name"] = "Damage",
		["Icon"] = "rbxassetid://106746371164727",
		["Description"] = "Increases your 1M event damage!",
		["MaxLevel"] = 18,
		["Order"] = 11,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MDamage,
		["Format"] = function(p76)
			return ("+%*"):format(p76)
		end,
		["CalculateMultiplier"] = function(_, p77)
			return p77 * 2
		end,
		["CalculateCost"] = function(_, p78)
			local v79 = 2.5 ^ p78 * 35
			return math.floor(v79)
		end
	},
	["CONFETTI_ATTACK_SPEED"] = {
		["Name"] = "Attack Speed",
		["Icon"] = "rbxassetid://83884379124762",
		["Description"] = "Increases your attack speed in the 1M event world!",
		["MaxLevel"] = 8,
		["Order"] = 17,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MAttackSpeedMultiplier,
		["Format"] = function(p80)
			local v81 = p80 * 100
			return ("x%*"):format(math.floor(v81) / 100)
		end,
		["CalculateMultiplier"] = function(_, p82)
			return p82 * 0.1 + 1
		end,
		["CalculateCost"] = function(_, p83)
			local v84 = 3 ^ p83 * 180
			return math.floor(v84)
		end
	},
	["CONFETTI_SLIME_LUCK"] = {
		["Name"] = "Slime Luck",
		["Icon"] = "rbxassetid://124800928454437",
		["Description"] = "Increases your chance of spawning better 1M slimes!",
		["MaxLevel"] = 8,
		["Order"] = 18,
		["IgnoreSuperRebirth"] = true,
		["CurrencyType"] = v2.Event1MConfetti,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.Event1MSlimeLuck,
		["Format"] = function(p85)
			local v86 = p85 * 100
			return ("+%*%%"):format((math.floor(v86)))
		end,
		["CalculateMultiplier"] = function(_, p87)
			return p87 * 0.08
		end,
		["CalculateCost"] = function(_, p88)
			local v89 = 3.5 ^ p88 * 1000
			return math.floor(v89)
		end
	}
}
return v90]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CONFETTI_UPGRADES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3946"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v22 = {
	["CANDY_SLIME_SPAWN_CAPACITY"] = {
		["Name"] = "Slime Spawn Capacity",
		["Icon"] = "rbxassetid://140179584961588",
		["Description"] = "Increases the maximum number of candy slimes that can spawn!",
		["MaxLevel"] = 25,
		["Order"] = 1,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World5SpawnCap,
		["Format"] = function(p4)
			return ("+%*"):format(p4)
		end,
		["CalculateMultiplier"] = function(_, p5)
			return p5
		end,
		["CalculateCost"] = function(_, p6)
			local v7 = 1.22 ^ p6 * 50000
			return math.floor(v7)
		end
	},
	["CANDY_SPAWN_SPEED_1"] = {
		["Name"] = "Slime Spawn Speed",
		["Icon"] = "rbxassetid://91181531852133",
		["Description"] = "Reduces the time between candy slime spawns!",
		["MaxLevel"] = 15,
		["Order"] = 2,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World5SpawnRate,
		["Format"] = function(p8)
			local v9 = p8 * 1000
			return ("-%*s"):format(math.floor(v9) / 1000)
		end,
		["CalculateMultiplier"] = function(_, p10)
			return p10 * 0.02
		end,
		["CalculateCost"] = function(_, p11)
			local v12 = 1.35 ^ p11 * 80000
			return math.floor(v12)
		end
	},
	["CANDY_COINS_MULTIPLIER_1"] = {
		["Name"] = "Candy Coin Multiplier",
		["Icon"] = "rbxassetid://107119582007802",
		["Description"] = "Multiplies the candy coins you earn!",
		["MaxLevel"] = 8,
		["Order"] = 3,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.CandyCoinsMultiplier,
		["Format"] = function(p13)
			local v14 = p13 * 100
			return ("x%*"):format(math.floor(v14) / 100)
		end,
		["CalculateMultiplier"] = function(_, p15)
			return p15 * 0.5 + 1
		end,
		["CalculateCost"] = function(_, p16)
			local v17 = 2.8 ^ p16 * 500000
			return math.floor(v17)
		end
	},
	["CANDY_ATTACK_RANGE_1"] = {
		["Name"] = "Candy Attack Range",
		["Icon"] = "rbxassetid://78157289763375",
		["Description"] = "Increases your attack range in Candy World!",
		["MaxLevel"] = 10,
		["Order"] = 4,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World5AttackRange,
		["Format"] = function(p18)
			return ("+%*"):format(p18)
		end,
		["CalculateMultiplier"] = function(_, p19)
			return p19 * 0.5
		end,
		["CalculateCost"] = function(_, p20)
			local v21 = 1.5 ^ p20 * 150000
			return math.floor(v21)
		end
	}
}
return v22]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CANDY_WORLD_UPGRADES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3947"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v23 = {
	["CANDY_SLIME_SPAWN_CAPACITY_2"] = {
		["Name"] = "Slime Spawn Capacity II",
		["Icon"] = "rbxassetid://140179584961588",
		["Description"] = "Further increases candy slime spawn capacity!",
		["MaxLevel"] = 20,
		["Order"] = 1,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World5SpawnCap,
		["Format"] = function(p4)
			return ("+%*"):format(p4)
		end,
		["CalculateMultiplier"] = function(_, p5)
			return p5
		end,
		["CalculateCost"] = function(_, p6)
			local v7 = 1.28 ^ p6 * 2500000
			return math.floor(v7)
		end
	},
	["CANDY_SPAWN_SPEED_2"] = {
		["Name"] = "Slime Spawn Speed II",
		["Icon"] = "rbxassetid://91181531852133",
		["Description"] = "Further reduces candy slime spawn time!",
		["MaxLevel"] = 12,
		["Order"] = 2,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World5SpawnRate,
		["Format"] = function(p8)
			local v9 = p8 * 1000
			return ("-%*s"):format(math.floor(v9) / 1000)
		end,
		["CalculateMultiplier"] = function(_, p10)
			return p10 * 0.02
		end,
		["CalculateCost"] = function(_, p11)
			local v12 = 1.45 ^ p11 * 5000000
			return math.floor(v12)
		end
	},
	["CANDY_COINS_MULTIPLIER_2"] = {
		["Name"] = "Candy Coin Multiplier II",
		["Icon"] = "rbxassetid://107119582007802",
		["Description"] = "Further multiplies candy coin earnings!",
		["MaxLevel"] = 6,
		["Order"] = 3,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.CandyCoinsMultiplier,
		["Format"] = function(p13)
			local v14 = p13 * 100
			return ("x%*"):format(math.floor(v14) / 100)
		end,
		["CalculateMultiplier"] = function(_, p15)
			return p15 * 0.35 + 1
		end,
		["CalculateCost"] = function(_, p16)
			local v17 = 2.8 ^ p16 * 25000000
			return math.floor(v17)
		end
	},
	["CANDY_RUNE_BULK_1"] = {
		["Name"] = "Rune Bulk Multiplier",
		["Icon"] = "rbxassetid://92458066679384",
		["Description"] = "Open more candy runes at once!",
		["MaxLevel"] = 15,
		["Order"] = 4,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.RuneBulkMultiplier,
		["Format"] = function(p18)
			local v19 = p18 * 100
			return ("x%*"):format(math.floor(v19) / 100)
		end,
		["CalculateMultiplier"] = function(_, p20)
			return p20 * 0.01 + 1
		end,
		["CalculateCost"] = function(_, p21)
			local v22 = 1.5 ^ p21 * 10000000
			return math.floor(v22)
		end
	}
}
return v23]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CANDY_WORLD_UPGRADES_2]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3948"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v26 = {
	["CANDY_SLIME_SPAWN_CAPACITY_3"] = {
		["Name"] = "Slime Spawn Capacity III",
		["Icon"] = "rbxassetid://140179584961588",
		["Description"] = "Even more candy slime spawns!",
		["MaxLevel"] = 18,
		["Order"] = 1,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World5SpawnCap,
		["Format"] = function(p4)
			return ("+%*"):format(p4)
		end,
		["CalculateMultiplier"] = function(_, p5)
			return p5
		end,
		["CalculateCost"] = function(_, p6)
			local v7 = 1.35 ^ p6 * 20000000000
			return math.floor(v7)
		end
	},
	["CANDY_COINS_MULTIPLIER_3"] = {
		["Name"] = "Candy Coin Multiplier III",
		["Icon"] = "rbxassetid://107119582007802",
		["Description"] = "A powerful boost to candy coin earnings!",
		["MaxLevel"] = 5,
		["Order"] = 2,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.CandyCoinsMultiplier,
		["Format"] = function(p8)
			local v9 = p8 * 100
			return ("x%*"):format(math.floor(v9) / 100)
		end,
		["CalculateMultiplier"] = function(_, p10)
			return p10 * 0.3 + 1
		end,
		["CalculateCost"] = function(_, p11)
			local v12 = 3.2 ^ p11 * 200000000000
			return math.floor(v12)
		end
	},
	["CANDY_ATTACK_RANGE_2"] = {
		["Name"] = "Candy Attack Range II",
		["Icon"] = "rbxassetid://78157289763375",
		["Description"] = "Further increases your candy world attack range!",
		["MaxLevel"] = 10,
		["Order"] = 3,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World5AttackRange,
		["Format"] = function(p13)
			return ("+%*"):format(p13)
		end,
		["CalculateMultiplier"] = function(_, p14)
			return p14 * 0.5
		end,
		["CalculateCost"] = function(_, p15)
			local v16 = 1.6 ^ p15 * 40000000000
			return math.floor(v16)
		end
	},
	["CANDY_RUNE_LUCK_1"] = {
		["Name"] = "Candy Rune Luck",
		["Icon"] = "rbxassetid://124800928454437",
		["Description"] = "Increases your luck finding rare candy runes!",
		["MaxLevel"] = 20,
		["Order"] = 4,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.RuneLuck,
		["Format"] = function(p17)
			return ("+%*"):format(p17)
		end,
		["CalculateMultiplier"] = function(_, p18)
			return p18 * 0.5
		end,
		["CalculateCost"] = function(_, p19)
			local v20 = 1.55 ^ p19 * 30000000000
			return math.floor(v20)
		end
	},
	["CANDY_GLOOP_COLLECT_LUCK"] = {
		["Name"] = "Gloop Finder",
		["Icon"] = "rbxassetid://124800928454437",
		["Description"] = "Increases your luck finding gloop in the Glow World!",
		["MaxLevel"] = 8,
		["Order"] = 5,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.GloopCollectLuck,
		["Format"] = function(p21)
			local v22 = p21 * 100
			return ("+%*%%"):format((math.floor(v22)))
		end,
		["CalculateMultiplier"] = function(_, p23)
			return p23 * 0.5
		end,
		["CalculateCost"] = function(_, p24)
			local v25 = 2.2 ^ p24 * 100000000000
			return math.floor(v25)
		end
	}
}
return v26]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CANDY_WORLD_UPGRADES_3]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3949"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v27 = {
	["CANDY_SLIME_SPAWN_CAPACITY_4"] = {
		["Name"] = "Slime Spawn Capacity IV",
		["Icon"] = "rbxassetid://140179584961588",
		["Description"] = "Massively increases candy slime spawns!",
		["MaxLevel"] = 15,
		["Order"] = 1,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World5SpawnCap,
		["Format"] = function(p4)
			return ("+%*"):format(p4)
		end,
		["CalculateMultiplier"] = function(_, p5)
			return p5
		end,
		["CalculateCost"] = function(_, p6)
			local v7 = 1.5 ^ p6 * 5000000000000
			return math.floor(v7)
		end
	},
	["CANDY_SPAWN_SPEED_3"] = {
		["Name"] = "Slime Spawn Speed III",
		["Icon"] = "rbxassetid://91181531852133",
		["Description"] = "Slimes spawn even faster!",
		["MaxLevel"] = 10,
		["Order"] = 2,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World5SpawnRate,
		["Format"] = function(p8)
			local v9 = p8 * 1000
			return ("-%*s"):format(math.floor(v9) / 1000)
		end,
		["CalculateMultiplier"] = function(_, p10)
			return p10 * 0.02
		end,
		["CalculateCost"] = function(_, p11)
			local v12 = 1.65 ^ p11 * 10000000000000
			return math.floor(v12)
		end
	},
	["CANDY_PET_XP_1"] = {
		["Name"] = "Pet Experience",
		["Icon"] = "rbxassetid://140179584961588",
		["Description"] = "Your pets earn more experience from candy slimes!",
		["MaxLevel"] = 15,
		["Order"] = 3,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.PetXP,
		["Format"] = function(p13)
			return ("+%*"):format(p13)
		end,
		["CalculateMultiplier"] = function(_, p14)
			return p14 * 2
		end,
		["CalculateCost"] = function(_, p15)
			local v16 = 1.55 ^ p15 * 3000000000000
			return math.floor(v16)
		end
	},
	["CANDY_RUNE_BULK_MULT"] = {
		["Name"] = "Rune Bulk Multiplier",
		["Icon"] = "rbxassetid://92458066679384",
		["Description"] = "Multiplies your rune opening bulk!",
		["MaxLevel"] = 5,
		["Order"] = 4,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.RuneBulkMultiplier,
		["Format"] = function(p17)
			local v18 = p17 * 100
			return ("x%*"):format(math.floor(v18) / 100)
		end,
		["CalculateMultiplier"] = function(_, p19)
			return p19 * 0.01 + 1
		end,
		["CalculateCost"] = function(_, p20)
			local v21 = 3 ^ p20 * 20000000000000
			return math.floor(v21)
		end
	},
	["CANDY_COINS_MULTIPLIER_4"] = {
		["Name"] = "Candy Coin Multiplier IV",
		["Icon"] = "rbxassetid://107119582007802",
		["Description"] = "An immense boost to candy coin earnings!",
		["MaxLevel"] = 5,
		["Order"] = 5,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.CandyCoinsMultiplier,
		["Format"] = function(p22)
			local v23 = p22 * 100
			return ("x%*"):format(math.floor(v23) / 100)
		end,
		["CalculateMultiplier"] = function(_, p24)
			return p24 * 0.25 + 1
		end,
		["CalculateCost"] = function(_, p25)
			local v26 = 3.5 ^ p25 * 10000000000000
			return math.floor(v26)
		end
	}
}
return v27]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CANDY_WORLD_UPGRADES_4]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3950"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v23 = {
	["CANDY_SLIME_SPAWN_CAPACITY_5"] = {
		["Name"] = "Slime Spawn Capacity V",
		["Icon"] = "rbxassetid://140179584961588",
		["Description"] = "The ultimate candy slime spawn capacity!",
		["MaxLevel"] = 10,
		["Order"] = 1,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.World5SpawnCap,
		["Format"] = function(p4)
			return ("+%*"):format(p4)
		end,
		["CalculateMultiplier"] = function(_, p5)
			return p5
		end,
		["CalculateCost"] = function(_, p6)
			local v7 = 1.55 ^ p6 * 500000000000000
			return math.floor(v7)
		end
	},
	["CANDY_PET_XP_MULT"] = {
		["Name"] = "Pet XP Multiplier",
		["Icon"] = "rbxassetid://140179584961588",
		["Description"] = "Multiplies all pet experience earned!",
		["MaxLevel"] = 8,
		["Order"] = 2,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.PetXPMultiplier,
		["Format"] = function(p8)
			local v9 = p8 * 100
			return ("x%*"):format(math.floor(v9) / 100)
		end,
		["CalculateMultiplier"] = function(_, p10)
			return p10 * 0.0125 + 1
		end,
		["CalculateCost"] = function(_, p11)
			local v12 = 2 ^ p11 * 1000000000000000
			return math.floor(v12)
		end
	},
	["CANDY_PET_ROLL_LUCK"] = {
		["Name"] = "Pet Roll Luck",
		["Icon"] = "rbxassetid://124800928454437",
		["Description"] = "Improves your luck when rolling for pets!",
		["MaxLevel"] = 5,
		["Order"] = 3,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.PetRollLuck,
		["Format"] = function(p13)
			local v14 = p13 * 100
			return ("+%*"):format(math.floor(v14) / 100)
		end,
		["CalculateMultiplier"] = function(_, p15)
			return p15 * 0.15
		end,
		["CalculateCost"] = function(_, p16)
			local v17 = 3.2 ^ p16 * 2000000000000000
			return math.floor(v17)
		end
	},
	["CANDY_RUNE_LUCK_MULT"] = {
		["Name"] = "Rune Luck Multiplier",
		["Icon"] = "rbxassetid://124800928454437",
		["Description"] = "Multiplies your candy rune luck!",
		["MaxLevel"] = 5,
		["Order"] = 4,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.RuneLuckMultiplier,
		["Format"] = function(p18)
			local v19 = p18 * 100
			return ("x%*"):format(math.floor(v19) / 100)
		end,
		["CalculateMultiplier"] = function(_, p20)
			return p20 * 0.01 + 1
		end,
		["CalculateCost"] = function(_, p21)
			local v22 = 2.8 ^ p21 * 1500000000000000
			return math.floor(v22)
		end
	}
}
return v23]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CANDY_WORLD_UPGRADES_5]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3951"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v28 = {
	["CANDY_COINS_MULTIPLIER_5"] = {
		["Name"] = "Candy Coin Multiplier V",
		["Icon"] = "rbxassetid://107119582007802",
		["Description"] = "The ultimate candy coin multiplier!",
		["MaxLevel"] = 5,
		["Order"] = 1,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.CandyCoinsMultiplier,
		["Format"] = function(p4)
			local v5 = p4 * 100
			return ("x%*"):format(math.floor(v5) / 100)
		end,
		["CalculateMultiplier"] = function(_, p6)
			return p6 * 0.2 + 1
		end,
		["CalculateCost"] = function(_, p7)
			local v8 = 3.5 ^ p7 * 5e16
			return math.floor(v8)
		end
	},
	["CANDY_GLOOP_CRAFT_SPEED"] = {
		["Name"] = "Gloop Craft Speed",
		["Icon"] = "rbxassetid://124800928454437",
		["Description"] = "Speeds up your gloop crafting!",
		["MaxLevel"] = 8,
		["Order"] = 2,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.GloopCraftSpeed,
		["Format"] = function(p9)
			local v10 = p9 * 100
			return ("x%*"):format(math.floor(v10) / 100)
		end,
		["CalculateMultiplier"] = function(_, p11)
			return p11 * 0.1 + 1
		end,
		["CalculateCost"] = function(_, p12)
			local v13 = 2 ^ p12 * 2e16
			return math.floor(v13)
		end
	},
	["CANDY_PET_RACE_LUCK"] = {
		["Name"] = "Pet Race Luck",
		["Icon"] = "rbxassetid://124800928454437",
		["Description"] = "Improves your odds of rolling rarer pet races!",
		["MaxLevel"] = 5,
		["Order"] = 3,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.PetRaceLuck,
		["Format"] = function(p14)
			local v15 = p14 * 100
			return ("+%*"):format(math.floor(v15) / 100)
		end,
		["CalculateMultiplier"] = function(_, p16)
			return p16 * 0.1
		end,
		["CalculateCost"] = function(_, p17)
			local v18 = 3.2 ^ p17 * 1e17
			return math.floor(v18)
		end
	},
	["CANDY_PET_COIN_MULT"] = {
		["Name"] = "Pet Coin Bonus",
		["Icon"] = "rbxassetid://106746371164727",
		["Description"] = "Increases coins earned from pet kills!",
		["MaxLevel"] = 8,
		["Order"] = 4,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.PetCoinMultiplier,
		["Format"] = function(p19)
			local v20 = p19 * 100
			return ("x%*"):format(math.floor(v20) / 100)
		end,
		["CalculateMultiplier"] = function(_, p21)
			return p21 * 0.0125 + 1
		end,
		["CalculateCost"] = function(_, p22)
			local v23 = 1.9 ^ p22 * 3e16
			return math.floor(v23)
		end
	},
	["CANDY_RUNE_LUCK_2"] = {
		["Name"] = "Candy Rune Luck II",
		["Icon"] = "rbxassetid://124800928454437",
		["Description"] = "A massive boost to candy rune luck!",
		["MaxLevel"] = 15,
		["Order"] = 5,
		["CurrencyType"] = v2.CandyCoins,
		["MultiplierFunctionality"] = "Default",
		["MultiplierType"] = v3.RuneLuck,
		["Format"] = function(p24)
			return ("+%*"):format(p24)
		end,
		["CalculateMultiplier"] = function(_, p25)
			return p25 * 0.5
		end,
		["CalculateCost"] = function(_, p26)
			local v27 = 1.8 ^ p26 * 1.5e16
			return math.floor(v27)
		end
	}
}
return v28]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CANDY_WORLD_UPGRADES_6]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3952"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
for _, v2 in script:GetDescendants() do
	if v2:IsA("ModuleScript") then
		for v3, v4 in require(v2) do
			v4.RuneOpen = v2.Name
			v1[v3] = v4
		end
	end
end
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RuneData]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3953"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = require(v1.Enums.RuneTypes)
local v4 = {}
local v5 = v3.Mud
local v6 = {
	["Name"] = "Mud",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(120, 85, 71)),
	["Order"] = 1,
	["Chance"] = 1,
	["Buffs"] = {
		{
			["type"] = v2.CoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 1
		}
	}
}
v4[v5] = v6
local v7 = v3.Stone
local v8 = {
	["Name"] = "Stone",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(127, 126, 125)),
	["Order"] = 2,
	["Chance"] = 25,
	["Buffs"] = {
		{
			["type"] = v2.CoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 2
		}
	}
}
v4[v7] = v8
local v9 = v3.Root
local v10 = {
	["Name"] = "Root",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(146, 110, 74)),
	["Order"] = 3,
	["Chance"] = 1000,
	["Buffs"] = {
		{
			["type"] = v2.CoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 3
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 2
		}
	}
}
v4[v9] = v10
local v11 = v3.Moss
local v12 = {
	["Name"] = "Moss",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(99, 155, 98)),
	["Order"] = 4,
	["Chance"] = 50000,
	["Buffs"] = {
		{
			["type"] = v2.CoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 5
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 3
		}
	}
}
v4[v11] = v12
local v13 = v3.Fungal
local v14 = {
	["Name"] = "Fungal",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(116, 255, 137)), ColorSequenceKeypoint.new(0.1, Color3.fromRGB(134, 255, 184)), ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 126, 33)) }),
	["Animated"] = true,
	["Order"] = 5,
	["Chance"] = 300000,
	["Buffs"] = {
		{
			["type"] = v2.CoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 7
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 5
		},
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.00001,
			["max"] = 1
		}
	}
}
v4[v13] = v14
local v15 = v3.Crystalroot
local v16 = {
	["Name"] = "Crystalroot",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 154, 255)), ColorSequenceKeypoint.new(0.1, Color3.fromRGB(255, 234, 138)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
	["Order"] = 6,
	["Animated"] = true,
	["Chance"] = 12500000,
	["Buffs"] = {
		{
			["type"] = v2.CoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 10
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 7
		},
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.00001,
			["max"] = 3
		}
	}
}
v4[v15] = v16
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WORLD_1_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3954"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = require(v1.Enums.RuneTypes)
local v4 = {}
local v5 = v3.Ash
local v6 = {
	["Name"] = "Ash",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(184, 184, 184)),
	["Order"] = 1,
	["Chance"] = 1,
	["Buffs"] = {
		{
			["type"] = v2.FireCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 1
		}
	}
}
v4[v5] = v6
local v7 = v3.Ember
local v8 = {
	["Name"] = "Ember",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(255, 201, 130)),
	["Order"] = 2,
	["Chance"] = 400,
	["Buffs"] = {
		{
			["type"] = v2.FireCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 2
		}
	}
}
v4[v7] = v8
local v9 = v3.Flare
local v10 = {
	["Name"] = "Flare",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(255, 128, 128)),
	["Order"] = 3,
	["Chance"] = 10000,
	["Buffs"] = {
		{
			["type"] = v2.FireCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 3
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 2
		}
	}
}
v4[v9] = v10
local v11 = v3.Pyroclast
local v12 = {
	["Name"] = "Pyroclast",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(167, 167, 167)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 115, 115)) }),
	["Order"] = 4,
	["Chance"] = 500000,
	["Buffs"] = {
		{
			["type"] = v2.FireCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 5
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 3
		}
	}
}
v4[v11] = v12
local v13 = v3.Eruption
local v14 = {
	["Name"] = "Eruption",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 132, 132)), ColorSequenceKeypoint.new(0.1, Color3.fromRGB(255, 206, 99)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 241, 118)) }),
	["Animated"] = true,
	["Order"] = 5,
	["Chance"] = 1300000,
	["Buffs"] = {
		{
			["type"] = v2.FireCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 7
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 5
		},
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.00001,
			["max"] = 1
		}
	}
}
v4[v13] = v14
local v15 = v3.Primordial
local v16 = {
	["Name"] = "Primordial",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 217, 1)), ColorSequenceKeypoint.new(0.1, Color3.fromRGB(255, 45, 45)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }),
	["Order"] = 6,
	["Animated"] = true,
	["Chance"] = 50000000,
	["Buffs"] = {
		{
			["type"] = v2.FireCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 10
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 7
		},
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.00001,
			["max"] = 3
		}
	}
}
v4[v15] = v16
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WORLD_2_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3955"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = require(v1.Enums.RuneTypes)
local v4 = {}
local v5 = v3.Wobble
local v6 = {
	["Name"] = "Wobble",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(255, 246, 113)),
	["Order"] = 1,
	["Chance"] = 85,
	["ShowPercentage"] = true,
	["InShop"] = true,
	["Buffs"] = {
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.0001,
			["max"] = 2
		}
	}
}
v4[v5] = v6
local v7 = v3.Sticky
local v8 = {
	["Name"] = "Sticky",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(137, 255, 121)),
	["Order"] = 2,
	["Chance"] = 10,
	["ShowPercentage"] = true,
	["InShop"] = true,
	["Buffs"] = {
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.0001,
			["max"] = 4
		}
	}
}
v4[v7] = v8
local v9 = v3.Bouncy
local v10 = {
	["Name"] = "Bouncy",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(114, 255, 161)),
	["Order"] = 3,
	["Chance"] = 4,
	["ShowPercentage"] = true,
	["InShop"] = true,
	["Buffs"] = {
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.0001,
			["max"] = 6
		},
		{
			["type"] = v2.ShardMultiplier,
			["value"] = 0.0001,
			["max"] = 2
		}
	}
}
v4[v9] = v10
local v11 = v3.Elastic
local v12 = {
	["Name"] = "Elastic",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 255, 118)), ColorSequenceKeypoint.new(1, Color3.fromRGB(94, 191, 255)) }),
	["Order"] = 4,
	["Chance"] = 0.9,
	["ShowPercentage"] = true,
	["InShop"] = true,
	["Announce"] = true,
	["Buffs"] = {
		{
			["type"] = v2.ShardMultiplier,
			["value"] = 0.0001,
			["max"] = 3
		},
		{
			["type"] = v2.RuneLuck,
			["value"] = 0.01,
			["max"] = 25
		}
	}
}
v4[v11] = v12
local v13 = v3.Prismatic
local v14 = {
	["Name"] = "Prismatic",
	["Gradient"] = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 145, 240)),
		ColorSequenceKeypoint.new(0.25, Color3.fromRGB(148, 141, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(111, 255, 231)),
		ColorSequenceKeypoint.new(0.75, Color3.fromRGB(108, 255, 120)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 252, 101))
	}),
	["Animated"] = true,
	["Order"] = 5,
	["Chance"] = 0.1,
	["ShowPercentage"] = true,
	["GlobalAnnounce"] = true,
	["InShop"] = true,
	["Buffs"] = {
		{
			["type"] = v2.ShardMultiplier,
			["value"] = 0.0001,
			["max"] = 3
		},
		{
			["type"] = v2.RuneLuck,
			["value"] = 0.01,
			["max"] = 50
		},
		{
			["type"] = v2.RuneBulk,
			["value"] = 1,
			["max"] = 250
		}
	}
}
v4[v13] = v14
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[JELLY_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3956"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = require(v1.Enums.RuneTypes)
local v4 = {}
local v5 = v3.Frostmark
local v6 = {
	["Name"] = "Frostmark",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 235, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 200, 230)) }),
	["Order"] = 1,
	["Chance"] = 1,
	["Buffs"] = {
		{
			["type"] = v2.IceCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 1
		}
	}
}
v4[v5] = v6
local v7 = v3.Glacial
local v8 = {
	["Name"] = "Glacial",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 220, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 160, 220)) }),
	["Order"] = 2,
	["Chance"] = 1000,
	["Buffs"] = {
		{
			["type"] = v2.IceCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 2
		}
	}
}
v4[v7] = v8
local v9 = v3.Permafrost
local v10 = {
	["Name"] = "Permafrost",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(210, 225, 230)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 150, 170)) }),
	["Order"] = 3,
	["Chance"] = 50000,
	["Buffs"] = {
		{
			["type"] = v2.IceCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 3
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 2
		}
	}
}
v4[v9] = v10
local v11 = v3.Cryostorm
local v12 = {
	["Name"] = "Cryostorm",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(190, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 200, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 110, 180)) }),
	["Order"] = 4,
	["Chance"] = 10000000,
	["Buffs"] = {
		{
			["type"] = v2.IceCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 5
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 3
		}
	}
}
v4[v11] = v12
local v13 = v3.Stormfrost
local v14 = {
	["Name"] = "Stormfrost",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 220, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 170, 255)) }),
	["Animated"] = true,
	["Order"] = 5,
	["Chance"] = 100000000,
	["Buffs"] = {
		{
			["type"] = v2.IceCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 7
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 5
		},
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.00001,
			["max"] = 1
		}
	}
}
v4[v13] = v14
local v15 = v3.Frostbound
local v16 = {
	["Name"] = "Frostbound",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 250, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 230, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(110, 200, 255)) }),
	["Order"] = 6,
	["Animated"] = true,
	["Chance"] = 1000000000,
	["Buffs"] = {
		{
			["type"] = v2.IceCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 10
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 7
		},
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.00001,
			["max"] = 3
		}
	}
}
v4[v15] = v16
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WORLD_3_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3957"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = require(v1.Enums.RuneTypes)
local v4 = {}
local v5 = v3.Quartz
local v6 = {
	["Name"] = "Quartz",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 186, 186)) }),
	["Order"] = 1,
	["Chance"] = 1,
	["Event"] = true,
	["Buffs"] = {
		{
			["type"] = v2.HeartsMultiplier,
			["value"] = 0.0005,
			["max"] = 10000
		}
	}
}
v4[v5] = v6
local v7 = v3.Ruby
local v8 = {
	["Name"] = "Ruby",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 109, 109)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 60, 60)) }),
	["Order"] = 2,
	["Chance"] = 1000,
	["Event"] = true,
	["Buffs"] = {
		{
			["type"] = v2.HeartsMultiplier,
			["value"] = 0.005,
			["max"] = 10000
		}
	}
}
v4[v7] = v8
local v9 = v3.Rosecore
local v10 = {
	["Name"] = "Rosecore",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 95, 234)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 68, 68)) }),
	["Order"] = 3,
	["Chance"] = 50000,
	["Event"] = true,
	["Buffs"] = {
		{
			["type"] = v2.HeartsMultiplier,
			["value"] = 0.1,
			["max"] = 100000
		},
		{
			["type"] = v2.ValentineDamageMultiplier,
			["value"] = 0.0005,
			["max"] = 50000
		}
	}
}
v4[v9] = v10
local v11 = v3.Heartstone
local v12 = {
	["Name"] = "Heartstone",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 97, 97)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 80, 240)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 146, 188)) }),
	["Order"] = 4,
	["Chance"] = 10000000,
	["Event"] = true,
	["Buffs"] = {
		{
			["type"] = v2.HeartsMultiplier,
			["value"] = 1,
			["max"] = 100000
		},
		{
			["type"] = v2.ValentineDamageMultiplier,
			["value"] = 0.005,
			["max"] = 100000
		}
	}
}
v4[v11] = v12
local v13 = v3.Pinkflux
local v14 = {
	["Name"] = "Pinkflux",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 137, 235)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 94, 142)), ColorSequenceKeypoint.new(1, Color3.fromRGB(137, 86, 255)) }),
	["Animated"] = true,
	["Order"] = 5,
	["Chance"] = 100000000,
	["Event"] = true,
	["Buffs"] = {
		{
			["type"] = v2.HeartsMultiplier,
			["value"] = 3,
			["max"] = 100000
		},
		{
			["type"] = v2.ValentineDamageMultiplier,
			["value"] = 1.5,
			["max"] = 100000
		},
		{
			["type"] = v2.ValentineTraitsLuck,
			["value"] = 0.001,
			["max"] = 5
		},
		{
			["type"] = v2.ValentineRuneLuck,
			["value"] = 0.01,
			["max"] = 50
		}
	}
}
v4[v13] = v14
local v15 = v3.Valentine
local v16 = {
	["Name"] = "Valentine",
	["Gradient"] = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 128)),
		ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 128, 255)),
		ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 255))
	}),
	["Animated"] = true,
	["Order"] = 6,
	["Secret"] = true,
	["Chance"] = 1000000000,
	["Event"] = true,
	["Buffs"] = {
		{
			["type"] = v2.HeartsMultiplier,
			["value"] = 25,
			["max"] = 50000
		},
		{
			["type"] = v2.ValentineDamageMultiplier,
			["value"] = 10,
			["max"] = 50000
		},
		{
			["type"] = v2.ValentineCrystalShardDropChance,
			["value"] = 0.001,
			["max"] = 0.05
		},
		{
			["type"] = v2.ValentineRuneLuck,
			["value"] = 0.1,
			["max"] = 50
		}
	}
}
v4[v15] = v16
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VALENTINE_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3958"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = require(v1.Enums.RuneTypes)
local v4 = {}
local v5 = v3.Kinetic
local v6 = {
	["Name"] = "Kinetic",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(87, 202, 255)),
	["Order"] = 1,
	["Chance"] = 85,
	["ShowPercentage"] = true,
	["InShop"] = true,
	["Buffs"] = {
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.0001,
			["max"] = 2
		}
	}
}
v4[v5] = v6
local v7 = v3.Surge
local v8 = {
	["Name"] = "Surge",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(255, 201, 84)),
	["Order"] = 2,
	["Chance"] = 10,
	["ShowPercentage"] = true,
	["InShop"] = true,
	["Buffs"] = {
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.0001,
			["max"] = 4
		}
	}
}
v4[v7] = v8
local v9 = v3.Overdrive
local v10 = {
	["Name"] = "Overdrive",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(255, 60, 60)),
	["Order"] = 3,
	["Chance"] = 4.45,
	["ShowPercentage"] = true,
	["InShop"] = true,
	["Buffs"] = {
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.0001,
			["max"] = 6
		},
		{
			["type"] = v2.ShardMultiplier,
			["value"] = 0.0001,
			["max"] = 2
		}
	}
}
v4[v9] = v10
local v11 = v3.Catalyst
local v12 = {
	["Name"] = "Catalyst",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(43, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(86, 255, 80)) }),
	["Order"] = 4,
	["Chance"] = 0.5,
	["ShowPercentage"] = true,
	["InShop"] = true,
	["Announce"] = true,
	["Buffs"] = {
		{
			["type"] = v2.ShardMultiplier,
			["value"] = 0.0001,
			["max"] = 3
		},
		{
			["type"] = v2.RuneLuck,
			["value"] = 0.01,
			["max"] = 25
		}
	}
}
v4[v11] = v12
local v13 = v3.Eternal
local v14 = {
	["Name"] = "Eternal",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 229)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 76, 246)) }),
	["Animated"] = true,
	["Order"] = 5,
	["Chance"] = 0.05,
	["ShowPercentage"] = true,
	["GlobalAnnounce"] = true,
	["InShop"] = true,
	["Buffs"] = {
		{
			["type"] = v2.ShardMultiplier,
			["value"] = 0.0001,
			["max"] = 3
		},
		{
			["type"] = v2.RuneLuck,
			["value"] = 0.01,
			["max"] = 50
		},
		{
			["type"] = v2.RuneBulk,
			["value"] = 1,
			["max"] = 250
		}
	}
}
v4[v13] = v14
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GLOOP_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3959"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = require(v1.Enums.RuneTypes)
local v4 = {}
local v5 = v3.Glop
local v6 = {
	["Name"] = "Glop",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 144)), ColorSequenceKeypoint.new(1, Color3.fromRGB(114, 255, 79)) }),
	["Order"] = 1,
	["Chance"] = 1,
	["Buffs"] = {
		{
			["type"] = v2.GlowCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 1
		}
	}
}
v4[v5] = v6
local v7 = v3.Ooze
local v8 = {
	["Name"] = "Ooze",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(131, 255, 228)), ColorSequenceKeypoint.new(1, Color3.fromRGB(77, 243, 118)) }),
	["Order"] = 2,
	["Chance"] = 2500,
	["Buffs"] = {
		{
			["type"] = v2.GlowCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 2
		}
	}
}
v4[v7] = v8
local v9 = v3.Slick
local v10 = {
	["Name"] = "Slick",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 131, 114)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 194, 82)) }),
	["Order"] = 3,
	["Chance"] = 100000,
	["Buffs"] = {
		{
			["type"] = v2.GlowCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 3
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 2
		}
	}
}
v4[v9] = v10
local v11 = v3.Gum
local v12 = {
	["Name"] = "Gum",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(242, 146, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 225, 251)), ColorSequenceKeypoint.new(1, Color3.fromRGB(233, 121, 255)) }),
	["Order"] = 4,
	["Chance"] = 10000000,
	["Buffs"] = {
		{
			["type"] = v2.GlowCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 5
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 3
		}
	}
}
v4[v11] = v12
local v13 = v3.Blob
local v14 = {
	["Name"] = "Blob",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 255, 115)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(107, 255, 168)), ColorSequenceKeypoint.new(1, Color3.fromRGB(91, 255, 58)) }),
	["Animated"] = true,
	["Order"] = 5,
	["Chance"] = 500000000,
	["Buffs"] = {
		{
			["type"] = v2.GlowCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 7
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 5
		},
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.00001,
			["max"] = 1
		}
	}
}
v4[v13] = v14
local v15 = v3.Muck
local v16 = {
	["Name"] = "Muck",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(134, 255, 118)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(133, 91, 67)), ColorSequenceKeypoint.new(1, Color3.fromRGB(204, 255, 121)) }),
	["Order"] = 6,
	["Animated"] = true,
	["Chance"] = 25000000000,
	["Buffs"] = {
		{
			["type"] = v2.GlowCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 10
		},
		{
			["type"] = v2.RebirthMultiplier,
			["value"] = 0.00001,
			["max"] = 7
		},
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.00001,
			["max"] = 3
		}
	}
}
v4[v15] = v16
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WORLD_4_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3960"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = require(v1.Enums.RuneTypes)
local v4 = {}
local v5 = v3.Streamer
local v6 = {
	["Name"] = "Streamer",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 230, 150)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 200, 100)) }),
	["Order"] = 1,
	["Chance"] = 1,
	["Event"] = true,
	["Buffs"] = {
		{
			["type"] = v2.ConfettiMultiplier,
			["value"] = 0.0003,
			["max"] = 10000
		}
	}
}
v4[v5] = v6
local v7 = v3.Sparkler
local v8 = {
	["Name"] = "Sparkler",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 80)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 50)) }),
	["Order"] = 2,
	["Chance"] = 1000,
	["Event"] = true,
	["Buffs"] = {
		{
			["type"] = v2.ConfettiMultiplier,
			["value"] = 0.003,
			["max"] = 10000
		}
	}
}
v4[v7] = v8
local v9 = v3.Firecracker
local v10 = {
	["Name"] = "Firecracker",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 80, 30)) }),
	["Order"] = 3,
	["Chance"] = 50000,
	["Event"] = true,
	["Buffs"] = {
		{
			["type"] = v2.ConfettiMultiplier,
			["value"] = 0.06,
			["max"] = 100000
		},
		{
			["type"] = v2.Event1MBalloonsMultiplier,
			["value"] = 0.0003,
			["max"] = 50000
		}
	}
}
v4[v9] = v10
local v11 = v3.Starburst
local v12 = {
	["Name"] = "Starburst",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 180, 50)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 200)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 220, 100)) }),
	["Order"] = 4,
	["Chance"] = 10000000,
	["Event"] = true,
	["Buffs"] = {
		{
			["type"] = v2.ConfettiMultiplier,
			["value"] = 0.6,
			["max"] = 100000
		},
		{
			["type"] = v2.Event1MBalloonsMultiplier,
			["value"] = 0.003,
			["max"] = 100000
		}
	}
}
v4[v11] = v12
local v13 = v3.Prismfetti
local v14 = {
	["Name"] = "Prismfetti",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 150)), ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 200, 255)) }),
	["Animated"] = true,
	["Order"] = 5,
	["Chance"] = 100000000,
	["Event"] = true,
	["Buffs"] = {
		{
			["type"] = v2.ConfettiMultiplier,
			["value"] = 1.8,
			["max"] = 100000
		},
		{
			["type"] = v2.Event1MDamageMultiplier,
			["value"] = 0.9,
			["max"] = 100000
		},
		{
			["type"] = v2.Event1MRuneLuck,
			["value"] = 0.006,
			["max"] = 50
		}
	}
}
v4[v13] = v14
local v15 = v3.Celebration
local v16 = {
	["Name"] = "Celebration",
	["Gradient"] = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)),
		ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 150, 50)),
		ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 100))
	}),
	["Animated"] = true,
	["Order"] = 6,
	["Secret"] = true,
	["Chance"] = 1000000000,
	["Event"] = true,
	["Buffs"] = {
		{
			["type"] = v2.ConfettiMultiplier,
			["value"] = 15,
			["max"] = 50000
		},
		{
			["type"] = v2.Event1MDamageMultiplier,
			["value"] = 6,
			["max"] = 50000
		},
		{
			["type"] = v2.Event1MBalloonsMultiplier,
			["value"] = 3,
			["max"] = 50000
		},
		{
			["type"] = v2.Event1MRuneLuck,
			["value"] = 0.06,
			["max"] = 50
		}
	}
}
v4[v15] = v16
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[EVENT_1M_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3961"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = require(v1.Enums.RuneTypes)
local v4 = {}
local v5 = v3.Taffy
local v6 = {
	["Name"] = "Taffy",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 182, 225)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 200)) }),
	["Order"] = 1,
	["Chance"] = 15,
	["Buffs"] = {
		{
			["type"] = v2.CandyCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 1
		}
	}
}
v4[v5] = v6
local v7 = v3.Caramel
local v8 = {
	["Name"] = "Caramel",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(210, 150, 75)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 190, 100)) }),
	["Order"] = 2,
	["Chance"] = 100000,
	["Buffs"] = {
		{
			["type"] = v2.CandyCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 2
		}
	}
}
v4[v7] = v8
local v9 = v3.Gumdrop
local v10 = {
	["Name"] = "Gumdrop",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 150)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 80, 255)) }),
	["Order"] = 3,
	["Chance"] = 100000000,
	["Buffs"] = {
		{
			["type"] = v2.CandyCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 3
		}
	}
}
v4[v9] = v10
local v11 = v3.Lollipop
local v12 = {
	["Name"] = "Lollipop",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 180)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 200, 230)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 200)) }),
	["Order"] = 4,
	["Chance"] = 25000000000,
	["Buffs"] = {
		{
			["type"] = v2.CandyCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 5
		}
	}
}
v4[v11] = v12
local v13 = v3.Jawbreaker
local v14 = {
	["Name"] = "Jawbreaker",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 120)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 50, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 80, 150)) }),
	["Animated"] = true,
	["Order"] = 5,
	["Chance"] = 1000000000000,
	["Buffs"] = {
		{
			["type"] = v2.CandyCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 7
		},
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.00001,
			["max"] = 1
		}
	}
}
v4[v13] = v14
local v15 = v3.Sugarplum
local v16 = {
	["Name"] = "Sugarplum",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 100, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 150, 220)), ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 80, 255)) }),
	["Order"] = 6,
	["Animated"] = true,
	["Chance"] = 50000000000000,
	["Buffs"] = {
		{
			["type"] = v2.CandyCoinsMultiplier,
			["value"] = 0.00001,
			["max"] = 10
		},
		{
			["type"] = v2.DamageMultiplier,
			["value"] = 0.00001,
			["max"] = 3
		}
	}
}
v4[v15] = v16
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CANDY_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3962"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
for _, v2 in script:GetDescendants() do
	if v2:IsA("ModuleScript") then
		v1[v2.Name] = require(v2)
	end
end
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RuneOpenData]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3963"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.RuneTypes)
return {
	["Name"] = "Earth Runes",
	["Category"] = "Main",
	["Order"] = 1,
	["Color"] = Color3.new(1, 1, 1),
	["Gradient"] = ColorSequence.new(Color3.new(1, 0.760784, 0.427451), Color3.new(0.533333, 1, 0.478431)),
	["Animated"] = true,
	["CurrencyType"] = v2.Coins,
	["CurrencyCost"] = 100,
	["Runes"] = {
		v3.Mud,
		v3.Stone,
		v3.Root,
		v3.Moss,
		v3.Fungal,
		v3.Crystalroot
	}
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WORLD_1_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3964"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.RuneTypes)
return {
	["Name"] = "Lava Runes",
	["Category"] = "Main",
	["Order"] = 2,
	["Color"] = Color3.new(1, 1, 1),
	["Gradient"] = ColorSequence.new(Color3.new(1, 0.243137, 0.243137), Color3.new(1, 0.654902, 0.258824)),
	["Animated"] = true,
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 1000,
	["Runes"] = {
		v3.Ash,
		v3.Ember,
		v3.Flare,
		v3.Pyroclast,
		v3.Eruption,
		v3.Primordial
	}
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WORLD_2_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3965"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.RuneTypes)
return {
	["Name"] = "Global Rune 1",
	["Icon"] = "rbxassetid://116910892493409",
	["Category"] = "Shop",
	["Order"] = 1,
	["Color"] = Color3.new(0.466667, 1, 0.360784),
	["Gradient"] = ColorSequence.new(Color3.new(0.333333, 1, 0.478431), Color3.new(0.243137, 1, 0.686275)),
	["Animated"] = true,
	["Runes"] = {
		v2.Wobble,
		v2.Sticky,
		v2.Bouncy,
		v2.Elastic,
		v2.Prismatic
	}
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[JELLY_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3966"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.RuneTypes)
return {
	["Name"] = "Ice Runes",
	["Category"] = "Main",
	["Order"] = 3,
	["Color"] = Color3.new(1, 1, 1),
	["Gradient"] = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.486275, 0.921569, 1)),
	["Animated"] = true,
	["CurrencyType"] = v2.IceCoins,
	["CurrencyCost"] = 10000,
	["Runes"] = {
		v3.Frostmark,
		v3.Glacial,
		v3.Permafrost,
		v3.Cryostorm,
		v3.Stormfrost,
		v3.Frostbound
	}
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WORLD_3_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3967"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = require(v1.Enums.RuneTypes)
return {
	["Name"] = "Valentine Runes",
	["Category"] = "Event",
	["Order"] = 1,
	["Color"] = Color3.new(1, 0.458824, 0.972549),
	["Gradient"] = ColorSequence.new(Color3.new(1, 0.470588, 0.470588), Color3.new(1, 0.478431, 0.929412)),
	["Animated"] = true,
	["RuneBulk"] = v3.ValentineRuneBulk,
	["RuneBulkMultiplier"] = v3.ValentineRuneBulkMultiplier,
	["RuneLuck"] = v3.ValentineRuneLuck,
	["RuneLuckMultiplier"] = v3.ValentineRuneLuckMultiplier,
	["RuneOpenTime"] = v3.ValentineRuneOpenTime,
	["RuneOpenTimeMultiplier"] = v3.ValentineRuneOpenTimeMultiplier,
	["CurrencyType"] = v2.Hearts,
	["CurrencyCost"] = 1000,
	["Runes"] = {
		v4.Quartz,
		v4.Ruby,
		v4.Rosecore,
		v4.Heartstone,
		v4.Pinkflux,
		v4.Valentine
	}
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VALENTINE_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3968"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.RuneTypes)
return {
	["Name"] = "Global Rune 2",
	["Icon"] = "rbxassetid://129398774383539",
	["Category"] = "Shop",
	["Order"] = 2,
	["Color"] = Color3.new(0.745098, 0.360784, 1),
	["Gradient"] = ColorSequence.new(Color3.new(0.756863, 0.333333, 1), Color3.new(0.745098, 0.188235, 1)),
	["Animated"] = true,
	["Runes"] = {
		v2.Kinetic,
		v2.Surge,
		v2.Overdrive,
		v2.Catalyst,
		v2.Eternal
	}
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GLOOP_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3969"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.RuneTypes)
return {
	["Name"] = "Glow Runes",
	["Category"] = "Main",
	["Order"] = 4,
	["Color"] = Color3.new(1, 1, 1),
	["Gradient"] = ColorSequence.new(Color3.new(0.341176, 1, 0.541176), Color3.new(0.666667, 1, 0.737255)),
	["Animated"] = true,
	["CurrencyType"] = v2.GlowCoins,
	["CurrencyCost"] = 5000000,
	["Runes"] = {
		v3.Glop,
		v3.Ooze,
		v3.Slick,
		v3.Gum,
		v3.Blob,
		v3.Muck
	}
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WORLD_4_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3970"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = require(v1.Enums.RuneTypes)
return {
	["Name"] = "1M Event Runes",
	["Category"] = "Event",
	["Order"] = 2,
	["Color"] = Color3.new(1, 0.843137, 0),
	["Gradient"] = ColorSequence.new(Color3.fromRGB(255, 215, 0), Color3.fromRGB(255, 165, 0)),
	["Animated"] = true,
	["RuneBulk"] = v3.Event1MRuneBulk,
	["RuneBulkMultiplier"] = v3.Event1MRuneBulkMultiplier,
	["RuneLuck"] = v3.Event1MRuneLuck,
	["RuneLuckMultiplier"] = v3.Event1MRuneLuckMultiplier,
	["RuneOpenTime"] = v3.Event1MRuneOpenTime,
	["RuneOpenTimeMultiplier"] = v3.Event1MRuneOpenTimeMultiplier,
	["CurrencyType"] = v2.Event1MBalloon,
	["CurrencyCost"] = 2000,
	["Runes"] = {
		v4.Streamer,
		v4.Sparkler,
		v4.Firecracker,
		v4.Starburst,
		v4.Prismfetti,
		v4.Celebration
	}
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[EVENT_1M_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3971"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.RuneTypes)
return {
	["Name"] = "Candy Runes",
	["Category"] = "Main",
	["Order"] = 5,
	["Color"] = Color3.new(1, 1, 1),
	["Gradient"] = ColorSequence.new(Color3.fromRGB(255, 150, 200), Color3.fromRGB(255, 100, 180)),
	["Animated"] = true,
	["CurrencyType"] = v2.CandyCoins,
	["CurrencyCost"] = 5000000,
	["Runes"] = {
		v3.Taffy,
		v3.Caramel,
		v3.Gumdrop,
		v3.Lollipop,
		v3.Jawbreaker,
		v3.Sugarplum
	}
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CANDY_RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3972"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
for _, v2 in script:GetDescendants() do
	if v2:IsA("ModuleScript") then
		v1[v2.Name] = require(v2)
	end
end
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MasteryData]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3973"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.EventType)
local v3 = require(v1.Enums.MultiplierTypes)
local v_u_4 = require(v1.Utility.Time)
local v7 = {
	["Name"] = "Playtime",
	["Order"] = 1,
	["EventType"] = v2.Playtime,
	["Format"] = function(_, p5)
		-- upvalues: (copy) v_u_4
		return v_u_4.format(p5)
	end,
	["FormatDescription"] = function(_, p6)
		-- upvalues: (copy) v_u_4
		return ("Play for %*"):format((v_u_4.formatToString(p6, {
			["Hours"] = true,
			["Minutes"] = true,
			["Seconds"] = true
		})))
	end
}
local v8 = {}
local v9 = {
	["Amount"] = 600,
	["Buffs"] = {
		{
			["multiplier"] = v3.StatsMultiplier,
			["value"] = 1.1
		}
	}
}
v8[1] = v9
local v10 = {
	["Amount"] = 1800,
	["Buffs"] = {
		{
			["multiplier"] = v3.StatsMultiplier,
			["value"] = 1.25
		}
	}
}
v8[2] = v10
local v11 = {
	["Amount"] = 3600,
	["Buffs"] = {
		{
			["multiplier"] = v3.StatsMultiplier,
			["value"] = 1.5
		}
	}
}
v8[3] = v11
local v12 = {
	["Amount"] = 10800,
	["Buffs"] = {
		{
			["multiplier"] = v3.StatsMultiplier,
			["value"] = 2
		}
	}
}
v8[4] = v12
local v13 = {
	["Amount"] = 21600,
	["Buffs"] = {
		{
			["multiplier"] = v3.StatsMultiplier,
			["value"] = 2.5
		}
	}
}
v8[5] = v13
local v14 = {
	["Amount"] = 43200,
	["Buffs"] = {
		{
			["multiplier"] = v3.StatsMultiplier,
			["value"] = 3
		}
	}
}
v8[6] = v14
local v15 = {
	["Amount"] = 86400,
	["Buffs"] = {
		{
			["multiplier"] = v3.StatsMultiplier,
			["value"] = 3.5
		}
	}
}
v8[7] = v15
local v16 = {
	["Amount"] = 172800,
	["Buffs"] = {
		{
			["multiplier"] = v3.StatsMultiplier,
			["value"] = 4
		}
	}
}
v8[8] = v16
local v17 = {
	["Amount"] = 259200,
	["Buffs"] = {
		{
			["multiplier"] = v3.StatsMultiplier,
			["value"] = 4.5
		}
	}
}
v8[9] = v17
local v18 = {
	["Amount"] = 604800,
	["Buffs"] = {
		{
			["multiplier"] = v3.StatsMultiplier,
			["value"] = 5
		}
	}
}
v8[10] = v18
v7.Tiers = v8
return v7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PLAYTIME]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3974"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.EventType)
local v3 = require(v1.Enums.MultiplierTypes)
local v_u_4 = require(v1.Utility.Format)
local v8 = {
	["Name"] = "Slimes Slayer",
	["Order"] = 3,
	["EventType"] = v2.SlimeKilled,
	["Format"] = function(_, p5)
		-- upvalues: (copy) v_u_4
		return v_u_4.abbreviateComma(p5)
	end,
	["FormatDescription"] = function(p6, p7)
		return ("Defeat %*"):format((p6:Format(p7)))
	end
}
local v9 = {}
local v10 = {
	["Amount"] = 10,
	["Buffs"] = {
		{
			["multiplier"] = v3.DamageMultiplier,
			["value"] = 1.01
		}
	}
}
v9[1] = v10
local v11 = {
	["Amount"] = 1000,
	["Buffs"] = {
		{
			["multiplier"] = v3.DamageMultiplier,
			["value"] = 1.05
		}
	}
}
v9[2] = v11
local v12 = {
	["Amount"] = 50000,
	["Buffs"] = {
		{
			["multiplier"] = v3.DamageMultiplier,
			["value"] = 1.1
		}
	}
}
v9[3] = v12
local v13 = {
	["Amount"] = 1000000,
	["Buffs"] = {
		{
			["multiplier"] = v3.DamageMultiplier,
			["value"] = 1.15
		}
	}
}
v9[4] = v13
local v14 = {
	["Amount"] = 500000000,
	["Buffs"] = {
		{
			["multiplier"] = v3.DamageMultiplier,
			["value"] = 1.2
		}
	}
}
v9[5] = v14
local v15 = {
	["Amount"] = 50000000000,
	["Buffs"] = {
		{
			["multiplier"] = v3.DamageMultiplier,
			["value"] = 1.25
		}
	}
}
v9[6] = v15
local v16 = {
	["Amount"] = 1000000000000,
	["Buffs"] = {
		{
			["multiplier"] = v3.DamageMultiplier,
			["value"] = 1.5
		}
	}
}
v9[7] = v16
local v17 = {
	["Amount"] = 100000000000000,
	["Buffs"] = {
		{
			["multiplier"] = v3.DamageMultiplier,
			["value"] = 2
		}
	}
}
v9[8] = v17
v8.Tiers = v9
return v8]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SLIMES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3975"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.EventType)
local v4 = require(v1.Enums.MultiplierTypes)
local v_u_5 = require(v1.Utility.Format)
local v10 = {
	["Name"] = "Coin Collector",
	["Order"] = 4,
	["EventType"] = v3.CurrencyAdded,
	["GetValue"] = function(_, p6)
		-- upvalues: (copy) v_u_2
		if p6.currency_type == v_u_2.Coins then
			return p6.amount
		end
	end,
	["Format"] = function(_, p7)
		-- upvalues: (copy) v_u_5
		return v_u_5.abbreviateComma(p7)
	end,
	["FormatDescription"] = function(p8, p9)
		return ("Collect %* Coins"):format((p8:Format(p9)))
	end
}
local v11 = {}
local v12 = {
	["Amount"] = 100,
	["Buffs"] = {
		{
			["multiplier"] = v4.CoinsMultiplier,
			["value"] = 1.1
		}
	}
}
v11[1] = v12
local v13 = {
	["Amount"] = 100000,
	["Buffs"] = {
		{
			["multiplier"] = v4.CoinsMultiplier,
			["value"] = 1.25
		}
	}
}
v11[2] = v13
local v14 = {
	["Amount"] = 100000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.CoinsMultiplier,
			["value"] = 1.5
		}
	}
}
v11[3] = v14
local v15 = {
	["Amount"] = 100000000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.CoinsMultiplier,
			["value"] = 2
		}
	}
}
v11[4] = v15
local v16 = {
	["Amount"] = 100000000000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.CoinsMultiplier,
			["value"] = 2.5
		}
	}
}
v11[5] = v16
v10.Tiers = v11
return v10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[COIN_COLLECTOR]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3976"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.EventType)
local v3 = require(v1.Enums.MultiplierTypes)
local v_u_4 = require(v1.Utility.Format)
local v7 = {
	["Name"] = "Runes Opened",
	["Order"] = 2,
	["EventType"] = v2.RuneOpen,
	["Format"] = function(_, p5)
		-- upvalues: (copy) v_u_4
		return v_u_4.abbreviateComma(p5)
	end,
	["FormatDescription"] = function(_, p6)
		-- upvalues: (copy) v_u_4
		return ("Open %* Runes"):format((v_u_4.abbreviateComma(p6)))
	end
}
local v8 = {}
local v9 = {
	["Amount"] = 100,
	["Buffs"] = {
		{
			["multiplier"] = v3.RuneBulkMultiplier,
			["value"] = 1.1
		}
	}
}
v8[1] = v9
local v10 = {
	["Amount"] = 5000,
	["Buffs"] = {
		{
			["multiplier"] = v3.RuneBulkMultiplier,
			["value"] = 1.2
		}
	}
}
v8[2] = v10
local v11 = {
	["Amount"] = 35000,
	["Buffs"] = {
		{
			["multiplier"] = v3.RuneBulkMultiplier,
			["value"] = 1.3
		}
	}
}
v8[3] = v11
local v12 = {
	["Amount"] = 100000,
	["Buffs"] = {
		{
			["multiplier"] = v3.RuneBulkMultiplier,
			["value"] = 1.4
		}
	}
}
v8[4] = v12
local v13 = {
	["Amount"] = 1000000,
	["Buffs"] = {
		{
			["multiplier"] = v3.RuneBulkMultiplier,
			["value"] = 1.5
		}
	}
}
v8[5] = v13
local v14 = {
	["Amount"] = 25000000,
	["Buffs"] = {
		{
			["multiplier"] = v3.RuneBulkMultiplier,
			["value"] = 1.6
		}
	}
}
v8[6] = v14
local v15 = {
	["Amount"] = 100000000,
	["Buffs"] = {
		{
			["multiplier"] = v3.RuneBulkMultiplier,
			["value"] = 1.7
		}
	}
}
v8[7] = v15
local v16 = {
	["Amount"] = 750000000,
	["Buffs"] = {
		{
			["multiplier"] = v3.RuneBulkMultiplier,
			["value"] = 1.8
		}
	}
}
v8[8] = v16
local v17 = {
	["Amount"] = 2500000000,
	["Buffs"] = {
		{
			["multiplier"] = v3.RuneBulkMultiplier,
			["value"] = 1.9
		}
	}
}
v8[9] = v17
local v18 = {
	["Amount"] = 50000000000,
	["Buffs"] = {
		{
			["multiplier"] = v3.RuneBulkMultiplier,
			["value"] = 2
		}
	}
}
v8[10] = v18
v7.Tiers = v8
return v7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RUNES]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3977"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.EventType)
local v4 = require(v1.Enums.MultiplierTypes)
local v_u_5 = require(v1.Utility.Format)
local v10 = {
	["Name"] = "Fire Coin Collector",
	["Order"] = 5,
	["EventType"] = v3.CurrencyAdded,
	["GetValue"] = function(_, p6)
		-- upvalues: (copy) v_u_2
		if p6.currency_type == v_u_2.FireCoins then
			return p6.amount
		end
	end,
	["Format"] = function(_, p7)
		-- upvalues: (copy) v_u_5
		return v_u_5.abbreviateComma(p7)
	end,
	["FormatDescription"] = function(p8, p9)
		return ("Collect %* Fire Coins"):format((p8:Format(p9)))
	end
}
local v11 = {}
local v12 = {
	["Amount"] = 100,
	["Buffs"] = {
		{
			["multiplier"] = v4.FireCoinsMultiplier,
			["value"] = 1.1
		}
	}
}
v11[1] = v12
local v13 = {
	["Amount"] = 100000,
	["Buffs"] = {
		{
			["multiplier"] = v4.FireCoinsMultiplier,
			["value"] = 1.25
		}
	}
}
v11[2] = v13
local v14 = {
	["Amount"] = 100000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.FireCoinsMultiplier,
			["value"] = 1.5
		}
	}
}
v11[3] = v14
local v15 = {
	["Amount"] = 100000000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.FireCoinsMultiplier,
			["value"] = 2
		}
	}
}
v11[4] = v15
local v16 = {
	["Amount"] = 100000000000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.FireCoinsMultiplier,
			["value"] = 2.5
		}
	}
}
v11[5] = v16
v10.Tiers = v11
return v10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[FIRE_COIN_COLLECTOR]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3978"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.EventType)
local v4 = require(v1.Enums.MultiplierTypes)
local v_u_5 = require(v1.Utility.Format)
local v10 = {
	["Name"] = "Ice Coin Collector",
	["Order"] = 6,
	["EventType"] = v3.CurrencyAdded,
	["GetValue"] = function(_, p6)
		-- upvalues: (copy) v_u_2
		if p6.currency_type == v_u_2.IceCoins then
			return p6.amount
		end
	end,
	["Format"] = function(_, p7)
		-- upvalues: (copy) v_u_5
		return v_u_5.abbreviateComma(p7)
	end,
	["FormatDescription"] = function(p8, p9)
		return ("Collect %* Ice Coins"):format((p8:Format(p9)))
	end
}
local v11 = {}
local v12 = {
	["Amount"] = 100,
	["Buffs"] = {
		{
			["multiplier"] = v4.IceCoinsMultiplier,
			["value"] = 1.1
		}
	}
}
v11[1] = v12
local v13 = {
	["Amount"] = 100000,
	["Buffs"] = {
		{
			["multiplier"] = v4.IceCoinsMultiplier,
			["value"] = 1.25
		}
	}
}
v11[2] = v13
local v14 = {
	["Amount"] = 100000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.IceCoinsMultiplier,
			["value"] = 1.5
		}
	}
}
v11[3] = v14
local v15 = {
	["Amount"] = 100000000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.IceCoinsMultiplier,
			["value"] = 2
		}
	}
}
v11[4] = v15
local v16 = {
	["Amount"] = 100000000000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.IceCoinsMultiplier,
			["value"] = 2.5
		}
	}
}
v11[5] = v16
v10.Tiers = v11
return v10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ICE_COIN_COLLECTOR]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3979"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.EventType)
local v3 = require(v1.Enums.MultiplierTypes)
local v_u_4 = require(v1.Utility.Format)
local v9 = {
	["Name"] = "Icy Boss",
	["Order"] = 7,
	["EventType"] = v2.IceBossDefeated,
	["GetValue"] = function(_, p5)
		return p5.amount
	end,
	["Format"] = function(_, p6)
		-- upvalues: (copy) v_u_4
		return v_u_4.abbreviateComma(p6)
	end,
	["FormatDescription"] = function(p7, p8)
		return ("Defeat Ice Boss %* Times"):format((p7:Format(p8)))
	end
}
local v10 = {}
local v11 = {
	["Amount"] = 1,
	["Buffs"] = {
		{
			["multiplier"] = v3.IceBossAttackSpeedMultiplier,
			["value"] = 1.1
		}
	}
}
v10[1] = v11
local v12 = {
	["Amount"] = 5,
	["Buffs"] = {
		{
			["multiplier"] = v3.IceBossAttackSpeedMultiplier,
			["value"] = 1.25
		}
	}
}
v10[2] = v12
local v13 = {
	["Amount"] = 15,
	["Buffs"] = {
		{
			["multiplier"] = v3.IceBossAttackSpeedMultiplier,
			["value"] = 1.5
		}
	}
}
v10[3] = v13
local v14 = {
	["Amount"] = 35,
	["Buffs"] = {
		{
			["multiplier"] = v3.IceBossAttackSpeedMultiplier,
			["value"] = 2
		}
	}
}
v10[4] = v14
local v15 = {
	["Amount"] = 50,
	["Buffs"] = {
		{
			["multiplier"] = v3.IceBossAttackSpeedMultiplier,
			["value"] = 2.5
		}
	}
}
v10[5] = v15
v9.Tiers = v10
return v9]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BOSS_DEFEATED]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3980"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.EventType)
local v4 = require(v1.Enums.MultiplierTypes)
local v_u_5 = require(v1.Utility.Format)
local v10 = {
	["Name"] = "Glow Coin Collector",
	["Order"] = 6,
	["EventType"] = v3.CurrencyAdded,
	["GetValue"] = function(_, p6)
		-- upvalues: (copy) v_u_2
		if p6.currency_type == v_u_2.GlowCoins then
			return p6.amount
		end
	end,
	["Format"] = function(_, p7)
		-- upvalues: (copy) v_u_5
		return v_u_5.abbreviateComma(p7)
	end,
	["FormatDescription"] = function(p8, p9)
		return ("Collect %* Glow Coins"):format((p8:Format(p9)))
	end
}
local v11 = {}
local v12 = {
	["Amount"] = 100000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.GlowCoinsMultiplier,
			["value"] = 1.1
		}
	}
}
v11[1] = v12
local v13 = {
	["Amount"] = 1000000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.GlowCoinsMultiplier,
			["value"] = 1.25
		}
	}
}
v11[2] = v13
local v14 = {
	["Amount"] = 100000000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.GlowCoinsMultiplier,
			["value"] = 1.5
		}
	}
}
v11[3] = v14
local v15 = {
	["Amount"] = 1000000000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.GlowCoinsMultiplier,
			["value"] = 2
		}
	}
}
v11[4] = v15
local v16 = {
	["Amount"] = 1000000000000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.GlowCoinsMultiplier,
			["value"] = 2.5
		}
	}
}
v11[5] = v16
v10.Tiers = v11
return v10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GLOW_COINS_COLLECTOR]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3981"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.EventType)
local v3 = require(v1.Enums.MultiplierTypes)
local v_u_4 = require(v1.Utility.Format)
local v9 = {
	["Name"] = "Gloop Collector",
	["Order"] = 6,
	["EventType"] = v2.GloopObtained,
	["GetValue"] = function(_, p5)
		return p5.amount
	end,
	["Format"] = function(_, p6)
		-- upvalues: (copy) v_u_4
		return v_u_4.abbreviateComma(p6)
	end,
	["FormatDescription"] = function(p7, p8)
		return ("Collect %* Gloop"):format((p7:Format(p8)))
	end
}
local v10 = {}
local v11 = {
	["Amount"] = 100,
	["Buffs"] = {
		{
			["multiplier"] = v3.GloopCollectLuck,
			["value"] = 0.1
		}
	}
}
v10[1] = v11
local v12 = {
	["Amount"] = 100000,
	["Buffs"] = {
		{
			["multiplier"] = v3.GloopCollectLuck,
			["value"] = 0.25
		}
	}
}
v10[2] = v12
local v13 = {
	["Amount"] = 100000000,
	["Buffs"] = {
		{
			["multiplier"] = v3.GloopCollectLuck,
			["value"] = 0.5
		}
	}
}
v10[3] = v13
local v14 = {
	["Amount"] = 100000000000,
	["Buffs"] = {
		{
			["multiplier"] = v3.GloopCollectLuck,
			["value"] = 1
		}
	}
}
v10[4] = v14
local v15 = {
	["Amount"] = 100000000000000,
	["Buffs"] = {
		{
			["multiplier"] = v3.GloopCollectLuck,
			["value"] = 2.5
		}
	}
}
v10[5] = v15
v9.Tiers = v10
return v9]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GLOOP_COLLECTOR]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3982"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.EventType)
local v4 = require(v1.Enums.MultiplierTypes)
local v_u_5 = require(v1.Utility.Format)
local v10 = {
	["Name"] = "Candy Coin Collector",
	["Order"] = 8,
	["EventType"] = v3.CurrencyAdded,
	["GetValue"] = function(_, p6)
		-- upvalues: (copy) v_u_2
		if p6.currency_type == v_u_2.CandyCoins then
			return p6.amount
		end
	end,
	["Format"] = function(_, p7)
		-- upvalues: (copy) v_u_5
		return v_u_5.abbreviateComma(p7)
	end,
	["FormatDescription"] = function(p8, p9)
		return ("Collect %* Candy Coins"):format((p8:Format(p9)))
	end
}
local v11 = {}
local v12 = {
	["Amount"] = 1000000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.CandyCoinsMultiplier,
			["value"] = 1.1
		}
	}
}
v11[1] = v12
local v13 = {
	["Amount"] = 1000000000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.CandyCoinsMultiplier,
			["value"] = 1.25
		}
	}
}
v11[2] = v13
local v14 = {
	["Amount"] = 1000000000000000,
	["Buffs"] = {
		{
			["multiplier"] = v4.CandyCoinsMultiplier,
			["value"] = 1.5
		}
	}
}
v11[3] = v14
local v15 = {
	["Amount"] = 1e18,
	["Buffs"] = {
		{
			["multiplier"] = v4.CandyCoinsMultiplier,
			["value"] = 2
		}
	}
}
v11[4] = v15
local v16 = {
	["Amount"] = 1e21,
	["Buffs"] = {
		{
			["multiplier"] = v4.CandyCoinsMultiplier,
			["value"] = 2.5
		}
	}
}
v11[5] = v16
v10.Tiers = v11
return v10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CANDY_COINS_COLLECTOR]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3983"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
for _, v2 in script:GetChildren() do
	if v2:IsA("ModuleScript") then
		v1[v2.Name] = require(v2)
	end
end
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SkillData]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3984"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = {
	["Name"] = "Lightning Chain",
	["Icon"] = "rbxassetid://88758720213900",
	["Order"] = 1,
	["World"] = 1,
	["Cost"] = 1
}
local v4 = {}
local v5 = {
	["Order"] = 1
}
local v6 = {}
local v7 = {
	["Cost"] = 1,
	["Description"] = "Chain to 1 additional slime",
	["Multipliers"] = {
		{
			["multiplier"] = v2.LightingStrikes,
			["amount"] = 1
		}
	}
}
v6[1] = v7
local v8 = {
	["Cost"] = 3,
	["Description"] = "Chain to 2 additional slime",
	["Multipliers"] = {
		{
			["multiplier"] = v2.LightingStrikes,
			["amount"] = 2
		}
	}
}
v6[2] = v8
local v9 = {
	["Cost"] = 5,
	["Description"] = "Chain to 3 additional slime",
	["Multipliers"] = {
		{
			["multiplier"] = v2.LightingStrikes,
			["amount"] = 3
		}
	}
}
v6[3] = v9
v5.Levels = v6
v4.Chain = v5
local v10 = {
	["Order"] = 2
}
local v11 = {}
local v12 = {
	["Cost"] = 1,
	["Description"] = "Lightning Damage is increased to 20% of your total Damage",
	["Multipliers"] = {
		{
			["multiplier"] = v2.LightingStrikeDamage,
			["amount"] = 0.2
		}
	}
}
v11[1] = v12
local v13 = {
	["Cost"] = 3,
	["Description"] = "Lightning Damage is increased to 30% of your total Damage",
	["Multipliers"] = {
		{
			["multiplier"] = v2.LightingStrikeDamage,
			["amount"] = 0.3
		}
	}
}
v11[2] = v13
local v14 = {
	["Cost"] = 5,
	["Description"] = "Lightning Damage is increased to 40% of your total Damage",
	["Multipliers"] = {
		{
			["multiplier"] = v2.LightingStrikeDamage,
			["amount"] = 0.4
		}
	}
}
v11[3] = v14
v10.Levels = v11
v4.Damage = v10
local v15 = {
	["Order"] = 3
}
local v16 = {}
local v17 = {
	["Cost"] = 1,
	["Description"] = "5% Chance to strike slime twice",
	["Multipliers"] = {
		{
			["multiplier"] = v2.LightingDoubleStrikeChance,
			["amount"] = 0.05
		}
	}
}
v16[1] = v17
local v18 = {
	["Cost"] = 3,
	["Description"] = "15% Chance to strike slime twice",
	["Multipliers"] = {
		{
			["multiplier"] = v2.LightingDoubleStrikeChance,
			["amount"] = 0.15
		}
	}
}
v16[2] = v18
local v19 = {
	["Cost"] = 5,
	["Description"] = "30% Chance to strike slime twice",
	["Multipliers"] = {
		{
			["multiplier"] = v2.LightingDoubleStrikeChance,
			["amount"] = 0.3
		}
	}
}
v16[3] = v19
v15.Levels = v16
v4.DoubleStrike = v15
local v20 = {
	["Order"] = 4
}
local v21 = {}
local v22 = {
	["Cost"] = 1,
	["Description"] = "-0.5s Lightning Cooldown",
	["Multipliers"] = {
		{
			["multiplier"] = v2.LightingStrikeCooldown,
			["amount"] = 0.5
		}
	}
}
v21[1] = v22
local v23 = {
	["Cost"] = 3,
	["Description"] = "-1s Lightning Cooldown",
	["Multipliers"] = {
		{
			["multiplier"] = v2.LightingStrikeCooldown,
			["amount"] = 1
		}
	}
}
v21[2] = v23
local v24 = {
	["Cost"] = 5,
	["Description"] = "-2s Lightning Cooldown",
	["Multipliers"] = {
		{
			["multiplier"] = v2.LightingStrikeCooldown,
			["amount"] = 2
		}
	}
}
v21[3] = v24
v20.Levels = v21
v4.LightningCooldown = v20
v3.Upgrades = v4
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Lightning]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3985"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.LockTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = require(v1.Enums.WorldTypes)
local v5 = {
	["Name"] = "Raining Arrow",
	["Icon"] = "rbxassetid://85341399056679",
	["Order"] = 2
}
local v6 = {
	[v2.World] = {
		["value"] = v4.LAVA_WORLD
	}
}
v5.LockedData = v6
v5.Cost = 1
local v7 = {}
local v8 = {
	["Order"] = 1
}
local v9 = {}
local v10 = {
	["Cost"] = 1,
	["Description"] = "Fires 1 additional arrow",
	["Multipliers"] = {
		{
			["multiplier"] = v3.ArrowFired,
			["amount"] = 1
		}
	}
}
v9[1] = v10
local v11 = {
	["Cost"] = 3,
	["Description"] = "Fires 2 additional arrows",
	["Multipliers"] = {
		{
			["multiplier"] = v3.ArrowFired,
			["amount"] = 2
		}
	}
}
v9[2] = v11
local v12 = {
	["Cost"] = 5,
	["Description"] = "Fires 3 additional arrows",
	["Multipliers"] = {
		{
			["multiplier"] = v3.ArrowFired,
			["amount"] = 3
		}
	}
}
v9[3] = v12
v8.Levels = v9
v7.ArrowFired = v8
local v13 = {
	["Order"] = 2
}
local v14 = {}
local v15 = {
	["Cost"] = 1,
	["Description"] = "Arrow Damage is increased to 20% of your total Damage",
	["Multipliers"] = {
		{
			["multiplier"] = v3.ArrowDamage,
			["amount"] = 0.2
		}
	}
}
v14[1] = v15
local v16 = {
	["Cost"] = 3,
	["Description"] = "Arrow Damage is increased to 30% of your total Damage",
	["Multipliers"] = {
		{
			["multiplier"] = v3.ArrowDamage,
			["amount"] = 0.3
		}
	}
}
v14[2] = v16
local v17 = {
	["Cost"] = 5,
	["Description"] = "Arrow Damage is increased to 40% of your total Damage",
	["Multipliers"] = {
		{
			["multiplier"] = v3.ArrowDamage,
			["amount"] = 0.4
		}
	}
}
v14[3] = v17
v13.Levels = v14
v7.ArrowDamage = v13
local v18 = {
	["Order"] = 3
}
local v19 = {}
local v20 = {
	["Cost"] = 1,
	["Description"] = "-0.5s Raining Arrows Cooldown",
	["Multipliers"] = {
		{
			["multiplier"] = v3.ArrowCooldown,
			["amount"] = 0.5
		}
	}
}
v19[1] = v20
local v21 = {
	["Cost"] = 3,
	["Description"] = "-1s Raining Arrows Cooldown",
	["Multipliers"] = {
		{
			["multiplier"] = v3.ArrowCooldown,
			["amount"] = 1
		}
	}
}
v19[2] = v21
local v22 = {
	["Cost"] = 5,
	["Description"] = "-2s Raining Arrows Cooldown",
	["Multipliers"] = {
		{
			["multiplier"] = v3.ArrowCooldown,
			["amount"] = 2
		}
	}
}
v19[3] = v22
v18.Levels = v19
v7.ArrowCooldown = v18
local v23 = {
	["Order"] = 4
}
local v24 = {}
local v25 = {
	["Cost"] = 1,
	["Description"] = "5% Chance to rain down arrows",
	["Multipliers"] = {
		{
			["multiplier"] = v3.ArrowRain,
			["amount"] = 0.05
		}
	}
}
v24[1] = v25
local v26 = {
	["Cost"] = 3,
	["Description"] = "15% Chance to rain down arrows",
	["Multipliers"] = {
		{
			["multiplier"] = v3.ArrowRain,
			["amount"] = 0.15
		}
	}
}
v24[2] = v26
local v27 = {
	["Cost"] = 5,
	["Description"] = "30% Chance to rain down arrows",
	["Multipliers"] = {
		{
			["multiplier"] = v3.ArrowRain,
			["amount"] = 0.3
		}
	}
}
v24[3] = v27
v23.Levels = v24
v7.ArrowRain = v23
v5.Upgrades = v7
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Arrow]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3986"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.LockTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = require(v1.Enums.WorldTypes)
local v5 = {
	["Name"] = "Icy Wind",
	["Icon"] = "rbxassetid://127566218661341",
	["Order"] = 3
}
local v6 = {
	[v2.World] = {
		["value"] = v4.ICE_WORLD
	}
}
v5.LockedData = v6
v5.Cost = 1
local v7 = {}
local v8 = {
	["Order"] = 1
}
local v9 = {}
local v10 = {
	["Cost"] = 1,
	["Description"] = "Freezes 50% of slimes!",
	["Multipliers"] = {
		{
			["multiplier"] = v3.FreezeAmount,
			["amount"] = 0.25
		}
	}
}
v9[1] = v10
local v11 = {
	["Cost"] = 3,
	["Description"] = "Freezes 75% of slimes!",
	["Multipliers"] = {
		{
			["multiplier"] = v3.FreezeAmount,
			["amount"] = 0.5
		}
	}
}
v9[2] = v11
local v12 = {
	["Cost"] = 5,
	["Description"] = "Freezes 100% of slimes!",
	["Multipliers"] = {
		{
			["multiplier"] = v3.FreezeAmount,
			["amount"] = 1
		}
	}
}
v9[3] = v12
v8.Levels = v9
v7.SlimesFrozen = v8
local v13 = {
	["Order"] = 2
}
local v14 = {}
local v15 = {
	["Cost"] = 1,
	["Description"] = "Freeze Damage is increased to 20% of your total damage!",
	["Multipliers"] = {
		{
			["multiplier"] = v3.FreezeDamage,
			["amount"] = 0.2
		}
	}
}
v14[1] = v15
local v16 = {
	["Cost"] = 3,
	["Description"] = "Freeze Damage is increased to 30% of your total damage!",
	["Multipliers"] = {
		{
			["multiplier"] = v3.FreezeDamage,
			["amount"] = 0.3
		}
	}
}
v14[2] = v16
local v17 = {
	["Cost"] = 5,
	["Description"] = "Freeze Damage is increased to 40% of your total damage!",
	["Multipliers"] = {
		{
			["multiplier"] = v3.FreezeDamage,
			["amount"] = 0.4
		}
	}
}
v14[3] = v17
v13.Levels = v14
v7.FreezeDamage = v13
local v18 = {
	["Order"] = 3
}
local v19 = {}
local v20 = {
	["Cost"] = 1,
	["Description"] = "-0.5s Icy Wind Cooldown",
	["Multipliers"] = {
		{
			["multiplier"] = v3.FreezeCooldown,
			["amount"] = 0.5
		}
	}
}
v19[1] = v20
local v21 = {
	["Cost"] = 3,
	["Description"] = "-1s Icy Wind Cooldown",
	["Multipliers"] = {
		{
			["multiplier"] = v3.FreezeCooldown,
			["amount"] = 1
		}
	}
}
v19[2] = v21
local v22 = {
	["Cost"] = 5,
	["Description"] = "-2s Icy Wind Cooldown",
	["Multipliers"] = {
		{
			["multiplier"] = v3.FreezeCooldown,
			["amount"] = 2
		}
	}
}
v19[3] = v22
v18.Levels = v19
v7.FreezeCooldown = v18
local v23 = {
	["Order"] = 4
}
local v24 = {}
local v25 = {
	["Cost"] = 1,
	["Description"] = "5% Chance to activate twice!",
	["Multipliers"] = {
		{
			["multiplier"] = v3.FreezeDoubleChance,
			["amount"] = 0.05
		}
	}
}
v24[1] = v25
local v26 = {
	["Cost"] = 3,
	["Description"] = "15% Chance to activate twice!",
	["Multipliers"] = {
		{
			["multiplier"] = v3.FreezeDoubleChance,
			["amount"] = 0.15
		}
	}
}
v24[2] = v26
local v27 = {
	["Cost"] = 5,
	["Description"] = "30% Chance to activate twice!",
	["Multipliers"] = {
		{
			["multiplier"] = v3.FreezeDoubleChance,
			["amount"] = 0.3
		}
	}
}
v24[3] = v27
v23.Levels = v24
v7.IcyDouble = v23
v5.Upgrades = v7
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[IcyWind]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3987"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(script.Parent.Colors)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = require(v1.Enums.PotionTypes)
local v5 = {
	[v4.Stats] = {
		["Name"] = "2x Stats Potion",
		["Icon"] = "rbxassetid://94384406501128",
		["Color"] = Color3.fromRGB(255, 255, 255),
		["Order"] = 1,
		["Duration"] = 900,
		["Description"] = "2x Stats for 15 Minutes. (Stats include Currency Gain, Damage and Rune Luck)",
		["Rainbow"] = true,
		["Gradient"] = v2.Rainbow.Gradient,
		["Multiplier"] = v3.StatsMultiplier,
		["MultiplierValue"] = 2
	},
	[v4.RuneLuck] = {
		["Name"] = "2x Rune Luck Potion",
		["Icon"] = "rbxassetid://103576822161458",
		["Color"] = Color3.fromRGB(159, 255, 80),
		["Order"] = 2,
		["Duration"] = 900,
		["Description"] = "2x Rune Luck for 15 Minutes",
		["Multiplier"] = v3.RuneLuckMultiplier,
		["MultiplierValue"] = 2
	},
	[v4.RuneSpeed] = {
		["Name"] = "2x Rune Speed Potion",
		["Icon"] = "rbxassetid://76521577998437",
		["Color"] = Color3.fromRGB(46, 213, 255),
		["Order"] = 3,
		["Duration"] = 900,
		["Description"] = "2x Rune Speed for 15 Minutes",
		["Multiplier"] = v3.RuneOpenTimeMultiplier,
		["MultiplierValue"] = 2
	},
	[v4.Damage] = {
		["Name"] = "2x Damage Potion",
		["Icon"] = "rbxassetid://122230269221038",
		["Color"] = Color3.fromRGB(255, 70, 70),
		["Order"] = 4,
		["Duration"] = 900,
		["Description"] = "2x Damage for 15 Minutes",
		["Multiplier"] = v3.DamageMultiplier,
		["MultiplierValue"] = 2
	},
	[v4.SkillXP] = {
		["Name"] = "2x Skill XP Potion",
		["Icon"] = "rbxassetid://127623213325385",
		["Color"] = Color3.fromRGB(255, 85, 255),
		["Order"] = 5,
		["Duration"] = 900,
		["Description"] = "2x Skill XP for 15 Minutes",
		["Multiplier"] = v3.SkillXPMultiplier,
		["MultiplierValue"] = 2
	}
}
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PotionData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3988"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Products)
return {
	[v2.Tokens[1]] = 49,
	[v2.Tokens[2]] = 149,
	[v2.Tokens[3]] = 499,
	[v2.Tokens[4]] = 999,
	[v2.Tokens[5]] = 12500
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TokenPackData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3989"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.LockTypes)
local v4 = require(v1.Enums.MultiplierTypes)
local v5 = require(v1.Enums.SlimeTypes)
local v6 = require(v1.Enums.WorldTypes)
local v7 = require(v1.Packages.Sift)
local v8 = {}
local v9 = v6.EARTH_WORLD
local v10 = {
	["Name"] = "Earth World",
	["Icon"] = "rbxassetid://119912775583431",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(91, 255, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(94, 255, 147)) }),
	["Order"] = 1,
	["Unlocked"] = true,
	["WorldSurgeCurrency"] = v2.Coins,
	["Multipliers"] = {
		["SpawnRate"] = v4.World1SpawnRate,
		["SpawnCap"] = v4.World1SpawnCap,
		["SpawnLuck"] = v4.World1SlimeLuck
	},
	["Attack"] = {
		["base"] = v4.AttackSpeed,
		["multi"] = v4.AttackSpeedMultiplier
	},
	["Damage"] = {
		["base"] = v4.Damage,
		["multi"] = v4.DamageMultiplier
	},
	["Range"] = {
		["base"] = v4.World1AttackRange,
		["multi"] = v4.AttackRangeMultiplier
	},
	["Currencies"] = { v2.Coins, v2.Rebirth, v2.Shards },
	["Slimes"] = {
		[v5.GreenSlime] = 80,
		[v5.BlueSlime] = 15,
		[v5.RedSlime] = 4,
		[v5.PurpleSlime] = 1
	}
}
v8[v9] = v10
local v11 = v6.LAVA_WORLD
local v12 = {
	["Name"] = "Lava World",
	["Icon"] = "rbxassetid://89639776621802",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(91, 255, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(94, 255, 147)) }),
	["Order"] = 2,
	["WorldSurgeCurrency"] = v2.FireCoins,
	["Multipliers"] = {
		["SpawnRate"] = v4.World2SpawnRate,
		["SpawnCap"] = v4.World2SpawnCap,
		["SpawnLuck"] = v4.World2SlimeLuck
	},
	["Attack"] = {
		["base"] = v4.AttackSpeed,
		["multi"] = v4.AttackSpeedMultiplier
	},
	["Damage"] = {
		["base"] = v4.Damage,
		["multi"] = v4.DamageMultiplier
	},
	["Range"] = {
		["base"] = v4.World2AttackRange,
		["multi"] = v4.AttackRangeMultiplier
	}
}
local v13 = {
	["Currency"] = {
		["Type"] = v2.Coins,
		["Amount"] = 3000000
	}
}
v12.Purchase = v13
local v14 = {
	[v3.World] = {
		["value"] = "LAVA_WORLD"
	}
}
v12.LockedData = v14
v12.Currencies = { v2.FireCoins, v2.Shards }
v12.Slimes = {
	[v5.GreySlime] = 80,
	[v5.OrangeSlime] = 15,
	[v5.YellowSlime] = 7,
	[v5.BrightRedSlime] = 1,
	[v5.MagmaSlime] = 0.1
}
v8[v11] = v12
local v15 = v6.ICE_WORLD
local v16 = {
	["Name"] = "Ice World",
	["Icon"] = "rbxassetid://116270873145366",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 226, 226)) }),
	["Order"] = 3,
	["CustomSpawning"] = true,
	["WorldSurgeCurrency"] = v2.IceCoins,
	["Multipliers"] = {
		["SpawnRate"] = v4.World3SpawnRate,
		["SpawnCap"] = v4.World3SpawnCap,
		["SpawnLuck"] = v4.World3SlimeLuck
	},
	["Attack"] = {
		["base"] = v4.AttackSpeed,
		["multi"] = v4.AttackSpeedMultiplier
	},
	["Damage"] = {
		["base"] = v4.Damage,
		["multi"] = v4.DamageMultiplier
	},
	["Range"] = {
		["base"] = v4.World3AttackRange,
		["multi"] = v4.AttackRangeMultiplier
	}
}
local v17 = {
	["Currency"] = {
		["Type"] = v2.FireCoins,
		["Amount"] = 1000000000
	}
}
v16.Purchase = v17
local v18 = {
	[v3.World] = {
		["value"] = "ICE_WORLD"
	}
}
v16.LockedData = v18
v16.Currencies = { v2.IceCoins, v2.Shards }
v16.Slimes = {
	[v5.IceSlime] = 90,
	[v5.PurpleIceSlime] = 8,
	[v5.PinkIceSlime] = 1.9,
	[v5.BlueIceSlime] = 0.99,
	[v5.WhiteIceSlime] = 0.01
}
v8[v15] = v16
local v19 = v6.VALENTINE_WORLD
local v20 = {
	["Name"] = "Valentine World",
	["Icon"] = "rbxassetid://79811841912304",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 182, 193)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 105, 180)) }),
	["Order"] = 100,
	["CustomSpawning"] = true,
	["Unlocked"] = true,
	["Event"] = true,
	["PausePotions"] = true,
	["Category"] = "Event",
	["WorldSurgeCurrency"] = v2.Hearts,
	["Currencies"] = { v2.Hearts, v2.CrystalHearts },
	["Attack"] = {
		["base"] = v4.ValentineAttackSpeed,
		["multi"] = v4.ValentineAttackSpeedMultiplier
	},
	["Damage"] = {
		["base"] = v4.ValentineDamage,
		["multi"] = v4.ValentineDamageMultiplier
	},
	["Range"] = {
		["base"] = v4.ValentineAttackRange,
		["multi"] = v4.ValentineAttackRangeMultiplier
	},
	["Slimes"] = {
		[v5.ValentineSlime1] = 85,
		[v5.ValentineSlime2] = 10,
		[v5.ValentineSlime3] = 4,
		[v5.ValentineSlime4] = 0.9,
		[v5.ValentineSlime5] = 0.1
	}
}
v8[v19] = v20
local v21 = v6.GLOW_WORLD
local v22 = {
	["Name"] = "Glow World",
	["Icon"] = "rbxassetid://103795527822612",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(134, 255, 86)), ColorSequenceKeypoint.new(1, Color3.fromRGB(19, 224, 47)) }),
	["Order"] = 4,
	["WorldSurgeCurrency"] = v2.GlowCoins,
	["Multipliers"] = {
		["SpawnRate"] = v4.World4SpawnRate,
		["SpawnCap"] = v4.World4SpawnCap,
		["SpawnLuck"] = v4.World4SlimeLuck
	},
	["Attack"] = {
		["base"] = v4.AttackSpeed,
		["multi"] = v4.AttackSpeedMultiplier
	},
	["Damage"] = {
		["base"] = v4.Damage,
		["multi"] = v4.DamageMultiplier
	},
	["Range"] = {
		["base"] = v4.World4AttackRange,
		["multi"] = v4.AttackRangeMultiplier
	}
}
local v23 = {
	["Currency"] = {
		["Type"] = v2.IceCoins,
		["Amount"] = 1000000000000
	}
}
v22.Purchase = v23
local v24 = {
	[v3.World] = {
		["value"] = v6.GLOW_WORLD
	}
}
v22.LockedData = v24
v22.Currencies = { v2.GlowCoins, v2.Shards, v2.SkillPoints }
v22.Slimes = {
	[v5.GloopSlime1] = 90,
	[v5.GloopSlime2] = 8,
	[v5.GloopSlime3] = 1.9,
	[v5.GloopSlime4] = 0.99,
	[v5.GloopSlime5] = 0.01
}
v8[v21] = v22
local v25 = v6.CANDY_WORLD
local v26 = {
	["Name"] = "Candy World",
	["Icon"] = "rbxassetid://119391435648062",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 182, 225)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 105, 180)) }),
	["Order"] = 5,
	["CustomSpawning"] = true,
	["WorldSurgeCurrency"] = v2.CandyCoins,
	["Multipliers"] = {
		["SpawnRate"] = v4.World5SpawnRate,
		["SpawnCap"] = v4.World5SpawnCap,
		["SpawnLuck"] = v4.World5SlimeLuck
	},
	["Attack"] = {
		["base"] = v4.AttackSpeed,
		["multi"] = v4.AttackSpeedMultiplier
	},
	["Damage"] = {
		["base"] = v4.Damage,
		["multi"] = v4.DamageMultiplier
	},
	["Range"] = {
		["base"] = v4.World5AttackRange,
		["multi"] = v4.AttackRangeMultiplier
	}
}
local v27 = {
	["Currency"] = {
		["Type"] = v2.GlowCoins,
		["Amount"] = 1000000000000000
	}
}
v26.Purchase = v27
local v28 = {
	[v3.World] = {
		["value"] = v6.CANDY_WORLD
	}
}
v26.LockedData = v28
v26.Currencies = { v2.CandyCoins, v2.Shards }
v26.Slimes = {
	[v5.CandySlime1] = 90,
	[v5.CandySlime2] = 8,
	[v5.CandySlime3] = 1.9,
	[v5.CandySlime4] = 0.99,
	[v5.CandySlime5] = 0.01
}
v8[v25] = v26
local v29 = v6.EVENT_1M_WORLD
local v30 = {
	["Name"] = "1M Event World",
	["Icon"] = "rbxassetid://123189598105012",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 165, 0)) }),
	["Order"] = 101,
	["Unlocked"] = true,
	["PausePotions"] = true,
	["Event"] = true,
	["Category"] = "Event",
	["WorldSurgeCurrency"] = v2.Event1MBalloon,
	["Currencies"] = { v2.Event1MBalloon, v2.Event1MConfetti, v2.Event1MStars },
	["Attack"] = {
		["base"] = v4.Event1MAttackSpeed,
		["multi"] = v4.Event1MAttackSpeedMultiplier
	},
	["Damage"] = {
		["base"] = v4.Event1MDamage,
		["multi"] = v4.Event1MDamageMultiplier
	},
	["Range"] = {
		["base"] = v4.Event1MAttackRange,
		["multi"] = v4.Event1MAttackRangeMultiplier
	},
	["Multipliers"] = {
		["SpawnRate"] = v4.Event1MSpawnRate,
		["SpawnCap"] = v4.Event1MSpawnCap,
		["SpawnLuck"] = v4.Event1MSlimeLuck
	},
	["Slimes"] = {
		[v5.Event1MSlime1] = 90,
		[v5.Event1MSlime2] = 8,
		[v5.Event1MSlime3] = 1.9,
		[v5.Event1MSlime4] = 0.99,
		[v5.Event1MSlime5] = 0.01
	}
}
v8[v29] = v30
for _, v_u_31 in v8 do
	if v_u_31.Slimes then
		v_u_31.DefaultSlime = v7.Array.sort(v7.Dictionary.keys(v_u_31.Slimes), function(p32, p33)
			-- upvalues: (copy) v_u_31
			return v_u_31.Slimes[p32] > v_u_31.Slimes[p33]
		end)[1]
	end
end
return v8]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WorldData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3990"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.IndexTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = {}
local v5 = v2.Slimes
local v6 = {}
local v7 = {
	["Every"] = 5,
	["Buffs"] = {
		{
			["type"] = v3.DamageMultiplier,
			["value"] = 0.05
		}
	}
}
v6.BuffInfo = v7
v4[v5] = v6
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[IndexRewardData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3991"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Formulas)
local v1 = {}
for _, v2 in script:GetChildren() do
	if v2:IsA("ModuleScript") then
		local v3 = string.match(v2.Name, "%d+")
		for v4, v5 in require(v2) do
			v1[("%*-%*"):format(v3, v4)] = v5
		end
	end
end
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UpgradeTreeData]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3992"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.LockTypes)
local v4 = require(v1.Enums.MultiplierTypes)
local v5 = require(v1.Enums.WorldTypes)
local v6 = Color3.fromRGB(148, 94, 255)
local v7 = Color3.fromRGB(66, 227, 255)
local v8 = Color3.fromRGB(99, 255, 99)
local v9 = {}
local v10 = {
	["Color"] = Color3.fromRGB(255, 255, 255)
}
local v11 = {}
local v12 = {
	["Text"] = "+1 Walkspeed",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 100000,
	["Multipliers"] = {
		{
			["type"] = v4.Walkspeed,
			["value"] = 1
		}
	}
}
v11[1] = v12
local v13 = {
	["Text"] = "+3 Walkspeed",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 250000,
	["Multipliers"] = {
		{
			["type"] = v4.Walkspeed,
			["value"] = 3
		}
	}
}
v11[2] = v13
local v14 = {
	["Text"] = "+5 Walkspeed",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 500000,
	["Multipliers"] = {
		{
			["type"] = v4.Walkspeed,
			["value"] = 5
		}
	}
}
v11[3] = v14
v10.Levels = v11
v9[1] = v10
local v15 = {
	["Requires"] = {
		["nodes"] = { "1-1" }
	},
	["Color"] = v6
}
local v16 = {
	{
		["Text"] = "Unlocks Rune Nodes",
		["CurrencyType"] = v2.FireCoins,
		["CurrencyCost"] = 500000
	}
}
v15.Levels = v16
v9[2] = v15
local v17 = {
	["Requires"] = {
		["nodes"] = { "1-2" }
	},
	["Color"] = v6
}
local v18 = {}
local v19 = {
	["Text"] = "+10 Rune Bulk",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 1000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneBulk,
			["value"] = 10
		}
	}
}
v18[1] = v19
v17.Levels = v18
v9[3] = v17
local v20 = {
	["Requires"] = {
		["nodes"] = { "1-3" }
	},
	["Color"] = v6
}
local v21 = {}
local v22 = {
	["Text"] = "+50 Rune Bulk",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 10000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneBulk,
			["value"] = 50
		}
	}
}
v21[1] = v22
v20.Levels = v21
v9[4] = v20
local v23 = {
	["Requires"] = {
		["nodes"] = { "1-4" }
	},
	["Color"] = v6
}
local v24 = {}
local v25 = {
	["Text"] = "+100 Rune Bulk",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 100000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneBulk,
			["value"] = 100
		}
	}
}
v24[1] = v25
v23.Levels = v24
v9[5] = v23
local v26 = {
	["Requires"] = {
		["nodes"] = { "1-3" }
	},
	["Color"] = v6
}
local v27 = {}
local v28 = {
	["Text"] = "+5 Rune Luck",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 2500000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneLuck,
			["value"] = 5
		}
	}
}
v27[1] = v28
v26.Levels = v27
v9[6] = v26
local v29 = {
	["Requires"] = {
		["nodes"] = { "1-6" }
	},
	["Color"] = v6
}
local v30 = {}
local v31 = {
	["Text"] = "+25 Rune Luck",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 12500000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneLuck,
			["value"] = 25
		}
	}
}
v30[1] = v31
v29.Levels = v30
v9[7] = v29
local v32 = {
	["Requires"] = {
		["nodes"] = { "1-7" }
	},
	["Color"] = v6
}
local v33 = {}
local v34 = {
	["Text"] = "+50 Rune Luck",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 120000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneLuck,
			["value"] = 50
		}
	}
}
v33[1] = v34
v32.Levels = v33
v9[8] = v32
local v35 = {
	["Requires"] = {
		["nodes"] = { "1-6" }
	},
	["Color"] = v6
}
local v36 = {}
local v37 = {
	["Text"] = "1.05x Rune Open Speed",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 5000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneOpenTimeMultiplier,
			["value"] = 1.05
		}
	}
}
v36[1] = v37
v35.Levels = v36
v9[9] = v35
local v38 = {
	["Requires"] = {
		["nodes"] = { "1-9" }
	},
	["Color"] = v6
}
local v39 = {}
local v40 = {
	["Text"] = "1.25x Rune Open Speed",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 15000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneOpenTimeMultiplier,
			["value"] = 1.25
		}
	}
}
v39[1] = v40
v38.Levels = v39
v9[10] = v38
local v41 = {
	["Requires"] = {
		["nodes"] = { "1-10" }
	},
	["Color"] = v6
}
local v42 = {}
local v43 = {
	["Text"] = "1.5x Rune Open Speed",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 150000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneOpenTimeMultiplier,
			["value"] = 1.5
		}
	}
}
v42[1] = v43
v41.Levels = v42
v9[11] = v41
local v44 = {
	["Requires"] = {
		["nodes"] = { "1-1" }
	},
	["Color"] = v7
}
local v45 = {
	{
		["Text"] = "Unlock Player Nodes",
		["CurrencyType"] = v2.FireCoins,
		["CurrencyCost"] = 1000000
	}
}
v44.Levels = v45
v9[12] = v44
local v46 = {
	["Requires"] = {
		["nodes"] = { "1-12" }
	},
	["Color"] = v7
}
local v47 = {}
local v48 = {
	["Text"] = "-0.25s Attack Speed",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 5000000,
	["Multipliers"] = {
		{
			["type"] = v4.AttackSpeed,
			["value"] = 0.25
		}
	}
}
v47[1] = v48
v46.Levels = v47
v9[13] = v46
local v49 = {
	["Requires"] = {
		["nodes"] = { "1-13" }
	},
	["Color"] = v7
}
local v50 = {}
local v51 = {
	["Text"] = "1.1x Attack Range",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 25000000,
	["Multipliers"] = {
		{
			["type"] = v4.AttackRangeMultiplier,
			["value"] = 1.1
		}
	}
}
v50[1] = v51
v49.Levels = v50
v9[14] = v49
local v52 = {
	["Requires"] = {
		["nodes"] = { "1-14" }
	},
	["Color"] = v7
}
local v53 = {}
local v54 = {
	["Text"] = "Increase Critical Chance",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 75000000,
	["Multipliers"] = {
		{
			["type"] = v4.CriticalHitChance,
			["value"] = 0.04
		}
	}
}
v53[1] = v54
v52.Levels = v53
v9[15] = v52
local v55 = {
	["Requires"] = {
		["nodes"] = { "1-15" }
	},
	["Color"] = v7
}
local v56 = {}
local v57 = {
	["Text"] = "Increase Critical Damage",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 125000000,
	["Multipliers"] = {
		{
			["type"] = v4.CriticalHitMultiplier,
			["value"] = 2
		}
	}
}
v56[1] = v57
v55.Levels = v56
v9[16] = v55
local v58 = {
	["Requires"] = {
		["nodes"] = { "1-16" }
	},
	["Color"] = v7
}
local v59 = {}
local v60 = {
	["Text"] = "Combos give more multiplier!",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 200000000,
	["Multipliers"] = {
		{
			["type"] = v4.ComboMultiplier,
			["value"] = 0.15
		}
	}
}
v59[1] = v60
v58.Levels = v59
v9[17] = v58
local v61 = {
	["Requires"] = {
		["nodes"] = { "1-1" }
	},
	["Color"] = v8
}
local v62 = {
	{
		["Text"] = "Unlock Player Nodes",
		["CurrencyType"] = v2.FireCoins,
		["CurrencyCost"] = 1500000
	}
}
v61.Levels = v62
v9[18] = v61
local v63 = {
	["Requires"] = {
		["nodes"] = { "1-18" }
	},
	["Color"] = v8
}
local v64 = {}
local v65 = {
	["Text"] = "3x Rebirth Multiplier",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 5000000,
	["Multipliers"] = {
		{
			["type"] = v4.RebirthMultiplier,
			["value"] = 1.5
		}
	}
}
v64[1] = v65
v63.Levels = v64
v9[19] = v63
local v66 = {
	["Requires"] = {
		["nodes"] = { "1-19" }
	},
	["Color"] = v8
}
local v67 = {}
local v68 = {
	["Text"] = "Golden Slimes can now spawn!",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 15000000,
	["Multipliers"] = {
		{
			["type"] = v4.GoldenChance,
			["value"] = 0.05
		}
	}
}
v67[1] = v68
v66.Levels = v67
v9[20] = v66
local v69 = {
	["Requires"] = {
		["nodes"] = { "1-20" }
	},
	["Color"] = v8
}
local v70 = {}
local v71 = {
	["Text"] = "Diamond Slimes can now spawn!",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 80000000,
	["Multipliers"] = {
		{
			["type"] = v4.DiamondChance,
			["value"] = 0.03
		}
	}
}
v70[1] = v71
v69.Levels = v70
v9[21] = v69
local v72 = {
	["Requires"] = {
		["nodes"] = { "1-21" }
	},
	["Color"] = v8
}
local v73 = {}
local v74 = {
	["Text"] = "Rainbow Slimes can now spawn!",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 250000000,
	["Multipliers"] = {
		{
			["type"] = v4.RainbowChance,
			["value"] = 0.01
		}
	}
}
v73[1] = v74
v72.Levels = v73
v9[22] = v72
local v75 = {
	["Requires"] = {
		["nodes"] = { "1-20" }
	},
	["Color"] = v8
}
local v76 = {}
local v77 = {
	["Text"] = "Shards have a higher chance to drop!",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 12500000,
	["Multipliers"] = {
		{
			["type"] = v4.ShardDropChance,
			["value"] = 0.04
		}
	}
}
v76[1] = v77
v75.Levels = v76
v9[23] = v75
local v78 = {
	["Requires"] = {
		["nodes"] = { "1-23" }
	},
	["Color"] = v8
}
local v79 = {}
local v80 = {
	["Text"] = "Lucky Block boost duration increased!",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 80000000,
	["Multipliers"] = {
		{
			["type"] = v4.LuckyBlockDurationIncrease,
			["value"] = 60
		}
	}
}
v79[1] = v80
v78.Levels = v79
v9[24] = v78
local v81 = {
	["Requires"] = {
		["nodes"] = { "1-23" }
	},
	["Color"] = Color3.fromRGB(204, 242, 255)
}
local v82 = {
	[v3.World] = {
		["value"] = v5.ICE_WORLD
	}
}
v81.LockedData = v82
local v83 = {
	{
		["Text"] = "Unlocks Ice World Upgrades",
		["CurrencyType"] = v2.FireCoins,
		["CurrencyCost"] = 1200000000
	}
}
v81.Levels = v83
v9[25] = v81
local v84 = {
	["Requires"] = {
		["nodes"] = { "1-25" }
	},
	["Color"] = Color3.fromRGB(255, 112, 112)
}
local v85 = {}
local v86 = {
	["Text"] = "+10% Damage",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 2500000000,
	["Multipliers"] = {
		{
			["type"] = v4.DamageMultiplier,
			["value"] = 1.1
		}
	}
}
v85[1] = v86
v84.Levels = v85
v9[26] = v84
local v87 = {
	["Requires"] = {
		["nodes"] = { "1-26" }
	},
	["Color"] = Color3.fromRGB(255, 112, 112)
}
local v88 = {}
local v89 = {
	["Text"] = "+50% Damage",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 5000000000,
	["Multipliers"] = {
		{
			["type"] = v4.DamageMultiplier,
			["value"] = 1.5
		}
	}
}
v88[1] = v89
v87.Levels = v88
v9[27] = v87
local v90 = {
	["Requires"] = {
		["nodes"] = { "1-27" }
	},
	["Color"] = Color3.fromRGB(255, 112, 112)
}
local v91 = {}
local v92 = {
	["Text"] = "+100% Damage",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 15000000000,
	["Multipliers"] = {
		{
			["type"] = v4.DamageMultiplier,
			["value"] = 2
		}
	}
}
v91[1] = v92
v90.Levels = v91
v9[28] = v90
local v93 = {
	["Requires"] = {
		["nodes"] = { "1-27" }
	},
	["Color"] = v6
}
local v94 = {}
local v95 = {
	["Text"] = "+50 Rune Bulk",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 5000000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneBulk,
			["value"] = 50
		}
	}
}
v94[1] = v95
v93.Levels = v94
v9[29] = v93
local v96 = {
	["Requires"] = {
		["nodes"] = { "1-29" }
	},
	["Color"] = v6
}
local v97 = {}
local v98 = {
	["Text"] = "+150 Rune Bulk",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 10000000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneBulk,
			["value"] = 150
		}
	}
}
v97[1] = v98
v96.Levels = v97
v9[30] = v96
local v99 = {
	["Requires"] = {
		["nodes"] = { "1-29" }
	},
	["Color"] = v6
}
local v100 = {}
local v101 = {
	["Text"] = "1.1x Rune Open Speed",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 12500000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneOpenTimeMultiplier,
			["value"] = 1.1
		}
	}
}
v100[1] = v101
v99.Levels = v100
v9[31] = v99
local v102 = {
	["Requires"] = {
		["nodes"] = { "1-31" }
	},
	["Color"] = v6
}
local v103 = {}
local v104 = {
	["Text"] = "1.15x Rune Open Speed",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 15000000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneOpenTimeMultiplier,
			["value"] = 1.15
		}
	}
}
v103[1] = v104
v102.Levels = v103
v9[32] = v102
local v105 = {
	["Requires"] = {
		["nodes"] = { "1-32" }
	},
	["Color"] = v6
}
local v106 = {}
local v107 = {
	["Text"] = "1.25x Rune Open Speed",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 25000000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneOpenTimeMultiplier,
			["value"] = 1.25
		}
	}
}
v106[1] = v107
v105.Levels = v106
v9[33] = v105
local v108 = {
	["Requires"] = {
		["nodes"] = { "1-33" }
	},
	["Color"] = v6
}
local v109 = {}
local v110 = {
	["Text"] = "1.35x Rune Open Speed",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 50000000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneOpenTimeMultiplier,
			["value"] = 1.35
		}
	}
}
v109[1] = v110
v108.Levels = v109
v9[34] = v108
local v111 = {
	["Requires"] = {
		["nodes"] = { "1-34" }
	},
	["Color"] = v6
}
local v112 = {}
local v113 = {
	["Text"] = "1.5x Rune Open Speed",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 100000000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneOpenTimeMultiplier,
			["value"] = 1.5
		}
	}
}
v112[1] = v113
v111.Levels = v112
v9[35] = v111
local v114 = {
	["Requires"] = {
		["nodes"] = { "1-29" }
	},
	["Color"] = v6
}
local v115 = {}
local v116 = {
	["Text"] = "1.01x Rune Luck",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 12000000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneLuckMultiplier,
			["value"] = 1.01
		}
	}
}
v115[1] = v116
v114.Levels = v115
v9[36] = v114
local v117 = {
	["Requires"] = {
		["nodes"] = { "1-36" }
	},
	["Color"] = v6
}
local v118 = {}
local v119 = {
	["Text"] = "1.05x Rune Luck",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 25000000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneLuckMultiplier,
			["value"] = 1.05
		}
	}
}
v118[1] = v119
v117.Levels = v118
v9[37] = v117
local v120 = {
	["Requires"] = {
		["nodes"] = { "1-37" }
	},
	["Color"] = v6
}
local v121 = {}
local v122 = {
	["Text"] = "1.1x Rune Luck",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 50000000000,
	["Multipliers"] = {
		{
			["type"] = v4.RuneLuckMultiplier,
			["value"] = 1.1
		}
	}
}
v121[1] = v122
v120.Levels = v121
v9[38] = v120
local v123 = {
	["Requires"] = {
		["nodes"] = { "1-37" }
	},
	["Color"] = Color3.fromRGB(144, 255, 236)
}
local v124 = {}
local v125 = {
	["Text"] = "-1% Boss Cooldown",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 50000000000,
	["Multipliers"] = {
		{
			["type"] = v4.IceBossCooldownPercentage,
			["value"] = 0.01
		}
	}
}
v124[1] = v125
v123.Levels = v124
v9[39] = v123
local v126 = {
	["Requires"] = {
		["nodes"] = { "1-39" }
	},
	["Color"] = Color3.fromRGB(144, 255, 236)
}
local v127 = {}
local v128 = {
	["Text"] = "-2% Boss Cooldown",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 150000000000,
	["Multipliers"] = {
		{
			["type"] = v4.IceBossCooldownPercentage,
			["value"] = 0.02
		}
	}
}
v127[1] = v128
v126.Levels = v127
v9[40] = v126
local v129 = {
	["Requires"] = {
		["nodes"] = { "1-40" }
	},
	["Color"] = Color3.fromRGB(144, 255, 236)
}
local v130 = {}
local v131 = {
	["Text"] = "-3% Boss Cooldown",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 250000000000,
	["Multipliers"] = {
		{
			["type"] = v4.IceBossCooldownPercentage,
			["value"] = 0.03
		}
	}
}
v130[1] = v131
v129.Levels = v130
v9[41] = v129
local v132 = {
	["Requires"] = {
		["nodes"] = { "1-41" }
	},
	["Color"] = Color3.fromRGB(144, 255, 236)
}
local v133 = {}
local v134 = {
	["Text"] = "-5% Boss Cooldown",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 750000000000,
	["Multipliers"] = {
		{
			["type"] = v4.IceBossCooldownPercentage,
			["value"] = 0.05
		}
	}
}
v133[1] = v134
v132.Levels = v133
v9[42] = v132
local v135 = {
	["Requires"] = {
		["nodes"] = { "1-41" }
	},
	["Color"] = Color3.fromRGB(173, 86, 255)
}
local v136 = {}
local v137 = {
	["Text"] = "-1% Free Shard Cooldown",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 120000000000,
	["Multipliers"] = {
		{
			["type"] = v4.FreeShardPercentage,
			["value"] = 0.01
		}
	}
}
v136[1] = v137
v135.Levels = v136
v9[43] = v135
local v138 = {
	["Requires"] = {
		["nodes"] = { "1-43" }
	},
	["Color"] = Color3.fromRGB(173, 86, 255)
}
local v139 = {}
local v140 = {
	["Text"] = "-2% Free Shard Cooldown",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 180000000000,
	["Multipliers"] = {
		{
			["type"] = v4.FreeShardPercentage,
			["value"] = 0.02
		}
	}
}
v139[1] = v140
v138.Levels = v139
v9[44] = v138
local v141 = {
	["Requires"] = {
		["nodes"] = { "1-44" }
	},
	["Color"] = Color3.fromRGB(173, 86, 255)
}
local v142 = {}
local v143 = {
	["Text"] = "-3% Free Shard Cooldown",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 250000000000,
	["Multipliers"] = {
		{
			["type"] = v4.FreeShardPercentage,
			["value"] = 0.03
		}
	}
}
v142[1] = v143
v141.Levels = v142
v9[45] = v141
local v144 = {
	["Requires"] = {
		["nodes"] = { "1-45" }
	},
	["Color"] = Color3.fromRGB(173, 86, 255)
}
local v145 = {}
local v146 = {
	["Text"] = "-5% Free Shard Cooldown",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 350000000000,
	["Multipliers"] = {
		{
			["type"] = v4.FreeShardPercentage,
			["value"] = 0.05
		}
	}
}
v145[1] = v146
v144.Levels = v145
v9[46] = v144
local v147 = {
	["Requires"] = {
		["nodes"] = { "1-46" }
	},
	["Color"] = Color3.fromRGB(173, 86, 255)
}
local v148 = {}
local v149 = {
	["Text"] = "-10% Free Shard Cooldown",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 500000000000,
	["Multipliers"] = {
		{
			["type"] = v4.FreeShardPercentage,
			["value"] = 0.1
		}
	}
}
v148[1] = v149
v147.Levels = v148
v9[47] = v147
local v150 = {
	["Requires"] = {
		["nodes"] = { "1-44" }
	},
	["Color"] = Color3.fromRGB(255, 189, 90)
}
local v151 = {}
local v152 = {
	["Text"] = "+30s Ice World Duration",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 1000000000000,
	["Multipliers"] = {
		{
			["type"] = v4.IceWorldDuration,
			["value"] = 30
		}
	}
}
v151[1] = v152
v150.Levels = v151
v9[48] = v150
local v153 = {
	["Requires"] = {
		["nodes"] = { "1-48" }
	},
	["Color"] = Color3.fromRGB(255, 189, 90)
}
local v154 = {}
local v155 = {
	["Text"] = "+60s Ice World Duration",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 1500000000000,
	["Multipliers"] = {
		{
			["type"] = v4.IceWorldDuration,
			["value"] = 60
		}
	}
}
v154[1] = v155
v153.Levels = v154
v9[49] = v153
local v156 = {
	["Requires"] = {
		["nodes"] = { "1-49" }
	},
	["Color"] = Color3.fromRGB(255, 189, 90)
}
local v157 = {}
local v158 = {
	["Text"] = "+90s Ice World Duration",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 2000000000000,
	["Multipliers"] = {
		{
			["type"] = v4.IceWorldDuration,
			["value"] = 90
		}
	}
}
v157[1] = v158
v156.Levels = v157
v9[50] = v156
local v159 = {
	["Requires"] = {
		["nodes"] = { "1-50" }
	},
	["Color"] = Color3.fromRGB(255, 189, 90)
}
local v160 = {}
local v161 = {
	["Text"] = "+120s Ice World Duration",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 5000000000000,
	["Multipliers"] = {
		{
			["type"] = v4.IceWorldDuration,
			["value"] = 120
		}
	}
}
v160[1] = v161
v159.Levels = v160
v9[51] = v159
local v162 = {
	["Requires"] = {
		["nodes"] = { "1-51" }
	},
	["Color"] = Color3.fromRGB(255, 189, 90)
}
local v163 = {}
local v164 = {
	["Text"] = "+150s Ice World Duration",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 15000000000000,
	["Multipliers"] = {
		{
			["type"] = v4.IceWorldDuration,
			["value"] = 150
		}
	}
}
v163[1] = v164
v162.Levels = v163
v9[52] = v162
local v165 = {
	["Requires"] = {
		["nodes"] = { "1-52" }
	},
	["Color"] = Color3.fromRGB(255, 189, 90)
}
local v166 = {}
local v167 = {
	["Text"] = "+180s Ice World Duration",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 25000000000000,
	["Multipliers"] = {
		{
			["type"] = v4.IceWorldDuration,
			["value"] = 180
		}
	}
}
v166[1] = v167
v165.Levels = v166
v9[53] = v165
local v168 = {
	["Requires"] = {
		["nodes"] = { "1-31" }
	},
	["Color"] = Color3.fromRGB(181, 90, 255)
}
local v169 = {}
local v170 = {
	["Text"] = "+1% Skill XP Multiplier",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 25000000000,
	["Multipliers"] = {
		{
			["type"] = v4.SkillXPMultiplier,
			["value"] = 1.01
		}
	}
}
v169[1] = v170
v168.Levels = v169
v9[54] = v168
local v171 = {
	["Requires"] = {
		["nodes"] = { "1-54" }
	},
	["Color"] = Color3.fromRGB(181, 90, 255)
}
local v172 = {}
local v173 = {
	["Text"] = "+3% Skill XP Multiplier",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 40000000000,
	["Multipliers"] = {
		{
			["type"] = v4.SkillXPMultiplier,
			["value"] = 1.04
		}
	}
}
v172[1] = v173
v171.Levels = v172
v9[55] = v171
local v174 = {
	["Requires"] = {
		["nodes"] = { "1-55" }
	},
	["Color"] = Color3.fromRGB(181, 90, 255)
}
local v175 = {}
local v176 = {
	["Text"] = "+6% Skill XP Multiplier",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 80000000000,
	["Multipliers"] = {
		{
			["type"] = v4.SkillXPMultiplier,
			["value"] = 1.06
		}
	}
}
v175[1] = v176
v174.Levels = v175
v9[56] = v174
local v177 = {
	["Requires"] = {
		["nodes"] = { "1-54" }
	},
	["Color"] = Color3.fromRGB(116, 255, 128)
}
local v178 = {}
local v179 = {
	["Text"] = "+5s Bonus Duration",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 50000000000,
	["Multipliers"] = {
		{
			["type"] = v4.IceBonusTime,
			["value"] = 5
		}
	}
}
v178[1] = v179
v177.Levels = v178
v9[57] = v177
local v180 = {
	["Requires"] = {
		["nodes"] = { "1-57" }
	},
	["Color"] = Color3.fromRGB(116, 255, 128)
}
local v181 = {}
local v182 = {
	["Text"] = "+10s Bonus Duration",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 80000000000,
	["Multipliers"] = {
		{
			["type"] = v4.IceBonusTime,
			["value"] = 10
		}
	}
}
v181[1] = v182
v180.Levels = v181
v9[58] = v180
local v183 = {
	["Requires"] = {
		["nodes"] = { "1-58" }
	},
	["Color"] = Color3.fromRGB(116, 255, 128)
}
local v184 = {}
local v185 = {
	["Text"] = "+15s Bonus Duration",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 120000000000,
	["Multipliers"] = {
		{
			["type"] = v4.IceBonusTime,
			["value"] = 15
		}
	}
}
v184[1] = v185
v183.Levels = v184
v9[59] = v183
local v186 = {
	["Requires"] = {
		["nodes"] = { "1-59" }
	},
	["Color"] = Color3.fromRGB(116, 255, 128)
}
local v187 = {}
local v188 = {
	["Text"] = "+25s Bonus Duration",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 250000000000,
	["Multipliers"] = {
		{
			["type"] = v4.IceBonusTime,
			["value"] = 25
		}
	}
}
v187[1] = v188
v186.Levels = v187
v9[60] = v186
local v189 = {
	["Requires"] = {
		["nodes"] = { "1-60" }
	},
	["Color"] = Color3.fromRGB(255, 90, 90)
}
local v190 = {}
local v191 = {
	["Text"] = "-1% Amulet Cost",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 500000000000,
	["Multipliers"] = {
		{
			["type"] = v4.AmuletCheaperCost,
			["value"] = 0.01
		}
	}
}
v190[1] = v191
v189.Levels = v190
v9[61] = v189
local v192 = {
	["Requires"] = {
		["nodes"] = { "1-60" }
	},
	["Color"] = Color3.fromRGB(255, 90, 90)
}
local v193 = {}
local v194 = {
	["Text"] = "-4% Amulet Cost",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 1000000000000,
	["Multipliers"] = {
		{
			["type"] = v4.AmuletCheaperCost,
			["value"] = 0.04
		}
	}
}
v193[1] = v194
v192.Levels = v193
v9[62] = v192
local v195 = {
	["Requires"] = {
		["nodes"] = { "1-60" }
	},
	["Color"] = Color3.fromRGB(255, 90, 90)
}
local v196 = {}
local v197 = {
	["Text"] = "-5% Amulet Cost",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 2500000000000,
	["Multipliers"] = {
		{
			["type"] = v4.AmuletCheaperCost,
			["value"] = 0.05
		}
	}
}
v196[1] = v197
v195.Levels = v196
v9[63] = v195
local v198 = {
	["Requires"] = {
		["nodes"] = { "1-60" }
	},
	["Color"] = Color3.fromRGB(255, 90, 90)
}
local v199 = {}
local v200 = {
	["Text"] = "-10% Amulet Cost",
	["CurrencyType"] = v2.FireCoins,
	["CurrencyCost"] = 5000000000000,
	["Multipliers"] = {
		{
			["type"] = v4.AmuletCheaperCost,
			["value"] = 0.1
		}
	}
}
v199[1] = v200
v198.Levels = v199
v9[64] = v198
return v9]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UpgradeTree1]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3993"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = require(v1.Utility.Format)
local v5 = Color3.fromRGB(255, 147, 223)
local v6 = Color3.fromRGB(255, 115, 213)
local v7 = Color3.fromRGB(255, 91, 140)
local v8 = Color3.fromRGB(255, 61, 120)
local v9 = Color3.fromRGB(255, 24, 93)
local v10 = {}
for v11 = 1, 200 do
	local v12 = (v11 * 0.1 + 1) * 100
	local v13 = math.floor(v12) / 100
	local v14 = {
		["Text"] = ("x%* Heart Multiplier"):format(v13),
		["CurrencyType"] = v2.Hearts
	}
	local v15 = 1.5 ^ (v11 - 1) * 2500
	v14.CurrencyCost = math.floor(v15)
	v14.Multipliers = {
		{
			["type"] = v3.HeartsMultiplier,
			["value"] = v13
		}
	}
	table.insert(v10, v14)
end
local v16 = {}
for v17 = 1, 50 do
	local v18 = v17 * 10
	local v19 = {
		["Text"] = ("+%* Rune Bulk"):format((v4.abbreviateComma(v18))),
		["CurrencyType"] = v2.Hearts
	}
	local v20 = 2.25 ^ (v17 - 1) * 10000
	v19.CurrencyCost = math.floor(v20)
	v19.Multipliers = {
		{
			["type"] = v3.ValentineRuneBulk,
			["value"] = v18
		}
	}
	table.insert(v16, v19)
end
local v21 = {}
for v22 = 1, 50 do
	local v23 = (v22 * 0.25 + 1) * 100
	local v24 = math.floor(v23) / 100
	local v25 = {
		["Text"] = ("x%* Rune Luck"):format((v4.abbreviateComma(v24))),
		["CurrencyType"] = v2.Hearts
	}
	local v26 = 2.5 ^ (v22 - 1) * 15000
	v25.CurrencyCost = math.floor(v26)
	v25.Multipliers = {
		{
			["type"] = v3.ValentineRuneLuck,
			["value"] = v24
		}
	}
	table.insert(v21, v25)
end
local v27 = {}
for v28 = 1, 25 do
	local v29 = (v28 * 0.1 + 1) * 100
	local v30 = math.floor(v29) / 100
	local v31 = {
		["Text"] = ("x%* Valentine Damage Multiplier"):format((v4.abbreviateComma(v30))),
		["CurrencyType"] = v2.Hearts
	}
	local v32 = 2.5 ^ (v28 - 1) * 7500
	v31.CurrencyCost = math.floor(v32)
	v31.Multipliers = {
		{
			["type"] = v3.ValentineDamageMultiplier,
			["value"] = v30
		}
	}
	table.insert(v27, v31)
end
local v33 = {}
for v34 = 1, 5 do
	local v35 = v34 * 0.5
	local v36 = {
		["Text"] = ("+%* Valentine Attack Range"):format((v4.abbreviateComma(v35))),
		["CurrencyType"] = v2.Hearts
	}
	local v37 = 2.5 ^ (v34 - 1) * 12500
	v36.CurrencyCost = math.floor(v37)
	v36.Multipliers = {
		{
			["type"] = v3.ValentineAttackRange,
			["value"] = v35
		}
	}
	table.insert(v33, v36)
end
local v38 = {}
for v39 = 1, 15 do
	local v40 = {
		["Text"] = ("+%* Slime Tier XP (Fill Slimes Faster)"):format(v39),
		["CurrencyType"] = v2.Hearts
	}
	local v41 = 600 ^ (v39 - 1) * 50000
	v40.CurrencyCost = math.floor(v41)
	v40.Multipliers = {
		{
			["type"] = v3.ValentineSlimeXP,
			["value"] = v39
		}
	}
	table.insert(v38, v40)
end
local v42 = {}
for v43 = 1, 15 do
	local v44 = (v43 * 0.1 + 1) * 100
	local v45 = math.floor(v44) / 100
	local v46 = {}
	local v47 = (v45 - 1) * 100
	v46.Text = ("+%*%% Valentine Passive Luck"):format((math.floor(v47)))
	v46.CurrencyType = v2.Hearts
	local v48 = 125 ^ (v43 - 1) * 18000
	v46.CurrencyCost = math.floor(v48)
	v46.Multipliers = {
		{
			["type"] = v3.ValentineTraitsLuckMultiplier,
			["value"] = v45
		}
	}
	table.insert(v42, v46)
end
local v49 = {}
for v50 = 1, 10 do
	local v51 = (v50 * 0.1 + 1) * 100
	local v52 = math.floor(v51) / 100
	local v53 = {}
	local v54 = (v52 - 1) * 100
	v53.Text = ("+%*%% Valentine Attack Speed"):format((math.floor(v54)))
	v53.CurrencyType = v2.Hearts
	local v55 = 1250 ^ (v50 - 1) * 18000
	v53.CurrencyCost = math.floor(v55)
	v53.Multipliers = {
		{
			["type"] = v3.ValentineAttackSpeedMultiplier,
			["value"] = v52
		}
	}
	table.insert(v49, v53)
end
local v56 = {}
for v57 = 1, 5 do
	local v58 = (v57 * 0.1 + 1) * 100
	local v59 = math.floor(v58) / 100
	local v60 = {}
	local v61 = (v59 - 1) * 100
	v60.Text = ("+%*%% Valentine Rune Open Time"):format((math.floor(v61)))
	v60.CurrencyType = v2.Hearts
	local v62 = 1250 ^ (v57 - 1) * 25000
	v60.CurrencyCost = math.floor(v62)
	v60.Multipliers = {
		{
			["type"] = v3.ValentineRuneOpenTimeMultiplier,
			["value"] = v59
		}
	}
	table.insert(v56, v60)
end
local v63 = {}
for v64 = 1, 5 do
	local v65 = (v64 * 0.5 + 1) * 100
	local v66 = math.floor(v65) / 100
	local v67 = {
		["Text"] = ("x%* Heart Multiplier"):format(v66),
		["CurrencyType"] = v2.Hearts
	}
	local v68 = 6000 ^ (v64 - 1) * 1000000
	v67.CurrencyCost = math.floor(v68)
	v67.Multipliers = {
		{
			["type"] = v3.HeartsMultiplier,
			["value"] = v66
		}
	}
	table.insert(v63, v67)
end
local v69 = {}
for v70 = 1, 75 do
	local v71 = v70 * 5
	local v72 = {}
	local v73 = v71 * 100
	v72.Text = ("+%*s Ice World Duration"):format(math.floor(v73) / 100)
	v72.CurrencyType = v2.Hearts
	local v74 = 3.25 ^ (v70 - 1) * 1500000
	v72.CurrencyCost = math.floor(v74)
	v72.Multipliers = {
		{
			["type"] = v3.IceWorldDuration,
			["value"] = v71
		}
	}
	table.insert(v69, v72)
end
local v75 = {}
for v76 = 1, 60 do
	local v77 = {}
	local v78 = v76 * 100
	v77.Text = ("+%*s Lucky Block Buff Duration"):format(math.floor(v78) / 100)
	v77.CurrencyType = v2.Hearts
	local v79 = 2.75 ^ (v76 - 1) * 1000000000
	v77.CurrencyCost = math.floor(v79)
	v77.Multipliers = {
		{
			["type"] = v3.LuckyBlockDurationIncrease,
			["value"] = v76
		}
	}
	table.insert(v75, v77)
end
local v80 = {}
for v81 = 1, 25 do
	local v82 = (v81 * 0.16 + 1) * 100
	local v83 = math.floor(v82) / 100
	local v84 = {
		["Text"] = ("x%* Coins Multiplier"):format(v83),
		["CurrencyType"] = v2.Hearts
	}
	local v85 = 3 ^ (v81 - 1) * 20000000000000
	v84.CurrencyCost = math.floor(v85)
	v84.Multipliers = {
		{
			["type"] = v3.CoinsMultiplier,
			["value"] = v83
		}
	}
	table.insert(v80, v84)
end
local v86 = {}
for v87 = 1, 25 do
	local v88 = (v87 * 0.16 + 1) * 100
	local v89 = math.floor(v88) / 100
	local v90 = {
		["Text"] = ("x%* Fire Coins Multiplier"):format(v89),
		["CurrencyType"] = v2.Hearts
	}
	local v91 = 3 ^ (v87 - 1) * 200000000000000
	v90.CurrencyCost = math.floor(v91)
	v90.Multipliers = {
		{
			["type"] = v3.FireCoinsMultiplier,
			["value"] = v89
		}
	}
	table.insert(v86, v90)
end
local v92 = {}
for v93 = 1, 25 do
	local v94 = (v93 * 0.16 + 1) * 100
	local v95 = math.floor(v94) / 100
	local v96 = {
		["Text"] = ("x%* Ice Coins Multiplier"):format(v95),
		["CurrencyType"] = v2.Hearts
	}
	local v97 = 3 ^ (v93 - 1) * 1e17
	v96.CurrencyCost = math.floor(v97)
	v96.Multipliers = {
		{
			["type"] = v3.IceCoinsMultiplier,
			["value"] = v95
		}
	}
	table.insert(v92, v96)
end
local v98 = {
	{
		["Color"] = v5,
		["IgnoreAscend"] = true,
		["Levels"] = v10
	}
}
local v99 = {
	["Color"] = v6,
	["IgnoreAscend"] = true,
	["Requires"] = {
		["nodes"] = { "2-1" }
	},
	["Levels"] = v16
}
v98[2] = v99
local v100 = {
	["Color"] = v7,
	["IgnoreAscend"] = true,
	["Requires"] = {
		["nodes"] = { "2-2" }
	},
	["Levels"] = v21
}
v98[3] = v100
local v101 = {
	["Color"] = v6,
	["IgnoreAscend"] = true,
	["Requires"] = {
		["nodes"] = { "2-2" }
	},
	["Levels"] = v27
}
v98[4] = v101
local v102 = {
	["Color"] = v6,
	["IgnoreAscend"] = true,
	["Requires"] = {
		["nodes"] = { "2-2" }
	},
	["Levels"] = v33
}
v98[5] = v102
local v103 = {
	["Color"] = v8,
	["IgnoreAscend"] = true,
	["Requires"] = {
		["nodes"] = { "2-3" }
	},
	["Levels"] = v38
}
v98[6] = v103
local v104 = {
	["Color"] = v7,
	["IgnoreAscend"] = true,
	["Requires"] = {
		["nodes"] = { "2-3" }
	},
	["Levels"] = v42
}
v98[7] = v104
local v105 = {
	["Color"] = v7,
	["IgnoreAscend"] = true,
	["Requires"] = {
		["nodes"] = { "2-3" }
	},
	["Levels"] = v49
}
v98[8] = v105
local v106 = {
	["Color"] = v7,
	["IgnoreAscend"] = true,
	["Requires"] = {
		["nodes"] = { "2-8" }
	},
	["Levels"] = v56
}
v98[9] = v106
local v107 = {
	["Color"] = v7,
	["IgnoreAscend"] = true,
	["Requires"] = {
		["nodes"] = { "2-7" }
	},
	["Levels"] = v56
}
v98[10] = v107
local v108 = {
	["Color"] = v8,
	["IgnoreAscend"] = true,
	["Requires"] = {
		["nodes"] = { "2-6" }
	},
	["Levels"] = v63
}
v98[11] = v108
local v109 = {
	["Color"] = v8,
	["IgnoreAscend"] = true,
	["Requires"] = {
		["nodes"] = { "2-11" }
	},
	["Levels"] = v75
}
v98[12] = v109
local v110 = {
	["Color"] = v9,
	["IgnoreAscend"] = true,
	["Requires"] = {
		["nodes"] = { "2-11" }
	},
	["Levels"] = v69
}
v98[13] = v110
local v111 = {
	["Color"] = v8,
	["IgnoreAscend"] = true,
	["Requires"] = {
		["nodes"] = { "2-6" }
	},
	["Levels"] = v80
}
v98[14] = v111
local v112 = {
	["Color"] = v8,
	["IgnoreAscend"] = true,
	["Requires"] = {
		["nodes"] = { "2-14" }
	},
	["Levels"] = v86
}
v98[15] = v112
local v113 = {
	["Color"] = v9,
	["IgnoreAscend"] = true,
	["Requires"] = {
		["nodes"] = { "2-14" }
	},
	["Levels"] = v92
}
v98[16] = v113
return v98]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UpgradeTree2]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3994"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = Color3.fromRGB(100, 200, 255)
local v5 = Color3.fromRGB(255, 100, 100)
local v6 = Color3.fromRGB(255, 215, 0)
local v7 = Color3.fromRGB(150, 255, 150)
local v8 = Color3.fromRGB(200, 100, 255)
local v9 = {}
local v10 = {
	["Title"] = "Skill Foundation",
	["Color"] = v4,
	["IgnoreAscend"] = true
}
local v11 = {}
local v12 = {
	["Text"] = "x1.5 Skill XP",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 30,
	["Multipliers"] = {
		{
			["type"] = v3.SkillXPMultiplier,
			["value"] = 1.5
		}
	}
}
v11[1] = v12
v10.Levels = v11
v9[1] = v10
local v13 = {
	["Title"] = "Skill Expertise",
	["Requires"] = {
		["nodes"] = { "3-1" }
	},
	["Color"] = v4,
	["IgnoreAscend"] = true
}
local v14 = {}
local v15 = {
	["Text"] = "x2 Skill XP",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 50,
	["Multipliers"] = {
		{
			["type"] = v3.SkillXPMultiplier,
			["value"] = 2
		}
	}
}
v14[1] = v15
v13.Levels = v14
v9[2] = v13
local v16 = {
	["Title"] = "Lightning Affinity",
	["Requires"] = {
		["nodes"] = { "3-2" }
	},
	["Color"] = v4,
	["IgnoreAscend"] = true
}
local v17 = {}
local v18 = {
	["Text"] = "+50% Lightning Damage",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 30,
	["Multipliers"] = {
		{
			["type"] = v3.LightingStrikeDamage,
			["value"] = 0.5
		}
	}
}
v17[1] = v18
v16.Levels = v17
v9[3] = v16
local v19 = {
	["Title"] = "Arrow Mastery",
	["Requires"] = {
		["nodes"] = { "3-2" }
	},
	["Color"] = v4,
	["IgnoreAscend"] = true
}
local v20 = {}
local v21 = {
	["Text"] = "+50% Arrow Damage",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 30,
	["Multipliers"] = {
		{
			["type"] = v3.ArrowDamage,
			["value"] = 0.5
		}
	}
}
v20[1] = v21
v19.Levels = v20
v9[4] = v19
local v22 = {
	["Title"] = "Icy Mastery",
	["Requires"] = {
		["nodes"] = { "3-3" }
	},
	["Color"] = v4,
	["IgnoreAscend"] = true
}
local v23 = {}
local v24 = {
	["Text"] = "+100% Freeze Damage",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 50,
	["Multipliers"] = {
		{
			["type"] = v3.FreezeDamage,
			["value"] = 1
		}
	}
}
v23[1] = v24
v22.Levels = v23
v9[5] = v22
local v25 = {
	["Title"] = "Skill Synergy",
	["Requires"] = {
		["nodes"] = { "3-3", "3-5" }
	},
	["Color"] = v4,
	["IgnoreAscend"] = true
}
local v26 = {}
local v27 = {
	["Text"] = "x2.5 Skill XP",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 50,
	["Multipliers"] = {
		{
			["type"] = v3.SkillXPMultiplier,
			["value"] = 2.5
		}
	}
}
v26[1] = v27
v25.Levels = v26
v9[6] = v25
local v28 = {
	["Title"] = "Swift Strikes",
	["Color"] = v5,
	["IgnoreAscend"] = true
}
local v29 = {}
local v30 = {
	["Text"] = "-5% Attack Speed",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 30,
	["Multipliers"] = {
		{
			["type"] = v3.AttackSpeed,
			["value"] = 0.05
		}
	}
}
v29[1] = v30
v28.Levels = v29
v9[7] = v28
local v31 = {
	["Title"] = "Rapid Assault",
	["Requires"] = {
		["nodes"] = { "3-7" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true
}
local v32 = {}
local v33 = {
	["Text"] = "x1.1 Attack Speed Multiplier",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 50,
	["Multipliers"] = {
		{
			["type"] = v3.AttackSpeedMultiplier,
			["value"] = 1.1
		}
	}
}
v32[1] = v33
v31.Levels = v32
v9[8] = v31
local v34 = {
	["Title"] = "Critical Eye",
	["Requires"] = {
		["nodes"] = { "3-8" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true
}
local v35 = {}
local v36 = {
	["Text"] = "+2% Critical Hit Chance",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 30,
	["Multipliers"] = {
		{
			["type"] = v3.CriticalHitChance,
			["value"] = 0.02
		}
	}
}
v35[1] = v36
v34.Levels = v35
v9[9] = v34
local v37 = {
	["Title"] = "Devastating Blows",
	["Requires"] = {
		["nodes"] = { "3-9" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true
}
local v38 = {}
local v39 = {
	["Text"] = "x1.25 Critical Hit Multiplier",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 50,
	["Multipliers"] = {
		{
			["type"] = v3.CriticalHitMultiplier,
			["value"] = 1.25
		}
	}
}
v38[1] = v39
v37.Levels = v38
v9[10] = v37
local v40 = {
	["Title"] = "Extended Reach",
	["Requires"] = {
		["nodes"] = { "3-10" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true
}
local v41 = {}
local v42 = {
	["Text"] = "x1.15 Attack Range",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 50,
	["Multipliers"] = {
		{
			["type"] = v3.AttackRangeMultiplier,
			["value"] = 1.15
		}
	}
}
v41[1] = v42
v40.Levels = v41
v9[11] = v40
local v43 = {
	["Title"] = "Overwhelming Power",
	["Requires"] = {
		["nodes"] = { "3-11" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true
}
local v44 = {}
local v45 = {
	["Text"] = "x1.5 Damage Multiplier",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 30,
	["Multipliers"] = {
		{
			["type"] = v3.DamageMultiplier,
			["value"] = 1.5
		}
	}
}
v44[1] = v45
v43.Levels = v44
v9[12] = v43
local v46 = {
	["Title"] = "Wealth Foundation",
	["Color"] = v6,
	["IgnoreAscend"] = true
}
local v47 = {}
local v48 = {
	["Text"] = "x1.25 Currency Gain",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 30,
	["Multipliers"] = {
		{
			["type"] = v3.CurrencyGain,
			["value"] = 1.25
		}
	}
}
v47[1] = v48
v46.Levels = v47
v9[13] = v46
local v49 = {
	["Title"] = "Economic Mastery",
	["Requires"] = {
		["nodes"] = { "3-13" }
	},
	["Color"] = v6,
	["IgnoreAscend"] = true
}
local v50 = {}
local v51 = {
	["Text"] = "x1.5 Currency Gain",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 50,
	["Multipliers"] = {
		{
			["type"] = v3.CurrencyGain,
			["value"] = 1.5
		}
	}
}
v50[1] = v51
v49.Levels = v50
v9[14] = v49
local v52 = {
	["Title"] = "Shard Hunter",
	["Requires"] = {
		["nodes"] = { "3-14" }
	},
	["Color"] = v6,
	["IgnoreAscend"] = true
}
local v53 = {}
local v54 = {
	["Text"] = "+5% Shard Drop Chance",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 30,
	["Multipliers"] = {
		{
			["type"] = v3.ShardDropChance,
			["value"] = 0.05
		}
	}
}
v53[1] = v54
v52.Levels = v53
v9[15] = v52
local v55 = {
	["Title"] = "Shard Abundance",
	["Requires"] = {
		["nodes"] = { "3-15" }
	},
	["Color"] = v6,
	["IgnoreAscend"] = true
}
local v56 = {}
local v57 = {
	["Text"] = "x1.5 Shard Multiplier",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 50,
	["Multipliers"] = {
		{
			["type"] = v3.ShardMultiplier,
			["value"] = 1.5
		}
	}
}
v56[1] = v57
v55.Levels = v56
v9[16] = v55
local v58 = {
	["Title"] = "Fortune\'s Favor",
	["Requires"] = {
		["nodes"] = { "3-16" }
	},
	["Color"] = v6,
	["IgnoreAscend"] = true
}
local v59 = {}
local v60 = {
	["Text"] = "x2 Currency Gain",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 50,
	["Multipliers"] = {
		{
			["type"] = v3.CurrencyGain,
			["value"] = 2
		}
	}
}
v59[1] = v60
v58.Levels = v59
v9[17] = v58
local v61 = {
	["Title"] = "Rune Efficiency",
	["Color"] = v7,
	["IgnoreAscend"] = true
}
local v62 = {}
local v63 = {
	["Text"] = "+25 Rune Bulk",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 30,
	["Multipliers"] = {
		{
			["type"] = v3.RuneBulk,
			["value"] = 25
		}
	}
}
v62[1] = v63
v61.Levels = v62
v9[18] = v61
local v64 = {
	["Title"] = "Rune Mastery",
	["Requires"] = {
		["nodes"] = { "3-18" }
	},
	["Color"] = v7,
	["IgnoreAscend"] = true
}
local v65 = {}
local v66 = {
	["Text"] = "+1 Rune Luck",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 50,
	["Multipliers"] = {
		{
			["type"] = v3.RuneLuck,
			["value"] = 1
		}
	}
}
v65[1] = v66
v64.Levels = v65
v9[19] = v64
local v67 = {
	["Title"] = "Swift Movement",
	["Requires"] = {
		["nodes"] = { "3-19" }
	},
	["Color"] = v7,
	["IgnoreAscend"] = true
}
local v68 = {}
local v69 = {
	["Text"] = "x1.2 Walkspeed",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 30,
	["Multipliers"] = {
		{
			["type"] = v3.WalkspeedMultiplier,
			["value"] = 1.2
		}
	}
}
v68[1] = v69
v67.Levels = v68
v9[20] = v67
local v70 = {
	["Title"] = "Stat Amplification",
	["Requires"] = {
		["nodes"] = { "3-20" }
	},
	["Color"] = v7,
	["IgnoreAscend"] = true
}
local v71 = {}
local v72 = {
	["Text"] = "x1.5 Stats Multiplier",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 50,
	["Multipliers"] = {
		{
			["type"] = v3.StatsMultiplier,
			["value"] = 1.5
		}
	}
}
v71[1] = v72
v70.Levels = v71
v9[21] = v70
local v73 = {
	["Title"] = "Combo Artist",
	["Requires"] = {
		["nodes"] = { "3-21" }
	},
	["Color"] = v7,
	["IgnoreAscend"] = true
}
local v74 = {}
local v75 = {
	["Text"] = "+10% Combo Multiplier",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 50,
	["Multipliers"] = {
		{
			["type"] = v3.ComboMultiplier,
			["value"] = 0.1
		}
	}
}
v74[1] = v75
v73.Levels = v74
v9[22] = v73
local v76 = {
	["Title"] = "Mystic Cloning",
	["Requires"] = {
		["nodes"] = { "3-6", "3-12" }
	},
	["Color"] = v8,
	["IgnoreAscend"] = true
}
local v77 = {}
local v78 = {
	["Text"] = "+5% Rune Clone Chance",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 30,
	["Multipliers"] = {
		{
			["type"] = v3.RuneCloneChance,
			["value"] = 0.05
		}
	}
}
v77[1] = v78
v76.Levels = v77
v9[23] = v76
local v79 = {
	["Title"] = "Arcane Duplication",
	["Requires"] = {
		["nodes"] = { "3-17", "3-22" }
	},
	["Color"] = v8,
	["IgnoreAscend"] = true
}
local v80 = {}
local v81 = {
	["Text"] = "x2 Rune Clone Multiplier",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 30,
	["Multipliers"] = {
		{
			["type"] = v3.RuneCloneMultiplier,
			["value"] = 2
		}
	}
}
v80[1] = v81
v79.Levels = v80
v9[24] = v79
local v82 = {
	["Title"] = "Transcendence",
	["Requires"] = {
		["nodes"] = { "3-23", "3-24" }
	},
	["Color"] = Color3.fromRGB(255, 208, 0),
	["IgnoreAscend"] = true
}
local v83 = {}
local v84 = {
	["Text"] = "x2 Rune Bulk Multiplier",
	["CurrencyType"] = v2.SkillPoints,
	["CurrencyCost"] = 50,
	["Multipliers"] = {
		{
			["type"] = v3.RuneBulkMultiplier,
			["value"] = 2
		}
	}
}
v83[1] = v84
v82.Levels = v83
v9[25] = v82
return v9]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UpgradeTree3]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3995"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = require(v1.Utility.Format)
local v5 = Color3.fromRGB(255, 200, 50)
local v6 = Color3.fromRGB(255, 100, 80)
local v7 = Color3.fromRGB(140, 100, 255)
local v8 = Color3.fromRGB(80, 200, 120)
local v9 = Color3.fromRGB(255, 130, 200)
local v10 = Color3.fromRGB(80, 200, 180)
local v11 = {}
for v12 = 1, 60 do
	local v13 = (v12 * 0.08 + 1) * 100
	local v14 = math.floor(v13) / 100
	local v15 = {
		["Text"] = ("x%* Balloon Multiplier"):format(v14),
		["CurrencyType"] = v2.Event1MBalloon
	}
	local v16 = 1.55 ^ (v12 - 1) * 150
	v15.CurrencyCost = math.floor(v16)
	v15.Multipliers = {
		{
			["type"] = v3.Event1MBalloonsMultiplier,
			["value"] = v14
		}
	}
	table.insert(v11, v15)
end
local v17 = {}
for v18 = 1, 30 do
	local v19 = (v18 * 0.1 + 1) * 100
	local v20 = math.floor(v19) / 100
	local v21 = {
		["Text"] = ("x%* Balloon Multiplier"):format(v20),
		["CurrencyType"] = v2.Event1MBalloon
	}
	local v22 = 1.75 ^ (v18 - 1) * 8000
	v21.CurrencyCost = math.floor(v22)
	v21.Multipliers = {
		{
			["type"] = v3.Event1MBalloonsMultiplier,
			["value"] = v20
		}
	}
	table.insert(v17, v21)
end
local v23 = {}
for v24 = 1, 18 do
	local v25 = (v24 * 0.15 + 1) * 100
	local v26 = math.floor(v25) / 100
	local v27 = {
		["Text"] = ("x%* Balloon Multiplier"):format(v26),
		["CurrencyType"] = v2.Event1MBalloon
	}
	local v28 = 2.5 ^ (v24 - 1) * 1000000
	v27.CurrencyCost = math.floor(v28)
	v27.Multipliers = {
		{
			["type"] = v3.Event1MBalloonsMultiplier,
			["value"] = v26
		}
	}
	table.insert(v23, v27)
end
local v29 = {}
for v30 = 1, 8 do
	local v31 = (v30 * 0.35 + 1) * 100
	local v32 = math.floor(v31) / 100
	local v33 = {
		["Text"] = ("x%* Balloon Multiplier"):format(v32),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v34 = 3 ^ (v30 - 1) * 2000000000
	v33.CurrencyCost = math.floor(v34)
	v33.Multipliers = {
		{
			["type"] = v3.Event1MBalloonsMultiplier,
			["value"] = v32
		}
	}
	table.insert(v29, v33)
end
local v35 = {}
for v36 = 1, 4 do
	local v37 = (v36 * 0.75 + 1) * 100
	local v38 = math.floor(v37) / 100
	local v39 = {
		["Text"] = ("x%* Balloon Multiplier"):format(v38),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v40 = 4.5 ^ (v36 - 1) * 3000000000000000
	v39.CurrencyCost = math.floor(v40)
	v39.Multipliers = {
		{
			["type"] = v3.Event1MBalloonsMultiplier,
			["value"] = v38
		}
	}
	table.insert(v35, v39)
end
local v41 = {}
for v42 = 1, 20 do
	local v43 = (v42 * 0.1 + 1) * 100
	local v44 = math.floor(v43) / 100
	local v45 = {
		["Text"] = ("x%* Damage Multiplier"):format((v4.abbreviateComma(v44))),
		["CurrencyType"] = v2.Event1MBalloon
	}
	local v46 = 2 ^ (v42 - 1) * 750
	v45.CurrencyCost = math.floor(v46)
	v45.Multipliers = {
		{
			["type"] = v3.Event1MDamageMultiplier,
			["value"] = v44
		}
	}
	table.insert(v41, v45)
end
local v47 = {}
for v48 = 1, 18 do
	local v49 = (v48 * 0.15 + 1) * 100
	local v50 = math.floor(v49) / 100
	local v51 = {
		["Text"] = ("x%* Damage Multiplier"):format((v4.abbreviateComma(v50))),
		["CurrencyType"] = v2.Event1MBalloon
	}
	local v52 = 2.4 ^ (v48 - 1) * 18000
	v51.CurrencyCost = math.floor(v52)
	v51.Multipliers = {
		{
			["type"] = v3.Event1MDamageMultiplier,
			["value"] = v50
		}
	}
	table.insert(v47, v51)
end
local v53 = {}
for v54 = 1, 12 do
	local v55 = (v54 * 0.2 + 1) * 100
	local v56 = math.floor(v55) / 100
	local v57 = {
		["Text"] = ("x%* Damage Multiplier"):format((v4.abbreviateComma(v56))),
		["CurrencyType"] = v2.Event1MBalloon
	}
	local v58 = 3 ^ (v54 - 1) * 2000000
	v57.CurrencyCost = math.floor(v58)
	v57.Multipliers = {
		{
			["type"] = v3.Event1MDamageMultiplier,
			["value"] = v56
		}
	}
	table.insert(v53, v57)
end
local v59 = {}
for v60 = 1, 10 do
	local v61 = (v60 * 0.25 + 1) * 100
	local v62 = math.floor(v61) / 100
	local v63 = {
		["Text"] = ("x%* Damage Multiplier"):format((v4.abbreviateComma(v62))),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v64 = 3.5 ^ (v60 - 1) * 20000000000000
	v63.CurrencyCost = math.floor(v64)
	v63.Multipliers = {
		{
			["type"] = v3.Event1MDamageMultiplier,
			["value"] = v62
		}
	}
	table.insert(v59, v63)
end
local v65 = {}
for v66 = 1, 4 do
	local v67 = v66 * 0.5
	local v68 = {
		["Text"] = ("+%* Attack Range"):format((v4.abbreviateComma(v67))),
		["CurrencyType"] = v2.Event1MBalloon
	}
	local v69 = 2.5 ^ (v66 - 1) * 3000
	v68.CurrencyCost = math.floor(v69)
	v68.Multipliers = {
		{
			["type"] = v3.Event1MAttackRange,
			["value"] = v67
		}
	}
	table.insert(v65, v68)
end
local v70 = {}
for v71 = 1, 4 do
	local v72 = v71 * 0.5
	local v73 = {
		["Text"] = ("+%* Attack Range"):format((v4.abbreviateComma(v72))),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v74 = 4 ^ (v71 - 1) * 20000000000
	v73.CurrencyCost = math.floor(v74)
	v73.Multipliers = {
		{
			["type"] = v3.Event1MAttackRange,
			["value"] = v72
		}
	}
	table.insert(v70, v73)
end
local v75 = {}
for v76 = 1, 8 do
	local v77 = (v76 * 0.1 + 1) * 100
	local v78 = math.floor(v77) / 100
	local v79 = {}
	local v80 = (v78 - 1) * 100
	v79.Text = ("+%*%% Attack Speed"):format((math.floor(v80)))
	v79.CurrencyType = v2.Event1MBalloon
	local v81 = 2.5 ^ (v76 - 1) * 1500
	v79.CurrencyCost = math.floor(v81)
	v79.Multipliers = {
		{
			["type"] = v3.Event1MAttackSpeedMultiplier,
			["value"] = v78
		}
	}
	table.insert(v75, v79)
end
local v82 = {}
for v83 = 1, 8 do
	local v84 = (v83 * 0.1 + 1) * 100
	local v85 = math.floor(v84) / 100
	local v86 = {}
	local v87 = (v85 - 1) * 100
	v86.Text = ("+%*%% Attack Speed"):format((math.floor(v87)))
	v86.CurrencyType = v2.Event1MConfetti
	local v88 = 3 ^ (v83 - 1) * 800
	v86.CurrencyCost = math.floor(v88)
	v86.Multipliers = {
		{
			["type"] = v3.Event1MAttackSpeedMultiplier,
			["value"] = v85
		}
	}
	table.insert(v82, v86)
end
local v89 = {}
for v90 = 1, 12 do
	local v91 = v90 * 0.1
	local v92 = {}
	local v93 = v91 * 100
	v92.Text = ("+%*%% Slime Luck"):format((math.floor(v93)))
	v92.CurrencyType = v2.Event1MBalloon
	local v94 = 3 ^ (v90 - 1) * 3000
	v92.CurrencyCost = math.floor(v94)
	v92.Multipliers = {
		{
			["type"] = v3.Event1MSlimeLuck,
			["value"] = v91
		}
	}
	table.insert(v89, v92)
end
local v95 = {}
for v96 = 1, 8 do
	local v97 = v96 * 0.1
	local v98 = {}
	local v99 = v97 * 100
	v98.Text = ("+%*%% Slime Luck"):format((math.floor(v99)))
	v98.CurrencyType = v2.Event1MConfetti
	local v100 = 3.75 ^ (v96 - 1) * 200000000000000
	v98.CurrencyCost = math.floor(v100)
	v98.Multipliers = {
		{
			["type"] = v3.Event1MSlimeLuck,
			["value"] = v97
		}
	}
	table.insert(v95, v98)
end
local v101 = {}
for v102 = 1, 12 do
	local v103 = {
		["Text"] = ("+%* Spawn Cap"):format(v102),
		["CurrencyType"] = v2.Event1MBalloon
	}
	local v104 = 3 ^ (v102 - 1) * 7000
	v103.CurrencyCost = math.floor(v104)
	v103.Multipliers = {
		{
			["type"] = v3.Event1MSpawnCap,
			["value"] = v102
		}
	}
	table.insert(v101, v103)
end
local v105 = {}
for v106 = 1, 8 do
	local v107 = {
		["Text"] = ("+%* Spawn Cap"):format(v106),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v108 = 3.75 ^ (v106 - 1) * 2000000000
	v107.CurrencyCost = math.floor(v108)
	v107.Multipliers = {
		{
			["type"] = v3.Event1MSpawnCap,
			["value"] = v106
		}
	}
	table.insert(v105, v107)
end
local v109 = {}
for v110 = 1, 12 do
	local v111 = (v110 * 0.1 + 1) * 100
	local v112 = math.floor(v111) / 100
	local v113 = {}
	local v114 = (v112 - 1) * 100
	v113.Text = ("+%*%% Traits Luck"):format((math.floor(v114)))
	v113.CurrencyType = v2.Event1MBalloon
	local v115 = 2.5 ^ (v110 - 1) * 150000
	v113.CurrencyCost = math.floor(v115)
	v113.Multipliers = {
		{
			["type"] = v3.MillionaireTraitsLuckMultiplier,
			["value"] = v112
		}
	}
	table.insert(v109, v113)
end
local v116 = {}
for v117 = 1, 8 do
	local v118 = (v117 * 0.15 + 1) * 100
	local v119 = math.floor(v118) / 100
	local v120 = {}
	local v121 = (v119 - 1) * 100
	v120.Text = ("+%*%% Traits Luck"):format((math.floor(v121)))
	v120.CurrencyType = v2.Event1MConfetti
	local v122 = 3.5 ^ (v117 - 1) * 2000000000000
	v120.CurrencyCost = math.floor(v122)
	v120.Multipliers = {
		{
			["type"] = v3.MillionaireTraitsLuckMultiplier,
			["value"] = v119
		}
	}
	table.insert(v116, v120)
end
local v123 = {}
for v124 = 1, 8 do
	local v125 = v124 * 0.05
	local v126 = {}
	local v127 = v125 * 100
	v126.Text = ("-%*s Spawn Rate"):format(math.floor(v127) / 100)
	v126.CurrencyType = v2.Event1MBalloon
	local v128 = 3 ^ (v124 - 1) * 350000
	v126.CurrencyCost = math.floor(v128)
	v126.Multipliers = {
		{
			["type"] = v3.Event1MSpawnRate,
			["value"] = v125
		}
	}
	table.insert(v123, v126)
end
local v129 = {}
for v130 = 1, 35 do
	local v131 = v130 * 10
	local v132 = {
		["Text"] = ("+%* Rune Bulk"):format((v4.abbreviateComma(v131))),
		["CurrencyType"] = v2.Event1MBalloon
	}
	local v133 = 2.25 ^ (v130 - 1) * 15000
	v132.CurrencyCost = math.floor(v133)
	v132.Multipliers = {
		{
			["type"] = v3.Event1MRuneBulk,
			["value"] = v131
		}
	}
	table.insert(v129, v132)
end
local v134 = {}
for v135 = 1, 18 do
	local v136 = v135 * 15
	local v137 = {
		["Text"] = ("+%* Rune Bulk"):format((v4.abbreviateComma(v136))),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v138 = 2.5 ^ (v135 - 1) * 1800
	v137.CurrencyCost = math.floor(v138)
	v137.Multipliers = {
		{
			["type"] = v3.Event1MRuneBulk,
			["value"] = v136
		}
	}
	table.insert(v134, v137)
end
local v139 = {}
for v140 = 1, 18 do
	local v141 = v140 * 20
	local v142 = {
		["Text"] = ("+%* Rune Bulk"):format((v4.abbreviateComma(v141))),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v143 = 3 ^ (v140 - 1) * 200000000000
	v142.CurrencyCost = math.floor(v143)
	v142.Multipliers = {
		{
			["type"] = v3.Event1MRuneBulk,
			["value"] = v141
		}
	}
	table.insert(v139, v142)
end
local v144 = {}
for v145 = 1, 35 do
	local v146 = (v145 * 0.25 + 1) * 100
	local v147 = math.floor(v146) / 100
	local v148 = {
		["Text"] = ("x%* Rune Luck"):format((v4.abbreviateComma(v147))),
		["CurrencyType"] = v2.Event1MBalloon
	}
	local v149 = 2.4 ^ (v145 - 1) * 20000
	v148.CurrencyCost = math.floor(v149)
	v148.Multipliers = {
		{
			["type"] = v3.Event1MRuneLuckMultiplier,
			["value"] = v147
		}
	}
	table.insert(v144, v148)
end
local v150 = {}
for v151 = 1, 18 do
	local v152 = (v151 * 0.3 + 1) * 100
	local v153 = math.floor(v152) / 100
	local v154 = {
		["Text"] = ("x%* Rune Luck"):format((v4.abbreviateComma(v153))),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v155 = 2.75 ^ (v151 - 1) * 3000
	v154.CurrencyCost = math.floor(v155)
	v154.Multipliers = {
		{
			["type"] = v3.Event1MRuneLuckMultiplier,
			["value"] = v153
		}
	}
	table.insert(v150, v154)
end
local v156 = {}
for v157 = 1, 4 do
	local v158 = (v157 * 0.1 + 1) * 100
	local v159 = math.floor(v158) / 100
	local v160 = {}
	local v161 = (v159 - 1) * 100
	v160.Text = ("+%*%% Rune Open Speed"):format((math.floor(v161)))
	v160.CurrencyType = v2.Event1MBalloon
	local v162 = 3 ^ (v157 - 1) * 75000
	v160.CurrencyCost = math.floor(v162)
	v160.Multipliers = {
		{
			["type"] = v3.Event1MRuneOpenTimeMultiplier,
			["value"] = v159
		}
	}
	table.insert(v156, v160)
end
local v163 = {}
for v164 = 1, 4 do
	local v165 = (v164 * 0.1 + 1) * 100
	local v166 = math.floor(v165) / 100
	local v167 = {}
	local v168 = (v166 - 1) * 100
	v167.Text = ("+%*%% Rune Open Speed"):format((math.floor(v168)))
	v167.CurrencyType = v2.Event1MConfetti
	local v169 = 4 ^ (v164 - 1) * 200000000000
	v167.CurrencyCost = math.floor(v169)
	v167.Multipliers = {
		{
			["type"] = v3.Event1MRuneOpenTimeMultiplier,
			["value"] = v166
		}
	}
	table.insert(v163, v167)
end
local v170 = {}
for v171 = 1, 35 do
	local v172 = (v171 * 0.25 + 1) * 100
	local v173 = math.floor(v172) / 100
	local v174 = {
		["Text"] = ("x%* Confetti Multiplier"):format(v173),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v175 = 2.4 ^ (v171 - 1) * 7000
	v174.CurrencyCost = math.floor(v175)
	v174.Multipliers = {
		{
			["type"] = v3.ConfettiMultiplier,
			["value"] = v173
		}
	}
	table.insert(v170, v174)
end
local v176 = {}
for v177 = 1, 18 do
	local v178 = {
		["Text"] = ("+%* Confetti Base Value"):format(v177),
		["CurrencyType"] = v2.Event1MBalloon
	}
	local v179 = 2.5 ^ (v177 - 1) * 35000
	v178.CurrencyCost = math.floor(v179)
	v178.Multipliers = {
		{
			["type"] = v3.ConfettiBaseValue,
			["value"] = v177
		}
	}
	table.insert(v176, v178)
end
local v180 = {}
for v181 = 1, 12 do
	local v182 = {
		["Text"] = ("+%* Auto Confetti/s"):format(v181),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v183 = 3 ^ (v181 - 1) * 750
	v182.CurrencyCost = math.floor(v183)
	v182.Multipliers = {
		{
			["type"] = v3.ConfettiAutoClick,
			["value"] = v181
		}
	}
	table.insert(v180, v182)
end
local v184 = {}
for v185 = 1, 8 do
	local v186 = v185 * 0.04
	local v187 = {}
	local v188 = v186 * 100
	v187.Text = ("-%*s Click Speed"):format(math.floor(v188) / 100)
	v187.CurrencyType = v2.Event1MConfetti
	local v189 = 3.5 ^ (v185 - 1) * 1500
	v187.CurrencyCost = math.floor(v189)
	v187.Multipliers = {
		{
			["type"] = v3.ConfettiClickSpeed,
			["value"] = v186
		}
	}
	table.insert(v184, v187)
end
local v190 = {}
for v191 = 1, 8 do
	local v192 = v191 * 0.05
	local v193 = {}
	local v194 = v192 * 100
	v193.Text = ("+%*%% Critical Chance"):format((math.floor(v194)))
	v193.CurrencyType = v2.Event1MConfetti
	local v195 = 3.75 ^ (v191 - 1) * 7000
	v193.CurrencyCost = math.floor(v195)
	v193.Multipliers = {
		{
			["type"] = v3.ConfettiCriticalChance,
			["value"] = v192
		}
	}
	table.insert(v190, v193)
end
local v196 = {}
for v197 = 1, 8 do
	local v198 = v197 * 0.5
	local v199 = {}
	local v200 = v198 * 100
	v199.Text = ("x%* Critical Power"):format(math.floor(v200) / 100)
	v199.CurrencyType = v2.Event1MConfetti
	local v201 = 3.75 ^ (v197 - 1) * 14000
	v199.CurrencyCost = math.floor(v201)
	v199.Multipliers = {
		{
			["type"] = v3.ConfettiCriticalMultiplier,
			["value"] = v198
		}
	}
	table.insert(v196, v199)
end
local v202 = {}
for v203 = 1, 12 do
	local v204 = (v203 * 0.05 + 1) * 100
	local v205 = math.floor(v204) / 100
	local v206 = {
		["Text"] = ("x%* Gloop Drop Luck"):format(v205),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v207 = 3 ^ (v203 - 1) * 20000000000
	v206.CurrencyCost = math.floor(v207)
	v206.Multipliers = {
		{
			["type"] = v3.GloopCollectLuck,
			["value"] = v205
		}
	}
	table.insert(v202, v206)
end
local v208 = {}
for v209 = 1, 12 do
	local v210 = (v209 * 0.01 + 1) * 100
	local v211 = math.floor(v210) / 100
	local v212 = {
		["Text"] = ("x%* Currency Gain"):format(v211),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v213 = 3.5 ^ (v209 - 1) * 70000000000
	v212.CurrencyCost = math.floor(v213)
	v212.Multipliers = {
		{
			["type"] = v3.CurrencyGainMultiplier,
			["value"] = v211
		}
	}
	table.insert(v208, v212)
end
local v214 = {}
for v215 = 1, 8 do
	local v216 = (v215 * 0.01 + 1) * 100
	local v217 = math.floor(v216) / 100
	local v218 = {
		["Text"] = ("x%* Shard Multiplier"):format(v217),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v219 = 3.75 ^ (v215 - 1) * 200000000000
	v218.CurrencyCost = math.floor(v219)
	v218.Multipliers = {
		{
			["type"] = v3.ShardMultiplier,
			["value"] = v217
		}
	}
	table.insert(v214, v218)
end
local v220 = {}
for v221 = 1, 12 do
	local v222 = (v221 * 0.042 + 1) * 100
	local v223 = math.floor(v222) / 100
	local v224 = {
		["Text"] = ("x%* Rebirth Multiplier"):format(v223),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v225 = 3 ^ (v221 - 1) * 20000000000
	v224.CurrencyCost = math.floor(v225)
	v224.Multipliers = {
		{
			["type"] = v3.RebirthMultiplier,
			["value"] = v223
		}
	}
	table.insert(v220, v224)
end
local v226 = {}
for v227 = 1, 8 do
	local v228 = v227 * 5
	local v229 = {
		["Text"] = ("+%*s Ice World Duration"):format(v228),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v230 = 3.5 ^ (v227 - 1) * 70000000000
	v229.CurrencyCost = math.floor(v230)
	v229.Multipliers = {
		{
			["type"] = v3.IceWorldDuration,
			["value"] = v228
		}
	}
	table.insert(v226, v229)
end
local v231 = {}
for v232 = 1, 12 do
	local v233 = (v232 * 0.042 + 1) * 100
	local v234 = math.floor(v233) / 100
	local v235 = {
		["Text"] = ("x%* Coins Multiplier"):format(v234),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v236 = 3 ^ (v232 - 1) * 200000000000
	v235.CurrencyCost = math.floor(v236)
	v235.Multipliers = {
		{
			["type"] = v3.CoinsMultiplier,
			["value"] = v234
		}
	}
	table.insert(v231, v235)
end
local v237 = {}
for v238 = 1, 10 do
	local v239 = (v238 * 0.01 + 1) * 100
	local v240 = math.floor(v239) / 100
	local v241 = {
		["Text"] = ("x%* Skill XP Multiplier"):format(v240),
		["CurrencyType"] = v2.Event1MConfetti
	}
	local v242 = 3.75 ^ (v238 - 1) * 700000000000
	v241.CurrencyCost = math.floor(v242)
	v241.Multipliers = {
		{
			["type"] = v3.SkillXPMultiplier,
			["value"] = v240
		}
	}
	table.insert(v237, v241)
end
local v243 = {}
for v244 = 1, 10 do
	local v245 = v244 * 0.02 * 100
	local v246 = math.floor(v245) / 100
	local v247 = {}
	local v248 = v246 * 100
	v247.Text = ("+%*%% Event Star Drop Chance"):format((math.floor(v248)))
	v247.CurrencyType = v2.Event1MConfetti
	local v249 = 4 ^ (v244 - 1) * 1e21
	v247.CurrencyCost = math.floor(v249)
	v247.Multipliers = {
		{
			["type"] = v3.Event1MStarDropChance,
			["value"] = v246
		}
	}
	table.insert(v243, v247)
end
local v250 = {
	{
		["Title"] = "Balloon Fortune",
		["Color"] = v5,
		["IgnoreAscend"] = true,
		["Levels"] = v11
	}
}
local v251 = {
	["Title"] = "Balloon Fortune II",
	["Requires"] = {
		["nodes"] = { "4-1" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true,
	["Levels"] = v17
}
v250[2] = v251
local v252 = {
	["Title"] = "Lucky Slimes",
	["Requires"] = {
		["nodes"] = { "4-2" }
	},
	["Color"] = v8,
	["IgnoreAscend"] = true,
	["Levels"] = v89
}
v250[3] = v252
local v253 = {
	["Title"] = "Party Punch",
	["Requires"] = {
		["nodes"] = { "4-2" }
	},
	["Color"] = v6,
	["IgnoreAscend"] = true,
	["Levels"] = v41
}
v250[4] = v253
local v254 = {
	["Title"] = "Wide Celebration",
	["Requires"] = {
		["nodes"] = { "4-4" }
	},
	["Color"] = v6,
	["IgnoreAscend"] = true,
	["Levels"] = v65
}
v250[5] = v254
local v255 = {
	["Title"] = "Quick Pops",
	["Requires"] = {
		["nodes"] = { "4-4" }
	},
	["Color"] = v6,
	["IgnoreAscend"] = true,
	["Levels"] = v75
}
v250[6] = v255
local v256 = {
	["Title"] = "Party Punch II",
	["Requires"] = {
		["nodes"] = { "4-6" }
	},
	["Color"] = v6,
	["IgnoreAscend"] = true,
	["Levels"] = v47
}
v250[7] = v256
local v257 = {
	["Title"] = "Crowd Control",
	["Requires"] = {
		["nodes"] = { "4-5", "4-6" }
	},
	["Color"] = v8,
	["IgnoreAscend"] = true,
	["Levels"] = v101
}
v250[8] = v257
local v258 = {
	["Title"] = "Rune Rush",
	["Requires"] = {
		["nodes"] = { "4-8" }
	},
	["Color"] = v7,
	["IgnoreAscend"] = true,
	["Levels"] = v129
}
v250[9] = v258
local v259 = {
	["Title"] = "Rune Fortune",
	["Requires"] = {
		["nodes"] = { "4-9" }
	},
	["Color"] = v7,
	["IgnoreAscend"] = true,
	["Levels"] = v144
}
v250[10] = v259
local v260 = {
	["Title"] = "Rune Haste",
	["Requires"] = {
		["nodes"] = { "4-10" }
	},
	["Color"] = v7,
	["IgnoreAscend"] = true,
	["Levels"] = v156
}
v250[11] = v260
local v261 = {
	["Title"] = "Balloon Fortune III",
	["Requires"] = {
		["nodes"] = { "4-11" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true,
	["Levels"] = v23
}
v250[12] = v261
local v262 = {
	["Title"] = "Trait Fortune",
	["Requires"] = {
		["nodes"] = { "4-12" }
	},
	["Color"] = v8,
	["IgnoreAscend"] = true,
	["Levels"] = v109
}
v250[13] = v262
local v263 = {
	["Title"] = "Rapid Spawns",
	["Requires"] = {
		["nodes"] = { "4-13" }
	},
	["Color"] = v8,
	["IgnoreAscend"] = true,
	["Levels"] = v123
}
v250[14] = v263
local v264 = {
	["Title"] = "Party Punch III",
	["Requires"] = {
		["nodes"] = { "4-14" }
	},
	["Color"] = v6,
	["IgnoreAscend"] = true,
	["Levels"] = v53
}
v250[15] = v264
local v265 = {
	["Title"] = "Quick Pops II",
	["Requires"] = {
		["nodes"] = { "4-15" }
	},
	["Color"] = v6,
	["IgnoreAscend"] = true,
	["Levels"] = v82
}
v250[16] = v265
local v266 = {
	["Title"] = "Rune Rush II",
	["Requires"] = {
		["nodes"] = { "4-16" }
	},
	["Color"] = v7,
	["IgnoreAscend"] = true,
	["Levels"] = v134
}
v250[17] = v266
local v267 = {
	["Title"] = "Rune Fortune II",
	["Requires"] = {
		["nodes"] = { "4-17" }
	},
	["Color"] = v7,
	["IgnoreAscend"] = true,
	["Levels"] = v150
}
v250[18] = v267
local v268 = {
	["Title"] = "Confetti Power",
	["Requires"] = {
		["nodes"] = { "4-18" }
	},
	["Color"] = v9,
	["IgnoreAscend"] = true,
	["Levels"] = v170
}
v250[19] = v268
local v269 = {
	["Title"] = "Balloon Fortune IV",
	["Requires"] = {
		["nodes"] = { "4-19" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true,
	["Levels"] = v29
}
v250[20] = v269
local v270 = {
	["Title"] = "Gloop Hunter",
	["Requires"] = {
		["nodes"] = { "4-20" }
	},
	["Color"] = v10,
	["IgnoreAscend"] = true,
	["Levels"] = v202
}
v250[21] = v270
local v271 = {
	["Title"] = "Currency Surge",
	["Requires"] = {
		["nodes"] = { "4-21" }
	},
	["Color"] = v10,
	["IgnoreAscend"] = true,
	["Levels"] = v208
}
v250[22] = v271
local v272 = {
	["Title"] = "Shard Boost",
	["Requires"] = {
		["nodes"] = { "4-22" }
	},
	["Color"] = v10,
	["IgnoreAscend"] = true,
	["Levels"] = v214
}
v250[23] = v272
local v273 = {
	["Title"] = "Rebirth Boost",
	["Requires"] = {
		["nodes"] = { "4-20" }
	},
	["Color"] = v10,
	["IgnoreAscend"] = true,
	["Levels"] = v220
}
v250[24] = v273
local v274 = {
	["Title"] = "Ice World Duration",
	["Requires"] = {
		["nodes"] = { "4-24" }
	},
	["Color"] = v10,
	["IgnoreAscend"] = true,
	["Levels"] = v226
}
v250[25] = v274
local v275 = {
	["Title"] = "Coin Shower",
	["Requires"] = {
		["nodes"] = { "4-25" }
	},
	["Color"] = v10,
	["IgnoreAscend"] = true,
	["Levels"] = v231
}
v250[26] = v275
local v276 = {
	["Title"] = "Knowledge Boost",
	["Requires"] = {
		["nodes"] = { "4-26" }
	},
	["Color"] = v10,
	["IgnoreAscend"] = true,
	["Levels"] = v237
}
v250[27] = v276
local v277 = {
	["Title"] = "Confetti Amplifier",
	["Requires"] = {
		["nodes"] = { "4-8" }
	},
	["Color"] = v9,
	["IgnoreAscend"] = true,
	["Levels"] = v176
}
v250[28] = v277
local v278 = {
	["Title"] = "Auto Confetti",
	["Requires"] = {
		["nodes"] = { "4-28" }
	},
	["Color"] = v9,
	["IgnoreAscend"] = true,
	["Levels"] = v180
}
v250[29] = v278
local v279 = {
	["Title"] = "Quick Clicks",
	["Requires"] = {
		["nodes"] = { "4-29" }
	},
	["Color"] = v9,
	["IgnoreAscend"] = true,
	["Levels"] = v184
}
v250[30] = v279
local v280 = {
	["Title"] = "Critical Confetti",
	["Requires"] = {
		["nodes"] = { "4-30" }
	},
	["Color"] = v9,
	["IgnoreAscend"] = true,
	["Levels"] = v190
}
v250[31] = v280
local v281 = {
	["Title"] = "Critical Power",
	["Requires"] = {
		["nodes"] = { "4-31" }
	},
	["Color"] = v9,
	["IgnoreAscend"] = true,
	["Levels"] = v196
}
v250[32] = v281
local v282 = {
	["Title"] = "Crowd Control II",
	["Requires"] = {
		["nodes"] = { "4-32" }
	},
	["Color"] = v8,
	["IgnoreAscend"] = true,
	["Levels"] = v105
}
v250[33] = v282
local v283 = {
	["Title"] = "Wide Celebration II",
	["Requires"] = {
		["nodes"] = { "4-33" }
	},
	["Color"] = v6,
	["IgnoreAscend"] = true,
	["Levels"] = v70
}
v250[34] = v283
local v284 = {
	["Title"] = "Rune Rush III",
	["Requires"] = {
		["nodes"] = { "4-34" }
	},
	["Color"] = v7,
	["IgnoreAscend"] = true,
	["Levels"] = v139
}
v250[35] = v284
local v285 = {
	["Title"] = "Rune Haste II",
	["Requires"] = {
		["nodes"] = { "4-35" }
	},
	["Color"] = v7,
	["IgnoreAscend"] = true,
	["Levels"] = v163
}
v250[36] = v285
local v286 = {
	["Title"] = "Trait Fortune II",
	["Requires"] = {
		["nodes"] = { "4-36" }
	},
	["Color"] = v8,
	["IgnoreAscend"] = true,
	["Levels"] = v116
}
v250[37] = v286
local v287 = {
	["Title"] = "Party Punch IV",
	["Requires"] = {
		["nodes"] = { "4-37" }
	},
	["Color"] = v6,
	["IgnoreAscend"] = true,
	["Levels"] = v59
}
v250[38] = v287
local v288 = {
	["Title"] = "Lucky Slimes II",
	["Requires"] = {
		["nodes"] = { "4-38" }
	},
	["Color"] = v8,
	["IgnoreAscend"] = true,
	["Levels"] = v95
}
v250[39] = v288
local v289 = {
	["Title"] = "Balloon Mastery",
	["Requires"] = {
		["nodes"] = { "4-39" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true,
	["Levels"] = v35
}
v250[40] = v289
local v290 = {
	["Title"] = "Event Star Drop Chance",
	["Requires"] = {
		["nodes"] = { "4-40" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true,
	["Levels"] = v243
}
v250[41] = v290
return v250]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UpgradeTree4]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3996"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v4 = Color3.fromRGB(255, 150, 200)
local v5 = Color3.fromRGB(255, 100, 80)
local v6 = Color3.fromRGB(80, 200, 120)
local v7 = Color3.fromRGB(160, 120, 255)
local v8 = Color3.fromRGB(80, 220, 220)
local v9 = Color3.fromRGB(255, 200, 50)
local v10 = {}
for v11 = 1, 999 do
	local v12 = (v11 * 0.005 + 1) * 1000
	local v13 = math.floor(v12) / 1000
	local v14 = {
		["Text"] = ("x%* Candy Coins"):format(v13),
		["CurrencyType"] = v2.CandyCoins
	}
	local v15 = 1.06 ^ (v11 - 1) * 100000
	v14.CurrencyCost = math.floor(v15)
	v14.Multipliers = {
		{
			["type"] = v3.CandyCoinsMultiplier,
			["value"] = v13
		}
	}
	table.insert(v10, v14)
end
local v16 = {}
for v17 = 1, 15 do
	local v18 = {
		["Text"] = ("+%* Damage"):format(v17),
		["CurrencyType"] = v2.CandyCoins
	}
	local v19 = 1.6 ^ (v17 - 1) * 1000000
	v18.CurrencyCost = math.floor(v19)
	v18.Multipliers = {
		{
			["type"] = v3.Damage,
			["value"] = v17
		}
	}
	table.insert(v16, v18)
end
local v20 = {}
for v21 = 1, 10 do
	local v22 = {
		["Text"] = ("+%* Spawn Cap"):format(v21),
		["CurrencyType"] = v2.CandyCoins
	}
	local v23 = 1.7 ^ (v21 - 1) * 750000
	v22.CurrencyCost = math.floor(v23)
	v22.Multipliers = {
		{
			["type"] = v3.World5SpawnCap,
			["value"] = v21
		}
	}
	table.insert(v20, v22)
end
local v24 = {}
for v25 = 1, 10 do
	local v26 = v25 * 0.005
	local v27 = {}
	local v28 = v26 * 1000
	v27.Text = ("+%*%% Crit Chance"):format(math.floor(v28) / 10)
	v27.CurrencyType = v2.CandyCoins
	local v29 = 1.7 ^ (v25 - 1) * 5000000
	v27.CurrencyCost = math.floor(v29)
	v27.Multipliers = {
		{
			["type"] = v3.CriticalHitChance,
			["value"] = v26
		}
	}
	table.insert(v24, v27)
end
local v30 = {}
for v31 = 1, 10 do
	local v32 = (v31 * 0.01 + 1) * 100
	local v33 = math.floor(v32) / 100
	local v34 = {
		["Text"] = ("x%* Damage Multiplier"):format(v33),
		["CurrencyType"] = v2.CandyCoins
	}
	local v35 = 1.65 ^ (v31 - 1) * 3000000
	v34.CurrencyCost = math.floor(v35)
	v34.Multipliers = {
		{
			["type"] = v3.DamageMultiplier,
			["value"] = v33
		}
	}
	table.insert(v30, v34)
end
local v36 = {}
for v37 = 1, 8 do
	local v38 = v37 * 0.015
	local v39 = {}
	local v40 = v38 * 1000
	v39.Text = ("-%*s Spawn Rate"):format(math.floor(v40) / 1000)
	v39.CurrencyType = v2.CandyCoins
	local v41 = 1.8 ^ (v37 - 1) * 100000000000
	v39.CurrencyCost = math.floor(v41)
	v39.Multipliers = {
		{
			["type"] = v3.World5SpawnRate,
			["value"] = v38
		}
	}
	table.insert(v36, v39)
end
local v42 = {}
for v43 = 1, 10 do
	local v44 = (v43 * 0.01 + 1) * 100
	local v45 = math.floor(v44) / 100
	local v46 = {
		["Text"] = ("x%* Pet XP"):format(v45),
		["CurrencyType"] = v2.CandyCoins
	}
	local v47 = 1.75 ^ (v43 - 1) * 200000000000
	v46.CurrencyCost = math.floor(v47)
	v46.Multipliers = {
		{
			["type"] = v3.PetXPMultiplier,
			["value"] = v45
		}
	}
	table.insert(v42, v46)
end
local v48 = {}
for v49 = 1, 8 do
	local v50 = (v49 * 0.01 + 1) * 100
	local v51 = math.floor(v50) / 100
	local v52 = {
		["Text"] = ("x%* Crit Multiplier"):format(v51),
		["CurrencyType"] = v2.CandyCoins
	}
	local v53 = 1.8 ^ (v49 - 1) * 400000000000
	v52.CurrencyCost = math.floor(v53)
	v52.Multipliers = {
		{
			["type"] = v3.CriticalHitMultiplier,
			["value"] = v51
		}
	}
	table.insert(v48, v52)
end
local v54 = {}
for v55 = 1, 8 do
	local v56 = v55 * 0.005
	local v57 = {}
	local v58 = v56 * 1000
	v57.Text = ("-%*s Spawn Rate"):format(math.floor(v58) / 1000)
	v57.CurrencyType = v2.CandyCoins
	local v59 = 1.75 ^ (v55 - 1) * 300000000000
	v57.CurrencyCost = math.floor(v59)
	v57.Multipliers = {
		{
			["type"] = v3.World5SpawnRate,
			["value"] = v56
		}
	}
	table.insert(v54, v57)
end
local v60 = {}
for v61 = 1, 5 do
	local v62 = v61 * 0.15
	local v63 = {}
	local v64 = v62 * 100
	v63.Text = ("+%* Attack Range"):format(math.floor(v64) / 100)
	v63.CurrencyType = v2.CandyCoins
	local v65 = 2.2 ^ (v61 - 1) * 1000000000000
	v63.CurrencyCost = math.floor(v65)
	v63.Multipliers = {
		{
			["type"] = v3.World5AttackRange,
			["value"] = v62
		}
	}
	table.insert(v60, v63)
end
local v66 = {}
for v67 = 1, 8 do
	local v68 = v67 * 0.5
	local v69 = {}
	local v70 = v68 * 100
	v69.Text = ("+%*%% Slime Luck"):format((math.floor(v70)))
	v69.CurrencyType = v2.CandyCoins
	local v71 = 1.9 ^ (v67 - 1) * 100000000000
	v69.CurrencyCost = math.floor(v71)
	v69.Multipliers = {
		{
			["type"] = v3.World5SlimeLuck,
			["value"] = v68
		}
	}
	table.insert(v66, v69)
end
local v72 = {}
for v73 = 1, 8 do
	local v74 = (v73 * 0.01 + 1) * 100
	local v75 = math.floor(v74) / 100
	local v76 = {
		["Text"] = ("x%* Pet Damage"):format(v75),
		["CurrencyType"] = v2.CandyCoins
	}
	local v77 = 1.85 ^ (v73 - 1) * 5000000000000
	v76.CurrencyCost = math.floor(v77)
	v76.Multipliers = {
		{
			["type"] = v3.PetDamagePercentMultiplier,
			["value"] = v75
		}
	}
	table.insert(v72, v76)
end
local v78 = {}
for v79 = 1, 20 do
	local v80 = v79 * 2
	local v81 = {
		["Text"] = ("+%* Rune Bulk"):format(v80),
		["CurrencyType"] = v2.CandyCoins
	}
	local v82 = 1.7 ^ (v79 - 1) * 10000000000000
	v81.CurrencyCost = math.floor(v82)
	v81.Multipliers = {
		{
			["type"] = v3.RuneBulk,
			["value"] = v80
		}
	}
	table.insert(v78, v81)
end
local v83 = {}
for v84 = 1, 15 do
	local v85 = v84 * 0.3
	local v86 = {}
	local v87 = v85 * 10
	v86.Text = ("+%* Rune Luck"):format(math.floor(v87) / 10)
	v86.CurrencyType = v2.CandyCoins
	local v88 = 1.8 ^ (v84 - 1) * 20000000000000
	v86.CurrencyCost = math.floor(v88)
	v86.Multipliers = {
		{
			["type"] = v3.RuneLuck,
			["value"] = v85
		}
	}
	table.insert(v83, v86)
end
local v89 = {}
for v90 = 1, 5 do
	local v91 = v90 * 0.2
	local v92 = {}
	local v93 = v91 * 10
	v92.Text = ("+%* Pet Roll Luck"):format(math.floor(v93) / 10)
	v92.CurrencyType = v2.CandyCoins
	local v94 = 2.5 ^ (v90 - 1) * 50000000000000
	v92.CurrencyCost = math.floor(v94)
	v92.Multipliers = {
		{
			["type"] = v3.PetRollLuck,
			["value"] = v91
		}
	}
	table.insert(v89, v92)
end
local v95 = {}
for v96 = 1, 15 do
	local v97 = (v96 * 0.005 + 1) * 1000
	local v98 = math.floor(v97) / 1000
	local v99 = {
		["Text"] = ("x%* Candy Coins"):format(v98),
		["CurrencyType"] = v2.CandyCoins
	}
	local v100 = 1.6 ^ (v96 - 1) * 500000000000000
	v99.CurrencyCost = math.floor(v100)
	v99.Multipliers = {
		{
			["type"] = v3.CandyCoinsMultiplier,
			["value"] = v98
		}
	}
	table.insert(v95, v99)
end
local v101 = {}
for v102 = 1, 5 do
	local v103 = (v102 * 0.02 + 1) * 100
	local v104 = math.floor(v103) / 100
	local v105 = {
		["Text"] = ("x%* Rune Open Speed"):format(v104),
		["CurrencyType"] = v2.CandyCoins
	}
	local v106 = 2.5 ^ (v102 - 1) * 1000000000000000
	v105.CurrencyCost = math.floor(v106)
	v105.Multipliers = {
		{
			["type"] = v3.RuneOpenTimeMultiplier,
			["value"] = v104
		}
	}
	table.insert(v101, v105)
end
local v107 = {}
for v108 = 1, 8 do
	local v109 = v108 * 0.01
	local v110 = {}
	local v111 = v109 * 100
	v110.Text = ("+%*%% Combo Multiplier"):format((math.floor(v111)))
	v110.CurrencyType = v2.CandyCoins
	local v112 = 1.9 ^ (v108 - 1) * 2000000000000000
	v110.CurrencyCost = math.floor(v112)
	v110.Multipliers = {
		{
			["type"] = v3.ComboMultiplier,
			["value"] = v109
		}
	}
	table.insert(v107, v110)
end
local v113 = {}
for v114 = 1, 5 do
	local v115 = {
		["Text"] = ("+%* Currency Gain"):format(v114),
		["CurrencyType"] = v2.CandyCoins
	}
	local v116 = 2.8 ^ (v114 - 1) * 1e16
	v115.CurrencyCost = math.floor(v116)
	v115.Multipliers = {
		{
			["type"] = v3.CurrencyGain,
			["value"] = v114
		}
	}
	table.insert(v113, v115)
end
local v117 = {}
for v118 = 1, 10 do
	local v119 = (v118 * 0.01 + 1) * 100
	local v120 = math.floor(v119) / 100
	local v121 = {
		["Text"] = ("x%* Candy Coins"):format(v120),
		["CurrencyType"] = v2.CandyCoins
	}
	local v122 = 3 ^ (v118 - 1) * 5e16
	v121.CurrencyCost = math.floor(v122)
	v121.Multipliers = {
		{
			["type"] = v3.CandyCoinsMultiplier,
			["value"] = v120
		}
	}
	table.insert(v117, v121)
end
local v123 = {
	{
		["Title"] = "Candy Fortune",
		["Color"] = v4,
		["IgnoreAscend"] = true,
		["Levels"] = v10
	}
}
local v124 = {
	["Title"] = "Sweet Strikes",
	["Requires"] = {
		["nodes"] = { "5-1" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true,
	["Levels"] = v16
}
v123[2] = v124
local v125 = {
	["Title"] = "Sugar Spawns",
	["Requires"] = {
		["nodes"] = { "5-2" }
	},
	["Color"] = v6,
	["IgnoreAscend"] = true,
	["Levels"] = v20
}
v123[3] = v125
local v126 = {
	["Title"] = "Candy Crit",
	["Requires"] = {
		["nodes"] = { "5-2" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true,
	["Levels"] = v24
}
v123[4] = v126
local v127 = {
	["Title"] = "Battle Candy",
	["Requires"] = {
		["nodes"] = { "5-2" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true,
	["Levels"] = v30
}
v123[5] = v127
local v128 = {
	["Title"] = "Quick Spawn",
	["Requires"] = {
		["nodes"] = { "5-5" }
	},
	["Color"] = v6,
	["IgnoreAscend"] = true,
	["Levels"] = v36
}
v123[6] = v128
local v129 = {
	["Title"] = "Pet Vigor",
	["Requires"] = {
		["nodes"] = { "5-6" }
	},
	["Color"] = v8,
	["IgnoreAscend"] = true,
	["Levels"] = v42
}
v123[7] = v129
local v130 = {
	["Title"] = "Crit Power",
	["Requires"] = {
		["nodes"] = { "5-7" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true,
	["Levels"] = v48
}
v123[8] = v130
local v131 = {
	["Title"] = "Sugar Rush",
	["Requires"] = {
		["nodes"] = { "5-6" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true,
	["Levels"] = v54
}
v123[9] = v131
local v132 = {
	["Title"] = "Extended Reach",
	["Requires"] = {
		["nodes"] = { "5-9" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true,
	["Levels"] = v60
}
v123[10] = v132
local v133 = {
	["Title"] = "Spawn Luck",
	["Requires"] = {
		["nodes"] = { "5-6" }
	},
	["Color"] = v6,
	["IgnoreAscend"] = true,
	["Levels"] = v66
}
v123[11] = v133
local v134 = {
	["Title"] = "Pet Power",
	["Requires"] = {
		["nodes"] = { "5-11" }
	},
	["Color"] = v8,
	["IgnoreAscend"] = true,
	["Levels"] = v72
}
v123[12] = v134
local v135 = {
	["Title"] = "Rune Fortune",
	["Requires"] = {
		["nodes"] = { "5-12" }
	},
	["Color"] = v7,
	["IgnoreAscend"] = true,
	["Levels"] = v78
}
v123[13] = v135
local v136 = {
	["Title"] = "Rune Mastery",
	["Requires"] = {
		["nodes"] = { "5-13" }
	},
	["Color"] = v7,
	["IgnoreAscend"] = true,
	["Levels"] = v83
}
v123[14] = v136
local v137 = {
	["Title"] = "Pet Roll",
	["Requires"] = {
		["nodes"] = { "5-13" }
	},
	["Color"] = v8,
	["IgnoreAscend"] = true,
	["Levels"] = v89
}
v123[15] = v137
local v138 = {
	["Title"] = "Candy Coins II",
	["Requires"] = {
		["nodes"] = { "5-12" }
	},
	["Color"] = v4,
	["IgnoreAscend"] = true,
	["Levels"] = v95
}
v123[16] = v138
local v139 = {
	["Title"] = "Rune Speed",
	["Requires"] = {
		["nodes"] = { "5-16" }
	},
	["Color"] = v7,
	["IgnoreAscend"] = true,
	["Levels"] = v101
}
v123[17] = v139
local v140 = {
	["Title"] = "Combo Power",
	["Requires"] = {
		["nodes"] = { "5-16" }
	},
	["Color"] = v5,
	["IgnoreAscend"] = true,
	["Levels"] = v107
}
v123[18] = v140
local v141 = {
	["Title"] = "Currency Flow",
	["Requires"] = {
		["nodes"] = { "5-18", "5-15" }
	},
	["Color"] = v4,
	["IgnoreAscend"] = true,
	["Levels"] = v113
}
v123[19] = v141
local v142 = {
	["Title"] = "Grand Fortune",
	["Requires"] = {
		["nodes"] = { "5-19" }
	},
	["Color"] = v9,
	["IgnoreAscend"] = true,
	["Levels"] = v117
}
v123[20] = v142
return v123]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UpgradeTree5]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3997"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

game:GetService("Players")
local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
game:GetService("ServerScriptService")
require(v1.Enums.CurrencyTypes)
require(v1.Enums.MultiplierTypes)
require(v1.Utility.Format)
return {}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Formulas]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3998"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	[1] = {
		["Luck"] = 2,
		["Timer"] = 900
	},
	[2] = {
		["Luck"] = 4,
		["Timer"] = 900
	},
	[4] = {
		["Luck"] = 8,
		["Timer"] = 900
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ServerLuckData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3999"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	[0] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(165, 165, 165)), ColorSequenceKeypoint.new(1, Color3.fromRGB(110, 110, 110)) })
	},
	[1] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 255, 131)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 85)) })
	},
	[2] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(99, 245, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 134, 218)) })
	},
	[3] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 80, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(111, 33, 163)) })
	},
	[4] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 240, 109)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 174, 52)) })
	},
	[5] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 158, 67)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 174, 24)) })
	},
	[6] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 78, 78)), ColorSequenceKeypoint.new(1, Color3.fromRGB(204, 35, 35)) })
	},
	[7] = {
		["Gradient"] = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 107, 107)),
			ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 178, 100)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(78, 190, 255)),
			ColorSequenceKeypoint.new(0.75, Color3.fromRGB(109, 255, 109)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(184, 84, 255))
		}),
		["Animated"] = true
	},
	[8] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
		["Animated"] = true
	},
	[9] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 87, 87)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 209, 41)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 77, 0)) }),
		["Animated"] = true
	},
	[10] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 225)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(69, 137, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 217)) }),
		["Animated"] = true
	},
	[11] = {
		["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(133, 255, 80)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(66, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 82, 255)) }),
		["Animated"] = true
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TierData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4000"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	2,
	4,
	6,
	8,
	10
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[IndexToMultiplier]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4001"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = {}
local v4 = {
	["Perk"] = "2x Coins",
	["Text"] = "2x Coins for %s",
	["Icon"] = "rbxassetid://137385384245893",
	["Duration"] = 240,
	["Chance"] = 100,
	["Multipliers"] = {
		{
			["multiplier"] = v2.CoinsMultiplier,
			["amount"] = 2
		}
	}
}
v3.BUFF_1 = v4
local v5 = {
	["Perk"] = "2x Damage",
	["Text"] = "2x Damage for %s",
	["Icon"] = "rbxassetid://106746371164727",
	["Duration"] = 240,
	["Chance"] = 100,
	["Multipliers"] = {
		{
			["multiplier"] = v2.DamageMultiplier,
			["amount"] = 2
		}
	}
}
v3.BUFF_2 = v5
local v6 = {
	["Perk"] = "2x Rebirth",
	["Text"] = "2x Rebirth for %s",
	["Icon"] = "rbxassetid://87974431889658",
	["Duration"] = 240,
	["Chance"] = 100,
	["Multipliers"] = {
		{
			["multiplier"] = v2.RebirthMultiplier,
			["amount"] = 2
		}
	}
}
v3.BUFF_3 = v6
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LuckyBlockData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4002"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("ServerScriptService")
local v_u_4 = require(v_u_1.Enums.StatisticTypes)
local v_u_5 = require(v_u_1.Packages.Observers)
local v_u_6 = require(v_u_1.Utility.Spring)
local function v_u_8()
	local v7 = Instance.new("Beam")
	v7.Brightness = 2.1
	v7.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
	v7.Texture = "rbxassetid://86357734011375"
	v7.LightEmission = 0
	v7.LightInfluence = 0
	v7.TextureLength = 5
	v7.TextureMode = Enum.TextureMode.Static
	v7.TextureSpeed = -1
	v7.Transparency = NumberSequence.new(0, 1)
	v7.FaceCamera = true
	v7.Width0 = 3
	v7.Width1 = 3
	return v7
end
local v_u_9 = workspace:WaitForChild("Persistent"):WaitForChild("Onboarding")
local v_u_10 = v_u_1:WaitForChild("Assets"):WaitForChild("OnboardingAttachment")
local v_u_11 = v_u_10:WaitForChild("BillboardGui")
local function v_u_13(p_u_12)
	-- upvalues: (copy) v_u_6
	v_u_6.target(p_u_12, 0.5, 5, {
		["Position"] = UDim2.fromScale(0.5, 0.5)
	})
	task.delay(0.1, function()
		-- upvalues: (ref) v_u_6, (copy) p_u_12
		v_u_6.target(p_u_12, 1, 5, {
			["Position"] = UDim2.fromScale(0.5, 0.636)
		})
	end)
end
local v54 = {
	{
		["Step"] = 1,
		["OnboardingName"] = "Defeat a Slime",
		["Goal"] = 1,
		["Title"] = function() end,
		["Client"] = function(_)
			-- upvalues: (copy) v_u_1, (copy) v_u_9, (copy) v_u_8, (copy) v_u_11, (copy) v_u_5, (copy) v_u_10, (copy) v_u_13, (copy) v_u_2, (copy) v_u_6
			local v_u_14 = require(v_u_1.Client.Gameplay.Sllimes.SlimeSpawnerController)
			local v15 = require(v_u_1.Utility.UI)
			local v16 = require(v_u_1.Utility.ZoneUtil)
			local v_u_17 = v15:get("Persistent", "Onboarding"):WaitForChild("Frame")
			v_u_17.Title.Text = "Walk into the zone"
			local v_u_18 = Instance.new("Attachment")
			v_u_18.Parent = v_u_9:WaitForChild("Zone")
			local v_u_19 = v_u_8()
			v_u_19.Parent = v_u_18.Parent
			v_u_19.Attachment0 = v_u_18
			local v_u_20 = nil
			v_u_11.Size = UDim2.fromScale(4, 4)
			local v_u_24 = v_u_5.observeCharacter(function(p21, p22)
				-- upvalues: (ref) v_u_20, (copy) v_u_19
				if p21 == game.Players.LocalPlayer then
					if v_u_20 then
						v_u_20:Destroy()
						v_u_20 = nil
					end
					local v23 = p22:WaitForChild("HumanoidRootPart")
					if v23 then
						v_u_20 = Instance.new("Attachment")
						v_u_20.Parent = v23
						v_u_19.Attachment1 = v_u_20
					end
				end
			end)
			local v_u_25 = nil
			local v_u_29 = v16.observe("SLIME_ZONE", function()
				-- upvalues: (copy) v_u_17, (ref) v_u_10, (ref) v_u_11, (ref) v_u_13, (ref) v_u_2, (copy) v_u_14, (ref) v_u_6, (copy) v_u_18, (ref) v_u_9
				v_u_17.Title.Text = "Defeat a slime!"
				v_u_10.Parent = workspace
				v_u_11.Enabled = true
				v_u_13(v_u_17.Title)
				local v_u_26 = nil
				local v_u_28 = v_u_2.Heartbeat:Connect(function(_)
					-- upvalues: (ref) v_u_14, (ref) v_u_26, (ref) v_u_6, (ref) v_u_10, (ref) v_u_18, (ref) v_u_11
					local v27 = v_u_14:getClosestSlime()
					if v27 and (not v_u_26 or v27.uid ~= v_u_26.uid) then
						v_u_26 = v27
						v_u_6.target(v_u_10, 1, 5, {
							["CFrame"] = CFrame.new(v27.position)
						})
						v_u_18.CFrame = CFrame.new(v27.position)
						v_u_18.Parent = workspace
					end
					if v_u_26 then
						v_u_11.Enabled = not v_u_14:isInRange(v_u_26.position)
					end
				end)
				return function()
					-- upvalues: (ref) v_u_28, (ref) v_u_13, (ref) v_u_17, (ref) v_u_11, (ref) v_u_10, (ref) v_u_18, (ref) v_u_9
					if v_u_28 then
						v_u_28:Disconnect()
						v_u_28 = nil
					end
					v_u_13(v_u_17.Title)
					v_u_11.Enabled = false
					v_u_10.Parent = script
					v_u_18.CFrame = CFrame.new()
					v_u_18.Parent = v_u_9:WaitForChild("Zone")
					v_u_17.Title.Text = "Walk into the zone"
				end
			end)
			return function()
				-- upvalues: (copy) v_u_29, (ref) v_u_24, (copy) v_u_18, (copy) v_u_19, (ref) v_u_20, (ref) v_u_25
				v_u_29()
				v_u_24()
				v_u_18:Destroy()
				v_u_19:Destroy()
				if v_u_20 then
					v_u_20:Destroy()
					v_u_20 = nil
				end
				if v_u_25 then
					v_u_25:Disconnect()
					v_u_25 = nil
				end
			end
		end,
		["CanComplete"] = function(p30, p31)
			-- upvalues: (copy) v_u_3, (copy) v_u_4
			return require(v_u_3.Server.Data.StatisticService):get(p31, v_u_4.SlimesDefeated) >= p30.Goal
		end,
		["Server"] = function(_, _)
			return function() end
		end,
		["ServerInit"] = function(p_u_32, p_u_33)
			-- upvalues: (copy) v_u_3, (copy) v_u_4
			require(v_u_3.Server.Data.StatisticService).OnAdded:Connect(function(p34, p35, _)
				-- upvalues: (copy) p_u_33, (copy) p_u_32, (ref) v_u_4
				if p_u_33:getCurrentStep(p34) == p_u_32.Step then
					if p35 == v_u_4.SlimesDefeated then
						if p_u_32:CanComplete(p34) then
							p_u_33:complete(p34, p_u_32.Step)
						end
					end
				else
					return
				end
			end)
		end
	},
	{
		["Step"] = 2,
		["OnboardingName"] = "Purchase Player Upgrade",
		["Title"] = "Purchase a Player Upgrade",
		["Goal"] = 1,
		["Upgrades"] = {
			"RANGE_INCREASE_1",
			"DAMAGE_INCREASE",
			"COIN_MULTIPLIER",
			"SLIME_SPAWN_CAP",
			"SLIME_SPAWN_SPEED",
			"SLIME_LUCK"
		},
		["Client"] = function(_)
			-- upvalues: (copy) v_u_1, (copy) v_u_9, (copy) v_u_10, (copy) v_u_11, (copy) v_u_6, (copy) v_u_8, (copy) v_u_5
			local v_u_36 = require(v_u_1.Utility.Firework)
			local v37 = require(v_u_1.Utility.UI):get("Persistent", "Onboarding"):WaitForChild("Frame")
			local v38 = v_u_9:WaitForChild("Upgrade")
			v37.Title.Text = "Purchase an Upgrade"
			v_u_10.Parent = workspace
			v_u_11.Enabled = true
			v_u_6.target(v_u_10, 1, 1, {
				["CFrame"] = CFrame.new(v38.Position)
			})
			v_u_6.target(v_u_11, 1, 1, {
				["Size"] = UDim2.fromScale(8, 2.5)
			})
			local v_u_39 = Instance.new("Attachment")
			v_u_39.Parent = v38
			local v_u_40 = v_u_8()
			v_u_40.Parent = v_u_39.Parent
			v_u_40.Attachment0 = v_u_39
			local v_u_41 = nil
			local v_u_45 = v_u_5.observeCharacter(function(p42, p43)
				-- upvalues: (ref) v_u_41, (copy) v_u_40
				if p42 == game.Players.LocalPlayer then
					if v_u_41 then
						v_u_41:Destroy()
						v_u_41 = nil
					end
					local v44 = p43:WaitForChild("HumanoidRootPart")
					if v44 then
						v_u_41 = Instance.new("Attachment")
						v_u_41.Parent = v44
						v_u_40.Attachment1 = v_u_41
					end
				end
			end)
			return function()
				-- upvalues: (ref) v_u_11, (ref) v_u_10, (copy) v_u_39, (copy) v_u_40, (ref) v_u_41, (copy) v_u_36, (ref) v_u_45
				v_u_11.Enabled = false
				v_u_10.Parent = script
				v_u_39:Destroy()
				v_u_40:Destroy()
				if v_u_41 then
					v_u_41:Destroy()
					v_u_41 = nil
				end
				v_u_36.fire()
				v_u_45()
			end
		end,
		["CanComplete"] = function(p46, p47)
			-- upvalues: (copy) v_u_3
			local v48 = require(v_u_3.Server.Gameplay.Upgrades.UpgradeBoardService)
			local v49 = 0
			for _, v50 in p46.Upgrades do
				v49 = v49 + v48:getLevel(p47, v50)
			end
			return p46.Goal <= v49
		end,
		["ServerInit"] = function(p_u_51, p_u_52)
			-- upvalues: (copy) v_u_3
			require(v_u_3.Server.Gameplay.Upgrades.UpgradeBoardService).OnUpgrade:Connect(function(p53)
				-- upvalues: (copy) p_u_52, (copy) p_u_51
				if p_u_52:getCurrentStep(p53) == p_u_51.Step then
					if p_u_51:CanComplete(p53) then
						p_u_52:complete(p53, p_u_51.Step)
					end
				end
			end)
		end
	}
}
return v54]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[OnboardingSteps]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4003"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.SlimeVarientTypes)
local v_u_3 = v1:WaitForChild("Assets"):WaitForChild("VFX")
local v19 = {
	[v2.Normal] = {
		["Order"] = 1,
		["Rotation"] = 90,
		["Multiplier"] = 1,
		["GetModel"] = function(p4)
			if workspace:FindFirstChild("normal-slime") then
				return workspace:FindFirstChild("normal-slime")
			end
			local v5 = Instance.new("Model")
			v5.Name = "normal-slime"
			v5.Parent = workspace
			p4:CreateHighlight().Parent = v5
			return v5
		end,
		["CreateHighlight"] = function(_)
			local v6 = Instance.new("Highlight")
			v6.DepthMode = Enum.HighlightDepthMode.Occluded
			v6.FillTransparency = 1
			return v6
		end
	},
	[v2.Golden] = {
		["Order"] = 2,
		["Rotation"] = 90,
		["Multiplier"] = 1.25,
		["GetModel"] = function(p7)
			if workspace:FindFirstChild("golden-slime") then
				return workspace:FindFirstChild("golden-slime")
			end
			local v8 = Instance.new("Model")
			v8.Name = "golden-slime"
			v8.Parent = workspace
			p7:CreateHighlight().Parent = v8
			return v8
		end,
		["CreateHighlight"] = function(_)
			local v9 = Instance.new("Highlight")
			v9.DepthMode = Enum.HighlightDepthMode.Occluded
			v9.FillColor = Color3.fromRGB(255, 255, 0)
			v9.FillTransparency = 0.3
			return v9
		end,
		["GetGradient"] = function()
			return ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)),
				ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 170, 0)),
				ColorSequenceKeypoint.new(0.66, Color3.fromRGB(255, 255, 127)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 0))
			})
		end,
		["ApplyVFX"] = function(p10)
			-- upvalues: (copy) v_u_3
			v_u_3:WaitForChild("golden-slime"):Clone().Parent = p10.PrimaryPart
		end
	},
	[v2.Diamond] = {
		["Order"] = 3,
		["Rotation"] = 90,
		["Multiplier"] = 1.5,
		["GetModel"] = function(p11)
			if workspace:FindFirstChild("diamond-slime") then
				return workspace:FindFirstChild("diamond-slime")
			end
			local v12 = Instance.new("Model")
			v12.Name = "diamond-slime"
			v12.Parent = workspace
			p11:CreateHighlight().Parent = v12
			return v12
		end,
		["CreateHighlight"] = function(_)
			local v13 = Instance.new("Highlight")
			v13.DepthMode = Enum.HighlightDepthMode.Occluded
			v13.FillColor = Color3.fromRGB(170, 255, 255)
			v13.FillTransparency = 0.3
			return v13
		end,
		["GetGradient"] = function()
			return ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 255)) })
		end,
		["ApplyVFX"] = function(_, p14)
			-- upvalues: (copy) v_u_3
			v_u_3:WaitForChild("diamond-slime"):Clone().Parent = p14.PrimaryPart
		end
	},
	[v2.Rainbow] = {
		["Order"] = 4,
		["Multiplier"] = 2,
		["GetModel"] = function(p15)
			if workspace:FindFirstChild("rainbow-slime") then
				return workspace:FindFirstChild("rainbow-slime")
			end
			local v16 = Instance.new("Model")
			v16.Name = "rainbow-slime"
			v16.Parent = workspace
			p15:CreateHighlight().Parent = v16
			return v16
		end,
		["CreateHighlight"] = function(_)
			local v17 = Instance.new("Highlight")
			v17.DepthMode = Enum.HighlightDepthMode.Occluded
			v17.FillColor = Color3.fromRGB(255, 255, 255)
			v17.FillTransparency = 0.3
			v17:AddTag("Rainbow")
			return v17
		end,
		["Animated"] = true,
		["Rotation"] = 0,
		["GetGradient"] = function()
			return ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
				ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 127, 0)),
				ColorSequenceKeypoint.new(0.34, Color3.fromRGB(255, 255, 0)),
				ColorSequenceKeypoint.new(0.51, Color3.fromRGB(0, 255, 0)),
				ColorSequenceKeypoint.new(0.68, Color3.fromRGB(0, 0, 255)),
				ColorSequenceKeypoint.new(0.85, Color3.fromRGB(75, 0, 130)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(148, 0, 211))
			})
		end,
		["ApplyVFX"] = function(p18)
			-- upvalues: (copy) v_u_3
			v_u_3:WaitForChild("rainbow-slime"):Clone().Parent = p18.PrimaryPart
		end
	}
}
return v19]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeVarientData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4004"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.ItemTypes)
local v4 = require(v1.Enums.PotionTypes)
local v5 = {
	["Rewards"] = {
		{
			["ItemType"] = v3.Currency,
			["Key"] = v2.Coins,
			["Amount"] = 10000
		},
		{
			["ItemType"] = v3.RuneOpen,
			["Key"] = "JELLY_RUNES",
			["Amount"] = 10
		},
		{
			["ItemType"] = v3.Potions,
			["Key"] = v4.Stats,
			["Amount"] = 1
		},
		{
			["ItemType"] = v3.Currency,
			["Key"] = v2.Tokens,
			["Amount"] = 50
		}
	}
}
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[StarterPackData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4005"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.ItemTypes)
local v4 = require(v1.Enums.PotionTypes)
local v5 = {}
local v6 = {
	["OneTime"] = true,
	["Reward"] = {
		["ItemType"] = v3.Potions,
		["Key"] = v4.Stats,
		["Amount"] = 1
	}
}
v5.token_1 = v6
local v7 = {
	["OneTime"] = true,
	["Reward"] = {
		["ItemType"] = v3.Potions,
		["Key"] = v4.Damage,
		["Amount"] = 1
	}
}
v5.token_2 = v7
local v8 = {
	["OneTime"] = true,
	["Reward"] = {
		["ItemType"] = v3.Potions,
		["Key"] = v4.RuneLuck,
		["Amount"] = 1
	}
}
v5.token_3 = v8
local v9 = {
	["OneTime"] = true,
	["Reward"] = {
		["ItemType"] = v3.Potions,
		["Key"] = v4.RuneSpeed,
		["Amount"] = 1
	}
}
v5.token_4 = v9
local v10 = {
	["OneTime"] = true,
	["Reward"] = {
		["ItemType"] = v3.SkillXP,
		["Amount"] = 5000
	}
}
v5.token_5 = v10
local v11 = {
	["OneTime"] = true,
	["Reward"] = {
		["ItemType"] = v3.Potions,
		["Key"] = v4.Damage,
		["Amount"] = 1
	}
}
v5.token_6 = v11
local v12 = {
	["OneTime"] = true,
	["Reward"] = {
		["ItemType"] = v3.Currency,
		["Key"] = v2.Shards,
		["Amount"] = 1000
	}
}
v5.token_7 = v12
local v13 = {
	["OneTime"] = true,
	["Reward"] = {
		["ItemType"] = v3.Potions,
		["Key"] = v4.Damage,
		["Amount"] = 1
	}
}
v5.token_8 = v13
local v14 = {
	["OneTime"] = true,
	["Reward"] = {
		["ItemType"] = v3.Potions,
		["Key"] = v4.Damage,
		["Amount"] = 1
	}
}
v5.token_9 = v14
local v15 = {
	["OneTime"] = true,
	["Reward"] = {
		["ItemType"] = v3.Currency,
		["Key"] = v2.CrystalHearts,
		["Amount"] = 1000
	}
}
v5.token_10 = v15
local v16 = {
	["OneTime"] = true,
	["Reward"] = {
		["ItemType"] = v3.Currency,
		["Key"] = v2.Tokens,
		["Amount"] = 5
	}
}
v5.token_11 = v16
local v17 = {
	["OneTime"] = true,
	["Reward"] = {
		["ItemType"] = v3.SkillXP,
		["Amount"] = 1000
	}
}
v5.token_12 = v17
local v18 = {
	["OneTime"] = true,
	["Reward"] = {
		["ItemType"] = v3.Currency,
		["Key"] = v2.Tokens,
		["Amount"] = 5
	}
}
v5.token_13 = v18
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SecretTokenData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4006"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	20,
	30,
	40,
	50,
	60,
	80,
	125
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[DailyRewardData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4007"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v4 = {
	[require(v1.Enums.SlimeEffectTypes).Frozen] = {
		["Name"] = "Frozen",
		["apply"] = function(p2)
			local v_u_3 = Instance.new("Part")
			v_u_3.Color = Color3.new(0.34902, 0.760784, 1)
			v_u_3.CFrame = p2.model:GetPivot()
			v_u_3.Transparency = 0.5
			v_u_3.Material = Enum.Material.Ice
			v_u_3.Size = p2.model:GetExtentsSize() + Vector3.new(1, 1, 1)
			v_u_3.CanCollide = false
			v_u_3.Anchored = true
			v_u_3.Parent = workspace
			return function()
				-- upvalues: (copy) v_u_3
				v_u_3:Destroy()
			end
		end
	}
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[EffectData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4008"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Format)
local v20 = {
	["Requirements"] = function(_, p4)
		return p4 * 5
	end,
	["Benefits"] = {
		{
			["Text"] = "Keep Amulets"
		},
		{
			["Text"] = "Keep Robux Runes"
		},
		{
			["Text"] = "Keep Skills"
		},
		{
			["Text"] = "Keep Ice Boss Level(s)"
		},
		{
			["Text"] = "+1 Super Rebirth",
			["Special"] = true
		},
		{
			["Text"] = "%s Currency Gain",
			["Special"] = true,
			["Format"] = function(_, p5)
				local v6 = p5 * 100
				return ("+%*%%"):format((math.floor(v6)))
			end,
			["Get"] = function(_, p7)
				return p7 >= 100 and 0.025 or (p7 >= 50 and 0.01 or (p7 >= 25 and 0.02 or (p7 >= 10 and 0.05 or 0.1)))
			end,
			["MultiplierType"] = v2.CurrencyGainMultiplier,
			["Calculate"] = function(p8, p9)
				local v10 = 1
				for v11 = 1, math.min(p9, 100) do
					v10 = v10 + p8:Get(v11)
				end
				if p9 >= 100 then
					v10 = v10 + (p9 - 100) * p8:Get(p9)
				end
				local v12 = v10 * 100
				return math.floor(v12) / 100
			end
		},
		{
			["Text"] = "%s Rune Bulk",
			["Special"] = true,
			["Format"] = function(_, p13)
				-- upvalues: (copy) v_u_3
				return ("+%*"):format((v_u_3.abbreviateComma(p13)))
			end,
			["Get"] = function(_, p14)
				return p14 >= 100 and 10 or (p14 >= 50 and 20 or (p14 >= 25 and 50 or (p14 >= 10 and 75 or 100)))
			end,
			["MultiplierType"] = v2.RuneBulk,
			["Calculate"] = function(p15, p16)
				local v17 = 0
				for v18 = 1, math.min(p16, 100) do
					v17 = v17 + p15:Get(v18)
				end
				if p16 >= 100 then
					v17 = v17 + (p16 - 100) * p15:Get(p16)
				end
				local v19 = v17 * 100
				return math.floor(v19) / 100
			end
		}
	},
	["Lose"] = {
		{
			["Text"] = "All Upgrades"
		},
		{
			["Text"] = "Runes under 1M Chance"
		},
		{
			["Text"] = "Worlds"
		},
		{
			["Text"] = "Currency"
		}
	}
}
return v20]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SuperRebirthData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4009"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.LockTypes)
local v4 = require(v1.Enums.MultiplierTypes)
local v5 = require(v1.Enums.Products)
local v6 = {}
local v7 = {
	["Name"] = "Slime Amulet",
	["Icon"] = "rbxassetid://0",
	["Multipliers"] = {
		v4.RuneBulk,
		v4.RuneLuckMultiplier,
		v4.DamageMultiplier,
		v4.ComboMultiplier,
		v4.StatsMultiplier,
		v4.CurrencyGainMultiplier,
		v4.RebirthMultiplier,
		v4.ShardMultiplier,
		v4.SkillXPMultiplier,
		v4.IceBossCooldownPercentage
	}
}
local v8 = {}
local v9 = {
	["Icon"] = "rbxassetid://138717318445432"
}
local v10 = {
	[v3.SkillLevel] = {
		["value"] = 10
	}
}
v9.LockedData = v10
v9.CurrencyType = v2.Shards
v9.Amount = 100
v8[1] = v9
local v11 = {
	["Icon"] = "rbxassetid://71762142128848"
}
local v12 = {
	[v3.SkillLevel] = {
		["value"] = 20
	}
}
v11.LockedData = v12
v11.CurrencyType = v2.Shards
v11.Amount = 500
v8[2] = v11
local v13 = {
	["Icon"] = "rbxassetid://110757147995153"
}
local v14 = {
	[v3.SkillLevel] = {
		["value"] = 40
	}
}
v13.LockedData = v14
v13.CurrencyType = v2.Shards
v13.Amount = 1000
v8[3] = v13
local v15 = {
	["Icon"] = "rbxassetid://136345397117321"
}
local v16 = {
	[v3.SkillLevel] = {
		["value"] = 60
	}
}
v15.LockedData = v16
v15.CurrencyType = v2.Shards
v15.Amount = 1500
v8[4] = v15
local v17 = {
	["Icon"] = "rbxassetid://92512152376727"
}
local v18 = {
	[v3.SkillLevel] = {
		["value"] = 100
	}
}
v17.LockedData = v18
v17.CurrencyType = v2.Shards
v17.Amount = 2500
v8[5] = v17
v7.Tiers = v8
v6.AmuletHall = v7
local v19 = {
	["Name"] = "Valentine Amulet",
	["Icon"] = "rbxassetid://0",
	["Frame"] = "HeartCrystals",
	["Multipliers"] = {
		v4.ValentineRuneBulk,
		v4.ValentineRuneLuckMultiplier,
		v4.ValentineDamageMultiplier,
		v4.HeartsMultiplier,
		v4.ValentineTraitsLuckMultiplier,
		v4.ValentineAttackRangeMultiplier,
		v4.ValentineCrystalShardMultiplier
	}
}
local v20 = {
	{
		["Icon"] = "rbxassetid://130498699671102",
		["CurrencyType"] = v2.CrystalHearts,
		["Amount"] = 25,
		["productid"] = v5.CrystalHearts[1]
	},
	{
		["Icon"] = "rbxassetid://97777264247308",
		["CurrencyType"] = v2.CrystalHearts,
		["Amount"] = 100,
		["productid"] = v5.CrystalHearts[1]
	},
	{
		["Icon"] = "rbxassetid://119223916310572",
		["CurrencyType"] = v2.CrystalHearts,
		["Amount"] = 500,
		["productid"] = v5.CrystalHearts[2]
	},
	{
		["Icon"] = "rbxassetid://76841257130587",
		["CurrencyType"] = v2.CrystalHearts,
		["Amount"] = 1250,
		["productid"] = v5.CrystalHearts[2]
	},
	{
		["Icon"] = "rbxassetid://120194378535401",
		["CurrencyType"] = v2.CrystalHearts,
		["Amount"] = 2500,
		["productid"] = v5.CrystalHearts[3]
	}
}
v19.Tiers = v20
v6.Valentine = v19
local v21 = {
	["Name"] = "Millionaire Amulet",
	["Icon"] = "rbxassetid://104830547168409",
	["Frame"] = "Event1MStars",
	["Multipliers"] = {
		v4.Event1MRuneBulk,
		v4.Event1MRuneLuckMultiplier,
		v4.Event1MDamageMultiplier,
		v4.Event1MBalloonsMultiplier,
		v4.Event1MAttackRangeMultiplier,
		v4.MillionaireTraitsLuckMultiplier
	}
}
local v22 = {
	{
		["Icon"] = "rbxassetid://104830547168409",
		["CurrencyType"] = v2.Event1MStars,
		["Amount"] = 25
	},
	{
		["Icon"] = "rbxassetid://126815084895769",
		["CurrencyType"] = v2.Event1MStars,
		["Amount"] = 100
	},
	{
		["Icon"] = "rbxassetid://120794038613017",
		["CurrencyType"] = v2.Event1MStars,
		["Amount"] = 500
	},
	{
		["Icon"] = "rbxassetid://117472451333718",
		["CurrencyType"] = v2.Event1MStars,
		["Amount"] = 1250
	},
	{
		["Icon"] = "rbxassetid://101813133860585",
		["CurrencyType"] = v2.Event1MStars,
		["Amount"] = 2500
	}
}
v21.Tiers = v22
v6.Millionaire = v21
return v6]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AmuletData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4010"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Products)
return {
	[v2.Shards[1]] = 500,
	[v2.Shards[2]] = 3000,
	[v2.Shards[3]] = 10000,
	[v2.Shards[4]] = 50000,
	[v2.Shards[5]] = 100000
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ShardsPackData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4011"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
local v2 = {
	["Name"] = "Update 1 - Ice World!",
	["Date"] = {
		["day"] = 26,
		["month"] = 1,
		["year"] = 2026
	},
	["Image"] = "rbxassetid://130706426944176",
	["TitleGradient"] = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(127, 244, 255)),
		ColorSequenceKeypoint.new(0.33, Color3.fromRGB(90, 192, 255)),
		ColorSequenceKeypoint.new(0.66, Color3.fromRGB(127, 244, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 192, 255))
	})
}
local v3 = {
	[5] = {
		["Title"] = "World 3 - Ice World!",
		["Color"] = Color3.fromRGB(142, 197, 255)
	},
	[10] = {
		["Text"] = "Welcome to Ice World, a brand new frozen area packed with new mechanics, bosses, and progression!"
	},
	[11] = {
		["Thumbnail"] = "rbxassetid://122582878620614"
	},
	[15] = {
		["Title"] = "Slime Wave Game!",
		["Color"] = Color3.fromRGB(142, 197, 255)
	},
	[20] = {
		["Text"] = "Reach high scores in the Slime Wave game and compete with players globally in Ice World!"
	},
	[25] = {
		["Title"] = "World 2 Skill Tree Boosts!",
		["Color"] = Color3.fromRGB(142, 197, 255)
	},
	[30] = {
		["Text"] = "Purchase new skill tree nodes in World 2 to boost your progress in Ice World!"
	},
	[35] = {
		["Title"] = "New Skill - Ice Wind!",
		["Color"] = Color3.fromRGB(142, 197, 255)
	},
	[40] = {
		["Text"] = "Ice Wind freezes slimes in your zone, making them weaker and easier to defeat!"
	},
	[45] = {
		["Title"] = "SUPER REBIRTHS!",
		["Color"] = Color3.fromRGB(142, 197, 255)
	},
	[50] = {
		["Text"] = "Reset your progress for permanent buffs with Super Rebirths, located in Ice World!"
	},
	[55] = {
		["Title"] = "Amulet Hall!",
		["Color"] = Color3.fromRGB(142, 197, 255)
	},
	[60] = {
		["Text"] = "Use shards to roll for powerful Amulets that grant permanent buffs!"
	},
	[65] = {
		["Text"] = "Requires milestone skill levels to unlock better amulets."
	},
	[70] = {
		["Title"] = "Free Shard Dispenser!",
		["Color"] = Color3.fromRGB(142, 197, 255)
	},
	[75] = {
		["Text"] = "Receive free shards every 12 hours in the Amulet Hall!"
	},
	[80] = {
		["Title"] = "Ice Boss!",
		["Color"] = Color3.fromRGB(142, 197, 255)
	},
	[85] = {
		["Text"] = "Defeat the Ice Slime Boss for rewards like tokens and shards!"
	},
	[90] = {
		["Text"] = "Each defeat levels up the boss, making it stronger but more rewarding."
	},
	[95] = {
		["Text"] = "Respawns every 8 hours (can be reduced with Amulets)."
	},
	[100] = {
		["Title"] = "Ice Coin Leaderboard!",
		["Color"] = Color3.fromRGB(142, 197, 255)
	},
	[105] = {
		["Text"] = "Compete to earn the most Ice Coins before the leaderboard resets for a chance to win Tokens!"
	},
	[110] = {
		["Title"] = "New Masteries!",
		["Color"] = Color3.fromRGB(142, 197, 255)
	},
	[115] = {
		["Text"] = "Bosses Defeated, Ice Coins, and Fire Coins masteries have been added!"
	},
	[120] = {
		["Title"] = "Discord Buff!",
		["Color"] = Color3.fromRGB(142, 197, 255)
	},
	[125] = {
		["Text"] = "Members of the Discord server receive a nice Rune Bulk buff!"
	},
	[130] = {
		["Title"] = "Login Streaks!",
		["Color"] = Color3.fromRGB(142, 197, 255)
	},
	[135] = {
		["Text"] = "Login daily to gain +1 Rune Bulk per day!"
	},
	[140] = {
		["Text"] = "Every 7th day grants +10 Rune Bulk. Missing a day resets your streak and buff!"
	},
	[150] = {
		["Title"] = "Important Change!",
		["Color"] = Color3.fromRGB(142, 197, 255)
	},
	[155] = {
		["Text"] = "Coin Multiplier Progressive Packs have been removed from the game."
	},
	[160] = {
		["Text"] = "All owners have been fully refunded in Tokens. Sorry for the inconvenience!"
	}
}
v2.Content = v3
v1[1] = v2
local v4 = {
	["Name"] = "Update 2 - Valentine Event!",
	["Date"] = {
		["day"] = 1,
		["month"] = 2,
		["year"] = 2026
	},
	["Image"] = "rbxassetid://102527198195473",
	["TitleGradient"] = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 127, 229)),
		ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 87, 235)),
		ColorSequenceKeypoint.new(0.66, Color3.fromRGB(255, 127, 229)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 87, 235))
	})
}
local v5 = {
	[5] = {
		["Title"] = "Valentine Event!",
		["Color"] = Color3.fromRGB(255, 168, 238)
	},
	[10] = {
		["Text"] = "New Valentine Event, unlock Traits, Amulets and more!"
	},
	[11] = {
		["Thumbnail"] = "rbxassetid://117797580975582"
	},
	[15] = {
		["Title"] = "Amulet Passives!",
		["Color"] = Color3.fromRGB(255, 168, 238)
	},
	[20] = {
		["Text"] = "Tier 5 amulets now have a chance to grant powerful passive effects!"
	},
	[25] = {
		["Title"] = "Blessings!",
		["Color"] = Color3.fromRGB(255, 168, 238)
	},
	[30] = {
		["Text"] = "Blessings grant temporary buffs to aid your progress!"
	},
	[35] = {
		["Text"] = "Valentine Blessing - Defeat Valentine Slime!"
	},
	[40] = {
		["Text"] = "Ice Blessing - Defeat Ice Slime Boss!"
	},
	[100] = {
		["Title"] = "Changes!",
		["Color"] = Color3.fromRGB(255, 168, 238)
	},
	[110] = {
		["Text"] = "Buy all gamepass bundle!"
	},
	[150] = {
		["Text"] = "Many bug fixes and improvements!"
	}
}
v4.Content = v5
v1[2] = v4
local v6 = {
	["Name"] = "Update 3 - Glow World!",
	["Date"] = {
		["day"] = 10,
		["month"] = 2,
		["year"] = 2026
	},
	["Image"] = "rbxassetid://71852343403988",
	["TitleGradient"] = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 255, 96)),
		ColorSequenceKeypoint.new(0.33, Color3.fromRGB(154, 255, 171)),
		ColorSequenceKeypoint.new(0.66, Color3.fromRGB(88, 255, 96)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(206, 255, 214))
	})
}
local v7 = {
	[5] = {
		["Title"] = "World 4 - Glow World!",
		["Color"] = Color3.fromRGB(88, 255, 120)
	},
	[6] = {
		["Thumbnail"] = "rbxassetid://71852343403988"
	},
	[10] = {
		["Text"] = "A brand new end-game world has arrived! Explore Glow World and take on the toughest slimes yet!"
	},
	[11] = {
		["Text"] = "13 new upgrades split into tiers! Progress through Damage, Spawn Capacity, Coin Multipliers, Rune Bulk, and more!"
	},
	[12] = {
		["Text"] = "Open Glow Runes for 1T Glow Coins each! 6 new rune types from common Glop to the ultra-rare Muck!"
	},
	[15] = {
		["Title"] = "New Upgrade Tree!",
		["Color"] = Color3.fromRGB(88, 255, 120)
	},
	[20] = {
		["Text"] = "Upgrade Tree 3 brings 25 new nodes across 4 branches: Skill Mastery, Combat, Economy, and Rune Utility!"
	},
	[30] = {
		["Title"] = "Amulet Upgrader!",
		["Color"] = Color3.fromRGB(88, 255, 120)
	},
	[40] = {
		["Text"] = "Located in Glow World, Use gloop to improve amulets!"
	},
	[50] = {
		["Title"] = "Gloop System!",
		["Color"] = Color3.fromRGB(88, 255, 120)
	},
	[55] = {
		["Text"] = "Apply Gloops to your amulets for stat boosts! Higher rarity Gloops give bigger buffs but risk breaking your amulet!"
	},
	[60] = {
		["Text"] = "Use Spiked Gloop to repair broken amulets and remove all applied Gloops!"
	},
	[65] = {
		["Title"] = "Skill Reset!",
		["Color"] = Color3.fromRGB(88, 255, 120)
	},
	[70] = {
		["Text"] = "You can now reset your skills and Upgrade Tree 3 using Skill Reset Tickets! All spent skill points are refunded!"
	},
	[75] = {
		["Title"] = "New Masteries!",
		["Color"] = Color3.fromRGB(88, 255, 120)
	},
	[80] = {
		["Text"] = "Gloop Collector and Glow Coins Collector masteries have been added!"
	},
	[85] = {
		["Title"] = "New Store Packs!",
		["Color"] = Color3.fromRGB(88, 255, 120)
	},
	[90] = {
		["Text"] = "Gloop Pack and updated Skilled Pack are now available in the store!"
	},
	[95] = {
		["Title"] = "New Code!",
		["Color"] = Color3.fromRGB(88, 255, 120)
	},
	[100] = {
		["Text"] = "Use code GLOOP for free Gloops!"
	},
	[105] = {
		["Title"] = "Changes!",
		["Color"] = Color3.fromRGB(88, 255, 120)
	},
	[110] = {
		["Text"] = "Skill XP is now capped at level 111 meaning xp is the same after that point!"
	},
	[111] = {
		["Text"] = "Damage Star & Coin Star now work in the Valentine\'s World"
	},
	[112] = {
		["Text"] = "Ice Blessing bug has been fixed"
	},
	[113] = {
		["Text"] = "You can now Toggle your active skills on/off by clicking them on the HUD"
	},
	[114] = {
		["Text"] = "x2 Stats Potion now gives x2 currency gain + damage  and rune luck"
	},
	[115] = {
		["Text"] = "Many bug fixes and improvements!"
	}
}
v6.Content = v7
v1[3] = v6
local v8 = {
	["Name"] = "Update 4 - 1M Visits Event World!",
	["Date"] = {
		["day"] = 26,
		["month"] = 2,
		["year"] = 2026
	},
	["Image"] = "rbxassetid://73955649000127",
	["TitleGradient"] = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 216, 88)),
		ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 250, 183)),
		ColorSequenceKeypoint.new(0.66, Color3.fromRGB(255, 228, 76)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 222, 74))
	})
}
local v9 = {
	[5] = {
		["Title"] = "1M Visits Event World!",
		["Color"] = Color3.fromRGB(255, 216, 88)
	},
	[6] = {
		["Thumbnail"] = "rbxassetid://73955649000127"
	},
	[10] = {
		["Text"] = "A brand new event world to celebrate 1M visits! Take on 5 new slimes and earn Balloons, Confetti, and Stars!"
	},
	[15] = {
		["Title"] = "Confetti Clicking!",
		["Color"] = Color3.fromRGB(255, 216, 88)
	},
	[20] = {
		["Text"] = "Click to earn Confetti! Upgrade your click speed, auto-clicker, and critical hit chance to maximize your gains!"
	},
	[25] = {
		["Title"] = "Millionaire Milestones!",
		["Color"] = Color3.fromRGB(255, 216, 88)
	},
	[30] = {
		["Text"] = "Progress through 15 milestones by earning Balloons! Unlock new features and powerful buffs along the way!"
	},
	[35] = {
		["Title"] = "Millionaire Traits!",
		["Color"] = Color3.fromRGB(255, 216, 88)
	},
	[40] = {
		["Text"] = "Roll for random passive bonuses with 7 trait rarities, from common Spark all the way to the legendary Supernova!"
	},
	[45] = {
		["Title"] = "Ascension!",
		["Color"] = Color3.fromRGB(255, 216, 88)
	},
	[50] = {
		["Text"] = "Reset your event progress to earn permanent Balloon Multiplier boosts! Each ascension costs more but rewards more!"
	},
	[55] = {
		["Title"] = "Event Runes!",
		["Color"] = Color3.fromRGB(255, 216, 88)
	},
	[60] = {
		["Text"] = "Open Event Runes with Balloons! 6 new rune types from common Streamer to the secret Celebration rune!"
	},
	[65] = {
		["Title"] = "Upgrade Tree 4!",
		["Color"] = Color3.fromRGB(255, 216, 88)
	},
	[70] = {
		["Text"] = "A massive 40-node event tree! Branches for Balloons, Combat, Spawns, Runes, Confetti, and main-game crossover boosts!"
	},
	[75] = {
		["Title"] = "Firework Blessing!",
		["Color"] = Color3.fromRGB(255, 216, 88)
	},
	[80] = {
		["Text"] = "Unlocked at Milestone 6! Click fireworks in the world for a timed Balloon, Confetti, and Gloop Luck buff!"
	},
	[85] = {
		["Title"] = "New Amulet Perks!",
		["Color"] = Color3.fromRGB(255, 216, 88)
	},
	[90] = {
		["Text"] = "4 new perks: Gloop Guardian, Ascension Keeper, Confetti Critic, and Gloop Magnet!"
	},
	[95] = {
		["Title"] = "Store: Rune Bulk & Speed!",
		["Color"] = Color3.fromRGB(255, 216, 88)
	},
	[100] = {
		["Text"] = "Purchase up to 10 levels of extra Rune Bulk and Rune Open Speed from the store!"
	},
	[105] = {
		["Title"] = "Star Packs!",
		["Color"] = Color3.fromRGB(255, 216, 88)
	},
	[110] = {
		["Text"] = "Buy Stars to spend in the event world! Available in packs of 200, 2,500, and 12,500!"
	},
	[115] = {
		["Title"] = "New Code!",
		["Color"] = Color3.fromRGB(255, 216, 88)
	},
	[120] = {
		["Text"] = "Use code 1M for 500 Shards, a Green Gloop, and a Spiked Gloop!"
	}
}
v8.Content = v9
v1[4] = v8
local v10 = {
	["Name"] = "Update 5 - Candy World!",
	["Date"] = {
		["day"] = 7,
		["month"] = 3,
		["year"] = 2026
	},
	["Image"] = "rbxassetid://132574460943772",
	["TitleGradient"] = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 105, 180)),
		ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 182, 213)),
		ColorSequenceKeypoint.new(0.66, Color3.fromRGB(255, 105, 180)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 182, 213))
	})
}
local v11 = {
	[5] = {
		["Title"] = "World 5 - Candy World!",
		["Color"] = Color3.fromRGB(255, 150, 200)
	},
	[6] = {
		["Thumbnail"] = "rbxassetid://132574460943772"
	},
	[10] = {
		["Text"] = "A brand new end-game world has arrived! Take on 6 new candy slimes and earn Candy Coins!"
	},
	[15] = {
		["Title"] = "Pets!",
		["Color"] = Color3.fromRGB(255, 150, 200)
	},
	[20] = {
		["Text"] = "Collect 10 unique pets across 6 rarities, from common Gumdrop to the mythical Cosmic Candy! Level up 6 attributes to power up your pets!"
	},
	[25] = {
		["Title"] = "Slime Races!",
		["Color"] = Color3.fromRGB(255, 150, 200)
	},
	[30] = {
		["Text"] = "Roll for 10 pet races across 6 rarities! Legendary and Mythical races grant unique passive abilities!"
	},
	[35] = {
		["Title"] = "Gloop Crafting!",
		["Color"] = Color3.fromRGB(255, 150, 200)
	},
	[40] = {
		["Text"] = "Craft gloops through a 5-tier chain using shards! Combine lower-tier gloops to create more powerful ones!"
	},
	[45] = {
		["Title"] = "Candy Runes!",
		["Color"] = Color3.fromRGB(255, 150, 200)
	},
	[50] = {
		["Text"] = "6 new candy runes from common Taffy to the ultra-rare Sugarplum!"
	},
	[55] = {
		["Title"] = "26 New Upgrades!",
		["Color"] = Color3.fromRGB(255, 150, 200)
	},
	[60] = {
		["Text"] = "6 upgrade boards covering spawn capacity, coin multipliers, rune luck, pet boosts, and gloop upgrades!"
	},
	[65] = {
		["Title"] = "Upgrade Tree 5!",
		["Color"] = Color3.fromRGB(255, 150, 200)
	},
	[70] = {
		["Text"] = "20 new nodes across Combat, Spawn, Pet, Rune, and Economy branches!"
	},
	[75] = {
		["Title"] = "Candy Coins Mastery!",
		["Color"] = Color3.fromRGB(255, 150, 200)
	},
	[80] = {
		["Text"] = "5-tier mastery for collecting Candy Coins with multiplier rewards up to 2.5x!"
	},
	[85] = {
		["Title"] = "New Gamepasses!",
		["Color"] = Color3.fromRGB(255, 150, 200)
	},
	[90] = {
		["Text"] = "2x Candy Coins, 2x Craft Speed, Bulk Gloop Craft, and Pet Roll Luck gamepasses!"
	}
}
v10.Content = v11
v1[5] = v10
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UpdateLogData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4012"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.SlimeTypes)
local v3 = {}
local v4 = {
	[v2.ValentineSlime1] = {
		["target"] = v2.ValentineSlime2,
		["amount"] = 1000,
		["order"] = 1
	},
	[v2.ValentineSlime2] = {
		["target"] = v2.ValentineSlime3,
		["amount"] = 2500,
		["order"] = 2
	},
	[v2.ValentineSlime3] = {
		["target"] = v2.ValentineSlime4,
		["amount"] = 5000,
		["order"] = 3
	},
	[v2.ValentineSlime4] = {
		["target"] = v2.ValentineSlime5,
		["amount"] = 10000,
		["order"] = 4
	}
}
v3.Progressive = v4
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ValentineData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4013"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
for _, v2 in script:QueryDescendants("ModuleScript") do
	v1[v2.Name] = require(v2)
end
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BlessingData]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="4014"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("ServerScriptService")
local v_u_4 = require(v2.Config.MultiplierData)
local v5 = require(v2.Enums.MultiplierTypes)
local v6 = require(v2.Enums.SlimeTypes)
local v_u_7 = require(v2.Utility.Multiplier)
local v_u_8 = require(v2.Utility.MultiplierUtil)
local v9 = require(v2.Utility.Network)
local v_u_10 = require(v2.Utility.PerkUtil)
local v_u_11 = require(v2.Utility.Time)
local v_u_12 = v9.remoteEvent(script.Name)
local v_u_13 = {
	v6.ValentineSlime1,
	v6.ValentineSlime2,
	v6.ValentineSlime3,
	v6.ValentineSlime4,
	v6.ValentineSlime5
}
local v14 = {
	["Name"] = "Valentines Blessing",
	["Icon"] = "rbxassetid://108393163278143",
	["MaxTime"] = 3600,
	["DurationPerKill"] = 15
}
local v15 = {
	[v5.WalkspeedMultiplier] = {
		["min"] = 1.01,
		["max"] = 1.25
	},
	[v5.CurrencyGainMultiplier] = {
		["min"] = 1.01,
		["max"] = 1.5
	},
	[v5.ShardMultiplier] = {
		["min"] = 1.01,
		["max"] = 1.5
	},
	[v5.HeartsMultiplier] = {
		["min"] = 1.01,
		["max"] = 2
	}
}
v14.Multipliers = v15
function v14.Server(p_u_16, _)
	-- upvalues: (copy) v_u_3, (copy) v_u_13, (copy) v_u_12, (copy) v_u_1, (copy) v_u_7
	local v_u_17 = {}
	require(v_u_3.Server.Gameplay.Slimes.SlimeSpawnService).OnKilled:Connect(function(p18, p19)
		-- upvalues: (ref) v_u_13, (copy) v_u_17, (copy) p_u_16, (ref) v_u_12
		if p19 then
			if table.find(v_u_13, p19.slime) then
				local v20 = v_u_17
				local v21 = p_u_16.MaxTime
				local v22 = (v_u_17[p18] or 0) + p_u_16.DurationPerKill
				v20[p18] = math.min(v21, v22)
				v_u_12.fire(p18, v_u_17[p18])
			end
		else
			return
		end
	end)
	task.spawn(function()
		-- upvalues: (copy) v_u_17, (ref) v_u_12
		while true do
			for v23, v24 in v_u_17 do
				local v25 = v24 - 1
				if v25 <= 0 then
					v_u_17[v23] = nil
				else
					v_u_17[v23] = v25
				end
				v_u_12.fire(v23, v_u_17[v23] or 0)
			end
			task.wait(1)
		end
	end)
	v_u_1.PlayerRemoving:Connect(function(p26)
		-- upvalues: (copy) v_u_17
		v_u_17[p26] = nil
	end)
	for v27, v_u_28 in p_u_16.Multipliers do
		v_u_7.assign(v27, function(p29)
			-- upvalues: (copy) v_u_17, (copy) p_u_16, (copy) v_u_28
			if not v_u_17[p29] then
				return nil
			end
			local v30 = v_u_17[p29] / p_u_16.MaxTime
			local v31 = math.clamp(v30, 0, 1)
			return v_u_28.min + (v_u_28.max - v_u_28.min) * v31
		end)
	end
end
function v14.Client(p_u_32, _)
	-- upvalues: (copy) v_u_4, (copy) v_u_8, (copy) v_u_12, (copy) v_u_10, (copy) v_u_11, (copy) v_u_7
	local v_u_33 = 0
	local function v_u_42()
		-- upvalues: (copy) p_u_32, (ref) v_u_4, (ref) v_u_33, (ref) v_u_8
		local v34 = {}
		for v35, v36 in p_u_32.Multipliers do
			local v37 = v_u_4[v35]
			if v37 then
				local v38 = v_u_33 / p_u_32.MaxTime
				local v39 = math.clamp(v38, 0, 1)
				local v40 = v36.min + (v36.max - v36.min) * v39
				local v41 = ("%* %*"):format(v_u_8.format(v35, v40), v37.Name)
				table.insert(v34, v41)
			end
		end
		return table.concat(v34, "\n")
	end
	v_u_12.listen(function(p43)
		-- upvalues: (ref) v_u_33, (ref) v_u_10, (copy) p_u_32, (ref) v_u_11, (copy) v_u_42
		v_u_33 = p43
		if v_u_33 <= 0 then
			v_u_10:remove(script.Name)
		else
			local v44 = v_u_10
			local v45 = script.Name
			local v46 = {
				["Name"] = p_u_32.Name,
				["Icon"] = p_u_32.Icon,
				["Text"] = v_u_11.format(p43),
				["Tooltip"] = {
					["Title"] = p_u_32.Name,
					["Description"] = v_u_42()
				}
			}
			v44:update(v45, v46)
		end
	end)
	local v_u_47 = v_u_33
	for v48, v_u_49 in p_u_32.Multipliers do
		v_u_7.assign(v48, function(_)
			-- upvalues: (ref) v_u_47, (copy) p_u_32, (copy) v_u_49
			if v_u_47 <= 0 then
				return nil
			end
			local v50 = v_u_47 / p_u_32.MaxTime
			local v51 = math.clamp(v50, 0, 1)
			return v_u_49.min + (v_u_49.max - v_u_49.min) * v51
		end)
	end
end
return v14]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ValentineBlessing]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4015"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("ServerScriptService")
local v_u_4 = require(v2.Config.MultiplierData)
local v5 = require(v2.Enums.MultiplierTypes)
local v_u_6 = require(v2.Utility.Multiplier)
local v_u_7 = require(v2.Utility.MultiplierUtil)
local v8 = require(v2.Utility.Network)
local v_u_9 = require(v2.Utility.PerkUtil)
local v_u_10 = require(v2.Utility.Time)
local v_u_11 = v8.remoteEvent(script.Name)
local v40 = {
	["Name"] = "Ice Blessing",
	["Icon"] = "rbxassetid://132592414320618",
	["MaxTime"] = 1800,
	["Multipliers"] = {
		[v5.IceCoinsMultiplier] = 1.25,
		[v5.DamageMultiplier] = 1.1,
		[v5.AttackRangeMultiplier] = 1.1
	},
	["Server"] = function(p_u_12, _)
		-- upvalues: (copy) v_u_3, (copy) v_u_11, (copy) v_u_1, (copy) v_u_6
		local v_u_13 = {}
		require(v_u_3.Server.Gameplay["Ice World"].IceBossService).OnKilled:Connect(function(p14, _)
			-- upvalues: (copy) v_u_13, (copy) p_u_12, (ref) v_u_11
			v_u_13[p14] = workspace:GetServerTimeNow() + p_u_12.MaxTime
			v_u_11.fire(p14, v_u_13[p14])
		end)
		v_u_1.PlayerRemoving:Connect(function(p15)
			-- upvalues: (copy) v_u_13
			v_u_13[p15] = nil
		end)
		for v16, v_u_17 in p_u_12.Multipliers do
			v_u_6.assign(v16, function(p18)
				-- upvalues: (copy) v_u_13, (copy) p_u_12, (copy) v_u_17
				local v19 = v_u_13[p18]
				local v20
				if v19 then
					local v21 = v19 - workspace:GetServerTimeNow()
					if v21 <= 0 then
						v_u_13[p18] = nil
						v20 = nil
					else
						v20 = v21 / p_u_12.MaxTime
					end
				else
					v20 = nil
				end
				if v20 then
					return v_u_17
				end
			end)
		end
	end,
	["Client"] = function(p_u_22, _)
		-- upvalues: (copy) v_u_4, (copy) v_u_7, (copy) v_u_11, (copy) v_u_9, (copy) v_u_10, (copy) v_u_6
		local v_u_23 = 0
		local function v_u_29()
			-- upvalues: (copy) p_u_22, (ref) v_u_4, (ref) v_u_7
			local v24 = {}
			for v25, v26 in p_u_22.Multipliers do
				local v27 = v_u_4[v25]
				if v27 then
					local v28 = ("%* %*"):format(v_u_7.format(v25, v26), v27.Name)
					table.insert(v24, v28)
				end
			end
			return table.concat(v24, "\n")
		end
		local v_u_30 = nil
		v_u_11.listen(function(p31)
			-- upvalues: (ref) v_u_30, (ref) v_u_23, (ref) v_u_9, (copy) p_u_22, (ref) v_u_10, (copy) v_u_29
			if v_u_30 then
				task.cancel(v_u_30)
				v_u_30 = nil
			end
			local v32 = p31 - workspace:GetServerTimeNow()
			local v_u_33 = math.max(v32, 0)
			v_u_23 = v_u_33
			if v_u_33 <= 0 then
				v_u_9:remove(script.Name)
			else
				v_u_30 = task.spawn(function()
					-- upvalues: (ref) v_u_33, (ref) v_u_23, (ref) v_u_9, (ref) p_u_22, (ref) v_u_10, (ref) v_u_29
					while v_u_33 > 0 do
						v_u_33 = v_u_33 - 1
						v_u_23 = v_u_33
						local v34 = v_u_9
						local v35 = script.Name
						local v36 = {
							["Name"] = p_u_22.Name,
							["Icon"] = p_u_22.Icon,
							["Text"] = v_u_10.format(v_u_33),
							["Tooltip"] = {
								["Title"] = p_u_22.Name,
								["Description"] = v_u_29()
							}
						}
						v34:update(v35, v36)
						task.wait(1)
					end
					v_u_9:remove(script.Name)
				end)
			end
		end)
		local v_u_37 = v_u_23
		for v38, v_u_39 in p_u_22.Multipliers do
			v_u_6.assign(v38, function(_)
				-- upvalues: (ref) v_u_37, (copy) v_u_39
				if v_u_37 <= 0 then
					return nil
				else
					return v_u_39
				end
			end)
		end
	end
}
return v40]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[IceBlessing]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4016"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Config.MultiplierData)
local v4 = require(v2.Enums.MultiplierTypes)
local v_u_5 = require(v2.Utility.Multiplier)
local v_u_6 = require(v2.Utility.MultiplierUtil)
local v7 = require(v2.Utility.Network)
local v_u_8 = require(v2.Utility.PerkUtil)
local v_u_9 = require(v2.Utility.Time)
local v_u_10 = v7.remoteEvent(script.Name)
local v_u_11 = v7.remoteFunction("FireworkBlessing/press")
local v46 = {
	["Name"] = "Firework Blessing",
	["Icon"] = "rbxassetid://98522455423896",
	["MaxTime"] = 3600,
	["PerPress"] = 240,
	["Cooldown"] = 1,
	["Multipliers"] = {
		[v4.Event1MBalloonsMultiplier] = 2,
		[v4.ConfettiMultiplier] = 2,
		[v4.GloopCollectLuck] = 1.25,
		[v4.ShardMultiplier] = 1.25
	},
	["Server"] = function(p_u_12, _)
		-- upvalues: (copy) v_u_11, (copy) v_u_10, (copy) v_u_1, (copy) v_u_5
		local v13 = game:GetService("ServerScriptService")
		local v_u_14 = require(v13.Server.Gameplay.Event1M.MillionaireMilestoneService)
		local v_u_15 = {}
		local v_u_16 = {}
		v_u_11.listen(function(p17)
			-- upvalues: (copy) v_u_14, (copy) v_u_16, (copy) p_u_12, (copy) v_u_15, (ref) v_u_10
			if not v_u_14:isUnlocked(p17, "Firework") then
				return false, "Not unlocked!"
			end
			local v18 = workspace:GetServerTimeNow()
			if v_u_16[p17] and v18 < v_u_16[p17] then
				return false, "Too fast!"
			end
			v_u_16[p17] = v18 + p_u_12.Cooldown
			local v19 = v_u_15[p17] or v18
			if v19 < v18 then
				v19 = v18
			end
			local v20 = v_u_15
			local v21 = v19 + p_u_12.PerPress
			local v22 = v18 + p_u_12.MaxTime
			v20[p17] = math.min(v21, v22)
			v_u_10.fire(p17, v_u_15[p17])
			return true
		end)
		v_u_1.PlayerRemoving:Connect(function(p23)
			-- upvalues: (copy) v_u_15, (copy) v_u_16
			v_u_15[p23] = nil
			v_u_16[p23] = nil
		end)
		for v24, v_u_25 in p_u_12.Multipliers do
			v_u_5.assign(v24, function(p26)
				-- upvalues: (copy) v_u_15, (copy) v_u_25
				local v27 = v_u_15[p26]
				if v27 then
					if v27 > workspace:GetServerTimeNow() then
						return v_u_25
					end
					v_u_15[p26] = nil
				end
			end)
		end
	end,
	["Client"] = function(p_u_28, _)
		-- upvalues: (copy) v_u_3, (copy) v_u_6, (copy) v_u_10, (copy) v_u_8, (copy) v_u_9, (copy) v_u_5
		local v_u_29 = 0
		local function v_u_35()
			-- upvalues: (copy) p_u_28, (ref) v_u_3, (ref) v_u_6
			local v30 = {}
			for v31, v32 in p_u_28.Multipliers do
				local v33 = v_u_3[v31]
				if v33 then
					local v34 = ("%* %*"):format(v_u_6.format(v31, v32), v33.Name)
					table.insert(v30, v34)
				end
			end
			return table.concat(v30, "\n")
		end
		local v_u_36 = nil
		v_u_10.listen(function(p37)
			-- upvalues: (ref) v_u_36, (ref) v_u_29, (ref) v_u_8, (copy) p_u_28, (ref) v_u_9, (copy) v_u_35
			if v_u_36 then
				task.cancel(v_u_36)
				v_u_36 = nil
			end
			local v38 = p37 - workspace:GetServerTimeNow()
			local v_u_39 = math.max(v38, 0)
			v_u_29 = v_u_39
			if v_u_39 <= 0 then
				v_u_8:remove(script.Name)
			else
				v_u_36 = task.spawn(function()
					-- upvalues: (ref) v_u_39, (ref) v_u_29, (ref) v_u_8, (ref) p_u_28, (ref) v_u_9, (ref) v_u_35
					while v_u_39 > 0 do
						v_u_39 = v_u_39 - 1
						v_u_29 = v_u_39
						local v40 = v_u_8
						local v41 = script.Name
						local v42 = {
							["Name"] = p_u_28.Name,
							["Icon"] = p_u_28.Icon,
							["Text"] = v_u_9.format(v_u_39),
							["Tooltip"] = {
								["Title"] = p_u_28.Name,
								["Description"] = v_u_35()
							}
						}
						v40:update(v41, v42)
						task.wait(1)
					end
					v_u_8:remove(script.Name)
				end)
			end
		end)
		local v_u_43 = v_u_29
		for v44, v_u_45 in p_u_28.Multipliers do
			v_u_5.assign(v44, function(_)
				-- upvalues: (ref) v_u_43, (copy) v_u_45
				if v_u_43 <= 0 then
					return nil
				else
					return v_u_45
				end
			end)
		end
	end
}
return v46]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[FireworkBlessing]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="4017"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Products)
return {
	[v2.CrystalHearts[1]] = 200,
	[v2.CrystalHearts[2]] = 2500,
	[v2.CrystalHearts[3]] = 12500
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CrystalHeartsData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4018"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.AmuletPassiveTypes)
local v11 = {
	[v2.HeartAttack] = {
		["Name"] = "Heart Attack",
		["Icon"] = "rbxassetid://96022333579405",
		["Description"] = "When active the heart will attack slimes \nfor you dealing massive damage!",
		["Amount"] = 300,
		["Duration"] = 30
	},
	[v2.CoinStar] = {
		["Name"] = "Coin Star",
		["Icon"] = "rbxassetid://84163588806091",
		["Description"] = "When active the coin star will \nincrease your currency gain as you defeat slimes!",
		["Amount"] = 400,
		["Duration"] = 60,
		["Multiplier"] = function(p3)
			local v4 = (1 + p3 / 100) * 100
			return math.floor(v4) / 100
		end
	},
	[v2.DamageStar] = {
		["Name"] = "Damage Star",
		["Icon"] = "rbxassetid://106746371164727",
		["Description"] = "When active the damage star will \nincrease your damage as you defeat slimes!",
		["Amount"] = 200,
		["Duration"] = 60,
		["Multiplier"] = function(p5)
			local v6 = (1 + p5 / 100) * 100
			return math.floor(v6) / 100
		end
	},
	[v2.ShardStar] = {
		["Name"] = "Shard Star",
		["Icon"] = "rbxassetid://129297197332278",
		["Description"] = "When active the shard star will \nincrease your shard gain as you defeat slimes!",
		["Amount"] = 450,
		["Duration"] = 30,
		["Multiplier"] = function(p7)
			local v8 = (1 + p7 / 100) * 100
			return math.floor(v8) / 100
		end
	},
	[v2.WorldSurge] = {
		["Name"] = "World Surge",
		["Icon"] = "rbxassetid://73121279344434",
		["Description"] = "When active the world surge will \nincrease coins by 2 in a random world!",
		["Amount"] = 1000,
		["Duration"] = 300,
		["Multiplier"] = function(p9)
			local v10 = (1 + p9 / 200) * 100
			return math.floor(v10) / 100
		end
	},
	[v2.RuneRoyalty] = {
		["Name"] = "Rune Royalty",
		["Icon"] = "rbxassetid://128263943992743",
		["Description"] = "Open runes for 30s for this to trigger! \nWhen active you open runes faster!",
		["Amount"] = 30,
		["Duration"] = 30
	}
}
return v11]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AmuletPassiveData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4019"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = require(v1.Enums.ValentineTraitTypes)
local v4 = {}
local v5 = v3.Pink
local v6 = {
	["Name"] = "Pink",
	["Description"] = "+5% Valentine Damage",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(255, 155, 250)),
	["Order"] = 1,
	["Chance"] = 100,
	["Buffs"] = {
		{
			["multiplier"] = v2.ValentineDamage,
			["value"] = 1.05
		}
	}
}
v4[v5] = v6
local v7 = v3.Charm
local v8 = {
	["Name"] = "Charm",
	["Description"] = "+5% Hearts Multiplier",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(255, 91, 118)),
	["Order"] = 2,
	["Chance"] = 100,
	["Buffs"] = {
		{
			["multiplier"] = v2.HeartsMultiplier,
			["value"] = 1.05
		}
	}
}
v4[v7] = v8
local v9 = v3.Pulse
local v10 = {
	["Name"] = "Pulse",
	["Description"] = "+25% Valentine Damage",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(255, 76, 165)),
	["Order"] = 3,
	["Chance"] = 0.2,
	["Buffs"] = {
		{
			["multiplier"] = v2.ValentineDamage,
			["value"] = 1.25
		}
	}
}
v4[v9] = v10
local v11 = v3.Adore
local v12 = {
	["Name"] = "Adore",
	["Description"] = "+25% Hearts Multiplier",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(255, 81, 81)),
	["Order"] = 4,
	["Chance"] = 0.2,
	["Buffs"] = {
		{
			["multiplier"] = v2.HeartsMultiplier,
			["value"] = 1.25
		}
	}
}
v4[v11] = v12
local v13 = v3.Glitter
local v14 = {
	["Name"] = "Glitter",
	["Description"] = "+10% Valentine Rune Bulk, +10% Valentine Rune Luck",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(255, 33, 237)),
	["Order"] = 5,
	["Chance"] = 0.002,
	["Buffs"] = {
		{
			["multiplier"] = v2.ValentineRuneBulkMultiplier,
			["value"] = 1.1
		},
		{
			["multiplier"] = v2.ValentineRuneLuck,
			["value"] = 1.1
		}
	}
}
v4[v13] = v14
local v15 = v3.Shimmer
local v16 = {
	["Name"] = "Shimmer",
	["Description"] = "+75% Hearts Multiplier, +50% Valentine Damage, +10% Valentine Attack Speed",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(199, 21, 133)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 20, 147)) }),
	["Animated"] = true,
	["Order"] = 6,
	["Chance"] = 0.00001,
	["Buffs"] = {
		{
			["multiplier"] = v2.HeartsMultiplier,
			["value"] = 1.75
		},
		{
			["multiplier"] = v2.ValentineDamage,
			["value"] = 1.5
		},
		{
			["multiplier"] = v2.ValentineAttackSpeedMultiplier,
			["value"] = 1.1
		}
	}
}
v4[v15] = v16
local v17 = v3.Heartbeat
local v18 = {
	["Name"] = "Heartbeat",
	["Description"] = "+125% Hearts Multiplier, +100% Valentine Damage, +100% Valentine Rune Luck, +5% Crystal Heart Drop Chance",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 95, 188)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 166, 218)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 73, 73)) }),
	["Animated"] = true,
	["Order"] = 7,
	["Chance"] = 1e-7,
	["Buffs"] = {
		{
			["multiplier"] = v2.HeartsMultiplier,
			["value"] = 2.25
		},
		{
			["multiplier"] = v2.ValentineDamage,
			["value"] = 2
		},
		{
			["multiplier"] = v2.ValentineRuneLuck,
			["value"] = 2
		},
		{
			["multiplier"] = v2.ValentineCrystalShardDropChance,
			["value"] = 0.05
		}
	}
}
v4[v17] = v18
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ValentineTraitsData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4020"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = {}
local v4 = {
	["Name"] = "Test Boost",
	["Icon"] = "rbxassetid://1234567890",
	["Multipliers"] = {
		{
			["type"] = v2.CoinsMultiplier,
			["value"] = 1.5,
			["mathType"] = "Multiply"
		}
	}
}
v3.temp_boost_1 = v4
local v5 = {
	["Name"] = "Test Boost",
	["Icon"] = "rbxassetid://1234567890",
	["Multipliers"] = {
		{
			["type"] = v2.CoinsMultiplier,
			["value"] = 1.5,
			["mathType"] = "Multiply"
		}
	}
}
v3.temp_boost_2 = v5
local v6 = {
	["Name"] = "Gift to you!",
	["Icon"] = "rbxassetid://70754291488761",
	["Multipliers"] = {
		{
			["type"] = v2.CurrencyGainMultiplier,
			["value"] = 2,
			["mathType"] = "Multiply"
		}
	}
}
v3.leave_boost = v6
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TempBoostData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4021"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
require(v1.Enums.MultiplierTypes)
local v2 = require(v1.Enums.RuneTypes)
local v3 = require(script.Parent.SimulationEngine)
local v_u_4 = require(script.Parent.UpgradeBoardData)
local v5 = {
	["world"] = "GLOW_WORLD",
	["boardLevels"] = {},
	["treeNodes"] = {},
	["runeAmounts"] = {},
	["superRebirths"] = 0,
	["currencies"] = {
		["GlowCoins"] = 0
	}
}
local v6 = v3.createState(v5)
local v7, v8 = v3.simulate(v6, 3600, {
	["strategy"] = "bestValue",
	["logInterval"] = 300
})
print("=== FRESH GLOOP PLAYER - 1 HOUR ===")
v3.printReport(v7, v8)
local v9 = {
	["world"] = "GLOW_WORLD",
	["boardLevels"] = {
		["DAMAGE_INCREASE_4"] = 10,
		["GLOOP_SLIME_SPAWN_CAPACITY"] = 30,
		["SLIME_SPAWN_SPEED_4"] = 15,
		["GLOOP_COINS_MULTIPLIER_2"] = 3
	},
	["treeNodes"] = {
		["1-1"] = 3,
		["1-2"] = 1,
		["1-3"] = 1,
		["1-12"] = 1,
		["1-13"] = 1,
		["1-14"] = 1,
		["1-15"] = 1,
		["1-16"] = 1,
		["1-18"] = 1,
		["1-19"] = 1,
		["1-20"] = 1,
		["1-21"] = 1
	},
	["runeAmounts"] = {
		["Glop"] = 300000,
		["Ooze"] = 100000,
		["Slick"] = 20000
	},
	["amulets"] = {},
	["superRebirths"] = 5,
	["masteryTiers"] = {
		["PLAYTIME"] = 4
	},
	["currencies"] = {
		["GlowCoins"] = 500000
	}
}
local v10 = v3.createState(v9)
local v11, v12 = v3.simulate(v10, 3600, {
	["strategy"] = "bestValue",
	["logInterval"] = 300
})
print("=== MID-GAME GLOOP - 1 HOUR ===")
v3.printReport(v11, v12)
local v13 = v3.createState
local v20 = {
	["world"] = "GLOW_WORLD",
	["boardLevels"] = (function(p14)
		-- upvalues: (copy) v_u_4
		local v15 = {}
		for v16, v17 in p14 do
			local v18 = v_u_4[v16]
			if v18 then
				local v19 = v18.MaxLevel
				v15[v16] = math.min(v17, v19)
			end
		end
		return v15
	end)({
		["REBIRTH_MULTIPLIER"] = 999,
		["DAMAGE_MULTIPLIER"] = 999,
		["COIN_MULTIPLIER_2"] = 999,
		["FIRE_COIN_MULTIPLIER_1"] = 999,
		["ICE_COIN_MULTIPLIER_1"] = 99999,
		["DAMAGE_MULTIPLIER_II"] = 9999,
		["SLIME_SPAWN_CAP"] = 999,
		["SLIME_SPAWN_SPEED"] = 999,
		["SLIME_LUCK"] = 999,
		["DAMAGE_INCREASE"] = 44,
		["RANGE_INCREASE_1"] = 999,
		["COIN_MULTIPLIER"] = 999,
		["RUNE_BULK_1"] = 13,
		["RUNE_LUCK"] = 12,
		["RUNE_SPEED_MULTIPLIER_1"] = 12,
		["SLIME_SPAWN_CAP_2"] = 9999,
		["SLIME_SPAWN_SPEED_2"] = 9999,
		["SLIME_LUCK_2"] = 99999,
		["RANGE_INCREASE_2"] = 99999,
		["DAMAGE_INCREASE_2"] = 9999,
		["FIRE_COIN_MULTIPLIER_2"] = 99999,
		["DAMAGE_INCREASE_3"] = 999999,
		["ICE_COIN_MULTIPLIER_2"] = 999999,
		["SLIME_SPAWN_SPEED_3"] = 24,
		["SLIME_DURATION_1"] = 999999,
		["SLIME_DURATION_2"] = 4,
		["DAMAGE_INCREASE_4"] = 10
	}),
	["treeNodes"] = (function()
		return {
			["1-" .. 1] = 1,
			["1-" .. 2] = 1,
			["1-" .. 3] = 1,
			["1-" .. 4] = 1,
			["1-" .. 5] = 1,
			["1-" .. 6] = 1,
			["1-" .. 7] = 1,
			["1-" .. 8] = 1,
			["1-" .. 9] = 1,
			["1-" .. 10] = 1,
			["1-" .. 11] = 1,
			["1-" .. 12] = 1,
			["1-" .. 13] = 1,
			["1-" .. 14] = 1,
			["1-" .. 15] = 1,
			["1-" .. 16] = 1,
			["1-" .. 17] = 1,
			["1-" .. 18] = 1,
			["1-" .. 19] = 1,
			["1-" .. 20] = 1,
			["1-" .. 21] = 1,
			["1-" .. 22] = 1,
			["1-" .. 23] = 1,
			["1-" .. 24] = 1,
			["1-1"] = 3
		}
	end)(),
	["runeAmounts"] = {
		[v2.Mud] = 327688,
		[v2.Stone] = 258493,
		[v2.Root] = 110556,
		[v2.Moss] = 23268,
		[v2.Fungal] = 8972,
		[v2.Crystalroot] = 895,
		[v2.Ash] = 127725,
		[v2.Ember] = 53387,
		[v2.Flare] = 18354,
		[v2.Pyroclast] = 2479,
		[v2.Eruption] = 1418,
		[v2.Primordial] = 123,
		[v2.Frostmark] = 440000,
		[v2.Glacial] = 151096,
		[v2.Permafrost] = 32185,
		[v2.Cryostorm] = 1537,
		[v2.Stormfrost] = 228,
		[v2.Frostbound] = 6
	},
	["superRebirths"] = 0,
	["masteryTiers"] = {
		["PLAYTIME"] = 4,
		["COIN_COLLECTOR"] = 4,
		["FIRE_COIN_COLLECTOR"] = 4,
		["ICE_COIN_COLLECTOR"] = 4,
		["RUNES"] = 5,
		["SLIMES"] = 3
	},
	["potions"] = {},
	["currencies"] = {
		["Coins"] = 152000000,
		["FireCoins"] = 7200000000,
		["IceCoins"] = 22400000000,
		["Rebirth"] = 991730,
		["Shards"] = 304
	}
}
local v21 = v13(v20)
local v22, v23 = v3.simulate(v21, 3600, {
	["strategy"] = "bestValue",
	["logInterval"] = 300
})
print("=== LATE-GAME PRESET - 1 HOUR ===")
v3.printReport(v22, v23)
local v24 = {
	["world"] = "GLOW_WORLD",
	["boardLevels"] = {
		["DAMAGE_INCREASE_4"] = 25,
		["GLOOP_SLIME_SPAWN_CAPACITY"] = 99,
		["SLIME_SPAWN_SPEED_4"] = 38,
		["GLOOP_COINS_MULTIPLIER_2"] = 8
	},
	["superRebirths"] = 10,
	["masteryTiers"] = {
		["PLAYTIME"] = 5
	},
	["currencies"] = {}
}
local v25 = v3.createState(v24)
local v26 = v3.getDerivedStats(v25)
print("\n=== STAT SNAPSHOT ===")
print("Damage:", v26.damage)
print("Attack Interval:", string.format("%.3fs", v26.attackInterval))
print("Spawn Cap:", v26.spawnCap)
print("Spawn Rate:", string.format("%.3fs", v26.spawnRate))
local v27 = print
local v28 = v26.totalDPS
v27("Total DPS:", (math.floor(v28)))
local v29 = print
local v30 = v26.avgSlimeHP * v26.currencyMulti * v26.statsMulti * v26.variantEV * v26.coinGain
v29("Coins/Kill:", (math.floor(v30)))
local v_u_31 = {
	["world"] = "GLOW_WORLD",
	["boardLevels"] = {},
	["currencies"] = {
		["GlowCoins"] = 0
	},
	["superRebirths"] = 0,
	["masteryTiers"] = {
		["PLAYTIME"] = 4
	}
}
local v32 = v3.compare
local v33 = {}
local v34 = {
	["name"] = "With 10 Super Rebirths"
}
local v35 = table.clone(v_u_31)
v35.superRebirths = 10
v34.config = v35
__set_list(v33, 1, {{
	["name"] = "Current Balance",
	["config"] = v_u_31
}, v34, {
	["name"] = "With Potions + Blessing",
	["config"] = (function()
		-- upvalues: (copy) v_u_31
		local v36 = table.clone(v_u_31)
		v36.potions = { "Stats", "Damage" }
		v36.blessings = {
			["IceBlessing"] = true
		}
		return v36
	end)()
}})
v32(v33, 3600, "bestValue")]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SimulationExamples]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4022"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.MultiplierData)
local v_u_3 = require(v1.Config.WorldData)
local v_u_4 = require(v1.Config.SlimeData)
local v_u_5 = require(v1.Config.CurrencyData)
local v_u_6 = require(v1.Config.SlimeVarientData)
local v_u_7 = require(v1.Config.RuneData)
local v_u_8 = require(v1.Config.SuperRebirthData)
local v_u_9 = require(v1.Config.PotionData)
local v_u_10 = require(v1.Config.UpgradeTreeData)
local v_u_11 = require(v1.Enums.MultiplierTypes)
local v_u_12 = require(v1.Enums.SlimeVarientTypes)
local v_u_13 = require(v1.Config.UpgradeBoardData)
local v_u_19 = {
	["get"] = function(p14, p15)
		-- upvalues: (copy) v_u_2
		local v16 = v_u_2[p14]
		if not v16 then
			return 1
		end
		local v17 = v16.Base
		for _, v18 in p15 do
			if v18 then
				if v16.Merge then
					v17 = v16.Merge(v17, v18)
				else
					v17 = v16.Calculate(v17, v18)
				end
			end
		end
		return v16.Calculate(v16.Default, v17)
	end
}
local v_u_61 = {
	["computeBoardContributions"] = function(p20)
		-- upvalues: (copy) v_u_13
		local v21 = {}
		for v22, v23 in p20 do
			if v23 > 0 then
				local v24 = v_u_13[v22]
				if v24 then
					v21[v24.MultiplierType] = (v21[v24.MultiplierType] or 0) + v24.CalculateMultiplier(v24, v23)
				end
			end
		end
		return v21
	end,
	["computeTreeContributions"] = function(p25)
		-- upvalues: (copy) v_u_10
		local v26 = {}
		for v27, v28 in p25 do
			if v28 > 0 then
				local _, v29 = string.match(v27, "^(%d+)-(%d+)$")
				local v30 = tonumber(v29)
				if v30 then
					local v31 = v_u_10[v30]
					if v31 then
						local v32 = v31.Levels[v28]
						if v32 and v32.Multipliers then
							for _, v33 in v32.Multipliers do
								v26[v33.type] = v26[v33.type] or {}
								v26[v33.type]["tree_" .. v27] = v33.value
							end
						end
					end
				end
			end
		end
		return v26
	end,
	["computeRuneContributions"] = function(p34)
		-- upvalues: (copy) v_u_7, (copy) v_u_2
		local v35 = {}
		for v36, v37 in p34 do
			if v37 > 0 then
				local v38 = v_u_7[v36]
				if v38 then
					for _, v39 in v38.Buffs do
						local v40 = v_u_2[v39.type]
						if v40 then
							local v41 = v37 * v39.value
							local v42 = v39.max or (1 / 0)
							local v43 = math.min(v41, v42)
							local v44
							if v40.RuneTransform then
								v44 = v40.RuneTransform(v43)
							else
								v44 = v43 + 1
							end
							v35[v39.type] = v35[v39.type] or {}
							v35[v39.type]["rune_" .. v36] = v44
						end
					end
				end
			end
		end
		return v35
	end,
	["computeSuperRebirthContributions"] = function(p45)
		-- upvalues: (copy) v_u_8
		local v46 = {}
		if p45 <= 0 then
			return v46
		end
		for _, v47 in v_u_8.Benefits do
			if v47.MultiplierType and v47.Calculate then
				v46[v47.MultiplierType] = v47:Calculate(p45)
			end
		end
		return v46
	end,
	["computePotionContributions"] = function(p48)
		-- upvalues: (copy) v_u_9
		local v49 = {}
		for _, v50 in p48 do
			local v51 = v_u_9[v50]
			if v51 and v51.Multiplier then
				v49[v51.Multiplier] = v51.MultiplierValue
			end
		end
		return v49
	end,
	["computeBlessingContributions"] = function(p52)
		-- upvalues: (copy) v_u_11
		local v53 = {}
		if not p52 then
			return v53
		end
		if p52.IceBlessing then
			for v54, v55 in {
				[v_u_11.IceCoinsMultiplier] = 1.25,
				[v_u_11.DamageMultiplier] = 1.1,
				[v_u_11.AttackRangeMultiplier] = 1.1
			} do
				v53[v54] = v53[v54] or {}
				v53[v54].blessing_ice = v55
			end
		end
		if p52.ValentineBlessing and p52.ValentineBlessing > 0 then
			local v56 = p52.ValentineBlessing
			local v57 = math.clamp(v56, 0, 1)
			for v58, v59 in {
				[v_u_11.WalkspeedMultiplier] = { 1.01, 1.25 },
				[v_u_11.CurrencyGainMultiplier] = { 1.01, 1.5 },
				[v_u_11.ShardMultiplier] = { 1.01, 1.5 },
				[v_u_11.HeartsMultiplier] = { 1.01, 2 }
			} do
				v53[v58] = v53[v58] or {}
				v53[v58].blessing_valentine = v59[1] + (v59[2] - v59[1]) * v57
			end
		end
		return v53
	end,
	["computeWeekendContributions"] = function(p60)
		-- upvalues: (copy) v_u_11
		return p60 and {
			[v_u_11.SkillXPMultiplier] = 1.5,
			[v_u_11.RuneLuckMultiplier] = 1.5,
			[v_u_11.RuneBulk] = 25,
			[v_u_11.ValentineTraitsLuckMultiplier] = 1.25
		} or {}
	end
}
local v_u_62 = {}
local v63 = {
	{
		[v_u_11.StatsMultiplier] = 1.1
	},
	{
		[v_u_11.StatsMultiplier] = 1.25
	},
	{
		[v_u_11.StatsMultiplier] = 1.5
	},
	{
		[v_u_11.StatsMultiplier] = 2
	},
	{
		[v_u_11.StatsMultiplier] = 2.5
	},
	{
		[v_u_11.StatsMultiplier] = 3
	},
	{
		[v_u_11.StatsMultiplier] = 3.5
	},
	{
		[v_u_11.StatsMultiplier] = 4
	},
	{
		[v_u_11.StatsMultiplier] = 4.5
	},
	{
		[v_u_11.StatsMultiplier] = 5
	}
}
v_u_62.PLAYTIME = v63
function v_u_61.computeMasteryContributions(p64)
	-- upvalues: (copy) v_u_62
	local v65 = {}
	for v66, v67 in p64 do
		if v67 > 0 then
			local v68 = v_u_62[v66]
			if v68 and v68[v67] then
				for v69, v70 in v68[v67] do
					v65[v69] = v65[v69] or {}
					v65[v69]["mastery_" .. v66] = v70
				end
			end
		end
	end
	return v65
end
function v_u_61.build(p71)
	-- upvalues: (copy) v_u_61, (copy) v_u_3
	local v72 = p71.boardLevels and (table.clone(p71.boardLevels) or {}) or {}
	local v73 = v_u_61.computeBoardContributions(v72)
	local v74 = v_u_61.computeTreeContributions(p71.treeNodes or {})
	local v75 = v_u_61.computeRuneContributions(p71.runeAmounts or {})
	local v76 = v_u_61.computeSuperRebirthContributions(p71.superRebirths or 0)
	local v77 = v_u_61.computePotionContributions(p71.potions or {})
	local v78 = v_u_61.computeBlessingContributions(p71.blessings)
	local v79 = v_u_61.computeWeekendContributions(p71.weekendBuffs or false)
	local v80 = v_u_61.computeMasteryContributions(p71.masteryTiers or {})
	local v_u_81 = {}
	local function v86(p82, p83)
		-- upvalues: (copy) v_u_81
		for v84, v85 in p83 do
			v_u_81[v84] = v_u_81[v84] or {}
			v_u_81[v84][p82] = v85
		end
	end
	local function v92(p87)
		-- upvalues: (copy) v_u_81
		for v88, v89 in p87 do
			v_u_81[v88] = v_u_81[v88] or {}
			for v90, v91 in v89 do
				v_u_81[v88][v90] = v91
			end
		end
	end
	v86("board", v73)
	v92(v74)
	v92(v75)
	v86("superRebirth", v76)
	v86("potion", v77)
	v92(v78)
	v86("weekend", v79)
	v92(v80)
	if p71.amulets then
		for v93, v94 in p71.amulets do
			for v95, v96 in v94 do
				v_u_81[v95] = v_u_81[v95] or {}
				v_u_81[v95]["amulet_" .. v93] = v96
			end
		end
	end
	if p71.extraContributions then
		v86("extra", p71.extraContributions)
	end
	local v97 = v_u_3[p71.world]
	return {
		["multipliers"] = v_u_81,
		["boardLevels"] = v72,
		["currencies"] = table.clone(p71.currencies or {}),
		["world"] = p71.world,
		["worldCurrencyType"] = v97 and v97.WorldSurgeCurrency or "Coins",
		["slimesKilled"] = 0,
		["time"] = 0,
		["totalSpent"] = {}
	}
end
local v_u_98 = {}
local function v_u_106(p99, p100)
	-- upvalues: (copy) v_u_13
	local v101 = 0
	for v102, v103 in v_u_13 do
		if v103.MultiplierType == p100 then
			local v104 = p99.boardLevels[v102] or 0
			if v104 > 0 then
				v101 = v101 + v103.CalculateMultiplier(v103, v104)
			end
		end
	end
	p99.multipliers[p100] = p99.multipliers[p100] or {}
	local v105 = p99.multipliers[p100]
	if v101 <= 0 then
		v101 = nil
	end
	v105.board = v101
end
local function v_u_200(p107)
	-- upvalues: (copy) v_u_3, (copy) v_u_19, (copy) v_u_11, (copy) v_u_5, (copy) v_u_6, (copy) v_u_12, (copy) v_u_4
	local v108 = v_u_3[p107.world]
	if not v108 then
		local v109 = error
		local v110 = p107.world
		v109("Invalid world: " .. tostring(v110))
	end
	local v111
	if v108.Damage then
		local v112 = v108.Damage.base
		v111 = v_u_19.get(v112, p107.multipliers[v112] or {}) or 1
	else
		v111 = 1
	end
	local v113
	if v108.Damage then
		local v114 = v108.Damage.multi
		v113 = v_u_19.get(v114, p107.multipliers[v114] or {}) or 1
	else
		v113 = 1
	end
	local v115 = v111 * v113
	local v116 = math.ceil(v115)
	local v117
	if v108.Attack then
		local v118 = v108.Attack.base
		v117 = v_u_19.get(v118, p107.multipliers[v118] or {}) or 1
	else
		v117 = 1
	end
	local v119
	if v108.Attack then
		local v120 = v108.Attack.multi
		v119 = v_u_19.get(v120, p107.multipliers[v120] or {}) or 1
	else
		v119 = 1
	end
	local v121 = v117 / v119
	local v122 = math.max(v121, 0.01)
	local v123, v124
	if v108.Multipliers then
		local v125 = v108.Multipliers.SpawnCap
		v123 = v_u_19.get(v125, p107.multipliers[v125] or {})
		local v126 = v108.Multipliers.SpawnRate
		v124 = v_u_19.get(v126, p107.multipliers[v126] or {})
	else
		v124 = 1
		v123 = 2
	end
	local v127 = math.max(v124, 0.1)
	local v128 = v_u_11.CriticalHitChance
	local v129 = v_u_19.get(v128, p107.multipliers[v128] or {})
	local v130 = v_u_11.CriticalHitMultiplier
	local v131 = 1 + v129 * (v_u_19.get(v130, p107.multipliers[v130] or {}) - 1)
	local v132 = v_u_5[p107.worldCurrencyType]
	local v133
	if v132 and v132.multiplier then
		local v134 = v132.multiplier
		v133 = v_u_19.get(v134, p107.multipliers[v134] or {}) or 1
	else
		v133 = 1
	end
	local v135 = v_u_11.Stats
	local v136 = v_u_19.get(v135, p107.multipliers[v135] or {})
	local v137 = v_u_11.StatsMultiplier
	local v138 = v136 * v_u_19.get(v137, p107.multipliers[v137] or {})
	local v139 = v_u_11.CurrencyGain
	local v140 = v_u_19.get(v139, p107.multipliers[v139] or {})
	local v141 = v_u_11.CurrencyGainMultiplier
	local v142 = v140 * v_u_19.get(v141, p107.multipliers[v141] or {})
	local v143 = v_u_11.RainbowChance
	local v144 = v_u_19.get(v143, p107.multipliers[v143] or {})
	local v145 = v_u_11.DiamondChance
	local v146 = v_u_19.get(v145, p107.multipliers[v145] or {})
	local v147 = v_u_11.GoldenChance
	local v148 = v_u_19.get(v147, p107.multipliers[v147] or {})
	local v149 = v_u_6[v_u_12.Rainbow] and v_u_6[v_u_12.Rainbow].Multiplier or 2
	local v150 = v_u_6[v_u_12.Diamond] and v_u_6[v_u_12.Diamond].Multiplier or 1.5
	local v151 = v_u_6[v_u_12.Golden] and v_u_6[v_u_12.Golden].Multiplier or 1.25
	local v152 = v144 * v149
	local v153 = v146 - v144
	local v154 = v152 + math.max(0, v153) * v150
	local v155 = v148 - v146
	local v156 = v154 + math.max(0, v155) * v151
	local v157 = 1 - v148
	local v158 = v156 + math.max(0, v157) * 1
	local v159 = 0
	local v160 = 0
	if v108.Slimes then
		for v161, v162 in v108.Slimes do
			local v163 = v_u_4[v161]
			if v163 then
				v159 = v159 + v163.Health * v162
				v160 = v160 + v162
			end
		end
		if v160 > 0 then
			v159 = v159 / v160
		end
	end
	local v164 = v159 <= 0 and 100 or v159
	local v165 = v_u_11.ComboMultiplier
	local v166 = v_u_19.get(v165, p107.multipliers[v165] or {})
	local v167 = (v123 < 3 or v166 <= 0) and 1 or 1 + 0.8999999999999999 * v166
	local v168 = v_u_11.LightingStrikeCooldown
	local v169 = v_u_19.get(v168, p107.multipliers[v168] or {})
	local v170 = v_u_11.LightingStrikes
	local v171 = v_u_19.get(v170, p107.multipliers[v170] or {})
	local v172 = v_u_11.LightingStrikeDamage
	local v173 = v_u_19.get(v172, p107.multipliers[v172] or {})
	local v174 = v_u_11.LightingDoubleStrikeChance
	local v175 = v_u_19.get(v174, p107.multipliers[v174] or {})
	local v176 = (v169 <= 0 or (v171 <= 0 or v173 <= 0)) and 0 or v116 * v173 * v131 * v171 * (1 + v175) / math.max(v169, 0.1)
	local v177 = v_u_11.ArrowCooldown
	local v178 = v_u_19.get(v177, p107.multipliers[v177] or {})
	local v179 = v_u_11.ArrowFired
	local v180 = v_u_19.get(v179, p107.multipliers[v179] or {})
	local v181 = v_u_11.ArrowDamage
	local v182 = v_u_19.get(v181, p107.multipliers[v181] or {})
	local v183 = v_u_11.ArrowRain
	local v184 = v_u_19.get(v183, p107.multipliers[v183] or {})
	local v185
	if v178 > 0 and v180 > 0 then
		local v186 = v180 * (1 - v184) + 20 * v184
		v185 = v116 * v182 * v131 * v186 / math.max(v178, 0.1)
	else
		v185 = 0
	end
	local v187 = v_u_11.FreezeCooldown
	local v188 = v_u_19.get(v187, p107.multipliers[v187] or {})
	local v189 = v_u_11.FreezeAmount
	local v190 = v_u_19.get(v189, p107.multipliers[v189] or {})
	local v191 = v_u_11.FreezeDamage
	local v192 = v_u_19.get(v191, p107.multipliers[v191] or {})
	local v193 = v_u_11.FreezeDoubleChance
	local v194 = v_u_19.get(v193, p107.multipliers[v193] or {})
	local v195
	if v188 > 0 and (v190 > 0 and v192 > 0) then
		local v196 = v123 * v190
		local v197 = math.floor(v196)
		local v198 = math.max(1, v197)
		v195 = v116 * v192 * v131 * 5 * v198 * (1 + v194) / math.max(v188, 0.1)
	else
		v195 = 0
	end
	local v199 = v116 * v131 * math.min(v123, 20) / v122
	return {
		["damage"] = v116,
		["critEV"] = v131,
		["attackInterval"] = v122,
		["spawnCap"] = v123,
		["spawnRate"] = v127,
		["avgSlimeHP"] = v164,
		["currencyMulti"] = v133,
		["statsMulti"] = v138,
		["coinGain"] = v142,
		["variantEV"] = v158,
		["comboBonus"] = v167,
		["baseDPS"] = v199,
		["lightningDPS"] = v176,
		["arrowDPS"] = v185,
		["icyWindDPS"] = v195,
		["totalDPS"] = v199 + v176 + v185 + v195
	}
end
local function v_u_228(p201, p202)
	-- upvalues: (copy) v_u_13, (copy) v_u_200, (copy) v_u_106
	local v203 = {}
	for v204, v205 in v_u_13 do
		local v206 = p201.boardLevels[v204] or 0
		if v205.MaxLevel > v206 then
			local v207 = v205.CalculateCost(v205, v206 + 1)
			if v207 <= (p201.currencies[v205.CurrencyType] or 0) then
				table.insert(v203, {
					["name"] = v204,
					["def"] = v205,
					["cost"] = v207,
					["level"] = v206
				})
			end
		end
	end
	if #v203 == 0 then
		return false
	end
	local v208 = nil
	if p202 == "cheapest" then
		local v209 = (1 / 0)
		for _, v210 in v203 do
			if v210.cost < v209 then
				v209 = v210.cost
				v208 = v210
			end
		end
	else
		local v211 = v_u_200(p201)
		local v212 = v211.totalDPS
		local v213 = v211.avgSlimeHP
		local v214 = v212 / math.max(v213, 1) * v211.avgSlimeHP * v211.currencyMulti * v211.statsMulti * v211.variantEV * v211.coinGain * v211.comboBonus
		local v215 = 0
		for _, v216 in v203 do
			p201.boardLevels[v216.name] = v216.level + 1
			v_u_106(p201, v216.def.MultiplierType)
			local v217 = v_u_200(p201)
			local v218 = v217.totalDPS
			local v219 = v217.avgSlimeHP
			local v220 = v218 / math.max(v219, 1) * v217.avgSlimeHP * v217.currencyMulti * v217.statsMulti * v217.variantEV * v217.coinGain * v217.comboBonus
			p201.boardLevels[v216.name] = v216.level
			v_u_106(p201, v216.def.MultiplierType)
			local v221 = v220 - v214
			local v222 = v216.cost
			local v223 = v221 / math.max(v222, 1)
			if v215 < v223 then
				v208 = v216
				v215 = v223
			end
		end
		if not v208 then
			local v224 = (1 / 0)
			for _, v225 in v203 do
				if v225.cost < v224 then
					v224 = v225.cost
					v208 = v225
				end
			end
		end
	end
	if not v208 then
		return false
	end
	local v226 = p201.currencies
	local v227 = v208.def.CurrencyType
	v226[v227] = v226[v227] - v208.cost
	p201.boardLevels[v208.name] = v208.level + 1
	p201.totalSpent[v208.def.CurrencyType] = (p201.totalSpent[v208.def.CurrencyType] or 0) + v208.cost
	v_u_106(p201, v208.def.MultiplierType)
	return true
end
function v_u_98.simulate(p229, p230, p231)
	-- upvalues: (copy) v_u_200, (copy) v_u_11, (copy) v_u_19, (copy) v_u_228
	local v232 = p231 or {}
	local v233 = v232.strategy or "none"
	local v234 = v232.logInterval or 300
	local v235 = v232.tickSize or 1
	local v236 = v232.maxBuysPerTick or 100
	local v237 = v234
	local v238 = 0
	local v239 = {}
	while v238 < p230 do
		local v240 = p230 - v238
		local v241 = math.min(v235, v240)
		local v242 = v_u_200(p229)
		local v243 = v242.avgSlimeHP
		local v244 = v242.totalDPS
		local v245 = v243 / math.max(v244, 0.01)
		local v246 = v242.spawnCap
		local v247 = v242.spawnRate
		local v248 = v246 / math.max(v245, v247)
		local v249 = v242.totalDPS
		local v250 = v242.avgSlimeHP
		local v251 = v249 / math.max(v250, 1)
		local v252 = math.min(v248, v251)
		local v253 = v252 * v241
		local v254 = v242.avgSlimeHP * v242.currencyMulti * v242.statsMulti * v242.comboBonus * v242.variantEV * v242.coinGain
		p229.slimesKilled = p229.slimesKilled + v253
		local v255 = p229.currencies
		local v256 = p229.worldCurrencyType
		local v257 = p229.currencies[p229.worldCurrencyType] or 0
		local v258 = v253 * v254
		v255[v256] = v257 + math.floor(v258)
		local v259 = v_u_11.ShardDropChance
		local v260 = v_u_19.get(v259, p229.multipliers[v259] or {})
		local v261 = v_u_11.ShardMultiplier
		local v262 = v_u_19.get(v261, p229.multipliers[v261] or {})
		if v260 > 0 then
			local v263 = v253 * v260 * v262
			local v264 = math.floor(v263)
			if v264 > 0 then
				p229.currencies.Shards = (p229.currencies.Shards or 0) + v264
			end
		end
		if v233 ~= "none" then
			for _ = 1, v236 do
				if not v_u_228(p229, v233) then
					break
				end
			end
		end
		v238 = v238 + v241
		p229.time = v238
		if v234 <= v238 then
			local v265 = {
				["time"] = v238,
				["currency"] = p229.currencies[p229.worldCurrencyType] or 0,
				["killsPerSec"] = v252,
				["totalKills"] = p229.slimesKilled,
				["coinsPerKill"] = v254,
				["dps"] = v242.totalDPS,
				["boardLevels"] = table.clone(p229.boardLevels)
			}
			table.insert(v239, v265)
			v234 = v234 + v237
		end
	end
	return p229, v239
end
function v_u_98.printReport(p266, p267)
	-- upvalues: (copy) v_u_13, (copy) v_u_200
	print("\n========================================================")
	print("              SIMULATION REPORT")
	print("========================================================")
	print(string.format("  World:          %s", p266.world))
	local v268 = print
	local v269 = string.format
	local v270 = p266.time / 60
	v268(v269("  Duration:       %dm %ds", math.floor(v270), p266.time % 60))
	local v271 = print
	local v272 = string.format
	local v273 = p266.slimesKilled
	local v274 = math.floor(v273)
	v271(v272("  Slimes Killed:  %s", (tostring(v274))))
	print("\n--- Currencies ---")
	for v275, v276 in p266.currencies do
		if v276 > 0 then
			local v277 = print
			local v278 = string.format
			local v279 = tostring(v275)
			local v280 = math.floor(v276)
			v277(v278("  %-16s %s", v279, (tostring(v280))))
		end
	end
	if next(p266.totalSpent) then
		print("\n--- Total Spent ---")
		for v281, v282 in p266.totalSpent do
			local v283 = print
			local v284 = string.format
			local v285 = tostring(v281)
			local v286 = math.floor(v282)
			v283(v284("  %-16s %s", v285, (tostring(v286))))
		end
	end
	print("\n--- Upgrade Levels ---")
	local v287 = {}
	for v288, v289 in p266.boardLevels do
		if v289 > 0 then
			table.insert(v287, {
				["name"] = v288,
				["level"] = v289
			})
		end
	end
	table.sort(v287, function(p290, p291)
		return p290.level > p291.level
	end)
	for _, v292 in v287 do
		local v293 = v_u_13[v292.name]
		local v294 = print
		local v295 = string.format
		local v296 = v292.name
		local v297 = v292.level
		local v298 = v293 and v293.MaxLevel or "?"
		v294(v295("  %-35s Lv %d / %s", v296, v297, (tostring(v298))))
	end
	local v299 = v_u_200(p266)
	local v300 = v299.avgSlimeHP * v299.currencyMulti * v299.statsMulti * v299.variantEV * v299.coinGain * v299.comboBonus
	print("\n--- Final Stats ---")
	local v301 = print
	local v302 = string.format
	local v303 = v299.damage
	local v304 = math.floor(v303)
	v301(v302("  Damage:         %s", (tostring(v304))))
	print(string.format("  Attack Speed:   %.3fs", v299.attackInterval))
	print(string.format("  Spawn Cap:      %.0f", v299.spawnCap))
	print(string.format("  Spawn Rate:     %.3fs", v299.spawnRate))
	local v305 = print
	local v306 = string.format
	local v307 = v299.totalDPS
	local v308 = math.floor(v307)
	v305(v306("  Total DPS:      %s", (tostring(v308))))
	local v309 = print
	local v310 = string.format
	local v311 = math.floor(v300)
	v309(v310("  Coins/Kill:     %s", (tostring(v311))))
	local v312 = print
	local v313 = string.format
	local v314 = v299.lightningDPS
	local v315 = math.floor(v314)
	v312(v313("  Lightning DPS:  %s", (tostring(v315))))
	local v316 = print
	local v317 = string.format
	local v318 = v299.arrowDPS
	local v319 = math.floor(v318)
	v316(v317("  Arrow DPS:      %s", (tostring(v319))))
	local v320 = print
	local v321 = string.format
	local v322 = v299.icyWindDPS
	local v323 = math.floor(v322)
	v320(v321("  IcyWind DPS:    %s", (tostring(v323))))
	print(string.format("  Crit EV:        %.2fx", v299.critEV))
	print(string.format("  Variant EV:     %.3fx", v299.variantEV))
	if #p267 > 0 then
		print("\n--- Progression ---")
		print(string.format("  %-6s %-12s %-16s %-12s %-10s", "Time", "Kills/s", "Currency", "Coins/Kill", "DPS"))
		for _, v324 in p267 do
			local v325 = print
			local v326 = string.format
			local v327 = string.format("%dm", v324.time / 60)
			local v328 = string.format("%.1f", v324.killsPerSec)
			local v329 = v324.currency
			local v330 = math.floor(v329)
			local v331 = tostring(v330)
			local v332 = v324.coinsPerKill
			local v333 = math.floor(v332)
			local v334 = tostring(v333)
			local v335 = v324.dps
			local v336 = math.floor(v335)
			v325(v326("  %-6s %-12s %-16s %-12s %-10s", v327, v328, v331, v334, (tostring(v336))))
		end
	end
	print("========================================================\n")
end
function v_u_98.compare(p337, p338, p339)
	-- upvalues: (copy) v_u_61, (copy) v_u_98
	print(string.format("\n=== COMPARE | %dm | %s ===", p338 / 60, p339 or "bestValue"))
	local v340 = {}
	for _, v341 in p337 do
		local v342 = v_u_61.build(v341.config)
		local v343 = v_u_98.simulate(v342, p338, {
			["strategy"] = p339 or "bestValue"
		})
		local v344 = {
			["name"] = v341.name,
			["state"] = v343
		}
		table.insert(v340, v344)
	end
	print(string.format("  %-25s %-18s %-14s", "Build", "Currency", "Kills"))
	print("  " .. string.rep("-", 60))
	local v345 = v340[1]
	for _, v346 in v340 do
		local v347 = v346.state.currencies[v346.state.worldCurrencyType] or 0
		local v348
		if v346 == v345 then
			v348 = ""
		else
			local v349 = v345.state.currencies[v345.state.worldCurrencyType] or 1
			v348 = string.format(" (%+.1f%%)", (v347 / v349 - 1) * 100)
		end
		local v350 = print
		local v351 = string.format
		local v352 = v346.name
		local v353 = math.floor(v347)
		local v354 = tostring(v353) .. v348
		local v355 = v346.state.slimesKilled
		local v356 = math.floor(v355)
		v350(v351("  %-25s %-18s %-14s", v352, v354, (tostring(v356))))
	end
	print("")
end
return {
	["createState"] = v_u_61.build,
	["simulate"] = v_u_98.simulate,
	["printReport"] = v_u_98.printReport,
	["compare"] = v_u_98.compare,
	["getMult"] = function(p357, p358)
		-- upvalues: (copy) v_u_19
		return v_u_19.get(p358, p357.multipliers[p358] or {})
	end,
	["getDerivedStats"] = v_u_200,
	["AllBoardData"] = v_u_13,
	["UpgradeTreeData"] = v_u_10
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SimulationEngine]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4023"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.GloopTypes)
local v3 = {}
local v4 = v2.Green
local v5 = {
	["Name"] = "Green Gloop",
	["Icon"] = "rbxassetid://118458749917969",
	["Description"] = "100% Chance but gives small buffs",
	["Chance"] = 100,
	["Color"] = Color3.fromRGB(0, 255, 0),
	["Order"] = 1,
	["DropChance"] = 0.0003333333333333333,
	["Buffs"] = {
		["Multiplier"] = 0.02
	}
}
v3[v4] = v5
local v6 = v2.Yellow
local v7 = {
	["Name"] = "Yellow Gloop",
	["Icon"] = "rbxassetid://107216977069574",
	["Description"] = "75% Chance but gives medium buffs \n25% chance of breaking",
	["Chance"] = 75,
	["Color"] = Color3.fromRGB(255, 238, 0),
	["Order"] = 2,
	["DropChance"] = 0.0001,
	["Buffs"] = {
		["Multiplier"] = 0.05
	}
}
v3[v6] = v7
local v8 = v2.Pink
local v9 = {
	["Name"] = "Pink Gloop",
	["Icon"] = "rbxassetid://92918716959573",
	["Description"] = "50% Chance but gives rare buffs \n50% chance of breaking",
	["Chance"] = 50,
	["Color"] = Color3.fromRGB(255, 103, 128),
	["Order"] = 3,
	["DropChance"] = 0.00002,
	["Buffs"] = {
		["Multiplier"] = 0.1
	}
}
v3[v8] = v9
local v10 = v2.Purple
local v11 = {
	["Name"] = "Purple Gloop",
	["Icon"] = "rbxassetid://132570466720809",
	["Description"] = "25% Chance gives more buffs \n75% chance of breaking",
	["Chance"] = 25,
	["Color"] = Color3.fromRGB(128, 0, 128),
	["Order"] = 4,
	["DropChance"] = 0.00001,
	["Buffs"] = {
		["Multiplier"] = 0.15
	}
}
v3[v10] = v11
v3[v2.Spiked] = {
	["Name"] = "Spiked Gloop",
	["Icon"] = "rbxassetid://118869391640825",
	["Description"] = "Removes all gloops and fixes broken amulets.",
	["Color"] = Color3.fromRGB(255, 0, 0),
	["Order"] = 5,
	["DropChance"] = 1e-6,
	["Chance"] = 100,
	["Buffs"] = {}
}
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GloopData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4024"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.GloopTypes)
local v4 = require(v1.Enums.ItemTypes)
local v5 = require(v1.Enums.LockTypes)
local v6 = require(v1.Enums.PotionTypes)
local v7 = require(v1.Enums.Products)
local v8 = require(v1.Enums.WorldTypes)
local v9 = {}
local v10 = {
	["Id"] = v7.Pack.Gloop
}
local v11 = {
	[v5.World] = {
		["value"] = v8.GLOW_WORLD
	}
}
v10.LockedData = v11
v10.Rewards = {
	{
		["ItemType"] = v4.Gloop,
		["Key"] = v3.Green,
		["Amount"] = 10
	},
	{
		["ItemType"] = v4.Gloop,
		["Key"] = v3.Yellow,
		["Amount"] = 8
	},
	{
		["ItemType"] = v4.Gloop,
		["Key"] = v3.Pink,
		["Amount"] = 5
	},
	{
		["ItemType"] = v4.Gloop,
		["Key"] = v3.Purple,
		["Amount"] = 3
	},
	{
		["ItemType"] = v4.Gloop,
		["Key"] = v3.Spiked,
		["Amount"] = 1
	},
	{
		["ItemType"] = v4.RuneOpen,
		["Key"] = "GLOOP_RUNES",
		["Amount"] = 10
	}
}
v9.GloopPack = v10
local v12 = {
	["Id"] = v7.Pack.Skill,
	["Rewards"] = {
		{
			["ItemType"] = v4.SkillXP,
			["Amount"] = 20000
		},
		{
			["ItemType"] = v4.Currency,
			["Key"] = v2.Tokens,
			["Amount"] = 300
		},
		{
			["ItemType"] = v4.Potions,
			["Key"] = v6.Stats,
			["Amount"] = 1
		},
		{
			["ItemType"] = v4.RuneOpen,
			["Key"] = "GLOOP_RUNES",
			["Amount"] = 5
		}
	}
}
v9.SkilledPack = v12
return v9]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[StorePackData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4025"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = require(v1.Enums.MillionaireTraitTypes)
local v4 = {}
local v5 = v3.Spark
local v6 = {
	["Name"] = "Spark",
	["Description"] = "+5% Balloon Multiplier",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(255, 220, 100)),
	["Order"] = 1,
	["Chance"] = 100,
	["Buffs"] = {
		{
			["multiplier"] = v2.Event1MBalloonsMultiplier,
			["value"] = 1.05
		}
	}
}
v4[v5] = v6
local v7 = v3.Glow
local v8 = {
	["Name"] = "Glow",
	["Description"] = "+5% Confetti Multiplier",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(81, 235, 255)),
	["Order"] = 2,
	["Chance"] = 100,
	["Buffs"] = {
		{
			["multiplier"] = v2.ConfettiMultiplier,
			["value"] = 1.05
		}
	}
}
v4[v7] = v8
local v9 = v3.Flash
local v10 = {
	["Name"] = "Flash",
	["Description"] = "+18% Balloon Multiplier",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(255, 180, 50)),
	["Order"] = 3,
	["Chance"] = 0.125,
	["Buffs"] = {
		{
			["multiplier"] = v2.Event1MBalloonsMultiplier,
			["value"] = 1.18
		}
	}
}
v4[v9] = v10
local v11 = v3.Dazzle
local v12 = {
	["Name"] = "Dazzle",
	["Description"] = "+18% Confetti Multiplier",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(50, 200, 255)),
	["Order"] = 4,
	["Chance"] = 0.125,
	["Buffs"] = {
		{
			["multiplier"] = v2.ConfettiMultiplier,
			["value"] = 1.18
		}
	}
}
v4[v11] = v12
local v13 = v3.Radiance
local v14 = {
	["Name"] = "Radiance",
	["Description"] = "+6% 1M Rune Bulk, +6% 1M Rune Luck",
	["Gradient"] = ColorSequence.new(Color3.fromRGB(255, 150, 30)),
	["Order"] = 5,
	["Chance"] = 0.0006666666666666666,
	["Buffs"] = {
		{
			["multiplier"] = v2.Event1MRuneBulkMultiplier,
			["value"] = 1.06
		},
		{
			["multiplier"] = v2.Event1MRuneLuck,
			["value"] = 1.06
		}
	}
}
v4[v13] = v14
local v15 = v3.Brilliance
local v16 = {
	["Name"] = "Brilliance",
	["Description"] = "+45% Balloon Multiplier, +30% Confetti Multiplier, +6% 1M Attack Speed",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 50)) }),
	["Animated"] = true,
	["Order"] = 6,
	["Chance"] = 3.3333333333333333e-6,
	["Buffs"] = {
		{
			["multiplier"] = v2.Event1MBalloonsMultiplier,
			["value"] = 1.45
		},
		{
			["multiplier"] = v2.ConfettiMultiplier,
			["value"] = 1.3
		},
		{
			["multiplier"] = v2.Event1MAttackSpeedMultiplier,
			["value"] = 1.06
		}
	}
}
v4[v15] = v16
local v17 = v3.Supernova
local v18 = {
	["Name"] = "Supernova",
	["Description"] = "+85% Balloon Multiplier, +65% Confetti Multiplier, +65% 1M Rune Luck, +30% 1M Damage",
	["Gradient"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 50)) }),
	["Animated"] = true,
	["Order"] = 7,
	["Chance"] = 2e-8,
	["Buffs"] = {
		{
			["multiplier"] = v2.Event1MBalloonsMultiplier,
			["value"] = 1.85
		},
		{
			["multiplier"] = v2.ConfettiMultiplier,
			["value"] = 1.65
		},
		{
			["multiplier"] = v2.Event1MRuneLuck,
			["value"] = 1.65
		},
		{
			["multiplier"] = v2.Event1MDamageMultiplier,
			["value"] = 1.3
		}
	}
}
v4[v17] = v18
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MillionaireTraitsData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4026"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = {}
local v4 = {
	["Name"] = "Party Starter",
	["Requirement"] = 250,
	["Order"] = 1,
	["Buffs"] = {
		{
			["multiplier"] = v2.Event1MBalloonsMultiplier,
			["value"] = 1.15
		}
	}
}
local v5 = {
	["Name"] = "Confetti Toss",
	["Requirement"] = 1000,
	["Order"] = 2,
	["Unlocks"] = "Confetti",
	["Buffs"] = {
		{
			["multiplier"] = v2.ConfettiMultiplier,
			["value"] = 1.05
		}
	}
}
local v6 = {
	["Name"] = "Balloon Bonanza",
	["Requirement"] = 3000,
	["Order"] = 3,
	["Buffs"] = {
		{
			["multiplier"] = v2.Event1MBalloonsMultiplier,
			["value"] = 1.2
		}
	}
}
local v7 = {
	["Name"] = "Festive Frenzy",
	["Requirement"] = 8000,
	["Order"] = 4,
	["Buffs"] = {
		{
			["multiplier"] = v2.ConfettiMultiplier,
			["value"] = 1.1
		},
		{
			["multiplier"] = v2.Event1MDamageMultiplier,
			["value"] = 1.05
		}
	}
}
local v8 = {
	["Name"] = "Celebration",
	["Requirement"] = 18000,
	["Order"] = 5,
	["Buffs"] = {
		{
			["multiplier"] = v2.Event1MBalloonsMultiplier,
			["value"] = 1.25
		},
		{
			["multiplier"] = v2.Event1MSpawnCap,
			["value"] = 1
		}
	}
}
local v9 = {
	["Name"] = "Firework Show",
	["Requirement"] = 35000,
	["Order"] = 6,
	["Unlocks"] = "Firework",
	["Buffs"] = {
		{
			["multiplier"] = v2.ConfettiMultiplier,
			["value"] = 1.15
		},
		{
			["multiplier"] = v2.Event1MDamageMultiplier,
			["value"] = 1.1
		}
	}
}
local v10 = {
	["Name"] = "Grand Gala",
	["Requirement"] = 75000,
	["Order"] = 7,
	["Buffs"] = {
		{
			["multiplier"] = v2.Event1MBalloonsMultiplier,
			["value"] = 1.3
		},
		{
			["multiplier"] = v2.Event1MSlimeLuck,
			["value"] = 0.1
		},
		{
			["multiplier"] = v2.Event1MSpawnCap,
			["value"] = 1
		}
	}
}
local v11 = {
	["Name"] = "Spectacular",
	["Requirement"] = 150000,
	["Order"] = 8,
	["Buffs"] = {
		{
			["multiplier"] = v2.ConfettiMultiplier,
			["value"] = 1.2
		},
		{
			["multiplier"] = v2.Event1MDamageMultiplier,
			["value"] = 1.15
		},
		{
			["multiplier"] = v2.Event1MSpawnCap,
			["value"] = 1
		}
	}
}
local v12 = {
	["Name"] = "Party Legend",
	["Requirement"] = 300000,
	["Order"] = 9,
	["Buffs"] = {
		{
			["multiplier"] = v2.Event1MBalloonsMultiplier,
			["value"] = 1.35
		},
		{
			["multiplier"] = v2.Event1MDamageMultiplier,
			["value"] = 1.25
		},
		{
			["multiplier"] = v2.Event1MSlimeLuck,
			["value"] = 0.15
		}
	}
}
local v13 = {
	["Name"] = "Mega Bash",
	["Requirement"] = 500000,
	["Order"] = 10,
	["Buffs"] = {
		{
			["multiplier"] = v2.ConfettiMultiplier,
			["value"] = 1.4
		},
		{
			["multiplier"] = v2.Event1MDamageMultiplier,
			["value"] = 1.4
		},
		{
			["multiplier"] = v2.Event1MAttackSpeedMultiplier,
			["value"] = 1.1
		}
	}
}
local v14 = {
	["Name"] = "Festival King",
	["Requirement"] = 750000,
	["Order"] = 11,
	["Buffs"] = {
		{
			["multiplier"] = v2.Event1MBalloonsMultiplier,
			["value"] = 1.75
		},
		{
			["multiplier"] = v2.ConfettiMultiplier,
			["value"] = 1.3
		},
		{
			["multiplier"] = v2.Event1MSlimeLuck,
			["value"] = 0.2
		},
		{
			["multiplier"] = v2.Event1MSpawnCap,
			["value"] = 2
		}
	}
}
local v15 = {
	["Name"] = "Millionaire",
	["Requirement"] = 1100000,
	["Order"] = 12,
	["Buffs"] = {
		{
			["multiplier"] = v2.Event1MBalloonsMultiplier,
			["value"] = 2
		},
		{
			["multiplier"] = v2.ConfettiMultiplier,
			["value"] = 1.5
		},
		{
			["multiplier"] = v2.Event1MDamageMultiplier,
			["value"] = 1.5
		},
		{
			["multiplier"] = v2.Event1MSlimeLuck,
			["value"] = 0.3
		}
	}
}
local v16 = {
	["Name"] = "Golden Jubilee",
	["Requirement"] = 1500000,
	["Order"] = 13,
	["Buffs"] = {
		{
			["multiplier"] = v2.Event1MBalloonsMultiplier,
			["value"] = 2.5
		},
		{
			["multiplier"] = v2.ConfettiMultiplier,
			["value"] = 2
		},
		{
			["multiplier"] = v2.Event1MDamageMultiplier,
			["value"] = 1.75
		},
		{
			["multiplier"] = v2.Event1MAttackSpeedMultiplier,
			["value"] = 1.15
		}
	}
}
local v17 = {
	["Name"] = "Eternal Celebration",
	["Requirement"] = 2000000,
	["Order"] = 14,
	["Buffs"] = {
		{
			["multiplier"] = v2.Event1MBalloonsMultiplier,
			["value"] = 3
		},
		{
			["multiplier"] = v2.ConfettiMultiplier,
			["value"] = 2.5
		},
		{
			["multiplier"] = v2.Event1MDamageMultiplier,
			["value"] = 2
		},
		{
			["multiplier"] = v2.Event1MSlimeLuck,
			["value"] = 0.5
		},
		{
			["multiplier"] = v2.Event1MSpawnCap,
			["value"] = 2
		}
	}
}
local v18 = {
	["Name"] = "Party God",
	["Requirement"] = 2500000,
	["Order"] = 15,
	["Buffs"] = {
		{
			["multiplier"] = v2.Event1MBalloonsMultiplier,
			["value"] = 4
		},
		{
			["multiplier"] = v2.ConfettiMultiplier,
			["value"] = 4
		},
		{
			["multiplier"] = v2.Event1MDamageMultiplier,
			["value"] = 2.5
		},
		{
			["multiplier"] = v2.Event1MSlimeLuck,
			["value"] = 1
		},
		{
			["multiplier"] = v2.Event1MAttackSpeedMultiplier,
			["value"] = 1.25
		}
	}
}
__set_list(v3, 1, {v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18})
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MillionaireMilestoneData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4027"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.AmuletPerkTypes)
local v3 = {
	[v2.GloopGuardian] = {
		["Name"] = "Gloop Guardian",
		["Icon"] = "rbxassetid://0",
		["Description"] = "Gloop applications have +10% success chance"
	},
	[v2.AscensionKeeper] = {
		["Name"] = "Ascension Keeper",
		["Icon"] = "rbxassetid://0",
		["Description"] = "Retain 15% of your balloons after ascending"
	},
	[v2.ConfettiCritic] = {
		["Name"] = "Confetti Critic",
		["Icon"] = "rbxassetid://0",
		["Description"] = "Confetti critical hits deal +1.5x bonus damage"
	},
	[v2.GloopMagnet] = {
		["Name"] = "Gloop Magnet",
		["Icon"] = "rbxassetid://0",
		["Description"] = "Gloop drops are 25% more common"
	},
	[v2.SlimeSurge] = {
		["Name"] = "Slime Surge",
		["Icon"] = "rbxassetid://0",
		["Description"] = "+15% slime spawn rate in Ice World"
	},
	[v2.ShardSeeker] = {
		["Name"] = "Shard Seeker",
		["Icon"] = "rbxassetid://0",
		["Description"] = "+20% shard drop chance in all worlds"
	},
	[v2.GoldenTouch] = {
		["Name"] = "Golden Touch",
		["Icon"] = "rbxassetid://0",
		["Description"] = "+10% Golden, Diamond, and Rainbow slime chance"
	},
	[v2.ComboKing] = {
		["Name"] = "Combo King",
		["Icon"] = "rbxassetid://0",
		["Description"] = "+50% combo multiplier bonus"
	}
}
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AmuletPerkData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4028"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Products)
return {
	[v2.Event1MStars[1]] = 200,
	[v2.Event1MStars[2]] = 2500,
	[v2.Event1MStars[3]] = 12500
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Event1MStarData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4029"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.CurrencyTypes)
local v3 = require(v1.Enums.SlimeTypes)
local v4 = {
	["CurrencyType"] = v2.CandyCoins
}
local v5 = {
	{
		["slime"] = v3.CandySlime1,
		["killsRequired"] = 0,
		["costToUnlock"] = 0
	},
	{
		["slime"] = v3.CandySlime2,
		["killsRequired"] = 500,
		["costToUnlock"] = 25000000
	},
	{
		["slime"] = v3.CandySlime3,
		["killsRequired"] = 1500,
		["costToUnlock"] = 200000000
	},
	{
		["slime"] = v3.CandySlime4,
		["killsRequired"] = 3000,
		["costToUnlock"] = 2000000000
	},
	{
		["slime"] = v3.CandySlime5,
		["killsRequired"] = 5000,
		["costToUnlock"] = 15000000000
	},
	{
		["slime"] = v3.CandySlime6,
		["killsRequired"] = 10000,
		["costToUnlock"] = 1000000000000
	}
}
v4.Zones = v5
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CandyData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4030"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.PetSlimeTypes)
local v3 = require(v1.Enums.RarityTypes)
local v4 = v1:WaitForChild("Assets"):WaitForChild("SlimePets")
local v5 = {
	[v3.Common] = {
		["PetAttackSpeed"] = 0,
		["PetDamagePercent"] = 0,
		["PetAgility"] = 0,
		["PetCoinMultiplier"] = 1,
		["PetRange"] = 0,
		["PetCritChance"] = 0
	},
	[v3.Uncommon] = {
		["PetAttackSpeed"] = 0.05,
		["PetDamagePercent"] = 0.02,
		["PetAgility"] = 1,
		["PetCoinMultiplier"] = 1.05,
		["PetRange"] = 0.3,
		["PetCritChance"] = 0.005
	},
	[v3.Rare] = {
		["PetAttackSpeed"] = 0.1,
		["PetDamagePercent"] = 0.05,
		["PetAgility"] = 2,
		["PetCoinMultiplier"] = 1.1,
		["PetRange"] = 0.6,
		["PetCritChance"] = 0.01
	},
	[v3.Epic] = {
		["PetAttackSpeed"] = 0.2,
		["PetDamagePercent"] = 0.1,
		["PetAgility"] = 3,
		["PetCoinMultiplier"] = 1.2,
		["PetRange"] = 1,
		["PetCritChance"] = 0.02
	},
	[v3.Legendary] = {
		["PetAttackSpeed"] = 0.3,
		["PetDamagePercent"] = 0.15,
		["PetAgility"] = 5,
		["PetCoinMultiplier"] = 1.4,
		["PetRange"] = 1.5,
		["PetCritChance"] = 0.03
	},
	[v3.Mythical] = {
		["PetAttackSpeed"] = 0.5,
		["PetDamagePercent"] = 0.25,
		["PetAgility"] = 8,
		["PetCoinMultiplier"] = 1.8,
		["PetRange"] = 2,
		["PetCritChance"] = 0.05
	}
}
local v_u_6 = {
	[v2.CandyPet_Gumdrop] = {
		["Name"] = "Gumdrop",
		["Rarity"] = v3.Common,
		["Weight"] = 100,
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 150, 200),
		["Order"] = 1
	},
	[v2.CandyPet_Taffy] = {
		["Name"] = "Taffy",
		["Rarity"] = v3.Common,
		["Weight"] = 80,
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 180, 230),
		["Order"] = 2
	},
	[v2.CandyPet_JellyBean] = {
		["Name"] = "Jelly Bean",
		["Rarity"] = v3.Common,
		["Weight"] = 70,
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(230, 200, 255),
		["Order"] = 3
	},
	[v2.CandyPet_Lollipop] = {
		["Name"] = "Lollipop",
		["Rarity"] = v3.Uncommon,
		["Weight"] = 30,
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(100, 255, 150),
		["Order"] = 4
	},
	[v2.CandyPet_Caramel] = {
		["Name"] = "Caramel",
		["Rarity"] = v3.Uncommon,
		["Weight"] = 30,
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(200, 150, 80),
		["Order"] = 5
	},
	[v2.CandyPet_CottonCandy] = {
		["Name"] = "Cotton Candy",
		["Rarity"] = v3.Rare,
		["Weight"] = 15,
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(150, 200, 255),
		["Order"] = 6
	},
	[v2.CandyPet_Peppermint] = {
		["Name"] = "Peppermint",
		["Rarity"] = v3.Rare,
		["Weight"] = 10,
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 100, 100),
		["Order"] = 7
	},
	[v2.CandyPet_ChocolateTruffle] = {
		["Name"] = "Chocolate Truffle",
		["Rarity"] = v3.Epic,
		["Weight"] = 5,
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(120, 60, 30),
		["Order"] = 8
	},
	[v2.CandyPet_GoldenGummy] = {
		["Name"] = "Golden Gummy",
		["Rarity"] = v3.Legendary,
		["Weight"] = 1,
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 200, 50),
		["Order"] = 9
	},
	[v2.CandyPet_CosmicCandy] = {
		["Name"] = "Cosmic Candy",
		["Rarity"] = v3.Mythical,
		["Weight"] = 0.1,
		["Icon"] = "rbxassetid://140179584961588",
		["Color"] = Color3.fromRGB(255, 50, 255),
		["Order"] = 10
	}
}
for v7, v8 in v_u_6 do
	v8.Model = v4:FindFirstChild(v7)
	if not v8.Model then
		warn("[PetSlimeData] Model not found for " .. v7)
	end
	v8.BaseStats = v5[v8.Rarity] or v5[v3.Common]
end
local v9 = 0
for _, v10 in v_u_6 do
	v9 = v9 + v10.Weight
end
local v11 = {}
for v12, _ in v_u_6 do
	table.insert(v11, v12)
end
table.sort(v11, function(p13, p14)
	-- upvalues: (copy) v_u_6
	return v_u_6[p13].Order < v_u_6[p14].Order
end)
return {
	["Pets"] = v_u_6,
	["TotalWeight"] = v9,
	["OrderedPets"] = v11,
	["RollCost"] = 1000,
	["RarityBaseStats"] = v5
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PetSlimeData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4031"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.PetAttributeTypes)
local v3 = require(v1.Enums.MultiplierTypes)
local v10 = {
	[v2.PetAttackSpeed] = {
		["Name"] = "Attack Speed",
		["Description"] = "Reduces time between pet attacks",
		["Icon"] = "rbxassetid://83884379124762",
		["Order"] = 1,
		["MaxLevel"] = 100,
		["MultiplierType"] = v3.PetAttackSpeed,
		["CalculateValue"] = function(p4)
			return p4 * 0.015
		end
	},
	[v2.PetDamage] = {
		["Name"] = "Damage",
		["Description"] = "Increases pet damage (% of player damage)",
		["Icon"] = "rbxassetid://106746371164727",
		["Order"] = 2,
		["MaxLevel"] = 100,
		["MultiplierType"] = v3.PetDamagePercent,
		["CalculateValue"] = function(p5)
			return p5 * 0.0095
		end
	},
	[v2.PetAgility] = {
		["Name"] = "Agility",
		["Description"] = "Increases pet movement speed",
		["Icon"] = "rbxassetid://83884379124762",
		["Order"] = 3,
		["MaxLevel"] = 100,
		["MultiplierType"] = v3.PetAgility,
		["CalculateValue"] = function(p6)
			return p6 * 0.2
		end
	},
	[v2.PetCoinMultiplier] = {
		["Name"] = "Coin Bonus",
		["Description"] = "Bonus coins from pet kills",
		["Icon"] = "rbxassetid://106746371164727",
		["Order"] = 4,
		["MaxLevel"] = 100,
		["MultiplierType"] = v3.PetCoinMultiplier,
		["CalculateValue"] = function(p7)
			return p7 * 0.02 + 1
		end
	},
	[v2.PetRange] = {
		["Name"] = "Range",
		["Description"] = "Increases pet attack range",
		["Icon"] = "rbxassetid://78157289763375",
		["Order"] = 5,
		["MaxLevel"] = 100,
		["MultiplierType"] = v3.PetRange,
		["CalculateValue"] = function(p8)
			return p8 * 0.08
		end
	},
	[v2.PetCritChance] = {
		["Name"] = "Critical Hit",
		["Description"] = "Chance for pet to deal critical hits",
		["Icon"] = "rbxassetid://00000000",
		["Order"] = 6,
		["MaxLevel"] = 100,
		["MultiplierType"] = v3.PetCritChance,
		["CalculateValue"] = function(p9)
			return p9 * 0.003
		end
	}
}
return v10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PetAttributeData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4032"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.MultiplierTypes)
local v3 = require(v1.Enums.Products)
local v4 = require(v1.Enums.RarityTypes)
local v5 = require(v1.Enums.SlimeRaceTypes)
local v6 = require(v1.Functions.WaitFor)
local v7 = {
	[v4.Common] = {
		[v2.PetAttackSpeed] = 0.02,
		[v2.PetDamagePercent] = 0.01,
		[v2.PetAgility] = 0.5,
		[v2.PetCoinMultiplier] = 1.02,
		[v2.PetRange] = 0.1,
		[v2.PetCritChance] = 0.002
	},
	[v4.Uncommon] = {
		[v2.PetAttackSpeed] = 0.05,
		[v2.PetDamagePercent] = 0.02,
		[v2.PetAgility] = 1,
		[v2.PetCoinMultiplier] = 1.05,
		[v2.PetRange] = 0.3,
		[v2.PetCritChance] = 0.005
	},
	[v4.Rare] = {
		[v2.PetAttackSpeed] = 0.1,
		[v2.PetDamagePercent] = 0.04,
		[v2.PetAgility] = 2,
		[v2.PetCoinMultiplier] = 1.1,
		[v2.PetRange] = 0.5,
		[v2.PetCritChance] = 0.01
	},
	[v4.Epic] = {
		[v2.PetAttackSpeed] = 0.15,
		[v2.PetDamagePercent] = 0.07,
		[v2.PetAgility] = 3,
		[v2.PetCoinMultiplier] = 1.15,
		[v2.PetRange] = 0.8,
		[v2.PetCritChance] = 0.015
	},
	[v4.Legendary] = {
		[v2.PetAttackSpeed] = 0.25,
		[v2.PetDamagePercent] = 0.12,
		[v2.PetAgility] = 5,
		[v2.PetCoinMultiplier] = 1.3,
		[v2.PetRange] = 1.2,
		[v2.PetCritChance] = 0.025
	},
	[v4.Mythical] = {
		[v2.PetAttackSpeed] = 0.4,
		[v2.PetDamagePercent] = 0.2,
		[v2.PetAgility] = 8,
		[v2.PetCoinMultiplier] = 1.5,
		[v2.PetRange] = 2,
		[v2.PetCritChance] = 0.04
	}
}
local v_u_8 = v6(v1, "Assets", "PetRaces")
local v_u_35 = {
	[v5.Pebble] = {
		["Name"] = "Pebble",
		["Rarity"] = v4.Common,
		["Weight"] = 40,
		["Color"] = Color3.fromRGB(255, 150, 200),
		["Order"] = 1,
		["Transform"] = function(p9)
			local v10 = p9:FindFirstChildWhichIsA("Decal", true)
			if v10 then
				v10.Texture = "rbxassetid://7822802483"
			end
			for _, v11 in p9:GetChildren() do
				if v11:IsA("MeshPart") then
					v11.Material = Enum.Material.Pebble
				end
			end
		end
	},
	[v5.Dewdrop] = {
		["Name"] = "Dewdrop",
		["Rarity"] = v4.Common,
		["Weight"] = 30,
		["Color"] = Color3.fromRGB(100, 200, 255),
		["Order"] = 2,
		["Transform"] = function(p12)
			local v13 = p12:FindFirstChildWhichIsA("Decal", true)
			if v13 then
				v13.Texture = "rbxassetid://686692237"
			end
		end
	},
	[v5.Bramble] = {
		["Name"] = "Bramble",
		["Rarity"] = v4.Uncommon,
		["Weight"] = 15,
		["Color"] = Color3.fromRGB(255, 180, 230),
		["Order"] = 3,
		["Transform"] = function(p14)
			local v15 = p14:FindFirstChildWhichIsA("Decal", true)
			if v15 then
				v15.Texture = "rbxassetid://186421725"
			end
		end
	},
	[v5.Ember] = {
		["Name"] = "Ember",
		["Rarity"] = v4.Uncommon,
		["Weight"] = 8,
		["Color"] = Color3.fromRGB(255, 100, 100),
		["Order"] = 4,
		["Transform"] = function(p16)
			local v17 = p16:FindFirstChildWhichIsA("Decal", true)
			if v17 then
				v17.Texture = "rbxassetid://125381679041659"
			end
		end
	},
	[v5.Gilded] = {
		["Name"] = "Gilded",
		["Rarity"] = v4.Rare,
		["Weight"] = 3,
		["Color"] = Color3.fromRGB(218, 165, 32),
		["Order"] = 5,
		["Transform"] = function(p18)
			local v19 = p18:FindFirstChildWhichIsA("Decal", true)
			if v19 then
				v19.Texture = "rbxassetid://1108967375"
			end
		end
	},
	[v5.Ironhide] = {
		["Name"] = "Ironhide",
		["Rarity"] = v4.Rare,
		["Weight"] = 2,
		["Color"] = Color3.fromRGB(200, 150, 80),
		["Order"] = 6,
		["Transform"] = function(p20)
			local v21 = p20:FindFirstChildWhichIsA("Decal", true)
			if v21 then
				v21.Texture = "rbxassetid://12156100678"
			end
		end
	},
	[v5.Glacial] = {
		["Name"] = "Glacial",
		["Rarity"] = v4.Epic,
		["Weight"] = 1,
		["Color"] = Color3.fromRGB(150, 200, 255),
		["Order"] = 7,
		["Transform"] = function(p22)
			local v23 = p22:FindFirstChildWhichIsA("Decal", true)
			if v23 then
				v23.Texture = "rbxassetid://6058064270"
			end
			for _, v24 in p22:GetChildren() do
				if v24:IsA("MeshPart") then
					v24.Material = Enum.Material.Ice
				end
			end
		end
	},
	[v5.Tempest] = {
		["Name"] = "Tempest",
		["Rarity"] = v4.Epic,
		["Weight"] = 0.5,
		["Color"] = Color3.fromRGB(255, 130, 255),
		["Order"] = 8,
		["Transform"] = function(p25)
			local v26 = p25:FindFirstChildWhichIsA("Decal", true)
			if v26 then
				v26.Texture = "rbxassetid://2513175977"
			end
		end
	},
	[v5.Voidborn] = {
		["Name"] = "Voidborn",
		["Rarity"] = v4.Legendary,
		["Weight"] = 0.3,
		["Color"] = Color3.fromRGB(255, 200, 50),
		["Order"] = 9,
		["Passive"] = {
			["Name"] = "Black Hole",
			["Description"] = "Every 300 pet kills, spawns a black hole that sucks in and destroys all nearby slimes for 10s",
			["KillThreshold"] = 300,
			["Duration"] = 10,
			["Range"] = 100,
			["Icon"] = "rbxassetid://140179584961588"
		},
		["Transform"] = function(p27)
			-- upvalues: (copy) v_u_8
			local v28 = v_u_8:FindFirstChild("Voidborn")
			if v28 then
				for _, v29 in v28:GetChildren() do
					v29:Clone().Parent = p27
				end
				local v30 = p27:FindFirstChildWhichIsA("Decal", true)
				if v30 then
					v30.Texture = "rbxassetid://5481852463"
				end
			end
		end
	},
	[v5.Celestial] = {
		["Name"] = "Celestial",
		["Rarity"] = v4.Mythical,
		["Weight"] = 0.2,
		["Color"] = Color3.fromRGB(255, 50, 255),
		["Order"] = 10,
		["Passive"] = {
			["Name"] = "Meteor Strike",
			["Description"] = "Every 300 pet kills, meteors rain around your pet for 30s, destroying slimes on impact",
			["KillThreshold"] = 300,
			["Duration"] = 30,
			["Range"] = 20,
			["ImpactRadius"] = 10,
			["MeteorInterval"] = 0.3,
			["Icon"] = "rbxassetid://140179584961588"
		},
		["Transform"] = function(p31)
			-- upvalues: (copy) v_u_8
			local v32 = v_u_8:FindFirstChild("Voidborn")
			if v32 then
				for _, v33 in v32:GetChildren() do
					v33:Clone().Parent = p31
				end
				local v34 = p31:FindFirstChildWhichIsA("Decal", true)
				if v34 then
					v34.Texture = "rbxassetid://880611615"
				end
			end
		end
	}
}
for _, v36 in v_u_35 do
	v36.StatBoosts = v7[v36.Rarity] or v7[v4.Common]
end
local v37 = 0
for _, v38 in v_u_35 do
	v37 = v37 + v38.Weight
end
local v39 = {}
for v40 in v_u_35 do
	table.insert(v39, v40)
end
table.sort(v39, function(p41, p42)
	-- upvalues: (copy) v_u_35
	return v_u_35[p41].Weight > v_u_35[p42].Weight
end)
local function v_u_48(p43)
	for _, v44 in p43:GetChildren() do
		if v44:GetAttribute("_RaceAdded") then
			v44:Destroy()
		end
	end
	for _, v45 in p43:GetDescendants() do
		if v45:IsA("BasePart") then
			local v46 = v45:GetAttribute("_OriginalMaterial")
			if v46 and Enum.Material[v46] then
				v45.Material = Enum.Material[v46]
			end
		end
		if v45:IsA("Decal") then
			local v47 = v45:GetAttribute("_OriginalTexture")
			if v47 then
				v45.Texture = v47
			end
		end
	end
end
return {
	["Races"] = v_u_35,
	["TotalWeight"] = v37,
	["OrderedRaces"] = v39,
	["RollCost"] = 1,
	["Slots"] = {
		{
			["Unlocked"] = true
		},
		{
			["RequiredLevel"] = 50,
			["ProductId"] = v3.RaceSlot2
		},
		{
			["RequiredLevel"] = 150,
			["ProductId"] = v3.RaceSlot3
		}
	},
	["RarityStatBoosts"] = v7,
	["captureOriginals"] = function(p49)
		for _, v50 in p49:GetDescendants() do
			if v50:IsA("BasePart") and not v50:GetAttribute("_OriginalMaterial") then
				v50:SetAttribute("_OriginalMaterial", v50.Material.Name)
			end
			if v50:IsA("Decal") and not v50:GetAttribute("_OriginalTexture") then
				v50:SetAttribute("_OriginalTexture", v50.Texture)
			end
		end
	end,
	["resetTransform"] = v_u_48,
	["applyRaceTransform"] = function(p51, p52)
		-- upvalues: (copy) v_u_48, (copy) v_u_35
		v_u_48(p51)
		local v53 = v_u_35[p52]
		if v53 and v53.Transform then
			local v54 = {}
			for _, v55 in p51:GetChildren() do
				v54[v55] = true
			end
			v53.Transform(p51)
			for _, v56 in p51:GetChildren() do
				if not v54[v56] then
					v56:SetAttribute("_RaceAdded", true)
				end
			end
		end
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeRaceData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4033"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.GloopTypes)
local v3 = {
	[v2.Yellow] = {
		["InputGloop"] = v2.Green,
		["InputAmount"] = 5,
		["ShardCost"] = 500,
		["Order"] = 1
	},
	[v2.Pink] = {
		["InputGloop"] = v2.Yellow,
		["InputAmount"] = 5,
		["ShardCost"] = 1000,
		["Order"] = 2
	},
	[v2.Purple] = {
		["InputGloop"] = v2.Pink,
		["InputAmount"] = 5,
		["ShardCost"] = 2000,
		["Order"] = 3
	},
	[v2.Spiked] = {
		["InputGloop"] = v2.Purple,
		["InputAmount"] = 5,
		["ShardCost"] = 5000,
		["Order"] = 4
	}
}
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GloopCraftData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4034"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.Products)
return {
	[v2.RaceRerolls[1]] = 1,
	[v2.RaceRerolls[2]] = 5,
	[v2.RaceRerolls[3]] = 10,
	[v2.RaceRerolls[4]] = 20,
	[v2.RaceRerolls[5]] = 120
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RaceRerollData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="4035"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Enums]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="4036"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Welcome"] = 3149831792997777
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Badges]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4037"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Tokens"] = "Tokens",
	["Coins"] = "Coins",
	["Rebirth"] = "Rebirth",
	["SuperRebirth"] = "SuperRebirth",
	["SkillPoints"] = "SkillPoints",
	["Shards"] = "Shards",
	["FireCoins"] = "FireCoins",
	["IceCoins"] = "IceCoins",
	["GlowCoins"] = "GlowCoins",
	["CandyCoins"] = "CandyCoins",
	["Hearts"] = "Hearts",
	["CrystalHearts"] = "CrystalHearts",
	["SkillResetTickets"] = "SkillResetTickets",
	["Event1MBalloon"] = "Event1MBalloon",
	["Event1MStars"] = "Event1MStars",
	["Event1MConfetti"] = "Event1MConfetti",
	["RaceRerolls"] = "RaceRerolls"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CurrencyTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4038"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Playtime"] = "Playtime",
	["RuneOpen"] = "RuneOpen",
	["CurrencyAdded"] = "CurrencyAdded",
	["SlimeKilled"] = "SlimeKilled",
	["RoundCompleted"] = "RoundCompleted",
	["RoundScoreEarned"] = "RoundScoreEarned",
	["GloopObtained"] = "GloopObtained",
	["IceBossDefeated"] = "IceBossDefeated",
	["PetSlimeKilled"] = "PetSlimeKilled"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[EventType]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4039"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
require(v1.Config.Constants)
return {
	["BasicLuck"] = 1664189692,
	["SuperLuck"] = 1664349414,
	["UltraLuck"] = 1664181567,
	["OPLuck"] = 1664757152,
	["VIP"] = 1664653173,
	["MVP"] = 1664269493,
	["RuneBulk2x"] = 1664415455,
	["RuneClone2x"] = 1664077844,
	["FasterRunes"] = 1664507236,
	["Damage2x"] = 1664749090,
	["AttackRange2x"] = 1664395376,
	["Shards2x"] = 1684699699,
	["SkillXP2x"] = 1668748912,
	["SkillXP3x"] = 1668802879,
	["SkillXP5x"] = 1668621884,
	["Coins2x"] = 1683373827,
	["FireCoins2x"] = 1684579688,
	["IceCoins2x"] = 1686404444,
	["CandyCoins2x"] = 1735231028,
	["SuperRebirth2x"] = 1687622879,
	["GloopRate2x"] = 1709945163,
	["GlowCoins2x"] = 1709201227,
	["BulkGloopCraft"] = 1733075977,
	["CraftSpeed2x"] = 1736241311,
	["PetRollLuck"] = 1737021286
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Gamepasses]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4040"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Slimes"] = "Slimes"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[IndexTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4041"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Currency"] = "Currency",
	["Potions"] = "Potions",
	["Runes"] = "Runes",
	["RuneOpen"] = "RuneOpen",
	["SkillXP"] = "SkillXP",
	["TempBuffs"] = "TempBuffs",
	["Gloop"] = "Gloop"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ItemTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4042"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Door"] = "Door",
	["Node"] = "Node",
	["Upgrade"] = "Upgrade",
	["World"] = "World",
	["SkillLevel"] = "SkillLevel",
	["Onboarding"] = "Onboarding",
	["Milestone"] = "Milestone"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LockTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4043"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Walkspeed"] = "Walkspeed",
	["WalkspeedMultiplier"] = "WalkspeedMultiplier",
	["Stats"] = "Stats",
	["StatsMultiplier"] = "StatsMultiplier",
	["RuneBulk"] = "RuneBulk",
	["RuneOpenTime"] = "RuneOpenTime",
	["RuneOpenTimeMultiplier"] = "RuneOpenTimeMultiplier",
	["RuneLuck"] = "RuneLuck",
	["RuneLuckMultiplier"] = "RuneLuckMultiplier",
	["RuneClone"] = "RuneClone",
	["RuneCloneMultiplier"] = "RuneCloneMultiplier",
	["RuneCloneChance"] = "RuneCloneChance",
	["RuneBulkMultiplier"] = "RuneBulkMultiplier",
	["World1SpawnCap"] = "World1SpawnCap",
	["World1SpawnRate"] = "World1SpawnRate",
	["World1SlimeLuck"] = "World1SlimeLuck",
	["World1AttackRange"] = "World1AttackRange",
	["World2SpawnCap"] = "World2SpawnCap",
	["World2SpawnRate"] = "World2SpawnRate",
	["World2SlimeLuck"] = "World2SlimeLuck",
	["World2AttackRange"] = "World2AttackRange",
	["World3SpawnCap"] = "World3SpawnCap",
	["World3SpawnRate"] = "World3SpawnRate",
	["World3SlimeLuck"] = "World3SlimeLuck",
	["World3AttackRange"] = "World3AttackRange",
	["World4SpawnCap"] = "World4SpawnCap",
	["World4SpawnRate"] = "World4SpawnRate",
	["World4SlimeLuck"] = "World4SlimeLuck",
	["World4AttackRange"] = "World4AttackRange",
	["World5SpawnCap"] = "World5SpawnCap",
	["World5SpawnRate"] = "World5SpawnRate",
	["World5SlimeLuck"] = "World5SlimeLuck",
	["World5AttackRange"] = "World5AttackRange",
	["AttackRange"] = "AttackRange",
	["AttackRangeMultiplier"] = "AttackRangeMultiplier",
	["AttackSpeed"] = "AttackSpeed",
	["AttackSpeedMultiplier"] = "AttackSpeedMultiplier",
	["Damage"] = "Damage",
	["DamageMultiplier"] = "DamageMultiplier",
	["CoinsMultiplier"] = "CoinsMultiplier",
	["RebirthMultiplier"] = "RebirthMultiplier",
	["FireCoinsMultiplier"] = "FireCoinsMultiplier",
	["IceCoinsMultiplier"] = "IceCoinsMultiplier",
	["GlowCoinsMultiplier"] = "GlowCoinsMultiplier",
	["CandyCoinsMultiplier"] = "CandyCoinsMultiplier",
	["GoldenChance"] = "GoldenChance",
	["DiamondChance"] = "DiamondChance",
	["RainbowChance"] = "RainbowChance",
	["CriticalHitChance"] = "CriticalHitChance",
	["CriticalHitMultiplier"] = "CriticalHitMultiplier",
	["ShardDropChance"] = "ShardDropChance",
	["ShardMultiplier"] = "ShardMultiplier",
	["LuckyBlockDurationIncrease"] = "LuckyBlockDurationIncrease",
	["ComboMultiplier"] = "ComboMultiplier",
	["CurrencyGain"] = "CurrencyGain",
	["CurrencyGainMultiplier"] = "CurrencyGainMultiplier",
	["SkillXP"] = "SkillXP",
	["SkillXPMultiplier"] = "SkillXPMultiplier",
	["LightingStrikes"] = "LightingStrikes",
	["LightingStrikeDamage"] = "LightingStrikeDamage",
	["LightingStrikeCooldown"] = "LightingStrikeCooldown",
	["LightingDoubleStrikeChance"] = "LightingDoubleStrikeChance",
	["ArrowFired"] = "ArrowFired",
	["ArrowDamage"] = "ArrowDamage",
	["ArrowCooldown"] = "ArrowCooldown",
	["ArrowRain"] = "ArrowRain",
	["FreezeAmount"] = "FreezeAmount",
	["FreezeDamage"] = "FreezeDamage",
	["FreezeCooldown"] = "FreezeCooldown",
	["FreezeDoubleChance"] = "FreezeDoubleChance",
	["IceWorldDuration"] = "IceWorldDuration",
	["IceWorldDurationMultiplier"] = "IceWorldDurationMultiplier",
	["IceBonusTime"] = "IceBonusTime",
	["FreeShardPercentage"] = "FreeShardPercentage",
	["IceBossCooldown"] = "IceBossCooldown",
	["IceBossCooldownPercentage"] = "IceBossCooldownPercentage",
	["IceBossAttackRange"] = "World3AttackRange",
	["IceBossAttackRangeMultiplier"] = "AttackRangeMultiplier",
	["IceBossAttackSpeed"] = "AttackSpeed",
	["IceBossAttackSpeedMultiplier"] = "AttackSpeedMultiplier",
	["AmuletCheaperCost"] = "AmuletCheaperCost",
	["SuperRebirthMultiplier"] = "SuperRebirthMultiplier",
	["ValentineSpawnCap"] = "ValentineSpawnCap",
	["ValentineSpawnRate"] = "ValentineSpawnRate",
	["ValentineAttackSpeed"] = "ValentineAttackSpeed",
	["ValentineAttackSpeedMultiplier"] = "ValentineAttackSpeedMultiplier",
	["ValentineAttackRange"] = "ValentineAttackRange",
	["ValentineAttackRangeMultiplier"] = "ValentineAttackRangeMultiplier",
	["ValentineDamage"] = "ValentineDamage",
	["ValentineDamageMultiplier"] = "ValentineDamageMultiplier",
	["HeartsMultiplier"] = "HeartsMultiplier",
	["ValentineTraitsLuck"] = "ValentineTraitsLuck",
	["ValentineTraitsLuckMultiplier"] = "ValentineTraitsLuckMultiplier",
	["ValentineRuneBulk"] = "ValentineRuneBulk",
	["ValentineRuneBulkMultiplier"] = "ValentineRuneBulkMultiplier",
	["ValentineRuneLuck"] = "ValentineRuneLuck",
	["ValentineRuneOpenTime"] = "ValentineRuneOpenTime",
	["ValentineRuneOpenTimeMultiplier"] = "ValentineRuneOpenTimeMultiplier",
	["ValentineRuneLuckMultiplier"] = "ValentineRuneLuckMultiplier",
	["ValentineCrystalShardDropChance"] = "ValentineCrystalShardDropChance",
	["ValentineCrystalShards"] = "ValentineCrystalShards",
	["ValentineCrystalShardMultiplier"] = "ValentineCrystalShardMultiplier",
	["ValentineSlimeXP"] = "ValentineSlimeXP",
	["GloopCollectLuck"] = "GloopCollectLuck",
	["GloopCraftSpeed"] = "GloopCraftSpeed",
	["Event1MSpawnCap"] = "Event1MSpawnCap",
	["Event1MSpawnRate"] = "Event1MSpawnRate",
	["Event1MAttackSpeed"] = "Event1MAttackSpeed",
	["Event1MAttackSpeedMultiplier"] = "Event1MAttackSpeedMultiplier",
	["Event1MAttackRange"] = "Event1MAttackRange",
	["Event1MAttackRangeMultiplier"] = "Event1MAttackRangeMultiplier",
	["Event1MDamage"] = "Event1MDamage",
	["Event1MDamageMultiplier"] = "Event1MDamageMultiplier",
	["Event1MBalloonsMultiplier"] = "Event1MBalloonsMultiplier",
	["Event1MSlimeLuck"] = "Event1MSlimeLuck",
	["Event1MStarDropChance"] = "Event1MStarDropChance",
	["Event1MStars"] = "Event1MStars",
	["Event1MStarMultiplier"] = "Event1MStarMultiplier",
	["ConfettiMultiplier"] = "ConfettiMultiplier",
	["ConfettiBaseValue"] = "ConfettiBaseValue",
	["ConfettiClickSpeed"] = "ConfettiClickSpeed",
	["ConfettiAutoClick"] = "ConfettiAutoClick",
	["ConfettiAutoMultiplier"] = "ConfettiAutoMultiplier",
	["ConfettiCriticalChance"] = "ConfettiCriticalChance",
	["ConfettiCriticalMultiplier"] = "ConfettiCriticalMultiplier",
	["Event1MRuneBulk"] = "Event1MRuneBulk",
	["Event1MRuneBulkMultiplier"] = "Event1MRuneBulkMultiplier",
	["Event1MRuneLuck"] = "Event1MRuneLuck",
	["Event1MRuneLuckMultiplier"] = "Event1MRuneLuckMultiplier",
	["Event1MRuneOpenTime"] = "Event1MRuneOpenTime",
	["Event1MRuneOpenTimeMultiplier"] = "Event1MRuneOpenTimeMultiplier",
	["MillionaireTraitsLuck"] = "MillionaireTraitsLuck",
	["MillionaireTraitsLuckMultiplier"] = "MillionaireTraitsLuckMultiplier",
	["PetAttackSpeed"] = "PetAttackSpeed",
	["PetAttackSpeedMultiplier"] = "PetAttackSpeedMultiplier",
	["PetDamagePercent"] = "PetDamagePercent",
	["PetDamagePercentMultiplier"] = "PetDamagePercentMultiplier",
	["PetAgility"] = "PetAgility",
	["PetAgilityMultiplier"] = "PetAgilityMultiplier",
	["PetCoinMultiplier"] = "PetCoinMultiplier",
	["PetRange"] = "PetRange",
	["PetRangeMultiplier"] = "PetRangeMultiplier",
	["PetCritChance"] = "PetCritChance",
	["PetXP"] = "PetXP",
	["PetXPMultiplier"] = "PetXPMultiplier",
	["PetRollLuck"] = "PetRollLuck",
	["PetRaceLuck"] = "PetRaceLuck"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MultiplierTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4044"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Frozen"] = "Frozen"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeEffectTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4045"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Stats"] = "Stats",
	["RuneLuck"] = "RuneLuck",
	["RuneSpeed"] = "RuneSpeed",
	["Damage"] = "Damage",
	["SkillXP"] = "SkillXP"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PotionTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4046"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = require(script.Parent.Gamepasses)
local v2 = require(script.Parent.PotionTypes)
local v3 = {
	["StarterPack"] = 3512112425,
	["LavaWorldOffer"] = 3533723620
}
local v4 = {
	["JELLY_RUNES"] = {
		3507947871,
		3507948035,
		3507948243,
		3507948444,
		3507948609
	},
	["GLOOP_RUNES"] = {
		3532978837,
		3532979139,
		3532979350,
		3532979543,
		3532979720
	}
}
v3.GlobalRunes = v4
v3.ServerLuck = {
	[1] = 3509023108,
	[2] = 3509023343,
	[4] = 3509023570
}
v3.SkipLuckyBlockTimer = 3510704877
v3.Tokens = {
	3507887090,
	3507887995,
	3507888118,
	3507888253,
	3507888620
}
v3.Shards = {
	3522950519,
	3522951124,
	3522951608,
	3522952055,
	3522952851
}
v3.CrystalHearts = { 3524603281, 3524604024, 3524604912 }
v3.Event1MStars = { 3545615306, 3545615761, 3545615879 }
v3.Pack = {
	["Gloop"] = 3533726648,
	["Skill"] = 3533726029
}
v3.ResetTickets = { 3533985715, 3533986167 }
v3.PotionsAll = 3507816747
local v5 = {
	[v2.Stats] = { 3507813603, 3507813849 },
	[v2.Damage] = { 3507814183, 3507814384 },
	[v2.RuneLuck] = { 3507815100, 3507815263 },
	[v2.RuneSpeed] = { 3507814738, 3507814909 },
	[v2.SkillXP] = { 3534334138, 3534334523 }
}
v3.Potions = v5
v3.Gamepasses = {
	[v1.BasicLuck] = 3507912188,
	[v1.SuperLuck] = 3507912361,
	[v1.UltraLuck] = 3507912577,
	[v1.OPLuck] = 3507913340,
	[v1.VIP] = 3507911622,
	[v1.MVP] = 3507911771,
	[v1.RuneBulk2x] = 3507910830,
	[v1.RuneClone2x] = 3507911306,
	[v1.FasterRunes] = 3507911957,
	[v1.Damage2x] = 3507912724,
	[v1.AttackRange2x] = 3507912924,
	[v1.CandyCoins2x] = 3549682184,
	[v1.SkillXP2x] = 3512833995,
	[v1.SkillXP3x] = 3512833909,
	[v1.SkillXP5x] = 3512833752,
	[v1.Shards2x] = 3522920247,
	[v1.SuperRebirth2x] = 3522882363,
	[v1.Coins2x] = 3522883676,
	[v1.FireCoins2x] = 3522882917,
	[v1.IceCoins2x] = 3522883212,
	[v1.GloopRate2x] = 3534336852,
	[v1.GlowCoins2x] = 3534337123,
	[v1.BulkGloopCraft] = 3549158027,
	[v1.CraftSpeed2x] = 3549157909,
	[v1.PetRollLuck] = 3549174537
}
v3.RaceRerolls = {
	3549725596,
	3549725738,
	3549725802,
	3549725869,
	3549725988
}
v3.AllGamepasses = 3525411353
v3.ExtraRuneBulk = {
	["ONE"] = 3545636010,
	["MAX"] = 3545636117
}
v3.ExtraRuneSpeed = {
	["ONE"] = 3545636219,
	["MAX"] = 3545636326
}
v3.RaceSlot2 = 3550193507
v3.RaceSlot3 = 3550193572
v3.SkipGloopCraftTimer = 3548770337
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Products]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4047"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Playtime"] = "Playtime",
	["Currency"] = "Currency",
	["TreeChopped"] = "TreeChopped",
	["CarHit"] = "CarHit",
	["FishCaught"] = "FishCaught",
	["RunesOpened"] = "RunesOpened"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[QuestTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4048"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Common"] = "Common",
	["Uncommon"] = "Uncommon",
	["Rare"] = "Rare",
	["Epic"] = "Epic",
	["Legendary"] = "Legendary",
	["Mythical"] = "Mythical",
	["Secret"] = "Secret"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RarityTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4049"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Mud"] = "Mud",
	["Stone"] = "Stone",
	["Root"] = "Root",
	["Moss"] = "Moss",
	["Fungal"] = "Fungal",
	["Crystalroot"] = "Crystalroot",
	["Ash"] = "Ash",
	["Ember"] = "Ember",
	["Flare"] = "Flare",
	["Pyroclast"] = "Pyroclast",
	["Eruption"] = "Eruption",
	["Primordial"] = "Primordial",
	["Frostmark"] = "Frostmark",
	["Glacial"] = "Glacial",
	["Permafrost"] = "Permafrost",
	["Cryostorm"] = "Cryostorm",
	["Stormfrost"] = "Stormfrost",
	["Frostbound"] = "Frostbound",
	["Wobble"] = "Wobble",
	["Sticky"] = "Sticky",
	["Bouncy"] = "Bouncy",
	["Elastic"] = "Elastic",
	["Prismatic"] = "Prismatic",
	["Quartz"] = "Quartz",
	["Ruby"] = "Ruby",
	["Rosecore"] = "Rosecore",
	["Heartstone"] = "Heartstone",
	["Pinkflux"] = "Pinkflux",
	["Valentine"] = "Valentine",
	["Kinetic"] = "Kinetic",
	["Surge"] = "Surge",
	["Overdrive"] = "Overdrive",
	["Catalyst"] = "Catalyst",
	["Eternal"] = "Eternal",
	["Glop"] = "Glop",
	["Ooze"] = "Ooze",
	["Slick"] = "Slick",
	["Gum"] = "Gum",
	["Blob"] = "Blob",
	["Muck"] = "Muck",
	["Taffy"] = "Taffy",
	["Caramel"] = "Caramel",
	["Gumdrop"] = "Gumdrop",
	["Lollipop"] = "Lollipop",
	["Jawbreaker"] = "Jawbreaker",
	["Sugarplum"] = "Sugarplum",
	["Streamer"] = "Streamer",
	["Sparkler"] = "Sparkler",
	["Firecracker"] = "Firecracker",
	["Starburst"] = "Starburst",
	["Prismfetti"] = "Prismfetti",
	["Celebration"] = "Celebration"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RuneTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4050"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Gameplay"] = "Gameplay",
	["World"] = "World",
	["Sound"] = "Sound",
	["UI"] = "UI",
	["Performance"] = "Performance"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SettingCategoryTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4051"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Music"] = "Music",
	["SFX"] = "SFX",
	["CameraShakes"] = "CameraShakes",
	["RunePopup"] = "RunePopup",
	["CurrencyPopup"] = "CurrencyPopup",
	["AutoCurrencyPopup"] = "AutoCurrencyPopup",
	["RuneMessages"] = "RuneMessages",
	["GlobalMessages"] = "GlobalMessages",
	["TipMessages"] = "TipMessages",
	["RuneLuck"] = "RuneLuck",
	["HideMaxedUpgrades"] = "HideMaxedUpgrades",
	["VFX"] = "VFX",
	["DamageIndicators"] = "DamageIndicators",
	["HideOtherPlayers"] = "HideOtherPlayers",
	["HideOtherPets"] = "HideOtherPets",
	["ShowWorldCurrency"] = "ShowWorldCurrency",
	["HideLeaderboardTags"] = "HideLeaderboardTags",
	["CandyZonePriority"] = "CandyZonePriority",
	["BuyMaxUpgradeTree"] = "BuyMaxUpgradeTree"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SettingTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4052"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Gameplay"] = "Gameplay",
	["Monetization"] = "Monetization",
	["Runes"] = "Runes",
	["Currency"] = "Currency"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[StatisticCategoryType]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4053"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Config.RuneOpenData)
local v3 = {
	["Playtime"] = "Playtime",
	["RobuxSpent"] = "RobuxSpent",
	["RunesOpened"] = "RunesOpened",
	["SlimesDefeated"] = "SlimesDefeated",
	["IceWorldHighestRound"] = "IceWorldHighestRound",
	["IceWorldTotalScore"] = "IceWorldTotalScore",
	["IceBossDefeated"] = "IceBossDefeated",
	["RuneLuck"] = "RuneLuck",
	["RuneBulk"] = "RuneBulk"
}
for _, v4 in require(script.Parent.CurrencyTypes) do
	local v5 = ("Total%*"):format(v4)
	v3[v5] = v5
end
for v6 in v2 do
	local v7 = ("Rune%*Opened"):format(v6)
	v3[v7] = v7
end
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[StatisticTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4054"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["EARTH_WORLD"] = "EARTH_WORLD",
	["LAVA_WORLD"] = "LAVA_WORLD",
	["VOID_WORLD"] = "VOID_WORLD",
	["ICE_WORLD"] = "ICE_WORLD",
	["VALENTINE_WORLD"] = "VALENTINE_WORLD",
	["GLOW_WORLD"] = "GLOW_WORLD",
	["EVENT_1M_WORLD"] = "EVENT_1M_WORLD",
	["CANDY_WORLD"] = "CANDY_WORLD"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WorldTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4055"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["GreenSlime"] = "GreenSlime",
	["BlueSlime"] = "BlueSlime",
	["RedSlime"] = "RedSlime",
	["PurpleSlime"] = "PurpleSlime",
	["GreySlime"] = "GreySlime",
	["OrangeSlime"] = "OrangeSlime",
	["YellowSlime"] = "YellowSlime",
	["BrightRedSlime"] = "BrightRedSlime",
	["MagmaSlime"] = "MagmaSlime",
	["IceSlime"] = "IceSlime",
	["PurpleIceSlime"] = "PurpleIceSlime",
	["PinkIceSlime"] = "PinkIceSlime",
	["BlueIceSlime"] = "BlueIceSlime",
	["WhiteIceSlime"] = "WhiteIceSlime",
	["ValentineSlime1"] = "ValentineSlime1",
	["ValentineSlime2"] = "ValentineSlime2",
	["ValentineSlime3"] = "ValentineSlime3",
	["ValentineSlime4"] = "ValentineSlime4",
	["ValentineSlime5"] = "ValentineSlime5",
	["GloopSlime1"] = "GloopSlime1",
	["GloopSlime2"] = "GloopSlime2",
	["GloopSlime3"] = "GloopSlime3",
	["GloopSlime4"] = "GloopSlime4",
	["GloopSlime5"] = "GloopSlime5",
	["Event1MSlime1"] = "Event1MSlime1",
	["Event1MSlime2"] = "Event1MSlime2",
	["Event1MSlime3"] = "Event1MSlime3",
	["Event1MSlime4"] = "Event1MSlime4",
	["Event1MSlime5"] = "Event1MSlime5",
	["CandySlime1"] = "CandySlime1",
	["CandySlime2"] = "CandySlime2",
	["CandySlime3"] = "CandySlime3",
	["CandySlime4"] = "CandySlime4",
	["CandySlime5"] = "CandySlime5",
	["CandySlime6"] = "CandySlime6"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4056"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Max"] = "Max",
	["ValentineMaxedOut"] = "ValentineMaxedOut",
	["World1Complete"] = "World1Complete",
	["World2Complete"] = "World2Complete",
	["World3Complete"] = "World3Complete",
	["GlowWorldReady"] = "GlowWorldReady",
	["CasualPreGlow"] = "CasualPreGlow",
	["CandyWorldReady"] = "CandyWorldReady",
	["CandyZonesFilled"] = "CandyZonesFilled"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TestingPresetTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4057"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Normal"] = "Normal",
	["Golden"] = "Golden",
	["Diamond"] = "Diamond",
	["Rainbow"] = "Rainbow"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeVarientTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4058"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["HeartAttack"] = "HeartAttack",
	["CoinStar"] = "CoinStar",
	["DamageStar"] = "DamageStar",
	["ShardStar"] = "ShardStar",
	["WorldSurge"] = "WorldSurge",
	["RuneRoyalty"] = "RuneRoyalty"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AmuletPassiveTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4059"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Pink"] = "Pink",
	["Charm"] = "Charm",
	["Pulse"] = "Pulse",
	["Adore"] = "Adore",
	["Glitter"] = "Glitter",
	["Shimmer"] = "Shimmer",
	["Heartbeat"] = "Heartbeat"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ValentineTraitTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4060"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Green"] = "Green",
	["Yellow"] = "Yellow",
	["Pink"] = "Pink",
	["Purple"] = "Purple",
	["Spiked"] = "Spiked"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GloopTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4061"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Spark"] = "Spark",
	["Glow"] = "Glow",
	["Flash"] = "Flash",
	["Dazzle"] = "Dazzle",
	["Radiance"] = "Radiance",
	["Brilliance"] = "Brilliance",
	["Supernova"] = "Supernova"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MillionaireTraitTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4062"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["GloopGuardian"] = "GloopGuardian",
	["AscensionKeeper"] = "AscensionKeeper",
	["ConfettiCritic"] = "ConfettiCritic",
	["GloopMagnet"] = "GloopMagnet",
	["SlimeSurge"] = "SlimeSurge",
	["ShardSeeker"] = "ShardSeeker",
	["GoldenTouch"] = "GoldenTouch",
	["ComboKing"] = "ComboKing"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AmuletPerkTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4063"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["CandyPet_Gumdrop"] = "CandyPet_Gumdrop",
	["CandyPet_Taffy"] = "CandyPet_Taffy",
	["CandyPet_JellyBean"] = "CandyPet_JellyBean",
	["CandyPet_Lollipop"] = "CandyPet_Lollipop",
	["CandyPet_Caramel"] = "CandyPet_Caramel",
	["CandyPet_CottonCandy"] = "CandyPet_CottonCandy",
	["CandyPet_Peppermint"] = "CandyPet_Peppermint",
	["CandyPet_ChocolateTruffle"] = "CandyPet_ChocolateTruffle",
	["CandyPet_GoldenGummy"] = "CandyPet_GoldenGummy",
	["CandyPet_CosmicCandy"] = "CandyPet_CosmicCandy"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PetSlimeTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4064"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["PetAttackSpeed"] = "PetAttackSpeed",
	["PetDamage"] = "PetDamage",
	["PetAgility"] = "PetAgility",
	["PetCoinMultiplier"] = "PetCoinMultiplier",
	["PetRange"] = "PetRange",
	["PetCritChance"] = "PetCritChance"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PetAttributeTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4065"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Pebble"] = "Pebble",
	["Dewdrop"] = "Dewdrop",
	["Bramble"] = "Bramble",
	["Ember"] = "Ember",
	["Gilded"] = "Gilded",
	["Ironhide"] = "Ironhide",
	["Glacial"] = "Glacial",
	["Tempest"] = "Tempest",
	["Voidborn"] = "Voidborn",
	["Celestial"] = "Celestial"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeRaceTypes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="4066"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Functions]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="4067"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
return function(p2, p_u_3)
	-- upvalues: (copy) v_u_1
	local v_u_4 = nil
	local v_u_5 = 0
	p2.Touched:Connect(function(p6)
		-- upvalues: (ref) v_u_1, (ref) v_u_5, (ref) v_u_4, (copy) p_u_3
		local v7 = v_u_1:GetPlayerFromCharacter(p6.Parent)
		if v7 and v7 == v_u_1.LocalPlayer then
			v_u_5 = v_u_5 + 1
			if v_u_5 <= 1 then
				if v_u_4 then
					v_u_4()
					v_u_4 = nil
				end
				v_u_4 = p_u_3()
			end
		else
			return
		end
	end)
	p2.TouchEnded:Connect(function(p8)
		-- upvalues: (ref) v_u_1, (ref) v_u_5, (ref) v_u_4
		local v9 = v_u_1:GetPlayerFromCharacter(p8.Parent)
		if v9 and v9 == v_u_1.LocalPlayer then
			v_u_5 = v_u_5 - 1
			if v_u_5 <= 0 then
				if v_u_4 then
					v_u_4()
					v_u_4 = nil
				end
			end
		else
			return
		end
	end)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CreateButtonZone]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4068"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Packages.Observers)
return function(p4, p_u_5)
	-- upvalues: (copy) v_u_1, (copy) v_u_3
	local v_u_6 = {}
	local v_u_7 = {}
	p4.Touched:Connect(function(p8)
		-- upvalues: (ref) v_u_1, (copy) v_u_6, (copy) v_u_7, (copy) p_u_5
		local v9 = v_u_1:GetPlayerFromCharacter(p8.Parent)
		if v9 then
			if not v_u_6[v9] then
				v_u_6[v9] = 0
			end
			local v10 = v_u_6
			v10[v9] = v10[v9] + 1
			if v_u_6[v9] <= 1 then
				if v_u_7[v9] then
					v_u_7[v9]()
					v_u_7[v9] = nil
				end
				v_u_7[v9] = p_u_5(v9)
			end
		else
			return
		end
	end)
	p4.TouchEnded:Connect(function(p11)
		-- upvalues: (ref) v_u_1, (copy) v_u_6, (copy) v_u_7
		local v12 = v_u_1:GetPlayerFromCharacter(p11.Parent)
		if v12 then
			if v_u_6[v12] then
				local v13 = v_u_6
				v13[v12] = v13[v12] - 1
				if v_u_6[v12] <= 0 then
					if v_u_7[v12] then
						v_u_7[v12]()
						v_u_7[v12] = nil
					end
				end
			else
				return
			end
		else
			return
		end
	end)
	v_u_3.observeCharacter(function(p_u_14, _)
		-- upvalues: (copy) v_u_6, (copy) v_u_7
		return function()
			-- upvalues: (ref) v_u_6, (copy) p_u_14, (ref) v_u_7
			v_u_6[p_u_14] = nil
			if v_u_7[p_u_14] then
				v_u_7[p_u_14]()
			end
			v_u_7[p_u_14] = nil
		end
	end)
	v_u_1.PlayerRemoving:Connect(function(p15)
		-- upvalues: (copy) v_u_6, (copy) v_u_7
		v_u_6[p15] = nil
		if v_u_7[p15] then
			v_u_7[p15]()
		end
		v_u_7[p15] = nil
	end)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CreateButtonZoneServer]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4069"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.CurrencyData)
local v3 = require(v1.Enums.CurrencyTypes)
local v_u_4 = require(v1.Enums.SettingTypes)
local v_u_5 = require(v1.Packages.Throttle)
local v_u_6 = require(v1.Utility.Format)
local v_u_7 = require(v1.Utility.SettingUtil)
local v_u_8 = require(v1.Utility.Sound)
local v_u_9 = require(v1.Utility.Spring)
local v_u_10 = require(v1.Utility.UI):get("Persistent", "FirePopup")
local v_u_11 = v_u_10:WaitForChild("Template")
v_u_11.Visible = false
local v_u_12 = Random.new()
local v_u_13 = {
	[v3.Hearts] = "HeartCollect",
	[v3.CrystalHearts] = "HeartCrystalCollect"
}
local v_u_14 = {}
for _ = 1, 20 do
	local v15 = v_u_11:Clone()
	v15.Visible = false
	v15.Parent = v_u_10
	table.insert(v_u_14, v15)
end
return function(p_u_16)
	-- upvalues: (copy) v_u_7, (copy) v_u_4, (copy) v_u_2, (copy) v_u_5, (copy) v_u_8, (copy) v_u_13, (copy) v_u_14, (copy) v_u_11, (copy) v_u_10, (copy) v_u_6, (copy) v_u_12, (copy) v_u_9
	if v_u_7.get(v_u_4.CurrencyPopup) then
		local v17 = v_u_2[p_u_16.currency]
		if v17 then
			v_u_5("coin-collect-sound", 0.1, function()
				-- upvalues: (ref) v_u_8, (ref) v_u_13, (copy) p_u_16
				v_u_8.play(v_u_13[p_u_16.currency] or "CoinCollect")
			end)
			local v_u_18 = table.remove(v_u_14)
			if not v_u_18 then
				v_u_18 = v_u_11:Clone()
				v_u_18.Visible = false
				v_u_18.Parent = v_u_10
			end
			v_u_18.Position = UDim2.fromScale(0.5, 0.5)
			v_u_18.Rotation = 0
			v_u_18.Visible = true
			local v19 = v_u_18.Amount
			v19.TextTransparency = 0
			local v20 = v_u_6.abbreviateComma
			local v21 = p_u_16.amount
			v19.Text = ("+%*"):format((v20((math.floor(v21)))))
			v19.UIGradient.Color = p_u_16.color or v19.UIGradient.Color
			v_u_18.Icon.Image = v17.Icon
			local v22 = v_u_12:NextNumber(0.2, 0.8)
			local v23 = v_u_12:NextNumber(0.2, 0.8)
			v_u_18.Position = UDim2.fromScale(v22, v23 + 0.1)
			v_u_18.Rotation = math.random(2) == 1 and -30 or 30
			v_u_9.target(v_u_18, 0.5, 3, {
				["Position"] = UDim2.fromScale(v22, v23),
				["Rotation"] = 0
			})
			local v24 = v_u_18:FindFirstChild("WhiteText")
			if not v24 then
				v24 = v19:Clone()
				v24.Name = "WhiteText"
				v24.TextColor3 = Color3.new(1, 1, 1)
				v24.ZIndex = v19.ZIndex - 1
				v24.UIGradient:Destroy()
				v24.UIStroke:Destroy()
				v24.Parent = v_u_18
			end
			v24.TextTransparency = 0
			v24.UIScale.Scale = 1
			v_u_9.target(v24, 1, 1.5, {
				["TextTransparency"] = 1
			})
			v_u_9.target(v24.UIScale, 0.5, 2, {
				["Scale"] = 2
			})
			task.delay(p_u_16.duration or 1, function()
				-- upvalues: (copy) v_u_18, (ref) v_u_10, (ref) v_u_14
				local v25 = v_u_18
				v25.Visible = false
				v25.Parent = v_u_10
				local v26 = v_u_14
				table.insert(v26, v25)
			end)
		end
	else
		return
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CurrencyPopup]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4070"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.Constants)
local v_u_3 = {}
require(v1.Packages.Observers).observePlayer(function(p_u_4)
	-- upvalues: (copy) v_u_3
	return function()
		-- upvalues: (ref) v_u_3, (copy) p_u_4
		v_u_3[p_u_4] = nil
	end
end)
return function(p_u_5)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	if v_u_3[p_u_5] then
		return true
	end
	local v6, v7 = pcall(function()
		-- upvalues: (copy) p_u_5, (ref) v_u_2
		return p_u_5:IsInGroup(v_u_2.GROUP_ID)
	end)
	if not (v6 and v7) then
		return false
	end
	v_u_3[p_u_5] = true
	return true
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[IsInGroup]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4071"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = require(v1.Config.CurrencyData)
local v_u_4 = require(v1.Enums.SettingTypes)
require(v1.Utility.Format)
local v_u_5 = require(v1.Utility.SettingUtil)
local v_u_6 = v1:WaitForChild("Assets")
local v_u_7 = {}
for _ = 1, 20 do
	local v8 = Instance.new("Attachment")
	local v9 = v_u_6.Billboard.Collect:Clone()
	v9.Parent = v8
	table.insert(v_u_7, {
		["attachment"] = v8,
		["collect"] = v9
	})
end
return function(p10)
	-- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) v_u_7, (copy) v_u_6, (copy) v_u_3, (copy) v_u_2
	if v_u_5.get(v_u_4.DamageIndicators) then
		local v_u_11 = table.remove(v_u_7)
		if not v_u_11 then
			local v12 = Instance.new("Attachment")
			local v13 = v_u_6.Billboard.Collect:Clone()
			v13.Parent = v12
			v_u_11 = {
				["attachment"] = v12,
				["collect"] = v13
			}
		end
		local v14 = v_u_11.attachment
		local v15 = v_u_11.collect
		v14.Position = p10.StartPosition
		v14.Parent = workspace
		v15.Canvas.Amount.TextColor3 = p10.Color or Color3.fromRGB(255, 255, 255)
		v15.Canvas.Amount.Text = p10.Value
		v15.Canvas.Icon.Visible = p10.Currency ~= nil and true or p10.Icon ~= nil
		if p10.Currency then
			v15.Canvas.Icon.Image = v_u_3[p10.Currency].Icon
		end
		if p10.Icon then
			v15.Canvas.Icon.Image = p10.Icon
		end
		local v16 = v_u_2:Create(v14, TweenInfo.new(p10.Duration or 1, Enum.EasingStyle.Linear), {
			["Position"] = p10.EndPosition
		})
		v16:Play()
		v16.Completed:Once(function()
			-- upvalues: (copy) v_u_11, (ref) v_u_7
			local v17 = v_u_11
			v17.attachment.Parent = nil
			local v18 = v_u_7
			table.insert(v18, v17)
		end)
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[NumberIndicator]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4072"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(...)
	local v1 = { ... }
	local v2 = v1[1]
	for v3 = 2, #v1 do
		v2 = v2:WaitForChild(v1[v3])
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WaitFor]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4073"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	local v2 = 1.115 ^ (math.min(p1, 111) - 1) * 50
	return math.floor(v2)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CalculateSkillXP]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4074"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("HttpService")
local v_u_2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = require(v3.Utility.Cooldown)
return function(p5, p_u_6, p_u_7)
	-- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_4
	local v_u_8 = v_u_1:GenerateGUID(false)
	p5.Touched:Connect(function(p9)
		-- upvalues: (ref) v_u_2, (copy) p_u_7, (ref) v_u_4, (copy) v_u_8, (copy) p_u_6
		local v10 = v_u_2:GetPlayerFromCharacter(p9.Parent)
		if v10 then
			if not (p_u_7 and v_u_4.isOnCooldown(v10, v_u_8, p_u_7)) then
				p_u_6(v10)
			end
		else
			return
		end
	end)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Touched]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4075"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.GloopData)
local v3 = require(v1.Enums.CurrencyTypes)
local v_u_4 = require(v1.Enums.SettingTypes)
require(v1.Packages.Throttle)
local v_u_5 = require(v1.Utility.Format)
local v_u_6 = require(v1.Utility.SettingUtil)
require(v1.Utility.Sound)
local v_u_7 = require(v1.Utility.Spring)
local v_u_8 = require(v1.Utility.UI):get("Persistent", "FirePopup")
local v_u_9 = v_u_8:WaitForChild("Template")
v_u_9.Visible = false
local v_u_10 = Random.new()
local _ = {
	[v3.Hearts] = "HeartCollect",
	[v3.CrystalHearts] = "HeartCrystalCollect"
}
local v_u_11 = {}
for _ = 1, 20 do
	local v12 = v_u_9:Clone()
	v12.Visible = false
	v12.Parent = v_u_8
	table.insert(v_u_11, v12)
end
return function(p13)
	-- upvalues: (copy) v_u_6, (copy) v_u_4, (copy) v_u_2, (copy) v_u_11, (copy) v_u_9, (copy) v_u_8, (copy) v_u_5, (copy) v_u_10, (copy) v_u_7
	if v_u_6.get(v_u_4.CurrencyPopup) then
		local v14 = v_u_2[p13.gloop]
		if v14 then
			local v_u_15 = table.remove(v_u_11)
			if not v_u_15 then
				v_u_15 = v_u_9:Clone()
				v_u_15.Visible = false
				v_u_15.Parent = v_u_8
			end
			v_u_15.Position = UDim2.fromScale(0.5, 0.5)
			v_u_15.Rotation = 0
			v_u_15.Visible = true
			local v16 = v_u_15.Amount
			v16.TextTransparency = 0
			local v17 = v_u_5.abbreviateComma
			local v18 = p13.amount
			v16.Text = ("+%*"):format((v17((math.floor(v18)))))
			v16.UIGradient.Color = p13.color or v16.UIGradient.Color
			v_u_15.Icon.Image = v14.Icon
			local v19 = v_u_10:NextNumber(0.2, 0.8)
			local v20 = v_u_10:NextNumber(0.2, 0.8)
			v_u_15.Position = UDim2.fromScale(v19, v20 + 0.1)
			v_u_15.Rotation = math.random(2) == 1 and -30 or 30
			v_u_7.target(v_u_15, 0.5, 3, {
				["Position"] = UDim2.fromScale(v19, v20),
				["Rotation"] = 0
			})
			local v21 = v_u_15:FindFirstChild("WhiteText")
			if not v21 then
				v21 = v16:Clone()
				v21.Name = "WhiteText"
				v21.TextColor3 = Color3.new(1, 1, 1)
				v21.ZIndex = v16.ZIndex - 1
				v21.UIGradient:Destroy()
				v21.UIStroke:Destroy()
				v21.Parent = v_u_15
			end
			v21.TextTransparency = 0
			v21.UIScale.Scale = 1
			v_u_7.target(v21, 1, 1.5, {
				["TextTransparency"] = 1
			})
			v_u_7.target(v21.UIScale, 0.5, 2, {
				["Scale"] = 2
			})
			task.delay(p13.duration or 1, function()
				-- upvalues: (copy) v_u_15, (ref) v_u_8, (ref) v_u_11
				local v22 = v_u_15
				v22.Visible = false
				v22.Parent = v_u_8
				local v23 = v_u_11
				table.insert(v23, v22)
			end)
		end
	else
		return
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GloopPopup]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="4076"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	local v2 = 1.115 ^ (math.min(p1, 211) - 1) * 50
	return math.floor(v2)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CalculatePetXP]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="4077"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Assets]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Folder" referent="4078"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Animations]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="4079"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VFX]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Attachment" referent="4080"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Collect]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ParticleEmitter" referent="4081"><Properties><Vector3 name="Acceleration"><X>0</X><Y>-50</Y><Z>0</Z></Vector3><float name="Brightness">10</float><ColorSequence name="Color">0 1 1 0.49803921580314636 0 1 1 1 0.49803921580314636 0 </ColorSequence><float name="Drag">6</float><bool name="Enabled">false</bool><NumberRange name="FlipbookFramerate">2 2</NumberRange><NumberRange name="Lifetime">0.25 0.25</NumberRange><bool name="LockedToPart">true</bool><token name="Orientation">2</token><float name="Rate">0</float><NumberRange name="Rotation">90 90</NumberRange><NumberSequence name="Size">0 0 0 0.2444799840450287 1.1452744007110596 0.10687500238418579 1 0 0 </NumberSequence><NumberRange name="Speed">30 40</NumberRange><Vector2 name="SpreadAngle"><X>-360</X><Y>360</Y></Vector2><NumberSequence name="Squash">0 -0.30000001192092896 0 1 -0.30000001192092896 0 </NumberSequence><Content name="Texture"><url><![CDATA[rbxassetid://8030734851]]></url></Content><NumberSequence name="Transparency">0 0 0 1 1 0 </NumberSequence><BinaryString name="AttributesSerialize">AgAAAAkAAABFbWl0Q291bnQGAAAAAAAAFEAJAAAARW1pdERlbGF5BgAAAAAAAAAA</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Shards]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ParticleEmitter" referent="4082"><Properties><Vector3 name="Acceleration"><X>0</X><Y>-50</Y><Z>0</Z></Vector3><float name="Brightness">10</float><ColorSequence name="Color">0 1 1 0.49803921580314636 0 1 1 1 0.49803921580314636 0 </ColorSequence><float name="Drag">6</float><bool name="Enabled">false</bool><NumberRange name="FlipbookFramerate">2 2</NumberRange><NumberRange name="Lifetime">0.25 0.25</NumberRange><bool name="LockedToPart">true</bool><token name="Orientation">2</token><float name="Rate">0</float><NumberRange name="Rotation">90 90</NumberRange><NumberSequence name="Size">0 0 0 0.2444799840450287 1.1452744007110596 0.10687500238418579 1 0 0 </NumberSequence><NumberRange name="Speed">30 40</NumberRange><Vector2 name="SpreadAngle"><X>-360</X><Y>360</Y></Vector2><NumberSequence name="Squash">0 -0.30000001192092896 0 1 -0.30000001192092896 0 </NumberSequence><Content name="Texture"><url><![CDATA[rbxassetid://8030734851]]></url></Content><NumberSequence name="Transparency">0 0 0 1 1 0 </NumberSequence><BinaryString name="AttributesSerialize">AgAAAAkAAABFbWl0Q291bnQGAAAAAAAALkAJAAAARW1pdERlbGF5BgAAAAAAAAAA</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeHit]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4083"><Properties><Vector3 name="Acceleration"><X>0</X><Y>-150</Y><Z>0</Z></Vector3><float name="Brightness">10</float><ColorSequence name="Color">0 0.9921568632125854 0.6431372761726379 0.6784313917160034 0 1 0.9921568632125854 0.6431372761726379 0.6784313917160034 0 </ColorSequence><float name="Drag">6</float><bool name="Enabled">false</bool><NumberRange name="FlipbookFramerate">2 2</NumberRange><NumberRange name="Lifetime">0.5 0.5</NumberRange><bool name="LockedToPart">true</bool><token name="Orientation">2</token><float name="Rate">0</float><NumberRange name="Rotation">90 90</NumberRange><NumberSequence name="Size">0 0 0 0.2444799840450287 1.1452744007110596 0.10687500238418579 1 0 0 </NumberSequence><NumberRange name="Speed">42 42</NumberRange><Vector2 name="SpreadAngle"><X>-360</X><Y>360</Y></Vector2><NumberSequence name="Squash">0 -0.699999988079071 0 1 -0.6750001907348633 0 </NumberSequence><Content name="Texture"><url><![CDATA[rbxassetid://8030734851]]></url></Content><NumberSequence name="Transparency">0 0 0 1 1 0 </NumberSequence><BinaryString name="AttributesSerialize">AgAAAAkAAABFbWl0Q291bnQGAAAAAAAASUAJAAAARW1pdERlbGF5BgAAAAAAAAAA</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeDestroy]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Attachment" referent="4084"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Rune]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ParticleEmitter" referent="4085"><Properties><float name="Brightness">10</float><ColorSequence name="Color">0 1 0.3333333432674408 1 0 0.24913495779037476 0.3333333432674408 0.6666666865348816 0.49803921580314636 0 0.4221453368663788 1 0.9830194711685181 0.9324920773506165 0 0.5224913954734802 1 0.8392156958580017 0.3607843220233917 0 0.6366782188415527 0.22745098173618317 0.9372549057006836 1 0 0.7352941632270813 0.8235294222831726 0.4156862795352936 1 0 0.7854671478271484 0.8235294222831726 0.4156862795352936 1 0 0.8685121536254883 0.4913494884967804 0.5910034775733948 1 0 0.8806228637695312 0.4173083007335663 0.6300807595252991 1 0 0.9584775567054749 0.8485002517700195 0.75291907787323 0.5850195288658142 0 1 1 0.7960784435272217 0.43921568989753723 0 </ColorSequence><float name="Drag">5</float><bool name="Enabled">false</bool><NumberRange name="Lifetime">0.800000011920929 1</NumberRange><bool name="LockedToPart">true</bool><float name="Rate">25</float><NumberRange name="RotSpeed">-250 250</NumberRange><NumberRange name="Rotation">-180 180</NumberRange><NumberSequence name="Size">0 1.0090819597244263 0 0.20447997748851776 0.4866465628147125 0.21527080237865448 0.41047999262809753 0 0 0.5204799771308899 0.41264721751213074 0.15472587943077087 0.8484799861907959 0.7590987086296082 0 1 1 0 </NumberSequence><NumberRange name="Speed">32 38.400001525878906</NumberRange><Vector2 name="SpreadAngle"><X>-360</X><Y>360</Y></Vector2><Content name="Texture"><url><![CDATA[rbxassetid://12942158384]]></url></Content><NumberSequence name="Transparency">0 1 0 0.2964799702167511 0 0 0.6884799599647522 0 0 1 1 0 </NumberSequence><float name="ZOffset">-1</float><BinaryString name="AttributesSerialize">AQAAAAkAAABFbWl0Q291bnQGAAAAAAAAJEA=</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Dots]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4086"><Properties><float name="Brightness">10</float><ColorSequence name="Color">0 1 0.3333333432674408 1 0 0.24913495779037476 0.3333333432674408 0.6666666865348816 0.49803921580314636 0 0.4221453368663788 1 0.9830194711685181 0.9324920773506165 0 0.5224913954734802 1 0.8392156958580017 0.3607843220233917 0 0.6366782188415527 0.22745098173618317 0.9372549057006836 1 0 0.7352941632270813 0.8235294222831726 0.4156862795352936 1 0 0.7854671478271484 0.8235294222831726 0.4156862795352936 1 0 0.8685121536254883 0.4913494884967804 0.5910034775733948 1 0 0.8806228637695312 0.4173083007335663 0.6300807595252991 1 0 0.9584775567054749 0.8485002517700195 0.75291907787323 0.5850195288658142 0 1 1 0.7960784435272217 0.43921568989753723 0 </ColorSequence><float name="Drag">5</float><bool name="Enabled">false</bool><NumberRange name="Lifetime">0.800000011920929 1</NumberRange><bool name="LockedToPart">true</bool><float name="Rate">25</float><NumberRange name="RotSpeed">-250 250</NumberRange><NumberRange name="Rotation">-180 180</NumberRange><NumberSequence name="Size">0 1.0090819597244263 0 0.20447997748851776 0.4866465628147125 0.21527080237865448 0.41047999262809753 0 0 0.5204799771308899 0.41264721751213074 0.15472587943077087 0.8484799861907959 0.7590987086296082 0 1 1 0 </NumberSequence><NumberRange name="Speed">32 38.400001525878906</NumberRange><Vector2 name="SpreadAngle"><X>-360</X><Y>360</Y></Vector2><Content name="Texture"><url><![CDATA[rbxassetid://10598374841]]></url></Content><NumberSequence name="Transparency">0 1 0 0.2964799702167511 0 0 0.6884799599647522 0 0 1 1 0 </NumberSequence><float name="ZOffset">-1</float><BinaryString name="AttributesSerialize">AQAAAAkAAABFbWl0Q291bnQGAAAAAAAAJEA=</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Dots]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4087"><Properties><float name="Brightness">10</float><ColorSequence name="Color">0 1 0.3333333432674408 1 0 1 1 0.3333333432674408 1 0 </ColorSequence><bool name="Enabled">false</bool><NumberRange name="Lifetime">0.10000000149011612 0.10000000149011612</NumberRange><bool name="LockedToPart">true</bool><float name="Rate">1</float><NumberRange name="Rotation">-180 180</NumberRange><NumberSequence name="Size">0 12.934196472167969 0 1 0 0 </NumberSequence><NumberRange name="Speed">0 0</NumberRange><Content name="Texture"><url><![CDATA[rbxassetid://15707449578]]></url></Content><NumberSequence name="Transparency">0 1 0 0.3041920065879822 0 0 0.6601920127868652 0 0 1 1 0 </NumberSequence><BinaryString name="AttributesSerialize">AQAAAAkAAABFbWl0Q291bnQGAAAAAAAA8D8=</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Effect]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4088"><Properties><float name="Brightness">4</float><ColorSequence name="Color">0 1 0.3333333432674408 1 0 0.24913495779037476 0.3333333432674408 0.6666666865348816 0.49803921580314636 0 0.4221453368663788 1 0.9830194711685181 0.9324920773506165 0 0.5224913954734802 1 0.8392156958580017 0.3607843220233917 0 0.6366782188415527 0.22745098173618317 0.9372549057006836 1 0 0.7352941632270813 0.8235294222831726 0.4156862795352936 1 0 0.7854671478271484 0.8235294222831726 0.4156862795352936 1 0 0.8685121536254883 0.4913494884967804 0.5910034775733948 1 0 0.8806228637695312 0.4173083007335663 0.6300807595252991 1 0 0.9584775567054749 0.8485002517700195 0.75291907787323 0.5850195288658142 0 1 1 0.7960784435272217 0.43921568989753723 0 </ColorSequence><float name="Drag">5</float><NumberRange name="Lifetime">0.2750000059604645 0.44999998807907104</NumberRange><token name="Orientation">2</token><float name="Rate">0</float><NumberRange name="Rotation">90 90</NumberRange><NumberSequence name="Size">0 0 0 0.25 2.411099910736084 0.5130000114440918 1 0 0 </NumberSequence><NumberRange name="Speed">42 54</NumberRange><Vector2 name="SpreadAngle"><X>-360</X><Y>360</Y></Vector2><NumberSequence name="Squash">0 0.33000001311302185 0 1 0.33000001311302185 0 </NumberSequence><Content name="Texture"><url><![CDATA[rbxassetid://8030734851]]></url></Content><BinaryString name="AttributesSerialize">AQAAAAkAAABFbWl0Q291bnQGAAAAAAAALkA=</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Shards]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4089"><Properties><float name="Brightness">5</float><ColorSequence name="Color">0 1 0.3333333432674408 1 0 0.24913495779037476 0.3333333432674408 0.6666666865348816 0.49803921580314636 0 0.4221453368663788 1 0.9830194711685181 0.9324920773506165 0 0.5224913954734802 1 0.8392156958580017 0.3607843220233917 0 0.6366782188415527 0.22745098173618317 0.9372549057006836 1 0 0.7352941632270813 0.8235294222831726 0.4156862795352936 1 0 0.7854671478271484 0.8235294222831726 0.4156862795352936 1 0 0.8685121536254883 0.4913494884967804 0.5910034775733948 1 0 0.8806228637695312 0.4173083007335663 0.6300807595252991 1 0 0.9584775567054749 0.8485002517700195 0.75291907787323 0.5850195288658142 0 1 1 0.7960784435272217 0.43921568989753723 0 </ColorSequence><float name="Drag">15</float><token name="EmissionDirection">2</token><bool name="Enabled">false</bool><NumberRange name="Lifetime">0.375 0.44999998807907104</NumberRange><float name="LightEmission">1</float><float name="Rate">10</float><NumberSequence name="Size">0 0 0 0.16500000655651093 0.48000001907348633 0.15000000596046448 0.3683932423591614 1.9499995708465576 0.33000001311302185 0.550000011920929 0.15000000596046448 0.15000000596046448 1 0 0 </NumberSequence><NumberRange name="Speed">72 96</NumberRange><Vector2 name="SpreadAngle"><X>-360</X><Y>360</Y></Vector2><NumberSequence name="Squash">0 0 0 1 0.25 0 </NumberSequence><Content name="Texture"><url><![CDATA[rbxassetid://10598374841]]></url></Content><float name="TimeScale">0.5</float><BinaryString name="AttributesSerialize">AgAAAAkAAABFbWl0Q291bnQGAAAAAAAALkAJAAAARW1pdERlbGF5BgAAAAAAAAAA</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Sparks]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Attachment" referent="4090"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Lightning]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ParticleEmitter" referent="4091"><Properties><Vector3 name="Acceleration"><X>0</X><Y>0.2766442894935608</Y><Z>0</Z></Vector3><float name="Brightness">0.014999999664723873</float><bool name="Enabled">false</bool><NumberRange name="Lifetime">0.5 1</NumberRange><float name="LightEmission">1</float><float name="Rate">5</float><NumberRange name="RotSpeed">450 450</NumberRange><NumberRange name="Rotation">0 180</NumberRange><NumberSequence name="Size">0 5.532885551452637 0 1 5.532885551452637 0 </NumberSequence><NumberRange name="Speed">0.2766442894935608 0.5532885789871216</NumberRange><Vector2 name="SpreadAngle"><X>360</X><Y>-360</Y></Vector2><Content name="Texture"><url><![CDATA[rbxassetid://8153562120]]></url></Content><NumberSequence name="Transparency">0 1 0 0.49695494771003723 0 0 1 1 0 </NumberSequence><BinaryString name="AttributesSerialize">AgAAAAkAAABFbWl0Q291bnQGAAAAAAAACEAJAAAARW1pdERlbGF5BgAAAAAAAAAA</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Swirl3]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4092"><Properties><Vector3 name="Acceleration"><X>0</X><Y>0.2766442894935608</Y><Z>0</Z></Vector3><float name="Brightness">0.014999999664723873</float><token name="EmissionDirection">3</token><bool name="Enabled">false</bool><NumberRange name="Lifetime">1 1.5</NumberRange><float name="LightEmission">1</float><float name="Rate">5</float><NumberRange name="RotSpeed">450 450</NumberRange><NumberRange name="Rotation">0 180</NumberRange><NumberSequence name="Size">0 5.532885551452637 0 1 5.532885551452637 0 </NumberSequence><NumberRange name="Speed">0.8299328684806824 1.1065771579742432</NumberRange><Vector2 name="SpreadAngle"><X>15</X><Y>15</Y></Vector2><Content name="Texture"><url><![CDATA[rbxassetid://8153562120]]></url></Content><NumberSequence name="Transparency">0 1 0 0.49695494771003723 0 0 1 1 0 </NumberSequence><BinaryString name="AttributesSerialize">AgAAAAkAAABFbWl0Q291bnQGAAAAAAAAAEAJAAAARW1pdERlbGF5BgAAAAAAAAAA</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Swirl2]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4093"><Properties><float name="Brightness">10</float><ColorSequence name="Color">0 0.30588236451148987 0.6431372761726379 1 0 1 0.30588236451148987 0.6431372761726379 1 0 </ColorSequence><token name="EmissionDirection">3</token><bool name="Enabled">false</bool><token name="FlipbookLayout">2</token><token name="FlipbookMode">1</token><NumberRange name="Lifetime">0.4000000059604645 1</NumberRange><float name="LightEmission">1</float><bool name="LockedToPart">true</bool><float name="Rate">10</float><NumberRange name="Rotation">-360 360</NumberRange><NumberSequence name="Size">0 4.149664402008057 0 1 4.149664402008057 0 </NumberSequence><NumberRange name="Speed">0.0002766443067230284 0.0002766443067230284</NumberRange><Content name="Texture"><url><![CDATA[http://www.roblox.com/asset/?id=11372187376]]></url></Content><BinaryString name="AttributesSerialize">AgAAAAkAAABFbWl0Q291bnQGAAAAAAAAAEAJAAAARW1pdERlbGF5BgAAAAAAAAAA</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ParticleEmitter02]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4094"><Properties><float name="Brightness">10</float><ColorSequence name="Color">0 0.30588236451148987 0.6431372761726379 1 0 1 0.30588236451148987 0.6431372761726379 1 0 </ColorSequence><token name="EmissionDirection">3</token><bool name="Enabled">false</bool><token name="FlipbookLayout">2</token><token name="FlipbookMode">1</token><NumberRange name="Lifetime">0.4000000059604645 1</NumberRange><float name="LightEmission">1</float><bool name="LockedToPart">true</bool><float name="Rate">10</float><NumberRange name="Rotation">-360 360</NumberRange><NumberSequence name="Size">0 4.149664402008057 0 1 4.149664402008057 0 </NumberSequence><NumberRange name="Speed">0.0002766443067230284 0.0002766443067230284</NumberRange><Content name="Texture"><url><![CDATA[http://www.roblox.com/asset/?id=11372187376]]></url></Content><BinaryString name="AttributesSerialize">AgAAAAkAAABFbWl0Q291bnQGAAAAAAAAAEAJAAAARW1pdERlbGF5BgAAAAAAAAAA</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ParticleEmitter01]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4095"><Properties><float name="Brightness">5</float><ColorSequence name="Color">0 0.40392157435417175 0.8627451062202454 1 0 1 0.40392157435417175 0.8627451062202454 1 0 </ColorSequence><float name="Drag">5</float><token name="EmissionDirection">0</token><bool name="Enabled">false</bool><NumberRange name="Lifetime">0.5 0.5</NumberRange><float name="LightEmission">1</float><bool name="LockedToPart">true</bool><NumberRange name="Rotation">-360 360</NumberRange><NumberSequence name="Size">0 0 0 0.5 2.948713779449463 0 1 2.948713779449463 0 </NumberSequence><NumberRange name="Speed">14.743571281433105 14.743571281433105</NumberRange><Vector2 name="SpreadAngle"><X>90</X><Y>90</Y></Vector2><NumberSequence name="Squash">0 0 0 0.5 0.10000000149011612 0 1 0 0 </NumberSequence><Content name="Texture"><url><![CDATA[rbxassetid://10204970423]]></url></Content><NumberSequence name="Transparency">0 1 0 0.1411042958498001 0.8579235076904297 0 0.35429447889328003 0.9016393423080444 0 0.6150306463241577 0.9726775884628296 0 0.7561349272727966 0.9781420826911926 0 1 1 0 </NumberSequence><BinaryString name="AttributesSerialize">AgAAAAkAAABFbWl0Q291bnQGAAAAAAAAFEAJAAAARW1pdERlbGF5BgAAAAAAAAAA</BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4096"><Properties><float name="Brightness">6</float><ColorSequence name="Color">0 0.3529411852359772 0.8078431487083435 1 0 1 0.3529411852359772 0.8078431487083435 1 0 </ColorSequence><token name="EmissionDirection">3</token><bool name="Enabled">false</bool><NumberRange name="Lifetime">1 1</NumberRange><float name="LightEmission">1</float><bool name="LockedToPart">true</bool><float name="Rate">15</float><NumberSequence name="Size">0 5.8928937911987305 0 0.09243697673082352 9.821488380432129 0 0.3193277418613434 13.21436595916748 0 0.6084033846855164 15.267950057983398 0 1 16.339385986328125 0 </NumberSequence><NumberRange name="Speed">0.03267877176403999 0.03267877176403999</NumberRange><Content name="Texture"><url><![CDATA[rbxassetid://8030760338]]></url></Content><NumberSequence name="Transparency">0 1 0 0.10518292337656021 0.16249996423721313 0 1 1 0 </NumberSequence><BinaryString name="AttributesSerialize">AgAAAAkAAABFbWl0Q291bnQGAAAAAAAAAEAJAAAARW1pdERlbGF5BgAAAAAAAAAA</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Glow2]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4097"><Properties><float name="Brightness">2</float><ColorSequence name="Color">0 0.3529411852359772 0.8078431487083435 1 0 1 0.3529411852359772 0.8078431487083435 1 0 </ColorSequence><bool name="Enabled">false</bool><NumberRange name="Lifetime">1 1</NumberRange><float name="LightEmission">1</float><bool name="LockedToPart">true</bool><float name="Rate">15</float><NumberSequence name="Size">0 12.368934631347656 0 1 12.368934631347656 0 </NumberSequence><NumberRange name="Speed">0.008245956152677536 0.008245956152677536</NumberRange><Content name="Texture"><url><![CDATA[rbxassetid://8030760338]]></url></Content><NumberSequence name="Transparency">0 1 0 0.07469511777162552 0.5249999761581421 0 0.3216463327407837 0.831250011920929 0 0.6128048300743103 0.9312499761581421 0 1 1 0 </NumberSequence><BinaryString name="AttributesSerialize">AgAAAAkAAABFbWl0Q291bnQGAAAAAAAACEAJAAAARW1pdERlbGF5BgAAAAAAAAAA</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Glow1]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4098"><Properties><float name="Brightness">0.05000000074505806</float><token name="EmissionDirection">0</token><bool name="Enabled">false</bool><NumberRange name="Lifetime">0.6000000238418579 0.6000000238418579</NumberRange><float name="LightEmission">1</float><bool name="LockedToPart">true</bool><float name="Rate">3</float><NumberRange name="Rotation">37 999</NumberRange><NumberSequence name="Size">0 0 0 0.166158527135849 0 0 0.291158527135849 1.6930768489837646 0 0.5030487775802612 4.994575500488281 0 0.7713414430618286 5.556764125823975 0 1 5.556764125823975 0 </NumberSequence><NumberRange name="Speed">0.006350588519126177 0.006350588519126177</NumberRange><Content name="Texture"><url><![CDATA[rbxassetid://10529371971]]></url></Content><NumberSequence name="Transparency">0 1 0 0.02896341308951378 0.46875 0 0.06707316637039185 0.23124998807907104 0 0.13109755516052246 0.043749988079071045 0 0.18292681872844696 0 0 0.22713413834571838 0 0 0.4999999701976776 0 0 0.7103658318519592 0.5874999761581421 0 0.7728658318519592 0.7374999523162842 0 0.8536584973335266 0.862500011920929 0 0.9131097197532654 0.949999988079071 0 1 1 0 </NumberSequence><float name="VelocityInheritance">1</float><float name="ZOffset">1.6777712106704712</float><BinaryString name="AttributesSerialize">AgAAAAkAAABFbWl0Q291bnQGAAAAAAAA8D8JAAAARW1pdERlbGF5BgAAAAAAAAAA</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Charge0]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="4099"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Fireworks]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ParticleEmitter" referent="4100"><Properties><Vector3 name="Acceleration"><X>0</X><Y>-25</Y><Z>0</Z></Vector3><float name="Brightness">5</float><float name="Drag">20</float><NumberRange name="Lifetime">0.4000000059604645 0.800000011920929</NumberRange><float name="LightEmission">0.5</float><float name="LightInfluence">0.5</float><float name="Rate">26</float><NumberRange name="RotSpeed">-200 200</NumberRange><NumberRange name="Rotation">0 360</NumberRange><NumberSequence name="Size">0 0.10000000149011612 0.05000000074505806 1 0 0 </NumberSequence><NumberRange name="Speed">3 5</NumberRange><Vector2 name="SpreadAngle"><X>360</X><Y>360</Y></Vector2><Content name="Texture"><url><![CDATA[rbxassetid://3113323162]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Trail]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4101"><Properties><float name="Brightness">5</float><ColorSequence name="Color">0 1 0.9215686321258545 0.32549020648002625 0 1 1 0.9215686321258545 0.32549020648002625 0 </ColorSequence><float name="Drag">1</float><NumberRange name="Lifetime">0.25 0.5</NumberRange><float name="LightEmission">1</float><bool name="LockedToPart">true</bool><float name="Rate">150</float><NumberRange name="Rotation">-360 360</NumberRange><NumberSequence name="Size">0 0.29202133417129517 0.25 1 0 0 </NumberSequence><NumberRange name="Speed">10 15</NumberRange><Vector2 name="SpreadAngle"><X>-360</X><Y>360</Y></Vector2><Content name="Texture"><url><![CDATA[rbxassetid://17086409913]]></url></Content><NumberSequence name="Transparency">0 1 0 0.10092400014400482 0 0 1 0 0 </NumberSequence><float name="ZOffset">1</float><BinaryString name="AttributesSerialize">AQAAAAkAAABFbWl0Q291bnQGAAAAAAAAFEA=</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Spec]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4102"><Properties><float name="Brightness">10</float><ColorSequence name="Color">0 1 0.9215686321258545 0.32549020648002625 0 1 1 0.9215686321258545 0.32549020648002625 0 </ColorSequence><float name="Drag">5</float><NumberRange name="Lifetime">0.6000000238418579 1.2000000476837158</NumberRange><float name="LightEmission">1</float><bool name="LockedToPart">true</bool><token name="Orientation">2</token><float name="Rate">100</float><NumberRange name="Rotation">-90 -90</NumberRange><NumberSequence name="Size">0 0.8749997615814209 0.8749997615814209 1 0 0 </NumberSequence><NumberRange name="Speed">15 15</NumberRange><Vector2 name="SpreadAngle"><X>-180</X><Y>180</Y></Vector2><NumberSequence name="Squash">0 0.1875 1 1 -0.4875001907348633 1 </NumberSequence><Content name="Texture"><url><![CDATA[rbxassetid://6763809313]]></url></Content><NumberSequence name="Transparency">0 1 0 0.25 0 0 1 1 0 </NumberSequence><float name="ZOffset">2</float><BinaryString name="AttributesSerialize">AQAAAAkAAABFbWl0Q291bnQGAAAAAAAAOUA=</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Sparks]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4103"><Properties><Vector3 name="Acceleration"><X>0</X><Y>-3</Y><Z>0</Z></Vector3><float name="Brightness">4.5</float><float name="Drag">12.5</float><bool name="Enabled">false</bool><NumberRange name="Lifetime">0.6000000238418579 1.2999999523162842</NumberRange><float name="LightEmission">0.20000000298023224</float><float name="LightInfluence">0.4000000059604645</float><bool name="LockedToPart">true</bool><token name="Orientation">2</token><float name="Rate">11</float><NumberRange name="RotSpeed">-80 80</NumberRange><NumberRange name="Rotation">0 360</NumberRange><NumberSequence name="Size">0 0.25 0 0.6992600560188293 0.3125 0 1 0 0 </NumberSequence><NumberRange name="Speed">41 41</NumberRange><Vector2 name="SpreadAngle"><X>360</X><Y>360</Y></Vector2><Content name="Texture"><url><![CDATA[rbxassetid://3113323162]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Explosion]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Attachment" referent="4104"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[golden-slime]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ParticleEmitter" referent="4105"><Properties><ColorSequence name="Color">0 1 0.7137255072593689 0.30980393290519714 0 1 1 0.7137255072593689 0.30980393290519714 0 </ColorSequence><NumberRange name="Lifetime">2 2</NumberRange><float name="LightEmission">1</float><bool name="LockedToPart">true</bool><float name="Rate">0.800000011920929</float><NumberSequence name="Size">0 2.782392978668213 0 1 2.782392978668213 0 </NumberSequence><NumberRange name="Speed">0 0</NumberRange><Content name="Texture"><url><![CDATA[rbxassetid://867619398]]></url></Content><NumberSequence name="Transparency">0 1 0 0.4970000088214874 0.5 0 1 1 0 </NumberSequence><float name="ZOffset">0.000750000006519258</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Glow]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4106"><Properties><ColorSequence name="Color">0 1 0.8549019694328308 0.4941176474094391 0 1 1 0.8549019694328308 0.4941176474094391 0 </ColorSequence><NumberRange name="Lifetime">1 1</NumberRange><float name="LightEmission">1</float><bool name="LockedToPart">true</bool><float name="Rate">4</float><NumberRange name="RotSpeed">-10 20</NumberRange><NumberRange name="Rotation">-180 180</NumberRange><NumberSequence name="Size">0 3.4779913425445557 0 1 3.4779913425445557 0 </NumberSequence><NumberRange name="Speed">0 0</NumberRange><Content name="Texture"><url><![CDATA[rbxassetid://1084975295]]></url></Content><NumberSequence name="Transparency">0 1 0 0.5 0.699999988079071 0 1 1 0 </NumberSequence><float name="ZOffset">-0.000375000003259629</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Rays]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="4107"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[diamond-slime]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Attachment" referent="4108"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties><Item class="ParticleEmitter" referent="4109"><Properties><ColorSequence name="Color">0 0.6666666865348816 1 1 0 1 0.6666666865348816 1 1 0 </ColorSequence><NumberRange name="Lifetime">2 2</NumberRange><float name="LightEmission">1</float><bool name="LockedToPart">true</bool><float name="Rate">0.800000011920929</float><NumberSequence name="Size">0 2.782392978668213 0 1 2.782392978668213 0 </NumberSequence><NumberRange name="Speed">0 0</NumberRange><Content name="Texture"><url><![CDATA[rbxassetid://867619398]]></url></Content><NumberSequence name="Transparency">0 1 0 0.4970000088214874 0.5 0 1 1 0 </NumberSequence><float name="ZOffset">0.000750000006519258</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Glow]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4110"><Properties><NumberRange name="Lifetime">1 1</NumberRange><float name="LightEmission">1</float><bool name="LockedToPart">true</bool><float name="Rate">4</float><NumberRange name="RotSpeed">-10 20</NumberRange><NumberRange name="Rotation">-180 180</NumberRange><NumberSequence name="Size">0 3.4779913425445557 0 1 3.4779913425445557 0 </NumberSequence><NumberRange name="Speed">0 0</NumberRange><Content name="Texture"><url><![CDATA[rbxassetid://1084975295]]></url></Content><NumberSequence name="Transparency">0 1 0 0.5 0.699999988079071 0 1 1 0 </NumberSequence><float name="ZOffset">-0.000375000003259629</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Rays]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ParticleEmitter" referent="4111"><Properties><float name="Brightness">5</float><ColorSequence name="Color">0 1 0.7686274647712708 0.5764706134796143 0 0.3494809865951538 1 0.9058823585510254 0.572549045085907 0 1 1 0.7450980544090271 0.45098039507865906 0 </ColorSequence><float name="Drag">25</float><token name="EmissionDirection">2</token><NumberRange name="Lifetime">0.375 0.44999998807907104</NumberRange><float name="LightEmission">1</float><NumberSequence name="Size">0 0 0 0.20000000298023224 0.25 0.25 0.3752642571926117 0.8749997615814209 0.550000011920929 0.5512685179710388 0.5624997615814209 0.25 1 0 0 </NumberSequence><NumberRange name="Speed">0 0</NumberRange><NumberSequence name="Squash">0 0 0 1 0.25 0 </NumberSequence><Content name="Texture"><url><![CDATA[rbxassetid://10598374841]]></url></Content><float name="TimeScale">0.15000000596046448</float><NumberSequence name="Transparency">0 0.5 0 1 0.5 0 </NumberSequence><float name="ZOffset">2.700000047683716</float><BinaryString name="AttributesSerialize">AgAAAAkAAABFbWl0Q291bnQGAAAAAAAAAAAJAAAARW1pdERlbGF5BgAAAAAAAAAA</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Sparks]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="4112"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[rainbow-slime]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Attachment" referent="4113"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties><Item class="ParticleEmitter" referent="4114"><Properties><ColorSequence name="Color">0 0.6666666865348816 1 1 0 1 0.6666666865348816 1 1 0 </ColorSequence><NumberRange name="Lifetime">2 2</NumberRange><float name="LightEmission">1</float><bool name="LockedToPart">true</bool><float name="Rate">0.800000011920929</float><NumberSequence name="Size">0 2.782392978668213 0 1 2.782392978668213 0 </NumberSequence><NumberRange name="Speed">0 0</NumberRange><Content name="Texture"><url><![CDATA[rbxassetid://867619398]]></url></Content><NumberSequence name="Transparency">0 1 0 0.4970000088214874 0.5 0 1 1 0 </NumberSequence><float name="ZOffset">0.000750000006519258</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Glow]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ParticleEmitter" referent="4115"><Properties><NumberRange name="Lifetime">1 1</NumberRange><float name="LightEmission">1</float><bool name="LockedToPart">true</bool><float name="Rate">4</float><NumberRange name="RotSpeed">-10 20</NumberRange><NumberRange name="Rotation">-180 180</NumberRange><NumberSequence name="Size">0 3.4779913425445557 0 1 3.4779913425445557 0 </NumberSequence><NumberRange name="Speed">0 0</NumberRange><Content name="Texture"><url><![CDATA[rbxassetid://1084975295]]></url></Content><NumberSequence name="Transparency">0 1 0 0.5 0.699999988079071 0 1 1 0 </NumberSequence><float name="ZOffset">-0.000375000003259629</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Rays]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ParticleEmitter" referent="4116"><Properties><float name="Brightness">5</float><ColorSequence name="Color">0 1 0.7686274647712708 0.5764706134796143 0 0.3494809865951538 1 0.9058823585510254 0.572549045085907 0 1 1 0.7450980544090271 0.45098039507865906 0 </ColorSequence><float name="Drag">25</float><token name="EmissionDirection">2</token><NumberRange name="Lifetime">0.375 0.44999998807907104</NumberRange><float name="LightEmission">1</float><NumberSequence name="Size">0 0 0 0.20000000298023224 0.25 0.25 0.3752642571926117 0.8749997615814209 0.550000011920929 0.5512685179710388 0.5624997615814209 0.25 1 0 0 </NumberSequence><NumberRange name="Speed">0 0</NumberRange><NumberSequence name="Squash">0 0 0 1 0.25 0 </NumberSequence><Content name="Texture"><url><![CDATA[rbxassetid://10598374841]]></url></Content><float name="TimeScale">0.15000000596046448</float><NumberSequence name="Transparency">0 0.5 0 1 0.5 0 </NumberSequence><float name="ZOffset">2.700000047683716</float><BinaryString name="AttributesSerialize">AgAAAAkAAABFbWl0Q291bnQGAAAAAAAAAAAJAAAARW1pdERlbGF5BgAAAAAAAAAA</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Sparks]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Model" referent="4117"><Properties><CoordinateFrame name="ModelMeshCFrame"><X>-69.56170654296875</X><Y>-156.72512817382812</Y><Z>-304.0750427246094</Z><R00>1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>1</R11><R12>0</R12><R20>0</R20><R21>0</R21><R22>1</R22></CoordinateFrame><Vector3 name="ModelMeshSize"><X>0</X><Y>0</Y><Z>0</Z></Vector3><bool name="NeedsPivotMigration">false</bool><Ref name="PrimaryPart">4118</Ref><float name="ScaleFactor">0.4886792302131653</float><OptionalCoordinateFrame name="WorldPivotData"><CFrame><X>-4110.04052734375</X><Y>25.067829132080078</Y><Z>69.27782440185547</Z><R00>-1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>1</R12><R20>0</R20><R21>1</R21><R22>-0</R22></CFrame></OptionalCoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Ice Windsold]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Model" referent="4119"><Properties><CoordinateFrame name="ModelMeshCFrame"><X>0</X><Y>0</Y><Z>0</Z><R00>1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>1</R11><R12>0</R12><R20>0</R20><R21>0</R21><R22>1</R22></CoordinateFrame><Vector3 name="ModelMeshSize"><X>0</X><Y>0</Y><Z>0</Z></Vector3><bool name="NeedsPivotMigration">false</bool><float name="ScaleFactor">0.4886792302131653</float><OptionalCoordinateFrame name="WorldPivotData"><CFrame><X>-3990.794189453125</X><Y>27.02227783203125</Y><Z>-853.3150634765625</Z><R00>-1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>1</R12><R20>0</R20><R21>1</R21><R22>-0</R22></CFrame></OptionalCoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[NorthernLights]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Part" referent="4120"><Properties><token name="shape">1</token><token name="formFactorRaw">1</token><bool name="Anchored">true</bool><token name="BottomSurface">0</token><CoordinateFrame name="CFrame"><X>-4128.4580078125</X><Y>27.02236557006836</Y><Z>93.89921569824219</Z><R00>-1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>1</R12><R20>0</R20><R21>1</R21><R22>-0</R22></CoordinateFrame><bool name="CanCollide">false</bool><bool name="CanQuery">false</bool><bool name="CanTouch">false</bool><Color3uint8 name="Color3uint8">4288914085</Color3uint8><bool name="EnableFluidForces">false</bool><string name="MaterialVariantSerialized"></string><token name="TopSurface">0</token><float name="Transparency">1</float><Vector3 name="size"><X>0.4886792302131653</X><Y>0.4886792302131653</Y><Z>0.4886792302131653</Z></Vector3><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Beam]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Attachment" referent="4121"><Properties><CoordinateFrame name="CFrame"><X>0</X><Y>-42.53782272338867</Y><Z>-0.022712966427206993</Z><R00>1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>-1</R12><R20>0</R20><R21>1</R21><R22>0</R22></CoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[A1]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Attachment" referent="4122"><Properties><CoordinateFrame name="CFrame"><X>0</X><Y>-0.2216266542673111</Y><Z>-0.022712966427206993</Z><R00>1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>-1</R12><R20>0</R20><R21>1</R21><R22>0</R22></CoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[A0]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Beam" referent="4123"><Properties><Ref name="Attachment0">4122</Ref><Ref name="Attachment1">4121</Ref><float name="Brightness">5</float><float name="CurveSize0">9.773584365844727</float><float name="CurveSize1">9.773584365844727</float><float name="LightEmission">0.3499999940395355</float><Content name="Texture"><url><![CDATA[rbxassetid://10472974536]]></url></Content><float name="TextureLength">0.375</float><float name="TextureSpeed">0.20000000298023224</float><NumberSequence name="Transparency">0 1 0 0.15000000596046448 0.9850000143051147 0 0.30000001192092896 0.925000011920929 0 0.4000000059604645 0.824999988079071 0 0.5 0.699999988079071 0 0.6000000238418579 0.824999988079071 0 0.699999988079071 0.925000011920929 0 0.8500000238418579 0.9850000143051147 0 1 1 0 </NumberSequence><float name="Width0">48.867923736572266</float><float name="Width1">48.867923736572266</float><float name="ZOffset">-1</float><BinaryString name="AttributesSerialize">BAAAAAgAAABEdXJhdGlvbgYAAAAAAAAAAAkAAABFbWl0RGVsYXkGAAAAAAAAAAAGAAAAV2lkdGgwBgAAAAAAAAAABgAAAFdpZHRoMQYAAAAAAAAAAA==</BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Beam" referent="4124"><Properties><Ref name="Attachment0">4122</Ref><Ref name="Attachment1">4121</Ref><float name="Brightness">5</float><ColorSequence name="Color">0 0 1 1 0 1 0 1 1 0 </ColorSequence><float name="CurveSize0">9.773584365844727</float><float name="CurveSize1">9.773584365844727</float><bool name="FaceCamera">true</bool><float name="LightEmission">0.8500000238418579</float><Content name="Texture"><url><![CDATA[rbxassetid://10472990183]]></url></Content><float name="TextureLength">0.10000000149011612</float><float name="TextureSpeed">0.20000000298023224</float><NumberSequence name="Transparency">0 1 0 0.5 0.5 0 1 1 0 </NumberSequence><float name="Width0">12.216980934143066</float><float name="Width1">12.216980934143066</float><BinaryString name="AttributesSerialize">BAAAAAgAAABEdXJhdGlvbgYAAAAAAAAAAAkAAABFbWl0RGVsYXkGAAAAAAAAAAAGAAAAV2lkdGgwBgAAAAAAAAAABgAAAFdpZHRoMQYAAAAAAAAAAA==</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Beam1]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Beam" referent="4125"><Properties><Ref name="Attachment0">4122</Ref><Ref name="Attachment1">4121</Ref><float name="Brightness">0.07500000298023224</float><ColorSequence name="Color">0 0 0.6666666865348816 1 0 1 0 0.6666666865348816 1 0 </ColorSequence><float name="CurveSize0">9.773584365844727</float><float name="CurveSize1">9.773584365844727</float><float name="LightEmission">0.8500000238418579</float><Content name="Texture"><url><![CDATA[rbxassetid://10386316474]]></url></Content><float name="TextureLength">0.10000000149011612</float><float name="TextureSpeed">0.20000000298023224</float><NumberSequence name="Transparency">0 1 0 0.5 0.5 0 1 1 0 </NumberSequence><float name="Width0">24.433961868286133</float><float name="Width1">24.433961868286133</float><BinaryString name="AttributesSerialize">BAAAAAgAAABEdXJhdGlvbgYAAAAAAAAAAAkAAABFbWl0RGVsYXkGAAAAAAAAAAAGAAAAV2lkdGgwBgAAAAAAAAAABgAAAFdpZHRoMQYAAAAAAAAAAA==</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Beam2]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Part" referent="4126"><Properties><token name="shape">1</token><token name="formFactorRaw">1</token><bool name="Anchored">true</bool><token name="BottomSurface">0</token><CoordinateFrame name="CFrame"><X>-4128.4580078125</X><Y>27.02236557006836</Y><Z>93.89921569824219</Z><R00>-1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>1</R12><R20>0</R20><R21>1</R21><R22>-0</R22></CoordinateFrame><bool name="CanCollide">false</bool><bool name="CanQuery">false</bool><bool name="CanTouch">false</bool><Color3uint8 name="Color3uint8">4288914085</Color3uint8><bool name="EnableFluidForces">false</bool><string name="MaterialVariantSerialized"></string><token name="TopSurface">0</token><float name="Transparency">1</float><Vector3 name="size"><X>0.4886792302131653</X><Y>0.4886792302131653</Y><Z>0.4886792302131653</Z></Vector3><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Beam]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Attachment" referent="4127"><Properties><CoordinateFrame name="CFrame"><X>0</X><Y>-42.53782272338867</Y><Z>-0.022712966427206993</Z><R00>0</R00><R01>-1</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>-1</R12><R20>1</R20><R21>0</R21><R22>0</R22></CoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[A1]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Attachment" referent="4128"><Properties><CoordinateFrame name="CFrame"><X>0</X><Y>-0.2216266542673111</Y><Z>-0.022712966427206993</Z><R00>0</R00><R01>-1</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>-1</R12><R20>1</R20><R21>0</R21><R22>0</R22></CoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[A0]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Beam" referent="4129"><Properties><Ref name="Attachment0">4128</Ref><Ref name="Attachment1">4127</Ref><float name="Brightness">2</float><ColorSequence name="Color">0 0.6666666865348816 1 1 0 1 0.6666666865348816 1 1 0 </ColorSequence><float name="CurveSize0">9.773584365844727</float><float name="CurveSize1">9.773584365844727</float><float name="LightEmission">0.3499999940395355</float><Content name="Texture"><url><![CDATA[rbxassetid://10472974536]]></url></Content><float name="TextureLength">0.375</float><float name="TextureSpeed">0.20000000298023224</float><NumberSequence name="Transparency">0 1 0 0.25 0.8999999761581421 0 0.4000000059604645 0.800000011920929 0 0.5 0.6499999761581421 0 0.6000000238418579 0.800000011920929 0 0.75 0.8999999761581421 0 1 1 0 </NumberSequence><float name="Width0">12.216980934143066</float><float name="Width1">12.216980934143066</float><BinaryString name="AttributesSerialize">BAAAAAgAAABEdXJhdGlvbgYAAAAAAAAAAAkAAABFbWl0RGVsYXkGAAAAAAAAAAAGAAAAV2lkdGgwBgAAAAAAAAAABgAAAFdpZHRoMQYAAAAAAAAAAA==</BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item></Item><Item class="Model" referent="4130"><Properties><CoordinateFrame name="ModelMeshCFrame"><X>0</X><Y>0</Y><Z>0</Z><R00>1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>1</R11><R12>0</R12><R20>0</R20><R21>0</R21><R22>1</R22></CoordinateFrame><Vector3 name="ModelMeshSize"><X>0</X><Y>0</Y><Z>0</Z></Vector3><bool name="NeedsPivotMigration">false</bool><float name="ScaleFactor">0.4886792302131653</float><OptionalCoordinateFrame name="WorldPivotData"><CFrame><X>-3972.586181640625</X><Y>24.579059600830078</Y><Z>-866.3490600585938</Z><R00>-1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>1</R12><R20>0</R20><R21>1</R21><R22>-0</R22></CFrame></OptionalCoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[NorthernLights]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Part" referent="4131"><Properties><token name="shape">1</token><token name="formFactorRaw">1</token><bool name="Anchored">true</bool><token name="BottomSurface">0</token><CoordinateFrame name="CFrame"><X>-4110.181640625</X><Y>17.249496459960938</Y><Z>90.58988952636719</Z><R00>-1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>1</R12><R20>0</R20><R21>1</R21><R22>-0</R22></CoordinateFrame><bool name="CanCollide">false</bool><bool name="CanQuery">false</bool><bool name="CanTouch">false</bool><Color3uint8 name="Color3uint8">4288914085</Color3uint8><bool name="EnableFluidForces">false</bool><string name="MaterialVariantSerialized"></string><token name="TopSurface">0</token><float name="Transparency">1</float><Vector3 name="size"><X>0.4886792302131653</X><Y>0.4886792302131653</Y><Z>0.4886792302131653</Z></Vector3><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Beam]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Attachment" referent="4132"><Properties><CoordinateFrame name="CFrame"><X>0</X><Y>-52.311405181884766</Y><Z>-0.022712966427206993</Z><R00>0</R00><R01>-1</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>-1</R12><R20>1</R20><R21>0</R21><R22>0</R22></CoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[A1]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Attachment" referent="4133"><Properties><CoordinateFrame name="CFrame"><X>0</X><Y>-0.2216266542673111</Y><Z>-0.022712966427206993</Z><R00>0</R00><R01>-1</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>-1</R12><R20>1</R20><R21>0</R21><R22>0</R22></CoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[A0]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Beam" referent="4134"><Properties><Ref name="Attachment0">4133</Ref><Ref name="Attachment1">4132</Ref><float name="Brightness">2</float><ColorSequence name="Color">0 0 1 1 0 1 0 1 1 0 </ColorSequence><float name="CurveSize0">9.773584365844727</float><float name="CurveSize1">9.773584365844727</float><float name="LightEmission">0.3499999940395355</float><Content name="Texture"><url><![CDATA[rbxassetid://10472974536]]></url></Content><float name="TextureLength">0.375</float><float name="TextureSpeed">0.20000000298023224</float><NumberSequence name="Transparency">0 1 0 0.25 0.8999999761581421 0 0.4000000059604645 0.800000011920929 0 0.5 0.6499999761581421 0 0.6000000238418579 0.800000011920929 0 0.75 0.8999999761581421 0 1 1 0 </NumberSequence><float name="Width0">12.216980934143066</float><float name="Width1">12.216980934143066</float><BinaryString name="AttributesSerialize">BAAAAAgAAABEdXJhdGlvbgYAAAAAAAAAAAkAAABFbWl0RGVsYXkGAAAAAAAAAAAGAAAAV2lkdGgwBgAAAAAAAAAABgAAAFdpZHRoMQYAAAAAAAAAAA==</BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Part" referent="4135"><Properties><token name="shape">1</token><token name="formFactorRaw">1</token><bool name="Anchored">true</bool><token name="BottomSurface">0</token><CoordinateFrame name="CFrame"><X>-4110.181640625</X><Y>17.249496459960938</Y><Z>90.58988952636719</Z><R00>-1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>1</R12><R20>0</R20><R21>1</R21><R22>-0</R22></CoordinateFrame><bool name="CanCollide">false</bool><bool name="CanQuery">false</bool><bool name="CanTouch">false</bool><Color3uint8 name="Color3uint8">4288914085</Color3uint8><bool name="EnableFluidForces">false</bool><string name="MaterialVariantSerialized"></string><token name="TopSurface">0</token><float name="Transparency">1</float><Vector3 name="size"><X>0.4886792302131653</X><Y>0.4886792302131653</Y><Z>0.4886792302131653</Z></Vector3><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Beam]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Attachment" referent="4136"><Properties><CoordinateFrame name="CFrame"><X>0</X><Y>-52.311405181884766</Y><Z>-0.022712966427206993</Z><R00>1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>-1</R12><R20>0</R20><R21>1</R21><R22>0</R22></CoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[A1]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Attachment" referent="4137"><Properties><CoordinateFrame name="CFrame"><X>0</X><Y>-0.2216266542673111</Y><Z>-0.022712966427206993</Z><R00>1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>-1</R12><R20>0</R20><R21>1</R21><R22>0</R22></CoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[A0]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Beam" referent="4138"><Properties><Ref name="Attachment0">4122</Ref><Ref name="Attachment1">4121</Ref><float name="Brightness">5</float><float name="CurveSize0">9.773584365844727</float><float name="CurveSize1">9.773584365844727</float><float name="LightEmission">0.3499999940395355</float><Content name="Texture"><url><![CDATA[rbxassetid://10472974536]]></url></Content><float name="TextureLength">0.375</float><float name="TextureSpeed">0.20000000298023224</float><NumberSequence name="Transparency">0 1 0 0.15000000596046448 0.9850000143051147 0 0.30000001192092896 0.925000011920929 0 0.4000000059604645 0.824999988079071 0 0.5 0.699999988079071 0 0.6000000238418579 0.824999988079071 0 0.699999988079071 0.925000011920929 0 0.8500000238418579 0.9850000143051147 0 1 1 0 </NumberSequence><float name="Width0">48.867923736572266</float><float name="Width1">48.867923736572266</float><float name="ZOffset">-1</float><BinaryString name="AttributesSerialize">BAAAAAgAAABEdXJhdGlvbgYAAAAAAAAAAAkAAABFbWl0RGVsYXkGAAAAAAAAAAAGAAAAV2lkdGgwBgAAAAAAAAAABgAAAFdpZHRoMQYAAAAAAAAAAA==</BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Beam" referent="4139"><Properties><Ref name="Attachment0">4122</Ref><Ref name="Attachment1">4121</Ref><float name="Brightness">5</float><ColorSequence name="Color">0 0 1 1 0 1 0 1 1 0 </ColorSequence><float name="CurveSize0">9.773584365844727</float><float name="CurveSize1">9.773584365844727</float><bool name="FaceCamera">true</bool><float name="LightEmission">0.8500000238418579</float><Content name="Texture"><url><![CDATA[rbxassetid://10472990183]]></url></Content><float name="TextureLength">0.10000000149011612</float><float name="TextureSpeed">0.20000000298023224</float><NumberSequence name="Transparency">0 1 0 0.5 0.5 0 1 1 0 </NumberSequence><float name="Width0">12.216980934143066</float><float name="Width1">12.216980934143066</float><BinaryString name="AttributesSerialize">BAAAAAgAAABEdXJhdGlvbgYAAAAAAAAAAAkAAABFbWl0RGVsYXkGAAAAAAAAAAAGAAAAV2lkdGgwBgAAAAAAAAAABgAAAFdpZHRoMQYAAAAAAAAAAA==</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Beam1]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Beam" referent="4140"><Properties><Ref name="Attachment0">4122</Ref><Ref name="Attachment1">4121</Ref><float name="Brightness">0.07500000298023224</float><ColorSequence name="Color">0 0 0.6666666865348816 1 0 1 0 0.6666666865348816 1 0 </ColorSequence><float name="CurveSize0">9.773584365844727</float><float name="CurveSize1">9.773584365844727</float><float name="LightEmission">0.8500000238418579</float><Content name="Texture"><url><![CDATA[rbxassetid://10386316474]]></url></Content><float name="TextureLength">0.10000000149011612</float><float name="TextureSpeed">0.20000000298023224</float><NumberSequence name="Transparency">0 1 0 0.5 0.5 0 1 1 0 </NumberSequence><float name="Width0">24.433961868286133</float><float name="Width1">24.433961868286133</float><BinaryString name="AttributesSerialize">BAAAAAgAAABEdXJhdGlvbgYAAAAAAAAAAAkAAABFbWl0RGVsYXkGAAAAAAAAAAAGAAAAV2lkdGgwBgAAAAAAAAAABgAAAFdpZHRoMQYAAAAAAAAAAA==</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Beam2]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item></Item><Item class="Model" referent="4141"><Properties><CoordinateFrame name="ModelMeshCFrame"><X>0</X><Y>0</Y><Z>0</Z><R00>1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>1</R11><R12>0</R12><R20>0</R20><R21>0</R21><R22>1</R22></CoordinateFrame><Vector3 name="ModelMeshSize"><X>0</X><Y>0</Y><Z>0</Z></Vector3><bool name="NeedsPivotMigration">false</bool><float name="ScaleFactor">0.4886792302131653</float><OptionalCoordinateFrame name="WorldPivotData"><CFrame><X>-3957.017578125</X><Y>24.579059600830078</Y><Z>-856.70458984375</Z><R00>-1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>1</R12><R20>0</R20><R21>1</R21><R22>-0</R22></CFrame></OptionalCoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[NorthernLights]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Part" referent="4142"><Properties><token name="shape">1</token><token name="formFactorRaw">1</token><bool name="Anchored">true</bool><token name="BottomSurface">0</token><CoordinateFrame name="CFrame"><X>-4094.5546875</X><Y>24.579177856445312</Y><Z>90.50521850585938</Z><R00>-1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>1</R12><R20>0</R20><R21>1</R21><R22>-0</R22></CoordinateFrame><bool name="CanCollide">false</bool><bool name="CanQuery">false</bool><bool name="CanTouch">false</bool><Color3uint8 name="Color3uint8">4288914085</Color3uint8><bool name="EnableFluidForces">false</bool><string name="MaterialVariantSerialized"></string><token name="TopSurface">0</token><float name="Transparency">1</float><Vector3 name="size"><X>0.4886792302131653</X><Y>0.4886792302131653</Y><Z>0.4886792302131653</Z></Vector3><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Beam]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Attachment" referent="4143"><Properties><CoordinateFrame name="CFrame"><X>0</X><Y>-42.53782272338867</Y><Z>-0.022712966427206993</Z><R00>0</R00><R01>-1</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>-1</R12><R20>1</R20><R21>0</R21><R22>0</R22></CoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[A1]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Attachment" referent="4144"><Properties><CoordinateFrame name="CFrame"><X>0</X><Y>-0.2216266542673111</Y><Z>-0.022712966427206993</Z><R00>0</R00><R01>-1</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>-1</R12><R20>1</R20><R21>0</R21><R22>0</R22></CoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[A0]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Beam" referent="4145"><Properties><Ref name="Attachment0">4144</Ref><Ref name="Attachment1">4143</Ref><float name="Brightness">2</float><ColorSequence name="Color">0 0.6666666865348816 1 1 0 1 0.6666666865348816 1 1 0 </ColorSequence><float name="CurveSize0">9.773584365844727</float><float name="CurveSize1">9.773584365844727</float><float name="LightEmission">0.3499999940395355</float><Content name="Texture"><url><![CDATA[rbxassetid://10472974536]]></url></Content><float name="TextureLength">0.375</float><float name="TextureSpeed">0.20000000298023224</float><NumberSequence name="Transparency">0 1 0 0.25 0.8999999761581421 0 0.4000000059604645 0.800000011920929 0 0.5 0.6499999761581421 0 0.6000000238418579 0.800000011920929 0 0.75 0.8999999761581421 0 1 1 0 </NumberSequence><float name="Width0">12.216980934143066</float><float name="Width1">12.216980934143066</float><BinaryString name="AttributesSerialize">BAAAAAgAAABEdXJhdGlvbgYAAAAAAAAAAAkAAABFbWl0RGVsYXkGAAAAAAAAAAAGAAAAV2lkdGgwBgAAAAAAAAAABgAAAFdpZHRoMQYAAAAAAAAAAA==</BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Part" referent="4146"><Properties><token name="shape">1</token><token name="formFactorRaw">1</token><bool name="Anchored">true</bool><token name="BottomSurface">0</token><CoordinateFrame name="CFrame"><X>-4091.623291015625</X><Y>24.579177856445312</Y><Z>90.50521850585938</Z><R00>-1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>1</R12><R20>0</R20><R21>1</R21><R22>-0</R22></CoordinateFrame><bool name="CanCollide">false</bool><bool name="CanQuery">false</bool><bool name="CanTouch">false</bool><Color3uint8 name="Color3uint8">4288914085</Color3uint8><bool name="EnableFluidForces">false</bool><string name="MaterialVariantSerialized"></string><token name="TopSurface">0</token><float name="Transparency">1</float><Vector3 name="size"><X>0.4886792302131653</X><Y>0.4886792302131653</Y><Z>0.4886792302131653</Z></Vector3><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Beam]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Attachment" referent="4147"><Properties><CoordinateFrame name="CFrame"><X>0</X><Y>-42.53782272338867</Y><Z>-0.022712966427206993</Z><R00>1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>-1</R12><R20>0</R20><R21>1</R21><R22>0</R22></CoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[A1]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Attachment" referent="4148"><Properties><CoordinateFrame name="CFrame"><X>0</X><Y>-0.2216266542673111</Y><Z>-0.022712966427206993</Z><R00>1</R00><R01>0</R01><R02>0</R02><R10>0</R10><R11>0</R11><R12>-1</R12><R20>0</R20><R21>1</R21><R22>0</R22></CoordinateFrame><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[A0]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Beam" referent="4149"><Properties><Ref name="Attachment0">4122</Ref><Ref name="Attachment1">4121</Ref><float name="Brightness">5</float><float name="CurveSize0">9.773584365844727</float><float name="CurveSize1">9.773584365844727</float><float name="LightEmission">0.3499999940395355</float><Content name="Texture"><url><![CDATA[rbxassetid://10472974536]]></url></Content><float name="TextureLength">0.375</float><float name="TextureSpeed">0.20000000298023224</float><NumberSequence name="Transparency">0 1 0 0.15000000596046448 0.9850000143051147 0 0.30000001192092896 0.925000011920929 0 0.4000000059604645 0.824999988079071 0 0.5 0.699999988079071 0 0.6000000238418579 0.824999988079071 0 0.699999988079071 0.925000011920929 0 0.8500000238418579 0.9850000143051147 0 1 1 0 </NumberSequence><float name="Width0">48.867923736572266</float><float name="Width1">48.867923736572266</float><float name="ZOffset">-1</float><BinaryString name="AttributesSerialize">BAAAAAgAAABEdXJhdGlvbgYAAAAAAAAAAAkAAABFbWl0RGVsYXkGAAAAAAAAAAAGAAAAV2lkdGgwBgAAAAAAAAAABgAAAFdpZHRoMQYAAAAAAAAAAA==</BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Beam" referent="4150"><Properties><Ref name="Attachment0">4122</Ref><Ref name="Attachment1">4121</Ref><float name="Brightness">5</float><ColorSequence name="Color">0 0 1 1 0 1 0 1 1 0 </ColorSequence><float name="CurveSize0">9.773584365844727</float><float name="CurveSize1">9.773584365844727</float><bool name="FaceCamera">true</bool><float name="LightEmission">0.8500000238418579</float><Content name="Texture"><url><![CDATA[rbxassetid://10472990183]]></url></Content><float name="TextureLength">0.10000000149011612</float><float name="TextureSpeed">0.20000000298023224</float><NumberSequence name="Transparency">0 1 0 0.5 0.5 0 1 1 0 </NumberSequence><float name="Width0">12.216980934143066</float><float name="Width1">12.216980934143066</float><BinaryString name="AttributesSerialize">BAAAAAgAAABEdXJhdGlvbgYAAAAAAAAAAAkAAABFbWl0RGVsYXkGAAAAAAAAAAAGAAAAV2lkdGgwBgAAAAAAAAAABgAAAFdpZHRoMQYAAAAAAAAAAA==</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Beam1]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Beam" referent="4151"><Properties><Ref name="Attachment0">4122</Ref><Ref name="Attachment1">4121</Ref><float name="Brightness">0.07500000298023224</float><ColorSequence name="Color">0 0 0.6666666865348816 1 0 1 0 0.6666666865348816 1 0 </ColorSequence><float name="CurveSize0">9.773584365844727</float><float name="CurveSize1">9.773584365844727</float><float name="LightEmission">0.8500000238418579</float><Content name="Texture"><url><![CDATA[rbxassetid://10386316474]]></url></Content><float name="TextureLength">0.10000000149011612</float><float name="TextureSpeed">0.20000000298023224</float><NumberSequence name="Transparency">0 1 0 0.5 0.5 0 1 1 0 </NumberSequence><float name="Width0">24.433961868286133</float><float name="Width1">24.433961868286133</float><BinaryString name="AttributesSerialize">BAAAAAgAAABEdXJhdGlvbgYAAAAAAAAAAAkAAABFbWl0RGVsYXkGAAAAAAAAAAAGAAAAV2lkdGgwBgAAAAAAAAAABgAAAFdpZHRoMQYAAAAAAAAAAA==</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Beam2]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item></Item><Item class="P