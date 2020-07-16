//
//  NetModulePing.swift
//  
//
//  Created by Quentin Berry on 7/16/20.
//

import Foundation
import SwiftyBytes

/// This is a struct for the Ping NetModule.
public struct NetModulePing: NetModule{
    public var position: SIMD2<Float32> = [0,0]

    public init(){}

    /**
    Call this function to initialize the NetModule with data.
     - Parameters:
        - position : The vanilla chat command you wish to perform as a NetModuleChat.ChatCommandType
     
    ### Usage Example: ###
    ````
     
    ````
    */
    public init(position: SIMD2<Float32>){
        self.position = position
    }

    public mutating func decode(_ reader: BinaryReader) throws{
        self.position = [try reader.readFloat32(),try reader.readFloat32()]
    }
    public mutating func encode(_ writer: BinaryWriter) throws{
        try writer.writeFloat32(self.position[0])
        try writer.writeFloat32(self.position[1])
    }
}
