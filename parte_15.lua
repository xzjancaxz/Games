v_u_200, false, v_u_65, Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Left, Enum.KeyCode.Right)
			v_u_12:BindActionAtPriority("FreecamGamepadControlSpeed", v_u_203, false, v_u_65, Enum.KeyCode.DPadUp, Enum.KeyCode.DPadDown, Enum.KeyCode.DPadLeft, Enum.KeyCode.DPadRight)
		else
			v_u_12:BindActionAtPriority("FreecamKeyboard", v_u_200, false, v_u_65, Enum.KeyCode.W, Enum.KeyCode.U, Enum.KeyCode.A, Enum.KeyCode.H, Enum.KeyCode.S, Enum.KeyCode.J, Enum.KeyCode.D, Enum.KeyCode.K, Enum.KeyCode.E, Enum.KeyCode.I, Enum.KeyCode.Q, Enum.KeyCode.Y, Enum.KeyCode.Up, Enum.KeyCode.Down)
		end
		if v_u_45 then
			v_u_12:BindActionAtPriority("FreecamKeyboardTiltControl", v_u_200, false, v_u_65, Enum.KeyCode.Z, Enum.KeyCode.C)
			v_u_12:BindActionAtPriority("FreecamGamepadTiltControl", v_u_203, false, v_u_65, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
			v_u_12:BindActionAtPriority("FreecamKeyboardTiltControlSpeed", v_u_200, false, v_u_65, Enum.KeyCode.Comma, Enum.KeyCode.Period)
			if v_u_48 then
				v_u_12:BindActionAtPriority("FreecamKeyboardSmoothnessControl", v_u_200, false, v_u_65, Enum.KeyCode.LeftBracket, Enum.KeyCode.RightBracket, Enum.KeyCode.Semicolon, Enum.KeyCode.Quote, Enum.KeyCode.V, Enum.KeyCode.B, Enum.KeyCode.N, Enum.KeyCode.M)
			end
		end
		if v_u_54 then
			v_u_12:BindActionAtPriority("FreecamKeyboardDoFToggle", v_u_200, false, v_u_65, Enum.KeyCode.BackSlash)
			v_u_12:BindActionAtPriority("FreecamKeyboardDoFControls", v_u_200, false, v_u_65, Enum.KeyCode.Minus, Enum.KeyCode.Equals)
		end
		if v_u_57 then
			v_u_12:BindActionAtPriority("FreecamKeyboardPlayerLockToggle", v_u_200, false, v_u_65, Enum.KeyCode.Slash)
			v_u_12:BindActionAtPriority("FreecamKeyboardPlayerLockSwitch", v_u_200, false, v_u_65, Enum.KeyCode.R, Enum.KeyCode.T)
		end
		if v_u_63 then
			v_u_12:BindActionAtPriority("FreecamKeyboardCustomGuiToggle", v_u_200, false, v_u_65, Enum.KeyCode.G)
			v_u_12:BindActionAtPriority("FreecamKeyboardPlayerGuiToggle", v_u_200, false, v_u_65, Enum.KeyCode.X)
			v_u_12:BindActionAtPriority("FreecamKeyboardLeaderboardToggle", v_u_200, false, v_u_65, Enum.KeyCode.L)
		end
		v_u_12:BindActionAtPriority("FreecamMousePan", v_u_206, false, v_u_65, Enum.UserInputType.MouseMovement)
		v_u_12:BindActionAtPriority("FreecamMouseWheel", v_u_212, false, v_u_65, Enum.UserInputType.MouseWheel)
		v_u_12:BindActionAtPriority("FreecamGamepadButton", v_u_203, false, v_u_65, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY)
		v_u_12:BindActionAtPriority("FreecamGamepadTrigger", v_u_210, false, v_u_65, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonL2)
		v_u_12:BindActionAtPriority("FreecamGamepadThumbstick", v_u_208, false, v_u_65, Enum.KeyCode.Thumbstick1, Enum.KeyCode.Thumbstick2)
	end
	function v_u_122.StopCapture()
		-- upvalues: (ref) v_u_63, (ref) v_u_132, (ref) v_u_42, (ref) v_u_134, (ref) v_u_45, (ref) v_u_133, (copy) v_u_125, (copy) v_u_126, (copy) v_u_127, (copy) v_u_12, (ref) v_u_48, (ref) v_u_54, (ref) v_u_57
		if not v_u_63 then
			v_u_132 = 1
			if v_u_42 then
				v_u_134 = 1
			end
			if v_u_45 then
				v_u_133 = 1
			end
		end
		local v213 = v_u_125
		for v214, v215 in pairs(v213) do
			v213[v214] = v215 * 0
		end
		local v216 = v_u_126
		for v217, v218 in pairs(v216) do
			v216[v217] = v218 * 0
		end
		local v219 = v_u_127
		for v220, v221 in pairs(v219) do
			v219[v220] = v221 * 0
		end
		v_u_12:UnbindAction("FreecamKeyboard")
		if v_u_42 then
			v_u_12:UnbindAction("FreecamKeyboardControlSpeed")
			v_u_12:UnbindAction("FreecamGamepadControlSpeed")
		end
		if v_u_45 then
			v_u_12:UnbindAction("FreecamKeyboardTiltControl")
			v_u_12:UnbindAction("FreecamGamepadTiltControl")
			v_u_12:UnbindAction("FreecamKeyboardTiltControlSpeed")
			if v_u_48 then
				v_u_12:UnbindAction("FreecamKeyboardSmoothnessControl")
			end
		end
		if v_u_54 then
			v_u_12:UnbindAction("FreecamKeyboardDoFToggle")
			v_u_12:UnbindAction("FreecamKeyboardDoFControls")
		end
		if v_u_57 then
			v_u_12:UnbindAction("FreecamKeyboardPlayerLockToggle")
			v_u_12:UnbindAction("FreecamKeyboardPlayerLockSwitch")
		end
		if v_u_63 then
			v_u_12:UnbindAction("FreecamKeyboardCustomGuiToggle")
			v_u_12:UnbindAction("FreecamKeyboardPlayerGuiToggle")
			v_u_12:UnbindAction("FreecamKeyboardLeaderboardToggle")
		end
		v_u_12:UnbindAction("FreecamMousePan")
		v_u_12:UnbindAction("FreecamMouseWheel")
		v_u_12:UnbindAction("FreecamGamepadButton")
		v_u_12:UnbindAction("FreecamGamepadTrigger")
		v_u_12:UnbindAction("FreecamGamepadThumbstick")
	end
	function v_u_122.getNavSpeed()
		-- upvalues: (ref) v_u_132
		return v_u_132
	end
	function v_u_122.getFovSpeed()
		-- upvalues: (ref) v_u_134
		return v_u_134
	end
	function v_u_122.getRollSpeed()
		-- upvalues: (ref) v_u_133
		return v_u_133
	end
	local function v_u_250(p222)
		-- upvalues: (ref) v_u_48, (copy) v_u_122, (ref) v_u_54, (ref) v_u_25, (copy) v_u_118, (copy) v_u_119, (copy) v_u_120, (ref) v_u_45, (copy) v_u_121, (ref) v_u_117, (copy) v_u_8, (copy) v_u_11, (copy) v_u_10, (copy) v_u_6, (copy) v_u_75, (ref) v_u_116, (ref) v_u_115, (ref) v_u_57, (ref) v_u_88, (ref) v_u_93, (ref) v_u_89, (ref) v_u_90, (ref) v_u_63, (ref) v_u_26, (ref) v_u_22, (ref) v_u_76, (ref) v_u_77, (ref) v_u_78, (ref) v_u_79, (ref) v_u_42, (ref) v_u_91, (ref) v_u_92, (ref) v_u_23
		if v_u_48 then
			v_u_122.SpringControl(p222)
		end
		if v_u_54 and (v_u_25 and v_u_25.Parent) then
			v_u_122.DoF(p222)
		end
		local v223 = v_u_118:Update(p222, v_u_122.Vel(p222))
		local v224 = v_u_119:Update(p222, v_u_122.Pan(p222))
		local v225 = v_u_120:Update(p222, v_u_122.Fov(p222))
		local v226
		if v_u_45 then
			v226 = v_u_121:Update(p222, v_u_122.Roll(p222))
		else
			v226 = nil
		end
		local v227 = v_u_10(0.7002075382097097 / v_u_11((v_u_8(v_u_117 / 2))))
		v_u_117 = v_u_6(v_u_117 + v225 * 300 * (p222 / v227), 1, 120)
		local v228
		if v_u_45 then
			local v229 = v224 * v_u_75 * (p222 / v227)
			local v230 = v_u_116
			local v231 = v229.X
			local v232 = v229.Y
			local v233 = v226 * -1.5707963267948966 * (p222 / v227)
			v_u_116 = v230 + Vector3.new(v231, v232, v233)
			if v_u_48 then
				local v234 = v_u_116.x % 6.283185307179586
				local v235 = v_u_116.y % 6.283185307179586
				local v236 = v_u_116.z % 6.283185307179586
				v_u_116 = Vector3.new(v234, v235, v236)
			else
				local v237 = v_u_6(v_u_116.x, -1.5707963267948966, 1.5707963267948966)
				local v238 = v_u_116.y % 6.283185307179586
				local v239 = v_u_116.z
				v_u_116 = Vector3.new(v237, v238, v239)
			end
			v228 = CFrame.new(v_u_115) * CFrame.fromOrientation(v_u_116.x, v_u_116.y, v_u_116.z) * CFrame.new(v223 * Vector3.new(64, 64, 64) * p222)
		else
			v_u_116 = v_u_116 + v224 * v_u_75 * (p222 / v227)
			v_u_116 = Vector2.new(v_u_6(v_u_116.x, -1.5707963267948966, 1.5707963267948966), v_u_116.y % 6.283185307179586)
			v228 = CFrame.new(v_u_115) * CFrame.fromOrientation(v_u_116.x, v_u_116.y, 0) * CFrame.new(v223 * Vector3.new(64, 64, 64) * p222)
		end
		if v_u_57 and (v_u_88 and v_u_93) then
			local v240 = v223.Z * 64 * p222
			local v241 = v223.Y * 64 * p222
			v_u_89 = v_u_6(v_u_89 + v240, 5, 50)
			v_u_90 = v_u_6(v_u_90 + v241, -10, 10)
			local v242 = v_u_90
			local v243 = CFrame.new(v_u_93.Position + Vector3.new(0, v242, 0))
			local v244
			if v_u_45 then
				v244 = CFrame.fromOrientation(v_u_116.x, v_u_116.y, v_u_116.z)
			else
				v244 = CFrame.fromOrientation(v_u_116.x, v_u_116.y, 0)
			end
			v228 = v243 * v244 * CFrame.new(0, 0, v_u_89)
		end
		if v_u_63 and (v_u_26 and (v_u_26.Parent and (v_u_22 and (v_u_22.Parent and v_u_22.Enabled)))) then
			local v245 = ""
			if p222 > 0 then
				local v246 = (v228.p - v_u_115) / p222
				v245 = v245 .. string.format("Velocity: (%.1f, %.1f, %.1f)\n", v246.X, v246.Y, v246.Z)
			end
			local v247 = v245 .. string.format("FOV: %.1f\n", v_u_117)
			if v_u_45 then
				local v248 = string.format
				local v249 = v_u_116.z
				v247 = v247 .. v248("Tilt: %.1f\194\176\n", (math.deg(v249)))
			end
			if v_u_48 then
				v247 = (((v247 .. string.format("Stiffness (Vel): %.1f\n", v_u_76)) .. string.format("Stiffness (Pan): %.1f\n", v_u_77)) .. string.format("Stiffness (FOV): %.1f\n", v_u_78)) .. string.format("Stiffness (Roll): %.1f\n", v_u_79)
			end
			if v_u_42 then
				v247 = ((v247 .. string.format("Movement Speed: %.1f\n", v_u_122.getNavSpeed())) .. string.format("Zoom Speed: %.1f\n", v_u_122.getFovSpeed())) .. string.format("Tilt Speed: %.1f\n", v_u_122.getRollSpeed())
			end
			if v_u_54 then
				if v_u_25 and (v_u_25.Parent and v_u_25.Enabled) then
					v247 = ((((v247 .. string.format("Custom Depth Of Field: On\n")) .. string.format("Custom Depth Of Field Near Intensity: %.1f\n", v_u_25.NearIntensity)) .. string.format("Custom Depth Of Field Far Intensity: %.1f\n", v_u_25.FarIntensity)) .. string.format("Custom Depth Of Field Focus Distance: %.1f\n", v_u_25.FocusDistance)) .. string.format("Custom Depth Of Field Focus Radius: %.1f\n", v_u_25.InFocusRadius)
				else
					v247 = v247 .. string.format("Custom Depth Of Field: Off\n")
				end
			end
			if v_u_57 then
				if v_u_88 and #v_u_91 > 0 then
					v247 = v247 .. string.format("Player Lock: %s\n", v_u_91[v_u_92].Name)
				else
					v247 = v247 .. string.format("Player Lock: Off\n")
				end
			end
			v_u_26.Text = v247
		end
		v_u_115 = v228.p
		v_u_23.CFrame = v228
		v_u_23.Focus = v228
		v_u_23.FieldOfView = v_u_117
	end
	local v_u_251 = {}
	local v_u_252 = nil
	local v_u_253 = nil
	local v_u_254 = nil
	local v_u_255 = nil
	local v_u_256 = nil
	local v_u_257 = nil
	local v_u_258 = {}
	local v_u_259 = {
		["Backpack"] = true,
		["Chat"] = true,
		["Health"] = true,
		["PlayerList"] = true
	}
	local v_u_260 = {
		["BadgesNotificationsActive"] = true,
		["PointsNotificationsActive"] = true
	}
	function v_u_251.Push()
		-- upvalues: (copy) v_u_259, (copy) v_u_15, (copy) v_u_260, (ref) v_u_20, (ref) v_u_258, (ref) v_u_39, (ref) v_u_83, (ref) v_u_63, (ref) v_u_94, (ref) v_u_257, (ref) v_u_23, (ref) v_u_254, (ref) v_u_256, (ref) v_u_255, (ref) v_u_253, (copy) v_u_16, (ref) v_u_30, (copy) v_u_13, (copy) v_u_18, (ref) v_u_252
		for v261 in pairs(v_u_259) do
			v_u_259[v261] = v_u_15:GetCoreGuiEnabled(Enum.CoreGuiType[v261])
			v_u_15:SetCoreGuiEnabled(Enum.CoreGuiType[v261], false)
		end
		for v262 in pairs(v_u_260) do
			v_u_260[v262] = v_u_15:GetCore(v262)
			v_u_15:SetCore(v262, false)
		end
		local v263 = v_u_20:FindFirstChildOfClass("PlayerGui")
		if v263 then
			for _, v264 in pairs(v263:GetChildren()) do
				if v264:IsA("ScreenGui") and v264.Enabled then
					v_u_258[#v_u_258 + 1] = v264
					v264.Enabled = false
				end
			end
			if v_u_39 then
				v_u_83 = v263.ChildAdded:Connect(function(p265)
					-- upvalues: (ref) v_u_258, (ref) v_u_63, (ref) v_u_94
					if p265:IsA("ScreenGui") and p265.Enabled then
						v_u_258[#v_u_258 + 1] = p265
						if v_u_63 then
							p265.Enabled = v_u_94
							return
						end
						p265.Enabled = false
					end
				end)
			end
		end
		v_u_257 = v_u_23.FieldOfView
		v_u_23.FieldOfView = 70
		v_u_254 = v_u_23.CameraType
		v_u_23.CameraType = Enum.CameraType.Custom
		v_u_256 = v_u_23.CFrame
		v_u_255 = v_u_23.Focus
		v_u_253 = v_u_16.MouseIconEnabled
		v_u_16.MouseIconEnabled = false
		if v_u_30 then
			local v266 = v_u_13.LocalPlayer.DevEnableMouseLock
			local v267 = v_u_13.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable
			local v268 = v266 and (v_u_18.ControlMode == Enum.ControlMode.MouseLockSwitch and v_u_18.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove)
			if v268 then
				v268 = not v267
			end
			if v268 then
				v_u_252 = Enum.MouseBehavior.Default
				::l31::
				v_u_16.MouseBehavior = Enum.MouseBehavior.Default
				return
			end
		end
		v_u_252 = v_u_16.MouseBehavior
		goto l31
	end
	function v_u_251.Pop()
		-- upvalues: (copy) v_u_259, (copy) v_u_15, (copy) v_u_260, (ref) v_u_258, (ref) v_u_63, (ref) v_u_22, (ref) v_u_39, (ref) v_u_83, (ref) v_u_23, (ref) v_u_257, (ref) v_u_254, (ref) v_u_256, (ref) v_u_255, (copy) v_u_16, (ref) v_u_253, (ref) v_u_252
		for v269, v270 in pairs(v_u_259) do
			v_u_15:SetCoreGuiEnabled(Enum.CoreGuiType[v269], v270)
		end
		for v271, v272 in pairs(v_u_260) do
			v_u_15:SetCore(v271, v272)
		end
		for _, v273 in pairs(v_u_258) do
			if v_u_63 then
				if v273.Parent and v273 ~= v_u_22 then
					v273.Enabled = true
				end
			elseif v273.Parent then
				v273.Enabled = true
			end
		end
		if v_u_39 then
			if v_u_83 then
				v_u_83:Disconnect()
				v_u_83 = nil
			end
			v_u_258 = {}
		end
		v_u_23.FieldOfView = v_u_257
		v_u_257 = nil
		v_u_23.CameraType = v_u_254
		v_u_254 = nil
		v_u_23.CFrame = v_u_256
		v_u_256 = nil
		v_u_23.Focus = v_u_255
		v_u_255 = nil
		v_u_16.MouseIconEnabled = v_u_253
		v_u_253 = nil
		v_u_16.MouseBehavior = v_u_252
		v_u_252 = nil
	end
	function v_u_251.getScreenGuis()
		-- upvalues: (ref) v_u_258
		return v_u_258
	end
	local function v_u_277(p274)
		-- upvalues: (ref) v_u_91, (ref) v_u_92, (ref) v_u_88
		for v275, v276 in ipairs(v_u_91) do
			if v276 == p274 then
				table.remove(v_u_91, v275)
				if v_u_92 == v275 and v_u_88 then
					v_u_88 = false
					v_u_92 = 1
				end
				if v275 < v_u_92 then
					v_u_92 = v_u_92 - 1
				end
				if v_u_92 > #v_u_91 or v_u_92 < 1 then
					v_u_92 = 1
					return
				end
				break
			end
		end
	end
	local function v_u_282()
		-- upvalues: (ref) v_u_91, (copy) v_u_13, (ref) v_u_20, (ref) v_u_92, (ref) v_u_86, (ref) v_u_87, (copy) v_u_277
		v_u_91 = v_u_13:GetPlayers()
		for v278, v279 in ipairs(v_u_91) do
			if v279 == v_u_20 then
				v_u_92 = v278
				break
			end
		end
		v_u_86 = v_u_13.PlayerAdded:Connect(function(p280)
			-- upvalues: (ref) v_u_91
			local v281 = v_u_91
			table.insert(v281, p280)
		end)
		v_u_87 = v_u_13.PlayerRemoving:Connect(v_u_277)
	end
	local function v_u_284()
		-- upvalues: (ref) v_u_57, (copy) v_u_282, (ref) v_u_51, (ref) v_u_33, (ref) v_u_23, (ref) v_u_45, (ref) v_u_116, (ref) v_u_115, (ref) v_u_117, (copy) v_u_118, (copy) v_u_119, (copy) v_u_120, (copy) v_u_121, (ref) v_u_63, (ref) v_u_48, (ref) v_u_76, (ref) v_u_77, (ref) v_u_78, (ref) v_u_79, (ref) v_u_21, (ref) v_u_20, (ref) v_u_22, (ref) v_u_26, (ref) v_u_251, (ref) v_u_54, (ref) v_u_25, (copy) v_u_14, (copy) v_u_250, (copy) v_u_122
		if v_u_57 then
			v_u_282()
		end
		if not v_u_51 and v_u_33 then
			script:SetAttribute("FreecamEnabled", true)
		end
		local v283 = v_u_23.CFrame
		if v_u_45 then
			v_u_116 = Vector3.new(v283:toEulerAnglesYXZ())
		else
			v_u_116 = Vector2.new(v283:toEulerAnglesYXZ())
		end
		v_u_115 = v283.p
		v_u_117 = v_u_23.FieldOfView
		v_u_118:Reset((Vector3.new()))
		v_u_119:Reset(Vector2.new())
		v_u_120:Reset(0)
		if v_u_45 then
			v_u_121:Reset(0)
		end
		if not v_u_63 and v_u_48 then
			v_u_76 = 1.5
			v_u_77 = 1
			v_u_78 = 4
			v_u_79 = 1
		end
		if v_u_63 then
			v_u_21 = v_u_20:WaitForChild("PlayerGui")
			v_u_22 = v_u_21:WaitForChild("Freecam")
			if not (v_u_26 and v_u_26.Parent) then
				v_u_26 = Instance.new("TextLabel")
				v_u_26.Name = "FreecamCustomGui"
				v_u_26.TextColor3 = Color3.new(1, 1, 1)
				v_u_26.Font = Enum.Font.SourceSansBold
				v_u_26.TextSize = 20
				v_u_26.TextStrokeTransparency = 0
				v_u_26.BackgroundTransparency = 1
				v_u_26.TextWrapped = true
				v_u_26.TextXAlignment = Enum.TextXAlignment.Right
				v_u_26.AutomaticSize = Enum.AutomaticSize.Y
				v_u_26.AnchorPoint = Vector2.new(1, 1)
				v_u_26.Position = UDim2.new(1, -10, 1, -10)
				v_u_26.Size = UDim2.new(0, 400, 0, 0)
				v_u_26.Parent = v_u_22
			end
		end
		v_u_251.Push()
		if v_u_54 and not (v_u_25 and v_u_25.Parent) then
			v_u_25 = Instance.new("DepthOfFieldEffect")
			v_u_25.Enabled = false
			v_u_25.Name = "FreecamDepthOfField"
			v_u_25.Parent = v_u_23
		end
		v_u_14:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, v_u_250)
		v_u_122.StartCapture()
	end
	local function v_u_286()
		-- upvalues: (ref) v_u_51, (ref) v_u_33, (ref) v_u_57, (ref) v_u_86, (ref) v_u_87, (ref) v_u_88, (ref) v_u_92, (ref) v_u_91, (ref) v_u_54, (ref) v_u_25, (ref) v_u_82, (ref) v_u_84, (ref) v_u_85, (ref) v_u_63, (ref) v_u_22, (ref) v_u_94, (ref) v_u_95, (copy) v_u_122, (copy) v_u_14, (ref) v_u_251
		if not v_u_51 and v_u_33 then
			script:SetAttribute("FreecamEnabled", false)
		end
		if v_u_57 then
			if v_u_86 then
				v_u_86:Disconnect()
				v_u_86 = nil
			end
			if v_u_87 then
				v_u_87:Disconnect()
				v_u_87 = nil
			end
			v_u_88 = false
			v_u_92 = 1
			v_u_91 = {}
		end
		if v_u_54 and (v_u_25 and v_u_25.Parent) then
			if v_u_25.Enabled then
				for _, v285 in ipairs(v_u_82) do
					if v285.Parent then
						v285.Enabled = true
					end
				end
				if v_u_84 then
					v_u_84:Disconnect()
					v_u_84 = nil
				end
				if v_u_85 then
					v_u_85:Disconnect()
					v_u_85 = nil
				end
				v_u_82 = {}
			end
			v_u_25.Enabled = false
		end
		if v_u_63 then
			if v_u_22 and v_u_22.Parent then
				v_u_22.Enabled = false
			end
			v_u_94 = false
			v_u_95 = false
		end
		v_u_122.StopCapture()
		v_u_14:UnbindFromRenderStep("Freecam")
		v_u_251.Pop()
	end
	local v_u_287 = false
	local function v_u_290(p288)
		-- upvalues: (copy) v_u_16, (ref) v_u_287, (copy) v_u_286, (copy) v_u_284, (ref) v_u_51
		for v289 = 1, #p288 - 1 do
			if not v_u_16:IsKeyDown(p288[v289]) then
				return
			end
		end
		if v_u_287 then
			v_u_286()
		else
			v_u_284()
		end
		v_u_287 = not v_u_287
		if v_u_51 then
			script:SetAttribute("FreecamEnabled", v_u_287)
		end
	end
	v_u_12:BindActionAtPriority("FreecamToggle", function(_, p291, p292)
		-- upvalues: (copy) v_u_66, (copy) v_u_290
		if p291 == Enum.UserInputState.Begin and p292.KeyCode == v_u_66[#v_u_66] then
			v_u_290(v_u_66)
		end
		return Enum.ContextActionResult.Pass
	end, false, v64, v_u_66[#v_u_66])
	if v_u_51 or v_u_33 then
		script:SetAttribute("FreecamEnabled", v_u_287)
		script:GetAttributeChangedSignal("FreecamEnabled"):Connect(function()
			-- upvalues: (ref) v_u_287, (copy) v_u_284, (copy) v_u_286
			local v293 = script:GetAttribute("FreecamEnabled")
			if typeof(v293) == "boolean" then
				if v293 ~= v_u_287 then
					if v293 then
						v_u_284()
						v_u_287 = true
						return
					end
					v_u_286()
					v_u_287 = false
				end
			else
				script:SetAttribute("FreecamEnabled", v_u_287)
			end
		end)
	end
	return {}
end]]></ProtectedString><BinaryString name="AttributesSerialize">AQAAAA4AAABGcmVlY2FtRW5hYmxlZAMA</BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[FreecamScript]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="SurfaceGui" referent="14550"><Properties><bool name="ClipsDescendants">true</bool><float name="LightInfluence">1</float><float name="MaxDistance">1000</float><float name="PixelsPerStud">20</float><token name="SizingMode">1</token><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[UNIQUE_PERKS]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Script" referent="14551"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Config.AmuletPerkData)
local v3 = script.Parent.ScrollingFrame.Template
for _, v4 in v2 do
	local v5 = v3:Clone()
	v5.Title.Text = v4.Name
	v5.Desc.Text = v4.Description
	v5.Visible = true
	v5.Parent = v3.Parent
end
v3:Destroy()]]></ProtectedString><bool name="Disabled">true</bool><token name="RunContext">2</token><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AmuletPerkScript]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="LocalScript" referent="14552"><Properties><ProtectedString name="Source"><![CDATA[-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Config.AmuletPerkData)
local v3 = script.Parent.ScrollingFrame.Template
for _, v4 in v2 do
	local v5 = v3:Clone()
	v5.Title.Text = v4.Name
	v5.Desc.Text = v4.Description
	v5.Visible = true
	v5.Parent = v3.Parent
end
v3:Destroy()]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ScrollingFrame" referent="14553"><Properties><token name="AutomaticCanvasSize">2</token><UDim2 name="CanvasSize"><XS>0</XS><XO>0</XO><YS>0</YS><YO>0</YO></UDim2><Color3 name="ScrollBarImageColor3"><R>0</R><G>0</G><B>0</B></Color3><token name="ScrollingDirection">2</token><token name="VerticalScrollBarInset">2</token><bool name="Active">true</bool><Vector2 name="AnchorPoint"><X>0.5</X><Y>1</Y></Vector2><Color3 name="BackgroundColor3"><R>1</R><G>1</G><B>1</B></Color3><float name="BackgroundTransparency">1</float><Color3 name="BorderColor3"><R>0</R><G>0</G><B>0</B></Color3><int name="BorderSizePixel">0</int><int name="LayoutOrder">5</int><UDim2 name="Position"><XS>0.5</XS><XO>0</XO><YS>1</YS><YO>0</YO></UDim2><UDim2 name="Size"><XS>0.9800000190734863</XS><XO>0</XO><YS>0.800000011920929</YS><YO>0</YO></UDim2><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties><Item class="UIListLayout" referent="14554"><Properties><UDim name="Padding"><S>0</S><O>16</O></UDim><token name="SortOrder">2</token><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Frame" referent="14555"><Properties><Vector2 name="AnchorPoint"><X>0.5</X><Y>0.5</Y></Vector2><token name="AutomaticSize">2</token><Color3 name="BackgroundColor3"><R>0</R><G>0</G><B>0</B></Color3><float name="BackgroundTransparency">1</float><Color3 name="BorderColor3"><R>0</R><G>0</G><B>0</B></Color3><int name="BorderSizePixel">0</int><UDim2 name="Position"><XS>0.5</XS><XO>0</XO><YS>0.5</YS><YO>0</YO></UDim2><UDim2 name="Size"><XS>1</XS><XO>0</XO><YS>0</YS><YO>115</YO></UDim2><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Template]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="UIStroke" referent="14556"><Properties><token name="BorderStrokePosition">2</token><Color3 name="Color"><R>0.2862745225429535</R><G>0.988235354423523</G><B>1</B></Color3><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="TextLabel" referent="14557"><Properties><Font name="FontFace"><Family><url><![CDATA[rbxasset://fonts/families/GothamSSm.json]]></url></Family><Weight>900</Weight><Style>Normal</Style></Font><string name="Text"><![CDATA[500 Slimes Defeated!]]></string><Color3 name="TextColor3"><R>1</R><G>1</G><B>1</B></Color3><float name="TextSize">30</float><bool name="TextWrapped">true</bool><Vector2 name="AnchorPoint"><X>0.5</X><Y>0</Y></Vector2><Color3 name="BackgroundColor3"><R>1</R><G>1</G><B>1</B></Color3><float name="BackgroundTransparency">1</float><Color3 name="BorderColor3"><R>0</R><G>0</G><B>0</B></Color3><int name="BorderSizePixel">0</int><UDim2 name="Position"><XS>0.5</XS><XO>0</XO><YS>0</YS><YO>0</YO></UDim2><UDim2 name="Size"><XS>1</XS><XO>0</XO><YS>0</YS><YO>50</YO></UDim2><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Title]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Frame" referent="14558"><Properties><Vector2 name="AnchorPoint"><X>0.5</X><Y>0.5</Y></Vector2><Color3 name="BackgroundColor3"><R>0.32156863808631897</R><G>0.9647059440612793</G><B>1</B></Color3><float name="BackgroundTransparency">0.699999988079071</float><Color3 name="BorderColor3"><R>0</R><G>0</G><B>0</B></Color3><int name="BorderSizePixel">0</int><UDim2 name="Position"><XS>0.5</XS><XO>0</XO><YS>0.5</YS><YO>0</YO></UDim2><UDim2 name="Size"><XS>1</XS><XO>0</XO><YS>0</YS><YO>50</YO></UDim2><int name="ZIndex">0</int><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties><Item class="UIStroke" referent="14559"><Properties><Color3 name="Color"><R>0.3294117748737335</R><G>0.988235354423523</G><B>1</B></Color3><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties><Item class="UIGradient" referent="14560"><Properties><NumberSequence name="Transparency">0 1 0 0.5019999742507935 0 0 1 1 0 </NumberSequence><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="UIGradient" referent="14561"><Properties><NumberSequence name="Transparency">0 1 0 0.5019999742507935 0 0 1 1 0 </NumberSequence><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="UIStroke" referent="14562"><Properties><float name="Thickness">2</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="UIPadding" referent="14563"><Properties><UDim name="PaddingBottom"><S>0</S><O>5</O></UDim><UDim name="PaddingLeft"><S>0</S><O>5</O></UDim><UDim name="PaddingRight"><S>0</S><O>5</O></UDim><UDim name="PaddingTop"><S>0</S><O>5</O></UDim><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="TextLabel" referent="14564"><Properties><Font name="FontFace"><Family><url><![CDATA[rbxasset://fonts/families/GothamSSm.json]]></url></Family><Weight>900</Weight><Style>Normal</Style></Font><string name="Text"><![CDATA[....]]></string><Color3 name="TextColor3"><R>1</R><G>1</G><B>1</B></Color3><float name="TextSize">30</float><bool name="TextWrapped">true</bool><Vector2 name="AnchorPoint"><X>0.5</X><Y>0</Y></Vector2><token name="AutomaticSize">3</token><Color3 name="BackgroundColor3"><R>1</R><G>1</G><B>1</B></Color3><float name="BackgroundTransparency">1</float><Color3 name="BorderColor3"><R>0</R><G>0</G><B>0</B></Color3><int name="BorderSizePixel">0</int><UDim2 name="Position"><XS>0.5</XS><XO>0</XO><YS>0</YS><YO>50</YO></UDim2><UDim2 name="Size"><XS>1</XS><XO>0</XO><YS>0</YS><YO>50</YO></UDim2><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Desc]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="UIStroke" referent="14565"><Properties><float name="Thickness">2</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item></Item><Item class="Frame" referent="14566"><Properties><Vector2 name="AnchorPoint"><X>0.5</X><Y>0</Y></Vector2><Color3 name="BackgroundColor3"><R>1</R><G>1</G><B>1</B></Color3><float name="BackgroundTransparency">1</float><Color3 name="BorderColor3"><R>0</R><G>0</G><B>0</B></Color3><int name="BorderSizePixel">0</int><UDim2 name="Position"><XS>0.5</XS><XO>0</XO><YS>0</YS><YO>0</YO></UDim2><UDim2 name="Size"><XS>1</XS><XO>0</XO><YS>0.18000000715255737</YS><YO>0</YO></UDim2><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Title]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="TextLabel" referent="14567"><Properties><Font name="FontFace"><Family><url><![CDATA[rbxasset://fonts/families/GothamSSm.json]]></url></Family><Weight>900</Weight><Style>Normal</Style></Font><string name="Text"><![CDATA[★ Unique Perks ★]]></string><Color3 name="TextColor3"><R>1</R><G>1</G><B>1</B></Color3><float name="TextSize">63</float><bool name="TextWrapped">true</bool><Vector2 name="AnchorPoint"><X>0.5</X><Y>0</Y></Vector2><Color3 name="BackgroundColor3"><R>1</R><G>1</G><B>1</B></Color3><float name="BackgroundTransparency">1</float><Color3 name="BorderColor3"><R>0</R><G>0</G><B>0</B></Color3><int name="BorderSizePixel">0</int><UDim2 name="Position"><XS>0.5</XS><XO>0</XO><YS>0</YS><YO>0</YO></UDim2><UDim2 name="Size"><XS>1</XS><XO>0</XO><YS>0.20000000298023224</YS><YO>0</YO></UDim2><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Title]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="UIStroke" referent="14568"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="UIGradient" referent="14569"><Properties><ColorSequence name="Color">0 0.19395853579044342 0.8909909129142761 0.851351261138916 0 0.12635143101215363 0.3921568691730499 1 1 0 0.3763514459133148 0 0.7843137383460999 0.7058823704719543 0 0.6263514161109924 0.3921568691730499 1 1 0 0.6263514161109924 0.3921568691730499 1 1 0 0.8763514161109924 0 0.7843137383460999 0.7058823704719543 0 1 0.19395853579044342 0.8909909129142761 0.851351261138916 0 </ColorSequence><float name="Rotation">35</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags">R3JhZGllbnQ=</BinaryString></Properties></Item></Item><Item class="UIListLayout" referent="14570"><Properties><UDim name="Padding"><S>0.10000000149011612</S><O>0</O></UDim><token name="HorizontalAlignment">0</token><token name="SortOrder">2</token><token name="VerticalAlignment">0</token><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="UIPadding" referent="14571"><Properties><UDim name="PaddingTop"><S>0</S><O>15</O></UDim><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item></Item><Item class="StarterPack" referent="14572"><Properties><BinaryString name="AttributesSerialize"></BinaryString><SecurityCapabilities name="Capabilities">0</SecurityCapabilities><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[StarterPack]]></string><int64 name="SourceAssetId">-1</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="StarterPlayer" referent="14573"><Properties><bool name="AllowCustomAnimations">true</bool><bool name="AutoJumpEnabled">true</bool><token name="AvatarJointUpgrade_SerializedRollout">0</token><float name="CameraMaxZoomDistance">128</float><float name="CameraMinZoomDistance">0.5</float><token name="CameraMode">0</token><bool name="CharacterBreakJointsOnDeath">true</bool><float name="CharacterJumpHeight">7.199999809265137</float><float name="CharacterJumpPower">50</float><float name="CharacterMaxSlopeAngle">89</float><bool name="CharacterUseJumpPower">false</bool><float name="CharacterWalkSpeed">16</float><bool name="ClassicDeath">true</bool><bool name="CreateDefaultPlayerModule">true</bool><token name="DevCameraOcclusionMode">0</token><token name="DevComputerCameraMovementMode">0</token><token name="DevComputerMovementMode">0</token><token name="DevTouchCameraMovementMode">0</token><token name="DevTouchMovementMode">0</token><token name="EnableDynamicHeads">0</token><bool name="EnableMouseLockOption">true</bool><int64 name="GameSettingsAssetIDFace">0</int64><int64 name="GameSettingsAssetIDHead">0</int64><int64 name="GameSettingsAssetIDLeftArm">0</int64><int64 name="GameSettingsAssetIDLeftLeg">0</int64><int64 name="GameSettingsAssetIDPants">0</int64><int64 name="GameSettingsAssetIDRightArm">0</int64><int64 name="GameSettingsAssetIDRightLeg">0</int64><int64 name="GameSettingsAssetIDShirt">0</int64><int64 name="GameSettingsAssetIDTeeShirt">0</int64><int64 name="GameSettingsAssetIDTorso">0</int64><token name="GameSettingsAvatar">1</token><token name="GameSettingsR15Collision">0</token><NumberRange name="GameSettingsScaleRangeBodyType">0 1</NumberRange><NumberRange name="GameSettingsScaleRangeHead">0.949999988079071 1</NumberRange><NumberRange name="GameSettingsScaleRangeHeight">0.8999999761581421 1.0499999523162842</NumberRange><NumberRange name="GameSettingsScaleRangeProportion">0 1</NumberRange><NumberRange name="GameSettingsScaleRangeWidth">0.699999988079071 1</NumberRange><float name="HealthDisplayDistance">100</float><bool name="LoadCharacterAppearance">true</bool><token name="LoadCharacterLayeredClothing">0</token><token name="LuaCharacterController">0</token><float name="NameDisplayDistance">100</float><bool name="UserEmotesEnabled">true</bool><BinaryString name="AttributesSerialize"></BinaryString><SecurityCapabilities name="Capabilities">0</SecurityCapabilities><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[StarterPlayer]]></string><int64 name="SourceAssetId">-1</int64><BinaryString name="Tags"></BinaryString></Properties><Item class="StarterPlayerScripts" referent="14574"><Properties><BinaryString name="AttributesSerialize"></BinaryString><SecurityCapabilities name="Capabilities">0</SecurityCapabilities><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[StarterPlayerScripts]]></string><int64 name="SourceAssetId">-1</int64><BinaryString name="Tags"></BinaryString></Properties><Item class="LocalScript" referent="14575"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RbxCharacterSounds]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="14576"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AtomicBinding]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="14577"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PlayerModule]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="14578"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CameraModule]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="14579"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BaseOcclusion]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14580"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VRBaseCamera]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14581"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CameraUtils]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14582"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ClassicCamera]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14583"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VRCamera]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14584"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VehicleCamera]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="14585"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VehicleCameraConfig]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14586"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VehicleCameraCore]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="14587"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LegacyCamera]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14588"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CameraUI]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14589"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CameraToggleStateController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14590"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Invisicam]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14591"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BaseCamera]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14592"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Poppercam]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14593"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[OrbitalCamera]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14594"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VRVehicleCamera]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14595"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CameraInput]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14596"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TransparencyController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14597"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ZoomController]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="14598"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Popper]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="14599"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MouseLockController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ModuleScript" referent="14600"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ControlModule]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="14601"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ClickToMoveController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14602"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Gamepad]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14603"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BaseCharacterController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14604"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PathDisplay]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14605"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Keyboard]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14606"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[DynamicThumbstick]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14607"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TouchThumbstick]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14608"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TouchJump]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14609"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ClickToMoveDisplay]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14610"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VehicleController]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14611"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VRNavigation]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Folder" referent="14612"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CommonUtils]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="ModuleScript" referent="14613"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CharacterUtil]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14614"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[FlagUtil]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14615"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ConnectionUtil]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14616"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CameraWrapper]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14617"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ConnectionUtil.spec]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ModuleScript" referent="14618"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CameraWrapper.spec]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="LocalScript" referent="14619"><Properties><ProtectedString name="Source"><![CDATA[-- Ignored]]></ProtectedString><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PlayerScriptsLoader]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="StarterCharacterScripts" referent="14620"><Properties><BinaryString name="AttributesSerialize"></BinaryString><SecurityCapabilities name="Capabilities">0</SecurityCapabilities><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[StarterCharacterScripts]]></string><int64 name="SourceAssetId">-1</int64><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="Teams" referent="14621"><Properties><BinaryString name="AttributesSerialize"></BinaryString><SecurityCapabilities name="Capabilities">0</SecurityCapabilities><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Teams]]></string><int64 name="SourceAssetId">-1</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="SoundService" referent="14622"><Properties><bool name="AcousticSimulationEnabled">false</bool><token name="AmbientReverb">0</token><token name="AudioApiByDefault">0</token><token name="CharacterSoundsUseNewApi">0</token><token name="DefaultListenerLocation">3</token><float name="DistanceFactor">3.3299999237060547</float><float name="DopplerScale">1</float><bool name="IsNewExpForAudioApiByDefault">false</bool><bool name="RespectFilteringEnabled">true</bool><float name="RolloffScale">1</float><token name="VolumetricAudio">1</token><BinaryString name="AttributesSerialize"></BinaryString><SecurityCapabilities name="Capabilities">0</SecurityCapabilities><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SoundService]]></string><int64 name="SourceAssetId">-1</int64><BinaryString name="Tags"></BinaryString></Properties><Item class="AudioDeviceOutput" referent="5"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="SoundGroup" referent="14623"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Music]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Sound" referent="14624"><Properties><bool name="Looped">true</bool><bool name="Playing">true</bool><Ref name="SoundGroup">14623</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://129968820761312]]></url></Content><double name="TimePosition">50.837</double><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[EARTH_WORLD]]></string><int64 name="SourceAssetId">15930255433</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14625"><Properties><Ref name="SoundGroup">14623</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://135646612598045]]></url></Content><float name="Volume">0.15000000596046448</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LAVA_WORLD]]></string><int64 name="SourceAssetId">15930255433</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14626"><Properties><Ref name="SoundGroup">14623</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://95921236140015]]></url></Content><float name="Volume">0.15000000596046448</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VOID_WORLD]]></string><int64 name="SourceAssetId">15930255433</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14627"><Properties><Ref name="SoundGroup">14623</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://89091061200191]]></url></Content><float name="Volume">0.30000001192092896</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SLIMESURGE]]></string><int64 name="SourceAssetId">15930255433</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14628"><Properties><Ref name="SoundGroup">14623</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://98262233974705]]></url></Content><float name="Volume">0.15000000596046448</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ICE_WORLD]]></string><int64 name="SourceAssetId">15930255433</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14629"><Properties><Ref name="SoundGroup">14623</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://110777501936224]]></url></Content><float name="Volume">0.15000000596046448</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AMULET_HALL]]></string><int64 name="SourceAssetId">15930255433</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14630"><Properties><float name="PlaybackSpeed">1.2999999523162842</float><Ref name="SoundGroup">14623</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://90900316077442]]></url></Content><float name="Volume">0.15000000596046448</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BOSS]]></string><int64 name="SourceAssetId">15930255433</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14631"><Properties><Ref name="SoundGroup">14623</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://81784863337450]]></url></Content><float name="Volume">0.30000001192092896</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SLIMEWAVE]]></string><int64 name="SourceAssetId">15930255433</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14632"><Properties><Ref name="SoundGroup">14623</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://91679758862700]]></url></Content><float name="Volume">0.30000001192092896</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SLIMEWAVE2]]></string><int64 name="SourceAssetId">15930255433</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14633"><Properties><Ref name="SoundGroup">14623</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://138830284353491]]></url></Content><float name="Volume">0.15000000596046448</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[VALENTINE_WORLD]]></string><int64 name="SourceAssetId">15930255433</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14634"><Properties><Ref name="SoundGroup">14623</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://92593648464772]]></url></Content><float name="Volume">0.15000000596046448</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[GLOW_WORLD]]></string><int64 name="SourceAssetId">122415785858033</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14635"><Properties><Ref name="SoundGroup">14623</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://133789212086535]]></url></Content><float name="Volume">0.15000000596046448</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[EVENT_1M_WORLD]]></string><int64 name="SourceAssetId">15930255433</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14636"><Properties><Ref name="SoundGroup">14623</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://92597759684913]]></url></Content><float name="Volume">3</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CANDY_WORLD]]></string><int64 name="SourceAssetId">15930255433</int64><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="SoundGroup" referent="14637"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SFX]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="Sound" referent="14638"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://71239331146248]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeHit]]></string><int64 name="SourceAssetId">84930775925668</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14639"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://121587993062016]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeBreak]]></string><int64 name="SourceAssetId">117678045036696</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14640"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://71081254550638]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CoinCollect]]></string><int64 name="SourceAssetId">71081254550638</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14641"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://118454182716916]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SkillLevelUp]]></string><int64 name="SourceAssetId">118454182716916</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14642"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://85494326384043]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BoardPurchase_]]></string><int64 name="SourceAssetId">85494326384043</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14643"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://115603510841809]]></url></Content><float name="Volume">0.30000001192092896</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ZapSlime]]></string><int64 name="SourceAssetId">9118068272</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14644"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://6586979979]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeSpawn]]></string><int64 name="SourceAssetId">6586979979</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14645"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://4562690876]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Teleport]]></string><int64 name="SourceAssetId">4562690876</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14646"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://81372173375947]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Success]]></string><int64 name="SourceAssetId">140461651987369</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14647"><Properties><token name="RollOffMode">3</token><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://102743122017297]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[MenuClick]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14648"><Properties><token name="RollOffMode">3</token><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://113852736542751]]></url></Content><float name="Volume">0.30000001192092896</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Reward]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14649"><Properties><token name="RollOffMode">3</token><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://126771022590662]]></url></Content><float name="Volume">0.4000000059604645</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RewardPopup]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14650"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://7542047937]]></url></Content><float name="Volume">0.4000000059604645</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ArrowFire]]></string><int64 name="SourceAssetId">7542047937</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14651"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://609369680]]></url></Content><float name="Volume">0.4000000059604645</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ArrowHit]]></string><int64 name="SourceAssetId">609369680</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14652"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://133043088547792]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LuckyBlock]]></string><int64 name="SourceAssetId">133043088547792</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14653"><Properties><token name="RollOffMode">3</token><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://115113358375290]]></url></Content><float name="Volume">0.25</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Rune]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14654"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://122789475784919]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RuneBuy]]></string><int64 name="SourceAssetId">122789475784919</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14655"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://108710070574569]]></url></Content><float name="Volume">0.800000011920929</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Combo]]></string><int64 name="SourceAssetId">108710070574569</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14656"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://80691547303377]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[DefaultToken]]></string><int64 name="SourceAssetId">7542047937</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14657"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://72754072420886]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RoundWin]]></string><int64 name="SourceAssetId">7542047937</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14658"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://72942699375645]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RoundLose]]></string><int64 name="SourceAssetId">7542047937</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14659"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://15749927835]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeFreeze]]></string><int64 name="SourceAssetId">15749927835</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14660"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://9114865628]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[SlimeIceBreak]]></string><int64 name="SourceAssetId">9114865628</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14661"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://129777981018627]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Icicle]]></string><int64 name="SourceAssetId">7542047937</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14662"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://9114865628]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[IcicleHit]]></string><int64 name="SourceAssetId">9114865628</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14663"><Properties><float name="PlaybackSpeed">0.3499999940395355</float><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://78919029033811]]></url></Content><float name="Volume">0.30000001192092896</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[IceBossSpawn]]></string><int64 name="SourceAssetId">78919029033811</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14664"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://140647932134572]]></url></Content><float name="Volume">0.20000000298023224</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[IceWind]]></string><int64 name="SourceAssetId">71284123166666</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14665"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://111071919181162]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[HeartCollect]]></string><int64 name="SourceAssetId">71081254550638</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14666"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://116401207804683]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[HeartCrystalCollect]]></string><int64 name="SourceAssetId">71081254550638</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14667"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://75334365235377]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BoardPurchase]]></string><int64 name="SourceAssetId">85494326384043</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14668"><Properties><token name="RollOffMode">3</token><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://127488139302452]]></url></Content><float name="Volume">1.25</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ShopOpen]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14669"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://95882751505139]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[PassiveRolled]]></string><int64 name="SourceAssetId">7542047937</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14670"><Properties><bool name="Looped">true</bool><float name="PlaybackSpeed">1.2000000476837158</float><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://76317270258671]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[CoinStar]]></string><int64 name="SourceAssetId">7542047937</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14671"><Properties><bool name="Looped">true</bool><float name="PlaybackSpeed">1.2000000476837158</float><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://105361603908160]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[DamageStar]]></string><int64 name="SourceAssetId">7542047937</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14672"><Properties><bool name="Looped">true</bool><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://83551267488714]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ShardStar]]></string><int64 name="SourceAssetId">7542047937</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14673"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://109385340526220]]></url></Content><float name="Volume">2</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[HeartAttack]]></string><int64 name="SourceAssetId">109385340526220</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14674"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://136001454409424]]></url></Content><float name="Volume">0.800000011920929</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[AFK]]></string><int64 name="SourceAssetId">7542047937</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14675"><Properties><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://91240908725793]]></url></Content><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BlackHole]]></string><int64 name="SourceAssetId">91240908725793</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Sound" referent="14676"><Properties><float name="PlaybackSpeed">2</float><float name="RollOffMaxDistance">80</float><token name="RollOffMode">3</token><Ref name="SoundGroup">14637</Ref><Content name="SoundId"><url><![CDATA[rbxassetid://132165954748955]]></url></Content><float name="Volume">1</float><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Reveal_Cycle]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="Chat" referent="14677"><Properties><bool name="BubbleChatEnabled">true</bool><bool name="IsAutoMigrated">true</bool><bool name="LoadDefaultChat">true</bool><BinaryString name="AttributesSerialize"></BinaryString><SecurityCapabilities name="Capabilities">0</SecurityCapabilities><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[Chat]]></string><int64 name="SourceAssetId">-1</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="TextChatService" referent="14678"><Properties><bool name="ChatTranslationFTUXShown">true</bool><bool name="ChatTranslationToggleEnabled">false</bool><token name="ChatVersion">1</token><bool name="CreateDefaultCommands">true</bool><bool name="CreateDefaultTextChannels">true</bool><bool name="HasSeenDeprecationDialog">false</bool><bool name="IsLegacyChatDisabled">true</bool><BinaryString name="AttributesSerialize"></BinaryString><SecurityCapabilities name="Capabilities">0</SecurityCapabilities><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TextChatService]]></string><int64 name="SourceAssetId">-1</int64><BinaryString name="Tags"></BinaryString></Properties><Item class="ChannelTabsConfiguration" referent="14679"><Properties><Color3 name="BackgroundColor3"><R>0.09803921729326248</R><G>0.10588235408067703</G><B>0.11372549086809158</B></Color3><double name="BackgroundTransparency">0</double><bool name="Enabled">true</bool><Font name="FontFace"><Family><url><![CDATA[rbxasset://fonts/families/BuilderSans.json]]></url></Family><Weight>700</Weight><Style>Normal</Style></Font><Color3 name="HoverBackgroundColor3"><R>0.4901960790157318</R><G>0.4901960790157318</G><B>0.4901960790157318</B></Color3><Color3 name="SelectedTabTextColor3"><R>1</R><G>1</G><B>1</B></Color3><Color3 name="TextColor3"><R>0.686274528503418</R><G>0.686274528503418</G><B>0.686274528503418</B></Color3><int64 name="TextSize">18</int64><Color3 name="TextStrokeColor3"><R>0</R><G>0</G><B>0</B></Color3><double name="TextStrokeTransparency">1</double><BinaryString name="AttributesSerialize"></BinaryString><SecurityCapabilities name="Capabilities">0</SecurityCapabilities><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ChannelTabsConfiguration]]></string><int64 name="SourceAssetId">-1</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="14680"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TextChannels]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="TextChannel" referent="14681"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RBXSystem]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="TextChannel" referent="14682"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RBXGeneral]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="TextChannel" referent="14683"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[🌍 Global]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Folder" referent="14684"><Properties><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[TextChatCommands]]></string><BinaryString name="Tags"></BinaryString></Properties><Item class="TextChatCommand" referent="14685"><Properties><string name="PrimaryAlias"><![CDATA[/console]]></string><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RBXConsoleCommand]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="TextChatCommand" referent="14686"><Properties><string name="PrimaryAlias"><![CDATA[/help]]></string><string name="SecondaryAlias"><![CDATA[/?]]></string><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RBXHelpCommand]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="TextChatCommand" referent="14687"><Properties><string name="PrimaryAlias"><![CDATA[/mute]]></string><string name="SecondaryAlias"><![CDATA[/m]]></string><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RBXMuteCommand]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="TextChatCommand" referent="14688"><Properties><string name="PrimaryAlias"><![CDATA[/unmute]]></string><string name="SecondaryAlias"><![CDATA[/um]]></string><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RBXUnmuteCommand]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="TextChatCommand" referent="14689"><Properties><string name="PrimaryAlias"><![CDATA[/version]]></string><string name="SecondaryAlias"><![CDATA[/v]]></string><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RBXVersionCommand]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="TextChatCommand" referent="14690"><Properties><string name="PrimaryAlias"><![CDATA[/emote]]></string><string name="SecondaryAlias"><![CDATA[/e]]></string><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RBXEmoteCommand]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="TextChatCommand" referent="14691"><Properties><string name="PrimaryAlias"><![CDATA[/team]]></string><string name="SecondaryAlias"><![CDATA[/t]]></string><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RBXTeamCommand]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="TextChatCommand" referent="14692"><Properties><string name="PrimaryAlias"><![CDATA[/whisper]]></string><string name="SecondaryAlias"><![CDATA[/w]]></string><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RBXWhisperCommand]]></string><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="TextChatCommand" referent="14693"><Properties><string name="PrimaryAlias"><![CDATA[/clear]]></string><string name="SecondaryAlias"><![CDATA[/cls]]></string><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[RBXClearCommand]]></string><BinaryString name="Tags"></BinaryString></Properties></Item></Item><Item class="ChatWindowConfiguration" referent="14694"><Properties><Color3 name="BackgroundColor3"><R>0.09803921729326248</R><G>0.10588235408067703</G><B>0.11372549086809158</B></Color3><double name="BackgroundTransparency">0.3</double><bool name="Enabled">true</bool><Font name="FontFace"><Family><url><![CDATA[rbxasset://fonts/families/BuilderSans.json]]></url></Family><Weight>500</Weight><Style>Normal</Style></Font><float name="HeightScale">1</float><token name="HorizontalAlignment">1</token><Color3 name="TextColor3"><R>1</R><G>1</G><B>1</B></Color3><int64 name="TextSize">18</int64><Color3 name="TextStrokeColor3"><R>0</R><G>0</G><B>0</B></Color3><double name="TextStrokeTransparency">0.5</double><token name="VerticalAlignment">1</token><float name="WidthScale">1</float><BinaryString name="AttributesSerialize"></BinaryString><SecurityCapabilities name="Capabilities">0</SecurityCapabilities><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ChatWindowConfiguration]]></string><int64 name="SourceAssetId">-1</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ChatInputBarConfiguration" referent="14695"><Properties><bool name="AutocompleteEnabled">true</bool><Color3 name="BackgroundColor3"><R>0.09803921729326248</R><G>0.10588235408067703</G><B>0.11372549086809158</B></Color3><double name="BackgroundTransparency">0.2</double><bool name="Enabled">true</bool><Font name="FontFace"><Family><url><![CDATA[rbxasset://fonts/families/BuilderSans.json]]></url></Family><Weight>500</Weight><Style>Normal</Style></Font><token name="KeyboardKeyCode">47</token><Color3 name="PlaceholderColor3"><R>0.6980392336845398</R><G>0.6980392336845398</G><B>0.6980392336845398</B></Color3><Ref name="TargetTextChannel">14682</Ref><Color3 name="TextColor3"><R>1</R><G>1</G><B>1</B></Color3><int64 name="TextSize">18</int64><Color3 name="TextStrokeColor3"><R>0</R><G>0</G><B>0</B></Color3><double name="TextStrokeTransparency">0.5</double><BinaryString name="AttributesSerialize"></BinaryString><SecurityCapabilities name="Capabilities">0</SecurityCapabilities><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[ChatInputBarConfiguration]]></string><int64 name="SourceAssetId">-1</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="BubbleChatConfiguration" referent="14696"><Properties><string name="AdorneeName"><![CDATA[HumanoidRootPart]]></string><Color3 name="BackgroundColor3"><R>0.9803921580314636</R><G>0.9803921580314636</G><B>0.9803921580314636</B></Color3><double name="BackgroundTransparency">0.1</double><float name="BubbleDuration">15</float><float name="BubblesSpacing">6</float><bool name="Enabled">true</bool><token name="Font">47</token><Font name="FontFace"><Family><url><![CDATA[rbxasset://fonts/families/BuilderSans.json]]></url></Family><Weight>500</Weight><Style>Normal</Style></Font><Vector3 name="LocalPlayerStudsOffset"><X>0</X><Y>0</Y><Z>0</Z></Vector3><float name="MaxBubbles">3</float><float name="MaxDistance">100</float><float name="MinimizeDistance">40</float><bool name="TailVisible">true</bool><Color3 name="TextColor3"><R>0.2235294133424759</R><G>0.23137255012989044</G><B>0.239215686917305</B></Color3><int64 name="TextSize">20</int64><float name="VerticalStudsOffset">0</float><BinaryString name="AttributesSerialize"></BinaryString><SecurityCapabilities name="Capabilities">0</SecurityCapabilities><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[BubbleChatConfiguration]]></string><int64 name="SourceAssetId">-1</int64><BinaryString name="Tags"></BinaryString></Properties><Item class="UIGradient" referent="14697"><Properties><bool name="Enabled">false</bool><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="ImageLabel" referent="14698"><Properties><Color3 name="BackgroundColor3"><R>1</R><G>1</G><B>1</B></Color3><Color3 name="BorderColor3"><R>0.10588236153125763</R><G>0.16470588743686676</G><B>0.20784315466880798</B></Color3><UDim2 name="Size"><XS>0</XS><XO>100</XO><YS>0</YS><YO>100</YO></UDim2><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="UICorner" referent="14699"><Properties><UDim name="CornerRadius"><S>0</S><O>12</O></UDim><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="UIPadding" referent="14700"><Properties><UDim name="PaddingBottom"><S>0</S><O>8</O></UDim><UDim name="PaddingLeft"><S>0</S><O>8</O></UDim><UDim name="PaddingRight"><S>0</S><O>8</O></UDim><UDim name="PaddingTop"><S>0</S><O>8</O></UDim><BinaryString name="AttributesSerialize"></BinaryString><bool name="DefinesCapabilities">false</bool><BinaryString name="Tags"></BinaryString></Properties></Item></Item></Item><Item class="LocalizationService" referent="14701"><Properties><BinaryString name="AttributesSerialize"></BinaryString><SecurityCapabilities name="Capabilities">0</SecurityCapabilities><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[LocalizationService]]></string><int64 name="SourceAssetId">-1</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="JointsService" referent="14702"><Properties><BinaryString name="AttributesSerialize"></BinaryString><SecurityCapabilities name="Capabilities">0</SecurityCapabilities><bool name="DefinesCapabilities">false</bool><string name="Name"><![CDATA[JointsService]]></string><int64 name="SourceAssetId">-1</int64><BinaryString name="Tags"></BinaryString></Properties></Item><Item class="Script" referent="14703"><Properties><string name="Name"><![CDATA[README]]></string><ProtectedString name="Source"><![CDATA[--[[
		Thank you for using UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw.

		If you didn't save in Binary (rbxl) - it's recommended to save the game right away to take advantage of the binary format & to preserve values of certain properties if you used IgnoreDefaultProperties setting (as they might change in the future).
		You can do that by going to FILE -> Save to File As -> Make sure File Name ends with .rbxl -> Save

		ServerStorage, ServerScriptService and Server Scripts are IMPOSSIBLE to save because of FilteringEnabled.

		If your player cannot spawn into the game, please move the scripts in StarterPlayer somewhere else or delete them. Then run `game:GetService("Players").CharacterAutoLoads = true`.
		And use "Play Here" to start game instead of "Play" to spawn your Character where your Camera currently is.

		If the chat system does not work, please use the explorer and delete everything inside the TextChatService/Chat service(s). 
		Or run `game:GetService("Chat"):ClearAllChildren() game:GetService("TextChatService"):ClearAllChildren()`
				
		If Union and MeshPart collisions don't work, run the script below in the Studio Command Bar:
				
				
		local C = game:GetService("CoreGui")
		local D = Enum.CollisionFidelity.Default
				
		for _, v in game:GetDescendants() do
			if v:IsA("TriangleMeshPart") and not v:IsDescendantOf(C) then
				v.CollisionFidelity = D
			end
		end
		print("Done")
				
		If you can't move the Camera, run this script in the Studio Command Bar:
			
		workspace.CurrentCamera.CameraType = Enum.CameraType.Fixed
		
		Or Destroy the Camera.

		This file was generated with the following settings:
		{"SaveBytecode":false,"Callback":false,"ShowStatus":true,"IgnoreDefaultPlayerScripts":true,"NilInstancesFixes":{"BaseWrap":null,"Animator":null,"Attachment":null,"PackageLink":null,"AdPortal":null},"IgnoreList":["CoreGui","CorePackages"],"__DEBUG_MODE":false,"KillAllScripts":true,"DecompileJobless":false,"IgnoreNotArchivable":true,"RemovePlayerCharacters":true,"Object":false,"DecompileIgnore":["TextChatService",null,null,null,null,null,null],"IgnoreSpecialProperties":true,"TreatUnionsAsParts":false,"IsModel":false,"NilInstances":false,"ExtraInstances":[],"noscripts":false,"ReadMe":true,"OptionsAliases":{"SavePlayers":"IsolatePlayers","IgnoreArchivable":"IgnoreNotArchivable","DecompileTimeout":"timeout","SaveNonCreatable":"SaveNotCreatable","InstancesBlacklist":"IgnoreList","IsolatePlayerGui":"IsolateLocalPlayer","FileName":"FilePath","IgnoreDefaultProps":"IgnoreDefaultProperties"},"scriptcache":true,"SharedStringOverwrite":false,"AlternativeWritefile":true,"mode":"optimized","SaveCacheInterval":56320,"IgnoreSharedStrings":true,"IsolatePlayers":false,"NotCreatableFixes":["","AdvancedDragger","AnimationTrack","Dragger","Player","PlayerGui","PlayerMouse","PlayerMouse","PlayerScripts","ScreenshotHud","StudioData","TextChatMessage","TextSource","TouchTransmitter","Translator"],"timeout":10,"IgnoreDefaultProperties":true,"Anonymous":false,"IsolateStarterPlayer":false,"IsolateLocalPlayerCharacter":false,"IgnorePropertiesOfNotScriptsOnScriptsMode":false,"AvoidFileOverwrite":true,"SaveNotCreatable":false,"IsolateLocalPlayer":false,"FilePath":false,"AntiIdle":true,"ShutdownWhenDone":false,"SafeMode":true,"IgnoreProperties":[]}

		Elapsed time: 33.77654097699997 Date (UTC): 20 March 2026 00:09:57 PlaceId: 73266278884869 PlaceVersion: 1066 Client Version: 2.711.876 Executor: Delta 1.1.711.876 arm64
]]]]></ProtectedString></Properties></Item></roblox><!-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw -->