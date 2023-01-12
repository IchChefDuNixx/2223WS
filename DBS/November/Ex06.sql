/*
# 1
Cover(R):
(i) splitting
AB -> C
AB -> D
AB -> E
D -> F
ABC -> D
ABC -> E
# remove trivials
# compress again

(ii) shorten left sides
A+ ?= CDE
no
B+ ?= CDE
no
D -> is elementary
A+ ?= DE
no
B+ ?= DE
no
C+ ?= DE
no
AB+ ?= DE
yes
AB -> DE

(iii) remove unnecessary FDs
AB+\AB->CDE ?= CDE
no
D+\D->F ?= F
no
AB+\AB->DE ?= DE
yes

result = {AB -> CDE, D -> F}

Cover(S):
(i) splitting
V -> W
V -> X
V -> Y
V -> Z
WZ -> V
WZ -> X
WZ -> Y
Y -> Z
# remove trivials
# compress again

(ii) shorten left sides
V -> WXYZ is elementary
W+ ?= VXY
no
Z+ ?= WXY
no
Y -> Z is elementary

(iii) remove unnecessary FDs
V+\V->WXYZ ?= WXYZ
no
WZ+\WZ->VXY ?= VXY
no
Y+\Y->Z ?= Z
no

no change by cover algorithm

# 2
key(R) = AB

key(S) = ?
# heuristic
1. splitting, removing trivials
2. all attributes appear in some FD
3. all attributes appear on the right side
4. # algorithm breaks, using closure of ALL possible attribute combinations
# member test
V+ = VWXYZ = S
W+ = W
X+ = X
Y+ = YZ
Z+ = Z

VW+
VX+
VY+
...
# all sets containing V are super keys

WX+ = WX
WY+ = WYZVX = S
WZ+ = WZVXY = S
XY+ = XYZ
XZ+ = XZ
YZ+ = YZ

WXY+ = WXYZV = S
WXZ+ = WXZVY = S
WYZ+ = WYZVX = S
XYZ+ = XYZ

WXYZ = WXYZV = S

minimal set of super keys = {V, WY, WZ}

# 3 (R and S already in 1NF)
# check whether no attribute depends on just a key subset

key(R) = AB
A+ ?= C
no
A+ ?= D
no
A+ ?= E
no
B+ ?= C
no
B+ ?= D
no
B+ ?= E
no
D -> F is elementary

R is in 2NF

key(S) = {V, WY, WZ}
W+ ?= V
no
W+ ?= X
no
W+ ?= Y
no
W+ ?= Z
no
Y+ ?= V
no
Y+ ?= W
no
Y+ ?= X
no
Y+ ?= Z
yes

violates 2NF constraint
S is not in 2NF (if WY is actually in the set of keys, else it is)

# 4 
# 3NF = 2NF + (no transitives) OR (left side key or right side prime)
AB -> CDE
left side key
D -> F
left side key (of relation R2: D -> F)
R is in 3NF

S is definitely not in 3NF. it violates the transitivity constraint

# 5 (3NF + left side superkey)
AB+ = ABCDEF = R
D+ = DF != R

R is not in BCNF

S is not in BCNF because it's not in 3NF (and maybe not in 2NF)

*/