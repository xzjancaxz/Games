.floor(v41)
		local v43 = v37 * 0.7
		v39.Size = v40(v42, (math.floor(v43)))
		p_u_2.applyInteractionHighlights("Image", v35, v39, {
			["Color"] = p_u_1._config.TextColor,
			["Transparency"] = 1,
			["HoveredColor"] = p_u_1._config.TextColor,
			["HoveredTransparency"] = p_u_1._config.TextTransparency,
			["ActiveColor"] = p_u_1._config.TextColor,
			["ActiveTransparency"] = p_u_1._config.TextTransparency
		})
		v39.Parent = v38
		local v44 = Instance.new("Frame")
		v44.Name = "TabContainer"
		v44.AutomaticSize = Enum.AutomaticSize.Y
		v44.Size = UDim2.fromScale(1, 0)
		v44.BackgroundTransparency = 1
		v44.BorderSizePixel = 0
		v44.ClipsDescendants = true
		p_u_2.UIListLayout(v44, Enum.FillDirection.Vertical, UDim.new(0, p_u_1._config.ItemSpacing.Y))
		p_u_2.UIPadding(v44, Vector2.new(0, p_u_1._config.ItemSpacing.Y)).PaddingBottom = UDim.new()
		p_u_34.ChildContainer = v44
		return v35
	end
	function v25.Update(p45)
		local v46 = p45.Instance
		local v47 = v46.TextLabel
		local v48 = v46.CloseButton
		v47.Text = p45.arguments.Text
		v48.Visible = p45.arguments.Hideable == true
	end
	function v25.ChildAdded(p49, _)
		return p49.ChildContainer
	end
	function v25.GenerateState(p50)
		-- upvalues: (copy) p_u_1
		p50.state.index = p50.parentWidget.state.index
		p50.state.index.ConnectedWidgets[p50.ID] = p50
		if p50.state.isOpened == nil then
			p50.state.isOpened = p_u_1._widgetState(p50, "isOpened", true)
		end
	end
	function v25.UpdateState(p51)
		-- upvalues: (copy) p_u_1, (copy) v_u_7
		local v52 = p51.Instance
		local v53 = p51.ChildContainer
		if p51.state.isOpened.lastChangeTick == p_u_1._cycleTick then
			if p51.state.isOpened.value == true then
				p51.lastOpenedTick = p_u_1._cycleTick + 1
				local v54 = p51.parentWidget
				local v55 = p51.Index
				if v54.state.index.value <= 0 then
					v54.state.index:set(v55)
				end
				v52.Visible = true
			else
				p51.lastClosedTick = p_u_1._cycleTick + 1
				v_u_7(p51.parentWidget, p51.Index)
				v52.Visible = false
			end
		end
		if p51.state.index.lastChangeTick == p_u_1._cycleTick then
			if p51.state.index.value == p51.Index then
				p51.ButtonColors.Color = p_u_1._config.TabActiveColor
				p51.ButtonColors.Transparency = p_u_1._config.TabActiveTransparency
				v52.BackgroundColor3 = p_u_1._config.TabActiveColor
				v52.BackgroundTransparency = p_u_1._config.TabActiveTransparency
				v53.Visible = true
				p51.lastSelectedTick = p_u_1._cycleTick + 1
				return
			end
			p51.ButtonColors.Color = p_u_1._config.TabColor
			p51.ButtonColors.Transparency = p_u_1._config.TabTransparency
			v52.BackgroundColor3 = p_u_1._config.TabColor
			v52.BackgroundTransparency = p_u_1._config.TabTransparency
			v53.Visible = false
			p51.lastUnselectedTick = p_u_1._cycleTick + 1
		end
	end
	function v25.Discard(p56)
		-- upvalues: (copy) v_u_7, (copy) p_u_2
		if p56.state.isOpened.value == true then
			v_u_7(p56.parentWidget, p56.Index)
		end
		p56.Instance:Destroy()
		p56.ChildContainer:Destroy()
		p_u_2.discardState(p56)
	end
	v24("Tab", v25)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Tab]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3467"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p_u_1, p_u_2)
	local v_u_3 = {}
	local v_u_4 = {}
	local v_u_5 = false
	local v_u_6 = nil
	local v_u_7 = 0
	local v_u_8 = -1
	local v_u_9 = -1
	local v_u_10 = 0
	local function v_u_17(p11, p12)
		-- upvalues: (copy) p_u_1
		local v13 = 0
		for _, v14 in p11._cellInstances do
			for _, v15 in v14[p12]:GetChildren() do
				if v15:IsA("GuiObject") then
					local v16 = v15.AbsoluteSize.X
					v13 = math.max(v13, v16)
				end
			end
		end
		p11._minWidths[p12] = v13 + 2 * p_u_1._config.CellPadding.X
	end
	local v18 = p_u_1._postCycleCallbacks
	table.insert(v18, function()
		-- upvalues: (copy) v_u_3, (copy) p_u_1, (copy) v_u_4, (copy) v_u_17
		for _, v19 in v_u_3 do
			for v20, v21 in v19._rowCycles do
				if v21 < p_u_1._cycleTick - 1 then
					local v22 = v19._rowInstances[v20]
					local v23 = v19._rowBorders[v20 - 1]
					if v22 ~= nil then
						v22:Destroy()
					end
					if v23 ~= nil then
						v23:Destroy()
					end
					v19._rowInstances[v20] = nil
					v19._rowBorders[v20 - 1] = nil
					v19._cellInstances[v20] = nil
					v19._rowCycles[v20] = nil
				end
			end
			v19._rowIndex = 1
			v19._columnIndex = 1
			v19.Instance.BorderContainer.Size = UDim2.new(1, 0, 0, v19._rowContainer.AbsoluteSize.Y)
			v19._columnBorders[0].Size = UDim2.new(0, 5, 0, v19._rowContainer.AbsoluteSize.Y)
		end
		for v24, v25 in v_u_4 do
			local v26 = false
			for v27, _ in v25 do
				v_u_17(v24, v27)
				v26 = true
			end
			if v26 then
				table.clear(v25)
				p_u_1._widgets.Table.UpdateState(v24)
			end
		end
	end)
	local function v_u_58()
		-- upvalues: (ref) v_u_5, (ref) v_u_6, (copy) p_u_1, (ref) v_u_8, (ref) v_u_7, (ref) v_u_9, (copy) p_u_2, (ref) v_u_10
		if v_u_5 ~= false and v_u_6 ~= nil then
			local v28 = v_u_6.state.widths
			local v29 = v_u_6.arguments.NumColumns
			local v30 = v_u_6.Instance
			local v31 = v30.BorderContainer
			local v32 = v_u_6.arguments.FixedWidth
			local v33 = 2 * p_u_1._config.CellPadding.X
			if v_u_8 == -1 then
				v_u_8 = v28.value[v_u_7]
				if v_u_8 == 0 then
					v_u_8 = v33 / v30.AbsoluteSize.X
				end
				v_u_9 = v28.value[v_u_7 + 1] or -1
				if v_u_9 == 0 then
					v_u_9 = v33 / v30.AbsoluteSize.X
				end
			end
			local v34 = v30.AbsolutePosition.X
			local v35
			if v_u_7 == 1 then
				v35 = 0
			else
				local v36 = v31:FindFirstChild((("Border_%*"):format(v_u_7 - 1))).AbsolutePosition.X + 3 - v34
				v35 = math.floor(v36)
			end
			local v37
			if v_u_7 >= v29 - 1 then
				v37 = v30.AbsoluteSize.X
			else
				local v38 = v31:FindFirstChild((("Border_%*"):format(v_u_7 + 1))).AbsolutePosition.X + 3 - v34
				v37 = math.floor(v38)
			end
			local v39 = v34 - p_u_2.GuiOffset.X
			local v40 = p_u_2.getMouseLocation().X
			local v41 = v35 + v39 + v33
			local v42 = v37 + v39 - v33
			local v43 = math.clamp(v40, v41, v42) - v_u_10
			local v44 = v_u_8 / (v_u_10 - v39 - v35)
			if v32 then
				local v45 = v28.value
				local v46 = v_u_7
				local v47 = v_u_8 + v43
				local v48 = math.round(v47)
				local v49 = v30.AbsoluteSize.X - v35
				v45[v46] = math.clamp(v48, v33, v49)
			else
				local v50 = v44 * v43
				local v51 = v28.value
				local v52 = v_u_7
				local v53 = v_u_8 + v50
				local v54 = (v37 - v35 - v33) / v30.AbsoluteSize.X
				v51[v52] = math.clamp(v53, 0, v54)
				if v_u_7 < v29 then
					local v55 = v28.value
					local v56 = v_u_7 + 1
					local v57 = v_u_9 - v50
					v55[v56] = math.clamp(v57, 0, 1)
				end
			end
			v28:set(v28.value, true)
		end
	end
	p_u_2.registerEvent("InputChanged", function()
		-- upvalues: (copy) p_u_1, (copy) v_u_58
		if p_u_1._started then
			v_u_58()
		end
	end)
	p_u_2.registerEvent("InputEnded", function(p59)
		-- upvalues: (copy) p_u_1, (ref) v_u_5, (ref) v_u_6, (ref) v_u_7, (ref) v_u_8, (ref) v_u_9, (ref) v_u_10
		if p_u_1._started then
			if p59.UserInputType == Enum.UserInputType.MouseButton1 and v_u_5 then
				v_u_5 = false
				v_u_6 = nil
				v_u_7 = 0
				v_u_8 = -1
				v_u_9 = -1
				v_u_10 = 0
			end
		end
	end)
	local function v_u_64(_, p60, p61, p62)
		-- upvalues: (copy) p_u_2, (copy) p_u_1
		local v63
		if p62 then
			v63 = Instance.new("TextButton")
			v63.Text = ""
			v63.AutoButtonColor = false
		else
			v63 = Instance.new("Frame")
		end
		v63.Name = ("Cell_%*"):format(p60)
		v63.AutomaticSize = Enum.AutomaticSize.Y
		v63.Size = UDim2.new(p61, UDim.new())
		v63.BackgroundTransparency = 1
		v63.ZIndex = p60
		v63.LayoutOrder = p60
		v63.ClipsDescendants = true
		if p62 then
			p_u_2.applyInteractionHighlights("Background", v63, v63, {
				["Color"] = p_u_1._config.HeaderColor,
				["Transparency"] = 1,
				["HoveredColor"] = p_u_1._config.HeaderHoveredColor,
				["HoveredTransparency"] = p_u_1._config.HeaderHoveredTransparency,
				["ActiveColor"] = p_u_1._config.HeaderActiveColor,
				["ActiveTransparency"] = p_u_1._config.HeaderActiveTransparency
			})
		end
		p_u_2.UIPadding(v63, p_u_1._config.CellPadding)
		p_u_2.UIListLayout(v63, Enum.FillDirection.Vertical, UDim.new())
		p_u_2.UISizeConstraint(v63, Vector2.new(2 * p_u_1._config.CellPadding.X, 0))
		return v63
	end
	local function v_u_74(p_u_65, p_u_66, p67)
		-- upvalues: (copy) p_u_1, (copy) p_u_2, (ref) v_u_5, (ref) v_u_6, (ref) v_u_7, (ref) v_u_8, (ref) v_u_9, (ref) v_u_10
		local v68 = Instance.new("ImageButton")
		v68.Name = ("Border_%*"):format(p_u_66)
		v68.Size = UDim2.new(0, 5, 1, 0)
		v68.BackgroundTransparency = 1
		v68.AutoButtonColor = false
		v68.Image = ""
		v68.ImageTransparency = 1
		v68.ZIndex = p_u_66
		v68.LayoutOrder = p_u_66 * 2
		local v69 = p_u_66 == p_u_65.arguments.NumColumns and 3 or 2
		local v70 = Instance.new("Frame")
		v70.Name = "Line"
		v70.Size = UDim2.new(0, 1, 1, 0)
		v70.Position = UDim2.fromOffset(v69, 0)
		v70.BackgroundColor3 = p_u_1._config[("TableBorder%*Color"):format(p67)]
		v70.BackgroundTransparency = p_u_1._config[("TableBorder%*Transparency"):format(p67)]
		v70.BorderSizePixel = 0
		v70.Parent = v68
		local v71 = Instance.new("Frame")
		v71.Name = "Hover"
		v71.Size = UDim2.new(0, 1, 1, 0)
		v71.Position = UDim2.fromOffset(v69, 0)
		v71.BackgroundColor3 = p_u_1._config[("TableBorder%*Color"):format(p67)]
		v71.BackgroundTransparency = p_u_1._config[("TableBorder%*Transparency"):format(p67)]
		v71.BorderSizePixel = 0
		v71.Visible = p_u_65.arguments.Resizable
		v71.Parent = v68
		p_u_2.applyInteractionHighlights("Background", v68, v71, {
			["Color"] = p_u_1._config.ResizeGripColor,
			["Transparency"] = 1,
			["HoveredColor"] = p_u_1._config.ResizeGripHoveredColor,
			["HoveredTransparency"] = p_u_1._config.ResizeGripHoveredTransparency,
			["ActiveColor"] = p_u_1._config.ResizeGripActiveColor,
			["ActiveTransparency"] = p_u_1._config.ResizeGripActiveTransparency
		})
		p_u_2.applyButtonDown(v68, function()
			-- upvalues: (copy) p_u_65, (copy) p_u_66, (ref) v_u_5, (ref) v_u_6, (ref) v_u_7, (ref) v_u_8, (ref) v_u_9, (ref) v_u_10, (ref) p_u_2
			if p_u_65.arguments.Resizable then
				local v72 = p_u_65
				local v73 = p_u_66
				v_u_5 = true
				v_u_6 = v72
				v_u_7 = v73
				v_u_8 = -1
				v_u_9 = -1
				v_u_10 = p_u_2.getMouseLocation().X
			end
		end)
		return v68
	end
	local function v_u_80(p75, p76)
		-- upvalues: (copy) p_u_1, (copy) p_u_2, (copy) v_u_64
		local v77 = Instance.new("Frame")
		v77.Name = ("Row_%*"):format(p76)
		v77.AutomaticSize = Enum.AutomaticSize.Y
		v77.Size = UDim2.fromScale(1, 0)
		if p76 == 0 then
			v77.BackgroundColor3 = p_u_1._config.TableHeaderColor
			v77.BackgroundTransparency = p_u_1._config.TableHeaderTransparency
		elseif p75.arguments.RowBackground == true then
			if p76 % 2 == 0 then
				v77.BackgroundColor3 = p_u_1._config.TableRowBgAltColor
				v77.BackgroundTransparency = p_u_1._config.TableRowBgAltTransparency
			else
				v77.BackgroundColor3 = p_u_1._config.TableRowBgColor
				v77.BackgroundTransparency = p_u_1._config.TableRowBgTransparency
			end
		else
			v77.BackgroundTransparency = 1
		end
		v77.BorderSizePixel = 0
		v77.ZIndex = p76 * 2 - 1
		v77.LayoutOrder = p76 * 2 - 1
		v77.ClipsDescendants = true
		p_u_2.UIListLayout(v77, Enum.FillDirection.Horizontal, UDim.new())
		p75._cellInstances[p76] = table.create(p75.arguments.NumColumns)
		for v78 = 1, p75.arguments.NumColumns do
			local v79 = v_u_64(p75, v78, p75._widths[v78], p76 == 0)
			v79.Parent = v77
			p75._cellInstances[p76][v78] = v79
		end
		p75._rowInstances[p76] = v77
		return v77
	end
	local function v_u_85(_, p81, p82)
		-- upvalues: (copy) p_u_1
		local v83 = Instance.new("Frame")
		v83.Name = ("Border_%*"):format(p81)
		v83.Size = UDim2.new(1, 0, 0, 0)
		v83.BackgroundTransparency = 1
		v83.ZIndex = p81 * 2
		v83.LayoutOrder = p81 * 2
		local v84 = Instance.new("Frame")
		v84.Name = "Line"
		v84.AnchorPoint = Vector2.new(0, 0.5)
		v84.Size = UDim2.new(1, 0, 0, 1)
		v84.BackgroundColor3 = p_u_1._config[("TableBorder%*Color"):format(p82)]
		v84.BackgroundTransparency = p_u_1._config[("TableBorder%*Transparency"):format(p82)]
		v84.BorderSizePixel = 0
		v84.Parent = v83
		return v83
	end
	local v157 = {
		["hasState"] = true,
		["hasChildren"] = true,
		["Args"] = {
			["NumColumns"] = 1,
			["Header"] = 2,
			["RowBackground"] = 3,
			["OuterBorders"] = 4,
			["InnerBorders"] = 5,
			["Resizable"] = 6,
			["FixedWidth"] = 7,
			["ProportionalWidth"] = 8,
			["LimitTableWidth"] = 9
		},
		["Events"] = {},
		["Generate"] = function(p_u_86)
			-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) p_u_2, (copy) p_u_1
			v_u_3[p_u_86.ID] = p_u_86
			v_u_4[p_u_86] = {}
			local v87 = Instance.new("Frame")
			v87.Name = "Iris_Table"
			v87.AutomaticSize = Enum.AutomaticSize.Y
			v87.Size = UDim2.fromScale(1, 0)
			v87.BackgroundTransparency = 1
			v87.ZIndex = p_u_86.ZIndex
			v87.LayoutOrder = p_u_86.ZIndex
			local v88 = Instance.new("Frame")
			v88.Name = "RowContainer"
			v88.AutomaticSize = Enum.AutomaticSize.Y
			v88.Size = UDim2.fromScale(1, 0)
			v88.BackgroundTransparency = 1
			v88.ZIndex = 1
			p_u_2.UISizeConstraint(v88)
			p_u_2.UIListLayout(v88, Enum.FillDirection.Vertical, UDim.new())
			v88.Parent = v87
			p_u_86._rowContainer = v88
			local v89 = Instance.new("Frame")
			v89.Name = "BorderContainer"
			v89.Size = UDim2.fromScale(1, 1)
			v89.BackgroundTransparency = 1
			v89.ZIndex = 2
			v89.ClipsDescendants = true
			p_u_2.UISizeConstraint(v89)
			p_u_2.UIListLayout(v89, Enum.FillDirection.Horizontal, UDim.new())
			p_u_2.UIStroke(v89, 1, p_u_1._config.TableBorderStrongColor, p_u_1._config.TableBorderStrongTransparency)
			v89.Parent = v87
			p_u_86._columnIndex = 1
			p_u_86._rowIndex = 1
			p_u_86._rowInstances = {}
			p_u_86._cellInstances = {}
			p_u_86._rowBorders = {}
			p_u_86._columnBorders = {}
			p_u_86._rowCycles = {}
			local v_u_90 = #p_u_1._postCycleCallbacks + 1
			local v_u_91 = p_u_1._cycleTick + 1
			p_u_1._postCycleCallbacks[v_u_90] = function()
				-- upvalues: (ref) p_u_1, (copy) v_u_91, (copy) p_u_86, (copy) v_u_90
				if v_u_91 <= p_u_1._cycleTick then
					if p_u_86.lastCycleTick ~= -1 then
						p_u_86.state.widths.lastChangeTick = p_u_1._cycleTick
						p_u_1._widgets.Table.UpdateState(p_u_86)
					end
					p_u_1._postCycleCallbacks[v_u_90] = nil
				end
			end
			return v87
		end,
		["GenerateState"] = function(p92)
			-- upvalues: (copy) p_u_1, (copy) v_u_74, (copy) v_u_64
			local v93 = p92.arguments.NumColumns
			if p92.state.widths == nil then
				local v94 = table.create(v93, 1 / v93)
				p92.state.widths = p_u_1._widgetState(p92, "widths", v94)
			end
			p92._widths = table.create(v93, UDim.new())
			p92._minWidths = table.create(v93, 0)
			local v95 = p92.Instance
			local v96 = v95.BorderContainer
			p92._cellInstances[-1] = table.create(v93)
			for v97 = 1, v93 do
				local v98 = v_u_74(p92, v97, "Light")
				v98.Visible = p92.arguments.InnerBorders
				p92._columnBorders[v97] = v98
				v98.Parent = v96
				local v99 = v_u_64(p92, v97, p92._widths[v97], false)
				v99:FindFirstChild("UISizeConstraint").MinSize = Vector2.new(2 * p_u_1._config.CellPadding.X + (v97 > 1 and -2 or 0) + (v97 < v93 and -3 or 0), 0)
				v99.LayoutOrder = v97 * 2 - 1
				p92._cellInstances[-1][v97] = v99
				v99.Parent = v96
			end
			local v100 = v_u_74(p92, v93, "Strong")
			p92._columnBorders[0] = v100
			v100.Parent = v95
		end,
		["Update"] = function(p101)
			-- upvalues: (copy) p_u_1, (copy) v_u_4
			local v102 = p101.arguments.NumColumns
			local v103 = v102 >= 1
			assert(v103, "Iris.Table must have at least one column.")
			if p101._widths ~= nil and #p101._widths ~= v102 then
				p101.arguments.NumColumns = #p101._widths
				warn("NumColumns cannot change once set. See documentation.")
			end
			for v104, v105 in p101._rowInstances do
				if v104 == 0 then
					v105.BackgroundColor3 = p_u_1._config.TableHeaderColor
					v105.BackgroundTransparency = p_u_1._config.TableHeaderTransparency
				elseif p101.arguments.RowBackground == true then
					if v104 % 2 == 0 then
						v105.BackgroundColor3 = p_u_1._config.TableRowBgAltColor
						v105.BackgroundTransparency = p_u_1._config.TableRowBgAltTransparency
					else
						v105.BackgroundColor3 = p_u_1._config.TableRowBgColor
						v105.BackgroundTransparency = p_u_1._config.TableRowBgTransparency
					end
				else
					v105.BackgroundTransparency = 1
				end
			end
			for _, v106 in p101._rowBorders do
				v106.Visible = p101.arguments.InnerBorders
			end
			for _, v107 in p101._columnBorders do
				v107.Visible = p101.arguments.InnerBorders or p101.arguments.Resizable
			end
			for _, v108 in p101._columnBorders do
				local v109 = v108:FindFirstChild("Hover")
				if v109 then
					v109.Visible = p101.arguments.Resizable
				end
			end
			if p101._columnBorders[v102] ~= nil then
				local v110 = p101._columnBorders[v102]
				local v111 = not p101.arguments.LimitTableWidth
				if v111 then
					v111 = p101.arguments.Resizable or p101.arguments.InnerBorders
				end
				v110.Visible = v111
				local v112 = p101._columnBorders[0]
				local v113 = p101.arguments.LimitTableWidth
				if v113 then
					v113 = p101.arguments.Resizable or p101.arguments.OuterBorders
				end
				v112.Visible = v113
			end
			local v114 = p101._rowInstances[0]
			local v115 = p101._rowBorders[0]
			if v114 ~= nil then
				v114.Visible = p101.arguments.Header
			end
			if v115 ~= nil then
				local v116 = p101.arguments.Header
				if v116 then
					v116 = p101.arguments.InnerBorders
				end
				v115.Visible = v116
			end
			p101.Instance.BorderContainer.UIStroke.Enabled = p101.arguments.OuterBorders
			for v117 = 1, p101.arguments.NumColumns do
				v_u_4[p101][v117] = true
			end
			if p101._widths ~= nil then
				p_u_1._widgets.Table.UpdateState(p101)
			end
		end,
		["UpdateState"] = function(p118)
			local v119 = p118.Instance
			local v120 = v119.BorderContainer
			local v121 = v119.RowContainer
			local v122 = p118.arguments.NumColumns
			local v123 = p118.state.widths.value
			local v124 = p118._minWidths
			local v125 = p118.arguments.FixedWidth
			local v126 = p118.arguments.ProportionalWidth
			if not p118.arguments.Resizable then
				if v125 then
					if v126 then
						for v127 = 1, v122 do
							v123[v127] = v124[v127]
						end
					else
						local v128 = 0
						for _, v129 in v124 do
							v128 = math.max(v128, v129)
						end
						for v130 = 1, v122 do
							v123[v130] = v128
						end
					end
				elseif v126 then
					local v131 = 0
					for _, v132 in v124 do
						v131 = v131 + v132
					end
					local v133 = 1 / v131
					for v134 = 1, v122 do
						v123[v134] = v133 * v124[v134]
					end
				else
					local v135 = 1 / v122
					for v136 = 1, v122 do
						v123[v136] = v135
					end
				end
			end
			local v137 = UDim.new()
			for v138 = 1, v122 do
				local v139 = v123[v138]
				local v140 = UDim.new(v125 and 0 or math.clamp(v139, 0, 1), not v125 and 0 or math.max(v139, 0))
				p118._widths[v138] = v140
				v137 = v137 + v140
				for _, v141 in p118._cellInstances do
					v141[v138].Size = UDim2.new(v140, UDim.new())
				end
				p118._cellInstances[-1][v138].Size = UDim2.new(v140 + UDim.new(0, (v138 > 1 and -2 or 0) - 3), UDim.new())
			end
			local v142 = v137.Offset
			local v143 = not (p118.arguments.FixedWidth and p118.arguments.LimitTableWidth) and (1 / 0) or v142
			v120.UISizeConstraint.MaxSize = Vector2.new(v143, (1 / 0))
			v121.UISizeConstraint.MaxSize = Vector2.new(v143, (1 / 0))
			p118._columnBorders[0].Position = UDim2.new(0, v143 - 3, 0, 0)
		end,
		["ChildAdded"] = function(p144, _)
			-- upvalues: (copy) p_u_1, (copy) v_u_4, (copy) v_u_80, (copy) v_u_85
			local v145 = p144._rowIndex
			local v146 = p144._columnIndex
			local v147 = p144._rowInstances[v145]
			p144._rowCycles[v145] = p_u_1._cycleTick
			v_u_4[p144][v146] = true
			if v147 ~= nil then
				return p144._cellInstances[v145][v146]
			end
			local v148 = v_u_80(p144, v145)
			if v145 == 0 then
				v148.Visible = p144.arguments.Header
			end
			v148.Parent = p144._rowContainer
			if v145 > 0 then
				local v149 = v_u_85(p144, v145 - 1, v145 == 1 and "Strong" or "Light")
				local v150 = p144.arguments.InnerBorders and (v145 == 1 and (p144.arguments.Header and p144.arguments.InnerBorders))
				if v150 then
					v150 = p144._rowInstances[0] ~= nil
				end
				v149.Visible = v150
				p144._rowBorders[v145 - 1] = v149
				v149.Parent = p144._rowContainer
			end
			return p144._cellInstances[v145][v146]
		end,
		["ChildDiscarded"] = function(p151, p152)
			-- upvalues: (copy) v_u_4
			local v153 = p152.Instance.Parent
			if v153 ~= nil then
				local v154 = v153.Name
				local v155 = tonumber(v154:sub(6))
				if v155 then
					v_u_4[p151][v155] = true
				end
			end
		end,
		["Discard"] = function(p156)
			-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) p_u_2
			v_u_3[p156.ID] = nil
			v_u_4[p156] = nil
			p156.Instance:Destroy()
			p_u_2.discardState(p156)
		end
	}
	p_u_1.WidgetConstructor("Table", v157)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Table]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3468"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p_u_1, p_u_2)
	local v3 = p_u_1.WidgetConstructor
	local v10 = {
		["hasState"] = false,
		["hasChildren"] = false,
		["Args"] = {
			["Text"] = 1,
			["Wrapped"] = 2,
			["Color"] = 3,
			["RichText"] = 4
		},
		["Events"] = {
			["hovered"] = p_u_2.EVENTS.hover(function(p4)
				return p4.Instance
			end)
		},
		["Generate"] = function(p5)
			-- upvalues: (copy) p_u_2
			local v6 = Instance.new("TextLabel")
			v6.Name = "Iris_Text"
			v6.Size = UDim2.fromOffset(0, 0)
			v6.BackgroundTransparency = 1
			v6.BorderSizePixel = 0
			v6.LayoutOrder = p5.ZIndex
			v6.AutomaticSize = Enum.AutomaticSize.XY
			p_u_2.applyTextStyle(v6)
			p_u_2.UIPadding(v6, Vector2.new(0, 2))
			return v6
		end,
		["Update"] = function(p7)
			-- upvalues: (copy) p_u_1
			local v8 = p7.Instance
			if p7.arguments.Text == nil then
				error("Text argument is required for Iris.Text().", 5)
			end
			if p7.arguments.Wrapped == nil then
				v8.TextWrapped = p_u_1._config.TextWrapped
			else
				v8.TextWrapped = p7.arguments.Wrapped
			end
			if p7.arguments.Color then
				v8.TextColor3 = p7.arguments.Color
			else
				v8.TextColor3 = p_u_1._config.TextColor
			end
			if p7.arguments.RichText == nil then
				v8.RichText = p_u_1._config.RichText
			else
				v8.RichText = p7.arguments.RichText
			end
			v8.Text = p7.arguments.Text
		end,
		["Discard"] = function(p9)
			p9.Instance:Destroy()
		end
	}
	v3("Text", v10)
	local v11 = p_u_1.WidgetConstructor
	local v21 = {
		["hasState"] = false,
		["hasChildren"] = false,
		["Args"] = {
			["Text"] = 1
		},
		["Events"] = {
			["hovered"] = p_u_2.EVENTS.hover(function(p12)
				return p12.Instance
			end)
		},
		["Generate"] = function(p13)
			-- upvalues: (copy) p_u_1, (copy) p_u_2
			local v14 = Instance.new("Frame")
			v14.Name = "Iris_SeparatorText"
			v14.Size = UDim2.new(p_u_1._config.ItemWidth, UDim.new())
			v14.BackgroundTransparency = 1
			v14.BorderSizePixel = 0
			v14.AutomaticSize = Enum.AutomaticSize.Y
			v14.LayoutOrder = p13.ZIndex
			v14.ClipsDescendants = true
			p_u_2.UIPadding(v14, Vector2.new(0, p_u_1._config.SeparatorTextPadding.Y))
			p_u_2.UIListLayout(v14, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemSpacing.X))
			v14.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			local v15 = Instance.new("TextLabel")
			v15.Name = "TextLabel"
			v15.BackgroundTransparency = 1
			v15.BorderSizePixel = 0
			v15.AutomaticSize = Enum.AutomaticSize.XY
			v15.LayoutOrder = 1
			p_u_2.applyTextStyle(v15)
			v15.Parent = v14
			local v16 = Instance.new("Frame")
			v16.Name = "Left"
			v16.AnchorPoint = Vector2.new(1, 0.5)
			v16.BackgroundColor3 = p_u_1._config.SeparatorColor
			v16.BackgroundTransparency = p_u_1._config.SeparatorTransparency
			v16.BorderSizePixel = 0
			v16.Size = UDim2.fromOffset(p_u_1._config.SeparatorTextPadding.X - p_u_1._config.ItemSpacing.X, p_u_1._config.SeparatorTextBorderSize)
			v16.Parent = v14
			local v17 = Instance.new("Frame")
			v17.Name = "Right"
			v17.AnchorPoint = Vector2.new(1, 0.5)
			v17.BackgroundColor3 = p_u_1._config.SeparatorColor
			v17.BackgroundTransparency = p_u_1._config.SeparatorTransparency
			v17.BorderSizePixel = 0
			v17.Size = UDim2.new(1, 0, 0, p_u_1._config.SeparatorTextBorderSize)
			v17.LayoutOrder = 2
			v17.Parent = v14
			return v14
		end,
		["Update"] = function(p18)
			local v19 = p18.Instance.TextLabel
			if p18.arguments.Text == nil then
				error("Text argument is required for Iris.SeparatorText().", 5)
			end
			v19.Text = p18.arguments.Text
		end,
		["Discard"] = function(p20)
			p20.Instance:Destroy()
		end
	}
	v11("SeparatorText", v21)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Text]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3469"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p_u_1, p_u_2)
	local v3 = {
		["hasState"] = true,
		["hasChildren"] = true
	}
	local v7 = {
		["collapsed"] = {
			["Init"] = function(_) end,
			["Get"] = function(p4)
				-- upvalues: (copy) p_u_1
				return p4.lastCollapsedTick == p_u_1._cycleTick
			end
		},
		["uncollapsed"] = {
			["Init"] = function(_) end,
			["Get"] = function(p5)
				-- upvalues: (copy) p_u_1
				return p5.lastUncollapsedTick == p_u_1._cycleTick
			end
		},
		["hovered"] = p_u_2.EVENTS.hover(function(p6)
			return p6.Instance
		end)
	}
	v3.Events = v7
	function v3.Discard(p8)
		-- upvalues: (copy) p_u_2
		p8.Instance:Destroy()
		p_u_2.discardState(p8)
	end
	function v3.ChildAdded(p9, _)
		local v10 = p9.ChildContainer
		v10.Visible = p9.state.isUncollapsed.value
		return v10
	end
	function v3.UpdateState(p11)
		-- upvalues: (copy) p_u_2, (copy) p_u_1
		local v12 = p11.state.isUncollapsed.value
		local v13 = p11.Instance
		local v14 = p11.ChildContainer
		v13.Header.Button.Arrow.Image = v12 and p_u_2.ICONS.DOWN_POINTING_TRIANGLE or p_u_2.ICONS.RIGHT_POINTING_TRIANGLE
		if v12 then
			p11.lastUncollapsedTick = p_u_1._cycleTick + 1
		else
			p11.lastCollapsedTick = p_u_1._cycleTick + 1
		end
		v14.Visible = v12
	end
	function v3.GenerateState(p15)
		-- upvalues: (copy) p_u_1
		if p15.state.isUncollapsed == nil then
			p15.state.isUncollapsed = p_u_1._widgetState(p15, "isUncollapsed", p15.arguments.DefaultOpen or false)
		end
	end
	local v32 = {
		["Args"] = {
			["Text"] = 1,
			["SpanAvailWidth"] = 2,
			["NoIndent"] = 3,
			["DefaultOpen"] = 4
		},
		["Generate"] = function(p_u_16)
			-- upvalues: (copy) p_u_1, (copy) p_u_2
			local v17 = Instance.new("Frame")
			v17.Name = "Iris_Tree"
			v17.Size = UDim2.new(p_u_1._config.ItemWidth, UDim.new(0, 0))
			v17.AutomaticSize = Enum.AutomaticSize.Y
			v17.BackgroundTransparency = 1
			v17.BorderSizePixel = 0
			v17.LayoutOrder = p_u_16.ZIndex
			p_u_2.UIListLayout(v17, Enum.FillDirection.Vertical, UDim.new(0, 0))
			local v18 = Instance.new("Frame")
			v18.Name = "TreeContainer"
			v18.Size = UDim2.fromScale(1, 0)
			v18.AutomaticSize = Enum.AutomaticSize.Y
			v18.BackgroundTransparency = 1
			v18.BorderSizePixel = 0
			v18.LayoutOrder = 1
			v18.Visible = false
			p_u_2.UIListLayout(v18, Enum.FillDirection.Vertical, UDim.new(0, p_u_1._config.ItemSpacing.Y))
			p_u_2.UIPadding(v18, Vector2.zero).PaddingTop = UDim.new(0, p_u_1._config.ItemSpacing.Y)
			v18.Parent = v17
			local v19 = Instance.new("Frame")
			v19.Name = "Header"
			v19.Size = UDim2.fromScale(1, 0)
			v19.AutomaticSize = Enum.AutomaticSize.Y
			v19.BackgroundTransparency = 1
			v19.BorderSizePixel = 0
			v19.Parent = v17
			local v20 = Instance.new("TextButton")
			v20.Name = "Button"
			v20.BackgroundTransparency = 1
			v20.BorderSizePixel = 0
			v20.Text = ""
			v20.AutoButtonColor = false
			p_u_2.applyInteractionHighlights("Background", v20, v19, {
				["Color"] = Color3.fromRGB(0, 0, 0),
				["Transparency"] = 1,
				["HoveredColor"] = p_u_1._config.HeaderHoveredColor,
				["HoveredTransparency"] = p_u_1._config.HeaderHoveredTransparency,
				["ActiveColor"] = p_u_1._config.HeaderActiveColor,
				["ActiveTransparency"] = p_u_1._config.HeaderActiveTransparency
			})
			p_u_2.UIPadding(v20, Vector2.zero).PaddingLeft = UDim.new(0, p_u_1._config.FramePadding.X)
			p_u_2.UIListLayout(v20, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			v20.Parent = v19
			local v21 = Instance.new("ImageLabel")
			v21.Name = "Arrow"
			local v22 = UDim2.fromOffset
			local v23 = p_u_1._config.TextSize
			local v24 = p_u_1._config.TextSize * 0.7
			v21.Size = v22(v23, (math.floor(v24)))
			v21.BackgroundTransparency = 1
			v21.BorderSizePixel = 0
			v21.ImageColor3 = p_u_1._config.TextColor
			v21.ImageTransparency = p_u_1._config.TextTransparency
			v21.ScaleType = Enum.ScaleType.Fit
			v21.Parent = v20
			local v25 = Instance.new("TextLabel")
			v25.Name = "TextLabel"
			v25.Size = UDim2.fromOffset(0, 0)
			v25.AutomaticSize = Enum.AutomaticSize.XY
			v25.BackgroundTransparency = 1
			v25.BorderSizePixel = 0
			p_u_2.UIPadding(v25, Vector2.zero).PaddingRight = UDim.new(0, 21)
			p_u_2.applyTextStyle(v25)
			v25.Parent = v20
			p_u_2.applyButtonClick(v20, function()
				-- upvalues: (copy) p_u_16
				p_u_16.state.isUncollapsed:set(not p_u_16.state.isUncollapsed.value)
			end)
			p_u_16.ChildContainer = v18
			return v17
		end,
		["Update"] = function(p26)
			-- upvalues: (copy) p_u_1
			local v27 = p26.Instance
			local v28 = p26.ChildContainer
			local v29 = v27.Header.Button
			local v30 = v29.TextLabel
			local v31 = v28.UIPadding
			v30.Text = p26.arguments.Text or "Tree"
			if p26.arguments.SpanAvailWidth then
				v29.AutomaticSize = Enum.AutomaticSize.Y
				v29.Size = UDim2.fromScale(1, 0)
			else
				v29.AutomaticSize = Enum.AutomaticSize.XY
				v29.Size = UDim2.fromScale(0, 0)
			end
			if p26.arguments.NoIndent then
				v31.PaddingLeft = UDim.new(0, 0)
			else
				v31.PaddingLeft = UDim.new(0, p_u_1._config.IndentSpacing)
			end
		end
	}
	p_u_1.WidgetConstructor("Tree", p_u_2.extend(v3, v32))
	local v44 = {
		["Args"] = {
			["Text"] = 1,
			["DefaultOpen"] = 2
		},
		["Generate"] = function(p_u_33)
			-- upvalues: (copy) p_u_1, (copy) p_u_2
			local v34 = Instance.new("Frame")
			v34.Name = "Iris_CollapsingHeader"
			v34.Size = UDim2.new(p_u_1._config.ItemWidth, UDim.new(0, 0))
			v34.AutomaticSize = Enum.AutomaticSize.Y
			v34.BackgroundTransparency = 1
			v34.BorderSizePixel = 0
			v34.LayoutOrder = p_u_33.ZIndex
			p_u_2.UIListLayout(v34, Enum.FillDirection.Vertical, UDim.new(0, 0))
			local v35 = Instance.new("Frame")
			v35.Name = "CollapsingHeaderContainer"
			v35.Size = UDim2.fromScale(1, 0)
			v35.AutomaticSize = Enum.AutomaticSize.Y
			v35.BackgroundTransparency = 1
			v35.BorderSizePixel = 0
			v35.LayoutOrder = 1
			v35.Visible = false
			p_u_2.UIListLayout(v35, Enum.FillDirection.Vertical, UDim.new(0, p_u_1._config.ItemSpacing.Y))
			p_u_2.UIPadding(v35, Vector2.zero).PaddingTop = UDim.new(0, p_u_1._config.ItemSpacing.Y)
			v35.Parent = v34
			local v36 = Instance.new("Frame")
			v36.Name = "Header"
			v36.Size = UDim2.fromScale(1, 0)
			v36.AutomaticSize = Enum.AutomaticSize.Y
			v36.BackgroundTransparency = 1
			v36.BorderSizePixel = 0
			v36.Parent = v34
			local v37 = Instance.new("TextButton")
			v37.Name = "Button"
			v37.Size = UDim2.new(1, 0, 0, 0)
			v37.AutomaticSize = Enum.AutomaticSize.Y
			v37.BackgroundColor3 = p_u_1._config.HeaderColor
			v37.BackgroundTransparency = p_u_1._config.HeaderTransparency
			v37.BorderSizePixel = 0
			v37.Text = ""
			v37.AutoButtonColor = false
			v37.ClipsDescendants = true
			p_u_2.UIPadding(v37, p_u_1._config.FramePadding)
			p_u_2.applyFrameStyle(v37, true)
			p_u_2.UIListLayout(v37, Enum.FillDirection.Horizontal, UDim.new(0, 2 * p_u_1._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center
			p_u_2.applyInteractionHighlights("Background", v37, v37, {
				["Color"] = p_u_1._config.HeaderColor,
				["Transparency"] = p_u_1._config.HeaderTransparency,
				["HoveredColor"] = p_u_1._config.HeaderHoveredColor,
				["HoveredTransparency"] = p_u_1._config.HeaderHoveredTransparency,
				["ActiveColor"] = p_u_1._config.HeaderActiveColor,
				["ActiveTransparency"] = p_u_1._config.HeaderActiveTransparency
			})
			v37.Parent = v36
			local v38 = Instance.new("ImageLabel")
			v38.Name = "Arrow"
			local v39 = UDim2.fromOffset
			local v40 = p_u_1._config.TextSize
			local v41 = p_u_1._config.TextSize * 0.8
			v38.Size = v39(v40, (math.ceil(v41)))
			v38.AutomaticSize = Enum.AutomaticSize.Y
			v38.BackgroundTransparency = 1
			v38.BorderSizePixel = 0
			v38.ImageColor3 = p_u_1._config.TextColor
			v38.ImageTransparency = p_u_1._config.TextTransparency
			v38.ScaleType = Enum.ScaleType.Fit
			v38.Parent = v37
			local v42 = Instance.new("TextLabel")
			v42.Name = "TextLabel"
			v42.Size = UDim2.fromOffset(0, 0)
			v42.AutomaticSize = Enum.AutomaticSize.XY
			v42.BackgroundTransparency = 1
			v42.BorderSizePixel = 0
			p_u_2.UIPadding(v42, Vector2.zero).PaddingRight = UDim.new(0, 21)
			p_u_2.applyTextStyle(v42)
			v42.Parent = v37
			p_u_2.applyButtonClick(v37, function()
				-- upvalues: (copy) p_u_33
				p_u_33.state.isUncollapsed:set(not p_u_33.state.isUncollapsed.value)
			end)
			p_u_33.ChildContainer = v35
			return v34
		end,
		["Update"] = function(p43)
			p43.Instance.Header.Button.TextLabel.Text = p43.arguments.Text or "Collapsing Header"
		end
	}
	p_u_1.WidgetConstructor("CollapsingHeader", p_u_2.extend(v3, v44))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Tree]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3470"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p_u_1, p_u_2)
	local function v_u_7()
		-- upvalues: (copy) p_u_1, (copy) p_u_2
		if p_u_1._rootInstance ~= nil then
			local v3 = p_u_1._rootInstance:FindFirstChild("PopupScreenGui")
			local v4 = v3.TooltipContainer
			local v5 = p_u_2.getMouseLocation()
			local v6 = p_u_2.findBestWindowPosForPopup(v5, v4.AbsoluteSize, p_u_1._config.DisplaySafeAreaPadding, v3.AbsoluteSize)
			v4.Position = UDim2.fromOffset(v6.X, v6.Y)
		end
	end
	p_u_2.registerEvent("InputChanged", function()
		-- upvalues: (copy) p_u_1, (copy) v_u_7
		if p_u_1._started then
			v_u_7()
		end
	end)
	local v14 = {
		["hasState"] = false,
		["hasChildren"] = false,
		["Args"] = {
			["Text"] = 1
		},
		["Events"] = {},
		["Generate"] = function(p8)
			-- upvalues: (copy) p_u_1, (copy) p_u_2
			p8.parentWidget = p_u_1._rootWidget
			local v9 = Instance.new("Frame")
			v9.Name = "Iris_Tooltip"
			v9.Size = UDim2.new(p_u_1._config.ContentWidth, UDim.new(0, 0))
			v9.AutomaticSize = Enum.AutomaticSize.Y
			v9.BorderSizePixel = 0
			v9.BackgroundTransparency = 1
			v9.ZIndex = 1
			local v10 = Instance.new("TextLabel")
			v10.Name = "TooltipText"
			v10.Size = UDim2.fromOffset(0, 0)
			v10.AutomaticSize = Enum.AutomaticSize.XY
			v10.BackgroundColor3 = p_u_1._config.PopupBgColor
			v10.BackgroundTransparency = p_u_1._config.PopupBgTransparency
			v10.TextWrapped = p_u_1._config.TextWrapped
			p_u_2.applyTextStyle(v10)
			p_u_2.UIStroke(v10, p_u_1._config.PopupBorderSize, p_u_1._config.BorderActiveColor, p_u_1._config.BorderActiveTransparency)
			p_u_2.UIPadding(v10, p_u_1._config.WindowPadding)
			if p_u_1._config.PopupRounding > 0 then
				p_u_2.UICorner(v10, p_u_1._config.PopupRounding)
			end
			v10.Parent = v9
			return v9
		end,
		["Update"] = function(p11)
			-- upvalues: (copy) v_u_7
			local v12 = p11.Instance.TooltipText
			if p11.arguments.Text == nil then
				error("Text argument is required for Iris.Tooltip().", 5)
			end
			v12.Text = p11.arguments.Text
			v_u_7()
		end,
		["Discard"] = function(p13)
			p13.Instance:Destroy()
		end
	}
	p_u_1.WidgetConstructor("Tooltip", v14)
	local v_u_15 = 0
	local v_u_16 = nil
	local v_u_17 = false
	local v_u_18 = nil
	local v_u_19 = nil
	local v_u_20 = false
	local v_u_21 = false
	local v_u_22 = false
	local v_u_23 = Enum.TopBottom.Top
	local v_u_24 = Enum.LeftRight.Left
	local v_u_25 = nil
	local v_u_26 = nil
	local v_u_27 = false
	local v_u_28 = {}
	local function v_u_33()
		-- upvalues: (copy) p_u_1, (copy) v_u_28
		if p_u_1._config.UseScreenGUIs == false then
			return
		else
			local v29 = 65535
			local v30 = nil
			for _, v31 in v_u_28 do
				if v31.state.isOpened.value and (not v31.arguments.NoNav and v31.Instance:IsA("ScreenGui")) then
					local v32 = v31.Instance.DisplayOrder
					if v32 < v29 then
						v30 = v31
						v29 = v32
					end
				end
			end
			if v30 then
				if v30.state.isUncollapsed.value == false then
					v30.state.isUncollapsed:set(true)
				end
				p_u_1.SetFocusedWindow(v30)
			end
		end
	end
	local function v_u_49(p34, p35)
		-- upvalues: (copy) p_u_1, (copy) p_u_2
		local v36 = Vector2.new(p34.state.position.value.X, p34.state.position.value.Y)
		local v37 = (p_u_1._config.TextSize + 2 * p_u_1._config.FramePadding.Y) * 2
		local v38 = p_u_2.getScreenSizeForWindow(p34)
		local v39 = Vector2.new(p_u_1._config.WindowBorderSize + p_u_1._config.DisplaySafeAreaPadding.X, p_u_1._config.WindowBorderSize + p_u_1._config.DisplaySafeAreaPadding.Y)
		local v40 = v38 - v36 - v39
		local v41 = Vector2.new
		local v42 = p35.X
		local v43 = v40.X
		local v44 = math.max(v43, v37)
		local v45 = math.clamp(v42, v37, v44)
		local v46 = p35.Y
		local v47 = v40.Y
		local v48 = math.max(v47, v37)
		return v41(v45, (math.clamp(v46, v37, v48)))
	end
	local function v_u_67(p50, p51)
		-- upvalues: (copy) p_u_2, (copy) p_u_1
		local v52 = p50.Instance
		local v53 = p_u_2.getScreenSizeForWindow(p50)
		local v54 = Vector2.new(p_u_1._config.WindowBorderSize + p_u_1._config.DisplaySafeAreaPadding.X, p_u_1._config.WindowBorderSize + p_u_1._config.DisplaySafeAreaPadding.Y)
		local v55 = Vector2.new
		local v56 = p51.X
		local v57 = v54.X
		local v58 = v54.X
		local v59 = v53.X - v52.WindowButton.AbsoluteSize.X - v54.X
		local v60 = math.max(v58, v59)
		local v61 = math.clamp(v56, v57, v60)
		local v62 = p51.Y
		local v63 = v54.Y
		local v64 = v54.Y
		local v65 = v53.Y - v52.WindowButton.AbsoluteSize.Y - v54.Y
		local v66 = math.max(v64, v65)
		return v55(v61, (math.clamp(v62, v63, v66)))
	end
	function p_u_1.SetFocusedWindow(p68)
		-- upvalues: (ref) v_u_26, (ref) v_u_27, (copy) v_u_28, (copy) p_u_1, (ref) v_u_15, (copy) p_u_2
		if v_u_26 ~= p68 then
			if v_u_27 and v_u_26 ~= nil then
				if v_u_28[v_u_26.ID] then
					local v69 = v_u_26.Instance.WindowButton
					local v70 = v69.Content.TitleBar
					if v_u_26.state.isUncollapsed.value then
						v70.BackgroundColor3 = p_u_1._config.TitleBgColor
						v70.BackgroundTransparency = p_u_1._config.TitleBgTransparency
					else
						v70.BackgroundColor3 = p_u_1._config.TitleBgCollapsedColor
						v70.BackgroundTransparency = p_u_1._config.TitleBgCollapsedTransparency
					end
					v69.UIStroke.Color = p_u_1._config.BorderColor
				end
				v_u_27 = false
				v_u_26 = nil
			end
			if p68 ~= nil then
				v_u_27 = true
				v_u_26 = p68
				local v71 = p68.Instance
				local v72 = v71.WindowButton
				local v73 = v72.Content.TitleBar
				v73.BackgroundColor3 = p_u_1._config.TitleBgActiveColor
				v73.BackgroundTransparency = p_u_1._config.TitleBgActiveTransparency
				v72.UIStroke.Color = p_u_1._config.BorderActiveColor
				v_u_15 = v_u_15 + 1
				if p68.usesScreenGuis then
					v71.DisplayOrder = v_u_15 + p_u_1._config.DisplayOrderOffset
				else
					v71.ZIndex = v_u_15 + p_u_1._config.DisplayOrderOffset
				end
				if p68.state.isUncollapsed.value == false then
					p68.state.isUncollapsed:set(true)
				end
				if p_u_2.GuiService.SelectedObject then
					if v73.Visible then
						p_u_2.GuiService:Select(v73)
						return
					end
					p_u_2.GuiService:Select(p68.ChildContainer)
				end
			end
		end
	end
	p_u_2.registerEvent("InputBegan", function(p74)
		-- upvalues: (copy) p_u_1, (copy) p_u_2, (copy) v_u_28, (copy) v_u_33, (ref) v_u_21, (ref) v_u_22, (ref) v_u_27, (ref) v_u_26, (ref) v_u_23, (ref) v_u_24, (ref) v_u_20, (ref) v_u_19
		if not p_u_1._started then
			return
		end
		if p74.UserInputType == Enum.UserInputType.MouseButton1 then
			local v75 = p_u_2.getMouseLocation()
			local v76 = false
			for _, v77 in v_u_28 do
				local v78 = v77.Instance
				if v78 then
					local v79 = v78.WindowButton.ResizeBorder
					if v79 and p_u_2.isPosInsideRect(v75, v79.AbsolutePosition - p_u_2.GuiOffset, v79.AbsolutePosition - p_u_2.GuiOffset + v79.AbsoluteSize) then
						v76 = true
						break
					end
				end
			end
			if not v76 then
				p_u_1.SetFocusedWindow(nil)
			end
		end
		if p74.KeyCode == Enum.KeyCode.Tab and (p_u_2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p_u_2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
			v_u_33()
		end
		if p74.UserInputType == Enum.UserInputType.MouseButton1 and (v_u_21 and (not v_u_22 and (v_u_27 and v_u_26))) then
			local v80 = v_u_26.state.position.value + v_u_26.state.size.value / 2
			local v81 = p_u_2.getMouseLocation() - v80
			local v82 = v81.X
			local v83 = math.abs(v82) * v_u_26.state.size.value.Y
			local v84 = v81.Y
			if math.abs(v84) * v_u_26.state.size.value.X <= v83 then
				v_u_23 = Enum.TopBottom.Center
				local v85 = v81.X
				local v86
				if math.sign(v85) == -1 then
					v86 = Enum.LeftRight.Left
				else
					v86 = Enum.LeftRight.Right
				end
				v_u_24 = v86
			else
				v_u_24 = Enum.LeftRight.Center
				local v87 = v81.Y
				local v88
				if math.sign(v87) == -1 then
					v88 = Enum.TopBottom.Top
				else
					v88 = Enum.TopBottom.Bottom
				end
				v_u_23 = v88
			end
			v_u_20 = true
			v_u_19 = v_u_26
		end
	end)
	p_u_2.registerEvent("TouchTapInWorld", function(_, p89)
		-- upvalues: (copy) p_u_1
		if p_u_1._started then
			if not p89 then
				p_u_1.SetFocusedWindow(nil)
			end
		end
	end)
	p_u_2.registerEvent("InputChanged", function(p90)
		-- upvalues: (copy) p_u_1, (ref) v_u_17, (ref) v_u_16, (copy) p_u_2, (ref) v_u_18, (copy) v_u_67, (ref) v_u_20, (ref) v_u_19, (ref) v_u_25, (ref) v_u_24, (ref) v_u_23, (copy) v_u_49
		if p_u_1._started then
			if v_u_17 and v_u_16 then
				local v91
				if p90.UserInputType == Enum.UserInputType.Touch then
					local v92 = p90.Position
					v91 = Vector2.new(v92.X, v92.Y)
				else
					v91 = p_u_2.getMouseLocation()
				end
				local v93 = v_u_16.Instance.WindowButton
				local v94 = v_u_67(v_u_16, v91 - v_u_18)
				v93.Position = UDim2.fromOffset(v94.X, v94.Y)
				v_u_16.state.position.value = v94
			end
			if v_u_20 and (v_u_19 and v_u_19.arguments.NoResize ~= true) then
				local v95 = v_u_19.Instance.WindowButton
				local v96 = Vector2.new(v95.Position.X.Offset, v95.Position.Y.Offset)
				local v97 = Vector2.new(v95.Size.X.Offset, v95.Size.Y.Offset)
				local v98
				if p90.UserInputType == Enum.UserInputType.Touch then
					v98 = p90.Delta
				else
					v98 = p_u_2.getMouseLocation() - v_u_25
				end
				local v99 = v96 + Vector2.new(v_u_24 ~= Enum.LeftRight.Left and 0 or v98.X, v_u_23 ~= Enum.TopBottom.Top and 0 or v98.Y)
				local v100 = Vector2.new
				local v101
				if v_u_24 == Enum.LeftRight.Left then
					v101 = -v98.X
				else
					v101 = v_u_24 ~= Enum.LeftRight.Right and 0 or v98.X
				end
				local v102
				if v_u_23 == Enum.TopBottom.Top then
					v102 = -v98.Y
				else
					v102 = v_u_23 ~= Enum.TopBottom.Bottom and 0 or v98.Y
				end
				local v103 = v_u_49(v_u_19, v97 + v100(v101, v102))
				local v104 = v_u_67(v_u_19, v99)
				v95.Size = UDim2.fromOffset(v103.X, v103.Y)
				v_u_19.state.size.value = v103
				v95.Position = UDim2.fromOffset(v104.X, v104.Y)
				v_u_19.state.position.value = v104
			end
			v_u_25 = p_u_2.getMouseLocation()
		end
	end)
	p_u_2.registerEvent("InputEnded", function(p105, _)
		-- upvalues: (copy) p_u_1, (ref) v_u_17, (ref) v_u_16, (ref) v_u_20, (ref) v_u_19, (copy) v_u_33
		if p_u_1._started then
			if (p105.UserInputType == Enum.UserInputType.MouseButton1 or p105.UserInputType == Enum.UserInputType.Touch) and (v_u_17 and v_u_16) then
				local v106 = v_u_16.Instance.WindowButton
				v_u_17 = false
				v_u_16.state.position:set(Vector2.new(v106.Position.X.Offset, v106.Position.Y.Offset))
			end
			if (p105.UserInputType == Enum.UserInputType.MouseButton1 or p105.UserInputType == Enum.UserInputType.Touch) and (v_u_20 and v_u_19) then
				local v107 = v_u_19.Instance
				v_u_20 = false
				v_u_19.state.size:set(v107.WindowButton.AbsoluteSize)
			end
			if p105.KeyCode == Enum.KeyCode.ButtonX then
				v_u_33()
			end
		end
	end)
	local v108 = p_u_1.WidgetConstructor
	local v109 = {
		["hasState"] = true,
		["hasChildren"] = true,
		["Args"] = {
			["Title"] = 1,
			["NoTitleBar"] = 2,
			["NoBackground"] = 3,
			["NoCollapse"] = 4,
			["NoClose"] = 5,
			["NoMove"] = 6,
			["NoScrollbar"] = 7,
			["NoResize"] = 8,
			["NoNav"] = 9,
			["NoMenu"] = 10
		}
	}
	local v115 = {
		["closed"] = {
			["Init"] = function(_) end,
			["Get"] = function(p110)
				-- upvalues: (copy) p_u_1
				return p110.lastClosedTick == p_u_1._cycleTick
			end
		},
		["opened"] = {
			["Init"] = function(_) end,
			["Get"] = function(p111)
				-- upvalues: (copy) p_u_1
				return p111.lastOpenedTick == p_u_1._cycleTick
			end
		},
		["collapsed"] = {
			["Init"] = function(_) end,
			["Get"] = function(p112)
				-- upvalues: (copy) p_u_1
				return p112.lastCollapsedTick == p_u_1._cycleTick
			end
		},
		["uncollapsed"] = {
			["Init"] = function(_) end,
			["Get"] = function(p113)
				-- upvalues: (copy) p_u_1
				return p113.lastUncollapsedTick == p_u_1._cycleTick
			end
		},
		["hovered"] = p_u_2.EVENTS.hover(function(p114)
			return p114.Instance.WindowButton
		end)
	}
	v109.Events = v115
	function v109.Generate(p_u_116)
		-- upvalues: (copy) p_u_1, (copy) v_u_28, (copy) p_u_2, (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) v_u_27, (ref) v_u_26, (ref) v_u_20, (ref) v_u_23, (ref) v_u_24, (ref) v_u_19, (ref) v_u_21, (ref) v_u_22
		p_u_116.parentWidget = p_u_1._rootWidget
		p_u_116.usesScreenGuis = p_u_1._config.UseScreenGUIs
		v_u_28[p_u_116.ID] = p_u_116
		local v117
		if p_u_116.usesScreenGuis then
			v117 = Instance.new("ScreenGui")
			v117.ResetOnSpawn = false
			v117.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			v117.DisplayOrder = p_u_1._config.DisplayOrderOffset
			v117.IgnoreGuiInset = p_u_1._config.IgnoreGuiInset
		else
			v117 = Instance.new("Frame")
			v117.AnchorPoint = Vector2.new(0.5, 0.5)
			v117.Position = UDim2.new(0.5, 0, 0.5, 0)
			v117.Size = UDim2.new(1, 0, 1, 0)
			v117.BackgroundTransparency = 1
			v117.ZIndex = p_u_1._config.DisplayOrderOffset
		end
		v117.Name = "Iris_Window"
		local v118 = Instance.new("TextButton")
		v118.Name = "WindowButton"
		v118.Size = UDim2.fromOffset(0, 0)
		v118.BackgroundColor3 = p_u_1._config.MenubarBgColor
		v118.BackgroundTransparency = p_u_1._config.MenubarBgTransparency
		v118.BorderSizePixel = 0
		v118.Text = ""
		v118.ClipsDescendants = false
		v118.AutoButtonColor = false
		v118.Selectable = false
		v118.SelectionImageObject = p_u_1.SelectionImageObject
		v118.SelectionGroup = true
		v118.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
		v118.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
		v118.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
		v118.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
		p_u_2.UIStroke(v118, p_u_1._config.WindowBorderSize, p_u_1._config.BorderColor, p_u_1._config.BorderTransparency)
		v118.Parent = v117
		p_u_2.applyInputBegan(v118, function(p119)
			-- upvalues: (copy) p_u_116, (ref) p_u_1, (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) p_u_2
			if p119.UserInputType ~= Enum.UserInputType.MouseMovement and p119.UserInputType ~= Enum.UserInputType.Keyboard then
				if p_u_116.state.isUncollapsed.value then
					p_u_1.SetFocusedWindow(p_u_116)
				end
				if not p_u_116.arguments.NoMove and p119.UserInputType == Enum.UserInputType.MouseButton1 then
					v_u_16 = p_u_116
					v_u_17 = true
					v_u_18 = p_u_2.getMouseLocation() - p_u_116.state.position.value
				end
			end
		end)
		local v120 = Instance.new("Frame")
		v120.Name = "Content"
		v120.AnchorPoint = Vector2.new(0.5, 0.5)
		v120.Position = UDim2.fromScale(0.5, 0.5)
		v120.Size = UDim2.fromScale(1, 1)
		v120.BackgroundTransparency = 1
		v120.ClipsDescendants = true
		v120.Parent = v118
		local v121 = p_u_2.UIListLayout(v120, Enum.FillDirection.Vertical, UDim.new(0, 0))
		v121.HorizontalAlignment = Enum.HorizontalAlignment.Center
		v121.VerticalAlignment = Enum.VerticalAlignment.Top
		local v_u_122 = Instance.new("ScrollingFrame")
		v_u_122.Name = "WindowContainer"
		v_u_122.Size = UDim2.fromScale(1, 1)
		v_u_122.BackgroundColor3 = p_u_1._config.WindowBgColor
		v_u_122.BackgroundTransparency = p_u_1._config.WindowBgTransparency
		v_u_122.BorderSizePixel = 0
		v_u_122.AutomaticCanvasSize = Enum.AutomaticSize.Y
		v_u_122.ScrollBarImageTransparency = p_u_1._config.ScrollbarGrabTransparency
		v_u_122.ScrollBarImageColor3 = p_u_1._config.ScrollbarGrabColor
		v_u_122.CanvasSize = UDim2.fromScale(0, 0)
		v_u_122.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
		v_u_122.TopImage = p_u_2.ICONS.BLANK_SQUARE
		v_u_122.MidImage = p_u_2.ICONS.BLANK_SQUARE
		v_u_122.BottomImage = p_u_2.ICONS.BLANK_SQUARE
		v_u_122.LayoutOrder = p_u_116.ZIndex + 65535
		v_u_122.ClipsDescendants = true
		p_u_2.UIPadding(v_u_122, p_u_1._config.WindowPadding)
		v_u_122.Parent = v120
		local v123 = Instance.new("UIFlexItem")
		v123.FlexMode = Enum.UIFlexMode.Fill
		v123.ItemLineAlignment = Enum.ItemLineAlignment.End
		v123.Parent = v_u_122
		v_u_122:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
			-- upvalues: (copy) p_u_116, (copy) v_u_122
			p_u_116.state.scrollDistance.value = v_u_122.CanvasPosition.Y
		end)
		p_u_2.applyInputBegan(v_u_122, function(p124)
			-- upvalues: (copy) p_u_116, (ref) p_u_1
			if p124.UserInputType ~= Enum.UserInputType.MouseMovement and p124.UserInputType ~= Enum.UserInputType.Keyboard then
				if p_u_116.state.isUncollapsed.value then
					p_u_1.SetFocusedWindow(p_u_116)
				end
			end
		end)
		local v125 = Instance.new("Frame")
		v125.Name = "TerminatingFrame"
		v125.Size = UDim2.fromOffset(0, p_u_1._config.WindowPadding.Y + p_u_1._config.FramePadding.Y)
		v125.BackgroundTransparency = 1
		v125.BorderSizePixel = 0
		v125.LayoutOrder = 2147483632
		p_u_2.UIListLayout(v_u_122, Enum.FillDirection.Vertical, UDim.new(0, p_u_1._config.ItemSpacing.Y)).VerticalAlignment = Enum.VerticalAlignment.Top
		v125.Parent = v_u_122
		local v126 = Instance.new("Frame")
		v126.Name = "TitleBar"
		v126.AutomaticSize = Enum.AutomaticSize.Y
		v126.Size = UDim2.fromScale(1, 0)
		v126.BorderSizePixel = 0
		v126.ClipsDescendants = true
		v126.Parent = v120
		p_u_2.UIPadding(v126, Vector2.new(p_u_1._config.FramePadding.X))
		p_u_2.UIListLayout(v126, Enum.FillDirection.Horizontal, UDim.new(0, p_u_1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
		p_u_2.applyInputBegan(v126, function(p127)
			-- upvalues: (copy) p_u_116, (ref) v_u_16, (ref) v_u_17, (ref) v_u_18
			if p127.UserInputType == Enum.UserInputType.Touch and not p_u_116.arguments.NoMove then
				v_u_16 = p_u_116
				v_u_17 = true
				local v128 = p127.Position
				v_u_18 = Vector2.new(v128.X, v128.Y) - p_u_116.state.position.value
			end
		end)
		local v129 = p_u_1._config.TextSize + (p_u_1._config.FramePadding.Y - 1) * 2
		local v130 = Instance.new("TextButton")
		v130.Name = "CollapseButton"
		v130.AnchorPoint = Vector2.new(0, 0.5)
		v130.Size = UDim2.fromOffset(v129, v129)
		v130.Position = UDim2.new(0, 0, 0.5, 0)
		v130.AutomaticSize = Enum.AutomaticSize.None
		v130.BackgroundTransparency = 1
		v130.BorderSizePixel = 0
		v130.AutoButtonColor = false
		v130.Text = ""
		p_u_2.UICorner(v130)
		v130.Parent = v126
		p_u_2.applyButtonClick(v130, function()
			-- upvalues: (copy) p_u_116
			p_u_116.state.isUncollapsed:set(not p_u_116.state.isUncollapsed.value)
		end)
		p_u_2.applyInteractionHighlights("Background", v130, v130, {
			["Color"] = p_u_1._config.ButtonColor,
			["Transparency"] = 1,
			["HoveredColor"] = p_u_1._config.ButtonHoveredColor,
			["HoveredTransparency"] = p_u_1._config.ButtonHoveredTransparency,
			["ActiveColor"] = p_u_1._config.ButtonActiveColor,
			["ActiveTransparency"] = p_u_1._config.ButtonActiveTransparency
		})
		local v131 = Instance.new("ImageLabel")
		v131.Name = "Arrow"
		v131.AnchorPoint = Vector2.new(0.5, 0.5)
		local v132 = UDim2.fromOffset
		local v133 = v129 * 0.7
		local v134 = math.floor(v133)
		local v135 = v129 * 0.7
		v131.Size = v132(v134, (math.floor(v135)))
		v131.Position = UDim2.fromScale(0.5, 0.5)
		v131.BackgroundTransparency = 1
		v131.BorderSizePixel = 0
		v131.Image = p_u_2.ICONS.MULTIPLICATION_SIGN
		v131.ImageColor3 = p_u_1._config.TextColor
		v131.ImageTransparency = p_u_1._config.TextTransparency
		v131.Parent = v130
		local v136 = Instance.new("TextButton")
		v136.Name = "CloseButton"
		v136.AnchorPoint = Vector2.new(1, 0.5)
		v136.Size = UDim2.fromOffset(v129, v129)
		v136.Position = UDim2.new(1, 0, 0.5, 0)
		v136.AutomaticSize = Enum.AutomaticSize.None
		v136.BackgroundTransparency = 1
		v136.BorderSizePixel = 0
		v136.Text = ""
		v136.LayoutOrder = 2
		v136.AutoButtonColor = false
		p_u_2.UICorner(v136)
		p_u_2.applyButtonClick(v136, function()
			-- upvalues: (copy) p_u_116
			p_u_116.state.isOpened:set(false)
		end)
		p_u_2.applyInteractionHighlights("Background", v136, v136, {
			["Color"] = p_u_1._config.ButtonColor,
			["Transparency"] = 1,
			["HoveredColor"] = p_u_1._config.ButtonHoveredColor,
			["HoveredTransparency"] = p_u_1._config.ButtonHoveredTransparency,
			["ActiveColor"] = p_u_1._config.ButtonActiveColor,
			["ActiveTransparency"] = p_u_1._config.ButtonActiveTransparency
		})
		v136.Parent = v126
		local v137 = Instance.new("ImageLabel")
		v137.Name = "Icon"
		v137.AnchorPoint = Vector2.new(0.5, 0.5)
		local v138 = UDim2.fromOffset
		local v139 = v129 * 0.7
		local v140 = math.floor(v139)
		local v141 = v129 * 0.7
		v137.Size = v138(v140, (math.floor(v141)))
		v137.Position = UDim2.fromScale(0.5, 0.5)
		v137.BackgroundTransparency = 1
		v137.BorderSizePixel = 0
		v137.Image = p_u_2.ICONS.MULTIPLICATION_SIGN
		v137.ImageColor3 = p_u_1._config.TextColor
		v137.ImageTransparency = p_u_1._config.TextTransparency
		v137.Parent = v136
		local v142 = Instance.new("TextLabel")
		v142.Name = "Title"
		v142.AutomaticSize = Enum.AutomaticSize.XY
		v142.BorderSizePixel = 0
		v142.BackgroundTransparency = 1
		v142.LayoutOrder = 1
		v142.ClipsDescendants = true
		p_u_2.UIPadding(v142, Vector2.new(0, p_u_1._config.FramePadding.Y))
		p_u_2.applyTextStyle(v142)
		v142.TextXAlignment = Enum.TextXAlignment[p_u_1._config.WindowTitleAlign.Name]
		local v143 = Instance.new("UIFlexItem")
		v143.FlexMode = Enum.UIFlexMode.Fill
		v143.ItemLineAlignment = Enum.ItemLineAlignment.Center
		v143.Parent = v142
		v142.Parent = v126
		local v144 = p_u_1._config.TextSize + p_u_1._config.FramePadding.X
		local v145 = Instance.new("ImageButton")
		v145.Name = "LeftResizeGrip"
		v145.AnchorPoint = Vector2.yAxis
		v145.Rotation = 180
		v145.Size = UDim2.fromOffset(v144, v144)
		v145.Position = UDim2.fromScale(0, 1)
		v145.BackgroundTransparency = 1
		v145.BorderSizePixel = 0
		v145.Image = p_u_2.ICONS.BOTTOM_RIGHT_CORNER
		v145.ImageColor3 = p_u_1._config.ResizeGripColor
		v145.ImageTransparency = 1
		v145.AutoButtonColor = false
		v145.ZIndex = 3
		v145.Parent = v118
		p_u_2.applyInteractionHighlights("Image", v145, v145, {
			["Color"] = p_u_1._config.ResizeGripColor,
			["Transparency"] = 1,
			["HoveredColor"] = p_u_1._config.ResizeGripHoveredColor,
			["HoveredTransparency"] = p_u_1._config.ResizeGripHoveredTransparency,
			["ActiveColor"] = p_u_1._config.ResizeGripActiveColor,
			["ActiveTransparency"] = p_u_1._config.ResizeGripActiveTransparency
		})
		p_u_2.applyButtonDown(v145, function()
			-- upvalues: (ref) v_u_27, (ref) v_u_26, (copy) p_u_116, (ref) p_u_1, (ref) v_u_20, (ref) v_u_23, (ref) v_u_24, (ref) v_u_19
			if not v_u_27 or v_u_26 ~= p_u_116 then
				p_u_1.SetFocusedWindow(p_u_116)
			end
			v_u_20 = true
			v_u_23 = Enum.TopBottom.Bottom
			v_u_24 = Enum.LeftRight.Left
			v_u_19 = p_u_116
		end)
		local v146 = Instance.new("ImageButton")
		v146.Name = "RightResizeGrip"
		v146.AnchorPoint = Vector2.one
		v146.Rotation = 90
		v146.Size = UDim2.fromOffset(v144, v144)
		v146.Position = UDim2.fromScale(1, 1)
		v146.BackgroundTransparency = 1
		v146.BorderSizePixel = 0
		v146.Image = p_u_2.ICONS.BOTTOM_RIGHT_CORNER
		v146.ImageColor3 = p_u_1._config.ResizeGripColor
		v146.ImageTransparency = p_u_1._config.ResizeGripTransparency
		v146.AutoButtonColor = false
		v146.ZIndex = 3
		v146.Parent = v118
		p_u_2.applyInteractionHighlights("Image", v146, v146, {
			["Color"] = p_u_1._config.ResizeGripColor,
			["Transparency"] = p_u_1._config.ResizeGripTransparency,
			["HoveredColor"] = p_u_1._config.ResizeGripHoveredColor,
			["HoveredTransparency"] = p_u_1._config.ResizeGripHoveredTransparency,
			["ActiveColor"] = p_u_1._config.ResizeGripActiveColor,
			["ActiveTransparency"] = p_u_1._config.ResizeGripActiveTransparency
		})
		p_u_2.applyButtonDown(v146, function()
			-- upvalues: (ref) v_u_27, (ref) v_u_26, (copy) p_u_116, (ref) p_u_1, (ref) v_u_20, (ref) v_u_23, (ref) v_u_24, (ref) v_u_19
			if not v_u_27 or v_u_26 ~= p_u_116 then
				p_u_1.SetFocusedWindow(p_u_116)
			end
			v_u_20 = true
			v_u_23 = Enum.TopBottom.Bottom
			v_u_24 = Enum.LeftRight.Right
			v_u_19 = p_u_116
		end)
		local v147 = Instance.new("ImageButton")
		v147.Name = "LeftResizeBorder"
		v147.AnchorPoint = Vector2.new(1, 0.5)
		v147.Position = UDim2.fromScale(0, 0.5)
		v147.Size = UDim2.new(0, p_u_1._config.WindowResizePadding.X, 1, 2 * p_u_1._config.WindowBorderSize)
		v147.Transparency = 1
		v147.Image = p_u_2.ICONS.BORDER
		v147.ResampleMode = Enum.ResamplerMode.Pixelated
		v147.ScaleType = Enum.ScaleType.Slice
		v147.SliceCenter = Rect.new(0, 0, 1, 1)
		v147.ImageRectOffset = Vector2.new(2, 2)
		v147.ImageRectSize = Vector2.new(2, 1)
		v147.ImageTransparency = 1
		v147.ZIndex = 4
		v147.AutoButtonColor = false
		v147.Parent = v118
		local v148 = Instance.new("ImageButton")
		v148.Name = "RightResizeBorder"
		v148.AnchorPoint = Vector2.new(0, 0.5)
		v148.Position = UDim2.fromScale(1, 0.5)
		v148.Size = UDim2.new(0, p_u_1._config.WindowResizePadding.X, 1, 2 * p_u_1._config.WindowBorderSize)
		v148.Transparency = 1
		v148.Image = p_u_2.ICONS.BORDER
		v148.ResampleMode = Enum.ResamplerMode.Pixelated
		v148.ScaleType = Enum.ScaleType.Slice
		v148.SliceCenter = Rect.new(1, 0, 2, 1)
		v148.ImageRectOffset = Vector2.new(1, 2)
		v148.ImageRectSize = Vector2.new(2, 1)
		v148.ImageTransparency = 1
		v148.ZIndex = 4
		v148.AutoButtonColor = false
		v148.Parent = v118
		local v149 = Instance.new("ImageButton")
		v149.Name = "TopResizeBorder"
		v149.AnchorPoint = Vector2.new(0.5, 1)
		v149.Position = UDim2.fromScale(0.5, 0)
		v149.Size = UDim2.new(1, 2 * p_u_1._config.WindowBorderSize, 0, p_u_1._config.WindowResizePadding.Y)
		v149.Transparency = 1
		v149.Image = p_u_2.ICONS.BORDER
		v149.ResampleMode = Enum.ResamplerMode.Pixelated
		v149.ScaleType = Enum.ScaleType.Slice
		v149.SliceCenter = Rect.new(0, 0, 1, 1)
		v149.ImageRectOffset = Vector2.new(2, 2)
		v149.ImageRectSize = Vector2.new(1, 2)
		v149.ImageTransparency = 1
		v149.ZIndex = 4
		v149.AutoButtonColor = false
		v149.Parent = v118
		local v150 = Instance.new("ImageButton")
		v150.Name = "BottomResizeBorder"
		v150.AnchorPoint = Vector2.new(0.5, 0)
		v150.Position = UDim2.fromScale(0.5, 1)
		v150.Size = UDim2.new(1, 2 * p_u_1._config.WindowBorderSize, 0, p_u_1._config.WindowResizePadding.Y)
		v150.Transparency = 1
		v150.Image = p_u_2.ICONS.BORDER
		v150.ResampleMode = Enum.ResamplerMode.Pixelated
		v150.ScaleType = Enum.ScaleType.Slice
		v150.SliceCenter = Rect.new(0, 1, 1, 2)
		v150.ImageRectOffset = Vector2.new(2, 1)
		v150.ImageRectSize = Vector2.new(1, 2)
		v150.ImageTransparency = 1
		v150.ZIndex = 4
		v150.AutoButtonColor = false
		v150.Parent = v118
		p_u_2.applyInteractionHighlights("Image", v147, v147, {
			["Color"] = p_u_1._config.ResizeGripColor,
			["Transparency"] = 1,
			["HoveredColor"] = p_u_1._config.ResizeGripHoveredColor,
			["HoveredTransparency"] = p_u_1._config.ResizeGripHoveredTransparency,
			["ActiveColor"] = p_u_1._config.ResizeGripActiveColor,
			["ActiveTransparency"] = p_u_1._config.ResizeGripActiveTransparency
		})
		p_u_2.applyInteractionHighlights("Image", v148, v148, {
			["Color"] = p_u_1._config.ResizeGripColor,
			["Transparency"] = 1,
			["HoveredColor"] = p_u_1._config.ResizeGripHoveredColor,
			["HoveredTransparency"] = p_u_1._config.ResizeGripHoveredTransparency,
			["ActiveColor"] = p_u_1._config.ResizeGripActiveColor,
			["ActiveTransparency"] = p_u_1._config.ResizeGripActiveTransparency
		})
		p_u_2.applyInteractionHighlights("Image", v149, v149, {
			["Color"] = p_u_1._config.ResizeGripColor,
			["Transparency"] = 1,
			["HoveredColor"] = p_u_1._config.ResizeGripHoveredColor,
			["HoveredTransparency"] = p_u_1._config.ResizeGripHoveredTransparency,
			["ActiveColor"] = p_u_1._config.ResizeGripActiveColor,
			["ActiveTransparency"] = p_u_1._config.ResizeGripActiveTransparency
		})
		p_u_2.applyInteractionHighlights("Image", v150, v150, {
			["Color"] = p_u_1._config.ResizeGripColor,
			["Transparency"] = 1,
			["HoveredColor"] = p_u_1._config.ResizeGripHoveredColor,
			["HoveredTransparency"] = p_u_1._config.ResizeGripHoveredTransparency,
			["ActiveColor"] = p_u_1._config.ResizeGripActiveColor,
			["ActiveTransparency"] = p_u_1._config.ResizeGripActiveTransparency
		})
		local v151 = Instance.new("Frame")
		v151.Name = "ResizeBorder"
		v151.Size = UDim2.new(1, p_u_1._config.WindowResizePadding.X * 2, 1, p_u_1._config.WindowResizePadding.Y * 2)
		v151.Position = UDim2.fromOffset(-p_u_1._config.WindowResizePadding.X, -p_u_1._config.WindowResizePadding.Y)
		v151.BackgroundTransparency = 1
		v151.BorderSizePixel = 0
		v151.Active = false
		v151.Selectable = false
		v151.ClipsDescendants = false
		v151.Parent = v118
		p_u_2.applyMouseEnter(v151, function()
			-- upvalues: (ref) v_u_26, (copy) p_u_116, (ref) v_u_21
			if v_u_26 == p_u_116 then
				v_u_21 = true
			end
		end)
		p_u_2.applyMouseLeave(v151, function()
			-- upvalues: (ref) v_u_26, (copy) p_u_116, (ref) v_u_21
			if v_u_26 == p_u_116 then
				v_u_21 = false
			end
		end)
		p_u_2.applyInputBegan(v151, function(p152)
			-- upvalues: (copy) p_u_116, (ref) p_u_1
			if p152.UserInputType ~= Enum.UserInputType.MouseMovement and p152.UserInputType ~= Enum.UserInputType.Keyboard then
				if p_u_116.state.isUncollapsed.value then
					p_u_1.SetFocusedWindow(p_u_116)
				end
			end
		end)
		p_u_2.applyMouseEnter(v118, function()
			-- upvalues: (ref) v_u_26, (copy) p_u_116, (ref) v_u_22
			if v_u_26 == p_u_116 then
				v_u_22 = true
			end
		end)
		p_u_2.applyMouseLeave(v118, function()
			-- upvalues: (ref) v_u_26, (copy) p_u_116, (ref) v_u_22
			if v_u_26 == p_u_116 then
				v_u_22 = false
			end
		end)
		p_u_116.ChildContainer = v_u_122
		return v117
	end
	function v109.Update(p153)
		-- upvalues: (copy) p_u_1
		local v154 = p153.Instance
		local v155 = p153.ChildContainer
		local v156 = v154.WindowButton
		local v157 = v156.Content
		local v158 = v157.TitleBar
		local v159 = v158.Title
		local v160 = v157:FindFirstChild("Iris_MenuBar")
		local v161 = v156.LeftResizeGrip
		local v162 = v156.RightResizeGrip
		local v163 = v156.LeftResizeBorder
		local v164 = v156.RightResizeBorder
		local v165 = v156.TopResizeBorder
		local v166 = v156.BottomResizeBorder
		if p153.arguments.NoResize == true then
			v161.Visible = false
			v162.Visible = false
			v163.Visible = false
			v164.Visible = false
			v165.Visible = false
			v166.Visible = false
		else
			v161.Visible = true
			v162.Visible = true
			v163.Visible = true
			v164.Visible = true
			v165.Visible = true
			v166.Visible = true
		end
		if p153.arguments.NoScrollbar then
			v155.ScrollBarThickness = 0
		else
			v155.ScrollBarThickness = p_u_1._config.ScrollbarSize
		end
		if p153.arguments.NoTitleBar then
			v158.Visible = false
		else
			v158.Visible = true
		end
		if v160 then
			if p153.arguments.NoMenu then
				v160.Visible = false
			else
				v160.Visible = true
			end
		end
		if p153.arguments.NoBackground then
			v155.BackgroundTransparency = 1
		else
			v155.BackgroundTransparency = p_u_1._config.WindowBgTransparency
		end
		if p153.arguments.NoCollapse then
			v158.CollapseButton.Visible = false
		else
			v158.CollapseButton.Visible = true
		end
		if p153.arguments.NoClose then
			v158.CloseButton.Visible = false
		else
			v158.CloseButton.Visible = true
		end
		v159.Text = p153.arguments.Title or ""
	end
	function v109.Discard(p167)
		-- upvalues: (ref) v_u_26, (ref) v_u_27, (ref) v_u_16, (ref) v_u_17, (ref) v_u_19, (ref) v_u_20, (copy) v_u_28, (copy) p_u_2
		if v_u_26 == p167 then
			v_u_26 = nil
			v_u_27 = false
		end
		if v_u_16 == p167 then
			v_u_16 = nil
			v_u_17 = false
		end
		if v_u_19 == p167 then
			v_u_19 = nil
			v_u_20 = false
		end
		v_u_28[p167.ID] = nil
		p167.Instance:Destroy()
		p_u_2.discardState(p167)
	end
	function v109.ChildAdded(p168, p169)
		local v170 = p168.Instance.WindowButton.Content
		if p169.type ~= "MenuBar" then
			return p168.ChildContainer
		end
		local v171 = p168.ChildContainer
		p169.Instance.ZIndex = v171.ZIndex + 1
		p169.Instance.LayoutOrder = v171.LayoutOrder - 1
		return v170
	end
	function v109.UpdateState(p_u_172)
		-- upvalues: (copy) p_u_1, (copy) p_u_2
		local v173 = p_u_172.state.size.value
		local v174 = p_u_172.state.position.value
		local v175 = p_u_172.state.isUncollapsed.value
		local v176 = p_u_172.state.isOpened.value
		local v_u_177 = p_u_172.state.scrollDistance.value
		local v178 = p_u_172.Instance
		local v_u_179 = p_u_172.ChildContainer
		local v180 = v178.WindowButton
		local v181 = v180.Content
		local v182 = v181.TitleBar
		local v183 = v181:FindFirstChild("Iris_MenuBar")
		local v184 = v180.LeftResizeGrip
		local v185 = v180.RightResizeGrip
		local v186 = v180.LeftResizeBorder
		local v187 = v180.RightResizeBorder
		local v188 = v180.TopResizeBorder
		local v189 = v180.BottomResizeBorder
		v180.Size = UDim2.fromOffset(v173.X, v173.Y)
		v180.Position = UDim2.fromOffset(v174.X, v174.Y)
		if v176 then
			if p_u_172.usesScreenGuis then
				v178.Enabled = true
				v180.Visible = true
			else
				v178.Visible = true
				v180.Visible = true
			end
			p_u_172.lastOpenedTick = p_u_1._cycleTick + 1
		else
			if p_u_172.usesScreenGuis then
				v178.Enabled = false
				v180.Visible = false
			else
				v178.Visible = false
				v180.Visible = false
			end
			p_u_172.lastClosedTick = p_u_1._cycleTick + 1
		end
		if v175 then
			v182.CollapseButton.Arrow.Image = p_u_2.ICONS.DOWN_POINTING_TRIANGLE
			if v183 then
				v183.Visible = not p_u_172.arguments.NoMenu
			end
			v_u_179.Visible = true
			if p_u_172.arguments.NoResize ~= true then
				v184.Visible = true
				v185.Visible = true
				v186.Visible = true
				v187.Visible = true
				v188.Visible = true
				v189.Visible = true
			end
			v180.AutomaticSize = Enum.AutomaticSize.None
			p_u_172.lastUncollapsedTick = p_u_1._cycleTick + 1
		else
			local v190 = v182.AbsoluteSize.Y
			v182.CollapseButton.Arrow.Image = p_u_2.ICONS.RIGHT_POINTING_TRIANGLE
			if v183 then
				v183.Visible = false
			end
			v_u_179.Visible = false
			v184.Visible = false
			v185.Visible = false
			v186.Visible = false
			v187.Visible = false
			v188.Visible = false
			v189.Visible = false
			v180.Size = UDim2.fromOffset(v173.X, v190)
			p_u_172.lastCollapsedTick = p_u_1._cycleTick + 1
		end
		if v176 and v175 then
			p_u_1.SetFocusedWindow(p_u_172)
		else
			v182.BackgroundColor3 = p_u_1._config.TitleBgCollapsedColor
			v182.BackgroundTransparency = p_u_1._config.TitleBgCollapsedTransparency
			v180.UIStroke.Color = p_u_1._config.BorderColor
			p_u_1.SetFocusedWindow(nil)
		end
		if v_u_177 and v_u_177 ~= 0 then
			local v_u_191 = #p_u_1._postCycleCallbacks + 1
			local v_u_192 = p_u_1._cycleTick + 1
			p_u_1._postCycleCallbacks[v_u_191] = function()
				-- upvalues: (ref) p_u_1, (copy) v_u_192, (copy) p_u_172, (copy) v_u_179, (copy) v_u_177, (copy) v_u_191
				if v_u_192 <= p_u_1._cycleTick then
					if p_u_172.lastCycleTick ~= -1 then
						v_u_179.CanvasPosition = Vector2.new(0, v_u_177)
					end
					p_u_1._postCycleCallbacks[v_u_191] = nil
				end
			end
		end
	end
	function v109.GenerateState(p193)
		-- upvalues: (copy) p_u_1, (ref) v_u_27, (ref) v_u_26, (copy) v_u_67, (copy) v_u_49
		if p193.state.size == nil then
			p193.state.size = p_u_1._widgetState(p193, "size", Vector2.new(400, 300))
		end
		if p193.state.position == nil then
			local v194 = p193.state
			local v195 = p_u_1._widgetState
			local v196 = "position"
			local v197
			if v_u_27 and v_u_26 then
				v197 = v_u_26.state.position.value + Vector2.new(15, 45)
			else
				v197 = Vector2.new(150, 250)
			end
			v194.position = v195(p193, v196, v197)
		end
		p193.state.position.value = v_u_67(p193, p193.state.position.value)
		p193.state.size.value = v_u_49(p193, p193.state.size.value)
		if p193.state.isUncollapsed == nil then
			p193.state.isUncollapsed = p_u_1._widgetState(p193, "isUncollapsed", true)
		end
		if p193.state.isOpened == nil then
			p193.state.isOpened = p_u_1._widgetState(p193, "isOpened", true)
		end
		if p193.state.scrollDistance == nil then
			p193.state.scrollDistance = p_u_1._widgetState(p193, "scrollDistance", 0)
		end
	end
	v108("Window", v109)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Window]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item></Item><Item class="Folder" referent="3471"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[sah31m_sift@0.0.9]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3472"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Types)
local v1 = {
	["Array"] = require(script.Array),
	["Dictionary"] = require(script.Dictionary),
	["Set"] = require(script.Set),
	["None"] = require(script.None),
	["Types"] = require(script.Types),
	["equalObjects"] = require(script.Util.equalObjects),
	["isEmpty"] = require(script.Util.isEmpty)
}
v1.List = v1.Array
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[sift]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3473"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["at"] = require(script.at),
	["concat"] = require(script.concat),
	["concatDeep"] = require(script.concatDeep),
	["copy"] = require(script.copy),
	["copyDeep"] = require(script.copyDeep),
	["count"] = require(script.count),
	["create"] = require(script.create),
	["difference"] = require(script.difference),
	["differenceSymmetric"] = require(script.differenceSymmetric),
	["equals"] = require(script.equals),
	["equalsDeep"] = require(script.equalsDeep),
	["every"] = require(script.every),
	["filter"] = require(script.filter),
	["find"] = require(script.find),
	["findLast"] = require(script.findLast),
	["findWhere"] = require(script.findWhere),
	["findWhereLast"] = require(script.findWhereLast),
	["first"] = require(script.first),
	["flatten"] = require(script.flatten),
	["freeze"] = require(script.freeze),
	["freezeDeep"] = require(script.freezeDeep),
	["includes"] = require(script.includes),
	["insert"] = require(script.insert),
	["is"] = require(script.is),
	["last"] = require(script.last),
	["map"] = require(script.map),
	["pop"] = require(script.pop),
	["push"] = require(script.push),
	["reduce"] = require(script.reduce),
	["reduceRight"] = require(script.reduceRight),
	["removeIndex"] = require(script.removeIndex),
	["removeIndices"] = require(script.removeIndices),
	["removeValue"] = require(script.removeValue),
	["removeValues"] = require(script.removeValues),
	["reverse"] = require(script.reverse),
	["set"] = require(script.set),
	["shift"] = require(script.shift),
	["shuffle"] = require(script.shuffle),
	["slice"] = require(script.slice),
	["some"] = require(script.some),
	["sort"] = require(script.sort),
	["splice"] = require(script.splice),
	["toSet"] = require(script.toSet),
	["unshift"] = require(script.unshift),
	["update"] = require(script.update),
	["zip"] = require(script.zip),
	["zipAll"] = require(script.zipAll)
}
v1.join = v1.concat
v1.merge = v1.concat
v1.joinDeep = v1.concatDeep
v1.mergeDeep = v1.concatDeep
v1.append = v1.push
v1.prepend = v1.unshift
v1.indexOf = v1.find
v1.has = v1.includes
v1.contains = v1.includes
v1.isArray = v1.is
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Array]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3474"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	local v3 = #p1
	if p2 < 1 then
		p2 = p2 + v3
	end
	return p1[p2]
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[at]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3475"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.None)
return function(...)
	-- upvalues: (copy) v_u_2
	local v3 = {}
	for v4 = 1, select("#", ...) do
		local v5 = select(v4, ...)
		if type(v5) == "table" then
			for _, v6 in ipairs(v5) do
				if v6 ~= v_u_2 then
					table.insert(v3, v6)
				end
			end
		end
	end
	return v3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[concat]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3476"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(script.Parent.copyDeep)
local v_u_3 = require(v1.None)
return function(...)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v4 = {}
	for v5 = 1, select("#", ...) do
		local v6 = select(v5, ...)
		if type(v6) == "table" then
			for _, v7 in ipairs(v6) do
				if v7 ~= v_u_3 then
					if type(v7) == "table" then
						local v8 = v_u_2
						table.insert(v4, v8(v7))
					else
						table.insert(v4, v7)
					end
				end
			end
		end
	end
	return v4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[concatDeep]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3477"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return table.clone]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[copy]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3478"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local function v_u_5(p1)
	-- upvalues: (copy) v_u_5
	local v2 = table.clone(p1)
	for v3, v4 in p1 do
		if type(v4) == "table" then
			v2[v3] = v_u_5(v4)
		end
	end
	return v2
end
return v_u_5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[copyDeep]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3479"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.Util)
return function(p3, p4)
	-- upvalues: (copy) v_u_2
	local v5 = 0
	if type(p4) ~= "function" then
		p4 = v_u_2.func.truthy
	end
	for v6, v7 in ipairs(p3) do
		if p4(v7, v6, p3) then
			v5 = v5 + 1
		end
	end
	return v5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[count]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3480"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return table.create]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[create]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3481"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
local v_u_1 = require(script.Parent.toSet)
local v_u_2 = require(script.Parent.Parent.Set.toArray)
local v_u_3 = require(script.Parent.Parent.Set.difference)
return function(p4, ...)
	-- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_2
	local v5 = v_u_1(p4)
	local v6 = {}
	for _, v7 in { ... } do
		if typeof(v7) == "table" then
			local v8 = v_u_1
			table.insert(v6, v8(v7))
		end
	end
	return v_u_2((v_u_3(v5, unpack(v6))))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[difference]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3482"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
local v_u_1 = require(script.Parent.toSet)
local v_u_2 = require(script.Parent.Parent.Set.toArray)
local v_u_3 = require(script.Parent.Parent.Set.differenceSymmetric)
return function(p4, ...)
	-- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_2
	local v5 = v_u_1(p4)
	local v6 = {}
	for _, v7 in { ... } do
		if typeof(v7) == "table" then
			local v8 = v_u_1
			table.insert(v6, v8(v7))
		end
	end
	return v_u_2((v_u_3(v5, unpack(v6))))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[differenceSymmetric]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3483"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.Util)
local function v_u_7(p3, p4)
	if type(p3) ~= "table" or type(p4) ~= "table" then
		return p3 == p4
	end
	local v5 = #p3
	if #p4 ~= v5 then
		return false
	end
	for v6 = 1, v5 do
		if p3[v6] ~= p4[v6] then
			return false
		end
	end
	return true
end
return function(...)
	-- upvalues: (copy) v_u_2, (copy) v_u_7
	if v_u_2.equalObjects(...) then
		return true
	end
	local v8 = select("#", ...)
	local v9 = select(1, ...)
	for v10 = 2, v8 do
		if not v_u_7(v9, (select(v10, ...))) then
			return false
		end
	end
	return true
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[equals]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3484"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.Util)
local function v_u_7(p3, p4)
	-- upvalues: (copy) v_u_7
	if type(p3) ~= "table" or type(p4) ~= "table" then
		return p3 == p4
	end
	local v5 = #p3
	if #p4 ~= v5 then
		return false
	end
	for v6 = 1, v5 do
		if not v_u_7(p3[v6], p4[v6]) then
			return false
		end
	end
	return true
end
return function(...)
	-- upvalues: (copy) v_u_2, (copy) v_u_7
	if v_u_2.equalObjects(...) then
		return true
	end
	local v8 = select("#", ...)
	local v9 = select(1, ...)
	for v10 = 2, v8 do
		if not v_u_7(v9, (select(v10, ...))) then
			return false
		end
	end
	return true
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[equalsDeep]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3485"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	for v3, v4 in ipairs(p1) do
		if not p2(v4, v3, p1) then
			return false
		end
	end
	return true
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[every]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3486"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.Util)
return function(p3, p4)
	-- upvalues: (copy) v_u_2
	local v5 = {}
	if type(p4) ~= "function" then
		p4 = v_u_2.func.truthy
	end
	for v6, v7 in ipairs(p3) do
		if p4(v7, v6, p3) then
			table.insert(v5, v7)
		end
	end
	return v5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[filter]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3487"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2, p3)
	local v4 = #p1
	if type(p3) == "number" then
		if p3 < 1 then
			p3 = v4 + p3
		end
	else
		p3 = 1
	end
	return table.find(p1, p2, p3)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[find]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3488"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2, p3)
	local v4 = #p1
	if type(p3) == "number" then
		if p3 < 1 then
			p3 = v4 + p3
		end
	else
		p3 = v4
	end
	for v5 = p3, 1, -1 do
		if p1[v5] == p2 then
			return v5
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[findLast]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3489"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2, p3)
	local v4 = #p1
	if type(p3) == "number" then
		if p3 < 1 then
			p3 = v4 + p3
		end
	else
		p3 = 1
	end
	for v5 = p3, #p1 do
		if p2(p1[v5], v5, p1) then
			return v5
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[findWhere]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3490"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2, p3)
	local v4 = #p1
	if type(p3) == "number" then
		if p3 < 1 then
			p3 = v4 + p3
		end
	else
		p3 = v4
	end
	for v5 = p3, 1, -1 do
		if p2(p1[v5], v5, p1) then
			return v5
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[findWhereLast]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3491"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.at)
return function(p2)
	-- upvalues: (copy) v_u_1
	return v_u_1(p2, 1)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[first]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3492"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local function v_u_8(p1, p2)
	-- upvalues: (copy) v_u_8
	local v3 = type(p2) ~= "number" and (1 / 0) or p2
	local v4 = {}
	for _, v5 in ipairs(p1) do
		if type(v5) == "table" and v3 > 0 then
			local v6 = v_u_8(v5, v3 - 1)
			for _, v7 in ipairs(v6) do
				table.insert(v4, v7)
			end
		else
			table.insert(v4, v5)
		end
	end
	return v4
end
return v_u_8]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[flatten]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3493"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.copy)
return function(p2)
	-- upvalues: (copy) v_u_1
	local v3 = v_u_1(p2)
	table.freeze(v3)
	return v3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[freeze]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3494"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local function v_u_6(p1)
	-- upvalues: (copy) v_u_6
	local v2 = {}
	for v3 = 1, #p1 do
		local v4 = p1[v3]
		if type(v4) == "table" then
			local v5 = v_u_6
			table.insert(v2, v5(v4))
		else
			table.insert(v2, v4)
		end
	end
	table.freeze(v2)
	return v2
end
return v_u_6]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[freezeDeep]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3495"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.find)
return function(p2, p3, p4)
	-- upvalues: (copy) v_u_1
	return v_u_1(p2, p3, p4) ~= nil
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[includes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3496"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2, ...)
	local v3 = #p1
	if p2 < 1 then
		p2 = p2 + (v3 + 1)
	end
	if v3 < p2 then
		if v3 + 1 < p2 then
			return p1
		end
		p2 = v3 + 1
		v3 = v3 + 1
	end
	local v4 = {}
	for v5 = 1, v3 do
		if v5 == p2 then
			for _, v6 in ipairs({ ... }) do
				table.insert(v4, v6)
			end
		end
		local v7 = p1[v5]
		table.insert(v4, v7)
	end
	return v4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[insert]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3497"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	local v2
	if typeof(p1) == "table" and #p1 > 0 then
		v2 = next(p1, #p1) == nil
	else
		v2 = false
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[is]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3498"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.at)
return function(p2)
	-- upvalues: (copy) v_u_1
	return v_u_1(p2, 0)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[last]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3499"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	local v3 = {}
	for v4, v5 in ipairs(p1) do
		local v6 = p2(v5, v4, p1)
		if v6 ~= nil then
			table.insert(v3, v6)
		end
	end
	return v3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[map]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3500"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	local v3 = {}
	for v4 = 1, #p1 - (type(p2) ~= "number" and 1 or p2) do
		local v5 = p1[v4]
		table.insert(v3, v5)
	end
	return v3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[pop]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3501"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, ...)
	local v2 = {}
	for _, v3 in ipairs(p1) do
		table.insert(v2, v3)
	end
	for _, v4 in ipairs({ ... }) do
		table.insert(v2, v4)
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[push]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3502"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2, p3)
	local v4
	if p3 == nil then
		p3 = p1[1]
		v4 = 2
	else
		v4 = 1
	end
	for v5 = v4, #p1 do
		p3 = p2(p3, p1[v5], v5, p1)
	end
	return p3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[reduce]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3503"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2, p3)
	local v4 = #p1
	if p3 == nil then
		p3 = p1[v4]
		v4 = v4 - 1
	end
	for v5 = v4, 1, -1 do
		p3 = p2(p3, p1[v5], v5, p1)
	end
	return p3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[reduceRight]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3504"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	local v3 = #p1
	local v4 = {}
	if p2 < 1 then
		p2 = p2 + v3
	end
	for v5, v6 in ipairs(p1) do
		if v5 ~= p2 then
			table.insert(v4, v6)
		end
	end
	return v4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[removeIndex]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3505"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, ...)
	local v2 = #p1
	local v3 = {}
	local v4 = {}
	for _, v6 in ipairs({ ... }) do
		if v6 < 1 then
			local v6 = v6 + v2
		end
		v3[v6] = true
	end
	for v7, v8 in ipairs(p1) do
		if not v3[v7] then
			table.insert(v4, v8)
		end
	end
	return v4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[removeIndices]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3506"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	local v3 = {}
	for _, v4 in ipairs(p1) do
		if v4 ~= p2 then
			table.insert(v3, v4)
		end
	end
	return v3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[removeValue]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3507"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.toSet)
return function(p2, ...)
	-- upvalues: (copy) v_u_1
	local v3 = v_u_1({ ... })
	local v4 = {}
	for _, v5 in ipairs(p2) do
		if not v3[v5] then
			table.insert(v4, v5)
		end
	end
	return v4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[removeValues]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3508"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	local v2 = {}
	for v3 = #p1, 1, -1 do
		local v4 = p1[v3]
		table.insert(v2, v4)
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[reverse]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3509"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2, p3)
	local v4 = #p1
	local v5 = {}
	if p2 < 1 then
		p2 = p2 + v4
	end
	for v6, v7 in ipairs(p1) do
		if v6 == p2 then
			table.insert(v5, p3)
		else
			table.insert(v5, v7)
		end
	end
	return v5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[set]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3510"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	local v3 = #p1
	local v4 = {}
	for v5 = type(p2) ~= "number" and 2 or p2 + 1, v3 do
		local v6 = p1[v5]
		table.insert(v4, v6)
	end
	return v4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[shift]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3511"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.copy)
return function(p2)
	-- upvalues: (copy) v_u_1
	local v3 = Random.new(os.time() * #p2)
	local v4 = v_u_1(p2)
	for v5 = #v4, 1, -1 do
		local v6 = v3:NextInteger(1, v5)
		local v7 = v4[v5]
		v4[v5] = v4[v6]
		v4[v6] = v7
	end
	return v4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[shuffle]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3512"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2, p3)
	local v4 = #p1
	local v5 = {}
	local v6 = type(p2) ~= "number" and 1 or p2
	if type(p3) ~= "number" then
		p3 = v4
	end
	if v6 < 1 then
		v6 = v6 + v4
	end
	if p3 < 1 then
		p3 = p3 + v4
	end
	for v7 = v6, p3 do
		local v8 = p1[v7]
		table.insert(v5, v8)
	end
	return v5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[slice]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3513"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	for v3, v4 in ipairs(p1) do
		if p2(v4, v3, p1) then
			return true
		end
	end
	return false
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[some]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3514"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.copy)
return function(p2, p3)
	-- upvalues: (copy) v_u_1
	local v4 = v_u_1(p2)
	table.sort(v4, p3)
	return v4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[sort]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3515"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2, p3, ...)
	local v4 = #p1
	local v5 = {}
	local v6 = type(p2) ~= "number" and 1 or p2
	if type(p3) ~= "number" then
		p3 = v4
	end
	if v6 < 1 then
		v6 = v6 + v4
	end
	if p3 < 1 then
		p3 = p3 + v4
	end
	for v7 = 1, v6 - 1 do
		local v8 = p1[v7]
		table.insert(v5, v8)
	end
	for _, v9 in ipairs({ ... }) do
		table.insert(v5, v9)
	end
	for v10 = p3 + 1, v4 do
		local v11 = p1[v10]
		table.insert(v5, v11)
	end
	return v5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[splice]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3516"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
require(v1.Types)
return function(p2)
	local v3 = {}
	for _, v4 in ipairs(p2) do
		v3[v4] = true
	end
	return v3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[toSet]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3517"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, ...)
	local v2 = { ... }
	for _, v3 in ipairs(p1) do
		table.insert(v2, v3)
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[unshift]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3518"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.Util)
local v_u_3 = require(script.Parent.copy)
return function(p4, p5, p6, p7)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v8 = #p4
	local v9 = v_u_3(p4)
	if p5 < 1 then
		p5 = p5 + v8
	end
	if type(p6) ~= "function" then
		p6 = v_u_2.func.returned
	end
	if v9[p5] ~= nil then
		v9[p5] = p6(v9[p5], p5)
		return v9
	end
	local v10
	if type(p7) == "function" then
		v10 = p7(p5)
	else
		v10 = nil
	end
	v9[p5] = v10
	return v9
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[update]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3519"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.reduce)
return function(...)
	-- upvalues: (copy) v_u_1
	local v2 = { ... }
	local v3 = {}
	if select("#", ...) == 0 then
		return v3
	end
	for v7 = 1, v_u_1(v2, function(p4, p5)
		local v6 = #p5
		return math.min(p4, v6)
	end, #v2[1]) do
		local v8 = {}
		for _, v9 in ipairs(v2) do
			local v10 = v9[v7]
			table.insert(v8, v10)
		end
		table.insert(v3, v8)
	end
	return v3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[zip]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3520"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(script.Parent.reduce)
local v_u_3 = require(v1.None)
return function(...)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v4 = { ... }
	local v5 = {}
	if select("#", ...) == 0 then
		return v5
	end
	for v9 = 1, v_u_2(v4, function(p6, p7)
		local v8 = #p7
		return math.max(p6, v8)
	end, #v4[1]) do
		local v10 = {}
		for _, v11 in ipairs(v4) do
			local v12 = v11[v9]
			if v12 == nil then
				v12 = v_u_3
			end
			table.insert(v10, v12)
		end
		table.insert(v5, v10)
	end
	return v5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[zipAll]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3521"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["copy"] = require(script.copy),
	["copyDeep"] = require(script.copyDeep),
	["count"] = require(script.count),
	["entries"] = require(script.entries),
	["equals"] = require(script.equals),
	["equalsDeep"] = require(script.equalsDeep),
	["every"] = require(script.every),
	["filter"] = require(script.filter),
	["flatten"] = require(script.flatten),
	["flip"] = require(script.flip),
	["freeze"] = require(script.freeze),
	["freezeDeep"] = require(script.freezeDeep),
	["fromArrays"] = require(script.fromArrays),
	["fromEntries"] = require(script.fromEntries),
	["getDifference"] = require(script.getDifference),
	["has"] = require(script.has),
	["includes"] = require(script.includes),
	["keys"] = require(script.keys),
	["map"] = require(script.map),
	["merge"] = require(script.merge),
	["mergeDeep"] = require(script.mergeDeep),
	["removeKey"] = require(script.removeKey),
	["removeKeys"] = require(script.removeKeys),
	["removeValue"] = require(script.removeValue),
	["removeValues"] = require(script.removeValues),
	["set"] = require(script.set),
	["some"] = require(script.some),
	["update"] = require(script.update),
	["values"] = require(script.values),
	["withKeys"] = require(script.withKeys)
}
v1.join = v1.merge
v1.joinDeep = v1.mergeDeep
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Dictionary]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3522"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return table.clone]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[copy]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3523"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local function v_u_5(p1)
	-- upvalues: (copy) v_u_5
	local v2 = table.clone(p1)
	for v3, v4 in pairs(p1) do
		if type(v4) == "table" then
			v2[v3] = v_u_5(v4)
		end
	end
	return v2
end
return v_u_5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[copyDeep]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3524"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.Util)
return function(p3, p4)
	-- upvalues: (copy) v_u_2
	local v5 = 0
	if type(p4) ~= "function" then
		p4 = v_u_2.func.truthy
	end
	for v6, v7 in pairs(p3) do
		if p4(v7, v6, p3) then
			v5 = v5 + 1
		end
	end
	return v5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[count]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3525"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	local v2 = {}
	for v3, v4 in pairs(p1) do
		table.insert(v2, { v3, v4 })
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[entries]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3526"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.Util)
require(v1.Types)
local function v_u_9(p3, p4)
	if type(p3) ~= "table" or type(p4) ~= "table" then
		return p3 == p4
	end
	for v5, v6 in pairs(p3) do
		if p4[v5] ~= v6 then
			return false
		end
	end
	for v7, v8 in pairs(p4) do
		if p3[v7] ~= v8 then
			return false
		end
	end
	return true
end
return function(...)
	-- upvalues: (copy) v_u_2, (copy) v_u_9
	if v_u_2.equalObjects(...) then
		return true
	end
	local v10 = select("#", ...)
	local v11 = select(1, ...)
	for v12 = 2, v10 do
		if not v_u_9(v11, (select(v12, ...))) then
			return false
		end
	end
	return true
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[equals]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3527"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.Util)
require(v1.Types)
local function v_u_9(p3, p4)
	-- upvalues: (copy) v_u_9
	if type(p3) ~= "table" or type(p4) ~= "table" then
		return p3 == p4
	end
	for v5, v6 in pairs(p3) do
		if not v_u_9(v6, p4[v5]) then
			return false
		end
	end
	for v7, v8 in pairs(p4) do
		if not v_u_9(v8, p3[v7]) then
			return false
		end
	end
	return true
end
return function(...)
	-- upvalues: (copy) v_u_2, (copy) v_u_9
	if v_u_2.equalObjects(...) then
		return true
	end
	local v10 = select("#", ...)
	local v11 = select(1, ...)
	for v12 = 2, v10 do
		if not v_u_9(v11, (select(v12, ...))) then
			return false
		end
	end
	return true
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[equalsDeep]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3528"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	for v3, v4 in pairs(p1) do
		if not p2(v4, v3, p1) then
			return false
		end
	end
	return true
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[every]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3529"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.Util)
return function(p3, p4)
	-- upvalues: (copy) v_u_2
	local v5 = {}
	if type(p4) ~= "function" then
		p4 = v_u_2.func.truthy
	end
	for v6, v7 in pairs(p3) do
		if p4(v7, v6, p3) then
			v5[v6] = v7
		end
	end
	return v5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[filter]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3530"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
local function v_u_10(p1, p2)
	-- upvalues: (copy) v_u_10
	local v3 = type(p2) ~= "number" and (1 / 0) or p2
	local v4 = {}
	for v5, v6 in pairs(p1) do
		if type(v6) == "table" and v3 > 0 then
			local v7 = v_u_10(v6, v3 - 1)
			for v8, v9 in pairs(v4) do
				v7[v8] = v9
			end
			v4 = v7
		else
			v4[v5] = v6
		end
	end
	return v4
end
return v_u_10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[flatten]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3531"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	local v2 = {}
	for v3, v4 in pairs(p1) do
		v2[v4] = v3
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[flip]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3532"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
local v_u_1 = require(script.Parent.copy)
return function(p2)
	-- upvalues: (copy) v_u_1
	local v3 = v_u_1(p2)
	table.freeze(v3)
	return v3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[freeze]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3533"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
local function v_u_5(p1)
	-- upvalues: (copy) v_u_5
	local v2 = {}
	for v3, v4 in pairs(p1) do
		if type(v4) == "table" then
			v2[v3] = v_u_5(v4)
		else
			v2[v3] = v4
		end
	end
	table.freeze(v2)
	return v2
end
return v_u_5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[freezeDeep]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3534"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	local v3 = {}
	for v4 = 1, #p1 do
		v3[p1[v4]] = p2[v4]
	end
	return v3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[fromArrays]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3535"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	local v2 = {}
	for _, v3 in ipairs(p1) do
		v2[v3[1]] = v3[2]
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[fromEntries]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3536"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local function v_u_11(p1, p2)
	-- upvalues: (copy) v_u_11
	local v3 = {}
	for v4, v5 in pairs(p1) do
		if p2[v4] then
			local v6 = type(v5)
			local v7 = p2[v4]
			if v6 == type(v7) then
				if type(v5) == "table" then
					local v8 = v_u_11(v5, p2[v4])
					if next(v8) then
						v3[v4] = v8
					end
				elseif v5 ~= p2[v4] then
					v3[v4] = v5
				end
			else
				v3[v4] = { v5, p2[v4] }
			end
		else
			v3[v4] = v5
		end
	end
	for v9, v10 in pairs(p2) do
		if not (v3[v9] or p1[v9]) then
			v3[v9] = v10
		end
	end
	return v3
end
return v_u_11]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[getDifference]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3537"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p1, p2)
	return p1[p2] ~= nil
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[has]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3538"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	for _, v3 in pairs(p1) do
		if v3 == p2 then
			return true
		end
	end
	return false
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[includes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3539"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	local v2 = {}
	for v3 in pairs(p1) do
		table.insert(v2, v3)
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[keys]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3540"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	local v3 = {}
	for v4, v5 in pairs(p1) do
		local v6, v7 = p2(v5, v4, p1)
		v3[v7 or v4] = v6
	end
	return v3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[map]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3541"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.None)
return function(...)
	-- upvalues: (copy) v_u_2
	local v3 = {}
	for v4 = 1, select("#", ...) do
		local v5 = select(v4, ...)
		if type(v5) == "table" then
			for v6, v8 in pairs(v5) do
				if v8 == v_u_2 then
					local v8 = nil
				end
				v3[v6] = v8
			end
		end
	end
	return v3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[merge]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3542"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.None)
local v_u_3 = require(script.Parent.copyDeep)
local function v_u_10(...)
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_10
	local v4 = {}
	for v5 = 1, select("#", ...) do
		local v6 = select(v5, ...)
		if type(v6) == "table" then
			for v7, v8 in pairs(v6) do
				if v8 == v_u_2 then
					v4[v7] = nil
				elseif type(v8) == "table" then
					if v4[v7] == nil then
						::l12::
						v4[v7] = v_u_3(v8)
					else
						local v9 = v4[v7]
						if type(v9) ~= "table" then
							goto l12
						end
						v4[v7] = v_u_10(v4[v7], v8)
					end
				else
					v4[v7] = v8
				end
			end
		end
	end
	return v4
end
return v_u_10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[mergeDeep]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3543"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.copy)
return function(p2, p3)
	-- upvalues: (copy) v_u_1
	local v4 = v_u_1(p2)
	v4[p3] = nil
	return v4
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[removeKey]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3544"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.copy)
return function(p2, ...)
	-- upvalues: (copy) v_u_1
	local v3 = v_u_1(p2)
	for _, v4 in ipairs({ ... }) do
		v3[v4] = nil
	end
	return v3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[removeKeys]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3545"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	local v3 = {}
	for v4, v5 in pairs(p1) do
		if v5 ~= p2 then
			v3[v4] = v5
		end
	end
	return v3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[removeValue]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3546"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.Array.toSet)
return function(p3, ...)
	-- upvalues: (copy) v_u_2
	local v4 = v_u_2({ ... })
	local v5 = {}
	for v6, v7 in pairs(p3) do
		if not v4[v7] then
			v5[v6] = v7
		end
	end
	return v5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[removeValues]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3547"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.copy)
return function(p2, p3, p4)
	-- upvalues: (copy) v_u_1
	local v5 = v_u_1(p2)
	v5[p3] = p4
	return v5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[set]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3548"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	for v3, v4 in pairs(p1) do
		if p2(v4, v3, p1) then
			return true
		end
	end
	return false
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[some]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3549"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.copy)
return function(p2, p3, p4, p5)
	-- upvalues: (copy) v_u_1
	local v6 = v_u_1(p2)
	if v6[p3] == nil then
		if p5 then
			local v7
			if type(p5) == "function" then
				v7 = p5(p3)
			else
				v7 = nil
			end
			v6[p3] = v7
		end
	elseif p4 then
		v6[p3] = p4(v6[p3], p3)
		return v6
	end
	return v6
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[update]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3550"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	local v2 = {}
	for _, v3 in pairs(p1) do
		table.insert(v2, v3)
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[values]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3551"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, ...)
	local v2 = {}
	for _, v3 in ipairs({ ... }) do
		v2[v3] = p1[v3]
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[withKeys]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3552"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = newproxy(true)
getmetatable(v1).__tostring = function()
	return "Sift.None"
end
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[None]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3553"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["add"] = require(script.add),
	["copy"] = require(script.copy),
	["count"] = require(script.count),
	["delete"] = require(script.delete),
	["difference"] = require(script.difference),
	["differenceSymmetric"] = require(script.differenceSymmetric),
	["filter"] = require(script.filter),
	["fromArray"] = require(script.fromArray),
	["has"] = require(script.has),
	["intersection"] = require(script.intersection),
	["isSubset"] = require(script.isSubset),
	["isSuperset"] = require(script.isSuperset),
	["map"] = require(script.map),
	["merge"] = require(script.merge),
	["toArray"] = require(script.toArray)
}
v1.fromList = v1.fromArray
v1.join = v1.merge
v1.subtract = v1.delete
v1.union = v1.merge
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Set]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3554"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, ...)
	local v2 = {}
	for v3, _ in pairs(p1) do
		v2[v3] = true
	end
	for _, v4 in ipairs({ ... }) do
		v2[v4] = true
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[add]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3555"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
return require(v1.Dictionary.copy)]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[copy]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3556"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.Util)
return function(p3, p4)
	-- upvalues: (copy) v_u_2
	local v5 = 0
	if type(p4) ~= "function" then
		p4 = v_u_2.func.truthy
	end
	for v6, _ in pairs(p3) do
		if p4(v6, p3) then
			v5 = v5 + 1
		end
	end
	return v5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[count]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3557"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, ...)
	local v2 = {}
	for v3, _ in pairs(p1) do
		v2[v3] = true
	end
	for _, v4 in ipairs({ ... }) do
		v2[v4] = nil
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[delete]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3558"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p1, ...)
	local v2 = table.clone(p1)
	for _, v3 in { ... } do
		if typeof(v3) == "table" then
			for v4 in v3 do
				v2[v4] = nil
			end
		end
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[difference]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3559"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p1, ...)
	local v2 = table.clone(p1)
	for _, v3 in { ... } do
		if typeof(v3) == "table" then
			for v4 in v3 do
				v2[v4] = v2[v4] == nil
			end
		end
	end
	for v5, v6 in v2 do
		v2[v5] = v6 and true or nil
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[differenceSymmetric]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3560"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent.Parent
local v_u_2 = require(v1.Util)
return function(p3, p4)
	-- upvalues: (copy) v_u_2
	local v5 = {}
	if type(p4) ~= "function" then
		p4 = v_u_2.func.truthy
	end
	for v6, _ in pairs(p3) do
		if p4(v6, p3) then
			v5[v6] = true
		end
	end
	return v5
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[filter]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3561"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	local v2 = table.create(#p1)
	for _, v3 in ipairs(p1) do
		v2[v3] = true
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[fromArray]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3562"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	return p1[p2] == true
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[has]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3563"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(...)
	local v1 = select("#", ...)
	local v2 = select(1, ...)
	local v3 = {}
	for v4, _ in pairs(v2) do
		local v5 = true
		for v6 = 2, v1 do
			if select(v6, ...)[v4] ~= true then
				v5 = false
				break
			end
		end
		if v5 then
			v3[v4] = true
		end
	end
	return v3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[intersection]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3564"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	for v3, v4 in pairs(p1) do
		if p2[v3] ~= v4 then
			return false
		end
	end
	return true
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[isSubset]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3565"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.isSubset)
return function(p2, p3)
	-- upvalues: (copy) v_u_1
	return v_u_1(p3, p2)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[isSuperset]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3566"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1, p2)
	local v3 = {}
	for v4, _ in pairs(p1) do
		local v5 = p2(v4, p1)
		if v5 ~= nil then
			v3[v5] = true
		end
	end
	return v3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[map]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3567"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(...)
	local v1 = {}
	for v2 = 1, select("#", ...) do
		local v3 = select(v2, ...)
		if type(v3) == "table" then
			for v4, _ in pairs(v3) do
				v1[v4] = true
			end
		end
	end
	return v1
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[merge]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3568"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	local v2 = {}
	for v3, _ in pairs(p1) do
		table.insert(v2, v3)
	end
	return v2
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[toArray]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3569"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.None)
return nil]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Types]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3570"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["equalObjects"] = require(script.equalObjects),
	["func"] = require(script.func),
	["isEmpty"] = require(script.isEmpty)
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Util]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3571"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(...)
	local v1 = select(1, ...)
	for v2 = 2, select("#", ...) do
		if v1 ~= select(v2, ...) then
			return false
		end
	end
	return true
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[equalObjects]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3572"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["truthy"] = function()
		return true
	end,
	["noop"] = function() end,
	["returned"] = function(...)
		return ...
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[func]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3573"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

require(script.Parent.Parent.Types)
return function(p1)
	return next(p1) == nil
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[isEmpty]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item></Item><Item class="Folder" referent="3574"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[evaera_cmdr@1.12.0]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3575"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("RunService")
local v2 = require(script.Shared:WaitForChild("Util"))
if v1:IsServer() == false then
	error("Cmdr server module is somehow running on a client!")
end
local v3 = {
	["ReplicatedRoot"] = nil,
	["RemoteFunction"] = nil,
	["RemoteEvent"] = nil,
	["Util"] = v2,
	["DefaultCommandsFolder"] = script.BuiltInCommands
}
local v_u_7 = setmetatable(v3, {
	["__index"] = function(p_u_4, p5)
		local v_u_6 = p_u_4.Registry[p5]
		if v_u_6 and type(v_u_6) == "function" then
			return function(_, ...)
				-- upvalues: (copy) v_u_6, (copy) p_u_4
				return v_u_6(p_u_4.Registry, ...)
			end
		end
	end
})
v_u_7.Registry = require(script.Shared.Registry)(v_u_7)
v_u_7.Dispatcher = require(script.Shared.Dispatcher)(v_u_7)
require(script.Initialize)(v_u_7)
function v_u_7.RemoteFunction.OnServerInvoke(p8, p9, p10)
	-- upvalues: (ref) v_u_7
	return #p9 > 100000 and "Input too long" or v_u_7.Dispatcher:EvaluateAndRun(p9, p8, p10)
end
return v_u_7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[cmdr]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3576"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("RunService")
local v2 = game:GetService("StarterGui")
local v3 = game:GetService("Players").LocalPlayer
local v4 = script:WaitForChild("Shared")
local v_u_5 = require(v4:WaitForChild("Util"))
if v1:IsClient() == false then
	error("Server scripts cannot require the client library. Please require the server library to use Cmdr in your own code.")
end
local v6 = {
	["ReplicatedRoot"] = script,
	["RemoteFunction"] = script:WaitForChild("CmdrFunction"),
	["RemoteEvent"] = script:WaitForChild("CmdrEvent"),
	["ActivationKeys"] = {
		[Enum.KeyCode.F2] = true
	},
	["Enabled"] = true,
	["MashToEnable"] = false,
	["ActivationUnlocksMouse"] = false,
	["HideOnLostFocus"] = true,
	["PlaceName"] = "Cmdr",
	["Util"] = v_u_5,
	["Events"] = {}
}
local v_u_10 = setmetatable(v6, {
	["__index"] = function(p_u_7, p8)
		local v_u_9 = p_u_7.Dispatcher[p8]
		if v_u_9 and type(v_u_9) == "function" then
			return function(_, ...)
				-- upvalues: (copy) v_u_9, (copy) p_u_7
				return v_u_9(p_u_7.Dispatcher, ...)
			end
		end
	end
})
v_u_10.Registry = require(v4.Registry)(v_u_10)
v_u_10.Dispatcher = require(v4.Dispatcher)(v_u_10)
if v2:WaitForChild("Cmdr") and (wait() and v3:WaitForChild("PlayerGui"):FindFirstChild("Cmdr") == nil) then
	v2.Cmdr:Clone().Parent = v3.PlayerGui
end
local v_u_11 = require(script.CmdrInterface)(v_u_10)
function v_u_10.SetActivationKeys(p12, p13)
	-- upvalues: (copy) v_u_5
	p12.ActivationKeys = v_u_5.MakeDictionary(p13)
end
function v_u_10.SetPlaceName(p14, p15)
	-- upvalues: (copy) v_u_11
	p14.PlaceName = p15
	v_u_11.Window:UpdateLabel()
end
function v_u_10.SetEnabled(p16, p17)
	p16.Enabled = p17
end
function v_u_10.SetActivationUnlocksMouse(p18, p19)
	p18.ActivationUnlocksMouse = p19
end
function v_u_10.Show(p20)
	-- upvalues: (copy) v_u_11
	if p20.Enabled then
		v_u_11.Window:Show()
	end
end
function v_u_10.Hide(_)
	-- upvalues: (copy) v_u_11
	v_u_11.Window:Hide()
end
function v_u_10.Toggle(p21)
	-- upvalues: (copy) v_u_11
	if not p21.Enabled then
		return p21:Hide()
	end
	v_u_11.Window:SetVisible(not v_u_11.Window:IsVisible())
end
function v_u_10.SetMashToEnable(p22, p23)
	p22.MashToEnable = p23
	if p23 then
		p22:SetEnabled(false)
	end
end
function v_u_10.SetHideOnLostFocus(p24, p25)
	p24.HideOnLostFocus = p25
end
function v_u_10.HandleEvent(p26, p27, p28)
	p26.Events[p27] = p28
end
if v1:IsServer() == false then
	v_u_10.Registry:RegisterTypesIn(script:WaitForChild("Types"))
	v_u_10.Registry:RegisterCommandsIn(script:WaitForChild("Commands"))
end
v_u_10.RemoteEvent.OnClientEvent:Connect(function(p29, ...)
	-- upvalues: (ref) v_u_10
	if v_u_10.Events[p29] then
		v_u_10.Events[p29](...)
	end
end)
require(script.DefaultEventHandlers)(v_u_10)
return v_u_10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CmdrClient]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3577"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players").LocalPlayer
return function(p_u_2)
	-- upvalues: (copy) v_u_1
	local v_u_3 = p_u_2.Util
	local v_u_4 = require(script:WaitForChild("Window"))
	v_u_4.Cmdr = p_u_2
	local v_u_5 = require(script:WaitForChild("AutoComplete"))(p_u_2)
	v_u_4.AutoComplete = v_u_5
	function v_u_4.ProcessEntry(p6)
		-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) p_u_2, (ref) v_u_1
		local v7 = v_u_3.TrimString(p6)
		if #v7 ~= 0 then
			v_u_4:AddLine(v_u_4:GetLabel() .. " " .. v7, Color3.fromRGB(255, 223, 93))
			v_u_4:AddLine(p_u_2.Dispatcher:EvaluateAndRun(v7, v_u_1, {
				["IsHuman"] = true
			}))
		end
	end
	function v_u_4.OnTextChanged(p8)
		-- upvalues: (copy) p_u_2, (ref) v_u_1, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5
		local v9 = p_u_2.Dispatcher:Evaluate(p8, v_u_1, true)
		local v10 = v_u_3.SplitString(p8)
		local v11 = table.remove(v10, 1)
		local v12
		if v9 then
			v10 = v_u_3.MashExcessArguments(v10, #v9.Object.Args)
			if #v10 == #v9.Object.Args then
				v12 = true
			else
				v12 = false
			end
		else
			v12 = false
		end
		local v13
		if v11 then
			v13 = #v10 > 0
		else
			v13 = v11
		end
		if p8:sub(#p8, #p8):match("%s") and not v12 then
			v10[#v10 + 1] = ""
			v13 = true
		end
		if v9 and v13 then
			local v14, v15 = v9:Validate()
			v_u_4:SetIsValidInput(v14, ("Validation errors: %s"):format(v15 or ""))
			local v16 = {}
			local v17 = v9:GetArgument(#v10)
			if v17 then
				local v18 = v17.TextSegmentInProgress
				local v19 = false
				if v17.RawSegmentsAreAutocomplete then
					for v20, v21 in ipairs(v17.RawSegments) do
						v16[v20] = { v21, v21 }
					end
				else
					local v22, v23 = v17:GetAutocomplete()
					v19 = (v23 or {}).IsPartial or false
					for v24, v25 in pairs(v22) do
						v16[v24] = { v18, v25 }
					end
				end
				local v26
				if #v18 > 0 then
					v26, v15 = v17:Validate()
				else
					v26 = true
				end
				if not v12 and v26 then
					v_u_4:HideInvalidState()
				end
				local v27 = v_u_5
				local v28 = {}
				if v12 then
					v12 = #p8 - #v18 + (p8:sub(#p8, #p8):match("%s") and -1 or 0)
				end
				v28.at = v12
				v28.prefix = #v17.RawSegments == 1 and (v17.Prefix or "") or ""
				local v29
				if #v9.Arguments == #v9.ArgumentDefinitions then
					v29 = #v18 > 0
				else
					v29 = false
				end
				v28.isLast = v29
				v28.numArgs = #v10
				v28.command = v9
				v28.arg = v17
				v28.name = v17.Name .. (v17.Required and "" or "?")
				v28.type = v17.Type.DisplayName
				v28.description = v26 == false and v15 and v15 or v17.Object.Description
				v28.invalid = not v26
				v28.isPartial = v19
				return v27:Show(v16, v28)
			end
		elseif v11 and #v10 == 0 then
			v_u_4:SetIsValidInput(true)
			local v30 = p_u_2.Registry:GetCommand(v11)
			local v31 = nil
			if v30 then
				v31 = {
					v30.Name,
					v30.Name,
					["options"] = {
						["name"] = v30.Name,
						["description"] = v30.Description
					}
				}
				local v32 = v30.Args
				if v32 then
					v32 = v30.Args[1]
				end
				if type(v32) == "function" then
					v32 = v32(v9)
				end
				if v32 and (not v32.Optional and v32.Default == nil) then
					v_u_4:SetIsValidInput(false, "This command has required arguments.")
					v_u_4:HideInvalidState()
				end
			else
				v_u_4:SetIsValidInput(false, ("%q is not a valid command name. Use the help command to see all available commands."):format(v11))
			end
			local v33 = { v31 }
			for _, v34 in pairs(p_u_2.Registry:GetCommandNames()) do
				if v11:lower() == v34:lower():sub(1, #v11) and (v31 == nil or v31[1] ~= v11) then
					local v35 = p_u_2.Registry:GetCommand(v34)
					v33[#v33 + 1] = {
						v11,
						v34,
						["options"] = {
							["name"] = v35.Name,
							["description"] = v35.Description
						}
					}
				end
			end
			return v_u_5:Show(v33)
		end
		v_u_4:SetIsValidInput(false, "Use the help command to see all available commands.")
		v_u_5:Hide()
	end
	v_u_4:UpdateLabel()
	v_u_4:UpdateWindowHeight()
	return {
		["Window"] = v_u_4,
		["AutoComplete"] = v_u_5
	}
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CmdrInterface]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3578"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players").LocalPlayer
return function(p2)
	-- upvalues: (copy) v_u_1
	local v_u_3 = {
		["Items"] = {},
		["ItemOptions"] = {},
		["SelectedItem"] = 0
	}
	local v_u_4 = p2.Util
	local v_u_5 = v_u_1:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Autocomplete")
	local v_u_6 = v_u_5:WaitForChild("TextButton")
	local v_u_7 = v_u_5:WaitForChild("Title")
	local v_u_8 = v_u_5:WaitForChild("Description")
	local v_u_9 = v_u_5.Parent:WaitForChild("Frame"):WaitForChild("Entry")
	v_u_6.Parent = nil
	local v_u_10 = v_u_5.ScrollBarThickness
	local function v_u_15(p11, p12, p13, p14)
		-- upvalues: (copy) v_u_4
		p11.Visible = p13 ~= nil
		p12.Text = p13 or ""
		if p14 then
			p12.Size = UDim2.new(0, v_u_4.GetTextSize(p13 or "", p12, Vector2.new(1000, 1000), 1, 0).X, p11.Size.Y.Scale, p11.Size.Y.Offset)
		end
	end
	local function v_u_23()
		-- upvalues: (copy) v_u_5, (copy) v_u_7
		local v16 = v_u_5
		local v17 = UDim2.new
		local v18 = v_u_7.Field.TextBounds.X + v_u_7.Field.Type.TextBounds.X
		local v19 = v_u_5.Size.X.Offset
		local v20 = math.max(v18, v19)
		local v21 = v_u_5.UIListLayout.AbsoluteContentSize.Y
		local v22 = v_u_5.Parent.AbsoluteSize.Y - v_u_5.AbsolutePosition.Y - 10
		v16.Size = v17(0, v20, 0, (math.min(v21, v22)))
	end
	local function v_u_31(p24)
		-- upvalues: (copy) v_u_15, (copy) v_u_7, (copy) v_u_8, (copy) v_u_5, (copy) v_u_23, (copy) v_u_10
		v_u_15(v_u_7, v_u_7.Field, p24.name, true)
		local v25 = v_u_7.Field.Type
		local v26 = v_u_7.Field.Type
		local v27 = p24.type
		if v27 then
			v27 = ": " .. p24.type:sub(1, 1):upper() .. p24.type:sub(2)
		end
		v25.Visible = v27 ~= nil
		v26.Text = v27 or ""
		local v28 = v_u_8
		local v29 = v_u_8.Label
		local v30 = p24.description
		v28.Visible = v30 ~= nil
		v29.Text = v30 or ""
		v_u_8.Label.TextColor3 = p24.invalid and Color3.fromRGB(255, 73, 73) or Color3.fromRGB(255, 255, 255)
		v_u_8.Size = UDim2.new(1, 0, 0, 40)
		while not v_u_8.Label.TextFits do
			v_u_8.Size = v_u_8.Size + UDim2.new(0, 0, 0, 2)
			if v_u_8.Size.Y.Offset > 500 then
				break
			end
		end
		task.wait()
		v_u_5.UIListLayout:ApplyLayout()
		v_u_23()
		v_u_5.ScrollBarThickness = v_u_10
	end
	function v_u_3.Show(p32, p33, p34)
		-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_9, (copy) v_u_4, (copy) v_u_31
		local v35 = p34 or {}
		for _, v36 in pairs(p32.Items) do
			if v36.gui then
				v36.gui:Destroy()
			end
		end
		p32.SelectedItem = 1
		p32.Items = p33
		p32.Prefix = v35.prefix or ""
		p32.LastItem = v35.isLast or false
		p32.Command = v35.command
		p32.Arg = v35.arg
		p32.NumArgs = v35.numArgs
		p32.IsPartial = v35.isPartial
		v_u_5.ScrollBarThickness = 0
		local v37 = 200
		for v38, v39 in pairs(p32.Items) do
			local v40 = v39[1]
			local v41 = v39[2]
			local v42 = v_u_6:Clone()
			v42.Name = v40 .. v41
			v42.BackgroundTransparency = v38 == p32.SelectedItem and 0.5 or 1
			local v43, v44 = string.find(v41:lower(), v40:lower(), 1, true)
			v42.Typed.Text = string.rep(" ", v43 - 1) .. v40
			local v45 = v42.Suggest
			local v46 = v43 - 1
			local v47 = string.sub(v41, 0, v46)
			local v48 = string.rep(" ", #v40)
			local v49 = v44 + 1
			v45.Text = v47 .. v48 .. string.sub(v41, v49)
			v42.Parent = v_u_5
			v42.LayoutOrder = v38
			local v50 = v42.Typed.TextBounds.X
			local v51 = v42.Suggest.TextBounds.X
			local v52 = math.max(v50, v51) + 20
			if v37 < v52 then
				v37 = v52
			end
			v39.gui = v42
		end
		v_u_5.UIListLayout:ApplyLayout()
		local v53 = v_u_9.TextBox.Text
		local v54 = v_u_4.SplitString(v53)
		if v53:sub(#v53, #v53) == " " and not v35.at then
			v54[#v54 + 1] = "e"
		end
		table.remove(v54, #v54)
		local v55 = (v35.at and v35.at or #table.concat(v54, " ") + 1) * 7
		v_u_5.Position = UDim2.new(0, v_u_9.TextBox.AbsolutePosition.X - 10 + v55, 0, v_u_9.TextBox.AbsolutePosition.Y + 30)
		v_u_5.Size = UDim2.new(0, v37, 0, v_u_5.UIListLayout.AbsoluteContentSize.Y)
		v_u_5.Visible = true
		local v56 = v_u_31
		if p32.Items[1] then
			v35 = p32.Items[1].options or v35
		end
		v56(v35)
	end
	function v_u_3.GetSelectedItem(_)
		-- upvalues: (copy) v_u_5, (copy) v_u_3
		if v_u_5.Visible == false then
			return nil
		else
			return v_u_3.Items[v_u_3.SelectedItem]
		end
	end
	function v_u_3.Hide(_)
		-- upvalues: (copy) v_u_5
		v_u_5.Visible = false
	end
	function v_u_3.IsVisible(_)
		-- upvalues: (copy) v_u_5
		return v_u_5.Visible
	end
	function v_u_3.Select(p57, p58)
		-- upvalues: (copy) v_u_5, (copy) v_u_7, (copy) v_u_8, (copy) v_u_6, (copy) v_u_31
		if v_u_5.Visible then
			p57.SelectedItem = p57.SelectedItem + p58
			if p57.SelectedItem > #p57.Items then
				p57.SelectedItem = 1
			elseif p57.SelectedItem < 1 then
				p57.SelectedItem = #p57.Items
			end
			for v59, v60 in pairs(p57.Items) do
				v60.gui.BackgroundTransparency = v59 == p57.SelectedItem and 0.5 or 1
			end
			local v61 = v_u_5
			local v62 = Vector2.new
			local v63 = v_u_7.Size.Y.Offset + v_u_8.Size.Y.Offset + p57.SelectedItem * v_u_6.Size.Y.Offset - v_u_5.Size.Y.Offset
			v61.CanvasPosition = v62(0, (math.max(0, v63)))
			if p57.Items[p57.SelectedItem] and p57.Items[p57.SelectedItem].options then
				v_u_31(p57.Items[p57.SelectedItem].options or {})
			end
		end
	end
	v_u_5.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(v_u_23)
	return v_u_3
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AutoComplete]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3579"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("GuiService")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("TextChatService")
local v_u_4 = game:GetService("Players").LocalPlayer
local v_u_5 = { Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.Touch }
local v_u_6 = {
	["Valid"] = true,
	["AutoComplete"] = nil,
	["ProcessEntry"] = nil,
	["OnTextChanged"] = nil,
	["Cmdr"] = nil,
	["HistoryState"] = nil
}
local v_u_7 = v_u_4:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Frame")
local v_u_8 = v_u_7:WaitForChild("Line")
local v_u_9 = v_u_7:WaitForChild("Entry")
v_u_8.Parent = nil
function v_u_6.UpdateLabel(p10)
	-- upvalues: (copy) v_u_9, (copy) v_u_4
	v_u_9.TextLabel.Text = v_u_4.Name .. "@" .. p10.Cmdr.PlaceName .. "$"
end
function v_u_6.GetLabel(_)
	-- upvalues: (copy) v_u_9
	return v_u_9.TextLabel.Text
end
function v_u_6.UpdateWindowHeight(_)
	-- upvalues: (copy) v_u_7
	local v11 = v_u_7.UIListLayout.AbsoluteContentSize.Y + v_u_7.UIPadding.PaddingTop.Offset + v_u_7.UIPadding.PaddingBottom.Offset
	v_u_7.Size = UDim2.new(v_u_7.Size.X.Scale, v_u_7.Size.X.Offset, 0, (math.clamp(v11, 0, 300)))
	v_u_7.CanvasPosition = Vector2.new(0, v11)
end
function v_u_6.AddLine(p12, p13, p14)
	-- upvalues: (copy) v_u_6, (copy) v_u_8, (copy) v_u_7
	local v15 = p14 or {}
	local v16 = tostring(p13)
	local v17 = typeof(v15) == "Color3" and {
		["Color"] = v15
	} or v15
	if #v16 == 0 then
		v_u_6:UpdateWindowHeight()
	else
		local v18 = p12.Cmdr.Util.EmulateTabstops(v16 or "nil", 8)
		local v19 = v_u_8:Clone()
		v19.Text = v18
		v19.TextColor3 = v17.Color or v19.TextColor3
		v19.RichText = v17.RichText or false
		v19.Parent = v_u_7
	end
end
function v_u_6.IsVisible(_)
	-- upvalues: (copy) v_u_7
	return v_u_7.Visible
end
function v_u_6.SetVisible(p20, p21)
	-- upvalues: (copy) v_u_7, (copy) v_u_3, (copy) v_u_9, (copy) v_u_2
	v_u_7.Visible = p21
	if p21 then
		p20.PreviousChatWindowConfigurationEnabled = v_u_3.ChatWindowConfiguration.Enabled
		p20.PreviousChatInputBarConfigurationEnabled = v_u_3.ChatInputBarConfiguration.Enabled
		v_u_3.ChatWindowConfiguration.Enabled = false
		v_u_3.ChatInputBarConfiguration.Enabled = false
		v_u_9.TextBox:CaptureFocus()
		p20:SetEntryText("")
		if p20.Cmdr.ActivationUnlocksMouse then
			p20.PreviousMouseBehavior = v_u_2.MouseBehavior
			v_u_2.MouseBehavior = Enum.MouseBehavior.Default
			return
		end
	else
		v_u_3.ChatWindowConfiguration.Enabled = p20.PreviousChatWindowConfigurationEnabled == nil and true or p20.PreviousChatWindowConfigurationEnabled
		v_u_3.ChatInputBarConfiguration.Enabled = p20.PreviousChatInputBarConfigurationEnabled == nil and true or p20.PreviousChatInputBarConfigurationEnabled
		v_u_9.TextBox:ReleaseFocus()
		p20.AutoComplete:Hide()
		if p20.PreviousMouseBehavior then
			v_u_2.MouseBehavior = p20.PreviousMouseBehavior
			p20.PreviousMouseBehavior = nil
		end
	end
end
function v_u_6.Hide(p22)
	return p22:SetVisible(false)
end
function v_u_6.Show(p23)
	return p23:SetVisible(true)
end
function v_u_6.SetEntryText(p24, p25)
	-- upvalues: (copy) v_u_9, (copy) v_u_6
	v_u_9.TextBox.Text = p25
	if p24:IsVisible() then
		v_u_9.TextBox:CaptureFocus()
		v_u_9.TextBox.CursorPosition = #p25 + 1
		v_u_6:UpdateWindowHeight()
	end
end
function v_u_6.GetEntryText(_)
	-- upvalues: (copy) v_u_9
	return v_u_9.TextBox.Text:gsub("\t", "")
end
function v_u_6.SetIsValidInput(p26, p27, p28)
	-- upvalues: (copy) v_u_9
	v_u_9.TextBox.TextColor3 = p27 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 73, 73)
	p26.Valid = p27
	p26._errorText = p28
end
function v_u_6.HideInvalidState(_)
	-- upvalues: (copy) v_u_9
	v_u_9.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
end
function v_u_6.LoseFocus(p29, p30)
	-- upvalues: (copy) v_u_9, (copy) v_u_7, (copy) v_u_1
	local v31 = v_u_9.TextBox.Text
	p29:ClearHistoryState()
	if v_u_7.Visible and not v_u_1.MenuIsOpen then
		v_u_9.TextBox:CaptureFocus()
	elseif v_u_1.MenuIsOpen and v_u_7.Visible then
		p29:Hide()
	end
	if p30 and p29.Valid then
		wait()
		p29:SetEntryText("")
		p29.ProcessEntry(v31)
	elseif p30 then
		p29:AddLine(p29._errorText, Color3.fromRGB(255, 153, 153))
	end
end
function v_u_6.TraverseHistory(p32, p33)
	local v34 = p32.Cmdr.Dispatcher:GetHistory()
	if p32.HistoryState == nil then
		p32.HistoryState = {
			["Position"] = #v34 + 1,
			["InitialText"] = p32:GetEntryText()
		}
	end
	local v35 = p32.HistoryState
	local v36 = p32.HistoryState.Position + p33
	local v37 = #v34 + 1
	v35.Position = math.clamp(v36, 1, v37)
	p32:SetEntryText(p32.HistoryState.Position == #v34 + 1 and p32.HistoryState.InitialText or v34[p32.HistoryState.Position])
end
function v_u_6.ClearHistoryState(p38)
	p38.HistoryState = nil
end
function v_u_6.SelectVertical(p39, p40)
	if p39.AutoComplete:IsVisible() and not p39.HistoryState then
		p39.AutoComplete:Select(p40)
	else
		p39:TraverseHistory(p40)
	end
end
local v_u_41 = 0
local v_u_42 = 0
function v_u_6.BeginInput(p43, p44, p45)
	-- upvalues: (copy) v_u_1, (ref) v_u_41, (ref) v_u_42, (copy) v_u_5, (copy) v_u_7
	if v_u_1.MenuIsOpen then
		p43:Hide()
	end
	if p45 and p43:IsVisible() == false then
		return
	elseif p43.Cmdr.ActivationKeys[p44.KeyCode] then
		if p43.Cmdr.MashToEnable and not p43.Cmdr.Enabled then
			if tick() - v_u_41 < 1 then
				if v_u_42 >= 5 then
					return p43.Cmdr:SetEnabled(true)
				end
				v_u_42 = v_u_42 + 1
			else
				v_u_42 = 1
			end
			v_u_41 = tick()
		elseif p43.Cmdr.Enabled then
			p43:SetVisible(not p43:IsVisible())
			wait()
			p43:SetEntryText("")
			if v_u_1.MenuIsOpen then
				p43:Hide()
			end
		end
	elseif p43.Cmdr.Enabled == false or not p43:IsVisible() then
		if p43:IsVisible() then
			p43:Hide()
		end
	elseif p43.Cmdr.HideOnLostFocus and table.find(v_u_5, p44.UserInputType) then
		local v46 = p44.Position
		local v47 = v_u_7.AbsolutePosition
		local v48 = v_u_7.AbsoluteSize
		if v46.X < v47.X or (v46.X > v47.X + v48.X or (v46.Y < v47.Y or v46.Y > v47.Y + v48.Y)) then
			p43:Hide()
			return
		end
	else
		if p44.KeyCode == Enum.KeyCode.Down then
			p43:SelectVertical(1)
			return
		end
		if p44.KeyCode == Enum.KeyCode.Up then
			p43:SelectVertical(-1)
			return
		end
		if p44.KeyCode == Enum.KeyCode.Return then
			wait()
			p43:SetEntryText(p43:GetEntryText():gsub("\n", ""):gsub("\r", ""))
			return
		end
		if p44.KeyCode == Enum.KeyCode.Tab then
			local v49 = p43.AutoComplete:GetSelectedItem()
			local v50 = p43:GetEntryText()
			if v49 and not (v50:sub(#v50, #v50):match("%s") and p43.AutoComplete.LastItem) then
				local v51 = v49[2]
				local v52 = p43.AutoComplete.Command
				local v53, v54
				if v52 then
					local v55 = p43.AutoComplete.Arg
					v53 = v52.Alias
					if p43.AutoComplete.NumArgs == #v52.ArgumentDefinitions then
						v54 = false
					else
						v54 = p43.AutoComplete.IsPartial == false
					end
					local v56 = v52.Arguments
					for v57 = 1, #v56 do
						local v58 = v56[v57]
						local v59 = v58.RawSegments
						if v58 == v55 then
							v59[#v59] = v51
						end
						local v60 = v58.Prefix .. table.concat(v59, ",")
						if v60:find(" ") or v60 == "" then
							v60 = ("%q"):format(v60)
						end
						v53 = ("%s %s"):format(v53, v60)
						if v58 == v55 then
							break
						end
					end
				else
					v53 = v51
					v54 = true
				end
				wait()
				p43:SetEntryText(v53 .. (v54 and " " or ""))
			else
				wait()
				p43:SetEntryText(p43:GetEntryText())
			end
		end
		p43:ClearHistoryState()
	end
end
v_u_9.TextBox.FocusLost:Connect(function(p61)
	-- upvalues: (copy) v_u_6
	return v_u_6:LoseFocus(p61)
end)
v_u_2.InputBegan:Connect(function(p62, p63)
	-- upvalues: (copy) v_u_6
	return v_u_6:BeginInput(p62, p63)
end)
v_u_9.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	-- upvalues: (copy) v_u_7, (copy) v_u_9, (copy) v_u_6
	v_u_7.CanvasPosition = Vector2.new(0, v_u_7.AbsoluteCanvasSize.Y)
	if v_u_9.TextBox.Text:match("\t") then
		v_u_9.TextBox.Text = v_u_9.TextBox.Text:gsub("\t", "")
	elseif v_u_6.OnTextChanged then
		return v_u_6.OnTextChanged(v_u_9.TextBox.Text)
	end
end)
v_u_7.ChildAdded:Connect(function()
	-- upvalues: (copy) v_u_6
	task.defer(v_u_6.UpdateWindowHeight)
end)
return v_u_6]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Window]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3580"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("StarterGui")
local v_u_2 = require(script.Parent.CmdrInterface.Window)
return function(p3)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	p3:HandleEvent("Message", function(p4)
		-- upvalues: (ref) v_u_1
		v_u_1:SetCore("ChatMakeSystemMessage", {
			["Text"] = ("[Announcement] %s"):format(p4),
			["Color"] = Color3.fromRGB(249, 217, 56)
		})
	end)
	p3:HandleEvent("AddLine", function(...)
		-- upvalues: (ref) v_u_2
		v_u_2:AddLine(...)
	end)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[DefaultEventHandlers]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="3581"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function()
	local v1 = Instance.new("ScreenGui")
	v1.DisplayOrder = 1000
	v1.Name = "Cmdr"
	v1.ResetOnSpawn = false
	v1.AutoLocalize = false
	local v2 = Instance.new("ScrollingFrame")
	v2.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
	v2.BackgroundTransparency = 0.4
	v2.BorderSizePixel = 0
	v2.CanvasSize = UDim2.new(0, 0, 0, 0)
	v2.Name = "Frame"
	v2.Position = UDim2.new(0.025, 0, 0, 25)
	v2.ScrollBarThickness = 6
	v2.ScrollingDirection = Enum.ScrollingDirection.Y
	v2.Selectable = false
	v2.Size = UDim2.new(0.95, 0, 0, 0)
	v2.Visible = false
	v2.AutomaticCanvasSize = Enum.AutomaticSize.Y
	v2.Parent = v1
	local v3 = Instance.new("ScrollingFrame")
	v3.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
	v3.BackgroundTransparency = 0.5
	v3.BorderSizePixel = 0
	v3.CanvasSize = UDim2.new(0, 0, 0, 0)
	v3.Name = "Autocomplete"
	v3.Position = UDim2.new(0, 167, 0, 75)
	v3.ScrollBarThickness = 6
	v3.ScrollingDirection = Enum.ScrollingDirection.Y
	v3.Selectable = false
	v3.Size = UDim2.new(0, 200, 0, 200)
	v3.Visible = false
	v3.AutomaticCanvasSize = Enum.AutomaticSize.Y
	v3.Parent = v1
	local v4 = Instance.new("UIListLayout")
	v4.SortOrder = Enum.SortOrder.LayoutOrder
	v4.Parent = v2
	local v5 = Instance.new("TextBox")
	v5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v5.BackgroundTransparency = 1
	v5.Font = Enum.Font.Code
	v5.Name = "Line"
	v5.Size = UDim2.new(1, 0, 0, 20)
	v5.AutomaticSize = Enum.AutomaticSize.Y
	v5.TextColor3 = Color3.fromRGB(255, 255, 255)
	v5.TextSize = 14
	v5.TextXAlignment = Enum.TextXAlignment.Left
	v5.TextEditable = false
	v5.ClearTextOnFocus = false
	v5.Parent = v2
	local v6 = Instance.new("UIPadding")
	v6.PaddingBottom = UDim.new(0, 10)
	v6.PaddingLeft = UDim.new(0, 10)
	v6.PaddingRight = UDim.new(0, 10)
	v6.PaddingTop = UDim.new(0, 10)
	v6.Parent = v2
	local v7 = Instance.new("Frame")
	v7.BackgroundTransparency = 1
	v7.LayoutOrder = 999999999
	v7.Name = "Entry"
	v7.Size = UDim2.new(1, 0, 0, 20)
	v7.Parent = v2
	local v8 = Instance.new("UIListLayout")
	v8.SortOrder = Enum.SortOrder.LayoutOrder
	v8.Parent = v3
	local v9 = Instance.new("Frame")
	v9.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
	v9.BackgroundTransparency = 0.2
	v9.BorderSizePixel = 0
	v9.LayoutOrder = -2
	v9.Name = "Title"
	v9.Size = UDim2.new(1, 0, 0, 40)
	v9.Parent = v3
	local v10 = Instance.new("Frame")
	v10.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
	v10.BackgroundTransparency = 0.2
	v10.BorderSizePixel = 0
	v10.LayoutOrder = -1
	v10.Name = "Description"
	v10.Size = UDim2.new(1, 0, 0, 20)
	v10.Parent = v3
	local v11 = Instance.new("TextButton")
	v11.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
	v11.BackgroundTransparency = 0.5
	v11.BorderSizePixel = 0
	v11.Font = Enum.Font.Code
	v11.Size = UDim2.new(1, 0, 0, 30)
	v11.Text = ""
	v11.TextColor3 = Color3.fromRGB(255, 255, 255)
	v11.TextSize = 14
	v11.TextXAlignment = Enum.TextXAlignment.Left
	v11.Parent = v3
	local v12 = Instance.new("UIListLayout")
	v12.FillDirection = Enum.FillDirection.Horizontal
	v12.SortOrder = Enum.SortOrder.LayoutOrder
	v12.Padding = UDim.new(0, 7)
	v12.Parent = v7
	local v13 = Instance.new("TextBox")
	v13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v13.BackgroundTransparency = 1
	v13.ClearTextOnFocus = false
	v13.Font = Enum.Font.Code
	v13.LayoutOrder = 999999999
	v13.Position = UDim2.new(0, 140, 0, 0)
	v13.Size = UDim2.new(1, 0, 0, 20)
	v13.Text = "x"
	v13.TextColor3 = Color3.fromRGB(255, 255, 255)
	v13.TextSize = 14
	v13.TextXAlignment = Enum.TextXAlignment.Left
	v13.Selectable = false
	v13.Parent = v7
	local v14 = Instance.new("TextLabel")
	v14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v14.BackgroundTransparency = 1
	v14.Font = Enum.Font.Code
	v14.Size = UDim2.new(0, 0, 0, 20)
	v14.AutomaticSize = Enum.AutomaticSize.X
	v14.Text = ""
	v14.TextColor3 = Color3.fromRGB(255, 223, 93)
	v14.TextSize = 14
	v14.TextXAlignment = Enum.TextXAlignment.Left
	v14.Parent = v7
	local v15 = Instance.new("TextLabel")
	v15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v15.BackgroundTransparency = 1
	v15.Font = Enum.Font.SourceSansBold
	v15.Name = "Field"
	v15.Size = UDim2.new(0, 37, 1, 0)
	v15.Text = "from"
	v15.TextColor3 = Color3.fromRGB(255, 255, 255)
	v15.TextSize = 20
	v15.TextXAlignment = Enum.TextXAlignment.Left
	v15.Parent = v9
	local v16 = Instance.new("UIPadding")
	v16.PaddingLeft = UDim.new(0, 10)
	v16.Parent = v9
	local v17 = Instance.new("TextLabel")
	v17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v17.BackgroundTransparency = 1
	v17.Font = Enum.Font.SourceSansLight
	v17.Name = "Label"
	v17.Size = UDim2.new(1, 0, 1, 0)
	v17.Text = "The players to teleport. The players to teleport. The players to teleport. The players to teleport. "
	v17.TextColor3 = Color3.fromRGB(255, 255, 255)
	v17.TextSize = 16
	v17.TextWrapped = true
	v17.TextXAlignment = Enum.TextXAlignment.Left
	v17.TextYAlignment = Enum.TextYAlignment.Top
	v17.Parent = v10
	local v18 = Instance.new("UIPadding")
	v18.PaddingBottom = UDim.new(0, 10)
	v18.PaddingLeft = UDim.new(0, 10)
	v18.PaddingRight = UDim.new(0, 10)
	v18.Parent = v10
	local v19 = Instance.new("TextLabel")
	v19.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v19.BackgroundTransparency = 1
	v19.Font = Enum.Font.Code
	v19.Name = "Typed"
	v19.Size = UDim2.new(1, 0, 1, 0)
	v19.Text = "Lab"
	v19.TextColor3 = Color3.fromRGB(131, 222, 255)
	v19.TextSize = 14
	v19.TextXAlignment = Enum.TextXAlignment.Left
	v19.Parent = v11
	local v20 = Instance.new("UIPadding")
	v20.PaddingLeft = UDim.new(0, 10)
	v20.Parent = v11
	local v21 = Instance.new("TextLabel")
	v21.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v21.BackgroundTransparency = 1
	v21.Font = Enum.Font.Code
	v21.Name = "Suggest"
	v21.Size = UDim2.new(1, 0, 1, 0)
	v21.Text = "   el"
	v21.TextColor3 = Color3.fromRGB(255, 255, 255)
	v21.TextSize = 14
	v21.TextXAlignment = Enum.TextXAlignment.Left
	v21.Parent = v11
	local v22 = Instance.new("TextLabel")
	v22.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v22.BackgroundTransparency = 1
	v22.BorderColor3 = Color3.fromRGB(255, 153, 153)
	v22.Font = Enum.Font.SourceSans
	v22.Name = "Type"
	v22.Position = UDim2.new(1, 0, 0, 0)
	v22.Size = UDim2.new(0, 0, 1, 0)
	v22.Text = ": Players"
	v22.TextColor3 = Color3.fromRGB(255, 255, 255)
	v22.TextSize = 15
	v22.TextXAlignment = Enum.TextXAlignment.Left
	v22.Parent = v15
	v1.Parent = game:GetService("StarterGui")
	return v1
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CreateGui]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3582"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("StarterGui")
local v_u_3 = require(script.Parent.CreateGui)
return function(p4)
	-- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_3
	local v5 = nil
	v5 = script.Parent.CmdrClient
	v5.Parent = v_u_1
	local v6 = Instance.new("RemoteFunction")
	v6.Name = "CmdrFunction"
	v6.Parent = v5
	local v7 = Instance.new("RemoteEvent")
	v7.Name = "CmdrEvent"
	v7.Parent = v5
	local v8 = Instance.new("Folder")
	v8.Name = "Commands"
	v8.Parent = v5
	local v9 = Instance.new("Folder")
	v9.Name = "Types"
	v9.Parent = v5
	script.Parent.Shared.Parent = v5
	p4.ReplicatedRoot = v5
	p4.RemoteFunction = v6
	p4.RemoteEvent = v7
	p4:RegisterTypesIn(script.Parent.BuiltInTypes)
	script.Parent.BuiltInTypes:Destroy()
	script.Parent.BuiltInCommands.Name = "Server commands"
	if v_u_2:FindFirstChild("Cmdr") == nil then
		v_u_3()
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Initialize]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="3583"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BuiltInCommands]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3584"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v12 = {
	["Name"] = "help",
	["Description"] = "Displays a list of all commands, or inspects one command.",
	["Group"] = "Help",
	["Args"] = {
		{
			["Type"] = "command",
			["Name"] = "Command",
			["Description"] = "The command to view information on",
			["Optional"] = true
		}
	},
	["ClientRun"] = function(p1, p2)
		if p2 then
			local v3 = p1.Cmdr.Registry:GetCommand(p2)
			p1:Reply(("Command: %*"):format(v3.Name), Color3.fromRGB(230, 126, 34))
			if v3.Aliases and #v3.Aliases > 0 then
				p1:Reply(("Aliases: %*"):format((table.concat(v3.Aliases, ", "))), Color3.fromRGB(230, 230, 230))
			end
			p1:Reply(v3.Description, Color3.fromRGB(230, 230, 230))
			for v4, v5 in ipairs(v3.Args) do
				p1:Reply((("#%* %*%*: %* - %*"):format(v4, v5.Name, v5.Optional == true and "?" or "", v5.Type, v5.Description)))
			end
		else
			p1:Reply("Argument Shorthands\n-------------------\n.   Me/Self\n*   All/Everyone\n**  Others\n?   Random\n?N  List of N random values\n")
			p1:Reply("Tips\n----\n\226\128\162 Utilize the Tab key to automatically complete commands\n\226\128\162 Easily select and copy command output\n")
			local v6 = p1.Cmdr.Registry:GetCommands()
			table.sort(v6, function(p7, p8)
				if p7.Group and p8.Group then
					return p7.Group < p8.Group
				else
					return p7.Group
				end
			end)
			local v9 = nil
			for _, v10 in ipairs(v6) do
				v10.Group = v10.Group or "No Group"
				if v9 ~= v10.Group then
					p1:Reply((("\n%*\n%*"):format(v10.Group, (string.rep("-", #v10.Group)))))
					v9 = v10.Group
				end
				local v11
				if v10.Description then
					v11 = ("%* - %*"):format(v10.Name, v10.Description)
				else
					v11 = v10.Name
				end
				p1:Reply(v11)
			end
		end
		return ""
	end
}
return v12]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[help]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="3585"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Admin]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3586"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "announce",
	["Aliases"] = { "m" },
	["Description"] = "Makes a server-wide announcement.",
	["Group"] = "DefaultAdmin",
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "text",
			["Description"] = "The announcement text."
		}
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[announce]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3587"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("TextService")
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("Chat")
return function(p4, p5)
	-- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_3
	local v6 = v_u_1:FilterStringAsync(p5, p4.Executor.UserId, Enum.TextFilterContext.PublicChat)
	for _, v7 in ipairs(v_u_2:GetPlayers()) do
		if v_u_3:CanUsersChatAsync(p4.Executor.UserId, v7.UserId) then
			p4:SendEvent(v7, "Message", v6:GetChatForUserAsync(v7.UserId), p4.Executor)
		end
	end
	return "Created announcement."
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[announceServer]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3588"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "goto-place",
	["Aliases"] = {},
	["Description"] = "Teleport to a Roblox place",
	["Group"] = "DefaultAdmin",
	["AutoExec"] = { "alias \"follow-player|Join a player in another server\" goto-place $1{players|Players} ${{get-player-place-instance $2{playerId|Target}}}", "alias \"rejoin|Rejoin this place. You might end up in a different server.\" goto-place $1{players|Players} ${get-player-place-instance ${me} PlaceId}" },
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "Players",
			["Description"] = "The players you want to teleport"
		},
		{
			["Type"] = "integer",
			["Name"] = "Place ID",
			["Description"] = "The Place ID you want to teleport to"
		},
		{
			["Type"] = "string",
			["Name"] = "JobId",
			["Description"] = "The specific JobId you want to teleport to",
			["Optional"] = true
		}
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[gotoPlace]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3589"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("TeleportService")
return function(p2, p3, p4, p5)
	-- upvalues: (copy) v_u_1
	local v6 = p3 or { p2.Executor }
	if p4 <= 0 then
		return "Invalid place ID"
	end
	if p5 == "-" then
		return "Invalid job ID"
	end
	p2:Reply("Commencing teleport...")
	if p5 then
		for _, v7 in ipairs(v6) do
			v_u_1:TeleportToPlaceInstance(p4, p5, v7)
		end
	else
		v_u_1:TeleportAsync(p4, v6)
	end
	return "Teleported."
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[gotoPlaceServer]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3590"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "kick",
	["Aliases"] = { "boot" },
	["Description"] = "Kicks a player or set of players.",
	["Group"] = "DefaultAdmin",
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "players",
			["Description"] = "The players to kick."
		}
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[kick]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3591"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(_, p1)
	for _, v2 in pairs(p1) do
		v2:Kick("Kicked by admin.")
	end
	return ("Kicked %d players."):format(#p1)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[kickServer]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3592"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "kill",
	["Aliases"] = { "slay" },
	["Description"] = "Kills a player or set of players.",
	["Group"] = "DefaultAdmin",
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "victims",
			["Description"] = "The players to kill."
		}
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[kill]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3593"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(_, p1)
	for _, v2 in pairs(p1) do
		if v2.Character then
			v2.Character:BreakJoints()
		end
	end
	return ("Killed %d players."):format(#p1)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[killServer]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3594"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "respawn",
	["Description"] = "Respawns a player or a group of players.",
	["Group"] = "DefaultAdmin",
	["AutoExec"] = { "alias \"refresh|Respawns the player and returns them to their previous location.\" var= .refresh_pos ${position $1{player|Player}} && respawn $1 && tp $1 @${{var .refresh_pos}}" },
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "targets",
			["Description"] = "The players to respawn."
		}
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[respawn]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3595"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(_, p1)
	for _, v2 in pairs(p1) do
		if v2.Character then
			v2:LoadCharacter()
		end
	end
	return ("Respawned %d players."):format(#p1)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[respawnServer]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3596"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "teleport",
	["Aliases"] = { "tp" },
	["Description"] = "Teleports a player or set of players to one target.",
	["Group"] = "DefaultAdmin",
	["AutoExec"] = { "alias \"bring|Brings a player or set of players to you.\" teleport $1{players|players|The players to bring} ${me}", "alias \"to|Teleports you to another player or location.\" teleport ${me} $1{player @ vector3|Destination|The player or location to teleport to}" },
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "From",
			["Description"] = "The players to teleport"
		},
		{
			["Type"] = "player @ vector3",
			["Name"] = "Destination",
			["Description"] = "The player to teleport to"
		}
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[teleport]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3597"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(_, p1, p2)
	local v3 = nil
	if typeof(p2) == "Instance" then
		if not (p2.Character and p2.Character:FindFirstChild("HumanoidRootPart")) then
			return "Target player has no character."
		end
		v3 = p2.Character.HumanoidRootPart.CFrame
	elseif typeof(p2) == "Vector3" then
		v3 = CFrame.new(p2)
	end
	for _, v4 in ipairs(p1) do
		if v4.Character and v4.Character:FindFirstChild("HumanoidRootPart") then
			v4.Character.HumanoidRootPart.CFrame = v3
		end
	end
	return ("Teleported %d players."):format(#p1)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[teleportServer]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3598"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Debug]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3599"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Name"] = "blink",
	["Aliases"] = { "b" },
	["Description"] = "Teleports you to where your mouse is hovering.",
	["Group"] = "DefaultDebug",
	["Args"] = {},
	["ClientRun"] = function(p1)
		local v2 = p1.Executor:GetMouse()
		local v3 = p1.Executor.Character
		if not v3 then
			return "You don\'t have a character."
		end
		v3:MoveTo(v2.Hit.p)
		return "Blinked!"
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[blink]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3600"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "fetch",
	["Aliases"] = {},
	["Description"] = "Fetch a value from the Internet",
	["Group"] = "DefaultDebug",
	["Args"] = {
		{
			["Type"] = "url",
			["Name"] = "URL",
			["Description"] = "The URL to fetch."
		}
	}
}
return v1]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[fetch]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3601"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("HttpService")
return function(_, p2)
	-- upvalues: (copy) v_u_1
	return v_u_1:GetAsync(p2)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[fetchServer]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3602"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v2 = {
	["Name"] = "get-player-place-instance",
	["Aliases"] = {},
	["Description"] = "Returns the target player\'s Place ID and the JobId separated by a space. Returns 0 if the player is offline or something else goes wrong.",
	["Group"] = "DefaultDebug",
	["Args"] = {
		{
			["Type"] = "playerId",
			["Name"] = "Player",
			["Description"] = "Get the place instance of this player"
		},
		function(p1)
			return {
				["Type"] = p1.Cmdr.Util.MakeEnumType("PlaceInstance Format", { "PlaceIdJobId", "PlaceId", "JobId" }),
				["Name"] = "Format",
				["Description"] = "What data to return. PlaceIdJobId returns both separated by a space.",
				["Default"] = "PlaceIdJobId"
			}
		end
	}
}
return v2]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[getPlayerPlaceInstance]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3603"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("TeleportService")
return function(_, p_u_2, p3)
	-- upvalues: (copy) v_u_1
	local v4 = p3 or "PlaceIdJobId"
	local v5, _, v6, v7, v8 = pcall(function()
		-- upvalues: (ref) v_u_1, (copy) p_u_2
		return v_u_1:GetPlayerPlaceInstanceAsync(p_u_2)
	end)
	if not v5 or v6 and #v6 > 0 then
		if v4 == "PlaceIdJobId" then
			return "0 -"
		end
		if v4 == "PlaceId" then
			return "0"
		end
		if v4 == "JobId" then
			return "-"
		end
	end
	if v4 == "PlaceIdJobId" then
		return v7 .. " " .. v8
	end
	if v4 == "PlaceId" then
		return tostring(v7)
	end
	if v4 == "JobId" then
		return tostring(v8)
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[getPlayerPlaceInstanceServer]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3604"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v4 = {
	["Name"] = "position",
	["Aliases"] = { "pos" },
	["Description"] = "Returns Vector3 position of you or other players. Empty string is the player has no character.",
	["Group"] = "DefaultDebug",
	["Args"] = {
		{
			["Type"] = "player",
			["Name"] = "Player",
			["Description"] = "The player to report the position of. Omit for your own position.",
			["Default"] = game:GetService("Players").LocalPlayer
		}
	},
	["ClientRun"] = function(_, p1)
		local v2 = p1.Character
		if not (v2 and v2:FindFirstChild("HumanoidRootPart")) then
			return ""
		end
		local v3 = v2.HumanoidRootPart.Position
		return tostring(v3):gsub("%s", "")
	end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[position]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3605"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v7 = {
	["Name"] = "thru",
	["Aliases"] = { "t", "through" },
	["Description"] = "Teleports you through whatever your mouse is hovering over, placing you equidistantly from the wall.",
	["Group"] = "DefaultDebug",
	["Args"] = {
		{
			["Type"] = "number",
			["Name"] = "Extra distance",
			["Description"] = "Go through the wall an additional X studs.",
			["Default"] = 0
		}
	},
	["ClientRun"] = function(p1, p2)
		local v3 = p1.Executor:GetMouse()
		local v4 = p1.Executor.Character
		if not (v4 and v4:FindFirstChild("HumanoidRootPart")) then
			return "You don\'t have a character."
		end
		local v5 = v4.HumanoidRootPart.Position
		local v6 = v3.Hit.p - v5
		v4:MoveTo(v6 * 2 + v6.unit * p2 + v5)
		return "Blinked!"
	end
}
return v7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[thru]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3606"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Name"] = "uptime",
	["Aliases"] = {},
	["Description"] = "Returns the amount of time the server has been running.",
	["Group"] = "DefaultDebug",
	["Args"] = {}
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[uptime]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3607"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = os.time()
return function()
	-- upvalues: (copy) v_u_1
	local v2 = os.time() - v_u_1
	local v3 = v2 / 86400
	local v4 = math.floor(v3)
	local v5 = v2 / 3600
	local v6 = math.floor(v5) % 24
	local v7 = v2 / 60
	return ("%dd %dh %dm %ds"):format(v4, v6, math.floor(v7) % 60, math.floor(v2) % 60)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[uptimeServer]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3608"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Name"] = "version",
	["Args"] = {},
	["Description"] = "Shows the current version of Cmdr",
	["Group"] = "DefaultDebug",
	["Run"] = function()
		return ("Cmdr Version %s"):format("v1.12.0")
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[version]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3609"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Utility]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3610"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v4 = {
	["Name"] = "alias",
	["Aliases"] = {},
	["Description"] = "Creates a new, single command out of a command and given arguments.",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "Alias name",
			["Description"] = "The key or input type you\'d like to bind the command to."
		},
		{
			["Type"] = "string",
			["Name"] = "Command string",
			["Description"] = "The command text you want to run. Separate multiple commands with \"&&\". Accept arguments with $1, $2, $3, etc."
		}
	},
	["ClientRun"] = function(p1, p2, p3)
		p1.Cmdr.Registry:RegisterCommandObject(p1.Cmdr.Util.MakeAliasCommand(p2, p3), true)
		return ("Created alias %q"):format(p2)
	end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[alias]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3611"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("UserInputService")
local v13 = {
	["Name"] = "bind",
	["Aliases"] = {},
	["Description"] = "Binds a command string to a key or mouse input.",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "userInput ! bindableResource @ player",
			["Name"] = "Input",
			["Description"] = "The key or input type you\'d like to bind the command to."
		},
		{
			["Type"] = "command",
			["Name"] = "Command",
			["Description"] = "The command you want to run on this input"
		},
		{
			["Type"] = "string",
			["Name"] = "Arguments",
			["Description"] = "The arguments for the command",
			["Default"] = ""
		}
	},
	["ClientRun"] = function(p_u_2, p_u_3, p4, p5)
		-- upvalues: (copy) v_u_1
		local v6 = p_u_2:GetStore("CMDR_Binds")
		local v_u_7 = p4 .. " " .. p5
		if v6[p_u_3] then
			v6[p_u_3]:Disconnect()
		end
		local v8 = p_u_2:GetArgument(1).Type.Name
		if v8 == "userInput" then
			v6[p_u_3] = v_u_1.InputBegan:Connect(function(p9, p10)
				-- upvalues: (copy) p_u_3, (copy) p_u_2, (ref) v_u_7
				if not p10 then
					if p9.UserInputType == p_u_3 or p9.KeyCode == p_u_3 then
						p_u_2:Reply(p_u_2.Dispatcher:EvaluateAndRun(p_u_2.Cmdr.Util.RunEmbeddedCommands(p_u_2.Dispatcher, v_u_7)))
					end
				end
			end)
		else
			if v8 == "bindableResource" then
				return "Unimplemented..."
			end
			if v8 == "player" then
				v6[p_u_3] = p_u_3.Chatted:Connect(function(p11)
					-- upvalues: (copy) p_u_2, (ref) v_u_7, (copy) p_u_3
					local v12 = p_u_2.Cmdr.Util.RunEmbeddedCommands(p_u_2.Dispatcher, p_u_2.Cmdr.Util.SubstituteArgs(v_u_7, { p11 }))
					p_u_2:Reply(("%s $ %s : %s"):format(p_u_3.Name, v12, p_u_2.Dispatcher:EvaluateAndRun(v12)), Color3.fromRGB(244, 92, 66))
				end)
			end
		end
		return "Bound command to input."
	end
}
return v13]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[bind]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3612"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
return {
	["Name"] = "clear",
	["Aliases"] = {},
	["Description"] = "Clear all lines above the entry line of the Cmdr window.",
	["Group"] = "DefaultUtil",
	["Args"] = {},
	["ClientRun"] = function()
		-- upvalues: (copy) v_u_1
		local v2 = v_u_1.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Cmdr")
		local v3 = v2:WaitForChild("Frame")
		if v2 and v3 then
			for _, v4 in pairs(v3:GetChildren()) do
				if v4.Name == "Line" and v4:IsA("TextBox") then
					v4:Destroy()
				end
			end
		end
		return ""
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[clear]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3613"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v3 = {
	["Name"] = "convertTimestamp",
	["Aliases"] = { "date" },
	["Description"] = "Convert a timestamp to a human-readable format.",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "number",
			["Name"] = "timestamp",
			["Description"] = "A numerical representation of a specific moment in time.",
			["Optional"] = true
		}
	},
	["ClientRun"] = function(_, p1)
		local v2 = p1 or os.time()
		return ("%* %*"):format(os.date("%x", v2), (os.date("%X", v2)))
	end
}
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[convertTimestamp]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3614"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v2 = {
	["Name"] = "echo",
	["Aliases"] = { "=" },
	["Description"] = "Echoes your text back to you.",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "Text",
			["Description"] = "The text."
		}
	},
	["Run"] = function(_, p1)
		return p1
	end
}
return v2]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[echo]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3615"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v_u_2 = {
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.fromRGB(17, 17, 17),
	["BackgroundTransparency"] = 0.05,
	["BorderColor3"] = Color3.fromRGB(17, 17, 17),
	["BorderSizePixel"] = 20,
	["ClearTextOnFocus"] = false,
	["MultiLine"] = true,
	["Position"] = UDim2.new(0.5, 0, 0.5, 0),
	["Size"] = UDim2.new(0.5, 0, 0.4, 0),
	["Font"] = Enum.Font.Code,
	["TextColor3"] = Color3.fromRGB(241, 241, 241),
	["TextWrapped"] = true,
	["TextSize"] = 18,
	["TextXAlignment"] = "Left",
	["TextYAlignment"] = "Top",
	["AutoLocalize"] = false,
	["PlaceholderText"] = "Right click to exit"
}
local v_u_3 = nil
local v14 = {
	["Name"] = "edit",
	["Aliases"] = {},
	["Description"] = "Edit text in a TextBox",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "Input text",
			["Description"] = "The text you wish to edit",
			["Default"] = ""
		},
		{
			["Type"] = "string",
			["Name"] = "Delimiter",
			["Description"] = "The character that separates each line",
			["Default"] = ","
		}
	},
	["ClientRun"] = function(p4, p5, p_u_6)
		-- upvalues: (ref) v_u_3, (copy) v_u_2, (copy) v_u_1
		v_u_3 = v_u_3 or p4.Cmdr.Util.Mutex()
		local v_u_7 = v_u_3()
		p4:Reply("Right-click on the text area to exit.", Color3.fromRGB(158, 158, 158))
		local v_u_8 = Instance.new("ScreenGui")
		v_u_8.Name = "CmdrEditBox"
		v_u_8.ResetOnSpawn = false
		local v_u_9 = Instance.new("TextBox")
		for v10, v11 in pairs(v_u_2) do
			v_u_9[v10] = v11
		end
		v_u_9.Text = p5:gsub(p_u_6, "\n")
		v_u_9.Parent = v_u_8
		v_u_8.Parent = v_u_1.LocalPlayer:WaitForChild("PlayerGui")
		local v_u_12 = coroutine.running()
		v_u_9.InputBegan:Connect(function(p13)
			-- upvalues: (copy) v_u_12, (copy) v_u_9, (copy) p_u_6, (copy) v_u_8, (copy) v_u_7
			if p13.UserInputType == Enum.UserInputType.MouseButton2 then
				coroutine.resume(v_u_12, v_u_9.Text:gsub("\n", p_u_6))
				v_u_8:Destroy()
				v_u_7()
			end
		end)
		return coroutine.yield()
	end
}
return v14]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[edit]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3616"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v4 = {
	["Name"] = "history",
	["Aliases"] = {},
	["AutoExec"] = { "alias \"!|Displays previous command from history.\" run ${history $1{number|Line Number}}", "alias \"^|Runs the previous command, replacing all occurrences of A with B.\" run ${run replace ${history -1} $1{string|A} $2{string|B}}", "alias \"!!|Reruns the last command.\" ! -1" },
	["Description"] = "Displays previous commands from history.",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "integer",
			["Name"] = "Line Number",
			["Description"] = "Command line number (can be negative to go from end)"
		}
	},
	["ClientRun"] = function(p1, p2)
		local v3 = p1.Dispatcher:GetHistory()
		if p2 <= 0 then
			p2 = #v3 + p2
		end
		return v3[p2] or ""
	end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[history]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3617"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
return {
	["Name"] = "hover",
	["Description"] = "Returns the name of the player you are hovering over.",
	["Group"] = "DefaultUtil",
	["Args"] = {},
	["ClientRun"] = function()
		-- upvalues: (copy) v_u_1
		local v2 = v_u_1.LocalPlayer:GetMouse().Target
		if not v2 then
			return ""
		end
		local v3 = v_u_1:GetPlayerFromCharacter(v2:FindFirstAncestorOfClass("Model"))
		return v3 and v3.Name or ""
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[hover]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3618"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v3 = {
	["Name"] = "json-array-decode",
	["Aliases"] = {},
	["Description"] = "Decodes a JSON Array into a comma-separated list",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "json",
			["Name"] = "JSON",
			["Description"] = "The JSON array."
		}
	},
	["ClientRun"] = function(_, p1)
		local v2 = type(p1) ~= "table" and { p1 } or p1
		return table.concat(v2, ",")
	end
}
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[jsonArrayDecode]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3619"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("HttpService")
local v3 = {
	["Name"] = "json-array-encode",
	["Aliases"] = {},
	["Description"] = "Encodes a comma-separated list into a JSON array",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "CSV",
			["Description"] = "The comma-separated list"
		}
	},
	["Run"] = function(_, p2)
		-- upvalues: (copy) v_u_1
		return v_u_1:JSONEncode(p2:split(","))
	end
}
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[jsonArrayEncode]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3620"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v2 = {
	["Name"] = "len",
	["Aliases"] = {},
	["Description"] = "Returns the length of a comma-separated list",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "CSV",
			["Description"] = "The comma-separated list"
		}
	},
	["Run"] = function(_, p1)
		return #p1:split(",")
	end
}
return v2]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[len]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3621"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v4 = {
	["Name"] = "math",
	["Aliases"] = {},
	["Description"] = "Perform a math operation on 2 values.",
	["Group"] = "DefaultUtil",
	["AutoExec"] = {
		"alias \"+|Perform an addition.\" math + $1{number|Number} $2{number|Number}",
		"alias \"-|Perform a subtraction.\" math - $1{number|Number} $2{number|Number}",
		"alias \"*|Perform a multiplication.\" math * $1{number|Number} $2{number|Number}",
		"alias \"/|Perform a division.\" math / $1{number|Number} $2{number|Number}",
		"alias \"**|Perform an exponentiation.\" math ** $1{number|Number} $2{number|Number}",
		"alias \"%|Perform a modulus.\" math % $1{number|Number} $2{number|Number}"
	},
	["Args"] = {
		{
			["Type"] = "mathOperator",
			["Name"] = "Operation",
			["Description"] = "A math operation."
		},
		{
			["Type"] = "number",
			["Name"] = "Value",
			["Description"] = "A number value."
		},
		{
			["Type"] = "number",
			["Name"] = "Value",
			["Description"] = "A number value."
		}
	},
	["ClientRun"] = function(_, p1, p2, p3)
		return p1.Perform(p2, p3)
	end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[math]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3622"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v3 = {
	["Name"] = "pick",
	["Aliases"] = {},
	["Description"] = "Picks a value out of a comma-separated list.",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "integer",
			["Name"] = "Index to pick",
			["Description"] = "The index of the item you want to pick"
		},
		{
			["Type"] = "string",
			["Name"] = "CSV",
			["Description"] = "The comma-separated list"
		}
	},
	["Run"] = function(_, p1, p2)
		return p2:split(",")[p1] or ""
	end
}
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[pick]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3623"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v4 = {
	["Name"] = "rand",
	["Aliases"] = {},
	["Description"] = "Returns a random number between min and max",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "integer",
			["Name"] = "First number",
			["Description"] = "If second number is nil, random number is between 1 and this value. If second number is provided, number is between this number and the second number."
		},
		{
			["Type"] = "integer",
			["Name"] = "Second number",
			["Description"] = "The upper bound.",
			["Optional"] = true
		}
	},
	["Run"] = function(_, p1, p2)
		local v3 = p2 and math.random(p1, p2) or math.random(p1)
		return tostring(v3)
	end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[rand]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3624"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v4 = {
	["Name"] = "replace",
	["Aliases"] = { "gsub", "//" },
	["Description"] = "Replaces text A with text B",
	["Group"] = "DefaultUtil",
	["AutoExec"] = { "alias \"map|Maps a CSV into another CSV\" replace $1{string|CSV} ([^,]+) \"$2{string|mapped value|Use %1 to insert the element}\"", "alias \"join|Joins a CSV with a specified delimiter\" replace $1{string|CSV} , $2{string|Delimiter}" },
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "Haystack",
			["Description"] = "The source string upon which to perform replacement."
		},
		{
			["Type"] = "string",
			["Name"] = "Needle",
			["Description"] = "The string pattern search for."
		},
		{
			["Type"] = "string",
			["Name"] = "Replacement",
			["Description"] = "The string to replace matches (%1 to insert matches).",
			["Default"] = ""
		}
	},
	["Run"] = function(_, p1, p2, p3)
		return p1:gsub(p2, p3)
	end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[replace]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3625"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v3 = {
	["Name"] = "resolve",
	["Aliases"] = {},
	["Description"] = "Resolves Argument Value Operators into lists. E.g., resolve players * gives you a list of all players.",
	["Group"] = "DefaultUtil",
	["AutoExec"] = { "alias \"me|Displays your username\" resolve players ." },
	["Args"] = {
		{
			["Type"] = "type",
			["Name"] = "Type",
			["Description"] = "The type for which to resolve"
		},
		function(p1)
			if p1:GetArgument(1):Validate() ~= false then
				return {
					["Type"] = p1:GetArgument(1):GetValue(),
					["Name"] = "Argument Value Operator",
					["Description"] = "The value operator to resolve. One of: * ** . ? ?N",
					["Optional"] = true
				}
			end
		end
	},
	["Run"] = function(p2)
		return table.concat(p2:GetArgument(2).RawSegments, ",")
	end
}
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[resolve]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3626"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v3 = {
	["Name"] = "run",
	["Aliases"] = { ">" },
	["AutoExec"] = { "alias \"discard|Run a command and discard the output.\" replace ${run $1} .* \\\"\\\"" },
	["Description"] = "Runs a given command string (replacing embedded commands).",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "Command",
			["Description"] = "The command string to run"
		}
	},
	["Run"] = function(p1, p2)
		return p1.Cmdr.Util.RunCommandString(p1.Dispatcher, p2)
	end
}
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[run]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3627"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v7 = {
	["Name"] = "run-lines",
	["Aliases"] = {},
	["Description"] = "Splits input by newlines and runs each line as its own command. This is used by the init-run command.",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "Script",
			["Description"] = "The script to parse.",
			["Default"] = ""
		}
	},
	["ClientRun"] = function(p1, p2)
		if #p2 == 0 then
			return ""
		end
		local v3 = p1.Dispatcher:Run("var", "INIT_PRINT_OUTPUT") ~= ""
		local v4 = p2:gsub("\n+", "\n"):split("\n")
		for _, v5 in ipairs(v4) do
			if v5:sub(1, 1) ~= "#" then
				local v6 = p1.Dispatcher:EvaluateAndRun(v5)
				if v3 then
					p1:Reply(v6)
				end
			end
		end
		return ""
	end
}
return v7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[runLines]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3628"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_3 = {
	["startsWith"] = function(p1, p2)
		if p1:sub(1, #p2) == p2 then
			return p1:sub(#p2 + 1)
		end
	end
}
local v11 = {
	["Name"] = "runif",
	["Aliases"] = {},
	["Description"] = "Runs a given command string if a certain condition is met.",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "conditionFunction",
			["Name"] = "Condition",
			["Description"] = "The condition function"
		},
		{
			["Type"] = "string",
			["Name"] = "Argument",
			["Description"] = "The argument to the condition function"
		},
		{
			["Type"] = "string",
			["Name"] = "Test against",
			["Description"] = "The text to test against."
		},
		{
			["Type"] = "string",
			["Name"] = "Command",
			["Description"] = "The command string to run if requirements are met. If omitted, return value from condition function is used.",
			["Optional"] = true
		}
	},
	["Run"] = function(p4, p5, p6, p7, p8)
		-- upvalues: (copy) v_u_3
		local v9 = v_u_3[p5]
		if not v9 then
			return ("Condition %q is not valid."):format(p5)
		end
		local v10 = v9(p7, p6)
		return not v10 and "" or p4.Dispatcher:EvaluateAndRun(p4.Cmdr.Util.RunEmbeddedCommands(p4.Dispatcher, p8 or v10))
	end
}
return v11]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[runif]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3629"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v4 = {
	["Name"] = "unbind",
	["Aliases"] = {},
	["Description"] = "Unbinds an input previously bound with Bind",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "userInput ! bindableResource @ player",
			["Name"] = "Input/Key",
			["Description"] = "The key or input type you\'d like to unbind."
		}
	},
	["ClientRun"] = function(p1, p2)
		local v3 = p1:GetStore("CMDR_Binds")
		if not v3[p2] then
			return "That input wasn\'t bound."
		end
		v3[p2]:Disconnect()
		v3[p2] = nil
		return "Unbound command from input."
	end
}
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[unbind]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3630"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v3 = {
	["Name"] = "var",
	["Aliases"] = {},
	["Description"] = "Gets a stored variable.",
	["Group"] = "DefaultUtil",
	["AutoExec"] = { "alias \"init-edit|Edit your initialization script\" edit ${var init} \\\\\n && var= init ||", "alias \"init-run|Re-runs the initialization script manually.\" run-lines ${var init}", "init-run" },
	["Args"] = {
		{
			["Type"] = "storedKey",
			["Name"] = "Key",
			["Description"] = "The key to get, retrieved from your user data store. Keys prefixed with . are not saved. Keys prefixed with $ are game-wide. Keys prefixed with $. are game-wide and non-saved."
		}
	},
	["ClientRun"] = function(p1, p2)
		p1:GetStore("vars_used")[p2] = true
	end
}
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[var]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3631"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("DataStoreService")
local v_u_2 = {}
local v_u_3 = nil
local v_u_4 = nil
task.spawn(function()
	-- upvalues: (ref) v_u_3, (ref) v_u_4, (copy) v_u_1, (copy) v_u_2
	local v6, v7 = pcall(function()
		-- upvalues: (ref) v_u_1
		local v5 = v_u_1:GetDataStore("_package/eryn.io/Cmdr")
		v5:GetAsync("test_key")
		return v5
	end)
	v_u_3 = v6
	v_u_4 = v7
	while #v_u_2 > 0 do
		coroutine.resume(table.remove(v_u_2, 1))
	end
end)
return function(p8, p9)
	-- upvalues: (ref) v_u_3, (copy) v_u_2, (ref) v_u_4
	if v_u_3 == nil then
		local v10 = v_u_2
		local v11 = coroutine.running
		table.insert(v10, v11())
		coroutine.yield()
	end
	local v12 = true
	local v13
	if p9:sub(1, 1) == "$" then
		p9 = p9:sub(2)
		v13 = true
	else
		v13 = false
	end
	if p9:sub(1, 1) == "." then
		p9 = p9:sub(2)
		v12 = false
	end
	if v12 and not v_u_3 then
		return "# You must publish this place to the web to use saved keys."
	else
		local v14 = "var_"
		local v15
		if v13 then
			v15 = "global"
		else
			local v16 = p8.Executor.UserId
			v15 = tostring(v16)
		end
		local v17 = v14 .. v15
		if v12 then
			local v18 = v_u_4:GetAsync(v17 .. "_" .. p9) or ""
			return type(v18) == "table" and (table.concat(v18, ",") or "") or v18
		else
			local v19 = p8:GetStore(v17)[p9] or ""
			return type(v19) == "table" and (table.concat(v19, ",") or "") or v19
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[varServer]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3632"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v3 = {
	["Name"] = "var=",
	["Aliases"] = {},
	["Description"] = "Sets a stored value.",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "storedKey",
			["Name"] = "Key",
			["Description"] = "The key to set, saved in your user data store. Keys prefixed with . are not saved. Keys prefixed with $ are game-wide. Keys prefixed with $. are game-wide and non-saved."
		},
		{
			["Type"] = "string",
			["Name"] = "Value",
			["Description"] = "Value or values to set.",
			["Default"] = ""
		}
	},
	["ClientRun"] = function(p1, p2)
		p1:GetStore("vars_used")[p2] = true
	end
}
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[varSet]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3633"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("DataStoreService")
local v_u_2 = {}
local v_u_3 = nil
local v_u_4 = nil
task.spawn(function()
	-- upvalues: (ref) v_u_3, (ref) v_u_4, (copy) v_u_1, (copy) v_u_2
	local v6, v7 = pcall(function()
		-- upvalues: (ref) v_u_1
		local v5 = v_u_1:GetDataStore("_package/eryn.io/Cmdr")
		v5:GetAsync("test_key")
		return v5
	end)
	v_u_3 = v6
	v_u_4 = v7
	while #v_u_2 > 0 do
		coroutine.resume(table.remove(v_u_2, 1))
	end
end)
return function(p8, p9, p10)
	-- upvalues: (ref) v_u_3, (copy) v_u_2, (ref) v_u_4
	if v_u_3 == nil then
		local v11 = v_u_2
		local v12 = coroutine.running
		table.insert(v11, v12())
		coroutine.yield()
	end
	local v13 = true
	local v14
	if p9:sub(1, 1) == "$" then
		p9 = p9:sub(2)
		v14 = true
	else
		v14 = false
	end
	if p9:sub(1, 1) == "." then
		p9 = p9:sub(2)
		v13 = false
	end
	if v13 and not v_u_3 then
		return "# You must publish this place to the web to use saved keys."
	else
		local v15 = "var_"
		local v16
		if v14 then
			v16 = "global"
		else
			local v17 = p8.Executor.UserId
			v16 = tostring(v17)
		end
		local v18 = v15 .. v16
		if v13 then
			v_u_4:SetAsync(v18 .. "_" .. p9, p10)
			return type(p10) == "table" and (table.concat(p10, ",") or "") or p10
		else
			p8:GetStore(v18)[p9] = p10
			return type(p10) == "table" and (table.concat(p10, ",") or "") or p10
		end
	end
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[varSetServer]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3634"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BuiltInTypes]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3635"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	p1:RegisterType("bindableResource", p1.Cmdr.Util.MakeEnumType("BindableResource", { "Chat" }))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BindableResource]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3636"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Shared.Util)
local v_u_2 = v_u_1.MakeFuzzyFinder({
	"White",
	"Grey",
	"Light yellow",
	"Brick yellow",
	"Light green (Mint)",
	"Light reddish violet",
	"Pastel Blue",
	"Light orange brown",
	"Nougat",
	"Bright red",
	"Med. reddish violet",
	"Bright blue",
	"Bright yellow",
	"Earth orange",
	"Black",
	"Dark grey",
	"Dark green",
	"Medium green",
	"Lig. Yellowich orange",
	"Bright green",
	"Dark orange",
	"Light bluish violet",
	"Transparent",
	"Tr. Red",
	"Tr. Lg blue",
	"Tr. Blue",
	"Tr. Yellow",
	"Light blue",
	"Tr. Flu. Reddish orange",
	"Tr. Green",
	"Tr. Flu. Green",
	"Phosph. White",
	"Light red",
	"Medium red",
	"Medium blue",
	"Light grey",
	"Bright violet",
	"Br. yellowish orange",
	"Bright orange",
	"Bright bluish green",
	"Earth yellow",
	"Bright bluish violet",
	"Tr. Brown",
	"Medium bluish violet",
	"Tr. Medi. reddish violet",
	"Med. yellowish green",
	"Med. bluish green",
	"Light bluish green",
	"Br. yellowish green",
	"Lig. yellowish green",
	"Med. yellowish orange",
	"Br. reddish orange",
	"Bright reddish violet",
	"Light orange",
	"Tr. Bright bluish violet",
	"Gold",
	"Dark nougat",
	"Silver",
	"Neon orange",
	"Neon green",
	"Sand blue",
	"Sand violet",
	"Medium orange",
	"Sand yellow",
	"Earth blue",
	"Earth green",
	"Tr. Flu. Blue",
	"Sand blue metallic",
	"Sand violet metallic",
	"Sand yellow metallic",
	"Dark grey metallic",
	"Black metallic",
	"Light grey metallic",
	"Sand green",
	"Sand red",
	"Dark red",
	"Tr. Flu. Yellow",
	"Tr. Flu. Red",
	"Gun metallic",
	"Red flip/flop",
	"Yellow flip/flop",
	"Silver flip/flop",
	"Curry",
	"Fire Yellow",
	"Flame yellowish orange",
	"Reddish brown",
	"Flame reddish orange",
	"Medium stone grey",
	"Royal blue",
	"Dark Royal blue",
	"Bright reddish lilac",
	"Dark stone grey",
	"Lemon metalic",
	"Light stone grey",
	"Dark Curry",
	"Faded green",
	"Turquoise",
	"Light Royal blue",
	"Medium Royal blue",
	"Rust",
	"Brown",
	"Reddish lilac",
	"Lilac",
	"Light lilac",
	"Bright purple",
	"Light purple",
	"Light pink",
	"Light brick yellow",
	"Warm yellowish orange",
	"Cool yellow",
	"Dove blue",
	"Medium lilac",
	"Slime green",
	"Smoky grey",
	"Dark blue",
	"Parsley green",
	"Steel blue",
	"Storm blue",
	"Lapis",
	"Dark indigo",
	"Sea green",
	"Shamrock",
	"Fossil",
	"Mulberry",
	"Forest green",
	"Cadet blue",
	"Electric blue",
	"Eggplant",
	"Moss",
	"Artichoke",
	"Sage green",
	"Ghost grey",
	"Lilac",
	"Plum",
	"Olivine",
	"Laurel green",
	"Quill grey",
	"Crimson",
	"Mint",
	"Baby blue",
	"Carnation pink",
	"Persimmon",
	"Maroon",
	"Gold",
	"Daisy orange",
	"Pearl",
	"Fog",
	"Salmon",
	"Terra Cotta",
	"Cocoa",
	"Wheat",
	"Buttermilk",
	"Mauve",
	"Sunrise",
	"Tawny",
	"Rust",
	"Cashmere",
	"Khaki",
	"Lily white",
	"Seashell",
	"Burgundy",
	"Cork",
	"Burlap",
	"Beige",
	"Oyster",
	"Pine Cone",
	"Fawn brown",
	"Hurricane grey",
	"Cloudy grey",
	"Linen",
	"Copper",
	"Dirt brown",
	"Bronze",
	"Flint",
	"Dark taupe",
	"Burnt Sienna",
	"Institutional white",
	"Mid gray",
	"Really black",
	"Really red",
	"Deep orange",
	"Alder",
	"Dusty Rose",
	"Olive",
	"New Yeller",
	"Really blue",
	"Navy blue",
	"Deep blue",
	"Cyan",
	"CGA brown",
	"Magenta",
	"Pink",
	"Deep orange",
	"Teal",
	"Toothpaste",
	"Lime green",
	"Camo",
	"Grime",
	"Lavender",
	"Pastel light blue",
	"Pastel orange",
	"Pastel violet",
	"Pastel blue-green",
	"Pastel green",
	"Pastel yellow",
	"Pastel brown",
	"Royal purple",
	"Hot pink"
})
local v_u_10 = {
	["Prefixes"] = "% teamColor",
	["Transform"] = function(p3)
		-- upvalues: (copy) v_u_2
		local v4 = {}
		for v5, v6 in pairs(v_u_2(p3)) do
			v4[v5] = BrickColor.new(v6)
		end
		return v4
	end,
	["Validate"] = function(p7)
		return #p7 > 0, "No valid brick colors with that name could be found."
	end,
	["Autocomplete"] = function(p8)
		-- upvalues: (copy) v_u_1
		return v_u_1.GetNames(p8)
	end,
	["Parse"] = function(p9)
		return p9[1]
	end
}
local v_u_12 = {
	["Transform"] = v_u_10.Transform,
	["Validate"] = v_u_10.Validate,
	["Autocomplete"] = v_u_10.Autocomplete,
	["Parse"] = function(p11)
		return p11[1].Color
	end
}
return function(p13)
	-- upvalues: (copy) v_u_10, (copy) v_u_1, (copy) v_u_12
	p13:RegisterType("brickColor", v_u_10)
	p13:RegisterType("brickColors", v_u_1.MakeListableType(v_u_10, {
		["Prefixes"] = "% teamColors"
	}))
	p13:RegisterType("brickColor3", v_u_12)
	p13:RegisterType("brickColor3s", v_u_1.MakeListableType(v_u_12))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BrickColor]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3637"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Shared.Util)
local v_u_4 = v_u_1.MakeSequenceType({
	["Prefixes"] = "# hexColor3 ! brickColor3",
	["ValidateEach"] = function(p2, p3)
		if p2 == nil then
			return false, ("Invalid or missing number at position %d in Color3 type."):format(p3)
		elseif p2 < 0 or p2 > 255 then
			return false, ("Number out of acceptable range 0-255 at position %d in Color3 type."):format(p3)
		elseif p2 % 1 == 0 then
			return true
		else
			return false, ("Number is not an integer at position %d in Color3 type."):format(p3)
		end
	end,
	["TransformEach"] = tonumber,
	["Constructor"] = Color3.fromRGB,
	["Length"] = 3
})
local function v_u_6(p5)
	if #p5 == 1 then
		p5 = p5 .. p5
	end
	return tonumber(p5, 16)
end
local v_u_15 = {
	["Transform"] = function(p7)
		-- upvalues: (copy) v_u_1, (copy) v_u_6
		local v8, v9, v10 = p7:match("^#?(%x%x?)(%x%x?)(%x%x?)$")
		return v_u_1.Each(v_u_6, v8, v9, v10)
	end,
	["Validate"] = function(p11, p12, p13)
		local v14
		if p11 == nil or p12 == nil then
			v14 = false
		else
			v14 = p13 ~= nil
		end
		return v14, "Invalid hex color"
	end,
	["Parse"] = function(...)
		return Color3.fromRGB(...)
	end
}
return function(p16)
	-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_15
	p16:RegisterType("color3", v_u_4)
	p16:RegisterType("color3s", v_u_1.MakeListableType(v_u_4, {
		["Prefixes"] = "# hexColor3s ! brickColor3s"
	}))
	p16:RegisterType("hexColor3", v_u_15)
	p16:RegisterType("hexColor3s", v_u_1.MakeListableType(v_u_15))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Color3]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3638"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Shared.Util)
return function(p_u_2)
	-- upvalues: (copy) v_u_1
	local v7 = {
		["Transform"] = function(p3)
			-- upvalues: (ref) v_u_1, (copy) p_u_2
			return v_u_1.MakeFuzzyFinder(p_u_2:GetCommandNames())(p3)
		end,
		["Validate"] = function(p4)
			return #p4 > 0, "No command with that name could be found."
		end,
		["Autocomplete"] = function(p5)
			return p5
		end,
		["Parse"] = function(p6)
			return p6[1]
		end
	}
	p_u_2:RegisterType("command", v7)
	p_u_2:RegisterType("commands", v_u_1.MakeListableType(v7))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Command]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3639"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	p1:RegisterType("conditionFunction", p1.Cmdr.Util.MakeEnumType("ConditionFunction", { "startsWith" }))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ConditionFunction]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3640"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Shared.Util)
local v_u_2 = {
	["Years"] = 31556926,
	["Months"] = 2629744,
	["Weeks"] = 604800,
	["Days"] = 86400,
	["Hours"] = 3600,
	["Minutes"] = 60,
	["Seconds"] = 1
}
local v3 = {}
for v4, _ in pairs(v_u_2) do
	table.insert(v3, v4)
end
local v_u_5 = v_u_1.MakeFuzzyFinder(v3)
local function v_u_14(p6)
	-- upvalues: (copy) v_u_5, (copy) v_u_2
	if p6 == nil or p6 == "" then
		return nil
	else
		local v7 = tonumber(p6)
		if v7 and v7 == 0 then
			return 0, 0, true
		else
			local v8 = p6:gsub("-?%d+%a+", ""):match("-?%d+")
			if v8 then
				return nil, tonumber(v8), true
			else
				local v9 = nil
				local v10 = nil
				for v11 in p6:gmatch("-?%d+%a+") do
					local v12
					v10, v12 = v11:match("(-?%d+)(%a+)")
					local v13 = v_u_5(v12)
					if #v13 == 0 then
						return nil, tonumber(v10)
					end
					v9 = (v9 == nil and 0 or v9) + (v12:lower() == "m" and 60 or v_u_2[v13[1]]) * tonumber(v10)
				end
				if v9 == nil then
					return nil
				else
					return v9, tonumber(v10)
				end
			end
		end
	end
end
local function v_u_23(p15, p16, p17, p18)
	local v19 = p18 or 1
	local v20 = {}
	for v21, v22 in pairs(p15) do
		if p17 == 1 then
			v20[v21] = p16 .. v22:sub(v19, #v22 - 1)
		else
			v20[v21] = p16 .. v22:sub(v19)
		end
	end
	return v20
end
local v_u_34 = {
	["Transform"] = function(p24)
		-- upvalues: (copy) v_u_14
		return p24, v_u_14(p24)
	end,
	["Validate"] = function(_, p25)
		return p25 ~= nil
	end,
	["Autocomplete"] = function(p26, p27, p28, p29, p30)
		-- upvalues: (copy) v_u_5, (copy) v_u_23
		local v31 = {}
		if p29 or p30 then
			if p29 == true then
				p30 = v_u_5("") or p30
			end
			if p29 == true then
				return v_u_23(p30, p26, p28)
			else
				return v_u_23(p30, p26, p26:match("^.*(%a+)$"):len() + 1)
			end
		else
			if p27 ~= nil then
				local v32 = p26:match("^.*-?%d+(%a+)%s?$")
				v31 = v_u_23(v_u_5(v32), p26, p28, #v32 + 1)
				table.sort(v31)
			end
			return v31
		end
	end,
	["Parse"] = function(_, p33)
		return p33
	end
}
return function(p35)
	-- upvalues: (copy) v_u_34, (copy) v_u_1
	p35:RegisterType("duration", v_u_34)
	p35:RegisterType("durations", v_u_1.MakeListableType(v_u_34))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Duration]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3641"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("HttpService")
return function(p2)
	-- upvalues: (copy) v_u_1
	p2:RegisterType("json", {
		["Validate"] = function(p3)
			-- upvalues: (ref) v_u_1
			return pcall(v_u_1.JSONDecode, v_u_1, p3)
		end,
		["Parse"] = function(p4)
			-- upvalues: (ref) v_u_1
			return v_u_1:JSONDecode(p4)
		end
	})
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[JSON]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3642"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(p1)
	p1:RegisterType("mathOperator", p1.Cmdr.Util.MakeEnumType("Math Operator", {
		{
			["Name"] = "+",
			["Perform"] = function(p2, p3)
				return p2 + p3
			end
		},
		{
			["Name"] = "-",
			["Perform"] = function(p4, p5)
				return p4 - p5
			end
		},
		{
			["Name"] = "*",
			["Perform"] = function(p6, p7)
				return p6 * p7
			end
		},
		{
			["Name"] = "/",
			["Perform"] = function(p8, p9)
				return p8 / p9
			end
		},
		{
			["Name"] = "**",
			["Perform"] = function(p10, p11)
				return p10 ^ p11
			end
		},
		{
			["Name"] = "%",
			["Perform"] = function(p12, p13)
				return p12 % p13
			end
		}
	}))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MathOperator]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3643"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Shared.Util)
local v_u_2 = game:GetService("Players")
local v_u_8 = {
	["Transform"] = function(p3)
		-- upvalues: (copy) v_u_1, (copy) v_u_2
		return v_u_1.MakeFuzzyFinder(v_u_2:GetPlayers())(p3)
	end,
	["Validate"] = function(p4)
		return #p4 > 0, "No player with that name could be found."
	end,
	["Autocomplete"] = function(p5)
		-- upvalues: (copy) v_u_1
		return v_u_1.GetNames(p5)
	end,
	["Parse"] = function(p6)
		return p6[1]
	end,
	["Default"] = function(p7)
		return p7.Name
	end,
	["ArgumentOperatorAliases"] = {
		["me"] = ".",
		["all"] = "*",
		["others"] = "**",
		["random"] = "?"
	}
}
return function(p9)
	-- upvalues: (copy) v_u_8, (copy) v_u_1
	p9:RegisterType("player", v_u_8)
	p9:RegisterType("players", v_u_1.MakeListableType(v_u_8, {
		["Prefixes"] = "% teamPlayers"
	}))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Player]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3644"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Shared.Util)
local v_u_2 = game:GetService("Players")
local v_u_3 = {}
local v_u_13 = {
	["DisplayName"] = "Full Player Name",
	["Prefixes"] = "# integer",
	["Transform"] = function(p4)
		-- upvalues: (copy) v_u_1, (copy) v_u_2
		return p4, v_u_1.MakeFuzzyFinder(v_u_2:GetPlayers())(p4)
	end,
	["ValidateOnce"] = function(p5)
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		local v6
		if v_u_3[p5] then
			v6 = v_u_3[p5]
		elseif v_u_2:FindFirstChild(p5) then
			v_u_3[p5] = v_u_2[p5].UserId
			v6 = v_u_2[p5].UserId
		else
			local v7
			v7, v6 = pcall(v_u_2.GetUserIdFromNameAsync, v_u_2, p5)
			if v7 then
				v_u_3[p5] = v6
			else
				v6 = nil
			end
		end
		return v6 ~= nil, "No player with that name could be found."
	end,
	["Autocomplete"] = function(_, p8)
		-- upvalues: (copy) v_u_1
		return v_u_1.GetNames(p8)
	end,
	["Parse"] = function(p9)
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		if v_u_3[p9] then
			return v_u_3[p9]
		end
		if v_u_2:FindFirstChild(p9) then
			v_u_3[p9] = v_u_2[p9].UserId
			return v_u_2[p9].UserId
		end
		local v10, v11 = pcall(v_u_2.GetUserIdFromNameAsync, v_u_2, p9)
		if not v10 then
			return nil
		end
		v_u_3[p9] = v11
		return v11
	end,
	["Default"] = function(p12)
		return p12.Name
	end,
	["ArgumentOperatorAliases"] = {
		["me"] = ".",
		["all"] = "*",
		["others"] = "**",
		["random"] = "?"
	}
}
return function(p14)
	-- upvalues: (copy) v_u_13, (copy) v_u_1
	p14:RegisterType("playerId", v_u_13)
	p14:RegisterType("playerIds", v_u_1.MakeListableType(v_u_13, {
		["Prefixes"] = "# integers"
	}))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PlayerId]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3645"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Shared.Util)
local v_u_4 = {
	["Validate"] = function(p2)
		return p2 ~= nil
	end,
	["Parse"] = function(p3)
		return tostring(p3)
	end
}
local v_u_8 = {
	["Transform"] = function(p5)
		return tonumber(p5)
	end,
	["Validate"] = function(p6)
		return p6 ~= nil
	end,
	["Parse"] = function(p7)
		return p7
	end
}
local v_u_13 = {
	["Transform"] = function(p9)
		return tonumber(p9)
	end,
	["Validate"] = function(p10)
		local v11
		if p10 == nil then
			v11 = false
		else
			v11 = p10 == math.floor(p10)
		end
		return v11, "Only whole numbers are valid."
	end,
	["Parse"] = function(p12)
		return p12
	end
}
local v_u_18 = {
	["Transform"] = function(p14)
		return tonumber(p14)
	end,
	["Validate"] = function(p15)
		local v16
		if p15 == nil or p15 ~= math.floor(p15) then
			v16 = false
		else
			v16 = p15 > 0
		end
		return v16, "Only positive whole numbers are valid."
	end,
	["Parse"] = function(p17)
		return p17
	end
}
local v_u_23 = {
	["Transform"] = function(p19)
		return tonumber(p19)
	end,
	["Validate"] = function(p20)
		local v21
		if p20 == nil or p20 ~= math.floor(p20) then
			v21 = false
		else
			v21 = p20 >= 0
		end
		return v21, "Only non-negative whole numbers are valid."
	end,
	["Parse"] = function(p22)
		return p22
	end
}
local v_u_28 = {
	["Transform"] = function(p24)
		return tonumber(p24)
	end,
	["Validate"] = function(p25)
		local v26
		if p25 == nil or (p25 ~= math.floor(p25) or p25 < 0) then
			v26 = false
		else
			v26 = p25 <= 255
		end
		return v26, "Only bytes are valid."
	end,
	["Parse"] = function(p27)
		return p27
	end
}
local v_u_33 = {
	["Transform"] = function(p29)
		return tonumber(p29)
	end,
	["Validate"] = function(p30)
		local v31
		if p30 == nil or (p30 ~= math.floor(p30) or p30 < 0) then
			v31 = false
		else
			v31 = p30 <= 9
		end
		return v31, "Only digits are valid."
	end,
	["Parse"] = function(p32)
		return p32
	end
}
local v_u_34 = v_u_1.MakeDictionary({
	"true",
	"t",
	"yes",
	"y",
	"on",
	"enable",
	"enabled",
	"1",
	"+"
})
local v_u_35 = v_u_1.MakeDictionary({
	"false",
	"f",
	"no",
	"n",
	"off",
	"disable",
	"disabled",
	"0",
	"-"
})
local v_u_39 = {
	["Transform"] = function(p36)
		return p36:lower()
	end,
	["Validate"] = function(p37)
		-- upvalues: (copy) v_u_34, (copy) v_u_35
		return v_u_34[p37] ~= nil and true or v_u_35[p37] ~= nil, "Please use true/yes/on or false/no/off."
	end,
	["Parse"] = function(p38)
		-- upvalues: (copy) v_u_34, (copy) v_u_35
		if v_u_34[p38] then
			return true
		elseif v_u_35[p38] then
			return false
		else
			return nil
		end
	end
}
return function(p40)
	-- upvalues: (copy) v_u_4, (copy) v_u_8, (copy) v_u_13, (copy) v_u_18, (copy) v_u_23, (copy) v_u_28, (copy) v_u_33, (ref) v_u_39, (copy) v_u_1
	p40:RegisterType("string", v_u_4)
	p40:RegisterType("number", v_u_8)
	p40:RegisterType("integer", v_u_13)
	p40:RegisterType("positiveInteger", v_u_18)
	p40:RegisterType("nonNegativeInteger", v_u_23)
	p40:RegisterType("byte", v_u_28)
	p40:RegisterType("digit", v_u_33)
	p40:RegisterType("boolean", v_u_39)
	p40:RegisterType("strings", v_u_1.MakeListableType(v_u_4))
	p40:RegisterType("numbers", v_u_1.MakeListableType(v_u_8))
	p40:RegisterType("integers", v_u_1.MakeListableType(v_u_13))
	p40:RegisterType("positiveIntegers", v_u_1.MakeListableType(v_u_18))
	p40:RegisterType("nonNegativeIntegers", v_u_1.MakeListableType(v_u_23))
	p40:RegisterType("bytes", v_u_1.MakeListableType(v_u_28))
	p40:RegisterType("digits", v_u_1.MakeListableType(v_u_33))
	p40:RegisterType("booleans", v_u_1.MakeListableType(v_u_39))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Primitives]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3646"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Shared.Util)
local v_u_2 = {
	"^%a[%w_]*$",
	"^%$%a[%w_]*$",
	"^%.%a[%w_]*$",
	"^%$%.%a[%w_]*$"
}
return function(p_u_3)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v8 = {
		["Autocomplete"] = function(p4)
			-- upvalues: (copy) p_u_3
			return p_u_3.Cmdr.Util.MakeFuzzyFinder(p_u_3.Cmdr.Util.DictionaryKeys(p_u_3:GetStore("vars_used") or {}))(p4)
		end,
		["Validate"] = function(p5)
			-- upvalues: (ref) v_u_2
			for _, v6 in ipairs(v_u_2) do
				if p5:match(v6) then
					return true
				end
			end
			return false, "Key names must start with an optional modifier: . $ or $. and must begin with a letter."
		end,
		["Parse"] = function(p7)
			return p7
		end
	}
	p_u_3:RegisterType("storedKey", v8)
	p_u_3:RegisterType("storedKeys", v_u_1.MakeListableType(v8))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[StoredKey]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3647"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Teams")
local v_u_2 = require(script.Parent.Parent.Shared.Util)
local v_u_7 = {
	["Transform"] = function(p3)
		-- upvalues: (copy) v_u_2, (copy) v_u_1
		return v_u_2.MakeFuzzyFinder(v_u_1:GetTeams())(p3)
	end,
	["Validate"] = function(p4)
		return #p4 > 0, "No team with that name could be found."
	end,
	["Autocomplete"] = function(p5)
		-- upvalues: (copy) v_u_2
		return v_u_2.GetNames(p5)
	end,
	["Parse"] = function(p6)
		return p6[1]
	end
}
local v_u_9 = {
	["Listable"] = true,
	["Transform"] = v_u_7.Transform,
	["Validate"] = v_u_7.Validate,
	["Autocomplete"] = v_u_7.Autocomplete,
	["Parse"] = function(p8)
		return p8[1]:GetPlayers()
	end
}
local v_u_11 = {
	["Transform"] = v_u_7.Transform,
	["Validate"] = v_u_7.Validate,
	["Autocomplete"] = v_u_7.Autocomplete,
	["Parse"] = function(p10)
		return p10[1].TeamColor
	end
}
return function(p12)
	-- upvalues: (copy) v_u_7, (copy) v_u_2, (copy) v_u_9, (copy) v_u_11
	p12:RegisterType("team", v_u_7)
	p12:RegisterType("teams", v_u_2.MakeListableType(v_u_7))
	p12:RegisterType("teamPlayers", v_u_9)
	p12:RegisterType("teamColor", v_u_11)
	p12:RegisterType("teamColors", v_u_2.MakeListableType(v_u_11))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Team]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3648"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Shared.Util)
return function(p_u_2)
	-- upvalues: (copy) v_u_1
	local v7 = {
		["Transform"] = function(p3)
			-- upvalues: (ref) v_u_1, (copy) p_u_2
			return v_u_1.MakeFuzzyFinder(p_u_2:GetTypeNames())(p3)
		end,
		["Validate"] = function(p4)
			return #p4 > 0, "No type with that name could be found."
		end,
		["Autocomplete"] = function(p5)
			return p5
		end,
		["Parse"] = function(p6)
			return p6[1]
		end
	}
	p_u_2:RegisterType("type", v7)
	p_u_2:RegisterType("types", v_u_1.MakeListableType(v7))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Type]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3649"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Shared.Util)
local v_u_4 = {
	["Validate"] = function(p2)
		if p2:match("^https?://.+$") then
			return true
		else
			return false, "URLs must begin with http:// or https://"
		end
	end,
	["Parse"] = function(p3)
		return p3
	end
}
return function(p5)
	-- upvalues: (copy) v_u_4, (copy) v_u_1
	p5:RegisterType("url", v_u_4)
	p5:RegisterType("urls", v_u_1.MakeListableType(v_u_4))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[URL]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3650"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Shared.Util)
local v_u_2 = Enum.UserInputType:GetEnumItems()
for _, v3 in pairs(Enum.KeyCode:GetEnumItems()) do
	v_u_2[#v_u_2 + 1] = v3
end
local v_u_8 = {
	["Transform"] = function(p4)
		-- upvalues: (copy) v_u_1, (copy) v_u_2
		return v_u_1.MakeFuzzyFinder(v_u_2)(p4)
	end,
	["Validate"] = function(p5)
		return #p5 > 0
	end,
	["Autocomplete"] = function(p6)
		-- upvalues: (copy) v_u_1
		return v_u_1.GetNames(p6)
	end,
	["Parse"] = function(p7)
		return p7[1]
	end
}
return function(p9)
	-- upvalues: (copy) v_u_8, (copy) v_u_1
	p9:RegisterType("userInput", v_u_8)
	p9:RegisterType("userInputs", v_u_1.MakeListableType(v_u_8))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UserInput]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3651"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Shared.Util)
local function v4(p2, p3)
	if p2 == nil then
		return false, ("Invalid or missing number at position %d in Vector type."):format(p3)
	else
		return true
	end
end
local v_u_5 = v_u_1.MakeSequenceType({
	["ValidateEach"] = v4,
	["TransformEach"] = tonumber,
	["Constructor"] = Vector3.new,
	["Length"] = 3
})
local v_u_6 = v_u_1.MakeSequenceType({
	["ValidateEach"] = v4,
	["TransformEach"] = tonumber,
	["Constructor"] = Vector2.new,
	["Length"] = 2
})
return function(p7)
	-- upvalues: (copy) v_u_5, (copy) v_u_1, (copy) v_u_6
	p7:RegisterType("vector3", v_u_5)
	p7:RegisterType("vector3s", v_u_1.MakeListableType(v_u_5))
	p7:RegisterType("vector2", v_u_6)
	p7:RegisterType("vector2s", v_u_1.MakeListableType(v_u_6))
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Vector]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3652"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Shared]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3653"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Util)
local function v_u_4(p2)
	for _, v3 in ipairs({
		"%.",
		"%?",
		"%*",
		"%*%*"
	}) do
		p2 = p2:gsub("\\" .. v3, v3:gsub("%%", ""))
	end
	return p2
end
local v_u_5 = {}
v_u_5.__index = v_u_5
function v_u_5.new(p6, p7, p8)
	-- upvalues: (copy) v_u_1, (copy) v_u_5
	local v9 = {
		["Command"] = p6,
		["Type"] = nil,
		["Name"] = p7.Name,
		["Object"] = p7
	}
	local v10
	if p7.Default == nil then
		v10 = p7.Optional ~= true
	else
		v10 = false
	end
	v9.Required = v10
	v9.Executor = p6.Executor
	v9.RawValue = p8
	v9.RawSegments = {}
	v9.TransformedValues = {}
	v9.Prefix = ""
	v9.TextSegmentInProgress = ""
	v9.RawSegmentsAreAutocomplete = false
	local v11 = p7.Type
	if type(v11) == "table" then
		v9.Type = p7.Type
	else
		local v12, v13, v14 = v_u_1.ParsePrefixedUnionType(p6.Cmdr.Registry:GetTypeName(p7.Type), p8)
		v9.Type = p6.Dispatcher.Registry:GetType(v12)
		v9.RawValue = v13
		v9.Prefix = v14
		if v9.Type == nil then
			error(string.format("%s has an unregistered type %q", v9.Name or "<none>", v12 or "<none>"))
		end
	end
	local v15 = v_u_5
	setmetatable(v9, v15)
	v9:Transform()
	return v9
end
function v_u_5.GetDefaultAutocomplete(p16)
	if not p16.Type.Autocomplete then
		return {}
	end
	local v17, v18 = p16.Type.Autocomplete(p16:TransformSegment(""))
	return v17, v18 or {}
end
function v_u_5.Transform(p19)
	-- upvalues: (copy) v_u_4, (copy) v_u_1
	if #p19.TransformedValues == 0 then
		local v20 = p19.RawValue
		if p19.Type.ArgumentOperatorAliases then
			v20 = p19.Type.ArgumentOperatorAliases[v20] or v20
		end
		if v20 == "." and p19.Type.Default then
			v20 = p19.Type.Default(p19.Executor) or ""
			p19.RawSegmentsAreAutocomplete = true
		end
		if v20 == "?" and p19.Type.Autocomplete then
			local v21, v22 = p19:GetDefaultAutocomplete()
			if not v22.IsPartial and #v21 > 0 then
				v20 = v21[math.random(1, #v21)]
				p19.RawSegmentsAreAutocomplete = true
			end
		end
		if p19.Type.Listable and #p19.RawValue > 0 then
			local v23 = v20:match("^%?(%d+)$")
			if v23 then
				local v24 = tonumber(v23)
				if v24 and v24 > 0 then
					local v25 = {}
					local v26, v27 = p19:GetDefaultAutocomplete()
					if not v27.IsPartial and #v26 > 0 then
						local v28 = #v26
						for _ = 1, math.min(v24, v28) do
							local v29 = table.remove
							local v30 = math.random
							local v31 = #v26
							table.insert(v25, v29(v26, v30(1, v31)))
						end
						v20 = table.concat(v25, ",")
						p19.RawSegmentsAreAutocomplete = true
					end
				end
			elseif v20 == "*" or v20 == "**" then
				local v32, v33 = p19:GetDefaultAutocomplete()
				if not v33.IsPartial and #v32 > 0 then
					if v20 == "**" and p19.Type.Default then
						local v34 = p19.Type.Default(p19.Executor) or ""
						for v35, v36 in ipairs(v32) do
							if v36 == v34 then
								table.remove(v32, v35)
							end
						end
					end
					v20 = table.concat(v32, ",")
					p19.RawSegmentsAreAutocomplete = true
				end
			end
			local v37 = v_u_4(v20)
			local v38 = v_u_1.SplitStringSimple(v37, ",")
			local v39 = #v38 == 0 and { "" } or v38
			if v37:sub(#v37, #v37) == "," then
				v39[#v39 + 1] = ""
			end
			for v40, v41 in ipairs(v39) do
				p19.RawSegments[v40] = v41
				p19.TransformedValues[v40] = { p19:TransformSegment(v41) }
			end
			p19.TextSegmentInProgress = v39[#v39]
		else
			local v42 = v_u_4(v20)
			p19.RawSegments[1] = v_u_4(v42)
			p19.TransformedValues[1] = { p19:TransformSegment(v42) }
			p19.TextSegmentInProgress = p19.RawValue
		end
	else
		return
	end
end
function v_u_5.TransformSegment(p43, p44)
	if p43.Type.Transform then
		return p43.Type.Transform(p44, p43.Executor)
	else
		return p44
	end
end
function v_u_5.GetTransformedValue(p45, p46)
	local v47 = p45.TransformedValues[p46]
	return unpack(v47)
end
function v_u_5.Validate(p48, p49)
	if p48.RawValue == nil or #p48.RawValue == 0 and p48.Required == false then
		return true
	end
	if p48.Required and (p48.RawSegments[1] == nil or #p48.RawSegments[1] == 0) then
		return false, "This argument is required."
	end
	if not (p48.Type.Validate or p48.Type.ValidateOnce) then
		return true
	end
	for v50 = 1, #p48.TransformedValues do
		if p48.Type.Validate then
			local v51, v52 = p48.Type.Validate(p48:GetTransformedValue(v50))
			if not v51 then
				return v51, v52 or "Invalid value"
			end
		end
		if p49 and p48.Type.ValidateOnce then
			local v53, v54 = p48.Type.ValidateOnce(p48:GetTransformedValue(v50))
			if not v53 then
				return v53, v54
			end
		end
	end
	return true
end
function v_u_5.GetAutocomplete(p55)
	return not p55.Type.Autocomplete and {} or p55.Type.Autocomplete(p55:GetTransformedValue(#p55.TransformedValues))
end
function v_u_5.ParseValue(p56, p57)
	if p56.Type.Parse then
		return p56.Type.Parse(p56:GetTransformedValue(p57))
	else
		return p56:GetTransformedValue(p57)
	end
end
function v_u_5.GetValue(p58)
	if #p58.RawValue == 0 and (not p58.Required and p58.Object.Default ~= nil) then
		return p58.Object.Default
	end
	if not p58.Type.Listable then
		return p58:ParseValue(1)
	end
	local v59 = {}
	for v60 = 1, #p58.TransformedValues do
		local v61 = p58:ParseValue(v60)
		if type(v61) ~= "table" then
			error(("Listable types must return a table from Parse (%s)"):format(p58.Type.Name))
		end
		for _, v62 in pairs(v61) do
			v59[v62] = true
		end
	end
	local v63 = {}
	for v64 in pairs(v59) do
		v63[#v63 + 1] = v64
	end
	return v63
end
return v_u_5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Argument]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3654"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("RunService")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(script.Parent.Argument)
local v_u_4 = v_u_1:IsServer()
local v_u_5 = {}
v_u_5.__index = v_u_5
function v_u_5.new(p6)
	-- upvalues: (copy) v_u_5
	local v7 = {
		["Dispatcher"] = p6.Dispatcher,
		["Cmdr"] = p6.Dispatcher.Cmdr,
		["Name"] = p6.CommandObject.Name,
		["RawText"] = p6.Text,
		["Object"] = p6.CommandObject,
		["Group"] = p6.CommandObject.Group,
		["State"] = {},
		["Aliases"] = p6.CommandObject.Aliases,
		["Alias"] = p6.Alias,
		["Description"] = p6.CommandObject.Description,
		["Executor"] = p6.Executor,
		["ArgumentDefinitions"] = p6.CommandObject.Args,
		["RawArguments"] = p6.Arguments,
		["Arguments"] = {},
		["Data"] = p6.Data,
		["Response"] = nil
	}
	local v8 = v_u_5
	setmetatable(v7, v8)
	return v7
end
function v_u_5.Parse(p9, p10)
	-- upvalues: (copy) v_u_3
	local v11 = false
	for v12, v14 in ipairs(p9.ArgumentDefinitions) do
		if type(v14) == "function" then
			local v14 = v14(p9)
			if v14 == nil then
				break
			end
		end
		local v15
		if v14.Default == nil then
			v15 = v14.Optional ~= true
		else
			v15 = false
		end
		if v15 and v11 then
			error(("Command %q: Required arguments cannot occur after optional arguments."):format(p9.Name))
		else
			v11 = not v15 and true or v11
		end
		if p9.RawArguments[v12] == nil and (v15 and p10 ~= true) then
			return false, ("Required argument #%d %s is missing."):format(v12, v14.Name)
		end
		if p9.RawArguments[v12] or p10 then
			p9.Arguments[v12] = v_u_3.new(p9, v14, p9.RawArguments[v12] or "")
		end
	end
	return true
end
function v_u_5.Validate(p16, p17)
	p16._Validated = true
	local v18 = ""
	local v19 = true
	for v20, v21 in pairs(p16.Arguments) do
		local v22, v23 = v21:Validate(p17)
		if not v22 then
			v18 = ("%s; #%d %s: %s"):format(v18, v20, v21.Name, v23 or "error")
			v19 = false
		end
	end
	return v19, v18:sub(3)
end
function v_u_5.GetLastArgument(p24)
	for v25 = #p24.Arguments, 1, -1 do
		if p24.Arguments[v25].RawValue then
			return p24.Arguments[v25]
		end
	end
end
function v_u_5.GatherArgumentValues(p26)
	local v27 = {}
	for v28 = 1, #p26.ArgumentDefinitions do
		local v29 = p26.Arguments[v28]
		if v29 then
			v27[v28] = v29:GetValue()
		else
			local v30 = p26.ArgumentDefinitions[v28]
			if type(v30) == "table" then
				v27[v28] = p26.ArgumentDefinitions[v28].Default
			end
		end
	end
	return v27, #p26.ArgumentDefinitions
end
function v_u_5.Run(p31)
	-- upvalues: (copy) v_u_4
	if p31._Validated == nil then
		error("Must validate a command before running.")
	end
	local v32 = p31.Dispatcher:RunHooks("BeforeRun", p31)
	if v32 then
		return v32
	end
	if not v_u_4 and (p31.Object.Data and p31.Data == nil) then
		local v33, v34 = p31:GatherArgumentValues()
		p31.Data = p31.Object.Data(p31, unpack(v33, 1, v34))
	end
	if not v_u_4 and p31.Object.ClientRun then
		local v35, v36 = p31:GatherArgumentValues()
		p31.Response = p31.Object.ClientRun(p31, unpack(v35, 1, v36))
	end
	if p31.Response == nil then
		if p31.Object.Run then
			local v37, v38 = p31:GatherArgumentValues()
			p31.Response = p31.Object.Run(p31, unpack(v37, 1, v38))
		elseif v_u_4 then
			if p31.Object.ClientRun then
				warn(p31.Name, "command fell back to the server because ClientRun returned nil, but there is no server implementation! Either return a string from ClientRun, or create a server implementation for this command.")
			else
				warn(p31.Name, "command has no implementation!")
			end
			p31.Response = "No implementation."
		else
			p31.Response = p31.Dispatcher:Send(p31.RawText, p31.Data)
		end
	end
	return p31.Dispatcher:RunHooks("AfterRun", p31) or p31.Response
end
function v_u_5.GetArgument(p39, p40)
	return p39.Arguments[p40]
end
function v_u_5.GetData(p41)
	-- upvalues: (copy) v_u_4
	if p41.Data then
		return p41.Data
	end
	if p41.Object.Data and not v_u_4 then
		p41.Data = p41.Object.Data(p41)
	end
	return p41.Data
end
function v_u_5.SendEvent(p42, p43, p44, ...)
	-- upvalues: (copy) v_u_4, (copy) v_u_2
	local v45 = typeof(p43) == "Instance"
	assert(v45, "Argument #1 must be a Player")
	local v46 = p43:IsA("Player")
	assert(v46, "Argument #1 must be a Player")
	local v47 = type(p44) == "string"
	assert(v47, "Argument #2 must be a string")
	if v_u_4 then
		p42.Dispatcher.Cmdr.RemoteEvent:FireClient(p43, p44, ...)
	elseif p42.Dispatcher.Cmdr.Events[p44] then
		local v48 = p43 == v_u_2.LocalPlayer
		assert(v48, "Event messages can only be sent to the local player on the client.")
		p42.Dispatcher.Cmdr.Events[p44](...)
	end
end
function v_u_5.BroadcastEvent(p49, ...)
	-- upvalues: (copy) v_u_4
	if not v_u_4 then
		error("Can\'t broadcast event messages from the client.", 2)
	end
	p49.Dispatcher.Cmdr.RemoteEvent:FireAllClients(...)
end
function v_u_5.Reply(p50, ...)
	return p50:SendEvent(p50.Executor, "AddLine", ...)
end
function v_u_5.GetStore(p51, ...)
	return p51.Dispatcher.Cmdr.Registry:GetStore(...)
end
function v_u_5.HasImplementation(p52)
	-- upvalues: (copy) v_u_1
	return (v_u_1:IsClient() and p52.Object.ClientRun or p52.Object.Run) and true or false
end
return v_u_5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Command]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3655"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("RunService")
local v_u_2 = game:GetService("TeleportService")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(script.Parent.Util)
local v_u_5 = require(script.Parent.Command)
local v_u_6 = false
local v_u_54 = {
	["Cmdr"] = nil,
	["Registry"] = nil,
	["Evaluate"] = function(p7, p8, p9, p10, p11)
		-- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5
		if v_u_1:IsClient() == true and p9 ~= v_u_3.LocalPlayer then
			error("Can\'t evaluate a command that isn\'t sent by the local player.")
		end
		local v12 = v_u_4.SplitString(p8)
		local v13 = table.remove(v12, 1)
		local v14 = p7.Registry:GetCommand(v13)
		if v14 then
			local v15 = {
				["Dispatcher"] = p7,
				["Text"] = p8,
				["CommandObject"] = v14,
				["Alias"] = v13,
				["Executor"] = p9,
				["Arguments"] = v_u_4.MashExcessArguments(v12, #v14.Args),
				["Data"] = p11
			}
			local v16 = v_u_5.new(v15)
			local v17, v18 = v16:Parse(p10)
			if v17 then
				return v16
			else
				return false, v18
			end
		else
			return false, ("%q is not a valid command name. Use the help command to see all available commands."):format((tostring(v13)))
		end
	end,
	["EvaluateAndRun"] = function(p19, p20, p21, p22)
		-- upvalues: (copy) v_u_3, (copy) v_u_1
		local v23 = p21 or v_u_3.LocalPlayer
		local v24 = p22 or {}
		if v_u_1:IsClient() and v24.IsHuman then
			p19:PushHistory(p20)
		end
		local v_u_25, v26 = p19:Evaluate(p20, v23, nil, v24.Data)
		if not v_u_25 then
			return v26
		end
		local v30, v31 = xpcall(function()
			-- upvalues: (copy) v_u_25
			local v27, v28 = v_u_25:Validate(true)
			return v27 and (v_u_25:Run() or "Command executed.") or v28
		end, function(p29)
			return debug.traceback((tostring(p29)))
		end)
		if not v30 then
			warn(("Error occurred while evaluating command string %q\n%s"):format(p20, (tostring(v31))))
		end
		return v30 and v31 and v31 or "An error occurred while running this command. Check the console for more information."
	end,
	["Send"] = function(p32, p33, p34)
		-- upvalues: (copy) v_u_1
		if v_u_1:IsClient() == false then
			error("Dispatcher:Send can only be called from the client.")
		end
		return p32.Cmdr.RemoteFunction:InvokeServer(p33, {
			["Data"] = p34
		})
	end,
	["Run"] = function(p35, ...)
		-- upvalues: (copy) v_u_3
		if not v_u_3.LocalPlayer then
			error("Dispatcher:Run can only be called from the client.")
		end
		local v36 = { ... }
		local v37 = v36[1]
		for v38 = 2, #v36 do
			local v39 = v36[v38]
			v37 = v37 .. " " .. tostring(v39)
		end
		local v40, v41 = p35:Evaluate(v37, v_u_3.LocalPlayer)
		if not v40 then
			error(v41)
		end
		local v42, v43 = v40:Validate(true)
		if not v42 then
			error(v43)
		end
		return v40:Run()
	end,
	["RunHooks"] = function(p44, p45, p46, ...)
		-- upvalues: (copy) v_u_1, (ref) v_u_6
		if not p44.Registry.Hooks[p45] then
			error(("Invalid hook name: %q"):format(p45), 2)
		end
		if p45 == "BeforeRun" and (#p44.Registry.Hooks[p45] == 0 and (p46.Group ~= "DefaultUtil" and (p46.Group ~= "UserAlias" and p46:HasImplementation()))) then
			if not v_u_1:IsStudio() then
				return "Command blocked for security as no BeforeRun hook is configured."
			end
			if v_u_6 == false then
				p46:Reply((v_u_1:IsServer() and "<Server>" or "<Client>") .. " Commands will not run in-game if no BeforeRun hook is configured. Learn more: https://eryn.io/Cmdr/guide/Hooks.html", Color3.fromRGB(255, 228, 26))
				v_u_6 = true
			end
		end
		for _, v47 in ipairs(p44.Registry.Hooks[p45]) do
			local v48 = v47.callback(p46, ...)
			if v48 ~= nil then
				return tostring(v48)
			end
		end
	end,
	["PushHistory"] = function(p49, p50)
		-- upvalues: (copy) v_u_1, (copy) v_u_4, (copy) v_u_2
		local v51 = v_u_1:IsClient()
		assert(v51, "PushHistory may only be used from the client.")
		local v52 = p49:GetHistory()
		if v_u_4.TrimString(p50) ~= "" and p50 ~= v52[#v52] then
			v52[#v52 + 1] = p50
			v_u_2:SetTeleportSetting("CmdrCommandHistory", v52)
		end
	end,
	["GetHistory"] = function(_)
		-- upvalues: (copy) v_u_1, (copy) v_u_2
		local v53 = v_u_1:IsClient()
		assert(v53, "GetHistory may only be used from the client.")
		return v_u_2:GetTeleportSetting("CmdrCommandHistory") or {}
	end
}
return function(p55)
	-- upvalues: (copy) v_u_54
	v_u_54.Cmdr = p55
	v_u_54.Registry = p55.Registry
	return v_u_54
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Dispatcher]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3656"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("RunService")
local v_u_2 = require(script.Parent.Util)
local v_u_19 = {
	["TypeMethods"] = v_u_2.MakeDictionary({
		"Transform",
		"Validate",
		"Autocomplete",
		"Parse",
		"DisplayName",
		"Listable",
		"ValidateOnce",
		"Prefixes",
		"Default",
		"ArgumentOperatorAliases"
	}),
	["CommandMethods"] = v_u_2.MakeDictionary({
		"Name",
		"Aliases",
		"AutoExec",
		"Description",
		"Args",
		"Run",
		"ClientRun",
		"Data",
		"Group"
	}),
	["CommandArgProps"] = v_u_2.MakeDictionary({
		"Name",
		"Type",
		"Description",
		"Optional",
		"Default"
	}),
	["Types"] = {},
	["TypeAliases"] = {},
	["Commands"] = {},
	["CommandsArray"] = {},
	["Cmdr"] = nil,
	["Hooks"] = {
		["BeforeRun"] = {},
		["AfterRun"] = {}
	},
	["Stores"] = setmetatable({}, {
		["__index"] = function(p3, p4)
			p3[p4] = {}
			return p3[p4]
		end
	}),
	["AutoExecBuffer"] = {},
	["RegisterType"] = function(p5, p6, p7)
		if not p6 or typeof(p6) ~= "string" then
			error("Invalid type name provided: nil")
		end
		if not p6:find("^[%d%l]%w*$") then
			error(("Invalid type name provided: \"%s\", type names must be alphanumeric and start with a lower-case letter or a digit."):format(p6))
		end
		for v8 in pairs(p7) do
			if p5.TypeMethods[v8] == nil then
				error("Unknown key/method in type \"" .. p6 .. "\": " .. v8)
			end
		end
		if p5.Types[p6] ~= nil then
			error(("Type \"%s\" has already been registered."):format(p6))
		end
		p7.Name = p6
		p7.DisplayName = p7.DisplayName or p6
		p5.Types[p6] = p7
		if p7.Prefixes then
			p5:RegisterTypePrefix(p6, p7.Prefixes)
		end
	end,
	["RegisterTypePrefix"] = function(p9, p10, p11)
		if not p9.TypeAliases[p10] then
			p9.TypeAliases[p10] = p10
		end
		p9.TypeAliases[p10] = ("%s %s"):format(p9.TypeAliases[p10], p11)
	end,
	["RegisterTypeAlias"] = function(p12, p13, p14)
		local v15 = p12.TypeAliases[p13] == nil
		assert(v15, ("Type alias %s already exists!"):format(p14))
		p12.TypeAliases[p13] = p14
	end,
	["RegisterTypesIn"] = function(p16, p17)
		for _, v18 in pairs(p17:GetChildren()) do
			if v18:IsA("ModuleScript") then
				v18.Parent = p16.Cmdr.ReplicatedRoot.Types
				require(v18)(p16)
			else
				p16:RegisterTypesIn(v18)
			end
		end
	end
}
v_u_19.RegisterHooksIn = v_u_19.RegisterTypesIn
function v_u_19.RegisterCommandObject(p20, p21, _)
	-- upvalues: (copy) v_u_1
	for v22 in pairs(p21) do
		if p20.CommandMethods[v22] == nil then
			error("Unknown key/method in command " .. (p21.Name or "unknown command") .. ": " .. v22)
		end
	end
	if p21.Args then
		for v23, v24 in pairs(p21.Args) do
			if type(v24) == "table" then
				for v25 in pairs(v24) do
					if p20.CommandArgProps[v25] == nil then
						error(("Unknown property in command \"%s\" argument #%d: %s"):format(p21.Name or "unknown", v23, v25))
					end
				end
			end
		end
	end
	if p21.AutoExec and v_u_1:IsClient() then
		local v26 = p20.AutoExecBuffer
		local v27 = p21.AutoExec
		table.insert(v26, v27)
		p20:FlushAutoExecBufferDeferred()
	end
	local v28 = p20.Commands[p21.Name:lower()]
	if v28 and v28.Aliases then
		for _, v29 in pairs(v28.Aliases) do
			p20.Commands[v29:lower()] = nil
		end
	elseif not v28 then
		local v30 = p20.CommandsArray
		table.insert(v30, p21)
	end
	p20.Commands[p21.Name:lower()] = p21
	if p21.Aliases then
		for _, v31 in pairs(p21.Aliases) do
			p20.Commands[v31:lower()] = p21
		end
	end
end
function v_u_19.RegisterCommand(p32, p33, p34, p35)
	-- upvalues: (copy) v_u_1
	local v36 = require(p33)
	local v37 = typeof(v36) == "table"
	local v38 = ("Invalid return value from command script \"%*\" (CommandDefinition expected, got %*)"):format(p33.Name, (typeof(v36)))
	assert(v37, v38)
	if p34 then
		local v39 = v_u_1:IsServer()
		assert(v39, "The commandServerScript parameter is not valid for client usage.")
		v36.Run = require(p34)
	end
	if not p35 or p35(v36) then
		p32:RegisterCommandObject(v36)
		p33.Parent = p32.Cmdr.ReplicatedRoot.Commands
	end
end
function v_u_19.RegisterCommandsIn(p40, p41, p42)
	local v43 = {}
	local v44 = {}
	for _, v45 in pairs(p41:GetChildren()) do
		if v45:IsA("ModuleScript") then
			if v45.Name:find("Server") then
				v43[v45] = true
			else
				local v46 = p41:FindFirstChild(v45.Name .. "Server")
				if v46 then
					v44[v46] = true
				end
				p40:RegisterCommand(v45, v46, p42)
			end
		else
			p40:RegisterCommandsIn(v45, p42)
		end
	end
	for v47 in pairs(v43) do
		if not v44[v47] then
			warn("Command script " .. v47.Name .. " was skipped because it has \'Server\' in its name, and has no equivalent shared script.")
		end
	end
end
function v_u_19.RegisterDefaultCommands(p48, p_u_49)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v50 = v_u_1:IsServer()
	assert(v50, "RegisterDefaultCommands cannot be called from the client.")
	local v51 = type(p_u_49) == "table"
	if v51 then
		p_u_49 = v_u_2.MakeDictionary(p_u_49)
	end
	p48:RegisterCommandsIn(p48.Cmdr.DefaultCommandsFolder, v51 and function(p52)
		-- upvalues: (ref) p_u_49
		return p_u_49[p52.Group] or false
	end or p_u_49)
end
function v_u_19.GetCommand(p53, p54)
	return p53.Commands[(p54 or ""):lower()]
end
function v_u_19.GetCommands(p55)
	return p55.CommandsArray
end
function v_u_19.GetCommandNames(p56)
	local v57 = {}
	for _, v58 in pairs(p56.CommandsArray) do
		local v59 = v58.Name
		table.insert(v57, v59)
	end
	return v57
end
v_u_19.GetCommandsAsStrings = v_u_19.GetCommandNames
function v_u_19.GetTypeNames(p60)
	local v61 = {}
	for v62 in pairs(p60.Types) do
		table.insert(v61, v62)
	end
	return v61
end
function v_u_19.GetType(p63, p64)
	return p63.Types[p64]
end
function v_u_19.GetTypeName(p65, p66)
	return p65.TypeAliases[p66] or p66
end
function v_u_19.RegisterHook(p67, p68, p69, p70)
	if not p67.Hooks[p68] then
		error(("Invalid hook name: %q"):format(p68), 2)
	end
	local v71 = p67.Hooks[p68]
	table.insert(v71, {
		["callback"] = p69,
		["priority"] = p70 or 0
	})
	table.sort(p67.Hooks[p68], function(p72, p73)
		return p72.priority < p73.priority
	end)
end
v_u_19.AddHook = v_u_19.RegisterHook
function v_u_19.GetStore(p74, p75)
	return p74.Stores[p75]
end
function v_u_19.FlushAutoExecBufferDeferred(p_u_76)
	-- upvalues: (copy) v_u_1
	if not p_u_76.AutoExecFlushConnection then
		p_u_76.AutoExecFlushConnection = v_u_1.Heartbeat:Connect(function()
			-- upvalues: (copy) p_u_76
			p_u_76.AutoExecFlushConnection:Disconnect()
			p_u_76.AutoExecFlushConnection = nil
			p_u_76:FlushAutoExecBuffer()
		end)
	end
end
function v_u_19.FlushAutoExecBuffer(p77)
	for _, v78 in ipairs(p77.AutoExecBuffer) do
		for _, v79 in ipairs(v78) do
			p77.Cmdr.Dispatcher:EvaluateAndRun(v79)
		end
	end
	p77.AutoExecBuffer = {}
end
return function(p80)
	-- upvalues: (copy) v_u_19
	v_u_19.Cmdr = p80
	return v_u_19
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Registry]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3657"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("TextService")
local v_u_35 = {
	["MakeDictionary"] = function(p2)
		local v3 = {}
		for v4 = 1, #p2 do
			v3[p2[v4]] = true
		end
		return v3
	end,
	["DictionaryKeys"] = function(p5)
		local v6 = {}
		for v7 in pairs(p5) do
			table.insert(v6, v7)
		end
		return v6
	end,
	["MakeFuzzyFinder"] = function(p8)
		local v_u_9 = nil
		local v_u_10 = {}
		if typeof(p8) == "Enum" then
			p8 = p8:GetEnumItems()
		end
		if typeof(p8) == "Instance" then
			v_u_10 = p8:GetChildren()
			v_u_9 = {}
			for v11 = 1, #v_u_10 do
				v_u_9[v11] = v_u_10[v11].Name
			end
			::l8::
			return function(p12, p13)
				-- upvalues: (ref) v_u_9, (ref) v_u_10
				local v14 = {}
				for v15, v16 in pairs(v_u_9) do
					local v17
					if v_u_10 then
						v17 = v_u_10[v15] or v16
					else
						v17 = v16
					end
					if v16:lower() == p12:lower() then
						if p13 then
							return v17
						end
						table.insert(v14, 1, v17)
					elseif v16:lower():find(p12:lower(), 1, true) then
						v14[#v14 + 1] = v17
					end
				end
				if p13 then
					return v14[1]
				else
					return v14
				end
			end
		end
		if typeof(p8) ~= "table" then
			error("MakeFuzzyFinder only accepts a table, Enum, or Instance.")
			goto l8
		end
		local v18 = p8[1]
		if typeof(v18) ~= "Instance" then
			local v19 = p8[1]
			if typeof(v19) ~= "EnumItem" then
				local v20 = p8[1]
				if typeof(v20) ~= "table" then
					::l15::
					local v21 = p8[1]
					if type(v21) == "string" then
						v_u_9 = p8
					elseif p8[1] == nil then
						v_u_9 = {}
					else
						error("MakeFuzzyFinder only accepts tables of instances or strings.")
					end
					goto l8
				end
				local v22 = p8[1].Name
				if typeof(v22) ~= "string" then
					goto l15
				end
			end
		end
		v_u_9 = {}
		v_u_10 = p8
		for v23 = 1, #p8 do
			v_u_9[v23] = v_u_10[v23].Name
			p8 = v_u_10
			v_u_10 = p8
		end
		goto l8
	end,
	["GetNames"] = function(p24)
		local v25 = {}
		for v26 = 1, #p24 do
			local v27 = p24[v26].Name
			if not v27 then
				local v28 = p24[v26]
				v27 = tostring(v28)
			end
			v25[v26] = v27
		end
		return v25
	end,
	["SplitStringSimple"] = function(p29, p30)
		local v31 = p30 == nil and "%s" or p30
		local v32 = {}
		local v33 = 1
		for v34 in string.gmatch(p29, "([^" .. v31 .. "]+)") do
			v32[v33] = v34
			v33 = v33 + 1
		end
		return v32
	end
}
local function v_u_37(p36)
	return utf8.char((tonumber(p36, 16)))
end
function v_u_35.ParseEscapeSequences(p38)
	-- upvalues: (copy) v_u_37
	return p38:gsub("\\(.)", {
		["t"] = "\t",
		["n"] = "\n"
	}):gsub("\\u(%x%x%x%x)", v_u_37):gsub("\\x(%x%x)", v_u_37)
end
function v_u_35.EncodeEscapedOperator(p39, p40)
	local v41 = p40:sub(1, 1)
	local v42 = p40:gsub(".", "%%%1")
	return p39:gsub("(" .. ("%" .. v41) .. "+)(" .. v42 .. ")", function(p43, p44)
		return (p43:sub(1, #p43 - 1) .. p44):gsub(".", function(p45)
			return "\\u" .. string.format("%04x", string.byte(p45), 16)
		end)
	end)
end
local v_u_46 = { "&&", "||", ";" }
function v_u_35.EncodeEscapedOperators(p47)
	-- upvalues: (copy) v_u_46, (copy) v_u_35
	for _, v48 in ipairs(v_u_46) do
		p47 = v_u_35.EncodeEscapedOperator(p47, v48)
	end
	return p47
end
function v_u_35.SplitString(p49, p50)
	-- upvalues: (copy) v_u_35
	local v51 = nil
	local v52 = nil
	local v53 = {}
	local v54 = p50 or (1 / 0)
	for v55 in p49:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___"):gmatch("[^ ]+") do
		local v56 = v_u_35.ParseEscapeSequences(v55)
		local v57 = v56:match("^([\'\"])")
		local v58 = v56:match("([\'\"])$")
		local v59 = v56:match("(\\*)[\'\"]$")
		if v57 and not (v51 or v58) then
			v51 = v57
			v52 = v56
		elseif v52 and (v58 == v51 and #v59 % 2 == 0) then
			v56 = v52 .. " " .. v56
			v52 = nil
			v51 = nil
		elseif v52 then
			v52 = v52 .. " " .. v56
		end
		if not v52 then
			v53[#v53 + (v54 < #v53 and 0 or 1)] = v56:gsub("^([\'\"])", ""):gsub("([\'\"])$", ""):gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n")
		end
	end
	if v52 then
		v53[#v53 + (v54 < #v53 and 0 or 1)] = v52:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n")
	end
	return v53
end
function v_u_35.MashExcessArguments(p60, p61)
	local v62 = {}
	for v63 = 1, #p60 do
		if p61 < v63 then
			v62[p61] = ("%s %s"):format(v62[p61] or "", p60[v63])
		else
			v62[v63] = p60[v63]
		end
	end
	return v62
end
function v_u_35.TrimString(p64)
	local _, v65 = string.find(p64, "^%s*")
	return v65 == #p64 and "" or string.match(p64, ".*%S", v65 + 1)
end
function v_u_35.GetTextSize(p66, p67, p68)
	-- upvalues: (copy) v_u_1
	return v_u_1:GetTextSize(p66, p67.TextSize, p67.Font, p68 or Vector2.new(p67.AbsoluteSize.X, 0))
end
function v_u_35.MakeEnumType(p_u_69, p70)
	-- upvalues: (copy) v_u_35
	local v_u_71 = v_u_35.MakeFuzzyFinder(p70)
	return {
		["Validate"] = function(p72)
			-- upvalues: (copy) v_u_71, (copy) p_u_69
			return v_u_71(p72, true) ~= nil, ("Value %q is not a valid %s."):format(p72, p_u_69)
		end,
		["Autocomplete"] = function(p73)
			-- upvalues: (copy) v_u_71, (ref) v_u_35
			local v74 = v_u_71(p73)
			local v75 = v74[1]
			if type(v75) ~= "string" then
				v74 = v_u_35.GetNames(v74) or v74
			end
			return v74
		end,
		["Parse"] = function(p76)
			-- upvalues: (copy) v_u_71
			return v_u_71(p76, true)
		end
	}
end
function v_u_35.ParsePrefixedUnionType(p77, p78)
	-- upvalues: (copy) v_u_35
	local v79 = v_u_35.SplitStringSimple(p77)
	local v80 = {}
	for v81 = 1, #v79, 2 do
		v80[#v80 + 1] = {
			["prefix"] = v79[v81 - 1] or "",
			["type"] = v79[v81]
		}
	end
	table.sort(v80, function(p82, p83)
		return #p82.prefix > #p83.prefix
	end)
	for v84 = 1, #v80 do
		local v85 = v80[v84]
		if p78:sub(1, #v85.prefix) == v85.prefix then
			return v85.type, p78:sub(#v85.prefix + 1), v85.prefix
		end
	end
end
function v_u_35.MakeListableType(p_u_86, p87)
	local v88 = {
		["Listable"] = true,
		["Transform"] = p_u_86.Transform,
		["Validate"] = p_u_86.Validate,
		["ValidateOnce"] = p_u_86.ValidateOnce,
		["Autocomplete"] = p_u_86.Autocomplete,
		["Default"] = p_u_86.Default,
		["ArgumentOperatorAliases"] = p_u_86.ArgumentOperatorAliases,
		["Parse"] = function(...)
			-- upvalues: (copy) p_u_86
			return { p_u_86.Parse(...) }
		end
	}
	if p87 then
		for v89, v90 in pairs(p87) do
			v88[v89] = v90
		end
	end
	return v88
end
function v_u_35.RunCommandString(p91, p92)
	-- upvalues: (copy) v_u_35
	local v93 = v_u_35.ParseEscapeSequences(p92)
	local v94 = v_u_35.EncodeEscapedOperators(v93):split("&&")
	local v95 = ""
	for v96, v97 in ipairs(v94) do
		local v98 = v95:gsub("%$", "\\x24"):gsub("%%", "%%%%")
		local v99 = "||"
		if v95:find("%s") then
			v98 = ("%q"):format(v98) or v98
		end
		local v100 = v97:gsub(v99, v98)
		local v101 = v_u_35.RunEmbeddedCommands(p91, v100)
		v95 = tostring(p91:EvaluateAndRun(v101))
		if v96 == #v94 then
			return v95
		end
	end
end
function v_u_35.RunEmbeddedCommands(p102, p103)
	-- upvalues: (copy) v_u_35
	local v104 = p103:gsub("\\%$", "___!CMDR_DOLLAR!___")
	local v105 = {}
	for v106 in v104:gmatch("$(%b{})") do
		local v107 = v106:sub(2, #v106 - 1)
		local v108
		if v107:match("^{.+}$") then
			v107 = v107:sub(2, #v107 - 1)
			v108 = false
		else
			v108 = true
		end
		v105[v106] = v_u_35.RunCommandString(p102, v107)
		if v108 and (v105[v106]:find("%s") or v105[v106] == "") then
			v105[v106] = string.format("%q", v105[v106])
		end
	end
	return v104:gsub("$(%b{})", v105):gsub("___!CMDR_DOLLAR!___", "$")
end
function v_u_35.SubstituteArgs(p109, p110)
	local v111 = p109:gsub("\\%$", "___!CMDR_DOLLAR!___")
	if type(p110) == "table" then
		for v112 = 1, #p110 do
			local v113 = tostring(v112)
			p110[v113] = p110[v112]
			if p110[v113]:find("%s") then
				p110[v113] = string.format("%q", p110[v113])
			end
		end
	end
	return v111:gsub("($%d+)%b{}", "%1"):gsub("$(%w+)", p110):gsub("___!CMDR_DOLLAR!___", "$")
end
function v_u_35.MakeAliasCommand(p114, p115)
	-- upvalues: (copy) v_u_35
	local v116, v117 = unpack(p114:split("|"))
	local v_u_118 = v_u_35.EncodeEscapedOperators(p115)
	local v119 = {}
	local v120 = {}
	for v121 in v_u_118:gmatch("$(%d+)") do
		if v119[v121] == nil then
			v119[v121] = true
			local v122 = v_u_118:match((("$%*(%%b{})"):format(v121)))
			local v123, v124, v125
			if v122 then
				local v126 = v122:sub(2, #v122 - 1)
				v123, v124, v125 = unpack(v126:split("|"))
			else
				v123 = nil
				v124 = nil
				v125 = nil
			end
			local v127
			if v123 then
				v127 = v123:match("%?$") and true or false
			else
				v127 = v123
			end
			local v128 = not v123 and "string" or v123:match("^%w+")
			local v129 = v124 or ("Argument %*"):format(v121)
			table.insert(v120, {
				["Type"] = v128,
				["Name"] = v129,
				["Description"] = v125 or "",
				["Optional"] = v127
			})
		end
	end
	return {
		["Name"] = v116,
		["Aliases"] = {},
		["Description"] = ("<Alias> %*"):format(v117 or v_u_118),
		["Group"] = "UserAlias",
		["Args"] = v120,
		["Run"] = function(p130)
			-- upvalues: (ref) v_u_35, (ref) v_u_118
			return v_u_35.RunCommandString(p130.Dispatcher, v_u_35.SubstituteArgs(v_u_118, p130.RawArguments))
		end
	}
end
function v_u_35.MakeSequenceType(p131)
	-- upvalues: (copy) v_u_35
	local v_u_132 = p131 or {}
	local v133 = v_u_132.Parse ~= nil and true or v_u_132.Constructor ~= nil
	assert(v133, "MakeSequenceType: Must provide one of: Constructor, Parse")
	v_u_132.TransformEach = v_u_132.TransformEach or function(...)
		return ...
	end
	v_u_132.ValidateEach = v_u_132.ValidateEach or function()
		return true
	end
	return {
		["Prefixes"] = v_u_132.Prefixes,
		["Transform"] = function(p134)
			-- upvalues: (ref) v_u_35, (ref) v_u_132
			return v_u_35.Map(v_u_35.SplitPrioritizedDelimeter(p134, { ",", "%s" }), function(p135)
				-- upvalues: (ref) v_u_132
				return v_u_132.TransformEach(p135)
			end)
		end,
		["Validate"] = function(p136)
			-- upvalues: (ref) v_u_132
			if v_u_132.Length and #p136 > v_u_132.Length then
				return false, ("Maximum of %d values allowed in sequence"):format(v_u_132.Length)
			end
			for v137 = 1, v_u_132.Length or #p136 do
				local v138, v139 = v_u_132.ValidateEach(p136[v137], v137)
				if not v138 then
					return false, v139
				end
			end
			return true
		end,
		["Parse"] = v_u_132.Parse or function(p140)
			-- upvalues: (ref) v_u_132
			return v_u_132.Constructor(unpack(p140))
		end
	}
end
function v_u_35.SplitPrioritizedDelimeter(p141, p142)
	-- upvalues: (copy) v_u_35
	for v143, v144 in ipairs(p142) do
		if p141:find(v144) or v143 == #p142 then
			return v_u_35.SplitStringSimple(p141, v144)
		end
	end
end
function v_u_35.Map(p145, p146)
	local v147 = {}
	for v148, v149 in ipairs(p145) do
		v147[v148] = p146(v149, v148)
	end
	return v147
end
function v_u_35.Each(p150, ...)
	local v151 = {}
	for v152, v153 in ipairs({ ... }) do
		v151[v152] = p150(v153)
	end
	return unpack(v151)
end
function v_u_35.EmulateTabstops(p154, p155)
	local v156 = #p154
	local v157 = table.create(v156)
	local v158 = 0
	for v159 = 1, v156 do
		local v160 = string.sub(p154, v159, v159)
		if v160 == "\t" then
			local v161 = p155 - v158 % p155
			local v162 = string.rep
			table.insert(v157, v162(" ", v161))
			v158 = v158 + v161
		else
			table.insert(v157, v160)
			if v160 == "\n" then
				v158 = 0
			elseif v160 ~= "\r" then
				v158 = v158 + 1
			end
		end
	end
	return table.concat(v157)
end
function v_u_35.Mutex()
	local v_u_163 = {}
	local v_u_164 = false
	return function()
		-- upvalues: (ref) v_u_164, (copy) v_u_163
		if v_u_164 then
			local v165 = v_u_163
			local v166 = coroutine.running
			table.insert(v165, v166())
			coroutine.yield()
		else
			v_u_164 = true
		end
		return function()
			-- upvalues: (ref) v_u_163, (ref) v_u_164
			if #v_u_163 > 0 then
				coroutine.resume(table.remove(v_u_163, 1))
			else
				v_u_164 = false
			end
		end
	end
end
return v_u_35]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Util]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item></Item><Item class="Folder" referent="3658"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[evaera_promise@4.0.0]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3659"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {
	["__mode"] = "k"
}
local function v7(p_u_2, p3)
	local v4 = {}
	for _, v5 in ipairs(p3) do
		v4[v5] = v5
	end
	return setmetatable(v4, {
		["__index"] = function(_, p6)
			-- upvalues: (copy) p_u_2
			error(string.format("%s is not in %s!", p6, p_u_2), 2)
		end,
		["__newindex"] = function()
			-- upvalues: (copy) p_u_2
			error(string.format("Creating new members in %s is not allowed!", p_u_2), 2)
		end
	})
end
local v_u_8 = {
	["Kind"] = v7("Promise.Error.Kind", {
		"ExecutionError",
		"AlreadyCancelled",
		"NotResolvedInTime",
		"TimedOut"
	})
}
v_u_8.__index = v_u_8
function v_u_8.new(p9, p10)
	-- upvalues: (ref) v_u_8
	local v11 = p9 or {}
	local v12 = {}
	local v13 = v11.error
	v12.error = tostring(v13) or "[This error has no error text.]"
	v12.trace = v11.trace
	v12.context = v11.context
	v12.kind = v11.kind
	v12.parent = p10
	v12.createdTick = os.clock()
	v12.createdTrace = debug.traceback()
	local v14 = v_u_8
	return setmetatable(v12, v14)
end
function v_u_8.is(p15)
	if type(p15) == "table" then
		local v16 = getmetatable(p15)
		if type(v16) == "table" then
			local v17
			if rawget(p15, "error") == nil then
				v17 = false
			else
				local v18 = rawget(v16, "extend")
				v17 = type(v18) == "function"
			end
			return v17
		end
	end
	return false
end
function v_u_8.isKind(p19, p20)
	-- upvalues: (ref) v_u_8
	local v21 = p20 ~= nil
	assert(v21, "Argument #2 to Promise.Error.isKind must not be nil")
	local v22 = v_u_8.is(p19)
	if v22 then
		v22 = p19.kind == p20
	end
	return v22
end
function v_u_8.extend(p23, p24)
	-- upvalues: (ref) v_u_8
	local v25 = p24 or {}
	v25.kind = v25.kind or p23.kind
	return v_u_8.new(v25, p23)
end
function v_u_8.getErrorChain(p26)
	local v27 = { p26 }
	while v27[#v27].parent do
		local v28 = v27[#v27].parent
		table.insert(v27, v28)
	end
	return v27
end
function v_u_8.__tostring(p29)
	local v30 = { string.format("-- Promise.Error(%s) --", p29.kind or "?") }
	for _, v31 in ipairs(p29:getErrorChain()) do
		local v32 = table.concat
		local v33 = { v31.trace or v31.error, v31.context }
		table.insert(v30, v32(v33, "\n"))
	end
	return table.concat(v30, "\n")
end
local function v_u_34(...)
	return select("#", ...), { ... }
end
local function v_u_36(p35, ...)
	return p35, select("#", ...), { ... }
end
local function v_u_43(p_u_37, p38, ...)
	-- upvalues: (copy) v_u_36, (ref) v_u_8
	local v39 = v_u_36
	local v40 = xpcall
	local v41 = p_u_37 ~= nil
	assert(v41, "traceback is nil")
	return v39(v40(p38, function(p42)
		-- upvalues: (ref) v_u_8, (copy) p_u_37
		if type(p42) == "table" then
			return p42
		else
			return v_u_8.new({
				["error"] = p42,
				["kind"] = v_u_8.Kind.ExecutionError,
				["trace"] = debug.traceback(tostring(p42), 2),
				["context"] = "Promise created at:\n\n" .. p_u_37
			})
		end
	end, ...))
end
local v_u_44 = {
	["Error"] = v_u_8,
	["Status"] = v7("Promise.Status", {
		"Started",
		"Resolved",
		"Rejected",
		"Cancelled"
	}),
	["_getTime"] = os.clock,
	["_timeEvent"] = game:GetService("RunService").Heartbeat,
	["_unhandledRejectionCallbacks"] = {},
	["prototype"] = {}
}
v_u_44.__index = v_u_44.prototype
function v_u_44._new(p45, p_u_46, p47)
	-- upvalues: (copy) v_u_44, (copy) v_u_1, (copy) v_u_43
	if p47 ~= nil and not v_u_44.is(p47) then
		error("Argument #2 to Promise.new must be a promise or nil", 2)
	end
	local v_u_48 = {
		["_thread"] = nil,
		["_source"] = p45,
		["_status"] = v_u_44.Status.Started,
		["_values"] = nil,
		["_valuesLength"] = -1,
		["_unhandledRejection"] = true,
		["_queuedResolve"] = {},
		["_queuedReject"] = {},
		["_queuedFinally"] = {},
		["_cancellationHook"] = nil,
		["_parent"] = p47
	}
	local v49 = v_u_1
	v_u_48._consumers = setmetatable({}, v49)
	if p47 and p47._status == v_u_44.Status.Started then
		p47._consumers[v_u_48] = true
	end
	local v50 = v_u_44
	setmetatable(v_u_48, v50)
	local function v_u_51(...)
		-- upvalues: (copy) v_u_48
		v_u_48:_resolve(...)
	end
	local function v_u_52(...)
		-- upvalues: (copy) v_u_48
		v_u_48:_reject(...)
	end
	local function v_u_54(p53)
		-- upvalues: (copy) v_u_48, (ref) v_u_44
		if p53 then
			if v_u_48._status == v_u_44.Status.Cancelled then
				p53()
			else
				v_u_48._cancellationHook = p53
			end
		end
		return v_u_48._status == v_u_44.Status.Cancelled
	end
	v_u_48._thread = coroutine.create(function()
		-- upvalues: (ref) v_u_43, (copy) v_u_48, (copy) p_u_46, (copy) v_u_51, (copy) v_u_52, (copy) v_u_54
		local v55, _, v56 = v_u_43(v_u_48._source, p_u_46, v_u_51, v_u_52, v_u_54)
		if not v55 then
			v_u_52(v56[1])
		end
	end)
	task.spawn(v_u_48._thread)
	return v_u_48
end
function v_u_44.new(p57)
	-- upvalues: (copy) v_u_44
	return v_u_44._new(debug.traceback(nil, 2), p57)
end
function v_u_44.__tostring(p58)
	return string.format("Promise(%s)", p58._status)
end
function v_u_44.defer(p_u_59)
	-- upvalues: (copy) v_u_44, (copy) v_u_43
	local v_u_60 = debug.traceback(nil, 2)
	return v_u_44._new(v_u_60, function(p_u_61, p_u_62, p_u_63)
		-- upvalues: (ref) v_u_44, (ref) v_u_43, (copy) v_u_60, (copy) p_u_59
		local v_u_64 = nil
		v_u_64 = v_u_44._timeEvent:Connect(function()
			-- upvalues: (ref) v_u_64, (ref) v_u_43, (ref) v_u_60, (ref) p_u_59, (copy) p_u_61, (copy) p_u_62, (copy) p_u_63
			v_u_64:Disconnect()
			local v65, _, v66 = v_u_43(v_u_60, p_u_59, p_u_61, p_u_62, p_u_63)
			if not v65 then
				p_u_62(v66[1])
			end
		end)
	end)
end
v_u_44.async = v_u_44.defer
function v_u_44.resolve(...)
	-- upvalues: (copy) v_u_34, (copy) v_u_44
	local v_u_67, v_u_68 = v_u_34(...)
	return v_u_44._new(debug.traceback(nil, 2), function(p69)
		-- upvalues: (copy) v_u_68, (copy) v_u_67
		local v70 = v_u_68
		local v71 = v_u_67
		p69(unpack(v70, 1, v71))
	end)
end
function v_u_44.reject(...)
	-- upvalues: (copy) v_u_34, (copy) v_u_44
	local v_u_72, v_u_73 = v_u_34(...)
	return v_u_44._new(debug.traceback(nil, 2), function(_, p74)
		-- upvalues: (copy) v_u_73, (copy) v_u_72
		local v75 = v_u_73
		local v76 = v_u_72
		p74(unpack(v75, 1, v76))
	end)
end
function v_u_44._try(p77, p_u_78, ...)
	-- upvalues: (copy) v_u_34, (copy) v_u_44
	local v_u_79, v_u_80 = v_u_34(...)
	return v_u_44._new(p77, function(p81)
		-- upvalues: (copy) p_u_78, (copy) v_u_80, (copy) v_u_79
		local v82 = v_u_80
		local v83 = v_u_79
		p81(p_u_78(unpack(v82, 1, v83)))
	end)
end
function v_u_44.try(p84, ...)
	-- upvalues: (copy) v_u_44
	return v_u_44._try(debug.traceback(nil, 2), p84, ...)
end
function v_u_44._all(p85, p_u_86, p_u_87)
	-- upvalues: (copy) v_u_44
	if type(p_u_86) ~= "table" then
		error(string.format("Please pass a list of promises to %s", "Promise.all"), 3)
	end
	for v88, v89 in pairs(p_u_86) do
		if not v_u_44.is(v89) then
			error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(v88))), 3)
		end
	end
	if #p_u_86 == 0 or p_u_87 == 0 then
		return v_u_44.resolve({})
	else
		return v_u_44._new(p85, function(p_u_90, p_u_91, p92)
			-- upvalues: (copy) p_u_87, (copy) p_u_86
			local v_u_93 = {}
			local v_u_94 = {}
			local v_u_95 = 0
			local v_u_96 = 0
			local v_u_97 = false
			local function v_u_100(p98, ...)
				-- upvalues: (ref) v_u_97, (ref) v_u_95, (ref) p_u_87, (copy) v_u_93, (ref) p_u_86, (copy) p_u_90, (copy) v_u_94
				if not v_u_97 then
					v_u_95 = v_u_95 + 1
					if p_u_87 == nil then
						v_u_93[p98] = ...
					else
						v_u_93[v_u_95] = ...
					end
					if v_u_95 >= (p_u_87 or #p_u_86) then
						v_u_97 = true
						p_u_90(v_u_93)
						for _, v99 in ipairs(v_u_94) do
							v99:cancel()
						end
					end
				end
			end
			p92(function()
				-- upvalues: (copy) v_u_94
				for _, v101 in ipairs(v_u_94) do
					v101:cancel()
				end
			end)
			local v_u_102 = v_u_97
			for v_u_103, v104 in ipairs(p_u_86) do
				v_u_94[v_u_103] = v104:andThen(function(...)
					-- upvalues: (copy) v_u_100, (copy) v_u_103
					v_u_100(v_u_103, ...)
				end, function(...)
					-- upvalues: (ref) v_u_96, (ref) p_u_87, (ref) p_u_86, (copy) v_u_94, (ref) v_u_102, (copy) p_u_91
					v_u_96 = v_u_96 + 1
					if p_u_87 == nil or #p_u_86 - v_u_96 < p_u_87 then
						for _, v105 in ipairs(v_u_94) do
							v105:cancel()
						end
						v_u_102 = true
						p_u_91(...)
					end
				end)
			end
			if v_u_102 then
				for _, v106 in ipairs(v_u_94) do
					v106:cancel()
				end
			end
		end)
	end
end
function v_u_44.all(p107)
	-- upvalues: (copy) v_u_44
	return v_u_44._all(debug.traceback(nil, 2), p107)
end
function v_u_44.fold(p108, p_u_109, p110)
	-- upvalues: (copy) v_u_44
	local v111 = type(p108) == "table"
	assert(v111, "Bad argument #1 to Promise.fold: must be a table")
	local v112
	if type(p_u_109) == "function" then
		v112 = true
	elseif type(p_u_109) == "table" then
		local v113 = getmetatable(p_u_109)
		if v113 then
			local v114 = rawget(v113, "__call")
			v112 = type(v114) == "function"
		else
			v112 = false
		end
	else
		v112 = false
	end
	assert(v112, "Bad argument #2 to Promise.fold: must be a function")
	local v_u_115 = v_u_44.resolve(p110)
	return v_u_44.each(p108, function(p_u_116, p_u_117)
		-- upvalues: (ref) v_u_115, (copy) p_u_109
		v_u_115 = v_u_115:andThen(function(p118)
			-- upvalues: (ref) p_u_109, (copy) p_u_116, (copy) p_u_117
			return p_u_109(p118, p_u_116, p_u_117)
		end)
	end):andThen(function()
		-- upvalues: (ref) v_u_115
		return v_u_115
	end)
end
function v_u_44.some(p119, p120)
	-- upvalues: (copy) v_u_44
	local v121 = type(p120) == "number"
	assert(v121, "Bad argument #2 to Promise.some: must be a number")
	return v_u_44._all(debug.traceback(nil, 2), p119, p120)
end
function v_u_44.any(p122)
	-- upvalues: (copy) v_u_44
	return v_u_44._all(debug.traceback(nil, 2), p122, 1):andThen(function(p123)
		return p123[1]
	end)
end
function v_u_44.allSettled(p_u_124)
	-- upvalues: (copy) v_u_44
	if type(p_u_124) ~= "table" then
		error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2)
	end
	for v125, v126 in pairs(p_u_124) do
		if not v_u_44.is(v126) then
			error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(v125))), 2)
		end
	end
	if #p_u_124 == 0 then
		return v_u_44.resolve({})
	else
		return v_u_44._new(debug.traceback(nil, 2), function(p_u_127, _, p128)
			-- upvalues: (copy) p_u_124
			local v_u_129 = {}
			local v_u_130 = {}
			local v_u_131 = 0
			local function v_u_133(p132, ...)
				-- upvalues: (ref) v_u_131, (copy) v_u_129, (ref) p_u_124, (copy) p_u_127
				v_u_131 = v_u_131 + 1
				v_u_129[p132] = ...
				if v_u_131 >= #p_u_124 then
					p_u_127(v_u_129)
				end
			end
			p128(function()
				-- upvalues: (copy) v_u_130
				for _, v134 in ipairs(v_u_130) do
					v134:cancel()
				end
			end)
			for v_u_135, v136 in ipairs(p_u_124) do
				v_u_130[v_u_135] = v136:finally(function(...)
					-- upvalues: (copy) v_u_133, (copy) v_u_135
					v_u_133(v_u_135, ...)
				end)
			end
		end)
	end
end
function v_u_44.race(p_u_137)
	-- upvalues: (copy) v_u_44
	local v138 = type(p_u_137) == "table"
	local v139 = string.format
	assert(v138, v139("Please pass a list of promises to %s", "Promise.race"))
	for v140, v141 in pairs(p_u_137) do
		local v142 = v_u_44.is(v141)
		local v143 = string.format
		local v144 = tostring(v140)
		assert(v142, v143("Non-promise value passed into %s at index %s", "Promise.race", v144))
	end
	return v_u_44._new(debug.traceback(nil, 2), function(p_u_145, p_u_146, p147)
		-- upvalues: (copy) p_u_137
		local v_u_148 = {}
		local v_u_149 = false
		if not p147(function(...)
			-- upvalues: (copy) v_u_148, (ref) v_u_149, (copy) p_u_146
			for _, v150 in ipairs(v_u_148) do
				v150:cancel()
			end
			v_u_149 = true
			return p_u_146(...)
		end) then
			local v_u_151 = v_u_149
			for v152, v153 in ipairs(p_u_137) do
				v_u_148[v152] = v153:andThen(function(...)
					-- upvalues: (copy) v_u_148, (ref) v_u_151, (copy) p_u_145
					for _, v154 in ipairs(v_u_148) do
						v154:cancel()
					end
					v_u_151 = true
					return p_u_145(...)
				end, function(...)
					-- upvalues: (copy) v_u_148, (ref) v_u_151, (copy) p_u_146
					for _, v155 in ipairs(v_u_148) do
						v155:cancel()
					end
					v_u_151 = true
					return p_u_146(...)
				end)
			end
			if v_u_151 then
				for _, v156 in ipairs(v_u_148) do
					v156:cancel()
				end
			end
		end
	end)
end
function v_u_44.each(p_u_157, p_u_158)
	-- upvalues: (copy) v_u_44, (ref) v_u_8
	local v159 = type(p_u_157) == "table"
	local v160 = string.format
	assert(v159, v160("Please pass a list of promises to %s", "Promise.each"))
	local v161
	if type(p_u_158) == "function" then
		v161 = true
	elseif type(p_u_158) == "table" then
		local v162 = getmetatable(p_u_158)
		if v162 then
			local v163 = rawget(v162, "__call")
			v161 = type(v163) == "function"
		else
			v161 = false
		end
	else
		v161 = false
	end
	local v164 = string.format
	assert(v161, v164("Please pass a handler function to %s!", "Promise.each"))
	return v_u_44._new(debug.traceback(nil, 2), function(p165, p166, p167)
		-- upvalues: (copy) p_u_157, (ref) v_u_44, (ref) v_u_8, (copy) p_u_158
		local v168 = {}
		local v_u_169 = {}
		local v_u_170 = false
		p167(function()
			-- upvalues: (ref) v_u_170, (copy) v_u_169
			v_u_170 = true
			for _, v171 in ipairs(v_u_169) do
				v171:cancel()
			end
		end)
		local v172 = v_u_170
		local v173 = {}
		for v174, v175 in ipairs(p_u_157) do
			if v_u_44.is(v175) then
				if v175:getStatus() == v_u_44.Status.Cancelled then
					for _, v176 in ipairs(v_u_169) do
						v176:cancel()
					end
					return p166(v_u_8.new({
						["error"] = "Promise is cancelled",
						["kind"] = v_u_8.Kind.AlreadyCancelled,
						["context"] = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", v174, v175._source)
					}))
				end
				if v175:getStatus() == v_u_44.Status.Rejected then
					for _, v177 in ipairs(v_u_169) do
						v177:cancel()
					end
					return p166(select(2, v175:await()))
				end
				local v178 = v175:andThen(function(...)
					return ...
				end)
				table.insert(v_u_169, v178)
				v173[v174] = v178
			else
				v173[v174] = v175
			end
		end
		for v179, v182 in ipairs(v173) do
			if v_u_44.is(v182) then
				local v181, v182 = v182:await()
				if not v181 then
					for _, v183 in ipairs(v_u_169) do
						v183:cancel()
					end
					return p166(v182)
				end
			end
			if v172 then
				return
			end
			local v184 = v_u_44.resolve(p_u_158(v182, v179))
			table.insert(v_u_169, v184)
			local v185, v186 = v184:await()
			if not v185 then
				for _, v187 in ipairs(v_u_169) do
					v187:cancel()
				end
				return p166(v186)
			end
			v168[v179] = v186
		end
		p165(v168)
	end)
end
function v_u_44.is(p188)
	-- upvalues: (copy) v_u_44
	if type(p188) ~= "table" then
		return false
	end
	local v189 = getmetatable(p188)
	if v189 == v_u_44 then
		return true
	end
	if v189 ~= nil then
		if type(v189) == "table" then
			local v190 = rawget(v189, "__index")
			if type(v190) == "table" then
				local v191 = rawget(v189, "__index")
				local v192 = rawget(v191, "andThen")
				local v193
				if type(v192) == "function" then
					v193 = true
				else
					local v194 = type(v192) == "table" and getmetatable(v192)
					if v194 then
						local v195 = rawget(v194, "__call")
						v193 = type(v195) == "function"
					else
						v193 = false
					end
				end
				if v193 then
					return true
				end
			end
		end
		return false
	end
	local v196 = p188.andThen
	if type(v196) == "function" then
		return true
	end
	local v197 = type(v196) == "table" and getmetatable(v196)
	if v197 then
		local v198 = rawget(v197, "__call")
		if type(v198) == "function" then
			return true
		end
	end
	return false
end
function v_u_44.promisify(p_u_199)
	-- upvalues: (copy) v_u_44
	return function(...)
		-- upvalues: (ref) v_u_44, (copy) p_u_199
		return v_u_44._try(debug.traceback(nil, 2), p_u_199, ...)
	end
end
local v_u_200 = nil
local v_u_201 = nil
function v_u_44.delay(p202)
	-- upvalues: (copy) v_u_44, (ref) v_u_201, (ref) v_u_200
	local v203 = type(p202) == "number"
	assert(v203, "Bad argument #1 to Promise.delay, must be a number.")
	local v_u_204 = (p202 < 0.016666666666666666 or p202 == (1 / 0)) and 0.016666666666666666 or p202
	return v_u_44._new(debug.traceback(nil, 2), function(p205, _, p206)
		-- upvalues: (ref) v_u_44, (ref) v_u_204, (ref) v_u_201, (ref) v_u_200
		local v207 = v_u_44._getTime()
		local v208 = v207 + v_u_204
		local v_u_209 = {
			["resolve"] = p205,
			["startTime"] = v207,
			["endTime"] = v208
		}
		if v_u_201 == nil then
			v_u_200 = v_u_209
			v_u_201 = v_u_44._timeEvent:Connect(function()
				-- upvalues: (ref) v_u_44, (ref) v_u_200, (ref) v_u_201
				local v210 = v_u_44._getTime()
				while v_u_200 ~= nil and v_u_200.endTime < v210 do
					local v211 = v_u_200
					v_u_200 = v211.next
					if v_u_200 == nil then
						v_u_201:Disconnect()
						v_u_201 = nil
					else
						v_u_200.previous = nil
					end
					v211.resolve(v_u_44._getTime() - v211.startTime)
				end
			end)
		elseif v_u_200.endTime < v208 then
			local v212 = v_u_200
			local v213 = v212.next
			while v213 ~= nil and v213.endTime < v208 do
				local v214 = v213.next
				v212 = v213
				v213 = v214
			end
			v212.next = v_u_209
			v_u_209.previous = v212
			if v213 ~= nil then
				v_u_209.next = v213
				v213.previous = v_u_209
			end
		else
			v_u_209.next = v_u_200
			v_u_200.previous = v_u_209
			v_u_200 = v_u_209
		end
		p206(function()
			-- upvalues: (copy) v_u_209, (ref) v_u_200, (ref) v_u_201
			local v215 = v_u_209.next
			if v_u_200 == v_u_209 then
				if v215 == nil then
					v_u_201:Disconnect()
					v_u_201 = nil
				else
					v215.previous = nil
				end
				v_u_200 = v215
			else
				local v216 = v_u_209.previous
				v216.next = v215
				if v215 ~= nil then
					v215.previous = v216
				end
			end
		end)
	end)
end
local function v221(p217, p_u_218, p_u_219)
	-- upvalues: (copy) v_u_44, (ref) v_u_8
	local v_u_220 = debug.traceback(nil, 2)
	return v_u_44.race({ v_u_44.delay(p_u_218):andThen(function()
			-- upvalues: (ref) v_u_44, (copy) p_u_219, (ref) v_u_8, (copy) p_u_218, (copy) v_u_220
			return v_u_44.reject(p_u_219 == nil and v_u_8.new({
				["kind"] = v_u_8.Kind.TimedOut,
				["error"] = "Timed out",
				["context"] = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", p_u_218, v_u_220)
			}) or p_u_219)
		end), p217 })
end
v_u_44.prototype.timeout = v221
function v_u_44.prototype.getStatus(p222)
	return p222._status
end
function v_u_44.prototype._andThen(p_u_223, p_u_224, p_u_225, p_u_226)
	-- upvalues: (copy) v_u_44, (copy) v_u_43
	p_u_223._unhandledRejection = false
	if p_u_223._status ~= v_u_44.Status.Cancelled then
		return v_u_44._new(p_u_224, function(p_u_227, p_u_228, p229)
			-- upvalues: (copy) p_u_225, (copy) p_u_224, (ref) v_u_43, (copy) p_u_226, (copy) p_u_223, (ref) v_u_44
			local v_u_230
			if p_u_225 then
				local v_u_231 = p_u_224
				local v_u_232 = p_u_225
				v_u_230 = function(...)
					-- upvalues: (ref) v_u_43, (copy) v_u_231, (copy) v_u_232, (copy) p_u_227, (copy) p_u_228
					local v233, v234, v235 = v_u_43(v_u_231, v_u_232, ...)
					if v233 then
						p_u_227(unpack(v235, 1, v234))
					else
						p_u_228(v235[1])
					end
				end
			else
				v_u_230 = p_u_227
			end
			if p_u_226 then
				local v_u_236 = p_u_224
				local v_u_237 = p_u_226
				p_u_228 = function(...)
					-- upvalues: (ref) v_u_43, (copy) v_u_236, (copy) v_u_237, (copy) p_u_227, (copy) p_u_228
					local v238, v239, v240 = v_u_43(v_u_236, v_u_237, ...)
					if v238 then
						p_u_227(unpack(v240, 1, v239))
					else
						p_u_228(v240[1])
					end
				end
			end
			if p_u_223._status == v_u_44.Status.Started then
				local v241 = p_u_223._queuedResolve
				table.insert(v241, v_u_230)
				local v242 = p_u_223._queuedReject
				table.insert(v242, p_u_228)
				p229(function()
					-- upvalues: (ref) p_u_223, (ref) v_u_44, (ref) v_u_230, (ref) p_u_228
					if p_u_223._status == v_u_44.Status.Started then
						table.remove(p_u_223._queuedResolve, table.find(p_u_223._queuedResolve, v_u_230))
						table.remove(p_u_223._queuedReject, table.find(p_u_223._queuedReject, p_u_228))
					end
				end)
			elseif p_u_223._status == v_u_44.Status.Resolved then
				local v243 = p_u_223._values
				local v244 = p_u_223._valuesLength
				v_u_230(unpack(v243, 1, v244))
			elseif p_u_223._status == v_u_44.Status.Rejected then
				local v245 = p_u_223._values
				local v246 = p_u_223._valuesLength
				p_u_228(unpack(v245, 1, v246))
			end
		end, p_u_223)
	end
	local v247 = v_u_44.new(function() end)
	v247:cancel()
	return v247
end
function v_u_44.prototype.andThen(p248, p249, p250)
	local v251
	if p249 == nil or type(p249) == "function" then
		v251 = true
	elseif type(p249) == "table" then
		local v252 = getmetatable(p249)
		if v252 then
			local v253 = rawget(v252, "__call")
			v251 = type(v253) == "function"
		else
			v251 = false
		end
	else
		v251 = false
	end
	local v254 = string.format
	assert(v251, v254("Please pass a handler function to %s!", "Promise:andThen"))
	local v255
	if p250 == nil or type(p250) == "function" then
		v255 = true
	elseif type(p250) == "table" then
		local v256 = getmetatable(p250)
		if v256 then
			local v257 = rawget(v256, "__call")
			v255 = type(v257) == "function"
		else
			v255 = false
		end
	else
		v255 = false
	end
	local v258 = string.format
	assert(v255, v258("Please pass a handler function to %s!", "Promise:andThen"))
	return p248:_andThen(debug.traceback(nil, 2), p249, p250)
end
function v_u_44.prototype.catch(p259, p260)
	local v261
	if p260 == nil or type(p260) == "function" then
		v261 = true
	elseif type(p260) == "table" then
		local v262 = getmetatable(p260)
		if v262 then
			local v263 = rawget(v262, "__call")
			v261 = type(v263) == "function"
		else
			v261 = false
		end
	else
		v261 = false
	end
	local v264 = string.format
	assert(v261, v264("Please pass a handler function to %s!", "Promise:catch"))
	return p259:_andThen(debug.traceback(nil, 2), nil, p260)
end
function v_u_44.prototype.tap(p265, p_u_266)
	-- upvalues: (copy) v_u_44, (copy) v_u_34
	local v267
	if type(p_u_266) == "function" then
		v267 = true
	elseif type(p_u_266) == "table" then
		local v268 = getmetatable(p_u_266)
		if v268 then
			local v269 = rawget(v268, "__call")
			v267 = type(v269) == "function"
		else
			v267 = false
		end
	else
		v267 = false
	end
	local v270 = string.format
	assert(v267, v270("Please pass a handler function to %s!", "Promise:tap"))
	return p265:_andThen(debug.traceback(nil, 2), function(...)
		-- upvalues: (copy) p_u_266, (ref) v_u_44, (ref) v_u_34
		local v271 = p_u_266(...)
		if not v_u_44.is(v271) then
			return ...
		end
		local v_u_272, v_u_273 = v_u_34(...)
		return v271:andThen(function()
			-- upvalues: (copy) v_u_273, (copy) v_u_272
			local v274 = v_u_273
			local v275 = v_u_272
			return unpack(v274, 1, v275)
		end)
	end)
end
function v_u_44.prototype.andThenCall(p276, p_u_277, ...)
	-- upvalues: (copy) v_u_34
	local v278
	if type(p_u_277) == "function" then
		v278 = true
	elseif type(p_u_277) == "table" then
		local v279 = getmetatable(p_u_277)
		if v279 then
			local v280 = rawget(v279, "__call")
			v278 = type(v280) == "function"
		else
			v278 = false
		end
	else
		v278 = false
	end
	local v281 = string.format
	assert(v278, v281("Please pass a handler function to %s!", "Promise:andThenCall"))
	local v_u_282, v_u_283 = v_u_34(...)
	return p276:_andThen(debug.traceback(nil, 2), function()
		-- upvalues: (copy) p_u_277, (copy) v_u_283, (copy) v_u_282
		local v284 = v_u_283
		local v285 = v_u_282
		return p_u_277(unpack(v284, 1, v285))
	end)
end
function v_u_44.prototype.andThenReturn(p286, ...)
	-- upvalues: (copy) v_u_34
	local v_u_287, v_u_288 = v_u_34(...)
	return p286:_andThen(debug.traceback(nil, 2), function()
		-- upvalues: (copy) v_u_288, (copy) v_u_287
		local v289 = v_u_288
		local v290 = v_u_287
		return unpack(v289, 1, v290)
	end)
end
function v_u_44.prototype.cancel(p291)
	-- upvalues: (copy) v_u_44
	if p291._status == v_u_44.Status.Started then
		p291._status = v_u_44.Status.Cancelled
		if p291._cancellationHook then
			p291._cancellationHook()
		end
		coroutine.close(p291._thread)
		if p291._parent then
			p291._parent:_consumerCancelled(p291)
		end
		for v292 in pairs(p291._consumers) do
			v292:cancel()
		end
		p291:_finalize()
	end
end
function v_u_44.prototype._consumerCancelled(p293, p294)
	-- upvalues: (copy) v_u_44
	if p293._status == v_u_44.Status.Started then
		p293._consumers[p294] = nil
		if next(p293._consumers) == nil then
			p293:cancel()
		end
	end
end
function v_u_44.prototype._finally(p_u_295, p296, p_u_297)
	-- upvalues: (copy) v_u_44
	p_u_295._unhandledRejection = false
	return v_u_44._new(p296, function(p_u_298, p_u_299, p300)
		-- upvalues: (copy) p_u_295, (copy) p_u_297, (ref) v_u_44
		local v_u_301 = nil
		p300(function()
			-- upvalues: (ref) p_u_295, (ref) v_u_301
			p_u_295:_consumerCancelled(p_u_295)
			if v_u_301 then
				v_u_301:cancel()
			end
		end)
		local v304 = p_u_297 and function(...)
			-- upvalues: (ref) p_u_297, (ref) v_u_44, (ref) v_u_301, (copy) p_u_298, (ref) p_u_295, (copy) p_u_299
			local v302 = p_u_297(...)
			if v_u_44.is(v302) then
				v_u_301 = v302
				v302:finally(function(p303)
					-- upvalues: (ref) v_u_44, (ref) p_u_298, (ref) p_u_295
					if p303 ~= v_u_44.Status.Rejected then
						p_u_298(p_u_295)
					end
				end):catch(function(...)
					-- upvalues: (ref) p_u_299
					p_u_299(...)
				end)
			else
				p_u_298(p_u_295)
			end
		end or p_u_298
		if p_u_295._status == v_u_44.Status.Started then
			local v305 = p_u_295._queuedFinally
			table.insert(v305, v304)
		else
			v304(p_u_295._status)
		end
	end)
end
function v_u_44.prototype.finally(p306, p307)
	local v308
	if p307 == nil or type(p307) == "function" then
		v308 = true
	elseif type(p307) == "table" then
		local v309 = getmetatable(p307)
		if v309 then
			local v310 = rawget(v309, "__call")
			v308 = type(v310) == "function"
		else
			v308 = false
		end
	else
		v308 = false
	end
	local v311 = string.format
	assert(v308, v311("Please pass a handler function to %s!", "Promise:finally"))
	return p306:_finally(debug.traceback(nil, 2), p307)
end
function v_u_44.prototype.finallyCall(p312, p_u_313, ...)
	-- upvalues: (copy) v_u_34
	local v314
	if type(p_u_313) == "function" then
		v314 = true
	elseif type(p_u_313) == "table" then
		local v315 = getmetatable(p_u_313)
		if v315 then
			local v316 = rawget(v315, "__call")
			v314 = type(v316) == "function"
		else
			v314 = false
		end
	else
		v314 = false
	end
	local v317 = string.format
	assert(v314, v317("Please pass a handler function to %s!", "Promise:finallyCall"))
	local v_u_318, v_u_319 = v_u_34(...)
	return p312:_finally(debug.traceback(nil, 2), function()
		-- upvalues: (copy) p_u_313, (copy) v_u_319, (copy) v_u_318
		local v320 = v_u_319
		local v321 = v_u_318
		return p_u_313(unpack(v320, 1, v321))
	end)
end
function v_u_44.prototype.finallyReturn(p322, ...)
	-- upvalues: (copy) v_u_34
	local v_u_323, v_u_324 = v_u_34(...)
	return p322:_finally(debug.traceback(nil, 2), function()
		-- upvalues: (copy) v_u_324, (copy) v_u_323
		local v325 = v_u_324
		local v326 = v_u_323
		return unpack(v325, 1, v326)
	end)
end
function v_u_44.prototype.awaitStatus(p327)
	-- upvalues: (copy) v_u_44
	p327._unhandledRejection = false
	if p327._status == v_u_44.Status.Started then
		local v_u_328 = coroutine.running()
		p327:finally(function()
			-- upvalues: (copy) v_u_328
			task.spawn(v_u_328)
		end):catch(function() end)
		coroutine.yield()
	end
	if p327._status == v_u_44.Status.Resolved then
		local v329 = p327._status
		local v330 = p327._values
		local v331 = p327._valuesLength
		return v329, unpack(v330, 1, v331)
	end
	if p327._status ~= v_u_44.Status.Rejected then
		return p327._status
	end
	local v332 = p327._status
	local v333 = p327._values
	local v334 = p327._valuesLength
	return v332, unpack(v333, 1, v334)
end
local function v_u_336(p335, ...)
	-- upvalues: (copy) v_u_44
	return p335 == v_u_44.Status.Resolved, ...
end
function v_u_44.prototype.await(p337)
	-- upvalues: (copy) v_u_336
	return v_u_336(p337:awaitStatus())
end
local function v_u_339(p338, ...)
	-- upvalues: (copy) v_u_44
	if p338 ~= v_u_44.Status.Resolved then
		error(... == nil and "Expected Promise rejected with no value." or ..., 3)
	end
	return ...
end
function v_u_44.prototype.expect(p340)
	-- upvalues: (copy) v_u_339
	return v_u_339(p340:awaitStatus())
end
v_u_44.prototype.awaitValue = v_u_44.prototype.expect
function v_u_44.prototype._unwrap(p341)
	-- upvalues: (copy) v_u_44
	if p341._status == v_u_44.Status.Started then
		error("Promise has not resolved or rejected.", 2)
	end
	local v342 = p341._status == v_u_44.Status.Resolved
	local v343 = p341._values
	local v344 = p341._valuesLength
	return v342, unpack(v343, 1, v344)
end
local function v353(p_u_345, ...)
	-- upvalues: (copy) v_u_44, (ref) v_u_8, (copy) v_u_34
	if p_u_345._status == v_u_44.Status.Started then
		if v_u_44.is((...)) then
			if select("#", ...) > 1 then
				local v346 = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", p_u_345._source)
				warn(v346)
			end
			local v_u_347 = ...
			local v349 = v_u_347:andThen(function(...)
				-- upvalues: (copy) p_u_345
				p_u_345:_resolve(...)
			end, function(...)
				-- upvalues: (copy) v_u_347, (ref) v_u_8, (copy) p_u_345
				local v348 = v_u_347._values[1]
				if v_u_347._error then
					v348 = v_u_8.new({
						["error"] = v_u_347._error,
						["kind"] = v_u_8.Kind.ExecutionError,
						["context"] = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]"
					})
				end
				if v_u_8.isKind(v348, v_u_8.Kind.ExecutionError) then
					return p_u_345:_reject(v348:extend({
						["error"] = "This Promise was chained to a Promise that errored.",
						["trace"] = "",
						["context"] = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", p_u_345._source)
					}))
				end
				p_u_345:_reject(...)
			end)
			if v349._status == v_u_44.Status.Cancelled then
				p_u_345:cancel()
			elseif v349._status == v_u_44.Status.Started then
				p_u_345._parent = v349
				v349._consumers[p_u_345] = true
			end
		else
			p_u_345._status = v_u_44.Status.Resolved
			local v350, v351 = v_u_34(...)
			p_u_345._valuesLength = v350
			p_u_345._values = v351
			for _, v352 in ipairs(p_u_345._queuedResolve) do
				coroutine.wrap(v352)(...)
			end
			p_u_345:_finalize()
			return
		end
	else
		if v_u_44.is((...)) then
			(...):_consumerCancelled(p_u_345)
		end
		return
	end
end
v_u_44.prototype._resolve = v353
function v_u_44.prototype._reject(p_u_354, ...)
	-- upvalues: (copy) v_u_44, (copy) v_u_34
	if p_u_354._status == v_u_44.Status.Started then
		p_u_354._status = v_u_44.Status.Rejected
		local v355, v356 = v_u_34(...)
		p_u_354._valuesLength = v355
		p_u_354._values = v356
		local v357 = p_u_354._queuedReject
		if next(v357) == nil then
			local v_u_358 = tostring((...))
			coroutine.wrap(function()
				-- upvalues: (ref) v_u_44, (copy) p_u_354, (copy) v_u_358
				v_u_44._timeEvent:Wait()
				if p_u_354._unhandledRejection then
					local v359 = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", v_u_358, p_u_354._source)
					for _, v360 in ipairs(v_u_44._unhandledRejectionCallbacks) do
						local v361 = task.spawn
						local v362 = p_u_354
						local v363 = p_u_354._values
						local v364 = p_u_354._valuesLength
						v361(v360, v362, unpack(v363, 1, v364))
					end
					if not v_u_44.TEST then
						warn(v359)
					end
				else
					return
				end
			end)()
		else
			for _, v365 in ipairs(p_u_354._queuedReject) do
				coroutine.wrap(v365)(...)
			end
		end
		p_u_354:_finalize()
	end
end
function v_u_44.prototype._finalize(p366)
	-- upvalues: (copy) v_u_44
	for _, v367 in ipairs(p366._queuedFinally) do
		coroutine.wrap(v367)(p366._status)
	end
	p366._queuedFinally = nil
	p366._queuedReject = nil
	p366._queuedResolve = nil
	if not v_u_44.TEST then
		p366._parent = nil
		p366._consumers = nil
	end
	task.defer(coroutine.close, p366._thread)
end
local function v372(p368, p369)
	-- upvalues: (copy) v_u_44, (ref) v_u_8
	local v370 = debug.traceback(nil, 2)
	if p368._status == v_u_44.Status.Resolved then
		return p368:_andThen(v370, function(...)
			return ...
		end)
	end
	local v371 = v_u_44.reject
	if p369 == nil then
		p369 = v_u_8.new({
			["kind"] = v_u_8.Kind.NotResolvedInTime,
			["error"] = "This Promise was not resolved in time for :now()",
			["context"] = ":now() was called at:\n\n" .. v370
		}) or p369
	end
	return v371(p369)
end
v_u_44.prototype.now = v372
function v_u_44.retry(p_u_373, p_u_374, ...)
	-- upvalues: (copy) v_u_44
	local v375
	if type(p_u_373) == "function" then
		v375 = true
	elseif type(p_u_373) == "table" then
		local v376 = getmetatable(p_u_373)
		if v376 then
			local v377 = rawget(v376, "__call")
			v375 = type(v377) == "function"
		else
			v375 = false
		end
	else
		v375 = false
	end
	assert(v375, "Parameter #1 to Promise.retry must be a function")
	local v378 = type(p_u_374) == "number"
	assert(v378, "Parameter #2 to Promise.retry must be a number")
	local v_u_379 = { ... }
	local v_u_380 = select("#", ...)
	return v_u_44.resolve(p_u_373(...)):catch(function(...)
		-- upvalues: (copy) p_u_374, (ref) v_u_44, (copy) p_u_373, (copy) v_u_379, (copy) v_u_380
		if p_u_374 <= 0 then
			return v_u_44.reject(...)
		end
		local v381 = v_u_379
		local v382 = v_u_380
		return v_u_44.retry(p_u_373, p_u_374 - 1, unpack(v381, 1, v382))
	end)
end
function v_u_44.retryWithDelay(p_u_383, p_u_384, p_u_385, ...)
	-- upvalues: (copy) v_u_44
	local v386
	if type(p_u_383) == "function" then
		v386 = true
	elseif type(p_u_383) == "table" then
		local v387 = getmetatable(p_u_383)
		if v387 then
			local v388 = rawget(v387, "__call")
			v386 = type(v388) == "function"
		else
			v386 = false
		end
	else
		v386 = false
	end
	assert(v386, "Parameter #1 to Promise.retry must be a function")
	local v389 = type(p_u_384) == "number"
	assert(v389, "Parameter #2 (times) to Promise.retry must be a number")
	local v390 = type(p_u_385) == "number"
	assert(v390, "Parameter #3 (seconds) to Promise.retry must be a number")
	local v_u_391 = { ... }
	local v_u_392 = select("#", ...)
	return v_u_44.resolve(p_u_383(...)):catch(function(...)
		-- upvalues: (copy) p_u_384, (ref) v_u_44, (copy) p_u_385, (copy) p_u_383, (copy) v_u_391, (copy) v_u_392
		if p_u_384 <= 0 then
			return v_u_44.reject(...)
		end
		v_u_44.delay(p_u_385):await()
		local v393 = v_u_391
		local v394 = v_u_392
		return v_u_44.retryWithDelay(p_u_383, p_u_384 - 1, p_u_385, unpack(v393, 1, v394))
	end)
end
function v_u_44.fromEvent(p_u_395, p396)
	-- upvalues: (copy) v_u_44
	local v_u_397 = p396 or function()
		return true
	end
	return v_u_44._new(debug.traceback(nil, 2), function(p_u_398, _, p399)
		-- upvalues: (copy) p_u_395, (ref) v_u_397
		local v_u_400 = nil
		local v_u_401 = false
		local function v402()
			-- upvalues: (ref) v_u_400
			v_u_400:Disconnect()
			v_u_400 = nil
		end
		v_u_400 = p_u_395:Connect(function(...)
			-- upvalues: (ref) v_u_397, (copy) p_u_398, (ref) v_u_400, (ref) v_u_401
			local v403 = v_u_397(...)
			if v403 == true then
				p_u_398(...)
				if v_u_400 then
					v_u_400:Disconnect()
					v_u_400 = nil
				else
					v_u_401 = true
				end
			else
				if type(v403) ~= "boolean" then
					error("Promise.fromEvent predicate should always return a boolean")
				end
				return
			end
		end)
		if v_u_401 and v_u_400 then
			return v402()
		end
		p399(v402)
	end)
end
function v_u_44.onUnhandledRejection(p_u_404)
	-- upvalues: (copy) v_u_44
	local v405 = v_u_44._unhandledRejectionCallbacks
	table.insert(v405, p_u_404)
	return function()
		-- upvalues: (ref) v_u_44, (copy) p_u_404
		local v406 = table.find(v_u_44._unhandledRejectionCallbacks, p_u_404)
		if v406 then
			table.remove(v_u_44._unhandledRejectionCallbacks, v406)
		end
	end
end
return v_u_44]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[promise]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3660"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function()
	local v_u_1 = require(script.Parent)
	v_u_1.TEST = true
	local v_u_2 = Instance.new("BindableEvent")
	v_u_1._timeEvent = v_u_2.Event
	local v_u_3 = 0
	function v_u_1._getTime()
		-- upvalues: (ref) v_u_3
		return v_u_3
	end
	local function v_u_6(p4)
		-- upvalues: (ref) v_u_3, (copy) v_u_2
		local v5 = p4 or 0.016666666666666666
		v_u_3 = v_u_3 + v5
		v_u_2:Fire(v5)
	end
	local function v_u_7(...)
		return select("#", ...), { ... }
	end
	describe("Promise.Status", function()
		-- upvalues: (copy) v_u_1
		it("should error if indexing nil value", function()
			-- upvalues: (ref) v_u_1
			expect(function()
				-- upvalues: (ref) v_u_1
				local _ = v_u_1.Status.wrong
			end).to.throw()
		end)
	end)
	describe("Unhandled rejection signal", function()
		-- upvalues: (copy) v_u_1, (ref) v_u_6
		it("should call unhandled rejection callbacks", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_6
			local v_u_9 = v_u_1.new(function(_, p8)
				p8(1, 2)
			end)
			local v_u_10 = 0
			local function v14(p11, p12, p13)
				-- upvalues: (ref) v_u_10, (copy) v_u_9
				v_u_10 = v_u_10 + 1
				expect(p11).to.equal(v_u_9)
				expect(p12).to.equal(1)
				expect(p13).to.equal(2)
			end
			local v15 = v_u_1.onUnhandledRejection(v14)
			v_u_6()
			expect(v_u_10).to.equal(1)
			v15()
			v_u_1.new(function(_, p16)
				p16(3, 4)
			end)
			v_u_6()
			expect(v_u_10).to.equal(1)
		end)
	end)
	describe("Promise.new", function()
		-- upvalues: (copy) v_u_1
		it("should instantiate with a callback", function()
			-- upvalues: (ref) v_u_1
			local v17 = v_u_1.new(function() end)
			expect(v17).to.be.ok()
		end)
		it("should invoke the given callback with resolve and reject", function()
			-- upvalues: (ref) v_u_1
			local v_u_18 = 0
			local v_u_19 = nil
			local v_u_20 = nil
			local v23 = v_u_1.new(function(p21, p22)
				-- upvalues: (ref) v_u_18, (ref) v_u_19, (ref) v_u_20
				v_u_18 = v_u_18 + 1
				v_u_19 = p21
				v_u_20 = p22
			end)
			expect(v23).to.be.ok()
			expect(v_u_18).to.equal(1)
			expect(v_u_19).to.be.a("function")
			expect(v_u_20).to.be.a("function")
			expect(v23:getStatus()).to.equal(v_u_1.Status.Started)
		end)
		it("should resolve promises on resolve()", function()
			-- upvalues: (ref) v_u_1
			local v_u_24 = 0
			local v26 = v_u_1.new(function(p25)
				-- upvalues: (ref) v_u_24
				v_u_24 = v_u_24 + 1
				p25()
			end)
			expect(v26).to.be.ok()
			expect(v_u_24).to.equal(1)
			expect(v26:getStatus()).to.equal(v_u_1.Status.Resolved)
		end)
		it("should reject promises on reject()", function()
			-- upvalues: (ref) v_u_1
			local v_u_27 = 0
			local v29 = v_u_1.new(function(_, p28)
				-- upvalues: (ref) v_u_27
				v_u_27 = v_u_27 + 1
				p28()
			end)
			expect(v29).to.be.ok()
			expect(v_u_27).to.equal(1)
			expect(v29:getStatus()).to.equal(v_u_1.Status.Rejected)
		end)
		it("should reject on error in callback", function()
			-- upvalues: (ref) v_u_1
			local v_u_30 = 0
			local v31 = v_u_1.new(function()
				-- upvalues: (ref) v_u_30
				v_u_30 = v_u_30 + 1
				error("hahah")
			end)
			expect(v31).to.be.ok()
			expect(v_u_30).to.equal(1)
			expect(v31:getStatus()).to.equal(v_u_1.Status.Rejected)
			local v32 = expect
			local v33 = v31._values[1]
			v32(tostring(v33):find("hahah")).to.be.ok()
			local v34 = expect
			local v35 = v31._values[1]
			v34(tostring(v35):find("init.spec")).to.be.ok()
			local v36 = expect
			local v37 = v31._values[1]
			v36(tostring(v37):find("runExecutor")).to.be.ok()
		end)
		it("should work with C functions", function()
			-- upvalues: (ref) v_u_1
			expect(function()
				-- upvalues: (ref) v_u_1
				v_u_1.new(tick):andThen(tick)
			end).to.never.throw()
		end)
		it("should have a nice tostring", function()
			-- upvalues: (ref) v_u_1
			local v38 = expect
			local v39 = v_u_1.resolve
			v38(tostring(v39()):gmatch("Promise(Resolved)")).to.be.ok()
		end)
		it("should allow yielding", function()
			-- upvalues: (ref) v_u_1
			local v_u_40 = Instance.new("BindableEvent")
			local v42 = v_u_1.new(function(p41)
				-- upvalues: (copy) v_u_40
				v_u_40.Event:Wait()
				p41(5)
			end)
			expect(v42:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_40:Fire()
			expect(v42:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v42._values[1]).to.equal(5)
		end)
		it("should preserve stack traces of resolve-chained promises", function()
			-- upvalues: (ref) v_u_1
			local v44 = v_u_1.new(function(p43)
				-- upvalues: (ref) v_u_1
				p43(v_u_1.new(function()
					error("sample text")
				end))
			end)
			expect(v44:getStatus()).to.equal(v_u_1.Status.Rejected)
			local v45 = v44._values[1]
			local v46 = tostring(v45)
			expect(v46:find("sample text")).to.be.ok()
			expect(v46:find("nestedCall")).to.be.ok()
			expect(v46:find("runExecutor")).to.be.ok()
			expect(v46:find("runPlanNode")).to.be.ok()
			expect(v46:find("...Rejected because it was chained to the following Promise, which encountered an error:")).to.be.ok()
		end)
		it("should report errors from Promises with _error (< v2)", function()
			-- upvalues: (ref) v_u_1
			local v47 = v_u_1.reject()
			v47._error = "Sample error"
			local v48 = v_u_1.resolve():andThenReturn(v47)
			expect(v48:getStatus()).to.equal(v_u_1.Status.Rejected)
			local v49 = v48._values[1]
			local v50 = tostring(v49)
			expect(v50:find("Sample error")).to.be.ok()
			expect(v50:find("...Rejected because it was chained to the following Promise, which encountered an error:")).to.be.ok()
			expect(v50:find("%[No stack trace available")).to.be.ok()
		end)
		it("should allow callable tables", function()
			-- upvalues: (ref) v_u_1
			local v52 = v_u_1.new((setmetatable({}, {
				["__call"] = function(_, p51)
					p51(1)
				end
			})))
			local v_u_53 = false
			local v55 = {
				["__call"] = function(_, p54)
					-- upvalues: (ref) v_u_53
					expect(p54).to.equal(1)
					v_u_53 = true
				end
			}
			v52:andThen((setmetatable({}, v55)))
			expect(v_u_53).to.equal(true)
		end)
		itSKIP("should close the thread after resolve", function()
			-- upvalues: (ref) v_u_1
			local v_u_56 = 0
			v_u_1.new(function(p57)
				-- upvalues: (ref) v_u_56, (ref) v_u_1
				v_u_56 = v_u_56 + 1
				p57()
				v_u_1.delay(1):await()
				v_u_56 = v_u_56 + 1
			end)
			task.wait(1)
			expect(v_u_56).to.equal(1)
		end)
	end)
	describe("Promise.defer", function()
		-- upvalues: (copy) v_u_1, (ref) v_u_6
		it("should execute after the time event", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_6
			local v_u_58 = 0
			local v63 = v_u_1.defer(function(p59, p60, p61, p62)
				-- upvalues: (ref) v_u_58
				expect((type(p59))).to.equal("function")
				expect((type(p60))).to.equal("function")
				expect((type(p61))).to.equal("function")
				expect((type(p62))).to.equal("nil")
				v_u_58 = v_u_58 + 1
				p59("foo")
			end)
			expect(v_u_58).to.equal(0)
			expect(v63:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_6()
			expect(v_u_58).to.equal(1)
			expect(v63:getStatus()).to.equal(v_u_1.Status.Resolved)
			v_u_6()
			expect(v_u_58).to.equal(1)
		end)
	end)
	describe("Promise.delay", function()
		-- upvalues: (copy) v_u_1, (ref) v_u_6
		it("should schedule promise resolution", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_6
			local v64 = v_u_1.delay(1)
			expect(v64:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_6()
			expect(v64:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_6(1)
			expect(v64:getStatus()).to.equal(v_u_1.Status.Resolved)
		end)
		it("should allow for delays to be cancelled", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_6
			local v_u_65 = v_u_1.delay(2)
			v_u_1.delay(1):andThen(function()
				-- upvalues: (copy) v_u_65
				v_u_65:cancel()
			end)
			expect(v_u_65:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_6()
			expect(v_u_65:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_6(1)
			expect(v_u_65:getStatus()).to.equal(v_u_1.Status.Cancelled)
			v_u_6(1)
		end)
	end)
	describe("Promise.resolve", function()
		-- upvalues: (copy) v_u_1
		it("should immediately resolve with a value", function()
			-- upvalues: (ref) v_u_1
			local v66 = v_u_1.resolve(5, 6)
			expect(v66).to.be.ok()
			expect(v66:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v66._values[1]).to.equal(5)
			expect(v66._values[2]).to.equal(6)
		end)
		it("should chain onto passed promises", function()
			-- upvalues: (ref) v_u_1
			local v68 = v_u_1.resolve(v_u_1.new(function(_, p67)
				p67(7)
			end))
			expect(v68).to.be.ok()
			expect(v68:getStatus()).to.equal(v_u_1.Status.Rejected)
			expect(v68._values[1]).to.equal(7)
		end)
	end)
	describe("Promise.reject", function()
		-- upvalues: (copy) v_u_1
		it("should immediately reject with a value", function()
			-- upvalues: (ref) v_u_1
			local v69 = v_u_1.reject(6, 7)
			expect(v69).to.be.ok()
			expect(v69:getStatus()).to.equal(v_u_1.Status.Rejected)
			expect(v69._values[1]).to.equal(6)
			expect(v69._values[2]).to.equal(7)
		end)
		it("should pass a promise as-is as an error", function()
			-- upvalues: (ref) v_u_1
			local v71 = v_u_1.new(function(p70)
				p70(6)
			end)
			local v72 = v_u_1.reject(v71)
			expect(v72).to.be.ok()
			expect(v72:getStatus()).to.equal(v_u_1.Status.Rejected)
			expect(v72._values[1]).to.equal(v71)
		end)
	end)
	describe("Promise:andThen", function()
		-- upvalues: (copy) v_u_1, (copy) v_u_7
		it("should allow yielding", function()
			-- upvalues: (ref) v_u_1
			local v_u_73 = Instance.new("BindableEvent")
			local v74 = v_u_1.resolve():andThen(function()
				-- upvalues: (copy) v_u_73
				v_u_73.Event:Wait()
				return 5
			end)
			expect(v74:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_73:Fire()
			expect(v74:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v74._values[1]).to.equal(5)
		end)
		it("should run andThens on a new thread", function()
			-- upvalues: (ref) v_u_1
			local v_u_75 = Instance.new("BindableEvent")
			local v_u_76 = nil
			local v78 = v_u_1.new(function(p77)
				-- upvalues: (ref) v_u_76
				v_u_76 = p77
			end)
			local v79 = v78:andThen(function()
				-- upvalues: (copy) v_u_75
				v_u_75.Event:Wait()
				return 5
			end)
			local v80 = v78:andThen(function()
				return "foo"
			end)
			expect(v78:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_76()
			expect(v80:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v80._values[1]).to.equal("foo")
			expect(v79:getStatus()).to.equal(v_u_1.Status.Started)
		end)
		it("should chain onto resolved promises", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_7
			local v_u_81 = nil
			local v_u_82 = nil
			local v_u_83 = 0
			local v_u_84 = 0
			local v85 = v_u_1.resolve(5)
			local v88 = v85:andThen(function(...)
				-- upvalues: (ref) v_u_82, (ref) v_u_81, (ref) v_u_7, (ref) v_u_83
				local v86, v87 = v_u_7(...)
				v_u_82 = v86
				v_u_81 = v87
				v_u_83 = v_u_83 + 1
			end, function()
				-- upvalues: (ref) v_u_84
				v_u_84 = v_u_84 + 1
			end)
			expect(v_u_84).to.equal(0)
			expect(v_u_83).to.equal(1)
			expect(v_u_82).to.equal(1)
			expect(v_u_81[1]).to.equal(5)
			expect(v85).to.be.ok()
			expect(v85:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v85._values[1]).to.equal(5)
			expect(v88).to.be.ok()
			expect(v88).never.to.equal(v85)
			expect(v88:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(#v88._values).to.equal(0)
		end)
		it("should chain onto rejected promises", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_7
			local v_u_89 = nil
			local v_u_90 = nil
			local v_u_91 = 0
			local v_u_92 = 0
			local v93 = v_u_1.reject(5)
			local v96 = v93:andThen(function(...)
				-- upvalues: (ref) v_u_92
				v_u_92 = v_u_92 + 1
			end, function(...)
				-- upvalues: (ref) v_u_90, (ref) v_u_89, (ref) v_u_7, (ref) v_u_91
				local v94, v95 = v_u_7(...)
				v_u_90 = v94
				v_u_89 = v95
				v_u_91 = v_u_91 + 1
			end)
			expect(v_u_92).to.equal(0)
			expect(v_u_91).to.equal(1)
			expect(v_u_90).to.equal(1)
			expect(v_u_89[1]).to.equal(5)
			expect(v93).to.be.ok()
			expect(v93:getStatus()).to.equal(v_u_1.Status.Rejected)
			expect(v93._values[1]).to.equal(5)
			expect(v96).to.be.ok()
			expect(v96).never.to.equal(v93)
			expect(v96:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(#v96._values).to.equal(0)
		end)
		it("should reject on error in callback", function()
			-- upvalues: (ref) v_u_1
			local v_u_97 = 0
			local v98 = v_u_1.resolve(1):andThen(function()
				-- upvalues: (ref) v_u_97
				v_u_97 = v_u_97 + 1
				error("hahah")
			end)
			expect(v98).to.be.ok()
			expect(v_u_97).to.equal(1)
			expect(v98:getStatus()).to.equal(v_u_1.Status.Rejected)
			local v99 = expect
			local v100 = v98._values[1]
			v99(tostring(v100):find("hahah")).to.be.ok()
			local v101 = expect
			local v102 = v98._values[1]
			v101(tostring(v102):find("init.spec")).to.be.ok()
			local v103 = expect
			local v104 = v98._values[1]
			v103(tostring(v104):find("runExecutor")).to.be.ok()
		end)
		it("should chain onto asynchronously resolved promises", function()
			-- upvalues: (ref) v_u_1
			local v_u_105 = nil
			local v_u_106 = nil
			local v_u_107 = 0
			local v_u_108 = 0
			local v_u_109 = nil
			local v111 = v_u_1.new(function(p110)
				-- upvalues: (ref) v_u_109
				v_u_109 = p110
			end)
			local v112 = v111:andThen(function(...)
				-- upvalues: (ref) v_u_105, (ref) v_u_106, (ref) v_u_107
				v_u_105 = { ... }
				v_u_106 = select("#", ...)
				v_u_107 = v_u_107 + 1
			end, function()
				-- upvalues: (ref) v_u_108
				v_u_108 = v_u_108 + 1
			end)
			expect(v_u_107).to.equal(0)
			expect(v_u_108).to.equal(0)
			v_u_109(6)
			expect(v_u_108).to.equal(0)
			expect(v_u_107).to.equal(1)
			expect(v_u_106).to.equal(1)
			expect(v_u_105[1]).to.equal(6)
			expect(v111).to.be.ok()
			expect(v111:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v111._values[1]).to.equal(6)
			expect(v112).to.be.ok()
			expect(v112).never.to.equal(v111)
			expect(v112:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(#v112._values).to.equal(0)
		end)
		it("should chain onto asynchronously rejected promises", function()
			-- upvalues: (ref) v_u_1
			local v_u_113 = nil
			local v_u_114 = nil
			local v_u_115 = 0
			local v_u_116 = 0
			local v_u_117 = nil
			local v119 = v_u_1.new(function(_, p118)
				-- upvalues: (ref) v_u_117
				v_u_117 = p118
			end)
			local v120 = v119:andThen(function()
				-- upvalues: (ref) v_u_116
				v_u_116 = v_u_116 + 1
			end, function(...)
				-- upvalues: (ref) v_u_113, (ref) v_u_114, (ref) v_u_115
				v_u_113 = { ... }
				v_u_114 = select("#", ...)
				v_u_115 = v_u_115 + 1
			end)
			expect(v_u_115).to.equal(0)
			expect(v_u_116).to.equal(0)
			v_u_117(6)
			expect(v_u_116).to.equal(0)
			expect(v_u_115).to.equal(1)
			expect(v_u_114).to.equal(1)
			expect(v_u_113[1]).to.equal(6)
			expect(v119).to.be.ok()
			expect(v119:getStatus()).to.equal(v_u_1.Status.Rejected)
			expect(v119._values[1]).to.equal(6)
			expect(v120).to.be.ok()
			expect(v120).never.to.equal(v119)
			expect(v120:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(#v120._values).to.equal(0)
		end)
		it("should propagate errors through multiple levels", function()
			-- upvalues: (ref) v_u_1
			local v_u_121 = nil
			local v_u_122 = nil
			local v_u_123 = nil
			v_u_1.new(function(_, p124)
				p124(1, 2, 3)
			end):andThen(function() end):catch(function(p125, p126, p127)
				-- upvalues: (ref) v_u_121, (ref) v_u_122, (ref) v_u_123
				v_u_121 = p125
				v_u_122 = p126
				v_u_123 = p127
			end)
			expect(v_u_121).to.equal(1)
			expect(v_u_122).to.equal(2)
			expect(v_u_123).to.equal(3)
		end)
		it("should not call queued callbacks from a cancelled sub-promise", function()
			-- upvalues: (ref) v_u_1
			local v_u_128 = nil
			local v_u_129 = 0
			local v131 = v_u_1.new(function(p130)
				-- upvalues: (ref) v_u_128
				v_u_128 = p130
			end)
			v131:andThen(function()
				-- upvalues: (ref) v_u_129
				v_u_129 = v_u_129 + 1
			end)
			v131:andThen(function()
				-- upvalues: (ref) v_u_129
				v_u_129 = v_u_129 + 1
			end):cancel()
			v_u_128("foo")
			expect(v_u_129).to.equal(1)
		end)
	end)
	describe("Promise:cancel", function()
		-- upvalues: (copy) v_u_1, (ref) v_u_6
		it("should mark promises as cancelled and not resolve or reject them", function()
			-- upvalues: (ref) v_u_1
			local v_u_132 = 0
			local v_u_133 = 0
			local v134 = v_u_1.new(function() end):andThen(function()
				-- upvalues: (ref) v_u_132
				v_u_132 = v_u_132 + 1
			end):finally(function()
				-- upvalues: (ref) v_u_133
				v_u_133 = v_u_133 + 1
			end)
			v134:cancel()
			v134:cancel()
			expect(v_u_132).to.equal(0)
			expect(v_u_133).to.equal(1)
			expect(v134:getStatus()).to.equal(v_u_1.Status.Cancelled)
		end)
		it("should call the cancellation hook once", function()
			-- upvalues: (ref) v_u_1
			local v_u_135 = 0
			local v137 = v_u_1.new(function(_, _, p136)
				-- upvalues: (ref) v_u_135
				p136(function()
					-- upvalues: (ref) v_u_135
					v_u_135 = v_u_135 + 1
				end)
			end)
			v137:cancel()
			v137:cancel()
			expect(v_u_135).to.equal(1)
		end)
		it("should propagate cancellations", function()
			-- upvalues: (ref) v_u_1
			local v138 = v_u_1.new(function() end)
			local v139 = v138:andThen()
			local v140 = v138:andThen()
			expect(v138:getStatus()).to.equal(v_u_1.Status.Started)
			expect(v139:getStatus()).to.equal(v_u_1.Status.Started)
			expect(v140:getStatus()).to.equal(v_u_1.Status.Started)
			v139:cancel()
			expect(v138:getStatus()).to.equal(v_u_1.Status.Started)
			expect(v139:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v140:getStatus()).to.equal(v_u_1.Status.Started)
			v140:cancel()
			expect(v138:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v139:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v140:getStatus()).to.equal(v_u_1.Status.Cancelled)
		end)
		it("should affect downstream promises", function()
			-- upvalues: (ref) v_u_1
			local v141 = v_u_1.new(function() end)
			local v142 = v141:andThen()
			v141:cancel()
			expect(v142:getStatus()).to.equal(v_u_1.Status.Cancelled)
		end)
		it("should track consumers", function()
			-- upvalues: (ref) v_u_1
			local v_u_143 = v_u_1.new(function() end)
			local v144 = v_u_1.resolve()
			local v_u_145 = v144:andThen(function()
				-- upvalues: (copy) v_u_143
				return v_u_143
			end)
			local v147 = v_u_1.new(function(p146)
				-- upvalues: (copy) v_u_145
				p146(v_u_145)
			end)
			local v148 = v147:andThen(function() end)
			expect(v_u_145._parent).to.never.equal(v144)
			expect(v147._parent).to.never.equal(v_u_145)
			expect(v147._consumers[v148]).to.be.ok()
			expect(v148._parent).to.equal(v147)
		end)
		it("should cancel resolved pending promises", function()
			-- upvalues: (ref) v_u_1
			local v_u_149 = v_u_1.new(function() end)
			local v151 = v_u_1.new(function(p150)
				-- upvalues: (copy) v_u_149
				p150(v_u_149)
			end):finally(function() end)
			v151:cancel()
			expect(v_u_149._status).to.equal(v_u_1.Status.Cancelled)
			expect(v151._status).to.equal(v_u_1.Status.Cancelled)
		end)
		it("should close the promise thread", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_6
			local v_u_152 = 0
			v_u_1.new(function()
				-- upvalues: (ref) v_u_152, (ref) v_u_1
				v_u_152 = v_u_152 + 1
				v_u_1.delay(1):await()
				v_u_152 = v_u_152 + 1
			end):cancel()
			v_u_6(2)
			expect(v_u_152).to.equal(1)
		end)
	end)
	describe("Promise:finally", function()
		-- upvalues: (copy) v_u_1
		it("should be called upon resolve, reject, or cancel", function()
			-- upvalues: (ref) v_u_1
			local v_u_153 = 0
			local function v154()
				-- upvalues: (ref) v_u_153
				v_u_153 = v_u_153 + 1
			end
			v_u_1.new(function(p155, _)
				p155()
			end):finally(v154)
			v_u_1.resolve():andThen(function() end):finally(v154):finally(v154)
			v_u_1.reject():finally(v154)
			v_u_1.new(function() end):finally(v154):cancel()
			expect(v_u_153).to.equal(5)
		end)
		it("should not forward return values", function()
			-- upvalues: (ref) v_u_1
			local v_u_156 = nil
			v_u_1.resolve(2):finally(function()
				return 1
			end):andThen(function(p157)
				-- upvalues: (ref) v_u_156
				v_u_156 = p157
			end)
			expect(v_u_156).to.equal(2)
		end)
		it("should not consume rejections", function()
			-- upvalues: (ref) v_u_1
			local v_u_158 = false
			local v_u_159 = false
			v_u_1.reject(5):finally(function()
				return 42
			end):andThen(function()
				-- upvalues: (ref) v_u_159
				v_u_159 = true
			end):catch(function(p160)
				-- upvalues: (ref) v_u_158
				v_u_158 = true
				expect(p160).to.equal(5)
			end)
			expect(v_u_158).to.equal(true)
			expect(v_u_159).to.equal(false)
		end)
		it("should wait for returned promises", function()
			-- upvalues: (ref) v_u_1
			local v_u_161 = nil
			local v163 = v_u_1.reject("foo"):finally(function()
				-- upvalues: (ref) v_u_1, (ref) v_u_161
				return v_u_1.new(function(p162)
					-- upvalues: (ref) v_u_161
					v_u_161 = p162
				end)
			end)
			expect(v163:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_161()
			expect(v163:getStatus()).to.equal(v_u_1.Status.Rejected)
			local _, v164 = v163:_unwrap()
			expect(v164).to.equal("foo")
		end)
		it("should reject with a returned rejected promise\'s value", function()
			-- upvalues: (ref) v_u_1
			local v_u_165 = nil
			local v167 = v_u_1.reject("foo"):finally(function()
				-- upvalues: (ref) v_u_1, (ref) v_u_165
				return v_u_1.new(function(_, p166)
					-- upvalues: (ref) v_u_165
					v_u_165 = p166
				end)
			end)
			expect(v167:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_165("bar")
			expect(v167:getStatus()).to.equal(v_u_1.Status.Rejected)
			local _, v168 = v167:_unwrap()
			expect(v168).to.equal("bar")
		end)
		it("should reject when handler errors", function()
			-- upvalues: (ref) v_u_1
			local v_u_169 = {}
			local v170, v171 = v_u_1.reject("bar"):finally(function()
				-- upvalues: (copy) v_u_169
				error(v_u_169)
			end):_unwrap()
			expect(v170).to.equal(false)
			expect(v171).to.equal(v_u_169)
		end)
		it("should not prevent cancellation", function()
			-- upvalues: (ref) v_u_1
			local v172 = v_u_1.new(function() end)
			local v_u_173 = false
			v172:finally(function()
				-- upvalues: (ref) v_u_173
				v_u_173 = true
			end)
			v172:andThen(function() end):cancel()
			expect(v172:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v_u_173).to.equal(true)
		end)
		it("should propagate cancellation downwards", function()
			-- upvalues: (ref) v_u_1
			local v_u_174 = false
			local v175 = v_u_1.new(function() end)
			local v176 = v175:finally(function()
				-- upvalues: (ref) v_u_174
				v_u_174 = true
			end)
			v175:cancel()
			expect(v175:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v176:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v_u_174).to.equal(true)
			expect(false).to.equal(false)
		end)
		it("should propagate cancellation upwards", function()
			-- upvalues: (ref) v_u_1
			local v_u_177 = false
			local v178 = v_u_1.new(function() end)
			local v179 = v178:finally(function()
				-- upvalues: (ref) v_u_177
				v_u_177 = true
			end)
			v179:cancel()
			expect(v178:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v179:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v_u_177).to.equal(true)
			expect(false).to.equal(false)
		end)
		it("should cancel returned promise if cancelled", function()
			-- upvalues: (ref) v_u_1
			local v_u_180 = v_u_1.new(function() end)
			v_u_1.resolve():finally(function()
				-- upvalues: (copy) v_u_180
				return v_u_180
			end):cancel()
			expect(v_u_180:getStatus()).to.equal(v_u_1.Status.Cancelled)
		end)
	end)
	describe("Promise.all", function()
		-- upvalues: (copy) v_u_1, (copy) v_u_7
		it("should error if given something other than a table", function()
			-- upvalues: (ref) v_u_1
			expect(function()
				-- upvalues: (ref) v_u_1
				v_u_1.all(1)
			end).to.throw()
		end)
		it("should resolve instantly with an empty table if given no promises", function()
			-- upvalues: (ref) v_u_1
			local v181 = v_u_1.all({})
			local v182, v183 = v181:_unwrap()
			expect(v182).to.equal(true)
			expect(v181:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v183).to.be.a("table")
			expect(next(v183)).to.equal(nil)
		end)
		it("should error if given non-promise values", function()
			-- upvalues: (ref) v_u_1
			expect(function()
				-- upvalues: (ref) v_u_1
				v_u_1.all({
					{},
					{},
					{}
				})
			end).to.throw()
		end)
		it("should wait for all promises to be resolved and return their values", function()
			-- upvalues: (ref) v_u_7, (ref) v_u_1
			local v184, v_u_185 = v_u_7(1, "A string", nil, false)
			local v_u_186 = {}
			local v187 = {}
			for v_u_188 = 1, v184 do
				v187[v_u_188] = v_u_1.new(function(p189)
					-- upvalues: (copy) v_u_186, (copy) v_u_188, (copy) v_u_185
					v_u_186[v_u_188] = { p189, v_u_185[v_u_188] }
				end)
			end
			local v190 = v_u_1.all(v187)
			for _, v191 in ipairs(v_u_186) do
				expect(v190:getStatus()).to.equal(v_u_1.Status.Started)
				v191[1](v191[2])
			end
			local v192, v193 = v_u_7(v190:_unwrap())
			local v194, v195 = unpack(v193, 1, v192)
			expect(v192).to.equal(2)
			expect(v194).to.equal(true)
			expect(v195).to.be.a("table")
			expect(#v195).to.equal(#v187)
			for v196 = 1, v184 do
				expect(v195[v196]).to.equal(v_u_185[v196])
			end
		end)
		it("should reject if any individual promise rejected", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_7
			local v_u_197 = nil
			local v_u_198 = nil
			local v200 = v_u_1.new(function(_, p199)
				-- upvalues: (ref) v_u_197
				v_u_197 = p199
			end)
			local v202 = v_u_1.new(function(p201)
				-- upvalues: (ref) v_u_198
				v_u_198 = p201
			end)
			local v203 = v_u_1.all({ v200, v202 })
			expect(v203:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_197("baz", "qux")
			v_u_198("foo", "bar")
			local v204, v205 = v_u_7(v203:_unwrap())
			local v206, v207, v208 = unpack(v205, 1, v204)
			expect(v204).to.equal(3)
			expect(v206).to.equal(false)
			expect(v207).to.equal("baz")
			expect(v208).to.equal("qux")
			expect(v202:getStatus()).to.equal(v_u_1.Status.Cancelled)
		end)
		it("should not resolve if resolved after rejecting", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_7
			local v_u_209 = nil
			local v_u_210 = nil
			local v213 = { v_u_1.new(function(_, p211)
					-- upvalues: (ref) v_u_209
					v_u_209 = p211
				end), (v_u_1.new(function(p212)
					-- upvalues: (ref) v_u_210
					v_u_210 = p212
				end)) }
			local v214 = v_u_1.all(v213)
			expect(v214:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_209("baz", "qux")
			v_u_210("foo", "bar")
			local v215, v216 = v_u_7(v214:_unwrap())
			local v217, v218, v219 = unpack(v216, 1, v215)
			expect(v215).to.equal(3)
			expect(v217).to.equal(false)
			expect(v218).to.equal("baz")
			expect(v219).to.equal("qux")
		end)
		it("should only reject once", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_7
			local v_u_220 = nil
			local v_u_221 = nil
			local v224 = { v_u_1.new(function(_, p222)
					-- upvalues: (ref) v_u_220
					v_u_220 = p222
				end), (v_u_1.new(function(_, p223)
					-- upvalues: (ref) v_u_221
					v_u_221 = p223
				end)) }
			local v225 = v_u_1.all(v224)
			expect(v225:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_220("foo", "bar")
			expect(v225:getStatus()).to.equal(v_u_1.Status.Rejected)
			v_u_221("baz", "qux")
			local v226, v227 = v_u_7(v225:_unwrap())
			local v228, v229, v230 = unpack(v227, 1, v226)
			expect(v226).to.equal(3)
			expect(v228).to.equal(false)
			expect(v229).to.equal("foo")
			expect(v230).to.equal("bar")
		end)
		it("should error if a non-array table is passed in", function()
			-- upvalues: (ref) v_u_1
			local v231, v232 = pcall(function()
				-- upvalues: (ref) v_u_1
				v_u_1.all(v_u_1.new(function() end))
			end)
			expect(v231).to.be.ok()
			expect(v232:find("Non%-promise")).to.be.ok()
		end)
		it("should cancel pending promises if one rejects", function()
			-- upvalues: (ref) v_u_1
			local v233 = v_u_1.new(function() end)
			expect(v_u_1.all({ v_u_1.resolve(), v_u_1.reject(), v233 }):getStatus()).to.equal(v_u_1.Status.Rejected)
			expect(v233:getStatus()).to.equal(v_u_1.Status.Cancelled)
		end)
		it("should cancel promises if it is cancelled", function()
			-- upvalues: (ref) v_u_1
			local v234 = v_u_1.new(function() end)
			v234:andThen(function() end)
			local v235 = { v_u_1.new(function() end), v_u_1.new(function() end), v234 }
			v_u_1.all(v235):cancel()
			expect(v235[1]:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v235[2]:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v235[3]:getStatus()).to.equal(v_u_1.Status.Started)
		end)
	end)
	describe("Promise.fold", function()
		-- upvalues: (copy) v_u_1, (ref) v_u_6
		it("should return the initial value in a promise when the list is empty", function()
			-- upvalues: (ref) v_u_1
			local v236 = {}
			local v237 = v_u_1.fold({}, function()
				error("should not be called")
			end, v236)
			expect(v_u_1.is(v237)).to.equal(true)
			expect(v237:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v237:expect()).to.equal(v236)
		end)
		it("should accept promises in the list", function()
			-- upvalues: (ref) v_u_1
			local v_u_238 = nil
			local v242 = v_u_1.fold({ v_u_1.new(function(p239)
					-- upvalues: (ref) v_u_238
					v_u_238 = p239
				end), 2, 3 }, function(p240, p241)
				return p240 + p241
			end, 0)
			v_u_238(1)
			expect(v_u_1.is(v242)).to.equal(true)
			expect(v242:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v242:expect()).to.equal(6)
		end)
		it("should always return a promise even if the list or reducer don\'t use them", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_6
			local v246 = v_u_1.fold({ 1, 2, 3 }, function(p243, p244, p245)
				-- upvalues: (ref) v_u_1
				if p245 == 2 then
					return v_u_1.delay(1):andThenReturn(p243 + p244)
				else
					return p243 + p244
				end
			end, 0)
			expect(v_u_1.is(v246)).to.equal(true)
			expect(v246:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_6(2)
			expect(v246:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v246:expect()).to.equal(6)
		end)
		it("should return the first rejected promise", function()
			-- upvalues: (ref) v_u_1
			local v250 = v_u_1.fold({ 1, 2, 3 }, function(p247, p248, p249)
				-- upvalues: (ref) v_u_1
				if p249 == 2 then
					return v_u_1.reject("foo")
				else
					return p247 + p248
				end
			end, 0)
			expect(v_u_1.is(v250)).to.equal(true)
			local v251, v252 = v250:awaitStatus()
			expect(v251).to.equal(v_u_1.Status.Rejected)
			expect(v252).to.equal("foo")
		end)
		it("should return the first canceled promise", function()
			-- upvalues: (ref) v_u_1
			local v_u_253 = nil
			local v257 = v_u_1.fold({ 1, 2, 3 }, function(p254, p255, p256)
				-- upvalues: (ref) v_u_253, (ref) v_u_1
				if p256 == 1 then
					return p254 + p255
				end
				if p256 == 2 then
					v_u_253 = v_u_1.delay(1):andThenReturn(p254 + p255)
					return v_u_253
				end
				error("this should not run if the promise is cancelled")
			end, 0)
			expect(v_u_1.is(v257)).to.equal(true)
			expect(v257:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_253:cancel()
			expect(v257:getStatus()).to.equal(v_u_1.Status.Cancelled)
		end)
	end)
	describe("Promise.race", function()
		-- upvalues: (copy) v_u_1
		it("should resolve with the first settled value", function()
			-- upvalues: (ref) v_u_1
			local v259 = v_u_1.race({ v_u_1.resolve(1), v_u_1.resolve(2) }):andThen(function(p258)
				expect(p258).to.equal(1)
			end)
			expect(v259:getStatus()).to.equal(v_u_1.Status.Resolved)
		end)
		it("should cancel other promises", function()
			-- upvalues: (ref) v_u_1
			local v260 = v_u_1.new(function() end)
			v260:andThen(function() end)
			local v262 = { v260, v_u_1.new(function() end), v_u_1.new(function(p261)
					p261(2)
				end) }
			local v263 = v_u_1.race(v262)
			expect(v263:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v263._values[1]).to.equal(2)
			expect(v262[1]:getStatus()).to.equal(v_u_1.Status.Started)
			expect(v262[2]:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v262[3]:getStatus()).to.equal(v_u_1.Status.Resolved)
			local v264 = v_u_1.new(function() end)
			expect(v_u_1.race({ v_u_1.reject(), v_u_1.resolve(), v264 }):getStatus()).to.equal(v_u_1.Status.Rejected)
			expect(v264:getStatus()).to.equal(v_u_1.Status.Cancelled)
		end)
		it("should error if a non-array table is passed in", function()
			-- upvalues: (ref) v_u_1
			local v265, v266 = pcall(function()
				-- upvalues: (ref) v_u_1
				v_u_1.race(v_u_1.new(function() end))
			end)
			expect(v265).to.be.ok()
			expect(v266:find("Non%-promise")).to.be.ok()
		end)
		it("should cancel promises if it is cancelled", function()
			-- upvalues: (ref) v_u_1
			local v267 = v_u_1.new(function() end)
			v267:andThen(function() end)
			local v268 = { v_u_1.new(function() end), v_u_1.new(function() end), v267 }
			v_u_1.race(v268):cancel()
			expect(v268[1]:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v268[2]:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v268[3]:getStatus()).to.equal(v_u_1.Status.Started)
		end)
	end)
	describe("Promise.promisify", function()
		-- upvalues: (copy) v_u_1
		it("should wrap functions", function()
			-- upvalues: (ref) v_u_1
			local v270 = v_u_1.promisify(function(p269)
				return p269 + 1
			end)(1)
			local v271, v272 = v270:_unwrap()
			expect(v271).to.equal(true)
			expect(v270:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v272).to.equal(2)
		end)
		it("should catch errors after a yield", function()
			-- upvalues: (ref) v_u_1
			local v_u_273 = Instance.new("BindableEvent")
			local v274 = v_u_1.promisify(function()
				-- upvalues: (copy) v_u_273
				v_u_273.Event:Wait()
				error("errortext")
			end)()
			expect(v274:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_273:Fire()
			expect(v274:getStatus()).to.equal(v_u_1.Status.Rejected)
			local v275 = expect
			local v276 = v274._values[1]
			v275(tostring(v276):find("errortext")).to.be.ok()
		end)
	end)
	describe("Promise.tap", function()
		-- upvalues: (copy) v_u_1
		it("should thread through values", function()
			-- upvalues: (ref) v_u_1
			local v_u_277 = nil
			local v_u_278 = nil
			v_u_1.resolve(1):andThen(function(p279)
				return p279 + 1
			end):tap(function(p280)
				-- upvalues: (ref) v_u_277
				v_u_277 = p280
				return p280 + 1
			end):andThen(function(p281)
				-- upvalues: (ref) v_u_278
				v_u_278 = p281
			end)
			expect(v_u_277).to.equal(2)
			expect(v_u_278).to.equal(2)
		end)
		it("should chain onto promises", function()
			-- upvalues: (ref) v_u_1
			local v_u_282 = nil
			local v_u_283 = nil
			local v286 = v_u_1.resolve(1):tap(function()
				-- upvalues: (ref) v_u_1, (ref) v_u_282
				return v_u_1.new(function(p284)
					-- upvalues: (ref) v_u_282
					v_u_282 = p284
				end)
			end):andThen(function(p285)
				-- upvalues: (ref) v_u_283
				v_u_283 = p285
			end)
			expect(v286:getStatus()).to.equal(v_u_1.Status.Started)
			expect(v_u_283).to.never.be.ok()
			v_u_282(1)
			expect(v286:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v_u_283).to.equal(1)
		end)
	end)
	describe("Promise.try", function()
		-- upvalues: (copy) v_u_1
		it("should catch synchronous errors", function()
			-- upvalues: (ref) v_u_1
			local v_u_287 = nil
			v_u_1.try(function()
				error("errortext")
			end):catch(function(p288)
				-- upvalues: (ref) v_u_287
				v_u_287 = tostring(p288)
			end)
			expect(v_u_287:find("errortext")).to.be.ok()
		end)
		it("should reject with error objects", function()
			-- upvalues: (ref) v_u_1
			local v_u_289 = {}
			local v290, v291 = v_u_1.try(function()
				-- upvalues: (copy) v_u_289
				error(v_u_289)
			end):_unwrap()
			expect(v290).to.equal(false)
			expect(v291).to.equal(v_u_289)
		end)
		it("should catch asynchronous errors", function()
			-- upvalues: (ref) v_u_1
			local v_u_292 = Instance.new("BindableEvent")
			local v293 = v_u_1.try(function()
				-- upvalues: (copy) v_u_292
				v_u_292.Event:Wait()
				error("errortext")
			end)
			expect(v293:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_292:Fire()
			expect(v293:getStatus()).to.equal(v_u_1.Status.Rejected)
			local v294 = expect
			local v295 = v293._values[1]
			v294(tostring(v295):find("errortext")).to.be.ok()
		end)
	end)
	describe("Promise:andThenReturn", function()
		-- upvalues: (copy) v_u_1
		it("should return the given values", function()
			-- upvalues: (ref) v_u_1
			local v_u_296 = nil
			local v_u_297 = nil
			v_u_1.resolve():andThenReturn(1, 2):andThen(function(p298, p299)
				-- upvalues: (ref) v_u_296, (ref) v_u_297
				v_u_296 = p298
				v_u_297 = p299
			end)
			expect(v_u_296).to.equal(1)
			expect(v_u_297).to.equal(2)
		end)
	end)
	describe("Promise:andThenCall", function()
		-- upvalues: (copy) v_u_1
		it("should call the given function with arguments", function()
			-- upvalues: (ref) v_u_1
			local v_u_300 = nil
			local v_u_301 = nil
			v_u_1.resolve():andThenCall(function(p302, p303)
				-- upvalues: (ref) v_u_300, (ref) v_u_301
				v_u_300 = p302
				v_u_301 = p303
			end, 3, 4)
			expect(v_u_300).to.equal(3)
			expect(v_u_301).to.equal(4)
		end)
	end)
	describe("Promise.some", function()
		-- upvalues: (copy) v_u_1
		it("should resolve once the goal is reached", function()
			-- upvalues: (ref) v_u_1
			local v304 = v_u_1.some({ v_u_1.resolve(1), v_u_1.reject(), v_u_1.resolve(2) }, 2)
			expect(v304:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v304._values[1][1]).to.equal(1)
			expect(v304._values[1][2]).to.equal(2)
		end)
		it("should error if the goal can\'t be reached", function()
			-- upvalues: (ref) v_u_1
			expect(v_u_1.some({ v_u_1.resolve(), v_u_1.reject() }, 2):getStatus()).to.equal(v_u_1.Status.Rejected)
			local v_u_305 = nil
			local v307 = v_u_1.some({ v_u_1.resolve(), v_u_1.new(function(_, p306)
					-- upvalues: (ref) v_u_305
					v_u_305 = p306
				end) }, 2)
			expect(v307:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_305("foo")
			expect(v307:getStatus()).to.equal(v_u_1.Status.Rejected)
			expect(v307._values[1]).to.equal("foo")
		end)
		it("should cancel pending Promises once the goal is reached", function()
			-- upvalues: (ref) v_u_1
			local v_u_308 = nil
			local v309 = v_u_1.new(function() end)
			local v311 = v_u_1.new(function(p310)
				-- upvalues: (ref) v_u_308
				v_u_308 = p310
			end)
			local v312 = v_u_1.some({ v309, v311, v_u_1.resolve() }, 2)
			expect(v312:getStatus()).to.equal(v_u_1.Status.Started)
			expect(v309:getStatus()).to.equal(v_u_1.Status.Started)
			expect(v311:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_308()
			expect(v312:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v309:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v311:getStatus()).to.equal(v_u_1.Status.Resolved)
		end)
		it("should error if passed a non-number", function()
			-- upvalues: (ref) v_u_1
			expect(function()
				-- upvalues: (ref) v_u_1
				v_u_1.some({}, "non-number")
			end).to.throw()
		end)
		it("should return an empty array if amount is 0", function()
			-- upvalues: (ref) v_u_1
			local v313 = v_u_1.some({ v_u_1.resolve(2) }, 0)
			expect(v313:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(#v313._values[1]).to.equal(0)
		end)
		it("should not return extra values", function()
			-- upvalues: (ref) v_u_1
			local v314 = v_u_1.some({
				v_u_1.resolve(1),
				v_u_1.resolve(2),
				v_u_1.resolve(3),
				v_u_1.resolve(4)
			}, 2)
			expect(v314:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(#v314._values[1]).to.equal(2)
			expect(v314._values[1][1]).to.equal(1)
			expect(v314._values[1][2]).to.equal(2)
		end)
		it("should cancel promises if it is cancelled", function()
			-- upvalues: (ref) v_u_1
			local v315 = v_u_1.new(function() end)
			v315:andThen(function() end)
			local v316 = { v_u_1.new(function() end), v_u_1.new(function() end), v315 }
			v_u_1.some(v316, 3):cancel()
			expect(v316[1]:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v316[2]:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v316[3]:getStatus()).to.equal(v_u_1.Status.Started)
		end)
		describe("Promise.any", function()
			-- upvalues: (ref) v_u_1
			it("should return the value directly", function()
				-- upvalues: (ref) v_u_1
				local v317 = v_u_1.any({ v_u_1.reject(), v_u_1.reject(), v_u_1.resolve(1) })
				expect(v317:getStatus()).to.equal(v_u_1.Status.Resolved)
				expect(v317._values[1]).to.equal(1)
			end)
			it("should error if all are rejected", function()
				-- upvalues: (ref) v_u_1
				expect(v_u_1.any({ v_u_1.reject(), v_u_1.reject(), v_u_1.reject() }):getStatus()).to.equal(v_u_1.Status.Rejected)
			end)
		end)
	end)
	describe("Promise.allSettled", function()
		-- upvalues: (copy) v_u_1
		it("should resolve with an array of PromiseStatuses", function()
			-- upvalues: (ref) v_u_1
			local v_u_318 = nil
			local v320 = v_u_1.allSettled({
				v_u_1.resolve(),
				v_u_1.reject(),
				v_u_1.resolve(),
				v_u_1.new(function(_, p319)
					-- upvalues: (ref) v_u_318
					v_u_318 = p319
				end)
			})
			expect(v320:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_318()
			expect(v320:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v320._values[1][1]).to.equal(v_u_1.Status.Resolved)
			expect(v320._values[1][2]).to.equal(v_u_1.Status.Rejected)
			expect(v320._values[1][3]).to.equal(v_u_1.Status.Resolved)
			expect(v320._values[1][4]).to.equal(v_u_1.Status.Rejected)
		end)
		it("should cancel promises if it is cancelled", function()
			-- upvalues: (ref) v_u_1
			local v321 = v_u_1.new(function() end)
			v321:andThen(function() end)
			local v322 = { v_u_1.new(function() end), v_u_1.new(function() end), v321 }
			v_u_1.allSettled(v322):cancel()
			expect(v322[1]:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v322[2]:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v322[3]:getStatus()).to.equal(v_u_1.Status.Started)
		end)
	end)
	describe("Promise:await", function()
		-- upvalues: (copy) v_u_1, (ref) v_u_6
		it("should return the correct values", function()
			-- upvalues: (ref) v_u_1
			local v323, v324, v325, v326, v327 = v_u_1.resolve(5, 6, nil, 7):await()
			expect(v323).to.equal(true)
			expect(v324).to.equal(5)
			expect(v325).to.equal(6)
			expect(v326).to.equal(nil)
			expect(v327).to.equal(7)
		end)
		it("should work if yielding is needed", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_6
			local v_u_328 = false
			task.spawn(function()
				-- upvalues: (ref) v_u_1, (ref) v_u_328
				local _, v329 = v_u_1.delay(1):await()
				expect((type(v329))).to.equal("number")
				v_u_328 = true
			end)
			v_u_6(2)
			expect(v_u_328).to.equal(true)
		end)
	end)
	describe("Promise:expect", function()
		-- upvalues: (copy) v_u_1
		it("should throw the correct values", function()
			-- upvalues: (ref) v_u_1
			local v330 = {}
			local v_u_331 = v_u_1.reject(v330)
			local v332, v333 = pcall(function()
				-- upvalues: (copy) v_u_331
				v_u_331:expect()
			end)
			expect(v332).to.equal(false)
			expect(v333).to.equal(v330)
		end)
	end)
	describe("Promise:now", function()
		-- upvalues: (copy) v_u_1
		it("should resolve if the Promise is resolved", function()
			-- upvalues: (ref) v_u_1
			local v334, v335 = v_u_1.resolve("foo"):now():_unwrap()
			expect(v334).to.equal(true)
			expect(v335).to.equal("foo")
		end)
		it("should reject if the Promise is not resolved", function()
			-- upvalues: (ref) v_u_1
			local v336, v337 = v_u_1.new(function() end):now():_unwrap()
			expect(v336).to.equal(false)
			expect(v_u_1.Error.isKind(v337, "NotResolvedInTime")).to.equal(true)
		end)
		it("should reject with a custom rejection value", function()
			-- upvalues: (ref) v_u_1
			local v338, v339 = v_u_1.new(function() end):now("foo"):_unwrap()
			expect(v338).to.equal(false)
			expect(v339).to.equal("foo")
		end)
	end)
	describe("Promise.each", function()
		-- upvalues: (copy) v_u_1
		it("should iterate", function()
			-- upvalues: (ref) v_u_1
			local v340, v341 = v_u_1.each({
				"foo",
				"bar",
				"baz",
				"qux"
			}, function(...)
				return { ... }
			end):_unwrap()
			expect(v340).to.equal(true)
			expect(v341[1][1]).to.equal("foo")
			expect(v341[1][2]).to.equal(1)
			expect(v341[2][1]).to.equal("bar")
			expect(v341[2][2]).to.equal(2)
			expect(v341[3][1]).to.equal("baz")
			expect(v341[3][2]).to.equal(3)
			expect(v341[4][1]).to.equal("qux")
			expect(v341[4][2]).to.equal(4)
		end)
		it("should iterate serially", function()
			-- upvalues: (ref) v_u_1
			local v_u_342 = {}
			local v_u_343 = {}
			local v349 = v_u_1.each({ "foo", "bar", "baz" }, function(p_u_344, p345)
				-- upvalues: (copy) v_u_343, (ref) v_u_1, (copy) v_u_342
				v_u_343[p345] = (v_u_343[p345] or 0) + 1
				return v_u_1.new(function(p_u_346)
					-- upvalues: (ref) v_u_342, (copy) p_u_344
					local v347 = v_u_342
					local function v348()
						-- upvalues: (copy) p_u_346, (ref) p_u_344
						p_u_346(p_u_344:upper())
					end
					table.insert(v347, v348)
				end)
			end)
			expect(v349:getStatus()).to.equal(v_u_1.Status.Started)
			expect(#v_u_342).to.equal(1)
			expect(v_u_343[1]).to.equal(1)
			expect(v_u_343[2]).to.never.be.ok()
			table.remove(v_u_342, 1)()
			expect(v349:getStatus()).to.equal(v_u_1.Status.Started)
			expect(#v_u_342).to.equal(1)
			expect(v_u_343[1]).to.equal(1)
			expect(v_u_343[2]).to.equal(1)
			expect(v_u_343[3]).to.never.be.ok()
			table.remove(v_u_342, 1)()
			expect(v349:getStatus()).to.equal(v_u_1.Status.Started)
			expect(v_u_343[1]).to.equal(1)
			expect(v_u_343[2]).to.equal(1)
			expect(v_u_343[3]).to.equal(1)
			table.remove(v_u_342, 1)()
			expect(v349:getStatus()).to.equal(v_u_1.Status.Resolved)
			local v350 = expect
			local v351 = v349._values[1]
			v350((type(v351))).to.equal("table")
			local v352 = expect
			local v353 = v349._values[2]
			v352((type(v353))).to.equal("nil")
			local v354 = v349._values[1]
			expect(v354[1]).to.equal("FOO")
			expect(v354[2]).to.equal("BAR")
			expect(v354[3]).to.equal("BAZ")
		end)
		it("should reject with the value if the predicate promise rejects", function()
			-- upvalues: (ref) v_u_1
			local v355 = v_u_1.each({ 1, 2, 3 }, function()
				-- upvalues: (ref) v_u_1
				return v_u_1.reject("foobar")
			end)
			expect(v355:getStatus()).to.equal(v_u_1.Status.Rejected)
			expect(v355._values[1]).to.equal("foobar")
		end)
		it("should allow Promises to be in the list and wait when it gets to them", function()
			-- upvalues: (ref) v_u_1
			local v_u_356 = nil
			local v358 = { (v_u_1.new(function(p357)
					-- upvalues: (ref) v_u_356
					v_u_356 = p357
				end)) }
			local v360 = v_u_1.each(v358, function(p359)
				return p359 * 2
			end)
			expect(v360:getStatus()).to.equal(v_u_1.Status.Started)
			v_u_356(2)
			expect(v360:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v360._values[1][1]).to.equal(4)
		end)
		it("should reject with the value if a Promise from the list rejects", function()
			-- upvalues: (ref) v_u_1
			local v_u_361 = false
			local v362 = v_u_1.each({ 1, 2, v_u_1.reject("foobar") }, function(_)
				-- upvalues: (ref) v_u_361
				v_u_361 = true
				return "never"
			end)
			expect(v362:getStatus()).to.equal(v_u_1.Status.Rejected)
			expect(v362._values[1]).to.equal("foobar")
			expect(v_u_361).to.equal(false)
		end)
		it("should reject immediately if there\'s a cancelled Promise in the list initially", function()
			-- upvalues: (ref) v_u_1
			local v363 = v_u_1.new(function() end)
			v363:cancel()
			local v_u_364 = false
			local v365 = v_u_1.each({ 1, 2, v363 }, function()
				-- upvalues: (ref) v_u_364
				v_u_364 = true
			end)
			expect(v365:getStatus()).to.equal(v_u_1.Status.Rejected)
			expect(v_u_364).to.equal(false)
			expect(v365._values[1].kind).to.equal(v_u_1.Error.Kind.AlreadyCancelled)
		end)
		it("should stop iteration if Promise.each is cancelled", function()
			-- upvalues: (ref) v_u_1
			local v_u_366 = {}
			local v368 = v_u_1.each({ "foo", "bar", "baz" }, function(_, p367)
				-- upvalues: (copy) v_u_366, (ref) v_u_1
				v_u_366[p367] = (v_u_366[p367] or 0) + 1
				return v_u_1.new(function() end)
			end)
			expect(v368:getStatus()).to.equal(v_u_1.Status.Started)
			expect(v_u_366[1]).to.equal(1)
			expect(v_u_366[2]).to.never.be.ok()
			v368:cancel()
			expect(v368:getStatus()).to.equal(v_u_1.Status.Cancelled)
			expect(v_u_366[1]).to.equal(1)
			expect(v_u_366[2]).to.never.be.ok()
		end)
		it("should cancel the Promise returned from the predicate if Promise.each is cancelled", function()
			-- upvalues: (ref) v_u_1
			local v_u_369 = nil
			v_u_1.each({ "foo", "bar", "baz" }, function(_, _)
				-- upvalues: (ref) v_u_369, (ref) v_u_1
				v_u_369 = v_u_1.new(function() end)
				return v_u_369
			end):cancel()
			expect(v_u_369:getStatus()).to.equal(v_u_1.Status.Cancelled)
		end)
		it("should cancel Promises in the list if Promise.each is cancelled", function()
			-- upvalues: (ref) v_u_1
			local v370 = v_u_1.new(function() end)
			v_u_1.each({ v370 }, function() end):cancel()
			expect(v370:getStatus()).to.equal(v_u_1.Status.Cancelled)
		end)
	end)
	describe("Promise.retry", function()
		-- upvalues: (copy) v_u_1
		it("should retry N times", function()
			-- upvalues: (ref) v_u_1
			local v_u_371 = 0
			local v373 = v_u_1.retry(function(p372)
				-- upvalues: (ref) v_u_371, (ref) v_u_1
				expect(p372).to.equal("foo")
				v_u_371 = v_u_371 + 1
				if v_u_371 == 5 then
					return v_u_1.resolve("ok")
				else
					return v_u_1.reject("fail")
				end
			end, 5, "foo")
			expect(v373:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v373._values[1]).to.equal("ok")
		end)
		it("should reject if threshold is exceeded", function()
			-- upvalues: (ref) v_u_1
			local v374 = v_u_1.retry(function()
				-- upvalues: (ref) v_u_1
				return v_u_1.reject("fail")
			end, 5)
			expect(v374:getStatus()).to.equal(v_u_1.Status.Rejected)
			expect(v374._values[1]).to.equal("fail")
		end)
	end)
	describe("Promise.retryWithDelay", function()
		-- upvalues: (copy) v_u_1, (ref) v_u_6
		it("should retry after a delay", function()
			-- upvalues: (ref) v_u_1, (ref) v_u_6
			local v_u_375 = 0
			local v377 = v_u_1.retryWithDelay(function(p376)
				-- upvalues: (ref) v_u_375, (ref) v_u_1
				expect(p376).to.equal("foo")
				v_u_375 = v_u_375 + 1
				if v_u_375 == 3 then
					return v_u_1.resolve("ok")
				else
					return v_u_1.reject("fail")
				end
			end, 3, 10, "foo")
			expect(v_u_375).to.equal(1)
			v_u_6(11)
			expect(v_u_375).to.equal(2)
			v_u_6(11)
			expect(v_u_375).to.equal(3)
			expect(v377:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v377._values[1]).to.equal("ok")
		end)
	end)
	describe("Promise.fromEvent", function()
		-- upvalues: (copy) v_u_1
		it("should convert a Promise into an event", function()
			-- upvalues: (ref) v_u_1
			local v378 = Instance.new("BindableEvent")
			local v379 = v_u_1.fromEvent(v378.Event)
			expect(v379:getStatus()).to.equal(v_u_1.Status.Started)
			v378:Fire("foo")
			expect(v379:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v379._values[1]).to.equal("foo")
		end)
		it("should convert a Promise into an event with the predicate", function()
			-- upvalues: (ref) v_u_1
			local v380 = Instance.new("BindableEvent")
			local v382 = v_u_1.fromEvent(v380.Event, function(p381)
				return p381 == "foo"
			end)
			expect(v382:getStatus()).to.equal(v_u_1.Status.Started)
			v380:Fire("bar")
			expect(v382:getStatus()).to.equal(v_u_1.Status.Started)
			v380:Fire("foo")
			expect(v382:getStatus()).to.equal(v_u_1.Status.Resolved)
			expect(v382._values[1]).to.equal("foo")
		end)
	end)
	describe("Promise.is", function()
		-- upvalues: (copy) v_u_1
		it("should work with current version", function()
			-- upvalues: (ref) v_u_1
			local v383 = v_u_1.resolve(1)
			expect(v_u_1.is(v383)).to.equal(true)
		end)
		it("should work with any object with an andThen", function()
			-- upvalues: (ref) v_u_1
			expect(v_u_1.is({
				["andThen"] = function()
					return 1
				end
			})).to.equal(true)
		end)
		it("should work with older promises", function()
			-- upvalues: (ref) v_u_1
			local v384 = {
				["prototype"] = {}
			}
			v384.__index = v384.prototype
			function v384.prototype.andThen(_) end
			local v385 = setmetatable({}, v384)
			expect(v_u_1.is(v385)).to.equal(true)
		end)
	end)
end]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[init.spec]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item></Item></Item><Item class="Folder" referent="3661"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Client]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="LocalScript" referent="3662"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local v2 = game:GetService("StarterGui")
local v3 = game:GetService("ReplicatedFirst")
local v4 = game:GetService("ContentProvider")
local v_u_5 = game:GetService("TweenService")
game:GetService("RunService"):IsStudio()
v3:RemoveDefaultLoadingScreen()
local v6 = v1.LocalPlayer
local v7 = v6:WaitForChild("PlayerGui", 999)
local v8 = v3:WaitForChild("LOADING")
v4:PreloadAsync({ v8 })
v8.Enabled = true
v8.Parent = v7
local v9 = v8:WaitForChild("Inner")
local v_u_10 = v9:WaitForChild("CanvasGroup")
local v_u_11 = v9:WaitForChild("Progress")
local v_u_12 = v_u_11:WaitForChild("TextLabel")
v2:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
v2:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
v_u_12.Text = "0%"
v_u_11.Bar.Size = UDim2.fromScale(0, 1)
v_u_10.GroupTransparency = 1
local v_u_13 = Instance.new("NumberValue")
local v15 = v_u_13.Changed:Connect(function(p14)
	-- upvalues: (copy) v_u_12, (copy) v_u_5, (copy) v_u_11
	v_u_12.Text = ("%*%%"):format((math.floor(p14)))
	v_u_5:Create(v_u_11.Bar, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
		["Size"] = UDim2.fromScale(p14 / 100, 1)
	}):Play()
end)
local function v_u_17(...)
	-- upvalues: (copy) v_u_5
	local v16 = v_u_5:Create(...)
	v16:Play()
	if not ({ ... })[4] then
		v16.Completed:Wait()
	end
	v16:Destroy()
end
local function v19(p18)
	-- upvalues: (copy) v_u_17, (copy) v_u_13, (copy) v_u_10
	v_u_17(v_u_13, TweenInfo.new(1), {
		["Value"] = p18
	}, true)
	v_u_17(v_u_10, TweenInfo.new(1), {
		["GroupTransparency"] = 1 - p18 / 100
	}, true)
end
v19(10)
if not v6:GetAttribute("_CLIENT_LOADED_") then
	repeat
		task.wait()
	until v6:GetAttribute("_CLIENT_LOADED_")
end
v19(20)
task.wait(1)
if not v6.Character then
	v6.CharacterAdded:Wait()
end
v6:RequestStreamAroundAsync(v6.Character:GetPivot().Position)
local v20 = v6.Character:WaitForChild("HumanoidRootPart")
v20.Anchored = true
v19(80)
if not game:IsLoaded() then
	game.Loaded:Wait()
end
v19(100)
task.wait(2)
v20.Anchored = false
v_u_5:Create(v9, TweenInfo.new(0.5), {
	["GroupTransparency"] = 1
}):Play()
task.wait(0.5)
v2:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
v2:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
script:Destroy()
v8:Destroy()
v15:Disconnect()]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Loading]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Script" referent="3663"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = require(v2.Config.Constants)
local v4 = require(v2.Packages.Replica)
local v5 = require(v2.Utility.Network)
local v6 = tick()
require(script.Parent.Data.DataController)
v4.RequestData()
for _, v7 in v2.Utility:GetChildren() do
	local v8 = tick()
	require(v7)
	if v3.DEBUG_MODE.LOADER then
		local v9 = print
		local v10 = string.format
		local v11 = v7.Name
		local v12 = tick() - v8
		v9(v10("\240\159\167\169 | Loaded Utility Module: %s in %ss", v11, (string.sub(v12, 0, 4))))
	end
end
for _, v_u_13 in script.Parent:GetDescendants() do
	if v_u_13:IsA("ModuleScript") and (string.find(v_u_13.Name, "Controller$") and v_u_13.Name ~= "DataController") then
		local v_u_14 = false
		task.delay(3, function()
			-- upvalues: (ref) v_u_14, (copy) v_u_13
			if not v_u_14 then
				warn((("[%*]: %* took too long to load."):format(script.Name, v_u_13.Name)))
			end
		end)
		local v15 = tick()
		local v16 = require(v_u_13)
		if v16.init then
			v16:init()
		end
		v_u_14 = true
		if v3.DEBUG_MODE.LOADER then
			local v17 = print
			local v18 = string.format
			local v19 = v_u_13.Name
			local v20 = tick() - v15
			v17(v18("\240\159\167\169 | Loaded Module: %s in %ss", v19, (string.sub(v20, 0, 4))))
		end
	end
end
v5.remoteEvent("client-loaded").fire()
v1.LocalPlayer:SetAttribute("_CLIENT_LOADED_", true)
local v21 = print
local v22 = string.format
local v23 = tick() - v6
v21(v22("\226\156\133 | Client loaded in: %ss", (string.sub(v23, 0, 4))))]]></ProtectedString><token name="RunContext">2</token><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[client]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="3664"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Currency]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3665"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Client.Data.DataController)
local v3 = require(v1.Config.CurrencyData)
local v_u_11 = {
	["Currency"] = {},
	["OnUpdated"] = require(v1.Packages.Signal).new(),
	["get"] = function(p4, p5)
		return p4.Currency[p5] or 0
	end,
	["observe"] = function(p6, p_u_7, p_u_8)
		p_u_8(p6:get(p_u_7))
		return p6.OnUpdated:Connect(function(p9, p10)
			-- upvalues: (copy) p_u_7, (copy) p_u_8
			if p9 == p_u_7 then
				p_u_8(p10)
			end
		end)
	end
}
for v_u_12, _ in v3 do
	v2:onSet({ "Currency", v_u_12 }, function(p13)
		-- upvalues: (copy) v_u_11, (copy) v_u_12
		v_u_11.Currency[v_u_12] = p13
		v_u_11.OnUpdated:Fire(v_u_12, p13)
	end)
end
return v_u_11]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CurrencyController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3666"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Utility.Network)
local v_u_3 = require(v1.Utility.Notify)
local v4 = {}
local v_u_5 = require(v1.Utility.UI):get("Persistent", "Pending")
v_u_5.Enabled = false
local v_u_6 = v2.remoteFunction("PurchaseToken")
function v4.purchase(_, p7, p8)
	-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_3
	v_u_5.Enabled = true
	local v9, v10 = v_u_6.invoke(p7, p8)
	v_u_3.Notify({
		["Message"] = v10,
		["Type"] = v9 and v_u_3.Types.Success or v_u_3.Types.Error
	})
	task.delay(0.2, function()
		-- upvalues: (ref) v_u_5
		v_u_5.Enabled = false
	end)
end
function v4.init(_) end
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TokenController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3667"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Data]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3668"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Replica)
local v3 = {}
local v_u_4 = nil
local v_u_5 = {}
function v3.get(_)
	-- upvalues: (ref) v_u_4
	if not v_u_4 then
		repeat
			task.wait()
		until v_u_4
	end
	return v_u_4
end
function v3.getValue(p6, p7)
	local v8 = p6:get()
	if not v8 then
		return nil
	end
	local v9 = v8.Data
	for v10 = 1, #p7 do
		v9 = v9[p7[v10]]
	end
	return v9
end
function v3.onSet(p11, p12, p13)
	-- upvalues: (ref) v_u_4
	p13(p11:getValue(p12))
	return v_u_4:OnSet(p12, p13)
end
function v3.onChange(_, p_u_14)
	-- upvalues: (copy) v_u_5
	local v15 = v_u_5
	table.insert(v15, p_u_14)
	return function()
		-- upvalues: (ref) v_u_5, (copy) p_u_14
		local v16 = table.find(v_u_5, p_u_14)
		if v16 then
			table.remove(v_u_5, v16)
		end
	end
end
v2.OnNew("ProfileData", function(p17)
	-- upvalues: (ref) v_u_4, (copy) v_u_5
	v_u_4 = p17
	v_u_4:OnChange(function(...)
		-- upvalues: (ref) v_u_5
		for _, v18 in v_u_5 do
			v18(...)
		end
	end)
end)
return v3]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[DataController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="3669"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Statistics]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3670"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Client.Data.DataController)
local v3 = require(v1.Config.StatisticsData)
local v_u_11 = {
	["Statistics"] = {},
	["OnStatisticChanged"] = require(v1.Packages.Signal).new(),
	["get"] = function(p4, p5)
		return p4.Statistics[p5] or 0
	end,
	["observe"] = function(p6, p_u_7, p_u_8)
		p_u_8(p6:get(p_u_7))
		return p6.OnStatisticChanged:Connect(function(p9, p10)
			-- upvalues: (copy) p_u_7, (copy) p_u_8
			if p9 == p_u_7 then
				p_u_8(p10)
			end
		end)
	end
}
for v_u_12, v_u_13 in v3 do
	v2:onSet({ "Statistics", v_u_12 }, function(p14)
		-- upvalues: (copy) v_u_11, (copy) v_u_12, (copy) v_u_13
		v_u_11.Statistics[v_u_12] = p14 or v_u_13.Default
		v_u_11.OnStatisticChanged:Fire(v_u_12, v_u_11.Statistics[v_u_12])
	end)
end
return v_u_11]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[StatisticController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3671"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Gamepasses]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3672"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Enums.Gamepasses)
local v_u_3 = require(v1.Utility.Format)
local v_u_4 = require(v1.Utility.GamepassUtil)
local v_u_5 = require(v1.Utility.Marketplace)
local v_u_6 = require(v1.Utility.RobloxNotify)
return {
	["init"] = function(_)
		-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_4, (copy) v_u_6, (copy) v_u_3
		task.spawn(function()
			-- upvalues: (ref) v_u_2, (ref) v_u_5, (ref) v_u_4, (ref) v_u_6, (ref) v_u_3
			task.wait(2)
			while true do
				for _, v_u_7 in v_u_2 do
					local v8 = v_u_5.GetGamepassInfo(v_u_7)
					if v8 then
						if v_u_4.has(v_u_7) then
							task.wait(1)
						else
							v_u_6.prompt({
								["Title"] = v8.Name,
								["Text"] = "Just for you!",
								["Icon"] = ("rbxassetid://%*"):format(v8.IconImageAssetId),
								["Duration"] = 10,
								["Callback"] = function(...)
									-- upvalues: (ref) v_u_5, (copy) v_u_7
									v_u_5.PromptGamepass(v_u_7)
								end,
								["Button1"] = v_u_3.robux(v_u_3.comma(v8.PriceInRobux)),
								["Button2"] = "No Thanks"
							})
							task.wait(300)
						end
					else
						task.wait(1)
					end
				end
			end
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GamepassPromptController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3673"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Enums.Gamepasses)
local v_u_3 = require(v1.Packages.Observers)
local v_u_4 = require(v1.Utility.Format)
local v_u_5 = require(v1.Utility.GamepassUtil)
local v_u_6 = require(v1.Utility.Marketplace)
return {
	["init"] = function(_)
		-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_6, (copy) v_u_4, (copy) v_u_5
		v_u_3.observeTag("GamepassBoard", function(p_u_7)
			-- upvalues: (ref) v_u_2, (ref) v_u_6, (ref) v_u_4, (ref) v_u_5
			local v8 = p_u_7:GetAttribute("Gamepass")
			if v8 then
				local v9 = p_u_7:WaitForChild("SurfaceGui")
				local v_u_10 = v9:WaitForChild("Title")
				local v_u_11 = v9:WaitForChild("Value")
				local v_u_12 = v9:WaitForChild("Robux")
				local v_u_13 = v9:WaitForChild("ImageLabel")
				local v_u_14 = p_u_7.CFrame
				local v_u_15 = v_u_2[v8]
				p_u_7.CFrame = CFrame.new(99999, 999999, 99999)
				local v_u_16 = false
				v_u_6.ObserveGamepass(v_u_15, function(p17)
					-- upvalues: (copy) v_u_13, (copy) v_u_10, (copy) v_u_11, (copy) v_u_12, (ref) v_u_4, (ref) v_u_16, (copy) p_u_7, (copy) v_u_14
					v_u_13.Image = ("rbxassetid://%*"):format(p17.IconImageAssetId)
					v_u_10.Text = p17.Name
					v_u_11.Text = p17.Description
					v_u_12.Price.Text = v_u_4.robux(v_u_4.comma(p17.PriceInRobux))
					if not v_u_16 then
						p_u_7.CFrame = v_u_14
					end
				end)
				v_u_12.Activated:Connect(function()
					-- upvalues: (ref) v_u_6, (copy) v_u_15
					v_u_6.PromptGamepass(v_u_15)
				end)
				v_u_5.observe(v_u_15, function(p18)
					-- upvalues: (ref) v_u_16, (copy) p_u_7, (copy) v_u_14
					v_u_16 = p18
					p_u_7.CFrame = p18 and CFrame.new(99999, 999999, 99999) or v_u_14
				end)
			else
				p_u_7:Destroy()
			end
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GamepassBoardController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3674"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Gameplay]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3675"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("HttpService")
local v_u_2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = require(v3.Config.Constants)
local v_u_6 = require(v3.Packages.Observers)
local v7 = require(v3.Packages.Signal)
local v8 = require(v3.Utility.Network)
local v_u_9 = require(v3.Utility.Sound)
local v_u_10 = require(v3.Utility.UI)
local v11 = {
	["Action"] = nil,
	["ActionUpdated"] = v7.new()
}
local v_u_12 = v8.remoteEvent("AFK")
local v_u_13 = v8.remoteEvent("SetAFKAction")
function v11.observe(p14, p_u_15, p_u_16)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	if p14.Action == p_u_15 then
		local v17 = v_u_2.LocalPlayer:GetAttribute("MetaData")
		if v17 then
			p_u_16((v_u_1:JSONDecode(v17)))
		else
			p_u_16()
		end
	end
	return p14.ActionUpdated:Connect(function(p18)
		-- upvalues: (copy) p_u_15, (ref) v_u_2, (ref) v_u_1, (copy) p_u_16
		if p18 == p_u_15 then
			local v19 = v_u_2.LocalPlayer:GetAttribute("MetaData")
			if v19 then
				p_u_16((v_u_1:JSONDecode(v19)))
				return
			end
			p_u_16()
		end
	end)
end
function v11.getAction(p20)
	return p20.Action
end
function v11.setAction(_, p21, p22)
	-- upvalues: (copy) v_u_13
	v_u_13.fire(p21, p22)
end
function v11.init(p_u_23)
	-- upvalues: (copy) v_u_10, (copy) v_u_4, (copy) v_u_5, (copy) v_u_9, (copy) v_u_12, (copy) v_u_6, (copy) v_u_2
	local v_u_24 = os.time()
	local v_u_25 = v_u_10:get("Persistent", "AFK")
	local v_u_26 = v_u_25.Container.Timer
	v_u_25.Enabled = false
	v_u_4.InputBegan:Connect(function()
		-- upvalues: (ref) v_u_24, (copy) v_u_25
		v_u_24 = os.time()
		v_u_25.Enabled = false
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_24, (ref) v_u_5, (copy) v_u_25, (ref) v_u_9, (copy) v_u_26, (ref) v_u_12
		while true do
			local v27 = os.time() - v_u_24
			if v_u_5.AUTO_REJOIN_TIME - v27 <= 120 then
				if v_u_25.Enabled == false then
					v_u_9.play("AFK")
				end
				v_u_25.Enabled = true
				local v28 = v_u_26
				local v29 = v_u_5.AUTO_REJOIN_TIME - v27
				v28.Text = ("%*s"):format((math.floor(v29)))
			end
			if v_u_5.AUTO_REJOIN_TIME <= v27 then
				v_u_12.fire()
				task.wait(5)
			end
			task.wait(1)
		end
	end)
	v_u_6.observeAttribute(v_u_2.LocalPlayer, "Action", function(p30)
		-- upvalues: (copy) p_u_23
		p_u_23.Action = p30
		p_u_23.ActionUpdated:Fire(p30)
	end)
end
return v11]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AutoRejoinController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3676"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.WeekendBuffData)
local v_u_3 = require(v1.Packages.Observers)
local v_u_4 = require(v1.Utility.Multiplier)
local v_u_5 = require(v1.Utility.PerkUtil)
return {
	["init"] = function(_)
		-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_3, (copy) v_u_5
		local v_u_6 = {}
		for _, v_u_7 in v_u_2 do
			local v8 = v_u_7.text
			table.insert(v_u_6, v8)
			v_u_4.assign(v_u_7.type, function()
				-- upvalues: (copy) v_u_7
				if workspace:GetAttribute("Weekend") then
					return v_u_7.value
				end
			end)
		end
		v_u_3.observeAttribute(workspace, "Weekend", function(p9)
			-- upvalues: (ref) v_u_5, (copy) v_u_6
			v_u_5:remove("weekend")
			if p9 then
				local v10 = v_u_5
				local v11 = {
					["Text"] = "Weekend",
					["Icon"] = "rbxassetid://94853572052771",
					["Tooltip"] = {
						["Title"] = "Weekend Buffs",
						["Description"] = table.concat(v_u_6, "\n")
					}
				}
				v10:update(p9, v11)
			end
			return function()
				-- upvalues: (ref) v_u_5
				v_u_5:remove("weekend")
			end
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WeekendController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="3677"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Character]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3678"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v_u_2.Client.Settings.SettingsController)
local v_u_4 = require(v_u_2.Enums.SettingTypes)
local v_u_5 = require(v_u_2.Packages.Observers)
local v6 = {}
local v_u_7 = false
function v6.update(_, p8)
	-- upvalues: (copy) v_u_1, (ref) v_u_7, (copy) v_u_2
	if p8 == v_u_1.LocalPlayer then
		return
	else
		local v9 = p8.Character
		if v9 then
			if v_u_7 then
				v9.Parent = v_u_2
			else
				v9.Parent = workspace
			end
		else
			return
		end
	end
end
function v6.init(p_u_10)
	-- upvalues: (copy) v_u_5, (copy) v_u_3, (copy) v_u_4, (ref) v_u_7, (copy) v_u_1
	v_u_5.observeCharacter(function(p11, _)
		-- upvalues: (copy) p_u_10
		p_u_10:update(p11)
	end)
	v_u_3:observe(v_u_4.HideOtherPlayers, function(p12)
		-- upvalues: (ref) v_u_7, (ref) v_u_1, (copy) p_u_10
		v_u_7 = p12
		for _, v13 in v_u_1:GetPlayers() do
			p_u_10:update(v13)
		end
	end)
end
return v6]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CharacterController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3679"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Chat]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3680"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("HttpService")
local v_u_2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("TextChatService")
local v_u_5 = require(script.Parent.ChatTipsData)
local v_u_6 = require(v3.Client.Settings.SettingsController)
local v_u_7 = require(v3.Config.RuneData)
local v_u_8 = require(v3.Config.RuneOpenData)
local v_u_9 = require(v3.Config.TextChannels)
local v_u_10 = require(v3.Config.ValentineTraitsData)
local v_u_11 = require(v3.Enums.SettingTypes)
local v_u_12 = require(v3.Utility.FontFn)
local v_u_13 = require(v3.Utility.Format)
local v14 = require(v3.Utility.Network)
local v_u_15 = require(v3.Utility.SettingUtil)
require(v3.Utility.Time)
local v_u_16 = v_u_4.ChatWindowConfiguration
local v17 = {
	["Channels"] = {}
}
local v_u_18 = v14.remoteEvent("BasicChatEvent", true)
local v_u_19 = v14.remoteEvent("AdvancedChatEvent", true)
local function v_u_23(p20, p21)
	-- upvalues: (copy) v_u_12
	local v22 = {}
	if p20:GetAttribute("Premium") then
		table.insert(v22, "\238\128\129")
	end
	if p20:GetAttribute("Verified") then
		table.insert(v22, "\238\128\128")
	end
	return table.concat(v22, "") .. " " .. v_u_12.color(p20.DisplayName, p21)
end
local function v_u_26(p24)
	-- upvalues: (copy) v_u_1, (copy) v_u_15, (copy) v_u_11
	local v25 = v_u_1:JSONDecode(p24:GetAttribute("Tags") or "[]")
	return v_u_15.get(v_u_11.HideLeaderboardTags) and "" or (#v25 <= 0 and "" or table.concat(v25, "") .. "")
end
function v17.setupChannels(p27)
	-- upvalues: (copy) v_u_9, (copy) v_u_4
	for v28, v_u_29 in v_u_9 do
		local v_u_30 = v_u_4:WaitForChild(v_u_29.Name, 999)
		if v_u_29.OnIncomingMessage then
			function v_u_30.OnIncomingMessage(p31)
				-- upvalues: (copy) v_u_29, (copy) v_u_30
				return v_u_29.OnIncomingMessage(v_u_30, p31)
			end
		end
		p27.Channels[v28] = v_u_30
	end
end
function v17.chat(p32, p33, p34)
	-- upvalues: (copy) v_u_4
	if p32.Channels[p34 or ""] then
		p32.Channels[p34 or ""]:DisplaySystemMessage(p33)
	else
		v_u_4.TextChannels.RBXGeneral:DisplaySystemMessage(p33)
	end
end
function v17.chatWithData(p35, p36, p37)
	-- upvalues: (copy) v_u_6, (copy) v_u_11, (copy) v_u_7, (copy) v_u_12, (copy) v_u_13, (copy) v_u_8, (copy) v_u_10
	if typeof(p36) == "table" and (p36.Global and not v_u_6:get(v_u_11.GlobalMessages)) then
		return
	elseif p36.type == "runes" then
		if v_u_6:get(v_u_11.RuneMessages) then
			local v38 = v_u_7[p36.runeType or ""]
			if v38 then
				local v39
				if v38.InShop then
					v39 = v_u_12.gradient(("%* (%*%%)"):format(v38.Name, v38.Chance), v38.Gradient)
				else
					v39 = v_u_12.gradient(("%* (1/%*)"):format(v38.Name, (v_u_13.abbreviate(v38.Chance))), v38.Gradient)
				end
				p35:chat(v_u_12.size(("%*%* (@%*) obtained a %* Rune!"):format(p36.Global and "[GLOBAL] " or "", p36.playerName, p36.displayName, v39), 16), p37)
			end
		else
			return
		end
	elseif p36.type == "runeopen" then
		if v_u_6:get(v_u_11.RuneMessages) then
			local v40 = v_u_8[p36.runeType or ""]
			if v40 then
				local v41 = v_u_12.gradient(("%* x%*"):format(v40.Name, p36.amount), v40.Gradient)
				local v42 = ("[GLOBAL] %* (@%*) purchased %*!"):format(p36.playerName, p36.displayName, v41)
				p35:chat(v_u_12.size(v42, 16), p37)
			end
		else
			return
		end
	else
		if p36.type == "v_passives" then
			local v43 = v_u_10[p36.passiveType or ""]
			if not v43 then
				return
			end
			local v44 = v_u_12.gradient(("%* (1/%*)"):format(v43.Name, (v_u_13.abbreviate(100 / v43.Chance))), v43.Gradient)
			p35:chat(v_u_12.size(("%*%* (@%*) obtained a %* Passive!"):format(p36.Global and "[GLOBAL] " or "", p36.playerName, p36.displayName, v44), 16), p37)
		end
		return
	end
end
function v17.init(p_u_45)
	-- upvalues: (copy) v_u_18, (copy) v_u_19, (copy) v_u_4, (copy) v_u_16, (copy) v_u_2, (copy) v_u_26, (copy) v_u_23, (copy) v_u_15, (copy) v_u_11, (copy) v_u_5, (copy) v_u_12
	p_u_45:setupChannels()
	v_u_18.listen(function(p46, p47)
		-- upvalues: (copy) p_u_45
		p_u_45:chat(p46, p47)
	end)
	v_u_19.listen(function(p48, p49)
		-- upvalues: (copy) p_u_45
		p_u_45:chatWithData(p48, p49)
	end)
	function v_u_4.OnChatWindowAdded(p50)
		-- upvalues: (ref) v_u_16, (ref) v_u_2, (ref) v_u_26, (ref) v_u_23
		local v51 = v_u_16:DeriveNewMessageProperties()
		local v52 = p50.TextSource
		if v52 then
			local v53 = v_u_2:GetPlayerByUserId(v52.UserId)
			if v53 then
				if v53:GetAttribute("Title") then
					return v51
				end
				v51.PrefixText = ("%*%*: "):format(v_u_26(v53), (v_u_23(v53, Color3.fromRGB(83, 255, 120))))
				return v51
			end
		end
	end
	task.spawn(function()
		-- upvalues: (ref) v_u_15, (ref) v_u_11, (ref) v_u_5, (copy) p_u_45, (ref) v_u_12
		while true do
			while v_u_15.get(v_u_11.TipMessages) do
				for _, v54 in v_u_5 do
					if v_u_15.get(v_u_11.TipMessages) then
						p_u_45:chat(v_u_12.size(("%* %*"):format(v_u_12.color("[TIP]", Color3.fromRGB(110, 255, 53)), (v_u_12.color(v54, Color3.fromRGB(164, 255, 128)))), 16))
						task.wait(300)
					end
				end
			end
			task.wait(5)
		end
	end)
end
return v17]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ChatController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3681"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	"Make sure to open runes to progress faster!",
	"Make sure to follow us on roblox for boosts!",
	"Use codes for free rewards!",
	"Remember to check back on previous worlds for more upgrades"
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ChatTipsData]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3682"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Lighting]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3683"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

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
	if p9 then
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
	else
		return
	end
end
function v5.init(p_u_15)
	-- upvalues: (copy) v_u_4
	v_u_4.observe(function(p16, ...)
		-- upvalues: (copy) p_u_15
		p_u_15:update(p16)
	end)
end
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LightingController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3684"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Sound]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3685"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("SoundService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = require(v1.Client.Settings.SettingsController)
local v_u_5 = require(v1.Enums.SettingTypes)
local v_u_6 = require(v1.Enums.WorldTypes)
local v_u_7 = require(v1.Utility.WorldUtil)
local v8 = {}
local v_u_9 = 0.5
local function v_u_13(p10, p11)
	-- upvalues: (copy) v_u_3
	local v12 = v_u_3:Create(p10, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["Volume"] = p11
	})
	v12:Play()
	return v12
end
local function v_u_16(p14)
	-- upvalues: (copy) v_u_2, (copy) v_u_13, (ref) v_u_9
	for _, v_u_15 in v_u_2.Music:GetChildren() do
		if v_u_15:IsA("Sound") then
			if v_u_15.Name == p14 then
				v_u_15.Looped = true
				if not v_u_15.IsPlaying then
					v_u_15.Volume = 0
					v_u_15:Play()
				end
				v_u_13(v_u_15, v_u_9)
			elseif v_u_15.IsPlaying then
				v_u_13(v_u_15, 0).Completed:Once(function()
					-- upvalues: (copy) v_u_15
					v_u_15:Stop()
				end)
			end
		end
	end
end
function v8.decrease(_)
	-- upvalues: (ref) v_u_9, (copy) v_u_2, (copy) v_u_13
	v_u_9 = 0.2
	for _, v17 in v_u_2.Music:GetChildren() do
		if v17.IsPlaying then
			v_u_13(v17, v_u_9)
		end
	end
end
function v8.back(_)
	-- upvalues: (ref) v_u_9, (copy) v_u_2, (copy) v_u_13
	v_u_9 = 0.5
	for _, v18 in v_u_2.Music:GetChildren() do
		if v18.IsPlaying then
			v_u_13(v18, v_u_9)
		end
	end
end
function v8.playMusic(_, p19)
	-- upvalues: (copy) v_u_16
	v_u_16(p19)
end
function v8.stopMusic(_)
	-- upvalues: (copy) v_u_16, (copy) v_u_7, (copy) v_u_6
	v_u_16(v_u_7.get() or v_u_6.EARTH_WORLD)
end
function v8.init(_)
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_2, (copy) v_u_7, (copy) v_u_16, (copy) v_u_6
	v_u_4:observe(v_u_5.Music, function(p20)
		-- upvalues: (ref) v_u_2
		v_u_2.Music.Volume = p20 and 0.5 or 0
	end)
	v_u_4:observe(v_u_5.SFX, function(p21)
		-- upvalues: (ref) v_u_2
		v_u_2.SFX.Volume = p21 and 0.5 or 0
	end)
	v_u_7.observe(function(p22, ...)
		-- upvalues: (ref) v_u_16, (ref) v_u_6
		v_u_16(p22 or v_u_6.EARTH_WORLD)
	end)
end
return v8]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SoundController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3686"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Walkspeed]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3687"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Enums.MultiplierTypes)
local v_u_4 = require(v2.Packages.Observers)
local v_u_5 = require(v2.Utility.Multiplier)
return {
	["updateWalkspeed"] = function(_)
		-- upvalues: (copy) v_u_1, (copy) v_u_5, (copy) v_u_3
		local v6 = v_u_1.LocalPlayer.Character
		if v6 then
			local v7 = v6:FindFirstChildOfClass("Humanoid")
			if v7 then
				v7.WalkSpeed = v_u_5.get(v_u_3.Walkspeed) * v_u_5.get(v_u_3.WalkspeedMultiplier)
			end
		else
			return
		end
	end,
	["init"] = function(p_u_8)
		-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_5, (copy) v_u_3
		v_u_4.observeCharacter(function(p9, _)
			-- upvalues: (ref) v_u_1, (copy) p_u_8
			if p9 == v_u_1.LocalPlayer then
				p_u_8:updateWalkspeed()
			end
		end)
		v_u_5.observe(v_u_3.Walkspeed, function()
			-- upvalues: (copy) p_u_8
			p_u_8:updateWalkspeed()
		end)
		v_u_5.observe(v_u_3.WalkspeedMultiplier, function()
			-- upvalues: (copy) p_u_8
			p_u_8:updateWalkspeed()
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WalkspeedController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3688"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Sllimes]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3689"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("TweenService")
local v5 = require(v_u_2.Config.Constants)
local v_u_6 = require(v_u_2.Config.CurrencyData)
local v_u_7 = require(v_u_2.Config.EffectData)
local v_u_8 = require(v_u_2.Config.GloopData)
require(v_u_2.Config.ItemData)
local v_u_9 = require(v_u_2.Config.SlimeData)
local v_u_10 = require(v_u_2.Config.SlimeVarientData)
local v_u_11 = require(v_u_2.Config.WorldData)
local v_u_12 = require(v_u_2.Enums.MultiplierTypes)
local v_u_13 = require(v_u_2.Enums.SettingTypes)
local v_u_14 = require(v_u_2.Enums.SlimeVarientTypes)
local v_u_15 = require(v_u_2.Functions.CurrencyPopup)
local v_u_16 = require(v_u_2.Functions.GloopPopup)
local v_u_17 = require(v_u_2.Functions.NumberIndicator)
local v18 = require(v_u_2.Functions.WaitFor)
local v19 = require(v_u_2.Packages.Janitor)
local v_u_20 = require(v_u_2.Packages.Observers)
local v_u_21 = require(v_u_2.Utility.CollectUtil)
local v_u_22 = require(v_u_2.Utility.Format)
local v_u_23 = require(v_u_2.Utility.Multiplier)
local v24 = require(v_u_2.Utility.Network)
local v_u_25 = require(v_u_2.Utility.ObjCache)
local v_u_26 = require(v_u_2.Utility.SettingUtil)
local v_u_27 = require(v_u_2.Utility.Sound)
local v_u_28 = require(v_u_2.Utility.Spring)
local v_u_29 = require(v_u_2.Utility.VFXUtil)
local v_u_30 = require(v_u_2.Utility.WorldUtil)
local v_u_31 = require(v_u_2.Utility.ZoneUtil)
local v_u_32 = v24.remoteEvent("SlimeSpawnEvent")
local v_u_33 = v24.remoteEvent("SlimeAttackEvent")
local v_u_34 = v24.remoteEvent("SlimeUpdateEvent")
local v_u_35 = v24.remoteEvent("SlimeVisualEvent", true)
local v_u_36 = v24.remoteEvent("SlimeClearEvent")
local v_u_37 = v24.remoteEvent("SlimeComboEvent", true)
local v_u_38 = v24.remoteEvent("SlimeEffectEvent")
local v_u_39 = {}
local v_u_40 = {}
local v41 = {}
for v42, v43 in v_u_10 do
	v_u_39[v42] = v43:GetModel()
end
local v44 = v18(v_u_2, "Assets")
local v_u_45 = v18(v44, "RangePart"):Clone()
local v_u_46 = v_u_45:WaitForChild("SurfaceGui"):WaitForChild("Frame"):WaitForChild("UIScale")
v_u_45.Parent = v_u_2
local v_u_47 = v18(v44, "Billboard", "SlimeOverhead")
local v_u_48 = v18(v44, "Billboard", "Critical")
local v_u_49 = v18(v44, "Billboard", "Combo")
local v_u_50 = {}
for _, v51 in v18(workspace, "Persistent", "Slimes"):GetChildren() do
	if v51:IsA("BasePart") then
		v_u_50[v51.Name] = v51
	end
end
local v_u_52 = v19.new()
local v_u_53 = false
local v_u_54 = 2.1
local v_u_55 = v5.COMBO_MULTIPLIER
local v_u_56 = Random.new()
local v_u_57 = {}
local v_u_58 = {}
function v41.get(_, p59)
	-- upvalues: (ref) v_u_40
	return v_u_40[p59]
end
function v41.getInstances(_, p60)
	-- upvalues: (copy) v_u_9, (copy) v_u_10, (copy) v_u_14, (copy) v_u_57, (copy) v_u_2, (copy) v_u_47, (copy) v_u_29, (copy) v_u_25, (copy) v_u_39
	local v61 = v_u_9[p60.slime]
	if v61 then
		local v62 = ("%*-%*"):format(p60.slime, p60.type)
		local v63 = v_u_10[p60.type or v_u_14.Normal]
		if not v_u_57[v62] then
			local v64 = v61.Model:Clone()
			v64.Name = p60.uid
			v64.Parent = v_u_2
			local v65 = v_u_47:Clone()
			v65.Name = "__OVERHEAD__"
			v65.Title.Text = v61.Name
			v65.Title.TextColor3 = v61.Color
			v65.Adornee = v64.PrimaryPart
			v65.Parent = v64.PrimaryPart
			for _, v66 in ipairs(v64:GetDescendants()) do
				if v66:IsA("BasePart") then
					v66:SetAttribute("original", v66.Size)
				end
			end
			local v67 = v_u_29.create("SlimeHit")
			if v67 then
				v67.Name = "__HIT_PARTICLE"
				v_u_29.changeColor(v67, v61.Color)
				v67.Parent = v64.PrimaryPart
			end
			local v68 = v_u_29.create("SlimeDestroy")
			if v68 then
				v68.Name = "__DESTROY_PARTICLE"
				v_u_29.changeColor(v68, v61.Color)
				v68.Parent = v64.PrimaryPart
			end
			if v63.ApplyVFX then
				v63:ApplyVFX(v64)
			end
			v65.Type.Text = p60.type or "Normal"
			v65.Type.Visible = p60.type ~= v_u_14.Normal
			v65.Type.UIGradient.Rotation = v63.Rotation or 0
			if v63 and v63.GetGradient then
				v65.Type.UIGradient.Color = v63:GetGradient()
			end
			v_u_57[v62] = v_u_25.new(v64, v_u_39[p60.type or v_u_14.Normal])
		end
		local v69 = v_u_57[v62]
		local v70 = CFrame.new
		local v71 = p60.position
		local v72 = v61.Model.__ROOT.Size.Y / 2
		local v73 = v70(v71 + Vector3.new(0, v72, 0))
		local v74 = CFrame.Angles
		local v75 = math.random(0, 360)
		local v76 = v69:Get(v73 * v74(0, math.rad(v75), 0))
		local v77 = v76.PrimaryPart:WaitForChild("__OVERHEAD__")
		local v78 = v76.PrimaryPart:FindFirstChild("__HIT_PARTICLE")
		return {
			["model"] = v76,
			["overhead"] = v77,
			["vfx"] = {
				["destroy"] = v76.PrimaryPart:FindFirstChild("__DESTROY_PARTICLE"),
				["hit"] = v78
			}
		}
	end
end
function v41.playCritHit(_, p79)
	-- upvalues: (copy) v_u_26, (copy) v_u_13, (copy) v_u_48, (copy) v_u_4
	if v_u_26.get(v_u_13.DamageIndicators) then
		local v_u_80 = Instance.new("Attachment")
		v_u_80.CFrame = CFrame.new(p79 + Vector3.new(0, 3, 0))
		v_u_80.Parent = workspace
		local v_u_81 = v_u_48:Clone()
		local v82 = v_u_81.Size
		v_u_81.Adornee = v_u_80
		v_u_81.Parent = v_u_80
		v_u_81.Size = UDim2.new(0, 0, 0, 0)
		v_u_4:Create(v_u_80, TweenInfo.new(2, Enum.EasingStyle.Exponential), {
			["Position"] = v_u_80.Position + Vector3.new(0, 3, 0)
		}):Play()
		v_u_4:Create(v_u_81, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
			["Size"] = v82
		}):Play()
		local v_u_83 = v_u_4:Create(v_u_81.TextLabel, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
			["Rotation"] = 15
		})
		v_u_81.TextLabel.Rotation = -15
		v_u_83:Play()
		task.delay(1, function()
			-- upvalues: (ref) v_u_4, (copy) v_u_81, (copy) v_u_83, (copy) v_u_80
			v_u_4:Create(v_u_81, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
				["Size"] = UDim2.new(0, 0, 0, 0)
			}):Play()
			task.wait(1)
			v_u_83:Cancel()
			v_u_80:Destroy()
		end)
	end
end
function v41.playCombo(_, p84, p85)
	-- upvalues: (ref) v_u_55, (copy) v_u_49, (copy) v_u_27, (copy) v_u_56, (copy) v_u_4
	local v_u_86 = Instance.new("Attachment")
	v_u_86.CFrame = CFrame.new(p84 + Vector3.new(0, 3, 0))
	v_u_86.Parent = workspace
	local v87 = 1 + p85 * v_u_55
	local v_u_88 = v_u_49:Clone()
	local v89 = v_u_88.Size
	v_u_88.Value.Text = ("%* COMBO!"):format(p85)
	local v90 = v_u_88.Multi
	local v91 = v87 * 100
	v90.Text = ("(x%* Multiplier)"):format(math.floor(v91) / 100)
	v_u_88.Adornee = v_u_86
	v_u_88.Parent = v_u_86
	v_u_88.Size = UDim2.new(0, 0, 0, 0)
	v_u_27.play("Combo", {
		["PlaybackSpeed"] = v_u_56:NextNumber(1, 1 + p85 / 10)
	})
	v_u_4:Create(v_u_86, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
		["Position"] = v_u_86.Position + Vector3.new(0, 3, 0)
	}):Play()
	v_u_4:Create(v_u_88, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
		["Size"] = v89
	}):Play()
	local v_u_92 = v_u_4:Create(v_u_88, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
		["Size"] = UDim2.fromScale(v89.X.Scale * 2, v89.Y.Scale * 2)
	})
	task.delay(1, function()
		-- upvalues: (copy) v_u_92
		v_u_92:Play()
	end)
	task.delay(2, function()
		-- upvalues: (ref) v_u_4, (copy) v_u_88, (copy) v_u_92, (copy) v_u_86
		v_u_4:Create(v_u_88, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
			["Size"] = UDim2.new(0, 0, 0, 0)
		}):Play()
		task.wait(1)
		v_u_92:Cancel()
		v_u_86:Destroy()
	end)
end
function v41.spawn(p_u_93, p_u_94)
	-- upvalues: (copy) v_u_9, (ref) v_u_40, (copy) v_u_27, (copy) v_u_56, (copy) v_u_22, (copy) v_u_29, (copy) v_u_28, (copy) v_u_7, (copy) v_u_57
	local v95 = v_u_9[p_u_94.slime]
	if v95 then
		if not v_u_40[p_u_94.uid] then
			local v_u_96 = p_u_93:getInstances(p_u_94)
			v_u_27.play("SlimeSpawn", {
				["Parent"] = v_u_96.model.PrimaryPart,
				["PlaybackSpeed"] = v_u_56:NextNumber(0.8, 1.2)
			})
			local v_u_97 = {}
			v_u_40[p_u_94.uid] = {
				["uid"] = p_u_94.uid,
				["model"] = v_u_96.model,
				["color"] = v95.Color,
				["health"] = p_u_94.health,
				["maxHealth"] = p_u_94.maxHealth,
				["position"] = v_u_96.model:GetPivot().Position,
				["effects"] = {},
				["SetHealth"] = function(p98, p99)
					-- upvalues: (copy) v_u_96, (ref) v_u_22
					p98.health = p99
					v_u_96.overhead.Enabled = p99 < p98.maxHealth
					v_u_96.overhead.HP.Title.Text = v_u_22.abbreviateComma((math.floor(p99)))
					local v100 = v_u_96.overhead.HP.UIGradient
					local v101 = Vector2.new
					local v102 = p99 / p98.maxHealth
					v100.Offset = v101(math.clamp(v102, 0, 1), 0)
				end,
				["Hit"] = function(p103, p104)
					-- upvalues: (ref) v_u_27, (copy) v_u_96, (ref) v_u_56, (copy) p_u_93, (ref) v_u_29, (ref) v_u_28
					v_u_27.play("SlimeHit", {
						["Parent"] = v_u_96.model.PrimaryPart,
						["PlaybackSpeed"] = v_u_56:NextNumber(p104.crit and 1.2 or 0.8, p104.crit and 1.6 or 1.2)
					})
					if p104.crit then
						p_u_93:playCritHit(p103.position)
					end
					if p104.currency == nil then
						if v_u_96.vfx.hit then
							v_u_29.play(v_u_96.vfx.hit)
						end
						v_u_96.model:ScaleTo(0.6)
						v_u_28.target(v_u_96.model, 0.5, 5, {
							["Scale"] = 1
						})
					end
				end,
				["UpdateEffects"] = function(p105, p106)
					-- upvalues: (copy) v_u_97, (ref) v_u_7
					for v107, v108 in p105.effects do
						if v_u_97[v108.Type] and not v107[v108.Guid] then
							v_u_97[v108.Type]()
							v_u_97[v108.Type] = nil
						end
					end
					p105.effects = p106
					for _, v109 in p106 do
						if not v_u_97[v109.Type] then
							local v110 = v_u_7[v109.Type]
							if v110 and v110.apply then
								v_u_97[v109.Type] = v110.apply(p105)
							end
						end
					end
				end,
				["Destroy"] = function(_, p111)
					-- upvalues: (copy) v_u_97, (copy) v_u_96, (ref) v_u_40, (copy) p_u_94, (ref) v_u_57, (ref) v_u_28, (ref) v_u_27, (ref) v_u_56, (ref) v_u_29
					for _, v112 in v_u_97 do
						v112()
					end
					table.clear(v_u_97)
					if p111 then
						v_u_96.model:Destroy()
						v_u_40[p_u_94.uid] = nil
						return
					elseif v_u_96.model:GetAttribute("blackhole_suck") then
						v_u_96.model:SetAttribute("blackhole_suck", nil)
						local v113 = ("%*-%*"):format(p_u_94.slime, p_u_94.type)
						if v_u_57[v113] then
							v_u_28.stop(v_u_96.model)
							v_u_96.model:ScaleTo(1)
							v_u_96.overhead.Enabled = true
							v_u_57[v113]:Return(v_u_96.model)
						end
						v_u_40[p_u_94.uid] = nil
					else
						v_u_96.overhead.Enabled = false
						local v_u_114 = v_u_96.model.PrimaryPart:Clone()
						v_u_114.Parent = workspace
						v_u_27.play("SlimeBreak", {
							["Parent"] = v_u_114,
							["PlaybackSpeed"] = v_u_56:NextNumber(0.8, 1.2)
						})
						if v_u_96.vfx.destroy then
							v_u_96.vfx.destroy.Parent = v_u_114
							v_u_29.play(v_u_96.vfx.destroy)
						end
						v_u_28.target(v_u_96.model, 1, 5, {
							["Scale"] = 0.1
						})
						task.delay(0.3, function()
							-- upvalues: (ref) p_u_94, (ref) v_u_57, (ref) v_u_28, (ref) v_u_96, (copy) v_u_114
							local v115 = ("%*-%*"):format(p_u_94.slime, p_u_94.type)
							if v_u_57[v115] then
								v_u_28.stop(v_u_96.model)
								v_u_96.model:ScaleTo(1)
								v_u_96.overhead.Enabled = true
								v_u_57[v115]:Return(v_u_96.model)
							end
							task.wait(0.3)
							v_u_114:Destroy()
						end)
						v_u_40[p_u_94.uid] = nil
					end
				end
			}
			v_u_40[p_u_94.uid]:SetHealth(p_u_94.health)
		end
	else
		warn((("No slime data found for slime type: %*"):format(p_u_94.slime)))
		return
	end
end
function v41.start(p116)
	-- upvalues: (copy) v_u_30, (copy) v_u_52, (ref) v_u_53, (copy) v_u_28, (copy) v_u_45, (copy) v_u_58, (copy) v_u_3, (copy) v_u_1, (ref) v_u_54, (copy) v_u_33
	local v117 = v_u_30.get()
	v_u_52:Cleanup()
	v_u_53 = true
	v_u_28.stop(v_u_45)
	v_u_45.Parent = workspace
	local v118 = v_u_45
	local v119 = v_u_45.Size.X
	v118.Size = Vector3.new(v119, 0, 0)
	p116:updateRange()
	local v120 = v_u_58[v117] or 5
	local v121 = v_u_28.target
	local v122 = v_u_45
	local v123 = {}
	local v124 = v_u_45.Size.X
	local v125 = v120 * 2
	local v126 = v120 * 2
	v123.Size = Vector3.new(v124, v125, v126)
	v121(v122, 0.7, 5, v123)
	v_u_52:Add(v_u_3.Heartbeat:Connect(function()
		-- upvalues: (ref) v_u_1, (ref) v_u_45, (ref) v_u_54
		local v127 = v_u_1.LocalPlayer.Character
		if v127 then
			local v128 = v127:GetPivot()
			local v129 = v_u_45
			local v130 = v128.Position.X
			local v131 = v_u_54
			local v132 = v128.Position.Z
			v129.Position = Vector3.new(v130, v131, v132)
		end
	end))
	v_u_52:Add(task.spawn(function()
		-- upvalues: (ref) v_u_33
		while true do
			v_u_33.fire()
			task.wait(0.1)
		end
	end))
end
function v41.stop(_)
	-- upvalues: (ref) v_u_53, (copy) v_u_28, (copy) v_u_45, (copy) v_u_2, (copy) v_u_52
	v_u_53 = false
	local v133 = v_u_28.target
	local v134 = v_u_45
	local v135 = {}
	local v136 = v_u_45.Size.X
	v135.Size = Vector3.new(v136)
	v133(v134, 1, 5, v135)
	task.delay(0.5, function()
		-- upvalues: (ref) v_u_53, (ref) v_u_45, (ref) v_u_2, (ref) v_u_52
		if not v_u_53 then
			v_u_45.Parent = v_u_2
			v_u_52:Cleanup()
		end
	end)
end
function v41.update(_, p137, p138)
	-- upvalues: (ref) v_u_40
	local v139 = v_u_40[p137]
	if v139 then
		v139:SetHealth(p138.health)
	end
end
function v41.damage(_, p140, p141)
	-- upvalues: (ref) v_u_40, (copy) v_u_9, (copy) v_u_17, (copy) v_u_22, (copy) v_u_1, (copy) v_u_6, (copy) v_u_21, (copy) v_u_56, (copy) v_u_15, (copy) v_u_8, (copy) v_u_16
	local v142 = v_u_40[p140]
	if v142 then
		v142:Hit(p141)
	end
	local v143 = v_u_9[p141.slime]
	if v143 then
		local v144 = v_u_17
		local v145 = {
			["StartPosition"] = p141.position + Vector3.new(0, 3, 0),
			["EndPosition"] = p141.position + Vector3.new(0, 6, 0)
		}
		local v146 = v_u_22.abbreviateComma
		local v147 = p141.damage
		v145.Value = ("-%*"):format((v146((math.floor(v147)))))
		v145.Color = Color3.fromRGB(255, 0, 0)
		v144(v145)
		if p141.currency then
			local v148 = v_u_1.LocalPlayer.Character
			if not v148 then
				return
			end
			local v149 = v148:FindFirstChild("HumanoidRootPart")
			if not v149 then
				return
			end
			for v_u_150, v_u_151 in p141.currency do
				local v152 = v_u_6[v_u_150]
				local v_u_153 = v152 and v152.Color or Color3.fromRGB(255, 223, 0)
				v_u_21.collect({
					["Start"] = p141.position,
					["End"] = v149,
					["Color"] = ColorSequence.new(v_u_153, v143.Color),
					["Duration"] = v_u_56:NextNumber(0.3, 0.7)
				}):OnComplete(function()
					-- upvalues: (ref) v_u_15, (copy) v_u_150, (copy) v_u_151, (copy) v_u_153
					v_u_15({
						["currency"] = v_u_150,
						["amount"] = v_u_151,
						["color"] = ColorSequence.new(v_u_153)
					})
				end)
			end
		end
		if p141.gloop then
			local v154 = v_u_1.LocalPlayer.Character
			if not v154 then
				return
			end
			local v155 = v154:FindFirstChild("HumanoidRootPart")
			if not v155 then
				return
			end
			for v_u_156, v_u_157 in p141.gloop do
				local v158 = v_u_8[v_u_156]
				if v158 then
					local v_u_159 = v158.Color
					v_u_21.collect({
						["Start"] = p141.position,
						["End"] = v155,
						["Color"] = ColorSequence.new(v_u_159, v143.Color),
						["Duration"] = v_u_56:NextNumber(0.3, 0.7)
					}):OnComplete(function()
						-- upvalues: (ref) v_u_16, (copy) v_u_156, (copy) v_u_157, (copy) v_u_159
						v_u_16({
							["gloop"] = v_u_156,
							["amount"] = v_u_157,
							["color"] = ColorSequence.new(v_u_159)
						})
					end)
				end
			end
		end
	end
end
function v41.updateRange(_)
	-- upvalues: (copy) v_u_30, (copy) v_u_11, (copy) v_u_23, (copy) v_u_58, (copy) v_u_28, (copy) v_u_45
	local v160 = v_u_30.get()
	local v161 = v_u_11[v160]
	if v161 then
		if v161.Range then
			local v162 = v_u_23.get(v161.Range.base) * v_u_23.get(v161.Range.multi)
			v_u_58[v160] = v162
			local v163 = v_u_28.target
			local v164 = v_u_45
			local v165 = {}
			local v166 = v_u_45.Size.X
			local v167 = v162 * 2
			local v168 = v162 * 2
			v165.Size = Vector3.new(v166, v167, v168)
			v163(v164, 1, 2, v165)
		end
	else
		return
	end
end
function v41.getClosestSlime(_)
	-- upvalues: (copy) v_u_1, (ref) v_u_40
	local v169 = v_u_1.LocalPlayer.Character
	if not v169 then
		return nil
	end
	local v170 = v169:FindFirstChild("HumanoidRootPart")
	if not v170 then
		return nil
	end
	local v171 = (1 / 0)
	local v172 = nil
	for _, v173 in v_u_40 do
		local v174 = (v173.position - v170.Position).Magnitude
		if v174 < v171 then
			v172 = v173
			v171 = v174
		end
	end
	return v172
end
function v41.isInRange(_, p175)
	-- upvalues: (copy) v_u_1, (copy) v_u_58, (copy) v_u_30
	local v176 = v_u_1.LocalPlayer.Character
	if v176 then
		local v177 = v176:FindFirstChild("HumanoidRootPart")
		if v177 then
			return (p175 - v177.Position).Magnitude <= (v_u_58[v_u_30.get()] or 5)
		else
			return false
		end
	else
		return false
	end
end
function v41.init(p_u_178)
	-- upvalues: (copy) v_u_32, (copy) v_u_11, (copy) v_u_23, (copy) v_u_30, (ref) v_u_54, (copy) v_u_50, (copy) v_u_36, (ref) v_u_40, (copy) v_u_35, (copy) v_u_38, (copy) v_u_34, (copy) v_u_37, (copy) v_u_1, (copy) v_u_20, (copy) v_u_46, (copy) v_u_4, (copy) v_u_12, (ref) v_u_55, (copy) v_u_31
	v_u_32.listen(function(...)
		-- upvalues: (copy) p_u_178
		p_u_178:spawn(...)
	end)
	local v179 = {}
	for _, v180 in v_u_11 do
		if v180.Range then
			for _, v181 in v180.Range do
				if not v179[v181] then
					v179[v181] = true
					v_u_23.observe(v181, function(_)
						-- upvalues: (copy) p_u_178
						p_u_178:updateRange()
					end)
				end
			end
		end
	end
	v_u_30.observe(function(p182)
		-- upvalues: (ref) v_u_54, (ref) v_u_50, (copy) p_u_178
		v_u_54 = v_u_50[p182] and v_u_50[p182].Position.Y + v_u_50[p182].Size.Y / 2 or 2.1
		p_u_178:updateRange()
	end)
	v_u_36.listen(function()
		-- upvalues: (ref) v_u_40
		for _, v183 in v_u_40 do
			v183:Destroy(true)
		end
		v_u_40 = {}
	end)
	v_u_35.listen(function(p184)
		-- upvalues: (copy) p_u_178
		for v185, v186 in p184 do
			task.spawn(p_u_178.damage, p_u_178, v185, v186)
		end
	end)
	v_u_38.listen(function(p187, p188)
		-- upvalues: (ref) v_u_40
		if v_u_40[p187] then
			v_u_40[p187]:UpdateEffects(p188)
		end
	end)
	v_u_34.listen(function(p189)
		-- upvalues: (ref) v_u_40, (copy) p_u_178
		for v190, v191 in p189 do
			local v192 = v_u_40[v190]
			if v192 then
				if v191.health <= 0 then
					v192:Destroy()
				else
					p_u_178:update(v190, v191)
				end
				task.wait(0.01)
			end
		end
	end)
	v_u_37.listen(function(p193)
		-- upvalues: (ref) v_u_1, (copy) p_u_178
		local v194 = v_u_1.LocalPlayer.Character
		if v194 then
			p_u_178:playCombo(v194:GetPivot().Position, p193)
		end
	end)
	v_u_20.observeAttribute(v_u_1.LocalPlayer, "attack", function(p195)
		-- upvalues: (ref) v_u_46, (ref) v_u_4
		local v196 = p195 - workspace:GetServerTimeNow()
		v_u_46.Scale = v196 < 0.5 and (1 - v196 / 0.5 or 0) or 0
		v_u_4:Create(v_u_46, TweenInfo.new(v196, Enum.EasingStyle.Linear), {
			["Scale"] = 1
		}):Play()
	end)
	v_u_23.observe(v_u_12.ComboMultiplier, function(p197)
		-- upvalues: (ref) v_u_55
		v_u_55 = p197
	end)
	v_u_31.observe("SLIME_ZONE", function()
		-- upvalues: (copy) p_u_178
		p_u_178:start()
		return function()
			-- upvalues: (ref) p_u_178
			p_u_178:stop()
		end
	end)
end
return v41]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeSpawnerController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3690"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = require(v2.Packages.Janitor)
local v_u_5 = require(script.Parent.SlimeSpawnerController)
local v_u_6 = {}
local v_u_7 = false
local v_u_8 = v4.new()
function v_u_6.isActive(_)
	-- upvalues: (ref) v_u_7
	return v_u_7
end
function v_u_6.start(_)
	-- upvalues: (copy) v_u_8, (ref) v_u_7, (copy) v_u_3, (copy) v_u_1, (copy) v_u_5
	v_u_8:Cleanup()
	v_u_7 = true
	local v_u_9 = tick()
	v_u_8:Add(v_u_3.Heartbeat:Connect(function()
		-- upvalues: (ref) v_u_9, (ref) v_u_1, (ref) v_u_5
		if tick() - v_u_9 < 0.5 then
			return
		else
			v_u_9 = tick()
			local v10 = v_u_1.LocalPlayer.Character
			if v10 then
				local v11 = v10:FindFirstChildOfClass("Humanoid")
				if v11 and v11.Health > 0 then
					local v12 = v_u_5:getClosestSlime()
					if v12 then
						v11:MoveTo(v12.position)
					end
				end
			else
				return
			end
		end
	end))
end
function v_u_6.stop(_)
	-- upvalues: (ref) v_u_7, (copy) v_u_8
	v_u_7 = false
	v_u_8:Cleanup()
end
function v_u_6.toggle(_)
	-- upvalues: (ref) v_u_7, (copy) v_u_6
	if v_u_7 then
		v_u_6:stop()
	else
		v_u_6:start()
	end
	return v_u_7
end
function v_u_6.init(_) end
return v_u_6]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AutoSlimeController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3691"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = require(v1.Client.Gameplay.Sound.SoundController)
local v_u_4 = require(v1.Config.Colors)
local v5 = require(v1.Functions.WaitFor)
local v_u_6 = require(v1.Packages.Observers)
local v_u_7 = require(v1.Utility.Format)
local v8 = require(v1.Utility.Network)
local v_u_9 = require(v1.Utility.Notify)
local v_u_10 = require(v1.Utility.Sound)
local v_u_11 = require(v1.Utility.Time)
local v12 = {}
local v13 = v5(v5(workspace, "Persistent", "__ICE_WORLD_START__"), "SurfaceGui")
local v14 = v5(v13, "Frame")
local v_u_15 = v5(v13, "Claim")
local v_u_16 = v5(v14, "Killed")
local v_u_17 = v5(v14, "Round")
local v_u_18 = v5(v14, "Timer")
local v_u_19 = v5(v14, "Score")
local v_u_20 = v8.remoteFunction("StartIceWorldSpawnEvent")
local v_u_21 = v8.remoteFunction("StopIceWorldSpawnEvent")
local v_u_22 = false
local v_u_23 = nil
local v_u_24 = {
	["Active"] = v8.remoteEvent("IceWorld/Active"),
	["Score"] = v8.remoteEvent("IceWorld/Score"),
	["WaveUpdated"] = v8.remoteEvent("IceWorld/WaveUpdated"),
	["TimeRemaining"] = v8.remoteEvent("IceWorld/TimeRemaining"),
	["SlimesKilled"] = v8.remoteEvent("IceWorld/SlimesKilled")
}
local v_u_25 = nil
function v12.init(_)
	-- upvalues: (copy) v_u_6, (ref) v_u_23, (copy) v_u_15, (ref) v_u_22, (copy) v_u_20, (copy) v_u_9, (copy) v_u_21, (copy) v_u_24, (copy) v_u_17, (copy) v_u_10, (copy) v_u_2, (copy) v_u_16, (copy) v_u_4, (copy) v_u_3, (ref) v_u_25, (copy) v_u_19, (copy) v_u_18, (copy) v_u_11, (copy) v_u_7
	v_u_6.observeTag("IceWorldFloor", function(p26)
		-- upvalues: (ref) v_u_23
		v_u_23 = p26
		return function()
			-- upvalues: (ref) v_u_23
			v_u_23 = nil
		end
	end)
	v_u_15.Activated:Connect(function()
		-- upvalues: (ref) v_u_22, (ref) v_u_20, (ref) v_u_9, (ref) v_u_21
		if v_u_22 then
			local v27, v28 = v_u_21.invoke()
			v_u_9.Notify({
				["Message"] = v28,
				["Type"] = v27 and v_u_9.Types.Success or v_u_9.Types.Error
			})
		else
			local v29, v30 = v_u_20.invoke()
			v_u_9.Notify({
				["Message"] = v30,
				["Type"] = v29 and v_u_9.Types.Success or v_u_9.Types.Error
			})
		end
	end)
	v_u_24.WaveUpdated.listen(function(p31)
		-- upvalues: (ref) v_u_17, (ref) v_u_10, (ref) v_u_2, (ref) v_u_23
		v_u_17.Text = ("Round: %*"):format(p31)
		if p31 > 1 then
			v_u_10.play("RoundWin")
		end
		task.spawn(function()
			-- upvalues: (ref) v_u_2, (ref) v_u_23
			v_u_2:Create(v_u_23, TweenInfo.new(0.5), {
				["Color"] = Color3.new(1, 1, 1)
			}):Play()
			task.wait(0.2)
			v_u_2:Create(v_u_23, TweenInfo.new(1), {
				["Color"] = Color3.fromRGB(77, 113, 131)
			}):Play()
		end)
	end)
	v_u_24.SlimesKilled.listen(function(p32, p33)
		-- upvalues: (ref) v_u_16
		v_u_16.Text = ("Slimes Killed: %*/%*"):format(p32, p33)
	end)
	local v_u_34 = { "SLIMEWAVE", "SLIMEWAVE2" }
	local function v36(p35)
		-- upvalues: (ref) v_u_22, (ref) v_u_15, (ref) v_u_4, (ref) v_u_3, (copy) v_u_34, (ref) v_u_25, (ref) v_u_10, (ref) v_u_17, (ref) v_u_16, (ref) v_u_19, (ref) v_u_18, (ref) v_u_11
		v_u_22 = p35
		if p35 then
			v_u_15.Cost.Text = "Stop"
			v_u_15.UIGradient.Color = v_u_4.Red.Gradient
			v_u_15.UIStroke.Color = v_u_4.Red.Stroke
			v_u_15.Cost.UIStroke.Color = v_u_4.Red.Stroke
			v_u_3:playMusic(v_u_34[math.random(1, #v_u_34)])
		else
			if v_u_25 then
				task.cancel(v_u_25)
				v_u_25 = nil
				v_u_10.play("RoundLose")
			end
			v_u_15.Cost.Text = "Start"
			v_u_15.UIGradient.Color = v_u_4.Green.Gradient
			v_u_15.UIStroke.Color = v_u_4.Green.Stroke
			v_u_15.Cost.UIStroke.Color = v_u_4.Green.Stroke
			v_u_17.Text = "Round: --"
			v_u_16.Text = "Slimes Killed: --/--"
			v_u_19.Text = "Score: 0"
			v_u_18.Text = v_u_11.format(0)
			v_u_3:stopMusic()
		end
	end
	v_u_22 = false
	if v_u_25 then
		task.cancel(v_u_25)
		v_u_25 = nil
		v_u_10.play("RoundLose")
	end
	v_u_15.Cost.Text = "Start"
	v_u_15.UIGradient.Color = v_u_4.Green.Gradient
	v_u_15.UIStroke.Color = v_u_4.Green.Stroke
	v_u_15.Cost.UIStroke.Color = v_u_4.Green.Stroke
	v_u_17.Text = "Round: --"
	v_u_16.Text = "Slimes Killed: --/--"
	v_u_19.Text = "Score: 0"
	v_u_18.Text = v_u_11.format(0)
	v_u_3:stopMusic()
	v_u_24.Active.listen(v36)
	v_u_24.Score.listen(function(p37)
		-- upvalues: (ref) v_u_19, (ref) v_u_7
		v_u_19.Text = ("Score: %*"):format((v_u_7.abbreviateComma(p37)))
	end)
	v_u_24.TimeRemaining.listen(function(p_u_38)
		-- upvalues: (ref) v_u_25, (ref) v_u_18, (ref) v_u_11
		if v_u_25 then
			task.cancel(v_u_25)
			v_u_25 = nil
		end
		v_u_25 = task.spawn(function()
			-- upvalues: (copy) p_u_38, (ref) v_u_18, (ref) v_u_11
			while true do
				local v39 = p_u_38 - workspace:GetServerTimeNow()
				v_u_18.Text = v_u_11.format((math.floor(v39)))
				task.wait(1)
			end
		end)
	end)
end
return v12]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[IceWorldSlimeController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3692"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Config.SlimeData)
local v4 = require(v1.Config.ValentineData)
local v_u_5 = require(v1.Functions.WaitFor)
local v_u_6 = require(v1.Packages.Observers)
local v_u_7 = require(v1.Utility.CollectUtil)
local v_u_8 = {
	["Killed"] = require(v1.Utility.Network).remoteEvent("ValentineSlimeService/Killed", true)
}
local v_u_9 = {}
local v10 = {}
for v11, v12 in v4.Progressive do
	v_u_9[v12.target] = {
		["slime"] = v11,
		["amount"] = v12.amount
	}
end
function v10.slimeKilled(_, p13)
	-- upvalues: (copy) v_u_3, (copy) v_u_7
	local v14 = v_u_3[p13.slime]
	if v14 then
		v_u_7.collect({
			["Start"] = p13.startPos,
			["End"] = p13.endPos,
			["Color"] = ColorSequence.new(v14.Color),
			["Duration"] = 0.7
		}):OnComplete(function() end)
	end
end
function v10.setup(_, p15)
	-- upvalues: (copy) v_u_9, (copy) v_u_5, (copy) v_u_2
	local v_u_16 = v_u_9[p15.Name]
	if v_u_16 then
		local v17 = v_u_5(p15, "Interactive")
		local v_u_18 = v_u_5(v17, "Progress")
		local v_u_19 = v_u_5(v_u_5(v17, "SurfaceGui"), "TextLabel")
		local v_u_20 = v_u_18.Position
		local v_u_21 = v_u_18.Size
		local function v_u_34(p22)
			-- upvalues: (copy) v_u_16, (copy) v_u_21, (copy) v_u_18, (copy) v_u_20, (copy) v_u_19
			local v23 = p22 / v_u_16.amount
			local v24 = math.clamp(v23, 0, 1)
			local v25 = v_u_21.Y * v24
			local v26 = v_u_18
			local v27 = v_u_21.X
			local v28 = v_u_21.Z
			v26.Size = Vector3.new(v27, v25, v28)
			local v29 = v_u_18
			local v30 = v_u_20
			local v31 = (v25 - v_u_21.Y) / 2
			v29.Position = v30 + Vector3.new(0, v31, 0)
			local v32 = v_u_19
			local v33 = v24 * 10000
			v32.Text = ("%*%%"):format(math.floor(v33) / 100)
		end
		v_u_34(0)
		v_u_2:onSet({ "Valentines", "SlimeProgress", v_u_16.slime }, function(p35)
			-- upvalues: (copy) v_u_34
			v_u_34(p35 or 0)
		end)
	end
end
function v10.init(p_u_36)
	-- upvalues: (copy) v_u_8, (copy) v_u_6
	v_u_8.Killed.listen(function(p37)
		-- upvalues: (copy) p_u_36
		p_u_36:slimeKilled(p37)
	end)
	v_u_6.observeTag("ValentinePodium", function(p38)
		-- upvalues: (copy) p_u_36
		p_u_36:setup(p38)
	end)
end
return v10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ValentineSlimeController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3693"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Upgrades]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3694"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Config.MultiplierData)
local v_u_4 = require(v1.Config.UpgradeBoardData)
local v5 = require(v1.Enums.LockTypes)
local v6 = require(v1.Packages.Signal)
local v7 = require(v1.Utility.LockUtil)
local v_u_8 = require(v1.Utility.Multiplier)
local v_u_9 = require(v1.Utility.Sound)
local v_u_20 = {
	["Upgrades"] = {},
	["OnUpdated"] = v6.new(),
	["observe"] = function(p_u_10, p_u_11, p_u_12)
		p_u_12(p_u_10:getLevel(p_u_11))
		return p_u_10.OnUpdated:Connect(function(p13, _)
			-- upvalues: (copy) p_u_11, (copy) p_u_12, (copy) p_u_10
			if p_u_11 == p13 then
				p_u_12(p_u_10:getLevel(p_u_11))
			end
		end)
	end,
	["getLevel"] = function(p14, p15)
		return p14.Upgrades[p15] or 0
	end,
	["init"] = function(p_u_16)
		-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_8
		for v_u_17, v_u_18 in v_u_4 do
			if v_u_18.MultiplierFunctionality == "Default" then
				if v_u_3[v_u_18.MultiplierType] then
					v_u_8.assign(v_u_18.MultiplierType, function(_)
						-- upvalues: (copy) p_u_16, (copy) v_u_17, (copy) v_u_18
						local v19 = p_u_16:getLevel(v_u_17)
						if v19 and v19 > 0 then
							return v_u_18:CalculateMultiplier(v19)
						end
					end)
				else
					warn((("[%*] - MultiplierType \'%*\' for upgrade \'%*\' does not exist."):format(script.Name, v_u_18.MultiplierType, v_u_17)))
				end
			end
		end
	end
}
v7.assign(v5.Upgrade, function(p21)
	-- upvalues: (copy) v_u_20
	return (p21.level or 0) <= v_u_20:getLevel(p21.value)
end)
local v_u_22 = false
for v_u_23, _ in v_u_4 do
	v2:onSet({ "UpgradeBoard", v_u_23 }, function(p24)
		-- upvalues: (ref) v_u_22, (copy) v_u_20, (copy) v_u_23, (copy) v_u_9
		local v25 = p24 or 0
		if v_u_22 and (v_u_20.Upgrades[v_u_23] or 0) < v25 then
			v_u_9.play("Upgrade")
		end
		v_u_20.Upgrades[v_u_23] = v25
		v_u_20.OnUpdated:Fire(v_u_23, v25)
	end)
end
return v_u_20]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UpgradeBoardController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3695"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Client.Settings.SettingsController)
local v_u_4 = require(v2.Config.CurrencyData)
local v_u_5 = require(v2.Config.MultiplierData)
local v_u_6 = require(script.Parent.UpgradeBoardController)
local v_u_7 = require(v2.Config.UpgradeBoardData)
local v_u_8 = require(v2.Enums.LockTypes)
local v_u_9 = require(v2.Enums.SettingTypes)
local v10 = require(v2.Functions.WaitFor)
local v_u_11 = require(v2.Packages.Observers)
local v_u_12 = require(v2.Utility.FontFn)
local v_u_13 = require(v2.Utility.Format)
local v_u_14 = require(v2.Utility.LockUtil)
local v15 = require(v2.Utility.Network)
local v_u_16 = require(v2.Utility.Notify)
local v_u_17 = require(v2.Utility.PitchUtility)
local v_u_18 = require(v2.Utility.SettingUtil)
local v_u_19 = require(v2.Utility.Sound)
local v_u_20 = v15.remoteFunction("PurchaseUpgradeBoard")
local v_u_21 = v10(v1.LocalPlayer, "PlayerGui")
local v_u_22 = {}
local v23 = {}
local v_u_24 = false
local v_u_25 = {
	["CONFETTI_UPGRADES"] = "Confetti"
}
for v26, v27 in v_u_7 do
	if not v_u_22[v27.Board] then
		v_u_22[v27.Board] = {}
	end
	local v28 = v_u_22[v27.Board]
	table.insert(v28, v26)
end
function v23.setup(_, p29)
	-- upvalues: (copy) v_u_22, (copy) v_u_25, (copy) v_u_14, (copy) v_u_8, (copy) v_u_7, (copy) v_u_4, (copy) v_u_5, (copy) v_u_18, (copy) v_u_9, (ref) v_u_24, (copy) v_u_16, (copy) v_u_20, (copy) v_u_19, (copy) v_u_17, (copy) v_u_6, (copy) v_u_12, (copy) v_u_13, (copy) v_u_3, (copy) v_u_21
	if v_u_22[p29.Name] then
		local v_u_30 = p29.SurfaceGui
		local v31 = v_u_25[p29.Name]
		if v31 then
			local v32 = v_u_14.observe
			local v33 = {
				[v_u_8.Milestone] = {
					["value"] = v31
				}
			}
			v32(v33, function(p34)
				-- upvalues: (copy) v_u_30
				v_u_30.Enabled = not p34
			end)
		end
		local v_u_35 = {}
		for _, v_u_36 in v_u_22[p29.Name] do
			local v_u_37 = v_u_7[v_u_36]
			if v_u_37 then
				local v_u_38 = v_u_4[v_u_37.CurrencyType]
				if v_u_38 then
					local v_u_39 = v_u_5[v_u_37.MultiplierType]
					if v_u_39 then
						local v_u_40 = p29.SurfaceGui.Container.Template:Clone()
						v_u_40.Visible = true
						v_u_40.LayoutOrder = v_u_37.Order or 999
						v_u_40.Title.Text = v_u_37.Name
						v_u_40.Desc.Text = v_u_37.Description
						v_u_40.Icon.Image = v_u_37.Icon
						v_u_40.Icon_bg.Image = v_u_37.Icon
						v_u_40.Name = v_u_36
						v_u_40.Parent = p29.SurfaceGui.Container
						v_u_40.Frame.Max:AddTag("CurrencyButton")
						v_u_40.Frame.One:AddTag("CurrencyButton")
						v_u_40.Frame.Max:SetAttribute("Currency", v_u_37.CurrencyType)
						v_u_40.Frame.One:SetAttribute("Currency", v_u_37.CurrencyType)
						local v_u_41 = false
						local v_u_42 = false
						if v_u_37.LockedData then
							v_u_14.observe(v_u_37.LockedData, function(p43)
								-- upvalues: (ref) v_u_42, (copy) v_u_40, (ref) v_u_18, (ref) v_u_9, (ref) v_u_41, (ref) v_u_24, (ref) v_u_16, (copy) v_u_37
								v_u_42 = p43
								v_u_40.Visible = not v_u_42
								if v_u_18.get(v_u_9.HideMaxedUpgrades) and v_u_41 then
									v_u_40.Visible = false
								end
								if not v_u_42 and v_u_24 then
									v_u_16.Notify({
										["Message"] = ("%* Upgrade Unlocked! (%*)"):format(v_u_37.Name, v_u_37.Board),
										["Type"] = v_u_16.Types.New,
										["Duration"] = 6
									})
								end
							end)
						end
						v_u_40.Frame.Max.Activated:Connect(function()
							-- upvalues: (ref) v_u_20, (copy) v_u_36, (ref) v_u_19, (ref) v_u_17, (ref) v_u_16
							local v44, v45 = v_u_20.invoke(v_u_36, true)
							if v44 then
								v_u_19.play("BoardPurchase", {
									["PlaybackSpeed"] = v_u_17.get("UpgradeBoardPurchase")
								})
							end
							v_u_16.Notify({
								["Message"] = v45,
								["Type"] = v44 and v_u_16.Types.Success or v_u_16.Types.Error
							})
						end)
						v_u_40.Frame.One.Activated:Connect(function()
							-- upvalues: (ref) v_u_20, (copy) v_u_36, (ref) v_u_19, (ref) v_u_17, (ref) v_u_16
							local v46, v47 = v_u_20.invoke(v_u_36, false)
							if v46 then
								v_u_19.play("BoardPurchase", {
									["PlaybackSpeed"] = v_u_17.get("UpgradeBoardPurchase")
								})
							end
							v_u_16.Notify({
								["Message"] = v47,
								["Type"] = v46 and v_u_16.Types.Success or v_u_16.Types.Error
							})
						end)
						v_u_6:observe(v_u_36, function(p48)
							-- upvalues: (copy) v_u_37, (copy) v_u_40, (copy) v_u_39, (ref) v_u_41, (ref) v_u_18, (ref) v_u_9, (ref) v_u_42, (ref) v_u_12, (ref) v_u_13, (copy) v_u_38
							local v49 = v_u_37.CalculateVisual and v_u_37:CalculateVisual(p48) or v_u_37:CalculateMultiplier(p48)
							v_u_40.Cost.Visible = p48 < v_u_37.MaxLevel
							local v50 = v_u_37.Format or v_u_39.Format
							v_u_41 = v_u_37.MaxLevel <= p48
							if v_u_18.get(v_u_9.HideMaxedUpgrades) and v_u_41 then
								v_u_40.Visible = false
							else
								v_u_40.Visible = not v_u_42
							end
							if v_u_37.MaxLevel <= p48 then
								v_u_40.Level.Text = ("Max Level (%*)"):format(v_u_37.MaxLevel)
								v_u_40.Value.Text = v50(v49)
								v_u_40.LayoutOrder = 999 + (v_u_37.Order or 999)
								v_u_40.Frame.Max.Visible = false
								v_u_40.Frame.One.Visible = false
							else
								v_u_40.LayoutOrder = v_u_37.Order or 999
								local v51 = v_u_37:CalculateCost(p48)
								local v52 = math.floor(v51)
								local v53 = v_u_37.CalculateVisual and v_u_37:CalculateVisual(p48 + 1) or v_u_37:CalculateMultiplier(p48 + 1)
								v_u_40.Level.Text = ("Level: %*/%*"):format(p48, v_u_37.MaxLevel)
								v_u_40.Value.Text = ("%* \226\134\146 %*"):format(v50(v49), (v50(v53)))
								v_u_40.Cost.Text = ("Cost:  %*"):format((v_u_12.color(("%* %*"):format(v_u_13.abbreviateComma(v52), (v_u_38.GetPrefix(v52))), v_u_38.Color)))
								v_u_40.Frame.Max.Visible = true
								v_u_40.Frame.One.Visible = true
								v_u_40.Frame.Max:SetAttribute("Cost", v52)
								v_u_40.Frame.One:SetAttribute("Cost", v52)
							end
						end)
						v_u_35[v_u_36] = {
							["IsMaxed"] = function()
								-- upvalues: (ref) v_u_41
								return v_u_41
							end,
							["Hide"] = function()
								-- upvalues: (copy) v_u_40
								v_u_40.Visible = false
							end,
							["Show"] = function()
								-- upvalues: (ref) v_u_42, (copy) v_u_40
								if not v_u_42 then
									v_u_40.Visible = true
								end
							end
						}
					else
						warn((("[%*] - MultiplierType \'%*\' for upgrade \'%*\' does not exist."):format(script.Name, v_u_37.MultiplierType, v_u_36)))
					end
				else
					warn((("[%*] - CurrencyType \'%*\' for upgrade \'%*\' does not exist."):format(script.Name, v_u_37.CurrencyType, v_u_36)))
				end
			else
				warn((("[%*] - Upgrade \'%*\' data not found for board \'%*\'."):format(script.Name, v_u_36, p29.Name)))
			end
		end
		v_u_3:observe(v_u_9.HideMaxedUpgrades, function(p54)
			-- upvalues: (copy) v_u_35
			for _, v55 in v_u_35 do
				if v55.IsMaxed() and p54 then
					v55.Hide()
				else
					v55.Show()
				end
			end
		end)
		v_u_30.Container.Template.Visible = false
		v_u_30.Adornee = p29
		v_u_30.Parent = v_u_21
	else
		warn((("[%*] - No upgrades found for board \'%*\'."):format(script.Name, p29.Name)))
	end
end
function v23.init(p_u_56)
	-- upvalues: (copy) v_u_11, (ref) v_u_24
	v_u_11.observeTag("UpgradeBoards", function(p57)
		-- upvalues: (copy) p_u_56
		p_u_56:setup(p57)
	end, { workspace })
	task.delay(5, function()
		-- upvalues: (ref) v_u_24
		v_u_24 = true
	end)
end
return v23]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UpgradeBoardVisualController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3696"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(script.Parent.NodeClass)
local v_u_4 = require(v_u_2.Client.Data.DataController)
local v_u_5 = require(v_u_2.Config.UpgradeTreeData)
local v6 = require(v_u_2.Enums.LockTypes)
local v7 = require(v_u_2.Packages.Observers)
local v8 = require(v_u_2.Packages.Signal)
local v_u_9 = require(v_u_2.Utility.LockUtil)
local v10 = require(v_u_2.Utility.Multiplier)
local v11 = require(v_u_2.Utility.Network)
local v_u_12 = require(v_u_2.Utility.Notify)
local v_u_13 = {
	["NodesOwned"] = {},
	["Nodes"] = {},
	["NodeChanged"] = v8.new()
}
local v_u_14 = v11.remoteFunction("UpgradeNodePurchaseEvent")
local v_u_15 = Instance.new("Highlight")
v_u_15.FillColor = Color3.new(1, 1, 1)
v_u_15.OutlineColor = Color3.new(1, 1, 1)
v_u_15.FillTransparency = 0.8
v_u_15.OutlineTransparency = 0
v_u_15.Parent = v1.LocalPlayer:WaitForChild("PlayerGui")
function v_u_13.setup(p16, p_u_17)
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_3, (copy) v_u_14, (copy) v_u_12, (copy) v_u_15, (copy) v_u_13, (copy) v_u_4
	local v18 = v_u_5[p_u_17.Name]
	local v19 = v18 ~= nil
	local v20 = ("UpgradeTreeData[%*] is nil"):format(p_u_17.Name)
	assert(v19, v20)
	local v21 = p_u_17:WaitForChild("__ROOT")
	local v22 = v_u_2.Assets.Surface.Node:Clone()
	v22.Name = "__SURFACE"
	v22.Parent = p_u_17
	v22.Adornee = v21
	v22.Container.Title.Text = p_u_17.Name
	v22.ImageLabel.Image = v18.Image or ""
	if v18.Color then
		for _, v23 in p_u_17.Color:GetChildren() do
			if v23:IsA("BasePart") then
				v23.Color = v18.Color
			end
		end
	end
	local v_u_24 = v_u_3.new(p_u_17)
	local v25 = p_u_17.Name
	v_u_24.Tree = tonumber(v25:match("^(%d+)-"))
	v_u_24:setLevel(0)
	v_u_24:hide()
	local v26 = Instance.new("ClickDetector")
	v26.MaxActivationDistance = 999
	v26.Parent = p_u_17
	v26.MouseClick:Connect(function(_)
		-- upvalues: (ref) v_u_14, (copy) p_u_17, (ref) v_u_12
		local v27, v28 = v_u_14.invoke(p_u_17.Name)
		v_u_12.Notify({
			["Message"] = v28,
			["Type"] = v27 and v_u_12.Types.Success or v_u_12.Types.Error,
			["Stack"] = true
		})
	end)
	v26.MouseHoverEnter:Connect(function(_)
		-- upvalues: (copy) v_u_24, (ref) v_u_15, (copy) p_u_17
		if not v_u_24.Completed then
			if v_u_24:canAfford() then
				v_u_15.FillColor = Color3.new(0, 1, 0)
				v_u_15.OutlineColor = Color3.new(0, 1, 0)
			else
				v_u_15.FillColor = Color3.new(1, 0, 0)
				v_u_15.OutlineColor = Color3.new(1, 0, 0)
			end
			v_u_15.Adornee = p_u_17
		end
	end)
	v26.MouseHoverLeave:Connect(function(_)
		-- upvalues: (ref) v_u_15
		v_u_15.Adornee = nil
	end)
	if v_u_13:checkRequirements(v18.Requires) then
		v_u_24:show(true)
	end
	local v29 = v_u_4:getValue({ "Nodes" })
	if v29[p_u_17.Name] and v29[p_u_17.Name] > 0 then
		v_u_24:setLevel(v29[p_u_17.Name])
		v_u_24:show(true)
	end
	p16.Nodes[p_u_17.Name] = v_u_24
end
function v_u_13.checkRequirements(_, p30)
	-- upvalues: (copy) v_u_13, (copy) v_u_9
	if not p30 then
		return true
	end
	for _, v31 in p30.nodes or {} do
		if not v_u_13:hasNode(v31) then
			return false
		end
	end
	return not (p30.locked and v_u_9.isLocked(p30.locked))
end
function v_u_13.reset(_, p32)
	-- upvalues: (copy) v_u_13, (copy) v_u_5
	local v33 = v_u_13.Nodes[p32]
	if v33 then
		local v34 = v_u_5[p32]
		v33:setLevel(0)
		if v34.Requires then
			v33:hide()
		else
			v33:show(true)
		end
	else
		return
	end
end
function v_u_13.getLevel(p35, p36)
	return p35.NodesOwned[p36] or 0
end
function v_u_13.hasNode(p37, p38)
	return p37:getLevel(p38) > 0
end
function v_u_13.observe(p39, p_u_40, p_u_41)
	p_u_41(p39:getLevel(p_u_40))
	return p39.NodeChanged:Connect(function(p42, p43)
		-- upvalues: (copy) p_u_40, (copy) p_u_41
		if p42 == p_u_40 then
			p_u_41(p43)
		end
	end)
end
v_u_9.assign(v6.Node, function(p44)
	-- upvalues: (copy) v_u_13
	return v_u_13:hasNode(p44.value)
end)
for v_u_45, v46 in v_u_5 do
	v_u_13.NodesOwned[v_u_45] = v_u_4:getValue({ "Nodes", v_u_45 }) or 0
	v_u_13.NodeChanged:Fire(v_u_45, v_u_13.NodesOwned[v_u_45])
	if v46.Requires and v46.Requires.locked then
		v_u_9.observe(v46.Requires.locked, function(p47)
			-- upvalues: (copy) v_u_13, (copy) v_u_45, (copy) v_u_12
			local v48 = v_u_13.Nodes[v_u_45]
			if v48 then
				if v48.Hidden and not p47 then
					v_u_12.Notify({
						["Message"] = "New Upgrade Nodes Unlocked! (EARTH WORLD)",
						["Type"] = v_u_12.Types.New,
						["Duration"] = 6
					})
					v48:show()
				end
			end
		end)
	end
	for v_u_49, v_u_50 in v46.Levels do
		if v_u_50.Multipliers then
			for _, v_u_51 in v_u_50.Multipliers do
				v10.assign(v_u_51.type, function()
					-- upvalues: (copy) v_u_13, (copy) v_u_45, (copy) v_u_49, (copy) v_u_51
					if v_u_13:getLevel(v_u_45) == v_u_49 then
						return v_u_51.value
					end
				end)
			end
		end
		if v_u_50.Formula then
			v10.assign(v_u_50.Formula.multiplier, function(p52)
				-- upvalues: (copy) v_u_13, (copy) v_u_45, (copy) v_u_49, (copy) v_u_50
				if v_u_13:getLevel(v_u_45) == v_u_49 then
					local v53 = v_u_50.Formula.callback(p52)
					local v54 = v_u_50.Formula.min
					local v55 = v_u_50.Formula.cap
					return math.clamp(v53, v54, v55)
				end
			end)
		end
	end
end
v_u_13.NodeChanged:Connect(function(_, _)
	-- upvalues: (copy) v_u_13
	for _, v56 in v_u_13.Nodes do
		if v56.Hidden then
			if v_u_13:checkRequirements(v56.Data.Requires) then
				v56:show()
			end
			local v57 = v56.Level
			local v58 = v56.Data.Levels[v57 + 1]
			if v58 and (v58.Requires and v_u_13:checkRequirements(v58.Requires)) then
				v56:show()
			end
		end
	end
end)
v_u_4:onChange(function(_, p59, p60, _)
	-- upvalues: (copy) v_u_13
	if p59[1] == "Nodes" then
		if p59[2] then
			local v61 = p59[2]
			local v62 = v_u_13.Nodes[v61]
			if v62 then
				v_u_13.NodesOwned[v61] = p60 or 0
				v_u_13.NodeChanged:Fire(v61, p60 or 0)
				if p60 then
					v62:toggleLight(false)
					v62:setLevel(p60)
				else
					v_u_13:reset(v61)
				end
			else
				return
			end
		else
			for v63, _ in v_u_13.NodesOwned do
				if not p60[v63] then
					v_u_13.NodesOwned[v63] = 0
					v_u_13:reset(v63)
				end
			end
			return
		end
	else
		return
	end
end)
task.spawn(function()
	-- upvalues: (copy) v_u_13, (copy) v_u_4
	while true do
		for _, v64 in v_u_13.Nodes do
			if not (v64.Hidden or v64.Completed) then
				if v64:canAfford() then
					v64:toggleLight(true)
				else
					v64:toggleLight(false)
				end
			end
		end
		for v65, _ in v_u_4:getValue({ "Nodes" }) do
			local v66 = v_u_13.Nodes[v65]
			if v66 and (v66.Hidden and v_u_13:checkRequirements(v66.Requires)) then
				v66:show()
			end
		end
		task.wait(2)
	end
end)
v7.observeTag("Node", function(p67)
	-- upvalues: (copy) v_u_13
	v_u_13:setup(p67)
end)
return v_u_13]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UpgradeTreeController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3697"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Debris")
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = require(v_u_3.Client.Currency.CurrencyController)
local v_u_6 = require(v_u_3.Config.CurrencyData)
local v_u_7 = require(v_u_3.Config.UpgradeTreeData)
local v8 = require(v_u_3.Functions.WaitFor)
local v_u_9 = require(v_u_3.Packages.Throttle)
local v_u_10 = require(v_u_3.Utility.FontFn)
local v_u_11 = require(v_u_3.Utility.Format)
local v_u_12 = require(v_u_3.Utility.PitchUtility)
local v_u_13 = require(v_u_3.Utility.Sound)
local v_u_14 = require(v_u_3.Utility.Spring)
local v_u_15 = require(v_u_3.Utility.VFXUtil)
local v_u_16 = {}
v_u_16.__index = v_u_16
local function v_u_19(p17)
	for _, v18 in p17:GetChildren() do
		if v18:IsA("BasePart") then
			return v18.Color
		end
	end
	return Color3.new(1, 1, 1)
end
local v_u_20 = workspace.CurrentCamera.FieldOfView
local v21 = v8(v2.LocalPlayer, "PlayerGui", "Persistent", "UpgradeTree")
local v_u_22 = v8(v21, "Main", "HUDGlow")
v21.Enabled = true
v_u_22.ImageTransparency = 1
function v_u_16.new(p23)
	-- upvalues: (copy) v_u_16, (copy) v_u_7, (copy) v_u_19, (copy) v_u_15
	local v24 = v_u_16
	local v25 = setmetatable({}, v24)
	v25.Model = p23
	v25.SurfaceGui = p23:WaitForChild("__SURFACE")
	v25.Data = v_u_7[p23.Name]
	v25.Level = 1
	v25.Root = p23:WaitForChild("__ROOT")
	v25.Parent = p23.Parent
	v25.OriginalCFrame = p23:GetPivot()
	v25.HiddenCFrame = v25.OriginalCFrame - Vector3.new(0, 5, 0)
	v25.Hidden = false
	v25.Completed = false
	v25.Color = v_u_19(p23.Color)
	local v26 = Instance.new("PointLight")
	v26.Range = 10
	v26.Brightness = 0.5
	v26.Color = v25.Color
	v26.Enabled = false
	v26.Parent = v25.Root
	v25.VFX = v_u_15.create("UpgradeTree")
	v_u_15.changeColor(v25.VFX, v25.Color)
	v25.VFX.Parent = v25.Root
	v25.Light = v26
	v25.Thread = nil
	return v25
end
function v_u_16.setLevel(p_u_27, p28)
	-- upvalues: (copy) v_u_6, (copy) v_u_11, (copy) v_u_10, (copy) v_u_9
	local v_u_29 = p_u_27.Data.Levels[p28 + 1] or p_u_27.Data.Levels[p28]
	if v_u_29 then
		if p_u_27.Thread then
			task.cancel(p_u_27.Thread)
			p_u_27.Thread = nil
		end
		p_u_27.Completed = p28 == #p_u_27.Data.Levels
		if #p_u_27.Data.Levels <= 1 then
			p_u_27.SurfaceGui.Container.Level.Visible = false
			p_u_27.SurfaceGui.Container.LevelSplitter.Visible = false
		else
			p_u_27.SurfaceGui.Container.Level.Text = ("Level %* / %*"):format(p28, #p_u_27.Data.Levels)
		end
		p_u_27.SurfaceGui.Container.Description.Text = v_u_29.Text
		if v_u_29.CurrencyType then
			local v30 = v_u_6[v_u_29.CurrencyType]
			local v31 = v_u_11.abbreviateComma(v_u_29.CurrencyCost)
			local v32 = v30.GetPrefix(v_u_29.CurrencyCost)
			p_u_27.SurfaceGui.Container.Cost.Text = ("Cost: %*"):format((v_u_10.color(("%* %*"):format(v31, v32), v30.Color)))
		else
			p_u_27.SurfaceGui.Container.Cost.Text = ("Cost: %*"):format((v_u_10.color(("%* Awakening"):format(v_u_29.Awakening), Color3.new(1, 1, 1))))
		end
		if p_u_27.Completed then
			if v_u_29.Formula then
				p_u_27.Thread = task.spawn(function()
					-- upvalues: (copy) p_u_27, (copy) v_u_29
					while true do
						p_u_27.SurfaceGui.Container.Cost.Text = v_u_29.Formula.format(v_u_29.Formula.callback())
						task.wait(1)
					end
				end)
			else
				p_u_27.SurfaceGui.Container.Cost.Text = "Max Level Reached"
			end
		end
		if p_u_27.Level ~= p28 and p_u_27.Level < p28 then
			v_u_9("node-animate", 0.1, function()
				-- upvalues: (copy) p_u_27
				p_u_27:animate()
			end)
		end
		p_u_27.Level = p28
	end
end
function v_u_16.canAfford(p33, _)
	-- upvalues: (copy) v_u_5
	local v34 = p33.Data.Levels[p33.Level + 1]
	if v34 then
		return v34.CurrencyType and v_u_5:get(v34.CurrencyType) >= v34.CurrencyCost and true or false
	else
		return false
	end
end
function v_u_16.toggleLight(p35, p36)
	p35.Light.Enabled = p36
end
function v_u_16.show(p37, p38)
	-- upvalues: (copy) v_u_14
	p37.Hidden = false
	if not p38 then
		p37.Model:PivotTo(p37.HiddenCFrame)
		v_u_14.target(p37.Model, 0.5, 5, {
			["Pivot"] = p37.OriginalCFrame
		})
	end
	p37.Model.Parent = p37.Parent
end
function v_u_16.animate(p_u_39)
	-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_15, (copy) v_u_13, (copy) v_u_12, (copy) v_u_22, (copy) v_u_20
	local v40 = Instance.new("Part")
	v40.Color = p_u_39.Color or Color3.new(1, 1, 1)
	v40.Material = Enum.Material.Neon
	v40.Transparency = 0.5
	v40.Size = p_u_39.Root.Size
	v40.CFrame = p_u_39.Root.CFrame
	v40.CanCollide = false
	v40.CanQuery = false
	v40.CanTouch = false
	v40.Anchored = true
	v40.Size = v40.Size + Vector3.new(0, 6, 0)
	v40.Parent = workspace
	v_u_4:Create(v40, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
		["Position"] = v40.Position + Vector3.new(0, 5, 0),
		["Size"] = v40.Size - Vector3.new(0, 6, 0),
		["Transparency"] = 1
	}):Play()
	v_u_1:AddItem(v40, 1)
	v_u_15.play(p_u_39.VFX)
	v_u_13.play("BoardPurchase", {
		["PlaybackSpeed"] = v_u_12.get("UpgradeTreePurchase")
	})
	v_u_22.ImageColor3 = p_u_39.Color or Color3.new(1, 1, 1)
	v_u_4:Create(p_u_39.Light, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		["Brightness"] = 5,
		["Range"] = 15,
		["Enabled"] = true
	}):Play()
	v_u_4:Create(workspace.CurrentCamera, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		["FieldOfView"] = v_u_20 - 1.5
	}):Play()
	v_u_4:Create(v_u_22, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		["ImageTransparency"] = 0.9
	}):Play()
	task.delay(0.1, function()
		-- upvalues: (ref) v_u_4, (ref) v_u_20, (ref) v_u_22, (copy) p_u_39
		local v41 = {
			["FieldOfView"] = v_u_20
		}
		v_u_4:Create(workspace.CurrentCamera, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), v41):Play()
		v_u_4:Create(v_u_22, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			["ImageTransparency"] = 1
		}):Play()
		v_u_4:Create(p_u_39.Light, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			["Brightness"] = 0.5,
			["Range"] = 10,
			["Enabled"] = false
		}):Play()
	end)
end
function v_u_16.hide(p42, _)
	-- upvalues: (copy) v_u_3
	p42.Model.Parent = v_u_3
	p42.Hidden = true
end
function v_u_16.Destroy(p43)
	table.clear(p43)
	setmetatable(p43, nil)
end
return v_u_16]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[NodeClass]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3698"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Runes]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3699"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Currency.CurrencyController)
local v_u_3 = require(v1.Client.Data.Statistics.StatisticController)
local v_u_4 = require(v1.Config.Constants)
local v_u_5 = require(v1.Config.RuneData)
local v_u_6 = require(v1.Config.RuneOpenData)
local v_u_7 = require(v1.Enums.MultiplierTypes)
local v_u_8 = require(v1.Packages.Observers)
local v_u_9 = require(v1.Utility.Format)
local v_u_10 = require(v1.Utility.Multiplier)
local v_u_11 = require(v1.Utility.Time)
return {
	["setup"] = function(_, p12)
		-- upvalues: (copy) v_u_6, (copy) v_u_3, (copy) v_u_9, (copy) v_u_2, (copy) v_u_10, (copy) v_u_7, (copy) v_u_4, (copy) v_u_11, (copy) v_u_5
		local v_u_13 = v_u_6[p12.Name]
		if v_u_13 then
			local v14 = p12:WaitForChild("ScrollingFrame")
			local v15 = v14:WaitForChild("Odds"):WaitForChild("ScrollingFrame"):WaitForChild("Template")
			local v_u_16 = v14:WaitForChild("Stats")
			p12.Title.Text = v_u_13.Name
			v_u_16.World.Text = v_u_13.Name
			v_u_3:observe(("Rune%*Opened"):format(p12.Name), function(p17)
				-- upvalues: (copy) v_u_16, (ref) v_u_9
				v_u_16.Opened.Text = ("%* Opened"):format((v_u_9.abbreviateComma(p17)))
			end)
			v_u_2:observe(v_u_13.CurrencyType, function(p18)
				-- upvalues: (copy) v_u_13, (ref) v_u_10, (ref) v_u_7, (ref) v_u_4, (copy) v_u_16, (ref) v_u_9, (ref) v_u_11
				local v19 = p18 // v_u_13.CurrencyCost
				local v20 = v_u_10.get(v_u_7.RuneOpenTime) / v_u_10.get(v_u_7.RuneOpenTimeMultiplier)
				local v21 = v_u_4.RUNE_SPEED_CAP
				local v22 = v19 * math.max(v20, v21)
				v_u_16.OpenAmount.Text = ("%* Rune%*"):format(v_u_9.abbreviateComma(v19), v19 > 1 and "s" or "")
				v_u_16.OpenFor.Text = v_u_11.formatRune(v22)
			end)
			for _, v23 in v_u_13.Runes do
				local v24 = v_u_5[v23]
				if v24 and not v24.Secret then
					local v25 = v15:Clone()
					v25.Title.Text = ("%* - 1 in %*"):format(v24.Name, (v_u_9.abbreviateComma(v24.Chance)))
					v25.Title.UIGradient.Color = v24.Gradient
					v25.LayoutOrder = v24.Order
					v25.Parent = v15.Parent
					if v24.Animated then
						v25.Title.UIGradient:AddTag("Gradient")
					end
				end
			end
			v15:Destroy()
		else
			warn("No rune open data found for:", p12.Name)
		end
	end,
	["init"] = function(p_u_26)
		-- upvalues: (copy) v_u_8
		v_u_8.observeTag("RuneOpenBoard", function(p27)
			-- upvalues: (copy) p_u_26
			p_u_26:setup(p27)
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RuneOpenBoardController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3700"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Config.RuneData)
local v3 = require(v1.Packages.Signal)
local v4 = require(v1.Client.Data.DataController)
local v5 = require(v1.Config.MultiplierData)
local v6 = require(v1.Utility.Multiplier)
local v_u_14 = {
	["Runes"] = {},
	["OnRuneUpdated"] = v3.new(),
	["get"] = function(p7, p8)
		return p7.Runes[p8] or 0
	end,
	["observe"] = function(p9, p_u_10, p_u_11)
		p_u_11(p9:get(p_u_10))
		return p9.OnRuneUpdated:Connect(function(p12, p13)
			-- upvalues: (copy) p_u_10, (copy) p_u_11
			if p12 == p_u_10 then
				p_u_11(p13)
			end
		end)
	end
}
for v_u_15, _ in v2 do
	v4:onSet({ "Runes", v_u_15 }, function(p16)
		-- upvalues: (copy) v_u_14, (copy) v_u_15
		v_u_14.Runes[v_u_15] = p16
		v_u_14.OnRuneUpdated:Fire(v_u_15, p16)
	end)
end
for v_u_17, v18 in v2 do
	for _, v_u_19 in v18.Buffs do
		local v_u_20 = v5[v_u_19.type]
		if v_u_20 then
			v6.assign(v_u_19.type, function(_)
				-- upvalues: (copy) v_u_14, (copy) v_u_17, (copy) v_u_19, (copy) v_u_20
				local v21 = v_u_14:get(v_u_17)
				if v21 <= 0 then
					return
				else
					local v22 = v21 * v_u_19.value
					local v23 = v_u_19.max or (1 / 0)
					local v24 = math.min(v22, v23)
					if v_u_20.RuneTransform then
						return v_u_20.RuneTransform(v24)
					else
						return v24 + 1
					end
				end
			end)
		end
	end
end
return v_u_14]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RuneController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3701"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.Observers)
local v3 = require(v1.Utility.Network)
local v_u_4 = require(v1.Utility.Sound)
local v_u_5 = require(v1.Utility.VFXUtil)
local v6 = {}
local v_u_7 = v3.remoteEvent("RuneOpenEvent")
local v_u_8 = {}
local v_u_9 = 0
local v_u_10 = nil
function v6.init(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_8, (copy) v_u_5, (copy) v_u_4, (ref) v_u_9, (ref) v_u_10, (copy) v_u_7
	v_u_2.observeTag("RuneButton", function(p11)
		-- upvalues: (ref) v_u_8, (ref) v_u_5, (ref) v_u_4, (ref) v_u_9, (ref) v_u_10
		if not v_u_8[p11.Name] then
			local v_u_12 = v_u_5.create("Rune")
			v_u_12.Parent = p11
			local v14 = {
				["play"] = function()
					-- upvalues: (ref) v_u_4, (ref) v_u_9, (ref) v_u_5, (copy) v_u_12, (ref) v_u_10
					v_u_4.play("RuneBuy", {
						["PlaybackSpeed"] = v_u_9 + 1
					})
					v_u_5.play(v_u_12)
					local v13 = v_u_9 + 0.005
					v_u_9 = math.min(v13, 0.5)
					if v_u_10 then
						task.cancel(v_u_10)
					end
					v_u_10 = task.delay(1, function()
						-- upvalues: (ref) v_u_9
						v_u_9 = 0
					end)
				end
			}
			v_u_8[p11.Name] = v14
		end
	end)
	v_u_7.listen(function(p15)
		-- upvalues: (ref) v_u_8
		local v16 = v_u_8[p15]
		if v16 then
			v16.play()
		end
	end)
end
return v6]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RuneOpenController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3702"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Skills]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3703"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Debris")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Client.Gameplay.Sllimes.SlimeSpawnerController)
local v4 = require(v2.Utility.Network)
local v_u_5 = require(v2.Utility.Sound)
local v_u_6 = require(v2.Utility.VFXUtil)
local v7 = {}
local v_u_8 = v4.remoteEvent("LightningEvent")
local v_u_9 = Random.new()
function v7.strike(_, p10, p11)
	-- upvalues: (copy) v_u_3, (copy) v_u_6, (copy) v_u_1, (copy) v_u_5, (copy) v_u_9
	for _, v12 in p10 do
		local v13 = v_u_3:get(v12)
		if v13 then
			if p11 then
				local v14 = v_u_6.create("LightningStrike")
				v14.CFrame = v13.model.PrimaryPart.CFrame
				v14.Parent = workspace
				v_u_1:AddItem(v14, v_u_6.play(v14))
			end
			local v15 = v_u_6.create("Lightning")
			v15.Parent = v13.model.PrimaryPart
			v_u_1:AddItem(v15, v_u_6.play(v15))
			v_u_5.play("ZapSlime", {
				["Parent"] = v13.model.PrimaryPart,
				["PlaybackSpeed"] = v_u_9:NextNumber(0.9, 1.1)
			})
		end
	end
end
function v7.init(p_u_16)
	-- upvalues: (copy) v_u_8
	v_u_8.listen(function(...)
		-- upvalues: (copy) p_u_16
		p_u_16:strike(...)
	end)
end
return v7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LightningSkillController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3704"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = require(v2.Enums.LockTypes)
local v_u_5 = require(v2.Enums.SettingTypes)
local v6 = require(v2.Client.Data.DataController)
local v7 = require(v2.Config.SkillData)
local v8 = require(v2.Packages.Signal)
local v9 = require(v2.Utility.Multiplier)
local v10 = require(v2.Utility.Network)
local v_u_11 = require(v2.Utility.Sound)
local v_u_12 = require(v2.Utility.VFXUtil)
local v_u_13 = require(v2.Packages.Sift)
local v14 = require(v2.Utility.LockUtil)
local v_u_15 = require(v2.Utility.SettingUtil)
local v_u_16 = {
	["Unlocked"] = {},
	["Upgrades"] = {},
	["Level"] = 0,
	["OnUnlocked"] = v8.new(),
	["OnUpgraded"] = v8.new(),
	["OnReset"] = v8.new()
}
local v17 = v10.remoteEvent("SkillLevelUpEvent", true)
function v_u_16.isUnlocked(p18, p19)
	return table.find(p18.Unlocked, p19) ~= nil
end
v6:onSet({ "Skills", "Level" }, function(p20)
	-- upvalues: (copy) v_u_16
	v_u_16.Level = p20
end)
for _, v21 in v6:getValue({ "Skills", "Unlocked" }) or {} do
	local v22 = v_u_16.Unlocked
	table.insert(v22, v21)
	v_u_16.OnUnlocked:Fire(v21)
end
for v23, v24 in v6:getValue({ "Skills", "Upgrades" }) or {} do
	v_u_16.Upgrades[v23] = v24
	v_u_16.OnUpgraded:Fire(v23, v24)
end
v6:onChange(function(_, p25, p26, _)
	-- upvalues: (copy) v_u_16, (copy) v_u_13
	if p25[1] == "Skills" then
		if p25[2] == "Unlocked" then
			if typeof(p26) == "table" then
				v_u_16.Unlocked = v_u_13.Dictionary.copyDeep(p26)
				for _, v27 in p26 do
					v_u_16.OnUnlocked:Fire(v27)
				end
				v_u_16.OnReset:Fire()
				return
			elseif not table.find(v_u_16.Unlocked, p26) then
				local v28 = v_u_16.Unlocked
				table.insert(v28, p26)
				v_u_16.OnUnlocked:Fire(p26)
			end
		else
			if p25[2] == "Upgrades" then
				if not p25[3] then
					v_u_16.Upgrades = p26
					for v29, v30 in p26 do
						v_u_16.OnUpgraded:Fire(v29, v30)
					end
					v_u_16.OnReset:Fire()
					return
				end
				v_u_16.Upgrades[p25[3]] = p26
				v_u_16.OnUpgraded:Fire(p25[3], p26)
			end
			return
		end
	else
		return
	end
end)
for _, v31 in v7 do
	for v_u_32, v33 in v31.Upgrades do
		for v_u_34, v35 in v33.Levels do
			for _, v_u_36 in v35.Multipliers do
				v9.assign(v_u_36.multiplier, function()
					-- upvalues: (copy) v_u_16, (copy) v_u_32, (copy) v_u_34, (copy) v_u_36
					local v37 = v_u_16.Upgrades[v_u_32] or 0
					if v37 ~= 0 then
						if v37 == v_u_34 then
							return v_u_36.amount
						end
					end
				end)
			end
		end
	end
end
local function v_u_54(p_u_38, p39)
	-- upvalues: (copy) v_u_3
	if p_u_38 and p_u_38:IsA("Beam") then
		local v_u_40 = {}
		local v_u_41 = p39 or 0.3
		for _, v42 in ipairs(p_u_38.Transparency.Keypoints) do
			local v43 = {
				["Time"] = v42.Time,
				["Value"] = v42.Value,
				["Envelope"] = v42.Envelope
			}
			table.insert(v_u_40, v43)
		end
		local v_u_44 = os.clock()
		local v_u_45 = nil
		v_u_45 = v_u_3.Heartbeat:Connect(function()
			-- upvalues: (copy) v_u_44, (ref) v_u_41, (copy) v_u_40, (copy) p_u_38, (ref) v_u_45
			local v46 = (os.clock() - v_u_44) / v_u_41
			local v47 = math.clamp(v46, 0, 1)
			local v48 = table.create(#v_u_40)
			for v49, v50 in ipairs(v_u_40) do
				local v51 = NumberSequenceKeypoint.new
				local v52 = v50.Time
				local v53 = v50.Value + v47
				v48[v49] = v51(v52, math.clamp(v53, 0, 1), v50.Envelope)
			end
			p_u_38.Transparency = NumberSequence.new(v48)
			if v47 >= 1 then
				p_u_38.Transparency = NumberSequence.new(1)
				p_u_38.Enabled = false
				v_u_45:Disconnect()
			end
		end)
	end
end
v17.listen(function(...)
	-- upvalues: (copy) v_u_11, (copy) v_u_15, (copy) v_u_5, (copy) v_u_1, (copy) v_u_12, (copy) v_u_54
	v_u_11.play("SkillLevelUp")
	if v_u_15.get(v_u_5.VFX) then
		local v55 = v_u_1.LocalPlayer.Character
		if v55 then
			local v56 = v55:FindFirstChild("HumanoidRootPart")
			if v56 then
				local v_u_57 = v_u_12.create("SkillLvlUp")
				v_u_57.CFrame = v56.CFrame
				v_u_57.Parent = v55
				local v58 = Instance.new("WeldConstraint")
				v58.Part0 = v56
				v58.Part1 = v_u_57
				v58.Parent = v_u_57
				v_u_12.play(v_u_57)
				task.spawn(function()
					-- upvalues: (copy) v_u_57, (ref) v_u_54
					task.wait(0.2)
					for _, v59 in v_u_57:GetDescendants() do
						if v59:IsA("ParticleEmitter") then
							v59.Enabled = true
						end
					end
					task.wait(0.8)
					for _, v60 in v_u_57:GetDescendants() do
						if v60:IsA("Beam") then
							v_u_54(v60, 4)
						end
					end
					task.wait(3)
					for _, v61 in v_u_57:GetDescendants() do
						if v61:IsA("ParticleEmitter") then
							v61.Enabled = false
						end
					end
					task.wait(1)
					v_u_57:Destroy()
				end)
			end
		else
			return
		end
	else
		return
	end
end)
v14.assign(v4.SkillLevel, function(p62, _)
	-- upvalues: (copy) v_u_16
	return v_u_16.Level >= p62.value, ("Requires Skill Level %*"):format(p62.value)
end)
return v_u_16]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SkillController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3705"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = require(v1.Client.Gameplay.Sllimes.SlimeSpawnerController)
local v4 = require(v1.Functions.WaitFor)
local v5 = require(v1.Utility.Network)
local v_u_6 = require(v1.Utility.Sound)
local v7 = {}
local v_u_8 = v5.remoteEvent("ArrowEvent")
local v_u_9 = v4(v1, "Assets", "Arrow")
local v_u_10 = Random.new()
function v7.fire(_, p11)
	-- upvalues: (copy) v_u_3, (copy) v_u_9, (copy) v_u_6, (copy) v_u_10, (copy) v_u_2
	for _, v12 in p11 do
		local v13 = v_u_3:get(v12)
		if v13 then
			local v_u_14 = v_u_9:Clone()
			v_u_14.Parent = workspace
			local v15 = v13.model.PrimaryPart.Position
			local v16 = v13.model:GetExtentsSize()
			v_u_6.play("ArrowFire", {
				["Parent"] = v_u_14,
				["PlaybackSpeed"] = v_u_10:NextNumber(0.9, 1.1)
			})
			local v17 = CFrame.Angles(0, 0, 3.141592653589793)
			local v18 = CFrame.new
			local v19 = v16.Y / 2 + 20
			v_u_14.CFrame = v18(v15 + Vector3.new(0, v19, 0)) * v17
			local v20 = v_u_2:Create(v_u_14, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
				["CFrame"] = CFrame.new(v15) * v17
			})
			task.delay(0.4, function()
				-- upvalues: (ref) v_u_6, (copy) v_u_14, (ref) v_u_10
				v_u_6.play("ArrowHit", {
					["Parent"] = v_u_14,
					["PlaybackSpeed"] = v_u_10:NextNumber(0.9, 1.1)
				})
			end)
			v20:Play()
			v20.Completed:Once(function()
				-- upvalues: (copy) v_u_14
				v_u_14:Destroy()
			end)
		end
	end
end
function v7.init(p_u_21)
	-- upvalues: (copy) v_u_8
	v_u_8.listen(function(...)
		-- upvalues: (copy) p_u_21
		p_u_21:fire(...)
	end)
end
return v7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ArrowSkillController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3706"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Debris")
local v2 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
require(v2.Client.Gameplay.Sllimes.SlimeSpawnerController)
local v3 = require(v2.Functions.WaitFor)
local v4 = require(v2.Utility.Network)
local v_u_5 = require(v2.Utility.Sound)
local v6 = {}
local v_u_7 = v4.remoteEvent("FreezeVFXEvent")
local v_u_8 = v3(v2, "Assets", "VFX", "Ice Winds")
local v_u_9 = v_u_8:GetExtentsSize()
local v_u_10 = Random.new()
function v6.fire(_, p11, _)
	for _, _ in p11 do

	end
end
function v6.init(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_8, (copy) v_u_9, (copy) v_u_5, (copy) v_u_10, (copy) v_u_1
	v_u_7.listen(function(p12)
		-- upvalues: (ref) v_u_8, (ref) v_u_9, (ref) v_u_5, (ref) v_u_10, (ref) v_u_1
		if p12 then
			if p12 then
				local v13 = v_u_8:Clone()
				local v14 = p12.CFrame
				local v15 = v_u_9.Y / 2
				v13:PivotTo(v14 + Vector3.new(0, v15, 0))
				v13.Parent = workspace
				local v16 = 3
				for _, v17 in v13:QueryDescendants("ParticleEmitter") do
					v17:Emit(v17:GetAttribute("EmitCount") or 50)
					local v18 = v17.Lifetime.Max
					v16 = math.max(v16, v18)
				end
				v_u_5.play("IceWind", {
					["Parent"] = v13,
					["PlaybackSpeed"] = v_u_10:NextNumber(0.9, 1.1)
				})
				v_u_1:AddItem(v13, v16)
			end
		end
	end)
end
return v6]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[IceWindSkillController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3707"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Utility.Network)
local v_u_3 = require(v1.Utility.Marketplace)
local v_u_4 = require(v1.Enums.Products)
local v_u_5 = require(v1.Utility.Notify)
local v6 = {}
local v_u_7 = v2.remoteFunction("SkillServiceReset")
function v6.requestReset(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_5, (copy) v_u_3, (copy) v_u_4
	local v8, v9 = v_u_7.invoke()
	if v8 then
		v_u_5.Notify({
			["Message"] = v9 or "Skills reset successfully!",
			["Type"] = v_u_5.Types.Success
		})
		return true
	else
		if v9 == "PROMPT_PURCHASE" then
			v_u_3.PromptProduct(v_u_4.ResetTickets[1])
			v_u_5.Notify({
				["Message"] = "You need a Skill Reset Ticket to reset your skills!",
				["Type"] = v_u_5.Types.Error
			})
		else
			v_u_5.Notify({
				["Message"] = v9 or "Failed to reset skills!",
				["Type"] = v_u_5.Types.Error
			})
		end
		return false
	end
end
function v6.init(_) end
return v6]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SkillResetController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3708"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Rebirth]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3709"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Currency.CurrencyController)
local v_u_3 = require(v1.Client.Data.Statistics.StatisticController)
local v_u_4 = require(v1.Config.Constants)
local v_u_5 = require(v1.Enums.CurrencyTypes)
local v_u_6 = require(v1.Enums.MultiplierTypes)
local v_u_7 = require(v1.Enums.StatisticTypes)
local v8 = require(v1.Functions.WaitFor)
local v_u_9 = require(v1.Packages.Observers)
local v_u_10 = require(v1.Utility.Format)
local v_u_11 = require(v1.Utility.Multiplier)
local v12 = require(v1.Utility.Network)
local v_u_13 = require(v1.Utility.Notify)
local v14 = {}
local v_u_15 = v12.remoteEvent("RebirthEvent")
local v_u_16 = v8(workspace, "Persistent", "Onboarding", "Rebirth")
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = false
local function v_u_23()
	local v22 = Instance.new("Beam")
	v22.Brightness = 2.1
	v22.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
	v22.Texture = "rbxassetid://86357734011375"
	v22.LightEmission = 0
	v22.LightInfluence = 0
	v22.TextureLength = 5
	v22.TextureMode = Enum.TextureMode.Static
	v22.TextureSpeed = -1
	v22.Transparency = NumberSequence.new(0, 1)
	v22.FaceCamera = true
	v22.Width0 = 3
	v22.Width1 = 3
	return v22
end
function v14.update(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_3, (copy) v_u_7, (ref) v_u_17, (ref) v_u_19, (ref) v_u_18, (ref) v_u_20, (ref) v_u_21, (copy) v_u_4, (copy) v_u_16, (copy) v_u_23, (copy) v_u_9, (copy) v_u_13
	local v24 = v_u_2:get(v_u_5.Coins)
	if v_u_3:get(v_u_7[("Total%*"):format(v_u_5.Rebirth)]) > 0 then
		if v_u_17 then
			v_u_17:Destroy()
			v_u_17 = nil
		end
		if v_u_19 then
			v_u_19:Destroy()
			v_u_19 = nil
		end
		if v_u_18 then
			v_u_18:Destroy()
			v_u_18 = nil
		end
		if v_u_20 then
			v_u_20()
			v_u_20 = nil
		end
		v_u_21 = false
	elseif v_u_4.REBIRTH_AMOUNT <= v24 then
		if not v_u_17 then
			v_u_17 = Instance.new("Attachment")
			v_u_17.Parent = v_u_16
			v_u_19 = v_u_23()
			v_u_19.Parent = v_u_16
			v_u_19.Attachment0 = v_u_17
			v_u_20 = v_u_9.observeCharacter(function(p25, p26)
				-- upvalues: (ref) v_u_18, (ref) v_u_19
				if p25 == game.Players.LocalPlayer then
					if v_u_18 then
						v_u_18:Destroy()
						v_u_18 = nil
					end
					local v27 = p26:WaitForChild("HumanoidRootPart")
					if v27 then
						v_u_18 = Instance.new("Attachment")
						v_u_18.Parent = v27
						v_u_19.Attachment1 = v_u_18
					end
				end
			end)
		end
		if not v_u_21 then
			v_u_21 = true
			v_u_13.Notify({
				["Message"] = "You can now Rebirth!",
				["Type"] = v_u_13.Types.Success,
				["Duration"] = 5
			})
			return
		end
	else
		if v_u_17 then
			v_u_17:Destroy()
			v_u_17 = nil
		end
		if v_u_19 then
			v_u_19:Destroy()
			v_u_19 = nil
		end
		if v_u_18 then
			v_u_18:Destroy()
			v_u_18 = nil
		end
		if v_u_20 then
			v_u_20()
			v_u_20 = nil
		end
		v_u_21 = false
	end
end
function v14.init(p_u_28)
	-- upvalues: (copy) v_u_9, (copy) v_u_15, (copy) v_u_2, (copy) v_u_5, (copy) v_u_4, (copy) v_u_11, (copy) v_u_6, (copy) v_u_10
	v_u_9.observeTag("RebirthUI", function(p29)
		-- upvalues: (ref) v_u_15, (ref) v_u_2, (ref) v_u_5, (ref) v_u_4, (ref) v_u_11, (ref) v_u_6, (ref) v_u_10
		p29:WaitForChild("Rebirth").Activated:Connect(function()
			-- upvalues: (ref) v_u_15
			v_u_15.fire()
		end)
		local v_u_30 = p29:WaitForChild("Value"):WaitForChild("Title")
		local function v32()
			-- upvalues: (ref) v_u_2, (ref) v_u_5, (ref) v_u_4, (ref) v_u_11, (ref) v_u_6, (copy) v_u_30, (ref) v_u_10
			local v31 = v_u_2:get(v_u_5.Coins) // v_u_4.REBIRTH_AMOUNT * v_u_11.get(v_u_6.RebirthMultiplier)
			v_u_30.Text = v_u_10.abbreviateComma((math.floor(v31)))
		end
		v_u_11.observe(v_u_6.RebirthMultiplier, v32)
		v_u_2:observe(v_u_5.Coins, v32)
	end)
	v_u_2:observe(v_u_5.Coins, function(_)
		-- upvalues: (copy) p_u_28
		p_u_28:update()
	end)
end
return v14]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RebirthController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3710"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Currency.CurrencyController)
local v_u_3 = require(v1.Config.CurrencyData)
local v_u_4 = require(v1.Config.MultiplierData)
local v_u_5 = require(v1.Config.SuperRebirthData)
local v_u_6 = require(v1.Enums.CurrencyTypes)
local v_u_7 = require(v1.Packages.Sift)
local v_u_8 = require(v1.Utility.Format)
local v_u_9 = require(v1.Utility.PerkUtil)
return {
	["init"] = function(_)
		-- upvalues: (copy) v_u_7, (copy) v_u_5, (copy) v_u_2, (copy) v_u_6, (copy) v_u_9, (copy) v_u_4, (copy) v_u_3, (copy) v_u_8
		local v_u_11 = v_u_7.Array.filter(v_u_5.Benefits, function(p10)
			return p10.Get ~= nil
		end)
		v_u_2:observe(v_u_6.SuperRebirth, function(p12)
			-- upvalues: (ref) v_u_9, (copy) v_u_11, (ref) v_u_4, (ref) v_u_3, (ref) v_u_6, (ref) v_u_8
			if p12 <= 0 then
				v_u_9:remove("superrb")
			else
				local v13 = {}
				for _, v14 in v_u_11 do
					local v15 = v_u_4[v14.MultiplierType]
					local v16 = ("%* %*"):format(v14:Format(v14:Calculate(p12)), v15.Name)
					table.insert(v13, v16)
				end
				local v17 = v_u_9
				local v18 = {
					["Text"] = "",
					["Icon"] = v_u_3[v_u_6.SuperRebirth].Icon,
					["Tooltip"] = {
						["Title"] = ("Super Rebirths %*"):format((v_u_8.roman((math.min(100, p12))))),
						["Description"] = table.concat(v13, "\n")
					}
				}
				v17:update("superrb", v18)
			end
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SuperRebirthController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3711"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Mastery]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3712"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Config.MasteryData)
local v4 = require(v1.Packages.Signal)
local v_u_5 = require(v1.Utility.Multiplier)
local v_u_15 = {
	["Mastery"] = {},
	["MasteryUpdated"] = v4.new(),
	["getTier"] = function(p6, _, p7)
		return p6.Mastery[p7] and p6.Mastery[p7].tier or 0
	end,
	["init"] = function(p_u_8)
		-- upvalues: (copy) v_u_3, (copy) v_u_5
		for v_u_9, v10 in v_u_3 do
			for v_u_11, v12 in v10.Tiers do
				for _, v_u_13 in v12.Buffs do
					v_u_5.assign(v_u_13.multiplier, function(p14)
						-- upvalues: (copy) p_u_8, (copy) v_u_9, (copy) v_u_11, (copy) v_u_13
						if p_u_8:getTier(p14, v_u_9) == v_u_11 then
							return v_u_13.value
						end
					end)
				end
			end
		end
	end
}
for v16, v17 in v2:getValue({ "Mastery" }) or {} do
	v_u_15.Mastery[v16] = v17
end
v2:onChange(function(_, p18, p19, _)
	-- upvalues: (copy) v_u_15
	if p18[1] == "Mastery" then
		local v20 = p18[2]
		local v21 = p18[3]
		if not v21 then
			return
		end
		v_u_15.Mastery[v20][v21] = p19
		v_u_15.MasteryUpdated:Fire(v20)
	end
end)
return v_u_15]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MasteryController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3713"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[World]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3714"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Config.CurrencyData)
local v_u_4 = require(v1.Config.WorldData)
local v_u_5 = require(v1.Enums.LockTypes)
local v_u_6 = require(v1.Packages.Observers)
local v_u_7 = require(v1.Packages.Sift)
local v_u_8 = require(v1.Utility.Format)
local v_u_9 = require(v1.Utility.LockUtil)
local v10 = require(v1.Utility.Network)
local v_u_11 = require(v1.Utility.Notify)
local v12 = {}
local v_u_13 = {}
local v_u_14 = {}
local v_u_15 = v10.remoteFunction("WorldServicePurchase")
local v_u_16 = v10.remoteEvent("TeleportEvent")
function v12.unlock(_, p17)
	-- upvalues: (ref) v_u_14, (copy) v_u_13
	if not table.find(v_u_14, p17) then
		local v18 = v_u_14
		table.insert(v18, p17)
		local v19 = v_u_13[p17]
		if v19 then
			for _, v20 in v19 do
				v20.unlock()
			end
		end
	end
end
function v12.has(_, p21)
	-- upvalues: (copy) v_u_4, (ref) v_u_14
	local v22 = v_u_4[p21]
	if v22 then
		return v22.Unlocked and true or table.find(v_u_14, p21) ~= nil
	else
		return false
	end
end
function v12.setup(p23, p_u_24)
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_8, (copy) v_u_13, (copy) v_u_16, (copy) v_u_15, (copy) v_u_11
	local v_u_25 = p_u_24:WaitForChild("BillboardGui")
	local v_u_26 = p_u_24:WaitForChild("Glow")
	local v27 = v_u_4[p_u_24.Name]
	if v27 then
		if not v27.Purchase then
			v_u_25.Currency.Visible = false
			v_u_25.World.Text = v27.Name
		end
		v_u_25.World.Text = v27.Name
		local v28 = v27.Purchase
		if v28 then
			v28 = v27.Purchase.Currency
		end
		local v29 = v28 and v_u_3[v28.Type]
		if v29 then
			v_u_25.Currency.Text = ("%* %*"):format(v_u_8.abbreviateComma(v28.Amount), (v29.GetPrefix(v28.Amount)))
		end
		local v_u_30 = p_u_24.Glow.Color
		local v_u_31 = nil
		local v_u_32 = Instance.new("ProximityPrompt")
		v_u_32.RequiresLineOfSight = false
		v_u_32.ActionText = "Purchase"
		v_u_32.Parent = p_u_24.Attachment
		v_u_32.Triggered:Connect(function()
			-- upvalues: (ref) v_u_31
			if v_u_31 then
				v_u_31()
			end
		end)
		if not v_u_13[p_u_24.Name] then
			v_u_13[p_u_24.Name] = {}
		end
		local v35 = {
			["unlock"] = function()
				-- upvalues: (copy) v_u_25, (copy) v_u_26, (copy) v_u_30, (copy) v_u_32, (ref) v_u_31, (ref) v_u_16, (copy) p_u_24
				v_u_25.Currency.Visible = false
				v_u_25.ImageLabel.Visible = false
				v_u_26.Color = v_u_30
				v_u_26.Pixelate.Enabled = true
				v_u_26.PointLight.Enabled = true
				v_u_32.ActionText = "Teleport"
				v_u_31 = function()
					-- upvalues: (ref) v_u_16, (ref) p_u_24
					v_u_16.fire(p_u_24.Name)
				end
			end,
			["lock"] = function()
				-- upvalues: (copy) v_u_26, (copy) v_u_25, (copy) v_u_32, (ref) v_u_31, (ref) v_u_15, (copy) p_u_24, (ref) v_u_11
				v_u_26.Pixelate.Enabled = false
				v_u_26.PointLight.Enabled = false
				v_u_26.Color = Color3.new(0.431373, 0.431373, 0.431373)
				v_u_25.ImageLabel.Visible = true
				v_u_25.Currency.Visible = true
				v_u_32.ActionText = "Purchase"
				v_u_31 = function()
					-- upvalues: (ref) v_u_15, (ref) p_u_24, (ref) v_u_11
					local v33, v34 = v_u_15.invoke(p_u_24.Name)
					v_u_11.Notify({
						["Message"] = v34,
						["Type"] = v33 and v_u_11.Types.Success or v_u_11.Types.Error
					})
				end
			end
		}
		local v36 = v_u_13[p_u_24.Name]
		table.insert(v36, v35)
		if p23:has(p_u_24.Name) then
			v35.unlock()
		else
			v35.lock()
		end
	else
		v_u_25.World.Text = "Coming Soon!"
		v_u_25.Currency.Visible = false
	end
end
function v12.init(p_u_37)
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_13, (copy) v_u_4, (ref) v_u_14, (copy) v_u_7, (copy) v_u_9, (copy) v_u_5
	v_u_6.observeTag("Portal", function(p38)
		-- upvalues: (copy) p_u_37
		p_u_37:setup(p38)
	end)
	for _, v39 in v_u_2:getValue({ "Worlds" }) or {} do
		p_u_37:unlock(v39)
	end
	v_u_2:onChange(function(p40, p41, p42, _)
		-- upvalues: (copy) p_u_37, (ref) v_u_13, (ref) v_u_4, (ref) v_u_14, (ref) v_u_7
		if p41[1] == "Worlds" then
			if p40 == "TableInsert" then
				p_u_37:unlock(p42)
				return
			end
			for v43, v44 in v_u_13 do
				local v45 = v_u_4[v43]
				if v45 and not (v45.Unlocked or table.find(p42, v43)) then
					for _, v46 in v44 do
						v46.lock()
					end
				end
			end
			v_u_14 = v_u_7.Array.copy(p42 or {})
		end
	end)
	v_u_9.assign(v_u_5.World, function(p47)
		-- upvalues: (copy) p_u_37
		return p_u_37:has(p47.value), "You don\'t have access to this world."
	end)
end
return v12]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WorldController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3715"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Potion]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3716"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Signal)
local v3 = require(v1.Utility.Network)
local v4 = require(v1.Client.Data.DataController)
local v5 = require(v1.Config.PotionData)
local v6 = require(v1.Utility.Multiplier)
local v_u_7 = {
	["Storage"] = {},
	["Active"] = {},
	["OnPotionUpdated"] = v2.new(),
	["OnPotionTimeUpdated"] = v2.new()
}
local v_u_8 = v3.remoteEvent("PotionUseEvent")
function v_u_7.use(_, p9, p10)
	-- upvalues: (copy) v_u_8
	v_u_8.fire(p9, p10)
end
function v_u_7.getStorage(p11, p12)
	return p11.Storage[p12] or 0
end
function v_u_7.observeStorage(p13, p_u_14, p_u_15)
	p_u_15(p13:getStorage(p_u_14))
	return p13.OnPotionUpdated:Connect(function(p16, p17)
		-- upvalues: (copy) p_u_14, (copy) p_u_15
		if p16 == p_u_14 then
			p_u_15(p17)
		end
	end)
end
function v_u_7.getActiveTime(p18, p19)
	return p18.Active[p19] or 0
end
function v_u_7.observeActiveTime(p20, p_u_21, p_u_22)
	p_u_22(p20:getActiveTime(p_u_21))
	return p20.OnPotionTimeUpdated:Connect(function(p23, p24)
		-- upvalues: (copy) p_u_21, (copy) p_u_22
		if p23 == p_u_21 then
			p_u_22(p24)
		end
	end)
end
for v_u_25, v_u_26 in v5 do
	if v_u_26.Multiplier then
		v6.assign(v_u_26.Multiplier, function(_)
			-- upvalues: (copy) v_u_7, (copy) v_u_25, (copy) v_u_26
			if v_u_7:getActiveTime(v_u_25) > 0 then
				return v_u_26.MultiplierValue
			end
		end)
	end
end
for v27, v28 in v4:getValue({ "Potions" }) or {} do
	v_u_7.Storage[v27] = v28
	v_u_7.OnPotionUpdated:Fire(v27, v28)
end
for v29, v30 in v4:getValue({ "PotionsActive" }) or {} do
	v_u_7.Active[v29] = v30
	v_u_7.OnPotionTimeUpdated:Fire(v29, v30)
end
v4:onChange(function(_, p31, p32, _)
	-- upvalues: (copy) v_u_7
	local v33 = p31[2]
	if p31[1] == "Potions" then
		v_u_7.Storage[v33] = p32
		v_u_7.OnPotionUpdated:Fire(v33, p32)
	end
	if p31[1] == "PotionsActive" then
		v_u_7.Active[v33] = p32
		v_u_7.OnPotionTimeUpdated:Fire(v33, p32)
	end
end)
return v_u_7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PotionController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3717"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.PotionData)
local v_u_3 = require(v1.Config.WorldData)
local v_u_4 = require(v1.Utility.PerkUtil)
local v_u_5 = require(v1.Utility.Time)
local v_u_6 = require(v1.Utility.WorldUtil)
local v_u_7 = require(script.Parent.PotionController)
return {
	["isPaused"] = function(_)
		-- upvalues: (copy) v_u_6, (copy) v_u_3
		local v8 = v_u_6.get()
		if v8 then
			local v9 = v_u_3[v8]
			if v9 then
				return v9.PausePotions and true or false
			else
				return false
			end
		else
			return false
		end
	end,
	["init"] = function(p_u_10)
		-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_7, (copy) v_u_4, (copy) v_u_5
		local v_u_11 = false
		v_u_6.observe(function(_)
			-- upvalues: (ref) v_u_11, (copy) p_u_10, (ref) v_u_2, (ref) v_u_7, (ref) v_u_4
			v_u_11 = p_u_10:isPaused()
			if v_u_11 then
				for v12, v13 in v_u_2 do
					if v_u_7:getActiveTime(v12) > 0 then
						local v14 = v_u_4
						local v15 = ("potion_%*"):format(v12)
						local v16 = {
							["Text"] = "Paused",
							["Icon"] = v13.Icon,
							["Tooltip"] = {
								["Title"] = v13.Name,
								["Description"] = ("%* \n(Paused)"):format(v13.Description)
							}
						}
						v14:update(v15, v16)
					end
				end
			end
		end)
		local v_u_17 = v_u_11
		for v_u_18, v_u_19 in v_u_2 do
			v_u_7:observeActiveTime(v_u_18, function(p20)
				-- upvalues: (ref) v_u_4, (copy) v_u_18, (ref) v_u_17, (ref) v_u_5, (copy) v_u_19
				if p20 and p20 > 0 then
					v_u_4:update(("potion_%*"):format(v_u_18), {
						["Text"] = ("%*"):format(v_u_17 and "Paused" or v_u_5.format(p20)),
						["Icon"] = v_u_19.Icon,
						["Tooltip"] = {
							["Title"] = v_u_19.Name,
							["Description"] = ("%* \n(%*)"):format(v_u_19.Description, (v_u_5.format(p20)))
						}
					})
				else
					v_u_4:remove((("potion_%*"):format(v_u_18)))
				end
			end)
		end
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PotionUIController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3718"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Index]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3719"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Client.Data.DataController)
local v3 = require(v1.Config.IndexRewardData)
local v_u_4 = require(v1.Packages.Sift)
local v5 = require(v1.Packages.Signal)
local v6 = require(v1.Utility.Multiplier)
local v_u_7 = {
	["Updated"] = v5.new()
}
local v_u_8 = {}
function v_u_7.has(_, p9, p10, p11)
	-- upvalues: (copy) v_u_8
	if v_u_8[p9] then
		if v_u_8[p9][p10] then
			return not p11 and true or v_u_8[p9][p10][p11] ~= nil
		else
			return false
		end
	else
		return false
	end
end
function v_u_7.get(_, p12, p13, p14)
	-- upvalues: (copy) v_u_8
	if v_u_8[p12] then
		if p13 then
			if v_u_8[p12][p13] then
				if p14 then
					return v_u_8[p12][p13][p14]
				else
					return v_u_8[p12][p13]
				end
			else
				return nil
			end
		else
			return v_u_8[p12]
		end
	else
		return nil
	end
end
function v_u_7.observe(p_u_15, p_u_16, p_u_17, p_u_18, p_u_19)
	p_u_19(p_u_15:has(p_u_16, p_u_17, p_u_18))
	return p_u_15.Updated:Connect(function(...)
		-- upvalues: (copy) p_u_19, (copy) p_u_15, (copy) p_u_16, (copy) p_u_17, (copy) p_u_18
		p_u_19(p_u_15:has(p_u_16, p_u_17, p_u_18))
	end)
end
function v_u_7.getTotal(_, p20)
	-- upvalues: (copy) v_u_4, (copy) v_u_8
	return v_u_4.Dictionary.count(v_u_8[p20] or {})
end
for v_u_21, v_u_22 in v3 do
	for _, v_u_23 in v_u_22.BuffInfo.Buffs do
		v6.assign(v_u_23.type, function(_)
			-- upvalues: (copy) v_u_7, (copy) v_u_21, (copy) v_u_22, (copy) v_u_23
			local v24 = v_u_7:getTotal(v_u_21) / v_u_22.BuffInfo.Every
			local v25 = math.floor(v24)
			if v25 > 0 then
				return 1 + v_u_23.value * v25
			end
		end)
	end
end
for v26, v27 in v2:getValue({ "Index" }) or {} do
	v_u_8[v26] = {}
	for v28, v29 in v27 do
		v_u_8[v26][v28] = v29
	end
end
v_u_7.Updated:Fire()
v2:onChange(function(_, p30, p31, _)
	-- upvalues: (copy) v_u_8, (copy) v_u_7
	if p30[1] == "Index" then
		local v32 = p30[2]
		local v33 = p30[3]
		local v34 = p30[4]
		v_u_8[v32] = v_u_8[v32] or {}
		if v34 then
			v_u_8[v32][v33] = v_u_8[v32][v33] or {}
			v_u_8[v32][v33][v34] = p31
		else
			v_u_8[v32][v33] = p31
		end
		v_u_7.Updated:Fire()
	end
end)
return v_u_7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[IndexController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3720"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LuckyBlock]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3721"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = require(v1.Client.Data.DataController)
local v_u_4 = require(v1.Config.LuckyBlockData)
local v_u_5 = require(v1.Enums.Products)
local v_u_6 = require(v1.Packages.Observers)
local v_u_7 = require(v1.Utility.Marketplace)
local v_u_8 = require(v1.Utility.Multiplier)
local v9 = require(v1.Utility.Network)
local v_u_10 = require(v1.Utility.Notify)
local v_u_11 = require(v1.Utility.PerkUtil)
local v_u_12 = require(v1.Utility.Sound)
local v_u_13 = require(v1.Utility.Time)
local v14 = {}
local v_u_15 = {}
local v_u_16 = {}
local v_u_17 = v9.remoteFunction("ClaimLuckyBlock")
function v14.updateBillboards(_)
	-- upvalues: (copy) v_u_3, (copy) v_u_10, (copy) v_u_15, (copy) v_u_13
	local v18 = v_u_3:getValue({ "LuckyBlock", "Timer" }) or 99999
	if v18 <= 0 then
		v_u_10.Notify({
			["Message"] = "Lucky block ready to claim!",
			["Type"] = v_u_10.Types.Gift,
			["Duration"] = 8
		})
	end
	for _, v19 in v_u_15 do
		v19.TimerText.Text = v18 > 0 and (v_u_13.format(v18) or "Ready!") or "Ready!"
	end
end
function v14.setup(p20, p_u_21)
	-- upvalues: (copy) v_u_15, (copy) v_u_17, (copy) v_u_10, (copy) v_u_12, (copy) v_u_7, (copy) v_u_5, (copy) v_u_2, (copy) v_u_4
	local v22 = p_u_21:WaitForChild("BillboardGui"):WaitForChild("Frame")
	local v23 = v22:WaitForChild("Timer")
	local v_u_24 = v22:WaitForChild("Container"):WaitForChild("Template")
	local v25 = v_u_15
	table.insert(v25, {
		["Instance"] = p_u_21,
		["TimerText"] = v23
	})
	local v26 = Instance.new("ProximityPrompt")
	v26.ActionText = "Claim"
	v26.ObjectText = "Lucky Block"
	v26.HoldDuration = 0
	v26.RequiresLineOfSight = false
	v26.Parent = p_u_21
	v26.Triggered:Connect(function()
		-- upvalues: (ref) v_u_17, (ref) v_u_10, (ref) v_u_12, (ref) v_u_7, (ref) v_u_5, (copy) p_u_21, (ref) v_u_2
		local v27, v28 = v_u_17.invoke()
		v_u_10.Notify({
			["Message"] = v28,
			["Type"] = v27 and v_u_10.Types.Success or v_u_10.Types.Error
		})
		if v27 then
			v_u_12.play("LuckyBlock")
		else
			v_u_7.PromptProduct(v_u_5.SkipLuckyBlockTimer)
		end
		p_u_21.Highlight.FillColor = v27 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 0, 0)
		v_u_2:Create(p_u_21.Highlight, TweenInfo.new(0.5), {
			["FillTransparency"] = 0
		}):Play()
		task.delay(0.2, function()
			-- upvalues: (ref) v_u_2, (ref) p_u_21
			v_u_2:Create(p_u_21.Highlight, TweenInfo.new(0.5), {
				["FillTransparency"] = 1
			}):Play()
		end)
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_4, (copy) v_u_24
		while true do
			for _, v29 in v_u_4 do
				v_u_24.Icon.Image = v29.Icon
				v_u_24.Amount.Text = v29.Perk
				task.wait(1)
			end
			task.wait(1)
		end
	end)
	p20:updateBillboards()
end
function v14.init(p_u_30)
	-- upvalues: (copy) v_u_6, (copy) v_u_3, (copy) v_u_4, (copy) v_u_16, (copy) v_u_11, (copy) v_u_13, (copy) v_u_8
	v_u_6.observeTag("LuckyBlock", function(p31)
		-- upvalues: (copy) p_u_30
		p_u_30:setup(p31)
	end)
	v_u_3:onSet({ "LuckyBlock", "Timer" }, function(_)
		-- upvalues: (copy) p_u_30
		p_u_30:updateBillboards()
	end)
	v_u_3:onChange(function(_, p32, p33, _)
		-- upvalues: (ref) v_u_4, (ref) v_u_16, (ref) v_u_11, (ref) v_u_13
		if p32[1] == "LuckyBlock" then
			if p32[2] == "Buffs" then
				local v34 = p32[3]
				local v35 = v_u_4[v34]
				if p33 ~= nil then
					v_u_16[v34] = p33
					local v36 = v_u_11
					local v37 = ("lucky-block-%*"):format(v34)
					local v38 = {
						["Icon"] = v35.Icon,
						["Text"] = v_u_13.format(p33),
						["Tooltip"] = {
							["Title"] = "Lucky Block Boost!",
							["Description"] = ("Remaining: %*"):format((v_u_13.formatFull(p33)))
						}
					}
					v36:update(v37, v38)
					return
				end
				v_u_16[v34] = nil
				v_u_11:remove((("lucky-block-%*"):format(v34)))
			end
		end
	end)
	for v_u_39, v40 in v_u_4 do
		for _, v_u_41 in v40.Multipliers do
			v_u_8.assign(v_u_41.multiplier, function(_)
				-- upvalues: (ref) v_u_16, (copy) v_u_39, (copy) v_u_41
				if v_u_16[v_u_39] then
					return v_u_41.amount
				end
			end)
		end
	end
end
return v14]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LuckyBlockController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3722"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Ice World]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3723"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("TweenService")
local v5 = require(script.Parent.IceBossClass)
local v_u_6 = require(v_u_2.Client.Data.DataController)
local v_u_7 = require(v_u_2.Client.Gameplay.Sound.SoundController)
local v_u_8 = require(v_u_2.Enums.MultiplierTypes)
local v9 = require(v_u_2.Functions.WaitFor)
local v10 = require(v_u_2.Packages.Janitor)
local v_u_11 = require(v_u_2.Packages.Observers)
local v_u_12 = require(v_u_2.Utility.Format)
local v_u_13 = require(v_u_2.Utility.IceBossUtil)
local v_u_14 = require(v_u_2.Utility.Multiplier)
local v15 = require(v_u_2.Utility.Network)
local v_u_16 = require(v_u_2.Utility.Notify)
local v_u_17 = require(v_u_2.Utility.Spring)
local v_u_18 = require(v_u_2.Utility.Time)
local v_u_19 = require(v_u_2.Utility.UI)
local v_u_20 = require(v_u_2.Utility.ZoneUtil)
local v21 = {}
local v22 = v9(workspace, "Persistent", "ICE_WORLD_BOSS")
local v_u_23 = v9(v22, "Attachment", "BillboardGui", "Description")
local v_u_24 = v9(v22, "IceBossOverhead")
local v_u_25 = v9(v_u_2, "Assets", "RangePart"):Clone()
local v_u_26 = v_u_25:WaitForChild("SurfaceGui"):WaitForChild("Frame"):WaitForChild("UIScale")
v_u_25.Parent = v_u_2
local v_u_27 = {
	["Spawned"] = v15.remoteEvent("IceBossService/Spawn"),
	["Damage"] = v15.remoteEvent("IceBossService/Damage"),
	["Died"] = v15.remoteEvent("IceBossService/Died"),
	["Defeated"] = v15.remoteEvent("IceBossService/Defeated"),
	["Attack"] = v15.remoteEvent("IceBossService/Attack"),
	["Move"] = v15.remoteEvent("IceBossService/Move"),
	["Color"] = v15.remoteEvent("IceBossService/Color")
}
local v_u_28 = false
local v_u_29 = v10.new()
local v_u_30 = true
local v_u_31 = v5.new()
v_u_31:hide()
local v_u_32 = true
function v21.updateRange(_)
	-- upvalues: (copy) v_u_17, (copy) v_u_25
	local v33 = v_u_17.target
	local v34 = v_u_25
	local v35 = {}
	local v36 = v_u_25.Size.X
	v35.Size = Vector3.new(v36, 32, 32)
	v33(v34, 1, 2, v35)
end
function v21.enter(_)
	-- upvalues: (ref) v_u_30, (ref) v_u_32, (copy) v_u_31, (copy) v_u_19, (copy) v_u_7, (copy) v_u_29, (ref) v_u_28, (copy) v_u_17, (copy) v_u_25, (copy) v_u_3, (copy) v_u_1, (copy) v_u_27
	if not v_u_30 then
		if v_u_32 then
			v_u_31:show()
		else
			v_u_32 = true
			v_u_31:show():spawn()
		end
		v_u_19:AddToDefault("Hearts")
		v_u_7:playMusic("BOSS")
		v_u_29:Cleanup()
		v_u_28 = true
		v_u_17.stop(v_u_25)
		v_u_25.Parent = workspace
		local v37 = v_u_25
		local v38 = v_u_25.Size.X
		v37.Size = Vector3.new(v38, 0, 0)
		local v39 = v_u_17.target
		local v40 = v_u_25
		local v41 = {}
		local v42 = v_u_25.Size.X
		v41.Size = Vector3.new(v42, 32, 32)
		v39(v40, 0.7, 5, v41)
		v_u_29:Add(v_u_3.Heartbeat:Connect(function()
			-- upvalues: (ref) v_u_1, (ref) v_u_25
			local v43 = v_u_1.LocalPlayer.Character
			if v43 then
				local v44 = v43:GetPivot()
				local v45 = v_u_25
				local v46 = v44.Position.X
				local v47 = v44.Position.Z
				v45.Position = Vector3.new(v46, 8.141, v47)
			end
		end))
		v_u_29:Add(task.spawn(function()
			-- upvalues: (ref) v_u_27
			while true do
				v_u_27.Attack.fire()
				task.wait(0.1)
			end
		end))
	end
end
function v21.leave(_)
	-- upvalues: (ref) v_u_28, (copy) v_u_7, (copy) v_u_19, (copy) v_u_17, (copy) v_u_25, (copy) v_u_2, (copy) v_u_29
	v_u_28 = false
	v_u_7:stopMusic()
	v_u_19:removeFromDefault("Hearts")
	local v48 = v_u_17.target
	local v49 = v_u_25
	local v50 = {}
	local v51 = v_u_25.Size.X
	v50.Size = Vector3.new(v51)
	v48(v49, 1, 5, v50)
	task.delay(0.5, function()
		-- upvalues: (ref) v_u_28, (ref) v_u_25, (ref) v_u_2, (ref) v_u_29
		if not v_u_28 then
			v_u_25.Parent = v_u_2
			v_u_29:Cleanup()
		end
	end)
end
function v21.init(p_u_52)
	-- upvalues: (copy) v_u_20, (copy) v_u_27, (ref) v_u_28, (copy) v_u_31, (ref) v_u_32, (copy) v_u_6, (copy) v_u_24, (copy) v_u_12, (ref) v_u_30, (copy) v_u_13, (copy) v_u_23, (copy) v_u_14, (copy) v_u_8, (copy) v_u_18, (copy) v_u_16, (copy) v_u_11, (copy) v_u_1, (copy) v_u_26, (copy) v_u_4
	v_u_20.observe("ICE_BOSS_ZONE", function()
		-- upvalues: (copy) p_u_52
		p_u_52:enter()
		return function()
			-- upvalues: (ref) p_u_52
			p_u_52:leave()
		end
	end)
	v_u_27.Spawned.listen(function(...)
		-- upvalues: (ref) v_u_28, (ref) v_u_31, (ref) v_u_32
		if v_u_28 then
			v_u_31:show():spawn()
		else
			v_u_32 = false
		end
	end)
	v_u_6:onSet({ "IceBoss", "Level" }, function(p53)
		-- upvalues: (ref) v_u_24, (ref) v_u_12
		v_u_24.Title.Text = ("ICE SLIME BOSS (Lvl %*)"):format((v_u_12.comma(p53)))
	end)
	v_u_6:onSet({ "IceBoss", "Health" }, function(p54)
		-- upvalues: (ref) v_u_30, (ref) v_u_24, (ref) v_u_28, (ref) v_u_20, (copy) p_u_52, (ref) v_u_13, (ref) v_u_6, (ref) v_u_12
		v_u_30 = p54 <= 0
		v_u_24.Enabled = p54 > 0
		if not v_u_28 and (not v_u_30 and v_u_20.isInZone("ICE_BOSS_ZONE")) then
			p_u_52:enter()
		end
		local v55 = v_u_13.getMaxHealth(v_u_6:getValue({ "IceBoss", "Level" }) or 1)
		v_u_24.HP.UIGradient.Offset = Vector2.new(p54 / v55, 0)
		v_u_24.HP.Title.Text = ("%* / %*"):format(v_u_12.abbreviateComma(p54), (v_u_12.abbreviateComma(v55)))
	end)
	v_u_27.Damage.listen(function(p56)
		-- upvalues: (ref) v_u_31
		v_u_31:attack(p56)
	end)
	v_u_27.Defeated.listen(function(...)
		-- upvalues: (ref) v_u_31
		v_u_31:defeated():hide()
	end)
	local v_u_57 = nil
	local v_u_58 = false
	v_u_6:onSet({ "IceBoss", "Cooldown" }, function(p_u_59)
		-- upvalues: (ref) v_u_57, (ref) v_u_23, (ref) v_u_58, (ref) v_u_14, (ref) v_u_8, (ref) v_u_18, (ref) v_u_16
		if v_u_57 then
			task.cancel(v_u_57)
			v_u_57 = nil
		end
		v_u_23.Visible = p_u_59 ~= nil
		v_u_58 = false
		if p_u_59 then
			v_u_57 = task.spawn(function()
				-- upvalues: (copy) p_u_59, (ref) v_u_14, (ref) v_u_8, (ref) v_u_23, (ref) v_u_18, (ref) v_u_58, (ref) v_u_16
				while true do
					local v60 = workspace:GetServerTimeNow() - p_u_59
					local v61 = v_u_14.get(v_u_8.IceBossCooldown) * v_u_14.get(v_u_8.IceBossCooldownPercentage) - v60
					v_u_23.Text = ("Ice Boss: Respawns in %*"):format((v_u_18.format(v61)))
					if v61 <= 1 and not v_u_58 then
						v_u_16.Notify({
							["Message"] = "Ice boss has respawned!",
							["Type"] = v_u_16.Types.Success,
							["Duration"] = 5
						})
						v_u_58 = true
					end
					task.wait(1)
				end
			end)
		end
	end)
	v_u_11.observeAttribute(v_u_1.LocalPlayer, "ice_boss_attack", function(p62)
		-- upvalues: (ref) v_u_26, (ref) v_u_4
		local v63 = p62 - workspace:GetServerTimeNow()
		v_u_26.Scale = 0
		v_u_4:Create(v_u_26, TweenInfo.new(v63, Enum.EasingStyle.Linear), {
			["Scale"] = 1
		}):Play()
	end)
	v_u_27.Move.listen(function(p64, p65)
		-- upvalues: (ref) v_u_31
		if v_u_31[p64] then
			v_u_31[p64](v_u_31, p65)
		end
	end)
	v_u_27.Color.listen(function(p66)
		-- upvalues: (ref) v_u_31
		v_u_31:changeColor(p66)
	end)
	v_u_27.Died.listen(function() end)
end
return v21]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[IceBossController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3724"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Debris")
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("TweenService")
local v6 = require(v_u_3.Client.Settings.SettingsController)
local v7 = require(v_u_3.Enums.SettingTypes)
local v8 = require(v_u_3.Functions.WaitFor)
local v9 = require(v_u_3.Packages.Camerashaker)
local v_u_10 = require(v_u_3.Packages.Throttle)
local v_u_11 = require(v_u_3.Utility.IceBossUtil)
local v_u_12 = require(v_u_3.Utility.Sound)
local v_u_13 = require(v_u_3.Utility.Spring)
local v_u_14 = require(v_u_3.Utility.VFXUtil)
local v_u_15 = {}
v_u_15.__index = v_u_15
local v_u_16 = v8(v8(v_u_3, "Assets"), "Slimes", "IceBossSlime")
local v_u_17 = v8(workspace, "Persistent", "ICE_WORLD_BOSS")
local v_u_18 = Random.new()
local v_u_19 = workspace.CurrentCamera
local v_u_20 = false
local v_u_22 = v9.new(Enum.RenderPriority.Camera.Value + 1, function(p21)
	-- upvalues: (ref) v_u_20, (copy) v_u_19
	if not v_u_20 then
		v_u_19.CFrame = v_u_19.CFrame * p21
	end
end)
v_u_22:Start()
v6:observe(v7.CameraShakes, function(p23)
	-- upvalues: (ref) v_u_20
	v_u_20 = not p23
end)
function v_u_15.new()
	-- upvalues: (copy) v_u_15, (copy) v_u_16, (copy) v_u_17, (copy) v_u_14
	local v24 = v_u_15
	local v25 = setmetatable({}, v24)
	v25.Model = v_u_16:Clone()
	v25.Size = v25.Model:GetExtentsSize()
	v25.Scale = v25.Model:GetScale()
	local v26 = v25.Model
	local v27 = v_u_17.CFrame
	local v28 = v25.Size.Y / 2
	v26:PivotTo(v27 + Vector3.new(0, v28, 0))
	v25.Model.Parent = workspace
	v25.CFrame = v25.Model:GetPivot()
	v25._spawning = false
	local v29 = v_u_14.create("SlimeHit")
	v_u_14.changeColor(v29, v25.Model.Main.Color)
	v29.Parent = v25.Model.PrimaryPart
	local v30 = v_u_14.create("SlimeDestroy")
	v_u_14.changeColor(v30, v25.Model.Main.Color)
	v30.Parent = v25.Model.PrimaryPart
	v25.HitVFX = v29
	v25.DestroyVFX = v30
	v25.lookConnection = nil
	v25.Attacking = false
	v25.Colors = {}
	for _, v31 in v25.Model:QueryDescendants("BasePart") do
		v25.Colors[v31] = v31.Color
	end
	return v25
end
function v_u_15.spawn(p32)
	-- upvalues: (copy) v_u_12, (copy) v_u_22, (copy) v_u_13
	p32._spawning = true
	v_u_12.play("IceBossSpawn", {
		["RollOffMinDistance"] = 100,
		["Parent"] = p32.Model.PrimaryPart
	})
	v_u_22:ShakeOnce(0.4, 20, 2, 4, Vector3.new(0, 0.15, 0), Vector3.new(1.25, 0, 4))
	local v33 = p32.Model
	local v34 = p32.CFrame
	local v35 = p32.Size.Y * 1.1
	v33:PivotTo(v34 - Vector3.new(0, v35, 0))
	v_u_13.target(p32.Model, 1, 0.2, {
		["Pivot"] = p32.CFrame
	})
	return p32
end
function v_u_15.attack(p36, _)
	-- upvalues: (copy) v_u_5, (copy) v_u_1, (copy) v_u_12, (copy) v_u_18, (copy) v_u_14, (copy) v_u_13
	local v_u_37 = Instance.new("Highlight")
	v_u_37.Adornee = p36.Model
	v_u_37.OutlineTransparency = 1
	v_u_37.FillTransparency = 1
	v_u_37.Parent = p36.Model
	v_u_5:Create(v_u_37, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
		["FillTransparency"] = 0.5
	}):Play()
	task.delay(0.1, function()
		-- upvalues: (ref) v_u_5, (copy) v_u_37
		v_u_5:Create(v_u_37, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
			["FillTransparency"] = 1
		}):Play()
	end)
	v_u_1:AddItem(v_u_37, 0.3)
	v_u_12.play("SlimeHit", {
		["Parent"] = p36.Model.PrimaryPart,
		["PlaybackSpeed"] = v_u_18:NextNumber(0.8, 1.2)
	})
	v_u_14.play(p36.HitVFX)
	p36.Model:ScaleTo(p36.Scale * 0.95)
	v_u_13.target(p36.Model, 0.5, 5, {
		["Scale"] = p36.Scale
	})
	return p36
end
function v_u_15.changeColor(p38, p39)
	-- upvalues: (copy) v_u_5
	if p39 then
		local v40 = p39.End - workspace:GetServerTimeNow()
		for v41, _ in p38.Colors do
			v_u_5:Create(v41, TweenInfo.new(v40, Enum.EasingStyle.Linear), {
				["Color"] = p39.Color
			}):Play()
		end
	else
		for v42, v43 in p38.Colors do
			v42.Color = v43
		end
	end
end
function v_u_15.dropIcicle(_, p_u_44, p_u_45, p46)
	-- upvalues: (copy) v_u_11, (copy) v_u_5, (copy) v_u_10, (copy) v_u_22, (copy) v_u_12, (copy) v_u_18, (copy) v_u_1
	local v47 = v_u_11.createDangerCircle(p46 or 5)
	v47.Position = p_u_44
	v47.Parent = workspace
	local v_u_48 = v_u_11.createIcicle(p46 or 5)
	local v49 = v_u_48.Mesh.Scale.Y * 2
	v_u_48.Position = p_u_44 + Vector3.new(0, v49, 0)
	v_u_48.Parent = workspace
	task.delay(p_u_45 * 0.5, function()
		-- upvalues: (ref) v_u_5, (copy) v_u_48, (copy) p_u_45, (copy) p_u_44, (ref) v_u_10, (ref) v_u_22, (ref) v_u_12, (ref) v_u_18, (ref) v_u_1
		local v50 = v_u_5
		local v51 = v_u_48
		local v52 = TweenInfo.new(p_u_45 * 0.5, Enum.EasingStyle.Linear)
		local v53 = {}
		local v54 = p_u_44
		local v55 = v_u_48.Mesh.Scale.Y
		v53.Position = v54 - Vector3.new(0, v55, 0)
		v50:Create(v51, v52, v53):Play()
		task.wait(p_u_45 * 0.3)
		v_u_10("icicle_drop", 0.1, function(_, ...)
			-- upvalues: (ref) v_u_22, (ref) v_u_48, (ref) v_u_12, (ref) v_u_18, (ref) v_u_1
			v_u_22:ShakeOnce(1, 20, 0, 1, Vector3.new(0, 0.15, 0), Vector3.new(1.25, 0, 4))
			local v56 = v_u_48:Clone()
			v56.Transparency = 1
			v56.Parent = workspace
			v_u_12.play("Icicle", {
				["Parent"] = v56,
				["PlaybackSpeed"] = v_u_18:NextNumber(0.8, 1.2)
			})
			v_u_1:AddItem(v56, 1)
		end)
	end)
	v_u_1:AddItem(v_u_48, 5)
	v_u_1:AddItem(v47, p_u_45)
end
function v_u_15.move1(p57, p58)
	local v59 = workspace:GetServerTimeNow() - p58.started
	if p58.attack_duration > v59 then
		for _, v60 in p58.positions do
			p57:dropIcicle(v60, p58.attack_duration - v59)
		end
	end
end
function v_u_15.move2(p61, p62)
	local v63 = workspace:GetServerTimeNow() - p62.started
	if p62.attack_duration > v63 then
		for _, v64 in p62.positions do
			p61:dropIcicle(v64, p62.attack_duration - v63)
		end
	end
end
function v_u_15.move3(p65, p66)
	local v67 = workspace:GetServerTimeNow() - p66.started
	if p66.attack_duration > v67 then
		for _, v68 in p66.positions do
			p65:dropIcicle(v68, p66.attack_duration - v67)
		end
	end
end
function v_u_15.move4(p69, p70)
	local v71 = workspace:GetServerTimeNow() - p70.started
	if p70.attack_duration > v71 then
		for _, v72 in p70.positions do
			p69:dropIcicle(v72, p70.attack_duration - v71)
		end
	end
end
function v_u_15.move5(p73, p74)
	local v75 = workspace:GetServerTimeNow() - p74.started
	if p74.attack_duration > v75 then
		for _, v76 in p74.positions do
			p73:dropIcicle(v76, p74.attack_duration - v75)
		end
	end
end
function v_u_15.move6(p77, p78)
	local v79 = workspace:GetServerTimeNow() - p78.started
	if p78.attack_duration > v79 then
		for _, v80 in p78.positions do
			p77:dropIcicle(v80, p78.attack_duration - v79, 25)
		end
	end
end
function v_u_15.defeated(p81)
	-- upvalues: (copy) v_u_12, (copy) v_u_18, (copy) v_u_14
	v_u_12.play("SlimeDestroy", {
		["Parent"] = p81.Model.PrimaryPart,
		["PlaybackSpeed"] = v_u_18:NextNumber(0.8, 1.2)
	})
	v_u_14.play(p81.DestroyVFX)
	task.wait(1)
	return p81
end
function v_u_15.hide(p82)
	-- upvalues: (copy) v_u_3
	p82.Model.Parent = v_u_3
	if p82.lookConnection then
		p82.lookConnection:Disconnect()
		p82.lookConnection = nil
	end
	return p82
end
function v_u_15.show(p_u_83)
	-- upvalues: (copy) v_u_4, (copy) v_u_2
	if p_u_83.lookConnection then
		p_u_83.lookConnection:Disconnect()
		p_u_83.lookConnection = nil
	end
	p_u_83.Model.Parent = workspace
	p_u_83.lookConnection = v_u_4.Heartbeat:Connect(function(_)
		-- upvalues: (ref) v_u_2, (copy) p_u_83
		local v84 = v_u_2.LocalPlayer.Character
		if v84 then
			if not p_u_83.Attacking then
				local v85 = p_u_83.CFrame.Position.Y
				local v86 = v84:GetPivot()
				local v87 = v86.Position.X
				local v88 = v86.Position.Z
				local v89 = Vector3.new(v87, v85, v88)
				local v90 = p_u_83.Model:GetPivot()
				local v91 = v90:Lerp(CFrame.new(v90.Position, v89), 1)
				p_u_83.Model:PivotTo(v91)
			end
		else
			return
		end
	end)
	return p_u_83
end
function v_u_15.escape(p92)
	-- upvalues: (copy) v_u_13
	local v93 = v_u_13.target
	local v94 = p92.Model
	local v95 = {}
	local v96 = p92.CFrame
	local v97 = p92.Size.Y * 1.1
	v95.Pivot = v96 - Vector3.new(0, v97, 0)
	v93(v94, 1, 0.2, v95)
	task.wait(3)
	return p92
end
function v_u_15.Destroy(_) end
return v_u_15]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[IceBossClass]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3725"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Client.Data.DataController)
local v_u_4 = require(v2.Config.Constants)
local v_u_5 = require(v2.Enums.MultiplierTypes)
local v_u_6 = require(v2.Functions.Touched)
local v7 = require(v2.Functions.WaitFor)
local v_u_8 = require(v2.Utility.Multiplier)
local v9 = require(v2.Utility.Network)
local v_u_10 = require(v2.Utility.Notify)
local v_u_11 = require(v2.Utility.Time)
local v12 = {}
local v_u_13 = v7(workspace, "Persistent", "FREE_SHARDS")
local v_u_14 = v7(v_u_13, "Attachment", "BillboardGui", "Timer")
local v_u_15 = v9.remoteFunction("FreeShardService/Claim")
function v12.init(_)
	-- upvalues: (copy) v_u_14, (copy) v_u_3, (copy) v_u_4, (copy) v_u_8, (copy) v_u_5, (copy) v_u_11, (copy) v_u_6, (copy) v_u_13, (copy) v_u_1, (copy) v_u_15, (copy) v_u_10
	v_u_14.Text = "Claim Shards!"
	local v_u_16 = nil
	v_u_3:onSet({ "FreeShards" }, function(p_u_17)
		-- upvalues: (ref) v_u_16, (ref) v_u_4, (ref) v_u_8, (ref) v_u_5, (ref) v_u_14, (ref) v_u_11
		if v_u_16 then
			task.cancel(v_u_16)
			v_u_16 = nil
		end
		if p_u_17 then
			v_u_16 = task.spawn(function()
				-- upvalues: (copy) p_u_17, (ref) v_u_4, (ref) v_u_8, (ref) v_u_5, (ref) v_u_14, (ref) v_u_11
				while true do
					local v18 = workspace:GetServerTimeNow() - p_u_17
					local v19 = v_u_4.FREE_SHARD_TIME * v_u_8.get(v_u_5.FreeShardPercentage) - v18
					local v20 = math.floor(v19)
					if v20 <= 0 then
						break
					end
					v_u_14.Text = v_u_11.format(v20)
					task.wait(1)
				end
				v_u_14.Text = "Claim Shards!"
			end)
		end
	end)
	v_u_6(v_u_13, function(p21)
		-- upvalues: (ref) v_u_1, (ref) v_u_15, (ref) v_u_10
		if p21 == v_u_1.LocalPlayer then
			local v22, v23 = v_u_15.invoke()
			if not v22 then
				v_u_10.Notify({
					["Message"] = v23,
					["Type"] = v_u_10.Types.Error
				})
			end
		end
	end, 1)
end
return v12]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[FreeShardController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3726"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Amulets]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3727"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Gameplay.Sound.SoundController)
local v_u_3 = require(v1.Client.UI.UIController)
local v_u_4 = require(v1.Packages.Observers)
local v_u_5 = require(v1.Utility.UI)
local v_u_6 = require(v1.Utility.ZoneUtil)
return {
	["init"] = function(_)
		-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_5, (copy) v_u_6, (copy) v_u_2
		v_u_4.observeTag("AmuletHall", function(p_u_7)
			-- upvalues: (ref) v_u_3, (ref) v_u_5
			local v8 = Instance.new("ProximityPrompt")
			v8.UIOffset = Vector2.new(0, 999999)
			v8.RequiresLineOfSight = false
			v8.Parent = p_u_7
			v8.MaxActivationDistance = p_u_7:GetAttribute("Range") or 10
			v8.PromptShown:Connect(function()
				-- upvalues: (ref) v_u_3, (copy) p_u_7, (ref) v_u_5
				local v9 = v_u_3:get("BuySlimeAmulet")
				local v10 = p_u_7.Name
				v9:set("AmuletHall", (tonumber(v10)))
				v_u_5:open("BuySlimeAmulet")
			end)
			v8.PromptHidden:Connect(function()
				-- upvalues: (ref) v_u_5
				if v_u_5.Current == "BuySlimeAmulet" then
					v_u_5:close(v_u_5.Current)
				end
			end)
		end)
		v_u_6.observe("AMULET_HALL", function()
			-- upvalues: (ref) v_u_2
			v_u_2:playMusic("AMULET_HALL")
			return function()
				-- upvalues: (ref) v_u_2
				v_u_2:stopMusic()
			end
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AmuletHallController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3728"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Config.AmuletData)
local v_u_4 = require(v1.Config.AmuletPassiveData)
local v_u_5 = require(v1.Config.AmuletPerkData)
local v_u_6 = require(v1.Config.GloopData)
local v_u_7 = require(v1.Config.MultiplierData)
local v_u_8 = require(v1.Utility.MultiplierUtil)
local v_u_9 = require(v1.Utility.PerkUtil)
return {
	["update"] = function(_, p10)
		-- upvalues: (copy) v_u_2, (copy) v_u_9, (copy) v_u_3, (copy) v_u_6, (copy) v_u_7, (copy) v_u_8, (copy) v_u_4, (copy) v_u_5
		local v11 = v_u_2:getValue({ "Amulet", "Equipped", p10 })
		if v11 and v11.Tier ~= nil then
			local v12 = v_u_3[p10]
			local v13 = v12.Tiers[v11.Tier]
			local v14 = 0
			if v11.AppliedGloops and #v11.AppliedGloops > 0 then
				for _, v15 in v11.AppliedGloops do
					local v16 = v_u_6[v15]
					if v16 and v16.Buffs.Multiplier then
						v14 = v14 + v16.Buffs.Multiplier
					end
				end
			end
			local v17 = {}
			for v18, v19 in v11.Multipliers do
				local v20 = v_u_7[v18]
				if v20 then
					local v21 = ("%* %*"):format(v_u_8.format(v18, v19), v20.Name or "???")
					if v14 > 0 then
						local v22 = v14 * 100
						v21 = ("%* (+%*%%)"):format(v21, (math.floor(v22)))
					end
					table.insert(v17, v21)
				else
					warn((("Missing multiplier data for %* on amulet %*"):format(v18, p10)))
				end
			end
			local v23 = {}
			for _, v24 in v11.Passives or {} do
				local v25 = v_u_4[v24]
				if v25 then
					local v26 = ("\226\128\162 %*"):format(v25.Name)
					table.insert(v23, v26)
				end
			end
			local v27 = {}
			for _, v28 in v11.Perks or {} do
				local v29 = v_u_5[v28]
				if v29 then
					local v30 = ("\226\152\133 %*"):format(v29.Name)
					table.insert(v27, v30)
				end
			end
			v_u_9:update(("Amulet_%*"):format(p10), {
				["Icon"] = v13.Icon,
				["Text"] = "",
				["Tooltip"] = {
					["Title"] = ("Tier %* %*"):format(v11.Tier, v12.Name),
					["Passives"] = table.concat(v23, "\n"),
					["Perks"] = table.concat(v27, "\n"),
					["Description"] = table.concat(v17, "\n")
				}
			})
		else
			v_u_9:remove((("Amulet_%*"):format(p10)))
		end
	end,
	["init"] = function(p_u_31)
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		for v32 in v_u_3 do
			p_u_31:update(v32)
		end
		v_u_2:onChange(function(_, p33, _, _)
			-- upvalues: (copy) p_u_31
			if p33[1] == "Amulet" and p33[2] == "Equipped" then
				p_u_31:update(p33[3])
			end
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AmuletController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3729"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.UI.UIController)
local v_u_3 = require(v1.Packages.Observers)
local v_u_4 = require(v1.Utility.UI)
return {
	["init"] = function(_)
		-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_4
		v_u_3.observeTag("ValentineAmulet", function(p_u_5)
			-- upvalues: (ref) v_u_2, (ref) v_u_4
			local v6 = Instance.new("ProximityPrompt")
			v6.UIOffset = Vector2.new(0, 999999)
			v6.RequiresLineOfSight = false
			v6.Parent = p_u_5
			v6.MaxActivationDistance = p_u_5:GetAttribute("Range") or 10
			v6.PromptShown:Connect(function()
				-- upvalues: (ref) v_u_2, (copy) p_u_5, (ref) v_u_4
				local v7 = v_u_2:get("BuySlimeAmulet")
				local v8 = p_u_5.Name
				v7:set("Valentine", (tonumber(v8)))
				v_u_4:open("BuySlimeAmulet")
			end)
			v6.PromptHidden:Connect(function()
				-- upvalues: (ref) v_u_4
				if v_u_4.Current == "BuySlimeAmulet" then
					v_u_4:close(v_u_4.Current)
				end
			end)
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ValentineAmuletController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="3730"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Passives]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3731"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("SoundService")
local v5 = require(v_u_2.Functions.WaitFor)
local v6 = require(v_u_2.Packages.Janitor)
local v7 = require(v_u_2.Utility.Network)
local v8 = {}
local v_u_9 = {
	["Start"] = v7.remoteEvent("HeartAttackService/Start"),
	["Attack"] = v7.remoteEvent("HeartAttackService/Attack"),
	["Stop"] = v7.remoteEvent("HeartAttackService/Stop"),
	["StartMusic"] = v7.remoteEvent("HeartAttackService/StartMusic"),
	["StopMusic"] = v7.remoteEvent("HeartAttackService/StopMusic")
}
local v_u_10 = v5(v_u_2, "Assets", "VFX", "Passives", "HeartAttack")
local v_u_11 = false
local v_u_12 = v6.new()
local v_u_13 = 0.35
local v_u_14 = 0.45
local v_u_15 = "Idle"
local v_u_16 = 0
local v_u_17 = nil
local v_u_18 = nil
function v8.start(_)
	-- upvalues: (ref) v_u_11, (copy) v_u_10, (copy) v_u_12, (copy) v_u_3, (copy) v_u_1, (ref) v_u_15, (ref) v_u_16, (ref) v_u_13, (ref) v_u_17, (ref) v_u_18, (ref) v_u_14
	if not v_u_11 then
		v_u_11 = true
		v_u_10.Parent = workspace
		local v_u_19 = 0
		local v_u_20 = 0
		v_u_12:Add(v_u_3.RenderStepped:Connect(function(p21)
			-- upvalues: (ref) v_u_1, (ref) v_u_19, (ref) v_u_20, (ref) v_u_15, (ref) v_u_10, (ref) v_u_16, (ref) v_u_13, (ref) v_u_17, (ref) v_u_18, (ref) v_u_14
			local v22 = v_u_1.LocalPlayer.Character
			if v22 then
				local v23 = v22:FindFirstChild("HumanoidRootPart")
				if v23 then
					v_u_19 = v_u_19 + 2 * p21
					v_u_20 = v_u_20 + p21
					local v24 = v_u_19
					local v25 = math.cos(v24) * 4
					local v26 = v_u_19
					local v27 = math.sin(v26) * 4
					local v28 = v_u_20 * 3
					local v29 = math.sin(v28) * 1.5 + 2
					local v30 = v23.Position + Vector3.new(v25, v29, v27)
					local v31 = CFrame.lookAt(v30, v23.Position)
					if v_u_15 == "Idle" then
						v_u_10.CFrame = v31
					else
						v_u_16 = v_u_16 + p21
						if v_u_15 == "Out" then
							local v32 = v_u_16 / v_u_13
							local v33 = math.clamp(v32, 0, 1)
							local v34 = v33 * v33 * (3 - v33 * 2)
							v_u_10.CFrame = v_u_17:Lerp(v_u_18, v34)
							if v34 >= 1 then
								v_u_15 = "Back"
								v_u_16 = 0
								return
							end
						elseif v_u_15 == "Back" then
							local v35 = v_u_16 / v_u_14
							local v36 = math.clamp(v35, 0, 1)
							local v37 = v36 * v36 * (3 - v36 * 2)
							v_u_10.CFrame = v_u_18:Lerp(v31, v37)
							if v37 >= 1 then
								v_u_15 = "Idle"
								v_u_16 = 0
							end
						end
					end
				else
					return
				end
			else
				return
			end
		end))
	end
end
function v8.attack(_, p38)
	-- upvalues: (ref) v_u_15, (ref) v_u_13, (ref) v_u_14, (ref) v_u_16, (ref) v_u_17, (copy) v_u_10, (ref) v_u_18
	if v_u_15 == "Out" then
		return
	else
		local v39 = p38.t
		if v39 then
			v_u_13 = p38.h - workspace:GetServerTimeNow()
			v_u_14 = 1
			v_u_15 = "Out"
			v_u_16 = 0
			v_u_17 = v_u_10.CFrame
			v_u_18 = CFrame.lookAt(v39, v_u_17.Position)
		end
	end
end
function v8.stop(_)
	-- upvalues: (ref) v_u_11, (copy) v_u_10, (copy) v_u_2, (copy) v_u_12
	if v_u_11 then
		v_u_11 = false
		v_u_10.Parent = v_u_2
		v_u_12:Cleanup()
	end
end
function v8.init(p_u_40)
	-- upvalues: (copy) v_u_9, (copy) v_u_4, (ref) v_u_15, (ref) v_u_16
	v_u_9.Start.listen(function()
		-- upvalues: (copy) p_u_40
		p_u_40:start()
	end)
	v_u_9.Attack.listen(function(p41)
		-- upvalues: (copy) p_u_40
		p_u_40:attack(p41)
	end)
	v_u_9.Stop.listen(function()
		-- upvalues: (copy) p_u_40
		p_u_40:stop()
	end)
	v_u_9.StartMusic.listen(function()
		-- upvalues: (ref) v_u_4
		for _, v42 in v_u_4.Music:QueryDescendants("Sound") do
			if not v42:GetAttribute("playbackSpeed") then
				v42:SetAttribute("playbackSpeed", v42.PlaybackSpeed)
			end
			v42.PlaybackSpeed = (v42:GetAttribute("playbackSpeed") or 1) * 1.3
		end
	end)
	v_u_9.StopMusic.listen(function()
		-- upvalues: (ref) v_u_15, (ref) v_u_16, (ref) v_u_4
		if v_u_15 ~= "Idle" then
			v_u_15 = "Idle"
			v_u_16 = 0
		end
		for _, v43 in v_u_4.Music:QueryDescendants("Sound") do
			if not v43:GetAttribute("playbackSpeed") then
				v43:SetAttribute("playbackSpeed", v43.PlaybackSpeed)
			end
			v43.PlaybackSpeed = v43:GetAttribute("playbackSpeed") or 1
		end
	end)
end
return v8]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[HeartAttackController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3732"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("SoundService")
local v_u_5 = require(v_u_2.Client.Gameplay.Sound.SoundController)
local v_u_6 = require(v_u_2.Enums.MultiplierTypes)
local v7 = require(v_u_2.Functions.WaitFor)
local v8 = require(v_u_2.Packages.Janitor)
local v_u_9 = require(v_u_2.Utility.Multiplier)
local v10 = require(v_u_2.Utility.Network)
local v11 = {}
local v_u_12 = {
	["Start"] = v10.remoteEvent("CoinStarService/Start"),
	["Attack"] = v10.remoteEvent("CoinStarService/Attack"),
	["Stop"] = v10.remoteEvent("CoinStarService/Stop"),
	["UpdateMultiplier"] = v10.remoteEvent("CoinStarService/UpdateMultiplier")
}
local v_u_13 = v7(v4, "SFX", "CoinStar")
local v_u_14 = v7(v_u_2, "Assets", "VFX", "Passives", "CoinStar")
local v_u_15 = false
local v_u_16 = v8.new()
local v_u_17 = 0.35
local v_u_18 = 0.45
local v_u_19 = "Idle"
local v_u_20 = 0
local v_u_21 = nil
local v_u_22 = nil
function v11.start(_)
	-- upvalues: (ref) v_u_15, (copy) v_u_14, (copy) v_u_5, (copy) v_u_16, (copy) v_u_13, (copy) v_u_3, (copy) v_u_1, (ref) v_u_19, (ref) v_u_20, (ref) v_u_17, (ref) v_u_21, (ref) v_u_22, (ref) v_u_18
	if not v_u_15 then
		v_u_15 = true
		v_u_14.Parent = workspace
		v_u_5:decrease()
		local v23 = v_u_16:Add(v_u_13:Clone())
		v23:Play()
		v23.RollOffMinDistance = 50
		v23.RollOffMaxDistance = 100
		v23.Parent = v_u_14
		local v_u_24 = 0
		local v_u_25 = 0
		v_u_16:Add(v_u_3.RenderStepped:Connect(function(p26)
			-- upvalues: (ref) v_u_1, (ref) v_u_24, (ref) v_u_25, (ref) v_u_19, (ref) v_u_14, (ref) v_u_20, (ref) v_u_17, (ref) v_u_21, (ref) v_u_22, (ref) v_u_18
			local v27 = v_u_1.LocalPlayer.Character
			if v27 then
				local v28 = v27:FindFirstChild("HumanoidRootPart")
				if v28 then
					v_u_24 = v_u_24 + 2 * p26
					v_u_25 = v_u_25 + p26
					local v29 = v_u_24
					local v30 = math.cos(v29) * 6
					local v31 = v_u_24
					local v32 = math.sin(v31) * 6
					local v33 = v_u_25 * 3
					local v34 = math.sin(v33) * 1.5 + 2
					local v35 = v28.Position + Vector3.new(v30, v34, v32)
					local v36 = CFrame.lookAt(v35, v28.Position)
					if v_u_19 == "Idle" then
						v_u_14.CFrame = v36
					else
						v_u_20 = v_u_20 + p26
						if v_u_19 == "Out" then
							local v37 = v_u_20 / v_u_17
							local v38 = math.clamp(v37, 0, 1)
							local v39 = v38 * v38 * (3 - v38 * 2)
							v_u_14.CFrame = v_u_21:Lerp(v_u_22, v39)
							if v39 >= 1 then
								v_u_19 = "Back"
								v_u_20 = 0
								return
							end
						elseif v_u_19 == "Back" then
							local v40 = v_u_20 / v_u_18
							local v41 = math.clamp(v40, 0, 1)
							local v42 = v41 * v41 * (3 - v41 * 2)
							v_u_14.CFrame = v_u_22:Lerp(v36, v42)
							if v42 >= 1 then
								v_u_19 = "Idle"
								v_u_20 = 0
							end
						end
					end
				else
					return
				end
			else
				return
			end
		end))
	end
end
function v11.attack(_, p43)
	-- upvalues: (ref) v_u_19, (ref) v_u_17, (ref) v_u_18, (ref) v_u_20, (ref) v_u_21, (copy) v_u_14, (ref) v_u_22
	if v_u_19 == "Out" then
		return
	else
		local v44 = p43.t
		if v44 then
			v_u_17 = p43.h - workspace:GetServerTimeNow()
			v_u_18 = 1
			v_u_19 = "Out"
			v_u_20 = 0
			v_u_21 = v_u_14.CFrame
			v_u_22 = CFrame.lookAt(v44, v_u_21.Position)
		end
	end
end
function v11.stop(_)
	-- upvalues: (ref) v_u_15, (copy) v_u_5, (copy) v_u_14, (copy) v_u_2, (copy) v_u_16
	if v_u_15 then
		v_u_5:back()
		v_u_15 = false
		v_u_14.Parent = v_u_2
		v_u_16:Cleanup()
	end
end
function v11.init(p_u_45)
	-- upvalues: (copy) v_u_12, (copy) v_u_14, (copy) v_u_9, (copy) v_u_6
	local v_u_46 = nil
	v_u_12.Start.listen(function()
		-- upvalues: (copy) p_u_45, (ref) v_u_46
		p_u_45:start()
		v_u_46 = nil
	end)
	v_u_12.Attack.listen(function(p47)
		-- upvalues: (copy) p_u_45
		p_u_45:attack(p47)
	end)
	v_u_12.Stop.listen(function()
		-- upvalues: (copy) p_u_45, (ref) v_u_46
		p_u_45:stop()
		v_u_46 = nil
	end)
	v_u_12.UpdateMultiplier.listen(function(p48)
		-- upvalues: (ref) v_u_14, (ref) v_u_46
		v_u_14.BillboardGui.TextLabel.Text = ("x%*"):format(p48)
		v_u_46 = p48
	end)
	v_u_9.assign(v_u_6.CurrencyGainMultiplier, function()
		-- upvalues: (ref) v_u_46
		return v_u_46
	end)
	v_u_9.assign(v_u_6.HeartsMultiplier, function()
		-- upvalues: (ref) v_u_46
		return v_u_46
	end)
end
return v11]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CoinStarController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3733"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("SoundService")
local v_u_5 = require(v_u_2.Client.Gameplay.Sound.SoundController)
local v_u_6 = require(v_u_2.Enums.MultiplierTypes)
local v7 = require(v_u_2.Functions.WaitFor)
local v8 = require(v_u_2.Packages.Janitor)
local v_u_9 = require(v_u_2.Utility.Multiplier)
local v10 = require(v_u_2.Utility.Network)
local v11 = {}
local v_u_12 = {
	["Start"] = v10.remoteEvent("DamageStarService/Start"),
	["Attack"] = v10.remoteEvent("DamageStarService/Attack"),
	["Stop"] = v10.remoteEvent("DamageStarService/Stop"),
	["UpdateMultiplier"] = v10.remoteEvent("DamageStarService/UpdateMultiplier")
}
local v_u_13 = v7(v4, "SFX", "DamageStar")
local v_u_14 = v7(v_u_2, "Assets", "VFX", "Passives", "DamageStar")
local v_u_15 = false
local v_u_16 = v8.new()
local v_u_17 = 0.35
local v_u_18 = 0.45
local v_u_19 = "Idle"
local v_u_20 = 0
local v_u_21 = nil
local v_u_22 = nil
function v11.start(_)
	-- upvalues: (ref) v_u_15, (copy) v_u_14, (copy) v_u_16, (copy) v_u_13, (copy) v_u_5, (copy) v_u_3, (copy) v_u_1, (ref) v_u_19, (ref) v_u_20, (ref) v_u_17, (ref) v_u_21, (ref) v_u_22, (ref) v_u_18
	if not v_u_15 then
		v_u_15 = true
		v_u_14.Parent = workspace
		local v_u_23 = 0
		local v_u_24 = 0
		local v25 = v_u_16:Add(v_u_13:Clone())
		v25:Play()
		v25.RollOffMinDistance = 50
		v25.RollOffMaxDistance = 100
		v25.Parent = v_u_14
		v_u_5:decrease()
		v_u_16:Add(v_u_3.RenderStepped:Connect(function(p26)
			-- upvalues: (ref) v_u_1, (ref) v_u_23, (ref) v_u_24, (ref) v_u_19, (ref) v_u_14, (ref) v_u_20, (ref) v_u_17, (ref) v_u_21, (ref) v_u_22, (ref) v_u_18
			local v27 = v_u_1.LocalPlayer.Character
			if v27 then
				local v28 = v27:FindFirstChild("HumanoidRootPart")
				if v28 then
					v_u_23 = v_u_23 + 4 * p26
					v_u_24 = v_u_24 + p26
					local v29 = v_u_23
					local v30 = math.cos(v29) * 6
					local v31 = v_u_23
					local v32 = math.sin(v31) * 6
					local v33 = v_u_24 * 3
					local v34 = math.sin(v33) * 1.5 + 2
					local v35 = v28.Position + Vector3.new(v30, v34, v32)
					local v36 = CFrame.lookAt(v35, v28.Position)
					if v_u_19 == "Idle" then
						v_u_14.CFrame = v36
					else
						v_u_20 = v_u_20 + p26
						if v_u_19 == "Out" then
							local v37 = v_u_20 / v_u_17
							local v38 = math.clamp(v37, 0, 1)
							local v39 = v38 * v38 * (3 - v38 * 2)
							v_u_14.CFrame = v_u_21:Lerp(v_u_22, v39)
							if v39 >= 1 then
								v_u_19 = "Back"
								v_u_20 = 0
								return
							end
						elseif v_u_19 == "Back" then
							local v40 = v_u_20 / v_u_18
							local v41 = math.clamp(v40, 0, 1)
							local v42 = v41 * v41 * (3 - v41 * 2)
							v_u_14.CFrame = v_u_22:Lerp(v36, v42)
							if v42 >= 1 then
								v_u_19 = "Idle"
								v_u_20 = 0
							end
						end
					end
				else
					return
				end
			else
				return
			end
		end))
	end
end
function v11.attack(_, p43)
	-- upvalues: (ref) v_u_19, (ref) v_u_17, (ref) v_u_18, (ref) v_u_20, (ref) v_u_21, (copy) v_u_14, (ref) v_u_22
	if v_u_19 == "Out" then
		return
	else
		local v44 = p43.t
		if v44 then
			v_u_17 = p43.h - workspace:GetServerTimeNow()
			v_u_18 = 1
			v_u_19 = "Out"
			v_u_20 = 0
			v_u_21 = v_u_14.CFrame
			v_u_22 = CFrame.lookAt(v44, v_u_21.Position)
		end
	end
end
function v11.stop(_)
	-- upvalues: (ref) v_u_15, (copy) v_u_5, (copy) v_u_14, (copy) v_u_2, (copy) v_u_16
	if v_u_15 then
		v_u_5:back()
		v_u_15 = false
		v_u_14.Parent = v_u_2
		v_u_16:Cleanup()
	end
end
function v11.init(p_u_45)
	-- upvalues: (copy) v_u_12, (copy) v_u_14, (copy) v_u_9, (copy) v_u_6
	local v_u_46 = nil
	v_u_12.Start.listen(function()
		-- upvalues: (copy) p_u_45, (ref) v_u_46
		p_u_45:start()
		v_u_46 = nil
	end)
	v_u_12.Attack.listen(function(p47)
		-- upvalues: (copy) p_u_45
		p_u_45:attack(p47)
	end)
	v_u_12.Stop.listen(function()
		-- upvalues: (copy) p_u_45, (ref) v_u_46
		p_u_45:stop()
		v_u_46 = nil
	end)
	v_u_12.UpdateMultiplier.listen(function(p48)
		-- upvalues: (ref) v_u_14, (ref) v_u_46
		v_u_14.BillboardGui.TextLabel.Text = ("x%*"):format(p48)
		v_u_46 = p48
	end)
	v_u_9.assign(v_u_6.DamageMultiplier, function()
		-- upvalues: (ref) v_u_46
		return v_u_46
	end)
	v_u_9.assign(v_u_6.ValentineDamageMultiplier, function()
		-- upvalues: (ref) v_u_46
		return v_u_46
	end)
end
return v11]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[DamageStarController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3734"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("SoundService")
local v_u_5 = require(v_u_2.Client.Gameplay.Sound.SoundController)
local v_u_6 = require(v_u_2.Enums.MultiplierTypes)
local v7 = require(v_u_2.Functions.WaitFor)
local v8 = require(v_u_2.Packages.Janitor)
local v_u_9 = require(v_u_2.Utility.Multiplier)
local v10 = require(v_u_2.Utility.Network)
local v11 = {}
local v_u_12 = {
	["Start"] = v10.remoteEvent("ShardStarService/Start"),
	["Attack"] = v10.remoteEvent("ShardStarService/Attack"),
	["Stop"] = v10.remoteEvent("ShardStarService/Stop"),
	["UpdateMultiplier"] = v10.remoteEvent("ShardStarService/UpdateMultiplier")
}
local v_u_13 = v7(v4, "SFX", "ShardStar")
local v_u_14 = v7(v_u_2, "Assets", "VFX", "Passives", "ShardStar")
local v_u_15 = false
local v_u_16 = v8.new()
local v_u_17 = 0.35
local v_u_18 = 0.45
local v_u_19 = "Idle"
local v_u_20 = 0
local v_u_21 = nil
local v_u_22 = nil
function v11.start(_)
	-- upvalues: (ref) v_u_15, (copy) v_u_14, (copy) v_u_16, (copy) v_u_13, (copy) v_u_5, (copy) v_u_3, (copy) v_u_1, (ref) v_u_19, (ref) v_u_20, (ref) v_u_17, (ref) v_u_21, (ref) v_u_22, (ref) v_u_18
	if not v_u_15 then
		v_u_15 = true
		v_u_14.Parent = workspace
		local v23 = v_u_16:Add(v_u_13:Clone())
		v23:Play()
		v23.RollOffMinDistance = 50
		v23.RollOffMaxDistance = 100
		v23.Parent = v_u_14
		local v_u_24 = 0
		local v_u_25 = 0
		v_u_5:decrease()
		v_u_16:Add(v_u_3.RenderStepped:Connect(function(p26)
			-- upvalues: (ref) v_u_1, (ref) v_u_24, (ref) v_u_25, (ref) v_u_19, (ref) v_u_14, (ref) v_u_20, (ref) v_u_17, (ref) v_u_21, (ref) v_u_22, (ref) v_u_18
			local v27 = v_u_1.LocalPlayer.Character
			if v27 then
				local v28 = v27:FindFirstChild("HumanoidRootPart")
				if v28 then
					v_u_24 = v_u_24 + 4 * p26
					v_u_25 = v_u_25 + p26
					local v29 = v_u_24
					local v30 = math.cos(v29) * 6
					local v31 = v_u_24
					local v32 = math.sin(v31) * 6
					local v33 = v_u_25 * 3
					local v34 = math.sin(v33) * 1.5 + 2
					local v35 = v28.Position + Vector3.new(v30, v34, v32)
					local v36 = CFrame.lookAt(v35, v28.Position)
					if v_u_19 == "Idle" then
						v_u_14.CFrame = v36
					else
						v_u_20 = v_u_20 + p26
						if v_u_19 == "Out" then
							local v37 = v_u_20 / v_u_17
							local v38 = math.clamp(v37, 0, 1)
							local v39 = v38 * v38 * (3 - v38 * 2)
							v_u_14.CFrame = v_u_21:Lerp(v_u_22, v39)
							if v39 >= 1 then
								v_u_19 = "Back"
								v_u_20 = 0
								return
							end
						elseif v_u_19 == "Back" then
							local v40 = v_u_20 / v_u_18
							local v41 = math.clamp(v40, 0, 1)
							local v42 = v41 * v41 * (3 - v41 * 2)
							v_u_14.CFrame = v_u_22:Lerp(v36, v42)
							if v42 >= 1 then
								v_u_19 = "Idle"
								v_u_20 = 0
							end
						end
					end
				else
					return
				end
			else
				return
			end
		end))
	end
end
function v11.attack(_, p43)
	-- upvalues: (ref) v_u_19, (ref) v_u_17, (ref) v_u_18, (ref) v_u_20, (ref) v_u_21, (copy) v_u_14, (ref) v_u_22
	if v_u_19 == "Out" then
		return
	else
		local v44 = p43.t
		if v44 then
			v_u_17 = p43.h - workspace:GetServerTimeNow()
			v_u_18 = 1
			v_u_19 = "Out"
			v_u_20 = 0
			v_u_21 = v_u_14.CFrame
			v_u_22 = CFrame.lookAt(v44, v_u_21.Position)
		end
	end
end
function v11.stop(_)
	-- upvalues: (ref) v_u_15, (copy) v_u_5, (copy) v_u_14, (copy) v_u_2, (copy) v_u_16
	if v_u_15 then
		v_u_5:back()
		v_u_15 = false
		v_u_14.Parent = v_u_2
		v_u_16:Cleanup()
	end
end
function v11.init(p_u_45)
	-- upvalues: (copy) v_u_12, (copy) v_u_14, (copy) v_u_9, (copy) v_u_6
	local v_u_46 = nil
	v_u_12.Start.listen(function()
		-- upvalues: (copy) p_u_45, (ref) v_u_46
		p_u_45:start()
		v_u_46 = nil
	end)
	v_u_12.Attack.listen(function(p47)
		-- upvalues: (copy) p_u_45
		p_u_45:attack(p47)
	end)
	v_u_12.Stop.listen(function()
		-- upvalues: (copy) p_u_45, (ref) v_u_46
		p_u_45:stop()
		v_u_46 = nil
	end)
	v_u_12.UpdateMultiplier.listen(function(p48)
		-- upvalues: (ref) v_u_14, (ref) v_u_46
		v_u_14.BillboardGui.TextLabel.Text = ("x%*"):format(p48)
		v_u_46 = p48
	end)
	v_u_9.assign(v_u_6.ShardMultiplier, function()
		-- upvalues: (ref) v_u_46
		return v_u_46
	end)
end
return v11]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ShardStarController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3735"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.CurrencyData)
local v_u_3 = require(v1.Config.WorldData)
local v_u_4 = require(v1.Utility.Multiplier)
local v5 = require(v1.Utility.Network)
local v_u_6 = require(v1.Utility.PerkUtil)
local v_u_7 = require(v1.Utility.Time)
local v_u_8 = require(v1.Utility.WorldUtil)
local v9 = {}
local v_u_10 = {
	["Fetch"] = v5.remoteFunction("WorldSurgeService/Fetch"),
	["Updated"] = v5.remoteEvent("WorldSurgeService/Updated")
}
local v_u_11 = {}
local v_u_12 = nil
function v9.worldChanged(_, p13)
	-- upvalues: (ref) v_u_12, (ref) v_u_11, (copy) v_u_3, (copy) v_u_2, (copy) v_u_6, (copy) v_u_7
	if v_u_12 then
		task.cancel(v_u_12)
		v_u_12 = nil
	end
	local v_u_14 = v_u_11[p13]
	if v_u_14 then
		local v15 = v_u_3[p13]
		if v15 then
			local v16 = v15.WorldSurgeCurrency
			if v16 then
				local v_u_17 = v_u_2[v16]
				if v_u_17 then
					if v_u_14 - workspace:GetServerTimeNow() <= 0 then
						v_u_6:remove("world_surge")
						return false
					else
						v_u_12 = task.spawn(function()
							-- upvalues: (copy) v_u_14, (ref) v_u_6, (ref) v_u_7, (copy) v_u_17
							while true do
								local v18 = v_u_14 - workspace:GetServerTimeNow()
								if v18 <= 0 then
									break
								end
								local v19 = v_u_6
								local v20 = {
									["Text"] = v_u_7.format((math.max(0, v18))),
									["Icon"] = v_u_17.Icon
								}
								local v21 = {
									["Title"] = "World Surge",
									["Description"] = "A player has doubled this worlds earning!"
								}
								v20.Tooltip = v21
								v19:update("world_surge", v20)
								task.wait(1)
							end
							v_u_6:remove("world_surge")
						end)
						return true
					end
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end
function v9.init(p_u_22)
	-- upvalues: (ref) v_u_11, (copy) v_u_10, (copy) v_u_8, (copy) v_u_3, (copy) v_u_2, (copy) v_u_4, (copy) v_u_6
	v_u_11 = v_u_10.Fetch.invoke()
	v_u_10.Updated.listen(function(p23)
		-- upvalues: (ref) v_u_11, (copy) p_u_22, (ref) v_u_8
		v_u_11 = p23
		p_u_22:worldChanged(v_u_8.get())
	end)
	for v_u_24, v25 in v_u_3 do
		local v26 = v25.WorldSurgeCurrency
		if v26 then
			local v27 = v_u_2[v26]
			if v27 and v27.multiplier then
				v_u_4.assign(v27.multiplier, function()
					-- upvalues: (ref) v_u_11, (copy) v_u_24
					return v_u_11[v_u_24] and 2 or 1
				end)
			end
		end
	end
	v_u_8.observe(function(p28)
		-- upvalues: (copy) p_u_22, (ref) v_u_6
		if not p_u_22:worldChanged(p28) then
			v_u_6:remove("world_surge")
		end
	end)
end
return v9]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[WorldSurgeController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3736"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Enums.MultiplierTypes)
local v_u_3 = require(v1.Utility.Multiplier)
local v4 = require(v1.Utility.Network)
local v5 = {}
local v_u_6 = {
	["Start"] = v4.remoteEvent("RuneRoyaltyService/Start"),
	["Stop"] = v4.remoteEvent("RuneRoyaltyService/Stop")
}
local v_u_7 = false
function v5.init(_)
	-- upvalues: (copy) v_u_6, (ref) v_u_7, (copy) v_u_2, (copy) v_u_3
	v_u_6.Start.listen(function()
		-- upvalues: (ref) v_u_7
		v_u_7 = true
	end)
	v_u_6.Stop.listen(function()
		-- upvalues: (ref) v_u_7
		v_u_7 = false
	end)
	for _, v8 in { v_u_2.RuneOpenTimeMultiplier, v_u_2.ValentineRuneOpenTimeMultiplier } do
		v_u_3.assign(v8, function(_)
			-- upvalues: (ref) v_u_7
			return v_u_7 and 1.5 or 1
		end)
	end
end
return v5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RuneRoyaltyController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3737"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Passives]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3738"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Client.Data.DataController)
local v3 = require(v1.Config.ValentineTraitsData)
local v4 = require(v1.Packages.Signal)
local v5 = require(v1.Utility.Multiplier)
local v_u_7 = {
	["Equipped"] = nil,
	["Storage"] = {},
	["OnEquipped"] = v4.new(),
	["OnStorageUpdated"] = v4.new(),
	["getEquipped"] = function(p6)
		return p6.Equipped
	end
}
for v8, v9 in v2:getValue({ "ValentineTraits", "Storage" }) or {} do
	v_u_7.Storage[v8] = v9
	v_u_7.OnStorageUpdated:Fire(v8, v9)
end
v_u_7.Equipped = v2:getValue({ "ValentineTraits", "Equipped" })
v_u_7.OnEquipped:Fire(v_u_7.Equipped)
v2:onChange(function(_, p10, p11)
	-- upvalues: (copy) v_u_7
	if p10[1] == "ValentineTraits" then
		if p10[2] == "Storage" then
			local v12 = p10[3]
			v_u_7.Storage[v12] = p11 or 0
			v_u_7.OnStorageUpdated:Fire(v12, p11 or 0)
		end
		if p10[2] == "Equipped" then
			v_u_7.Equipped = p11
			v_u_7.OnEquipped:Fire(p11)
		end
	end
end)
for v_u_13, v14 in v3 do
	for _, v_u_15 in v14.Buffs do
		v5.assign(v_u_15.multiplier, function(_)
			-- upvalues: (copy) v_u_7, (copy) v_u_13, (copy) v_u_15
			if v_u_7:getEquipped() == v_u_13 then
				return v_u_15.value
			end
		end)
	end
end
return v_u_7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ValentineTraitController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3739"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Client.Data.DataController)
local v3 = require(v1.Config.MillionaireTraitsData)
local v4 = require(v1.Packages.Signal)
local v5 = require(v1.Utility.Multiplier)
local v_u_7 = {
	["Equipped"] = nil,
	["Storage"] = {},
	["OnEquipped"] = v4.new(),
	["OnStorageUpdated"] = v4.new(),
	["getEquipped"] = function(p6)
		return p6.Equipped
	end
}
for v8, v9 in v2:getValue({ "MillionaireTraits", "Storage" }) or {} do
	v_u_7.Storage[v8] = v9
	v_u_7.OnStorageUpdated:Fire(v8, v9)
end
v_u_7.Equipped = v2:getValue({ "MillionaireTraits", "Equipped" })
v_u_7.OnEquipped:Fire(v_u_7.Equipped)
v2:onChange(function(_, p10, p11)
	-- upvalues: (copy) v_u_7
	if p10[1] == "MillionaireTraits" then
		if p10[2] == "Storage" then
			local v12 = p10[3]
			v_u_7.Storage[v12] = p11 or 0
			v_u_7.OnStorageUpdated:Fire(v12, p11 or 0)
		end
		if p10[2] == "Equipped" then
			v_u_7.Equipped = p11
			v_u_7.OnEquipped:Fire(p11)
		end
	end
end)
for v_u_13, v14 in v3 do
	for _, v_u_15 in v14.Buffs do
		v5.assign(v_u_15.multiplier, function(_)
			-- upvalues: (copy) v_u_7, (copy) v_u_13, (copy) v_u_15
			if v_u_7:getEquipped() == v_u_13 then
				return v_u_15.value
			end
		end)
	end
end
return v_u_7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MillionaireTraitController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3740"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Valentine]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3741"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Client.Data.DataController)
local v_u_6 = {
	["Bloom"] = 0,
	["BloomUpdated"] = require(v1.Packages.Signal).new(),
	["get"] = function(p3)
		return p3.Bloom
	end,
	["observe"] = function(p4, p5)
		p5(p4:get())
		return p4.BloomUpdated:Connect(p5)
	end
}
v2:onSet({ "Bloom" }, function(p7)
	-- upvalues: (copy) v_u_6
	v_u_6.Bloom = p7
	v_u_6.BloomUpdated:Fire(p7)
end)
return v_u_6]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BloomController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3742"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Blessings]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3743"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.BlessingData)
return {
	["init"] = function(p3)
		-- upvalues: (copy) v_u_2
		for _, v4 in v_u_2 do
			if v4.Client then
				v4:Client(p3)
			end
		end
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BlessingController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3744"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TempBoosts]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3745"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Config.MultiplierData)
local v_u_4 = require(v1.Config.TempBoostData)
local v_u_5 = require(v1.Utility.Multiplier)
local v_u_6 = require(v1.Utility.PerkUtil)
local v_u_7 = require(v1.Utility.Time)
return {
	["Boosts"] = {},
	["getMultiplier"] = function(_, p8)
		-- upvalues: (copy) v_u_2, (copy) v_u_4
		local v9 = 0
		for v10 in v_u_2:getValue({ "TempBoosts" }) or {} do
			local v11 = v_u_4[v10]
			if v11 then
				for _, v12 in v11.Multipliers do
					if v12.type == p8 then
						if v12.mathType == "Add" then
							v9 = v9 + v12.value
						elseif v12.mathType == "Multiply" then
							v9 = (v9 <= 0 and 1 or v9) + (v12.value - 1)
						elseif v12.mathType == "Subtract" then
							v9 = v9 - v12.value
						end
					end
				end
			end
		end
		return v9
	end,
	["getDescriptions"] = function(_)
		-- upvalues: (copy) v_u_4, (copy) v_u_3
		local v13 = {}
		for v14, v15 in v_u_4 do
			local v16 = {}
			for _, v17 in v15.Multipliers do
				local v18 = v_u_3[v17.type]
				if v18 then
					if v17.mathType == "Add" then
						local v19 = ("+%* %*"):format(v17.value, v18.Name)
						table.insert(v16, v19)
					elseif v17.mathType == "Multiply" then
						local v20 = (v17.value - 1) * 100
						local v21 = ("+%*%% %*"):format(math.floor(v20), v18.Name)
						table.insert(v16, v21)
					elseif v17.mathType == "Subtract" then
						local v22 = ("-%* %*"):format(v17.value, v18.Name)
						table.insert(v16, v22)
					end
				end
			end
			v13[v14] = table.concat(v16, "\n")
		end
		return v13
	end,
	["init"] = function(p_u_23)
		-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_2, (copy) v_u_6, (copy) v_u_7
		local v_u_24 = p_u_23:getDescriptions()
		local v25 = {}
		for _, v26 in v_u_4 do
			for _, v_u_27 in v26.Multipliers do
				if not v25[v_u_27.type] then
					v25[v_u_27.type] = true
					v_u_5.assign(v_u_27.type, function()
						-- upvalues: (copy) p_u_23, (copy) v_u_27
						return p_u_23:getMultiplier(v_u_27.type)
					end)
				end
			end
		end
		for v28, v29 in v_u_2:getValue({ "TempBoosts" }) or {} do
			p_u_23.Boosts[v28] = v29
		end
		v_u_2:onChange(function(_, p30, p31, _)
			-- upvalues: (copy) p_u_23
			if p30[1] == "TempBoosts" then
				local v32 = p30[2]
				p_u_23.Boosts[v32] = p31
			end
		end)
		task.spawn(function()
			-- upvalues: (ref) v_u_4, (copy) p_u_23, (ref) v_u_6, (ref) v_u_7, (copy) v_u_24
			while true do
				local v33 = workspace:GetServerTimeNow()
				for v34, v35 in v_u_4 do
					local v36 = p_u_23.Boosts[v34]
					if v36 then
						local v37 = v_u_6
						local v38 = ("temp_%*"):format(v34)
						local v39 = {
							["Text"] = v_u_7.format(v36 - v33),
							["Icon"] = v35.Icon
						}
						local v40 = {
							["Title"] = v35.Name,
							["Description"] = v_u_24[v34]
						}
						v39.Tooltip = v40
						v37:update(v38, v39)
					else
						v_u_6:remove((("temp_%*"):format(v34)))
					end
				end
				task.wait(1)
			end
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TempBoostController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3746"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Leave]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3747"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("GuiService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Client.Data.DataController)
local v4 = require(v2.Utility.Network)
local v_u_5 = require(v2.Utility.Sound)
local v_u_6 = require(v2.Utility.UI)
local v7 = {}
local v_u_8 = {
	["claim"] = v4.remoteEvent("LeaveService/claim")
}
local v_u_9 = true
function v7.init(_)
	-- upvalues: (copy) v_u_6, (copy) v_u_3, (ref) v_u_9, (copy) v_u_1, (copy) v_u_5, (copy) v_u_8
	local v_u_10 = v_u_6:get("Persistent", "LeaveUI")
	local v11 = v_u_10.Container
	v_u_10.Enabled = false
	v_u_3:onSet({ "__leaveClaimed" }, function(p12)
		-- upvalues: (ref) v_u_9
		v_u_9 = p12
	end)
	v_u_1.MenuOpened:Connect(function()
		-- upvalues: (ref) v_u_9, (ref) v_u_5, (copy) v_u_10
		if not v_u_9 then
			v_u_5.play("LeaveSound")
			v_u_10.Enabled = true
		end
	end)
	v11.Buttons.Confirm.Activated:Connect(function()
		-- upvalues: (ref) v_u_9, (ref) v_u_8, (copy) v_u_10
		v_u_9 = true
		v_u_8.claim.fire()
		v_u_10.Enabled = false
	end)
end
return v7]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LeaveController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3748"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Event1M]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3749"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v_u_2.Client.Data.DataController)
local v4 = require(v_u_2.Config.MillionaireMilestoneData)
local v_u_5 = require(v_u_2.Config.MultiplierData)
local v_u_6 = require(v_u_2.Enums.LockTypes)
local v_u_7 = require(v_u_2.Functions.WaitFor)
local v_u_8 = require(v_u_2.Utility.Format)
local v_u_9 = require(v_u_2.Utility.LockUtil)
local v_u_10 = {}
local v11 = {}
for _, v12 in v4 do
	if v12.Unlocks then
		v_u_10[v12.Unlocks] = v12.Requirement
	end
end
local v_u_13 = v_u_7(workspace, "Persistent", "MILLIONAIRE_MILESTONE_BOARD")
local v_u_14 = v_u_7(v_u_13, "SurfaceGui")
local v_u_15 = v_u_7(v_u_14, "Title", "Tracking")
local v_u_16 = v_u_7(v_u_14, "ScrollingFrame")
local v_u_17 = v_u_7(v_u_16, "Template")
v_u_17.Visible = false
local v_u_18 = {}
for _, v19 in v4 do
	table.insert(v_u_18, v19)
end
table.sort(v_u_18, function(p20, p21)
	return p20.Order < p21.Order
end)
local v_u_22 = {}
function v11.init(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_6, (copy) v_u_10, (copy) v_u_3, (copy) v_u_7, (copy) v_u_2, (copy) v_u_8, (copy) v_u_18, (copy) v_u_17, (copy) v_u_5, (copy) v_u_16, (copy) v_u_22, (copy) v_u_15, (copy) v_u_14, (copy) v_u_13, (copy) v_u_1
	v_u_9.assign(v_u_6.Milestone, function(p23)
		-- upvalues: (ref) v_u_10, (ref) v_u_3
		local v24 = v_u_10[p23.value]
		return not v24 and true or v24 <= (v_u_3:getValue({ "MillionaireMilestones", "SlimesDefeated" }) or 0)
	end)
	local v_u_25 = v_u_7(workspace, "Persistent", "Event1MLocked")
	for _, v_u_26 in v_u_25:GetChildren() do
		local v27 = v_u_9.observe
		local v28 = {
			[v_u_6.Milestone] = {
				["value"] = v_u_26.Name
			}
		}
		v27(v28, function(p29)
			-- upvalues: (copy) v_u_26, (copy) v_u_25, (ref) v_u_2, (ref) v_u_8, (ref) v_u_10
			if v_u_26:IsA("BasePart") then
				v_u_26.Parent = p29 and v_u_25 or v_u_2
				v_u_26.SurfaceGui.Title.Text = ("Defeat %* Slimes to Unlock!"):format((v_u_8.abbreviateComma(v_u_10[v_u_26.Name])))
			end
		end)
	end
	for _, v30 in v_u_18 do
		local v31 = v_u_17:Clone()
		v31.Name = v30.Name
		v31.Visible = true
		v31.Requirement.Text = v_u_8.abbreviateComma(v30.Requirement) .. " Slimes"
		local v32 = v31.Frame.BuffTemplate
		v32.Visible = false
		for _, v33 in v30.Buffs do
			local v34 = v_u_5[v33.multiplier]
			local v35 = v32:Clone()
			v35.Visible = true
			if v34 then
				v35.Text = v34.Format(v33.value) .. " " .. v34.Name
			else
				local v36 = v33.value
				local v37 = tostring(v36)
				local v38 = v33.multiplier
				v35.Text = v37 .. " " .. tostring(v38)
			end
			v35.Parent = v31.Frame
		end
		v31.Parent = v_u_16
		local v39 = v_u_22
		local v40 = {
			["frame"] = v31,
			["requirement"] = v30.Requirement,
			["progress_bar"] = v31.Requirement.Frame
		}
		table.insert(v39, v40)
	end
	local function v_u_44(p41)
		-- upvalues: (ref) v_u_15, (ref) v_u_8, (ref) v_u_22
		v_u_15.Text = v_u_8.abbreviateComma(p41) .. " Slimes Defeated"
		for _, v42 in v_u_22 do
			local v43 = p41 / v42.requirement
			if math.clamp(v43, 0, 1) >= 1 then
				v42.frame.UIStroke.Color = Color3.new(0, 1, 0)
				v42.progress_bar.BackgroundColor3 = Color3.new(0, 1, 0)
				v42.progress_bar.UIStroke.Color = Color3.new(0, 1, 0)
				v42.frame.BackgroundTransparency = 0.5
			else
				v42.frame.UIStroke.Color = Color3.new(1, 1, 1)
				v42.progress_bar.BackgroundColor3 = Color3.new(1, 1, 1)
				v42.progress_bar.UIStroke.Color = Color3.new(1, 1, 1)
				v42.frame.BackgroundTransparency = 1
			end
		end
	end
	v_u_44(v_u_3:getValue({ "MillionaireMilestones", "SlimesDefeated" }) or 0)
	v_u_3:onChange(function(_, p45, p46)
		-- upvalues: (copy) v_u_44
		if p45[1] == "MillionaireMilestones" and p45[2] == "SlimesDefeated" then
			v_u_44(p46 or 0)
		end
	end)
	v_u_14.Adornee = v_u_13
	v_u_14.Parent = v_u_7(v_u_1.LocalPlayer, "PlayerGui")
end
return v11]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MillionaireMilestoneController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3750"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.UI.UIController)
local v_u_3 = require(v1.Packages.Observers)
local v_u_4 = require(v1.Utility.UI)
return {
	["init"] = function(_)
		-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_4
		v_u_3.observeTag("MillionaireAmulet", function(p_u_5)
			-- upvalues: (ref) v_u_2, (ref) v_u_4
			local v6 = Instance.new("ProximityPrompt")
			v6.UIOffset = Vector2.new(0, 999999)
			v6.RequiresLineOfSight = false
			v6.Parent = p_u_5
			v6.MaxActivationDistance = p_u_5:GetAttribute("Range") or 10
			v6.PromptShown:Connect(function()
				-- upvalues: (ref) v_u_2, (copy) p_u_5, (ref) v_u_4
				local v7 = v_u_2:get("BuySlimeAmulet")
				local v8 = p_u_5.Name
				v7:set("Millionaire", (tonumber(v8)))
				v_u_4:open("BuySlimeAmulet")
			end)
			v6.PromptHidden:Connect(function()
				-- upvalues: (ref) v_u_4
				if v_u_4.Current == "BuySlimeAmulet" then
					v_u_4:close(v_u_4.Current)
				end
			end)
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MillionaireAmuletController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3751"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Client.Data.DataController)
local v_u_6 = {
	["Ascension"] = 0,
	["AscensionUpdated"] = require(v1.Packages.Signal).new(),
	["get"] = function(p3)
		return p3.Ascension
	end,
	["observe"] = function(p4, p5)
		p5(p4:get())
		return p4.AscensionUpdated:Connect(p5)
	end
}
v2:onSet({ "Ascension" }, function(p7)
	-- upvalues: (copy) v_u_6
	v_u_6.Ascension = p7
	v_u_6.AscensionUpdated:Fire(p7)
end)
return v_u_6]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AscensionController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3752"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Candy]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3753"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Config.CandyData)
local v4 = require(v1.Config.CurrencyData)
local v_u_5 = require(v1.Packages.Observers)
local v_u_6 = require(v1.Utility.Format)
local v7 = require(v1.Utility.Network)
local v_u_8 = require(v1.Utility.Notify)
local v9 = {}
local v_u_10 = v7.remoteFunction("CandySlimeService/UnlockZone")
local v_u_11 = v4[v_u_3.CurrencyType]
function v9.setup(_, p_u_12)
	-- upvalues: (copy) v_u_3, (copy) v_u_6, (copy) v_u_11, (copy) v_u_2, (copy) v_u_10, (copy) v_u_8
	local v13 = p_u_12:GetAttribute("Zone")
	if v13 and typeof(v13) == "number" then
		local v_u_14 = v13 + 1
		local v_u_15 = v_u_3.Zones[v_u_14]
		if v_u_15 then
			local v16 = p_u_12:WaitForChild("ZoneGateUI")
			local v_u_17 = v16:WaitForChild("Challenges")
			local v18 = v_u_17:WaitForChild("Title")
			local v19 = v_u_17:WaitForChild("Template")
			local v_u_20 = v19:WaitForChild("Title")
			local v_u_21 = v19:WaitForChild("Progress"):WaitForChild("Bar")
			local v_u_22 = v16:WaitForChild("Purchase")
			local v23 = v_u_22:WaitForChild("Unlock")
			local v24 = v_u_22:WaitForChild("Cost"):WaitForChild("Title")
			local v25 = v_u_6.abbreviateComma(v_u_15.costToUnlock)
			if v_u_11 then
				v24.Text = ("%* %*"):format(v25, (v_u_11.GetPrefix(v_u_15.costToUnlock)))
			else
				v24.Text = ("%* Candy Coins"):format(v25)
			end
			v18.Text = ("Zone %*"):format(v13)
			local v_u_26 = v13 == 1
			local v_u_27 = v_u_15.killsRequired <= 0
			local v_u_28 = false
			local v_u_29
			if v_u_15.killsRequired > 0 then
				v_u_29 = v_u_2:onSet({ "Candy", "ZoneProgress", (tostring(v13)) }, function(p30)
					-- upvalues: (copy) v_u_15, (copy) v_u_20, (ref) v_u_6, (copy) v_u_21, (ref) v_u_27, (ref) v_u_28, (ref) v_u_26, (copy) v_u_17, (copy) v_u_22
					local v31 = p30 or 0
					local v32 = v_u_15.killsRequired
					local v33 = v31 / math.max(v32, 1)
					local v34 = math.clamp(v33, 0, 1)
					v_u_20.Text = ("%*/%* slimes defeated"):format(v_u_6.comma(v31), (v_u_6.comma(v32)))
					v_u_21.Size = UDim2.fromScale(v34, 1)
					v_u_27 = v34 >= 1
					if v_u_28 or not v_u_26 then
						v_u_17.Visible = false
						v_u_22.Visible = false
					else
						local v35 = v_u_17
						local v36
						if v_u_15.killsRequired > 0 then
							v36 = not v_u_27
						else
							v36 = false
						end
						v35.Visible = v36
						v_u_22.Visible = v_u_27
					end
				end)
			else
				v_u_29 = nil
			end
			local v_u_37
			if v13 > 1 then
				v_u_37 = v_u_2:onSet({ "Candy", "UnlockedZones", (tostring(v13)) }, function(p38)
					-- upvalues: (ref) v_u_26, (ref) v_u_28, (copy) v_u_17, (copy) v_u_22, (copy) v_u_15, (ref) v_u_27
					v_u_26 = p38 == true
					if v_u_28 or not v_u_26 then
						v_u_17.Visible = false
						v_u_22.Visible = false
					else
						local v39 = v_u_17
						local v40
						if v_u_15.killsRequired > 0 then
							v40 = not v_u_27
						else
							v40 = false
						end
						v39.Visible = v40
						v_u_22.Visible = v_u_27
					end
				end)
			else
				v_u_37 = nil
			end
			local v_u_44 = v_u_2:onSet({ "Candy", "UnlockedZones", (tostring(v_u_14)) }, function(p41)
				-- upvalues: (ref) v_u_28, (copy) p_u_12, (ref) v_u_26, (copy) v_u_17, (copy) v_u_22, (copy) v_u_15, (ref) v_u_27
				v_u_28 = p41 == true
				if v_u_28 then
					p_u_12:Destroy()
					return
				elseif v_u_28 or not v_u_26 then
					v_u_17.Visible = false
					v_u_22.Visible = false
				else
					local v42 = v_u_17
					local v43
					if v_u_15.killsRequired > 0 then
						v43 = not v_u_27
					else
						v43 = false
					end
					v42.Visible = v43
					v_u_22.Visible = v_u_27
				end
			end)
			local v_u_47 = v23.Activated:Connect(function()
				-- upvalues: (ref) v_u_10, (copy) v_u_14, (ref) v_u_8
				local v45, v46 = v_u_10.invoke(v_u_14)
				v_u_8.Notify({
					["Message"] = v46 or (v45 and "Zone unlocked!" or "Failed to unlock zone."),
					["Type"] = v45 and v_u_8.Types.Success or v_u_8.Types.Error
				})
			end)
			return function()
				-- upvalues: (ref) v_u_29, (ref) v_u_37, (copy) v_u_44, (copy) v_u_47
				if v_u_29 then
					v_u_29:Disconnect()
				end
				if v_u_37 then
					v_u_37:Disconnect()
				end
				if v_u_44 then
					v_u_44:Disconnect()
				end
				if v_u_47 then
					v_u_47:Disconnect()
				end
			end
		end
	end
end
function v9.init(p_u_48)
	-- upvalues: (copy) v_u_5
	v_u_5.observeTag("candyworldgate", function(p49)
		-- upvalues: (copy) p_u_48
		return p_u_48:setup(p49)
	end)
end
return v9]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CandyZoneGateController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3754"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Lighting")
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("RunService")
local v_u_5 = require(v_u_3.Config.PetAttributeData)
local v_u_6 = require(v_u_3.Config.PetSlimeData)
local v_u_7 = require(v_u_3.Config.RarityData)
local v8 = require(v_u_3.Enums.PetAttributeTypes)
local v_u_9 = require(v_u_3.Packages.Observers)
local v10 = require(v_u_3.Utility.Network)
local v_u_11 = require(v_u_3.Utility.Sound)
local v_u_12 = require(v_u_3.Utility.Spring)
local v_u_13 = require(v_u_3.Utility.UI)
local v14 = require(v_u_3.Packages.Signal)
local v_u_15 = {
	["AnimationStarted"] = v14.new(),
	["AnimationFinished"] = v14.new(),
	["_pendingRecoveryPet"] = nil
}
local v_u_16 = {
	["RequestRoll"] = v10.remoteFunction("PetRollService/RequestRoll")
}
local v_u_17 = {
	["RollResult"] = v10.remoteEvent("PetRollService/RollResult"),
	["PendingRollAvailable"] = v10.remoteEvent("PetRollService/PendingRollAvailable")
}
local v_u_18 = false
local v_u_19 = false
local v_u_20 = workspace.CurrentCamera
local v_u_21 = CFrame.Angles(0, 3.141592653589793, 0)
local v_u_22 = {
	[v8.PetAttackSpeed] = "PetAttackSpeed",
	[v8.PetDamage] = "PetDamagePercent",
	[v8.PetAgility] = "PetAgility",
	[v8.PetCoinMultiplier] = "PetCoinMultiplier",
	[v8.PetRange] = "PetRange",
	[v8.PetCritChance] = "PetCritChance"
}
local function v_u_25(p23, p24)
	if p23 == "PetAttackSpeed" then
		if p24 == 0 then
			return "0s", false
		else
			return string.format("-%.2fs", p24), true
		end
	elseif p23 == "PetDamagePercent" or p23 == "PetCritChance" then
		if p24 == 0 then
			return "0%", false
		else
			return string.format("+%.1f%%", p24 * 100), true
		end
	elseif p23 == "PetCoinMultiplier" then
		if p24 <= 1 then
			return "x1.00", false
		else
			return string.format("x%.2f", p24), true
		end
	elseif p23 == "PetAgility" then
		if p24 == 0 then
			return "0", false
		else
			return string.format("+%d", p24), true
		end
	elseif p23 == "PetRange" then
		if p24 == 0 then
			return "0", false
		else
			return string.format("+%.1f", p24), true
		end
	else
		return tostring(p24), p24 ~= 0
	end
end
local v_u_26 = {}
local v_u_27 = nil
local v_u_28 = nil
local function v_u_35(p29)
	-- upvalues: (copy) v_u_6, (copy) v_u_26
	local v30 = v_u_6.Pets[p29]
	if not (v30 and v30.Model) then
		return nil
	end
	if not v_u_26[p29] then
		v_u_26[p29] = {
			["available"] = {},
			["inUse"] = {}
		}
	end
	local v31 = v_u_26[p29]
	local v32
	if #v31.available > 0 then
		v32 = table.remove(v31.available)
	else
		v32 = v30.Model:Clone()
		for _, v33 in v32:GetDescendants() do
			if v33:IsA("BasePart") then
				v33.CastShadow = false
			end
		end
	end
	local v34 = v31.inUse
	table.insert(v34, v32)
	v32:ScaleTo(0.5)
	v32.Parent = workspace
	return v32
end
local function v_u_41(p36, p37)
	-- upvalues: (copy) v_u_3, (copy) v_u_26
	p37:ScaleTo(0.5)
	p37.Parent = v_u_3
	if v_u_26[p36] then
		local v38 = v_u_26[p36].inUse
		local v39 = table.find(v38, p37)
		if v39 then
			table.remove(v38, v39)
		end
		local v40 = v_u_26[p36].available
		table.insert(v40, p37)
	end
end
local function v_u_45()
	-- upvalues: (copy) v_u_26, (copy) v_u_3
	for _, v42 in v_u_26 do
		for _, v43 in v42.inUse do
			v43:ScaleTo(0.5)
			v43.Parent = v_u_3
			local v44 = v42.available
			table.insert(v44, v43)
		end
		v42.inUse = {}
	end
end
local function v_u_57(p46)
	-- upvalues: (copy) v_u_6, (copy) v_u_26, (copy) v_u_3
	local v47 = {}
	for _, v48 in p46 do
		v47[v48] = (v47[v48] or 0) + 1
	end
	for v49, v50 in v47 do
		local v51 = math.min(v50, 5)
		local v52 = v_u_6.Pets[v49]
		if v52 and v52.Model then
			if not v_u_26[v49] then
				v_u_26[v49] = {
					["available"] = {},
					["inUse"] = {}
				}
			end
			local v53 = v_u_26[v49]
			for _ = 1, v51 - (#v53.available + #v53.inUse) do
				local v54 = v52.Model:Clone()
				for _, v55 in v54:GetDescendants() do
					if v55:IsA("BasePart") then
						v55.CastShadow = false
					end
				end
				v54.Parent = v_u_3
				local v56 = v53.available
				table.insert(v56, v54)
			end
		end
	end
end
local function v_u_61(p58)
	-- upvalues: (copy) v_u_6, (copy) v_u_7
	local v59 = v_u_6.Pets[p58]
	if v59 then
		local v60 = v_u_7[v59.Rarity]
		if v60 then
			return v59.Name, v60.Name, v60.Color
		else
			return v59.Name, "???", Color3.new(1, 1, 1)
		end
	else
		return p58, "???", Color3.new(1, 1, 1)
	end
end
local function v_u_107(p62, p63)
	-- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_5, (copy) v_u_22, (copy) v_u_25
	local v64 = v_u_6.Pets[p62]
	local v65 = v_u_7[v64.Rarity]
	local v66 = Instance.new("Frame")
	v66.Name = "StatsPanel"
	v66.AnchorPoint = Vector2.new(0, 0.5)
	v66.Position = UDim2.fromScale(0.66, 0.48)
	v66.Size = UDim2.fromScale(0.16, 0)
	v66.AutomaticSize = Enum.AutomaticSize.Y
	v66.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
	v66.BackgroundTransparency = 1
	v66.BorderSizePixel = 0
	v66.ZIndex = 10
	v66.Parent = p63
	local v67 = Instance.new("UISizeConstraint")
	v67.MaxSize = Vector2.new(300, 420)
	v67.MinSize = Vector2.new(160, 0)
	v67.Parent = v66
	local v68 = Instance.new("UICorner")
	v68.CornerRadius = UDim.new(0, 18)
	v68.Parent = v66
	local v69 = Instance.new("UIStroke")
	v69.Thickness = 3.5
	v69.Color = v65.Color
	v69.Transparency = 1
	v69.Parent = v66
	local v70 = Instance.new("UIPadding")
	v70.PaddingTop = UDim.new(0, 14)
	v70.PaddingBottom = UDim.new(0, 14)
	v70.PaddingLeft = UDim.new(0, 14)
	v70.PaddingRight = UDim.new(0, 14)
	v70.Parent = v66
	local v71 = Instance.new("UIListLayout")
	v71.SortOrder = Enum.SortOrder.LayoutOrder
	v71.HorizontalAlignment = Enum.HorizontalAlignment.Center
	v71.Padding = UDim.new(0, 5)
	v71.Parent = v66
	local v72 = Instance.new("TextLabel")
	v72.Name = "Header"
	v72.Size = UDim2.new(1, 0, 0, 26)
	v72.BackgroundTransparency = 1
	v72.Font = Enum.Font.FredokaOne
	v72.TextSize = 20
	v72.TextXAlignment = Enum.TextXAlignment.Center
	v72.TextColor3 = Color3.fromRGB(255, 255, 255)
	v72.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	v72.TextStrokeTransparency = 1
	v72.TextTransparency = 1
	v72.Text = v64.Name
	v72.LayoutOrder = 0
	v72.ZIndex = 10
	v72.Parent = v66
	local v73 = Instance.new("Frame")
	v73.Name = "RarityBadge"
	v73.Size = UDim2.new(0.7, 0, 0, 22)
	v73.AnchorPoint = Vector2.new(0.5, 0)
	v73.BackgroundColor3 = v65.Color
	v73.BackgroundTransparency = 1
	v73.BorderSizePixel = 0
	v73.LayoutOrder = 1
	v73.ZIndex = 10
	v73.Parent = v66
	local v74 = Instance.new("UIListLayout")
	v74.FillDirection = Enum.FillDirection.Horizontal
	v74.HorizontalAlignment = Enum.HorizontalAlignment.Center
	v74.Parent = v73
	local v75 = Instance.new("UICorner")
	v75.CornerRadius = UDim.new(0, 10)
	v75.Parent = v73
	local v76 = Instance.new("UIStroke")
	v76.Thickness = 2
	v76.Color = Color3.fromRGB(255, 255, 255)
	v76.Transparency = 0.7
	v76.Parent = v73
	local v77 = Instance.new("TextLabel")
	v77.Name = "RarityText"
	v77.Size = UDim2.new(1, 0, 1, 0)
	v77.BackgroundTransparency = 1
	v77.Font = Enum.Font.FredokaOne
	v77.TextSize = 14
	v77.TextColor3 = Color3.fromRGB(255, 255, 255)
	v77.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	v77.TextStrokeTransparency = 1
	v77.TextTransparency = 1
	v77.Text = v65.Name
	v77.ZIndex = 11
	v77.Parent = v73
	local v78 = Instance.new("Frame")
	v78.Name = "Sep1"
	v78.Size = UDim2.new(1, 0, 0, 3)
	v78.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	v78.BorderSizePixel = 0
	v78.LayoutOrder = 2
	v78.ZIndex = 10
	v78.Parent = v66
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
	v80.TextTransparency = 1
	v80.LayoutOrder = 3
	v80.ZIndex = 10
	v80.Parent = v66
	local v81 = {}
	for v82, v83 in v_u_5 do
		table.insert(v81, {
			["type"] = v82,
			["data"] = v83
		})
	end
	table.sort(v81, function(p84, p85)
		return p84.data.Order < p85.data.Order
	end)
	for v86, v87 in v81 do
		local v88 = v_u_22[v87.type]
		if v88 then
			local v89, v90 = v_u_25(v88, v64.BaseStats and (v64.BaseStats[v88] or 0) or 0)
			local v91 = Instance.new("Frame")
			v91.Name = v87.type
			v91.Size = UDim2.new(1, 0, 0, 24)
			v91.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
			v91.BackgroundTransparency = 1
			v91.BorderSizePixel = 0
			v91.LayoutOrder = 10 + v86
			v91.ZIndex = 10
			v91.Parent = v66
			local v92 = Instance.new("UICorner")
			v92.CornerRadius = UDim.new(0, 8)
			v92.Parent = v91
			local v93 = Instance.new("UIPadding")
			v93.PaddingLeft = UDim.new(0, 6)
			v93.PaddingRight = UDim.new(0, 6)
			v93.Parent = v91
			local v94 = Instance.new("ImageLabel")
			v94.Size = UDim2.fromOffset(16, 16)
			v94.Position = UDim2.new(0, 0, 0.5, 0)
			v94.AnchorPoint = Vector2.new(0, 0.5)
			v94.BackgroundTransparency = 1
			v94.Image = v87.data.Icon
			v94.ImageTransparency = 1
			v94.ZIndex = 11
			v94.Parent = v91
			local v95 = Instance.new("TextLabel")
			v95.Size = UDim2.new(0.5, -20, 1, 0)
			v95.Position = UDim2.new(0, 20, 0, 0)
			v95.BackgroundTransparency = 1
			v95.Text = v87.data.Name
			v95.Font = Enum.Font.GothamBold
			v95.TextSize = 12
			v95.TextXAlignment = Enum.TextXAlignment.Left
			v95.TextColor3 = Color3.fromRGB(220, 220, 240)
			v95.TextTransparency = 1
			v95.ZIndex = 11
			v95.Parent = v91
			local v96 = Instance.new("TextLabel")
			v96.Name = "Value"
			v96.Size = UDim2.new(0.5, 0, 1, 0)
			v96.Position = UDim2.new(0.5, 0, 0, 0)
			v96.BackgroundTransparency = 1
			v96.Text = v89
			v96.Font = Enum.Font.FredokaOne
			v96.TextSize = 13
			v96.TextXAlignment = Enum.TextXAlignment.Right
			local v97
			if v90 then
				v97 = Color3.fromRGB(80, 255, 80)
			else
				v97 = Color3.fromRGB(90, 90, 110)
			end
			v96.TextColor3 = v97
			v96.TextTransparency = 1
			v96.ZIndex = 11
			v96.Parent = v91
		end
	end
	local v98 = Instance.new("Frame")
	v98.Name = "Sep2"
	v98.Size = UDim2.new(1, 0, 0, 3)
	v98.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	v98.BorderSizePixel = 0
	v98.LayoutOrder = 50
	v98.ZIndex = 10
	v98.Parent = v66
	local v99 = Instance.new("UICorner")
	v99.CornerRadius = UDim.new(0, 2)
	v99.Parent = v98
	local v100 = Instance.new("Frame")
	v100.Name = "ChanceRow"
	v100.Size = UDim2.new(1, 0, 0, 26)
	v100.BackgroundColor3 = Color3.fromRGB(40, 35, 20)
	v100.BackgroundTransparency = 1
	v100.BorderSizePixel = 0
	v100.LayoutOrder = 51
	v100.ZIndex = 10
	v100.Parent = v66
	local v101 = Instance.new("UICorner")
	v101.CornerRadius = UDim.new(0, 8)
	v101.Parent = v100
	local v102 = Instance.new("UIPadding")
	v102.PaddingLeft = UDim.new(0, 6)
	v102.PaddingRight = UDim.new(0, 6)
	v102.Parent = v100
	local v103 = Instance.new("TextLabel")
	v103.Size = UDim2.new(0.5, 0, 1, 0)
	v103.BackgroundTransparency = 1
	v103.Text = "Roll Chance"
	v103.Font = Enum.Font.GothamBold
	v103.TextSize = 12
	v103.TextXAlignment = Enum.TextXAlignment.Left
	v103.TextColor3 = Color3.fromRGB(220, 220, 240)
	v103.TextTransparency = 1
	v103.ZIndex = 11
	v103.Parent = v100
	local v104 = v64.Weight / v_u_6.TotalWeight * 100
	local v105
	if v104 >= 1 then
		v105 = string.format("%.1f%%", v104)
	elseif v104 >= 0.01 then
		v105 = string.format("%.2f%%", v104)
	else
		v105 = string.format("%.3f%%", v104)
	end
	local v106 = Instance.new("TextLabel")
	v106.Name = "Value"
	v106.Size = UDim2.new(0.5, 0, 1, 0)
	v106.Position = UDim2.new(0.5, 0, 0, 0)
	v106.BackgroundTransparency = 1
	v106.Text = v105
	v106.Font = Enum.Font.FredokaOne
	v106.TextSize = 15
	v106.TextXAlignment = Enum.TextXAlignment.Right
	v106.TextColor3 = Color3.fromRGB(255, 220, 50)
	v106.TextTransparency = 1
	v106.ZIndex = 11
	v106.Parent = v100
	return v66
end
local function v_u_111()
	-- upvalues: (copy) v_u_2, (copy) v_u_12
	local v108 = Instance.new("ScreenGui")
	v108.Name = "PetRevealUI"
	v108.IgnoreGuiInset = true
	v108.DisplayOrder = 100
	local v_u_109 = Instance.new("TextLabel")
	v_u_109.Name = "PetName"
	v_u_109.AnchorPoint = Vector2.new(0.5, 0)
	v_u_109.Size = UDim2.new(0.6, 0, 0, 50)
	v_u_109.Position = UDim2.fromScale(0.5, 0.58)
	v_u_109.BackgroundTransparency = 1
	v_u_109.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	v_u_109.TextSize = 42
	v_u_109.TextColor3 = Color3.new(1, 1, 1)
	v_u_109.TextStrokeColor3 = Color3.new(0, 0, 0)
	v_u_109.TextStrokeTransparency = 1
	v_u_109.TextTransparency = 1
	v_u_109.Text = ""
	v_u_109.Parent = v108
	local v_u_110 = Instance.new("TextLabel")
	v_u_110.Name = "RarityName"
	v_u_110.AnchorPoint = Vector2.new(0.5, 0)
	v_u_110.Size = UDim2.new(0.6, 0, 0, 36)
	v_u_110.Position = UDim2.new(0.5, 0, 0.58, 54)
	v_u_110.BackgroundTransparency = 1
	v_u_110.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	v_u_110.TextSize = 30
	v_u_110.TextColor3 = Color3.new(1, 1, 1)
	v_u_110.TextStrokeColor3 = Color3.new(0, 0, 0)
	v_u_110.TextStrokeTransparency = 1
	v_u_110.TextTransparency = 1
	v_u_110.Text = ""
	v_u_110.Parent = v108
	v108.Parent = v_u_2.LocalPlayer.PlayerGui
	task.defer(function()
		-- upvalues: (ref) v_u_12, (copy) v_u_109, (copy) v_u_110
		v_u_12.target(v_u_109, 0.7, 6, {
			["TextTransparency"] = 0,
			["TextStrokeTransparency"] = 0.3
		})
		v_u_12.target(v_u_110, 0.7, 6, {
			["TextTransparency"] = 0,
			["TextStrokeTransparency"] = 0.3
		})
	end)
	return v108, v_u_109, v_u_110
end
local function v_u_115(p112, p113)
	if p112.PrimaryPart then
		local v_u_114 = Instance.new("ParticleEmitter")
		v_u_114.Color = ColorSequence.new(p113)
		v_u_114.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0) })
		v_u_114.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.7, 0.2), NumberSequenceKeypoint.new(1, 1) })
		v_u_114.Lifetime = NumberRange.new(0.6, 1.2)
		v_u_114.Speed = NumberRange.new(6, 18)
		v_u_114.SpreadAngle = Vector2.new(360, 360)
		v_u_114.RotSpeed = NumberRange.new(-180, 180)
		v_u_114.Rate = 0
		v_u_114.LightEmission = 0.8
		v_u_114.LightInfluence = 0.2
		v_u_114.Parent = p112.PrimaryPart
		v_u_114:Emit(40)
		task.delay(2, function()
			-- upvalues: (copy) v_u_114
			v_u_114:Destroy()
		end)
	end
end
function v_u_15.playAnimation(_, p_u_116, p_u_117, p_u_118, p119)
	-- upvalues: (ref) v_u_18, (ref) v_u_19, (ref) v_u_27, (copy) v_u_12, (copy) v_u_13, (copy) v_u_57, (copy) v_u_15, (copy) v_u_111, (copy) v_u_20, (copy) v_u_35, (copy) v_u_21, (copy) v_u_4, (copy) v_u_61, (copy) v_u_1, (ref) v_u_28, (copy) v_u_115, (copy) v_u_107, (copy) v_u_41, (copy) v_u_45, (copy) v_u_11
	v_u_18 = true
	v_u_19 = false
	if v_u_27 then
		v_u_12.target(v_u_27, 1, 5, {
			["FarIntensity"] = 0.75,
			["InFocusRadius"] = 10,
			["NearIntensity"] = 0,
			["FocusDistance"] = 4
		})
	end
	v_u_13:hideAll()
	v_u_57(p_u_116)
	v_u_15.AnimationStarted:Fire()
	local v_u_120 = #p_u_116
	local v_u_121 = (p_u_118 - 1) * 3
	local v_u_122 = p_u_118 > 3 and (p119 and 0.4 or 0.12) > math.random() and 4 or 3
	local v_u_123, v_u_124, v_u_125 = v_u_111()
	local v126 = math.min(v_u_120, 3)
	local v_u_127 = v_u_20.CFrame
	local v_u_128 = {}
	local v_u_129 = 0
	local v_u_130 = false
	local v_u_131 = nil
	local v_u_132 = nil
	local v_u_133 = 0
	local v_u_134 = nil
	local v_u_135 = nil
	local v_u_136 = {}
	local v_u_137 = nil
	local v_u_138 = false
	local v_u_139 = 0
	local v_u_140 = false
	for v141 = 1, v126 do
		if p_u_116[v141] then
			local v142 = v_u_35(p_u_116[v141])
			if v142 then
				local v143 = {
					["model"] = v142,
					["petType"] = p_u_116[v141],
					["slotIndex"] = v141
				}
				table.insert(v_u_128, v143)
				local v144 = (v141 - 1) * 3
				local v145 = v_u_127 * CFrame.new(v144, 0, -4) * v_u_21
				local v146 = 1 - math.abs(v144) / 3
				v142:ScaleTo(math.max(0, v146) * 0.25 + 0.5)
				if v142.PrimaryPart then
					v142:PivotTo(v145)
				end
			end
		end
	end
	local v_u_147 = nil
	v_u_147 = v_u_4.RenderStepped:Connect(function(p148)
		-- upvalues: (ref) v_u_127, (ref) v_u_20, (ref) v_u_138, (ref) v_u_139, (ref) v_u_140, (ref) v_u_61, (copy) p_u_117, (copy) v_u_128, (copy) p_u_118, (ref) v_u_135, (copy) v_u_136, (ref) v_u_137, (ref) v_u_1, (ref) v_u_12, (ref) v_u_28, (ref) v_u_131, (ref) v_u_115, (ref) v_u_132, (ref) v_u_107, (ref) v_u_123, (copy) v_u_121, (ref) v_u_21, (ref) v_u_41, (ref) v_u_129, (ref) v_u_130, (ref) v_u_18, (ref) v_u_15, (ref) v_u_147, (copy) v_u_124, (copy) v_u_125, (ref) v_u_45, (ref) v_u_27, (ref) v_u_19, (ref) v_u_133, (copy) v_u_122, (copy) v_u_120, (copy) p_u_116, (ref) v_u_134, (ref) v_u_11, (ref) v_u_35
		v_u_127 = v_u_20.CFrame
		if v_u_138 then
			v_u_139 = v_u_139 + p148
			if not v_u_140 then
				v_u_140 = true
				local _, _, v149 = v_u_61(p_u_117)
				for v150 = #v_u_128, 1, -1 do
					local v151 = v_u_128[v150]
					if v151.slotIndex == p_u_118 then
						v_u_135 = v151
					else
						local v152 = v_u_136
						local v153 = {
							["model"] = v151.model,
							["petType"] = v151.petType,
							["slotIndex"] = v151.slotIndex,
							["yOffset"] = 0,
							["velocity"] = 0
						}
						table.insert(v152, v153)
						table.remove(v_u_128, v150)
					end
				end
				if v_u_135 then
					v_u_137 = Instance.new("ColorCorrectionEffect")
					v_u_137.Brightness = 0
					v_u_137.Parent = v_u_1
					v_u_12.target(v_u_137, 0.6, 10, {
						["Brightness"] = 0.4
					})
					task.delay(0.2, function()
						-- upvalues: (ref) v_u_137, (ref) v_u_12
						if v_u_137 then
							v_u_12.target(v_u_137, 0.8, 6, {
								["Brightness"] = 0
							})
						end
					end)
					v_u_28 = Instance.new("BloomEffect")
					v_u_28.Intensity = 0
					v_u_28.Size = 24
					v_u_28.Threshold = 0.8
					v_u_28.Parent = v_u_1
					v_u_12.target(v_u_28, 0.6, 8, {
						["Intensity"] = 1.2
					})
					task.delay(0.35, function()
						-- upvalues: (ref) v_u_28, (ref) v_u_12
						if v_u_28 then
							v_u_12.target(v_u_28, 0.8, 4, {
								["Intensity"] = 0.15
							})
						end
					end)
					v_u_131 = Instance.new("NumberValue")
					v_u_131.Value = 0.75
					v_u_131.Parent = v_u_135.model
					v_u_12.target(v_u_131, 0.5, 4, {
						["Value"] = 0.85
					})
					v_u_115(v_u_135.model, v149)
					v_u_132 = v_u_107(p_u_117, v_u_123)
					task.defer(function()
						-- upvalues: (ref) v_u_132, (ref) v_u_12
						if v_u_132 then
							v_u_12.target(v_u_132, 0.7, 5, {
								["Position"] = UDim2.fromScale(0.63, 0.48),
								["BackgroundTransparency"] = 0.05
							})
							for _, v154 in v_u_132:GetDescendants() do
								if v154:IsA("TextLabel") then
									v_u_12.target(v154, 0.7, 5, {
										["TextTransparency"] = 0,
										["TextStrokeTransparency"] = 0.5
									})
								elseif v154:IsA("ImageLabel") then
									v_u_12.target(v154, 0.7, 5, {
										["ImageTransparency"] = 0
									})
								elseif v154:IsA("UIStroke") then
									v_u_12.target(v154, 0.7, 5, {
										["Transparency"] = 0
									})
								end
							end
							for _, v155 in v_u_132:GetChildren() do
								if v155:IsA("Frame") and (v155.Name ~= "Sep1" and v155.Name ~= "Sep2") then
									if v155.Name == "RarityBadge" then
										v_u_12.target(v155, 0.7, 5, {
											["BackgroundTransparency"] = 0.15
										})
									else
										v_u_12.target(v155, 0.7, 5, {
											["BackgroundTransparency"] = 0
										})
									end
								end
							end
						end
					end)
				end
			end
			for v156 = #v_u_136, 1, -1 do
				local v157 = v_u_136[v156]
				v157.velocity = v157.velocity + p148 * 60
				v157.yOffset = v157.yOffset - v157.velocity * p148
				local v158 = v_u_121
				local v159 = (v157.slotIndex - 1) * 3 - v158
				local v160 = v_u_127 * CFrame.new(v159, v157.yOffset, -4) * v_u_21
				if v157.model.PrimaryPart then
					v157.model:PivotTo(v160)
				end
				if v157.yOffset < -12 then
					v_u_41(v157.petType, v157.model)
					table.remove(v_u_136, v156)
				end
			end
			if v_u_135 then
				v_u_129 = v_u_129 + p148
				local v161 = v_u_129 / 0.8
				local v162 = (1 - (1 - math.clamp(v161, 0, 1)) ^ 3) * 2 * 3.141592653589793 * 2
				local v163 = v_u_121
				local v164 = (v_u_135.slotIndex - 1) * 3 - v163
				local v165 = v_u_127 * CFrame.new(v164, 0, -4) * CFrame.Angles(0, 3.141592653589793 + v162, 0)
				if v_u_131 then
					v_u_135.model:ScaleTo(v_u_131.Value)
				end
				if v_u_135.model.PrimaryPart then
					v_u_135.model:PivotTo(v165)
				end
			end
			if not v_u_130 and v_u_139 >= 1 then
				v_u_130 = true
				for _, v166 in v_u_136 do
					v_u_41(v166.petType, v166.model)
				end
				table.clear(v_u_136)
				v_u_18 = false
				function v_u_15._pendingCleanup()
					-- upvalues: (ref) v_u_147, (ref) v_u_137, (ref) v_u_28, (ref) v_u_12, (ref) v_u_123, (ref) v_u_124, (ref) v_u_125, (ref) v_u_132, (ref) v_u_131, (ref) v_u_45, (ref) v_u_27, (ref) v_u_15
					v_u_147:Disconnect()
					if v_u_137 then
						v_u_137:Destroy()
						v_u_137 = nil
					end
					if v_u_28 then
						v_u_12.target(v_u_28, 1, 5, {
							["Intensity"] = 0
						})
						task.delay(0.5, function()
							-- upvalues: (ref) v_u_28
							if v_u_28 then
								v_u_28:Destroy()
								v_u_28 = nil
							end
						end)
					end
					if v_u_123 then
						v_u_12.target(v_u_124, 0.5, 6, {
							["TextTransparency"] = 1,
							["TextStrokeTransparency"] = 1
						})
						v_u_12.target(v_u_125, 0.5, 6, {
							["TextTransparency"] = 1,
							["TextStrokeTransparency"] = 1
						})
						if v_u_132 then
							v_u_12.target(v_u_132, 0.5, 6, {
								["BackgroundTransparency"] = 1
							})
							for _, v167 in v_u_132:GetDescendants() do
								if v167:IsA("TextLabel") then
									v_u_12.target(v167, 0.5, 6, {
										["TextTransparency"] = 1,
										["TextStrokeTransparency"] = 1
									})
								elseif v167:IsA("ImageLabel") then
									v_u_12.target(v167, 0.5, 6, {
										["ImageTransparency"] = 1
									})
								elseif v167:IsA("UIStroke") then
									v_u_12.target(v167, 0.5, 6, {
										["Transparency"] = 1
									})
								elseif v167:IsA("Frame") then
									v_u_12.target(v167, 0.5, 6, {
										["BackgroundTransparency"] = 1
									})
								end
							end
						end
						task.delay(0.5, function()
							-- upvalues: (ref) v_u_123
							if v_u_123 then
								v_u_123:Destroy()
								v_u_123 = nil
							end
						end)
					end
					if v_u_131 then
						v_u_131:Destroy()
						v_u_131 = nil
					end
					v_u_45()
					if v_u_27 then
						v_u_12.target(v_u_27, 1, 5, {
							["FarIntensity"] = 0,
							["InFocusRadius"] = 200,
							["NearIntensity"] = 0,
							["FocusDistance"] = 4
						})
					end
					v_u_15._pendingCleanup = nil
				end
				v_u_15.AnimationFinished:Fire(p_u_117)
			end
			return
		end
		if v_u_19 then
			v_u_19 = false
			v_u_133 = 4
		end
		v_u_133 = v_u_133 + p148
		local v168 = v_u_133 / 4
		local v169 = math.clamp(v168, 0, 1)
		local v170 = (1 - (1 - v169) ^ v_u_122) * v_u_121
		local v171 = v170 / 3 + 1
		local v172 = math.round(v171)
		local v173 = v_u_120
		local v174 = p_u_116[math.clamp(v172, 1, v173)]
		if v174 and v174 ~= v_u_134 then
			v_u_134 = v174
			local v175, v176, v177 = v_u_61(v174)
			v_u_124.Text = v175
			v_u_125.Text = v176
			v_u_125.TextColor3 = v177
			v_u_11.play("Reveal_Cycle", {
				["PlaybackSpeed"] = v169 * 0.6 + 0.8
			})
		end
		local v178 = v170 / 3
		local v179 = math.floor(v178) + 1
		local v180 = v179 - 2
		local v181 = math.max(1, v180)
		local v182 = v_u_120
		local v183 = v179 + 2
		local v184 = math.min(v182, v183)
		for v185 = #v_u_128, 1, -1 do
			local v186 = v_u_128[v185]
			if v186.slotIndex < v181 or v184 < v186.slotIndex then
				v_u_41(v186.petType, v186.model)
				table.remove(v_u_128, v185)
			end
		end
		for v187 = v181, v184 do
			local v188 = false
			for _, v189 in v_u_128 do
				if v189.slotIndex == v187 then
					v188 = true
					break
				end
			end
			if not v188 and p_u_116[v187] then
				local v190 = v_u_35(p_u_116[v187])
				if v190 then
					local v191 = v_u_128
					local v192 = {
						["model"] = v190,
						["petType"] = p_u_116[v187],
						["slotIndex"] = v187
					}
					table.insert(v191, v192)
				end
			end
		end
		for _, v193 in v_u_128 do
			local v194 = (v193.slotIndex - 1) * 3 - v170
			local v195 = v_u_127 * CFrame.new(v194, 0, -4) * v_u_21
			local v196 = 1 - math.abs(v194) / 3
			local v197 = math.max(0, v196) * 0.25 + 0.5
			v193.model:ScaleTo(v197)
			if v193.model.PrimaryPart then
				v193.model:PivotTo(v195)
			end
		end
		if v169 >= 1 then
			v_u_11.play("RuneBuy")
			v_u_138 = true
		end
	end)
end
function v_u_15.getPendingRecoveryPet(_)
	-- upvalues: (copy) v_u_15
	return v_u_15._pendingRecoveryPet
end
function v_u_15.clearPendingRecoveryPet(_)
	-- upvalues: (copy) v_u_15
	v_u_15._pendingRecoveryPet = nil
end
function v_u_15.skipAnimation(_)
	-- upvalues: (ref) v_u_18, (ref) v_u_19
	if v_u_18 then
		v_u_19 = true
	end
end
function v_u_15.requestRoll(_)
	-- upvalues: (ref) v_u_18, (copy) v_u_16
	if not v_u_18 then
		local _, _ = v_u_16.RequestRoll.invoke()
	end
end
function v_u_15.init(p_u_198)
	-- upvalues: (ref) v_u_27, (copy) v_u_1, (copy) v_u_17, (copy) v_u_15, (copy) v_u_9, (copy) v_u_13, (ref) v_u_18
	v_u_27 = Instance.new("DepthOfFieldEffect")
	v_u_27.FarIntensity = 0
	v_u_27.InFocusRadius = 200
	v_u_27.NearIntensity = 0
	v_u_27.FocusDistance = 4
	v_u_27.Parent = v_u_1
	v_u_17.RollResult.listen(function(p199)
		-- upvalues: (copy) p_u_198
		if p199 and (p199.sequence and (p199.winner and p199.winnerIndex)) then
			p_u_198:playAnimation(p199.sequence, p199.winner, p199.winnerIndex, p199.isLastRoll)
		end
	end)
	v_u_17.PendingRollAvailable.listen(function(p200)
		-- upvalues: (ref) v_u_15
		if p200 and p200.pendingPet then
			v_u_15._pendingRecoveryPet = p200.pendingPet
		end
	end)
	v_u_9.observeTag("RollingSlimes", function(p201)
		-- upvalues: (ref) v_u_13, (ref) v_u_18
		local v202 = Instance.new("ProximityPrompt")
		v202.UIOffset = Vector2.new(0, 999999)
		v202.RequiresLineOfSight = false
		v202.Parent = p201
		v202.MaxActivationDistance = p201:GetAttribute("Range") or 10
		v202.PromptShown:Connect(function()
			-- upvalues: (ref) v_u_13
			v_u_13:open("RollAPet")
		end)
		v202.PromptHidden:Connect(function()
			-- upvalues: (ref) v_u_18, (ref) v_u_13
			if not v_u_18 then
				if v_u_13.Current == "RollAPet" then
					v_u_13:close(v_u_13.Current)
				end
			end
		end)
	end)
end
return v_u_15]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PetRollController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3755"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Pets]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3756"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = require(v_u_2.Config.PetAttributeData)
local v_u_6 = require(v_u_2.Config.PetSlimeData)
local v_u_7 = require(v_u_2.Config.SlimeRaceData)
local v_u_8 = require(v_u_2.Enums.MultiplierTypes)
local v_u_9 = require(v_u_2.Enums.SettingTypes)
local v10 = require(v_u_2.Functions.WaitFor)
local v_u_11 = require(v_u_2.Utility.Multiplier)
local v12 = require(v_u_2.Utility.Network)
local v_u_13 = require(v_u_2.Utility.Spring)
local v_u_14 = require(v_u_2.Utility.WorldUtil)
local v_u_15 = require(v_u_2.Utility.ZoneUtil)
local v16 = require(v_u_2.Packages.Signal)
local v_u_17 = require(v_u_2.Client.Data.DataController)
local v_u_18 = require(v_u_2.Client.Settings.SettingsController)
local v19 = {
	["PetSpawned"] = v16.new(),
	["PetDespawned"] = v16.new()
}
local v_u_20 = v_u_1.LocalPlayer
local v_u_21 = v12.remoteEvent("PetCombatService/Position")
local v_u_22 = v12.remoteEvent("PetCombatService/Attack", true)
local v_u_23 = v12.remoteEvent("PetCombatService/LevelUp", true)
local v_u_24 = v12.remoteEvent("PetCombatService/Replicate", true)
local v_u_25 = v12.remoteEvent("SlimeSpawnEvent")
local v_u_26 = v12.remoteEvent("SlimeUpdateEvent")
local v_u_27 = v12.remoteEvent("SlimeClearEvent")
local v_u_28 = v10(v10(v_u_2, "Assets"), "RangePart")
local v_u_29 = {}
for _, v30 in v10(workspace, "Persistent", "Slimes"):GetChildren() do
	if v30:IsA("BasePart") then
		v_u_29[v30.Name] = v30
	end
end
local v_u_31 = nil
local v_u_32 = CFrame.new()
local v_u_33 = {}
local v_u_34 = Color3.fromRGB(150, 130, 255)
local v_u_35 = RaycastParams.new()
v_u_35.FilterType = Enum.RaycastFilterType.Exclude
v_u_35.FilterDescendantsInstances = {}
local function v_u_44()
	-- upvalues: (copy) v_u_1, (ref) v_u_31, (copy) v_u_33, (copy) v_u_35
	local v36 = {}
	for _, v37 in v_u_1:GetPlayers() do
		if v37.Character then
			local v38 = v37.Character
			table.insert(v36, v38)
		end
	end
	for _, v39 in {
		"normal-slime",
		"golden-slime",
		"diamond-slime",
		"rainbow-slime"
	} do
		local v40 = workspace:FindFirstChild(v39)
		if v40 then
			table.insert(v36, v40)
		end
	end
	if v_u_31 then
		local v41 = v_u_31
		table.insert(v36, v41)
	end
	for _, v42 in v_u_33 do
		local v43 = v42.model
		table.insert(v36, v43)
	end
	v_u_35.FilterDescendantsInstances = v36
end
v_u_1.PlayerAdded:Connect(function(p45)
	-- upvalues: (copy) v_u_44
	p45.CharacterAdded:Connect(function()
		-- upvalues: (ref) v_u_44
		v_u_44()
	end)
	p45.CharacterRemoving:Connect(function()
		-- upvalues: (ref) v_u_44
		v_u_44()
	end)
end)
local v_u_46 = v_u_31
local v_u_47 = 0
local v_u_48 = nil
local v_u_49 = nil
local v_u_50 = false
local v_u_51 = Vector3.new(0, 0, 0)
local v_u_52 = false
local v_u_53 = 2.1
local v_u_54 = {}
local v_u_55 = 0
local v_u_56 = nil
local v_u_57 = nil
for _, v58 in v_u_1:GetPlayers() do
	v58.CharacterAdded:Connect(function()
		-- upvalues: (copy) v_u_44
		v_u_44()
	end)
	v58.CharacterRemoving:Connect(function()
		-- upvalues: (copy) v_u_44
		v_u_44()
	end)
end
v_u_1.PlayerRemoving:Connect(function()
	-- upvalues: (copy) v_u_44
	v_u_44()
end)
local function v_u_71(p59)
	-- upvalues: (copy) v_u_54
	local v60 = (1 / 0)
	local v61 = nil
	local v62 = nil
	for v63, v64 in v_u_54 do
		local v65 = v64.X
		local v66 = v64.Z
		local v67 = Vector3.new(v65, 0, v66)
		local v68 = p59.X
		local v69 = p59.Z
		local v70 = (v67 - Vector3.new(v68, 0, v69)).Magnitude
		if v70 < v60 then
			v62 = v63
			v61 = v64
			v60 = v70
		end
	end
	return v61, v62
end
local function v_u_75(p72, p73)
	for _, v74 in p72:GetDescendants() do
		if v74:IsA("BasePart") then
			v74.Size = v74.Size * p73
		end
	end
end
function v19.spawnPet(p76, p77)
	-- upvalues: (copy) v_u_6, (copy) v_u_75, (ref) v_u_55, (copy) v_u_20, (ref) v_u_51, (ref) v_u_53, (ref) v_u_46, (copy) v_u_7, (copy) v_u_44, (copy) v_u_28, (copy) v_u_34, (copy) v_u_2, (ref) v_u_56, (ref) v_u_57, (copy) v_u_17
	p76:despawnPet()
	local v78 = v_u_6.Pets[p77]
	if v78 and v78.Model then
		local v79 = v78.Model:Clone()
		v_u_75(v79, 0.6)
		v79.Name = "PlayerPet"
		local _, v80 = v79:GetBoundingBox()
		v_u_55 = v80.Y / 2
		local v81 = v_u_20.Character
		local v82
		if v81 then
			local v83 = v81:FindFirstChild("HumanoidRootPart")
			if v83 then
				v82 = v83.Position
			else
				v82 = nil
			end
		else
			v82 = nil
		end
		if v82 then
			local v84 = v82.X + 2
			local v85 = v_u_53
			local v86 = v82.Z + 3
			v_u_51 = Vector3.new(v84, v85, v86)
			local v87 = v_u_55
			v79:PivotTo(CFrame.new(v_u_51 + Vector3.new(0, v87, 0)))
		end
		v79.Parent = workspace
		v_u_46 = v79
		v_u_7.captureOriginals(v79)
		p76:applySelectedRaceTransform()
		p76.PetSpawned:Fire(v79, p77)
		v_u_44()
		local v88 = v_u_28:Clone()
		v88.Name = "PetRangePart"
		v88.Color = v_u_34
		v88.Transparency = 0.85
		local v89 = v88.Size.X
		v88.Size = Vector3.new(v89, 0, 0)
		v88.Parent = v_u_2
		v_u_56 = v88
		v_u_57 = v88:WaitForChild("SurfaceGui"):WaitForChild("Frame"):WaitForChild("UIScale")
		p76:startFollow()
		if (v_u_17:getValue({ "Candy", "PetMode" }) or "Attack") == "Attack" then
			p76:showRange()
		end
	else
		warn("[PetController] No model found for pet: " .. tostring(p77))
	end
end
function v19.applySelectedRaceTransform(_)
	-- upvalues: (ref) v_u_46, (copy) v_u_17, (copy) v_u_7
	if v_u_46 then
		local v90 = (v_u_17:getValue({ "Candy", "RaceSlots" }) or {})[v_u_17:getValue({ "Candy", "RaceSelectedSlot" }) or "1"]
		if v90 and v_u_7.Races[v90] then
			v_u_7.applyRaceTransform(v_u_46, v90)
		else
			v_u_7.resetTransform(v_u_46)
		end
	else
		return
	end
end
function v19.despawnPet(p91)
	-- upvalues: (ref) v_u_48, (ref) v_u_49, (ref) v_u_46, (copy) v_u_44, (ref) v_u_56, (ref) v_u_57, (ref) v_u_51, (ref) v_u_55
	if v_u_48 then
		v_u_48:Disconnect()
		v_u_48 = nil
	end
	if v_u_49 then
		v_u_49:Disconnect()
		v_u_49 = nil
	end
	if v_u_46 then
		p91.PetDespawned:Fire()
		v_u_46:Destroy()
		v_u_46 = nil
		v_u_44()
	end
	if v_u_56 then
		v_u_56:Destroy()
		v_u_56 = nil
		v_u_57 = nil
	end
	v_u_51 = Vector3.new(0, 0, 0)
	v_u_55 = 0
end
function v19.showRange(_)
	-- upvalues: (ref) v_u_56, (copy) v_u_11, (copy) v_u_8, (copy) v_u_13
	if v_u_56 then
		v_u_56.Parent = workspace
		local v92 = v_u_56
		local v93 = v_u_56.Size.X
		v92.Size = Vector3.new(v93, 0, 0)
		local v94 = v_u_11.get(v_u_8.PetRange) * v_u_11.get(v_u_8.PetRangeMultiplier)
		local v95 = v_u_13.target
		local v96 = v_u_56
		local v97 = {}
		local v98 = v_u_56.Size.X
		local v99 = v94 * 2
		local v100 = v94 * 2
		v97.Size = Vector3.new(v98, v99, v100)
		v95(v96, 0.7, 5, v97)
	end
end
function v19.hideRange(_)
	-- upvalues: (ref) v_u_56, (copy) v_u_13, (copy) v_u_17, (copy) v_u_2
	if v_u_56 then
		local v101 = v_u_13.target
		local v102 = v_u_56
		local v103 = {}
		local v104 = v_u_56.Size.X
		v103.Size = Vector3.new(v104, 0, 0)
		v101(v102, 1, 5, v103)
		task.delay(0.5, function()
			-- upvalues: (ref) v_u_17, (ref) v_u_56, (ref) v_u_2
			if v_u_56 and (v_u_17:getValue({ "Candy", "PetMode" }) or "Attack") ~= "Attack" then
				v_u_56.Parent = v_u_2
			end
		end)
	end
end
function v19.updateRange(_)
	-- upvalues: (copy) v_u_17, (ref) v_u_56, (copy) v_u_11, (copy) v_u_8, (copy) v_u_13
	if v_u_56 and (v_u_17:getValue({ "Candy", "PetMode" }) or "Attack") == "Attack" then
		local v105 = v_u_11.get(v_u_8.PetRange) * v_u_11.get(v_u_8.PetRangeMultiplier)
		local v106 = v_u_13.target
		local v107 = v_u_56
		local v108 = {}
		local v109 = v_u_56.Size.X
		local v110 = v105 * 2
		local v111 = v105 * 2
		v108.Size = Vector3.new(v109, v110, v111)
		v106(v107, 1, 2, v108)
	end
end
function v19.startFollow(_)
	-- upvalues: (ref) v_u_48, (ref) v_u_49, (copy) v_u_3, (ref) v_u_46, (copy) v_u_20, (copy) v_u_11, (copy) v_u_8, (copy) v_u_17, (copy) v_u_71, (ref) v_u_51, (ref) v_u_53, (ref) v_u_32, (copy) v_u_35, (ref) v_u_55, (ref) v_u_56, (ref) v_u_47, (copy) v_u_21
	if v_u_48 then
		v_u_48:Disconnect()
	end
	if v_u_49 then
		v_u_49:Disconnect()
	end
	v_u_48 = v_u_3.Heartbeat:Connect(function(p112)
		-- upvalues: (ref) v_u_46, (ref) v_u_20, (ref) v_u_11, (ref) v_u_8, (ref) v_u_17, (ref) v_u_71, (ref) v_u_51, (ref) v_u_53, (ref) v_u_32, (ref) v_u_35, (ref) v_u_55, (ref) v_u_56
		if v_u_46 then
			local v113 = v_u_20.Character
			local v114
			if v113 then
				local v115 = v113:FindFirstChild("HumanoidRootPart")
				if v115 then
					v114 = v115.Position
				else
					v114 = nil
				end
			else
				v114 = nil
			end
			if v114 then
				local v116 = v_u_11.get(v_u_8.PetAgility) * v_u_11.get(v_u_8.PetAgilityMultiplier)
				local v117 = v_u_11.get(v_u_8.PetRange) * v_u_11.get(v_u_8.PetRangeMultiplier)
				local v118 = v_u_17:getValue({ "Candy", "PetMode" }) or "Attack"
				local v119
				if v118 == "Attack" then
					v119 = v_u_71(v_u_51)
					if v119 then
						local v120 = v119.X
						local v121 = v119.Z
						local v122 = Vector3.new(v120, 0, v121)
						local v123 = v_u_51.X
						local v124 = v_u_51.Z
						if (v122 - Vector3.new(v123, 0, v124)).Magnitude <= v117 * 0.8 then
							v119 = v_u_51
						end
					else
						local v125 = v_u_20.Character
						local v126
						if v125 then
							local v127 = v125:FindFirstChild("HumanoidRootPart")
							if v127 then
								local v128 = v127.CFrame:VectorToWorldSpace(Vector3.new(2, 0, 3))
								v126 = v127.Position + v128
							else
								v126 = nil
							end
						else
							v126 = nil
						end
						v119 = v126 or v114
					end
				else
					local v129 = v_u_20.Character
					local v130
					if v129 then
						local v131 = v129:FindFirstChild("HumanoidRootPart")
						if v131 then
							local v132 = v131.CFrame:VectorToWorldSpace(Vector3.new(2, 0, 3))
							v130 = v131.Position + v132
						else
							v130 = nil
						end
					else
						v130 = nil
					end
					v119 = v130 or v114
				end
				local v133 = v_u_51.X
				local v134 = v_u_51.Z
				local v135 = Vector3.new(v133, 0, v134)
				local v136 = v119.X
				local v137 = v119.Z
				local v138 = Vector3.new(v136, 0, v137)
				local v139 = (v138 - v135).Magnitude
				local v140 = v116 * p112
				if v139 > 0.1 then
					local v141 = (v138 - v135).Unit
					local v142 = math.min(v140, v139)
					local v143 = v_u_51.X + v141.X * v142
					local v144 = v_u_51.Z + v141.Z * v142
					local v145 = v_u_53
					v_u_51 = Vector3.new(v143, v145, v144)
					local v146 = v_u_51
					local v147 = v141.X
					local v148 = v141.Z
					local v149 = v146 + Vector3.new(v147, 0, v148)
					v_u_32 = CFrame.lookAt(v_u_51, v149)
				else
					local v150 = v_u_51.X
					local v151 = v_u_53
					local v152 = v_u_51.Z
					v_u_51 = Vector3.new(v150, v151, v152)
				end
				local v153 = v_u_51.X
				local v154 = v_u_51.Z
				local v155 = v_u_53 + 50
				local v156 = Vector3.new(v153, v155, v154)
				local v157 = workspace:Raycast(v156, Vector3.new(0, -100, 0), v_u_35)
				local v158
				if v157 then
					v158 = v157.Position.Y
				else
					v158 = v_u_53
				end
				local v159 = v139 > 0.5
				local v160 = tick() * (v159 and 6 or 3)
				local v161 = math.sin(v160)
				local v162 = math.abs(v161) * (v159 and 1.5 or 0.3)
				local v163 = v_u_51.X
				local v164 = v158 + v_u_55 + v162
				local v165 = v_u_51.Z
				local v166 = Vector3.new(v163, v164, v165)
				v_u_46:PivotTo(CFrame.new(v166) * (v_u_32 - v_u_32.Position))
				if v_u_56 and v118 == "Attack" then
					local v167 = v_u_56
					local v168 = v_u_51.X
					local v169 = v_u_51.Z
					v167.Position = Vector3.new(v168, v158, v169)
				end
			end
		else
			return
		end
	end)
	v_u_49 = v_u_3.Heartbeat:Connect(function()
		-- upvalues: (ref) v_u_47, (ref) v_u_21, (ref) v_u_51
		local v170 = tick()
		if v170 - v_u_47 >= 0.5 then
			v_u_47 = v170
			v_u_21.fire(v_u_51)
		end
	end)
end
function v19.onAttack(_, _)
	-- upvalues: (ref) v_u_46, (copy) v_u_13, (ref) v_u_57, (copy) v_u_11, (copy) v_u_8, (copy) v_u_4
	if v_u_46 then
		v_u_13.target(v_u_46, 0.6, 8, {
			["Scale"] = 0.8
		})
		task.delay(0.1, function()
			-- upvalues: (ref) v_u_46, (ref) v_u_13
			if v_u_46 then
				v_u_13.target(v_u_46, 0.6, 8, {
					["Scale"] = 1
				})
			end
		end)
		if v_u_57 then
			local v171 = v_u_11.get(v_u_8.PetAttackSpeed) / v_u_11.get(v_u_8.PetAttackSpeedMultiplier)
			local v172 = math.max(v171, 0.5)
			v_u_57.Scale = v172 < 0.5 and (1 - v172 / 0.5 or 0) or 0
			v_u_4:Create(v_u_57, TweenInfo.new(v172, Enum.EasingStyle.Linear), {
				["Scale"] = 1
			}):Play()
		end
	end
end
function v19.onLevelUp(_, _) end
function v19.spawnOtherPet(p173, p174, p175)
	-- upvalues: (copy) v_u_33, (copy) v_u_1, (copy) v_u_6, (copy) v_u_75, (ref) v_u_53, (ref) v_u_52, (copy) v_u_2, (copy) v_u_44
	if v_u_33[p174] and v_u_33[p174].petType ~= p175 then
		p173:despawnOtherPet(p174)
	end
	if v_u_33[p174] then
		return
	else
		local v176 = v_u_1:GetPlayerByUserId(p174)
		if v176 then
			local v177 = v_u_6.Pets[p175]
			if v177 and v177.Model then
				local v178 = v177.Model:Clone()
				v_u_75(v178, 0.6)
				v178.Name = "OtherPlayerPet_" .. tostring(p174)
				local _, v179 = v178:GetBoundingBox()
				local v180 = v179.Y / 2
				local v181 = v176.Character
				if v181 then
					v181 = v181:FindFirstChild("HumanoidRootPart")
				end
				local v182 = v181 and v181.Position or Vector3.new(0, 0, 0)
				local v183 = v182.X + 2
				local v184 = v_u_53
				local v185 = v182.Z + 3
				local v186 = Vector3.new(v183, v184, v185)
				v178:PivotTo(CFrame.new(v186 + Vector3.new(0, v180, 0)))
				local v187
				if v_u_52 then
					v187 = v_u_2
				else
					v187 = workspace
				end
				v178.Parent = v187
				v_u_33[p174] = {
					["model"] = v178,
					["petType"] = p175,
					["owner"] = v176,
					["position"] = v186,
					["facing"] = CFrame.new(),
					["halfHeight"] = v180
				}
				v_u_44()
			end
		else
			return
		end
	end
end
function v19.despawnOtherPet(_, p188)
	-- upvalues: (copy) v_u_33, (copy) v_u_44
	local v189 = v_u_33[p188]
	if v189 then
		v189.model:Destroy()
		v_u_33[p188] = nil
		v_u_44()
	end
end
function v19.setOtherPetsVisible(_, p190)
	-- upvalues: (copy) v_u_33, (copy) v_u_2
	for _, v191 in v_u_33 do
		local v192 = v191.model
		local v193
		if p190 then
			v193 = workspace
		else
			v193 = v_u_2
		end
		v192.Parent = v193
	end
end
function v19.init(p_u_194)
	-- upvalues: (copy) v_u_5, (copy) v_u_11, (copy) v_u_17, (copy) v_u_8, (copy) v_u_6, (copy) v_u_7, (copy) v_u_25, (copy) v_u_54, (copy) v_u_26, (copy) v_u_27, (copy) v_u_15, (ref) v_u_50, (copy) v_u_14, (copy) v_u_29, (ref) v_u_53, (ref) v_u_46, (copy) v_u_20, (ref) v_u_51, (ref) v_u_55, (copy) v_u_22, (copy) v_u_23, (copy) v_u_24, (copy) v_u_1, (copy) v_u_3, (copy) v_u_33, (copy) v_u_35, (copy) v_u_18, (copy) v_u_9, (ref) v_u_52
	for v_u_195, v_u_196 in v_u_5 do
		v_u_11.assign(v_u_196.MultiplierType, function()
			-- upvalues: (ref) v_u_17, (copy) v_u_195, (copy) v_u_196
			if v_u_17:getValue({ "Candy", "Pet" }) then
				local v197 = v_u_17:getValue({ "Candy", "PetAttributes", v_u_195 }) or 0
				if v197 ~= 0 then
					return v_u_196.CalculateValue(v197)
				end
			end
		end)
	end
	for v_u_198, v199 in {
		["PetAttackSpeed"] = v_u_8.PetAttackSpeed,
		["PetDamagePercent"] = v_u_8.PetDamagePercent,
		["PetAgility"] = v_u_8.PetAgility,
		["PetCoinMultiplier"] = v_u_8.PetCoinMultiplier,
		["PetRange"] = v_u_8.PetRange,
		["PetCritChance"] = v_u_8.PetCritChance
	} do
		v_u_11.assign(v199, function()
			-- upvalues: (ref) v_u_17, (ref) v_u_6, (copy) v_u_198
			local v200 = v_u_17:getValue({ "Candy", "Pet" })
			if v200 then
				local v201 = v_u_6.Pets[v200]
				if v201 and v201.BaseStats then
					local v202 = v201.BaseStats[v_u_198]
					if v202 and (v202 ~= 0 and (v202 ~= 1 or v_u_198 ~= "PetCoinMultiplier")) then
						return v202
					end
				end
			else
				return
			end
		end)
	end
	for _, v_u_203 in {
		v_u_8.PetAttackSpeed,
		v_u_8.PetDamagePercent,
		v_u_8.PetAgility,
		v_u_8.PetCoinMultiplier,
		v_u_8.PetRange,
		v_u_8.PetCritChance
	} do
		v_u_11.assign(v_u_203, function()
			-- upvalues: (ref) v_u_17, (ref) v_u_7, (copy) v_u_203, (ref) v_u_8
			if v_u_17:getValue({ "Candy", "Pet" }) then
				local v204 = v_u_17:getValue({ "Candy", "RaceSlots" })
				if v204 then
					local v205 = false
					local v206 = 0
					for v207, v208 in v204 do
						if v_u_17:getValue({ "Candy", "RaceUnlockedSlots", v207 }) then
							local v209 = v_u_7.Races[v208]
							if v209 and v209.StatBoosts then
								local v210 = v209.StatBoosts[v_u_203]
								if v210 then
									if v_u_203 == v_u_8.PetCoinMultiplier then
										if v205 then
											v206 = v206 * v210
										else
											v206 = v210
										end
									else
										v206 = v206 + v210
									end
									v205 = true
								end
							end
						end
					end
					if v205 then
						return v206
					end
				end
			else
				return
			end
		end)
	end
	v_u_25.listen(function(p211)
		-- upvalues: (ref) v_u_54
		if p211 and (p211.uid and p211.position) then
			v_u_54[p211.uid] = p211.position
		end
	end)
	v_u_26.listen(function(p212)
		-- upvalues: (ref) v_u_54
		for v213, v214 in p212 do
			if v214.health and v214.health <= 0 then
				v_u_54[v213] = nil
			end
		end
	end)
	v_u_27.listen(function()
		-- upvalues: (ref) v_u_54
		table.clear(v_u_54)
	end)
	v_u_17:onSet({ "Candy", "Pet" }, function(p215)
		-- upvalues: (copy) p_u_194
		if p215 then
			p_u_194:spawnPet(p215)
		else
			p_u_194:despawnPet()
		end
	end)
	v_u_17:onChange(function(_, p216)
		-- upvalues: (copy) p_u_194
		if p216[1] == "Candy" and (p216[2] == "RaceSlots" or p216[2] == "RaceSelectedSlot") then
			p_u_194:applySelectedRaceTransform()
		end
	end)
	v_u_11.observe(v_u_8.PetRange, function()
		-- upvalues: (copy) p_u_194
		p_u_194:updateRange()
	end)
	v_u_11.observe(v_u_8.PetRangeMultiplier, function()
		-- upvalues: (copy) p_u_194
		p_u_194:updateRange()
	end)
	v_u_15.observe("SLIME_ZONE", function()
		-- upvalues: (ref) v_u_50
		v_u_50 = true
		return function()
			-- upvalues: (ref) v_u_50
			v_u_50 = false
		end
	end)
	v_u_17:onSet({ "Candy", "PetMode" }, function(p217)
		-- upvalues: (copy) p_u_194
		if p217 == "Attack" then
			p_u_194:showRange()
		else
			p_u_194:hideRange()
		end
	end)
	v_u_14.observe(function(p218)
		-- upvalues: (ref) v_u_29, (ref) v_u_53, (ref) v_u_46, (ref) v_u_20, (ref) v_u_51, (ref) v_u_55
		local v219 = v_u_29[p218]
		if v219 then
			v_u_53 = v219.Position.Y + v219.Size.Y / 2
		else
			v_u_53 = 2.1
		end
		if v_u_46 then
			local v220 = v_u_20.Character
			local v221
			if v220 then
				local v222 = v220:FindFirstChild("HumanoidRootPart")
				if v222 then
					v221 = v222.Position
				else
					v221 = nil
				end
			else
				v221 = nil
			end
			if v221 then
				local v223 = v221.X + 2
				local v224 = v_u_53
				local v225 = v221.Z + 3
				v_u_51 = Vector3.new(v223, v224, v225)
				local v226 = v_u_55
				v_u_46:PivotTo(CFrame.new(v_u_51 + Vector3.new(0, v226, 0)))
			end
		end
	end)
	v_u_22.listen(function(p227)
		-- upvalues: (copy) p_u_194
		p_u_194:onAttack(p227)
	end)
	v_u_23.listen(function(p228)
		-- upvalues: (copy) p_u_194
		p_u_194:onLevelUp(p228)
	end)
	local v229 = v_u_17:getValue({ "Candy", "Pet" })
	if v229 then
		p_u_194:spawnPet(v229)
	end
	v_u_24.listen(function(p230)
		-- upvalues: (copy) p_u_194
		if p230 and (p230.player and p230.petType) then
			p_u_194:spawnOtherPet(p230.player, p230.petType)
		end
	end)
	v_u_1.PlayerRemoving:Connect(function(p231)
		-- upvalues: (copy) p_u_194
		p_u_194:despawnOtherPet(p231.UserId)
	end)
	v_u_3.Heartbeat:Connect(function(p232)
		-- upvalues: (ref) v_u_33, (ref) v_u_53, (ref) v_u_35
		for _, v233 in v_u_33 do
			if v233.model.Parent == workspace then
				local v234 = v233.owner.Character
				if v234 then
					local v235 = v234:FindFirstChild("HumanoidRootPart")
					if v235 then
						local v236 = v235.CFrame:VectorToWorldSpace(Vector3.new(2, 0, 3))
						local v237 = v235.Position + v236
						local v238 = v233.position.X
						local v239 = v233.position.Z
						local v240 = Vector3.new(v238, 0, v239)
						local v241 = v237.X
						local v242 = v237.Z
						local v243 = Vector3.new(v241, 0, v242)
						local v244 = (v243 - v240).Magnitude
						if v244 > 30 then
							local v245 = v237.X
							local v246 = v_u_53
							local v247 = v237.Z
							v233.position = Vector3.new(v245, v246, v247)
						else
							local v248 = p232 * 12
							if v244 > 0.1 then
								local v249 = (v243 - v240).Unit
								local v250 = math.min(v248, v244)
								local v251 = v233.position.X + v249.X * v250
								local v252 = v_u_53
								local v253 = v233.position.Z + v249.Z * v250
								v233.position = Vector3.new(v251, v252, v253)
								local v254 = v233.position
								local v255 = v249.X
								local v256 = v249.Z
								local v257 = v254 + Vector3.new(v255, 0, v256)
								v233.facing = CFrame.lookAt(v233.position, v257)
							end
						end
						local v258 = v233.position.X
						local v259 = v233.position.Z
						local v260 = v_u_53 + 50
						local v261 = Vector3.new(v258, v260, v259)
						local v262 = workspace:Raycast(v261, Vector3.new(0, -100, 0), v_u_35)
						local v263
						if v262 then
							v263 = v262.Position.Y
						else
							v263 = v_u_53
						end
						local v264 = v244 > 0.5
						local v265 = tick() * (v264 and 6 or 3)
						local v266 = math.sin(v265)
						local v267 = math.abs(v266) * (v264 and 1.5 or 0.3)
						local v268 = v233.position.X
						local v269 = v263 + v233.halfHeight + v267
						local v270 = v233.position.Z
						local v271 = Vector3.new(v268, v269, v270)
						local v272 = CFrame.new(v271) * (v233.facing - v233.facing.Position)
						v233.model:PivotTo(v272)
					end
				end
			end
		end
	end)
	v_u_18:observe(v_u_9.HideOtherPets, function(p273)
		-- upvalues: (ref) v_u_52, (copy) p_u_194
		v_u_52 = p273
		p_u_194:setOtherPetsVisible(not p273)
	end)
end
return v19]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PetController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3757"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Debris")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("SoundService")
local v_u_5 = game:GetService("TweenService")
local v6 = require(v2.Functions.WaitFor)
local v7 = require(v2.Utility.Network)
local v_u_8 = require(v2.Utility.Spring)
local v_u_9 = require(v2.Client.Gameplay.Sllimes.SlimeSpawnerController)
local v10 = {}
local v_u_11 = {
	["BlackHoleStart"] = v7.remoteEvent("PetPassive/BlackHoleStart", true),
	["BlackHoleStop"] = v7.remoteEvent("PetPassive/BlackHoleStop", true),
	["BlackHoleSuck"] = v7.remoteEvent("PetPassive/BlackHoleSuck", true),
	["MeteorStart"] = v7.remoteEvent("PetPassive/MeteorStart", true),
	["MeteorStrike"] = v7.remoteEvent("PetPassive/MeteorStrike", true),
	["MeteorStop"] = v7.remoteEvent("PetPassive/MeteorStop", true)
}
local v_u_12 = nil
local v_u_13 = Vector3.new(0, 0, 0)
local v_u_14 = nil
local v_u_15 = {}
local v_u_16 = {}
local v_u_17 = v6(v6(v2, "Assets", "PetPassives"), "Blackhole")
local v_u_18 = v6(v4, "SFX", "BlackHole")
function v10.startBlackHole(p19, p20)
	-- upvalues: (copy) v_u_17, (ref) v_u_13, (copy) v_u_18, (ref) v_u_12, (copy) v_u_8, (ref) v_u_14, (copy) v_u_3
	p19:stopBlackHole()
	local v21 = v_u_17:Clone()
	v_u_13 = p20.position + Vector3.new(0, 15, 0)
	v21:PivotTo(CFrame.new(v_u_13))
	v21.Parent = workspace
	local v22 = v_u_18:Clone()
	v22.Parent = v21.PrimaryPart
	v22:Play()
	v_u_12 = v21
	v21:ScaleTo(0.1)
	v_u_8.target(v21, 0.8, 1, {
		["Scale"] = 1
	})
	v_u_14 = v_u_3.Heartbeat:Connect(function()
		-- upvalues: (ref) v_u_12, (ref) v_u_13
		if v_u_12 and v_u_13 then
			local v23 = os.clock() * 1.5
			local v24 = math.sin(v23) * 0.5
			v_u_12:PivotTo(CFrame.new(v_u_13 + Vector3.new(0, v24, 0)))
		end
	end)
end
function v10.stopBlackHole(_)
	-- upvalues: (ref) v_u_14, (copy) v_u_15, (copy) v_u_16, (copy) v_u_9, (ref) v_u_13, (ref) v_u_12, (copy) v_u_8, (copy) v_u_1
	if v_u_14 then
		v_u_14:Disconnect()
		v_u_14 = nil
	end
	for _, v25 in v_u_15 do
		v25:Disconnect()
	end
	table.clear(v_u_15)
	for v26, v27 in v_u_16 do
		local v28 = v_u_9:get(v26)
		if v28 then
			v28.model:SetAttribute("blackhole_suck", nil)
			v28.model:ScaleTo(1)
			v28.model:PivotTo(CFrame.new(v27))
		end
	end
	table.clear(v_u_16)
	v_u_13 = Vector3.new(0, 0, 0)
	if v_u_12 then
		local v29 = v_u_12
		v_u_12 = nil
		v_u_8.target(v29, 0.8, 5, {
			["Scale"] = 0.1
		})
		v_u_1:AddItem(v29, 0.7)
	end
end
function v10.suckSlimes(_, p30)
	-- upvalues: (ref) v_u_12, (copy) v_u_15, (copy) v_u_9, (copy) v_u_16, (copy) v_u_3, (ref) v_u_13
	if v_u_12 then
		for _, v_u_31 in p30.uids do
			if not v_u_15[v_u_31] then
				local v32 = v_u_9:get(v_u_31)
				if v32 then
					local v_u_33 = v32.model
					v_u_33:SetAttribute("blackhole_suck", true)
					local v_u_34 = v_u_33:GetPivot().Position
					v_u_16[v_u_31] = v_u_34
					local v_u_35 = 0
					v_u_15[v_u_31] = v_u_3.Heartbeat:Connect(function(p36)
						-- upvalues: (ref) v_u_9, (copy) v_u_31, (ref) v_u_15, (ref) v_u_16, (ref) v_u_35, (ref) v_u_12, (ref) v_u_13, (copy) v_u_34, (copy) v_u_33
						if v_u_9:get(v_u_31) then
							v_u_35 = v_u_35 + p36
							local v37 = v_u_35 / 1.2
							local v38 = math.min(v37, 1)
							local v39 = v38 * v38 * v38
							local v40
							if v_u_12 then
								v40 = v_u_12:GetPivot().Position
							else
								v40 = v_u_13 or v_u_34
							end
							local v41 = v_u_34:Lerp(v40, v39)
							local v42 = 1 - v39 * 0.8
							v_u_33:PivotTo(CFrame.new(v41))
							v_u_33:ScaleTo(v42)
							if v38 >= 1 and v_u_15[v_u_31] then
								v_u_15[v_u_31]:Disconnect()
								v_u_15[v_u_31] = nil
							end
						else
							if v_u_15[v_u_31] then
								v_u_15[v_u_31]:Disconnect()
								v_u_15[v_u_31] = nil
							end
							v_u_16[v_u_31] = nil
						end
					end)
				end
			end
		end
	end
end
local v_u_43 = {
	Color3.fromRGB(255, 100, 50),
	Color3.fromRGB(255, 60, 30),
	Color3.fromRGB(255, 150, 50),
	Color3.fromRGB(200, 80, 255)
}
function v10.startMeteorRain(_, _) end
function v10.onMeteorStrike(p_u_44, p45)
	-- upvalues: (copy) v_u_43, (copy) v_u_5
	local v_u_46 = p45.position
	local v_u_47 = p45.impactRadius or 5
	local v48 = math.random()
	local v_u_49, v50
	if v48 < 0.5 then
		v_u_49 = math.random() * 1 + 1.5
		v50 = 0.45
	elseif v48 < 0.85 then
		v_u_49 = math.random() * 1.5 + 3
		v50 = 0.35
	else
		v_u_49 = math.random() * 1.5 + 5
		v50 = 0.25
	end
	local v51 = math.random() * 3.141592653589793 * 2
	local v52 = math.random() * 20 + 15
	local v53 = math.random() * 20 + 50
	local v54 = math.cos(v51) * v52
	local v55 = math.sin(v51) * v52
	local v56 = v_u_46 + Vector3.new(v54, v53, v55)
	local v_u_57 = v_u_43[math.random(#v_u_43)]
	local v_u_58 = Instance.new("Part")
	v_u_58.Shape = Enum.PartType.Ball
	v_u_58.Size = Vector3.new(1, 1, 1) * v_u_49
	v_u_58.Color = v_u_57
	v_u_58.Material = Enum.Material.Neon
	v_u_58.Anchored = true
	v_u_58.CanCollide = false
	v_u_58.CastShadow = false
	v_u_58.Position = v56
	v_u_58.Parent = workspace
	local v_u_59 = Instance.new("ParticleEmitter")
	v_u_59.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 220, 80)), ColorSequenceKeypoint.new(0.4, v_u_57), ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 20, 5)) })
	v_u_59.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, v_u_49 * 1.2), NumberSequenceKeypoint.new(1, 0) })
	v_u_59.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1) })
	v_u_59.Lifetime = NumberRange.new(0.15, 0.4)
	v_u_59.Rate = 100
	v_u_59.Speed = NumberRange.new(0, 2)
	v_u_59.SpreadAngle = Vector2.new(10, 10)
	v_u_59.Acceleration = Vector3.new(0, 5, 0)
	v_u_59.LightEmission = 1
	v_u_59.LightInfluence = 0
	v_u_59.Parent = v_u_58
	local v60 = Instance.new("PointLight")
	v60.Color = v_u_57
	v60.Brightness = 2
	v60.Range = v_u_49 * 4
	v60.Parent = v_u_58
	local v61 = v_u_5:Create(v_u_58, TweenInfo.new(v50, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		["Position"] = v_u_46
	})
	v61:Play()
	v61.Completed:Once(function()
		-- upvalues: (copy) v_u_59, (copy) v_u_58, (copy) p_u_44, (copy) v_u_46, (copy) v_u_47, (copy) v_u_57, (ref) v_u_49
		v_u_59.Enabled = false
		v_u_58:Destroy()
		p_u_44:createMeteorShockwave(v_u_46, v_u_47, v_u_57, v_u_49)
	end)
end
function v10.createMeteorShockwave(_, p62, p63, p64, p65)
	-- upvalues: (copy) v_u_5, (copy) v_u_1
	local v66 = p63 * 1.3
	local v67 = Instance.new("Part")
	v67.Shape = Enum.PartType.Ball
	v67.Size = Vector3.new(1, 1, 1) * p65 * 2
	v67.Position = p62
	v67.Color = Color3.fromRGB(255, 230, 160)
	v67.Material = Enum.Material.Neon
	v67.Anchored = true
	v67.CanCollide = false
	v67.CastShadow = false
	v67.Transparency = 0
	v67.Parent = workspace
	v_u_5:Create(v67, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["Size"] = Vector3.new(1, 1, 1) * (v66 * 2),
		["Transparency"] = 1
	}):Play()
	v_u_1:AddItem(v67, 0.4)
	local v68 = Instance.new("Part")
	v68.Shape = Enum.PartType.Cylinder
	local v69 = p65 * 2
	local v70 = p65 * 2
	v68.Size = Vector3.new(0.3, v69, v70)
	v68.CFrame = CFrame.new(p62 + Vector3.new(0, 0.3, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)
	v68.Color = p64
	v68.Material = Enum.Material.Neon
	v68.Anchored = true
	v68.CanCollide = false
	v68.CastShadow = false
	v68.Transparency = 0.1
	v68.Parent = workspace
	local v71 = v66 * 2
	v_u_5:Create(v68, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["Size"] = Vector3.new(0.3, v71, v71),
		["Transparency"] = 1
	}):Play()
	v_u_1:AddItem(v68, 0.6)
	local v72 = Instance.new("Part")
	v72.Shape = Enum.PartType.Cylinder
	v72.Size = Vector3.new(0.2, p65, p65)
	v72.CFrame = CFrame.new(p62 + Vector3.new(0, 0.3, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)
	v72.Color = Color3.fromRGB(255, 230, 160)
	v72.Material = Enum.Material.Neon
	v72.Anchored = true
	v72.CanCollide = false
	v72.CastShadow = false
	v72.Transparency = 0.3
	v72.Parent = workspace
	local v73 = v_u_5
	local v74 = TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v75 = {}
	local v76 = v71 * 1.2
	local v77 = v71 * 1.2
	v75.Size = Vector3.new(0.2, v76, v77)
	v75.Transparency = 1
	v73:Create(v72, v74, v75):Play()
	v_u_1:AddItem(v72, 0.75)
	local v78 = Instance.new("PointLight")
	v78.Color = p64
	v78.Brightness = 6
	v78.Range = v66 * 2.5
	v78.Parent = v67
	v_u_5:Create(v78, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["Brightness"] = 0
	}):Play()
	local v79 = Instance.new("Part")
	v79.Size = Vector3.new(0.5, 0.5, 0.5)
	v79.Position = p62
	v79.Transparency = 1
	v79.Anchored = true
	v79.CanCollide = false
	v79.Parent = workspace
	local v80 = Instance.new("ParticleEmitter")
	v80.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 80)), ColorSequenceKeypoint.new(0.5, p64), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 20, 5)) })
	v80.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, p65 * 1), NumberSequenceKeypoint.new(1, 0) })
	v80.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
	v80.Lifetime = NumberRange.new(0.4, 0.9)
	v80.Speed = NumberRange.new(15, 35)
	v80.SpreadAngle = Vector2.new(70, 70)
	v80.Acceleration = Vector3.new(0, -50, 0)
	v80.LightEmission = 1
	v80.LightInfluence = 0
	v80.Parent = v79
	local v81 = p65 * 12
	v80:Emit((math.floor(v81)))
	v80.Enabled = false
	v_u_1:AddItem(v79, 1.5)
end
function v10.stopMeteorRain(_) end
function v10.init(p_u_82)
	-- upvalues: (copy) v_u_11
	v_u_11.BlackHoleStart.listen(function(p83)
		-- upvalues: (copy) p_u_82
		p_u_82:startBlackHole(p83)
	end)
	v_u_11.BlackHoleStop.listen(function()
		-- upvalues: (copy) p_u_82
		p_u_82:stopBlackHole()
	end)
	v_u_11.BlackHoleSuck.listen(function(p84)
		-- upvalues: (copy) p_u_82
		p_u_82:suckSlimes(p84)
	end)
	v_u_11.MeteorStart.listen(function(p85)
		-- upvalues: (copy) p_u_82
		p_u_82:startMeteorRain(p85)
	end)
	v_u_11.MeteorStrike.listen(function(p86)
		-- upvalues: (copy) p_u_82
		p_u_82:onMeteorStrike(p86)
	end)
	v_u_11.MeteorStop.listen(function()
		-- upvalues: (copy) p_u_82
		p_u_82:stopMeteorRain()
	end)
end
return v10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PetPassiveController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3758"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = require(v2.Config.Constants)
local v_u_5 = require(v2.Config.PetSlimeData)
local v_u_6 = require(v2.Config.RarityData)
local v_u_7 = require(v2.Config.SlimeRaceData)
local v_u_8 = require(v2.Functions.CalculatePetXP)
local v9 = require(v2.Functions.WaitFor)
local v_u_10 = require(v2.Packages.Observers)
local v_u_11 = require(v2.Utility.Format)
local v_u_12 = require(v2.Client.Data.DataController)
local v_u_13 = require(v2.Client.Gameplay.Pets.PetController)
local v14 = {}
local v_u_15 = v1.LocalPlayer
local v_u_16 = v9(v9(v2, "Assets"), "Billboard", "SlimePet")
local v_u_17 = nil
local v_u_18 = {}
local function v_u_20()
	-- upvalues: (copy) v_u_18, (ref) v_u_17
	for _, v19 in v_u_18 do
		if typeof(v19) == "RBXScriptConnection" then
			v19:Disconnect()
		elseif typeof(v19) == "function" then
			v19()
		end
	end
	table.clear(v_u_18)
	if v_u_17 then
		v_u_17:Destroy()
		v_u_17 = nil
	end
end
local function v_u_25(p21)
	-- upvalues: (copy) v_u_12, (copy) v_u_4, (copy) v_u_8, (copy) v_u_11
	local v22 = v_u_12:getValue({ "Candy", "PetLevel" }) or 0
	local v23 = v_u_12:getValue({ "Candy", "PetXP" }) or 0
	if v_u_4.PET_LEVEL_CAP <= v22 then
		p21.Level.Text = ("Level %* (MAX)"):format(v22)
	else
		local v24 = v_u_8(v22 + 1)
		p21.Level.Text = ("Level %* (%*/%* XP)"):format(v22, v_u_11.abbreviateComma(v23), (v_u_11.abbreviateComma(v24)))
	end
end
local function v_u_32(p26)
	-- upvalues: (copy) v_u_15, (copy) v_u_7
	local v27 = v_u_15:GetAttribute("pet_passive_race")
	local v28 = p26.Template
	if v27 then
		local v29 = v_u_7.Races[v27]
		if v29 and v29.Passive then
			v28.Visible = true
			v28.Icon.Image = v29.Passive.Icon
			local v30 = v_u_15:GetAttribute("pet_passive_kills") or 0
			local v31 = v_u_15:GetAttribute("pet_passive_threshold") or 300
			v28.Overlay.Title.Text = ("%*/%*"):format(v30, v31)
		else
			v28.Visible = false
		end
	else
		v28.Visible = false
		return
	end
end
local function v_u_40(p33, p34)
	-- upvalues: (copy) v_u_15
	local v35 = v_u_15:GetAttribute("pet_passive_threshold") or 300
	local v36 = v_u_15:GetAttribute("pet_passive_cooldown")
	local v37 = p33.Template
	if not v36 then
		v37.Overlay.Title.Text = ("%*/%*"):format(p34 or 0, v35)
		local v38 = (p34 or 0) / v35
		local v39 = math.clamp(v38, 0, 1)
		v37.Overlay.UIGradient.Offset = Vector2.new(0, -(1 - v39))
	end
end
local function v_u_50(p41, p42)
	-- upvalues: (copy) v_u_15, (copy) v_u_11, (copy) v_u_3
	local v_u_43 = p41.Template
	if p42 then
		local v44 = p42 - workspace:GetServerTimeNow()
		if v44 > 0 then
			v_u_43.Overlay.UIGradient.Offset = Vector2.new(0, -1)
			local v45 = Instance.new("NumberValue")
			v45.Value = v44
			v45.Changed:Connect(function(p46)
				-- upvalues: (copy) v_u_43, (ref) v_u_11
				v_u_43.Overlay.Title.Text = v_u_11.decimal(p46, 1) .. "s"
			end)
			local v47 = TweenInfo.new(v44, Enum.EasingStyle.Linear)
			v_u_3:Create(v_u_43.Overlay.UIGradient, v47, {
				["Offset"] = Vector2.new(0, 0)
			}):Play()
			v_u_3:Create(v45, v47, {
				["Value"] = 0
			}):Play()
		end
	else
		local v48 = v_u_15:GetAttribute("pet_passive_kills") or 0
		local v49 = v_u_15:GetAttribute("pet_passive_threshold") or 300
		v_u_43.Overlay.Title.Text = ("%*/%*"):format(v48, v49)
		v_u_43.Overlay.UIGradient.Offset = Vector2.new(0, -1)
		return
	end
end
local function v_u_76(p51, p52)
	-- upvalues: (copy) v_u_20, (copy) v_u_5, (copy) v_u_6, (copy) v_u_16, (copy) v_u_25, (copy) v_u_32, (ref) v_u_17, (copy) v_u_18, (copy) v_u_12, (copy) v_u_10, (copy) v_u_15, (copy) v_u_40, (copy) v_u_50
	v_u_20()
	if p51 and p51.PrimaryPart then
		local v53 = v_u_5.Pets[p52]
		if v53 then
			local v54 = v_u_6[v53.Rarity]
			local v55 = v_u_16:Clone()
			v55.Adornee = p51.PrimaryPart
			v55.Title.Text = v53.Name
			if v54 and v54.Gradient then
				v55.Title.UIGradient.Color = v54.Gradient
			end
			v_u_25(v55)
			v_u_32(v55)
			v55.Parent = p51.PrimaryPart
			v_u_17 = v55
			local v56 = v_u_18
			local v57 = v_u_12
			local function v58()
				-- upvalues: (ref) v_u_17, (ref) v_u_25
				if v_u_17 then
					v_u_25(v_u_17)
				end
			end
			table.insert(v56, v57:onSet({ "Candy", "PetLevel" }, v58))
			local v59 = v_u_18
			local v60 = v_u_12
			local function v61()
				-- upvalues: (ref) v_u_17, (ref) v_u_25
				if v_u_17 then
					v_u_25(v_u_17)
				end
			end
			table.insert(v59, v60:onSet({ "Candy", "PetXP" }, v61))
			local v62 = v_u_18
			local v63 = v_u_10.observeAttribute
			local v64 = v_u_15
			local function v66(p65)
				-- upvalues: (ref) v_u_17, (ref) v_u_40
				if v_u_17 then
					v_u_40(v_u_17, p65)
				end
			end
			table.insert(v62, v63(v64, "pet_passive_kills", v66))
			local v67 = v_u_18
			local v68 = v_u_10.observeAttribute
			local v69 = v_u_15
			local function v71(p70)
				-- upvalues: (ref) v_u_17, (ref) v_u_50
				if v_u_17 then
					v_u_50(v_u_17, p70)
				end
			end
			table.insert(v67, v68(v69, "pet_passive_cooldown", v71))
			local v72 = v_u_18
			local v73 = v_u_10.observeAttribute
			local v74 = v_u_15
			local function v75()
				-- upvalues: (ref) v_u_17, (ref) v_u_32
				if v_u_17 then
					v_u_32(v_u_17)
				end
			end
			table.insert(v72, v73(v74, "pet_passive_race", v75))
		end
	else
		return
	end
end
function v14.init(_)
	-- upvalues: (copy) v_u_13, (copy) v_u_76, (copy) v_u_20, (copy) v_u_12
	v_u_13.PetSpawned:Connect(function(p77, p78)
		-- upvalues: (ref) v_u_76
		v_u_76(p77, p78)
	end)
	v_u_13.PetDespawned:Connect(function()
		-- upvalues: (ref) v_u_20
		v_u_20()
	end)
	local v_u_79 = v_u_12:getValue({ "Candy", "Pet" })
	if v_u_79 then
		task.defer(function()
			-- upvalues: (ref) v_u_76, (copy) v_u_79
			local v80 = workspace:FindFirstChild("PlayerPet")
			if v80 then
				v_u_76(v80, v_u_79)
			end
		end)
	end
end
return v14]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PetBillboardController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Folder" referent="3759"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Settings]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3760"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Client.Data.DataController)
local v3 = require(v1.Packages.Signal)
local v4 = require(v1.Utility.Network)
local v_u_5 = {
	["Settings"] = {},
	["OnSettingUpdated"] = v3.new()
}
local v_u_6 = v4.remoteEvent("SettingEvent")
function v_u_5.set(_, p7, p8)
	-- upvalues: (copy) v_u_6
	v_u_6.fire(p7, p8)
end
function v_u_5.get(p9, p10)
	return p9.Settings[p10]
end
function v_u_5.observe(p_u_11, p_u_12, p_u_13)
	p_u_13(p_u_11:get(p_u_12))
	return p_u_11.OnSettingUpdated:Connect(function(p14)
		-- upvalues: (copy) p_u_12, (copy) p_u_13, (copy) p_u_11
		if p14 == p_u_12 then
			p_u_13(p_u_11:get(p_u_12))
		end
	end)
end
for v15, v16 in v2:getValue({ "Settings" }) or {} do
	v_u_5.Settings[v15] = v16
	v_u_5.OnSettingUpdated:Fire(v15, v16)
end
v2:onChange(function(_, p17, p18, _)
	-- upvalues: (copy) v_u_5
	if p17[1] == "Settings" then
		local v19 = p17[2]
		v_u_5.Settings[v19] = p18
		v_u_5.OnSettingUpdated:Fire(v19, p18)
	end
end)
return v_u_5]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SettingsController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="3761"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UI]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3762"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ExperienceNotificationService")
local v_u_3 = require(v1.Packages.Topbarplus)
return {
	["init"] = function(_)
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		task.spawn(function()
			-- upvalues: (ref) v_u_3, (ref) v_u_2
			local v_u_4 = v_u_3.new()
			v_u_4:setImage(134621835128949)
			v_u_4:setRight()
			v_u_4.selected:Connect(function()
				-- upvalues: (ref) v_u_2, (copy) v_u_4
				pcall(function()
					-- upvalues: (ref) v_u_2
					v_u_2:PromptOptIn()
				end)
				v_u_4:deselect()
			end)
			local v5, v6 = pcall(function()
				-- upvalues: (ref) v_u_2
				return v_u_2:CanPromptOptInAsync()
			end)
			v_u_4:setEnabled(v5 and v6)
			v_u_2.OptInPromptClosed:Connect(function(...)
				-- upvalues: (copy) v_u_4, (ref) v_u_2
				task.delay(1, function()
					-- upvalues: (ref) v_u_4, (ref) v_u_2
					local v7 = v_u_4
					local v8, v9 = pcall(function()
						-- upvalues: (ref) v_u_2
						return v_u_2:CanPromptOptInAsync()
					end)
					v7:setEnabled(v8 and v9)
				end)
			end)
		end)
	end
}]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[NotificationController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3763"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.Constants)
local v_u_3 = require(v1.Utility.UI)
local v4 = {}
local v_u_5 = {}
function v4.open(_, p6, p7)
	-- upvalues: (copy) v_u_3, (copy) v_u_5
	local v8 = v_u_3:get(p7, p6)
	if v8 then
		v8.Enabled = true
	end
	if v_u_5[p6] and v_u_5[p6].close then
		v_u_5[p6]:open()
	else
		warn((("[%*] %* doesn\'t have a module!"):format(script.Name, p6)))
	end
end
function v4.close(_, p9, p10)
	-- upvalues: (copy) v_u_3, (copy) v_u_5
	v_u_3:get(p10, p9)
	if v_u_5[p9] and v_u_5[p9].close then
		v_u_5[p9]:close()
	else
		warn((("[%*] %* doesn\'t have a module!"):format(script.Name, p9)))
	end
end
function v4.get(_, p11)
	-- upvalues: (copy) v_u_5
	if not v_u_5[p11] then
		repeat
			task.wait()
		until v_u_5[p11] ~= nil
	end
	return v_u_5[p11]
end
function v4.init(p_u_12)
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_3
	for _, v_u_13 in script:QueryDescendants("ModuleScript") do
		local v_u_14 = false
		task.delay(3, function()
			-- upvalues: (ref) v_u_14, (copy) v_u_13
			if not v_u_14 then
				warn((("[%*]: %* took too long to load."):format(script.Name, v_u_13.Name)))
			end
		end)
		local v15 = require(v_u_13)
		v15:init()
		v_u_5[v_u_13.Name] = v15
		if v15.close then
			v15:close()
		end
		v_u_14 = true
		if v_u_2.DEBUG_MODE.UI then
			print((("\226\156\133 %* initialized successfully."):format(v_u_13.Name)))
		end
	end
	v_u_3.Initalised = true
	for _, v16 in v_u_3.CurrentHUDS do
		p_u_12:open(v16, "Huds")
	end
	v_u_3.OnUIOpened:Connect(function(p17)
		-- upvalues: (copy) p_u_12
		p_u_12:open(p17, "Gui")
	end)
	v_u_3.OnUIClosed:Connect(function(p18)
		-- upvalues: (copy) p_u_12
		p_u_12:close(p18, "Gui")
	end)
	v_u_3.OnHUDShow:Connect(function(p19)
		-- upvalues: (copy) p_u_12
		p_u_12:open(p19, "Huds")
	end)
	v_u_3.OnHUDHidden:Connect(function(p20)
		-- upvalues: (copy) p_u_12
		p_u_12:close(p20, "Huds")
	end)
end
return v4]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UIController]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Folder" referent="3764"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Gui]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="3765"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Settings.SettingsController)
local v_u_3 = require(v1.Client.Data.DataController)
local v_u_4 = require(v1.Config.Colors)
local v_u_5 = require(v1.Config.SettingData)
local v_u_6 = require(v1.Config.SettingsCategoryData)
local v_u_7 = require(v1.Packages.Topbarplus)
local v_u_8 = require(v1.Utility.LockUtil)
local v_u_9 = require(v1.Utility.Spring)
local v_u_10 = require(v1.Utility.UI)
local v11 = {}
local v_u_12 = v_u_10:get("Gui", "Settings").Container
local v_u_13 = v_u_12.Container.ScrollingFrame
local v_u_14 = v_u_12.Position
local v_u_15 = v_u_14 + UDim2.fromScale(0, 1)
function v11.open(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_12, (copy) v_u_14
	local v16 = {
		["Position"] = v_u_14,
		["Visible"] = true
	}
	v_u_9.target(v_u_12, 0.8, 5, v16)
end
function v11.close(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_12, (copy) v_u_15
	local v17 = {
		["Position"] = v_u_15,
		["Visible"] = false
	}
	v_u_9.target(v_u_12, 0.8, 5, v17)
end
function v11.setupSettings(_)
	-- upvalues: (copy) v_u_13, (copy) v_u_4, (copy) v_u_6, (copy) v_u_5, (copy) v_u_8, (copy) v_u_2, (copy) v_u_3
	local v18 = v_u_13.Template
	local v19 = v_u_13.CategoryTemplate
	local function v_u_22(p20, p21)
		-- upvalues: (ref) v_u_4
		p20.UIGradient.Color = p21 and v_u_4.Green.Gradient or v_u_4.Red.Gradient
		p20.UIStroke.Color = p21 and v_u_4.Green.Stroke or v_u_4.Red.Stroke
		p20.Cost.UIStroke.Color = p21 and v_u_4.Green.Stroke or v_u_4.Red.Stroke
		p20.Cost.Text = p21 and "ON" or "OFF"
	end
	local v23 = {}
	for v24, v25 in v_u_6 do
		local v26 = v19:Clone()
		v26.Title.Text = v25.Name
		v26.Visible = true
		v26.LayoutOrder = v25.Order * 1000
		v26.Parent = v_u_13
		v23[v24] = v26.LayoutOrder
	end
	for v_u_27, v28 in v_u_5 do
		local v_u_29 = v18:Clone()
		v_u_29.Visible = true
		v_u_29.LayoutOrder = (v23[v28.Category] or 0) + (v28.Order or 0)
		v_u_29.Parent = v_u_13
		v_u_29.Title.Text = v28.Name
		v_u_29.Description.Text = v28.Description or ""
		local v_u_30 = v28.Default
		if v28.ShowData then
			v_u_8.observe(v28.ShowData, function(p31)
				-- upvalues: (copy) v_u_29
				v_u_29.Visible = not p31
			end)
		end
		if v28.Options then
			local v32 = v_u_29.Select
			local v33 = v_u_30
			v32.UIGradient.Color = v_u_4.Green.Gradient
			v32.UIStroke.Color = v_u_4.Green.Stroke
			v32.Cost.UIStroke.Color = v_u_4.Green.Stroke
			v32.Cost.Text = v33 == "Auto" and "Auto" or "Zone " .. v33
			v_u_2:observe(v_u_27, function(p34)
				-- upvalues: (copy) v_u_29, (ref) v_u_4, (ref) v_u_30
				local v35 = v_u_29.Select
				v35.UIGradient.Color = v_u_4.Green.Gradient
				v35.UIStroke.Color = v_u_4.Green.Stroke
				v35.Cost.UIStroke.Color = v_u_4.Green.Stroke
				v35.Cost.Text = p34 == "Auto" and "Auto" or "Zone " .. p34
				v_u_30 = p34
			end)
			v_u_29.Select.Activated:Connect(function()
				-- upvalues: (ref) v_u_3, (ref) v_u_30, (ref) v_u_2, (copy) v_u_27
				local v36 = v_u_3:getValue({ "Candy", "UnlockedZones" }) or {}
				local v37 = { "Auto" }
				for v38 = 1, 6 do
					if v36[tostring(v38)] then
						local v39 = tostring(v38)
						table.insert(v37, v39)
					end
				end
				v_u_2:set(v_u_27, v37[(table.find(v37, v_u_30) or 1) % #v37 + 1])
			end)
		else
			v_u_22(v_u_29.Select, v_u_30)
			v_u_2:observe(v_u_27, function(p40)
				-- upvalues: (copy) v_u_22, (copy) v_u_29, (ref) v_u_30
				v_u_22(v_u_29.Select, p40)
				v_u_30 = p40
			end)
			v_u_29.Select.Activated:Connect(function()
				-- upvalues: (ref) v_u_2, (copy) v_u_27, (ref) v_u_30
				v_u_2:set(v_u_27, not v_u_30)
			end)
		end
	end
	v18:Destroy()
	v19:Destroy()
end
function v11.init(p41)
	-- upvalues: (copy) v_u_7, (copy) v_u_10
	p41:setupSettings()
	local v_u_42 = v_u_7.new()
	v_u_42:setImage("rbxassetid://140209010799082")
	v_u_42.selected:Connect(function()
		-- upvalues: (ref) v_u_10, (copy) v_u_42
		if v_u_10.Current == script.Name then
			v_u_10:close(script.Name)
		else
			v_u_10:open(script.Name)
		end
		v_u_42:deselect()
	end)
end
return v11]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Settings]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3766"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("AdService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = require(v2.Client.Currency.CurrencyController)
local v_u_6 = require(v2.Client.Currency.TokenController)
local v_u_7 = require(v2.Client.Data.DataController)
local v_u_8 = require(v2.Client.Data.Statistics.StatisticController)
local v_u_9 = require(v2.Client.Gameplay.Potion.PotionController)
local v_u_10 = require(v2.Client.Misc.ServerLuckController)
local v_u_11 = require(v2.Config.Colors)
local v_u_12 = require(v2.Config.Constants)
local v_u_13 = require(v2.Config.GamepassData)
local v_u_14 = require(v2.Config.IndexToGlobalRuneAmount)
local v_u_15 = require(v2.Config.ItemData)
local v_u_16 = require(v2.Config.PotionData)
local v_u_17 = require(v2.Config.RuneData)
local v_u_18 = require(v2.Config.RuneOpenData)
local v_u_19 = require(v2.Config.ServerLuckData)
local v_u_20 = require(v2.Config.ShardsPackData)
local v_u_21 = require(v2.Config.StorePackData)
local v_u_22 = require(v2.Enums.CurrencyTypes)
local v_u_23 = require(v2.Enums.MultiplierTypes)
local v_u_24 = require(v2.Enums.Products)
local v_u_25 = require(v2.Enums.StatisticTypes)
local v_u_26 = require(v2.Packages.Sift)
local v_u_27 = require(v2.Utility.Format)
local v_u_28 = require(v2.Utility.GamepassUtil)
local v_u_29 = require(v2.Utility.LockUtil)
local v_u_30 = require(v2.Utility.Marketplace)
local v_u_31 = require(v2.Utility.Multiplier)
local v_u_32 = require(v2.Utility.Network)
local v_u_33 = require(v2.Utility.Notify)
local v_u_34 = require(v2.Utility.PlayerListUtil)
local v_u_35 = require(v2.Utility.PolicyUtil)
local v_u_36 = require(v2.Utility.ProductUtil)
local v_u_37 = require(v2.Utility.RewardPopupUtil)
local v_u_38 = require(v2.Utility.ConfirmationUtil)
local v_u_39 = require(v2.Utility.Sound)
local v_u_40 = require(v2.Utility.Spring)
local v_u_41 = require(v2.Utility.Time)
local v_u_42 = require(v2.Utility.UI)
local v43 = {}
local v_u_44 = v_u_42:get("Gui", "Store").Container
local v_u_45 = v_u_44.Container.ScrollingFrame
local v_u_46 = v_u_44.Header
local v_u_47 = v_u_44.Position
local v_u_48 = v_u_47 + UDim2.fromScale(0, 1)
local v_u_49 = {}
local v_u_50 = {}
local v_u_51 = v_u_32.remoteFunction("TokenTime")
local v_u_52 = v_u_32.remoteFunction("GiftEvent")
local v_u_53 = v_u_32.remoteFunction("ClaimCodeEvent")
local v_u_54 = v_u_32.remoteFunction("DiscordService/Claim")
local v_u_55 = {
	Enum.AdAvailabilityResult.PlayerIneligible,
	Enum.AdAvailabilityResult.DeviceIneligible,
	Enum.AdAvailabilityResult.PublisherIneligible,
	Enum.AdAvailabilityResult.ExperienceIneligible
}
function v43.setupGlobalRunes(_)
	-- upvalues: (copy) v_u_26, (copy) v_u_18, (copy) v_u_45, (copy) v_u_32, (copy) v_u_35, (copy) v_u_24, (copy) v_u_17, (copy) v_u_27, (copy) v_u_49, (copy) v_u_50, (copy) v_u_14, (copy) v_u_30, (copy) v_u_33, (copy) v_u_38, (copy) v_u_6, (copy) v_u_1, (copy) v_u_55
	local v57 = v_u_26.Dictionary.filter(v_u_18, function(p56)
		return p56.Category == "Shop"
	end)
	local v58 = v_u_45.GlobalRuneTemplate
	v58.Visible = false
	local v_u_59 = v_u_32.remoteEvent("FreeAdRuneEvent")
	local v_u_60 = not v_u_35.Get().ArePaidRandomItemsRestricted
	local v_u_61 = {}
	for v_u_62, v63 in v57 do
		local v64 = v_u_24.GlobalRunes[v_u_62]
		local v65 = v64 ~= nil
		local v66 = ("%* doesn\'t have Products.GlobalRunes"):format(v_u_62)
		assert(v65, v66)
		local v67 = v58:Clone()
		v67.ImageLabel.Image = v63.Icon or ""
		v67.Glow.BackgroundColor3 = v63.Color
		v67.Title.Text = v63.Name
		v67.LayoutOrder = v67.LayoutOrder + (v63.Order or 5)
		v67.Visible = true
		v67.Name = v_u_62
		v67.Parent = v_u_45
		local v68 = v67.WatchAd
		v68.Visible = false
		table.insert(v_u_61, v68)
		v68.Activated:Connect(function()
			-- upvalues: (copy) v_u_59, (copy) v_u_62
			v_u_59.fire(v_u_62)
		end)
		local v69 = v67.Runes.Template
		v69.Visible = false
		for _, v70 in v63.Runes do
			local v71 = v_u_17[v70]
			local v72 = v69:Clone()
			v72.Visible = true
			v72.Rune.Text = v71.Name
			v72.Cost.Text = v_u_27.percentage(v71.Chance)
			v72.UIGradient.Color = v71.Gradient
			v72.UIGradient.Rotation = 45
			v72.Parent = v67.Runes
			if v71.Animated then
				v72.UIGradient:AddTag("Gradient")
			end
		end
		local v73 = v_u_49
		local v74 = v67.Purchase
		table.insert(v73, v74)
		local v75 = v_u_50
		local v76 = v67.Tokens
		table.insert(v75, v76)
		local v77 = v67.Purchase.Template
		local v78 = v67.Tokens.Template
		for v79, v_u_80 in v64 do
			local v_u_81 = v77:Clone()
			v_u_81.Amount.Text = ("x%*"):format((v_u_27.comma(v_u_14[v79])))
			v_u_81.Price.Text = v_u_27.robux("...")
			v_u_81.Visible = true
			v_u_81.Parent = v77.Parent
			local v_u_82 = v78:Clone()
			v_u_82.Amount.Text = ("x%*"):format((v_u_27.comma(v_u_14[v79])))
			v_u_82.Frame.Cost.Text = "..."
			v_u_82.Visible = true
			v_u_82.Parent = v78.Parent
			v_u_81.Activated:Connect(function()
				-- upvalues: (copy) v_u_60, (ref) v_u_30, (copy) v_u_80, (ref) v_u_33
				if v_u_60 then
					v_u_30.PromptProduct(v_u_80)
				else
					v_u_33.Notify({
						["Message"] = "Sorry you are not allowed to purchase this!",
						["Type"] = v_u_33.Types.Error
					})
				end
			end)
			v_u_82.Activated:Connect(function()
				-- upvalues: (copy) v_u_60, (copy) v_u_80, (ref) v_u_38, (ref) v_u_6, (ref) v_u_33
				if v_u_60 then
					local v_u_83 = v_u_80
					local v84 = v_u_38.prompt
					local v85 = {
						["Title"] = "Are you sure you want to purchase this?"
					}
					local v_u_86 = "Product"
					function v85.YesCallback()
						-- upvalues: (ref) v_u_6, (copy) v_u_86, (copy) v_u_83
						v_u_6:purchase(v_u_86, v_u_83)
					end
					v84(v85)
				else
					v_u_33.Notify({
						["Message"] = "Sorry you are not allowed to purchase this!",
						["Type"] = v_u_33.Types.Error
					})
				end
			end)
			v_u_30.ObserveProduct(v_u_80, function(p87)
				-- upvalues: (copy) v_u_81, (ref) v_u_27, (copy) v_u_82
				v_u_81.Price.Text = v_u_27.robux(v_u_27.comma(p87.PriceInRobux))
				v_u_82.Frame.Cost.Text = v_u_27.comma(p87.PriceInRobux)
			end)
		end
		v78:Destroy()
		v77:Destroy()
		v69:Destroy()
	end
	task.spawn(function()
		-- upvalues: (ref) v_u_1, (ref) v_u_55, (copy) v_u_61
		-- failed to decompile
	end)
	v58:Destroy()
end
function v43.setupGamepasses(_)
	-- upvalues: (copy) v_u_45, (copy) v_u_13, (copy) v_u_28, (copy) v_u_24, (copy) v_u_49, (copy) v_u_50, (copy) v_u_30, (copy) v_u_27, (copy) v_u_38, (copy) v_u_6, (copy) v_u_34, (copy) v_u_52, (copy) v_u_33
	local v88 = v_u_45.Gamepasses.Template
	for _, v89 in v_u_45.Gamepasses:GetChildren() do
		if v89:IsA("Frame") and v89.Name ~= "Template" then
			v89:Destroy()
		end
	end
	for v_u_90, v_u_91 in v_u_13 do
		local v_u_92 = v88:Clone()
		local v_u_93 = v_u_92.Container
		v_u_92.LayoutOrder = v_u_91.Order or 99
		v_u_92.Visible = true
		v_u_92.Parent = v88.Parent
		v_u_92.Name = tostring(v_u_90)
		v_u_93.Title.Text = v_u_91.Name
		v_u_93.Desc.Text = v_u_91.Description
		v_u_93.Icon.Image = v_u_91.Icon
		v_u_93.Faded_Icon.Image = v_u_93.Icon.Image
		v_u_93.UIGradient.Color = v_u_91.Gradient or ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 220, 95)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 160, 50)) })
		if v_u_91.Rotation then
			v_u_93.UIGradient.Rotation = v_u_91.Rotation
		end
		if v_u_91.Animated then
			v_u_93.UIGradient:AddTag("Gradient")
		end
		local v_u_94 = false
		v_u_28.observe(v_u_91.ID, function(p95)
			-- upvalues: (ref) v_u_94, (copy) v_u_93
			if p95 then
				v_u_94 = true
				v_u_93.Buttons.Robux.Price.Text = "Owned"
				v_u_93.Buttons.Tokens.Price.Text = "Owned"
			end
		end)
		v_u_93.Buttons.Gift.Visible = v_u_24.Gamepasses[v_u_90] ~= nil
		v_u_93.Buttons.Tokens.Visible = false
		local v96 = v_u_49
		local v97 = v_u_93.Buttons.Robux
		table.insert(v96, v97)
		local v98 = v_u_50
		local v99 = v_u_93.Buttons.Tokens
		table.insert(v98, v99)
		v_u_30.ObserveGamepass(v_u_91.ID, function(p100)
			-- upvalues: (copy) v_u_92, (copy) v_u_93, (ref) v_u_94, (ref) v_u_27
			v_u_92.Visible = p100.IsForSale
			v_u_93.Desc.Text = p100.Description
			v_u_93.Title.Text = p100.Name
			v_u_93.Icon.Image = ("rbxassetid://%*"):format(p100.IconImageAssetId)
			v_u_93.Faded_Icon.Image = v_u_93.Icon.Image
			if not v_u_94 then
				v_u_93.Buttons.Robux.Price.Text = v_u_27.robux((("%*"):format((v_u_27.comma(p100.PriceInRobux)))))
				v_u_93.Buttons.Tokens.Price.Text = ("%*"):format((v_u_27.comma(p100.PriceInRobux)))
			end
		end)
		v_u_93.Buttons.Robux.Activated:Connect(function()
			-- upvalues: (ref) v_u_94, (ref) v_u_30, (copy) v_u_91
			if not v_u_94 then
				v_u_30.PromptGamepass(v_u_91.ID)
			end
		end)
		v_u_93.Buttons.Tokens.Activated:Connect(function()
			-- upvalues: (ref) v_u_94, (copy) v_u_91, (ref) v_u_38, (ref) v_u_6
			if not v_u_94 then
				local v_u_101 = v_u_91.ID
				local v102 = v_u_38.prompt
				local v103 = {
					["Title"] = "Are you sure you want to purchase this?"
				}
				local v_u_104 = "Gamepass"
				function v103.YesCallback()
					-- upvalues: (ref) v_u_6, (copy) v_u_104, (copy) v_u_101
					v_u_6:purchase(v_u_104, v_u_101)
				end
				v102(v103)
			end
		end)
		v_u_93.Buttons.Gift.Activated:Connect(function()
			-- upvalues: (ref) v_u_34, (ref) v_u_28, (copy) v_u_91, (ref) v_u_52, (ref) v_u_24, (copy) v_u_90, (ref) v_u_33
			v_u_34.open(function(p105)
				-- upvalues: (ref) v_u_28, (ref) v_u_91, (ref) v_u_52, (ref) v_u_24, (ref) v_u_90, (ref) v_u_33
				local v106 = v_u_28.fetch(p105)
				if v106 and table.find(v106, v_u_91.ID) then
					return false, "Player already owns this gamepass!"
				end
				local v107, v108 = v_u_52.invoke(p105, v_u_24.Gamepasses[v_u_90])
				if v107 then
					return true
				end
				v_u_33.Notify({
					["Message"] = v108,
					["Type"] = v_u_33.Types.Error
				})
				return false, v108
			end)
		end)
	end
	v88:Destroy()
end
function v43.setupPotions(_)
	-- upvalues: (copy) v_u_45, (copy) v_u_49, (copy) v_u_50, (copy) v_u_30, (copy) v_u_24, (copy) v_u_38, (copy) v_u_6, (copy) v_u_27, (copy) v_u_16, (copy) v_u_9, (copy) v_u_11
	local v109 = v_u_45.PotionTemplate
	local v_u_110 = v_u_45.PotionAll
	v_u_110.Buttons.One.Price.Text = "..."
	v_u_110.Buttons.TokenOne.Price.Text = "..."
	local v111 = v_u_49
	local v112 = v_u_110.Buttons.One
	table.insert(v111, v112)
	local v113 = v_u_50
	local v114 = v_u_110.Buttons.TokenOne
	table.insert(v113, v114)
	v_u_110.Buttons.One.Activated:Connect(function()
		-- upvalues: (ref) v_u_30, (ref) v_u_24
		v_u_30.PromptProduct(v_u_24.PotionsAll)
	end)
	v_u_110.Buttons.TokenOne.Activated:Connect(function()
		-- upvalues: (ref) v_u_24, (ref) v_u_38, (ref) v_u_6
		local v_u_115 = v_u_24.PotionsAll
		local v116 = v_u_38.prompt
		local v117 = {
			["Title"] = "Are you sure you want to purchase this?"
		}
		local v_u_118 = "Product"
		function v117.YesCallback()
			-- upvalues: (ref) v_u_6, (copy) v_u_118, (copy) v_u_115
			v_u_6:purchase(v_u_118, v_u_115)
		end
		v116(v117)
	end)
	v_u_30.ObserveProduct(v_u_24.PotionsAll, function(p119)
		-- upvalues: (copy) v_u_110, (ref) v_u_27
		v_u_110.Buttons.TokenOne.Price.Text = v_u_27.comma(p119.PriceInRobux)
		v_u_110.Buttons.One.Price.Text = v_u_27.robux(v_u_27.comma(p119.PriceInRobux))
	end)
	for v_u_120, v121 in v_u_16 do
		local v_u_122 = v109:Clone()
		v_u_122.Title.Text = v121.Name
		v_u_122.LayoutOrder = v_u_122.LayoutOrder + v121.Order
		v_u_122.Icon.Image = v121.Icon
		v_u_122.BackgroundColor3 = v121.Color
		v_u_122.Description.Text = v121.Description
		v_u_122.Visible = true
		if v121.Rainbow then
			v_u_122.UIGradient.Color = v121.Gradient
			v_u_122.UIGradient:AddTag("Gradient")
		end
		local v123 = v_u_49
		local v124 = v_u_122.Buttons.One
		table.insert(v123, v124)
		local v125 = v_u_50
		local v126 = v_u_122.Buttons.TokenOne
		table.insert(v125, v126)
		local v127 = v_u_49
		local v128 = v_u_122.Buttons.Ten
		table.insert(v127, v128)
		local v129 = v_u_50
		local v130 = v_u_122.Buttons.TokenTen
		table.insert(v129, v130)
		v_u_9:observeStorage(v_u_120, function(p131)
			-- upvalues: (copy) v_u_122, (ref) v_u_11, (ref) v_u_27
			if p131 <= 0 then
				v_u_122.Buttons.Use.Price.Text = "Use"
				v_u_122.Buttons.Use.UIStroke.Color = v_u_11.Grey.Stroke
				v_u_122.Buttons.Use.Price.UIStroke.Color = v_u_11.Grey.Stroke
				v_u_122:SetAttribute("Useable", nil)
			else
				v_u_122.Buttons.Use.Price.Text = ("Use (%*)"):format((v_u_27.abbreviate(p131)))
				v_u_122.Buttons.Use.UIStroke.Color = v_u_11.Blue.Stroke
				v_u_122.Buttons.Use.Price.UIStroke.Color = v_u_11.Blue.Stroke
				v_u_122:SetAttribute("Useable", true)
			end
		end)
		local v_u_132 = v_u_24.Potions[v_u_120]
		if not v_u_132 then
			error((("%* doesn\'t have data in Products.Potions"):format(v_u_120)))
		end
		local v133 = {
			[v_u_132[1]] = {
				["main"] = v_u_122.Buttons.One,
				["token"] = v_u_122.Buttons.TokenOne
			},
			[v_u_132[2]] = {
				["main"] = v_u_122.Buttons.Ten,
				["token"] = v_u_122.Buttons.TokenTen
			}
		}
		for v_u_134, v_u_135 in v133 do
			v_u_135.token.Price.Text = "..."
			v_u_135.main.Price.Text = "..."
			v_u_30.ObserveProduct(v_u_134, function(p136)
				-- upvalues: (copy) v_u_135, (ref) v_u_27
				v_u_135.token.Price.Text = v_u_27.comma(p136.PriceInRobux)
				v_u_135.main.Price.Text = v_u_27.robux(v_u_27.comma(p136.PriceInRobux))
			end)
			v_u_135.main.Activated:Connect(function()
				-- upvalues: (ref) v_u_30, (copy) v_u_134
				v_u_30.PromptProduct(v_u_134)
			end)
			v_u_135.token.Activated:Connect(function()
				-- upvalues: (copy) v_u_134, (ref) v_u_38, (ref) v_u_6
				local v_u_137 = v_u_134
				local v138 = v_u_38.prompt
				local v139 = {
					["Title"] = "Are you sure you want to purchase this?"
				}
				local v_u_140 = "Product"
				function v139.YesCallback()
					-- upvalues: (ref) v_u_6, (copy) v_u_140, (copy) v_u_137
					v_u_6:purchase(v_u_140, v_u_137)
				end
				v138(v139)
			end)
		end
		v_u_122.Buttons.Use.Activated:Connect(function()
			-- upvalues: (copy) v_u_122, (ref) v_u_9, (copy) v_u_120, (ref) v_u_30, (copy) v_u_132
			if v_u_122:GetAttribute("Useable") then
				v_u_9:use(v_u_120)
			else
				v_u_30.PromptProduct(v_u_132[1])
			end
		end)
		v_u_122.Parent = v_u_45
	end
	v109:Destroy()
end
function v43.setupResetTickets(_)
	-- upvalues: (copy) v_u_45, (copy) v_u_49, (copy) v_u_50, (copy) v_u_30, (copy) v_u_24, (copy) v_u_27, (copy) v_u_38, (copy) v_u_6
	local v_u_141 = v_u_45.ResetTickets.Buttons
	local v142 = v_u_49
	local v143 = v_u_141.One
	table.insert(v142, v143)
	local v144 = v_u_49
	local v145 = v_u_141.Ten
	table.insert(v144, v145)
	local v146 = v_u_50
	local v147 = v_u_141.TokenOne
	table.insert(v146, v147)
	local v148 = v_u_50
	local v149 = v_u_141.TokenTen
	table.insert(v148, v149)
	v_u_30.ObserveProduct(v_u_24.ResetTickets[1], function(p150)
		-- upvalues: (copy) v_u_141, (ref) v_u_27
		v_u_141.One.Price.Text = v_u_27.robux(v_u_27.comma(p150.PriceInRobux))
		v_u_141.TokenOne.Price.Text = v_u_27.comma(p150.PriceInRobux)
	end)
	v_u_30.ObserveProduct(v_u_24.ResetTickets[2], function(p151)
		-- upvalues: (copy) v_u_141, (ref) v_u_27
		v_u_141.Ten.Price.Text = v_u_27.robux(v_u_27.comma(p151.PriceInRobux))
		v_u_141.TokenTen.Price.Text = v_u_27.comma(p151.PriceInRobux)
	end)
	v_u_141.One.Activated:Connect(function()
		-- upvalues: (ref) v_u_30, (ref) v_u_24
		v_u_30.PromptProduct(v_u_24.ResetTickets[1])
	end)
	v_u_141.Ten.Activated:Connect(function()
		-- upvalues: (ref) v_u_30, (ref) v_u_24
		v_u_30.PromptProduct(v_u_24.ResetTickets[2])
	end)
	v_u_141.TokenOne.Activated:Connect(function()
		-- upvalues: (ref) v_u_24, (ref) v_u_38, (ref) v_u_6
		local v_u_152 = v_u_24.ResetTickets[1]
		local v153 = v_u_38.prompt
		local v154 = {
			["Title"] = "Are you sure you want to purchase this?"
		}
		local v_u_155 = "Product"
		function v154.YesCallback()
			-- upvalues: (ref) v_u_6, (copy) v_u_155, (copy) v_u_152
			v_u_6:purchase(v_u_155, v_u_152)
		end
		v153(v154)
	end)
	v_u_141.TokenTen.Activated:Connect(function()
		-- upvalues: (ref) v_u_24, (ref) v_u_38, (ref) v_u_6
		local v_u_156 = v_u_24.ResetTickets[2]
		local v157 = v_u_38.prompt
		local v158 = {
			["Title"] = "Are you sure you want to purchase this?"
		}
		local v_u_159 = "Product"
		function v158.YesCallback()
			-- upvalues: (ref) v_u_6, (copy) v_u_159, (copy) v_u_156
			v_u_6:purchase(v_u_159, v_u_156)
		end
		v157(v158)
	end)
end
function v43.setupFirstTimePurchase(_)
	-- upvalues: (copy) v_u_45, (copy) v_u_8, (copy) v_u_25
	local v_u_160 = v_u_45.FirstPurchaseOffer
	v_u_8:observe(v_u_25.RobuxSpent, function(p161)
		-- upvalues: (copy) v_u_160
		v_u_160.Visible = p161 <= 0
	end)
end
function v43.setupPacks(_)
	-- upvalues: (copy) v_u_21, (copy) v_u_45, (copy) v_u_29, (copy) v_u_15, (copy) v_u_27, (copy) v_u_49, (copy) v_u_50, (copy) v_u_36, (copy) v_u_30, (copy) v_u_38, (copy) v_u_6
	for v162, v_u_163 in v_u_21 do
		local v_u_164 = v_u_45:FindFirstChild(v162)
		if not v_u_164 then
			error((("Frame for %* not found in Store UI"):format(v162)))
		end
		local v_u_165 = true
		local v_u_166 = false
		local v_u_167
		if v_u_163.LockedData then
			v_u_29.observe(v_u_163.LockedData, function(p168)
				-- upvalues: (ref) v_u_165, (copy) v_u_164, (ref) v_u_166
				v_u_165 = p168
				local v169 = v_u_164
				local v170 = not v_u_165
				if v170 then
					v170 = not v_u_166
				end
				v169.Visible = v170
			end)
			v_u_167 = v_u_165
		else
			v_u_165 = false
			v_u_167 = v_u_165
		end
		local v171 = v_u_164.Items.Template
		local v_u_172 = v_u_166
		for _, v173 in v_u_164.Items:GetChildren() do
			if v173:IsA("Frame") and v173 ~= v171 then
				v173:Destroy()
			end
		end
		for _, v174 in v_u_163.Rewards do
			local v175 = v171:Clone()
			v175.Visible = true
			v175.Parent = v_u_164.Items
			local v176 = v_u_15[v174.ItemType]
			if v176 then
				v176 = v176[v174.Key] or v176
			end
			if v176 then
				v175.Icon.Image = v176.Icon
				v175.Amount.Visible = v174.Amount ~= nil
				v175.Amount.Text = ("x%*"):format((v_u_27.abbreviate(v174.Amount or 1)))
			else
				v175.Icon.Image = ""
				v175.Amount.Text = "err"
			end
		end
		v171:Destroy()
		local v177 = v_u_49
		local v178 = v_u_164.Buttons.Robux
		table.insert(v177, v178)
		local v179 = v_u_50
		local v180 = v_u_164.Buttons.Tokens
		table.insert(v179, v180)
		v_u_36.observe(v_u_163.Id, function(p181)
			-- upvalues: (ref) v_u_172, (copy) v_u_164, (ref) v_u_167
			v_u_172 = p181 >= 1
			local v182 = v_u_164
			local v183 = not v_u_167
			if v183 then
				v183 = not v_u_172
			end
			v182.Visible = v183
		end)
		v_u_30.ObserveProduct(v_u_163.Id, function(p184)
			-- upvalues: (copy) v_u_164, (ref) v_u_27
			v_u_164.Buttons.Robux.Price.Text = v_u_27.robux(v_u_27.comma(p184.PriceInRobux))
			v_u_164.Buttons.Tokens.Price.Text = v_u_27.comma(p184.PriceInRobux)
		end)
		v_u_164.Buttons.Tokens.Activated:Connect(function()
			-- upvalues: (copy) v_u_163, (ref) v_u_38, (ref) v_u_6
			local v_u_185 = v_u_163.Id
			local v186 = v_u_38.prompt
			local v187 = {
				["Title"] = "Are you sure you want to purchase this?"
			}
			local v_u_188 = "Product"
			function v187.YesCallback()
				-- upvalues: (ref) v_u_6, (copy) v_u_188, (copy) v_u_185
				v_u_6:purchase(v_u_188, v_u_185)
			end
			v186(v187)
		end)
		v_u_164.Buttons.Robux.Activated:Connect(function()
			-- upvalues: (ref) v_u_30, (copy) v_u_163
			v_u_30.PromptProduct(v_u_163.Id)
		end)
	end
end
function v43.setupCodes(_)
	-- upvalues: (copy) v_u_45, (copy) v_u_53, (copy) v_u_33, (copy) v_u_37, (copy) v_u_4, (copy) v_u_42, (copy) v_u_35
	local v189 = v_u_45.Codes
	local v_u_190 = v189.Inner.Container.TextBox
	local function v_u_193()
		-- upvalues: (copy) v_u_190, (ref) v_u_53, (ref) v_u_33, (ref) v_u_37
		if v_u_190.Text == "" then
			return
		else
			local v191, v192 = v_u_53.invoke(v_u_190.Text)
			if v191 then
				v_u_33.Notify({
					["Message"] = "Code redeemed successfully!",
					["Type"] = v_u_33.Types.Success
				})
				v_u_37.show(v192)
			else
				v_u_33.Notify({
					["Message"] = v192,
					["Type"] = v_u_33.Types.Error
				})
			end
		end
	end
	v189.Inner.Purchase.Activated:Connect(v_u_193)
	v_u_4.InputBegan:Connect(function(p194, _)
		-- upvalues: (ref) v_u_42, (copy) v_u_193
		if v_u_42.Current == script.Name and p194.KeyCode == Enum.KeyCode.Return then
			v_u_193()
		end
	end)
	local v195 = v_u_35.Get()
	if table.find(v195.AllowedExternalLinkReferences, "Discord") then
		v189.Inner.Container.desc.Text = "Join our Discord for exclusive codes!"
	else
		v189.Inner.Container.desc.Text = "Follow @TheDCraft & @Entolecent for Codes!"
	end
end
function v43.setupStarterPack(_)
	-- upvalues: (copy) v_u_45, (copy) v_u_7, (copy) v_u_41, (copy) v_u_49, (copy) v_u_50, (copy) v_u_30, (copy) v_u_24, (copy) v_u_38, (copy) v_u_6, (copy) v_u_27
	local v_u_196 = v_u_45.StarterPack
	local v_u_197 = v_u_196.Timer
	v_u_7:onSet({ "StarterPack" }, function(p198)
		-- upvalues: (copy) v_u_196, (copy) v_u_197, (ref) v_u_41
		if type(p198) == "number" and p198 > 0 then
			v_u_196.Visible = true
			v_u_197.Text = v_u_41.format(p198)
		else
			v_u_196.Visible = false
		end
	end)
	local v199 = v_u_49
	local v200 = v_u_196.Buttons.Robux
	table.insert(v199, v200)
	local v201 = v_u_50
	local v202 = v_u_196.Buttons.Tokens
	table.insert(v201, v202)
	v_u_196.Buttons.Robux.Activated:Connect(function()
		-- upvalues: (ref) v_u_30, (ref) v_u_24
		v_u_30.PromptProduct(v_u_24.StarterPack)
	end)
	v_u_196.Buttons.Tokens.Activated:Connect(function()
		-- upvalues: (ref) v_u_24, (ref) v_u_38, (ref) v_u_6
		local v_u_203 = v_u_24.StarterPack
		local v204 = v_u_38.prompt
		local v205 = {
			["Title"] = "Are you sure you want to purchase this?"
		}
		local v_u_206 = "Product"
		function v205.YesCallback()
			-- upvalues: (ref) v_u_6, (copy) v_u_206, (copy) v_u_203
			v_u_6:purchase(v_u_206, v_u_203)
		end
		v204(v205)
	end)
	v_u_30.ObserveProduct(v_u_24.StarterPack, function(p207)
		-- upvalues: (copy) v_u_196, (ref) v_u_27
		v_u_196.Buttons.Robux.Price.Text = v_u_27.robux(v_u_27.comma(p207.PriceInRobux))
		v_u_196.Buttons.Tokens.Price.Text = v_u_27.comma(p207.PriceInRobux)
	end)
end
function v43.setupServerLuck(_)
	-- upvalues: (copy) v_u_45, (copy) v_u_19, (copy) v_u_24, (copy) v_u_27, (copy) v_u_30, (copy) v_u_10, (copy) v_u_41
	local v_u_208 = v_u_45.ServerLuck.Container
	local v209 = 0
	local v_u_210 = nil
	for v211, v212 in v_u_19 do
		if v209 < v211 then
			v_u_210 = v212
			v209 = v211
		end
	end
	local v_u_213 = {}
	local function v216(p214)
		-- upvalues: (copy) v_u_208, (ref) v_u_24, (ref) v_u_19, (ref) v_u_210, (copy) v_u_213, (ref) v_u_27
		v_u_208.Buttons.Robux.Visible = v_u_24.ServerLuck[p214] ~= nil
		local v215 = v_u_19[p214]
		if v215 then
			v_u_208.Boost.Current.Text = ("%*x"):format(p214)
			v_u_208.Boost.Next.Text = ("%*x"):format(v215.Luck)
			v_u_208.Boost.Current.Visible = true
			v_u_208.Boost.Middle.Visible = true
			v_u_208.Boost.Next.Visible = true
			v_u_208.Buttons.Robux.Price.Text = v_u_213[p214] and v_u_27.robux(v_u_27.comma(v_u_213[p214])) or "..."
		else
			v_u_208.Boost.Current.Visible = false
			v_u_208.Boost.Middle.Visible = false
			v_u_208.Boost.Next.Text = ("%*x"):format(v_u_210.Luck)
		end
	end
	for v_u_217, v218 in v_u_24.ServerLuck do
		v_u_30.ObserveProduct(v218, function(p219)
			-- upvalues: (copy) v_u_213, (copy) v_u_217, (ref) v_u_10, (copy) v_u_208, (ref) v_u_27
			v_u_213[v_u_217] = p219.PriceInRobux
			if v_u_217 == v_u_10.Luck then
				v_u_208.Buttons.Robux.Price.Text = v_u_27.robux(v_u_27.comma(p219.PriceInRobux))
			end
		end)
	end
	v_u_208.Buttons.Robux.Activated:Connect(function()
		-- upvalues: (ref) v_u_24, (ref) v_u_10, (ref) v_u_30
		local v220 = v_u_24.ServerLuck[v_u_10.Luck]
		if v220 then
			v_u_30.PromptProduct(v220)
		end
	end)
	v_u_10:observeLuck(v216)
	v_u_10:observeTimer(function(p221)
		-- upvalues: (copy) v_u_208, (ref) v_u_41
		v_u_208.Timer.Text = v_u_41.format(p221)
	end)
end
function v43.setupTokens(_)
	-- upvalues: (copy) v_u_46, (copy) v_u_41, (copy) v_u_12, (copy) v_u_51, (copy) v_u_5, (copy) v_u_22, (copy) v_u_27, (copy) v_u_24, (copy) v_u_30, (copy) v_u_34, (copy) v_u_52, (copy) v_u_33, (copy) v_u_45, (copy) v_u_50, (copy) v_u_49
	task.spawn(function()
		-- upvalues: (ref) v_u_46, (ref) v_u_41, (ref) v_u_12, (ref) v_u_51
		v_u_46.Tokens.Folder.TextLabel.Text = ("+1 Every %*"):format((v_u_41.format(v_u_12.TOKEN_TIME_INTERVAL)))
		local v222 = v_u_51.invoke()
		if v222 then
			while true do
				local v223 = workspace:GetServerTimeNow() - v222
				local v224 = (v_u_12.TOKEN_TIME_INTERVAL - v223) % v_u_12.TOKEN_TIME_INTERVAL
				v_u_46.Tokens.Folder.TextLabel.Text = ("+1 in %*"):format((v_u_41.format(v224)))
				task.wait(1)
			end
		else
			return
		end
	end)
	v_u_5:observe(v_u_22.Tokens, function(p225)
		-- upvalues: (ref) v_u_46, (ref) v_u_27
		v_u_46.Tokens.TextLabel.Text = v_u_27.comma(p225)
	end)
	local function v235(p226)
		-- upvalues: (ref) v_u_24, (ref) v_u_30, (ref) v_u_27, (ref) v_u_34, (ref) v_u_52, (ref) v_u_33
		for _, v_u_227 in p226:GetChildren() do
			if v_u_227:IsA("Frame") then
				local v228 = v_u_24.Tokens
				local v229 = v_u_227.Name
				local v_u_230 = v228[tonumber(v229)]
				if v_u_230 then
					v_u_30.ObserveProduct(v_u_230, function(p231)
						-- upvalues: (copy) v_u_227, (ref) v_u_27
						v_u_227.Buttons.Robux.Price.Text = v_u_27.robux(v_u_27.comma(p231.PriceInRobux))
					end)
					v_u_227.Buttons.Robux.Activated:Connect(function()
						-- upvalues: (ref) v_u_30, (copy) v_u_230
						v_u_30.PromptProduct(v_u_230)
					end)
					v_u_227.Buttons.Gift.Activated:Connect(function()
						-- upvalues: (ref) v_u_34, (ref) v_u_52, (copy) v_u_230, (ref) v_u_33
						v_u_34.open(function(p232)
							-- upvalues: (ref) v_u_52, (ref) v_u_230, (ref) v_u_33
							local v233, v234 = v_u_52.invoke(p232, v_u_230)
							if v233 then
								return true
							end
							v_u_33.Notify({
								["Message"] = v234,
								["Type"] = v_u_33.Types.Error
							})
							return false, v234
						end)
					end)
				end
			end
		end
	end
	v235(v_u_45.Tokens.Container.Top)
	v235(v_u_45.Tokens.Container.Bottom)
	local v_u_236 = "Robux"
	local function v_u_239()
		-- upvalues: (ref) v_u_50, (ref) v_u_236, (ref) v_u_49, (ref) v_u_46
		for _, v237 in v_u_50 do
			v237.Visible = v_u_236 == "Tokens"
		end
		for _, v238 in v_u_49 do
			v238.Visible = v_u_236 == "Robux"
		end
		v_u_46.Switch.Folder.Frame.UIGradient:RemoveTag("Gradient")
		if v_u_236 == "Tokens" then
			v_u_46.Switch.TextLabel.Text = "Switch to Robux"
			v_u_46.Switch.Folder.Frame.UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(153, 255, 127)),
				ColorSequenceKeypoint.new(0.33, Color3.fromRGB(30, 255, 0)),
				ColorSequenceKeypoint.new(0.66, Color3.fromRGB(127, 255, 127)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 255, 0))
			})
			v_u_46.Switch.UIStroke.Color = Color3.fromRGB(0, 85, 0)
			v_u_46.Switch.BackgroundColor3 = Color3.fromRGB(0, 85, 0)
		else
			v_u_46.Switch.TextLabel.Text = "Switch to Tickets"
			v_u_46.Switch.Folder.Frame.UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)),
				ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 170, 0)),
				ColorSequenceKeypoint.new(0.66, Color3.fromRGB(255, 255, 127)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 0))
			})
			v_u_46.Switch.UIStroke.Color = Color3.fromRGB(97, 65, 0)
			v_u_46.Switch.BackgroundColor3 = Color3.fromRGB(97, 65, 0)
		end
		v_u_46.Switch.Folder.Frame.UIGradient:AddTag("Gradient")
	end
	v_u_46.Switch.Activated:Connect(function()
		-- upvalues: (ref) v_u_236, (copy) v_u_239
		v_u_236 = v_u_236 == "Robux" and "Tokens" or "Robux"
		v_u_239()
	end)
	v_u_239()
end
function v43.setupRuneFrames(_)
	-- upvalues: (copy) v_u_45, (copy) v_u_23, (copy) v_u_24, (copy) v_u_49, (copy) v_u_50, (copy) v_u_30, (copy) v_u_27, (copy) v_u_38, (copy) v_u_6, (copy) v_u_7, (copy) v_u_31
	local v240 = v_u_45.ExtraRuneBulk
	local v241 = v_u_45.ExtraRuneSpeed
	for _, v_u_242 in {
		{
			["frame"] = v240,
			["multiplier_type"] = v_u_23.RuneBulkMultiplier,
			["products"] = v_u_24.ExtraRuneBulk,
			["label"] = "Rune Bulk"
		},
		{
			["frame"] = v241,
			["multiplier_type"] = v_u_23.RuneOpenTimeMultiplier,
			["products"] = v_u_24.ExtraRuneSpeed,
			["label"] = "Rune Speed"
		}
	} do
		local v_u_243 = v_u_242.frame
		local v_u_244 = v_u_243.Buttons
		local v245 = v_u_49
		local v246 = v_u_244.Robux_ONE
		table.insert(v245, v246)
		local v247 = v_u_49
		local v248 = v_u_244.Robux_MAX
		table.insert(v247, v248)
		local v249 = v_u_50
		local v250 = v_u_244.Tokens_ONE
		table.insert(v249, v250)
		local v251 = v_u_50
		local v252 = v_u_244.Tokens_MAX
		table.insert(v251, v252)
		v_u_30.ObserveProduct(v_u_242.products.ONE, function(p253)
			-- upvalues: (copy) v_u_244, (ref) v_u_27
			v_u_244.Robux_ONE.Price.Text = v_u_27.robux(v_u_27.comma(p253.PriceInRobux))
			v_u_244.Tokens_ONE.Price.Text = v_u_27.comma(p253.PriceInRobux)
		end)
		v_u_30.ObserveProduct(v_u_242.products.MAX, function(p254)
			-- upvalues: (copy) v_u_244, (ref) v_u_27
			v_u_244.Robux_MAX.Price.Text = v_u_27.robux(v_u_27.comma(p254.PriceInRobux))
			v_u_244.Tokens_MAX.Price.Text = v_u_27.comma(p254.PriceInRobux)
		end)
		v_u_244.Robux_ONE.Activated:Connect(function()
			-- upvalues: (ref) v_u_30, (copy) v_u_242
			v_u_30.PromptProduct(v_u_242.products.ONE)
		end)
		v_u_244.Robux_MAX.Activated:Connect(function()
			-- upvalues: (ref) v_u_30, (copy) v_u_242
			v_u_30.PromptProduct(v_u_242.products.MAX)
		end)
		v_u_244.Tokens_ONE.Activated:Connect(function()
			-- upvalues: (copy) v_u_242, (ref) v_u_38, (ref) v_u_6
			local v_u_255 = v_u_242.products.ONE
			local v256 = v_u_38.prompt
			local v257 = {
				["Title"] = "Are you sure you want to purchase this?"
			}
			local v_u_258 = "Product"
			function v257.YesCallback()
				-- upvalues: (ref) v_u_6, (copy) v_u_258, (copy) v_u_255
				v_u_6:purchase(v_u_258, v_u_255)
			end
			v256(v257)
		end)
		v_u_244.Tokens_MAX.Activated:Connect(function()
			-- upvalues: (copy) v_u_242, (ref) v_u_38, (ref) v_u_6
			local v_u_259 = v_u_242.products.MAX
			local v260 = v_u_38.prompt
			local v261 = {
				["Title"] = "Are you sure you want to purchase this?"
			}
			local v_u_262 = "Product"
			function v261.YesCallback()
				-- upvalues: (ref) v_u_6, (copy) v_u_262, (copy) v_u_259
				v_u_6:purchase(v_u_262, v_u_259)
			end
			v260(v261)
		end)
		local v_u_263 = 0
		v_u_7:onSet({ "Multipliers", v_u_242.multiplier_type }, function(p264)
			-- upvalues: (ref) v_u_263, (copy) v_u_243, (ref) v_u_27, (copy) v_u_242, (ref) v_u_49, (copy) v_u_244, (ref) v_u_50
			v_u_263 = p264 or 0
			v_u_243.Frame.Level.Text = ("Level %*/%*"):format(v_u_263, 10)
			v_u_243.Frame.Total.Text = ("x%* %*"):format(v_u_27.decimal(1 + v_u_263 * 0.1), v_u_242.label)
			if v_u_263 >= 10 then
				local v265 = table.find(v_u_49, v_u_244.Robux_ONE)
				if v265 then
					table.remove(v_u_49, v265)
				end
				local v266 = table.find(v_u_49, v_u_244.Robux_MAX)
				if v266 then
					table.remove(v_u_49, v266)
				end
				local v267 = table.find(v_u_50, v_u_244.Tokens_ONE)
				if v267 then
					table.remove(v_u_50, v267)
				end
				local v268 = table.find(v_u_50, v_u_244.Tokens_MAX)
				if v268 then
					table.remove(v_u_50, v268)
				end
				v_u_244.Robux_ONE.Visible = false
				v_u_244.Robux_MAX.Visible = false
				v_u_244.Tokens_ONE.Visible = false
				v_u_244.Tokens_MAX.Visible = false
			end
		end)
		v_u_31.assign(v_u_242.multiplier_type, function(_)
			-- upvalues: (ref) v_u_263
			if v_u_263 > 0 then
				return v_u_263 * 0.1 + 1
			else
				return nil
			end
		end)
	end
end
function v43.setupAllGamepasses(_)
	-- upvalues: (copy) v_u_45, (copy) v_u_49, (copy) v_u_50, (copy) v_u_7, (copy) v_u_30, (copy) v_u_24, (copy) v_u_38, (copy) v_u_6, (copy) v_u_34, (copy) v_u_52, (copy) v_u_33, (copy) v_u_27
	local v_u_269 = v_u_45.AllGamepasses.Container.Buttons
	local v270 = v_u_49
	local v271 = v_u_269.Robux
	table.insert(v270, v271)
	local v272 = v_u_50
	local v273 = v_u_269.Tokens
	table.insert(v272, v273)
	v_u_7:onSet({ "__allGamepassesPurchased" }, function(p274)
		-- upvalues: (copy) v_u_269, (ref) v_u_49, (ref) v_u_50
		v_u_269.Robux.Visible = not p274
		v_u_269.Tokens.Visible = not p274
		if p274 then
			local v275 = table.find(v_u_49, v_u_269.Robux)
			if v275 then
				table.remove(v_u_49, v275)
			end
			local v276 = table.find(v_u_50, v_u_269.Tokens)
			if v276 then
				table.remove(v_u_50, v276)
			end
		end
	end)
	v_u_269.Robux.Activated:Connect(function()
		-- upvalues: (ref) v_u_30, (ref) v_u_24
		v_u_30.PromptProduct(v_u_24.AllGamepasses)
	end)
	v_u_269.Tokens.Activated:Connect(function()
		-- upvalues: (ref) v_u_24, (ref) v_u_38, (ref) v_u_6
		local v_u_277 = v_u_24.AllGamepasses
		local v278 = v_u_38.prompt
		local v279 = {
			["Title"] = "Are you sure you want to purchase this?"
		}
		local v_u_280 = "Product"
		function v279.YesCallback()
			-- upvalues: (ref) v_u_6, (copy) v_u_280, (copy) v_u_277
			v_u_6:purchase(v_u_280, v_u_277)
		end
		v278(v279)
	end)
	v_u_269.Gift.Activated:Connect(function()
		-- upvalues: (ref) v_u_34, (ref) v_u_52, (ref) v_u_24, (ref) v_u_33
		v_u_34.open(function(p281)
			-- upvalues: (ref) v_u_52, (ref) v_u_24, (ref) v_u_33
			if p281:GetAttribute("allGP") then
				return false, "Player already owns all gamepasses!"
			end
			local v282, v283 = v_u_52.invoke(p281, v_u_24.AllGamepasses)
			if v282 then
				return true
			end
			v_u_33.Notify({
				["Message"] = v283,
				["Type"] = v_u_33.Types.Error
			})
			return false, v283
		end)
	end)
	v_u_30.ObserveProduct(v_u_24.AllGamepasses, function(p284)
		-- upvalues: (copy) v_u_269, (ref) v_u_27
		v_u_269.Robux.Price.Text = v_u_27.robux(v_u_27.comma(p284.PriceInRobux))
		v_u_269.Tokens.Price.Text = v_u_27.comma(p284.PriceInRobux)
	end)
end
function v43.setupShards(_)
	-- upvalues: (copy) v_u_24, (copy) v_u_20, (copy) v_u_27, (copy) v_u_30, (copy) v_u_34, (copy) v_u_52, (copy) v_u_33, (copy) v_u_45
	local function v295(p285)
		-- upvalues: (ref) v_u_24, (ref) v_u_20, (ref) v_u_27, (ref) v_u_30, (ref) v_u_34, (ref) v_u_52, (ref) v_u_33
		for _, v_u_286 in p285:GetChildren() do
			if v_u_286:IsA("Frame") then
				local v287 = v_u_24.Shards
				local v288 = v_u_286.Name
				local v_u_289 = v287[tonumber(v288)]
				if v_u_289 then
					local v290 = v_u_20[v_u_289]
					v_u_286.desc.Text = ("%* Shards"):format((v_u_27.comma(v290)))
					v_u_30.ObserveProduct(v_u_289, function(p291)
						-- upvalues: (copy) v_u_286, (ref) v_u_27
						v_u_286.Buttons.Robux.Price.Text = v_u_27.robux(v_u_27.comma(p291.PriceInRobux))
					end)
					v_u_286.Buttons.Robux.Activated:Connect(function()
						-- upvalues: (ref) v_u_30, (copy) v_u_289
						v_u_30.PromptProduct(v_u_289)
					end)
					v_u_286.Buttons.Gift.Activated:Connect(function()
						-- upvalues: (ref) v_u_34, (ref) v_u_52, (copy) v_u_289, (ref) v_u_33
						v_u_34.open(function(p292)
							-- upvalues: (ref) v_u_52, (ref) v_u_289, (ref) v_u_33
							local v293, v294 = v_u_52.invoke(p292, v_u_289)
							if v293 then
								return true
							end
							v_u_33.Notify({
								["Message"] = v294,
								["Type"] = v_u_33.Types.Error
							})
							return false, v294
						end)
					end)
				end
			end
		end
	end
	v295(v_u_45.Shards.Container.Top)
	v295(v_u_45.Shards.Container.Bottom)
end
function v43.setupDiscord(_)
	-- upvalues: (copy) v_u_45, (copy) v_u_7, (copy) v_u_31, (copy) v_u_23, (copy) v_u_33, (copy) v_u_54
	local v_u_296 = v_u_45.Discord.Inner
	local v_u_297 = false
	v_u_7:onSet({ "DiscordVerified" }, function(p298)
		-- upvalues: (ref) v_u_297, (copy) v_u_296
		v_u_297 = p298
		v_u_296.Overlay.Visible = v_u_297
	end)
	v_u_31.assign(v_u_23.RuneBulk, function(_)
		-- upvalues: (ref) v_u_297
		return v_u_297 and 10 or nil
	end)
	v_u_296.Purchase.Activated:Connect(function()
		-- upvalues: (ref) v_u_297, (copy) v_u_296, (ref) v_u_33, (ref) v_u_54
		if v_u_297 then
			return
		elseif string.lower(v_u_296.Container.TextBox.Text) == "slimes" then
			local v299, v300 = v_u_54.invoke()
			v_u_33.Notify({
				["Message"] = v300,
				["Type"] = v299 and v_u_33.Types.Success or v_u_33.Types.Error
			})
		else
			v_u_33.Notify({
				["Message"] = "Invalid String",
				["Type"] = v_u_33.Types.Error
			})
		end
	end)
end
function v43.goTo(_, p301)
	-- upvalues: (copy) v_u_45, (copy) v_u_3
	local v302 = v_u_45:FindFirstChild(p301)
	if v302 then
		local v303 = v_u_45.CanvasPosition.Y + v302.AbsolutePosition.Y - v_u_45.AbsolutePosition.Y
		v_u_3:Create(v_u_45, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
			["CanvasPosition"] = Vector2.new(0, v303)
		}):Play()
	end
end
function v43.setupSidebuttons(p_u_304)
	-- upvalues: (copy) v_u_44, (copy) v_u_40
	local v_u_305 = {}
	for _, v_u_306 in v_u_44.Bottom:GetChildren() do
		if v_u_306:IsA("GuiButton") then
			v_u_306.Activated:Connect(function()
				-- upvalues: (copy) p_u_304, (copy) v_u_306
				p_u_304:goTo(v_u_306.Name)
			end)
			v_u_306.MouseEnter:Connect(function()
				-- upvalues: (ref) v_u_40, (copy) v_u_306, (copy) v_u_305
				v_u_40.target(v_u_306.Frame.Icon, 0.5, 5, {
					["Position"] = UDim2.fromScale(0.5, 0.4),
					["Size"] = UDim2.fromScale(1.1, 1.1)
				})
				for _, v307 in v_u_305 do
					if v307 ~= v_u_306.Frame.Icon then
						v_u_40.target(v307, 1, 3, {
							["ImageColor3"] = Color3.new(0.33, 0.33, 0.33)
						})
					end
				end
			end)
			v_u_306.MouseLeave:Connect(function()
				-- upvalues: (ref) v_u_40, (copy) v_u_306, (copy) v_u_305
				v_u_40.target(v_u_306.Frame.Icon, 0.7, 3, {
					["Position"] = UDim2.fromScale(0.5, 0.5),
					["Size"] = UDim2.fromScale(1, 1)
				})
				for _, v308 in v_u_305 do
					v_u_40.target(v308, 1, 1, {
						["ImageColor3"] = Color3.new(1, 1, 1)
					})
				end
			end)
			local v309 = v_u_306.Frame.Icon
			table.insert(v_u_305, v309)
		end
	end
end
function v43.open(_)
	-- upvalues: (copy) v_u_40, (copy) v_u_44, (copy) v_u_47, (copy) v_u_39
	local v310 = {
		["Position"] = v_u_47,
		["Visible"] = true
	}
	v_u_40.target(v_u_44, 0.8, 5, v310)
	v_u_39.play("ShopOpen")
end
function v43.close(_)
	-- upvalues: (copy) v_u_40, (copy) v_u_44, (copy) v_u_48
	local v311 = {
		["Position"] = v_u_48,
		["Visible"] = false
	}
	v_u_40.target(v_u_44, 0.8, 5, v311)
end
function v43.init(p312)
	p312:setupGlobalRunes()
	p312:setupGamepasses()
	p312:setupPotions()
	p312:setupCodes()
	p312:setupStarterPack()
	p312:setupAllGamepasses()
	p312:setupSidebuttons()
	p312:setupServerLuck()
	p312:setupShards()
	p312:setupDiscord()
	p312:setupResetTickets()
	p312:setupPacks()
	p312:setupFirstTimePurchase()
	p312:setupTokens()
	p312:setupRuneFrames()
end
return v43]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Store]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3767"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.CurrencyData)
local v_u_3 = require(v1.Config.WorldData)
local v_u_4 = require(v1.Enums.WorldTypes)
local v_u_5 = require(v1.Utility.LockUtil)
local v6 = require(v1.Utility.Network)
local v_u_7 = require(v1.Utility.Spring)
local v_u_8 = require(v1.Utility.UI)
local v9 = {}
local v_u_10 = v6.remoteEvent("TeleportEvent")
local v_u_11 = v_u_8:get("Gui", "Teleport").Container
local v_u_12 = v_u_11.Container.ScrollingFrame
local v_u_13 = v_u_11.Position
local v_u_14 = v_u_13 + UDim2.fromScale(0, 1)
local v_u_15 = "World"
local v_u_16 = {}
function v9.open(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_11, (copy) v_u_13
	local v17 = {
		["Position"] = v_u_13,
		["Visible"] = true
	}
	v_u_7.target(v_u_11, 0.8, 5, v17)
end
function v9.close(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_11, (copy) v_u_14
	local v18 = {
		["Position"] = v_u_14,
		["Visible"] = false
	}
	v_u_7.target(v_u_11, 0.8, 5, v18)
end
function v9.select(_, p19)
	-- upvalues: (ref) v_u_15, (copy) v_u_16
	v_u_15 = p19
	for _, v20 in v_u_16 do
		v20.updateVisiblity()
	end
end
function v9.setupTabs(p_u_21)
	-- upvalues: (copy) v_u_11
	for _, v_u_22 in v_u_11.Header.Menus:GetChildren() do
		if v_u_22:IsA("GuiButton") then
			v_u_22.Activated:Connect(function()
				-- upvalues: (copy) p_u_21, (copy) v_u_22
				p_u_21:select(v_u_22.Name)
			end)
		end
	end
end
function v9.setupWorld(_)
	-- upvalues: (copy) v_u_12, (copy) v_u_3, (copy) v_u_10, (copy) v_u_8, (copy) v_u_2, (copy) v_u_5, (copy) v_u_16, (ref) v_u_15
	local v23 = v_u_12.Template
	for v_u_24, v_u_25 in v_u_3 do
		if not v_u_25.Ignore then
			local v_u_26 = v23:Clone()
			v_u_26.Visible = true
			v_u_26.LayoutOrder = v_u_25.Order or 999
			v_u_26.Parent = v_u_12
			v_u_26.Container.NEW.Visible = v_u_25.RecentEvent
			v_u_26.Container.Locked.Visible = false
			v_u_26.Container.WorldImage.Image = v_u_25.Icon
			v_u_26.Container.Header.Title.Text = v_u_25.Name
			if v_u_25.RecentEvent then
				v_u_26.LayoutOrder = -1
			end
			v_u_26.Container.Teleport.Activated:Connect(function()
				-- upvalues: (ref) v_u_10, (copy) v_u_24, (ref) v_u_8
				v_u_10.fire(v_u_24)
				if v_u_8.Current == script.Name then
					v_u_8:close(script.Name)
				end
			end)
			local v27 = v_u_26.Container.Currencies.Template
			for _, v28 in v_u_25.Currencies do
				local v29 = v_u_2[v28]
				if v29 then
					local v30 = v27:Clone()
					v30.Visible = true
					v30.Image = v29.Icon
					v30.Parent = v_u_26.Container.Currencies
				end
			end
			v27:Destroy()
			if v_u_25.LockedData then
				v_u_5.observe(v_u_25.LockedData, function(p31)
					-- upvalues: (copy) v_u_26
					v_u_26.Container.Locked.Visible = p31
				end)
			end
			v_u_16[v_u_24] = {
				["updateVisiblity"] = function()
					-- upvalues: (copy) v_u_25, (copy) v_u_26, (ref) v_u_15
					if v_u_25.RecentEvent then
						v_u_26.Visible = true
						return
					elseif v_u_15 == "Event" then
						v_u_26.Visible = v_u_25.Event
					else
						v_u_26.Visible = not v_u_25.Event
					end
				end
			}
		end
	end
	v23:Destroy()
end
function v9.setupRecentEvent(_)
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_11, (copy) v_u_10, (copy) v_u_8, (copy) v_u_2
	local v_u_32 = v_u_4.VALENTINE_WORLD
	local v33 = v_u_3[v_u_32]
	if v33 then
		local v34 = v_u_11.Container.Event.Container
		v34.Teleport.Activated:Connect(function()
			-- upvalues: (ref) v_u_10, (copy) v_u_32, (ref) v_u_8
			v_u_10.fire(v_u_32)
			if v_u_8.Current == script.Name then
				v_u_8:close(script.Name)
			end
		end)
		local v35 = v34.Currencies.Template
		for _, v36 in v33.Currencies do
			local v37 = v_u_2[v36]
			if v37 then
				local v38 = v35:Clone()
				v38.Visible = true
				v38.Image = v37.Icon
				v38.Parent = v34.Currencies
			end
		end
		v35:Destroy()
	end
end
function v9.init(p39)
	p39:setupWorld()
	p39:setupTabs()
	p39:select("World")
end
return v9]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Teleport]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3768"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Gameplay.Runes.RuneController)
local v_u_3 = require(v1.Config.GamepassData)
local v_u_4 = require(v1.Config.MultiplierData)
local v_u_5 = require(v1.Config.RuneData)
local v_u_6 = require(v1.Config.RuneOpenData)
local v7 = require(v1.Enums.Gamepasses)
local v_u_8 = require(v1.Enums.Products)
local v_u_9 = require(v1.Utility.FontFn)
local v_u_10 = require(v1.Utility.Format)
local v_u_11 = require(v1.Utility.GamepassUtil)
local v_u_12 = require(v1.Utility.Marketplace)
local v13 = require(v1.Utility.Network)
local v_u_14 = require(v1.Utility.Notify)
local v_u_15 = require(v1.Utility.PlayerListUtil)
local v_u_16 = require(v1.Utility.Spring)
local v17 = {}
local v_u_18 = require(v1.Utility.UI):get("Gui", "Runes").Container
local v19 = v_u_18.Container
local v_u_20 = v19.Right
local v_u_21 = v_u_20.Template
v_u_21.Visible = false
local v_u_22 = v19.Left
local v_u_23 = v_u_22.Template
v_u_23.Visible = false
local v_u_24 = {}
local v_u_25 = {
	["Menu"] = "Main",
	["Tab"] = nil
}
local v_u_26 = {}
local v_u_27 = v_u_18.Position
local v_u_28 = v_u_27 + UDim2.fromScale(0, 1)
local v_u_29 = { v7.RuneBulk2x, v7.RuneClone2x, v7.FasterRunes }
local v_u_30 = v13.remoteFunction("GiftEvent")
function v17.open(_)
	-- upvalues: (copy) v_u_16, (copy) v_u_18, (copy) v_u_27
	local v31 = {
		["Position"] = v_u_27,
		["Visible"] = true
	}
	v_u_16.target(v_u_18, 0.8, 5, v31)
end
function v17.close(_)
	-- upvalues: (copy) v_u_16, (copy) v_u_18, (copy) v_u_28
	local v32 = {
		["Position"] = v_u_28,
		["Visible"] = false
	}
	v_u_16.target(v_u_18, 0.8, 5, v32)
end
function v17.loadGamepasses(_)
	-- upvalues: (copy) v_u_18, (copy) v_u_29, (copy) v_u_3, (copy) v_u_11, (copy) v_u_8, (copy) v_u_12, (copy) v_u_10, (copy) v_u_15, (copy) v_u_30, (copy) v_u_14
	local v33 = v_u_18.Passes.Template
	for _, v_u_34 in v_u_29 do
		local v_u_35 = v_u_3[v_u_34]
		local v_u_36 = v33:Clone()
		v_u_36.LayoutOrder = v_u_35.Order or 99
		v_u_36.Visible = true
		v_u_36.Parent = v33.Parent
		v_u_36.Name = tostring(v_u_34)
		v_u_36.Title.Text = v_u_35.Name
		v_u_36.Desc.Text = v_u_35.Description
		v_u_36.Icon.Image = v_u_35.Icon
		v_u_36.Faded_Icon.Image = v_u_36.Icon.Image
		v_u_36.UIGradient.Color = v_u_35.Gradient or ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 220, 95)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 160, 50)) })
		if v_u_35.Rotation then
			v_u_36.UIGradient.Rotation = v_u_35.Rotation
		end
		if v_u_35.Animated then
			v_u_36.UIGradient:AddTag("Gradient")
		end
		local v_u_37 = false
		v_u_11.observe(v_u_35.ID, function(p38)
			-- upvalues: (ref) v_u_37, (copy) v_u_36
			if p38 then
				v_u_37 = true
				v_u_36.Buttons.Robux.Price.Text = "Owned"
			end
		end)
		v_u_36.Buttons.Gift.Visible = v_u_8.Gamepasses[v_u_34] ~= nil
		v_u_12.ObserveGamepass(v_u_35.ID, function(p39)
			-- upvalues: (copy) v_u_36, (ref) v_u_37, (ref) v_u_10
			v_u_36.Visible = p39.IsForSale
			v_u_36.Desc.Text = p39.Description
			v_u_36.Title.Text = p39.Name
			v_u_36.Icon.Image = ("rbxassetid://%*"):format(p39.IconImageAssetId)
			v_u_36.Faded_Icon.Image = v_u_36.Icon.Image
			if not v_u_37 then
				v_u_36.Buttons.Robux.Price.Text = v_u_10.robux((("%*"):format((v_u_10.comma(p39.PriceInRobux)))))
			end
		end)
		v_u_36.Buttons.Robux.Activated:Connect(function()
			-- upvalues: (ref) v_u_37, (ref) v_u_12, (copy) v_u_35
			if not v_u_37 then
				v_u_12.PromptGamepass(v_u_35.ID)
			end
		end)
		v_u_36.Buttons.Gift.Activated:Connect(function()
			-- upvalues: (ref) v_u_15, (ref) v_u_11, (copy) v_u_35, (ref) v_u_30, (copy) v_u_34, (ref) v_u_14
			v_u_15.open(function(p40)
				-- upvalues: (ref) v_u_11, (ref) v_u_35, (ref) v_u_30, (ref) v_u_34, (ref) v_u_14
				local v41 = v_u_11.fetch(p40)
				if v41 and table.find(v41, v_u_35.ID) then
					return false, "Player already owns this gamepass!"
				end
				local v42, v43 = v_u_30.invoke(p40, v_u_34)
				if v42 then
					return true
				end
				v_u_14.Notify({
					["Message"] = v43,
					["Type"] = v_u_14.Types.Error
				})
				return false, v43
			end)
		end)
	end
	v33:Destroy()
end
function v17.loadRunes(p44, p_u_45)
	-- upvalues: (copy) v_u_6, (copy) v_u_24, (copy) v_u_25, (copy) v_u_16, (copy) v_u_5, (copy) v_u_21, (copy) v_u_10, (copy) v_u_20, (copy) v_u_4, (copy) v_u_9, (copy) v_u_2
	local v46 = v_u_6[p_u_45]
	if v46 then
		if v_u_24[p_u_45] then
			if v_u_25.Tab ~= p_u_45 then
				if v_u_25.Tab and v_u_24[v_u_25.Tab] then
					for _, v47 in v_u_24[v_u_25.Tab] do
						v47.Visible = false
						v47.UIScale.Scale = 0
						v_u_16.stop(v47.UIScale)
					end
				end
				for _, v48 in v_u_24[p_u_45] do
					v48.Visible = not v48:GetAttribute("Locked")
					v_u_16.target(v48.UIScale, 0.6, 3, {
						["Scale"] = 1
					})
					task.wait(0.01)
				end
				v_u_25.Tab = p_u_45
			end
		else
			v_u_24[p_u_45] = {}
			for _, v49 in v46.Runes do
				local v_u_50 = v_u_5[v49]
				local v_u_51 = v_u_21:Clone()
				v_u_51.Name = v49
				v_u_51.Visible = false
				v_u_51.UIScale.Scale = 0
				v_u_51.LayoutOrder = v_u_50.Order or 0
				v_u_51:SetAttribute("Locked", v_u_50.Secret == true)
				if v_u_50.ShowPercentage then
					local v52 = v_u_51.Container.Header.Title
					local v53 = v_u_50.Name
					local v54 = v_u_10.decimal
					local v55 = v_u_50.Chance * 10000
					v52.Text = ("%* (%*%%)"):format(v53, (v54(math.floor(v55) / 10000)))
				else
					v_u_51.Container.Header.Title.Text = ("%* (1 in %*)"):format(v_u_50.Name, (v_u_10.abbreviateComma(v_u_50.Chance or 0)))
				end
				v_u_51.Container.Header.Quantity.Text = 0
				v_u_51.Container.UIGradient.Color = v_u_50.Gradient
				v_u_51.Parent = v_u_20
				local function v_u_67(p56)
					-- upvalues: (copy) v_u_50, (ref) v_u_4, (ref) v_u_9, (copy) v_u_51
					local v57 = {}
					for _, v58 in v_u_50.Buffs do
						local v59 = v_u_4[v58.type]
						if v59 then
							local v60 = v58.max or (1 / 0)
							local v61 = v58.value * p56
							local v62 = math.min(v61, v60)
							local v63 = v59.FormatBuff and v59.FormatBuff(v62) or v59.Format(v62)
							local v64 = v_u_9.color
							local v65 = ("%* %*"):format(v63, v59.ShortName or v59.Name)
							local v66 = v59.Color or Color3.new(1, 1, 1)
							table.insert(v57, v64(v65, v66))
						end
					end
					v_u_51.Container.Title.Text = table.concat(v57, ", ")
				end
				v_u_67(0)
				if v_u_50.Animated then
					v_u_51.Container.UIGradient:AddTag("Gradient")
				end
				v_u_2:observe(v49, function(p68)
					-- upvalues: (copy) v_u_51, (copy) v_u_50, (ref) v_u_25, (copy) p_u_45, (copy) v_u_67, (ref) v_u_10
					v_u_51.Container.Title.Visible = p68 > 0
					v_u_51.Container.Folder.Overlay.Visible = not v_u_51.Container.Title.Visible
					if v_u_50.Secret then
						v_u_51:SetAttribute("Locked", p68 <= 0)
						if p68 > 0 and v_u_25.Tab == p_u_45 then
							v_u_51.Visible = true
						end
					end
					v_u_67(p68)
					v_u_51.Container.Header.Quantity.Text = v_u_10.abbreviateComma(p68)
				end)
				v_u_24[p_u_45][v49] = v_u_51
			end
			p44:loadRunes(p_u_45)
			return
		end
	else
		return
	end
end
function v17.loadTabs(p_u_69)
	-- upvalues: (copy) v_u_6, (copy) v_u_23, (copy) v_u_25, (copy) v_u_22, (copy) v_u_26
	for v_u_70, v71 in v_u_6 do
		local v72 = v_u_23:Clone()
		v72.Visible = v_u_25.Menu == v71.Category
		v72.Name = v_u_70
		v72.Container.Title.Text = v71.Name
		v72.Container.UIGradient.Color = v71.Gradient
		v72.LayoutOrder = v71.Order or 9
		v72.Parent = v_u_22
		v72:SetAttribute("Locked", false)
		if v71.Animated then
			v72.Container.UIGradient:AddTag("Gradient")
		end
		v72.Activated:Connect(function()
			-- upvalues: (copy) p_u_69, (copy) v_u_70
			p_u_69:loadRunes(v_u_70)
		end)
		if not v_u_26[v71.Category] then
			v_u_26[v71.Category] = {}
		end
		local v73 = v_u_26[v71.Category]
		table.insert(v73, v72)
	end
end
function v17.selectMenu(_, p74)
	-- upvalues: (copy) v_u_25, (copy) v_u_26
	if v_u_25.Menu ~= p74 then
		for _, v75 in v_u_26[v_u_25.Menu] or {} do
			v75.Visible = false
		end
		v_u_25.Menu = p74
		for _, v76 in v_u_26[v_u_25.Menu] or {} do
			v76.Visible = not v76:GetAttribute("Locked")
		end
	end
end
function v17.setupMenus(p_u_77)
	-- upvalues: (copy) v_u_18
	for _, v_u_78 in v_u_18.Header.Menus:GetChildren() do
		if v_u_78:IsA("GuiButton") then
			v_u_78.Activated:Connect(function()
				-- upvalues: (copy) p_u_77, (copy) v_u_78
				p_u_77:selectMenu(v_u_78.Name)
			end)
		end
	end
end
function v17.init(p79)
	p79:loadTabs()
	p79:setupMenus()
	p79:loadGamepasses()
	p79:loadRunes("WORLD_1_RUNES")
end
return v17]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Runes]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3769"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.Statistics.StatisticController)
local v_u_3 = require(v1.Config.StatisticCategoryData)
local v_u_4 = require(v1.Config.StatisticsData)
local v_u_5 = require(v1.Packages.Topbarplus)
local v_u_6 = require(v1.Utility.LockUtil)
local v_u_7 = require(v1.Utility.Multiplier)
local v_u_8 = require(v1.Utility.Spring)
local v_u_9 = require(v1.Utility.UI)
local v10 = {}
local v_u_11 = v_u_9:get("Gui", "Profiles").Container
local v_u_12 = v_u_11.Container.ScrollingFrame
local v_u_13 = v_u_11.Position
local v_u_14 = v_u_13 + UDim2.fromScale(0, 1)
function v10.open(_)
	-- upvalues: (copy) v_u_8, (copy) v_u_11, (copy) v_u_13
	local v15 = {
		["Position"] = v_u_13,
		["Visible"] = true
	}
	v_u_8.target(v_u_11, 0.8, 5, v15)
end
function v10.close(_)
	-- upvalues: (copy) v_u_8, (copy) v_u_11, (copy) v_u_14
	local v16 = {
		["Position"] = v_u_14,
		["Visible"] = false
	}
	v_u_8.target(v_u_11, 0.8, 5, v16)
end
function v10.setupStats(_)
	-- upvalues: (copy) v_u_12, (copy) v_u_3, (copy) v_u_4, (copy) v_u_6, (copy) v_u_7, (copy) v_u_2
	local v17 = v_u_12.Template
	local v18 = v_u_12.TitleTemplate
	local v19 = {}
	for v20, v21 in v_u_3 do
		local v22 = v18:Clone()
		v22.Visible = true
		v22.Title.Text = v21.Name
		v22.LayoutOrder = v21.Order * 1000
		v22.Parent = v18.Parent
		v19[v20] = v22.LayoutOrder
	end
	for v23, v_u_24 in v_u_4 do
		local v_u_25 = v17:Clone()
		v_u_25.Visible = true
		v_u_25.Title.Text = v_u_24.Name
		v_u_25.LayoutOrder = (v19[v_u_24.Category] or 0) + (v_u_24.Order or 99)
		v_u_25.Parent = v17.Parent
		if v_u_24.Gradient then
			v_u_25.UIGradient.Color = v_u_24.Gradient
		else
			local v26 = v_u_3[v_u_24.Category]
			if v26 and v26.Gradient then
				v_u_25.UIGradient.Color = v26.Gradient
			end
		end
		if v_u_24.LockedData then
			v_u_6.observe(v_u_24.LockedData, function(p27)
				-- upvalues: (copy) v_u_25
				v_u_25.Visible = not p27
			end)
		end
		if v_u_24.Multiplier then
			local function v31()
				-- upvalues: (ref) v_u_7, (copy) v_u_24, (copy) v_u_25
				local v28 = v_u_7.get(v_u_24.Multiplier.base)
				local v29 = v_u_24.Multiplier.multiplier and v_u_7.get(v_u_24.Multiplier.multiplier) or 1
				local v30 = v28 * v29
				if v_u_24.GetValue then
					v30 = v_u_24.GetValue(v28, v29)
				end
				v_u_25.Value.Text = v_u_24.Format(v30)
			end
			for _, v32 in v_u_24.Multiplier do
				v_u_7.observe(v32, v31)
			end
		else
			v_u_2:observe(v23, function(p33)
				-- upvalues: (copy) v_u_24, (copy) v_u_25
				if v_u_24.CanShow then
					v_u_25.Visible = v_u_24:CanShow(p33)
				end
				v_u_25.Value.Text = v_u_24.Format(p33)
			end)
		end
		if v_u_24.GetFullValue and v_u_24.Updates then
			local function v35()
				-- upvalues: (copy) v_u_24, (copy) v_u_25
				local v34 = v_u_24.GetFullValue()
				if typeof(v34) == "string" then
					v_u_25.Value.Text = v34
				else
					v_u_25.Value.Text = v_u_24.Format(v34)
				end
			end
			for _, v36 in v_u_24.Updates do
				v_u_7.observe(v36, v35)
			end
		end
	end
	v18:Destroy()
	v17:Destroy()
end
function v10.init(p37)
	-- upvalues: (copy) v_u_5, (copy) v_u_9
	p37:setupStats()
	local v_u_38 = v_u_5.new()
	v_u_38:setImage("rbxassetid://78966829891086")
	v_u_38.selected:Connect(function()
		-- upvalues: (ref) v_u_9, (copy) v_u_38
		if v_u_9.Current == script.Name then
			v_u_9:close(script.Name)
		else
			v_u_9:open(script.Name)
		end
		v_u_38:deselect()
	end)
end
return v10]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Profiles]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3770"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Client.Gameplay.Mastery.MasteryController)
local v_u_4 = require(v1.Config.Colors)
local v_u_5 = require(v1.Config.MasteryData)
local v_u_6 = require(v1.Config.MultiplierData)
local v_u_7 = require(v1.Config.TierData)
local v8 = require(v1.Utility.Network)
local v_u_9 = require(v1.Utility.Notify)
local v_u_10 = require(v1.Utility.Spring)
local v11 = require(v1.Utility.UI)
local v12 = {}
local v_u_13 = v11:get("Gui", "Mastery").Container
local v_u_14 = v11:get("Huds", "Left").Container.Row2.Mastery.Noti
v_u_14.Visible = false
local v_u_15 = v8.remoteFunction("MasteryServiceClaim")
local v_u_16 = v_u_13.Position
local v_u_17 = v_u_16 + UDim2.fromScale(0, 1)
local v_u_18 = {}
function v12.open(_)
	-- upvalues: (copy) v_u_10, (copy) v_u_13, (copy) v_u_16
	local v19 = {
		["Position"] = v_u_16,
		["Visible"] = true
	}
	v_u_10.target(v_u_13, 0.8, 5, v19)
end
function v12.close(_)
	-- upvalues: (copy) v_u_10, (copy) v_u_13, (copy) v_u_17
	local v20 = {
		["Position"] = v_u_17,
		["Visible"] = false
	}
	v_u_10.target(v_u_13, 0.8, 5, v20)
end
function v12.setupMastery(_)
	-- upvalues: (copy) v_u_13, (copy) v_u_5, (copy) v_u_15, (copy) v_u_9, (copy) v_u_18, (copy) v_u_2, (copy) v_u_14, (copy) v_u_6, (copy) v_u_7, (copy) v_u_4
	local v21 = v_u_13.Container.ScrollingFrame.Template
	local v_u_22 = {}
	for v_u_23, v_u_24 in v_u_5 do
		local v25 = v21:Clone()
		v25.Name = v_u_23
		v25.Visible = true
		v25.LayoutOrder = v_u_24.Order
		v25.Parent = v21.Parent
		local v_u_26 = v25.Container
		v_u_26.Header.Title.Text = v_u_24.Name
		v_u_26.Claim.Activated:Connect(function()
			-- upvalues: (ref) v_u_15, (copy) v_u_23, (ref) v_u_9
			local v27, v28 = v_u_15.invoke(v_u_23)
			v_u_9.Notify({
				["Message"] = v28,
				["Type"] = v27 and v_u_9.Types.Success or v_u_9.Types.Error
			})
		end)
		local v_u_29 = -1
		local v_u_30 = {}
		local v_u_31 = v_u_26.Buffs.Template
		v_u_31.Visible = false
		local v_u_32 = false
		v_u_18[v_u_23] = {
			["update"] = function()
				-- upvalues: (ref) v_u_2, (copy) v_u_23, (ref) v_u_29, (copy) v_u_22, (ref) v_u_14, (copy) v_u_24, (copy) v_u_30, (ref) v_u_6, (copy) v_u_31, (copy) v_u_26, (ref) v_u_7, (ref) v_u_4, (ref) v_u_32, (ref) v_u_9
				local v33 = v_u_2:getValue({ "Mastery", v_u_23, "tier" })
				local v34 = v_u_2:getValue({ "Mastery", v_u_23, "progress" })
				if v33 ~= v_u_29 then
					v_u_29 = v33
					local v35 = table.find(v_u_22, v_u_23)
					if v35 then
						table.remove(v_u_22, v35)
					end
					if #v_u_22 <= 0 then
						v_u_14.Visible = false
					end
					local v36 = v_u_24.Tiers[v33]
					local v37 = v_u_24.Tiers[v33 + 1]
					for _, v38 in v_u_30 do
						v38:Destroy()
					end
					table.clear(v_u_30)
					if not v37 then
						for _, v39 in v36.Buffs do
							local v40 = v_u_6[v39.multiplier]
							if v40 then
								local v41 = v_u_31:Clone()
								v41.Image = v40.Icon
								v41.Visible = true
								v41.Title.Text = v40.Format(v39.value)
								v41.Parent = v_u_26.Buffs
								v41:SetAttribute("Multiplier", v39.multiplier)
								v41:SetAttribute("Current", v39.value)
								v41:SetAttribute("ItemType", "MasteryPerk")
								v41:AddTag("tooltip")
								local v42 = v_u_30
								table.insert(v42, v41)
							end
						end
						v_u_26.Progress.Visible = false
						v_u_26.Title.Text = "Maxed!"
						v_u_26.Title.Position = UDim2.fromScale(0.5, 0.97)
						v_u_26.Title.AnchorPoint = Vector2.new(0.5, 1)
						v_u_26.Claim.Visible = false
						return
					end
					local v43 = {}
					if v36 then
						for _, v44 in v36.Buffs do
							v43[v44.multiplier] = v44.value
						end
					end
					for _, v45 in v37.Buffs or {} do
						local v46 = v_u_6[v45.multiplier]
						if v46 then
							local v47 = v_u_31:Clone()
							v47.Image = v46.Icon
							v47.Visible = true
							v47.Title.Text = v46.Format(v45.value)
							v47.Parent = v_u_26.Buffs
							v47:SetAttribute("Multiplier", v45.multiplier)
							v47:SetAttribute("Current", v45.value)
							v47:SetAttribute("Previous", v43[v45.multiplier] or 0)
							v47:SetAttribute("ItemType", "MasteryPerk")
							v47:AddTag("tooltip")
							local v48 = v_u_30
							table.insert(v48, v47)
						end
					end
				end
				local v49 = v_u_7[v33]
				if v49 then
					v_u_26.UIGradient:RemoveTag("Gradient")
					v_u_26.UIGradient.Color = v49.Gradient
					if v49.Animated then
						v_u_26.UIGradient:AddTag("Gradient")
					end
				end
				local v50 = v_u_24.Tiers[v33 + 1]
				if v50 then
					local v51 = v34 / v50.Amount
					local v52 = math.clamp(v51, 0, 1)
					local v53 = v52 >= 1
					v_u_26.Progress.Title.Text = v_u_24:Format(v34)
					v_u_26.Progress.UIGradient.Offset = Vector2.new(v52, 0)
					v_u_26.Title.Text = v_u_24:FormatDescription(v50.Amount)
					v_u_26.Claim.UIGradient.Color = v53 and v_u_4.Green.Gradient or v_u_4.Grey.Gradient
					v_u_26.Claim.UIStroke.Color = v53 and v_u_4.Green.Stroke or v_u_4.Grey.Stroke
					v_u_26.Claim.Title.UIStroke.Color = v53 and v_u_4.Green.Stroke or v_u_4.Grey.Stroke
					if not v53 then
						v_u_32 = false
					end
					if #v_u_22 <= 0 then
						v_u_14.Visible = false
					end
					if v53 and not v_u_32 then
						if not table.find(v_u_22, v_u_23) then
							local v54 = v_u_22
							local v55 = v_u_23
							table.insert(v54, v55)
							v_u_14.Visible = true
						end
						v_u_9.Notify({
							["Message"] = ("%* mastery is claimable!"):format(v_u_24.Name),
							["Type"] = v_u_9.Types.Success
						})
						v_u_32 = true
					end
				end
			end
		}
		v_u_18[v_u_23].update()
	end
	v21:Destroy()
end
function v12.init(p56)
	-- upvalues: (copy) v_u_3, (copy) v_u_18
	p56:setupMastery()
	v_u_3.MasteryUpdated:Connect(function(p57)
		-- upvalues: (ref) v_u_18
		if v_u_18[p57] then
			v_u_18[p57].update()
		end
	end)
end
return v12]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Mastery]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3771"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Currency.CurrencyController)
local v_u_3 = require(v1.Client.Data.DataController)
local v_u_4 = require(v1.Client.Gameplay.Skills.SkillController)
local v_u_5 = require(v1.Client.Gameplay.Skills.SkillResetController)
local v6 = require(v1.Config.Constants)
local v_u_7 = require(v1.Config.GamepassData)
local v_u_8 = require(v1.Config.SkillData)
local v_u_9 = require(v1.Enums.CurrencyTypes)
local v10 = require(v1.Enums.Gamepasses)
local v_u_11 = require(v1.Enums.Products)
local v_u_12 = require(v1.Functions.CalculateSkillXP)
local v_u_13 = require(v1.Utility.ConfirmationUtil)
local v_u_14 = require(v1.Utility.Format)
local v_u_15 = require(v1.Utility.GamepassUtil)
local v_u_16 = require(v1.Utility.LockUtil)
local v_u_17 = require(v1.Utility.Marketplace)
local v18 = require(v1.Utility.Network)
local v_u_19 = require(v1.Utility.Notify)
local v_u_20 = require(v1.Utility.PlayerListUtil)
local v_u_21 = require(v1.Utility.Spring)
local v22 = {}
local v_u_23 = require(v1.Utility.UI):get("Gui", "Skills").Container
local v_u_24 = v_u_23.Container.ScrollingFrame
local v_u_25 = v_u_23.Bottom
local v_u_26 = v_u_23.Position
local v_u_27 = v_u_26 + UDim2.fromScale(0, 1)
local v_u_28 = v18.remoteFunction("SkillServiceUpgrade")
local v_u_29 = v18.remoteFunction("SkillServiceUnlock")
local v_u_30 = { v10.SkillXP2x, v10.SkillXP3x, v10.SkillXP5x }
local v_u_31 = v18.remoteFunction("GiftEvent")
local v_u_32 = {}
local v_u_33 = v6.SKILL_LEVEL_CAP
function v22.open(_)
	-- upvalues: (copy) v_u_21, (copy) v_u_23, (copy) v_u_26
	local v34 = {
		["Position"] = v_u_26,
		["Visible"] = true
	}
	v_u_21.target(v_u_23, 0.8, 5, v34)
end
function v22.close(_)
	-- upvalues: (copy) v_u_21, (copy) v_u_23, (copy) v_u_27
	local v35 = {
		["Position"] = v_u_27,
		["Visible"] = false
	}
	v_u_21.target(v_u_23, 0.8, 5, v35)
end
function v22.loadGamepasses(_)
	-- upvalues: (copy) v_u_23, (copy) v_u_30, (copy) v_u_7, (copy) v_u_15, (copy) v_u_11, (copy) v_u_17, (copy) v_u_14, (copy) v_u_20, (copy) v_u_31, (copy) v_u_19
	local v36 = v_u_23.Passes.Template
	for _, v_u_37 in v_u_30 do
		local v_u_38 = v_u_7[v_u_37]
		local v_u_39 = v36:Clone()
		v_u_39.LayoutOrder = v_u_38.Order or 99
		v_u_39.Visible = true
		v_u_39.Parent = v36.Parent
		v_u_39.Name = tostring(v_u_37)
		v_u_39.Title.Text = v_u_38.Name
		v_u_39.Desc.Text = v_u_38.Description
		v_u_39.Icon.Image = v_u_38.Icon
		v_u_39.Faded_Icon.Image = v_u_39.Icon.Image
		v_u_39.UIGradient.Color = v_u_38.Gradient or ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 220, 95)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 160, 50)) })
		if v_u_38.Rotation then
			v_u_39.UIGradient.Rotation = v_u_38.Rotation
		end
		if v_u_38.Animated then
			v_u_39.UIGradient:AddTag("Gradient")
		end
		local v_u_40 = false
		v_u_15.observe(v_u_38.ID, function(p41)
			-- upvalues: (ref) v_u_40, (copy) v_u_39
			if p41 then
				v_u_40 = true
				v_u_39.Buttons.Robux.Price.Text = "Owned"
			end
		end)
		v_u_39.Buttons.Gift.Visible = v_u_11.Gamepasses[v_u_37] ~= nil
		v_u_17.ObserveGamepass(v_u_38.ID, function(p42)
			-- upvalues: (copy) v_u_39, (ref) v_u_40, (ref) v_u_14
			v_u_39.Visible = p42.IsForSale
			v_u_39.Desc.Text = p42.Description
			v_u_39.Title.Text = p42.Name
			v_u_39.Icon.Image = ("rbxassetid://%*"):format(p42.IconImageAssetId)
			v_u_39.Faded_Icon.Image = v_u_39.Icon.Image
			if not v_u_40 then
				v_u_39.Buttons.Robux.Price.Text = v_u_14.robux((("%*"):format((v_u_14.comma(p42.PriceInRobux)))))
			end
		end)
		v_u_39.Buttons.Robux.Activated:Connect(function()
			-- upvalues: (ref) v_u_40, (ref) v_u_17, (copy) v_u_38
			if not v_u_40 then
				v_u_17.PromptGamepass(v_u_38.ID)
			end
		end)
		v_u_39.Buttons.Gift.Activated:Connect(function()
			-- upvalues: (ref) v_u_20, (ref) v_u_15, (copy) v_u_38, (ref) v_u_31, (copy) v_u_37, (ref) v_u_19
			v_u_20.open(function(p43)
				-- upvalues: (ref) v_u_15, (ref) v_u_38, (ref) v_u_31, (ref) v_u_37, (ref) v_u_19
				local v44 = v_u_15.fetch(p43)
				if v44 and table.find(v44, v_u_38.ID) then
					return false, "Player already owns this gamepass!"
				end
				local v45, v46 = v_u_31.invoke(p43, v_u_37)
				if v45 then
					return true
				end
				v_u_19.Notify({
					["Message"] = v46,
					["Type"] = v_u_19.Types.Error
				})
				return false, v46
			end)
		end)
	end
	v36:Destroy()
end
function v22.loadSkills(_)
	-- upvalues: (copy) v_u_24, (copy) v_u_8, (copy) v_u_16, (copy) v_u_29, (copy) v_u_3, (copy) v_u_28, (copy) v_u_19, (copy) v_u_32, (copy) v_u_4
	local v47 = v_u_24.Template
	for v_u_48, v_u_49 in v_u_8 do
		local v_u_50 = v47:Clone()
		v_u_50.Visible = true
		v_u_50.Name = v_u_48
		v_u_50.LayoutOrder = v_u_49.Order
		v_u_50.Parent = v_u_24
		v_u_50.Header.Title.Text = v_u_49.Name
		v_u_50.Header.Icon.Image = v_u_49.Icon
		v_u_50.Folder.Overlay.Visible = false
		if v_u_49.LockedData then
			v_u_16.observe(v_u_49.LockedData, function(p51)
				-- upvalues: (copy) v_u_50
				v_u_50.Visible = not p51
			end)
		end
		v_u_50.Folder.Purchase.Purchase.TextLabel.Text = v_u_49.Cost
		v_u_50.Folder.Purchase.Purchase.Activated:Connect(function()
			-- upvalues: (ref) v_u_29, (copy) v_u_48
			v_u_29.invoke(v_u_48)
		end)
		local v_u_52 = 0
		local function v_u_55()
			-- upvalues: (copy) v_u_49, (ref) v_u_3, (copy) v_u_50, (ref) v_u_52
			local v53 = 0
			for v54, _ in v_u_49.Upgrades do
				v53 = v53 + (v_u_3:getValue({ "Skills", "Upgrades", v54 }) or 0)
			end
			v_u_50.Header.Folder.Title.Text = ("%* / %*"):format(v53, v_u_52)
		end
		local v56 = v_u_50.SkillTemplate
		local v57 = v_u_52
		for v_u_58, v_u_59 in v_u_49.Upgrades do
			local v_u_60 = v56:Clone()
			v_u_60.Visible = true
			v_u_60.Name = v_u_58
			v_u_60.LayoutOrder = v_u_59.Order or 1
			v_u_60.Title.Text = v_u_59.Levels[1].Description
			v_u_60.Parent = v_u_50
			if v_u_59.LockedData then
				v_u_16.observe(v_u_59.LockedData, function(p61)
					-- upvalues: (copy) v_u_60
					v_u_60.Visible = not p61
				end)
			else
				v_u_60.Visible = true
			end
			v_u_52 = v57 + #v_u_59.Levels
			v_u_60.Purchase.Activated:Connect(function()
				-- upvalues: (ref) v_u_28, (copy) v_u_48, (copy) v_u_58, (ref) v_u_19
				local v62, v63 = v_u_28.invoke(v_u_48, v_u_58)
				v_u_19.Notify({
					["Message"] = v63,
					["Type"] = v62 and v_u_19.Types.Success or v_u_19.Types.Error
				})
			end)
			v_u_3:onSet({ "Skills", "Upgrades", v_u_58 }, function(p64)
				-- upvalues: (copy) v_u_59, (copy) v_u_60, (copy) v_u_55
				local v65 = (p64 or 0) + 1 > #v_u_59.Levels
				local v66 = v_u_59.Levels[(p64 or 0) + 1] or v_u_59.Levels[#v_u_59.Levels]
				v_u_60.Title.Text = v66.Description
				v_u_60.Purchase.TextLabel.Text = v66.Cost
				v_u_60.Purchase.Visible = not v65
				v_u_55()
			end)
			v57 = v_u_52
		end
		v_u_55()
		v56:Destroy()
		v_u_32[v_u_48] = {
			["Unlock"] = function()
				-- upvalues: (copy) v_u_50
				v_u_50.Folder.Purchase.Visible = false
			end,
			["Lock"] = function()
				-- upvalues: (copy) v_u_50
				v_u_50.Folder.Purchase.Visible = true
			end,
			["Update"] = v_u_55
		}
		v_u_32[v_u_48].Lock()
	end
	for _, v67 in v_u_3:getValue({ "Skills", "Unlocked" }) or {} do
		if v_u_32[v67] then
			v_u_32[v67].Unlock()
		end
	end
	v_u_3:onChange(function(_, p68, p69, _)
		-- upvalues: (ref) v_u_32
		if p68[1] == "Skills" then
			if p68[2] == "Unlocked" then
				if typeof(p69) == "table" then
					return
				end
				if v_u_32[p69] then
					v_u_32[p69].Unlock()
				end
			end
		end
	end)
	v_u_4.OnReset:Connect(function()
		-- upvalues: (ref) v_u_32, (ref) v_u_4
		for v70, v71 in v_u_32 do
			if v_u_4:isUnlocked(v70) then
				v71.Unlock()
			else
				v71.Lock()
			end
			v71.Update()
		end
	end)
	v47:Destroy()
end
function v22.setupProgress(_)
	-- upvalues: (copy) v_u_25, (copy) v_u_3, (copy) v_u_33, (copy) v_u_12, (copy) v_u_14
	local v_u_72 = v_u_25.Progress
	local v_u_73 = v_u_72.Title
	local function v77()
		-- upvalues: (ref) v_u_3, (ref) v_u_33, (copy) v_u_73, (copy) v_u_72, (ref) v_u_12, (ref) v_u_14
		local v74 = v_u_3:getValue({ "Skills", "XP" })
		local v75 = v_u_3:getValue({ "Skills", "Level" })
		if v_u_33 <= v75 then
			v_u_73.Text = "Max Level"
			v_u_72.UIGradient.Offset = Vector2.new(1, 0)
		else
			local v76 = v_u_12(v75 + 1)
			v_u_72.UIGradient.Offset = Vector2.new(v74 / v76, 0)
			v_u_73.Text = ("%* / %* XP (%* > %*)"):format(v_u_14.abbreviateComma(v74), v_u_14.abbreviateComma(v76), v75, v75 + 1)
		end
	end
	v_u_3:onSet({ "Skills", "XP" }, v77)
	v_u_3:onSet({ "Skills", "Level" }, v77)
end
function v22.init(p78)
	-- upvalues: (copy) v_u_23, (copy) v_u_2, (copy) v_u_9, (copy) v_u_17, (copy) v_u_11, (copy) v_u_13, (copy) v_u_5
	p78:loadSkills()
	p78:setupProgress()
	p78:loadGamepasses()
	v_u_23.Header.Reset.Activated:Connect(function()
		-- upvalues: (ref) v_u_2, (ref) v_u_9, (ref) v_u_17, (ref) v_u_11, (ref) v_u_13, (ref) v_u_5
		if v_u_2:get(v_u_9.SkillResetTickets) <= 0 then
			v_u_17.PromptProduct(v_u_11.ResetTickets[1])
		else
			local v79 = {
				["Title"] = "Are you sure you want to reset your skill points? This includes Skill Upgrades and Skill Upgrade Tree",
				["YesCallback"] = function()
					-- upvalues: (ref) v_u_5
					v_u_5:requestReset()
				end
			}
			v_u_13.prompt(v79)
		end
	end)
end
return v22]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Skills]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3772"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Gameplay.Index.IndexController)
local v_u_3 = require(v1.Config.IndexRewardData)
local v_u_4 = require(v1.Config.SlimeVarientData)
local v_u_5 = require(v1.Config.SlimeData)
local v_u_6 = require(v1.Config.WorldData)
local v_u_7 = require(v1.Enums.IndexTypes)
local v_u_8 = require(v1.Enums.SlimeVarientTypes)
local v9 = require(v1.Packages.Janitor)
local v_u_10 = require(v1.Utility.Format)
local v_u_11 = require(v1.Utility.Spring)
local v12 = {}
local v_u_13 = require(v1.Utility.UI):get("Gui", "Index").Container
local v_u_14 = v_u_13.Container.ScrollingFrame
local v_u_15 = v_u_13.Viewing
local v_u_16 = v_u_13.Position
local v_u_17 = v_u_16 + UDim2.fromScale(0, 1)
local v_u_18 = {}
local v_u_19 = {}
local v_u_20 = nil
local v_u_21 = v9.new()
function v12.open(p22)
	-- upvalues: (copy) v_u_11, (copy) v_u_13, (copy) v_u_16
	local v23 = {
		["Position"] = v_u_16,
		["Visible"] = true
	}
	v_u_11.target(v_u_13, 0.8, 5, v23)
	p22:updateView()
end
function v12.close(_)
	-- upvalues: (copy) v_u_11, (copy) v_u_13, (copy) v_u_17
	local v24 = {
		["Position"] = v_u_17,
		["Visible"] = false
	}
	v_u_11.target(v_u_13, 0.8, 5, v24)
end
function v12.updateView(_)
	-- upvalues: (copy) v_u_21, (ref) v_u_20, (copy) v_u_15, (copy) v_u_5, (copy) v_u_4, (copy) v_u_2, (copy) v_u_7, (copy) v_u_10, (copy) v_u_11
	v_u_21:Cleanup()
	if v_u_20 == nil then
		v_u_15.Header.Title.Text = "Select a slime"
		v_u_15.Header.UIGradient.Color = ColorSequence.new(Color3.fromRGB(87, 87, 87))
		v_u_15.Total.Value.Text = "0"
	else
		local v25 = v_u_5[v_u_20]
		local v26 = v_u_15.CanvasGroup.ViewportFrame
		v_u_15.Header.Title.Text = v25.Name
		v_u_15.Header.UIGradient.Color = ColorSequence.new(v25.Color)
		local v27 = v_u_15.Template
		local v28 = 0
		for v29, v30 in v_u_4 do
			local v31 = v_u_2:get(v_u_7.Slimes, v_u_20, v29) or 0
			local v32 = v_u_21:Add(v27:Clone())
			v32.Visible = true
			v32.LayoutOrder = 5 + v30.Order
			v32.Title.Text = v29
			v32.Title.UIGradient.Rotation = v30.Rotation or 0
			if v30.GetGradient then
				v32.Title.UIGradient.Color = v30:GetGradient()
			else
				v32.Title.UIGradient.Color = ColorSequence.new(Color3.fromRGB(200, 200, 200))
			end
			v28 = v28 + v31
			v32.Value.Text = v_u_10.abbreviateComma(v31)
			v32.Parent = v_u_15
		end
		v_u_15.Total.Value.Text = v_u_10.abbreviateComma(v28)
		v_u_15.CanvasGroup.GroupColor3 = v28 > 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
		local v_u_33 = v_u_21:Add(v25.Model:Clone())
		v_u_33:PivotTo(CFrame.new(0, 0, 0))
		v_u_33.Parent = v26
		local v34 = v_u_21:Add(Instance.new("Part"))
		v34.Color = Color3.new(0.372549, 0.372549, 0.372549)
		v34.Size = Vector3.new(500, 1, 500)
		v34.Material = Enum.Material.SmoothPlastic
		local v35 = -(v25.Model:GetExtentsSize().Y / 2) - 1
		v34.Position = Vector3.new(0, v35, 0)
		v34.Parent = v26
		local v36 = Instance.new("Texture")
		v36.Texture = "rbxassetid://6372755229"
		v36.Face = Enum.NormalId.Top
		v36.Transparency = 0.8
		v36.StudsPerTileU = 4
		v36.StudsPerTileV = 4
		v36.Parent = v34
		local v37 = v_u_21:Add(Instance.new("Camera"))
		v37.CFrame = CFrame.new(Vector3.new(2, 0, -6), Vector3.new(0, 0, 0))
		v37.Parent = v26
		v26.CurrentCamera = v37
		v_u_21:Add(task.spawn(function()
			-- upvalues: (copy) v_u_33, (ref) v_u_11
			local v38 = CFrame.new(0, 0, 0)
			while v_u_33.Parent do
				v_u_11.target(v_u_33, 0.3, 2, {
					["Pivot"] = v38 + Vector3.new(0, 1, 0)
				})
				task.wait(0.2)
				v_u_11.target(v_u_33, 0.3, 2, {
					["Pivot"] = v38
				})
				task.wait(0.5)
			end
		end))
	end
end
function v12.createCategories(_)
	-- upvalues: (copy) v_u_14, (copy) v_u_5, (copy) v_u_18, (copy) v_u_6
	local v39 = v_u_14.WorldCategory
	local v40 = v_u_14.WorldContainer
	for _, v41 in v_u_5 do
		if not v_u_18[v41.World] then
			local v42 = v_u_6[v41.World]
			if v42 then
				local v43 = v39:Clone()
				v43.Title.Text = v42.Name
				v43.LayoutOrder = v42.Order * 10
				v43.Parent = v_u_14
				local v44 = v40:Clone()
				v44.Name = v42.Name .. "Container"
				v44.LayoutOrder = v43.LayoutOrder + 1
				v44.Parent = v_u_14
				v44.Template.Visible = false
				v_u_18[v41.World] = v44
			end
		end
	end
	v39:Destroy()
	v40:Destroy()
end
function v12.updateProgress(_)
	-- upvalues: (copy) v_u_3, (copy) v_u_7, (copy) v_u_2, (copy) v_u_13
	local v45 = v_u_3[v_u_7.Slimes].BuffInfo
	local v46 = v45.Buffs[1].value
	local v47 = 0
	for _ in v_u_2:get(v_u_7.Slimes) or {} do
		v47 = v47 + 1
	end
	local v48 = v47 / v45.Every
	local v49 = math.floor(v48)
	v_u_13.Bottom.Current.Text = ("Current Boost = %*%%"):format(v49 * v46 * 100)
	v_u_13.Bottom.Title.Text = ("Every %* Slimes Discovered = +%*%% Damage"):format(v45.Every, v46 * 100)
end
function v12.createSlimes(p_u_50)
	-- upvalues: (copy) v_u_5, (copy) v_u_18, (ref) v_u_20, (copy) v_u_19, (copy) v_u_2, (copy) v_u_7, (copy) v_u_8
	for v_u_51, v52 in v_u_5 do
		local v53 = v_u_18[v52.World]
		if v53 then
			if v52.Model then
				local v54 = v53.Template:Clone()
				v54.Visible = true
				v54.Container.ItemImage.Image = v52.Icon or ""
				v54.LayoutOrder = v52.Order or 99
				v54.Container.Header.Title.Text = v52.Name
				v54.Parent = v53
				local v_u_55 = v54.Container.ViewportFrame
				local v_u_56 = v52.Model:Clone()
				v_u_56:PivotTo(CFrame.new(0, 0, 0))
				v_u_56.Parent = v_u_55
				local v57 = Instance.new("Camera")
				v57.CFrame = CFrame.new(Vector3.new(2, 0, -4), Vector3.new(0, 0, 0))
				v57.Parent = v_u_55
				v_u_55.CurrentCamera = v57
				v54.Activated:Connect(function()
					-- upvalues: (ref) v_u_20, (copy) v_u_51, (copy) p_u_50
					v_u_20 = v_u_51
					p_u_50:updateView()
				end)
				local v_u_58 = true
				local v_u_59 = nil
				v54.MouseEnter:Connect(function()
					-- upvalues: (ref) v_u_58, (ref) v_u_59, (copy) v_u_56
					if not v_u_58 then
						if v_u_59 then
							task.cancel(v_u_59)
						end
						v_u_59 = task.spawn(function()
							-- upvalues: (ref) v_u_56
							local v60 = 0.005
							while true do
								v_u_56:PivotTo(CFrame.new(0, 0, 0) * CFrame.Angles(0, v60, 0))
								v60 = v60 + 0.005
								task.wait()
							end
						end)
					end
				end)
				v54.MouseLeave:Connect(function()
					-- upvalues: (ref) v_u_59, (copy) v_u_56
					if v_u_59 then
						task.cancel(v_u_59)
					end
					v_u_56:PivotTo(CFrame.new(0, 0, 0))
				end)
				v_u_19[v_u_51] = {
					["unlock"] = function()
						-- upvalues: (ref) v_u_58, (copy) v_u_55
						v_u_58 = false
						v_u_55.ImageColor3 = Color3.new(1, 1, 1)
					end,
					["lock"] = function()
						-- upvalues: (ref) v_u_58, (copy) v_u_55
						v_u_58 = true
						v_u_55.ImageColor3 = Color3.new(0, 0, 0)
					end
				}
				v_u_2:observe(v_u_7.Slimes, v_u_51, v_u_8.Normal, function(p61)
					-- upvalues: (ref) v_u_19, (copy) v_u_51, (copy) p_u_50
					if p61 then
						v_u_19[v_u_51].unlock()
					else
						v_u_19[v_u_51].lock()
					end
					p_u_50:updateProgress()
				end)
			else
				warn((("Slime %* is missing a model"):format(v_u_51)))
			end
		end
	end
end
function v12.init(p62)
	p62:createCategories()
	p62:createSlimes()
	p62:updateView()
	p62:updateProgress()
end
return v12]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Index]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3773"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("GroupService")
local v_u_2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = require(v3.Config.Constants)
local v_u_5 = require(v3.Functions.IsInGroup)
local v_u_6 = require(v3.Utility.Notify)
local v_u_7 = require(v3.Utility.Spring)
local v_u_8 = require(v3.Utility.UI)
local v9 = {}
local v_u_10 = v_u_8:get("Gui", "Group").Container
local v_u_11 = v_u_10.Position
local v_u_12 = v_u_11 + UDim2.fromScale(0, 1)
local v_u_13 = { Enum.GroupMembershipStatus.Joined, Enum.GroupMembershipStatus.AlreadyMember }
function v9.open(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_10, (copy) v_u_11
	local v14 = {
		["Position"] = v_u_11,
		["Visible"] = true
	}
	v_u_7.target(v_u_10, 0.8, 5, v14)
end
function v9.close(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_10, (copy) v_u_12
	local v15 = {
		["Position"] = v_u_12,
		["Visible"] = false
	}
	v_u_7.target(v_u_10, 0.8, 5, v15)
end
function v9.init(_)
	-- upvalues: (copy) v_u_10, (copy) v_u_1, (copy) v_u_4, (copy) v_u_13, (copy) v_u_6, (copy) v_u_5, (copy) v_u_2, (copy) v_u_8
	v_u_10.Container.Step2.Join.Activated:Connect(function()
		-- upvalues: (ref) v_u_1, (ref) v_u_4, (ref) v_u_13, (ref) v_u_6
		local v16, v17 = pcall(function()
			-- upvalues: (ref) v_u_1, (ref) v_u_4
			return v_u_1:PromptJoinAsync(v_u_4.GROUP_ID)
		end)
		if v16 then
			if not table.find(v_u_13, v17 or "") then
				v_u_6.Notify({
					["Message"] = "You need join group and like game for auto farm!",
					["Type"] = v_u_6.Types.Error
				})
			end
		else
			v_u_6.Notify({
				["Message"] = "You need join group and like game for auto auto farm!",
				["Type"] = v_u_6.Types.Error
			})
			return
		end
	end)
	v_u_10.Container.Verify.Activated:Connect(function()
		-- upvalues: (ref) v_u_5, (ref) v_u_2, (ref) v_u_1, (ref) v_u_4, (ref) v_u_13, (ref) v_u_6, (ref) v_u_8
		if not v_u_5(v_u_2.LocalPlayer) then
			local v18, v19 = pcall(function()
				-- upvalues: (ref) v_u_1, (ref) v_u_4
				return v_u_1:PromptJoinAsync(v_u_4.GROUP_ID)
			end)
			if not v18 then
				v_u_6.Notify({
					["Message"] = "You need join group and like game for auto auto farm!",
					["Type"] = v_u_6.Types.Error
				})
				return
			end
			if not table.find(v_u_13, v19 or "") then
				v_u_6.Notify({
					["Message"] = "You need join group and like game for auto farm!",
					["Type"] = v_u_6.Types.Error
				})
				return
			end
		end
		if v_u_8.Current == script.Name then
			v_u_8:close(script.Name)
		end
		v_u_6.Notify({
			["Message"] = "Verified! You can now use Auto Farm.",
			["Type"] = v_u_6.Types.Success
		})
	end)
end
return v9]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Group]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3774"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Config.Colors)
local v_u_4 = require(v1.Config.Constants)
local v_u_5 = require(v1.Config.DailyRewardData)
local v6 = require(v1.Packages.Topbarplus)
local v7 = require(v1.Utility.Network)
local v_u_8 = require(v1.Utility.Notify)
local v_u_9 = require(v1.Utility.Spring)
local v_u_10 = require(v1.Utility.Time)
local v_u_11 = require(v1.Utility.UI)
local v12 = {}
local v_u_13 = v_u_11:get("Gui", "Daily").Container
local v_u_14 = v_u_13.Holder
local v_u_15 = v_u_14.Days.Template
local v_u_16 = v_u_13.Position
local v_u_17 = v_u_16 + UDim2.fromScale(0, 1)
local v_u_18 = v7.remoteFunction("DailyClaimEvent")
local v_u_19 = v6.new()
v_u_19:setLabel("Rewards")
v_u_19:setOrder(999)
v_u_19:setRight()
v_u_19.selected:Connect(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_19
	if v_u_11.Current == script.Name then
		v_u_11:close(script.Name)
	else
		v_u_11:open(script.Name)
	end
	v_u_19:deselect()
end)
local v_u_20 = {}
local function v_u_23()
	-- upvalues: (copy) v_u_15
	for v21 = 1, 6 do
		local v22 = v_u_15:Clone()
		v22.Name = ("Day%*"):format(v21)
		v22.Visible = true
		v22.LayoutOrder = v21
		v22.Title.Text = ("Day %*"):format(v21)
		v22.Parent = v_u_15.Parent
	end
	v_u_15:Destroy()
end
function v12.open(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_13, (copy) v_u_16
	local v24 = {
		["Position"] = v_u_16,
		["Visible"] = true
	}
	v_u_9.target(v_u_13, 0.8, 5, v24)
end
function v12.close(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_13, (copy) v_u_17
	local v25 = {
		["Position"] = v_u_17,
		["Visible"] = false
	}
	v_u_9.target(v_u_13, 0.8, 5, v25)
end
function v12.update(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_20, (copy) v_u_19, (copy) v_u_11
	local v26 = v_u_2:getValue({ "Daily" })
	local v27 = v26.Reward or 1
	local v28 = v26.Claimed or {}
	local v29 = false
	for v30 = 1, 7 do
		if v30 <= v27 then
			if table.find(v28, v30) then
				v_u_20[v30].Claimed()
			else
				v_u_20[v30].Claimable()
				v29 = true
			end
		else
			v_u_20[v30].Locked()
		end
	end
	if v29 then
		v_u_19:notify()
		task.delay(1, function()
			-- upvalues: (ref) v_u_11
			if v_u_11.Current ~= script.Name then
				v_u_11:open(script.Name)
			end
		end)
	else
		v_u_19:clearNotices()
	end
end
function v12.init(p_u_31)
	-- upvalues: (copy) v_u_23, (copy) v_u_5, (copy) v_u_14, (copy) v_u_18, (copy) v_u_8, (copy) v_u_20, (copy) v_u_3, (copy) v_u_2, (copy) v_u_4, (copy) v_u_13, (copy) v_u_10
	v_u_23()
	for v_u_32, v33 in v_u_5 do
		local v_u_34 = v_u_14:FindFirstChild((("Day%*"):format(v_u_32))) or v_u_14.Days:FindFirstChild((("Day%*"):format(v_u_32)))
		v_u_34.Amount.Text = ("x%*"):format(v33)
		v_u_34.Claim.Activated:Connect(function()
			-- upvalues: (ref) v_u_18, (copy) v_u_32, (ref) v_u_8
			local v35, v36 = v_u_18.invoke(v_u_32)
			v_u_8.Notify({
				["Message"] = v36,
				["Type"] = v35 and v_u_8.Types.Success or v_u_8.Types.Error
			})
		end)
		v_u_20[v_u_32] = {
			["Claimed"] = function()
				-- upvalues: (copy) v_u_34, (ref) v_u_3
				local v37 = v_u_34.Claim
				v37.UIGradient.Color = v_u_3.Green.Gradient or v_u_3.Grey.Gradient
				v37.Cost.UIStroke.Color = v_u_3.Green.Stroke or v_u_3.Grey.Stroke
				v37.UIStroke.Color = v_u_3.Green.Stroke or v_u_3.Grey.Stroke
				v_u_34.Claim.Cost.Text = "Claimed"
			end,
			["Claimable"] = function()
				-- upvalues: (copy) v_u_34, (ref) v_u_3
				local v38 = v_u_34.Claim
				v38.UIGradient.Color = v_u_3.Green.Gradient or v_u_3.Grey.Gradient
				v38.Cost.UIStroke.Color = v_u_3.Green.Stroke or v_u_3.Grey.Stroke
				v38.UIStroke.Color = v_u_3.Green.Stroke or v_u_3.Grey.Stroke
				v_u_34.Claim.Cost.Text = "Claim"
			end,
			["Locked"] = function()
				-- upvalues: (copy) v_u_34, (ref) v_u_3
				local v39 = v_u_34.Claim
				v39.UIGradient.Color = v_u_3.Grey.Gradient
				v39.Cost.UIStroke.Color = v_u_3.Grey.Stroke
				v39.UIStroke.Color = v_u_3.Grey.Stroke
				v_u_34.Claim.Cost.Text = "Locked"
			end
		}
	end
	p_u_31:update()
	v_u_2:onChange(function(_, p40, _, _)
		-- upvalues: (copy) p_u_31
		if p40[1] == "Daily" then
			p_u_31:update()
		end
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_4, (ref) v_u_13, (ref) v_u_10
		while true do
			local v41 = workspace:GetServerTimeNow()
			local v42 = (v41 // v_u_4.DAILY_TIME + 1) * v_u_4.DAILY_TIME - v41
			local v43 = math.max(v42, 0)
			v_u_13.Timer.Text = ("Next Reward in %*"):format((v_u_10.format(v43)))
			task.wait(1)
		end
	end)
end
return v12]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Daily]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3775"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Currency.CurrencyController)
local v_u_3 = require(v1.Client.Data.Statistics.StatisticController)
local v_u_4 = require(v1.Config.SuperRebirthData)
local v_u_5 = require(v1.Enums.CurrencyTypes)
local v_u_6 = require(v1.Enums.StatisticTypes)
local v_u_7 = require(v1.Utility.Format)
local v_u_8 = require(v1.Utility.Multiplier)
local v9 = require(v1.Utility.Network)
local v_u_10 = require(v1.Utility.Notify)
local v_u_11 = require(v1.Utility.Spring)
local v12 = {}
local v_u_13 = require(v1.Utility.UI):get("Gui", "SuperRebirths").Container
local v_u_14 = v_u_13.Container.SuperRebirth
local v_u_15 = v_u_13.Position
local v_u_16 = v_u_15 + UDim2.fromScale(0, 1)
local v_u_17 = v_u_13.Container.Top.Right
local v_u_18 = v_u_13.Container.Top.Left
local v_u_19 = v9.remoteFunction("SuperRebirthEvent")
function v12.open(_)
	-- upvalues: (copy) v_u_11, (copy) v_u_13, (copy) v_u_15
	local v20 = {
		["Position"] = v_u_15,
		["Visible"] = true
	}
	v_u_11.target(v_u_13, 0.8, 5, v20)
end
function v12.close(_)
	-- upvalues: (copy) v_u_11, (copy) v_u_13, (copy) v_u_16
	local v21 = {
		["Position"] = v_u_16,
		["Visible"] = false
	}
	v_u_11.target(v_u_13, 0.8, 5, v21)
end
function v12.setupLose(_)
	-- upvalues: (copy) v_u_17, (copy) v_u_4
	local v22 = v_u_17.Benefits.Template
	for _, v23 in v_u_4.Lose do
		local v24 = v22:Clone()
		v24.Text = v23.Text
		v24.Visible = true
		v24.Parent = v_u_17.Benefits
	end
	v22:Destroy()
end
function v12.setupBenefits(_)
	-- upvalues: (copy) v_u_18, (copy) v_u_4, (copy) v_u_2, (copy) v_u_5, (copy) v_u_8
	local v25 = v_u_18.Benefits.Template
	local v26 = v_u_18.Benefits.TemplateGolden
	for _, v_u_27 in v_u_4.Benefits do
		local v_u_28 = v_u_27.Special and v26:Clone() or v25:Clone()
		v_u_28.Text = v_u_27.Text
		v_u_28.Visible = true
		v_u_28.Parent = v_u_18.Benefits
		if v_u_27.Get then
			v_u_2:observe(v_u_5.SuperRebirth, function(p29)
				-- upvalues: (copy) v_u_28, (copy) v_u_27
				v_u_28.Text = string.format(v_u_27.Text, v_u_27:Format(v_u_27:Get(p29 + 1)))
			end)
		end
		if v_u_27.MultiplierType then
			local v_u_30 = {
				["last_updated"] = nil
			}
			v_u_8.assign(v_u_27.MultiplierType, function()
				-- upvalues: (copy) v_u_30, (copy) v_u_27, (ref) v_u_2, (ref) v_u_5
				if not v_u_30.last_updated or tick() - v_u_30.last_updated > 5 then
					v_u_30.value = v_u_27:Calculate(v_u_2:get(v_u_5.SuperRebirth))
					v_u_30.last_updated = tick()
				end
				return v_u_30.value
			end)
		end
	end
	v25:Destroy()
	v26:Destroy()
end
function v12.updateButton(_)
	-- upvalues: (copy) v_u_3, (copy) v_u_6, (copy) v_u_2, (copy) v_u_5, (copy) v_u_4, (copy) v_u_14, (copy) v_u_7
	local v31 = v_u_3:get(v_u_6.IceWorldHighestRound) or 0
	local v32 = v_u_4:Requirements((v_u_2:get(v_u_5.SuperRebirth) or 0) + 1) or (1 / 0)
	if v32 <= v31 then
		v_u_14.Price.Text = "Super Rebirth"
	else
		v_u_14.Price.Text = ("Reach Round %* to Super Rebirth"):format((v_u_7.abbreviateComma(v32)))
	end
end
function v12.init(p_u_33)
	-- upvalues: (copy) v_u_3, (copy) v_u_6, (copy) v_u_2, (copy) v_u_5, (copy) v_u_14, (copy) v_u_19, (copy) v_u_10
	p_u_33:setupLose()
	p_u_33:setupBenefits()
	v_u_3:observe(v_u_6.IceWorldHighestRound, function(_)
		-- upvalues: (copy) p_u_33
		p_u_33:updateButton()
	end)
	v_u_2:observe(v_u_5.SuperRebirth, function(_)
		-- upvalues: (copy) p_u_33
		p_u_33:updateButton()
	end)
	local v_u_34 = game:GetService("RunService")
	local v_u_35 = false
	local v_u_36 = 0
	local v_u_37 = v_u_14
	local v_u_38 = v_u_37:WaitForChild("UIGradient")
	local v_u_39 = v_u_37.Position
	local v_u_40 = nil
	v_u_37.InputBegan:Connect(function(p41)
		-- upvalues: (ref) v_u_35, (ref) v_u_36, (copy) v_u_38, (ref) v_u_40, (copy) v_u_34, (copy) v_u_37, (copy) v_u_39, (ref) v_u_19, (ref) v_u_10
		if p41.UserInputType == Enum.UserInputType.MouseButton1 and true or p41.UserInputType == Enum.UserInputType.Touch then
			v_u_35 = true
			v_u_36 = os.clock()
			if v_u_38 then
				v_u_38.Offset = Vector2.new(-1, 0)
			end
			local v_u_42 = nil
			local function v_u_43()
				-- upvalues: (ref) v_u_42
				return v_u_42
			end
			if not v_u_40 then
				v_u_40 = v_u_34.RenderStepped:Connect(function()
					-- upvalues: (copy) v_u_43, (ref) v_u_37, (ref) v_u_39
					local v44 = v_u_43()
					local v45 = math.clamp(v44, 0, 1)
					if v45 < 0.2 then
						v_u_37.Position = v_u_39
					else
						local v46 = (v45 - 0.2) / 0.8
						local v47 = v46 * v46 * 10 + 2
						local v48 = math.floor(v47)
						local v49 = Vector2.new(math.random(-v48, v48), math.random(-v48, v48))
						v_u_37.Position = v_u_39 + UDim2.fromScale(v49.X / 500, v49.Y / 500)
					end
				end)
			end
			local v_u_50 = nil
			v_u_50 = v_u_34.RenderStepped:Connect(function()
				-- upvalues: (ref) v_u_35, (ref) v_u_50, (ref) v_u_42, (ref) v_u_36, (ref) v_u_38, (ref) v_u_40, (ref) v_u_37, (ref) v_u_39, (ref) v_u_19, (ref) v_u_10
				if v_u_35 then
					local v51 = (os.clock() - v_u_36) / 3
					v_u_42 = math.clamp(v51, 0, 1)
					v_u_38.Offset = Vector2.new(v_u_42, 0)
					if v_u_42 >= 1 then
						v_u_50:Disconnect()
						v_u_35 = false
						if v_u_40 then
							v_u_40:Disconnect()
							v_u_40 = nil
						end
						v_u_37.Position = v_u_39
						if v_u_38 then
							v_u_38.Offset = Vector2.new(-1, 0)
						end
						local v52, v53 = v_u_19.invoke()
						v_u_10.Notify({
							["Message"] = v53,
							["Type"] = v52 and v_u_10.Types.Success or v_u_10.Types.Error
						})
					end
				else
					v_u_50:Disconnect()
				end
			end)
		end
	end)
	v_u_37.InputEnded:Connect(function(p54)
		-- upvalues: (ref) v_u_35, (ref) v_u_40, (copy) v_u_37, (copy) v_u_39, (copy) v_u_38
		if p54.UserInputType == Enum.UserInputType.MouseButton1 and true or p54.UserInputType == Enum.UserInputType.Touch then
			v_u_35 = false
			if v_u_40 then
				v_u_40:Disconnect()
				v_u_40 = nil
			end
			v_u_37.Position = v_u_39
			if v_u_38 then
				v_u_38.Offset = Vector2.new(-1, 0)
			end
		end
	end)
end
return v12]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SuperRebirths]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3776"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Utility.UI)
local v3 = require(v1.Utility.Network)
local v_u_4 = require(v1.Utility.Spring)
local v_u_5 = require(v1.Utility.Multiplier)
local v_u_6 = require(v1.Client.Data.DataController)
local v_u_7 = require(v1.Utility.Notify)
local v_u_8 = require(v1.Config.AmuletData)
local v_u_9 = require(v1.Config.AmuletPassiveData)
local v_u_10 = require(v1.Config.AmuletPerkData)
local v_u_11 = require(v1.Config.CurrencyData)
local v_u_12 = require(v1.Config.MultiplierData)
local v_u_13 = require(v1.Enums.MultiplierTypes)
local v14 = require(v1.Packages.Janitor)
local v_u_15 = require(v1.Packages.Throttle)
local v_u_16 = require(v1.Utility.Format)
local v_u_17 = require(v1.Utility.MultiplierUtil)
local v_u_18 = require(v1.Utility.Sound)
local v19 = {}
local v_u_20 = v_u_2:get("Gui", "Amulets").Container
local v_u_21 = v_u_20.Container.Top.Left
local v_u_22 = v_u_20.Container.Top.Right
local v_u_23 = v_u_20.Position
local v_u_24 = v_u_23 + UDim2.fromScale(0, 1)
local v_u_25 = v_u_21.Benefits.Template
v_u_25.Visible = false
local v_u_26 = v_u_22.Benefits.Template
v_u_26.Visible = false
local v_u_27 = {
	["Keep"] = v3.remoteFunction("AmuletService/Keep"),
	["Replace"] = v3.remoteFunction("AmuletService/Replace"),
	["Roll"] = v3.remoteFunction("AmuletService/Roll")
}
local v_u_28 = {}
local v_u_29 = {}
local v_u_30 = nil
local v_u_31 = v14.new()
function v19.open(_)
	-- upvalues: (copy) v_u_4, (copy) v_u_20, (copy) v_u_23, (copy) v_u_2
	local v32 = {
		["Position"] = v_u_23,
		["Visible"] = true
	}
	v_u_4.target(v_u_20, 0.8, 5, v32)
	v_u_2:lock()
end
function v19.close(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_20, (copy) v_u_24
	v_u_2:unlock()
	local v33 = {
		["Position"] = v_u_24,
		["Visible"] = false
	}
	v_u_4.target(v_u_20, 0.8, 5, v33)
end
function v19.load(p_u_34, p_u_35)
	-- upvalues: (copy) v_u_31, (copy) v_u_8, (copy) v_u_20, (copy) v_u_6, (ref) v_u_30, (copy) v_u_28, (copy) v_u_29, (copy) v_u_12, (copy) v_u_17, (copy) v_u_25, (copy) v_u_9, (copy) v_u_10, (copy) v_u_26, (copy) v_u_15, (copy) v_u_18, (copy) v_u_11, (copy) v_u_5, (copy) v_u_13, (copy) v_u_16, (copy) v_u_27, (copy) v_u_7, (copy) v_u_2
	v_u_31:Cleanup()
	local v36 = p_u_35.type
	local v37 = p_u_35.tier
	local v38 = v_u_8[v36]
	local v39 = v38.Tiers[v37]
	v_u_20.Container.Title.Text = ("Tier %* %*"):format(v37, v38.Name)
	v_u_20.Header.Icon.Image = v39.Icon or v38.Icon
	local v40 = v_u_6:getValue({ "Amulet", "Equipped", v36 })
	local v41 = v_u_6:getValue({ "Amulet", "Recent", v36 })
	v_u_30 = v36
	for _, v42 in v_u_28 do
		v42:Destroy()
	end
	table.clear(v_u_28)
	for _, v43 in v_u_29 do
		v43:Destroy()
	end
	table.clear(v_u_29)
	local function v51(p44, p45, p46, p47)
		local v48 = p44:Clone()
		v48.Text = p46
		v48.Visible = true
		v48.Parent = p44.Parent
		if p47 == "passive" then
			v48.TextColor3 = Color3.fromRGB(255, 255, 255)
			local v49 = Instance.new("UIGradient")
			v49.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)),
				ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 170, 0)),
				ColorSequenceKeypoint.new(0.66, Color3.fromRGB(255, 255, 127)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 0))
			})
			v49:AddTag("Gradient")
			v49.Parent = v48
		elseif p47 == "perk" then
			v48.TextColor3 = Color3.fromRGB(255, 255, 255)
			local v50 = Instance.new("UIGradient")
			v50.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 255, 255)),
				ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 200, 180)),
				ColorSequenceKeypoint.new(0.66, Color3.fromRGB(100, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 180))
			})
			v50:AddTag("Gradient")
			v50.Parent = v48
		end
		table.insert(p45, v48)
		return v48
	end
	local v52 = {}
	if v40 then
		for v53, v54 in v40.Multipliers do
			local v55 = v_u_12[v53]
			local v56 = v_u_25
			local v57 = v_u_28
			local v58 = ("%* %*"):format(v_u_17.format(v53, v54), v55.Name)
			local v59 = v56:Clone()
			v59.Text = v58
			v59.Visible = true
			v59.Parent = v56.Parent
			table.insert(v57, v59)
			table.insert(v52, v53)
		end
		for _, v60 in v40.Passives do
			v51(v_u_25, v_u_28, ("Passive: %*"):format((v_u_9[v60] or {
				["Name"] = "--"
			}).Name), "passive")
		end
		for _, v61 in v40.Perks or {} do
			v51(v_u_25, v_u_28, ("Perk: %*"):format((v_u_10[v61] or {
				["Name"] = "--"
			}).Name), "perk")
		end
	else
		local v62 = v_u_25
		local v63 = v_u_28
		local v64 = v62:Clone()
		v64.Text = "Nothing Here..."
		v64.Visible = true
		v64.Parent = v62.Parent
		table.insert(v63, v64)
	end
	local v_u_65 = false
	if v41 then
		local v66 = {}
		local v67 = {}
		for v68, v69 in v41.Multipliers do
			v66[v68] = v69
		end
		for _, v70 in v52 do
			if v66[v70] then
				local v71 = { v70, v66[v70] }
				table.insert(v67, v71)
				v66[v70] = nil
			end
		end
		for v72, v73 in v66 do
			table.insert(v67, { v72, v73 })
		end
		for _, v74 in v67 do
			local v75 = v74[1]
			local v76 = v74[2]
			local v77 = v_u_12[v75]
			local v78 = v_u_26
			local v79 = v_u_29
			local v80 = ("%* %*"):format(v_u_17.format(v75, v76), v77.Name)
			local v81 = v78:Clone()
			v81.Text = v80
			v81.Visible = true
			v81.Parent = v78.Parent
			table.insert(v79, v81)
			if v40 and v40.Multipliers[v75] then
				local v82 = v40.Multipliers[v75]
				if v82 < v76 then
					v81.TextColor3 = Color3.fromRGB(85, 255, 85)
				elseif v76 < v82 then
					v81.TextColor3 = Color3.fromRGB(255, 85, 85)
				end
			end
		end
		for _, v83 in v41.Passives do
			v51(v_u_26, v_u_29, ("Passive: %*"):format((v_u_9[v83] or {
				["Name"] = "--"
			}).Name), "passive")
			v_u_15("passive-amulet", 0.1, function()
				-- upvalues: (ref) v_u_18
				v_u_18.play("PassiveRolled")
			end)
			v_u_65 = true
		end
		for _, v84 in v41.Perks or {} do
			v51(v_u_26, v_u_29, ("Perk: %*"):format((v_u_10[v84] or {
				["Name"] = "--"
			}).Name), "perk")
			v_u_15("perk-amulet", 0.1, function()
				-- upvalues: (ref) v_u_18
				v_u_18.play("PassiveRolled")
			end)
			v_u_65 = true
		end
		task.delay(1.5, function()
			-- upvalues: (ref) v_u_65
			v_u_65 = false
		end)
	else
		local v85 = v_u_26
		local v86 = v_u_29
		local v87 = v85:Clone()
		v87.Text = "Nothing Here..."
		v87.Visible = true
		v87.Parent = v85.Parent
		table.insert(v86, v87)
	end
	if v39.CurrencyType then
		local v88 = v_u_11[v39.CurrencyType]
		local v89 = v39.Amount * (1 - v_u_5.get(v_u_13.AmuletCheaperCost))
		v_u_20.Container.Purchase.ImageLabel.Image = v88.Icon
		v_u_20.Container.Purchase.TextLabel.Text = v_u_16.abbreviateComma((math.floor(v89)))
	end
	v_u_31:Add(v_u_20.Container.Purchase.Activated:Connect(function()
		-- upvalues: (ref) v_u_65, (ref) v_u_6, (copy) p_u_35, (ref) v_u_27, (ref) v_u_7, (copy) p_u_34, (ref) v_u_31, (ref) v_u_2
		if v_u_65 then
			return
		else
			local v_u_90 = v_u_6:getValue({ "Amulet", "Recent", p_u_35.type })
			local v91, v92 = v_u_27.Roll.invoke(p_u_35)
			if v91 then
				local v_u_93 = false
				local v_u_94 = nil
				v_u_94 = v_u_6:onSet({ "Amulet", "Recent", p_u_35.type }, function(p95)
					-- upvalues: (copy) v_u_90, (ref) v_u_93, (ref) v_u_94, (ref) p_u_34, (ref) p_u_35
					if p95 ~= v_u_90 and not v_u_93 then
						v_u_93 = true
						if v_u_94 then
							v_u_94:Disconnect()
							v_u_94 = nil
						end
						p_u_34:load(p_u_35)
					end
				end)
				v_u_31:Add(function()
					-- upvalues: (ref) v_u_94
					if v_u_94 then
						v_u_94:Disconnect()
						v_u_94 = nil
					end
				end)
				task.delay(5, function()
					-- upvalues: (ref) v_u_93, (ref) v_u_94, (ref) p_u_34, (ref) p_u_35
					if not v_u_93 then
						v_u_93 = true
						if v_u_94 then
							v_u_94:Disconnect()
							v_u_94 = nil
						end
						p_u_34:load(p_u_35)
					end
				end)
				if v_u_2.Current ~= script.Name then
					v_u_2:open("Amulets")
				end
			else
				v_u_7.Notify({
					["Message"] = v92,
					["Type"] = v_u_7.Types.Error
				})
			end
		end
	end))
end
function v19.init(_)
	-- upvalues: (copy) v_u_21, (copy) v_u_27, (ref) v_u_30, (copy) v_u_7, (copy) v_u_2, (copy) v_u_22, (copy) v_u_8, (copy) v_u_5, (copy) v_u_6
	v_u_21.Keep.Activated:Connect(function()
		-- upvalues: (ref) v_u_27, (ref) v_u_30, (ref) v_u_7, (ref) v_u_2
		local v96, v97 = v_u_27.Keep.invoke(v_u_30)
		v_u_7.Notify({
			["Message"] = v97,
			["Type"] = v96 and v_u_7.Types.Success or v_u_7.Types.Error
		})
		if v_u_2.Current == script.Name then
			v_u_2:unlock()
			v_u_2:close(v_u_2.Current)
		end
	end)
	v_u_22.Replace.Activated:Connect(function()
		-- upvalues: (ref) v_u_27, (ref) v_u_30, (ref) v_u_7, (ref) v_u_2
		local v98, v99 = v_u_27.Replace.invoke(v_u_30)
		v_u_7.Notify({
			["Message"] = v99,
			["Type"] = v98 and v_u_7.Types.Success or v_u_7.Types.Error
		})
		if v_u_2.Current == script.Name then
			v_u_2:unlock()
			v_u_2:close(v_u_2.Current)
		end
	end)
	for v_u_100, v101 in v_u_8 do
		for _, v_u_102 in v101.Multipliers do
			v_u_5.assign(v_u_102, function(_)
				-- upvalues: (ref) v_u_6, (copy) v_u_100, (copy) v_u_102
				local v103 = v_u_6:getValue({ "Amulet", "Equipped", v_u_100 })
				return v103 and v103.Multipliers[v_u_102] or nil
			end)
		end
	end
end
return v19]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Amulets]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3777"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.AmuletData)
local v_u_3 = require(v1.Config.CrystalHeartsData)
local v_u_4 = require(v1.Config.CurrencyData)
local v_u_5 = require(v1.Config.Event1MStarData)
local v_u_6 = require(v1.Enums.MultiplierTypes)
local v_u_7 = require(v1.Enums.Products)
local v_u_8 = require(v1.Client.Data.DataController)
local v_u_9 = require(v1.Utility.Format)
local v_u_10 = require(v1.Utility.LockUtil)
local v_u_11 = require(v1.Utility.Marketplace)
local v_u_12 = require(v1.Utility.Multiplier)
local v13 = require(v1.Utility.Network)
local v_u_14 = require(v1.Utility.Notify)
local v_u_15 = require(v1.Utility.Spring)
local v_u_16 = require(v1.Utility.UI)
local v17 = {}
local v_u_18 = v_u_16:get("Gui", "BuySlimeAmulet").Container
local v_u_19 = v_u_18.Position
local v_u_20 = v_u_19 + UDim2.fromScale(0, 0.5)
local v_u_21 = nil
local v_u_22 = v13.remoteFunction("AmuletService/Roll")
function v17.open(_)
	-- upvalues: (copy) v_u_15, (copy) v_u_18, (copy) v_u_19
	local v23 = {
		["Position"] = v_u_19,
		["Visible"] = true
	}
	v_u_15.target(v_u_18, 0.8, 5, v23)
end
function v17.close(_)
	-- upvalues: (copy) v_u_15, (copy) v_u_18, (copy) v_u_20
	local v24 = {
		["Position"] = v_u_20,
		["Visible"] = false
	}
	v_u_15.target(v_u_18, 0.8, 5, v24)
end
function v17.setupCrystalHeart(_)
	-- upvalues: (copy) v_u_18, (copy) v_u_7, (copy) v_u_3, (copy) v_u_11, (copy) v_u_9
	for _, v_u_25 in v_u_18.Products.HeartCrystals:GetChildren() do
		if v_u_25:IsA("Frame") then
			local v26 = v_u_25.Name
			local v27 = tonumber(v26)
			local v_u_28 = v_u_7.CrystalHearts[v27]
			local v29 = v_u_3[v_u_28]
			v_u_25.Purchase.Price.Text = "..."
			v_u_11.ObserveProduct(v_u_28, function(p30)
				-- upvalues: (copy) v_u_25, (ref) v_u_9
				v_u_25.Purchase.Price.Text = v_u_9.robux(v_u_9.comma(p30.PriceInRobux))
			end)
			v_u_25.TextLabel.Text = v_u_9.comma(v29)
			v_u_25.Purchase.Activated:Connect(function()
				-- upvalues: (ref) v_u_11, (copy) v_u_28
				v_u_11.PromptProduct(v_u_28)
			end)
		end
	end
end
function v17.setupMillionaireStars(_)
	-- upvalues: (copy) v_u_18, (copy) v_u_7, (copy) v_u_5, (copy) v_u_11, (copy) v_u_9
	for _, v_u_31 in v_u_18.Products.Event1MStars:GetChildren() do
		if v_u_31:IsA("Frame") then
			local v32 = v_u_31.Name
			local v33 = tonumber(v32)
			local v_u_34 = v_u_7.Event1MStars[v33]
			local v35 = v_u_5[v_u_34]
			v_u_31.Purchase.Price.Text = "..."
			v_u_11.ObserveProduct(v_u_34, function(p36)
				-- upvalues: (copy) v_u_31, (ref) v_u_9
				v_u_31.Purchase.Price.Text = v_u_9.robux(v_u_9.comma(p36.PriceInRobux))
			end)
			v_u_31.TextLabel.Text = v_u_9.comma(v35)
			v_u_31.Purchase.Activated:Connect(function()
				-- upvalues: (ref) v_u_11, (copy) v_u_34
				v_u_11.PromptProduct(v_u_34)
			end)
		end
	end
end
function v17.set(_, p_u_37, p_u_38)
	-- upvalues: (ref) v_u_21, (copy) v_u_2, (copy) v_u_18, (copy) v_u_4, (copy) v_u_12, (copy) v_u_6, (copy) v_u_9, (copy) v_u_10, (copy) v_u_8, (copy) v_u_22, (copy) v_u_14, (copy) v_u_16
	if v_u_21 then
		v_u_21:Disconnect()
		v_u_21 = nil
	end
	local v39 = v_u_2[p_u_37]
	local v40 = v39.Tiers[p_u_38]
	for _, v41 in v_u_18.Products:GetChildren() do
		v41.Visible = v39.Frame == v41.Name
	end
	if v40.CurrencyType then
		local v42 = v_u_4[v40.CurrencyType]
		local v43 = v40.Amount * (1 - v_u_12.get(v_u_6.AmuletCheaperCost))
		v_u_18.Frame.Purchase.ImageLabel.Image = v42.Icon
		v_u_18.Frame.Purchase.TextLabel.Text = v_u_9.abbreviateComma((math.floor(v43)))
	end
	if v40.LockedData then
		local v44, v45 = v_u_10.isLocked(v40.LockedData)
		if v44 then
			v_u_18.Header.Title.Text = v45 or "Locked"
			v_u_18.Frame.Purchase.Folder.Overlay.Visible = true
			return
		end
	end
	v_u_18.Frame.Purchase.Folder.Overlay.Visible = false
	v_u_18.Header.Title.Text = ("Buy Tier %* %*?"):format(p_u_38, v39.Name)
	v_u_21 = v_u_18.Frame.Purchase.Activated:Connect(function()
		-- upvalues: (ref) v_u_8, (copy) p_u_37, (ref) v_u_22, (copy) p_u_38, (ref) v_u_14, (ref) v_u_16
		local v_u_46 = v_u_8:getValue({ "Amulet", "Recent", p_u_37 })
		local v47 = {
			["type"] = p_u_37,
			["tier"] = p_u_38
		}
		local v48, v49 = v_u_22.invoke(v47)
		if v48 then
			local v_u_50 = false
			local v_u_51 = nil
			v_u_51 = v_u_8:onSet({ "Amulet", "Recent", p_u_37 }, function(p52)
				-- upvalues: (copy) v_u_46, (ref) v_u_50, (ref) v_u_51, (ref) p_u_37, (ref) p_u_38
				if p52 ~= v_u_46 and not v_u_50 then
					v_u_50 = true
					if v_u_51 then
						v_u_51:Disconnect()
						v_u_51 = nil
					end
					local v53 = {
						["type"] = p_u_37,
						["tier"] = p_u_38
					}
					require(script.Parent.Parent):get("Amulets"):load(v53)
				end
			end)
			task.delay(5, function()
				-- upvalues: (ref) v_u_50, (ref) v_u_51, (ref) p_u_37, (ref) p_u_38
				if not v_u_50 then
					v_u_50 = true
					if v_u_51 then
						v_u_51:Disconnect()
						v_u_51 = nil
					end
					local v54 = {
						["type"] = p_u_37,
						["tier"] = p_u_38
					}
					require(script.Parent.Parent):get("Amulets"):load(v54)
				end
			end)
			v_u_16:open("Amulets")
		else
			v_u_14.Notify({
				["Message"] = v49,
				["Type"] = v_u_14.Types.Error
			})
		end
	end)
end
function v17.init(p55)
	p55:setupCrystalHeart()
	p55:setupMillionaireStars()
end
return v17]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BuySlimeAmulet]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3778"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Config.UpdateLogData)
local v3 = require(v1.Packages.Janitor)
local v4 = require(v1.Packages.Topbarplus)
local v_u_5 = require(v1.Utility.Spring)
local v_u_6 = require(v1.Utility.Time)
local v_u_7 = require(v1.Utility.UI)
local v8 = {}
local v_u_9 = v_u_7:get("Gui", "UpdateLog").Container
local v_u_10 = v_u_9.Left.Holder
local v_u_11 = v_u_9.Right.Right
local v_u_12 = v_u_11.TextContainer.Template
v_u_12.Visible = false
local v_u_13 = v_u_9.Position
local v_u_14 = v_u_13 + UDim2.fromScale(0, 1)
local v_u_15 = v3.new()
local v_u_16 = v4.new()
v_u_16:setImage("rbxassetid://110903138109426")
v_u_16:setRight()
v_u_16.selected:Connect(function()
	-- upvalues: (copy) v_u_7, (copy) v_u_16
	if v_u_7.Current == script.Name then
		v_u_7:close(script.Name)
	else
		v_u_7:open(script.Name)
	end
	v_u_16:deselect()
end)
function v8.open(_)
	-- upvalues: (copy) v_u_5, (copy) v_u_9, (copy) v_u_13
	local v17 = {
		["Position"] = v_u_13,
		["Visible"] = true
	}
	v_u_5.target(v_u_9, 0.8, 5, v17)
end
function v8.close(_)
	-- upvalues: (copy) v_u_5, (copy) v_u_9, (copy) v_u_14
	local v18 = {
		["Position"] = v_u_14,
		["Visible"] = false
	}
	v_u_5.target(v_u_9, 0.8, 5, v18)
end
local function v_u_22(p19)
	local v20 = os.time(p19)
	local v21 = workspace:GetServerTimeNow()
	return os.difftime(v21, v20)
end
function v8.view(_, p23)
	-- upvalues: (copy) v_u_15, (copy) v_u_2, (copy) v_u_11, (copy) v_u_9, (copy) v_u_12
	v_u_15:Cleanup()
	local v24 = v_u_2[p23]
	if v24 then
		v_u_11.Title.UIGradient:RemoveTag("Gradient")
		if v24.TitleGradient then
			v_u_11.Title.UIGradient.Color = v24.TitleGradient
			v_u_11.Title.UIGradient:AddTag("Gradient")
		end
		v_u_11.Title.Text = v24.Name
		v_u_9.Thumbnail.Image = v24.Image
		for v25, v26 in v24.Content do
			if v26.Thumbnail then
				local v27 = v_u_11.TextContainer.Thumbnail:Clone()
				v27.Image = v26.Thumbnail
				v27.LayoutOrder = v25
				v27.Visible = true
				v27.Parent = v_u_12.Parent
				v_u_15:Add(v27)
			else
				local v28 = v_u_12:Clone()
				v28.LayoutOrder = v25
				v28.Visible = true
				v28.Text = v26.Title or v26.Text
				if v26.Title then
					v28.TextSize = v28.TextSize + 5
					v28.TextColor3 = v26.Color or Color3.fromRGB(255, 255, 127)
					v28.Size = UDim2.new(0.975, 0, 0.09, 0)
				else
					v28.TextColor3 = v_u_12.TextColor3
				end
				v28.Parent = v_u_12.Parent
				v_u_15:Add(v28)
			end
		end
	end
end
function v8.loadLeft(p_u_29)
	-- upvalues: (copy) v_u_10, (copy) v_u_2, (copy) v_u_6, (copy) v_u_22, (copy) v_u_5
	local v30 = v_u_10.Template
	for v_u_31, v32 in v_u_2 do
		local v33 = v30:Clone()
		v33.Title.Text = v32.Name
		v33.Icon.Image = v32.Image
		v33.LayoutOrder = -v_u_31
		v33.Parent = v30.Parent
		local v_u_34 = v33.Hovered
		local v_u_35 = v_u_34.WorldName
		local v_u_36 = v33.Date
		local v_u_37 = v_u_35.Position
		local v_u_38 = v_u_37 + UDim2.fromScale(0, 0.1)
		local v_u_39 = v_u_36.Title.Position
		local v_u_40 = v_u_39 + UDim2.fromScale(0, 1)
		v_u_34.BackgroundTransparency = 1
		v_u_34.Visible = false
		v_u_35.Position = v_u_38
		v_u_36.Title.Text = v_u_6.GetUpdateTime(v_u_22(v32.Date))
		v33.Activated:Connect(function()
			-- upvalues: (copy) p_u_29, (copy) v_u_31
			p_u_29:view(v_u_31)
		end)
		v33.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u_5, (copy) v_u_35, (copy) v_u_37, (copy) v_u_34, (copy) v_u_36, (copy) v_u_40
			local v41 = {
				["Position"] = v_u_37
			}
			v_u_5.target(v_u_35, 1, 5, v41)
			v_u_5.target(v_u_34, 0.5, 5, {
				["BackgroundTransparency"] = 0,
				["Visible"] = true
			})
			local v42 = {
				["Position"] = v_u_40
			}
			v_u_5.target(v_u_36.Title, 1, 5, v42)
		end)
		v33.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_5, (copy) v_u_35, (copy) v_u_38, (copy) v_u_34, (copy) v_u_36, (copy) v_u_39
			local v43 = {
				["Position"] = v_u_38
			}
			v_u_5.target(v_u_35, 0.5, 5, v43)
			v_u_5.target(v_u_34, 1, 10, {
				["BackgroundTransparency"] = 1,
				["Visible"] = false
			})
			local v44 = {
				["Position"] = v_u_39
			}
			v_u_5.target(v_u_36.Title, 1, 5, v44)
		end)
	end
	v30.Visible = false
end
function v8.init(p45)
	-- upvalues: (copy) v_u_2
	p45:loadLeft()
	p45:view(#v_u_2)
end
return v8]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UpdateLog]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3779"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Currency.CurrencyController)
local v_u_3 = require(v1.Client.Gameplay.Valentine.BloomController)
local v4 = require(v1.Config.CurrencyData)
local v_u_5 = require(v1.Enums.CurrencyTypes)
local v_u_6 = require(v1.Utility.BloomUtil)
local v_u_7 = require(v1.Utility.Format)
local v8 = require(v1.Utility.Network)
local v_u_9 = require(v1.Utility.Notify)
local v_u_10 = require(v1.Utility.Spring)
local v11 = {}
local v_u_12 = require(v1.Utility.UI):get("Gui", "Bloom").Container
local v_u_13 = v_u_12.Position
local v_u_14 = v_u_13 + UDim2.fromScale(0, 1)
local v_u_15 = v4[v_u_5.Hearts]
local v_u_16 = {
	["Bloom"] = v8.remoteFunction("BloomService/bloom")
}
function v11.open(_)
	-- upvalues: (copy) v_u_10, (copy) v_u_12, (copy) v_u_13
	local v17 = {
		["Position"] = v_u_13,
		["Visible"] = true
	}
	v_u_10.target(v_u_12, 0.8, 5, v17)
end
function v11.close(_)
	-- upvalues: (copy) v_u_10, (copy) v_u_12, (copy) v_u_14
	local v18 = {
		["Position"] = v_u_14,
		["Visible"] = false
	}
	v_u_10.target(v_u_12, 0.8, 5, v18)
end
function v11.updateProgress(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_3, (copy) v_u_6, (copy) v_u_7, (copy) v_u_12, (copy) v_u_15
	local v19 = v_u_2:get(v_u_5.Hearts)
	local v20 = v_u_3:get()
	local v21 = v_u_6.getPrice(v20 + 1)
	local v22 = v_u_7.abbreviateComma(v19)
	local v23 = v_u_7.abbreviateComma(v21)
	local v24 = v19 / v21
	local v25 = math.clamp(v24, 0, 1)
	v_u_12.Container.Progress.UIGradient.Offset = Vector2.new(v25, 0)
	v_u_12.Container.Progress.Title.Text = ("%* / %* %*"):format(v22, v23, (v_u_15.GetPrefix(v21)))
end
function v11.updateMultipliers(_)
	-- upvalues: (copy) v_u_12, (copy) v_u_3, (copy) v_u_6, (copy) v_u_7
	local v26 = v_u_12.Container.Top
	local v27 = v_u_3:get()
	local v28 = v_u_6.getMultiplier(v27)
	local v29 = v_u_6.getMultiplier(v27 + 1)
	v26.Left.Benefits.Template.Text = ("x%* Heart Multiplier"):format((v_u_7.abbreviate((math.floor(v28)))))
	v26.Right.Benefits.Template.Text = ("x%* Heart Multiplier"):format((v_u_7.abbreviate((math.floor(v29)))))
end
function v11.init(p_u_30)
	-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_3, (copy) v_u_12, (copy) v_u_16, (copy) v_u_9
	v_u_2:observe(v_u_5.Hearts, function()
		-- upvalues: (copy) p_u_30
		p_u_30:updateProgress()
	end)
	v_u_3:observe(function()
		-- upvalues: (copy) p_u_30
		p_u_30:updateProgress()
		p_u_30:updateMultipliers()
	end)
	v_u_12.Container.Robux.Activated:Connect(function()
		-- upvalues: (ref) v_u_16, (ref) v_u_9
		local v31, v32 = v_u_16.Bloom:invoke()
		v_u_9.Notify({
			["Message"] = v32,
			["Type"] = v31 and v_u_9.Types.Success or v_u_9.Types.Error
		})
	end)
end
return v11]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Bloom]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3780"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Client.Currency.CurrencyController)
local v_u_4 = require(v2.Client.Data.DataController)
local v_u_5 = require(v2.Client.Gameplay.Passives.ValentineTraitController)
local v_u_6 = require(v2.Config.Colors)
local v_u_7 = require(v2.Config.CrystalHeartsData)
local v_u_8 = require(v2.Config.ValentineTraitsData)
local v_u_9 = require(v2.Enums.CurrencyTypes)
local v_u_10 = require(v2.Enums.MultiplierTypes)
local v_u_11 = require(v2.Enums.Products)
local v_u_12 = require(v2.Packages.Observers)
local v_u_13 = require(v2.Utility.Format)
local v_u_14 = require(v2.Utility.Marketplace)
local v_u_15 = require(v2.Utility.Multiplier)
local v16 = require(v2.Utility.Network)
local v_u_17 = require(v2.Utility.Notify)
local v_u_18 = require(v2.Utility.Spring)
local v_u_19 = require(v2.Utility.UI):get("Gui", "ValentineTraits").Container
local v20 = v_u_19.Left
local v_u_21 = v_u_19.Holder
local v_u_22 = v_u_19.Index
local v_u_23 = v_u_21.Bottom
local v_u_24 = v_u_19.Auto
local v_u_25 = v_u_21.StopAuto
local v_u_26 = v_u_19.Position
local v_u_27 = v_u_26 + UDim2.fromScale(0, 1)
local v_u_28 = {
	["Roll"] = v16.remoteFunction("ValentineTraitService/Roll"),
	["Equip"] = v16.remoteFunction("ValentineTraitService/Equip"),
	["Auto"] = v16.remoteEvent("ValentineTraitService/Auto"),
	["StopAuto"] = v16.remoteEvent("ValentineTraitService/StopAuto"),
	["Lock"] = v16.remoteEvent("ValentineTraitService/Lock")
}
local v_u_29 = {}
local v_u_30 = {}
local v31 = {}
for _, v_u_32 in v20:QueryDescendants("Frame") do
	v_u_29[v_u_32.LayoutOrder] = v_u_32
	local v33 = Instance.new("Frame")
	v33.Size = v_u_32.Size
	v33.LayoutOrder = v_u_32.LayoutOrder
	v33.BackgroundTransparency = 1
	v33.ClipsDescendants = true
	v33.Parent = v20
	v_u_32.Size = UDim2.fromScale(0.95, 0.95)
	v_u_32.AnchorPoint = Vector2.new(0.5, 0.5)
	v_u_32.Position = UDim2.fromScale(0.5, 0.5)
	v_u_32.Parent = v33
	v_u_30[v_u_32.LayoutOrder] = {
		["play"] = function()
			-- upvalues: (copy) v_u_18, (copy) v_u_32
			v_u_18.target(v_u_32, 0.8, 5, {
				["Position"] = UDim2.fromScale(0.5, 0.5)
			})
		end,
		["reset"] = function()
			-- upvalues: (copy) v_u_18, (copy) v_u_32
			v_u_18.stop(v_u_32)
			v_u_18.target(v_u_32, 0.8, 5, {
				["Position"] = UDim2.fromScale(1.7, 0.5)
			})
		end
	}
end
local v_u_34 = {}
local function v_u_35()
	-- upvalues: (copy) v_u_28, (copy) v_u_25
	v_u_28.StopAuto.fire()
	v_u_25.Visible = false
end
local function v_u_36()
	-- upvalues: (copy) v_u_34, (copy) v_u_17, (copy) v_u_25, (copy) v_u_24, (copy) v_u_28
	if #v_u_34 <= 0 then
		v_u_17.Notify({
			["Message"] = "You need atleast 1 Trait Selected",
			["Type"] = v_u_17.Types.Error
		})
	else
		v_u_25.Visible = true
		v_u_24.Visible = false
		v_u_28.Auto.fire(v_u_34)
	end
end
function v31.open(_)
	-- upvalues: (copy) v_u_18, (copy) v_u_19, (copy) v_u_26, (copy) v_u_30
	local v37 = {
		["Position"] = v_u_26,
		["Visible"] = true
	}
	v_u_18.target(v_u_19, 0.8, 5, v37)
	task.spawn(function()
		-- upvalues: (ref) v_u_30
		for _, v38 in v_u_30 do
			v38.play()
			task.wait(0.025)
		end
	end)
end
function v31.close(_)
	-- upvalues: (copy) v_u_18, (copy) v_u_19, (copy) v_u_27, (copy) v_u_28, (copy) v_u_25, (copy) v_u_30
	local v39 = {
		["Position"] = v_u_27,
		["Visible"] = false
	}
	v_u_18.target(v_u_19, 0.8, 5, v39)
	v_u_28.StopAuto.fire()
	v_u_25.Visible = false
	for _, v40 in v_u_30 do
		v40.reset()
	end
end
function v31.setupLocked(_)
	-- upvalues: (copy) v_u_19, (copy) v_u_28, (copy) v_u_4, (copy) v_u_6
	local v_u_41 = v_u_19.Lock
	v_u_41.Activated:Connect(function()
		-- upvalues: (ref) v_u_28
		v_u_28.Lock.fire()
	end)
	v_u_4:onSet({ "ValentineTraits", "Locked" }, function(p42)
		-- upvalues: (copy) v_u_41, (ref) v_u_6
		v_u_41.ImageLabel.Image = ("rbxassetid://%*"):format(p42 and 134434974939221 or 76096090670932)
		v_u_41.UIGradient.Color = p42 and v_u_6.Blue.Gradient or v_u_6.Grey.Gradient
	end)
end
function v31.setupProducts(_)
	-- upvalues: (copy) v_u_29, (copy) v_u_11, (copy) v_u_7, (copy) v_u_14, (copy) v_u_13
	for v43, v_u_44 in v_u_29 do
		local v_u_45 = v_u_11.CrystalHearts[v43]
		local v46 = v_u_7[v_u_45]
		v_u_44.Purchase.Price.Text = "..."
		v_u_14.ObserveProduct(v_u_45, function(p47)
			-- upvalues: (copy) v_u_44, (ref) v_u_13
			v_u_44.Purchase.Price.Text = v_u_13.robux(v_u_13.comma(p47.PriceInRobux))
		end)
		v_u_44.TextLabel.Text = v_u_13.comma(v46)
		v_u_44.Purchase.Activated:Connect(function()
			-- upvalues: (ref) v_u_14, (copy) v_u_45
			v_u_14.PromptProduct(v_u_45)
		end)
	end
end
function v31.setupCurrency(_)
	-- upvalues: (copy) v_u_19, (copy) v_u_3, (copy) v_u_9, (copy) v_u_13
	local v_u_48 = v_u_19.Holder.Gems.TextLabel
	v_u_3:observe(v_u_9.CrystalHearts, function(p49)
		-- upvalues: (copy) v_u_48, (ref) v_u_13
		v_u_48.Text = v_u_13.comma(p49)
	end)
end
function v31.setNone(_)
	-- upvalues: (copy) v_u_21
	v_u_21.Glow.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
	v_u_21.Current.Main.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
	v_u_21.Current.Main.Title.Text = "No Trait"
	v_u_21.Current.Main.Desc.Text = "Equip or Start Rolling to get a Traits!"
end
function v31.setupIndex(_)
	-- upvalues: (copy) v_u_22, (copy) v_u_8, (copy) v_u_13, (copy) v_u_15, (copy) v_u_10, (copy) v_u_23, (copy) v_u_18
	local v50 = v_u_22.Contents
	local v51 = v50.Template
	local v_u_52 = 0
	for _, v53 in v_u_8 do
		v_u_52 = v_u_52 + v53.Chance
	end
	local v_u_54 = {}
	for _, v55 in v_u_8 do
		local v56 = v51:Clone()
		v56.Visible = true
		v56.LayoutOrder = v55.Order
		v56.Parent = v50
		v56.Title.Text = v55.Name
		v56.Buffs.Text = v55.Description
		v56.UIGradient.Color = v55.Gradient
		if v55.Animated then
			v56.UIGradient:AddTag("Gradient")
		end
		if v55.Chance < 0.1 then
			local v57 = v56.Chance
			local v58 = v_u_13.abbreviateComma
			local v59 = 1 / v55.Chance
			v57.Text = ("1/%*"):format((v58((math.round(v59)))))
		else
			v56.Chance.Text = ("%*%%"):format((v_u_13.decimal(v55.Chance / v_u_52 * 100, 2)))
		end
		local v60 = {
			["textlabel"] = v56.Chance,
			["chance"] = v55.Chance
		}
		table.insert(v_u_54, v60)
	end
	local function v68()
		-- upvalues: (ref) v_u_15, (ref) v_u_10, (copy) v_u_54, (ref) v_u_52, (ref) v_u_13
		local v61 = v_u_15.get(v_u_10.ValentineTraitsLuck) * v_u_15.get(v_u_10.ValentineTraitsLuckMultiplier)
		local v62 = math.max(1, v61)
		for _, v63 in v_u_54 do
			local v64 = v63.chance * v62 / v_u_52 * 100
			if v_u_52 < v64 then
				v63.textlabel.Text = "Luck too high!"
			elseif v64 < 0.1 then
				local v65 = v63.textlabel
				local v66 = v_u_13.abbreviateComma
				local v67 = 100 / v64
				v65.Text = ("1/%*"):format((v66((math.round(v67)))))
			else
				v63.textlabel.Text = ("%*%%"):format((v_u_13.decimal(v64, 2)))
			end
		end
	end
	v68()
	v_u_15.observe(v_u_10.ValentineTraitsLuck, v68)
	v_u_15.observe(v_u_10.ValentineTraitsLuckMultiplier, v68)
	local v_u_69 = v_u_22.Position
	local v_u_70 = v_u_22.Size
	v_u_22.Visible = false
	v_u_23.Index.Activated:Connect(function()
		-- upvalues: (ref) v_u_22, (ref) v_u_18, (copy) v_u_69, (copy) v_u_70
		if v_u_22.Visible then
			v_u_18.target(v_u_22, 0.6, 5, {
				["Position"] = v_u_69 - UDim2.fromScale(0.2, 0),
				["Size"] = UDim2.fromScale(0, 0),
				["Visible"] = false
			})
		else
			local v71 = {
				["Position"] = v_u_69,
				["Size"] = v_u_70,
				["Visible"] = true
			}
			v_u_18.target(v_u_22, 0.6, 5, v71)
		end
	end)
	v51:Destroy()
end
function v31.setupAuto(_)
	-- upvalues: (copy) v_u_24, (copy) v_u_25, (copy) v_u_23, (copy) v_u_8, (copy) v_u_34, (copy) v_u_6, (copy) v_u_12, (copy) v_u_1, (copy) v_u_36, (copy) v_u_35
	local v72 = v_u_24.Contents
	local v73 = v72.Template
	v_u_25.Visible = false
	v_u_24.Visible = false
	v_u_24.Header.Close.Activated:Connect(function()
		-- upvalues: (ref) v_u_24
		v_u_24.Visible = false
	end)
	v_u_23.Auto.Activated:Connect(function()
		-- upvalues: (ref) v_u_24
		v_u_24.Visible = not v_u_24.Visible
	end)
	local v_u_74 = {}
	for v_u_75, v76 in v_u_8 do
		local v_u_77 = v73:Clone()
		v_u_77.Visible = true
		v_u_77.LayoutOrder = v76.Order
		v_u_77.Parent = v72
		v_u_77.Title.Text = v76.Name
		v_u_77.Title.UIGradient.Color = v76.Gradient
		v_u_74[v_u_75] = {
			["Selected"] = function(_)
				-- upvalues: (ref) v_u_34, (copy) v_u_75, (copy) v_u_77, (ref) v_u_6
				if not table.find(v_u_34, v_u_75) then
					local v78 = v_u_34
					local v79 = v_u_75
					table.insert(v78, v79)
				end
				v_u_77.Select.UIGradient.Color = v_u_6.Green.Gradient
				v_u_77.Select.UIStroke.Color = v_u_6.Green.Stroke
				v_u_77.Select.Cost.UIStroke.Color = v_u_6.Green.Stroke
				v_u_77.Select.Cost.Text = "Selected"
			end,
			["Deselect"] = function(_)
				-- upvalues: (ref) v_u_34, (copy) v_u_75, (copy) v_u_77, (ref) v_u_6
				local v80 = table.find(v_u_34, v_u_75)
				if v80 then
					table.remove(v_u_34, v80)
				end
				v_u_77.Select.UIGradient.Color = v_u_6.Grey.Gradient
				v_u_77.Select.UIStroke.Color = v_u_6.Grey.Stroke
				v_u_77.Select.Cost.UIStroke.Color = v_u_6.Grey.Stroke
				v_u_77.Select.Cost.Text = "Deselected"
			end,
			["Toggle"] = function(p81)
				-- upvalues: (ref) v_u_34, (copy) v_u_75
				if table.find(v_u_34, v_u_75) then
					p81:Deselect()
				else
					p81:Selected()
				end
			end
		}
		v_u_74[v_u_75]:Deselect()
		v_u_77.Select.Activated:Connect(function()
			-- upvalues: (copy) v_u_74, (copy) v_u_75
			v_u_74[v_u_75]:Toggle()
		end)
	end
	v_u_12.observeAttribute(v_u_1.LocalPlayer, "AutoPassive", function(p82)
		-- upvalues: (ref) v_u_25
		if p82 then
			v_u_25.Visible = true
		else
			v_u_25.Visible = false
		end
	end)
	v_u_24.Start.Activated:Connect(v_u_36)
	v_u_25.Activated:Connect(v_u_35)
	v73:Destroy()
end
function v31.setupInventory(_)
	-- upvalues: (copy) v_u_19, (copy) v_u_23, (copy) v_u_8, (copy) v_u_28, (copy) v_u_6, (copy) v_u_5
	local v_u_83 = v_u_19.Inventory
	local v84 = v_u_83.Contents
	local v85 = v84.Template
	v_u_83.Visible = false
	v_u_83.Header.Close.Activated:Connect(function()
		-- upvalues: (copy) v_u_83
		v_u_83.Visible = false
	end)
	v_u_23.Inventory.Activated:Connect(function()
		-- upvalues: (copy) v_u_83
		v_u_83.Visible = not v_u_83.Visible
	end)
	local v_u_86 = {}
	local v87 = nil
	for v_u_88, v89 in v_u_8 do
		local v_u_90 = v85:Clone()
		v_u_90.Visible = true
		v_u_90.LayoutOrder = v89.Order
		v_u_90.Parent = v84
		v_u_90.Title.Text = v89.Name
		v_u_90.Desc.Text = v89.Description
		v_u_90.UIGradient.Color = v89.Gradient
		if v89.Animated then
			v_u_90.UIGradient:AddTag("Gradient")
		end
		v_u_90.Equip.Activated:Connect(function()
			-- upvalues: (ref) v_u_28, (copy) v_u_88
			v_u_28.Equip.invoke(v_u_88)
		end)
		v_u_86[v_u_88] = {
			["Lock"] = function()
				-- upvalues: (copy) v_u_90
				v_u_90.Locked.Visible = true
			end,
			["Unlock"] = function()
				-- upvalues: (copy) v_u_90
				v_u_90.Locked.Visible = false
			end,
			["Equip"] = function()
				-- upvalues: (copy) v_u_90, (ref) v_u_6
				v_u_90.Equip.UIGradient.Color = v_u_6.Green.Gradient
				v_u_90.Equip.UIStroke.Color = v_u_6.Green.Stroke
				v_u_90.Equip.Cost.UIStroke.Color = v_u_6.Green.Stroke
				v_u_90.Equip.Cost.Text = "Equipped"
			end,
			["Unequip"] = function()
				-- upvalues: (copy) v_u_90, (ref) v_u_6
				v_u_90.Equip.UIGradient.Color = v_u_6.Grey.Gradient
				v_u_90.Equip.UIStroke.Color = v_u_6.Grey.Stroke
				v_u_90.Equip.Cost.UIStroke.Color = v_u_6.Grey.Stroke
				v_u_90.Equip.Cost.Text = "Equip"
			end
		}
		v_u_86[v_u_88]:Unequip()
		v_u_86[v_u_88]:Lock()
	end
	for v91, v92 in v_u_5.Storage do
		if v_u_86[v91] and v92 > 0 then
			v_u_86[v91]:Unlock()
		end
	end
	local v_u_93 = v_u_5:getEquipped()
	if v_u_93 and v_u_86[v_u_93] then
		v_u_86[v_u_93]:Equip()
	else
		v_u_93 = v87
	end
	v_u_5.OnEquipped:Connect(function(p94)
		-- upvalues: (ref) v_u_93, (copy) v_u_86
		if v_u_93 then
			v_u_86[v_u_93]:Unequip()
			v_u_93 = nil
		end
		if p94 and v_u_86[p94] then
			v_u_86[p94]:Equip()
			v_u_93 = p94
		end
	end)
	v_u_5.OnStorageUpdated:Connect(function(p95, p96)
		-- upvalues: (copy) v_u_86
		if v_u_86[p95] then
			if p96 and p96 > 0 then
				v_u_86[p95]:Unlock()
				return
			end
			v_u_86[p95]:Lock()
		end
	end)
	v85:Destroy()
end
function v31.equip(_, p97)
	-- upvalues: (copy) v_u_8, (copy) v_u_21
	local v98 = v_u_8[p97]
	if v98 then
		v_u_21.Glow.UIGradient.Color = v98.Gradient
		v_u_21.Current.Main.Title.Text = v98.Name
		v_u_21.Current.Main.Desc.Text = v98.Description
		if v98.Animated then
			v_u_21.Current.Main.UIGradient:RemoveTag("Gradient")
			v_u_21.Current.Main.UIGradient:AddTag("Gradient")
		else
			v_u_21.Current.Main.UIGradient:RemoveTag("Gradient")
		end
		v_u_21.Current.Main.UIGradient.Color = v98.Gradient
	end
end
function v31.setupEquip(p_u_99)
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local function v101(p100)
		-- upvalues: (copy) p_u_99
		if p100 then
			p_u_99:equip(p100)
		else
			p_u_99:setNone()
		end
	end
	local v102 = v_u_4:getValue({ "ValentineTraits", "Equipped" })
	if v102 then
		p_u_99:equip(v102)
	else
		p_u_99:setNone()
	end
	v_u_5.OnEquipped:Connect(v101)
end
function v31.init(p103)
	-- upvalues: (copy) v_u_28, (copy) v_u_35, (copy) v_u_23, (copy) v_u_17
	p103:setupLocked()
	p103:setupProducts()
	p103:setupCurrency()
	p103:setupIndex()
	p103:setupAuto()
	p103:setupInventory()
	p103:setupEquip()
	v_u_28.StopAuto.listen(v_u_35)
	v_u_23.Roll.Activated:Connect(function()
		-- upvalues: (ref) v_u_28, (ref) v_u_17
		local v104, v105 = v_u_28.Roll.invoke()
		if not v104 then
			v_u_17.Notify({
				["Message"] = v105,
				["Type"] = v_u_17.Types.Error
			})
		end
	end)
end
return v31]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ValentineTraits]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3781"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Utility.Spring)
local v3 = require(v1.Utility.UI)
local v_u_4 = require(v1.Client.Data.DataController)
local v_u_5 = require(v1.Config.AmuletData)
local v_u_6 = require(v1.Config.GloopData)
local v_u_7 = require(v1.Config.MultiplierData)
local v_u_8 = require(v1.Utility.MultiplierUtil)
local v9 = require(v1.Utility.Network)
local v_u_10 = require(v1.Utility.Notify)
local v11 = require(v1.Packages.Janitor)
local v12 = {}
local v_u_13 = {
	["ApplyGloop"] = v9.remoteFunction("AmuletService/ApplyGloop")
}
local v_u_14 = nil
v11.new()
local v_u_15 = v3:get("Gui", "AmuletUpgrader").Container
local v16 = v_u_15.Container
local v17 = v16.Left
local v_u_18 = v16.Right
local v_u_19 = v_u_18.Template
local v_u_20 = v17.Selector
local v_u_21 = v17.Middle
local v_u_22 = v_u_21.Container.Template
local v_u_23 = v_u_21.Template
local v24 = v17.Top
local v_u_25 = v24.Benefits
local v_u_26 = v_u_25.Template
local v_u_27 = v24.Icon
local v_u_28 = v_u_15.Position
local v_u_29 = v_u_28 + UDim2.fromScale(0, 1)
v_u_19.Visible = false
v_u_22.Visible = false
v_u_26.Visible = false
local v_u_30 = {}
function v12.updateStats(_)
	-- upvalues: (copy) v_u_30, (ref) v_u_14, (copy) v_u_4, (copy) v_u_26, (copy) v_u_25, (copy) v_u_6, (copy) v_u_7, (copy) v_u_8, (copy) v_u_5, (copy) v_u_27
	for _, v31 in v_u_30 do
		v31:Destroy()
	end
	table.clear(v_u_30)
	if v_u_14 then
		local v32 = v_u_4:getValue({ "Amulet", "Equipped", v_u_14 })
		if v32 and v32.Tier then
			local v33 = 0
			if v32.AppliedGloops and #v32.AppliedGloops > 0 then
				for _, v34 in v32.AppliedGloops do
					local v35 = v_u_6[v34]
					if v35 and v35.Buffs.Multiplier then
						v33 = v33 + v35.Buffs.Multiplier
					end
				end
			end
			for v36, v37 in v32.Multipliers do
				local v38 = v_u_7[v36]
				if v38 then
					local v39 = ("%* %*"):format(v_u_8.format(v36, v37), v38.Name)
					if v33 > 0 then
						local v40 = v33 * 100
						v39 = ("%* (+%*%%)"):format(v39, (math.floor(v40)))
					end
					local v41 = v_u_26:Clone()
					v41.Text = v39
					v41.Visible = true
					v41.Parent = v_u_25
					local v42 = v_u_30
					table.insert(v42, v41)
				end
			end
			local v43 = v_u_5[v_u_14]
			v_u_27.Image = v43.Tiers[v32.Tier].Icon or v43.Icon
		else
			local v44 = v_u_26:Clone()
			v44.Text = "No Amulet Equipped"
			v44.Visible = true
			v44.Parent = v_u_25
			local v45 = v_u_30
			table.insert(v45, v44)
		end
	else
		return
	end
end
local v_u_46 = {}
function v12.showUsed(_)
	-- upvalues: (copy) v_u_46, (ref) v_u_14, (copy) v_u_4, (copy) v_u_23, (copy) v_u_6, (copy) v_u_22, (copy) v_u_21
	for _, v47 in v_u_46 do
		v47:Destroy()
	end
	table.clear(v_u_46)
	if v_u_14 then
		local v48 = v_u_4:getValue({ "Amulet", "Equipped", v_u_14 })
		if v48 and v48.Tier then
			local v49 = v48.AppliedGloops or {}
			local v50 = v48.BrokenGloops or {}
			v_u_23.Text = ("Used Gloop (%*/5)"):format(#v49 + #v50)
			for _, v51 in v49 do
				local v52 = v_u_6[v51]
				if v52 then
					local v53 = v_u_22:Clone()
					v53.Icon.Image = v52.Icon
					v53.Success.Visible = true
					v53.Fail.Visible = false
					v53.Visible = true
					v53.Parent = v_u_21.Container
					local v54 = v_u_46
					table.insert(v54, v53)
				end
			end
			for _, v55 in v50 do
				local v56 = v_u_6[v55]
				if v56 then
					local v57 = v_u_22:Clone()
					v57.Icon.Image = v56.Icon
					v57.Success.Visible = false
					v57.Fail.Visible = true
					v57.Visible = true
					v57.Parent = v_u_21.Container
					local v58 = v_u_46
					table.insert(v58, v57)
				end
			end
		else
			v_u_23.Text = "Used Gloop (0/5)"
		end
	else
		return
	end
end
function v12.setupGloops(p_u_59)
	-- upvalues: (copy) v_u_6, (copy) v_u_19, (copy) v_u_18, (copy) v_u_4, (ref) v_u_14, (copy) v_u_10, (copy) v_u_13
	for v_u_60, v_u_61 in v_u_6 do
		local v_u_62 = v_u_19:Clone()
		v_u_62.Title.Text = v_u_61.Name
		v_u_62.SuccessRate.Text = ("%*%% Success Rate"):format(v_u_61.Chance)
		v_u_62.IconHolder.Icon.Image = v_u_61.Icon
		v_u_62.LayoutOrder = v_u_61.Order
		v_u_62.Visible = true
		v_u_62.Parent = v_u_18
		v_u_62:SetAttribute("ItemType", "Perk")
		v_u_62:SetAttribute("Title", v_u_61.Name)
		v_u_62:SetAttribute("Description", v_u_61.Description)
		v_u_62:AddTag("tooltip")
		v_u_4:onSet({ "Gloop", v_u_60 }, function(p63)
			-- upvalues: (copy) v_u_62
			v_u_62.Buttons.Use.Price.Text = ("Use (x%*)"):format(p63 or 0)
		end)
		v_u_62.Buttons.Use.Activated:Connect(function()
			-- upvalues: (ref) v_u_14, (ref) v_u_10, (ref) v_u_4, (copy) v_u_60, (copy) v_u_61, (ref) v_u_13, (copy) p_u_59
			if v_u_14 then
				local v64 = v_u_4:getValue({ "Amulet", "Equipped", v_u_14 })
				if v64 and v64.Tier then
					if (v_u_4:getValue({ "Gloop", v_u_60 }) or 0) <= 0 then
						v_u_10.Notify({
							["Message"] = ("Not enough %*!"):format(v_u_61.Name),
							["Type"] = v_u_10.Types.Error
						})
					else
						local v65, v66 = v_u_13.ApplyGloop.invoke(v_u_14, v_u_60)
						v_u_10.Notify({
							["Message"] = v66,
							["Type"] = v65 and v_u_10.Types.Success or v_u_10.Types.Error
						})
						task.wait(0.1)
						p_u_59:updateStats()
						p_u_59:showUsed()
					end
				else
					v_u_10.Notify({
						["Message"] = "No amulet equipped",
						["Type"] = v_u_10.Types.Error
					})
					return
				end
			else
				v_u_10.Notify({
					["Message"] = "No amulet selected",
					["Type"] = v_u_10.Types.Error
				})
				return
			end
		end)
	end
end
function v12.selectAmulet(p67, p68)
	-- upvalues: (ref) v_u_14, (copy) v_u_20, (copy) v_u_5
	v_u_14 = p68
	v_u_20.Display.Text = v_u_5[p68].Name
	p67:updateStats()
	p67:showUsed()
end
function v12.setupSelector(p_u_69)
	-- upvalues: (copy) v_u_20, (copy) v_u_4, (ref) v_u_14
	local v70 = v_u_20.Right
	local v71 = v_u_20.Left
	local v72 = v_u_20.Display
	local v_u_73 = {}
	local v_u_74 = 1
	for v75 in v_u_4:getValue({ "Amulet", "Equipped" }) or {} do
		table.insert(v_u_73, v75)
	end
	v_u_4:onChange(function(_, p76, _, _)
		-- upvalues: (copy) v_u_73, (ref) v_u_14, (copy) p_u_69
		if p76[1] == "Amulet" and p76[2] == "Equipped" then
			local v77 = p76[3]
			if not table.find(v_u_73, v77) then
				local v78 = v_u_73
				table.insert(v78, v77)
				if not v_u_14 then
					p_u_69:selectAmulet(v77)
				end
			end
		end
	end)
	if #v_u_73 <= 0 then
		v72.Text = "No Amulets"
	else
		p_u_69:selectAmulet(v_u_73[1])
	end
	v70.Activated:Connect(function()
		-- upvalues: (copy) v_u_73, (ref) v_u_74, (copy) p_u_69
		if #v_u_73 ~= 0 then
			v_u_74 = v_u_74 + 1
			if v_u_74 > #v_u_73 then
				v_u_74 = 1
			end
			p_u_69:selectAmulet(v_u_73[v_u_74])
		end
	end)
	v71.Activated:Connect(function()
		-- upvalues: (copy) v_u_73, (ref) v_u_74, (copy) p_u_69
		if #v_u_73 ~= 0 then
			v_u_74 = v_u_74 - 1
			if v_u_74 < 1 then
				v_u_74 = #v_u_73
			end
			p_u_69:selectAmulet(v_u_73[v_u_74])
		end
	end)
end
function v12.open(p79)
	-- upvalues: (copy) v_u_2, (copy) v_u_15, (copy) v_u_28
	p79:updateStats()
	p79:showUsed()
	local v80 = {
		["Position"] = v_u_28,
		["Visible"] = true
	}
	v_u_2.target(v_u_15, 0.8, 5, v80)
end
function v12.close(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_15, (copy) v_u_29
	local v81 = {
		["Position"] = v_u_29,
		["Visible"] = false
	}
	v_u_2.target(v_u_15, 0.8, 5, v81)
end
function v12.init(p82)
	p82:setupSelector()
	p82:setupGloops()
end
return v12]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AmuletUpgrader]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3782"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Enums.Gamepasses)
local v_u_3 = require(v1.Enums.Products)
local v_u_4 = require(v1.Enums.WorldTypes)
local v_u_5 = require(v1.Utility.Format)
local v_u_6 = require(v1.Utility.GamepassUtil)
local v_u_7 = require(v1.Utility.Marketplace)
local v8 = require(v1.Utility.Network)
local v_u_9 = require(v1.Utility.Spring)
local v_u_10 = require(v1.Utility.UI)
local v_u_11 = require(v1.Utility.WorldUtil)
local v12 = {}
local v_u_13 = v_u_10:get("Gui", "DiscountOffer").Container
local v_u_14 = v_u_13.Container.Buttons.Robux
local v_u_15 = v_u_13.Container.Buttons.No
local v_u_16 = v_u_13.Position
local v_u_17 = v_u_16 + UDim2.fromScale(0, 1)
local v_u_18 = false
local v_u_19 = v8.remoteFunction("CheckOfferSeen")
local v_u_20 = v8.remoteFunction("MarkOfferSeen")
function v12.open(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_13, (copy) v_u_16
	local v21 = {
		["Position"] = v_u_16,
		["Visible"] = true
	}
	v_u_9.target(v_u_13, 0.8, 5, v21)
end
function v12.close(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_13, (copy) v_u_17
	local v22 = {
		["Position"] = v_u_17,
		["Visible"] = false
	}
	v_u_9.target(v_u_13, 0.8, 5, v22)
end
function v12.init(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_3, (copy) v_u_14, (copy) v_u_5, (copy) v_u_11, (copy) v_u_4, (ref) v_u_18, (copy) v_u_19, (copy) v_u_6, (copy) v_u_2, (copy) v_u_10, (copy) v_u_20, (copy) v_u_15
	v_u_7.ObserveProduct(v_u_3.LavaWorldOffer, function(p23)
		-- upvalues: (ref) v_u_14, (ref) v_u_5
		v_u_14.Price.Text = v_u_5.robux(p23.PriceInRobux)
	end)
	v_u_11.observe(function(p24)
		-- upvalues: (ref) v_u_4, (ref) v_u_18, (ref) v_u_19, (ref) v_u_6, (ref) v_u_2, (ref) v_u_10, (ref) v_u_20
		if p24 == v_u_4.LAVA_WORLD and not v_u_18 then
			if not v_u_19.invoke("LavaWorldOffer") then
				if not v_u_6.has(v_u_2.SkillXP2x) then
					v_u_10:open(script.Name)
					v_u_10:lock()
				end
				v_u_20.invoke("LavaWorldOffer")
			end
			v_u_18 = true
		end
	end)
	v_u_14.Activated:Connect(function()
		-- upvalues: (ref) v_u_7, (ref) v_u_3, (ref) v_u_10
		v_u_7.PromptProduct(v_u_3.LavaWorldOffer)
		if v_u_10.Current == script.Name then
			v_u_10:unlock()
			v_u_10:close(script.Name)
		end
	end)
	v_u_15.Activated:Connect(function()
		-- upvalues: (ref) v_u_10
		if v_u_10.Current == script.Name then
			v_u_10:unlock()
			v_u_10:close(script.Name)
		end
	end)
end
return v12]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[DiscountOffer]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3783"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Client.Currency.CurrencyController)
local v_u_4 = require(v2.Client.Data.DataController)
local v_u_5 = require(v2.Client.Gameplay.Passives.MillionaireTraitController)
local v_u_6 = require(v2.Config.Colors)
local v_u_7 = require(v2.Config.Event1MStarData)
local v_u_8 = require(v2.Config.MillionaireTraitsData)
local v_u_9 = require(v2.Enums.CurrencyTypes)
local v_u_10 = require(v2.Enums.MultiplierTypes)
local v_u_11 = require(v2.Enums.Products)
local v_u_12 = require(v2.Packages.Observers)
local v_u_13 = require(v2.Utility.Format)
local v_u_14 = require(v2.Utility.Marketplace)
local v_u_15 = require(v2.Utility.Multiplier)
local v16 = require(v2.Utility.Network)
local v_u_17 = require(v2.Utility.Notify)
local v_u_18 = require(v2.Utility.Spring)
local v_u_19 = require(v2.Utility.UI):get("Gui", "MillionaireTraits").Container
local v_u_20 = v_u_19.Holder
local v21 = v_u_19.Left
local v_u_22 = v_u_19.Index
local v_u_23 = v_u_20.Bottom
local v_u_24 = v_u_19.Auto
local v_u_25 = v_u_20.StopAuto
local v_u_26 = v_u_19.Position
local v_u_27 = v_u_26 + UDim2.fromScale(0, 1)
local v_u_28 = {
	["Roll"] = v16.remoteFunction("MillionaireTraitService/Roll"),
	["Equip"] = v16.remoteFunction("MillionaireTraitService/Equip"),
	["Auto"] = v16.remoteEvent("MillionaireTraitService/Auto"),
	["StopAuto"] = v16.remoteEvent("MillionaireTraitService/StopAuto"),
	["Lock"] = v16.remoteEvent("MillionaireTraitService/Lock")
}
local v_u_29 = {}
local v_u_30 = {}
local v31 = {}
local v_u_32 = {}
for _, v_u_33 in v21:QueryDescendants("Frame") do
	v_u_29[v_u_33.LayoutOrder] = v_u_33
	local v34 = Instance.new("Frame")
	v34.Size = v_u_33.Size
	v34.LayoutOrder = v_u_33.LayoutOrder
	v34.BackgroundTransparency = 1
	v34.ClipsDescendants = true
	v34.Parent = v21
	v_u_33.Size = UDim2.fromScale(0.95, 0.95)
	v_u_33.AnchorPoint = Vector2.new(0.5, 0.5)
	v_u_33.Position = UDim2.fromScale(0.5, 0.5)
	v_u_33.Parent = v34
	v_u_30[v_u_33.LayoutOrder] = {
		["play"] = function()
			-- upvalues: (copy) v_u_18, (copy) v_u_33
			v_u_18.target(v_u_33, 0.8, 5, {
				["Position"] = UDim2.fromScale(0.5, 0.5)
			})
		end,
		["reset"] = function()
			-- upvalues: (copy) v_u_18, (copy) v_u_33
			v_u_18.stop(v_u_33)
			v_u_18.target(v_u_33, 0.8, 5, {
				["Position"] = UDim2.fromScale(1.7, 0.5)
			})
		end
	}
end
local function v_u_35()
	-- upvalues: (copy) v_u_28, (copy) v_u_25
	v_u_28.StopAuto.fire()
	v_u_25.Visible = false
end
local function v_u_36()
	-- upvalues: (copy) v_u_32, (copy) v_u_17, (copy) v_u_25, (copy) v_u_24, (copy) v_u_28
	if #v_u_32 <= 0 then
		v_u_17.Notify({
			["Message"] = "You need atleast 1 Trait Selected",
			["Type"] = v_u_17.Types.Error
		})
	else
		v_u_25.Visible = true
		v_u_24.Visible = false
		v_u_28.Auto.fire(v_u_32)
	end
end
function v31.open(_)
	-- upvalues: (copy) v_u_18, (copy) v_u_19, (copy) v_u_26, (copy) v_u_30
	local v37 = {
		["Position"] = v_u_26,
		["Visible"] = true
	}
	v_u_18.target(v_u_19, 0.8, 5, v37)
	task.spawn(function()
		-- upvalues: (ref) v_u_30
		for _, v38 in v_u_30 do
			v38.play()
			task.wait(0.025)
		end
	end)
end
function v31.close(_)
	-- upvalues: (copy) v_u_18, (copy) v_u_19, (copy) v_u_27, (copy) v_u_28, (copy) v_u_25, (copy) v_u_30
	local v39 = {
		["Position"] = v_u_27,
		["Visible"] = false
	}
	v_u_18.target(v_u_19, 0.8, 5, v39)
	v_u_28.StopAuto.fire()
	v_u_25.Visible = false
	for _, v40 in v_u_30 do
		v40.reset()
	end
end
function v31.setupLocked(_)
	-- upvalues: (copy) v_u_19, (copy) v_u_28, (copy) v_u_4, (copy) v_u_6
	local v_u_41 = v_u_19.Lock
	v_u_41.Activated:Connect(function()
		-- upvalues: (ref) v_u_28
		v_u_28.Lock.fire()
	end)
	v_u_4:onSet({ "MillionaireTraits", "Locked" }, function(p42)
		-- upvalues: (copy) v_u_41, (ref) v_u_6
		v_u_41.ImageLabel.Image = ("rbxassetid://%*"):format(p42 and 134434974939221 or 76096090670932)
		v_u_41.UIGradient.Color = p42 and v_u_6.Blue.Gradient or v_u_6.Grey.Gradient
	end)
end
function v31.setupCurrency(_)
	-- upvalues: (copy) v_u_19, (copy) v_u_3, (copy) v_u_9, (copy) v_u_13
	local v_u_43 = v_u_19.Holder.Gems.TextLabel
	v_u_3:observe(v_u_9.Event1MStars, function(p44)
		-- upvalues: (copy) v_u_43, (ref) v_u_13
		v_u_43.Text = v_u_13.comma(p44)
	end)
end
function v31.setNone(_)
	-- upvalues: (copy) v_u_20
	v_u_20.Glow.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
	v_u_20.Current.Main.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
	v_u_20.Current.Main.Title.Text = "No Trait"
	v_u_20.Current.Main.Desc.Text = "Equip or Start Rolling to get a Trait!"
end
function v31.setupIndex(_)
	-- upvalues: (copy) v_u_22, (copy) v_u_8, (copy) v_u_13, (copy) v_u_15, (copy) v_u_10, (copy) v_u_23, (copy) v_u_18
	local v45 = v_u_22.Contents
	local v46 = v45.Template
	local v_u_47 = 0
	for _, v48 in v_u_8 do
		v_u_47 = v_u_47 + v48.Chance
	end
	local v_u_49 = {}
	for _, v50 in v_u_8 do
		local v51 = v46:Clone()
		v51.Visible = true
		v51.LayoutOrder = v50.Order
		v51.Parent = v45
		v51.Title.Text = v50.Name
		v51.Buffs.Text = v50.Description
		v51.UIGradient.Color = v50.Gradient
		if v50.Animated then
			v51.UIGradient:AddTag("Gradient")
		end
		if v50.Chance < 0.1 then
			local v52 = v51.Chance
			local v53 = v_u_13.abbreviateComma
			local v54 = 1 / v50.Chance
			v52.Text = ("1/%*"):format((v53((math.round(v54)))))
		else
			v51.Chance.Text = ("%*%%"):format((v_u_13.decimal(v50.Chance / v_u_47 * 100, 2)))
		end
		local v55 = {
			["textlabel"] = v51.Chance,
			["chance"] = v50.Chance
		}
		table.insert(v_u_49, v55)
	end
	local function v63()
		-- upvalues: (ref) v_u_15, (ref) v_u_10, (copy) v_u_49, (ref) v_u_47, (ref) v_u_13
		local v56 = v_u_15.get(v_u_10.MillionaireTraitsLuck) * v_u_15.get(v_u_10.MillionaireTraitsLuckMultiplier)
		local v57 = math.max(1, v56)
		for _, v58 in v_u_49 do
			local v59 = v58.chance * v57 / v_u_47 * 100
			if v_u_47 < v59 then
				v58.textlabel.Text = "Luck too high!"
			elseif v59 < 0.1 then
				local v60 = v58.textlabel
				local v61 = v_u_13.abbreviateComma
				local v62 = 100 / v59
				v60.Text = ("1/%*"):format((v61((math.round(v62)))))
			else
				v58.textlabel.Text = ("%*%%"):format((v_u_13.decimal(v59, 2)))
			end
		end
	end
	v63()
	v_u_15.observe(v_u_10.MillionaireTraitsLuck, v63)
	v_u_15.observe(v_u_10.MillionaireTraitsLuckMultiplier, v63)
	local v_u_64 = v_u_22.Position
	local v_u_65 = v_u_22.Size
	v_u_22.Visible = false
	v_u_23.Index.Activated:Connect(function()
		-- upvalues: (ref) v_u_22, (ref) v_u_18, (copy) v_u_64, (copy) v_u_65
		if v_u_22.Visible then
			v_u_18.target(v_u_22, 0.6, 5, {
				["Position"] = v_u_64 - UDim2.fromScale(0.2, 0),
				["Size"] = UDim2.fromScale(0, 0),
				["Visible"] = false
			})
		else
			local v66 = {
				["Position"] = v_u_64,
				["Size"] = v_u_65,
				["Visible"] = true
			}
			v_u_18.target(v_u_22, 0.6, 5, v66)
		end
	end)
	v46:Destroy()
end
function v31.setupAuto(_)
	-- upvalues: (copy) v_u_24, (copy) v_u_25, (copy) v_u_23, (copy) v_u_8, (copy) v_u_32, (copy) v_u_6, (copy) v_u_12, (copy) v_u_1, (copy) v_u_36, (copy) v_u_35
	local v67 = v_u_24.Contents
	local v68 = v67.Template
	v_u_25.Visible = false
	v_u_24.Visible = false
	v_u_24.Header.Close.Activated:Connect(function()
		-- upvalues: (ref) v_u_24
		v_u_24.Visible = false
	end)
	v_u_23.Auto.Activated:Connect(function()
		-- upvalues: (ref) v_u_24
		v_u_24.Visible = not v_u_24.Visible
	end)
	local v_u_69 = {}
	for v_u_70, v71 in v_u_8 do
		local v_u_72 = v68:Clone()
		v_u_72.Visible = true
		v_u_72.LayoutOrder = v71.Order
		v_u_72.Parent = v67
		v_u_72.Title.Text = v71.Name
		v_u_72.Title.UIGradient.Color = v71.Gradient
		v_u_69[v_u_70] = {
			["Selected"] = function(_)
				-- upvalues: (ref) v_u_32, (copy) v_u_70, (copy) v_u_72, (ref) v_u_6
				if not table.find(v_u_32, v_u_70) then
					local v73 = v_u_32
					local v74 = v_u_70
					table.insert(v73, v74)
				end
				v_u_72.Select.UIGradient.Color = v_u_6.Green.Gradient
				v_u_72.Select.UIStroke.Color = v_u_6.Green.Stroke
				v_u_72.Select.Cost.UIStroke.Color = v_u_6.Green.Stroke
				v_u_72.Select.Cost.Text = "Selected"
			end,
			["Deselect"] = function(_)
				-- upvalues: (ref) v_u_32, (copy) v_u_70, (copy) v_u_72, (ref) v_u_6
				local v75 = table.find(v_u_32, v_u_70)
				if v75 then
					table.remove(v_u_32, v75)
				end
				v_u_72.Select.UIGradient.Color = v_u_6.Grey.Gradient
				v_u_72.Select.UIStroke.Color = v_u_6.Grey.Stroke
				v_u_72.Select.Cost.UIStroke.Color = v_u_6.Grey.Stroke
				v_u_72.Select.Cost.Text = "Deselected"
			end,
			["Toggle"] = function(p76)
				-- upvalues: (ref) v_u_32, (copy) v_u_70
				if table.find(v_u_32, v_u_70) then
					p76:Deselect()
				else
					p76:Selected()
				end
			end
		}
		v_u_69[v_u_70]:Deselect()
		v_u_72.Select.Activated:Connect(function()
			-- upvalues: (copy) v_u_69, (copy) v_u_70
			v_u_69[v_u_70]:Toggle()
		end)
	end
	v_u_12.observeAttribute(v_u_1.LocalPlayer, "MillionaireAutoTrait", function(p77)
		-- upvalues: (ref) v_u_25
		if p77 then
			v_u_25.Visible = true
		else
			v_u_25.Visible = false
		end
	end)
	v_u_24.Start.Activated:Connect(v_u_36)
	v_u_25.Activated:Connect(v_u_35)
	v68:Destroy()
end
function v31.setupInventory(_)
	-- upvalues: (copy) v_u_19, (copy) v_u_23, (copy) v_u_8, (copy) v_u_28, (copy) v_u_6, (copy) v_u_5
	local v_u_78 = v_u_19.Inventory
	local v79 = v_u_78.Contents
	local v80 = v79.Template
	v_u_78.Visible = false
	v_u_78.Header.Close.Activated:Connect(function()
		-- upvalues: (copy) v_u_78
		v_u_78.Visible = false
	end)
	v_u_23.Inventory.Activated:Connect(function()
		-- upvalues: (copy) v_u_78
		v_u_78.Visible = not v_u_78.Visible
	end)
	local v_u_81 = {}
	local v82 = nil
	for v_u_83, v84 in v_u_8 do
		local v_u_85 = v80:Clone()
		v_u_85.Visible = true
		v_u_85.LayoutOrder = v84.Order
		v_u_85.Parent = v79
		v_u_85.Title.Text = v84.Name
		v_u_85.Desc.Text = v84.Description
		v_u_85.UIGradient.Color = v84.Gradient
		if v84.Animated then
			v_u_85.UIGradient:AddTag("Gradient")
		end
		v_u_85.Equip.Activated:Connect(function()
			-- upvalues: (ref) v_u_28, (copy) v_u_83
			v_u_28.Equip.invoke(v_u_83)
		end)
		v_u_81[v_u_83] = {
			["Lock"] = function()
				-- upvalues: (copy) v_u_85
				v_u_85.Locked.Visible = true
			end,
			["Unlock"] = function()
				-- upvalues: (copy) v_u_85
				v_u_85.Locked.Visible = false
			end,
			["Equip"] = function()
				-- upvalues: (copy) v_u_85, (ref) v_u_6
				v_u_85.Equip.UIGradient.Color = v_u_6.Green.Gradient
				v_u_85.Equip.UIStroke.Color = v_u_6.Green.Stroke
				v_u_85.Equip.Cost.UIStroke.Color = v_u_6.Green.Stroke
				v_u_85.Equip.Cost.Text = "Equipped"
			end,
			["Unequip"] = function()
				-- upvalues: (copy) v_u_85, (ref) v_u_6
				v_u_85.Equip.UIGradient.Color = v_u_6.Grey.Gradient
				v_u_85.Equip.UIStroke.Color = v_u_6.Grey.Stroke
				v_u_85.Equip.Cost.UIStroke.Color = v_u_6.Grey.Stroke
				v_u_85.Equip.Cost.Text = "Equip"
			end
		}
		v_u_81[v_u_83]:Unequip()
		v_u_81[v_u_83]:Lock()
	end
	for v86, v87 in v_u_5.Storage do
		if v_u_81[v86] and v87 > 0 then
			v_u_81[v86]:Unlock()
		end
	end
	local v_u_88 = v_u_5:getEquipped()
	if v_u_88 and v_u_81[v_u_88] then
		v_u_81[v_u_88]:Equip()
	else
		v_u_88 = v82
	end
	v_u_5.OnEquipped:Connect(function(p89)
		-- upvalues: (ref) v_u_88, (copy) v_u_81
		if v_u_88 then
			v_u_81[v_u_88]:Unequip()
			v_u_88 = nil
		end
		if p89 and v_u_81[p89] then
			v_u_81[p89]:Equip()
			v_u_88 = p89
		end
	end)
	v_u_5.OnStorageUpdated:Connect(function(p90, p91)
		-- upvalues: (copy) v_u_81
		if v_u_81[p90] then
			if p91 and p91 > 0 then
				v_u_81[p90]:Unlock()
				return
			end
			v_u_81[p90]:Lock()
		end
	end)
	v80:Destroy()
end
function v31.equip(_, p92)
	-- upvalues: (copy) v_u_8, (copy) v_u_20
	local v93 = v_u_8[p92]
	if v93 then
		v_u_20.Glow.UIGradient.Color = v93.Gradient
		v_u_20.Current.Main.Title.Text = v93.Name
		v_u_20.Current.Main.Desc.Text = v93.Description
		if v93.Animated then
			v_u_20.Current.Main.UIGradient:RemoveTag("Gradient")
			v_u_20.Current.Main.UIGradient:AddTag("Gradient")
		else
			v_u_20.Current.Main.UIGradient:RemoveTag("Gradient")
		end
		v_u_20.Current.Main.UIGradient.Color = v93.Gradient
	end
end
function v31.setupEquip(p_u_94)
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local function v96(p95)
		-- upvalues: (copy) p_u_94
		if p95 then
			p_u_94:equip(p95)
		else
			p_u_94:setNone()
		end
	end
	local v97 = v_u_4:getValue({ "MillionaireTraits", "Equipped" })
	if v97 then
		p_u_94:equip(v97)
	else
		p_u_94:setNone()
	end
	v_u_5.OnEquipped:Connect(v96)
end
function v31.setupProducts(_)
	-- upvalues: (copy) v_u_29, (copy) v_u_11, (copy) v_u_7, (copy) v_u_14, (copy) v_u_13
	for v98, v_u_99 in v_u_29 do
		local v_u_100 = v_u_11.Event1MStars[v98]
		local v101 = v_u_7[v_u_100]
		v_u_99.Purchase.Price.Text = "..."
		v_u_14.ObserveProduct(v_u_100, function(p102)
			-- upvalues: (copy) v_u_99, (ref) v_u_13
			v_u_99.Purchase.Price.Text = v_u_13.robux(v_u_13.comma(p102.PriceInRobux))
		end)
		v_u_99.TextLabel.Text = v_u_13.comma(v101)
		v_u_99.Purchase.Activated:Connect(function()
			-- upvalues: (ref) v_u_14, (copy) v_u_100
			v_u_14.PromptProduct(v_u_100)
		end)
	end
end
function v31.init(p103)
	-- upvalues: (copy) v_u_28, (copy) v_u_35, (copy) v_u_23, (copy) v_u_17
	p103:setupLocked()
	p103:setupCurrency()
	p103:setupIndex()
	p103:setupAuto()
	p103:setupInventory()
	p103:setupEquip()
	p103:setupProducts()
	v_u_28.StopAuto.listen(v_u_35)
	v_u_23.Roll.Activated:Connect(function()
		-- upvalues: (ref) v_u_28, (ref) v_u_17
		local v104, v105 = v_u_28.Roll.invoke()
		if not v104 then
			v_u_17.Notify({
				["Message"] = v105,
				["Type"] = v_u_17.Types.Error
			})
		end
	end)
end
return v31]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MillionaireTraits]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3784"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Currency.CurrencyController)
local v_u_3 = require(v1.Client.Gameplay.Event1M.AscensionController)
local v4 = require(v1.Config.CurrencyData)
local v_u_5 = require(v1.Enums.CurrencyTypes)
local v_u_6 = require(v1.Utility.AscensionUtil)
local v_u_7 = require(v1.Utility.Format)
local v8 = require(v1.Utility.Network)
local v_u_9 = require(v1.Utility.Notify)
local v_u_10 = require(v1.Utility.Spring)
local v11 = {}
local v_u_12 = require(v1.Utility.UI):get("Gui", "Ascension").Container
local v_u_13 = v_u_12.Position
local v_u_14 = v_u_13 + UDim2.fromScale(0, 1)
local v_u_15 = v4[v_u_5.Event1MBalloon]
local v_u_16 = {
	["Ascend"] = v8.remoteFunction("AscensionService/ascend")
}
function v11.open(_)
	-- upvalues: (copy) v_u_10, (copy) v_u_12, (copy) v_u_13
	local v17 = {
		["Position"] = v_u_13,
		["Visible"] = true
	}
	v_u_10.target(v_u_12, 0.8, 5, v17)
end
function v11.close(_)
	-- upvalues: (copy) v_u_10, (copy) v_u_12, (copy) v_u_14
	local v18 = {
		["Position"] = v_u_14,
		["Visible"] = false
	}
	v_u_10.target(v_u_12, 0.8, 5, v18)
end
function v11.updateProgress(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_3, (copy) v_u_6, (copy) v_u_7, (copy) v_u_12, (copy) v_u_15
	local v19 = v_u_2:get(v_u_5.Event1MBalloon)
	local v20 = v_u_3:get()
	local v21 = v_u_6.getPrice(v20 + 1)
	local v22 = v_u_7.abbreviateComma(v19)
	local v23 = v_u_7.abbreviateComma(v21)
	local v24 = v19 / v21
	local v25 = math.clamp(v24, 0, 1)
	v_u_12.Container.Progress.UIGradient.Offset = Vector2.new(v25, 0)
	v_u_12.Container.Progress.Title.Text = ("%* / %* %*"):format(v22, v23, (v_u_15.GetPrefix(v21)))
end
function v11.updateMultipliers(_)
	-- upvalues: (copy) v_u_12, (copy) v_u_3, (copy) v_u_6, (copy) v_u_7
	local v26 = v_u_12.Container.Top
	local v27 = v_u_3:get()
	local v28 = v_u_6.getMultiplier(v27)
	local v29 = v_u_6.getMultiplier(v27 + 1)
	v26.Left.Benefits.Template.Text = ("x%* Balloon Multiplier"):format((v_u_7.abbreviate((math.floor(v28)))))
	v26.Right.Benefits.Template.Text = ("x%* Balloon Multiplier"):format((v_u_7.abbreviate((math.floor(v29)))))
end
function v11.init(p_u_30)
	-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_3, (copy) v_u_12, (copy) v_u_16, (copy) v_u_9
	v_u_2:observe(v_u_5.Event1MBalloon, function()
		-- upvalues: (copy) p_u_30
		p_u_30:updateProgress()
	end)
	v_u_3:observe(function()
		-- upvalues: (copy) p_u_30
		p_u_30:updateProgress()
		p_u_30:updateMultipliers()
	end)
	v_u_12.Container.Robux.Activated:Connect(function()
		-- upvalues: (ref) v_u_16, (ref) v_u_9
		local v31, v32 = v_u_16.Ascend:invoke()
		v_u_9.Notify({
			["Message"] = v32,
			["Type"] = v31 and v_u_9.Types.Success or v_u_9.Types.Error
		})
	end)
end
return v11]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Ascension]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="3785"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

game:GetService("MarketplaceService")
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Client.Data.DataController)
local v_u_3 = require(v1.Config.MultiplierData)
local v_u_4 = require(v1.Config.PetAttributeData)
local v_u_5 = require(v1.Config.PetSlimeData)
local v_u_6 = require(v1.Config.SlimeRaceData)
local v7 = require(v1.Enums.MultiplierTypes)
local v_u_8 = require(v1.Enums.PetAttributeTypes)
local v_u_9 = require(v1.Functions.CalculatePetXP)
local v_u_10 = require(v1.Config.Constants)
local v_u_11 = require(v1.Enums.Products)
local v12 = require(v1.Packages.Janitor)
local v_u_13 = require(v1.Utility.Format)
local v_u_14 = require(v1.Utility.Marketplace)
local v_u_15 = require(v1.Utility.Multiplier)
local v16 = require(v1.Utility.Network)
local v_u_17 = require(v1.Utility.Spring)
local v18 = {}
local v_u_19 = require(v1.Utility.UI):get("Gui", "MySlime").Container
local v_u_20 = v_u_19.Container
local v_u_21 = v_u_19.Position
local v_u_22 = v_u_21 + UDim2.fromScale(0, 0.2)
local v_u_23 = v16.remoteEvent("PetCombatService/ModeToggle")
local v_u_24 = v16.remoteFunction("PetCombatService/AttributeUpgrade")
local v_u_25 = v16.remoteFunction("PetCombatService/AttributeReset")
local v_u_26 = v12.new()
local v_u_27 = nil
local v_u_28 = nil
function v18.open(_)
	-- upvalues: (copy) v_u_17, (copy) v_u_19, (copy) v_u_21, (ref) v_u_27, (ref) v_u_28
	local v29 = {
		["Position"] = v_u_21,
		["Visible"] = true
	}
	v_u_17.target(v_u_19, 0.8, 5, v29)
	if v_u_27 then
		v_u_27()
	end
	if v_u_28 then
		v_u_28()
	end
end
function v18.close(_)
	-- upvalues: (copy) v_u_17, (copy) v_u_19, (copy) v_u_22
	local v30 = {
		["Position"] = v_u_22,
		["Visible"] = false
	}
	v_u_17.target(v_u_19, 0.8, 5, v30)
end
local v_u_31 = {
	[v_u_8.PetAttackSpeed] = v7.PetAttackSpeed,
	[v_u_8.PetDamage] = v7.PetDamagePercent,
	[v_u_8.PetAgility] = v7.PetAgility,
	[v_u_8.PetCoinMultiplier] = v7.PetCoinMultiplier,
	[v_u_8.PetRange] = v7.PetRange,
	[v_u_8.PetCritChance] = v7.PetCritChance
}
function v18.setupMainSlimePage(_)
	-- upvalues: (copy) v_u_20, (copy) v_u_8, (copy) v_u_31, (copy) v_u_3, (copy) v_u_15, (copy) v_u_4, (copy) v_u_2, (copy) v_u_13, (copy) v_u_10, (copy) v_u_9, (copy) v_u_6, (ref) v_u_27, (copy) v_u_26, (copy) v_u_5, (copy) v_u_17, (copy) v_u_23
	local v32 = v_u_20.Slime
	local v_u_33 = v32.CanvasGroup.ViewportFrame
	local v_u_34 = v32.Toggle.Toggle
	local v35 = v32.Template
	v35.Visible = false
	local v_u_36 = {
		{
			["name"] = "Level",
			["order"] = 1
		},
		{
			["name"] = "Age",
			["order"] = 2
		},
		{
			["name"] = "Race",
			["order"] = 3
		},
		{
			["name"] = "Damage",
			["order"] = 4,
			["attr"] = v_u_8.PetDamage
		},
		{
			["name"] = "Range",
			["order"] = 5,
			["attr"] = v_u_8.PetRange
		},
		{
			["name"] =