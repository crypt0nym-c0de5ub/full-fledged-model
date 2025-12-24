
include "table.mzn";
% =========== Model for SKINNY ==========

array[0..15] of int: SRp = array1d(0..15,[0,1,2,3, 7,4,5,6, 10,11,8,9, 13,14,15,12]);
array[0..15] of int: SRpv = array1d(0..15,[0,1,2,3, 5,6,7,4, 10,11,8,9, 15,12,13,14]);
array[0..15, 0..34] of int: posTable = array2d(0..15, 0..34, [  
 0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1,
 1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7,
 2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,
 3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5,
 4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,
 5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6,
 6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4,
 7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3,
 8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,
 9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,
10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,
11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,
12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,
13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,
14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,
15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11,  3, 13,  5, 14,  6, 12,  4, 10,  2,  8,  0,  9,  1, 15,  7, 11
]);


int: rEb = 4;
int: rEu = 10;
int: rEm = 6;
int: rEl = 6;
int: rEf = 7;

int: Step = 5;

% ========================================================= Upper (Begin) ======================================================
% ----- [Upper] Differential (Begin) -----
array[0..rEb, 0..15] of var 0..2: bX;  % X is extended from the distinguisher
array[0..rEb, 0..15] of var 0..2: bY;  % Y is extended from the distinguisher
array[0..rEb-1, 0..15] of var 0..1: bSTK;
array[0..rEb-1, 0..15] of var 0..2: bZ;
array[0..rEb-1, 0..15] of var 0..2: bW;
array[0..rEb-1, 0..15] of var 0..1: bTag;
var int: PrEb;

% *** SubCell ***
constraint forall(r in 0..rEb, c in 0..15)(
  SubCell(bY[r,c], bX[r,c])
);

% *** AddRoundTK ***
constraint forall(r in 0..rEb-1)(
  forall(c in 0.. 7)(XOR12(bZ[r,c], bSTK[r,c], bY[r,c])) /\
  forall(c in 8..15)(bY[r,c] = bZ[r,c])
);

% *** ShiftRow ***
constraint forall(r in 0..rEb-1, c in 0..15)(
  bZ[r,SRp[c]] = bW[r,c]
);

% *** MixColumn inv ***
constraint forall(r in 0..rEb-1, c in 0..3)(bTag[r,c] = 0);
constraint forall(r in 0..rEb-1, c in 0..3)(
  bW[r,c] = bX[r+1,c+ 4] /\
  XOR22(bW[r  ,c+ 8], bX[r+1,c+ 8], bW[r,c+ 4], bTag[r,c+ 4]) /\
  XOR22(bX[r+1,c+ 4], bX[r+1,c+12], bW[r,c+ 8], bTag[r,c+ 8]) /\
  XOR22(bX[r+1,c   ], bX[r+1,c+12], bW[r,c+12], bTag[r,c+12])
);

% *** Probability ***
constraint PrEb = 8*sum(r in 0..rEb, c in 0..15)(bX[r,c] = 1) + 8*sum(r in 0..rEb-1, c in 0..15)(bTag[r,c] = 1);
% ----- [Upper] Differential (End) -----
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ----- [Upper] Involved Collection (Begin) -----
array[0..rEb,   0..15] of var 0..1: bvX;    % X is extended from the distinguisher
array[0..rEb,   0..15] of var 0..1: bvY;    % Y is extended from the distinguisher
array[0..rEb-1, 0..15] of var 0..1: bvSTK;  % classical involved subkey 
array[0..rEb-1, 0..15] of var 0..1: bvZ;
array[0..rEb-1, 0..15] of var 0..1: bvW;

% *** Initial in each round (boundary) ***
constraint forall(c in 0..15)(bvY[rEb,c] = bX[rEb,c] - bY[rEb,c]);
constraint forall(r in 0..rEb-1, c in 0..15)(
  if bY[r,c] = 2 then bvY[r,c] = 1 elseif bY[r,c] = 1 then bvY[r,c] = bX[r,c] - bY[r,c] else bvY[r,c] = bvZ[r,c]
  endif
);

% *** SubCell ***
constraint forall(r in 0..rEb, c in 0..15)(
  if bY[r,c] = 1 /\ bX[r,c] = 2 then bvX[r,c] = 1
                                else bvX[r,c] = bvY[r,c]
  endif
);

% *** ShiftRow ***
constraint forall(r in 0..rEb-1, c in 0..15)(
  bvZ[r,SRp[c]] = bvW[r,c]
);

% *** MixColumn inv ***
constraint forall(r in 0..rEb-1, c in 0..3)(
  bvW[r,c   ] = if bvX[r+1,c] = 1 \/ bvX[r+1,c+4] = 1 \/                     bvX[r+1,c+12] = 1 then 1 else 0 endif /\
  bvW[r,c+ 4] = if                                       bvX[r+1,c+8] = 1                      then 1 else 0 endif /\
  bvW[r,c+ 8] = if bvX[r+1,c] = 1 \/                     bvX[r+1,c+8] = 1 \/ bvX[r+1,c+12] = 1 then 1 else 0 endif /\
  bvW[r,c+12] = if bvX[r+1,c] = 1                                                              then 1 else 0 endif
);

% *** AddClKey ***
constraint forall(r in 0..rEb-1)(
  forall(c in 0..7)(bvSTK[r,posTable[c,r]] = bvZ[r,c]) /\ forall(c in 8..15)(bvSTK[r,posTable[c,r]] = 0)
);

% ----- [Upper] Involved Collection (End) -----
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ----- [Upper] Apply State Test -----
array[0..rEb,   0..15] of var 0..2: bflagST;  % 0:close, 1:pre-guess, 2:epsilon
array[0..rEb,   0..15] of var 0..Step: btSC;  % bflagST = 0 --> btSC = 0; bflagST = 1 --> btSC <= 1; bflagST = 2 --> btSC <= Step
constraint forall(r in 0..rEb, c in 0..15)(
  if bflagST[r,c] = 0 then btSC[r,c] = 0 elseif bflagST[r,c] = 1 then btSC[r,c] <= 1 else btSC[r,c] <= Step endif
);
array[0..rEb-1, 0..15] of var 0..Step: beSTK;
array[0..rEb,   0..15] of var 0..Step: beX;
array[0..rEb-1, 0..15] of var 0..Step: beZ;
array[0..rEb-1, 0..15] of var 0..Step: beW;

% *** Initial ***
constraint forall(r in 1..rEb, c in 0..15)(
  if (bX[r,c] <= 1 \/ bY[r,c] <= 1) /\ bvX[r,c] = 1 then btSC[r,c] >= 0 else btSC[r,c] = 0 endif
);
constraint forall(c in 0..15)(beX[rEb,c] = btSC[rEb,c]);

% *** SubCell ***
constraint forall(r in 1..rEb-1, c in 0..15)(
  if btSC[r,c] >= 1 then beX[r,c] = btSC[r,c]
  elseif beZ[r,c] >= 1 then beX[r,c] = beZ[r,c]
  else beX[r,c] = 0
  endif
);

% *** ShiftRow ***
constraint forall(r in 1..rEb-1, c in 0..15)(
  beZ[r,SRp[c]] = beW[r,c]
);

% constraint beSTK[0,7] = beX[1,12] /\ beSTK[0,4] = beX[1,13] /\ beSTK[0,5] = beX[1,14] /\ beSTK[0,6] = beX[1,15];
constraint forall(r in 0..rEb-1, c in 0..7)(
  beSTK[r,posTable[c,r]] = if bZ[r,c] = 0 then beZ[r,c] else 0 endif
);

% *** MixColumn ***
constraint forall(r in 1..rEb, c in 0..3)(
  if beX[r,c   ] >= 1 then 
    beW[r-1,c   ] = if bW[r-1,c   ] <= 1 /\ bvX[r,c+ 4] = 0 /\ bvX[r,c+12] = 0 then beX[r,c   ] else 0 endif /\
    beW[r-1,c+ 8] = if bW[r-1,c+ 8] <= 1 /\ bvX[r,c+ 8] = 0 /\ bvX[r,c+12] = 0 then beX[r,c   ] else 0 endif /\
    beW[r-1,c+12] = if bW[r-1,c+12] <= 1                                       then beX[r,c   ] else 0 endif
  endif
  /\
  if beX[r,c+ 4] >= 1 then
    beW[r-1,c   ] = if bW[r-1,c   ] <= 1 /\ bvX[r,c   ] = 0 /\ bvX[r,c+12] = 0 then beX[r,c+ 4] else 0 endif
  endif
  /\
  if beX[r,c+ 8] >= 1 then 
    beW[r-1,c+ 4] = if bW[r-1,c+ 4] <= 1                                       then beX[r,c+ 8] else 0 endif /\
    beW[r-1,c+ 8] = if bW[r-1,c+ 8] <= 1 /\ bvX[r,c   ] = 0 /\ bvX[r,c+12] = 0 then beX[r,c+ 8] else 0 endif
  endif
  /\
  if beX[r,c+12] >= 1 then
    beW[r-1,c   ] = if bW[r-1,c   ] <= 1 /\ bvX[r,c   ] = 0 /\ bvX[r,c+ 4] = 0 then beX[r,c+12] else 0 endif /\
    beW[r-1,c+ 8] = if bW[r-1,c+ 8] <= 1 /\ bvX[r,c   ] = 0 /\ bvX[r,c+ 8] = 0 then beX[r,c+12] else 0 endif
  endif
);

constraint forall(r in 1..rEb, c in 0..3)(
  if (beX[r,c] = 0 /\ beX[r,c+4] = 0 /\ beX[r,c+12] = 0) then beW[r-1,c] = 0 endif /\
  if (beX[r,c+8] = 0) then beW[r-1,c+4] = 0 endif /\
  if (beX[r,c] = 0 /\ beX[r,c+8] = 0 /\ beX[r,c+12] = 0) then beW[r-1,c+8] = 0 endif /\
  if (beX[r,c] = 0) then beW[r-1,c+12] = 0 endif
);

% ----- [Upper] Apply State Test (End) -----
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ----- [Upper] Guess and Determine (Begin) -----
array[0..rEb,   0..15] of var 0..1: bdetX;      % X is extended from the distinguisher
array[0..rEb,   0..15] of var 0..1: bdetdiffX;  % value is determined after SC, without guessing subkey, the differential can be determined
array[0..rEb,   0..15] of var 0..1: bdetY;      % Y is extended from the distinguisher
array[0..rEb-1, 0..15] of var 0..1: bgSTK;
array[0..rEb-1, 0..15] of var 0..1: bdetZ;
array[0..rEb-1, 0..15] of var 0..1: bdetW;
array[0..rEb-1, 0..15] of var 0..1: bdetdiffW;
array[1..rEb, 0..15] of var 0..1: bfrSC;
array[2..rEb,   0..15] of var 0..1: bfrMC;

% *** Initialize Plaintext *** 
constraint forall(c in 0..15)(bdetY[0,c] = 1);

% *** AddRoundKey ***
constraint forall(r in 0..rEb-1, c in 0..15)(bvSTK[r,c] >= bgSTK[r,c]);
constraint forall(r in 0..rEb-1)(
  forall(c in 0.. 7)(if bgSTK[r,posTable[c,r]] = 1 then bdetZ[r,c] = bdetY[r,c] else bdetZ[r,c] = 0 endif) /\
  forall(c in 8..15)(bdetZ[r,c] = bdetY[r,c])
);

% *** SubCell ***
constraint forall(r in 1..rEb-1, c in 0..15)(
  bdetY[r,c] = (bdetX[r,c] = 1 \/ btSC[r,c] = 1)
);

% *** ShiftRow ***
constraint forall(r in 0..rEb-1, c in 0..15)(
  bdetZ[r,SRp[c]] = bdetW[r,c] /\ bdetdiffW[r,c] = bdetY[r,SRp[c]]
);

% *** MixColumn ***
constraint forall(r in 0..rEb-1, c in 0..3)(
  bdetX[r+1,c   ] = if bdetW[r,c] = 1 /\                     bdetW[r,c+8] = 1 /\ bdetW[r,c+12] = 1 then 1 else 0 endif /\
  bdetX[r+1,c+ 4] = if bdetW[r,c] = 1                                                              then 1 else 0 endif /\
  bdetX[r+1,c+ 8] = if                   bdetW[r,c+4] = 1 /\ bdetW[r,c+8] = 1                      then 1 else 0 endif /\
  bdetX[r+1,c+12] = if bdetW[r,c] = 1 /\                     bdetW[r,c+8] = 1                      then 1 else 0 endif /\
  
  bdetdiffX[r+1,c   ] = if bdetdiffW[r,c] = 1 /\                         bdetdiffW[r,c+8] = 1 /\ bdetdiffW[r,c+12] = 1 then 1 else 0 endif /\
  bdetdiffX[r+1,c+ 4] = if bdetdiffW[r,c] = 1                                                                          then 1 else 0 endif /\
  bdetdiffX[r+1,c+ 8] = if                       bdetdiffW[r,c+4] = 1 /\ bdetdiffW[r,c+8] = 1                          then 1 else 0 endif /\
  bdetdiffX[r+1,c+12] = if bdetdiffW[r,c] = 1 /\                         bdetdiffW[r,c+8] = 1                          then 1 else 0 endif
);

% *** Filter SC ***
constraint forall(r in 1..rEb, c in 0..15)(
  bfrSC[r,c] = if bdetY[r,c] = 1 /\ bY[r,c] = 1 then 1 else 0 endif
);

% *** Filter MC ***
constraint forall(r in 1..rEb-1, c in 0..3)(
  bfrMC[r+1,c   ] = if bdetdiffX[r+1,c   ] = 1 /\ bX[r+1,c   ] <= 1 /\ (bX[r+1,c+12] +                   bW[r,c+12]) >= 3 then 1 else 0 endif /\
  bfrMC[r+1,c+ 4] = 0 /\
  bfrMC[r+1,c+ 8] = if bdetdiffX[r+1,c+ 8] = 1 /\ bX[r+1,c+ 8] <= 1  /\ (          bW[r,c+4] + bW[r,c+ 8])            >= 3 then 1 else 0 endif /\
  bfrMC[r+1,c+12] = if bdetdiffX[r+1,c+12] = 1 /\ bX[r+1,c+12] <= 1  /\ (bW[r,c] +             bW[r,c+8 ])            >= 3 then 1 else 0 endif
);

constraint forall(c in 0..15)(bdetX[0,c] = 1);
% ----- [Upper] Guess and Determine (End) -----

% ----- [Upper] Epsilon (Begin) -----
% Here, we give the approach of guess-and-filter only, which allows the subkey deduction from known differentials
array[0..rEb,   0..15] of var -1..Step: bsaX;
array[0..rEb,   0..15] of var -1..Step: bsaY;
array[0..rEb-1, 0..15] of var -1..Step: bsaSTK;
array[0..rEb-1, 0..15] of var -1..Step: bsaZ;
array[0..rEb-1, 0..15] of var -1..Step: bsaW;

array[1..rEb,   0..15] of var -1..Step: bsadiffX;
array[1..rEb,   0..15] of var -1..Step: bsadiffY;
array[1..rEb,   0..15] of var -1..Step: bsadiffW;

% *** Initialition ***
constraint forall(r in 0..rEb, c in 0..15)(
  if bvX[r,c] = 0 then bsaX[r,c] = -1 elseif bdetX[r,c] = 1 then bsaX[r,c] = 0 else bsaX[r,c] >= 1 endif /\
  if bvY[r,c] = 0 then bsaY[r,c] = -1 elseif bdetY[r,c] = 1 then bsaY[r,c] = 0 else bsaY[r,c] >= 1 endif
);
constraint forall(r in 0..rEb-1, c in 0..15)(
  if bvZ[r,c] = 0 then bsaZ[r,c] = -1 elseif bdetZ[r,c] = 1 then bsaZ[r,c] = 0 else bsaZ[r,c] >= 1 endif /\
  if bvW[r,c] = 0 then bsaW[r,c] = -1 elseif bdetW[r,c] = 1 then bsaW[r,c] = 0 else bsaW[r,c] >= 1 endif /\
  if bvSTK[r,c] = 0 then bsaSTK[r,c] = -1 elseif bgSTK[r,c] = 1 then bsaSTK[r,c] = 0 else bsaSTK[r,c] >= 1 endif
);

% *** SubCell ***
constraint forall(r in 0..rEb, c in 0..15)(bsaY[r,c] = bsaX[r,c]);

% *** AddRoundKey ***
constraint forall(r in 0..rEb-1)(
  forall(c in 0..7)(if bvZ[r,c] = 1 then bsaSTK[r,posTable[c,r]] >= bsaY[r,c] /\ bsaSTK[r,posTable[c,r]] >= 0 else bsaSTK[r,posTable[c,r]] = -1 endif) /\
  forall(c in 0..7)(bsaZ[r,c] = bsaSTK[r,posTable[c,r]]) /\
  forall(c in 8..15)(if bvZ[r,c] = 1 then bsaZ[r,c] = bsaY[r,c] else bsaZ[r,c] = -1 endif)
);

% *** ShiftRow ***
constraint forall(r in 0..rEb-1, c in 0..15)(
  bsaZ[r,SRp[c]] = bsaW[r,c]
);

% *** MixColumn ***
constraint forall(r in 0..rEb-1, c in 0..3)(
  if bsaX[r+1,c   ] >= 1 then bsaX[r+1,c   ] = max(max(bsaW[r,c], bsaW[r,c+8]), bsaW[r,c+12]) endif /\
  if bsaX[r+1,c+ 4] >= 1 then bsaX[r+1,c+ 4] = bsaW[r,c] endif /\
  if bsaX[r+1,c+ 8] >= 1 then bsaX[r+1,c+ 8] = max(bsaW[r,c+4], bsaW[r,c+8]) endif /\
  if bsaX[r+1,c+12] >= 1 then bsaX[r+1,c+12] = max(bsaW[r,c], bsaW[r,c+8]) endif
);

% -- Differential step assignment --
% ** Initialization **
constraint forall(c in 0..15)(bsadiffX[1,c] = bsaX[1,c]);

% ** SubCell **
constraint forall(r in 1..rEb, c in 0..15)(bsadiffY[r,c] = bsaX[r,c]);

% ** ShiftRow **
constraint forall(r in 1..rEb, c in 0..15)(bsadiffW[r,c] = bsadiffY[r,SRp[c]]);

% ** MixColumn **
constraint forall(r in 1..rEb-1, c in 0..3)(
  bsadiffX[r+1,c   ] = max(max(bsadiffW[r,c], bsadiffW[r,c+8]), bsadiffW[r,c+12]) /\
  bsadiffX[r+1,c+ 4] = bsadiffW[r,c] /\
  bsadiffX[r+1,c+ 8] = max(bsadiffW[r,c+4], bsadiffW[r,c+8]) /\
  bsadiffX[r+1,c+12] = max(bsadiffW[r,c], bsadiffW[r,c+8])
);
% ----- [Upper] Epsilon (End) -----
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% % ========================================================= Upper (End) ======================================================



% % ======================================================= Lower (Begin) ======================================================
% % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% % ----- [Lower] Differential in Lower (Begin) -----
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..2: fX;  % X is extended to the distinguisher
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..2: fY;  % Y is extended to the distinguisher
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fSTK;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..2: fZ;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..2: fW;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf  , 0..15] of var 0..1: fTag;
var int: PrEf;

% *** SubCell ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  SubCell(fX[r,c], fY[r,c])
);

% *** AddRoundTK ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1)(
  forall(c in 0.. 7)(XOR12(fY[r,c], fSTK[r,c], fZ[r,c])) /\
  forall(c in 8..15)(fZ[r,c] = fY[r,c])
);

% *** ShiftRow ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  fZ[r,SRp[c]] = fW[r,c]
);

% *** MixColumn ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 4..7)(fTag[r,c] = 0);
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..3)(
  XOR22(fX[r+1,c+12], fW[r  ,c+12], fX[r+1,c   ], fTag[r  ,c   ]) /\
                                    fX[r+1,c+4] = fW[r,c]         /\
  XOR22(fW[r  ,c+ 4], fW[r  ,c+ 8], fX[r+1,c+ 8], fTag[r  ,c+ 8]) /\
  XOR22(fW[r  ,c   ], fW[r  ,c+ 8], fX[r+1,c+12], fTag[r  ,c+12])  
);

% *** Probability ***
constraint PrEf = 8*sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(fY[r,c] = 1) + 
                  8*sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(fTag[r,c] = 1);
% ----- [Lower] Differential in Upper (End) -----
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ----- [Lower] Involved Collection (Begin) -----
% the involved values
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fvX; 
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fvY;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fvSTK;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fvZ;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fvW;

% --- Boundary of between the Distinguisher and the extension ---
% *** Initial in each round ***
constraint forall(r = rEb+rEu+rEm+rEl, c in 0..15)(fvX[r,c] = if fY[r,c] >= 1 then 1 else 0 endif);
% *** SubCell ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  if fY[r,c] = 2 \/ (fY[r,c] = 1 /\ fX[r,c] = 2) then fvY[r,c] = 1
                                                 else fvY[r,c] = fvX[r,c]
  endif
);

% *** AddClKey ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1)(
  forall(c in 0..7)(fvSTK[r,posTable[c,r]] = fvY[r,c]) /\
  forall(c in 8..15)(fvSTK[r,posTable[c,r]] = 0) /\
  forall(c in 0..15)(fvZ[r,c] = fvY[r,c])
);

% *** ShiftRow ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  fvZ[r,SRp[c]] = fvW[r,c]
);

% *** MixColumn inv ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..3)(
    fvX[r+1,c   ] = if                                                     fvW[r,c+12] = 1 \/ fX[r+1,c   ] = 1 then 1 else 0 endif /\
    fvX[r+1,c+ 4] = if fvW[r,c] = 1 \/ fvW[r,c+4] = 1 \/ fvW[r,c+8] = 1                    \/ fX[r+1,c+ 4] = 1 then 1 else 0 endif /\
    fvX[r+1,c+ 8] = if                 fvW[r,c+4] = 1                                      \/ fX[r+1,c+ 8] = 1 then 1 else 0 endif /\
    fvX[r+1,c+12] = if                 fvW[r,c+4] = 1 \/ fvW[r,c+8] = 1 \/ fvW[r,c+12] = 1 \/ fX[r+1,c+12] = 1 then 1 else 0 endif
);

% ---------- the involved differentials ------------
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fdX; 
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fdW;

% ** initialization **
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  fdX[r,c] >= fvX[r,c] /\ fdW[r,c] >= fvW[r,c]
);
% ** SubCells **
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(fdX[r,c] = fvY[r,c]);

% ** MixColumn **
constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..3)(
  if fX[r,c+4] = 2 then fdW[r-1,c] = 1 else fdW[r-1,c] = 0 endif /\
  if fX[r,c+8] = 2 \/ fW[r-1,c+8] = 2 then fdW[r-1,c+4] = 1 endif /\
  if fX[r,c+4] = 2 \/ fX[r,c+12] = 2 then fdW[r-1,c+8] = 1 endif /\
  if fX[r,c] = 2 \/ fX[r,c+12] = 2 then fdW[r-1,c+12] = 1 endif
);
constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..3)(
  if fX[r,c+8] < 2 /\ fW[r-1,c+8] < 2 /\ fvW[r-1,c+4] = 0 then fdW[r-1,c+4] = 0 endif /\
  if fX[r,c+4] < 2 /\ fX[r,c+12] < 2 /\ fvW[r-1,c+8] = 0 then fdW[r-1,c+8] = 0 endif /\
  if fX[r,c] < 2 /\ fX[r,c+12] < 2 /\ fvW[r-1,c+12] = 0 then fdW[r-1,c+12] = 0 endif
);
% ----- [Lower] Involved Collection (End) -----
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ----- [Lower] Apply State Test -----
% before and after SBox (when PE is used, Y can be tested) [0:close, 1:pre-guess, 2:epsilon]
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..2: fflagST;  % 0:close, 1:pre-guess, 2:epsilon
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..Step: ftSC;  % bflagST = 0 --> btSC = 0; bflagST = 1 --> btSC <= 1; bflagST = 2 --> btSC <= Step
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  if fflagST[r,c] = 0 then ftSC[r,c] = 0 elseif fflagST[r,c] = 1 then ftSC[r,c] <= 1 else ftSC[r,c] <= Step endif
);
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..Step: feSTK;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..Step: feX;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..Step: feY;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..Step: feZ;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..Step: feW;

% *** Initial ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  if (fY[r,c] <= 1) /\ fvY[r,c] = 1 then ftSC[r,c] >= 0 else ftSC[r,c] = 0 endif
);
constraint forall(c in 0..15)(feY[rEb+rEu+rEm+rEl,c] = ftSC[rEb+rEu+rEm+rEl,c]);

% *** SubCell ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  if ftSC[r,c] >= 1 then feY[r,c] = ftSC[r,c]
  elseif feX[r,c] >= 1 then feY[r,c] = feX[r,c]
  else feY[r,c] = 0 endif
);

% *** AddRoundKey ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1)(
  forall(c in 0..7)(feSTK[r,posTable[c,r]] = feY[r,c]) /\ 
  forall(c in 0..15)(feZ[r,c] = feY[r,c])
);

% *** ShiftRow ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  feZ[r,SRp[c]] = feW[r,c]
);

% *** MixColumn ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..3)(
  if feW[r,c   ] >= 1 then 
    feX[r+1,c+ 4] = if fX[r+1,c+4 ] <= 1 /\                 fvW[r,c+4] = 0 /\ fvW[r,c+8] = 0                    then feW[r,c   ] else 0 endif
  endif
  /\
  if feW[r,c+ 4] >= 1 then 
    feX[r+1,c+ 4] = if fX[r+1,c+4 ] <= 1 /\ fvW[r,c] = 0 /\                   fvW[r,c+8] = 0                    then feW[r,c+ 4] else 0 endif /\
    feX[r+1,c+ 8] = if fX[r+1,c+8 ] <= 1                                                                        then feW[r,c+ 4] else 0 endif /\
    feX[r+1,c+12] = if fX[r+1,c+12] <= 1 /\                                   fvW[r,c+8] = 0 /\ fvW[r,c+12] = 0 then feW[r,c+ 4] else 0 endif
  endif
  /\
  if feW[r,c+ 8] >= 1 then
    feX[r+1,c+ 4] = if fX[r+1,c+ 4] <= 1 /\ fvW[r,c] = 0 /\ fvW[r,c+4] = 0                                      then feW[r,c+ 8] else 0 endif /\
    feX[r+1,c+12] = if fX[r+1,c+12] <= 1 /\                 fvW[r,c+4] = 0 /\                   fvW[r,c+12] = 0 then feW[r,c+ 8] else 0 endif
  endif
  /\
  if feW[r,c+12] >= 1 then 
    feX[r+1,c   ] = if fX[r+1,c   ] <= 1                                                                        then feW[r,c+12] else 0 endif /\
    feX[r+1,c+12] = if fX[r+1,c+12] <= 1 /\                fvW[r,c+4] = 0 /\ fvW[r,c+8] = 0                     then feW[r,c+12] else 0 endif
  endif
);
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..3)(
  if (feW[r,c+12] = 0)                                     then feX[r+1,c   ] = 0 endif /\
  if (feW[r,c] = 0 /\ feW[r,c+4] = 0 /\ feW[r,c+8] = 0)    then feX[r+1,c+ 4] = 0 endif /\
  if (feW[r,c+4] = 0)                                      then feX[r+1,c+ 8] = 0 endif /\
  if (feW[r,c+4] = 0 /\ feW[r,c+8] = 0 /\ feW[r,c+12] = 0) then feX[r+1,c+12] = 0 endif
);
% ----- [Lower] Apply State Test (End) -----
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ----- [Lower] Guess and Determine (Begin) -----
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fdetX;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fdetY; 
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fgSTK;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fdetZ;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fdetW;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fdetdiffX;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fdetdiffY;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: fdetdiffW;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: ffrSC;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var 0..1: ffrMC;

% *** Initial Plaintext ***
constraint forall(c in 0..15)(fdetW[rEb+rEu+rEm+rEl+rEf-1,c] = 1);

% *** ShiftRow ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  % stop the prop. of determination at this step
  fdetZ[r,SRp[c]] = if fvZ[r,SRp[c]] = 1 /\ fdetW[r,c] = 1 then 1 else 0 endif
);

% *** AddRoundKey ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..7)(fvSTK[r,c] >= fgSTK[r,c]);
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1)(
  forall(c in 0.. 7)(if fgSTK[r,posTable[c,r]] = 1 \/ feSTK[r,posTable[c,r]] = 1 then fdetY[r,c] = fdetZ[r,c] else fdetY[r,c] = 0 endif) /\
  % stop the prop. of determination at this step
  forall(c in 8..15)(fdetY[r,c] = if fvY[r,c] = 1 /\ fdetZ[r,c] = 1 then 1 else 0 endif)
);

% *** SubCell ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  fdetX[r,c] = fdetY[r,c]
);

% *** MixColumn ***
constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..3)(
  fdetW[r-1,c   ] = if                   fdetX[r,c+4] = 1                                          then 1 else 0 endif /\
  fdetW[r-1,c+ 4] = if                   fdetX[r,c+4] = 1 /\ fdetX[r,c+8] = 1 /\ fdetX[r,c+12] = 1 then 1 else 0 endif /\
  fdetW[r-1,c+ 8] = if                   fdetX[r,c+4] = 1 /\ fdetX[r,c+8] = 1                      then 1 else 0 endif /\
  fdetW[r-1,c+12] = if fdetX[r,c] = 1 /\                                         fdetX[r,c+12] = 1 then 1 else 0 endif
);

% -- Differential determination --
% ** initialization **
constraint forall(c in 0..15)(fdetdiffY[rEb+rEu+rEm+rEl+rEf-1,c] = 1);

% ** SubCell **
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..7)(fdetdiffX[r,c] = fgSTK[r,posTable[c,r]]);
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 8..15)(fdetdiffX[r,c] = fdetY[r,c]);

% ** ShiftRow **
constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  if fvY[r,SRp[c]] = 1 then fdetdiffY[r,SRp[c]] = fdetdiffW[r,c] else fdetdiffY[r,SRp[c]] = 0 endif
);

% ** MixColumn ** 
constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..3)(
  fdetdiffW[r-1,c   ] = if (fdetdiffX[r,c+4] = 1 \/ fX[r,c+4] = 0) then fdW[r-1,c] else 0 endif /\
  
  fdetdiffW[r-1,c+ 4] = if (fdetdiffX[r,c+4] = 1 \/ fX[r,c+4] = 0) /\ 
                           (fdetdiffX[r,c+8] = 1 \/ fX[r,c+8] = 0) /\ 
                           (fdetdiffX[r,c+12] = 1 \/ fX[r,c+12] = 0)  then fdW[r-1,c+4] else 0 endif /\
                           
  fdetdiffW[r-1,c+ 8] = if (fdetdiffX[r,c+4] = 1 \/ fX[r,c+4] = 0) /\ 
                           (fdetdiffX[r,c+12] = 1 \/ fX[r,c+12] = 0)    then fdW[r-1,c+8] else 0 endif /\
                           
  fdetdiffW[r-1,c+12] = if (fdetdiffX[r,c] = 1 \/ fX[r,c] = 0) /\ 
                           (fdetdiffX[r,c+12] = 1 \/ fX[r,c+12] = 0)  then fdW[r-1,c+12] else 0 endif
);
% -- *** --

% *** Filter SC ***
constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  ffrSC[r,c] = if fdetX[r,c] = 1 /\ fX[r,c] = 1 then 1 else 0 endif
);

% *** Filter MC ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..3)(
  ffrMC[r,c   ] = 0 /\
  ffrMC[r,c+ 4] = if fdetdiffW[r,c+ 4] = 1 /\ fW[r,c+ 4] <= 1 /\ (            fW[r  ,c+8] + fX[r+1,c+8])              >= 3 then 1 else 0 endif /\
  ffrMC[r,c+ 8] = if fdetdiffW[r,c+ 8] = 1 /\ fW[r,c+ 8] <= 1 /\ (            fX[r+1,c+4] +             fX[r+1,c+12]) >= 3 then 1 else 0 endif /\
  ffrMC[r,c+12] = if fdetdiffW[r,c+12] = 1 /\ fW[r,c+12] <= 1 /\ (fX[r+1,c] +                           fX[r+1,c+12]) >= 3 then 1 else 0 endif
);
% ----- [Lower] Guess and Determine (End) -----


% ----- [Lower] Epsilon (Begin) -----
% Here, we give the approach of guess-and-filter only, which allows the subkey deduction from known differentials (using Sbox property)

% --- value step assignment ---
% Since some values are allowed to be deduced, not all the values have to be assign a step.
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsaX;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsaY;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsgSTK;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsaZ;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, 0..15] of var -1..Step: fsaW;

% initialization
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  if fvX[r,c] = 0 then fsaX[r,c] = -1 elseif fdetX[r,c] = 1 then fsaX[r,c] = 0 else fsaX[r,c] != 0 endif /\
  if fvY[r,c] = 0 then fsaY[r,c] = -1 elseif fdetY[r,c] = 1 then fsaY[r,c] = 0 else fsaY[r,c] != 0 endif /\
  if fvZ[r,c] = 0 then fsaZ[r,c] = -1 elseif fdetZ[r,c] = 1 then fsaZ[r,c] = 0 else fsaZ[r,c] != 0 endif
);
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(
  if fvW[r,c] = 0 /\ fdW[r,c] = 0 then fsaW[r,c] = -1 elseif fdetW[r,c] = 1 then fsaW[r,c] = 0 else fsaW[r,c] != 0 endif
);
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1)(
  forall(c in 0..7)(
    if fvSTK[r,posTable[c,r]] = 0 then fsgSTK[r,posTable[c,r]] = -1
    elseif fgSTK[r,posTable[c,r]] = 1 then fsgSTK[r,posTable[c,r]] = 0
    elseif fgSTK[r,posTable[c,r]] = 0 then fsgSTK[r,posTable[c,r]] != 0
    endif
  ) /\
  forall(c in 8..15)(fsgSTK[r,posTable[c,r]] = -1)
);

% *** SubCell ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(if fvX[r,c] != 0 then fsaX[r,c] = fsaY[r,c] endif);

% *** AddRoundKey ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1)(
  forall(c in 0..7)(fsaY[r,c] = fsgSTK[r,posTable[c,r]]) /\
  forall(c in 8..15)(fsaY[r,c] = fsaZ[r,c])
);

% *** ShiftRow ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(
  if fvW[r,c] = 1 then fsaZ[r,SRp[c]] = fsaW[r,c] endif
);

% *** MixColumn ***
constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..3)(
  if fvW[r-1,c] = 1 /\ fsaX[r,c+4] >= 0 then fsaW[r-1,c] = fsaX[r,c+4] elseif fdetW[r-1,c] = 1 then fsaW[r-1,c] = 0 else fsaW[r-1,c] = -1 endif 
  /\
  if fvW[r-1,c+4] = 1 /\ fsaX[r,c+4] >= 0 /\ fsaX[r,c+8] >= 0 /\ fsaX[r,c+12] >= 0 then fsaW[r-1,c+ 4] = max([fsaX[r,c+4], fsaX[r,c+8], fsaX[r,c+12]]) elseif fdetW[r-1,c+4] = 1 then fsaW[r-1,c+ 4] = 0 else fsaW[r-1,c+ 4] = -1 endif 
  /\
  if fvW[r-1,c+8] = 1 /\ fsaX[r,c+4] >= 0 /\ fsaX[r,c+12] >= 0 then fsaW[r-1,c+ 8] = max(fsaX[r,c+4], fsaX[r,c+12]) elseif fdetW[r-1,c+8] = 1 then fsaW[r-1,c+8] = 0 else fsaW[r-1,c+8] = -1 endif 
  /\
  if fvW[r-1,c+12] = 1 /\ fsaX[r,c] >= 0 /\ fsaX[r,c+12] >= 0 then fsaW[r-1,c+12] = max(fsaX[r,c], fsaX[r,c+12]) elseif fdetW[r-1,c+12] = 1 then fsaW[r-1,c+12] = 0 else fsaW[r-1,c+12] = -1 endif
);

% ---------------- Differential step assignment ----------------
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsadiffX;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsadiffY;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, 0..15] of var -1..Step: fsadiffW;

% ** Initialization **
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  if fdX[r,c] = 0 then fsadiffX[r,c] = -1 
  elseif fdetdiffX[r,c] = 1 then fsadiffX[r,c] = 0
  elseif fdetdiffX[r,c] = 0 /\ fdX[r,c] = 1 then fsadiffX[r,c] >= fsaX[r,c] 
  endif
  /\
  if fvY[r,c] = 0 then fsadiffY[r,c] = -1
  elseif fdetdiffY[r,c] = 1 then fsadiffY[r,c] = 0
  elseif fdetdiffY[r,c] = 0 /\ fvY[r,c] = 1 then fsadiffY[r,c] >= fsaY[r,c] 
  endif
);
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(
  if fdW[r,c] = 0 then fsadiffW[r,c] = -1
  elseif fdetdiffW[r,c] = 1 then fsadiffW[r,c] = 0
  endif 
);

% ** SubCell **
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1)(
  forall(c in 0..7)(if fsgSTK[r,posTable[c,r]] >= 1 then fsadiffX[r,c] = fsgSTK[r,posTable[c,r]] 
                    elseif fsgSTK[r,posTable[c,r]] = -1 then fsadiffX[r,c] = -1 endif) /\
%   forall(c in 8..15)(fsadiffX[r,c] = max(fsaY[r,c],fsadiffY[r,c]))
  forall(c in 8..15)(fsadiffX[r,c] = fsaY[r,c])
);

% ** ShiftRow **
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(if fdX[r,SRp[c]] = 1 then fsadiffY[r,SRp[c]] = fsadiffW[r,c] endif);

% ** MixColumn **
constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..3)(
  if fdW[r-1,c   ] = 1 then fsadiffW[r-1,c   ] = fsadiffX[r,c+4] endif /\
  
  if fdW[r-1,c+ 4] = 1 /\ (fsadiffX[r,c+4]*fX[r,c+4] >= 0) /\ (fsadiffX[r,c+8]*fX[r,c+8] >= 0) /\ (fsadiffX[r,c+12]*fX[r,c+12] >= 0)
    then fsadiffW[r-1,c+ 4] = max(max(fsadiffX[r,c+4]*(fX[r,c+4] != 0), fsadiffX[r,c+8]*(fX[r,c+8] != 0)), fsadiffX[r,c+12]*(fX[r,c+12] != 0)) 
  else fsadiffW[r-1,c+ 4] = -1
  endif /\
    
  if fdW[r-1,c+ 8] = 1 /\ (fsadiffX[r,c+4]*fX[r,c+4] >= 0) /\ (fsadiffX[r,c+12]*fX[r,c+12] >= 0)
    then fsadiffW[r-1,c+ 8] = max(fsadiffX[r,c+4]*(fX[r,c+4] != 0), fsadiffX[r,c+12]*(fX[r,c+12] != 0)) 
  else fsadiffW[r-1,c+ 8] = -1
  endif /\
  
  if fdW[r-1,c+12] = 1 /\ (fsadiffX[r,c]*fX[r,c] >= 0) /\ (fsadiffX[r,c+12]*fX[r,c+12] >= 0)
    then fsadiffW[r-1,c+12] = max(fsadiffX[r,c]*(fX[r,c] != 0), fsadiffX[r,c+12]*(fX[r,c+12] != 0)) 
  else fsadiffW[r-1,c+12] = -1
  endif
);    

% ----------- deduce Differential by Sbox-property [begin] -------------
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsadedX;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsadedY;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, 0..15] of var -1..Step: fsadedW;

% initialization
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  if fdX[r,c] = 0 then fsadedX[r,c] = -1 elseif fsadiffX[r,c] >= 0 then fsadedX[r,c] = fsadiffX[r,c] elseif fsadevX[r,c] >= 0 then fsadedX[r,c] = fsadevX[r,c] else fsadedX[r,c] > -1 endif
);
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(
  if fdW[r,c] = 0 then fsadedW[r,c] = -1 elseif fsadiffW[r,c] >= 0 then fsadedW[r,c] = fsadiffW[r,c] else fsadedW[r,c] > -1 endif
);

% -------------------------
% back-track differential determination arising
constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..3)(
  % W3 = X0 + X3
  if fW[r-1,c+12] = 0 /\ fdW[r-1,c+12] = 1 then 
    (if fsadedX[r,c] != -1 /\ fX[r,c] != 0 /\ fsadedX[r,c] != fsadiffX[r,c] then fsadedX[r,c] = max([fsadiffX[r,c+12], fsadedX[r,c+12], fsadevX[r,c+12]]) endif)
    /\ 
    (if fsadedX[r,c+12] != -1 /\ fX[r,c+12] != 0  /\ fsadedX[r,c+12] != fsadiffX[r,c+12] then fsadedX[r,c+12] = max([fsadiffX[r,c], fsadedX[r,c], fsadevX[r,c+12]]) endif)
  endif
  /\
  % W2 = X1 + X3
  if (fW[r-1,c+8] = 0 /\ fdW[r-1,c+8] = 1) \/ ((fW[r-1,c+4] = 0 /\ fdW[r-1,c+4] = 1) /\ (fX[r,c+8] = 0 /\ fdX[r,c+8] = 1)) then 
    (if fsadedX[r,c+4] != -1 /\ fX[r,c+4] != 0  /\ fsadedX[r,c+4] != fsadiffX[r,c+4] then fsadedX[r,c+4] = max([fsadiffX[r,c+12], fsadedX[r,c+12], fsadevX[r,c+12]]) endif) 
    /\
    (if fsadedX[r,c+12] != -1 /\ fX[r,c+12] != 0  /\ fsadedX[r,c+12] != fsadiffX[r,c+12] then fsadedX[r,c+12] = max([fsadiffX[r,c+4], fsadedX[r,c+4], fsadevX[r,c+12]]) endif)
  endif
  /\
  % W1 = X1 + X2 + X3  ==> (W1 + X1) = X2 + X3
  if (fW[r-1,c+4] = 0 /\ fdW[r-1,c+4] = 1) /\ (fX[r,c+4] = 0 /\ fdX[r,c+4] = 1) then 
    (if fsadedX[r,c+8] != -1 /\ fX[r,c+8] != 0  /\ fsadedX[r,c+8] != fsadiffX[r,c+8] then fsadedX[r,c+8] = max([fsadiffX[r,c+12], fsadedX[r,c+12], fsadevX[r,c+8]]) endif) 
    /\
    (if fsadedX[r,c+12] != -1 /\ fX[r,c+12] != 0  /\ fsadedX[r,c+12] != fsadiffX[r,c+12] then fsadedX[r,c+12] = max([fsadiffX[r,c+8], fsadedX[r,c+8], fsadevX[r,c+12]]) endif)
  endif
  /\
  % W1 = X1 + X2 + X3  ==> (W1 + X2) = X1 + X3
  if (fW[r-1,c+4] = 0 /\ fdW[r-1,c+4] = 1) /\ (fX[r,c+8] = 0 /\ fdX[r,c+8] = 1) then 
    (if fsadedX[r,c+4] != -1 /\ fX[r,c+4] != 0  /\ fsadedX[r,c+4] != fsadiffX[r,c+4] then fsadedX[r,c+4] = max([fsadiffX[r,c+12], fsadedX[r,c+12], fsadevX[r,c+4]]) endif) 
    /\
    (if fsadedX[r,c+12] != -1 /\ fX[r,c+12] != 0  /\ fsadedX[r,c+12] != fsadiffX[r,c+12] then fsadedX[r,c+12] = max([fsadiffX[r,c+4], fsadedX[r,c+4], fsadevX[r,c+12]]) endif)
  endif
  /\
  % W1 = X1 + X2 + X3  ==> (W1 + X3) = X1 + X2
  if (fW[r-1,c+4] = 0 /\ fdW[r-1,c+4] = 1) /\ (fX[r,c+12] = 0 /\ fdX[r,c+12] = 1) then 
    (if fsadedX[r,c+4] != -1 /\ fX[r,c+4] != 0  /\ fsadedX[r,c+4] != fsadiffX[r,c+4] then fsadedX[r,c+4] = max([fsadiffX[r,c+8], fsadedX[r,c+8], fsadevX[r,c+4]]) endif)
    /\
    (if fsadedX[r,c+8] != -1 /\ fX[r,c+8] != 0  /\ fsadedX[r,c+8] != fsadiffX[r,c+8] then fsadedX[r,c+8] = max([fsadiffX[r,c+4], fsadedX[r,c+4], fsadevX[r,c+8]]) endif)
  endif
);
% -------------------------

% MixColumn
constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..3)(
  if fsadedW[r-1,c   ] >= 0 then fsadedW[r-1,c   ] = fsadedX[r,c+4] endif /\
  if fsadedW[r-1,c+ 4] >= 0 then fsadedW[r-1,c+ 4] = max([fsadedX[r,c+4]*(fX[r,c+4] != 0), fsadedX[r,c+8]*(fX[r,c+8] != 0), fsadedX[r,c+12]*(fX[r,c+12] != 0)]) endif /\
  if fsadedW[r-1,c+ 8] >= 0 then fsadedW[r-1,c+ 8] = max([fsadedX[r,c+4]*(fX[r,c+4] != 0), fsadedX[r,c+12]*(fX[r,c+12] != 0)]) endif /\
  if fsadedW[r-1,c+12] >= 0 then fsadedW[r-1,c+12] = max([fsadedX[r,c]*(fX[r,c] != 0), fsadedX[r,c+12]*(fX[r,c+12] != 0)]) endif
);

% ShiftRow
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(if fdX[r,SRp[c]] = 1 then fsadedY[r,SRp[c]] = fsadedW[r,c] else fsadedY[r,SRp[c]] = -1 endif);

% AddKey & SubCell
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(
  fsadedX[r,c] = fsadevY[r,c]
);

% ---=--- deduce values by Sbox-property (differential) [end] ---=---

% ---===--- deduce values by Sbox-property [begin] ---===---
% !! value determining using the property of Sbox
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsadevX;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsadevY;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsadevZ;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, 0..15] of var -1..Step: fsadevW;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsadevSTK;
% initialization
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  if fdX[r,c] = 1 /\ fvX[r,c] = 0 then fsadevX[r,c] = fsadevY[r,c]
    elseif fvX[r,c] = 0 then fsadevX[r,c] = -1 elseif fsaX[r,c] >= 0 then fsadevX[r,c] = fsaX[r,c] else fsadevX[r,c] != -1 endif /\
  if fvY[r,c] = 0 then fsadevY[r,c] = -1 elseif fsaY[r,c] >= 0 then fsadevY[r,c] = fsaY[r,c] else fsadevY[r,c] != -1 endif /\
  if fvZ[r,c] = 0 then fsadevZ[r,c] = -1 elseif fsaZ[r,c] >= 0 then fsadevZ[r,c] = fsaZ[r,c] else fsadevZ[r,c] != -1 endif /\
  if fsgSTK[r,c] >= 0 \/ fvSTK[r,c] = 0 \/ fsgSTK[r,c] > 0 then fsadevSTK[r,c] = -1 else fsadevSTK[r,c] != -1 endif
);
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(
  if fvW[r,c] = 0 then fsadevW[r,c] = -1 elseif fsaW[r,c] >= 0 then fsadevW[r,c] = fsaW[r,c] else fsadevW[r,c] != -1 endif
);

% Value deducation
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  if fsadedX[r,c] >= 0 /\ fX[r,c] >= 1 /\ fsadevX[r,c] != -1
    then fsadevX[r,c] = max([fsadedX[r,c], fsadedY[r,c], fsadiffY[r,c]])
  endif 
);

% Value propagation - SB
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(if fsadevX[r,c] != -1 then fsadevX[r,c] = fsadevY[r,c] endif);

% Value propagation - MC
constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..3)(
  if fsadevW[r-1,c   ] != -1 then fsadevW[r-1,c   ] = fsadevX[r,c+4] endif /\
  if fsadevW[r-1,c+ 4] != -1 then fsadevW[r-1,c+ 4] = max([fsadevX[r,c+4], fsadevX[r,c+8], fsadevX[r,c+12], fsaX[r,c+4], fsaX[r,c+8], fsaX[r,c+12]]) endif /\
  if fsadevW[r-1,c+ 8] != -1 then fsadevW[r-1,c+ 8] = max([fsadevX[r,c+4], fsadevX[r,c+12], fsaX[r,c+4], fsaX[r,c+12]]) endif /\
  if fsadevW[r-1,c+12] != -1 then fsadevW[r-1,c+12] = max([fsadevX[r,c], fsadevX[r,c+12], fsaX[r,c], fsaX[r,c+12]]) endif
);

% Value propagation - SR
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(fsadevZ[r,SRp[c]] = fsadevW[r,c]);

% Key deduction
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..7)(
  let{
    int: pc = posTable[c,r]
  } in 
  if fsadevSTK[r,pc] != -1 then fsadevSTK[r,pc] = max([fsadevY[r,c], fsadevZ[r,c]]) endif
);

% Value propagation - AK
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2)(
  forall(c in 0..7)(fsadevY[r,c] = max([fsgSTK[r,posTable[c,r]], fsadevSTK[r,posTable[c,r]], fsadevZ[r,c]])) /\
  forall(c in 8..15)(fsadevY[r,c] = fsadevZ[r,c])
);

% --- deduce values by Sbox-property [end] ---

% ----- [Lower] Epsilon (End) -----
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ======================================================= Lower (End) ======================================================


% ===================================================== Epsilon Complexity Eb union Ef (Begin) ====================================================
% ** Filters related to Steps **
array[0..Step] of var int: sgSTK;
array[0..Step] of var int: sdSTK;
array[2..rEb, 0..15] of var int: bsfrMC;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, 0..15] of var int: fsfrMC;
array[0..Step] of var int: sFrSC;
array[0..Step] of var int: sFrMC;
array[0..Step] of var int: sFrTT; % for rectangle attack, #filter times 2

% ===------=== Guess/Deduce subkey in each step ===------====
constraint sgSTK[0] = 0;
% consider the stronger key bridging
constraint forall(s in 1..Step)(
  sgSTK[s] = sum(r in 1..rEb-1, c in 0..15)(bsaSTK[r,c] = s /\ gL_bg[c] <= 2) + 
             sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(fsgSTK[r,c] = s /\ gL_bg[c] <= 2)
);
constraint forall(s in 0..Step)(
  sdSTK[s] = sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(fsadevSTK[r,c] = s)
);

% ===------=== Filters ===------===
% Can be directly deduced. (Filters in 0-th step)
constraint sFrSC[0] = sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(if fsadevX[r,c] = 0 /\ fdetX[r,c] = 0 then fY[r,c] - fX[r,c] else 0 endif);
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..3)(
  fsfrMC[r,c] = 0 /\
  if fsadedW[r,c+4] = 0 then (if fW[r,c+4] <= 1 /\ fdetdiffW[r,c+4] = 0 /\ (fW[r,c+8] + fX[r+1,c+ 8])>= 3  then fsfrMC[r,c+4] = 99 else fsfrMC[r,c+4] != 99 endif) else fsfrMC[r,c+4] != 99 endif/\
  if fsadedW[r,c+8] = 0 then (if fW[r,c+8] <= 1 /\ fdetdiffW[r,c+8] = 0 /\ (fX[r+1,c+4] + fX[r+1,c+12])>= 3 then fsfrMC[r,c+8] = 99 else fsfrMC[r,c+8] != 99 endif) else fsfrMC[r,c+8] != 99 endif/\
  if fsadedW[r,c+12] = 0 then (if fW[r,c+12] <= 1 /\ fdetdiffW[r,c+12] = 0 /\ (fX[r+1,c] + fX[r+1,c+12])>= 3 then fsfrMC[r,c+12] = 99 else fsfrMC[r,c+12] != 99 endif) else fsfrMC[r,c+12] != 99 endif
);
constraint sFrMC[0] = sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(fsfrMC[r,c] = 99);

% Filters for following steps
constraint forall(s in 1..Step)(
  sFrSC[s] = 
    sum(r in 1..rEb, c in 0..15)(if bsaY[r,c] = s then bX[r,c] - bY[r,c] else 0 endif) + 
    sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(if fsaX[r,c] = s then fY[r,c] - fX[r,c] else 0 endif) + 
    sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(if fsadevX[r,c] = s then fY[r,c] - fX[r,c] else 0 endif)
);
constraint forall(s in 1..Step)(
  forall(r in 1..rEb-1, c in 0..3)(
    if bsadiffW[r,c+ 4] = s then (if bX[r+1,c] <= 1 /\ bdetdiffX[r+1,c] = 0 /\ (bX[r+1,c+12] + bW[r,c+12]) >= 3 then bsfrMC[r+1,c] = s else bsfrMC[r+1,c] != s endif) else bsfrMC[r+1,c] != s endif/\
    bsfrMC[r+1,c+ 4] = 0 /\
    if bsadiffW[r,c+ 8] = s then (if bX[r+1,c+8] <= 1 /\ bdetdiffX[r+1,c+8] = 0 /\ (bW[r,c+4] + bW[r,c+ 8]) >= 3 then  bsfrMC[r+1,c+ 8] = s else  bsfrMC[r+1,c+ 8] != s endif) else bsfrMC[r+1,c+8] != s endif /\
    if bsadiffW[r,c+ 12] = s then (if bX[r+1,c+12] <= 1 /\ bdetdiffX[r+1,c+12] = 0 /\ (bW[r,c] + bW[r,c+8 ]) >= 3 then bsfrMC[r+1,c+12] = s else bsfrMC[r+1,c+12] != s endif) else bsfrMC[r+1,c+12] != s endif
  )
);
constraint forall(s in 1..Step)(
  forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..3)(
    fsfrMC[r,c   ] = 0 /\
    if fsadedW[r,c+ 4] = s \/ fsadiffW[r,c+ 4] = s then (if fW[r,c+4 ] <= 1 /\ fdetdiffW[r,c+4] = 0 /\ (fW[r  ,c+8] + fX[r+1,c+ 8])>= 3 then fsfrMC[r,c+4 ] = s else fsfrMC[r,c+4 ] != s endif) else fsfrMC[r,c+4 ] != s endif /\
    if fsadedW[r,c+ 8] = s \/ fsadiffW[r,c+ 8] = s then (if fW[r,c+8 ] <= 1 /\ fdetdiffW[r,c+8] = 0 /\ (fX[r+1,c+4] + fX[r+1,c+12])>= 3 then fsfrMC[r,c+8 ] = s else fsfrMC[r,c+8 ] != s endif) else fsfrMC[r,c+8 ] != s endif /\
    if fsadedW[r,c+12] = s \/ fsadiffW[r,c+12] = s then (if fW[r,c+12] <= 1 /\ fdetdiffW[r,c+12] = 0 /\ (fX[r+1,c  ] + fX[r+1,c+12])>= 3 then fsfrMC[r,c+12] = s else fsfrMC[r,c+12] != s endif) else fsfrMC[r,c+12] != s endif
  )
);
constraint forall(s in 1..Step)(
  sFrMC[s] = sum(r in 2..rEb-1, c in 0..15)(bsfrMC[r,c] = s) + 
             sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(fsfrMC[r,c] = s)
); 

% Total Filter = Classical Filter - Deduced key
constraint sFrTT[0] = 2*(sFrSC[0] + sFrMC[0]) - sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(fsadevSTK[r,c] = 0);
constraint forall(s in 1..Step)(
  sFrTT[s] = 2*(sFrSC[s] + sFrMC[s]) - 
             sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(fsadevSTK[r,c] = s)
);

array[0..Step] of var int: Re;
array[0..Step] of var int: Te;
var int: Tepsilon;
constraint Re[0] = 0 - sFrTT[0] /\ Te[0] = 0;
constraint forall(s in 1..Step)(Te[s] = Re[s-1] + sgSTK[s] /\ Re[s] = Re[s-1] + sgSTK[s] - sFrTT[s]);
constraint Tepsilon = max([0] ++ [Te[s] | s in 1..Step]);
% ====================================================== Epsilon Complexity Eb union Ef (End) =====================================================


% =================================================== Key Bridge (Begin) ===================================================
int: Spec = 3;
array[0..15] of var int: vLANE;
array[0..15] of var int: gLANE;
var int: vSTK_SUM;
var int: gSTK_SUM;
var 0..1: tsFlag; % 0 is state test in preguessing

% Classical Key Bridging --------------------------------------------------------------------------------------------------

% count involved subkey
constraint forall(c in 0..15)(
  vLANE[c] = sum(r in 0..rEb-1)(bvSTK[r,c]) 
  + sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1)(fvSTK[r,c])
);

% count guessed subkey
constraint forall(c in 0..15)(
  gLANE[c] = sum(r in 0..rEb-1)(bgSTK[r,c] = 1) + 
             sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1)(fgSTK[r,c] = 1)
);
% involved state without consideration of State Test
constraint vSTK_SUM = sum(c in 0..15)(if vLANE[c] >= Spec then Spec else vLANE[c] endif);
% guessed state without consideration of State Test
constraint gSTK_SUM = sum(c in 0..15)(if gLANE[c] >= Spec then Spec else gLANE[c] endif) + 
                      sum(r in 0..rEb, c in 0..15)(btSC[r,c] = 1) + 
                      sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(ftSC[r,c] = 1);

% Stronger Key Bridging ---------------------------------------------------------------------------------------------------
% When the stronger key bridge is employed, key counting is performed using a sliding window that spans 30 rounds.
% For the 33 round attack, the sliding window as [0..3, 26..29],[1..3, 26..30],[2..3, 26..31],[3..3, 26..32]
array[0..15] of var int: vL_bg;
array[0..15] of var int: gL_bg;
var int: vSTK_Sbg;
var int: gSTK_Sbg;

array[0..15] of var int: vsum029;
array[0..15] of var int: vsum130;
array[0..15] of var int: vsum231;
array[0..15] of var int: vsum332;
constraint forall(c in 0..15)(
  vsum029[c] = sum(r in 0..3)(bvSTK[r,c]) + sum(r in 26..29)(fvSTK[r,c]) /\
  vsum130[c] = sum(r in 1..3)(bvSTK[r,c]) + sum(r in 26..30)(fvSTK[r,c]) /\
  vsum231[c] = sum(r in 2..3)(bvSTK[r,c]) + sum(r in 26..31)(fvSTK[r,c]) /\
  vsum332[c] = sum(r in 3..3)(bvSTK[r,c]) + sum(r in 26..32)(fvSTK[r,c])
);
constraint forall(c in 0..15)(
  vL_bg[c] = max(max(vsum029[c], vsum130[c]), max(vsum231[c], vsum332[c]))
);

array[0..15] of var int: gsum029;
array[0..15] of var int: gsum130;
array[0..15] of var int: gsum231;
array[0..15] of var int: gsum332;
constraint forall(c in 0..15)(
  gsum029[c] = sum(r in 0..3)(bgSTK[r,c]) + sum(r in 26..29)(fgSTK[r,c]) /\
  gsum130[c] = sum(r in 1..3)(bgSTK[r,c]) + sum(r in 26..30)(fgSTK[r,c]) /\
  gsum231[c] = sum(r in 2..3)(bgSTK[r,c]) + sum(r in 26..31)(fgSTK[r,c]) /\
  gsum332[c] = sum(r in 3..3)(bgSTK[r,c]) + sum(r in 26..32)(fgSTK[r,c])
);
constraint forall(c in 0..15)(
    gL_bg[c] = max(max(gsum029[c], gsum130[c]), max(gsum231[c], gsum332[c]))
);

vSTK_Sbg = sum(c in 0..15)(if vL_bg[c] >= Spec then Spec else vL_bg[c] endif);
gSTK_Sbg = sum(c in 0..15)(if gL_bg[c] >= Spec then Spec else gL_bg[c] endif);
% ==================================================== Key Bridge (End) ====================================================

% ================================================================== Complexity [begin] ===================================================================
int: N = 64;
var int: rb;
var int: rf;
var int: rb_p;
var int: rf_p;

constraint rb = sum(c in 0..15)(bX[1,c] = 2);
constraint rf = sum(c in 0..15)(fY[rEb+rEu+rEm+rEl+rEf-1,c] = 2);
constraint rb_p = sum(r in 1..rEb-1, c in 0..15)(bfrSC[r,c]) + sum(r in 2..rEb-1, c in 0..15)(bfrMC[r,c]);
constraint rf_p = sum(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(ffrSC[r,c]) + sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(ffrMC[r,c]);

var int: Data;
var int: DataC;
var int: T1;
var int: T2u;
var int: T2l;
var int: T2;
var int: T3;  
var int: TimeC;
var int: MemoryC;
var 0..1: cp_P;

% var int: PrAtt = 46 + PrEb + PrEf;
% constraint 2*DataC = N + 4 + PrAtt;

constraint Data = 60;
constraint DataC = Data + 2;

constraint MemoryC = max([DataC, min(T2u-(4*gSTK_Sbg), T2l-(4*gSTK_Sbg)), 4*(vSTK_Sbg - gSTK_Sbg)]);

constraint T1 = DataC + 4*(gSTK_Sbg);
constraint T2u = Data + 4*(gSTK_Sbg) + 4*(rb-rb_p);
constraint T2l = T1 + 4*(rf-rf_p) + DataC - N + 1;
constraint if(T2u <= T2l) then(T2 = T2u /\ cp_P = 1) else(T2 = T2l /\ cp_P = 0) endif;
constraint T3 = 4*gSTK_Sbg + 2*Data + 8*(rb+rf-rb_p-rf_p) - 2*N + 4*Tepsilon;
constraint TimeC = max([T1, T2, T3]);
% ================================================================== Complexity [end] ===================================================================

% Solve
constraint 
  forall(r in 1..rEb-1, c in 0..15)(if bvSTK[r,c] = 1 then bsaSTK[r,c] >= 0 endif) /\
  forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(if fvSTK[r,c] = 1 then fsgSTK[r,c] >= 0 \/ fsadevSTK[r,c] >= 0 endif)
;
constraint TimeC <= N * Spec;
solve minimize 7*TimeC + 3*MemoryC;

% ---------------------------------------------------------------------------------------------------
% FIX UPPER FIX UPPER FIX UPPER FIX UPPER FIX UPPER FIX UPPER FIX UPPER FIX UPPER FIX UPPER FIX UPPER
constraint forall(r = 1, c in 0..15)(if c in {3}      then bSTK[r,c] = 1 else bSTK[r,c] = 0 endif);
constraint forall(r = 2, c in 0..15)(if c in {1,3}    then bSTK[r,c] = 1 else bSTK[r,c] = 0 endif);
constraint forall(r = 3, c in 0..15)(if c in {7}      then bSTK[r,c] = 1 else bSTK[r,c] = 0 endif);
constraint forall(r = 4, c in 0..15)(if c in {0,7}    then bY[r,c] = 1   else bY[r,c] = 0 endif);
constraint bX[4,0] = 1 /\ bX[4,7] = 1;
constraint PrEb = 16;
constraint sum(r in 0..rEb, c in 0..15)(bflagST[r,c]) = 0;
constraint forall(r in 0..2, c in 0..15)(if bvSTK[r,c] = 1 then bgSTK[r,c] = 1 else bgSTK[r,c] = 0 endif);
% FIX UPPER FIX UPPER FIX UPPER FIX UPPER FIX UPPER FIX UPPER FIX UPPER FIX UPPER FIX UPPER FIX UPPER

% % FIX LOWER FIX LOWER FIX LOWER FIX LOWER FIX LOWER FIX LOWER FIX LOWER FIX LOWER FIX LOWER FIX LOWER
constraint forall(r = 26, c in 0..15)(if c in {9} then fX[r,c] = 1 else fX[r,c] = 0 endif);
constraint forall(r in {26,28,30,32}, c in 0..7)(fSTK[r,c] = 0);
constraint forall(r = 27, c in 0..7)(if c in {6} then fSTK[r,c] = 1 else fSTK[r,c] = 0 endif);
constraint forall(r = 29, c in 0..7)(if c in {5} then fSTK[r,c] = 1 else fSTK[r,c] = 0 endif);
constraint forall(r = 31, c in 0..7)(if c in {3} then fSTK[r,c] = 1 else fSTK[r,c] = 0 endif);
constraint PrEf = 0;
constraint forall(r in 26..32, c in 0..15)(ftSC[r,c] = 0);

constraint forall(r in 30..32, c in 0..15)(if fvSTK[r,c] = 1 then fgSTK[r,c] = 1 endif);
constraint forall(r = 29, c in 0..15)(if c in {0} then fsgSTK[r,posTable[c,r]] = 2
                                  elseif c in {2,4} then fsgSTK[r,posTable[c,r]] = 3
                                  elseif c in {5,6,7} then fsgSTK[r,posTable[c,r]] = 0
                                  else fsgSTK[r,posTable[c,r]] = -1
                                  endif);
constraint forall(r = 28, c in 0..15)(if c in {2} then fsgSTK[r,posTable[c,r]] = 4
                                  elseif c in {4} then fsgSTK[r,posTable[c,r]] = 5
                                  else fsgSTK[r,posTable[c,r]] = -1
                                  endif);
constraint forall(r = 27, c in 0..15)(if c in {7} then fsgSTK[r,posTable[c,r]] = 5
                                  else fsgSTK[r,posTable[c,r]] = -1
                                  endif);
% % FIX LOWER FIX LOWER FIX LOWER FIX LOWER FIX LOWER FIX LOWER FIX LOWER FIX LOWER FIX LOWER FIX LOWER


% ----- Assistant Predicates -----
predicate SubCell(var 0..2: Sin, var 0..2: Sout) = 
  if Sin = 0 then Sout = 0
  else Sout >= 1
  endif
;

predicate XOR12(var 0..2: IN, var 0..1: SK, var 0..2: OUT) = 
  if     IN = 0 /\ SK = 0 then OUT = 0
  elseif IN = 0 /\ SK = 1 then OUT = 1
  elseif IN = 1 /\ SK = 0 then OUT = 1
  elseif IN = 1 /\ SK = 1 then OUT in {0,1}
  else                         OUT = 2
  endif
;

predicate XOR22(var 0..2: IN1, var 0..2: IN2, var 0..2: OUT, var 0..1: tag) = 
  if     IN1 = 0      /\ IN2 = 0       then OUT = 0
  elseif IN1 = 0      /\ IN2 = 1       then OUT = 1
  elseif IN1 = 1      /\ IN2 = 0       then OUT = 1
  elseif IN1 = 1      /\ IN2 = 1       then OUT in {0,1}
  elseif IN1 = 2      /\ IN2 in {0,1}  then OUT = 2
  elseif IN1 in {0,1} /\ IN2 = 2       then OUT = 2
  elseif IN1 = 2      /\ IN2 = 2       then OUT in {0,2}
  endif
  /\
  if (IN1 = 2 \/ IN2 = 2) /\ OUT = 0 then tag = 1 else tag = 0 endif
;