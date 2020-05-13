//
//  PacketFactory.swift
//  TerrariaProxyServer
//
//  Created by Quentin Berry on 5/12/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation
import SwiftyBytes

public enum TerrariaPacketFactory{
    public static func decodePacket(packet: [UInt8]) throws -> TerrariaPacket?{
        let packetData = BinaryReadableData(data: Data(packet))
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
            case .Placeholder:// TODO FINISH EDITING
                return PacketConnectRequest(from: packet)
            case .ClientUUID:
                return PacketConnectRequest(from: packet)
            case .ChestName:
                return PacketConnectRequest(from: packet)
            case .CatchNPC:
                return PacketConnectRequest(from: packet)
            case .ReleaseNPC:
                return PacketConnectRequest(from: packet)
            case .TravellingMerchantInventory:
                return PacketConnectRequest(from: packet)
            case .TeleportationPotion:
                return PacketConnectRequest(from: packet)
            case .AnglerQuest:
                return PacketConnectRequest(from: packet)
            case .CompleteAnglerQuest:
                return PacketConnectRequest(from: packet)
            case .NumberOfAnglerQuestsCompleted:
                return PacketConnectRequest(from: packet)
            case .CreateTemporaryAnimation:
                return PacketConnectRequest(from: packet)
            case .ReportInvasionProgress:
                return PacketConnectRequest(from: packet)
            case .PlaceObject:
                return PacketConnectRequest(from: packet)
            case .SyncPlayerChestIndex:
                return PacketConnectRequest(from: packet)
            case .CreateCombatText:
                return PacketConnectRequest(from: packet)
            case .LoadNetModule:
                return PacketConnectRequest(from: packet)
            case .NpcKillCount:
                return PacketConnectRequest(from: packet)
            case .PlayerStealth:
                return PacketConnectRequest(from: packet)
            case .ForceItemIntoNearestChest:
                return PacketConnectRequest(from: packet)
            case .UpdateTileEntity:
                return PacketConnectRequest(from: packet)
            case .PlaceTileEntity:
                return PacketConnectRequest(from: packet)
            case .TweakItem:
                return PacketConnectRequest(from: packet)
            case .PlaceItemFrame:
                return PacketConnectRequest(from: packet)
            case .UpdateItemDrop:
                return PacketConnectRequest(from: packet)
            case .EmoteBubble:
                return PacketConnectRequest(from: packet)
            case .SyncExtraValue:
                return PacketConnectRequest(from: packet)
            case .SocialHandshake:
                return PacketConnectRequest(from: packet)
            case .Deprecated:
                return PacketConnectRequest(from: packet)
            case .KillPortal:
                return PacketConnectRequest(from: packet)
            case .PlayerTeleportPortal:
                return PacketConnectRequest(from: packet)
            case .NotifyPlayerNpcKilled:
                return PacketConnectRequest(from: packet)
            case .NotifyPlayerOfEvent:
                return PacketConnectRequest(from: packet)
            case .UpdateMinionTarget:
                return PacketConnectRequest(from: packet)
            case .NpcTeleportPortal:
                return PacketConnectRequest(from: packet)
            case .UpdateShieldStrengths:
                return PacketConnectRequest(from: packet)
            case .NebulaLevelUp:
                return PacketConnectRequest(from: packet)
            case .MoonLordCountdown:
                return PacketConnectRequest(from: packet)
            case .NpcShopItem:
                return PacketConnectRequest(from: packet)
            case .GemLockToggle:
                return PacketConnectRequest(from: packet)
            case .PoofOfSmoke:
                return PacketConnectRequest(from: packet)
            case .SmartTextMessage:
                return PacketConnectRequest(from: packet)
            case .WiredCannonShot:
                return PacketConnectRequest(from: packet)
            case .MassWireOperation:
                return PacketConnectRequest(from: packet)
            case .MassWireOperationPay:
                return PacketConnectRequest(from: packet)
            case .ToggleParty:
                return PacketConnectRequest(from: packet)
            case .TreeGrowFX:
                return PacketConnectRequest(from: packet)
            case .CrystalInvasionStart:
                return PacketConnectRequest(from: packet)
            case .CrystalInvasionWipeAll:
                return PacketConnectRequest(from: packet)
            case .MinionAttackTargetUpdate:
                return PacketConnectRequest(from: packet)
            case .CrystalInvasionSendWaitTime:
                return PacketConnectRequest(from: packet)
            case .PlayerHurtV2:
                return PacketConnectRequest(from: packet)
            case .PlayerDeathV2:
                return PacketConnectRequest(from: packet)
            case .CreateCombatTextExtended:
                return PacketConnectRequest(from: packet)
            }
        }
        return nil
    }
}
