--- going to use this to just swap out the updateHealthHelper but
-- till I can resolve the fGetHealthInfo ....

function onInit()
  -- use this new updateHealthHelper to include death indicators
  --TokenManager.updateHealthHelper = updateHealthHelper
  
	OptionsManager.registerOption2("COMBAT_SHOW_RIP", false, "option_header_combat", "option_label_RIP", "option_entry_cycler", 
			{ labels = "option_val_on", values = "on", baselabel = "option_val_off", baseval = "off", default = "off" });
	OptionsManager.registerOption2("COMBAT_SHOW_RIP_DM", false, "option_header_combat", "option_label_RIP_DM", "option_entry_cycler", 
			{ labels = "option_val_on", values = "on", baselabel = "option_val_off", baseval = "off", default = "off" });
  
	DB.addHandler("options.COMBAT_SHOW_RIP", "onUpdate", TokenManager.onOptionChanged);
	DB.addHandler("options.COMBAT_SHOW_RIP_DM", "onUpdate", TokenManager.onOptionChanged);  
end

-- function updateHealthHelper(tokenCT, nodeCT)
	-- local sOptTH;
	-- if DB.getValue(nodeCT, "friendfoe", "") == "friend" then
		-- sOptTH = OptionsManager.getOption("TPCH");
	-- else
		-- sOptTH = OptionsManager.getOption("TNPCH");
	-- end
	-- local aWidgets = TokenManager.getWidgetList(tokenCT, "health");

	-- if sOptTH == "off" or sOptTH == "tooltip" then
		-- for _,vWidget in pairs(aWidgets) do
			-- vWidget.destroy();
		-- end
	-- else
		-- local _,sStatus,sColor = fGetHealthInfo(nodeCT);
		
		-- if sOptTH == "bar" or sOptTH == "barhover" then
			-- local w, h = tokenCT.getSize();
		
			-- if h >= TOKEN_HEALTH_MINBAR then
				-- local widgetHealthBar = aWidgets["healthbar"];
				-- if not widgetHealthBar then
					-- widgetHealthBar = tokenCT.addBitmapWidget("healthbar");
					-- widgetHealthBar.sendToBack();
					-- widgetHealthBar.setName("healthbar");
				-- end
				-- if widgetHealthBar then
					-- widgetHealthBar.setColor(sColor);
					-- widgetHealthBar.setTooltipText(sStatus);
					-- widgetHealthBar.setVisible(sOptTH == "bar");
				-- end
			-- end
			-- TokenManager.updateHealthBarScale(tokenCT, nodeCT);
			
			-- if aWidgets["healthdot"] then
				-- aWidgets["healthdot"].destroy();
			-- end
		-- elseif sOptTH == "dot" or sOptTH == "dothover" then
			-- local widgetHealthDot = aWidgets["healthdot"];
			-- if not widgetHealthDot then
				-- widgetHealthDot = tokenCT.addBitmapWidget("healthdot");
				-- widgetHealthDot.setPosition("bottomright", -4, -6);
				-- widgetHealthDot.setName("healthdot");
			-- end
			-- if widgetHealthDot then
				-- widgetHealthDot.setColor(sColor);
				-- widgetHealthDot.setTooltipText(sStatus);
				-- widgetHealthDot.setVisible(sOptTH == "dot");
			-- end

			-- if aWidgets["healthbar"] then
				-- aWidgets["healthbar"].destroy();
			-- end
		-- end
	-- end
  -- -- show rip on tokens
  -- local bOptionShowRIP = OptionsManager.isOption("COMBAT_SHOW_RIP", "on");
  -- local bOptionShowRIP_DM = OptionsManager.isOption("COMBAT_SHOW_RIP_DM", "on");
  -- -- new stuff, adds indicator for "DEAD" on the token. -celestian
  -- --local nPercentHealth = ActorManager2.getPercentWounded2("ct", nodeCT);
  -- local widgetDeathIndicator = tokenCT.findWidget("deathindicator");
  -- local nWidth, nHeight = tokenCT.getSize();
  -- local sName = DB.getValue(nodeCT,"name","Unknown");
  -- local sDeathTokenName = "token_dead";
  -- -- some tweaks I might apply at some point --celestian 
  -- -- this should let someone add randomness to the token
  -- -- sDeathTokenName = sDeathTokenName .. tostring(math.random(5)); -- creates token_dead0,token_dead1,token_dead2,token_dead3,token_dead4,token_dead5 string

  -- -- this makes a PC token different than NPC
  -- local rActor = ActorManager.getActorFromCT(nodeCT);
  -- local sActorType, nodeActor = ActorManager.getTypeAndNode(rActor);    
-- -- Debug.console("manager_token2.lua","updateHealthHelper","rActor",rActor);
-- -- Debug.console("manager_token2.lua","updateHealthHelper","sActorType",sActorType);
-- -- Debug.console("manager_token2.lua","updateHealthHelper","nodeActor",nodeActor);
  -- local nHPMax = DB.getValue(nodeActor,"hptotal",0);
  -- local nWounds = DB.getValue(nodeActor,"wounds",0);
  -- if sActorType == "pc" then
    -- sDeathTokenName = "token_dead_pc";
    -- nHPMax = DB.getValue(nodeActor,"hp.total",0);
    -- nWounds = DB.getValue(nodeActor,"hp.wounds",0);
  -- end
  -- -- display if health 0 or lower and option on
  -- local bPlayDead = ((nWounds >= nHPMax) and (bOptionShowRIP));
  -- if User.isHost() then
    -- bPlayDead = ((nWounds >= nHPMax) and (bOptionShowRIP_DM));
  -- end
-- -- Debug.console("manager_token2.lua","updateHealthHelper","nHPMax",nHPMax);
-- -- Debug.console("manager_token2.lua","updateHealthHelper","nWounds",nWounds);
-- -- Debug.console("manager_token2.lua","updateHealthHelper","bPlayDead",bPlayDead);
  -- if not widgetDeathIndicator then
    -- widgetDeathIndicator = tokenCT.addBitmapWidget(sDeathTokenName);
    -- widgetDeathIndicator.setBitmap(sDeathTokenName);
    -- widgetDeathIndicator.setName("deathindicator");
    -- widgetDeathIndicator.setTooltipText(sName .. " has fallen, as if dead.");
    -- widgetDeathIndicator.setSize(nWidth-20, nHeight-20);
  -- end
  -- -- nPercentHealth is the percent of damage, 1 = 100% or more so dead
  -- -- widgetDeathIndicator.setVisible(nPercentHealth>=1);
  -- widgetDeathIndicator.setVisible(bPlayDead);
  -- -- end new stuff
-- end
