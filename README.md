# FinSc-Hadron

[![Idris 2 Verification](https://img.shields.io/badge/Idris_2-0.8.0-blue.svg)](https://www.idris-lang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**Layer 4b Standard Model Decompositions, Quark Confinement & Hadronization Engine for Idris 2**

`FinSc-Hadron` forms **Layer 4b** of the 10-layer constructive non-linear multiset science framework. It formalizes subatomic Standard Model particle decompositions, quark-hadron color confinement matrices ($R + G + B = 0$), light and heavy meson algebras, strangeness hyperons, exotic multiquarks (tetraquarks, pentaquarks), high-energy 2-to-2 scattering kinematics, hadronization automata, and stellar/cosmic nucleosynthesis networks.

---

## 📦 Core Library Architecture & Modules

### 1. `Compound.QuarkHadronAlgebra` & `Compound.HadronicConfinement`
- **Quark-Hadron Confinement:** Color charge balance matrices (`Red`, `Green`, `Blue`) enforcing singlet color neutrality ($R + G + B = 0$).
- **Scale Transform:** `transformQuarkToHadron` scale transformation mapping subatomic color charge multisets to hadronic bound states.

### 2. `Compound.MesonAlgebra` & `Compound.HeavyMesonAlgebra`
- **Meson Algebra:** Light quark-antiquark bound states ($\pi^\pm, \pi^0, K^\pm, K^0$).
- **Heavy Meson Algebra:** Charmonium ($c\bar{c}$) and bottomonium ($b\bar{b}$) heavy quark bound state algebras.

### 3. `Compound.HyperonAlgebra` & `Compound.ExoticMultiquark`
- **Strangeness Hyperons:** Baryon octet and decuplet multiquark structures ($p, n, \Lambda, \Sigma, \Xi, \Omega$).
- **Exotic Multiquarks:** Tetraquark ($q q \bar{q} \bar{q}$) and pentaquark ($q q q q \bar{q}$) multiset bound states.

### 4. `Compound.StandardModel` & `Compound.GaugeBosons`
- **Complete Standard Model Catalog:** Full particle catalogue ($u, d, c, s, t, b, e, \mu, \tau, \nu_e, \nu_\mu, \nu_\tau, \gamma, W^\pm, Z^0, g, H$).
- **Gauge Bosons:** Gluon color octet operations and electroweak gauge boson couplings.

### 5. `Compound.ParticleScattering` & `Compound.HadronizationEngine`
- **2-to-2 Kinematics:** Relativistic 2-to-2 particle scattering kinematics and Mandelstam invariants ($s, t, u$).
- **Hadronization Automata:** Quark-Gluon Plasma (QGP) jet fragmentation and hadronization state transitions.

### 6. Nucleosynthesis Networks & `Compound.TypeIndexedMultiset`
- **Nucleosynthesis Networks:** Stellar and cosmic nucleosynthesis balance networks (`StellarNuclei`, `StellarNucleosynthesis`, `CosmicNucleosynthesis`, `AlphaReplication`, `PlasmaRecombination`).
- **Type-Indexed Multisets:** Synthesis of `TypeIndexedMultiset` tracking exact particle quantum numbers.
- **`Math.MuonG2Anomaly`:** Muon anomalous magnetic moment calculation over discrete field loops.

---

## 🚀 Building & Installing

```bash
idris2 --build FinSc-Hadron.ipkg
idris2 --install FinSc-Hadron.ipkg
```

---

## 🔬 Architectural Principles

- **Total Constructivism:** Enforces `%default total` across all Standard Model multiquark modules.
- **Strict Color Confinement:** Compile-time check enforcing $R + G + B = 0$ color neutrality.
- **Zero Floating-Point Drift:** Pure integer multiset cross-multiplication over quantum numbers.
