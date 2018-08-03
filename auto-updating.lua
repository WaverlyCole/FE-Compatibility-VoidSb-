local ScriptLink = [[https://pastebin.com/raw/E3XMtx2X]]

--[[Tutorial:
		1: Paste the link of your script above where it says "PASTE LINK HERE"
			Example: local ScriptLink = "https://pastebin.com/raw/E3XMtx2X"
			
		2: Upload this entire script to Pastebin and load using h/[RAW LINK HERE]
		    OR
		   Copy this entire script and in Sb Console type in c/ and press Ctrl + V
--]]
local FeSource = nil;pcall(function()FeSource = game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/WaverlyCole/FE-Compatibility-VoidSb-/master/translate.lua")end);
local ScriptSource = nil;pcall(function()ScriptSource = game:GetService("HttpService"):GetAsync(ScriptLink)end);
if not FeSource then error("Failed to grab update! Try again later.",0)end;if not ScriptSource then error("Failed to get link!",0)end;
local FeConversion = loadstring(FeSource);local FeSucc,FeErr = pcall(FeConversion);if not FeSucc then warn(FeErr)error("Failed to initiate! Try again later.",0) end;
local Script = loadstring(ScriptSource);local Succ,Err = pcall(Script);if not Succ then warn(Err)error("Error loading script.",0) end;
