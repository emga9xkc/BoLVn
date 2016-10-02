Version = 1.1
function OnLoad()
    local ToUpdate = {}
    ToUpdate.Version = Version
    ToUpdate.UseHttps = true
    ToUpdate.Host = "raw.githubusercontent.com"
    ToUpdate.VersionPath = "/emga9xkc/BoLVn/master/AutoBotLV30.ver"
    ToUpdate.ScriptPath =  "/emga9xkc/BoLVn/master/AutoBotLV30.lua"
    ToUpdate.SavePath = SCRIPT_PATH.."/AutoBotLV30.lua"
    ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) print("<font color=\"#FF794C\"><b>Thông báo: </b></font> <font color=\"#FFDFBF\">Download thành công phiên bản "..NewVersion..". Ấn F9 2 lần để load lại script </b></font>") end
    ToUpdate.CallbackNoUpdate = function(OldVersion) print("<font color=\"#FF794C\"><b>Thông báo: </b></font> <font color=\"#FFDFBF\">Đây là phiên bản mới nhất không cần update</b></font>") end
    ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color=\"#FF794C\"><b>Thông báo: </b></font> <font color=\"#FFDFBF\">Đang download phiên bản ("..NewVersion.."). Vui lòng chờ...</b></font>") end
    ToUpdate.CallbackError = function(NewVersion) print("<font color=\"#FF794C\"><b>Thông báo: </b></font> <font color=\"#FFDFBF\">Download lỗi. Vui lòng thử lại sau</b></font>") end
    ScriptUpdate(ToUpdate.Version,ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
end

player = GetMyHero()
function OnTick()
	AutoChat()
	veNhaKhiHetMau()
end


iVeNha = 0
iChatBve = true
dangBienVe = false
function veNhaKhiHetMau()
		if myHero.health < 1/3*myHero.maxHealth then
			dongHoCat = GetInventorySlotItem(3157)
			if dongHoCat ~= nil and myHero:CanUseSpell(dongHoCat) == READY then
			CastSpell(dongHoCat)
			end
			iVeNha = iVeNha + 1
			if dangBienVe == false then
				if iChatBve == true then
					SendChat("Gần hết máu, đang chạy ra Baron rồi B về")
					iChatBve = false
				end
			myHero:MoveTo(4600,9626)
			end
		  if iVeNha == 800 then
				dangBienVe = true
				CastSpell(RECALL)
				iVeNha = 0
			end
			if InFountain() then
			dangBienVe = false
			iChatBve = true
			end
		else
			lastHit()
			autoLevel()
			autoMuaDo()
			autoCombo()
			autoTheoSau()
		end
end

function OffDraw()
  for i = 1, heroManager.iCount do
    local player = heroManager:GetHero(i)
    if player and player.path.count > 1 then
      for j = player.path.curPath, player.path.count do
        local p1 = j == player.path.curPath and player or player.path:Path(j-1)
        local p2 = player.path:Path(2)
        DrawLine3D(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, 1, 0xFFFFFFFF)
      end
    end
  end
end

function OnDraw()
  DrawText("Auto Find LoL VN Lv30 ver "..Version.." By BoL Studio VN Crack",20,400,10,0xF9FF3300)
	DrawText("Home: http://gg.gg/bolvn2016",20,400,30,0xF9FF3300)
end




local tick = 0
local delay = 400

function lastHit()
	if player.charName == "Annie" then
		enemyMinions = minionManager(MINION_ENEMY, 600, player, MINION_SORT_HEALTH_ASC)
		enemyMinions:update()
		for _, minion in pairs(enemyMinions.objects) do
			if GetDistance(minion, myHero) <= (myHero.range + 75) and GetTickCount() > tick + delay then
				dmg = getDmg("AD", minion, myHero)
				dmgQ = getDmg("Q", minion, myHero)
				if dmg > minion.health then
					myHero:Attack(minion)
					tick = GetTickCount()
				end
				if dmgQ > minion.health then
					if (myHero:CanUseSpell(_Q) == READY) then
						CastSpell(_Q,minion)
						tick = GetTickCount()
					end
				end
			end
		end
	else
		enemyMinions = minionManager(MINION_ENEMY, 600, player, MINION_SORT_HEALTH_ASC)
		enemyMinions:update()
		for _, minion in pairs(enemyMinions.objects) do
			if GetDistance(minion, myHero) <= (myHero.range + 75) and GetTickCount() > tick + delay then
				dmg = getDmg("AD", minion, myHero)
				if dmg > minion.health then
					myHero:Attack(minion)
					tick = GetTickCount()
				end
			end
		end
	end
end


function autoCombo()
	if player.charName == "Ashe" then
		ts = TargetSelector(TARGET_PRIORITY,600)
		ts:update()
		if (ts.target ~= nil) then
			myHero:Attack(ts.target)
			if (myHero:CanUseSpell(_Q) == READY) then
				CastSpell(_Q, ts.target.x,ts.target.z)
			end
		end
		ts = TargetSelector(TARGET_PRIORITY,1200)
		ts:update()
		if (ts.target ~= nil) then
			if (myHero:CanUseSpell(_W) == READY) then
				CastSpell(_W, ts.target.x,ts.target.z)
			end
		end
		ts = TargetSelector(TARGET_PRIORITY,1200)
		ts:update()
		if (ts.target ~= nil) then
			if (myHero:CanUseSpell(_R) == READY) then
			CastSpell(_R, ts.target.x,ts.target.z)
			end
		end
	elseif player.charName == "Annie" then
		ts = TargetSelector(TARGET_PRIORITY,550)
		ts:update()
		if (ts.target ~= nil) then
			myHero:Attack(ts.target)
		end
		ts = TargetSelector(TARGET_PRIORITY,550)
		ts:update()
		if (ts.target ~= nil) then
			if (myHero:CanUseSpell(_Q) == READY) then
				CastSpell(_Q, ts.target)
			end
		end
		ts = TargetSelector(TARGET_PRIORITY,550)
		ts:update()
		if (ts.target ~= nil) then
			if (myHero:CanUseSpell(_W) == READY) then
				CastSpell(_W, ts.target.x,ts.target.z)
			end
		end
		ts = TargetSelector(TARGET_PRIORITY,550)
		ts:update()
		if (ts.target ~= nil) then
			if (myHero:CanUseSpell(_E) == READY) then
				CastSpell(_E)
			end
		end
		ts = TargetSelector(TARGET_PRIORITY,900)
		ts:update()
		if (ts.target ~= nil) then
			if (myHero:CanUseSpell(_R) == READY) then
			CastSpell(_R, ts.target.x,ts.target.z)
			end
		end
	else
		ts = TargetSelector(TARGET_PRIORITY,myHero.range)
		ts:update()
		if (ts.target ~= nil) then
			if (myHero:CanUseSpell(_Q) == READY) then
				CastSpell(_Q, ts.target)
			end
		end
		ts = TargetSelector(TARGET_PRIORITY,myHero.range)
		ts:update()
		if (ts.target ~= nil) then
			if (myHero:CanUseSpell(_W) == READY) then
				CastSpell(_W, ts.target.x,ts.target.z)
			end
		end
		ts = TargetSelector(TARGET_PRIORITY,myHero.range)
		ts:update()
		if (ts.target ~= nil) then
			if (myHero:CanUseSpell(_E) == READY) then
				CastSpell(_E)
			end
		end
		ts = TargetSelector(TARGET_PRIORITY,myHero.range)
		ts:update()
		if (ts.target ~= nil) then
			if (myHero:CanUseSpell(_R) == READY) then
			CastSpell(_R, ts.target.x,ts.target.z)
			end
		end
	end
end





i = 0
sttHero = 1
chat = true
function autoTheoSau()
	i = i + 1
	if i == 100 then
		Hero = heroManager:getHero(sttHero)
	if Hero.dead == true or Hero.name == "Disabled member" then
			i = 0
			if Hero.charName ~= myHero.charName then
				SendChat(Hero.charName.." Đã Chết!!")
			end
			if sttHero < 4 then
				chat = true
				sttHero = sttHero + 1
			else
				sttHero = 1
			end
		else
			if chat == true then
			SendChat("Đang Đi Theo "..Hero.name)
			end
			x1 = Hero.x
			y1 = Hero.z
			myHero:MoveTo(x1,y1)
			chat = false
		end
	end
	if i == 150 or i == 200 or i == 250 or i == 300 or i == 350 or i == 400 or i == 450 or i == 500 then
		myHero:MoveTo(Hero.x,Hero.z)
		end
	if i == 550 then
		x2 = Hero.x
		y2 = Hero.z
		myHero:MoveTo(x2,y2)
		i = 0
		if x2 == x1 and y2 == y1 then
			SendChat(Hero.charName.." Đứng Yên Khá Lâu, Thay Đổi Tướng")
			if sttHero < 4 then
				chat = true
				sttHero = sttHero + 1
			else
				sttHero = 1
			end
		end
	end
end





giayninja = "chuaMua"
giapmau = "chuaMua"
giapthienthan = "chuaMua"
giaplietsi = "chuaMua"
giaptamlinh = "chuaMua"
giapgai = "chuaMua"
function autoMuaDo()
	giayNinja = GetInventorySlotItem(3047)
	giayThuong = GetInventorySlotItem(1001)
	giapLuoi = GetInventorySlotItem(1029)
	giapGai = GetInventorySlotItem(3075)
	giapLua = GetInventorySlotItem(1031)
	giapTamLinh = GetInventorySlotItem(3065)
	hoaNgoc = GetInventorySlotItem(3067)
	aoChoangAmAnh = GetInventorySlotItem(3211)
	giapLietSi = GetInventorySlotItem(3742)
	daiKhongLo = GetInventorySlotItem(1011)
	giaoThienThan = GetInventorySlotItem(3026)
	aochoangBac = GetInventorySlotItem(1057)
	giapMau = GetInventorySlotItem(3083)
	vongTayPhaLe = GetInventorySlotItem(3801)
	if InFountain() or myHero.dead == true then
		if giayNinja == nil and giayThuong == nil then
				BuyItem(1001)
			end
		if giayNinja == nil and giapLuoi == nil then
				BuyItem(1029)
		end
		if giayNinja == nil then
			BuyItem(3047)
		end

		if giapMau == nil and daiKhongLo == nil then
				BuyItem(1011)
			end
			if giapMau == nil and vongTayPhaLe == nil then
				BuyItem(3801)
			end
			if giapMau == nil and hoaNgoc == nil then
				BuyItem(3067)
			end
		if giapMau == nil then
			BuyItem(3083)
		end
		if giaoThienThan == nil and aochoangBac == nil then
				BuyItem(1057)
			end
			if giaoThienThan == nil and giapLuoi == nil then
				BuyItem(1029)
			end
		if giaoThienThan == nil then
			BuyItem(3026)
		end
			if giapLietSi == nil and daiKhongLo == nil then
				BuyItem(1011)
			end
			if giapLietSi == nil and giapLua == nil then
				BuyItem(1031)
			end
		if giapLietSi == nil then
			BuyItem(3742)
		end
		if giapTamLinh == nil and giapLua == nil then
				BuyItem(1031)
			end
			if giapTamLinh == nil and giapLuoi == nil then
				BuyItem(1029)
			end
		if giapTamLinh == nil then
			BuyItem(3065)
		end
					if giapGai == nil and giapLua == nil then
				BuyItem(1031)
			end
			if giapGai == nil and giapLuoi == nil then
				BuyItem(1029)
			end
		if giapGai == nil then
			BuyItem(3075)
		end

	end
end





function autoMuaDo2()
	giayNinja = GetInventorySlotItem(3047)
	giayThuong = GetInventorySlotItem(1001)
	giapLuoi = GetInventorySlotItem(1029)
	giapGai = GetInventorySlotItem(3075)
	giapLua = GetInventorySlotItem(1031)
	giapTamLinh = GetInventorySlotItem(3065)
	hoaNgoc = GetInventorySlotItem(3067)
	aoChoangAmAnh = GetInventorySlotItem(3211)
	giapLietSi = GetInventorySlotItem(3742)
	daiKhongLo = GetInventorySlotItem(1011)
	giaoThienThan = GetInventorySlotItem(3026)
	aochoangBac = GetInventorySlotItem(1057)
	giapMau = GetInventorySlotItem(3083)
	vongTayPhaLe = GetInventorySlotItem(3801)
	if InFountain() or myHero.dead == true then
		if giayNinja == nil and giayThuong == nil and giayninja == "chuaMua" then
				BuyItem(1001)
			end
		if giayNinja == nil and giapLuoi == nil and giayninja == "chuaMua" then
				BuyItem(1029)
		end
		if giayNinja == nil and giayninja == "chuaMua" then
			BuyItem(3047)
			giayninja = "daMua"
		end

		if giapMau == nil and daiKhongLo == nil and giapmau == "chuaMua" then
				BuyItem(1011)
			end
			if giapMau == nil and vongTayPhaLe == nil and giapmau == "chuaMua" then
				BuyItem(3801)
			end
			if giapMau == nil and hoaNgoc == nil and giapmau == "chuaMua" then
				BuyItem(3067)
			end
		if giapMau == nil and giapmau == "chuaMua" then
			BuyItem(3083)
			giapmau = "daMua"
		end
		if giaoThienThan == nil and aochoangBac == nil and giapthienthan == "chuaMua" then
				BuyItem(1057)
			end
			if giaoThienThan == nil and giapLuoi == nil and giapthienthan == "chuaMua" then
				BuyItem(1029)
			end
		if giaoThienThan == nil and giapthienthan == "chuaMua" then
			BuyItem(3026)
		 giapthienthan = "daMua"
		end
			if giapLietSi == nil and daiKhongLo == nil and giaplietsi == "chuaMua" then
				BuyItem(1011)
			end
			if giapLietSi == nil and giapLua == nil and giaplietsi == "chuaMua" then
				BuyItem(1031)
			end
		if giapLietSi == nil and giaplietsi == "chuaMua" then
			BuyItem(3742)
			giaplietsi = "daMua"
		end
		if giapTamLinh == nil and giapLua == nil and giaptamlinh == "chuaMua" then
				BuyItem(1031)
			end
			if giapTamLinh == nil and giapLuoi == nil and giaptamlinh == "chuaMua" then
				BuyItem(1029)
			end
		if giapTamLinh == nil then
			BuyItem(3065)
		giaptamlinh = "daMua"
		end
					if giapGai == nil and giapLua == nil and giapgai == "chuaMua" then
				BuyItem(1031)
			end
			if giapGai == nil and giapLuoi == nil and giapgai == "chuaMua" then
				BuyItem(1029)
			end
		if giapGai == nil then
			BuyItem(3075)
giapgai = "daMua"
		end

	end
end


level = {}
LevelDaCong = 0
player = GetMyHero()
function autoLevel(value)
	champ=player.charName
	if champ=="Ahri" then level={1,3,2,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3,}
	elseif champ=="Akali" then level={1,3,1,2,1,4,1,3,1,2,4,3,3,2,2,4,3,2,}
	elseif champ=="Alistar" then level={1,3,2,1,3,4,1,3,1,3,4,1,3,2,2,4,2,2,}
	elseif champ=="Amumu" then level={1,3,3,2,3,4,3,2,3,2,4,2,2,1,1,4,1,1,}
	elseif champ=="Anivia" then level={1,3,3,2,3,4,3,1,3,1,4,1,1,2,2,4,2,2,}
	elseif champ=="Annie" then level={1,2,3,2,1,4,1,2,1,2,4,2,3,3,3,4,3,3,}
	elseif champ=="Ashe" then level={2,1,3,1,3,4,1,3,1,3,4,1,3,2,2,4,2,2,}
	elseif champ=="Blitzcrank" then level={1,3,2,3,2,4,3,2,3,2,4,3,2,1,1,4,1,1,}
	elseif champ=="Brand" then level={2,1,3,2,2,4,2,3,2,3,4,3,3,1,1,4,1,1,}
	elseif champ=="Caitlyn" then level={2,1,1,3,1,4,1,3,1,3,4,3,3,2,2,4,2,2,}
	elseif champ=="Cassiopeia" then level={1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2,}
	elseif champ=="Chogath" then level={1,3,2,2,2,4,2,3,2,3,4,3,3,1,1,4,1,1,}
	elseif champ=="Corki" then level={1,2,1,3,1,4,1,3,1,3,4,3,3,2,2,4,2,2,}
	elseif champ=="DrMundo" then level={1,2,1,3,1,4,1,3,1,3,4,3,2,3,2,4,2,2,}
	elseif champ=="Evelynn" then level={2,3,2,1,3,4,3,3,2,3,4,1,1,1,1,4,2,2,}
	elseif champ=="Ezreal" then level={1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2,}
	elseif champ=="Fiddlesticks" then level={2,3,2,1,3,4,2,2,2,3,4,3,3,1,4,1,1,1,}
	elseif champ=="Fizz" then level={3,1,2,1,2,4,1,1,1,2,4,2,2,3,3,4,3,3,}
	elseif champ=="Galio" then level={1,2,1,3,1,4,1,2,1,2,4,3,3,2,2,4,3,3,}
	elseif champ=="Gangplank" then level={1,2,1,3,1,4,1,2,1,2,4,2,2,3,3,4,3,3,}
	elseif champ=="Garen" then level={3,1,3,2,3,4,3,1,3,1,4,1,1,2,2,4,2,2,}
	elseif champ=="Gragas" then level={1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2,}
	elseif champ=="Graves" then level={1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2,}
	elseif champ=="Heimerdinger" then level={1,2,2,1,1,4,3,2,2,2,4,1,1,3,3,4,1,1,}
	elseif champ=="Irelia" then level={1,2,3,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3,}
	elseif champ=="Janna" then level={3,1,3,2,3,4,3,2,3,2,2,2,4,1,1,4,1,1,}
	elseif champ=="JarvanIV" then level={1,3,1,2,1,4,1,3,2,1,4,3,3,3,2,4,2,2,}
	elseif champ=="Jax" then level={1,2,3,1,1,4,1,2,1,2,4,2,3,2,3,4,3,3,}
	elseif champ=="Karma" then level={1,3,1,2,3,1,3,1,3,1,3,1,3,2,2,2,2,2,}
	elseif champ=="Karthus" then level={1,2,1,3,1,4,1,3,1,3,4,3,2,3,2,4,2,2,}
	elseif champ=="Kassadin" then level={1,2,1,3,1,4,1,3,1,3,4,3,3,2,2,4,2,2,}
	elseif champ=="Katarina" then level={3,1,3,2,3,4,3,1,3,1,4,1,1,2,2,4,2,2,}
	elseif champ=="Kayle" then level={3,2,3,1,3,4,3,2,3,2,4,2,2,1,1,4,1,1,}
	elseif champ=="Kennen" then level={1,2,3,1,2,4,1,2,1,1,4,2,2,3,3,4,3,3,}
	elseif champ=="KogMaw" then level={2,3,2,1,2,4,2,1,2,1,4,1,1,3,3,4,3,3,}
	elseif champ=="Leblanc" then level={1,2,1,3,1,4,1,2,1,2,4,2,3,2,3,4,3,3,}
	elseif champ=="LeeSin" then level={3,2,1,1,1,4,1,2,1,2,4,2,3,2,3,4,3,3,}
	elseif champ=="Leona" then level={1,3,2,2,2,4,2,3,2,3,4,3,3,1,1,4,1,1,}
	elseif champ=="Lux" then level={3,1,3,2,3,4,3,1,3,1,4,1,1,2,2,4,2,2,} --approved
	elseif champ=="Malphite" then level={1,3,1,2,1,4,1,3,1,3,4,3,2,3,2,4,2,2,}
	elseif champ=="Malzahar" then level={1,3,3,2,3,4,1,3,1,3,4,2,1,2,1,4,2,2,}
	elseif champ=="Maokai" then level={3,2,3,1,3,4,3,2,3,2,4,1,1,2,2,4,1,1,}
	elseif champ=="MasterYi" then level={3,1,3,1,3,4,3,1,3,1,4,1,2,2,2,4,2,2,}
	elseif champ=="MissFortune" then level={2,1,2,3,2,4,2,3,2,3,4,3,3,1,1,4,1,1,}
	elseif champ=="Mordekaiser" then level={3,1,3,2,3,4,3,1,3,1,4,1,1,2,2,4,2,2,}
	elseif champ=="Morgana" then level={1,2,2,3,2,4,2,3,2,3,4,3,3,1,1,4,1,1,}
	elseif champ=="Nasus" then level={1,2,1,3,1,4,1,2,1,2,4,2,3,2,3,4,3,3,}
	elseif champ=="Nidalee" then level={2,3,1,3,1,4,3,2,3,1,4,3,1,1,2,4,2,2,}
	elseif champ=="Nocturne" then level={1,2,1,3,1,4,1,3,1,3,4,3,3,2,2,4,2,2,}
	elseif champ=="Nunu" then level={3,1,3,2,1,4,3,1,3,1,4,1,3,2,2,4,2,2,}
	elseif champ=="Olaf" then level={2,1,2,3,3,4,3,3,3,1,4,2,1,1,2,4,2,1,}
	elseif champ=="Orianna" then level={1,2,1,3,1,4,1,2,1,2,4,2,2,3,3,4,3,3,}
	elseif champ=="Pantheon" then level={1,2,3,1,1,4,1,3,1,3,4,3,2,3,2,4,2,2,}
	elseif champ=="Poppy" then level={3,2,1,1,1,4,1,2,1,2,2,2,3,3,3,3,4,4,}
	elseif champ=="Rammus" then level={1,2,3,3,3,4,3,2,3,2,4,2,2,1,1,4,1,1,}
	elseif champ=="Renekton" then level={2,1,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3,}
	elseif champ=="Riven" then level={1,2,3,2,2,4,2,3,2,3,4,3,3,1,1,4,1,1,}
	elseif champ=="Rumble" then level={1,3,2,1,1,4,2,1,1,3,4,2,3,2,3,4,2,3,}
	elseif champ=="Ryze" then level={2,1,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3,}
	elseif champ=="Sejuani" then level={2,1,3,3,2,4,3,2,3,3,4,2,1,2,1,4,1,1,}
	elseif champ=="Shaco" then level={2,3,1,3,3,4,3,2,3,2,4,2,2,1,1,4,1,1,}
	elseif champ=="Shen" then level={1,2,1,3,1,4,1,3,1,3,4,3,3,2,2,4,2,2,}
	elseif champ=="Shyvana" then level={2,1,2,3,2,4,2,1,2,1,4,1,1,3,3,4,3,3,}
	elseif champ=="Singed" then level={3,1,2,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3,}
	elseif champ=="Sion" then level={1,3,3,2,3,4,3,1,3,1,4,1,1,2,2,4,2,2,}
	elseif champ=="Sivir" then level={1,3,1,2,1,4,1,2,1,2,4,2,3,2,3,4,3,3,}
	elseif champ=="Skarner" then level={1,2,1,3,1,4,1,2,1,2,4,2,2,3,3,4,3,3,}
	elseif champ=="Sona" then level={2,1,2,3,2,4,2,1,2,1,4,1,1,3,3,4,3,3,}
	elseif champ=="Soraka" then level={2,3,2,3,1,4,2,3,2,3,4,2,3,1,1,4,1,1,}
	elseif champ=="Swain" then level={2,3,3,1,3,4,3,1,3,1,4,1,1,2,2,4,2,2,}
	elseif champ=="Talon" then level={2,3,1,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3,}
	elseif champ=="Taric" then level={3,2,1,2,2,4,1,2,2,1,4,1,1,3,3,4,3,3,}
	elseif champ=="Teemo" then level={1,3,2,3,1,4,3,3,3,1,4,2,2,1,2,4,2,1,}
	elseif champ=="Tristana" then level={3,2,2,3,2,4,2,1,2,1,4,1,1,1,3,4,3,3,}
	elseif champ=="Trundle" then level={1,2,1,3,1,4,1,2,1,3,4,2,3,2,3,4,2,3,}
	elseif champ=="Tryndamere" then level={3,1,2,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3,}
	elseif champ=="TwistedFate" then level={2,1,1,3,1,4,2,1,2,1,4,2,2,3,3,4,3,3,} -- for TF AP
	elseif champ=="Twitch" then level={1,3,3,2,3,4,3,1,3,1,4,1,1,2,2,1,2,2,}
	elseif champ=="Udyr" then level={1,2,1,3,1,3,2,1,2,1,2,3,2,4,3,3,4,4,}
	elseif champ=="Urgot" then level={3,1,1,2,1,4,1,2,1,3,4,2,3,2,3,4,2,3,}
	elseif champ=="Vayne" then level={1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2,}
	elseif champ=="Veigar" then level={1,3,1,2,1,4,2,2,2,2,4,3,1,1,3,4,3,3,}
	elseif champ=="Viktor" then level={3,2,3,1,3,4,3,1,3,1,4,1,2,1,2,4,2,2,}
	elseif champ=="Vladimir" then level={1,3,1,2,1,4,1,3,1,3,4,3,2,3,2,4,2,2,}
	elseif champ=="Volibear" then level={2,3,2,1,2,4,3,2,1,2,4,3,1,3,1,4,3,1,}
	elseif champ=="Warwick" then level={2,1,1,2,1,4,1,3,1,3,4,3,3,3,2,4,2,2,}
	elseif champ=="MonkeyKing" then level={3,1,2,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2,} --approved
	elseif champ=="Xerath" then level={1,3,1,2,1,4,1,2,1,2,4,2,2,3,3,4,3,3,}
	elseif champ=="XinZhao" then level={1,3,1,2,1,4,1,2,1,2,4,2,2,3,3,4,3,3,}
	elseif champ=="Yorick" then level={2,3,1,3,3,4,3,2,3,1,4,2,1,2,1,4,2,1,}
	elseif champ=="Ziggs" then level={1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2,}
	elseif champ=="Zilean" then level={1,2,3,1,1,4,1,3,1,3,4,2,3,2,3,4,2,2,}
	else level={1,2,3,1,1,4,1,3,1,3,4,2,3,2,3,4,2,2,}
	end
	  if value == 1 then return SPELL_1
  elseif value == 2 then return SPELL_2
  elseif value == 3 then return SPELL_3
  elseif value == 4 then return SPELL_4
  end
	if player.level > LevelDaCong then
    LevelDaCong = LevelDaCong + 1
    LevelSpell(autoLevel(level[LevelDaCong]))
  end
end

autochati = 0
function AutoChat()
autochati = autochati + 1
if autochati%5000 == 0 then
SendChat("Auto Treo Nick Lên Lv30 Tại: http://gg.gg/bolvn2016")
end
end







class "ScriptUpdate"
function ScriptUpdate:__init(LocalVersion,UseHttps, Host, VersionPath, ScriptPath, SavePath, CallbackUpdate, CallbackNoUpdate, CallbackNewVersion,CallbackError)
    self.LocalVersion = LocalVersion
    self.Host = Host
    self.VersionPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(self.Host..VersionPath)..'&rand='..math.random(99999999)
    self.ScriptPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(self.Host..ScriptPath)..'&rand='..math.random(99999999)
    self.SavePath = SavePath
    self.CallbackUpdate = CallbackUpdate
    self.CallbackNoUpdate = CallbackNoUpdate
    self.CallbackNewVersion = CallbackNewVersion
    self.CallbackError = CallbackError
    AddDrawCallback(function() self:OnDraw() end)
    self:CreateSocket(self.VersionPath)
    self.DownloadStatus = 'Connect to Server for VersionInfo'
    AddTickCallback(function() self:GetOnlineVersion() end)
end

function ScriptUpdate:print(str)
    print('<font color="#FFFFFF">'..os.clock()..': '..str)
end

function ScriptUpdate:OnDraw()
    if self.DownloadStatus ~= 'Downloading Script (100%)' and self.DownloadStatus ~= 'Downloading VersionInfo (100%)'then
        DrawText('Download Status: '..(self.DownloadStatus or 'Unknown'),50,10,50,ARGB(0xFF,0xFF,0xFF,0xFF))
    end
end

function ScriptUpdate:CreateSocket(url)
    if not self.LuaSocket then
        self.LuaSocket = require("socket")
    else
        self.Socket:close()
        self.Socket = nil
        self.Size = nil
        self.RecvStarted = false
    end
    self.LuaSocket = require("socket")
    self.Socket = self.LuaSocket.tcp()
    self.Socket:settimeout(0, 'b')
    self.Socket:settimeout(99999999, 't')
    self.Socket:connect('sx-bol.eu', 80)
    self.Url = url
    self.Started = false
    self.LastPrint = ""
    self.File = ""
end

function ScriptUpdate:Base64Encode(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

function ScriptUpdate:GetOnlineVersion()
    if self.GotScriptVersion then return end

    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading VersionInfo (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</s'..'ize>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading VersionInfo ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading VersionInfo (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.File:find('<scr'..'ipt>')
        local ContentEnd, _ = self.File:find('</sc'..'ript>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            self.OnlineVersion = (Base64Decode(self.File:sub(ContentStart + 1,ContentEnd-1)))
            self.OnlineVersion = tonumber(self.OnlineVersion)
            if self.OnlineVersion ~= self.LocalVersion then
                if self.CallbackNewVersion and type(self.CallbackNewVersion) == 'function' then
                    self.CallbackNewVersion(self.OnlineVersion,self.LocalVersion)
                end
                self:CreateSocket(self.ScriptPath)
                self.DownloadStatus = 'Connect to Server for ScriptDownload'
                AddTickCallback(function() self:DownloadUpdate() end)
            else
                if self.CallbackNoUpdate and type(self.CallbackNoUpdate) == 'function' then
                    self.CallbackNoUpdate(self.LocalVersion)
                end
            end
        end
        self.GotScriptVersion = true
    end
end

function ScriptUpdate:DownloadUpdate()
    if self.GotScriptUpdate then return end
    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading Script (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</si'..'ze>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading Script ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading Script (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.NewFile:find('<sc'..'ript>')
        local ContentEnd, _ = self.NewFile:find('</scr'..'ipt>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            local newf = self.NewFile:sub(ContentStart+1,ContentEnd-1)
            local newf = newf:gsub('\r','')
            if newf:len() ~= self.Size then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
                return
            end
            local newf = Base64Decode(newf)
            if type(load(newf)) ~= 'function' then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
            else
                local f = io.open(self.SavePath,"w+b")
                f:write(newf)
                f:close()
                if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
                    self.CallbackUpdate(self.OnlineVersion,self.LocalVersion)
                end
            end
        end
        self.GotScriptUpdate = true
    end
end
