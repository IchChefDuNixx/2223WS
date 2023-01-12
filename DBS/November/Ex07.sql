/*
#7.1a)
AB -> CDE
D -> F
transitive, not in 3NF

b)
AB is superkey
D is not superkey, F is not prime, D > F violates 3NF

R1 = D+ = DF
R2 = (R - S1) u D = ABCE u D = R-F

AB -> CDE still contained
D -> F still contained
dependency preserving and lossless
left side superkey of S1,S2 respectively
is in BCNF

c)
R1 = ABCDE
S2 = DF

AB -> CDE still contained
D -> F still contained
dep. preserving and lossless
left side superkey of S1,S2 respectively
is in BCNF

d)
Y -> Z is not a superkey
not in BCNF

e)
S = VWXYZ
V > WZ
WZ > VXY
Y > Z # non-trivial FD that violates BCNF (Y is not a superkey)

S1 = Y+ = YZ
S2 = (S - S1) union Y = VWX u Y

set = (set - S) union S1,S2 = {} union (YZ, VWXY)
set = S1, S2
S1 = Y > Z
S2 = V > WZ, WZ > VXY

dependency preserving yes
lossless yes
useful maybe not

f)
S1 = V > WZ # superkey
S2 = WZ > VXY # superkey
S3 = Y > Z

dependency preserving yes
lossless yes

#7.2a)
R = ABCDEF
A > BC
D > EF

bad time complexity arises in the checking for (super?)keys. eg creating R3

b)
R = ABCDEF
A > BC
D > EF
ABCDEF > G

cover:
A > B
A > C
D > E
D > F
ABCDEF > G

R1 = ABC
R2 = DEF
R3 = ABCDEFG

#cleanup
R = ABCDEFG with FD ABCDEF > G

no need to search for a key, is faster

c)
synthesis:
-canonical cover as is
R1 = ABC
R2 = DEF
!none of the generated relations is a superkey of R
R3 = AD


#7.3a
Z = S1,S2
S1 = APHRODITE, with
R > OD
O > APHR
keys(ITER, ITEO)

S2 = APHRODITE, with
R > O
O > APHRD
keys(ITER, ITEO)

decomposition 1
R > OD # violates BCNF, R is no superkey
S11 = R+ = RODAHP
S12 = (S1 - S11) u R = ITER

S11 = R > APHOD
S12 = ITE > R
Z = S11,S12,S2

decomposition 2
R > O # violates BCNF, R is no superkey
S21 = R+ = ROAPHD
S22 = (S2 - S21) u R = ITER

S21 = R > APHOD
S22 = ITE > R
Z = S11,S12,S21,S22

since the decomposition yields the same results, Z = S11,S12 = S21,S22
is in BCNF

b)
S10 = APHRODITE > G
S11 = R > ODAPH
S12 = O > APHRD
# cleanup: is S12 contained in S11 and should it be removed?

S20 = APHRODITE > G
S21 = R > OAPHD
S22 = O > APHRD
# cleanup: is S22 contained in S21 and should it be removed?

Z = S10,S11,S12 = S20,S21,S22

c)
S11 = R > ODAPH
S12 = O > AHPRD
# neither is a superkey
S13 = ITE > R

S21 = R > OAPHD
S22 = O > APHRD
# neiter is a superkey
S23 = ITE > R

again, decomposition yields the same results for S1 and S2
Z = S11,S12,S13 = S21,S22,S23

d)
in this case, decomposition is better, in general it's likely simplified synthesis
*/