% Question
p :- q, not r.
p :- q, not s, not t.
s :- not p.
r :- not p.
v :- not u.
% Compute the dual rules for p, s and r.
%------------------------------------------------

%% Answer

% Dual for p
p :- (q, not r) ; (q, not s, not t).
% negating p using Demorgan's law
not_p :- (not q ; r), (not q ; s ; t).
% Splitting into multiple rules

not_p :- not q. % rule 1
not_p :- not q, s. % rule 1 makes this rule redundant. Keeping here for completeness.
not_p :- not q, t. % rule 1 makes this rule redundant. Keeping  here for completeness.
not_p :- r, not q.
not_p :- r, s.
not_p :- r, t.


% Dual for s
not_s :- p.

% Dual for r
not_r :- p.
