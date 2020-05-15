//
//  PacketTreeGrowFX.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketTreeGrowFX: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .TreeGrowFX
    public var payload: [UInt8] = []
    public var growEffect: Bool = false
    public var x: Int16 = 0
    public var y: Int16 = 0
    public var height: UInt8 = 0
    public var treeGore: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.growEffect = try reader.readBool()
        self.x = try reader.readInt16()
        self.y = try reader.readInt16()
        self.height = try reader.readUInt8()
        self.treeGore = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeBool(growEffect)
        try writer.writeInt16(x)
        try writer.writeInt16(y)
        try writer.writeUInt8(height)
        try writer.writeInt16(treeGore)
        payload.append(contentsOf: writer.data)
    }
}
