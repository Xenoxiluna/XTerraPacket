//
//  PacketNebulaLevelUp.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketNebulaLevelUp: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .NebulaLevelUp
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var levelUpType: UInt8 = 0
    public var originX: Float32 = 0
    public var originY: Float32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.levelUpType = try reader.readUInt8()
        self.originX = try reader.readFloat32()
        self.originY = try reader.readFloat32()
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
