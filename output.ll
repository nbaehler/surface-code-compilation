; ModuleID = 'output'
source_filename = "output"

%Qubit = type opaque
%Result = type opaque

define void @main() #0 {
entry:
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 11 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 11 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 11 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 12 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 25 to %Qubit*), %Result* inttoptr (i64 25 to %Result*))
  %0 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 25 to %Result*))
  br i1 %0, label %then, label %else

then:                                             ; preds = %entry
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  br label %continue

else:                                             ; preds = %entry
  br label %continue

continue:                                         ; preds = %else, %then
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 7 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 7 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 12 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 7 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 25 to %Qubit*), %Result* inttoptr (i64 25 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 12 to %Qubit*), %Result* inttoptr (i64 12 to %Result*))
  %1 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 25 to %Result*))
  br i1 %1, label %then1, label %else2

then1:                                            ; preds = %continue
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 7 to %Qubit*))
  br label %continue3

else2:                                            ; preds = %continue
  br label %continue3

continue3:                                        ; preds = %else2, %then1
  %2 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 12 to %Result*))
  br i1 %2, label %then4, label %else5

then4:                                            ; preds = %continue3
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 7 to %Qubit*))
  br label %continue6

else5:                                            ; preds = %continue3
  br label %continue6

continue6:                                        ; preds = %else5, %then4
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 16 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 11 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 25 to %Qubit*), %Result* inttoptr (i64 26 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 7 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 8 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 25 to %Qubit*), %Result* inttoptr (i64 27 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 7 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 8 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 11 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 11 to %Qubit*), %Result* inttoptr (i64 28 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 7 to %Qubit*), %Result* inttoptr (i64 29 to %Result*))
  %3 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 27 to %Result*))
  br i1 %3, label %then7, label %else8

then7:                                            ; preds = %continue6
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 16 to %Qubit*))
  br label %continue9

else8:                                            ; preds = %continue6
  br label %continue9

continue9:                                        ; preds = %else8, %then7
  %4 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 26 to %Result*))
  br i1 %4, label %then10, label %else11

then10:                                           ; preds = %continue9
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 8 to %Qubit*))
  br label %continue12

else11:                                           ; preds = %continue9
  br label %continue12

continue12:                                       ; preds = %else11, %then10
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 1 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 1 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 6 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 1 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 25 to %Qubit*), %Result* inttoptr (i64 26 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 1 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 1 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 1 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 2 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 25 to %Qubit*), %Result* inttoptr (i64 25 to %Result*))
  %5 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 25 to %Result*))
  br i1 %5, label %then13, label %else14

then13:                                           ; preds = %continue12
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  br label %continue15

else14:                                           ; preds = %continue12
  br label %continue15

continue15:                                       ; preds = %else14, %then13
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 1 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 2 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 25 to %Qubit*), %Result* inttoptr (i64 25 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 1 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 1 to %Qubit*), %Result* inttoptr (i64 1 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 2 to %Qubit*), %Result* inttoptr (i64 25 to %Result*))
  %6 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 27 to %Result*))
  br i1 %6, label %then16, label %else17

then16:                                           ; preds = %continue15
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  br label %continue18

else17:                                           ; preds = %continue15
  br label %continue18

continue18:                                       ; preds = %else17, %then16
  %7 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 28 to %Result*))
  br i1 %7, label %then19, label %else20

then19:                                           ; preds = %continue18
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  br label %continue21

else20:                                           ; preds = %continue18
  br label %continue21

continue21:                                       ; preds = %else20, %then19
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 17 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 17 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 12 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 17 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 25 to %Qubit*), %Result* inttoptr (i64 25 to %Result*))
  %8 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 25 to %Result*))
  br i1 %8, label %then22, label %else23

then22:                                           ; preds = %continue21
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 17 to %Qubit*))
  br label %continue24

else23:                                           ; preds = %continue21
  br label %continue24

continue24:                                       ; preds = %else23, %then22
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 7 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 7 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 7 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 12 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 25 to %Qubit*), %Result* inttoptr (i64 25 to %Result*))
  %9 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 25 to %Result*))
  br i1 %9, label %then25, label %else26

then25:                                           ; preds = %continue24
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  br label %continue27

else26:                                           ; preds = %continue24
  br label %continue27

continue27:                                       ; preds = %else26, %then25
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 2 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 7 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 25 to %Qubit*), %Result* inttoptr (i64 25 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 2 to %Qubit*), %Result* inttoptr (i64 2 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 7 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 7 to %Qubit*), %Result* inttoptr (i64 25 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 12 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 17 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 25 to %Qubit*), %Result* inttoptr (i64 25 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 12 to %Qubit*), %Result* inttoptr (i64 12 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 17 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 17 to %Qubit*), %Result* inttoptr (i64 25 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 17 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 18 to %Qubit*), %Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 25 to %Qubit*), %Result* inttoptr (i64 28 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 17 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 18 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 17 to %Qubit*), %Result* inttoptr (i64 29 to %Result*))
  %10 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 29 to %Result*))
  br i1 %10, label %then28, label %else29

then28:                                           ; preds = %continue27
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 18 to %Qubit*))
  br label %continue30

else29:                                           ; preds = %continue27
  br label %continue30

continue30:                                       ; preds = %else29, %then28
  call void @__quantum__qis__dumpmachine__body(i8* null)
  ret void
}

declare void @__quantum__qis__reset__body(%Qubit*)

declare void @__quantum__qis__h__body(%Qubit*)

declare void @__quantum__qis__cnot__body(%Qubit*, %Qubit*)

declare void @__quantum__qis__mz__body(%Qubit*, %Result*)

declare i1 @__quantum__qis__read_result__body(%Result*)

declare void @__quantum__qis__x__body(%Qubit*)

declare void @__quantum__qis__z__body(%Qubit*)

declare void @__quantum__qis__dumpmachine__body(i8*)

attributes #0 = { "EntryPoint" "requiredQubits"="26" "requiredResults"="30" }
