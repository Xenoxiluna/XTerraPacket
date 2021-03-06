//
//  PacketChestOpen.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//  Direction: Client -> Server

import Foundation
import SwiftyBytes

/// Used to "open" a world chest
public struct PacketChestOpen: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ClientToServer
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
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.chestId = try reader.readInt16()
        self.chestX = try reader.readInt16()
        self.chestY = try reader.readInt16()
        self.nameLength = try reader.readUInt8()

        if (self.nameLength >= 0 && self.nameLength <= 20){
            self.chestName = try reader.readVariableLengthString(.utf8)
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
            try writer.writeVariableLengthString(chestName, .utf8)
        }
        payload.append(contentsOf: writer.data.bytes)
    }
}
