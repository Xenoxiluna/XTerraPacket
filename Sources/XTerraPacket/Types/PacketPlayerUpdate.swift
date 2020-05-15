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
    public var control: UInt8 = 0
    public var pulley: UInt8 = 0
    public var item: UInt8 = 0
    public var x: Float32 = 0
    public var y: Float32 = 0
    public var velx: Float32 = 0
    public var vely: Float32 = 0
    
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
        self.x = try reader.readFloat32()
        self.y = try reader.readFloat32()
        self.velx = try reader.readFloat32()
        self.vely = try reader.readFloat32()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeUInt8(control)
        try writer.writeUInt8(pulley)
        try writer.writeUInt8(item)
        try writer.writeFloat32(x)
        try writer.writeFloat32(y)
        try writer.writeFloat32(velx)
        try writer.writeFloat32(vely)
        payload.append(contentsOf: writer.data)
    }
}
