Require Import Naturelle.
Section Session1_2018_Logique_Exercice_2.

Variable A B : Prop.

Theorem Exercice_2_Naturelle : ~(A /\ B) -> (~A \/ ~B).
Proof.



Theorem Exercice_2_Coq : ~(A /\ B) -> (~A \/ ~B).
Proof.
intro H.
left.

unfold not.
intro H1.
absurd (A/\B).

exact H.
split.
exact H1.
cut (B\/ ~B).
intro H2.
elim H2.
intro H3.
exact H3.
intro H4.

elim H2.
absurd A.
elim H.

Qed.

End Session1_2018_Logique_Exercice_2.

