//
//  PacketTeleport.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketTeleport: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .Teleport
    public var payload: [UInt8] = []
    public var flags: UInt8 = 0
    public var targetId: Int16 = 0
    public var x: Float32 = 0
    public var y: Float32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.flags = try reader.readUInt8()
        self.targetId = try reader.readInt16()
        self.x = try reader.readFloat32()
        self.y = try reader.readFloat32()
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
