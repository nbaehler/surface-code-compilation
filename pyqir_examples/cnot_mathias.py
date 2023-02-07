from pyqir import BasicQisBuilder, Constant, IntType, PointerType, SimpleModule, rt

# TODO rt is introduced in pyqir==0.8.0, but this version remove the Evaluator
# which I need

# index 0 : control
# index 1 : target
# index 2 : helper qubit for CNOT
# index 3 : helper qubit for ZZ and XX measurement
mod = SimpleModule("cnot", 4, 4)

# qubits
[s, t, plus, zzh] = mod.qubits

# measurement results
[s_r, t_r, plus_r, zzh_r] = mod.results

# Gate builder
qis = BasicQisBuilder(mod.builder)

# Types
i8 = IntType(mod.context, 8)
i8p = PointerType(i8)

# You can comment/uncomment to try different assignments for control and target
# assignment
# qis.x(ctl)
# qis.x(tgt)

# prepare X
qis.h(plus)

# measure ZZ between ctl and helper
qis.cx(s, zzh)
qis.cx(plus, zzh)
qis.mz(zzh, zzh_r)
qis.if_result(zzh_r, lambda: qis.x(plus))
qis.reset(zzh)

# measure XX between tgt and helper
qis.h(t)
qis.h(plus)
qis.cx(t, zzh)
qis.cx(plus, zzh)
qis.h(plus)
qis.h(t)
qis.mz(zzh, zzh_r)
# hacky: applying two Z gates, "returning" void from the last one
qis.if_result(zzh_r, lambda: (qis.z(s), qis.z(plus))[-1])
qis.reset(zzh)

# measure Z
qis.mz(plus, plus_r)
qis.if_result(plus_r, lambda: qis.x(t))
qis.reset(plus)


qis.mz(s, s_r)
rt.result_record_output(mod.builder, s_r, Constant.null(i8p))

qis.mz(t, t_r)
rt.result_record_output(mod.builder, t_r, Constant.null(i8p))

with open("cnot.ll", "w") as f:
    f.write(mod.ir())

print(mod.ir())
