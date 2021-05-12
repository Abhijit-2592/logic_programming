p :- q, not r.
p :- q, not s, not t.
s :- not p.
r :- not p.
v :- not u.

% adding even loops
% even loop for q
q :- not not_q.
not_q :- not q.
% even loop for t
t :- not not_t.
not_t :- not t.
% even loop for u
u :- not not_u.
not_u :- not u.
% even loop for v
v :- not not_v.
not_v :- not v.
