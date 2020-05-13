//
//  PacketType.swift
//  TerrariaProxyServer
//
//  Created by Quentin Berry on 4/13/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation

public enum TerrariaPacketType: UInt8
{
    case Other = 255
    case ConnectRequest = 1
    case Disconnect = 2
    case ConnectApproval = 3
    case PlayerInfo = 4
    case PlayerInventorySlot = 5
    case RequestWorldInfo = 6 //Continue
    case WorldInfo = 7 
    case TileGetSection = 8
    case Status = 9
    case TileSendSection = 10
    case TileFrameSection = 11
    case PlayerSpawn = 12
    case PlayerUpdate = 13
    case PlayerActive = 14
    case SyncPlayers = 15
    case PlayerHp = 16
    case Tile = 17
    case TimeSet = 18
    case DoorUse = 19
    case TileSendSquare = 20
    case ItemDrop = 21
    case ItemOwner = 22
    case NpcUpdate = 23
    case NpcItemStrike = 24
    case ChatText = 25
    case PlayerDamage = 26
    case ProjectileNew = 27
    case NpcStrike = 28
    case ProjectileDestroy = 29
    case TogglePvp = 30
    case ChestGetContents = 31
    case ChestItem = 32
    case ChestOpen = 33
    case PlaceChest = 34
    case EffectHeal = 35
    case Zones = 36
    case PasswordRequired = 37
    case PasswordSend = 38
    case RemoveItemOwner = 39
    case NpcTalk = 40
    case PlayerAnimation = 41
    case PlayerMana = 42
    case EffectMana = 43
    case PlayerKillMe = 44
    case PlayerTeam = 45
    case SignRead = 46
    case SignNew = 47
    case LiquidSet = 48
    case PlayerSpawnSelf = 49
    case PlayerBuff = 50
    case NpcSpecial = 51
    case ChestUnlock = 52
    case NpcAddBuff = 53
    case NpcUpdateBuff = 54
    case PlayerAddBuff = 55
    case UpdateNPCName = 56
    case UpdateGoodEvil = 57
    case PlayHarp = 58
    case HitSwitch = 59
    case UpdateNPCHome = 60
    case SpawnBossorInvasion = 61
    case PlayerDodge = 62
    case PaintTile = 63
    case PaintWall = 64
    case Teleport = 65
    case PlayerHealOther = 66
    case Placeholder = 67
    case ClientUUID = 68
    case ChestName = 69
    case CatchNPC = 70
    case ReleaseNPC = 71
    case TravellingMerchantInventory = 72
    case TeleportationPotion = 73
    case AnglerQuest = 74
    case CompleteAnglerQuest = 75
    case NumberOfAnglerQuestsCompleted = 76
    case CreateTemporaryAnimation = 77
    case ReportInvasionProgress = 78
    case PlaceObject = 79
    case SyncPlayerChestIndex = 80
    case CreateCombatText = 81
    case LoadNetModule = 82
    case NpcKillCount = 83
    case PlayerStealth = 84
    case ForceItemIntoNearestChest = 85
    case UpdateTileEntity = 86
    case PlaceTileEntity = 87
    case TweakItem = 88
    case PlaceItemFrame = 89
    case UpdateItemDrop = 90
    case EmoteBubble = 91
    case SyncExtraValue = 92
    case SocialHandshake = 93
    case Deprecated = 94
    case KillPortal = 95
    case PlayerTeleportPortal = 96
    case NotifyPlayerNpcKilled = 97
    case NotifyPlayerOfEvent = 98
    case UpdateMinionTarget = 99
    case NpcTeleportPortal = 100
    case UpdateShieldStrengths = 101
    case NebulaLevelUp = 102
    case MoonLordCountdown = 103
    case NpcShopItem = 104
    case GemLockToggle = 105
    case PoofOfSmoke = 106
    case SmartTextMessage = 107
    case WiredCannonShot = 108
    case MassWireOperation = 109
    case MassWireOperationPay = 110
    case ToggleParty = 111
    case TreeGrowFX = 112
    case CrystalInvasionStart = 113
    case CrystalInvasionWipeAll = 114
    case MinionAttackTargetUpdate = 115
    case CrystalInvasionSendWaitTime = 116
    case PlayerHurtV2 = 117
    case PlayerDeathV2 = 118
    case CreateCombatTextExtended = 119
}
