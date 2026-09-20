module Compound.HadronicConfinement

import Language.Reflection
import Core
import Transform
import Math.LinAlgebra.TernaryClassifier
import Geometry.LatticeTopology
import Data.Vect
import Data.Fin

%default total



||| Tabulator for 27-element vectors.
public export
tabulate27 : (Fin 27 -> a) -> Vect 27 a
tabulate27 = tabulate

||| A Hadronic Nucleon State (Proton / Neutron) spanning the 27-cell lattice.
||| Tracks color flux across the Red, Green, and Blue sectors.
public export
record HadronState where
  constructor MkHadronState
  latticeGrid : Vect 27 Core.BoxInt.BoxInt

||| Creates a balanced Hadronic Ground State at Epoch 3.
||| Injects 1 unit of Quark flux into each cell (9 Red + 9 Green + 9 Blue = 27 total flux).
public export
seedHadronEpoch3 : HadronState
seedHadronEpoch3 =
  let grid = tabulate27 (\idx => 
        case cellColorSector idx of
          RedColor   => intToBoxInt 1
          GreenColor => intToBoxInt 1
          BlueColor  => intToBoxInt 1)
  in MkHadronState grid

||| Computes the net color charge sum of a sector.
public export
sectorColorSum : ColorCharge -> HadronState -> Core.BoxInt.BoxInt
sectorColorSum targetColor (MkHadronState grid) =
  let cells = filter (\idx => cellColorSector idx == targetColor) (allFins 27)
  in foldl (\acc, idx => acc + index idx grid) (intToBoxInt 0) cells
  where
    allFins : (n : Nat) -> List (Fin n)
    allFins Z = []
    allFins (S k) = FZ :: map FS (allFins k)

||| Color Neutrality (White / Singlet State) Predicate:
||| A hadron is confined and color-neutral if and only if Red Sum == Green Sum == Blue Sum.
public export
isColorNeutral : HadronState -> Bool
isColorNeutral hadron =
  let r = sectorColorSum RedColor hadron
      g = sectorColorSum GreenColor hadron
      b = sectorColorSum BlueColor hadron
  in r == g && g == b

||| Total Hadronic Valence Flux: Sum of all 27 cells.
public export
totalHadronFlux : HadronState -> Core.BoxInt.BoxInt
totalHadronFlux (MkHadronState grid) = sumField27 grid

||| Step-Up to Epoch 3 Cosmic State: UniverseState 27 128 3.
public export
hadronCosmicStateEpoch3 : UniverseState 27 128 3
hadronCosmicStateEpoch3 = seedCosmicVacuum 27 128 3

------------------------------------------------------------------------
-- 4. PURE BOXEL MULTISET QCD NUCLEONS & Z-SLICE CONFINEMENT
------------------------------------------------------------------------

||| Converts a HadronState into a 3D Boxel multiset.
public export
hadronStateToBoxel : HadronState -> Boxel
hadronStateToBoxel (MkHadronState grid) = field27ToBoxel grid

||| Converts a 3D Boxel multiset into a HadronState.
public export
boxelToHadronState : Boxel -> HadronState
boxelToHadronState b = MkHadronState (boxelToField27 b)

||| Ground-state Hadron Nucleon represented as a canonical 3D Boxel multiset.
public export
seedHadronBoxel : Boxel
seedHadronBoxel = hadronStateToBoxel seedHadronEpoch3

||| Validates QCD Color Neutrality directly on a 3D Boxel multiset:
||| Evaluates that the 3 Z-slice Maxel planes (z=0 Red, z=1 Green, z=2 Blue)
||| carry identically balanced color flux.
public export
isHadronBoxelColorNeutral : Boxel -> Bool
isHadronBoxelColorNeutral b =
  let redSlice   = sliceBoxelZ 0 b
      greenSlice = sliceBoxelZ 1 b
      blueSlice  = sliceBoxelZ 2 b
      wRed   = totalMaxelWeight redSlice
      wGreen = totalMaxelWeight greenSlice
      wBlue  = totalMaxelWeight blueSlice
  in wRed == wGreen && wGreen == wBlue

||| Direct bridge from UniverseState 27 de dm to a 3D Boxel multiset.
public export
stateToEpoch3Boxel : UniverseState 27 de dm -> Boxel
stateToEpoch3Boxel (MkUniverseState vm _ _) = field27ToBoxel vm

||| A 4-Vexel Balance Array representing Hadronic Color Singlet Confinement:
||| q_R + q_G + q_B = B_singlet
public export
hadronSingletBalanceArray : BalanceArray 4
hadronSingletBalanceArray = MkBalanceArray [1, 1, 1, 0] [0, 0, 0, 1]

||| Audits that 3 color quark vexels balance the unified baryon singlet.
public export
auditHadronSingletBalanceProof : Bool
auditHadronSingletBalanceProof =
  let qR = MkVexel [(MkUnixel 1, intToBoxInt 9)]
      qG = MkVexel [(MkUnixel 2, intToBoxInt 9)]
      qB = MkVexel [(MkUnixel 3, intToBoxInt 9)]
      bSinglet = MkVexel [(MkUnixel 1, intToBoxInt 9), (MkUnixel 2, intToBoxInt 9), (MkUnixel 3, intToBoxInt 9)]
  in isBalanced [qR, qG, qB, bSinglet] hadronSingletBalanceArray &&
     isDisjointBalance hadronSingletBalanceArray

export
%macro
auditHadronSingletBalance : Elab (Compound.HadronicConfinement.auditHadronSingletBalanceProof = True)
auditHadronSingletBalance = pure Refl

------------------------------------------------------------------------
-- 5. UNIVERSAL TRANSFORM MULTISET HADRONIC CONFINEMENT INSTANCE
------------------------------------------------------------------------

||| A Baryon Singlet Target Sector for Hadronic Confinement.
public export
data HadronSector = BaryonSinglet

public export
Eq HadronSector where
  BaryonSinglet == BaryonSinglet = True

||| Hadronic Confinement Transform Multiset (G ⊗ Z ⊗ J):
||| G: EllipticSector (Bound State Confinement)
||| Z: 1 / [27] (Exact 27-cell normalization)
||| J: ColorCharge -> BaryonSinglet (Pushforward Contraction Map)
quarkToBaryonTransform : MaxelTransform ColorCharge HadronSector
quarkToBaryonTransform = mkTransformBox EllipticSector (mkUnixelFraction (intToBoxInt 1) 27)
  [ ((RedColor, BaryonSinglet), intToBoxInt 1)
  , ((GreenColor, BaryonSinglet), intToBoxInt 1)
  , ((BlueColor, BaryonSinglet), intToBoxInt 1)
  ]

||| Audits Hadronic Confinement Transform: 3 Quark Tokens (Red, Green, Blue) map to 1 Baryon Singlet count 3 under pushforward.
public export
auditQuarkToBaryonTransformProof : Bool
auditQuarkToBaryonTransformProof =
  let quarkBox : Box ColorCharge = insertBox RedColor (intToBoxInt 1) (insertBox GreenColor (intToBoxInt 1) (insertBox BlueColor (intToBoxInt 1) emptyBox))
      pushed = applyPushforwardContraction quarkToBaryonTransform quarkBox
  in lookupBox BaryonSinglet pushed == intToBoxInt 3
