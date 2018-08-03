if game:GetService("RunService"):IsClient()then error("Please run as a server script. Use h/ instead of hl/.")end;print("FE Compatibility: by WaverlyCole");InternalData = {}
do
	script.Parent = owner.Character
	local Event = Instance.new("RemoteEvent");Event.Name = "UserInput"
	local function NewFakeEvent()
		local Bind = Instance.new("BindableEvent")
		local Fake;Fake = {Connections = {},
		fakeEvent=true;
		Connect=function(self,Func)
			Bind.Event:connect(Func)
			self.Connections[Bind] = true
			return setmetatable({Connected = true},{
			__index = function (self,Index)
				if Index:lower() == "disconnect" then
					return function() Fake.Connections[Bind] = false;self.Connected = false end
				end
				return Fake[Index]
			end;
			__tostring = function() return "Connection" end;
		})
		end}
		Fake.connect = Fake.Connect;return Fake;
	end
	local Mouse = {Target=nil,Hit=CFrame.new(),KeyUp=NewFakeEvent(),KeyDown=NewFakeEvent(),Button1Up=NewFakeEvent(),Button1Down=NewFakeEvent()}
	local UserInputService = {InputBegan=NewFakeEvent(),InputEnded=NewFakeEvent()}
	local ContextActionService = {Actions={},BindAction = function(self,actionName,Func,touch,...)
		self.Actions[actionName] = Func and {Name=actionName,Function=Func,Keys={...}} or nil
	end};ContextActionService.UnBindAction = ContextActionService.BindAction
	local function TriggerEvent(self,Event,...)
		local Trigger = Mouse[Event]
		if Trigger and Trigger.fakeEvent and Trigger.Connections then
			for Connection,Active in pairs(Trigger.Connections) do if Active then Connection:Fire(...) end end
		end
	end
	Mouse.TrigEvent = TriggerEvent;UserInputService.TrigEvent = TriggerEvent
	Event.OnServerEvent:Connect(function(FiredBy,Input)
		if FiredBy.Name ~= owner.Name then return end
		if Input.MouseEvent then
			Mouse.Target = Input.Target;Mouse.Hit = Input.Hit
		else
			local Begin = Input.UserInputState == Enum.UserInputState.Begin
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then return Mouse:TrigEvent(Begin and "Button1Down" or "Button1Up") end
			for _,Action in pairs(ContextActionService.Actions) do
				for _,Key in pairs(Action.Keys) do if Key==Input.KeyCode then Action.Function(Action.Name,Input.UserInputState,Input) end end
			end
			Mouse:TrigEvent(Begin and "KeyDown" or "KeyUp",Input.KeyCode.Name:lower())
			UserInputService:TrigEvent(Begin and "InputBegan" or "InputEnded",Input,false)
		end
	end)
	InternalData["Mouse"] = Mouse;InternalData["ContextActionService"] = ContextActionService;InternalData["UserInputService"] = UserInputService
	Event.Parent = NLS([[
		local Player = owner;local Event = script:WaitForChild("UserInput");local UserInputService = game:GetService("UserInputService");local Mouse = Player:GetMouse()
		local Input = function(Input,gameProcessedEvent)
			if gameProcessedEvent then return end
			Event:FireServer({KeyCode=Input.KeyCode,UserInputType=Input.UserInputType,UserInputState=Input.UserInputState})
		end
		UserInputService.InputBegan:Connect(Input);UserInputService.InputEnded:Connect(Input)
		local Hit,Target
		while wait(1/30) do
			if Hit ~= Mouse.Hit or Target ~= Mouse.Target then
				Hit,Target = Mouse.Hit,Mouse.Target;Event:FireServer({["MouseEvent"]=true,["Target"]=Target,["Hit"]=Hit})
			end
		end
	]],owner.Character)
end
RealGame = game;game = setmetatable({},{
	__index = function (self,Index)
		local Sandbox = function (Thing)
			if Thing:IsA("Player") then
				local RealPlayer = Thing
				return setmetatable({},{
					__index = function (self,Index)
						local Type = type(RealPlayer[Index])
						if Type == "function" then
							if Index:lower() == "getmouse" or Index:lower() == "mouse" then
								return function (self)return InternalData["Mouse"] end
							end
							return function (self,...)return RealPlayer[Index](RealPlayer,...) end
						end
						return RealPlayer[Index]
					end;
					__tostring = function(self) return RealPlayer.Name end
				})
			end
		end
		if RealGame[Index] then
			local Type = type(RealGame[Index])
			if Type == "function" then
				if Index:lower() == "getservice" or Index:lower() == "service" then
					return function (self,Service)
						local FakeServices = {
							["players"] = function()
								return setmetatable({},{
									__index = function (self2,Index2)
										local RealService = RealGame:GetService(Service)
										local Type2 = type(Index2)
										if Type2 == "function" then
											return function (self,...) return RealService[Index2](RealService,...)end
										else
											if Index2:lower() == "localplayer" then return Sandbox(owner) end
											return RealService[Index2]
										end
									end;
									__tostring = function(self) return RealGame:GetService(Service).Name end
								})
							end;
							["contextactionservice"] = function() return InternalData["ContextActionService"] end;
							["userinputservice"] = function() return InternalData["UserInputService"] end;
							["runservice"] = function()
								return setmetatable({},{
									__index = function(self2,Index2)
										local RealService = RealGame:GetService(Service)
										local Type2 = type(Index2)
										if Type2 == "function" then
											return function (self,...) return RealService[Index2](RealService,...) end
										else
											local RunServices = {
												["bindtorenderstep"] = function() return function (self,Name,Priority,Function) return RealGame:GetService("RunService").Stepped:Connect(Function) end end;
												["renderstepped"] = function() return RealService["Stepped"] end
											}
											if RunServices[Index2:lower()] then return RunServices[Index2:lower()]() end
											return RealService[Index2]
										end
									end
								})
							end
						}
						if FakeServices[Service:lower()] then return FakeServices[Service:lower()]() end
						return RealGame:GetService(Service)
					end
				end
				return function (self,...) return RealGame[Index](RealGame,...) end
			else
				if game:GetService(Index) then return game:GetService(Index) end
				return RealGame[Index]
			end
		end
		return nil
	end
});Game = game;owner = game:GetService("Players").LocalPlayer;script = Instance.new("Script");print("Complete! Running...")

--//Paste script below this line.
