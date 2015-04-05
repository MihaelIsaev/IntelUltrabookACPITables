/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20131115-64 [Dec  1 2013]
 * Copyright (c) 2000 - 2013 Intel Corporation
 * 
 * Disassembly of SSDT-0.aml, Mon Feb 23 00:04:25 2015
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000000B1 (177)
 *     Revision         0x01
 *     Checksum         0xD8
 *     OEM ID           "Intel_"
 *     OEM Table ID     "ADebTabl"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20120913 (538052883)
 */
DefinitionBlock ("SSDT-0.aml", "SSDT", 1, "Intel_", "ADebTabl", 0x00001000)
{
    Scope (\)
    {
        Name (DPTR, 0x5EA9E000)
        Name (EPTR, 0x5EAAE000)
        Name (CPTR, 0x5EA9E010)
        Mutex (MMUT, 0x00)
        Method (MDBG, 1, Serialized)
        {
            Store (Acquire (MMUT, 0x03E8), Local0)
            If (LEqual (Local0, Zero))
            {
                OperationRegion (ABLK, SystemMemory, CPTR, 0x10)
                Field (ABLK, ByteAcc, NoLock, Preserve)
                {
                    AAAA,   128
                }

                Store (Arg0, AAAA)
                Add (CPTR, 0x10, CPTR)
                If (LGreaterEqual (CPTR, EPTR))
                {
                    Add (DPTR, 0x10, CPTR)
                }

                Release (MMUT)
            }

            Return (Local0)
        }
    }
}

