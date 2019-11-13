//
//  libheif.h
//  
//  Created by Greg Fajen on 11/13/19.
//

#if __linux__

#include "/usr/include/libheif/heif.h"

#elif __APPLE__

#include "/usr/local/Cellar/libheif/1.6.0/include/libheif/heif.h"

#endif

typedef struct heif_encoder *heif_encoder_ptr;

typedef struct {
    heif_encoder_ptr encoder;
    struct heif_error error;
} heif_encoder_result;

heif_encoder_result heif_context_get_encoder2(struct heif_context* context,
                                              const struct heif_encoder_descriptor* encoding) {
    heif_encoder_ptr encoder;
    struct heif_error error = heif_context_get_encoder(context, encoding, &encoder);
    
    heif_encoder_result result;
    result.encoder = encoder;
    result.error = error;
    
    return result;
}
