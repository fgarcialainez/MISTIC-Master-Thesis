//
//  JailbreakDetection.h
//  TFM - Protección de Aplicaciones Móviles en iOS
//
//  Created by Felix Garcia Lainez on 24/3/18.
//  Copyright (c) 2018. All rights reserved.
//

#include <stdbool.h>

#ifndef JailbreakDetection_h
#define JailbreakDetection_h

bool is_jailbroken_device(bool simulator);

void disable_jailbroken_device(bool simulator);

#endif /* JailbreakDetection_h */
