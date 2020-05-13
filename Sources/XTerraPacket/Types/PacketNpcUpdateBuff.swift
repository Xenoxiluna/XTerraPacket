//
//  PacketNpcUpdateBuff.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketNpcUpdateBuff: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .NpcUpdateBuff
    public var payload: [UInt8] = []
    public var npcId: Int16 = 0
    public var buffId1: UInt8 = 0
    public var time1: Int16 = 0
    public var buffId2: UInt8 = 0
    public var time2: Int16 = 0
    public var buffId3: UInt8 = 0
    public var time3: Int16 = 0
    public var buffId4: UInt8 = 0
    public var time4: Int16 = 0
    public var buffId5: UInt8 = 0
    public var time5: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.npcId = try reader.readInt16()
        self.buffId1 = try reader.readUInt8()
        self.time1 = try reader.readInt16()
        self.buffId2 = try reader.readUInt8()
        self.time2 = try reader.readInt16()
        self.buffId3 = try reader.readUInt8()
        self.time3 = try reader.readInt16()
        self.buffId4 = try reader.readUInt8()
        self.time4 = try reader.readInt16()
        self.buffId5 = try reader.readUInt8()
        self.time5 = try reader.readInt16()
    }
    public func encoded() -> [UInt8]{
        print("Not Implemented")
        return []
    }
    mutating public func encode(){
        print("Not Implemented")
    }
    public func getLength(){
        print("Not Implemented")
    }
}
