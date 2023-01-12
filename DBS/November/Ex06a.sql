/* 6a.1
# 1
Y = (APHRODITE)

(i) splitting
R > O
O > A
O > H
O > P
OP > D
OP > R
HP > P
HPR > D

R > O
O > AHP
OP > DR
HPR > D

(ii) shorten left sides
R > O
O > AHP
O+ =? DR
O+ = OAHPDR 
P+ =? DR
P+ =? P
HP =? D
HP+ = HP
HR+ =? D
HR+ = HROAPD
PR+ =? D
PR+ = PROAHD
R+ = ROAHPD

R > APHOD
O > APHRD

(iii)
-

# 2
potential keys:
RITE, OITE

# 3
ITE is not in any FD, also O is dependent on a real subset of RITE (R)
not 2NF

# 4
not 3NF because not 2NF

# 5 
not BCNF because not 3NF

/2
# 1
W = (ABCD)
AB > C
B > D

AB is key,
D depends on a real subset of AB (namely B),
not in 2NF

# 2
X = (ABCD)
ABC > D
BC > A

(i) already split
(ii) shorten
ABC\A: BC > D
BC > A
(iii)
-

BC+ = ABCD
BC is key
atomic > 1NF
all of X is included in at least (exactly) 1 FD (BC > ABCD)
no untrivial attribute depends on a real subset > 2NF
only one FD > no transitives
left side is key > 3NF
left side is superkey > BCNF

#3
V = (ABCDE)
CDE > AC
AE > BD
CD > E

(i) splitting
CDE > A
AE > BD
CD > E

(ii) shorten left sides
CDE > A
AE > BD
CD > E

(iii) remove unnecessary FDs
CDE > A
AE > BD

keys:
CDE+ = CDEAB
only key

2NF:
nothing depends on a real key subset
yes

3NF:
transitive: CDE > A, CDEA > B
not 3NF

#4
Y = (ABCDEF)
A > BC
C > D
E > F

transitive: A > BC, ABC > D
not 3NF

#5
Z = (ABCD)
ABC > D
AB > CD
C > A

AB > CD
C > A

only key = AB

1NF atomic yes
2NF nothing depends on a real key subset, yes
3NF left side key or right side prime, yes
BCNF left side superkey, no (C+ = CA != ABCD)
3NF but not BCNF

*/