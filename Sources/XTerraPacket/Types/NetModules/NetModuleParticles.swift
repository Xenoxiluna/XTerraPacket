//
//  NetModuleParticles.swift
//  
//
//  Created by Quentin Berry on 7/16/20.
//

import Foundation
import SwiftyBytes

/// This is a struct for the Particles NetModule.
public struct NetModuleParticles: NetModule{
    public var type: UInt8 = 0
    public var position: SIMD2<Float32> = []
    public var velocity: SIMD2<Float32> = []
    public var shaderIndex: Int32 = 0
    public var playerId: UInt8 = 0

    public init(){}

    public init(type: UInt8, position: SIMD2<Float32>, velocity: SIMD2<Float32>, shaderIndex: Int32, playerId: UInt8){
        self.type = type
        self.position = position
        self.velocity = velocity
        self.shaderIndex = shaderIndex
        self.playerId = playerId
    }

    public mutating func decode(_ reader: BinaryReader) throws{
        self.type = try reader.readUInt8()
        self.position = [try reader.readFloat32(),try reader.readFloat32()]
        self.velocity = [try reader.readFloat32(),try reader.readFloat32()]
        self.shaderIndex = try reader.readInt32()
        self.playerId = try reader.readUInt8()
    }
    public mutating func encode(_ writer: BinaryWriter) throws{
        try writer.writeUInt8(self.type)
        try writer.writeFloat32(self.position[0])
        try writer.writeFloat32(self.position[1])
        try writer.writeFloat32(self.velocity[0])
        try writer.writeFloat32(self.velocity[1])
        try writer.writeInt32(self.shaderIndex)
        try writer.writeUInt8(self.playerId)
    }
}
