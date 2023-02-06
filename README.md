# Surface code compilation

Semester project: _A practical introduction into surface code compilation_ at
[LSI](https://www.epfl.ch/labs/lsi/), EPFL.

Professor: Prof. [Giovanni De
Micheli](https://people.epfl.ch/giovanni.demicheli/?lang=en)\
Supervisor: [Mathias Soeken](https://people.epfl.ch/mathias.soeken?lang=en),
Ph.D.\
Student: [Nicolas Bähler](https://people.epfl.ch/nicolas.bahler?lang=en)\

The semester project is mainly based on [this
paper](https://arxiv.org/pdf/2110.11493.pdf). First, it
introduces surface codes as a means to implement fault-tolerant quantum
computing. Upon this basis, the authors propose a compilation scheme for quantum
circuits taking into account the geometrical constraints of todays hardware and
the surface code itself. Further, the novel technique allows to compile
significant parts of the circuit in a parallel fashion, which is a huge
advantage over naive compilation for surface codes.

This repository is an implementation of the proposed compilation scheme. For a
comprehensive introduction into the topic, refer the [Jupyter
notebooks](https://github.com/nbaehler/surface-code-compilation/blob/main/surface_code_compilation/notebook/surface_code_compilation.ipynb).
