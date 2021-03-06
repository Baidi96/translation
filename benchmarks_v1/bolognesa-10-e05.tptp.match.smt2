(declare-sort Sll_t)
(declare-sort Subrecord)
(declare-sort Record)
(declare-sort Map)
(declare-fun x0 () Sll_t)
(declare-fun x1 () Sll_t)
(declare-fun x2 () Sll_t)
(declare-fun x3 () Sll_t)
(declare-fun x4 () Sll_t)
(declare-fun x5 () Sll_t)
(declare-fun x6 () Sll_t)
(declare-fun x7 () Sll_t)
(declare-fun x8 () Sll_t)
(declare-fun x9 () Sll_t)
(declare-fun x10 () Sll_t)
(declare-fun x11 () Sll_t)
(declare-fun x12 () Sll_t)
(declare-fun x13 () Sll_t)
(declare-fun x14 () Sll_t)
(declare-fun nil () Sll_t)
(declare-fun next (Sll_t) Subrecord)
(declare-fun ref (Subrecord) Record)
(declare-fun emp () Map)
(declare-fun total_pto (Sll_t Record) Map)
(declare-fun total_ssep (Map Map) Map)
(declare-fun ls (Sll_t Sll_t) Map)
(declare-fun delta_pto (Sll_t Record) Bool)
(declare-fun delta_ssep (Map Map) Bool)
(assert (forall ((y Record)) (not (delta_pto nil y))))
(assert (forall ((h1 Map) (h2 Map)) (= (delta_ssep h1 h2) (delta_ssep h2 h1))))
(assert (forall ((h1 Map) (h2 Map)) (=> (or (delta_ssep h1 h2) (delta_ssep h2 h1)) (= (total_ssep h1 h2) (total_ssep h2 h1)))))
(assert (forall ((h1 Map) (h2 Map) (h3 Map)) (= (and (delta_ssep (total_ssep h1 h2) h3) (delta_ssep h1 h2)) (and (delta_ssep h1 (total_ssep h2 h3)) (delta_ssep h2 h3)))))
(assert (forall ((h1 Map) (h2 Map) (h3 Map)) (=> (or (and (delta_ssep (total_ssep h1 h2) h3) (delta_ssep h1 h2)) (and (delta_ssep h1 (total_ssep h2 h3)) (delta_ssep h2 h3))) (= (total_ssep (total_ssep h1 h2) h3) (total_ssep h1 (total_ssep h2 h3))))))
(assert (forall ((h Map)) (delta_ssep h emp)))
(assert (forall ((h Map)) (= h (total_ssep h emp))))
(assert (forall ((x Sll_t) (y Record) (z Record)) (not (and (delta_ssep (total_pto x y) (total_pto x z)) (delta_pto x y) (delta_pto x z)))))
(assert (forall ((in Sll_t) (out Sll_t) ($32 Map)) (= (= $32 (ls in out)) (or (= in out) (exists ((u Sll_t)) (and (not (= in out)) (delta_ssep (total_pto in (ref (next u))) (ls u out)) (= $32 (total_ssep (total_pto in (ref (next u))) (ls u out))) (delta_pto in (ref (next u)))))))))
(assert (not (forall (($47 Map)) (and (delta_ssep (ls x3 x6) (total_ssep (total_pto x9 (ref (next x1))) (total_ssep (total_pto x7 (ref (next x9))) (total_ssep (total_pto x6 (ref (next x7))) (total_ssep (ls x8 x9) (total_ssep (ls x1 x9) (total_ssep (total_pto x2 (ref (next x3))) (total_ssep (total_pto x5 (ref (next x1))) (total_ssep (total_pto x4 (ref (next x9))) (total_ssep (ls x10 x5) emp)))))))))) (= $47 (total_ssep (ls x3 x6) (total_ssep (total_pto x9 (ref (next x1))) (total_ssep (total_pto x7 (ref (next x9))) (total_ssep (total_pto x6 (ref (next x7))) (total_ssep (ls x8 x9) (total_ssep (ls x1 x9) (total_ssep (total_pto x2 (ref (next x3))) (total_ssep (total_pto x5 (ref (next x1))) (total_ssep (total_pto x4 (ref (next x9))) (total_ssep (ls x10 x5) emp))))))))))) (delta_ssep (total_pto x9 (ref (next x1))) (total_ssep (total_pto x7 (ref (next x9))) (total_ssep (total_pto x6 (ref (next x7))) (total_ssep (ls x8 x9) (total_ssep (ls x1 x9) (total_ssep (total_pto x2 (ref (next x3))) (total_ssep (total_pto x5 (ref (next x1))) (total_ssep (total_pto x4 (ref (next x9))) (total_ssep (ls x10 x5) emp))))))))) (delta_pto x9 (ref (next x1))) (delta_ssep (total_pto x7 (ref (next x9))) (total_ssep (total_pto x6 (ref (next x7))) (total_ssep (ls x8 x9) (total_ssep (ls x1 x9) (total_ssep (total_pto x2 (ref (next x3))) (total_ssep (total_pto x5 (ref (next x1))) (total_ssep (total_pto x4 (ref (next x9))) (total_ssep (ls x10 x5) emp)))))))) (delta_pto x7 (ref (next x9))) (delta_ssep (total_pto x6 (ref (next x7))) (total_ssep (ls x8 x9) (total_ssep (ls x1 x9) (total_ssep (total_pto x2 (ref (next x3))) (total_ssep (total_pto x5 (ref (next x1))) (total_ssep (total_pto x4 (ref (next x9))) (total_ssep (ls x10 x5) emp))))))) (delta_pto x6 (ref (next x7))) (delta_ssep (ls x8 x9) (total_ssep (ls x1 x9) (total_ssep (total_pto x2 (ref (next x3))) (total_ssep (total_pto x5 (ref (next x1))) (total_ssep (total_pto x4 (ref (next x9))) (total_ssep (ls x10 x5) emp)))))) (delta_ssep (ls x1 x9) (total_ssep (total_pto x2 (ref (next x3))) (total_ssep (total_pto x5 (ref (next x1))) (total_ssep (total_pto x4 (ref (next x9))) (total_ssep (ls x10 x5) emp))))) (delta_ssep (total_pto x2 (ref (next x3))) (total_ssep (total_pto x5 (ref (next x1))) (total_ssep (total_pto x4 (ref (next x9))) (total_ssep (ls x10 x5) emp)))) (delta_pto x2 (ref (next x3))) (delta_ssep (total_pto x5 (ref (next x1))) (total_ssep (total_pto x4 (ref (next x9))) (total_ssep (ls x10 x5) emp))) (delta_pto x5 (ref (next x1))) (delta_ssep (total_pto x4 (ref (next x9))) (total_ssep (ls x10 x5) emp)) (delta_pto x4 (ref (next x9))) (delta_ssep (ls x10 x5) emp)))))
(assert (forall (($101 Map)) (delta_ssep (ls x10 x5) (total_ssep (ls x5 x1) (total_ssep (ls x2 x9) (total_ssep (ls x4 x9) (total_ssep (ls x8 x1) (total_ssep (ls x1 x9) emp))))))))
(assert (forall (($101 Map)) (= $101 (total_ssep (ls x10 x5) (total_ssep (ls x5 x1) (total_ssep (ls x2 x9) (total_ssep (ls x4 x9) (total_ssep (ls x8 x1) (total_ssep (ls x1 x9) emp)))))))))
(assert (forall (($101 Map)) (delta_ssep (ls x5 x1) (total_ssep (ls x2 x9) (total_ssep (ls x4 x9) (total_ssep (ls x8 x1) (total_ssep (ls x1 x9) emp)))))))
(assert (forall (($101 Map)) (delta_ssep (ls x2 x9) (total_ssep (ls x4 x9) (total_ssep (ls x8 x1) (total_ssep (ls x1 x9) emp))))))
(assert (forall (($101 Map)) (delta_ssep (ls x4 x9) (total_ssep (ls x8 x1) (total_ssep (ls x1 x9) emp)))))
(assert (forall (($101 Map)) (delta_ssep (ls x8 x1) (total_ssep (ls x1 x9) emp))))
(assert (forall (($101 Map)) (delta_ssep (ls x1 x9) emp)))
(check-sat)

