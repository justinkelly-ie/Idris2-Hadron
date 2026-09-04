# 🔬 Idris2-Hadron

**Layer 4b Quark-to-Hadron Algebraic Functor, Multiquark Algebra & Color Confinement for Idris 2**

`Idris2-Hadron` models subatomic strong interactions and hadronic confinement within the **Constructive Multiset Physics Framework**. It provides categorical quark-to-hadron functors, color-singlet polyhedral state bounds, meson/hyperon algebras, hadronization automata, and nucleosynthesis balance reactions.

---

## Key Modules & Specifications

| Module | Architectural Role & Domain Scope |
| :--- | :--- |
| **`Compound.HadronicConfinement`** | Color-singlet confinement ($3 \times 3 \times 3 = 27$ Vexels) and $SU(3)$ color gauge invariance. |
| **`Compound.QuarkHadronAlgebra`** | Categorical quark-to-hadron functor ($3$-quark/anti-quark multisets into color-singlet hadrons). |
| **`Compound.MesonAlgebra`** | Quark-antiquark meson pseudoscalar and vector state algebra. |
| **`Compound.HeavyMesonAlgebra`** | Charmonium ($c\bar{c}$) and bottomonium ($b\bar{b}$) heavy quarkonium state invariants. |
| **`Compound.HyperonAlgebra`** | Strange hyperon ($\Lambda, \Sigma, \Xi, \Omega$) multiset balance states. |
| **`Compound.ExoticMultiquark`** | Tetraquark ($q\bar{q}q\bar{q}$) and pentaquark ($qqqq\bar{q}$) exotic multiset configurations. |
| **`Compound.StandardModel`** | Full Standard Model particle catalog and multiset vertex conservation. |
| **`Compound.ParticleScattering`** | High-energy $2 \to 2$ particle scattering kinematics and Mandelstam invariants ($s, t, u$). |
| **`Compound.HadronizationEngine`** | Hadronization and quark-gluon plasma (QGP) jet fragmentation automaton. |
| **`Compound.TypeIndexedMultiset`** | Type-indexed multiset synthesis for subatomic particle states. |
| **`Compound.GaugeBosons`** | Electroweak and strong gauge boson ($W^\pm, Z^0, \gamma, g$) vertex coupling. |
| **`Compound.StellarNuclei`** | Bound-state stellar nuclei mass defect and binding energy balance arrays. |
| **`Compound.StellarNucleosynthesis`** | Proton-proton chain and CNO cycle stellar nuclear fusion balance networks. |
| **`Compound.CosmicNucleosynthesis`** | Primordial Big Bang nucleosynthesis (BBN) light element synthesis. |
| **`Compound.PlasmaRecombination`** | Plasma recombination, photon decoupling, and Saha ionization balance. |
| **`Compound.AlphaReplication`** | Alpha particle ($^4\text{He}$) replication and polyhedral nuclear stability. |
| **`Math.MuonG2Anomaly`** | Discrete 1-loop vacuum polarization and muon anomalous magnetic moment $(g-2)_\mu$. |

---

## Dependencies

- **`Idris2-Multiset-Core`**
- **`Idris2-Multiset-Transform`**
- **`Idris2-Geometry`**
- **`Idris2-Physics`**

---

## Building & Usage

Build the package using `pack`:

```bash
idris2 --build Idris2-Hadron.ipkg
idris2 --install Idris2-Hadron.ipkg
```

---

&copy; Justin Kelly. Formalized in pair-programming collaboration with Google Antigravity.
