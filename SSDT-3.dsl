/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20131115-64 [Dec  1 2013]
 * Copyright (c) 2000 - 2013 Intel Corporation
 * 
 * Disassembly of SSDT-3.aml, Mon Feb 23 00:04:25 2015
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x0000004E (78)
 *     Revision         0x01
 *     Checksum         0x1A
 *     OEM ID           "MeSsdt"
 *     OEM Table ID     "MeSsdt "
 *     OEM Revision     0x00003000 (12288)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20120913 (538052883)
 */
DefinitionBlock ("SSDT-3.aml", "SSDT", 1, "MeSsdt", "MeSsdt ", 0x00003000)
{
    OperationRegion (MENV, SystemMemory, 0x5EA48C98, 0x01F4)
    Field (MENV, AnyAcc, Lock, Preserve)
    {
        MERV,   32, 
        PTTS,   8, 
        PTTB,   64, 
        Offset (0x1F4)
    }
}

