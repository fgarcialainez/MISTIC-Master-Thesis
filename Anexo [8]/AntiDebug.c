//
//  AntiDebug.c
//  TFM - Protección de Aplicaciones Móviles en iOS
//
//  Created by Felix Garcia Lainez on 25/3/18.
//  Copyright (c) 2018. All rights reserved.
//

#include "AntiDebug.h"

#include <stdlib.h>
#include <assert.h>
#include <unistd.h>
#include <sys/sysctl.h>

// Disable debugging sessions (anti-tampering detection)
void disable_gdb() {
    int                 junk;
    int                 mib[4];
    struct kinfo_proc   info;
    size_t              size;
    info.kp_proc.p_flag = 0;
    mib[0] = CTL_KERN;
    mib[1] = KERN_PROC;
    mib[2] = KERN_PROC_PID;
    mib[3] = getpid();
    size = sizeof(info);
    junk = sysctl(mib, sizeof(mib) / sizeof(*mib), &info, &size, NULL, 0);
    assert(junk == 0);
    
    if((info.kp_proc.p_flag & P_TRACED) != 0) {
        // If debugging session detected then exit application
        exit(-1);
    }
}
