/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20131115-64 [Dec  1 2013]
 * Copyright (c) 2000 - 2013 Intel Corporation
 * 
 * Disassembly of SSDT-14.aml, Mon Feb 23 00:04:25 2015
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000006A7 (1703)
 *     Revision         0x01
 *     Checksum         0x9B
 *     OEM ID           "CppcTa"
 *     OEM Table ID     "CppcTabl"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20120913 (538052883)
 */
DefinitionBlock ("SSDT-14.aml", "SSDT", 1, "CppcTa", "CppcTabl", 0x00001000)
{

    External (_PR_.CPU0, ProcessorObj)
    External (_PR_.CPU0._CPC, PkgObj)
    External (_PR_.CPU0._PPC, IntObj)
    External (_PR_.CPU0._PSS, PkgObj)
    External (_PR_.CPU0._TSS, IntObj)
    External (_PR_.CPU1, ProcessorObj)
    External (_PR_.CPU2, ProcessorObj)
    External (_PR_.CPU3, ProcessorObj)
    External (_PR_.CPU4, ProcessorObj)
    External (_PR_.CPU5, ProcessorObj)
    External (_PR_.CPU6, ProcessorObj)
    External (_PR_.CPU7, ProcessorObj)
    External (OSYS, FieldUnitObj)
    External (PDC0, IntObj)
    External (TCNT, FieldUnitObj)

    Scope (\_SB)
    {
        Device (PCCD)
        {
            Name (PCCA, 0x5EF6F018)
            Name (PCCS, 0x00001000)
            Name (PENB, 0x00000001)
            Name (_HID, EisaId ("INT340F"))  // _HID: Hardware ID
            Name (_STR, Unicode ("Collaborative Processor Performance Control (CPPC)"))  // _STR: Description String
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LGreaterEqual (OSYS, 0x07DC))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (TMPP, Package (0x02)
            {
                0x80000000, 
                0x80000000
            })
            Method (PADR, 0, NotSerialized)
            {
                Store (PCCA, Index (TMPP, Zero))
                Store (PCCS, Index (TMPP, One))
                Return (TMPP)
            }

            Method (GPRN, 0, Serialized)
            {
                Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                While (One)
                {
                    Store (ToInteger (TCNT), _T_0)
                    If (LEqual (_T_0, 0x08))
                    {
                        Notify (\_PR.CPU0, 0x83)
                        Notify (\_PR.CPU1, 0x83)
                        Notify (\_PR.CPU2, 0x83)
                        Notify (\_PR.CPU3, 0x83)
                        Notify (\_PR.CPU4, 0x83)
                        Notify (\_PR.CPU5, 0x83)
                        Notify (\_PR.CPU6, 0x83)
                        Notify (\_PR.CPU7, 0x83)
                    }
                    Else
                    {
                        If (LEqual (_T_0, 0x04))
                        {
                            Notify (\_PR.CPU0, 0x83)
                            Notify (\_PR.CPU1, 0x83)
                            Notify (\_PR.CPU2, 0x83)
                            Notify (\_PR.CPU3, 0x83)
                        }
                        Else
                        {
                            If (LEqual (_T_0, 0x02))
                            {
                                Notify (\_PR.CPU0, 0x83)
                                Notify (\_PR.CPU1, 0x83)
                            }
                            Else
                            {
                                Notify (\_PR.CPU0, 0x83)
                            }
                        }
                    }

                    Break
                }
            }

            Name (PCFG, Zero)
            Method (_PTC, 0, NotSerialized)  // _PTC: Processor Throttling Control
            {
                If (LAnd (CondRefOf (\PDC0), LNotEqual (\PDC0, 0x80000000)))
                {
                    If (And (\PDC0, 0x04))
                    {
                        Return (Package (0x02)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x00,               // Bit Width
                                    0x00,               // Bit Offset
                                    0x0000000000000000, // Address
                                    ,)
                            }, 

                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x00,               // Bit Width
                                    0x00,               // Bit Offset
                                    0x0000000000000000, // Address
                                    ,)
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x02)
                        {
                            ResourceTemplate ()
                            {
                                Register (SystemIO, 
                                    0x05,               // Bit Width
                                    0x00,               // Bit Offset
                                    0x0000000000001810, // Address
                                    ,)
                            }, 

                            ResourceTemplate ()
                            {
                                Register (SystemIO, 
                                    0x05,               // Bit Width
                                    0x00,               // Bit Offset
                                    0x0000000000001810, // Address
                                    ,)
                            }
                        })
                    }
                }
                Else
                {
                    Return (Package (0x02)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }
                    })
                }
            }

            Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
            {
                If (CondRefOf (\_PR.CPU0._PSS))
                {
                    Return (\_PR.CPU0._PSS)
                }
                Else
                {
                    Return (Package (0x02)
                    {
                        Package (0x06)
                        {
                            Zero, 
                            Zero, 
                            Zero, 
                            Zero, 
                            Zero, 
                            Zero
                        }, 

                        Package (0x06)
                        {
                            Zero, 
                            Zero, 
                            Zero, 
                            Zero, 
                            Zero, 
                            Zero
                        }
                    })
                }
            }

            Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilites
            {
                If (CondRefOf (\_PR.CPU0._PPC))
                {
                    Return (\_PR.CPU0._PPC)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_TSS, 0, NotSerialized)  // _TSS: Throttling Supported States
            {
                If (CondRefOf (\_PR.CPU0._TSS))
                {
                    Return (\_PR.CPU0._TSS)
                }
                Else
                {
                    Return (Package (0x02)
                    {
                        Package (0x05)
                        {
                            Zero, 
                            Zero, 
                            Zero, 
                            Zero, 
                            Zero
                        }, 

                        Package (0x05)
                        {
                            Zero, 
                            Zero, 
                            Zero, 
                            Zero, 
                            Zero
                        }
                    })
                }
            }

            OperationRegion (PCCO, SystemMemory, PCCA, 0x1000)
            Field (PCCO, AnyAcc, NoLock, Preserve)
            {
                PSIG,   32, 
                PCMD,   16, 
                PSTS,   16, 
                HIP0,   32, 
                NOP0,   32, 
                LNL0,   32, 
                LOP0,   32, 
                GPR0,   32, 
                DPR0,   32, 
                MPR0,   32, 
                HPR0,   32, 
                TOL0,   32, 
                TWR0,   32, 
                CWT0,   32, 
                NCR0,   64, 
                DCR0,   64, 
                PLR0,   32, 
                ENR0,   32, 
                Offset (0x6C), 
                HIP1,   32, 
                NOP1,   32, 
                LNL1,   32, 
                LOP1,   32, 
                GPR1,   32, 
                DPR1,   32, 
                MPR1,   32, 
                HPR1,   32, 
                TOL1,   32, 
                TWR1,   32, 
                CWT1,   32, 
                NCR1,   64, 
                DCR1,   64, 
                PLR1,   32, 
                ENR1,   32, 
                Offset (0xD0), 
                HIP2,   32, 
                NOP2,   32, 
                LNL2,   32, 
                LOP2,   32, 
                GPR2,   32, 
                DPR2,   32, 
                MPR2,   32, 
                HPR2,   32, 
                TOL2,   32, 
                TWR2,   32, 
                CWT2,   32, 
                NCR2,   64, 
                DCR2,   64, 
                PLR2,   32, 
                ENR2,   32, 
                Offset (0x134), 
                HIP3,   32, 
                NOP3,   32, 
                LNL3,   32, 
                LOP3,   32, 
                GPR3,   32, 
                DPR3,   32, 
                MPR3,   32, 
                HPR3,   32, 
                TOL3,   32, 
                TWR3,   32, 
                CWT3,   32, 
                NCR3,   64, 
                DCR3,   64, 
                PLR3,   32, 
                ENR3,   32, 
                Offset (0x198), 
                HIP4,   32, 
                NOP4,   32, 
                LNL4,   32, 
                LOP4,   32, 
                GPR4,   32, 
                DPR4,   32, 
                MPR4,   32, 
                HPR4,   32, 
                TOL4,   32, 
                TWR4,   32, 
                CWT4,   32, 
                NCR4,   64, 
                DCR4,   64, 
                PLR4,   32, 
                ENR4,   32, 
                Offset (0x1FC), 
                HIP5,   32, 
                NOP5,   32, 
                LNL5,   32, 
                LOP5,   32, 
                GPR5,   32, 
                DPR5,   32, 
                MPR5,   32, 
                HPR5,   32, 
                TOL5,   32, 
                TWR5,   32, 
                CWT5,   32, 
                NCR5,   64, 
                DCR5,   64, 
                PLR5,   32, 
                ENR5,   32, 
                Offset (0x260), 
                HIP6,   32, 
                NOP6,   32, 
                LNL6,   32, 
                LOP6,   32, 
                GPR6,   32, 
                DPR6,   32, 
                MPR6,   32, 
                HPR6,   32, 
                TOL6,   32, 
                TWR6,   32, 
                CWT6,   32, 
                NCR6,   64, 
                DCR6,   64, 
                PLR6,   32, 
                ENR6,   32, 
                Offset (0x2C4), 
                HIP7,   32, 
                NOP7,   32, 
                LNL7,   32, 
                LOP7,   32, 
                GPR7,   32, 
                DPR7,   32, 
                MPR7,   32, 
                HPR7,   32, 
                TOL7,   32, 
                TWR7,   32, 
                CWT7,   32, 
                NCR7,   64, 
                DCR7,   64, 
                PLR7,   32, 
                ENR7,   32, 
                Offset (0x328), 
                PBEL,   32, 
                GPER,   32
            }

            Method (PCPC, 0, NotSerialized)
            {
                If (CondRefOf (\_PR.CPU0._CPC))
                {
                    Return (\_PR.CPU0._CPC)
                }
                Else
                {
                    Return (Package (0x01)
                    {
                        Zero
                    })
                }
            }

            Method (PPSS, 0, NotSerialized)
            {
                If (CondRefOf (\_PR.CPU0._PSS))
                {
                    Return (\_PR.CPU0._PSS)
                }
                Else
                {
                    Return (Package (0x01)
                    {
                        Zero
                    })
                }
            }
        }
    }
}

