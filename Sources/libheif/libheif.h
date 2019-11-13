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
