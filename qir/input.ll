; ModuleID = 'input'
source_filename = "input"

%Qubit = type opaque

define void @main() #0 {
entry:
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 66 to %Qubit*), %Qubit* inttoptr (i64 10 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 46 to %Qubit*), %Qubit* inttoptr (i64 28 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 14 to %Qubit*), %Qubit* inttoptr (i64 48 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 16 to %Qubit*), %Qubit* inttoptr (i64 12 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 52 to %Qubit*), %Qubit* inttoptr (i64 50 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 10 to %Qubit*), %Qubit* inttoptr (i64 70 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 64 to %Qubit*), %Qubit* inttoptr (i64 32 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 32 to %Qubit*), %Qubit* inttoptr (i64 50 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 14 to %Qubit*), %Qubit* inttoptr (i64 66 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 52 to %Qubit*), %Qubit* inttoptr (i64 50 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 66 to %Qubit*), %Qubit* inttoptr (i64 34 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 28 to %Qubit*), %Qubit* inttoptr (i64 30 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 52 to %Qubit*), %Qubit* inttoptr (i64 48 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 12 to %Qubit*), %Qubit* inttoptr (i64 68 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 46 to %Qubit*), %Qubit* inttoptr (i64 10 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 12 to %Qubit*), %Qubit* inttoptr (i64 66 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 28 to %Qubit*), %Qubit* inttoptr (i64 34 to %Qubit*))
  call void @__quantum__qis__dumpmachine__body(i8* null)
  ret void
}

declare void @__quantum__qis__cnot__body(%Qubit*, %Qubit*)

declare void @__quantum__qis__dumpmachine__body(i8*)

attributes #0 = { "EntryPoint" "requiredQubits"="81" "requiredResults"="81" }
