//
//  PacketPlayLegacySound.swift
//
//
//  Created by Quentin Berry on 5/22/20.
//

import Foundation
import SwiftyBytes

public struct PacketPlayLegacySound: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayLegacySound
    public var payload: [UInt8] = []
    public var positionX: Float32 = 0
    public var positionY: Float32 = 0
    public var soundId: UInt16 = 0
    public var soundFlags: UInt8 = 0 // BitFlags | 1 = Style, 2 = VolumeScale, 3 = PitchOffset
    public var legacySoundStyle: Int32 = 0
    public var volumeScale: Float32 = 0
    public var pitchOffset: Float32 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.positionX = try reader.readFloat32()
        self.positionY = try reader.readFloat32()
        self.soundId = try reader.readUInt16()
        self.soundFlags = try reader.readUInt8()
        
        if soundFlags.bits[0] == 1{ // Style
            self.legacySoundStyle = try reader.readInt32()
        }
        if soundFlags.bits[1] == 1{ // VolumeScale
            self.volumeScale = try reader.readFloat32()
        }
        if soundFlags.bits[2] == 1{ // PitchOffset
            self.pitchOffset = try reader.readFloat32()
        }
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeFloat32(positionX)
        try writer.writeFloat32(positionY)
        try writer.writeUInt16(soundId)
        try writer.writeUInt8(soundFlags)
        
        if soundFlags.bits[0] == 1{
            try writer.writeInt32(legacySoundStyle)
        }
        if soundFlags.bits[1] == 1{
            try writer.writeFloat32(volumeScale)
        }
        if soundFlags.bits[2] == 1{
            try writer.writeFloat32(pitchOffset)
        }
        payload.append(contentsOf: writer.data.bytes)
    }
}
