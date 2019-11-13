//
//  File.swift
//  
//
//  Created by Greg Fajen on 11/13/19.
//

import Foundation
import libheif

public class HEIFContext {
    
    let context: OpaquePointer
    
    init() {
        context = heif_context_alloc()
    }
    
    deinit {
        heif_context_free(context)
    }
    
}

public class HEIFEncoder {
    
    let encoder: heif_encoder_ptr
    
    init?() {
        let format = heif_compression_HEVC
        var result: OpaquePointer?
        let error = heif_context_get_encoder_for_format(nil, format, &result)
        print("error: \(error.code) \(error.subcode)")
        
        if let encoder = result {
            self.encoder = encoder
        } else {
            return nil
        }
    }
    
    var lossyQuality: Int = 100 {
        didSet {
            heif_encoder_set_lossy_quality(encoder, Int32(lossyQuality))
        }
    }
    
}

public class HEIFImage {
    
    let image: heif_image_ptr
    
    init?(size: HEIFSize) {
        var result: OpaquePointer?
        
        let error = heif_image_create(Int32(size.width),
                                      Int32(size.height),
                                      heif_colorspace_RGB,
                                      heif_chroma_interleaved_RRGGBBAA_LE,
                                      &result)
        
        if let image = result {
            let error = heif_image_add_plane(image, heif_channel_interleaved,
                                             Int32(size.width),
                                             Int32(size.height),
                                             8)
            
            self.image = image
        } else {
            return nil
        }
    }
    
    func write(block: (Int, UnsafeMutablePointer<UInt8>)->()) {
        var stride: Int32 = 0
        let data = heif_image_get_plane(image, heif_channel_interleaved, &stride)
        block(Int(stride), data!)
    }
    
}

public struct HEIFSize {
    let width: Int
    let height: Int
}
