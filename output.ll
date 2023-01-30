; ModuleID = 'output'
source_filename = "output"

%Qubit = type opaque
%Result = type opaque

define void @main() #0 {
entry:
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 37 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 36 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 37 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 36 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 37 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 36 to %Qubit*))
  %0 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %0, label %then, label %else

then:                                             ; preds = %entry
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 36 to %Qubit*))
  br label %continue

else:                                             ; preds = %entry
  br label %continue

continue:                                         ; preds = %else, %then
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 27 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 27 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 36 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 27 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 36 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 36 to %Qubit*), %Result* inttoptr (i64 36 to %Result*))
  %1 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %1, label %then1, label %else2

then1:                                            ; preds = %continue
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 27 to %Qubit*))
  br label %continue3

else2:                                            ; preds = %continue
  br label %continue3

continue3:                                        ; preds = %else2, %then1
  %2 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 36 to %Result*))
  br i1 %2, label %then4, label %else5

then4:                                            ; preds = %continue3
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 27 to %Qubit*))
  br label %continue6

else5:                                            ; preds = %continue3
  br label %continue6

continue6:                                        ; preds = %else5, %then4
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 46 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 37 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 27 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 28 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 27 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 28 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 37 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 37 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 27 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %3 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %3, label %then7, label %else8

then7:                                            ; preds = %continue6
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 46 to %Qubit*))
  br label %continue9

else8:                                            ; preds = %continue6
  br label %continue9

continue9:                                        ; preds = %else8, %then7
  %4 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %4, label %then10, label %else11

then10:                                           ; preds = %continue9
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 46 to %Qubit*))
  br label %continue12

else11:                                           ; preds = %continue9
  br label %continue12

continue12:                                       ; preds = %else11, %then10
  %5 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %5, label %then13, label %else14

then13:                                           ; preds = %continue12
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 28 to %Qubit*))
  br label %continue15

else14:                                           ; preds = %continue12
  br label %continue15

continue15:                                       ; preds = %else14, %then13
  %6 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %6, label %then16, label %else17

then16:                                           ; preds = %continue15
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 28 to %Qubit*))
  br label %continue18

else17:                                           ; preds = %continue15
  br label %continue18

continue18:                                       ; preds = %else17, %then16
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 43 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 42 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 43 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 42 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 43 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 42 to %Qubit*))
  %7 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %7, label %then19, label %else20

then19:                                           ; preds = %continue18
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 42 to %Qubit*))
  br label %continue21

else20:                                           ; preds = %continue18
  br label %continue21

continue21:                                       ; preds = %else20, %then19
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 51 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 51 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 42 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 51 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 42 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 42 to %Qubit*), %Result* inttoptr (i64 42 to %Result*))
  %8 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %8, label %then22, label %else23

then22:                                           ; preds = %continue21
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 51 to %Qubit*))
  br label %continue24

else23:                                           ; preds = %continue21
  br label %continue24

continue24:                                       ; preds = %else23, %then22
  %9 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 42 to %Result*))
  br i1 %9, label %then25, label %else26

then25:                                           ; preds = %continue24
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 51 to %Qubit*))
  br label %continue27

else26:                                           ; preds = %continue24
  br label %continue27

continue27:                                       ; preds = %else26, %then25
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 52 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 43 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 51 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 50 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 51 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 50 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 43 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 43 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 51 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %10 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %10, label %then28, label %else29

then28:                                           ; preds = %continue27
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 52 to %Qubit*))
  br label %continue30

else29:                                           ; preds = %continue27
  br label %continue30

continue30:                                       ; preds = %else29, %then28
  %11 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %11, label %then31, label %else32

then31:                                           ; preds = %continue30
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 52 to %Qubit*))
  br label %continue33

else32:                                           ; preds = %continue30
  br label %continue33

continue33:                                       ; preds = %else32, %then31
  %12 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %12, label %then34, label %else35

then34:                                           ; preds = %continue33
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 50 to %Qubit*))
  br label %continue36

else35:                                           ; preds = %continue33
  br label %continue36

continue36:                                       ; preds = %else35, %then34
  %13 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %13, label %then37, label %else38

then37:                                           ; preds = %continue36
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 50 to %Qubit*))
  br label %continue39

else38:                                           ; preds = %continue36
  br label %continue39

continue39:                                       ; preds = %else38, %then37
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 23 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 22 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 23 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 22 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 23 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 22 to %Qubit*))
  %14 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %14, label %then40, label %else41

then40:                                           ; preds = %continue39
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 22 to %Qubit*))
  br label %continue42

else41:                                           ; preds = %continue39
  br label %continue42

continue42:                                       ; preds = %else41, %then40
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 31 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 31 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 40 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 40 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 31 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 40 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %15 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %15, label %then43, label %else44

then43:                                           ; preds = %continue42
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 40 to %Qubit*))
  br label %continue45

else44:                                           ; preds = %continue42
  br label %continue45

continue45:                                       ; preds = %else44, %then43
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 22 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 31 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 22 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 22 to %Qubit*), %Result* inttoptr (i64 22 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 31 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 31 to %Qubit*), %Result* inttoptr (i64 31 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 40 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 49 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 40 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 40 to %Qubit*), %Result* inttoptr (i64 40 to %Result*))
  %16 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %16, label %then46, label %else47

then46:                                           ; preds = %continue45
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  br label %continue48

else47:                                           ; preds = %continue45
  br label %continue48

continue48:                                       ; preds = %else47, %then46
  %17 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 40 to %Result*))
  br i1 %17, label %then49, label %else50

then49:                                           ; preds = %continue48
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  br label %continue51

else50:                                           ; preds = %continue48
  br label %continue51

continue51:                                       ; preds = %else50, %then49
  %18 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 31 to %Result*))
  br i1 %18, label %then52, label %else53

then52:                                           ; preds = %continue51
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  br label %continue54

else53:                                           ; preds = %continue51
  br label %continue54

continue54:                                       ; preds = %else53, %then52
  %19 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 22 to %Result*))
  br i1 %19, label %then55, label %else56

then55:                                           ; preds = %continue54
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  br label %continue57

else56:                                           ; preds = %continue54
  br label %continue57

continue57:                                       ; preds = %else56, %then55
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 14 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 23 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 49 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 48 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 48 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 23 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 23 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 49 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %20 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %20, label %then58, label %else59

then58:                                           ; preds = %continue57
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 14 to %Qubit*))
  br label %continue60

else59:                                           ; preds = %continue57
  br label %continue60

continue60:                                       ; preds = %else59, %then58
  %21 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %21, label %then61, label %else62

then61:                                           ; preds = %continue60
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 14 to %Qubit*))
  br label %continue63

else62:                                           ; preds = %continue60
  br label %continue63

continue63:                                       ; preds = %else62, %then61
  %22 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %22, label %then64, label %else65

then64:                                           ; preds = %continue63
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 48 to %Qubit*))
  br label %continue66

else65:                                           ; preds = %continue63
  br label %continue66

continue66:                                       ; preds = %else65, %then64
  %23 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %23, label %then67, label %else68

then67:                                           ; preds = %continue66
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 48 to %Qubit*))
  br label %continue69

else68:                                           ; preds = %continue66
  br label %continue69

continue69:                                       ; preds = %else68, %then67
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 7 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 6 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 7 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 6 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 7 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 6 to %Qubit*))
  %24 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %24, label %then70, label %else71

then70:                                           ; preds = %continue69
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 6 to %Qubit*))
  br label %continue72

else71:                                           ; preds = %continue69
  br label %continue72

continue72:                                       ; preds = %else71, %then70
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 5 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 4 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 5 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 4 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 5 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 4 to %Qubit*))
  %25 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %25, label %then73, label %else74

then73:                                           ; preds = %continue72
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 4 to %Qubit*))
  br label %continue75

else74:                                           ; preds = %continue72
  br label %continue75

continue75:                                       ; preds = %else74, %then73
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 6 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 5 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 6 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 5 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 6 to %Qubit*), %Result* inttoptr (i64 6 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 5 to %Qubit*), %Result* inttoptr (i64 5 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 13 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 13 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 4 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 13 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 4 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 4 to %Qubit*), %Result* inttoptr (i64 4 to %Result*))
  %26 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %26, label %then76, label %else77

then76:                                           ; preds = %continue75
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 13 to %Qubit*))
  br label %continue78

else77:                                           ; preds = %continue75
  br label %continue78

continue78:                                       ; preds = %else77, %then76
  %27 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 4 to %Result*))
  br i1 %27, label %then79, label %else80

then79:                                           ; preds = %continue78
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 13 to %Qubit*))
  br label %continue81

else80:                                           ; preds = %continue78
  br label %continue81

continue81:                                       ; preds = %else80, %then79
  %28 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 5 to %Result*))
  br i1 %28, label %then82, label %else83

then82:                                           ; preds = %continue81
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 13 to %Qubit*))
  br label %continue84

else83:                                           ; preds = %continue81
  br label %continue84

continue84:                                       ; preds = %else83, %then82
  %29 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 6 to %Result*))
  br i1 %29, label %then85, label %else86

then85:                                           ; preds = %continue84
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 13 to %Qubit*))
  br label %continue87

else86:                                           ; preds = %continue84
  br label %continue87

continue87:                                       ; preds = %else86, %then85
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 16 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 7 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 13 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 12 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 13 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 7 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 7 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 13 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %30 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %30, label %then88, label %else89

then88:                                           ; preds = %continue87
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 16 to %Qubit*))
  br label %continue90

else89:                                           ; preds = %continue87
  br label %continue90

continue90:                                       ; preds = %else89, %then88
  %31 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %31, label %then91, label %else92

then91:                                           ; preds = %continue90
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 16 to %Qubit*))
  br label %continue93

else92:                                           ; preds = %continue90
  br label %continue93

continue93:                                       ; preds = %else92, %then91
  %32 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %32, label %then94, label %else95

then94:                                           ; preds = %continue93
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  br label %continue96

else95:                                           ; preds = %continue93
  br label %continue96

continue96:                                       ; preds = %else95, %then94
  %33 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %33, label %then97, label %else98

then97:                                           ; preds = %continue96
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  br label %continue99

else98:                                           ; preds = %continue96
  br label %continue99

continue99:                                       ; preds = %else98, %then97
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 57 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 56 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 57 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 56 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 57 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 56 to %Qubit*))
  %34 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %34, label %then100, label %else101

then100:                                          ; preds = %continue99
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 56 to %Qubit*))
  br label %continue102

else101:                                          ; preds = %continue99
  br label %continue102

continue102:                                      ; preds = %else101, %then100
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 29 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 29 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 29 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 20 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %35 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %35, label %then103, label %else104

then103:                                          ; preds = %continue102
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  br label %continue105

else104:                                          ; preds = %continue102
  br label %continue105

continue105:                                      ; preds = %else104, %then103
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 47 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 47 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 38 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 38 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 47 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 38 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %36 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %36, label %then106, label %else107

then106:                                          ; preds = %continue105
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 38 to %Qubit*))
  br label %continue108

else107:                                          ; preds = %continue105
  br label %continue108

continue108:                                      ; preds = %else107, %then106
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 56 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 47 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 56 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 56 to %Qubit*), %Result* inttoptr (i64 56 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 47 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 47 to %Qubit*), %Result* inttoptr (i64 47 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 38 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 29 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 38 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 38 to %Qubit*), %Result* inttoptr (i64 38 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 29 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 29 to %Qubit*), %Result* inttoptr (i64 29 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 11 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 11 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 20 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 11 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 20 to %Qubit*), %Result* inttoptr (i64 20 to %Result*))
  %37 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %37, label %then109, label %else110

then109:                                          ; preds = %continue108
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 11 to %Qubit*))
  br label %continue111

else110:                                          ; preds = %continue108
  br label %continue111

continue111:                                      ; preds = %else110, %then109
  %38 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 20 to %Result*))
  br i1 %38, label %then112, label %else113

then112:                                          ; preds = %continue111
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 11 to %Qubit*))
  br label %continue114

else113:                                          ; preds = %continue111
  br label %continue114

continue114:                                      ; preds = %else113, %then112
  %39 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 47 to %Result*))
  br i1 %39, label %then115, label %else116

then115:                                          ; preds = %continue114
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 11 to %Qubit*))
  br label %continue117

else116:                                          ; preds = %continue114
  br label %continue117

continue117:                                      ; preds = %else116, %then115
  %40 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 29 to %Result*))
  br i1 %40, label %then118, label %else119

then118:                                          ; preds = %continue117
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 11 to %Qubit*))
  br label %continue120

else119:                                          ; preds = %continue117
  br label %continue120

continue120:                                      ; preds = %else119, %then118
  %41 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 56 to %Result*))
  br i1 %41, label %then121, label %else122

then121:                                          ; preds = %continue120
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 11 to %Qubit*))
  br label %continue123

else122:                                          ; preds = %continue120
  br label %continue123

continue123:                                      ; preds = %else122, %then121
  %42 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 38 to %Result*))
  br i1 %42, label %then124, label %else125

then124:                                          ; preds = %continue123
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 11 to %Qubit*))
  br label %continue126

else125:                                          ; preds = %continue123
  br label %continue126

continue126:                                      ; preds = %else125, %then124
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 66 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 57 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 11 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 10 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 11 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 10 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 57 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 57 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 11 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %43 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %43, label %then127, label %else128

then127:                                          ; preds = %continue126
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 66 to %Qubit*))
  br label %continue129

else128:                                          ; preds = %continue126
  br label %continue129

continue129:                                      ; preds = %else128, %then127
  %44 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %44, label %then130, label %else131

then130:                                          ; preds = %continue129
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 66 to %Qubit*))
  br label %continue132

else131:                                          ; preds = %continue129
  br label %continue132

continue132:                                      ; preds = %else131, %then130
  %45 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %45, label %then133, label %else134

then133:                                          ; preds = %continue132
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 10 to %Qubit*))
  br label %continue135

else134:                                          ; preds = %continue132
  br label %continue135

continue135:                                      ; preds = %else134, %then133
  %46 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %46, label %then136, label %else137

then136:                                          ; preds = %continue135
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 10 to %Qubit*))
  br label %continue138

else137:                                          ; preds = %continue135
  br label %continue138

continue138:                                      ; preds = %else137, %then136
  call void @__quantum__qis__reset__body(%Qubit* null)
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 1 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 3 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 4 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 5 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 6 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 7 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 8 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 9 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 11 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 13 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 15 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 17 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 18 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 19 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 21 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 22 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 23 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 24 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 26 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 27 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 29 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 31 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 36 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 37 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 38 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 39 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 40 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 41 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 42 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 43 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 44 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 45 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 47 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 51 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 53 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 54 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 55 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 56 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 57 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 58 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 59 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 60 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 61 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 62 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 63 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 67 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 69 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 72 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 73 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 74 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 75 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 76 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 77 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 78 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 79 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 80 to %Qubit*))
  call void @__quantum__qis__dumpmachine__body(i8* null)
  ret void
}

declare void @__quantum__qis__reset__body(%Qubit*)

declare void @__quantum__qis__cnot__body(%Qubit*, %Qubit*)

declare void @__quantum__qis__mz__body(%Qubit*, %Result*)

declare void @__quantum__qis__h__body(%Qubit*)

declare i1 @__quantum__qis__read_result__body(%Result*)

declare void @__quantum__qis__z__body(%Qubit*)

declare void @__quantum__qis__x__body(%Qubit*)

declare void @__quantum__qis__dumpmachine__body(i8*)

attributes #0 = { "EntryPoint" "requiredQubits"="82" "requiredResults"="86" }
