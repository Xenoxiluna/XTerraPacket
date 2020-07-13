//
//  PacketSyncExtraValue.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketSyncExtraValue: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .SyncExtraValue
    public var payload: [UInt8] = []
    public var npcIndex: Int16 = 0
    public var extraValue: Float32 = 0
    public var x: Float32 = 0
    public var y: Float32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.npcIndex = try reader.readInt16()
        self.extraValue = try reader.readFloat32()
        self.x = try reader.readFloat32()
        self.y = try reader.readFloat32()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(npcIndex)
        try writer.writeFloat32(extraValue)
        try writer.writeFloat32(x)
        try writer.writeFloat32(y)
        payload.append(contentsOf: writer.data.bytes)
    }
}
