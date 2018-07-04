//
//  IntegrityCheck.c
//  TFM - Protección de Aplicaciones Móviles en iOS
//
//  Created by Felix Garcia Lainez on 26/3/18.
//  Copyright (c) 2018. All rights reserved.
//

#include "IntegrityCheck.h"

#include <dlfcn.h>
#include <pthread/pthread.h>

#include <string.h>
#include <mach-o/fat.h>
#include <mach-o/loader.h>

#import <CommonCrypto/CommonDigest.h>

int checkCodeSignature(const char * originalSignature, char * destination) {
    const struct mach_header * header;
    Dl_info dlinfo;
    
    if (dladdr(checkCodeSignature, &dlinfo) == 0 || dlinfo.dli_fbase == NULL) {
        printf(" Error: Could not resolve symbol xyz");
        
        // End the thread
        pthread_exit(NULL);
    }
    
    while(1) {
        header = dlinfo.dli_fbase;  // Pointer on the Mach-O header
        struct load_command * cmd = (struct load_command *)(header + 1); // First load command

        // Now iterate through load command to find __text section of __TEXT segment
        for (uint32_t i = 0; cmd != NULL && i < header->ncmds; i++) {
            if (cmd->cmd == LC_SEGMENT) {
                // __TEXT load command is a LC_SEGMENT load command
                struct segment_command * segment = (struct segment_command *)cmd;
                
                if (!strcmp(segment->segname, "__TEXT")) {
                    // Stop on __TEXT segment load command and go through sections to find __text section
                    struct section * section = (struct section *)(segment + 1);
                    
                    for (uint32_t j = 0; section != NULL && j < segment->nsects; j++) {
                        if (!strcmp(section->sectname, "__text"))
                            break; // Stop on __text section load command
                        section = (struct section *)(section + 1);
                    }
                    
                    // Get here the __text section address, the __text section size and the
                    // virtual memory address so we can calculate a pointer on the __text section
                    uint32_t * textSectionAddr = (uint32_t *)section->addr;
                    uint32_t textSectionSize = section->size;
                    uint32_t * vmaddr = segment->vmaddr;
                    char * textSectionPtr = (char *)((int)header + (int)textSectionAddr - (int)vmaddr);
                    
                    // Calculate the signature of the data, store the
                    // result in a string and compare to the original one
                    unsigned char digest[CC_MD5_DIGEST_LENGTH];
                    CC_MD5(textSectionPtr, textSectionSize, digest); // Calculate the signature
                    
                    for (int i = 0; i < sizeof(digest); i++) // Fill the signature
                        sprintf(destination + (2 * i), "%02x", destination[i]);
                    
                    return strcmp(originalSignature, destination) == 0; // Verify signatures match
                }
            }
            
            cmd = (struct load_command *)((uint8_t *)cmd + cmd->cmdsize);
        }
    }
}
