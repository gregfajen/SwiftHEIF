//
//  File.swift
//  
//
//  Created by Greg Fajen on 11/13/19.
//

import Foundation
import libheif

public class HEIFImage {
    
    let image: heif_image_ptr
    
    public init(size: HEIFSize) throws {
        var result: OpaquePointer?
        
        let error = heif_image_create(Int32(size.width),
                                      Int32(size.height),
                                      heif_colorspace_RGB,
                                      heif_chroma_interleaved_RRGGBBAA_LE,
                                      &result)
        if error.exists { throw error }
        
        if let image = result {
            let error = heif_image_add_plane(image, heif_channel_interleaved,
                                             Int32(size.width),
                                             Int32(size.height),
                                             8)
            if error.exists { throw error }
            
            self.image = image
        } else {
            fatalError()
        }
    }
    
    func write(block: (Int, UnsafeMutablePointer<UInt8>)->()) {
        var stride: Int32 = 0
        let data = heif_image_get_plane(image, heif_channel_interleaved, &stride)
        block(Int(stride), data!)
    }
    
}


extension HEIFImage {
    
    func encode() -> HEIFImageHandler {
        let context = HEIFContext()
        let encoder = HEIFEncoder()!
        
        var result: OpaquePointer?
        let error = heif_context_encode_image(context.context, self.image, encoder.encoder, nil, &result)
        
        return HEIFImageHandler(result!)
    }
    
}
