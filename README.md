# Surface code compilation

Semester project: _A practical introduction into surface code compilation_ at
[LSI](https://www.epfl.ch/labs/lsi/), EPFL.

Professor: Prof. [Giovanni De
Micheli](https://people.epfl.ch/giovanni.demicheli/?lang=en)\
Supervisor: [Mathias Soeken](https://people.epfl.ch/mathias.soeken?lang=en),
Ph.D.\
Student: [Nicolas Bähler](https://people.epfl.ch/nicolas.bahler?lang=en)

![alt text](/surface_code_compilation/notebook/figures/operations.png)\
_Elementary surface code operations: Single-qubit preparation in the X basis
(i), and the Z basis (ii), destructive single-qubit measurement, in the X basis
(iii), and the Z basis (iv), two-qubit joint measurement of XX (v) and ZZ (vi),
a Move of a logical qubit from one patch to an unused patch (vii), two-qubit
preparation (viii) and destructive measurement (ix) in the Bell basis, and
finally a Hadamard gate using 3 ancilla logical qubits (x).
[\[1\]](#references)_

The semester project is mainly based on [this
paper](https://arxiv.org/pdf/2110.11493.pdf) [\[1\]](#references). First, it
introduces surface codes as a means to implement fault-tolerant quantum
computing. Upon this basis, the authors propose a compilation scheme for quantum
circuits taking into account the geometrical constraints of todays hardware and
the surface code itself. Further, the novel technique allows to compile
significant parts of the circuit in a parallel fashion, which is a huge
advantage over naive compilation for surface codes.

This repository is an implementation of the proposed compilation scheme. For a
comprehensive introduction to the topic, refer to the [Jupyter
notebooks](https://github.com/nbaehler/surface-code-compilation/blob/main/surface_code_compilation/notebook/surface_code_compilation.ipynb).
A more lightweight introduction can be found in the following [Medium
post](https://medium.com/@nicolas.bahler/surface-code-compilation-ae8d994468b4).

## [References](#references)

- [1] [https://arxiv.org/pdf/2110.11493.pdf](https://arxiv.org/pdf/2110.11493.pdf)
