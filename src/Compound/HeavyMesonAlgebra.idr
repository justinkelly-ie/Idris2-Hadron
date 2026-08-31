module Compound.HeavyMesonAlgebra

import Core.BoxInt
import Core.Multiset
import Core.VexelMaxel
import Core.UnixelFraction
import Math.FourGeometries
import Math.PauliExclusion
import Compound.TypeIndexedMultiset
import Compound.MesonAlgebra
import Data.List

%default total

------------------------------------------------------------------------
-- 1. HEAVY MESON SPECIES SPECIFICATION
------------------------------------------------------------------------

||| Heavy Meson & Quarkonium Species Specification.
public export
data HeavyMesonSpec = JPsiCharmonium | UpsilonBottomonium 
                     | DPlus | DZero | DsPlus 
                     | BPlus | BZero | BsZero

public export
Eq HeavyMesonSpec where
  JPsiCharmonium     == JPsiCharmonium     = True
  UpsilonBottomonium == UpsilonBottomonium = True
  DPlus              == DPlus              = True
  DZero              == DZero              = True
  DsPlus             == DsPlus             = True
  BPlus              == BPlus              = True
  BZero              == BZero              = True
  BsZero             == BsZero             = True
  _                  == _                  = False

public export
Show HeavyMesonSpec where
  show JPsiCharmonium     = "J/psi (c c_bar)"
  show UpsilonBottomonium = "Upsilon (b b_bar)"
  show DPlus              = "D+ (c d_bar)"
  show DZero              = "D0 (c u_bar)"
  show DsPlus             = "Ds+ (c s_bar)"
  show BPlus              = "B+ (u b_bar)"
  show BZero              = "B0 (d b_bar)"
  show BsZero             = "Bs0 (s b_bar)"

------------------------------------------------------------------------
-- 2. SMART CONSTRUCTORS FOR HEAVY MESONS
------------------------------------------------------------------------

||| Constructs a J/psi Charmonium (c c_bar) 18-token Meson Vexel.
%inline
public export
makeJPsiCharmoniumVexel : MesonVexel
makeJPsiCharmoniumVexel =
  MkVexel [ (MkUnixel 4, MkBoxInt 9)   -- Charm Quark
          , (MkUnixel 4, MkBoxInt 9)   -- Anti-Charm Quark
          ]

||| Constructs a Upsilon Bottomonium (b b_bar) 18-token Meson Vexel.
%inline
public export
makeUpsilonBottomoniumVexel : MesonVexel
makeUpsilonBottomoniumVexel =
  MkVexel [ (MkUnixel 5, MkBoxInt 9)   -- Bottom Quark
          , (MkUnixel 5, MkBoxInt 9)   -- Anti-Bottom Quark
          ]

------------------------------------------------------------------------
-- 3. OBSERVATIONS & AUDIT
------------------------------------------------------------------------

||| Evaluates mass tokens of a Heavy Meson Vexel (must equal 18 tokens).
%inline
public export
observeHeavyMesonMassTokens : MesonVexel -> BoxInt
observeHeavyMesonMassTokens (MkVexel [(u1, MkBoxInt w1), (u2, MkBoxInt w2)]) = MkBoxInt (w1 + w2)
observeHeavyMesonMassTokens m = totalVexelMass m

||| Audits Heavy Meson Mass Token Conservation:
||| 1. J/psi carries 18 mass tokens.
||| 2. Upsilon carries 18 mass tokens.
%inline
public export
auditHeavyMesonAlgebraProof : Bool
auditHeavyMesonAlgebraProof =
  (unwrapBox (observeHeavyMesonMassTokens makeJPsiCharmoniumVexel) == 18) &&
  (unwrapBox (observeHeavyMesonMassTokens makeUpsilonBottomoniumVexel) == 18)
