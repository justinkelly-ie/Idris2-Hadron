# Idris2-Hadron

[![Idris 2 Verification](https://img.shields.io/badge/Idris_2-0.8.0-blue.svg)](https://www.idris-lang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**Layer 4 Subatomic Hadronic Confinement & Standard Model Algebra**

`Idris2-Hadron` formalizes hadronic color charge confinement, particle scattering, and type-indexed multiset synthesis:

- **`Compound.HadronicConfinement`**: 3-color quark vexels ($q_R, q_G, q_B$) balancing the baryon singlet via `BalanceArray 4` (`%macro auditHadronSingletBalance`).
- **`Compound.StandardModel`**: Full particle catalog, QED pair annihilation vertex, Weak beta decay, and Higgs gauge decay (`%macro auditStandardModelCatalog`).
- **`Compound.TypeIndexedMultiset`**: Formal type-indexed synthesis: Quarks ($9$) $\to$ Hadrons ($27$) $\to$ Alpha ($108$) $\to$ Carbon-12 ($324$) (`%macro auditTypeIndexedMultiset`).

## 🚀 Building & Installing

```bash
idris2 --build Idris2-Hadron.ipkg
idris2 --install Idris2-Hadron.ipkg
```
