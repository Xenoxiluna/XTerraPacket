//
//  PacketFactory.swift
//  TerrariaProxyServer
//
//  Created by Quentin Berry on 5/12/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation
import SwiftyBytes

/// This is an enum for decoding packets somewhat dynamically
public enum TerrariaPacketFactory{
    
    /**
    Call this function for retriving a TerrariaPacket from an array of UInt8's
    - Parameters:
     - packet : The packet bytes to decode from.
    
    ### Usage Example: ###
    ````
    let packetData: [UInt8] = [25, 0, 13, 2, 72, 20, 0, 0, 0, 255, 16, 129, 69, 0, 240, 237, 69, 23, 143, 26, 65, 0, 0, 0, 0]
    guard var packet = try? TerrariaPacketFactory.decodePacket(packet: packetData) else {
        print("Parse failed!")
        print("Failed bytes: \(packetData))")
    }
    ````
    */
    public static func decodePacket(packet: [UInt8]) throws -> TerrariaPacket?{
        let packetData = BinaryData(data: Data(packet))
        let packetReader = BinaryReader(packetData)
        let length = try packetReader.readUInt16()
        if let ptype = TerrariaPacketType(rawValue: try packetReader.readUInt8()){
            switch ptype{
            case .Other:
                return nil
            case .ConnectRequest:
                return PacketConnectRequest(from: packet)
            case .Disconnect:
                return PacketDisconnect(from: packet)
            case .ConnectApproval:
                return PacketConnectApproval(from: packet)
            case .PlayerInfo:
                return PacketPlayerInfo(from: packet)
            case .PlayerInventorySlot:
                return PacketPlayerInventorySlot(from: packet)
            case .RequestWorldInfo:
                return PacketRequestWorldInfo(from: packet)
            case .WorldInfo:
                return PacketWorldInfo(from: packet)
            case .TileGetSection:
                return PacketTileGetSection(from: packet)
            case .Status:
                return PacketStatus(from: packet)
            case .TileSendSection:
                return PacketTileSendSection(from: packet)
            case .TileFrameSection:
                return PacketTileFrameSection(from: packet)
            case .PlayerSpawn:
                return PacketPlayerSpawn(from: packet)
            case .PlayerUpdate:
                return PacketPlayerUpdate(from: packet)
            case .PlayerActive:
                return PacketPlayerActive(from: packet)
            case .SyncPlayers:
                return PacketSyncPlayers(from: packet)
            case .PlayerHp:
                return PacketPlayerHp(from: packet)
            case .Tile:
                return PacketTile(from: packet)
            case .TimeSet:
                return PacketTimeSet(from: packet)
            case .DoorUse:
                return PacketDoorUse(from: packet)
            case .TileSendSquare:
                return PacketTileSendSquare(from: packet)
            case .ItemDrop:
                return PacketItemDrop(from: packet)
            case .ItemOwner:
                return PacketItemOwner(from: packet)
            case .NpcUpdate:
                return PacketNpcUpdate(from: packet)
            case .NpcItemStrike:
                return PacketNpcItemStrike(from: packet)
            case .ChatText:
                return PacketChatText(from: packet)
            case .PlayerDamage:
                return PacketPlayerDamage(from: packet)
            case .ProjectileNew:
                return PacketProjectileNew(from: packet)
            case .NpcStrike:
                return PacketNpcStrike(from: packet)
            case .ProjectileDestroy:
                return PacketProjectileDestroy(from: packet)
            case .TogglePvp:
                return PacketTogglePvp(from: packet)
            case .ChestGetContents:
                return PacketChestGetContents(from: packet)
            case .ChestItem:
                return PacketChestItem(from: packet)
            case .ChestOpen:
                return PacketChestOpen(from: packet)
            case .PlaceChest:
                return PacketPlaceChest(from: packet)
            case .EffectHeal:
                return PacketEffectHeal(from: packet)
            case .Zones:
                return PacketZones(from: packet)
            case .PasswordRequired:
                return PacketPasswordRequired(from: packet)
            case .PasswordSend:
                return PacketPasswordSend(from: packet)
            case .RemoveItemOwner:
                return PacketRemoveItemOwner(from: packet)
            case .NpcTalk:
                return PacketNpcTalk(from: packet)
            case .PlayerAnimation:
                return PacketPlayerAnimation(from: packet)
            case .PlayerMana:
                return PacketPlayerMana(from: packet)
            case .EffectMana:
                return PacketEffectMana(from: packet)
            case .PlayerKillMe:
                return PacketPlayerKillMe(from: packet)
            case .PlayerTeam:
                return PacketPlayerTeam(from: packet)
            case .SignRead:
                return PacketSignRead(from: packet)
            case .SignNew:
                return PacketSignNew(from: packet)
            case .LiquidSet:
                return PacketLiquidSet(from: packet)
            case .PlayerSpawnSelf:
                return PacketPlayerSpawnSelf(from: packet)
            case .PlayerBuff:
                return PacketPlayerBuff(from: packet)
            case .NpcSpecial:
                return PacketNpcSpecial(from: packet)
            case .ChestUnlock:
                return PacketChestUnlock(from: packet)
            case .NpcAddBuff:
                return PacketNpcAddBuff(from: packet)
            case .NpcUpdateBuff:
                return PacketNpcUpdateBuff(from: packet)
            case .PlayerAddBuff:
                return PacketPlayerAddBuff(from: packet)
            case .UpdateNPCName:
                return PacketUpdateNPCName(from: packet)
            case .UpdateGoodEvil:
                return PacketUpdateGoodEvil(from: packet)
            case .PlayHarp:
                return PacketPlayHarp(from: packet)
            case .HitSwitch:
                return PacketHitSwitch(from: packet)
            case .UpdateNPCHome:
                return PacketUpdateNPCHome(from: packet)
            case .SpawnBossorInvasion:
                return PacketSpawnBossorInvasion(from: packet)
            case .PlayerDodge:
                return PacketPlayerDodge(from: packet)
            case .PaintTile:
                return PacketPaintTile(from: packet)
            case .PaintWall:
                return PacketPaintWall(from: packet)
            case .Teleport:
                return PacketTeleport(from: packet)
            case .PlayerHealOther:
                return PacketPlayerHealOther(from: packet)
            case .Placeholder:
                return PacketPlaceholder(from: packet)
            case .ClientUUID:
                return PacketClientUUID(from: packet)
            case .ChestName:
                return PacketChestName(from: packet)
            case .CatchNPC:
                return PacketCatchNPC(from: packet)
            case .ReleaseNPC:
                return PacketReleaseNPC(from: packet)
            case .TravellingMerchantInventory:
                return PacketTravellingMerchantInventory(from: packet)
            case .TeleportationPotion:
                return PacketTeleportationPotion(from: packet)
            case .AnglerQuest:
                return PacketAnglerQuest(from: packet)
            case .CompleteAnglerQuest:
                return PacketCompleteAnglerQuest(from: packet)
            case .NumberOfAnglerQuestsCompleted:
                return PacketNumberOfAnglerQuestsCompleted(from: packet)
            case .CreateTemporaryAnimation:
                return PacketCreateTemporaryAnimation(from: packet)
            case .ReportInvasionProgress:
                return PacketReportInvasionProgress(from: packet)
            case .PlaceObject:
                return PacketPlaceObject(from: packet)
            case .SyncPlayerChestIndex:
                return PacketSyncPlayerChestIndex(from: packet)
            case .CreateCombatText:
                return PacketCreateCombatText(from: packet)
            case .LoadNetModule:
                return PacketLoadNetModule(from: packet)
            case .NpcKillCount:
                return PacketNpcKillCount(from: packet)
            case .PlayerStealth:
                return PacketPlayerStealth(from: packet)
            case .ForceItemIntoNearestChest:
                return PacketForceItemIntoNearestChest(from: packet)
            case .UpdateTileEntity:
                return PacketUpdateTileEntity(from: packet)
            case .PlaceTileEntity:
                return PacketPlaceTileEntity(from: packet)
            case .TweakItem:
                return PacketTweakItem(from: packet)
            case .PlaceItemFrame:
                return PacketPlaceItemFrame(from: packet)
            case .UpdateItemDrop:
                return PacketUpdateItemDrop(from: packet)
            case .EmoteBubble:
                return PacketEmoteBubble(from: packet)
            case .SyncExtraValue:
                return PacketSyncExtraValue(from: packet)
            case .SocialHandshake:
                return PacketSocialHandshake(from: packet)
            case .Deprecated:
                return PacketDeprecated(from: packet)
            case .KillPortal:
                return PacketKillPortal(from: packet)
            case .PlayerTeleportPortal:
                return PacketPlayerTeleportPortal(from: packet)
            case .NotifyPlayerNpcKilled:
                return PacketNotifyPlayerNpcKilled(from: packet)
            case .NotifyPlayerOfEvent:
                return PacketNotifyPlayerOfEvent(from: packet)
            case .UpdateMinionTarget:
                return PacketUpdateMinionTarget(from: packet)
            case .NpcTeleportPortal:
                return PacketNpcTeleportPortal(from: packet)
            case .UpdateShieldStrengths:
                return PacketUpdateShieldStrengths(from: packet)
            case .NebulaLevelUp:
                return PacketNebulaLevelUp(from: packet)
            case .MoonLordCountdown:
                return PacketMoonLordCountdown(from: packet)
            case .NpcShopItem:
                return PacketNpcShopItem(from: packet)
            case .GemLockToggle:
                return PacketGemLockToggle(from: packet)
            case .PoofOfSmoke:
                return PacketPoofOfSmoke(from: packet)
            case .SmartTextMessage:
                return PacketSmartTextMessage(from: packet)
            case .WiredCannonShot:
                return PacketWiredCannonShot(from: packet)
            case .MassWireOperation:
                return PacketMassWireOperation(from: packet)
            case .MassWireOperationPay:
                return PacketMassWireOperationPay(from: packet)
            case .ToggleParty:
                return PacketToggleParty(from: packet)
            case .TreeGrowFX:
                return PacketTreeGrowFX(from: packet)
            case .CrystalInvasionStart:
                return PacketCrystalInvasionStart(from: packet)
            case .CrystalInvasionWipeAll:
                return PacketCrystalInvasionWipeAll(from: packet)
            case .MinionAttackTargetUpdate:
                return PacketMinionAttackTargetUpdate(from: packet)
            case .CrystalInvasionSendWaitTime:
                return PacketCrystalInvasionSendWaitTime(from: packet)
            case .PlayerHurtV2:
                return PacketPlayerHurtV2(from: packet)
            case .PlayerDeathV2:
                return PacketPlayerDeathV2(from: packet)
            case .CreateCombatTextExtended:
                return PacketCreateCombatTextExtended(from: packet)
            case .Emoji:
                return PacketEmoji(from: packet)
            case .TileEntityDisplayDollItemSync:
                return PacketTileEntityDisplayDollItemSync(from: packet)
            case .RequestTileEntityInteraction:
                return PacketRequestTileEntityInteraction(from: packet)
            case .WeaponsRackTryPlacing:
                return PacketWeaponsRackTryPlacing(from: packet)
            case .TileEntityHatRackItemSync:
                return PacketTileEntityHatRackItemSync(from: packet)
            case .SyncTilePicking:
                return PacketSyncTilePicking(from: packet)
            case .SyncRevengeMarker:
                return PacketSyncRevengeMarker(from: packet)
            case .RemoveRevengeMarker:
                return PacketRemoveRevengeMarker(from: packet)
            case .LandGolfBallInCup:
                return PacketLandGolfBallInCup(from: packet)
            case .FinishedConnectingToServer:
                return PacketFinishedConnectingToServer(from: packet)
            case .FishOutNPC:
                return PacketFishOutNPC(from: packet)
            case .TamperWithNPC:
                return PacketTamperWithNPC(from: packet)
            case .PlayLegacySound:
                return PacketPlayLegacySound(from: packet)
            case .FoodPlatterTryPlacing:
                return PacketFoodPlatterTryPlacing(from: packet)
            case .UpdatePlayerLuckFactors:
                return PacketUpdatePlayerLuckFactors(from: packet)
            case .DeadPlayer:
                return PacketDeadPlayer(from: packet)
            case .SyncCavernMonsterType:
                return PacketSyncCavernMonsterType(from: packet)
            case .RequestNPCBuffRemoval:
                return PacketRequestNPCBuffRemoval(from: packet)
            case .ClientSyncedInventory:
                return PacketClientSyncedInventory(from: packet)
            case .SetCountsAsHostForGameplay:
                return PacketSetCountsAsHostForGameplay(from: packet)
            }
        }
        return nil
    }
}
