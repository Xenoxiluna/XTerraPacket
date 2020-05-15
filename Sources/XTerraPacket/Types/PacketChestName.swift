//
//  PacketChestName.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketChestName: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .ChestName
    public var payload: [UInt8] = []
    public var chestId: Int16 = 0
    public var chestX: Int16 = 0
    public var chestY: Int16 = 0
    public var name: String = ""
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.chestId = try reader.readInt16()
        self.chestX = try reader.readInt16()
        self.chestY = try reader.readInt16()
        self.name = try reader.read7BitEncodedString()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(chestId)
        try writer.writeInt16(chestX)
        try writer.writeInt16(chestY)
        try writer.write7BitEncodedString(name, encoding: .utf8)
        payload.append(contentsOf: writer.data)
    }
}
