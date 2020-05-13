//
//  PacketPlayerTeleportPortal.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketPlayerTeleportPortal: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayerTeleportPortal
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var portalColorIndex: Int16 = 0
    public var newPositionX: Float32 = 0
    public var newPositionY: Float32 = 0
    public var velocityX: Float32 = 0
    public var velocityY: Float32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.portalColorIndex = try reader.readInt16()
        self.newPositionX = try reader.readFloat32()
        self.newPositionY = try reader.readFloat32()
        self.velocityX = try reader.readFloat32()
        self.velocityY = try reader.readFloat32()
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
