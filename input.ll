; ModuleID = 'input'
source_filename = "input"

%Qubit = type opaque

define void @main() #0 {
entry:
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 6 to %Qubit*), %Qubit* inttoptr (i64 18 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 16 to %Qubit*), %Qubit* inttoptr (i64 8 to %Qubit*))
  ret void
}

declare void @__quantum__qis__cnot__body(%Qubit*, %Qubit*)

attributes #0 = { "EntryPoint" "requiredQubits"="36" "requiredResults"="36" }
