
include "table.mzn";
% =========== Model for SKINNY ==========

int: Spec = 3;
int: block_size = 64;


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


int: rEb = 5;
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

% % *** AddeqKey (0-th round) ***
% constraint forall(c in 0..3)(bvSTK[0,c] = if bvW[0,c] = 1 \/ bvW[0,c+4] = 1 \/ bvW[0,c+12] = 1 then 1 else 0 endif) /\
%                              bvSTK[0,7] = bvW[0, 8] /\
%                              bvSTK[0,4] = bvW[0, 9] /\
%                              bvSTK[0,5] = bvW[0,10] /\
%                              bvSTK[0,6] = bvW[0,11]
% ;
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

% *** AddRoundKey ***
% constraint forall(c in 0..3)(
%   beSTK[0,c] = if (beX[1,c] >= 1 \/ beX[1,c+4] >= 1 \/ beX[1,c+12] >= 1) /\ 
%                   count([beX[1,c], beX[1,c+4], beX[1,c+12]], 0) >= 2 
%                then max([beX[1,c], beX[1,c+4], beX[1,c+12]]) 
%                else 0 
%                endif
% );
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
% constraint forall(c in 0..3)(
%   if bgSTK[0,c] = 1 \/ beSTK[0,c] = 1 then bdetX[1,c   ] = bdetW[0,c   ] /\ 
%                                            bdetX[1,c+ 4] = bdetW[0,c+ 4] /\ 
%                                            bdetX[1,c+12] = bdetW[0,c+12] 
%                                       else bdetX[1,c] = 0 /\ bdetX[1,c+4] = 0 /\ bdetX[1,c+12] = 0
%   endif) /\ 
%   if bgSTK[0,7] = 1 \/ beSTK[0,7] = 1 then bdetX[1, 8] = bdetW[0, 8] else bdetX[1, 8] = 0 endif /\
%   if bgSTK[0,4] = 1 \/ beSTK[0,4] = 1 then bdetX[1, 9] = bdetW[0, 9] else bdetX[1, 9] = 0 endif /\
%   if bgSTK[0,5] = 1 \/ beSTK[0,5] = 1 then bdetX[1,10] = bdetW[0,10] else bdetX[1,10] = 0 endif /\
%   if bgSTK[0,6] = 1 \/ beSTK[0,6] = 1 then bdetX[1,11] = bdetW[0,11] else bdetX[1,11] = 0 endif
% ;
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
constraint forall(r in 0..rEb, c in 0..15)(bsaY[r,c] >= bsaX[r,c]);

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
constraint forall(r in 0..3, c in 0..3)(
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


% ##### Fixed Pattern #####
constraint forall(r = 2, c in 0..15)(if c in {3}      then bSTK[r,c] = 1 else bSTK[r,c] = 0 endif);
constraint forall(r = 3, c in 0..15)(if c in {1,3}    then bSTK[r,c] = 1 else bSTK[r,c] = 0 endif);
constraint forall(r = 4, c in 0..15)(if c in {7}      then bSTK[r,c] = 1 else bSTK[r,c] = 0 endif);
constraint forall(r = 5, c in 0..15)(if c in {0,7}    then bY[r,c] = 1   else bY[r,c] = 0 endif);
constraint bX[5,0] = 2 /\ bX[5,7] = 1;
constraint PrEb = 8;

constraint forall(r in {0,2}, c in 0..7)(bgSTK[r,c] = 1);
constraint forall(r in {1}, c in 8..15)(bgSTK[r,c] = 1);

% constraint forall(r in {3}, c in {8,9,11,12,14,15})(bgSTK[r,c] = 1);
% constraint sum(r in 0..3, c in 0..15)(bgSTK[r,c]) = 30;
% constraint sum(r in 0..rEb, c in 0..15)(bflagST[r,c]) = 0;

constraint forall(r in {3}, c in {8,9,11,12,14})(bgSTK[r,c] = 1);
constraint sum(r in 0..3, c in 0..15)(bgSTK[r,c]) = 29;
constraint btSC[5,0] = 1;
constraint sum(r in 0..rEb, c in 0..15)(bflagST[r,c]) = 1;
% ##### Fixed Pattern #####
% % ========================================================= Upper (End) ======================================================



% ======================================================= Lower (Begin) ======================================================
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ----- [Lower] Differential in Lower (Begin) -----
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

% -- the involved differentials --
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
  if fX[r,c+4] = 2 then fdW[r-1,c] = 1 endif /\
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
  fdetdiffW[r-1,c   ] = if (fdetdiffX[r,c+4] = 1 \/ fX[r,c+4] = 0)    then 1 else 0 endif /\
  fdetdiffW[r-1,c+ 4] = if (fdetdiffX[r,c+4] = 1 \/ fX[r,c+4] = 0) /\ 
                           (fdetdiffX[r,c+8] = 1 \/ fX[r,c+8] = 0) /\ 
                           (fdetdiffX[r,c+12] = 1 \/ fX[r,c+12] = 0)  then 1 else 0 endif /\
  fdetdiffW[r-1,c+ 8] = if (fdetdiffX[r,c+4] = 1 \/ fX[r,c+4] = 0) /\ 
                           (fdetdiffX[r,c+8] = 1 \/ fX[r,c+8] = 0)    then 1 else 0 endif /\
  fdetdiffW[r-1,c+12] = if (fdetdiffX[r,c] = 1 \/ fX[r,c] = 0) /\ 
                           (fdetdiffX[r,c+12] = 1 \/ fX[r,c+12] = 0)  then 1 else 0 endif
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
% Here, we give the approach of guess-and-filter only, which allows the subkey deduction from known differentials

array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsaX;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsaY;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsgSTK;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsaZ;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, 0..15] of var -1..Step: fsaW;

constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  if fdetZ[r,c] = 1 then fsaZ[r,c] = 0 elseif fdetZ[r,c] = 0 then fsaZ[r,c] != 0 endif /\
  if fvZ[r,c] = 0 then fsaZ[r,c] = -1 endif
);

constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1)(
  forall(c in 0..7)(
    if fgSTK[r,posTable[c,r]] = 1 then fsgSTK[r,posTable[c,r]] = 0 elseif fgSTK[r,posTable[c,r]] = 0 then fsgSTK[r,posTable[c,r]] != 0 endif /\
    if fvSTK[r,posTable[c,r]] = 0 then fsgSTK[r,posTable[c,r]] = -1 endif
  ) /\
  forall(c in 8..15)(fsgSTK[r,posTable[c,r]] = -1)
);


% *** SubCell ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(fsaX[r,c] = fsaY[r,c]);

% *** AddRoundKey ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1)(
  forall(c in 0..7)(fsaY[r,c] = fsgSTK[r,posTable[c,r]]) /\
  forall(c in 8..15)(fsaY[r,c] = fsaZ[r,c])
);

% *** ShiftRow ***
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(
  fsaZ[r,SRp[c]] = fsaW[r,c]
);

% *** MixColumn ***
constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..3)(
  fsaW[r-1,c   ] = if fvW[r-1,c   ] = 1 /\                  fsaX[r,c+4] >= 0                                          then fsaX[r,c+4] else -1 endif /\
  fsaW[r-1,c+ 4] = if fvW[r-1,c+ 4] = 1 /\                  fsaX[r,c+4] >= 0 /\ fsaX[r,c+8] >= 0 /\ fsaX[r,c+12] >= 0 then max(max(fsaX[r,c+4], fsaX[r,c+8]), fsaX[r,c+12]) else -1 endif /\
  fsaW[r-1,c+ 8] = if fvW[r-1,c+ 8] = 1 /\                  fsaX[r,c+4] >= 0 /\                     fsaX[r,c+12] >= 0 then max(fsaX[r,c+4], fsaX[r,c+12]) else -1 endif /\
  fsaW[r-1,c+12] = if fvW[r-1,c+12] = 1 /\ fsaX[r,c] >= 0 /\                                        fsaX[r,c+12] >= 0 then max(fsaX[r,c], fsaX[r,c+12]) else -1 endif
);

% -- Differential step assignment --
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsadiffX;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsadiffY;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsadiffZ;
array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, 0..15] of var -1..Step: fsadiffW;
% ** Initialization **
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
  if fdetX[r,c] = 1 then fsadiffX[r,c] = 0 elseif fdetX[r,c] = 0 then fsadiffX[r,c] != 0 endif /\ if fdX[r,c] = 0 then fsadiffX[r,c] = -1 endif /\
  if fdetY[r,c] = 1 then fsadiffY[r,c] = 0 elseif fdetY[r,c] = 0 then fsadiffY[r,c] != 0 endif /\ if fvY[r,c] = 0 then fsadiffY[r,c] = -1 endif /\
  if fdetZ[r,c] = 1 then fsadiffZ[r,c] = 0 elseif fdetZ[r,c] = 0 then fsadiffZ[r,c] != 0 endif /\ if fvZ[r,c] = 0 then fsadiffZ[r,c] = -1 endif
);
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(
  if fsaW[r,c] >= 1 then fsadiffW[r,c] = fsaW[r,c] 
    elseif (fdetW[r,c] = 1 \/ fdetdiffW[r,c] = 1) /\ fdW[r,c] = 1 then fsadiffW[r,c] = 0 
    elseif fdetW[r,c] = 0 then fsadiffW[r,c] != 0 
  endif 
  /\ if fdW[r,c] = 0 then fsadiffW[r,c] = -1 endif
);

% ** SubCell **
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1)(
  forall(c in 0..7)(if fsgSTK[r,posTable[c,r]] >= 1 then fsadiffX[r,c] = fsgSTK[r,posTable[c,r]] endif) /\
  forall(c in 8..15)(fsadiffX[r,c] = fsadiffY[r,c])
);

constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..3)(
  if fW[r-1,c+8] = 0 \/ (fW[r-1,c+4] = 0 /\ fX[r,c+8] = 0) then 
    (if fdX[r,c+4] = 1 /\ fsaX[r,c+4] = -1 then fsadiffX[r,c+4] >= fsadiffX[r,c+12] endif) /\
    (if fdX[r,c+12] = 1 /\ fsaX[r,c+12] = -1 then fsadiffX[r,c+12] >= fsadiffX[r,c+4] endif)
     endif /\
  if fW[r-1,c+12] = 0 then 
    (if fdX[r,c] = 1 /\ fsaX[r,c] = -1 then fsadiffX[r,c] >= fsadiffX[r,c+12] endif) /\
    (if fdX[r,c+12] = 1 /\ fsaX[r,c+12] = -1 then fsadiffX[r,c+12] >= fsadiffX[r,c] endif)
     endif /\
  if fW[r-1,c+4] = 0 /\ fX[r,c+12] = 0 then
    (if fdX[r,c+4] = 1 /\ fsaX[r,c+4] = -1 then fsadiffX[r,c+4] >= fsadiffX[r,c+8] endif) /\
    (if fdX[r,c+8] = 1 /\ fsaX[r,c+8] = -1 then fsadiffX[r,c+8] >= fsadiffX[r,c+4] endif)
     endif
);

% ** ShiftRow **
constraint forall(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-2, c in 0..15)(if fvY[r,SRp[c]] = 1 then fsadiffY[r,SRp[c]] >= fsadiffW[r,c] endif);

% ** MixColumn **
constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..3)(
  if fdW[r-1,c   ] = 1 /\ fsaW[r-1,c   ] = -1 then fsadiffW[r-1,c   ] = fsadiffX[r,c+4] endif /\
  if fdW[r-1,c+ 4] = 1 /\ fsaW[r-1,c+ 4] = -1 then fsadiffW[r-1,c+ 4] = max(max(fsadiffX[r,c+4], fsadiffX[r,c+8]), fsadiffX[r,c+12]) endif /\
  if fdW[r-1,c+ 8] = 1 /\ fsaW[r-1,c+ 8] = -1 then fsadiffW[r-1,c+ 8] = max(fsadiffX[r,c+4], fsadiffX[r,c+12]) endif /\
  if fdW[r-1,c+12] = 1 then fsadiffW[r-1,c+12] = max(fsadiffX[r,c], fsadiffX[r,c+12]) endif
);

% % TEST temporary
constraint forall(r = 28, c in 0..7)(if c in {7} then fsgSTK[r,posTable[c,r]] = 5 else fsgSTK[r,posTable[c,r]] = -1 endif);
constraint forall(r = 29, c in 0..7)(if c in {2} then fsgSTK[r,posTable[c,r]] = 4 elseif c in {4} then fsgSTK[r,posTable[c,r]] = 5 else fsgSTK[r,posTable[c,r]] = -1 endif);

% % -- The back-track deduction --
% array[rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsddX;

% array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsdvX;
% array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsdvY;
% array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsdvZ;
% array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fsdvW;
% array[rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, 0..15] of var -1..Step: fdvSTK; % mark where the subkey can be deduced by the property of Sbox

% % ** Initialization **
% constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(
%   if fsadiffX[r,c] <= 0 then fsddX[r,c] = fsadiffX[r,c] 
%   elseif fX[r,c] = 0 then fsddX[r,c] = -1 
%   else fsddX[r,c] >= 4 endif
% );

% constraint forall(r in rEb+rEu+rEm+rEl+1..rEb+rEu+rEm+rEl+rEf-1, c in 0..3)(
%   if fW[r-1, c+8] = 0 then fsddX[r,c+4] = fsddX[r,c+12] /\ fsddX[r,c+4] = fsadiffW[r-1,c+8] else fsddX[r,c+4] = -1 /\ fsddX[r,c+12] = -1 endif
% );
% ----- [Lower] Epsilon (End) -----
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% ##### Fixed Pattern #####
constraint forall(r = 27, c in 0..15)(if c in {9} then fX[r,c] = 1 else fX[r,c] = 0 endif);
constraint forall(r in {27,29,31,33}, c in 0..7)(fSTK[r,c] = 0);
constraint forall(r = 28, c in 0..7)(if c in {6} then fSTK[r,c] = 1 else fSTK[r,c] = 0 endif);
constraint forall(r = 30, c in 0..7)(if c in {5} then fSTK[r,c] = 1 else fSTK[r,c] = 0 endif);
constraint forall(r = 32, c in 0..7)(if c in {3} then fSTK[r,c] = 1 else fSTK[r,c] = 0 endif);
constraint PrEf = 0;

constraint forall(r in 27..33, c in 0..15)(ftSC[r,c] = 0);

constraint forall(r in 30..33)(forall(c in 0..7)(fgSTK[r,posTable[c,r]] = 1) /\ forall(c in 8..15)(fgSTK[r,posTable[c,r]] = 0));
constraint forall(r in 27..29, c in 0..15)(fgSTK[r,c] = 0);
% ##### Fixed Pattern #####
% ======================================================= Lower (End) ======================================================


% ===================================================== Epsilon Complexity Eb union Ef (Begin) ====================================================

% ** Filters related to Steps **
array[1..Step] of var int: sFrSC;
array[1..Step] of var int: sFrMC;

constraint forall(s in 1..Step)(
  sFrSC[s] = 
    sum(r in 1..rEb, c in 0..15)(if bsaY[r,c] = s then bX[r,c] - bY[r,c] else 0 endif)
);


% ====================================================== Epsilon (End) =====================================================


% % % =================================================== Key Bridge (Begin) ===================================================
% array[0..15] of var int: vLANE;
% array[0..15] of var int: gLANE;
% var int: vSTK_SUM;
% var int: gSTK_SUM;
% var 0..1: tsFlag; % 0 is state test in preguessing

% % count involved subkey
% constraint forall(c in 0..15)(
%   vLANE[c] = sum(r in 0..rEb-1)(bvSTK[r,c]) 
%   + sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1)(fvSTK[r,c])
% );

% % count guessed subkey
% constraint forall(c in 0..15)(
%   gLANE[c] = sum(r in 0..rEb-1)(bgSTK[r,c] = 1) + 
%              sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1)(fgSTK[r,c] = 1)
% );

% % involved state without consideration of State Test
% constraint vSTK_SUM = sum(c in 0..15)(if vLANE[c] >= 3 then 3 else vLANE[c] endif);
% % guessed state without consideration of State Test
% constraint gSTK_SUM = sum(c in 0..15)(if gLANE[c] >= 3 then 3 else gLANE[c] endif) + 
%                       sum(r in 1..rEb, c in 0..15)(btSC[r,c] = 1) + 
%                       sum(r in rEb+rEu+rEm+rEl..rEb+rEu+rEm+rEl+rEf-1, c in 0..15)(ftSC[r,c] = 1);
% % ==================================================== Key Bridge (End) ====================================================






























































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