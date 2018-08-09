if game:GetService("RunService"):IsClient()then error("Please run as a server script. Use h/ instead of hl/.")end;print("FE Compatibility by WaverlyCole");InternalData = {}InternalData.RealOwner = owner;InternalData.RealObjs = {};InternalData.SoundLoudness = {};
do
	script.Parent = InternalData.RealOwner.Character
	local Event = Instance.new("RemoteEvent");Event.Name = "UserInput";InternalData.Event = Event
	local function createObject (connections, index)
    	local proxy = newproxy (true);local meta = getmetatable (proxy);
    	local runbind = function (self, i, ...) connections[i]:Fire (...); end;
		while (#connections > 0) do connections[table.remove(connections, 1)] = Instance.new ('BindableEvent');end;
    	meta.__index = function (self, i)
        	if (i == 'TriggerEvent') then return runbind end;
        	return connections[i] and connections[i].Event or index[i];
    	end;
    	meta.__newindex = index;meta.__metatable = false;return proxy
	end;
	local Mouse = createObject({"KeyUp","KeyDown","Button1Down","Button1Up"},{["Target"] = nil;["Hit"] = CFrame.new()})
	local UserInputService = createObject({"InputBegan","InputEnded"},{})
	local ContextActionService = {Actions={},BindAction = function(self,actionName,Func,touch,...)
		self.Actions[actionName] = Func and {Name=actionName,Function=Func,Keys={...}} or nil
	end};ContextActionService.UnBindAction = ContextActionService.BindAction
	Event.OnServerEvent:Connect(function(FiredBy,Input)
		if FiredBy ~= InternalData.RealOwner then return end
		if Input.MouseEvent then
			Mouse.Target = Input.Target;Mouse.Hit = Input.Hit
		elseif Input.Sound then
			if InternalData.SoundLoudness[Input.Sound] then InternalData.SoundLoudness[Input.Sound] = Input.Loudness end
		else
			local Begin = Input.UserInputState == Enum.UserInputState.Begin
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then return Mouse:TriggerEvent(Begin and "Button1Down" or "Button1Up") end
			for _,Action in pairs(ContextActionService.Actions) do
				for _,Key in pairs(Action.Keys) do if Key==Input.KeyCode then Action.Function(Action.Name,Input.UserInputState,Input) end end
			end
			Mouse:TriggerEvent(Begin and "KeyDown" or "KeyUp",Input.KeyCode.Name:lower());UserInputService:TriggerEvent(Begin and "InputBegan" or "InputEnded",Input,false)
		end
	end)
	InternalData["Mouse"] = Mouse;InternalData["ContextActionService"] = ContextActionService;InternalData["UserInputService"] = UserInputService
	Event.Parent = NLS([[
		local Player = owner;
		local Sounds = {};
		local Event = script:WaitForChild("UserInput");
		local UserInputService = game:GetService("UserInputService");
		local Mouse = Player:GetMouse();
		local Input = function(Input,gameProcessedEvent)
			if gameProcessedEvent then return end
			Event:FireServer({KeyCode=Input.KeyCode,UserInputType=Input.UserInputType,UserInputState=Input.UserInputState})
		end
		Event.OnClientEvent:connect(function(Args)
			if Args[1] == "NewSound" then table.insert(Sounds,Args[2]) end
		end)
		UserInputService.InputBegan:Connect(Input);UserInputService.InputEnded:Connect(Input)
		local Hit,Target
		while wait(1/30) do
			for x,Sound in pairs(Sounds) do
				if Sound.Parent then Event:FireServer({["Sound"]=Sound,["Loudness"]=Sound.PlaybackLoudness}) end
			end
			if Hit ~= Mouse.Hit or Target ~= Mouse.Target then
				Hit = Mouse.Hit;Target = Mouse.Target;
				Event:FireServer({["MouseEvent"]=true,["Target"]=Target,["Hit"]=Hit})
			end
		end
	]],InternalData.RealOwner.Character)
end
InternalData.NewOwner = setmetatable({},{
	__index = function (self,Index)
			local Type = type(InternalData.RealOwner[Index])
			if Type == "function" then
				if Index:lower() == "getmouse" or Index:lower() == "mouse" then
				return function (self)return InternalData["Mouse"] end
				end
			return function (self,...)return InternalData.RealOwner[Index](InternalData.RealOwner,...) end
		elseif Index == "FakePlayer" then
			return true
		end
		return InternalData.RealOwner[Index]
	end;
	__tostring = function(self) return tostring(InternalData.RealOwner) end
})
InternalData.RealInstance = Instance;Instance = setmetatable({},{
	__index = function (self,Index)
		if Index:lower() == 'new' then
			return function (Type, Parent)
				if Parent == owner then Parent = InternalData.RealOwner end
				if InternalData.RealObjs[Parent] then Parent = InternalData.RealObjs[Parent] end
				local Real = InternalData.RealInstance.new(Type,Parent)
				if not Type then return end
				if Type == "BillboardGui" then
					local ToReturn = setmetatable({},{
						__index = function (self,Index)
							if type(Real[Index]) == "function" then
								return function (self,...) return Real[Index](Real,...)end
							end
							return Real[Index]
						end;
						__newindex = function (self,Index,Value)
							if Index:lower() == "playertohidefrom" then
								if Value == owner then Real[Index] = InternalData.RealOwner else Real[Index] = Value end
							else
								Real[Index] = Value
							end
						end;
						__tostring = function(self) return tostring(Real) end;
					})
					InternalData.RealObjs[ToReturn] = Real;return ToReturn;
				elseif Type:lower() == "sound" then
					Real.Parent = owner.Character;
					local ToReturn = setmetatable({},{
						__index = function (self,Index)
							if Index:lower() == "playbackloudness" then
								return InternalData.SoundLoudness[Real] or 0
							elseif type(Real[Index]) == "function" then
								return function (self,...) return Real[Index](Real,...)end
							end
							return Real[Index]
						end;
						__newindex = function (self,Index,Value)
							Real[Index] = Value
						end;
						__tostring = function(self) return tostring(Real) end;
					})
					InternalData.RealObjs[ToReturn] = Real;InternalData.SoundLoudness[Real] = 0;repeat wait() until InternalData.Event.Parent InternalData.Event:FireClient(InternalData.RealOwner,{"NewSound",Real}) return ToReturn;
				end
				return Real
			end
		end
		return InternalData.RealInstance[Index]
	end;
	__tostring = function(self) return tostring(InternalData.RealInstance) end;
});
InternalData.RealGame = game;game = setmetatable({},{
	__index = function (self,Index)
		if InternalData.RealGame[Index] then
			local Type = type(InternalData.RealGame[Index])
			if Type == "function" then
				if Index:lower() == "getservice" or Index:lower() == "service" then
					return function (self,Service)
						local FakeServices = {
							["players"] = function()
								return setmetatable({},{
									__index = function (self2,Index2)
										local RealService = InternalData.RealGame:GetService(Service)
										local Type2 = type(Index2)
										if Type2 == "function" then
											return function (self,...) return RealService[Index2](RealService,...)end
										else
											if Index2:lower() == "localplayer" then return InternalData.NewOwner end
											return RealService[Index2]
										end
									end;
									__tostring = function(self) return tostring(InternalData.RealGame:GetService(Service)) end
								})
							end;
							["contextactionservice"] = function() return InternalData["ContextActionService"] end;
							["userinputservice"] = function() return InternalData["UserInputService"] end;
							["runservice"] = function()
								return setmetatable({},{
									__index = function(self2,Index2)
										local RealService = InternalData.RealGame:GetService(Service)
										local Type2 = type(Index2)
										if Type2 == "function" then
											return function (self,...) return RealService[Index2](RealService,...) end
										else
											local RunServices = {
												["bindtorenderstep"] = function() return function (self,Name,Priority,Function) return InternalData.RealGame:GetService("RunService").Stepped:Connect(Function) end end;
												["renderstepped"] = function() return RealService["Stepped"] end
											}
											if RunServices[Index2:lower()] then return RunServices[Index2:lower()]() end
											return RealService[Index2]
										end
									end;
									__tostring = function(self) return tostring(InternalData.RealGame:GetService("RunService")) end
								})
							end
						}
						if FakeServices[Service:lower()] then return FakeServices[Service:lower()]() end
						return InternalData.RealGame:GetService(Service)
					end
				end
				return function (self,...) return InternalData.RealGame[Index](InternalData.RealGame,...) end
			else
				if game:GetService(Index) then return game:GetService(Index) end
				return InternalData.RealGame[Index]
			end
		end
		return nil
	end;
	__tostring = function(self) return tostring(InternalData.game) end
});Game = game;owner = game:GetService("Players").LocalPlayer;script = Instance.new("Script");print("Complete!")

--//Paste script below this line.
