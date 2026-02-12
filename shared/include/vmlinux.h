/* Fallback vmlinux.h with common BPF types */
#ifndef __VMLINUX_H__
#define __VMLINUX_H__

typedef unsigned char __u8;
typedef short unsigned int __u16;
typedef unsigned int __u32;
typedef long long unsigned int __u64;
typedef signed char __s8;
typedef short int __s16;
typedef int __s32;
typedef long long int __s64;

typedef __u16 __be16;
typedef __u32 __be32;
typedef __u64 __be64;
typedef __u32 __wsum;

struct __sk_buff {};

#endif
