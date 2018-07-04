//
//  JailbreakDetection.c
//  TFM - Protección de Aplicaciones Móviles en iOS
//
//  Created by Felix Garcia Lainez on 24/3/18.
//  Copyright (c) 2018. All rights reserved.
//

#include "JailbreakDetection.h"

#include <stdlib.h>
#include <unistd.h>

// Check if device is Jailbroken (SandBox Integrity Check).
bool is_jailbroken_device(bool simulator) {
    bool jailbroken = false;
    
    if(!simulator) {
        int pid = fork();
        
        // On success 0 is returned in the child process
        if(!pid){
            exit(0);
        }
        
        // On success return the PID of the child process in the parent.
        // On failure, -1 is returned in the parent.
        if(pid >= 0) {
            jailbroken = true;
        }
    }
    
    return jailbroken;
}

// Check if device is Jailbroken, and if so then exit application (SandBox Integrity Check).
void disable_jailbroken_device(bool simulator) {
    if(!simulator) {
        int pid = fork();
    
        // On success 0 is returned in the child process
        if(!pid){
            exit(0);
        }

        // On success return the PID of the child process in the parent.
        // On failure, -1 is returned in the parent.
        if(pid >= 0) {
            exit(-1);
        }
    }
}
