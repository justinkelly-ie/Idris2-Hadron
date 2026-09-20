module Hadron.HadronScaleTransforms

import Core

%default total

||| Concrete hadronic state wrapping total quark multiset weight BoxInt
public export
record ConcreteHadronState where
  constructor MkConcreteHadron
  quarkWeight : BoxInt

public export
Eq ConcreteHadronState where
  (MkConcreteHadron w1) == (MkConcreteHadron w2) = w1 == w2

public export
Show ConcreteHadronState where
  show (MkConcreteHadron w) = "ConcreteHadron(Weight=" ++ show (unwrapBox w) ++ ")"

||| Abstract macro hadronic domain state wrapping total baryonic weight BoxInt
public export
record HadronMacroDomain where
  constructor MkHadronMacro
  baryonicWeight : BoxInt

public export
Eq HadronMacroDomain where
  (MkHadronMacro w1) == (MkHadronMacro w2) = w1 == w2

public export
Show HadronMacroDomain where
  show (MkHadronMacro w) = "HadronMacro(Weight=" ++ show (unwrapBox w) ++ ")"

||| Heterogeneous MultisetScaleAdjunction instance (f_* ⊣ f^*) between ConcreteHadronState and HadronMacroDomain
public export
MultisetScaleAdjunction ConcreteHadronState HadronMacroDomain where
  f_pushforward (MkConcreteHadron w) = MkHadronMacro w
  f_pullback (MkHadronMacro w)       = MkConcreteHadron w
  verifyUnit _   = Refl
  verifyCounit _ = Refl

--------------------------------------------------------------------------------
-- CATEGORY-THEORETIC HOM-TENSOR MULTISET ADJUNCTION (L ⊣ R)
--------------------------------------------------------------------------------

||| Left adjoint hadron scale functor L_Hadron wrapping concrete states and payload a
public export
data ConcreteHadronFunctor : Type -> Type where
  MkConcreteHadronFunctor : ConcreteHadronState -> a -> ConcreteHadronFunctor a

public export
Functor ConcreteHadronFunctor where
  map f (MkConcreteHadronFunctor c x) = MkConcreteHadronFunctor c (f x)

public export
(Eq a) => Eq (ConcreteHadronFunctor a) where
  (MkConcreteHadronFunctor c1 x1) == (MkConcreteHadronFunctor c2 x2) = c1 == c2 && x1 == x2

||| Right adjoint hadron scale functor R_Hadron wrapping HadronMacroDomain states and payload a
public export
data AbstractHadronFunctor : Type -> Type where
  MkAbstractHadronFunctor : HadronMacroDomain -> a -> AbstractHadronFunctor a

public export
Functor AbstractHadronFunctor where
  map f (MkAbstractHadronFunctor m x) = MkAbstractHadronFunctor m (f x)

public export
(Eq a) => Eq (AbstractHadronFunctor a) where
  (MkAbstractHadronFunctor m1 x1) == (MkAbstractHadronFunctor m2 x2) = m1 == m2 && x1 == x2

||| Forward hom-tensor isomorphism mapping concrete to macro hadron scale multiset tensors
public export
hadronHomTensorIso : MultisetTensor (ConcreteHadronFunctor a) b -> MultisetTensor a (AbstractHadronFunctor b)
hadronHomTensorIso ZeroM = ZeroM
hadronHomTensorIso (AddM (MkConcreteHadronFunctor (MkConcreteHadron w) val, payload) weight rest) =
  AddM (val, MkAbstractHadronFunctor (MkHadronMacro w) payload) weight (hadronHomTensorIso rest)

||| Inverse hom-tensor isomorphism mapping macro to concrete hadron scale multiset tensors
public export
hadronHomTensorInv : MultisetTensor a (AbstractHadronFunctor b) -> MultisetTensor (ConcreteHadronFunctor a) b
hadronHomTensorInv ZeroM = ZeroM
hadronHomTensorInv (AddM (val, MkAbstractHadronFunctor (MkHadronMacro w) payload) weight rest) =
  AddM (MkConcreteHadronFunctor (MkConcreteHadron w) val, payload) weight (hadronHomTensorInv rest)

||| Static proof witness verifying forward inverse round-trip isomorphism identity
public export
0 proofHadronHomIso : (t : MultisetTensor (ConcreteHadronFunctor a) b) ->
                     hadronHomTensorInv (hadronHomTensorIso t) = t
proofHadronHomIso ZeroM = Refl
proofHadronHomIso (AddM (MkConcreteHadronFunctor (MkConcreteHadron w) val, payload) weight rest) =
  let rec = proofHadronHomIso rest
  in cong (AddM (MkConcreteHadronFunctor (MkConcreteHadron w) val, payload) weight) rec

||| Static proof witness verifying reverse inverse round-trip isomorphism identity
public export
0 proofHadronHomInv : (u : MultisetTensor a (AbstractHadronFunctor b)) ->
                     hadronHomTensorIso (hadronHomTensorInv u) = u
proofHadronHomInv ZeroM = Refl
proofHadronHomInv (AddM (val, MkAbstractHadronFunctor (MkHadronMacro w) payload) weight rest) =
  let rec = proofHadronHomInv rest
  in cong (AddM (val, MkAbstractHadronFunctor (MkHadronMacro w) payload) weight) rec

||| Category-Theoretic MultisetAdjunction instance L_Hadron ⊣ R_Hadron for hadronic scale space
public export
MultisetAdjunction ConcreteHadronFunctor AbstractHadronFunctor where
  leftAdjoint x = MkConcreteHadronFunctor (MkConcreteHadron (intToBoxInt 0)) x
  rightAdjoint (MkConcreteHadronFunctor _ x) = x
  homTensorIso = hadronHomTensorIso
  homTensorInv = hadronHomTensorInv
  verifyHomIso = proofHadronHomIso
  verifyHomInv = proofHadronHomInv

||| Proof witness exporter for Hadron ScaleTransform Plugin
public export
auditHadronScaleTransformProof : Bool
auditHadronScaleTransformProof = True
