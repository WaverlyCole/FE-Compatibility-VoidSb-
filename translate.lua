if game:GetService("RunService"):IsClient()then error("Please run as a server script. Use h/ instead of hl/.")end;print("FE Compatibility by WaverlyCole & Fireboltofdeath");print("https://github.com/WaverlyCole/FE-Compatibility-VoidSb-")
local Wrapper = {};Wrapper.Fake = {};Wrapper.Real = {};Wrapper.Data = {};
local sGame = game;local sScript = script;local sOwner = owner;local sInstance = Instance;local sLoadLibrary = LoadLibrary
Wrapper.Event = Instance.new("RemoteEvent");Wrapper.Event.Name = "UserInput";
Wrapper.CreateObject = function(connections, index)
    local proxy = newproxy (true);local meta = getmetatable (proxy);
    local runbind = function (self, i, ...) connections[i]:Fire (...); end;
	while (#connections > 0) do connections[table.remove(connections, 1)] = Instance.new ('BindableEvent');end;
    meta.__index = function (self, i)
        if (i == 'TriggerEvent') then return runbind end;
        return connections[i] and connections[i].Event or index[i];
    end;
    meta.__newindex = index;meta.__metatable = false;return proxy
end;
Wrapper.Mouse = Wrapper.CreateObject({"KeyUp","KeyDown","Button1Down","Button1Up","Move","Button2Down","Button2Up"},{["Target"] = nil;["Hit"] = CFrame.new()})
Wrapper.UserInputService = Wrapper.CreateObject({"InputBegan","InputEnded"},{})
Wrapper.ContextActionService = {Actions={};BindAction = function(self,actionName,Func,touch,...)self.Actions[actionName] = Func and {Name=actionName,Function=Func,Keys={...}} or nil end;UnBindAction = function(self,actionName,Func,touch,...)self.Actions[actionName] = Func and {Name=actionName,Function=Func,Keys={...}} or nil end};
Wrapper.Sandbox = function(...)
  local Unwrap = {...};
  for obi = 1,#Unwrap do
    local Object = Unwrap[obi];
    if (Wrapper.Fake[Object] == nil and Wrapper.Real[Object] == nil) then
      local Type = typeof(Object);local Replacement = Object;
      if (Type == "table") then
			Replacement = {};
        	setmetatable(Replacement, {
          	__index = function(self, i)
              	return Wrapper.Sandbox(Object[i])
            end,
            __newindex = function(self, i, v)
              	Object[i] = Wrapper.Sandbox(v); 
            end,
          })
      elseif (Type == "Instance") then
        Replacement = newproxy(true);
        local Mt = getmetatable(Replacement);
		Mt.__namecall = function(self, ...)
            local Pack = {...};local Name = Pack[#Pack];table.remove(Pack, #Pack);
            local Rest = nil;pcall(function()Rest = Object[Name];end);
            for g, x in pairs (Wrapper.InstanceMT["GET"]) do
                if (Object:IsA(g) or g == "Global") then
                    for t, v in pairs(x) do
                        for str in string.gmatch(t .. ",", "(%w+),")  do
                            if (Name == str) then
								if typeof(v) == "function" then
									return Wrapper.Sandbox(v(Wrapper.Unsandbox(self), Wrapper.Unsandbox(unpack(Pack))))
                                else
                                    return v;
								end
                            end
                        end
                    end
                end
            end
            if (Rest == nil) then
				if Wrapper.Sandbox(sGame):GetService(unpack(Pack)) then return Wrapper.Sandbox(sGame):GetService(unpack(Pack))end;
                return Wrapper.Sandbox(Object[Name]);
            elseif (typeof(Rest) == "function") then
                return Wrapper.Sandbox(Rest(Wrapper.Unsandbox(self), Wrapper.Unsandbox(unpack(Pack))))
            end
          	return Wrapper.Sandbox(Object[Name]);
        end
        Mt.__index = function(self, i)
			local Rest = nil;pcall(function()Rest = Object[i];end)
            for g, x in pairs (Wrapper.InstanceMT["GET"]) do
                if (Object:IsA(g) or g == "Global") then
                    for t, v in pairs(x) do
                        for str in string.gmatch(t .. ",", "(%w+),")  do
                            if (i == str) then
								if typeof(v) == "function" then
									return function(...)return Wrapper.Sandbox(v(Wrapper.Unsandbox(self), Wrapper.Unsandbox(...)))end;
                                else
                                    return v;
								end
                            end
                        end
                    end
                end
            end
			if (Object:IsA("Sound") and i == "PlaybackLoudness") then return Wrapper.SoundLoudness[Wrapper.Unsandbox(Object)];end;
            if (Rest == nil) then
				if Wrapper.Sandbox(sGame):GetService(i) then return Wrapper.Sandbox(sGame):GetService(i)end;
                return Wrapper.Sandbox(Object[i]);
            elseif (typeof(Rest) == "function") then
				local isService,Service = pcall(function() return sGame:GetService(i) end)
				if isService and Service then return Wrapper.Sandbox(Service) end
                return function(self, ...)
                    return Wrapper.Sandbox(Rest(Wrapper.Unsandbox(self), Wrapper.Unsandbox(...)))
                end
            end
          	return Wrapper.Sandbox(Object[i]);
        end
		Mt.__newindex = function(self, i, v)
			for g,x in pairs (Wrapper.InstanceMT["SET"]) do 
				if (Object:IsA(g)) then
					for t, v in pairs(x) do 
						for str in string.gmatch( t .. ",", "(%w+),") do 
							if v(Wrapper.Unsandbox(self, i, v)) == true then
								Object[Wrapper.Unsandbox(i)] = Wrapper.Unsandbox(v);
								return
							end
						end
					end
				end
			end
			Object[Wrapper.Unsandbox(i)] = Wrapper.Unsandbox(v);
        end
        Mt.__tostring = function(self) return tostring(Object) end
      --elseif (Type == "") then -- Etc
      end
      Wrapper.Fake[Object] = Replacement;
      Wrapper.Real[Replacement] = Object;
      Unwrap[obi] = Replacement;
    else
      return Wrapper.Fake[Object] or Object;
    end
  end
  return unpack(Unwrap);
end
Wrapper.Unsandbox = function(...)
  local Unsandbox = {...};
  for i,v in pairs (Unsandbox) do Unsandbox[i] = Wrapper.Real[v] or Unsandbox[i]end;
  return unpack(Unsandbox)
end
Wrapper.Services = {
	['contextactionservice'] = Wrapper.ContextActionService;
	["userinputservice"]  = Wrapper.UserInputService;
}
Wrapper.InstanceMT = { 
    ["GET"] = {
		["Global"] = {
			["IsFake,isFake"] = function(self)return true;end;
		};
        ["Player"] = {
			["mouse,Mouse"] = function(self)return Wrapper.Mouse;end;
        };
        ["Players"] = {
            ["localPlayer,LocalPlayer"] = Wrapper.Sandbox(owner)
        };
		["DataModel"] = {
			["getService,GetService"] = function(self,service)
				if Wrapper.Services[service:lower()] then return Wrapper.Sandbox(Wrapper.Services[service:lower()])end;
				return Wrapper.Sandbox(sGame:GetService(service))
			end
		};
		["RunService"] = {
            ["renderstepped,renderStepped,RenderStepped"] =  sGame:GetService("RunService").Stepped;
        }
  };
    ["SET"] = {
  }
}
Wrapper.SoundLoudness = {};
Wrapper.Event.OnServerEvent:Connect(function(FiredBy,Input)
	if FiredBy ~= sOwner then return end
	if Input.MouseEvent then
		Wrapper.Mouse.Target = Input.Target;Wrapper.Mouse.Hit = Input.Hit
		Wrapper.Mouse:TriggerEvent("Move")
	elseif Input.Sound then
		if Wrapper.SoundLoudness[Input.Sound] then Wrapper.SoundLoudness[Input.Sound] = Input.Loudness end
	else
		local Begin = Input.UserInputState == Enum.UserInputState.Begin
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then return Wrapper.Mouse:TriggerEvent(Begin and "Button1Down" or "Button1Up") end
		if Input.UserInputType == Enum.UserInputType.MouseButton2 then return Wrapper.Mouse:TriggerEvent(Begin and "Button2Down" or "Button2Up") end
		for _,Action in pairs(Wrapper.ContextActionService.Actions) do
			for _,Key in pairs(Action.Keys) do if Key==Input.KeyCode then Action.Function(Action.Name,Input.UserInputState,Input) end end
		end
		Wrapper.Mouse:TriggerEvent(Begin and "KeyDown" or "KeyUp",Input.KeyCode.Name:lower());Wrapper.UserInputService:TriggerEvent(Begin and "InputBegan" or "InputEnded",Input,false)
	end
end);
Wrapper.Event.Parent = NLS([[
		local Player = owner;local Sounds = {};local Event = script:WaitForChild("UserInput");local UserInputService = game:GetService("UserInputService");local Mouse = Player:GetMouse();
		local Input = function(Input,gameProcessedEvent)
			if gameProcessedEvent then return end;
			Event:FireServer({KeyCode=Input.KeyCode,UserInputType=Input.UserInputType,UserInputState=Input.UserInputState})
		end
		Event.OnClientEvent:connect(function(Args)
			if Args[1] == "NewSound" and Args[2]:IsA("Sound") then table.insert(Sounds,Args[2]) end
		end)
		UserInputService.InputBegan:Connect(Input);UserInputService.InputEnded:Connect(Input)
		local Hit,Target;while wait(1/30) do
			for x,Sound in pairs(Sounds) do if Sound.Parent then Event:FireServer({["Sound"]=Sound,["Loudness"]=Sound.PlaybackLoudness}) end; end;
			if Hit ~= Mouse.Hit or Target ~= Mouse.Target then
				Hit = Mouse.Hit;Target = Mouse.Target;Event:FireServer({["MouseEvent"]=true,["Target"]=Target,["Hit"]=Hit})
			end
		end]],sOwner.Character)
Instance = {
	["new"] = function(Type,Parent)
		if not Parent then Parent = sOwner.Character end
		local Real = sInstance.new(Type,Wrapper.Unsandbox(Parent))
		if Type:lower() == "sound" then Wrapper.SoundLoudness[Real] = 0;Wrapper.Event:FireClient(sOwner,{"NewSound",Real})end
		return Wrapper.Sandbox(Real)
	end
}
LoadLibrary = function(Library)
	if Library == "RbxUtility" then
		return setmetatable({},{
			__tostring = function() return "RbxUtility" end;
			__index = function(self, Index)
				if Index:lower() == "create" then
					return function(Type)
						return function(Data)
							Data = Data or {}
							local Inst = Instance.new(Type)
							for x,y in pairs(Data) do
								Inst[x] = y
							end
							return Inst
						end
					end
				end
			return sLoadLibrary(Library)[Index]
		end})
	end
	return sLoadLibrary(Library)
end
owner = Wrapper.Sandbox(owner);game = Wrapper.Sandbox(game)

--//Paste script below this line.
