//
//  PacketNpcStrike.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketNpcStrike: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .NpcItemStrike
    public var payload: [UInt8] = []
    public var npcId: Int16 = 0
    public var damage: Int16 = 0
    public var knockback: Float32 = 0
    public var direction: UInt8 = 0
    public var crit: Bool = false
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.npcId = try reader.readInt16()
        self.damage = try reader.readInt16()
        self.knockback = try reader.readFloat32()
        self.direction = try reader.readUInt8()
        self.crit = try reader.readBool()
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
