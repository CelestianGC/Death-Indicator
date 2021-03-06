function onInit()
	OptionsManager.registerOption2("COMBAT_SHOW_RIP", false, "option_header_combat", "option_label_RIP", "option_entry_cycler", 
			{ labels = "option_val_on", values = "on", baselabel = "option_val_off", baseval = "off", default = "on" });
	OptionsManager.registerOption2("COMBAT_SHOW_RIP_DM", false, "option_header_combat", "option_label_RIP_DM", "option_entry_cycler", 
			{ labels = "option_val_on", values = "on", baselabel = "option_val_off", baseval = "off", default = "on" });
  
  CombatManager.addCombatantFieldChangeHandler("wounds", "onUpdate", updateHealth);
  CombatManager.addCombatantFieldChangeHandler("tokenrefid", "onUpdate", updateHealth);
	DB.addHandler("options.COMBAT_SHOW_RIP", "onUpdate", TokenManager.onOptionChanged);
	DB.addHandler("options.COMBAT_SHOW_RIP_DM", "onUpdate", TokenManager.onOptionChanged);
  
  -- for when options are toggled in settings.
	DB.addHandler("options.COMBAT_SHOW_RIP", "onUpdate", updateCTEntries);
	DB.addHandler("options.COMBAT_SHOW_RIP_DM", "onUpdate", updateCTEntries);  
  Interface.onDesktopInit = onDesktopInit
end

-- we do this to delay it till things are loaded
-- otherwise cold start map tokens come back nil
function onDesktopInit()
  updateCTEntries();
end

function updateCTEntries()
	for _,node in pairs(CombatManager.getCombatantNodes()) do
  updateHealth(node.getChild("wounds"));
	end
end


-- update tokens for health changes
function updateHealth(nodeField)
  local nodeCT = nodeField.getParent();
  local tokenCT = CombatManager.getTokenFromCT(nodeCT);
  if (tokenCT) then
    -- Percent Damage, Status String, Wound Color
    local pDmg, pStatus, sColor = TokenManager2.getHealthInfo(nodeCT);
    
    -- show rip on tokens
    local bOptionShowRIP = OptionsManager.isOption("COMBAT_SHOW_RIP", "on");
    local bOptionShowRIP_DM = OptionsManager.isOption("COMBAT_SHOW_RIP_DM", "on");
    -- display if health 0 or lower and option on
    local bPlayDead = ((pDmg >= 1) and (bOptionShowRIP));
    if User.isHost() then
      bPlayDead = ((pDmg >= 1) and (bOptionShowRIP_DM));
    end
    local widgetDeathIndicator = tokenCT.findWidget("deathindicator");
    if bPlayDead then
      if not widgetDeathIndicator then
        local nWidth, nHeight = tokenCT.getSize();
        local nScale = tokenCT.getScale();
        local sName = DB.getValue(nodeCT,"name","Unknown");
        -- new stuff, adds indicator for "DEAD" on the token. -celestian
        local sDeathTokenName = "token_dead";
        -- sDeathTokenName = sDeathTokenName .. tostring(math.random(5)); -- creates token_dead0,token_dead1,token_dead2,token_dead3,token_dead4,token_dead5 string
        -- figure out if this is a pc token
        local rActor = ActorManager.getActorFromCT(nodeCT);
        local sActorType, nodeActor = ActorManager.getTypeAndNode(rActor);    
        if sActorType == "pc" then
          sDeathTokenName = "token_dead_pc";
        end
        widgetDeathIndicator = tokenCT.addBitmapWidget(sDeathTokenName);
        widgetDeathIndicator.setBitmap(sDeathTokenName);
        widgetDeathIndicator.setName("deathindicator");
        widgetDeathIndicator.setTooltipText(sName .. " has fallen, as if dead.");
        widgetDeathIndicator.setSize(nWidth-20, nHeight-20);
        --widgetDeathIndicator.setFrame(sDeathTokenName, 5, 5, 5, 5);
      end
      widgetDeathIndicator.setVisible(bPlayDead);
    else
      if widgetDeathIndicator then
        widgetDeathIndicator.destroy();
      end
    end
  end
end
