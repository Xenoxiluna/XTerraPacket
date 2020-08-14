//
//  TerrariaPacket.swift
//  
//
//  Created by Quentin Berry on 5/12/20.
//

import Foundation
import SwiftyBytes

/// This is a protocol in which all TerrariaPackets should conform to.
public protocol TerrariaPacket{
    var bytes: [UInt8] {get set}
    var length: UInt16 {get set}
    var context: TerrariaPacketContext {get set}
    var packetType: TerrariaPacketType {get set}
    var payload: [UInt8] {get set}
    
    init()

    /**
    Call this function to encode the payload of a terraria packet.
    */
    mutating func encodePayload() throws
    
    /**
    Call this function to decode the payload of a terraria packet.
    */
    mutating func decodePayload() throws
}

/// Legacy Packet Structure
/// Offset  |  Type  |  Description
///   0        UInt16   Message Length
///   1        UInt8     Message Type
///   2    *     Payload
/// ----------------------------------
extension TerrariaPacket{
    public init(from data: [UInt8]) {
        self.init()
        self.bytes = data
    }
    public func getType() -> TerrariaPacketType {
        return self.packetType
    }
    
    /**
    Call this function to conveniently decode the header and the payload of a given packet.
    
    ### Usage Example: ###
    ````
    let packetData: [UInt8] = [25, 0, 13, 2, 72, 20, 0, 0, 0, 255, 16, 129, 69, 0, 240, 237, 69, 23, 143, 26, 65, 0, 0, 0, 0]
    guard var packet = try? TerrariaPacketFactory.decodePacket(packet: packetData) else {
        print("Parse failed!")
        print("Failed bytes: \(packetData))")
    }
     
    do{
        try packet.decode()
        print("Decoded Packet Bytes: \(packet.bytes))")
    }catch{
        print("Decode failed...")
        print("Failed Packet Bytes: \(packet.bytes))")
        return
    }
    ````
    */
    mutating public func decode(_ context: TerrariaPacketContext) throws{
        self.context = context
        try decodeHeader()
        try decodePayload()
    }
    
    /**
    Call this function to decode the header of a terraria packet.
    */
    mutating public func decodeHeader() throws{
        self.context = context
        let packetData = BinaryData(data: Data(self.bytes))
        let packetReader = BinaryReader(packetData)
        self.length = try packetReader.readUInt16()
        if let ptype = TerrariaPacketType(rawValue: try packetReader.readUInt8()){
            self.packetType = ptype
        }
        self.payload = try packetReader.read(Data(self.bytes).count - packetReader.readIndex)
    }
    
    /**
    Call this function to encode the header and payload of a terraria packet.
    */
    mutating public func encode() throws{
        try encodePayload()
        calculateLength()
        try encodeHeader()
        bytes.append(contentsOf: payload)
    }
    
    /**
    Call this function to conveniently encode a terraria packet and retrieve the packet byte array.
    */
    mutating public func encoded() throws -> [UInt8]{
        try encode()
        return bytes
    }
    
    /**
    Call this function to encode the header of a terraria packet.
    */
    mutating public func encodeHeader() throws{
        resetBytes()
        let writer = BinaryWriter()
        try writer.writeUInt16(length)
        try writer.writeUInt8(packetType.rawValue)
        bytes.append(contentsOf: writer.data.bytes)
    }
    
    /**
    Call this function to calculate the length of a terraria packet.
    */
    mutating public func calculateLength(){
        length = UInt16(payload.count + 3)
    }
    
    /**
    Call this function to retrieve the length of a terraria packet.
    */
    public func getLength() -> UInt16 {
        return length
    }
    
    /**
    Call this function to reset the payload of a terraria packet.
    */
    mutating func resetPayload(){
        self.payload = []
    }
    
    /**
    Call this function to reset the byte array of a terraria packet.
    */
    mutating func resetBytes(){
        self.bytes = []
    }
}
