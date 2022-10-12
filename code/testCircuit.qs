namespace Circuits {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation testCircuit() : Unit {
        use qctl = Qubit();
        use qtgt = Qubit();

        CNOT(qctl, qtgt);
        CNOT(qctl, qtgt);
    }
}