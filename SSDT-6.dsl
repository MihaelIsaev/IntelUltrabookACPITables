/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20131115-64 [Dec  1 2013]
 * Copyright (c) 2000 - 2013 Intel Corporation
 * 
 * Disassembly of SSDT-6.aml, Mon Feb 23 00:04:25 2015
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00001AA5 (6821)
 *     Revision         0x01
 *     Checksum         0xFC
 *     OEM ID           "INTEL "
 *     OEM Table ID     "HSW-FFRD"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20120913 (538052883)
 */
DefinitionBlock ("SSDT-6.aml", "SSDT", 1, "INTEL ", "HSW-FFRD", 0x00001000)
{

    External (_SB_.GP2A, MethodObj)    // 2 Arguments
    External (_SB_.GP2B, MethodObj)    // 2 Arguments
    External (_SB_.GP2N, MethodObj)    // 2 Arguments
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.HDEF, DeviceObj)
    External (_SB_.PCI0.I2C0, DeviceObj)
    External (_SB_.PCI0.I2C0.SHUB, DeviceObj)
    External (_SB_.PCI0.I2C1, DeviceObj)
    External (_SB_.PCI0.I2C1.TPD1, DeviceObj)
    External (_SB_.PCI0.I2C1.TPD7, DeviceObj)
    External (_SB_.PCI0.I2C1.TPD8, DeviceObj)
    External (_SB_.PCI0.I2C1.TPL0, DeviceObj)
    External (_SB_.PCI0.RP01, DeviceObj)
    External (_SB_.PCI0.RP01.L23E, FieldUnitObj)
    External (_SB_.PCI0.RP01.L23R, FieldUnitObj)
    External (_SB_.PCI0.RP01.LASX, FieldUnitObj)
    External (_SB_.PCI0.RP01.LDIS, FieldUnitObj)
    External (_SB_.PCI0.RP01.LEDM, FieldUnitObj)
    External (_SB_.PCI0.SAT0, DeviceObj)
    External (_SB_.PCI0.SAT0.PRT1, DeviceObj)
    External (_SB_.PCI0.SAT0.PRT2, DeviceObj)
    External (_SB_.PCI0.SDHC, DeviceObj)
    External (_SB_.PCI0.SDHC.WI01, DeviceObj)
    External (_SB_.PCI0.XHC_, DeviceObj)
    External (_SB_.PCI0.XHC_.MEMB, FieldUnitObj)
    External (_SB_.PCI0.XHC_.RHUB, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS05, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS06, DeviceObj)
    External (_SB_.RDGP, MethodObj)    // 1 Arguments
    External (_SB_.WTGP, MethodObj)    // 2 Arguments
    External (ADBG, MethodObj)    // 1 Arguments
    External (AUDD, FieldUnitObj)
    External (BHB_, IntObj)
    External (BID_, FieldUnitObj)
    External (CKEN, FieldUnitObj)
    External (GO08, FieldUnitObj)
    External (GO45, FieldUnitObj)
    External (GO51, FieldUnitObj)
    External (GS08, FieldUnitObj)
    External (GS45, FieldUnitObj)
    External (GS51, FieldUnitObj)
    External (HDAD, FieldUnitObj)
    External (I20D, FieldUnitObj)
    External (I21D, FieldUnitObj)
    External (IC0D, FieldUnitObj)
    External (IC1D, FieldUnitObj)
    External (IC1S, FieldUnitObj)
    External (PEP0, FieldUnitObj)
    External (PMFS, FieldUnitObj)
    External (RCG0, FieldUnitObj)
    External (RIC0, FieldUnitObj)
    External (RTD3, FieldUnitObj)
    External (SDS0, FieldUnitObj)
    External (SDS1, FieldUnitObj)
    External (SHSB, FieldUnitObj)
    External (UAMS, IntObj)
    External (VRRD, FieldUnitObj)
    External (VRSD, FieldUnitObj)

    Name (LONT, Zero)
    Method (SGON, 2, Serialized)
    {
        If (LNotEqual (\_SB.RDGP (Arg0), Arg1))
        {
            Divide (Subtract (Timer, \LONT), 0x2710, , Local0)
            If (LLess (Local0, \VRSD))
            {
                Sleep (Subtract (\VRSD, Local0))
            }

            \_SB.WTGP (Arg0, Arg1)
            Store (Timer, \LONT)
            Return (One)
        }
        Else
        {
            Return (Zero)
        }
    }

    If (LAnd (LEqual (BID, BHB), LEqual (RTD3, One)))
    {
        Scope (\_SB.PCI0.RP01)
        {
            Name (SLOT, One)
            Name (RSTG, 0x4D)
            Name (PWRG, 0x53)
            Name (RONP, One)
            Name (PONP, One)
            Name (NGFF, One)
            Name (SCLK, One)
            Name (WKEN, Zero)
            Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
            {
                Return (0x03)
            }

            Method (_DSW, 3, NotSerialized)  // _DSW: Device Sleep Wake
            {
                ADBG ("_DSW PCIe")
                ADBG (SLOT)
                If (Arg1)
                {
                    Store (Zero, WKEN)
                    ADBG ("PCIE Sx DisWak")
                }
                Else
                {
                    If (LAnd (Arg0, Arg2))
                    {
                        Store (One, WKEN)
                        ADBG ("PCIE D3 En Wak")
                    }
                    Else
                    {
                        Store (Zero, WKEN)
                        ADBG ("PCIE D0 DisWak")
                    }
                }
            }

            PowerResource (PXP, 0x00, 0x0000)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    ADBG ("_STA")
                    ADBG (SLOT)
                    If (LAnd (LEqual (\_SB.RDGP (PWRG), PONP), LEqual (\_SB.RDGP (RSTG), RONP)))
                    {
                        ADBG ("PCIE _STA ON")
                        Return (One)
                    }
                    Else
                    {
                        ADBG ("PCIE _STA OFF")
                        Return (Zero)
                    }
                }

                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                    ADBG ("PCIE _ON")
                    ADBG (SLOT)
                    If (LNot (NGFF))
                    {
                        \_SB.WTGP (PWRG, PONP)
                        Sleep (PEP0)
                    }

                    While (LEqual (PMFS, One))
                    {
                        Stall (0x0A)
                    }

                    Store (Or (ShiftLeft (SCLK, 0x18), ShiftLeft (SCLK, 0x10)
                        ), Local1)
                    Or (Local1, 0x04, Local1)
                    Store (Local1, \CKEN)
                    While (LEqual (PMFS, One))
                    {
                        Stall (0x0A)
                    }

                    \_SB.WTGP (RSTG, RONP)
                    Store (One, L23R)
                    Sleep (0x10)
                    Store (Zero, Local0)
                    While (L23R)
                    {
                        If (LGreater (Local0, 0x04))
                        {
                            ADBG ("PCIE L23R TO")
                            Break
                        }

                        Sleep (0x10)
                        Increment (Local0)
                    }

                    Store (Zero, Local0)
                    While (LEqual (LASX, Zero))
                    {
                        If (LGreater (Local0, 0x7B))
                        {
                            ADBG ("PCIE LASX TO")
                            Break
                        }

                        Sleep (0x10)
                        Increment (Local0)
                    }

                    Store (Zero, LEDM)
                }

                Method (_OFF, 0, Serialized)  // _OFF: Power Off
                {
                    Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                    ADBG ("PCIE _OFF")
                    ADBG (SLOT)
                    Store (One, L23E)
                    Sleep (0x10)
                    Store (Zero, Local0)
                    While (L23E)
                    {
                        If (LGreater (Local0, 0x04))
                        {
                            Break
                        }

                        Sleep (0x10)
                        Increment (Local0)
                    }

                    Store (One, LEDM)
                    While (LEqual (PMFS, One))
                    {
                        Stall (0x0A)
                    }

                    Store (Or (ShiftLeft (SCLK, 0x18), 0x04), Local1)
                    Store (Local1, \CKEN)
                    While (LEqual (PMFS, One))
                    {
                        Stall (0x0A)
                    }

                    \_SB.WTGP (RSTG, Not (RONP))
                    If (LNot (NGFF))
                    {
                        \_SB.WTGP (PWRG, Not (PONP))
                    }

                    Store (One, LDIS)
                    Store (Zero, LDIS)
                    If (WKEN)
                    {
                        While (One)
                        {
                            Store (SLOT, _T_0)
                            If (LEqual (_T_0, 0x03))
                            {
                                Store (One, \GS08)
                                Store (Zero, \GO08)
                            }
                            Else
                            {
                                If (LEqual (_T_0, 0x04))
                                {
                                    Store (One, \GS45)
                                    Store (Zero, \GO45)
                                }
                                Else
                                {
                                    If (LEqual (_T_0, 0x05))
                                    {
                                        Store (One, \GS51)
                                        Store (Zero, \GO51)
                                    }
                                    Else
                                    {
                                    }
                                }
                            }

                            Break
                        }
                    }
                }
            }

            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                PXP
            })
        }

        Scope (\_SB.PCI0.SAT0)
        {
            Method (_PS0, 0, Serialized)  // _PS0: Power State 0
            {
                ADBG ("SATA0 Ctrlr D0")
            }

            Method (_PS3, 0, Serialized)  // _PS3: Power State 3
            {
                ADBG ("SATA0 Ctrlr D3")
            }

            OperationRegion (SMIO, PCI_Config, 0x24, 0x04)
            Field (SMIO, AnyAcc, NoLock, Preserve)
            {
                MBR6,   32
            }

            OperationRegion (ST93, PCI_Config, 0x93, One)
            Field (ST93, AnyAcc, NoLock, Preserve)
            {
                P0P,    1, 
                P1P,    1, 
                P2P,    1, 
                P3P,    1
            }

            Scope (PRT1)
            {
                Name (CONN, One)
                Method (_INI, 0, NotSerialized)  // _INI: Initialize
                {
                    ADBG ("PRT1 _INI")
                    If (LEqual (P1P, Zero))
                    {
                        Store (Zero, CONN)
                        \_SB.WTGP (0x5A, One)
                    }
                }

                PowerResource (P1PR, 0x00, 0x0000)
                {
                    Name (OFTM, Zero)
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (LEqual (\_SB.RDGP (0x5A), One))
                        {
                            ADBG ("SATADir STA OFF")
                            Return (Zero)
                        }
                        Else
                        {
                            ADBG ("SATADir STA ON")
                            Return (One)
                        }
                    }

                    Method (_ON, 0, NotSerialized)  // _ON_: Power On
                    {
                        If (And (RCG0, 0x10))
                        {
                            If (LEqual (CONN, One))
                            {
                                If (LNotEqual (^OFTM, Zero))
                                {
                                    Divide (Subtract (Timer, ^OFTM), 0x2710, , Local0)
                                    Store (Zero, ^OFTM)
                                    If (LLess (Local0, 0x32))
                                    {
                                        Sleep (Subtract (0x32, Local0))
                                    }
                                }

                                ADBG ("SATADir ON")
                                SGON (0x5A, Zero)
                            }
                        }
                    }

                    Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                    {
                        If (And (RCG0, 0x10))
                        {
                            ADBG ("SATADir OFF")
                            Add (\_SB.PCI0.SAT0.MBR6, 0x0198, Local0)
                            OperationRegion (PSTS, SystemMemory, Local0, 0x18)
                            Field (PSTS, DWordAcc, NoLock, Preserve)
                            {
                                CMST,   1, 
                                CSUD,   1, 
                                    ,   2, 
                                CFRE,   1, 
                                Offset (0x10), 
                                SDET,   4, 
                                Offset (0x14), 
                                CDET,   4
                            }

                            If (LOr (LEqual (SDET, One), LEqual (SDET, 0x03)))
                            {
                                Store (Zero, CMST)
                                Store (Zero, CFRE)
                                Store (Zero, CSUD)
                                Store (0x04, CDET)
                                Sleep (0x10)
                                While (LNotEqual (SDET, 0x04))
                                {
                                    Sleep (0x10)
                                }
                            }

                            \_SB.WTGP (0x5A, One)
                            Store (Timer, ^OFTM)
                        }
                    }
                }

                Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                {
                    P1PR
                })
                Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
                {
                    P1PR
                })
            }

            Scope (PRT2)
            {
                Name (CONN, One)
                Method (_INI, 0, NotSerialized)  // _INI: Initialize
                {
                    ADBG ("PRT2 _INI")
                    If (LEqual (P2P, Zero))
                    {
                        Store (Zero, CONN)
                        \_SB.WTGP (0x56, One)
                    }
                }

                PowerResource (P2PR, 0x00, 0x0000)
                {
                    Name (OFTM, Zero)
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (LEqual (\_SB.RDGP (0x56), One))
                        {
                            ADBG ("SATACab STA OFF")
                            Return (Zero)
                        }
                        Else
                        {
                            ADBG ("SATACab STA ON")
                            Return (One)
                        }
                    }

                    Method (_ON, 0, NotSerialized)  // _ON_: Power On
                    {
                        If (And (RCG0, 0x20))
                        {
                            If (LEqual (CONN, One))
                            {
                                If (LNotEqual (^OFTM, Zero))
                                {
                                    Divide (Subtract (Timer, ^OFTM), 0x2710, , Local0)
                                    Store (Zero, ^OFTM)
                                    If (LLess (Local0, 0x32))
                                    {
                                        Sleep (Subtract (0x32, Local0))
                                    }
                                }

                                ADBG ("SATACab ON")
                                SGON (0x56, Zero)
                            }
                        }
                    }

                    Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                    {
                        If (And (RCG0, 0x20))
                        {
                            ADBG ("SATACab OFF")
                            Add (\_SB.PCI0.SAT0.MBR6, 0x0218, Local0)
                            OperationRegion (PSTS, SystemMemory, Local0, 0x18)
                            Field (PSTS, DWordAcc, NoLock, Preserve)
                            {
                                CMST,   1, 
                                CSUD,   1, 
                                    ,   2, 
                                CFRE,   1, 
                                Offset (0x10), 
                                SDET,   4, 
                                Offset (0x14), 
                                CDET,   4
                            }

                            If (LOr (LEqual (SDET, One), LEqual (SDET, 0x03)))
                            {
                                Store (Zero, CMST)
                                Store (Zero, CFRE)
                                Store (Zero, CSUD)
                                Store (0x04, CDET)
                                Sleep (0x10)
                                While (LNotEqual (SDET, 0x04))
                                {
                                    Sleep (0x10)
                                }
                            }

                            \_SB.WTGP (0x56, One)
                            Store (Timer, ^OFTM)
                        }
                    }
                }

                Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                {
                    P2PR
                })
                Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
                {
                    P2PR
                })
            }

            Name (DRV, Zero)
            Name (PWR, Zero)
            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                Name (_T_2, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_1, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                If (LEqual (Arg0, Buffer (0x10)
                        {
                            /* 0000 */   0x9B, 0x14, 0xDB, 0xE4, 0xFE, 0xFC, 0x5B, 0x42,
                            /* 0008 */   0xA6, 0xD8, 0x92, 0x35, 0x7D, 0x78, 0xFC, 0x7F
                        }))
                {
                    While (One)
                    {
                        Store (Arg2, _T_0)
                        If (LEqual (_T_0, Zero))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            If (LEqual (_T_0, One))
                            {
                                Return (Package (0x00) {})
                            }
                            Else
                            {
                                If (LEqual (_T_0, 0x02))
                                {
                                    Store (ToInteger (DerefOf (Index (Arg3, Zero))), DRV)
                                    Store (ToInteger (DerefOf (Index (Arg3, One))), PWR)
                                    While (One)
                                    {
                                        Store (DRV, _T_1)
                                        If (LEqual (_T_1, Ones))
                                        {
                                            If (PWR)
                                            {
                                                \_SB.PCI0.SAT0.PRT1.P1PR._ON ()
                                                \_SB.PCI0.SAT0.PRT2.P2PR._ON ()
                                            }
                                        }

                                        Break
                                    }

                                    Return (Zero)
                                }
                                Else
                                {
                                    If (LEqual (_T_0, 0x03))
                                    {
                                        Store (ToInteger (DerefOf (Index (Arg3, Zero))), DRV)
                                        While (One)
                                        {
                                            Store (DRV, _T_2)
                                            If (LEqual (_T_2, 0xFFFF))
                                            {
                                                Store (One, Local0)
                                                Return (Local0)
                                            }
                                            Else
                                            {
                                                If (LEqual (_T_2, 0x0001FFFF))
                                                {
                                                    If (LEqual (\_SB.PCI0.SAT0.PRT1.P1PR._STA (), Zero))
                                                    {
                                                        Store (Zero, Local0)
                                                    }
                                                    Else
                                                    {
                                                        Store (One, Local0)
                                                    }

                                                    Return (Local0)
                                                }
                                                Else
                                                {
                                                    If (LEqual (_T_2, 0x0002FFFF))
                                                    {
                                                        If (LEqual (\_SB.PCI0.SAT0.PRT2.P2PR._STA (), Zero))
                                                        {
                                                            Store (Zero, Local0)
                                                        }
                                                        Else
                                                        {
                                                            Store (One, Local0)
                                                        }

                                                        Return (Local0)
                                                    }
                                                    Else
                                                    {
                                                        Return (Ones)
                                                    }
                                                }
                                            }

                                            Break
                                        }
                                    }
                                    Else
                                    {
                                        Return (Zero)
                                    }
                                }
                            }
                        }

                        Break
                    }
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Scope (\_SB.PCI0.XHC)
        {
            Name (_S0W, 0x03)  // _S0W: S0 Device Wake State
        }

        Scope (\_SB.PCI0.XHC.RHUB)
        {
            Method (_PS0, 0, Serialized)  // _PS0: Power State 0
            {
                ADBG ("RHUB _PS0")
                Store (Zero, USPP)
            }

            Method (_PS2, 0, Serialized)  // _PS2: Power State 2
            {
                OperationRegion (XHCM, SystemMemory, And (\_SB.PCI0.XHC.MEMB, 0xFFFF0000), 0x0600)
                Field (XHCM, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    XHCV,   16, 
                    Offset (0x480), 
                    HP01,   1, 
                    Offset (0x490), 
                    HP02,   1, 
                    Offset (0x4F0), 
                    HP08,   1, 
                    Offset (0x510), 
                    SP00,   1, 
                    Offset (0x520), 
                    SP01,   1, 
                    Offset (0x540), 
                    SP03,   1
                }

                ADBG ("RHUB PS2")
                If (LEqual (XHCV, 0xFFFF))
                {
                    ADBG ("NO MEM_BASE")
                    Return (Zero)
                }

                If (LAnd (LEqual (HP08, Zero), LEqual (SP03, Zero)))
                {
                    Or (USPP, One, USPP)
                }

                If (LAnd (LEqual (HP01, Zero), LEqual (SP00, Zero)))
                {
                    Or (USPP, 0x02, USPP)
                }

                If (LAnd (LEqual (HP02, Zero), LEqual (SP01, Zero)))
                {
                    Or (USPP, 0x04, USPP)
                }
            }

            Method (_PS3, 0, Serialized)  // _PS3: Power State 3
            {
                ADBG ("RHUB _PS3")
            }
        }

        Scope (\_SB.PCI0.XHC.RHUB.HS06)
        {
            PowerResource (PX06, 0x00, 0x0000)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If (LEqual (\_SB.RDGP (0x54), One))
                    {
                        ADBG ("WWAN _STA ON")
                        Return (One)
                    }
                    Else
                    {
                        ADBG ("WWAN_STA OFF")
                        Return (Zero)
                    }
                }

                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                    ADBG ("WWAN PWR ON")
                    SGON (0x54, One)
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                    ADBG ("WWAN PWR OFF")
                    \_SB.WTGP (0x54, Zero)
                }
            }

            Name (_S0W, 0x02)  // _S0W: S0 Device Wake State
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                \_SB.PCI0.XHC.RHUB.HS06.PX06
            })
            Name (_PR2, Package (0x01)  // _PR2: Power Resources for D2
            {
                \_SB.PCI0.XHC.RHUB.HS06.PX06
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                \_SB.PCI0.XHC.RHUB.HS06.PX06
            })
        }

        Scope (\_SB.PCI0.XHC.RHUB.HS05)
        {
            PowerResource (PX05, 0x00, 0x0000)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If (LEqual (\_SB.RDGP (0x19), One))
                    {
                        ADBG ("USB port 5 Camera _STA ON")
                        Return (One)
                    }
                    Else
                    {
                        ADBG ("USB port 5 Camera _STA OFF")
                        Return (Zero)
                    }
                }

                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                    ADBG ("Camera PWR ON")
                    SGON (0x19, One)
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                    ADBG ("Camera PWR OFF")
                    \_SB.WTGP (0x19, Zero)
                }
            }

            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                \_SB.PCI0.XHC.RHUB.HS05.PX05
            })
            Name (_PR2, Package (0x01)  // _PR2: Power Resources for D2
            {
                \_SB.PCI0.XHC.RHUB.HS05.PX05
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                \_SB.PCI0.XHC.RHUB.HS05.PX05
            })
        }

        Scope (\_SB.PCI0.XHC)
        {
            Name (UPWR, Zero)
            Name (USPP, Zero)
            Method (DUAM, 0, Serialized)
            {
                OperationRegion (XHCM, SystemMemory, And (\_SB.PCI0.XHC.MEMB, 0xFFFF0000), 0x0600)
                Field (XHCM, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    XHCV,   16, 
                    Offset (0x480), 
                    HP01,   1, 
                    Offset (0x490), 
                    HP02,   1, 
                    Offset (0x4F0), 
                    HP08,   1, 
                    Offset (0x510), 
                    SP00,   1, 
                    Offset (0x520), 
                    SP01,   1, 
                    Offset (0x540), 
                    SP03,   1
                }

                If (LNotEqual (\UAMS, Zero))
                {
                    ADBG (" Enter CS USB")
                    Store (Zero, UPWR)
                    If (LEqual (XHCV, 0xFFFF))
                    {
                        If (And (USPP, One))
                        {
                            ADBG (" SD Card PWR OFF")
                            \_SB.WTGP (0x3C, Zero)
                            Or (UPWR, One, UPWR)
                        }

                        If (And (USPP, 0x06))
                        {
                            ADBG ("HS1/SS0 PWR OFF")
                            ADBG ("HS2/SS1 PWR OFF")
                            \_SB.GP2N (0x28, One)
                            \_SB.WTGP (0x0D, Zero)
                            \_SB.WTGP (0x2B, Zero)
                            Or (UPWR, 0x02, UPWR)
                            Or (UPWR, 0x04, UPWR)
                        }
                    }
                    Else
                    {
                        If (LAnd (LEqual (HP08, Zero), LEqual (SP03, Zero)))
                        {
                            ADBG (" SD Card PWR OFF")
                            \_SB.WTGP (0x3C, Zero)
                            Or (UPWR, One, UPWR)
                        }

                        If (LAnd (LAnd (LEqual (HP01, Zero), LEqual (SP00, Zero)), LAnd (
                            LEqual (HP02, Zero), LEqual (SP01, Zero))))
                        {
                            ADBG ("HS1/SS0 PWR OFF")
                            ADBG ("HS2/SS1 PWR OFF")
                            \_SB.GP2N (0x28, One)
                            \_SB.WTGP (0x0D, Zero)
                            \_SB.WTGP (0x2B, Zero)
                            Or (UPWR, 0x02, UPWR)
                            Or (UPWR, 0x04, UPWR)
                        }
                    }
                }
                Else
                {
                    If (And (UPWR, One))
                    {
                        ADBG ("XHCI13 PWR ON")
                        \_SB.WTGP (0x3C, One)
                    }

                    If (And (UPWR, 0x02))
                    {
                        ADBG ("HS1/SS0 PWR ON")
                        \_SB.GP2N (0x28, Zero)
                        \_SB.WTGP (0x0D, One)
                    }

                    If (And (UPWR, 0x04))
                    {
                        ADBG ("HS2/SS1 PWR ON")
                        \_SB.GP2N (0x28, Zero)
                        \_SB.WTGP (0x2B, One)
                    }
                }
            }
        }

        Scope (\_SB.PCI0)
        {
            PowerResource (PAUD, 0x00, 0x0000)
            {
                Name (PSTA, One)
                Name (ONTM, Zero)
                Name (_STA, One)  // _STA: Status
                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                    ADBG ("Audio Codec LON")
                    Store (One, _STA)
                    PUAM ()
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                    ADBG ("Audio Codec LOFF")
                    Store (Zero, _STA)
                    PUAM ()
                }

                Method (PUAM, 0, Serialized)
                {
                    If (LAnd (LEqual (^_STA, Zero), LNotEqual (\UAMS, Zero)))
                    {
                        ADBG ("PAUD-PUAM OFF")
                        If (LEqual (\_SB.RDGP (0x4C), One))
                        {
                            \_SB.WTGP (0x4C, Zero)
                            Store (Zero, ^PSTA)
                            Store (Zero, ^ONTM)
                            ADBG ("Audio Codec OFF")
                        }
                    }
                    Else
                    {
                        ADBG ("PAUD-PUAM ON")
                        If (LNotEqual (^PSTA, One))
                        {
                            SGON (0x4C, One)
                            Store (One, ^PSTA)
                            Store (Timer, ^ONTM)
                            ADBG ("Audio Codec ON")
                        }
                    }
                }
            }
        }

        If (LNot (HDAD))
        {
            Scope (\_SB.PCI0.HDEF)
            {
                Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                {
                    ADBG ("HD-A Ctrlr D0")
                    If (LEqual (\_SB.PCI0.PAUD.ONTM, Zero))
                    {
                        Return (Zero)
                    }

                    Divide (Subtract (Timer, \_SB.PCI0.PAUD.ONTM), 0x2710, , Local0)
                    Add (AUDD, VRRD, Local1)
                    If (LLess (Local0, Local1))
                    {
                        Sleep (Subtract (Local1, Local0))
                    }
                }

                Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                {
                    ADBG ("HD-A Ctrlr D3")
                }

                Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                {
                    \_SB.PCI0.PAUD
                })
            }
        }

        Scope (\_SB.PCI0.I2C0)
        {
            Method (_PR0, 0, NotSerialized)  // _PR0: Power Resources for D0
            {
                Store (Zero, Local0)
                If (LEqual (And (SDS0, One), Zero))
                {
                    Or (0x02, Local0, Local0)
                }

                If (LEqual (Local0, One))
                {
                    Return (Package (0x02)
                    {
                        \_SB.PCI0.I2C0.SHUB.PSEN, 
                        \_SB.PCI0.I2C1.PXTC
                    })
                }

                Return (Package (0x00) {})
            }

            Method (PS0X, 0, Serialized)
            {
                ADBG ("I2C1 _PS0")
                Sleep (I20D)
                If (And (LEqual (RIC0, One), LEqual (\_SB.RDGP (0x2C), One)))
                {
                    \_SB.WTGP (0x31, One)
                    Sleep (0x10)
                }
            }

            Method (PS3X, 0, Serialized)
            {
                ADBG ("I2C0 Ctrlr D3")
                If (And (LEqual (RIC0, One), LEqual (\_SB.RDGP (0x2C), One)))
                {
                    \_SB.WTGP (0x31, Zero)
                    Sleep (0x10)
                }
            }
        }

        Scope (\_SB.PCI0.I2C0.SHUB)
        {
            Method (_PS0, 0, Serialized)  // _PS0: Power State 0
            {
                If (LEqual (\_SB.PCI0.I2C0.SHUB.PSEN.ONTM, Zero))
                {
                    Return (Zero)
                }

                Divide (Subtract (Timer, \_SB.PCI0.I2C0.SHUB.PSEN.ONTM), 0x2710, , Local0)
                Add (IC0D, VRRD, Local1)
                If (LLess (Local0, Local1))
                {
                    Sleep (Subtract (Local1, Local0))
                }
            }

            Method (_PS3, 0, Serialized)  // _PS3: Power State 3
            {
                ADBG ("SHUB D3")
            }

            Method (_PR0, 0, NotSerialized)  // _PR0: Power Resources for D0
            {
                If (And (LEqual (RIC0, One), LEqual (\_SB.RDGP (0x2C), One)))
                {
                    Return (Package (0x02)
                    {
                        PSEN, 
                        \_SB.PCI0.I2C1.PXTC
                    })
                }
                Else
                {
                    Return (Package (0x00) {})
                }
            }

            Method (_PR3, 0, NotSerialized)  // _PR3: Power Resources for D3hot
            {
                If (And (LEqual (RIC0, One), LEqual (\_SB.RDGP (0x2C), One)))
                {
                    Return (Package (0x02)
                    {
                        PSEN, 
                        \_SB.PCI0.I2C1.PXTC
                    })
                }
                Else
                {
                    Return (Package (0x00) {})
                }
            }

            PowerResource (PSEN, 0x00, 0x0000)
            {
                Name (ONTM, Zero)
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If (LEqual (SHSB, Zero))
                    {
                        If (LEqual (\_SB.RDGP (0x2E), One))
                        {
                            ADBG ("SHUB _STA ON")
                            Return (One)
                        }
                    }
                    Else
                    {
                        If (LEqual (\_SB.RDGP (0x46), One))
                        {
                            ADBG ("SHUB _STA ON")
                            Return (One)
                        }
                    }

                    ADBG ("SHUB _STA OFF")
                    Return (Zero)
                }

                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                    If (And (LEqual (RIC0, One), LEqual (\_SB.RDGP (0x2C), One)))
                    {
                        ADBG ("Sensor Hub ON")
                        If (LEqual (SHSB, Zero))
                        {
                            If (LEqual (SGON (0x2E, One), One))
                            {
                                Store (Timer, ^ONTM)
                                \_SB.GP2B (0x0E, One)
                            }
                        }
                        Else
                        {
                            If (LEqual (SGON (0x46, One), One))
                            {
                                Store (Timer, ^ONTM)
                                \_SB.GP2B (0x0E, One)
                            }
                        }
                    }
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                    If (And (LEqual (RIC0, One), LEqual (\_SB.RDGP (0x2C), One)))
                    {
                        ADBG ("Sensor Hub LOFF")
                        \_SB.GP2B (0x0E, Zero)
                        If (LEqual (SHSB, Zero))
                        {
                            \_SB.WTGP (0x2E, Zero)
                        }
                        Else
                        {
                            \_SB.WTGP (0x46, Zero)
                        }

                        Store (Zero, ^ONTM)
                        ADBG ("Sensor Hub OFF")
                        Store (Zero, ^ONTM)
                    }
                }
            }
        }

        Scope (\_SB.PCI0.I2C1)
        {
            Method (PS0X, 0, Serialized)
            {
                ADBG ("I2C1 _PS0")
                Sleep (I21D)
            }

            Method (PS3X, 0, Serialized)
            {
                ADBG ("I2C1 _PS3")
            }

            PowerResource (PXTC, 0x00, 0x0000)
            {
                Name (ONTM, Zero)
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If (LEqual (\_SB.RDGP (0x59), One))
                    {
                        ADBG ("I2C1 _STA ON")
                        Return (One)
                    }
                    Else
                    {
                        ADBG ("I2C1 _STA OFF")
                        Return (Zero)
                    }
                }

                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                    If (LOr (LEqual (\_SB.RDGP (0x59), Zero), LEqual (\_SB.RDGP (0x34), Zero)))
                    {
                        ADBG ("I2C1 PWR ON")
                        \_SB.WTGP (0x34, One)
                        SGON (0x59, One)
                        Store (Timer, ^ONTM)
                        \_SB.GP2A (0x32, One)
                        If (LAnd (LNotEqual (And (SDS1, 0x0800), 0x0800), 
                            LNotEqual (And (SDS1, 0x1000), 0x1000)))
                        {
                            \_SB.GP2A (0x37, One)
                        }
                    }
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                    ADBG ("I2C1 PWR OFF")
                    \_SB.GP2A (0x32, Zero)
                    If (LAnd (LNotEqual (And (SDS1, 0x0800), 0x0800), 
                        LNotEqual (And (SDS1, 0x1000), 0x1000)))
                    {
                        \_SB.GP2A (0x37, Zero)
                    }

                    \_SB.WTGP (0x59, Zero)
                    \_SB.WTGP (0x34, Zero)
                    Store (Zero, ^ONTM)
                }
            }

            Scope (TPL0)
            {
                Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                {
                    If (LEqual (\_SB.PCI0.I2C1.PXTC.ONTM, Zero))
                    {
                        Return (Zero)
                    }

                    Divide (Subtract (Timer, \_SB.PCI0.I2C1.PXTC.ONTM), 0x2710, , Local0)
                    Add (IC1D, VRRD, Local1)
                    If (LLess (Local0, Local1))
                    {
                        Sleep (Subtract (Local1, Local0))
                    }
                }

                Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                {
                    ADBG ("TPL0 D3")
                }

                Method (_PR0, 0, NotSerialized)  // _PR0: Power Resources for D0
                {
                    If (LEqual (And (SDS1, One), One))
                    {
                        Return (Package (0x02)
                        {
                            \_SB.PCI0.I2C0.SHUB.PSEN, 
                            PXTC
                        })
                    }
                    Else
                    {
                        Return (Package (0x00) {})
                    }
                }

                Method (_PR3, 0, NotSerialized)  // _PR3: Power Resources for D3hot
                {
                    If (LEqual (And (SDS1, One), One))
                    {
                        Return (Package (0x02)
                        {
                            \_SB.PCI0.I2C0.SHUB.PSEN, 
                            PXTC
                        })
                    }
                    Else
                    {
                        Return (Package (0x00) {})
                    }
                }
            }

            Scope (TPD1)
            {
                Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                {
                    If (LEqual (\_SB.PCI0.I2C1.PXTC.ONTM, Zero))
                    {
                        Return (Zero)
                    }

                    ADBG ("TPD1 D0")
                    Divide (Subtract (Timer, \_SB.PCI0.I2C1.PXTC.ONTM), 0x2710, , Local0)
                    Add (IC1S, VRRD, Local1)
                    If (LLess (Local0, Local1))
                    {
                        Sleep (Subtract (Local1, Local0))
                    }
                }

                Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                {
                    ADBG ("TPD1 D3")
                }

                Method (_PR0, 0, NotSerialized)  // _PR0: Power Resources for D0
                {
                    If (LEqual (And (SDS1, 0x08), 0x08))
                    {
                        Return (Package (0x02)
                        {
                            \_SB.PCI0.I2C0.SHUB.PSEN, 
                            PXTC
                        })
                    }
                    Else
                    {
                        Return (Package (0x00) {})
                    }
                }

                Method (_PR3, 0, NotSerialized)  // _PR3: Power Resources for D3hot
                {
                    If (LEqual (And (SDS1, 0x08), 0x08))
                    {
                        Return (Package (0x02)
                        {
                            \_SB.PCI0.I2C0.SHUB.PSEN, 
                            PXTC
                        })
                    }
                    Else
                    {
                        Return (Package (0x00) {})
                    }
                }
            }

            Scope (TPD7)
            {
                Method (PS0X, 0, Serialized)
                {
                    If (LEqual (\_SB.PCI0.I2C1.PXTC.ONTM, Zero))
                    {
                        Return (Zero)
                    }

                    Divide (Subtract (Timer, \_SB.PCI0.I2C1.PXTC.ONTM), 0x2710, , Local0)
                    Add (IC1S, VRRD, Local1)
                    If (LLess (Local0, Local1))
                    {
                        Sleep (Subtract (Local1, Local0))
                    }
                }

                Method (_PR0, 0, NotSerialized)  // _PR0: Power Resources for D0
                {
                    If (LEqual (And (SDS1, 0x0800), 0x0800))
                    {
                        Return (Package (0x01)
                        {
                            PXTC
                        })
                    }
                    Else
                    {
                        Return (Package (0x00) {})
                    }
                }

                Method (_PR3, 0, NotSerialized)  // _PR3: Power Resources for D3hot
                {
                    If (LEqual (And (SDS1, 0x0800), 0x0800))
                    {
                        Return (Package (0x01)
                        {
                            PXTC
                        })
                    }
                    Else
                    {
                        Return (Package (0x00) {})
                    }
                }
            }

            Scope (TPD8)
            {
                Method (PS0X, 0, Serialized)
                {
                    If (LEqual (\_SB.PCI0.I2C1.PXTC.ONTM, Zero))
                    {
                        Return (Zero)
                    }

                    Divide (Subtract (Timer, \_SB.PCI0.I2C1.PXTC.ONTM), 0x2710, , Local0)
                    Add (IC1S, VRRD, Local1)
                    If (LLess (Local0, Local1))
                    {
                        Sleep (Subtract (Local1, Local0))
                    }
                }

                Method (_PR0, 0, NotSerialized)  // _PR0: Power Resources for D0
                {
                    If (LEqual (And (SDS1, 0x1000), 0x1000))
                    {
                        Return (Package (0x01)
                        {
                            PXTC
                        })
                    }
                    Else
                    {
                        Return (Package (0x00) {})
                    }
                }

                Method (_PR3, 0, NotSerialized)  // _PR3: Power Resources for D3hot
                {
                    If (LEqual (And (SDS1, 0x1000), 0x1000))
                    {
                        Return (Package (0x01)
                        {
                            PXTC
                        })
                    }
                    Else
                    {
                        Return (Package (0x00) {})
                    }
                }
            }
        }

        Scope (\_SB.PCI0.SDHC)
        {
            Method (PS0X, 0, Serialized)
            {
                ADBG ("NGFF RST DeAsrt")
                \_SB.WTGP (0x4D, One)
            }
        }

        Scope (\_SB.PCI0.SDHC.WI01)
        {
            Method (PS0X, 0, Serialized)
            {
                ADBG ("NGFF RST DeAsrt")
                \_SB.WTGP (0x4D, One)
            }

            Method (PS3X, 0, Serialized)
            {
                ADBG ("NGFF RST Asrt")
                \_SB.WTGP (0x4D, Zero)
            }
        }
    }
}

