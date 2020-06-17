//
//  PacketChestOpen.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketChestOpen: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .ChestOpen
    public var payload: [UInt8] = []
    public var chestId: Int16 = 0
    public var chestX: Int16 = 0
    public var chestY: Int16 = 0
    public var nameLength: UInt8 = 0
    public var chestName: String = ""
    
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
        self.nameLength = try reader.readUInt8()

        if (self.nameLength >= 0 && self.nameLength <= 20){
            self.chestName = try reader.read7BitEncodedString()
        }
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(chestId)
        try writer.writeInt16(chestX)
        try writer.writeInt16(chestY)
        try writer.writeUInt8(nameLength)
        self.nameLength = UInt8(chestName.count)
        
        if (self.nameLength >= 0 && self.nameLength <= 20){
            try writer.write7BitEncodedString(chestName, encoding: .utf8)
        }
        payload.append(contentsOf: writer.data)
    }
}
