module Hadron.NucleosynthesisStream

import Data.List
import Data.Fuel
import Math.OnSeq.FusedStream
import Compound.AlphaReplication
import Core.VexelMaxel
import Core.BoxInt

%default total

------------------------------------------------------------------------
-- 1. DEFORESTED NUCLEOSYNTHESIS & JET STREAMING
------------------------------------------------------------------------

||| Convert a sequence of Alpha clusters into a deforested stream.
public export
streamAlphaClusters : List AlphaClusterState -> FusedStream AlphaClusterState
streamAlphaClusters = stream

||| Deforested extraction of 3D spatial Boxel representations from Alpha clusters.
public export
fusedAlphaBoxelStream : FusedStream AlphaClusterState -> FusedStream Boxel
fusedAlphaBoxelStream = mapStream alphaClusterToBoxel

||| Deforested filter for stable nuclear clusters.
public export
fusedFilterStableAlpha : FusedStream AlphaClusterState -> FusedStream AlphaClusterState
fusedFilterStableAlpha = filterStream isAlphaStable

||| Deforested triple-alpha fusion map (Combines trios into 324-token carbon core total flux).
public export
fusedTripleAlphaFluxStream : FusedStream AlphaClusterState -> FusedStream Core.BoxInt.BoxInt
fusedTripleAlphaFluxStream = mapStream (\alpha => totalAlphaFlux alpha * Core.BoxInt.intToBoxInt 3)

||| Evaluates an Alpha cluster stream into a List container.
public export
runAlphaStream : Fuel -> FusedStream AlphaClusterState -> List AlphaClusterState
runAlphaStream = runFueledStream

||| Direct stream generation for triple-alpha Carbon fusion flux ($3 \times 108 \to 324$).
public export
unfoldAlphaFusionStream : List AlphaClusterState -> FusedStream Core.BoxInt.BoxInt
unfoldAlphaFusionStream alphas = fusedTripleAlphaFluxStream (stream alphas)
