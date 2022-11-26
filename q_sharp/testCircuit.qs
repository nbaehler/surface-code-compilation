// from Circuits import testCircuit
//
// -------------------------------
//
// in_qir = testCircuit.as_qir()
//
// with open("temp.ll", "w") as f:
//     f.writelines(in_qir)
//
// os.system("llvm-as temp.ll")
//
// cnots = logGates("temp.bc")
//
// os.remove("temp.ll")
// os.remove("temp.bc")
//
// -------------------------------
//
// path = Path(__file__).parent
// file_path = os.path.join(path, "bitcode/bernstein_vazirani.bc")
//
// cnots = logGates(file_path)
//
// -------------------------------
//
//
// Read QIR file generated using the QIR-Alliance generator
// in_qir = testCircuit.as_qir()
//
// Write temporary llvm file so that the parser can read it
// with tempfile.NamedTemporaryFile(
//     suffix=".ll"
// ) as f:   https://github.com/qir-alliance/pyqir/blob/a99afdb8126b1ff0a331bdc81aed9930f7bd23b9/examples/evaluator/teleport.pyL36-L40
//     f.write(in_qir.encode("utf-8"))
//     f.flush()
//     cnots = parse_qir(f.name)
//
// -------------------------------
//
// cnots = [(0, 1), (15, 1)]
//
// -------------------------------

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