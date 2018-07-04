//
//  IntegrityCheck.h
//  TFM - Protección de Aplicaciones Móviles en iOS
//
//  Created by Felix Garcia Lainez on 26/3/18.
//  Copyright (c) 2018. All rights reserved.
//

#ifndef IntegrityCheck_h
#define IntegrityCheck_h

#include <stdio.h>

int checkCodeSignature(const char * originalSignature, char * destination);

#endif /* IntegrityCheck_h */
