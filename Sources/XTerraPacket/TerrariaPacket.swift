//
//  TerrariaPacket.swift
//  
//
//  Created by Quentin Berry on 5/12/20.
//

import Foundation
import SwiftyBytes

public protocol TerrariaPacket{
    var bytes: [UInt8] {get set}
    var length: UInt16 {get set}
    var packetType: TerrariaPacketType {get set}
    var payload: [UInt8] {get set}
    
    init()

    mutating func encodePayload() throws
    mutating func decodePayload() throws
}

extension TerrariaPacket{
    public init(from data: [UInt8]) {
        self.init()
        self.bytes = data
    }
    public func getType() -> TerrariaPacketType {
        return self.packetType
    }
    
    mutating public func decode() throws{
        try decodeHeader()
        try decodePayload()
    }
    
    /// Legacy Packet Structure
    /// Offset  |  Type  |  Description
    ///   0        UInt16   Message Length
    ///   1        UInt8     Message Type
    ///   2    *     Payload
    /// ----------------------------------
    mutating public func decodeHeader() throws{
        let packetData = BinaryReadableData(data: Data(self.bytes))
        let packetReader = BinaryReader(packetData)
        self.length = try packetReader.readUInt16()
        if let ptype = TerrariaPacketType(rawValue: try packetReader.readUInt8()){
            self.packetType = ptype
        }
        self.payload = try packetReader.read(Data(self.bytes).count - packetReader.readIndex)
    }
    
    mutating public func encode() throws{
        try encodePayload()
        calculateLength()
        try encodeHeader()
    }
    
    mutating public func encoded() throws -> [UInt8]{
        try encode()
        return bytes
    }
    
    mutating public func encodeHeader() throws{
        resetBytes()
        let writer = BinaryWriter()
        try writer.writeUInt16(length)
        try writer.writeUInt8(packetType.rawValue)
        bytes.append(contentsOf: writer.data)
    }
    
    mutating public func calculateLength(){
        length = UInt16(payload.count + 3)
    }
    
    public func getLength() -> UInt16 {
        return length
    }
    
    mutating func resetPayload(){
        self.payload = []
    }
    
    mutating func resetBytes(){
        self.bytes = []
    }
}
