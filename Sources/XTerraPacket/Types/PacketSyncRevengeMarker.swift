//
//  PacketSyncRevengeMarker.swift
//
//
//  Created by Quentin Berry on 5/22/20.
//

import Foundation
import SwiftyBytes

public struct PacketSyncRevengeMarker: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .SyncRevengeMarker
    public var payload: [UInt8] = []
    public var uniqueId: Int32 = 0
    public var pos: SIMD2<Float32> = [0,0]
    public var npcId: Int32 = 0
    public var npcHpPercent: Float32 = 0
    public var npcType: Int32 = 0
    public var npcAI: Int32 = 0
    public var coinValue: Int32 = 0
    public var baseValue: Float32 = 0
    public var spawnedFromStatue: Bool = false
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.uniqueId = try reader.readInt32()
        self.pos = [try reader.readFloat32(), try reader.readFloat32()]
        self.npcId = try reader.readInt32()
        self.npcHpPercent = try reader.readFloat32()
        self.npcType = try reader.readInt32()
        self.npcAI = try reader.readInt32()
        self.coinValue = try reader.readInt32()
        self.baseValue = try reader.readFloat32()
        self.spawnedFromStatue = try reader.readBool()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt32(uniqueId)
        try writer.writeFloat32(pos.x)
        try writer.writeFloat32(pos.y)
        try writer.writeInt32(npcId)
        try writer.writeFloat32(npcHpPercent)
        try writer.writeInt32(npcType)
        try writer.writeInt32(npcAI)
        try writer.writeInt32(coinValue)
        try writer.writeFloat32(baseValue)
        try writer.writeBool(spawnedFromStatue)
        payload.append(contentsOf: writer.data.bytes)
    }
}
