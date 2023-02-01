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
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 73 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 74 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 73 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 74 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 73 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 74 to %Qubit*))
  %47 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %47, label %then139, label %else140

then139:                                          ; preds = %continue138
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 74 to %Qubit*))
  br label %continue141

else140:                                          ; preds = %continue138
  br label %continue141

continue141:                                      ; preds = %else140, %then139
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 24 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 25 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 24 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 24 to %Qubit*))
  %48 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %48, label %then142, label %else143

then142:                                          ; preds = %continue141
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 24 to %Qubit*))
  br label %continue144

else143:                                          ; preds = %continue141
  br label %continue144

continue144:                                      ; preds = %else143, %then142
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 75 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 76 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 75 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 76 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 75 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 76 to %Qubit*))
  %49 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %49, label %then145, label %else146

then145:                                          ; preds = %continue144
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 76 to %Qubit*))
  br label %continue147

else146:                                          ; preds = %continue144
  br label %continue147

continue147:                                      ; preds = %else146, %then145
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 77 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 78 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 77 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 78 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 77 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 78 to %Qubit*))
  %50 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %50, label %then148, label %else149

then148:                                          ; preds = %continue147
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 78 to %Qubit*))
  br label %continue150

else149:                                          ; preds = %continue147
  br label %continue150

continue150:                                      ; preds = %else149, %then148
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 79 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 80 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 79 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 80 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 79 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 80 to %Qubit*))
  %51 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %51, label %then151, label %else152

then151:                                          ; preds = %continue150
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 80 to %Qubit*))
  br label %continue153

else152:                                          ; preds = %continue150
  br label %continue153

continue153:                                      ; preds = %else152, %then151
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 62 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 62 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 71 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 62 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %52 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %52, label %then154, label %else155

then154:                                          ; preds = %continue153
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 62 to %Qubit*))
  br label %continue156

else155:                                          ; preds = %continue153
  br label %continue156

continue156:                                      ; preds = %else155, %then154
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 53 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 53 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 44 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 44 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 53 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 44 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %53 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %53, label %then157, label %else158

then157:                                          ; preds = %continue156
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 44 to %Qubit*))
  br label %continue159

else158:                                          ; preds = %continue156
  br label %continue159

continue159:                                      ; preds = %else158, %then157
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 26 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 26 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 35 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 26 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %54 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %54, label %then160, label %else161

then160:                                          ; preds = %continue159
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 26 to %Qubit*))
  br label %continue162

else161:                                          ; preds = %continue159
  br label %continue162

continue162:                                      ; preds = %else161, %then160
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 74 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 75 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 74 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 75 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 74 to %Qubit*), %Result* inttoptr (i64 74 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 75 to %Qubit*), %Result* inttoptr (i64 75 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 76 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 77 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 76 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 77 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 76 to %Qubit*), %Result* inttoptr (i64 76 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 77 to %Qubit*), %Result* inttoptr (i64 77 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 78 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 79 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 78 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 79 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 78 to %Qubit*), %Result* inttoptr (i64 78 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 79 to %Qubit*), %Result* inttoptr (i64 79 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 80 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 71 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 80 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 80 to %Qubit*), %Result* inttoptr (i64 80 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 71 to %Qubit*), %Result* inttoptr (i64 71 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 62 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 53 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 62 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 62 to %Qubit*), %Result* inttoptr (i64 62 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 53 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 53 to %Qubit*), %Result* inttoptr (i64 53 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 44 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 35 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 44 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 44 to %Qubit*), %Result* inttoptr (i64 44 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 35 to %Qubit*), %Result* inttoptr (i64 35 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 26 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 25 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 26 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 25 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 26 to %Qubit*), %Result* inttoptr (i64 26 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 25 to %Qubit*), %Result* inttoptr (i64 25 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 24 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 33 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 24 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 24 to %Qubit*), %Result* inttoptr (i64 24 to %Result*))
  %55 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %55, label %then163, label %else164

then163:                                          ; preds = %continue162
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue165

else164:                                          ; preds = %continue162
  br label %continue165

continue165:                                      ; preds = %else164, %then163
  %56 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 24 to %Result*))
  br i1 %56, label %then166, label %else167

then166:                                          ; preds = %continue165
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue168

else167:                                          ; preds = %continue165
  br label %continue168

continue168:                                      ; preds = %else167, %then166
  %57 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 75 to %Result*))
  br i1 %57, label %then169, label %else170

then169:                                          ; preds = %continue168
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue171

else170:                                          ; preds = %continue168
  br label %continue171

continue171:                                      ; preds = %else170, %then169
  %58 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 77 to %Result*))
  br i1 %58, label %then172, label %else173

then172:                                          ; preds = %continue171
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue174

else173:                                          ; preds = %continue171
  br label %continue174

continue174:                                      ; preds = %else173, %then172
  %59 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 79 to %Result*))
  br i1 %59, label %then175, label %else176

then175:                                          ; preds = %continue174
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue177

else176:                                          ; preds = %continue174
  br label %continue177

continue177:                                      ; preds = %else176, %then175
  %60 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 71 to %Result*))
  br i1 %60, label %then178, label %else179

then178:                                          ; preds = %continue177
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue180

else179:                                          ; preds = %continue177
  br label %continue180

continue180:                                      ; preds = %else179, %then178
  %61 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 53 to %Result*))
  br i1 %61, label %then181, label %else182

then181:                                          ; preds = %continue180
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue183

else182:                                          ; preds = %continue180
  br label %continue183

continue183:                                      ; preds = %else182, %then181
  %62 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 35 to %Result*))
  br i1 %62, label %then184, label %else185

then184:                                          ; preds = %continue183
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue186

else185:                                          ; preds = %continue183
  br label %continue186

continue186:                                      ; preds = %else185, %then184
  %63 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 25 to %Result*))
  br i1 %63, label %then187, label %else188

then187:                                          ; preds = %continue186
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue189

else188:                                          ; preds = %continue186
  br label %continue189

continue189:                                      ; preds = %else188, %then187
  %64 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 74 to %Result*))
  br i1 %64, label %then190, label %else191

then190:                                          ; preds = %continue189
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue192

else191:                                          ; preds = %continue189
  br label %continue192

continue192:                                      ; preds = %else191, %then190
  %65 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 76 to %Result*))
  br i1 %65, label %then193, label %else194

then193:                                          ; preds = %continue192
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue195

else194:                                          ; preds = %continue192
  br label %continue195

continue195:                                      ; preds = %else194, %then193
  %66 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 78 to %Result*))
  br i1 %66, label %then196, label %else197

then196:                                          ; preds = %continue195
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue198

else197:                                          ; preds = %continue195
  br label %continue198

continue198:                                      ; preds = %else197, %then196
  %67 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 80 to %Result*))
  br i1 %67, label %then199, label %else200

then199:                                          ; preds = %continue198
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue201

else200:                                          ; preds = %continue198
  br label %continue201

continue201:                                      ; preds = %else200, %then199
  %68 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 62 to %Result*))
  br i1 %68, label %then202, label %else203

then202:                                          ; preds = %continue201
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue204

else203:                                          ; preds = %continue201
  br label %continue204

continue204:                                      ; preds = %else203, %then202
  %69 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 44 to %Result*))
  br i1 %69, label %then205, label %else206

then205:                                          ; preds = %continue204
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue207

else206:                                          ; preds = %continue204
  br label %continue207

continue207:                                      ; preds = %else206, %then205
  %70 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 26 to %Result*))
  br i1 %70, label %then208, label %else209

then208:                                          ; preds = %continue207
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue210

else209:                                          ; preds = %continue207
  br label %continue210

continue210:                                      ; preds = %else209, %then208
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 64 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 73 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 33 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 32 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 32 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 73 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 73 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 33 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %71 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %71, label %then211, label %else212

then211:                                          ; preds = %continue210
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 64 to %Qubit*))
  br label %continue213

else212:                                          ; preds = %continue210
  br label %continue213

continue213:                                      ; preds = %else212, %then211
  %72 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %72, label %then214, label %else215

then214:                                          ; preds = %continue213
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 64 to %Qubit*))
  br label %continue216

else215:                                          ; preds = %continue213
  br label %continue216

continue216:                                      ; preds = %else215, %then214
  %73 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %73, label %then217, label %else218

then217:                                          ; preds = %continue216
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 32 to %Qubit*))
  br label %continue219

else218:                                          ; preds = %continue216
  br label %continue219

continue219:                                      ; preds = %else218, %then217
  %74 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %74, label %then220, label %else221

then220:                                          ; preds = %continue219
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 32 to %Qubit*))
  br label %continue222

else221:                                          ; preds = %continue219
  br label %continue222

continue222:                                      ; preds = %else221, %then220
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 41 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 40 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 41 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 40 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 41 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 40 to %Qubit*))
  %75 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %75, label %then223, label %else224

then223:                                          ; preds = %continue222
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 40 to %Qubit*))
  br label %continue225

else224:                                          ; preds = %continue222
  br label %continue225

continue225:                                      ; preds = %else224, %then223
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 40 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 49 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 40 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 40 to %Qubit*), %Result* inttoptr (i64 40 to %Result*))
  %76 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %76, label %then226, label %else227

then226:                                          ; preds = %continue225
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  br label %continue228

else227:                                          ; preds = %continue225
  br label %continue228

continue228:                                      ; preds = %else227, %then226
  %77 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 40 to %Result*))
  br i1 %77, label %then229, label %else230

then229:                                          ; preds = %continue228
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  br label %continue231

else230:                                          ; preds = %continue228
  br label %continue231

continue231:                                      ; preds = %else230, %then229
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 32 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 41 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 49 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 50 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 50 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 41 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 41 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 49 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %78 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %78, label %then232, label %else233

then232:                                          ; preds = %continue231
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 32 to %Qubit*))
  br label %continue234

else233:                                          ; preds = %continue231
  br label %continue234

continue234:                                      ; preds = %else233, %then232
  %79 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %79, label %then235, label %else236

then235:                                          ; preds = %continue234
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 32 to %Qubit*))
  br label %continue237

else236:                                          ; preds = %continue234
  br label %continue237

continue237:                                      ; preds = %else236, %then235
  %80 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %80, label %then238, label %else239

then238:                                          ; preds = %continue237
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 50 to %Qubit*))
  br label %continue240

else239:                                          ; preds = %continue237
  br label %continue240

continue240:                                      ; preds = %else239, %then238
  %81 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %81, label %then241, label %else242

then241:                                          ; preds = %continue240
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 50 to %Qubit*))
  br label %continue243

else242:                                          ; preds = %continue240
  br label %continue243

continue243:                                      ; preds = %else242, %then241
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 19 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 19 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 20 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 19 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  %82 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %82, label %then244, label %else245

then244:                                          ; preds = %continue243
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  br label %continue246

else245:                                          ; preds = %continue243
  br label %continue246

continue246:                                      ; preds = %else245, %then244
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 29 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 29 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 20 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 29 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 20 to %Qubit*), %Result* inttoptr (i64 20 to %Result*))
  %83 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %83, label %then247, label %else248

then247:                                          ; preds = %continue246
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 29 to %Qubit*))
  br label %continue249

else248:                                          ; preds = %continue246
  br label %continue249

continue249:                                      ; preds = %else248, %then247
  %84 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 20 to %Result*))
  br i1 %84, label %then250, label %else251

then250:                                          ; preds = %continue249
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 29 to %Qubit*))
  br label %continue252

else251:                                          ; preds = %continue249
  br label %continue252

continue252:                                      ; preds = %else251, %then250
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 28 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 19 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 29 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 30 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 29 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 30 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 19 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 19 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 29 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %85 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %85, label %then253, label %else254

then253:                                          ; preds = %continue252
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 28 to %Qubit*))
  br label %continue255

else254:                                          ; preds = %continue252
  br label %continue255

continue255:                                      ; preds = %else254, %then253
  %86 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %86, label %then256, label %else257

then256:                                          ; preds = %continue255
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 28 to %Qubit*))
  br label %continue258

else257:                                          ; preds = %continue255
  br label %continue258

continue258:                                      ; preds = %else257, %then256
  %87 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %87, label %then259, label %else260

then259:                                          ; preds = %continue258
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 30 to %Qubit*))
  br label %continue261

else260:                                          ; preds = %continue258
  br label %continue261

continue261:                                      ; preds = %else260, %then259
  %88 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %88, label %then262, label %else263

then262:                                          ; preds = %continue261
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 30 to %Qubit*))
  br label %continue264

else263:                                          ; preds = %continue261
  br label %continue264

continue264:                                      ; preds = %else263, %then262
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 61 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 60 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 61 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 60 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 61 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 60 to %Qubit*))
  %89 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %89, label %then265, label %else266

then265:                                          ; preds = %continue264
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 60 to %Qubit*))
  br label %continue267

else266:                                          ; preds = %continue264
  br label %continue267

continue267:                                      ; preds = %else266, %then265
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 59 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 58 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 59 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 58 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 59 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 58 to %Qubit*))
  %90 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %90, label %then268, label %else269

then268:                                          ; preds = %continue267
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 58 to %Qubit*))
  br label %continue270

else269:                                          ; preds = %continue267
  br label %continue270

continue270:                                      ; preds = %else269, %then268
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 60 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 59 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 60 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 59 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 60 to %Qubit*), %Result* inttoptr (i64 60 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 59 to %Qubit*), %Result* inttoptr (i64 59 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 58 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 49 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 58 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 58 to %Qubit*), %Result* inttoptr (i64 58 to %Result*))
  %91 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %91, label %then271, label %else272

then271:                                          ; preds = %continue270
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  br label %continue273

else272:                                          ; preds = %continue270
  br label %continue273

continue273:                                      ; preds = %else272, %then271
  %92 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 58 to %Result*))
  br i1 %92, label %then274, label %else275

then274:                                          ; preds = %continue273
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  br label %continue276

else275:                                          ; preds = %continue273
  br label %continue276

continue276:                                      ; preds = %else275, %then274
  %93 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 59 to %Result*))
  br i1 %93, label %then277, label %else278

then277:                                          ; preds = %continue276
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  br label %continue279

else278:                                          ; preds = %continue276
  br label %continue279

continue279:                                      ; preds = %else278, %then277
  %94 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 60 to %Result*))
  br i1 %94, label %then280, label %else281

then280:                                          ; preds = %continue279
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  br label %continue282

else281:                                          ; preds = %continue279
  br label %continue282

continue282:                                      ; preds = %else281, %then280
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 52 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 61 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 49 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 48 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 48 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 61 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 61 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 49 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %95 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %95, label %then283, label %else284

then283:                                          ; preds = %continue282
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 52 to %Qubit*))
  br label %continue285

else284:                                          ; preds = %continue282
  br label %continue285

continue285:                                      ; preds = %else284, %then283
  %96 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %96, label %then286, label %else287

then286:                                          ; preds = %continue285
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 52 to %Qubit*))
  br label %continue288

else287:                                          ; preds = %continue285
  br label %continue288

continue288:                                      ; preds = %else287, %then286
  %97 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %97, label %then289, label %else290

then289:                                          ; preds = %continue288
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 48 to %Qubit*))
  br label %continue291

else290:                                          ; preds = %continue288
  br label %continue291

continue291:                                      ; preds = %else290, %then289
  %98 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %98, label %then292, label %else293

then292:                                          ; preds = %continue291
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 48 to %Qubit*))
  br label %continue294

else293:                                          ; preds = %continue291
  br label %continue294

continue294:                                      ; preds = %else293, %then292
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 23 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 22 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 23 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 22 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 23 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 22 to %Qubit*))
  %99 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %99, label %then295, label %else296

then295:                                          ; preds = %continue294
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 22 to %Qubit*))
  br label %continue297

else296:                                          ; preds = %continue294
  br label %continue297

continue297:                                      ; preds = %else296, %then295
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 47 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 47 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 56 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 56 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 47 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 56 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %100 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %100, label %then298, label %else299

then298:                                          ; preds = %continue297
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 56 to %Qubit*))
  br label %continue300

else299:                                          ; preds = %continue297
  br label %continue300

continue300:                                      ; preds = %else299, %then298
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 21 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 21 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 20 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 21 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  %101 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %101, label %then301, label %else302

then301:                                          ; preds = %continue300
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  br label %continue303

else302:                                          ; preds = %continue300
  br label %continue303

continue303:                                      ; preds = %else302, %then301
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 29 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 29 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 38 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 38 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 29 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 38 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %102 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %102, label %then304, label %else305

then304:                                          ; preds = %continue303
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 38 to %Qubit*))
  br label %continue306

else305:                                          ; preds = %continue303
  br label %continue306

continue306:                                      ; preds = %else305, %then304
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 22 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 21 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 22 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 21 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 22 to %Qubit*), %Result* inttoptr (i64 22 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 21 to %Qubit*), %Result* inttoptr (i64 21 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 20 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 29 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 20 to %Qubit*), %Result* inttoptr (i64 20 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 29 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 29 to %Qubit*), %Result* inttoptr (i64 29 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 38 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 47 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 38 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 38 to %Qubit*), %Result* inttoptr (i64 38 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 47 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 47 to %Qubit*), %Result* inttoptr (i64 47 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 56 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 65 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 56 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 56 to %Qubit*), %Result* inttoptr (i64 56 to %Result*))
  %103 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %103, label %then307, label %else308

then307:                                          ; preds = %continue306
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  br label %continue309

else308:                                          ; preds = %continue306
  br label %continue309

continue309:                                      ; preds = %else308, %then307
  %104 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 56 to %Result*))
  br i1 %104, label %then310, label %else311

then310:                                          ; preds = %continue309
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  br label %continue312

else311:                                          ; preds = %continue309
  br label %continue312

continue312:                                      ; preds = %else311, %then310
  %105 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 21 to %Result*))
  br i1 %105, label %then313, label %else314

then313:                                          ; preds = %continue312
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  br label %continue315

else314:                                          ; preds = %continue312
  br label %continue315

continue315:                                      ; preds = %else314, %then313
  %106 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 29 to %Result*))
  br i1 %106, label %then316, label %else317

then316:                                          ; preds = %continue315
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  br label %continue318

else317:                                          ; preds = %continue315
  br label %continue318

continue318:                                      ; preds = %else317, %then316
  %107 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 47 to %Result*))
  br i1 %107, label %then319, label %else320

then319:                                          ; preds = %continue318
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  br label %continue321

else320:                                          ; preds = %continue318
  br label %continue321

continue321:                                      ; preds = %else320, %then319
  %108 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 22 to %Result*))
  br i1 %108, label %then322, label %else323

then322:                                          ; preds = %continue321
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  br label %continue324

else323:                                          ; preds = %continue321
  br label %continue324

continue324:                                      ; preds = %else323, %then322
  %109 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 20 to %Result*))
  br i1 %109, label %then325, label %else326

then325:                                          ; preds = %continue324
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  br label %continue327

else326:                                          ; preds = %continue324
  br label %continue327

continue327:                                      ; preds = %else326, %then325
  %110 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 38 to %Result*))
  br i1 %110, label %then328, label %else329

then328:                                          ; preds = %continue327
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  br label %continue330

else329:                                          ; preds = %continue327
  br label %continue330

continue330:                                      ; preds = %else329, %then328
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 14 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 23 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 65 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 66 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 66 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 23 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 23 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 65 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %111 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %111, label %then331, label %else332

then331:                                          ; preds = %continue330
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 14 to %Qubit*))
  br label %continue333

else332:                                          ; preds = %continue330
  br label %continue333

continue333:                                      ; preds = %else332, %then331
  %112 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %112, label %then334, label %else335

then334:                                          ; preds = %continue333
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 14 to %Qubit*))
  br label %continue336

else335:                                          ; preds = %continue333
  br label %continue336

continue336:                                      ; preds = %else335, %then334
  %113 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %113, label %then337, label %else338

then337:                                          ; preds = %continue336
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 66 to %Qubit*))
  br label %continue339

else338:                                          ; preds = %continue336
  br label %continue339

continue339:                                      ; preds = %else338, %then337
  %114 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %114, label %then340, label %else341

then340:                                          ; preds = %continue339
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 66 to %Qubit*))
  br label %continue342

else341:                                          ; preds = %continue339
  br label %continue342

continue342:                                      ; preds = %else341, %then340
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 1 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 1 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 2 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 1 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  %115 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %115, label %then343, label %else344

then343:                                          ; preds = %continue342
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  br label %continue345

else344:                                          ; preds = %continue342
  br label %continue345

continue345:                                      ; preds = %else344, %then343
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 53 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 53 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 62 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 62 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 53 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 62 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %116 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %116, label %then346, label %else347

then346:                                          ; preds = %continue345
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 62 to %Qubit*))
  br label %continue348

else347:                                          ; preds = %continue345
  br label %continue348

continue348:                                      ; preds = %else347, %then346
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 3 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 4 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 3 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 4 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 3 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 4 to %Qubit*))
  %117 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %117, label %then349, label %else350

then349:                                          ; preds = %continue348
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 4 to %Qubit*))
  br label %continue351

else350:                                          ; preds = %continue348
  br label %continue351

continue351:                                      ; preds = %else350, %then349
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 5 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 6 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 5 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 6 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 5 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 6 to %Qubit*))
  %118 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %118, label %then352, label %else353

then352:                                          ; preds = %continue351
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 6 to %Qubit*))
  br label %continue354

else353:                                          ; preds = %continue351
  br label %continue354

continue354:                                      ; preds = %else353, %then352
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 7 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 8 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 7 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 8 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 7 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 8 to %Qubit*))
  %119 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %119, label %then355, label %else356

then355:                                          ; preds = %continue354
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 8 to %Qubit*))
  br label %continue357

else356:                                          ; preds = %continue354
  br label %continue357

continue357:                                      ; preds = %else356, %then355
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 17 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 17 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 26 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 26 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 17 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 26 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %120 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %120, label %then358, label %else359

then358:                                          ; preds = %continue357
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 26 to %Qubit*))
  br label %continue360

else359:                                          ; preds = %continue357
  br label %continue360

continue360:                                      ; preds = %else359, %then358
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 44 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 44 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 35 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 44 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %121 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %121, label %then361, label %else362

then361:                                          ; preds = %continue360
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 44 to %Qubit*))
  br label %continue363

else362:                                          ; preds = %continue360
  br label %continue363

continue363:                                      ; preds = %else362, %then361
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 2 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 3 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 3 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 2 to %Qubit*), %Result* inttoptr (i64 2 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 3 to %Qubit*), %Result* inttoptr (i64 3 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 4 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 5 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 4 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 5 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 4 to %Qubit*), %Result* inttoptr (i64 4 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 5 to %Qubit*), %Result* inttoptr (i64 5 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 6 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 7 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 6 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 7 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 6 to %Qubit*), %Result* inttoptr (i64 6 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 7 to %Qubit*), %Result* inttoptr (i64 7 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 8 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 17 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 8 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 8 to %Qubit*), %Result* inttoptr (i64 8 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 17 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 17 to %Qubit*), %Result* inttoptr (i64 17 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 26 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 35 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 26 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 26 to %Qubit*), %Result* inttoptr (i64 26 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 35 to %Qubit*), %Result* inttoptr (i64 35 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 44 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 53 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 44 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 44 to %Qubit*), %Result* inttoptr (i64 44 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 53 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 53 to %Qubit*), %Result* inttoptr (i64 53 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 62 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 71 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 62 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 62 to %Qubit*), %Result* inttoptr (i64 62 to %Result*))
  %122 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %122, label %then364, label %else365

then364:                                          ; preds = %continue363
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  br label %continue366

else365:                                          ; preds = %continue363
  br label %continue366

continue366:                                      ; preds = %else365, %then364
  %123 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 62 to %Result*))
  br i1 %123, label %then367, label %else368

then367:                                          ; preds = %continue366
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  br label %continue369

else368:                                          ; preds = %continue366
  br label %continue369

continue369:                                      ; preds = %else368, %then367
  %124 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 3 to %Result*))
  br i1 %124, label %then370, label %else371

then370:                                          ; preds = %continue369
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  br label %continue372

else371:                                          ; preds = %continue369
  br label %continue372

continue372:                                      ; preds = %else371, %then370
  %125 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 5 to %Result*))
  br i1 %125, label %then373, label %else374

then373:                                          ; preds = %continue372
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  br label %continue375

else374:                                          ; preds = %continue372
  br label %continue375

continue375:                                      ; preds = %else374, %then373
  %126 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 7 to %Result*))
  br i1 %126, label %then376, label %else377

then376:                                          ; preds = %continue375
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  br label %continue378

else377:                                          ; preds = %continue375
  br label %continue378

continue378:                                      ; preds = %else377, %then376
  %127 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 17 to %Result*))
  br i1 %127, label %then379, label %else380

then379:                                          ; preds = %continue378
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  br label %continue381

else380:                                          ; preds = %continue378
  br label %continue381

continue381:                                      ; preds = %else380, %then379
  %128 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 35 to %Result*))
  br i1 %128, label %then382, label %else383

then382:                                          ; preds = %continue381
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  br label %continue384

else383:                                          ; preds = %continue381
  br label %continue384

continue384:                                      ; preds = %else383, %then382
  %129 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 53 to %Result*))
  br i1 %129, label %then385, label %else386

then385:                                          ; preds = %continue384
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  br label %continue387

else386:                                          ; preds = %continue384
  br label %continue387

continue387:                                      ; preds = %else386, %then385
  %130 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 2 to %Result*))
  br i1 %130, label %then388, label %else389

then388:                                          ; preds = %continue387
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  br label %continue390

else389:                                          ; preds = %continue387
  br label %continue390

continue390:                                      ; preds = %else389, %then388
  %131 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 4 to %Result*))
  br i1 %131, label %then391, label %else392

then391:                                          ; preds = %continue390
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  br label %continue393

else392:                                          ; preds = %continue390
  br label %continue393

continue393:                                      ; preds = %else392, %then391
  %132 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 6 to %Result*))
  br i1 %132, label %then394, label %else395

then394:                                          ; preds = %continue393
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  br label %continue396

else395:                                          ; preds = %continue393
  br label %continue396

continue396:                                      ; preds = %else395, %then394
  %133 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 8 to %Result*))
  br i1 %133, label %then397, label %else398

then397:                                          ; preds = %continue396
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  br label %continue399

else398:                                          ; preds = %continue396
  br label %continue399

continue399:                                      ; preds = %else398, %then397
  %134 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 26 to %Result*))
  br i1 %134, label %then400, label %else401

then400:                                          ; preds = %continue399
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  br label %continue402

else401:                                          ; preds = %continue399
  br label %continue402

continue402:                                      ; preds = %else401, %then400
  %135 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 44 to %Result*))
  br i1 %135, label %then403, label %else404

then403:                                          ; preds = %continue402
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  br label %continue405

else404:                                          ; preds = %continue402
  br label %continue405

continue405:                                      ; preds = %else404, %then403
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 10 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 1 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 71 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 70 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 70 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 1 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 1 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 71 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %136 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %136, label %then406, label %else407

then406:                                          ; preds = %continue405
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 10 to %Qubit*))
  br label %continue408

else407:                                          ; preds = %continue405
  br label %continue408

continue408:                                      ; preds = %else407, %then406
  %137 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %137, label %then409, label %else410

then409:                                          ; preds = %continue408
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 10 to %Qubit*))
  br label %continue411

else410:                                          ; preds = %continue408
  br label %continue411

continue411:                                      ; preds = %else410, %then409
  %138 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %138, label %then412, label %else413

then412:                                          ; preds = %continue411
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 70 to %Qubit*))
  br label %continue414

else413:                                          ; preds = %continue411
  br label %continue414

continue414:                                      ; preds = %else413, %then412
  %139 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %139, label %then415, label %else416

then415:                                          ; preds = %continue414
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 70 to %Qubit*))
  br label %continue417

else416:                                          ; preds = %continue414
  br label %continue417

continue417:                                      ; preds = %else416, %then415
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 43 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 42 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 43 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 42 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 43 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 42 to %Qubit*))
  %140 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %140, label %then418, label %else419

then418:                                          ; preds = %continue417
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 42 to %Qubit*))
  br label %continue420

else419:                                          ; preds = %continue417
  br label %continue420

continue420:                                      ; preds = %else419, %then418
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 51 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 51 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 42 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 51 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 42 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 42 to %Qubit*), %Result* inttoptr (i64 42 to %Result*))
  %141 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %141, label %then421, label %else422

then421:                                          ; preds = %continue420
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 51 to %Qubit*))
  br label %continue423

else422:                                          ; preds = %continue420
  br label %continue423

continue423:                                      ; preds = %else422, %then421
  %142 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 42 to %Result*))
  br i1 %142, label %then424, label %else425

then424:                                          ; preds = %continue423
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 51 to %Qubit*))
  br label %continue426

else425:                                          ; preds = %continue423
  br label %continue426

continue426:                                      ; preds = %else425, %then424
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
  %143 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %143, label %then427, label %else428

then427:                                          ; preds = %continue426
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 52 to %Qubit*))
  br label %continue429

else428:                                          ; preds = %continue426
  br label %continue429

continue429:                                      ; preds = %else428, %then427
  %144 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %144, label %then430, label %else431

then430:                                          ; preds = %continue429
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 52 to %Qubit*))
  br label %continue432

else431:                                          ; preds = %continue429
  br label %continue432

continue432:                                      ; preds = %else431, %then430
  %145 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %145, label %then433, label %else434

then433:                                          ; preds = %continue432
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 50 to %Qubit*))
  br label %continue435

else434:                                          ; preds = %continue432
  br label %continue435

continue435:                                      ; preds = %else434, %then433
  %146 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %146, label %then436, label %else437

then436:                                          ; preds = %continue435
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 50 to %Qubit*))
  br label %continue438

else437:                                          ; preds = %continue435
  br label %continue438

continue438:                                      ; preds = %else437, %then436
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 37 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 36 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 37 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 36 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 37 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 36 to %Qubit*))
  %147 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %147, label %then439, label %else440

then439:                                          ; preds = %continue438
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 36 to %Qubit*))
  br label %continue441

else440:                                          ; preds = %continue438
  br label %continue441

continue441:                                      ; preds = %else440, %then439
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 27 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 27 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 18 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 18 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 27 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 18 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %148 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %148, label %then442, label %else443

then442:                                          ; preds = %continue441
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 18 to %Qubit*))
  br label %continue444

else443:                                          ; preds = %continue441
  br label %continue444

continue444:                                      ; preds = %else443, %then442
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 36 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 27 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 36 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 36 to %Qubit*), %Result* inttoptr (i64 36 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 27 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 27 to %Qubit*), %Result* inttoptr (i64 27 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 9 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 9 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 18 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 9 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 18 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 18 to %Qubit*), %Result* inttoptr (i64 18 to %Result*))
  %149 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %149, label %then445, label %else446

then445:                                          ; preds = %continue444
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 9 to %Qubit*))
  br label %continue447

else446:                                          ; preds = %continue444
  br label %continue447

continue447:                                      ; preds = %else446, %then445
  %150 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 18 to %Result*))
  br i1 %150, label %then448, label %else449

then448:                                          ; preds = %continue447
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 9 to %Qubit*))
  br label %continue450

else449:                                          ; preds = %continue447
  br label %continue450

continue450:                                      ; preds = %else449, %then448
  %151 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 27 to %Result*))
  br i1 %151, label %then451, label %else452

then451:                                          ; preds = %continue450
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 9 to %Qubit*))
  br label %continue453

else452:                                          ; preds = %continue450
  br label %continue453

continue453:                                      ; preds = %else452, %then451
  %152 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 36 to %Result*))
  br i1 %152, label %then454, label %else455

then454:                                          ; preds = %continue453
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 9 to %Qubit*))
  br label %continue456

else455:                                          ; preds = %continue453
  br label %continue456

continue456:                                      ; preds = %else455, %then454
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 46 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 37 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 9 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 10 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 9 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 10 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 37 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 37 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 9 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %153 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %153, label %then457, label %else458

then457:                                          ; preds = %continue456
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 46 to %Qubit*))
  br label %continue459

else458:                                          ; preds = %continue456
  br label %continue459

continue459:                                      ; preds = %else458, %then457
  %154 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %154, label %then460, label %else461

then460:                                          ; preds = %continue459
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 46 to %Qubit*))
  br label %continue462

else461:                                          ; preds = %continue459
  br label %continue462

continue462:                                      ; preds = %else461, %then460
  %155 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %155, label %then463, label %else464

then463:                                          ; preds = %continue462
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 10 to %Qubit*))
  br label %continue465

else464:                                          ; preds = %continue462
  br label %continue465

continue465:                                      ; preds = %else464, %then463
  %156 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %156, label %then466, label %else467

then466:                                          ; preds = %continue465
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 10 to %Qubit*))
  br label %continue468

else467:                                          ; preds = %continue465
  br label %continue468

continue468:                                      ; preds = %else467, %then466
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 21 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 22 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 21 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 22 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 21 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 22 to %Qubit*))
  %157 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %157, label %then469, label %else470

then469:                                          ; preds = %continue468
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 22 to %Qubit*))
  br label %continue471

else470:                                          ; preds = %continue468
  br label %continue471

continue471:                                      ; preds = %else470, %then469
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 58 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 58 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 49 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 58 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %158 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %158, label %then472, label %else473

then472:                                          ; preds = %continue471
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 58 to %Qubit*))
  br label %continue474

else473:                                          ; preds = %continue471
  br label %continue474

continue474:                                      ; preds = %else473, %then472
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 31 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 31 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 40 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 40 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 31 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 40 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %159 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %159, label %then475, label %else476

then475:                                          ; preds = %continue474
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 40 to %Qubit*))
  br label %continue477

else476:                                          ; preds = %continue474
  br label %continue477

continue477:                                      ; preds = %else476, %then475
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 22 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 31 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 22 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 22 to %Qubit*), %Result* inttoptr (i64 22 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 31 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 31 to %Qubit*), %Result* inttoptr (i64 31 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 40 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 49 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 40 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 40 to %Qubit*), %Result* inttoptr (i64 40 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 49 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 49 to %Qubit*), %Result* inttoptr (i64 49 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 67 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 67 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 58 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 67 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 58 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 58 to %Qubit*), %Result* inttoptr (i64 58 to %Result*))
  %160 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %160, label %then478, label %else479

then478:                                          ; preds = %continue477
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 67 to %Qubit*))
  br label %continue480

else479:                                          ; preds = %continue477
  br label %continue480

continue480:                                      ; preds = %else479, %then478
  %161 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 58 to %Result*))
  br i1 %161, label %then481, label %else482

then481:                                          ; preds = %continue480
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 67 to %Qubit*))
  br label %continue483

else482:                                          ; preds = %continue480
  br label %continue483

continue483:                                      ; preds = %else482, %then481
  %162 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 31 to %Result*))
  br i1 %162, label %then484, label %else485

then484:                                          ; preds = %continue483
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 67 to %Qubit*))
  br label %continue486

else485:                                          ; preds = %continue483
  br label %continue486

continue486:                                      ; preds = %else485, %then484
  %163 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 49 to %Result*))
  br i1 %163, label %then487, label %else488

then487:                                          ; preds = %continue486
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 67 to %Qubit*))
  br label %continue489

else488:                                          ; preds = %continue486
  br label %continue489

continue489:                                      ; preds = %else488, %then487
  %164 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 22 to %Result*))
  br i1 %164, label %then490, label %else491

then490:                                          ; preds = %continue489
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 67 to %Qubit*))
  br label %continue492

else491:                                          ; preds = %continue489
  br label %continue492

continue492:                                      ; preds = %else491, %then490
  %165 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 40 to %Result*))
  br i1 %165, label %then493, label %else494

then493:                                          ; preds = %continue492
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 67 to %Qubit*))
  br label %continue495

else494:                                          ; preds = %continue492
  br label %continue495

continue495:                                      ; preds = %else494, %then493
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 12 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 21 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 67 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 68 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 67 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 68 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 21 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 21 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 67 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %166 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %166, label %then496, label %else497

then496:                                          ; preds = %continue495
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  br label %continue498

else497:                                          ; preds = %continue495
  br label %continue498

continue498:                                      ; preds = %else497, %then496
  %167 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %167, label %then499, label %else500

then499:                                          ; preds = %continue498
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  br label %continue501

else500:                                          ; preds = %continue498
  br label %continue501

continue501:                                      ; preds = %else500, %then499
  %168 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %168, label %then502, label %else503

then502:                                          ; preds = %continue501
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 68 to %Qubit*))
  br label %continue504

else503:                                          ; preds = %continue501
  br label %continue504

continue504:                                      ; preds = %else503, %then502
  %169 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %169, label %then505, label %else506

then505:                                          ; preds = %continue504
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 68 to %Qubit*))
  br label %continue507

else506:                                          ; preds = %continue504
  br label %continue507

continue507:                                      ; preds = %else506, %then505
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 75 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 76 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 75 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 76 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 75 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 76 to %Qubit*))
  %170 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %170, label %then508, label %else509

then508:                                          ; preds = %continue507
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 76 to %Qubit*))
  br label %continue510

else509:                                          ; preds = %continue507
  br label %continue510

continue510:                                      ; preds = %else509, %then508
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 53 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 53 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 44 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 44 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 53 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 44 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %171 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %171, label %then511, label %else512

then511:                                          ; preds = %continue510
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 44 to %Qubit*))
  br label %continue513

else512:                                          ; preds = %continue510
  br label %continue513

continue513:                                      ; preds = %else512, %then511
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 77 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 78 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 77 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 78 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 77 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 78 to %Qubit*))
  %172 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %172, label %then514, label %else515

then514:                                          ; preds = %continue513
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 78 to %Qubit*))
  br label %continue516

else515:                                          ; preds = %continue513
  br label %continue516

continue516:                                      ; preds = %else515, %then514
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 79 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 80 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 79 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 80 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 79 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 80 to %Qubit*))
  %173 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %173, label %then517, label %else518

then517:                                          ; preds = %continue516
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 80 to %Qubit*))
  br label %continue519

else518:                                          ; preds = %continue516
  br label %continue519

continue519:                                      ; preds = %else518, %then517
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 62 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 62 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 71 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 62 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %174 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %174, label %then520, label %else521

then520:                                          ; preds = %continue519
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 62 to %Qubit*))
  br label %continue522

else521:                                          ; preds = %continue519
  br label %continue522

continue522:                                      ; preds = %else521, %then520
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 76 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 77 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 76 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 77 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 76 to %Qubit*), %Result* inttoptr (i64 76 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 77 to %Qubit*), %Result* inttoptr (i64 77 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 78 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 79 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 78 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 79 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 78 to %Qubit*), %Result* inttoptr (i64 78 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 79 to %Qubit*), %Result* inttoptr (i64 79 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 80 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 71 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 80 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 80 to %Qubit*), %Result* inttoptr (i64 80 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 71 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 71 to %Qubit*), %Result* inttoptr (i64 71 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 62 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 53 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 62 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 62 to %Qubit*), %Result* inttoptr (i64 62 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 53 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 53 to %Qubit*), %Result* inttoptr (i64 53 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 44 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 35 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 44 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 44 to %Qubit*), %Result* inttoptr (i64 44 to %Result*))
  %175 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %175, label %then523, label %else524

then523:                                          ; preds = %continue522
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  br label %continue525

else524:                                          ; preds = %continue522
  br label %continue525

continue525:                                      ; preds = %else524, %then523
  %176 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 44 to %Result*))
  br i1 %176, label %then526, label %else527

then526:                                          ; preds = %continue525
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  br label %continue528

else527:                                          ; preds = %continue525
  br label %continue528

continue528:                                      ; preds = %else527, %then526
  %177 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 77 to %Result*))
  br i1 %177, label %then529, label %else530

then529:                                          ; preds = %continue528
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  br label %continue531

else530:                                          ; preds = %continue528
  br label %continue531

continue531:                                      ; preds = %else530, %then529
  %178 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 79 to %Result*))
  br i1 %178, label %then532, label %else533

then532:                                          ; preds = %continue531
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  br label %continue534

else533:                                          ; preds = %continue531
  br label %continue534

continue534:                                      ; preds = %else533, %then532
  %179 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 71 to %Result*))
  br i1 %179, label %then535, label %else536

then535:                                          ; preds = %continue534
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  br label %continue537

else536:                                          ; preds = %continue534
  br label %continue537

continue537:                                      ; preds = %else536, %then535
  %180 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 53 to %Result*))
  br i1 %180, label %then538, label %else539

then538:                                          ; preds = %continue537
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  br label %continue540

else539:                                          ; preds = %continue537
  br label %continue540

continue540:                                      ; preds = %else539, %then538
  %181 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 76 to %Result*))
  br i1 %181, label %then541, label %else542

then541:                                          ; preds = %continue540
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  br label %continue543

else542:                                          ; preds = %continue540
  br label %continue543

continue543:                                      ; preds = %else542, %then541
  %182 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 78 to %Result*))
  br i1 %182, label %then544, label %else545

then544:                                          ; preds = %continue543
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  br label %continue546

else545:                                          ; preds = %continue543
  br label %continue546

continue546:                                      ; preds = %else545, %then544
  %183 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 80 to %Result*))
  br i1 %183, label %then547, label %else548

then547:                                          ; preds = %continue546
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  br label %continue549

else548:                                          ; preds = %continue546
  br label %continue549

continue549:                                      ; preds = %else548, %then547
  %184 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 62 to %Result*))
  br i1 %184, label %then550, label %else551

then550:                                          ; preds = %continue549
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  br label %continue552

else551:                                          ; preds = %continue549
  br label %continue552

continue552:                                      ; preds = %else551, %then550
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 66 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 75 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 35 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 34 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 35 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 34 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 75 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 75 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 35 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %185 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %185, label %then553, label %else554

then553:                                          ; preds = %continue552
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 66 to %Qubit*))
  br label %continue555

else554:                                          ; preds = %continue552
  br label %continue555

continue555:                                      ; preds = %else554, %then553
  %186 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %186, label %then556, label %else557

then556:                                          ; preds = %continue555
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 66 to %Qubit*))
  br label %continue558

else557:                                          ; preds = %continue555
  br label %continue558

continue558:                                      ; preds = %else557, %then556
  %187 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %187, label %then559, label %else560

then559:                                          ; preds = %continue558
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 34 to %Qubit*))
  br label %continue561

else560:                                          ; preds = %continue558
  br label %continue561

continue561:                                      ; preds = %else560, %then559
  %188 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %188, label %then562, label %else563

then562:                                          ; preds = %continue561
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 34 to %Qubit*))
  br label %continue564

else563:                                          ; preds = %continue561
  br label %continue564

continue564:                                      ; preds = %else563, %then562
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 21 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 21 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 20 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 21 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  %189 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %189, label %then565, label %else566

then565:                                          ; preds = %continue564
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  br label %continue567

else566:                                          ; preds = %continue564
  br label %continue567

continue567:                                      ; preds = %else566, %then565
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 47 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 47 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 56 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 56 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 47 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 56 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %190 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %190, label %then568, label %else569

then568:                                          ; preds = %continue567
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 56 to %Qubit*))
  br label %continue570

else569:                                          ; preds = %continue567
  br label %continue570

continue570:                                      ; preds = %else569, %then568
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 29 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 29 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 38 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 38 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 29 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 38 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %191 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %191, label %then571, label %else572

then571:                                          ; preds = %continue570
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 38 to %Qubit*))
  br label %continue573

else572:                                          ; preds = %continue570
  br label %continue573

continue573:                                      ; preds = %else572, %then571
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 20 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 29 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 20 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 20 to %Qubit*), %Result* inttoptr (i64 20 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 29 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 29 to %Qubit*), %Result* inttoptr (i64 29 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 38 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 47 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 38 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 38 to %Qubit*), %Result* inttoptr (i64 38 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 47 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 47 to %Qubit*), %Result* inttoptr (i64 47 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 56 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 65 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 56 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 56 to %Qubit*), %Result* inttoptr (i64 56 to %Result*))
  %192 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %192, label %then574, label %else575

then574:                                          ; preds = %continue573
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  br label %continue576

else575:                                          ; preds = %continue573
  br label %continue576

continue576:                                      ; preds = %else575, %then574
  %193 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 56 to %Result*))
  br i1 %193, label %then577, label %else578

then577:                                          ; preds = %continue576
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  br label %continue579

else578:                                          ; preds = %continue576
  br label %continue579

continue579:                                      ; preds = %else578, %then577
  %194 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 29 to %Result*))
  br i1 %194, label %then580, label %else581

then580:                                          ; preds = %continue579
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  br label %continue582

else581:                                          ; preds = %continue579
  br label %continue582

continue582:                                      ; preds = %else581, %then580
  %195 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 47 to %Result*))
  br i1 %195, label %then583, label %else584

then583:                                          ; preds = %continue582
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  br label %continue585

else584:                                          ; preds = %continue582
  br label %continue585

continue585:                                      ; preds = %else584, %then583
  %196 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 20 to %Result*))
  br i1 %196, label %then586, label %else587

then586:                                          ; preds = %continue585
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  br label %continue588

else587:                                          ; preds = %continue585
  br label %continue588

continue588:                                      ; preds = %else587, %then586
  %197 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 38 to %Result*))
  br i1 %197, label %then589, label %else590

then589:                                          ; preds = %continue588
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  br label %continue591

else590:                                          ; preds = %continue588
  br label %continue591

continue591:                                      ; preds = %else590, %then589
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 12 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 21 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 65 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 66 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 65 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 66 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 21 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 21 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 65 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %198 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %198, label %then592, label %else593

then592:                                          ; preds = %continue591
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  br label %continue594

else593:                                          ; preds = %continue591
  br label %continue594

continue594:                                      ; preds = %else593, %then592
  %199 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %199, label %then595, label %else596

then595:                                          ; preds = %continue594
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 12 to %Qubit*))
  br label %continue597

else596:                                          ; preds = %continue594
  br label %continue597

continue597:                                      ; preds = %else596, %then595
  %200 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %200, label %then598, label %else599

then598:                                          ; preds = %continue597
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 66 to %Qubit*))
  br label %continue600

else599:                                          ; preds = %continue597
  br label %continue600

continue600:                                      ; preds = %else599, %then598
  %201 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %201, label %then601, label %else602

then601:                                          ; preds = %continue600
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 66 to %Qubit*))
  br label %continue603

else602:                                          ; preds = %continue600
  br label %continue603

continue603:                                      ; preds = %else602, %then601
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 19 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 18 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 19 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 18 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 19 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 18 to %Qubit*))
  %202 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %202, label %then604, label %else605

then604:                                          ; preds = %continue603
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 18 to %Qubit*))
  br label %continue606

else605:                                          ; preds = %continue603
  br label %continue606

continue606:                                      ; preds = %else605, %then604
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 15 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 15 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 24 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 24 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 15 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 24 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %203 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %203, label %then607, label %else608

then607:                                          ; preds = %continue606
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 24 to %Qubit*))
  br label %continue609

else608:                                          ; preds = %continue606
  br label %continue609

continue609:                                      ; preds = %else608, %then607
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 9 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 9 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* null)
  call void @__quantum__qis__h__body(%Qubit* null)
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 9 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* null, %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  %204 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %204, label %then610, label %else611

then610:                                          ; preds = %continue609
  call void @__quantum__qis__x__body(%Qubit* null)
  br label %continue612

else611:                                          ; preds = %continue609
  br label %continue612

continue612:                                      ; preds = %else611, %then610
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 1 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 1 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 2 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 1 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  %205 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %205, label %then613, label %else614

then613:                                          ; preds = %continue612
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  br label %continue615

else614:                                          ; preds = %continue612
  br label %continue615

continue615:                                      ; preds = %else614, %then613
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 3 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 4 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 3 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 4 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 3 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 4 to %Qubit*))
  %206 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %206, label %then616, label %else617

then616:                                          ; preds = %continue615
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 4 to %Qubit*))
  br label %continue618

else617:                                          ; preds = %continue615
  br label %continue618

continue618:                                      ; preds = %else617, %then616
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 5 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 6 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 5 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 6 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 5 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 6 to %Qubit*))
  %207 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %207, label %then619, label %else620

then619:                                          ; preds = %continue618
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 6 to %Qubit*))
  br label %continue621

else620:                                          ; preds = %continue618
  br label %continue621

continue621:                                      ; preds = %else620, %then619
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 18 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 9 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 18 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 18 to %Qubit*), %Result* inttoptr (i64 18 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 9 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 9 to %Qubit*), %Result* inttoptr (i64 9 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* null, %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 1 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* null)
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 1 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* null, %Result* null)
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 1 to %Qubit*), %Result* inttoptr (i64 1 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 2 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 3 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 2 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 3 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 2 to %Qubit*), %Result* inttoptr (i64 2 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 3 to %Qubit*), %Result* inttoptr (i64 3 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 4 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 5 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 4 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 5 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 4 to %Qubit*), %Result* inttoptr (i64 4 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 5 to %Qubit*), %Result* inttoptr (i64 5 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 6 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 15 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 6 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 6 to %Qubit*), %Result* inttoptr (i64 6 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 15 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 15 to %Qubit*), %Result* inttoptr (i64 15 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 24 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 33 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 81 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 24 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 24 to %Qubit*), %Result* inttoptr (i64 24 to %Result*))
  %208 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 81 to %Result*))
  br i1 %208, label %then622, label %else623

then622:                                          ; preds = %continue621
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue624

else623:                                          ; preds = %continue621
  br label %continue624

continue624:                                      ; preds = %else623, %then622
  %209 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 24 to %Result*))
  br i1 %209, label %then625, label %else626

then625:                                          ; preds = %continue624
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue627

else626:                                          ; preds = %continue624
  br label %continue627

continue627:                                      ; preds = %else626, %then625
  %210 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 9 to %Result*))
  br i1 %210, label %then628, label %else629

then628:                                          ; preds = %continue627
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue630

else629:                                          ; preds = %continue627
  br label %continue630

continue630:                                      ; preds = %else629, %then628
  %211 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 1 to %Result*))
  br i1 %211, label %then631, label %else632

then631:                                          ; preds = %continue630
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue633

else632:                                          ; preds = %continue630
  br label %continue633

continue633:                                      ; preds = %else632, %then631
  %212 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 3 to %Result*))
  br i1 %212, label %then634, label %else635

then634:                                          ; preds = %continue633
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue636

else635:                                          ; preds = %continue633
  br label %continue636

continue636:                                      ; preds = %else635, %then634
  %213 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 5 to %Result*))
  br i1 %213, label %then637, label %else638

then637:                                          ; preds = %continue636
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue639

else638:                                          ; preds = %continue636
  br label %continue639

continue639:                                      ; preds = %else638, %then637
  %214 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 15 to %Result*))
  br i1 %214, label %then640, label %else641

then640:                                          ; preds = %continue639
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue642

else641:                                          ; preds = %continue639
  br label %continue642

continue642:                                      ; preds = %else641, %then640
  %215 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 18 to %Result*))
  br i1 %215, label %then643, label %else644

then643:                                          ; preds = %continue642
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue645

else644:                                          ; preds = %continue642
  br label %continue645

continue645:                                      ; preds = %else644, %then643
  %216 = call i1 @__quantum__qis__read_result__body(%Result* null)
  br i1 %216, label %then646, label %else647

then646:                                          ; preds = %continue645
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue648

else647:                                          ; preds = %continue645
  br label %continue648

continue648:                                      ; preds = %else647, %then646
  %217 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 2 to %Result*))
  br i1 %217, label %then649, label %else650

then649:                                          ; preds = %continue648
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue651

else650:                                          ; preds = %continue648
  br label %continue651

continue651:                                      ; preds = %else650, %then649
  %218 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 4 to %Result*))
  br i1 %218, label %then652, label %else653

then652:                                          ; preds = %continue651
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue654

else653:                                          ; preds = %continue651
  br label %continue654

continue654:                                      ; preds = %else653, %then652
  %219 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 6 to %Result*))
  br i1 %219, label %then655, label %else656

then655:                                          ; preds = %continue654
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  br label %continue657

else656:                                          ; preds = %continue654
  br label %continue657

continue657:                                      ; preds = %else656, %then655
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 28 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 19 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 82 to %Result*))
  call void @__quantum__qis__reset__body(%Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 33 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__cnot__body(%Qubit* inttoptr (i64 34 to %Qubit*), %Qubit* inttoptr (i64 81 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 81 to %Qubit*), %Result* inttoptr (i64 83 to %Result*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 33 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 34 to %Qubit*))
  call void @__quantum__qis__h__body(%Qubit* inttoptr (i64 19 to %Qubit*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 19 to %Qubit*), %Result* inttoptr (i64 84 to %Result*))
  call void @__quantum__qis__mz__body(%Qubit* inttoptr (i64 33 to %Qubit*), %Result* inttoptr (i64 85 to %Result*))
  %220 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 83 to %Result*))
  br i1 %220, label %then658, label %else659

then658:                                          ; preds = %continue657
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 28 to %Qubit*))
  br label %continue660

else659:                                          ; preds = %continue657
  br label %continue660

continue660:                                      ; preds = %else659, %then658
  %221 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 84 to %Result*))
  br i1 %221, label %then661, label %else662

then661:                                          ; preds = %continue660
  call void @__quantum__qis__z__body(%Qubit* inttoptr (i64 28 to %Qubit*))
  br label %continue663

else662:                                          ; preds = %continue660
  br label %continue663

continue663:                                      ; preds = %else662, %then661
  %222 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 82 to %Result*))
  br i1 %222, label %then664, label %else665

then664:                                          ; preds = %continue663
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 34 to %Qubit*))
  br label %continue666

else665:                                          ; preds = %continue663
  br label %continue666

continue666:                                      ; preds = %else665, %then664
  %223 = call i1 @__quantum__qis__read_result__body(%Result* inttoptr (i64 85 to %Result*))
  br i1 %223, label %then667, label %else668

then667:                                          ; preds = %continue666
  call void @__quantum__qis__x__body(%Qubit* inttoptr (i64 34 to %Qubit*))
  br label %continue669

else668:                                          ; preds = %continue666
  br label %continue669

continue669:                                      ; preds = %else668, %then667
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
