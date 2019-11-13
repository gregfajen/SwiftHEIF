//
//  File.swift
//  
//
//  Created by Greg Fajen on 11/13/19.
//

import Foundation
import libheif

class HEIFContext {
    
    let context: OpaquePointer
    
    init() {
        context = heif_context_alloc()
    }
    
    deinit {
        heif_context_free(context)
    }
    
}

class HEIFEncoder {
    
    var encoder: heif_encoder_ptr
    
    init?(context: HEIFContext) {
        var comp = heif_compression_HEVC
        let pointer = OpaquePointer(UnsafeRawPointer(&comp))
        
        let result = heif_context_get_encoder2(context.context, pointer)
        
        let error = result.error
        print("error: \(error.code) \(error.subcode)")
        
        if let encoder = result.encoder {
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
