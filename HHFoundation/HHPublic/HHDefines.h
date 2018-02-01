//
//  HHMarco.h
//  Pods
//
//  Created by xheng on 7/11/17.
//

#ifndef HHDefines_h
#define HHDefines_h

#ifdef __cplusplus

#define HH_EXTERN extern "C" __attribute__((visibility ("default")))

#else

#define HH_EXTERN extern __attribute__((visibility ("default")))

#endif

#endif /* HHDefines_h */
