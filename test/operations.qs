namespace Operations {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    open Microsoft.Quantum.Diagnostics; // Those are namespaces not packages
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    internal operation PrepareX(q : Qubit) : Unit {
        AssertAllZero([q]);

        H(q);
    }

    internal operation PrepareZ(q : Qubit) : Unit {
        AssertAllZero([q]);
    }

    internal operation HorizontalPrepareBB(q1 : Qubit, q2 : Qubit) : Unit {
        AssertAllZero([q1, q2]);

        PrepareZ(q1);
        PrepareZ(q2);

        let x = HorizontalMeasureXX(q1, q2);

        if x == One {
            Z(q2);
        }

        //DumpRegister((), [q1, q2]); //REMOVE
    }

    internal operation VerticalPrepareBB(q1 : Qubit, q2 : Qubit) : Unit {
        AssertAllZero([q1, q2]);

        PrepareX(q1);
        PrepareX(q2);

        let z = VerticalMeasureZZ(q1, q2);

        if z == One {
            X(q2);
        }

        //DumpRegister((), [q1, q2]); //REMOVE
    }


    internal operation MeasureZ(q : Qubit) : Result {
        return MResetZ(q); // M in Z and then set to |0>
    }

    internal operation MeasureX(q : Qubit) : Result {
        return MResetX(q); // M in X and then set to |0>
    }

    internal operation VerticalMeasureZZ(q1 : Qubit, q2 : Qubit) : Result { // Return Zero or One, not |00> etc. Those are the eigenvalues associated to the sub vector spaces. https://learn.microsoft.com/en-us/azure/quantum/concepts-pauli-measurements
        return Measure([PauliZ, PauliZ], [q1, q2]);
    }

    internal operation HorizontalMeasureXX(q1 : Qubit, q2 : Qubit) : Result {
        return Measure([PauliX, PauliX], [q1, q2]);
    }

    internal operation VerticalMeasureBB(q1 : Qubit, q2 : Qubit) : Result[] { //TODO change this
        let z = VerticalMeasureZZ(q1, q2);
        let x1 = MeasureX(q1);
        let x2 = MeasureX(q2);
        let x = BoolAsResult(x1 != x2);

        return [x, z]; // Not sure!
    }

    internal operation HorizontalMeasureBB(q1 : Qubit, q2 : Qubit) : Result[] {
        let x = HorizontalMeasureXX(q1, q2);
        let z1 = MeasureZ(q1);
        let z2 = MeasureZ(q2);
        let z = BoolAsResult(z1 != z2);

        return [x, z]; // Not sure!
    }

    operation LocalCnot(ctl : Qubit, tgt : Qubit, hlp : Qubit): Unit {
        PrepareX(hlp);

        let a = VerticalMeasureZZ(ctl, hlp);
        let b = HorizontalMeasureXX(hlp, tgt);
        let c = MeasureZ(hlp);

        if b == One {
            Z(ctl);
        }

        if c != a {
            X(tgt);
        }
    }

    operation VerticalMove(frm : Qubit, to : Qubit): Unit {
        PrepareX(to);

        let z = VerticalMeasureZZ(frm, to);
        let x = MeasureX(frm);

        if z == One {
            X(to);
        }

        if x == One {
            Z(to);
        }
    }

    operation HorizontalMove(frm : Qubit, to : Qubit): Unit {
        PrepareZ(to);

        let x = HorizontalMeasureXX(frm, to);
        let z = MeasureZ(frm);

        if x == One {
            Z(to);
        }

        if z == One {
            X(to);
        }
    }


    operation DiagonalSwap(tl : Qubit, trhlp : Qubit, blhlp : Qubit, br : Qubit): Unit {
        HorizontalMove(tl, trhlp);
        HorizontalMove(br, blhlp);

        VerticalMove(trhlp, br);
        VerticalMove(blhlp, tl);
    }

    operation LocalCnotSim(ctl : Bool, tgt : Bool): Unit {
        use qctl = Qubit();
        use qtgt = Qubit();
        use qhlp = Qubit();

        PrepareZ(qctl);
        PrepareZ(qtgt);

        if ctl {
            X(qctl);
        }

        if tgt {
            X(qtgt);
        }

        LocalCnot(qctl, qtgt, qhlp);

        let rctl = M(qctl);
        let rtgt = M(qtgt);


        Message($"Got ctl={rctl}, tgt={rtgt}");
    }

    operation VerticalMoveSim(frm : Bool, to : Bool): Unit {
        use qfrm = Qubit();
        use qto = Qubit();

        PrepareZ(qfrm);
        PrepareZ(qto);

        if frm {
            X(qfrm);
        }

        if to {
            X(qto);
        }

        VerticalMove(qfrm, qto);

        let rfrm = M(qfrm);
        let rto = M(qto);

        Message($"Got frm={rfrm}, to={rto}");
    }

    operation HorizontalMoveSim(frm : Bool, to : Bool): Unit {
        use qfrm = Qubit();
        use qto = Qubit();

        PrepareZ(qfrm);
        PrepareZ(qto);


        if frm {
            X(qfrm);
        }

        if to {
            X(qto);
        }

        HorizontalMove(qfrm, qto);

        let rfrm = M(qfrm);
        let rto = M(qto);

        Message($"Got frm={rfrm}, to={rto}");
    }


    operation DiagonalSwapSim(tl : Bool, br : Bool): Unit {
        use qtl = Qubit();
        use qbr = Qubit();

        PrepareZ(qtl);
        PrepareZ(qbr);

        use qtrhlp = Qubit();
        use qblhlp = Qubit();

        if tl {
            X(qtl);
        }

        if br {
            X(qbr);
        }

        DiagonalSwap(qtl, qtrhlp, qblhlp, qbr);

        let rtl = M(qtl);
        let rbr = M(qbr);

        Message($"Got tl={rtl}, br={rbr}");
    }
}