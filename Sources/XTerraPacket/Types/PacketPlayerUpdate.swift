//
//  PacketPlayerUpdate.swift
//  
//
//  Created by Quentin Berry on 5/10/20.
//

import Foundation
import SwiftyBytes

public struct PacketPlayerUpdate: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayerUpdate
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var control: UInt8 = 0 // Bit Flags - ControlUp = 1, ControlDown = 2, ControlLeft = 4, ControlRight = 8, ControlJump = 16, ControlUseItem = 32, Direction = 64|
    public var pulley: UInt8 = 0 // Bit Flags -  0 = None, 1 = Direction, 2 = Direction, 4 = Update Velocity, 8 = Vortex Stealth Active, 16 = Gravity Direction, 32 = Shield Raised|
    public var item: UInt8 = 0
    public var positionX: Float32 = 0
    public var positionY: Float32 = 0
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
        self.control = try reader.readUInt8()
        self.pulley = try reader.readUInt8()
        self.item = try reader.readUInt8()
        self.positionX = try reader.readFloat32()
        self.positionY = try reader.readFloat32()
        
        // Only read if Update Velocity is set
        if (self.pulley & (1 << 2)) != 0{
            self.velocityX = try reader.readFloat32()
            self.velocityY = try reader.readFloat32()
        }
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeUInt8(control)
        try writer.writeUInt8(pulley)
        try writer.writeUInt8(item)
        try writer.writeFloat32(positionX)
        try writer.writeFloat32(positionY)
        
        if (self.pulley & (1 << 2)) != 0{
            try writer.writeFloat32(velocityX)
            try writer.writeFloat32(velocityY)
        }
        payload.append(contentsOf: writer.data)
    }
}
