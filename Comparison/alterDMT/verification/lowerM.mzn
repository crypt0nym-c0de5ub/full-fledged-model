
% NOTE:
% This model for TK3, slight modify it when mounting on TK2
% bit format is reversed, i.e. 0x72 = 1,1,1,0, 0,0,1,0


include "AES_DDT.dzn";
include "AES_BCT.dzn";
include "AES_MC.dzn";


array[0..15] of var 0..15: SRp = array1d(0..15, [0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11]);
array[0..15] of var 0..15: hperm = array1d(0..15, [1,6,11,12,5,10,15,0,9,14,3,4,13,2,7,8]);
array[0..7] of int: weights = array1d(0..7,[1, 2, 4, 8, 16, 32, 64, 128]);
int: KSize = 3;

int: bR = 1;
int: uR = 4;
int: mR = 2;
int: lR = 4;
int: fR = 4;

% ================================= UPPER (begin) =====================================
array[1..KSize, 0..bR+uR+mR-1, 0..15, 0..7] of var 0..1: utk;  % tk in binary format
array[1..KSize, 0..bR+uR+mR-1, 0..15] of var 0..255: utk_int;  % tk in integer format
array[2..KSize, 0..bR+uR+mR-1, 0..15, 0..7] of var 0..1: utp;  % temporary variable after shift bits.
array[0..bR+uR+mR-1, 0..15, 0..7] of var 0..1: uSTK;  % stk in binary format, stk = add(tk_i)
array[0..bR+uR+mR-1, 0..15] of var 0..255: uSTK_int;  % stk in integer format

constraint forall(r in 0..bR+uR+mR-1, c in 0..15)(
  forall(s in 1..KSize)(
    utk_int[s,r,c] = sum(i in 0..7)(utk[s,r,c,i] * weights[i])
  ) 
  /\
  uSTK_int[r,c] = sum(i in 0..7)(uSTK[r,c,i] * weights[i])
);

array[bR..bR+uR+mR-1, 0..15, 0..7] of var 0..1: uAK; % before AK
array[bR..bR+uR+mR-1, 0..15, 0..7] of var 0..1: uSB; % before SB
array[bR..bR+uR+mR-2, 0..15, 0..7] of var 0..1: uSR; % before SR
array[bR-1..bR+uR+mR-2, 0..15, 0..7] of var 0..1: uMC; % before MC

array[bR..bR+uR+mR-1, 0..15] of var 0..255: uAK_int; % before AK
array[bR..bR+uR+mR-1, 0..15] of var 0..255: uSB_int; % before SB
array[bR..bR+uR+mR-2, 0..15] of var 0..255: uSR_int; % before SR
array[bR-1..bR+uR+mR-2, 0..15] of var 0..255: uMC_int; % before MC

% bit to int
constraint 
  forall(r in bR..bR+uR+mR-1, c in 0..15)(
    uAK_int[r,c] = sum(i in 0..7)(uAK[r,c,i] * weights[i]) /\
    uSB_int[r,c] = sum(i in 0..7)(uSB[r,c,i] * weights[i])
    ) /\
  forall(r in bR..bR+uR+mR-2, c in 0..15)(
    uSR_int[r,c] = sum(i in 0..7)(uSR[r,c,i] * weights[i])
    ) /\
  forall(r in bR-1..bR+uR+mR-2, c in 0..15)(
    uMC_int[r,c] = sum(i in 0..7)(uMC[r,c,i] * weights[i])
    )
;

% This verification without PrEb
array[bR..bR+uR+mR-2, 0..15] of var 0..255: uPrSB; % prob. of SB

% % =========== Key schedule ==============
% LFSR2 ("<<" to ">>" for compatibility)
constraint forall(r in 0..bR+uR+mR-1, c in 0..15, i in 1..7)((utp[2,r,c,i] = utk[2,r,c,i-1]));
constraint forall(r in 0..bR+uR+mR-1, c in 0..15)(utp[2,r,c,0] = (utk[2,r,c,5] + utk[2,r,c,7]) mod 2);
% LFSR3 ("<<" to ">>" for compatibility)
constraint forall(r in 0..bR+uR+mR-1, c in 0..15, i in 0..6)(utp[3,r,c,i] = utk[3,r,c,i+1]);
constraint forall(r in 0..bR+uR+mR-1, c in 0..15)(utp[3,r,c,7] = (utk[3,r,c,0] + utk[3,r,c,6]) mod 2);
% h permutation
constraint forall(r in 0..bR+uR+mR-2, c in 0..15, i in 0..7)(utk[1,r+1,c,i] = utk[1,r,hperm[c],i]);
constraint forall(r in 0..bR+uR+mR-2, c in 0..15, i in 0..7)(utk[2,r+1,c,i] = utp[2,r,hperm[c],i]);
constraint forall(r in 0..bR+uR+mR-2, c in 0..15, i in 0..7)(utk[3,r+1,c,i] = utp[3,r,hperm[c],i]);
% Get STK
constraint forall(r in 0..bR+uR+mR-1, c in 0..15, i in 0..7)(uSTK[r,c,i] = (utk[1,r,c,i] + utk[2,r,c,i]+ utk[3,r,c,i]) mod 2);

% ======== Diff. Propagation =======
% --- operation AK ---
constraint forall(r in bR..bR+uR+mR-1, c in 0..15, i in 0..7)(
  uSB[r,c,i] = (uAK[r,c,i] + uSTK[r,c,i]) mod 2
);

% --- operation SB ---
constraint forall(r in bR..bR+uR-1, c in 0..15)(
  if uSB_int[r,c] > 0
  then (uPrSB[r,c] = DDT[uSB_int[r,c], uSR_int[r,c]]) /\ uPrSB[r,c] > 0
  else uSR_int[r,c] = 0 /\ uPrSB[r,c] = 0
  endif
);

% --- operation SR ---
constraint forall(r in bR..bR+uR-1, c in 0..15)(
  forall(i in 0..7)(uMC[r,c,i] = uSR[r,SRp[c],i]) /\
  uMC_int[r,c] = uSR_int[r,SRp[c]]
);

% --- operation MC ---
constraint forall(r in bR-1..bR+uR-1, col in [0,4,8,12])(
  _MC(array1d(0..3, [uMC_int[r,c] | c in col..col+3]), 
      array2d(0..3, 0..7, [uMC[r,c,i] | c in col..col+3, i in 0..7]),
      array2d(0..3, 0..7, [uAK[r+1,c,i] | c in col..col+3, i in 0..7])
     )
);

% ================ Truncated Pattern ================
constraint forall(r = 0,c in 0..15)(if c in {3,8,10} then uSTK_int[r,c] > 1 else uSTK_int[r,c] = 0 endif);
constraint forall(r = 1,c in 0..15)(if c in {5,10,15} then uSTK_int[r,c] > 1 else uSTK_int[r,c] = 0 endif);
constraint forall(r = 2,c in 0..15)(if c in {4,5,6} then uSTK_int[r,c] > 1 else uSTK_int[r,c] = 0 endif);
constraint forall(r = 3,c in 0..15)(if c in {} then uSTK_int[r,c] > 1 else uSTK_int[r,c] = 0 endif);
constraint forall(r = 4,c in 0..15)(if c in {} then uSTK_int[r,c] > 1 else uSTK_int[r,c] = 0 endif); % 0
constraint forall(r = 5,c in 0..15)(if c in {2,7,13} then uSTK_int[r,c] > 1 else uSTK_int[r,c] = 0 endif); % 0
constraint forall(r = 6,c in 0..15)(if c in {12,13,14} then uSTK_int[r,c] > 1 else uSTK_int[r,c] = 0 endif);

% MC
constraint forall(r = 0, c in 0..15)(if c in {4,5,6,7,8,9,11,12,14,15} then uMC_int[r,c] > 1 else uMC_int[r,c] = 0 endif);
constraint forall(r = 1, c in 0..15)(if c in {5,6} then uMC_int[r,c] > 1 else uMC_int[r,c] = 0 endif);
constraint forall(r = 2, c in 0..15)(if c in {} then uMC_int[r,c] > 1 else uMC_int[r,c] = 0 endif);
constraint forall(r = 3, c in 0..15)(if c in {} then uMC_int[r,c] > 1 else uMC_int[r,c] = 0 endif); % 0
constraint forall(r = 4, c in 0..15)(if c in {} then uMC_int[r,c] > 1 else uMC_int[r,c] = 0 endif); % 0
constraint forall(r = 5, c in 0..15)(if c in {} then uMC_int[r,c] > 1 else uMC_int[r,c] = 0 endif); % 0
% constraint forall(r = 6, c in 0..15)(if c in {} then uMC_int[r,c] > 1 else uMC_int[r,c] = 0 endif); % 0

% AK
constraint forall(r = 1, c in 0..15)(if c in {5,9,10,14,15} then uAK_int[r,c] > 1 else uAK_int[r,c] = 0 endif);
constraint forall(r = 2, c in 0..15)(if c in {4,5,6} then uAK_int[r,c] > 1 else uAK_int[r,c] = 0 endif);
constraint forall(r = 3, c in 0..15)(if c in {} then uAK_int[r,c] > 1 else uAK_int[r,c] = 0 endif);
constraint forall(r = 4, c in 0..15)(if c in {} then uAK_int[r,c] > 1 else uAK_int[r,c] = 0 endif); % 0
constraint forall(r = 5, c in 0..15)(if c in {} then uAK_int[r,c] > 1 else uAK_int[r,c] = 0 endif); % 0
constraint forall(r = 6, c in 0..15)(if c in {} then uAK_int[r,c] > 1 else uAK_int[r,c] = 0 endif); % 0
% constraint forall(r = 7, c in 0..15)(if c in {} then uAK_int[r,c] > 1 else uAK_int[r,c] = 0 endif); % 0

% SB
constraint forall(r = 1, c in 0..15)(if c in {9,14} then uSB_int[r,c] > 1 else uSB_int[r,c] = 0 endif);
constraint forall(r = 2, c in 0..15)(if c in {} then uSB_int[r,c] > 1 else uSB_int[r,c] = 0 endif);
constraint forall(r = 3, c in 0..15)(if c in {} then uSB_int[r,c] > 1 else uSB_int[r,c] = 0 endif); % 0
constraint forall(r = 4, c in 0..15)(if c in {} then uSB_int[r,c] > 1 else uSB_int[r,c] = 0 endif); % 0
constraint forall(r = 5, c in 0..15)(if c in {2,7,13} then uSB_int[r,c] > 1 else uSB_int[r,c] = 0 endif); % 0
% constraint forall(r = 6, c in 0..15)(if c in {3,9,14} then uSB_int[r,c] > 1 else uSB_int[r,c] = 0 endif);

constraint forall(r = 5, c in 0..15)(uSR_int[5,c] = 0 /\ uPrSB[5,c] = 0);
% ================================= UPPER (end) =====================================


% ================================= LOWER (begin) ===================================
array[1..KSize, bR+uR..bR+uR+mR+lR+fR, 0..15, 0..7] of var 0..1: ltk;  % s tks in lower
array[1..KSize, bR+uR..bR+uR+mR+lR+fR, 0..15] of var 0..255: ltk_int;  % tk in integer format
array[1..KSize, bR+uR..bR+uR+mR+lR+fR, 0..15, 0..7] of var 0..1: ltp;  % temporary variable after shift bits.
array[bR+uR..bR+uR+mR+lR+fR, 0..15, 0..7] of var 0..1: lSTK;  % stk in binary format, stk = add(tk_i)
array[bR+uR..bR+uR+mR+lR+fR, 0..15] of var 0..255: lSTK_int;  % stk in integer format

% ====== bin to int ======
constraint forall(r in bR+uR..bR+uR+mR+lR+fR, c in 0..15)(
  forall(s in 1..KSize)(
    ltk_int[s,r,c] = sum(i in 0..7)(ltk[s,r,c,i] * weights[i])
  )
  /\
  lSTK_int[r,c] = sum(i in 0..7)(lSTK[r,c,i] * weights[i])
);

array[bR+uR+1..bR+uR+mR+lR, 0..15, 0..7] of var 0..1: lAK; % before AK
array[bR+uR+1..bR+uR+mR+lR-1, 0..15, 0..7] of var 0..1: lSB; % before SB
array[bR+uR+1..bR+uR+mR+lR-1, 0..15, 0..7] of var 0..1: lSR; % before SR
array[bR+uR+1..bR+uR+mR+lR-1, 0..15, 0..7] of var 0..1: lMC; % before MC

array[bR+uR+1..bR+uR+mR+lR, 0..15] of var 0..255: lAK_int; % before AK
array[bR+uR+1..bR+uR+mR+lR-1, 0..15] of var 0..255: lSB_int; % before SB
array[bR+uR+1..bR+uR+mR+lR-1, 0..15] of var 0..255: lSR_int; % before SR
array[bR+uR+1..bR+uR+mR+lR-1, 0..15] of var 0..255: lMC_int; % before MC

% bit to int
constraint 
  forall(r in bR+uR+1..bR+uR+mR+lR, c in 0..15)(
    lAK_int[r,c] = sum(i in 0..7)(lAK[r,c,i] * weights[i])
  )/\
  forall(r in bR+uR+1..bR+uR+mR+lR-1, c in 0..15)(
    lSB_int[r,c] = sum(i in 0..7)(lSB[r,c,i] * weights[i]) /\
    lSR_int[r,c] = sum(i in 0..7)(lSR[r,c,i] * weights[i]) /\
    lMC_int[r,c] = sum(i in 0..7)(lMC[r,c,i] * weights[i])
    )
;

% This verification without PrEb
array[bR+uR+1..bR+uR+mR+lR-1, 0..15] of var 0..255: lPrSB; % prob. of SB

% =========== Key schedule (lower) ==============
% LFSR2 ("<<" to ">>" for compatibility)
constraint forall(r in bR+uR..bR+uR+mR+lR+fR, c in 0..15, i in 1..7)(ltp[2,r,c,i] = ltk[2,r,c,i-1]);
constraint forall(r in bR+uR..bR+uR+mR+lR+fR, c in 0..15)(ltp[2,r,c,0] = (ltk[2,r,c,5] + ltk[2,r,c,7]) mod 2);
% LFSR3 ("<<" to ">>" for compatibility)
constraint forall(r in bR+uR..bR+uR+mR+lR+fR, c in 0..15, i in 0..6)(ltp[3,r,c,i] = ltk[3,r,c,i+1]);
constraint forall(r in bR+uR..bR+uR+mR+lR+fR, c in 0..15)(ltp[3,r,c,7] = (ltk[3,r,c,0] + ltk[3,r,c,6]) mod 2);                               
% h permutation
constraint forall(r in bR+uR..bR+uR+mR+lR+fR-1, c in 0..15, i in 0..7)(ltk[1,r+1,c,i] = ltk[1,r,hperm[c],i]);
constraint forall(r in bR+uR..bR+uR+mR+lR+fR-1, c in 0..15, i in 0..7)(ltk[2,r+1,c,i] = ltp[2,r,hperm[c],i]);
constraint forall(r in bR+uR..bR+uR+mR+lR+fR-1, c in 0..15, i in 0..7)(ltk[3,r+1,c,i] = ltp[3,r,hperm[c],i]);
% Get STK
constraint forall(r in bR+uR..bR+uR+mR+lR+fR, c in 0..15, i in 0..7)(lSTK[r,c,i] = (ltk[1,r,c,i] + ltk[2,r,c,i] + ltk[3,r,c,i]) mod 2);

% ======== Diff. Propagation =======
% --- operation AK ---
constraint forall(r in 7..8, c in 0..15, i in 0..7)(
  lSB[r,c,i] = (lAK[r,c,i] + lSTK[r,c,i]) mod 2
);

% --- operation SB ---
constraint forall(r in 6..7, c in 0..15)(
  if lSB_int[r,c] > 0
  then (lPrSB[r,c] = DDT[lSB_int[r,c], lSR_int[r,c]]) /\ lPrSB[r,c] > 0
  else lSR_int[r,c] = 0 /\ lPrSB[r,c] = 0
  endif
);

% --- operation SR ---
constraint forall(r in 6..7, c in 0..15)(
  forall(i in 0..7)(lMC[r,c,i] = lSR[r,SRp[c],i]) /\
  lMC_int[r,c] = lSR_int[r,SRp[c]]
);

% --- operation MC ---
constraint forall(r in 6..7, col in [0,4,8,12])(
  _MC(array1d(0..3, [lMC_int[r,c] | c in col..col+3]), 
      array2d(0..3, 0..7, [lMC[r,c,i] | c in col..col+3, i in 0..7]),
      array2d(0..3, 0..7, [lAK[r+1,c,i] | c in col..col+3, i in 0..7])
     )
);

% ========= Truncated Pattern =========
constraint forall(r = 5, c in 0..15)(if c in {6,9,12} then lSTK_int[r,c] > 1 else lSTK_int[r,c] = 0 endif);
constraint forall(r = 6, c in 0..15)(if c in {1,3,8} then lSTK_int[r,c] > 1 else lSTK_int[r,c] = 0 endif);
constraint forall(r = 7, c in 0..15)(if c in {0,10,15} then lSTK_int[r,c] > 1 else lSTK_int[r,c] = 0 endif);
constraint forall(r = 8, c in 0..15)(if c in {5,6,7} then lSTK_int[r,c] > 1 else lSTK_int[r,c] = 0 endif);
constraint forall(r = 9, c in 0..15)(if c in {} then lSTK_int[r,c] > 1 else lSTK_int[r,c] = 0 endif);
constraint forall(r = 10, c in 0..15)(if c in {} then lSTK_int[r,c] > 1 else lSTK_int[r,c] = 0 endif); % 0
constraint forall(r = 11, c in 0..15)(if c in {2,7,8} then lSTK_int[r,c] > 1 else lSTK_int[r,c] = 0 endif); % 0
constraint forall(r = 12, c in 0..15)(if c in {13,14,15} then lSTK_int[r,c] > 1 else lSTK_int[r,c] = 0 endif);
constraint forall(r = 13, c in 0..15)(if c in {6,9,12} then lSTK_int[r,c] > 1 else lSTK_int[r,c] = 0 endif);
constraint forall(r = 14, c in 0..15)(if c in {1,3,8} then lSTK_int[r,c] > 1 else lSTK_int[r,c] = 0 endif);
constraint forall(r = 15, c in 0..15)(if c in {0,10,15} then lSTK_int[r,c] > 1 else lSTK_int[r,c] = 0 endif);

% AK
constraint forall(r = 6, c in 0..15)(lAK_int[r,c] = 0);
constraint forall(r = 7, c in 0..15)(if c in {0,3,10,14,15} then lAK_int[r,c] > 1 else lAK_int[r,c] = 0 endif);
constraint forall(r = 8, c in 0..15)(if c in {5,6,7} then lAK_int[r,c] > 1 else lAK_int[r,c] = 0 endif);
constraint forall(r = 9, c in 0..15)(if c in {} then lAK_int[r,c] > 1 else lAK_int[r,c] = 0 endif);
constraint forall(r = 10, c in 0..15)(if c in {} then lAK_int[r,c] > 1 else lAK_int[r,c] = 0 endif); % 0
constraint forall(r = 11, c in 0..15)(if c in {} then lAK_int[r,c] > 1 else lAK_int[r,c] = 0 endif); % 0
% constraint forall(r = 12, c in 0..15)(if c in {} then lAK_int[r,c] > 1 else lAK_int[r,c] = 0 endif); % 0
% constraint forall(r = 13, c in 0..15)(if c in {} then lAK_int[r,c] > 1 else lAK_int[r,c] = 0 endif);

constraint lSB_int[6,8] = lSTK_int[6,8];

% SB
constraint forall(r = 6, c in 0..15)(if c in {0,1,2,5,6,7,8,12,13,15} then lSB_int[r,c] > 1 else lSB_int[r,c] = 0 endif);
constraint forall(r = 7, c in 0..15)(if c in {3,14} then lSB_int[r,c] > 1 else lSB_int[r,c] = 0 endif);
constraint forall(r = 8, c in 0..15)(if c in {} then lSB_int[r,c] > 1 else lSB_int[r,c] = 0 endif); % 0
constraint forall(r = 9, c in 0..15)(if c in {} then lSB_int[r,c] > 1 else lSB_int[r,c] = 0 endif); % 0
constraint forall(r = 10, c in 0..15)(if c in {} then lSB_int[r,c] > 1 else lSB_int[r,c] = 0 endif); % 0
% constraint forall(r = 11, c in 0..15)(if c in {} then lSB_int[r,c] > 1 else lSB_int[r,c] = 0 endif); % 0
% constraint forall(r = 12, c in 0..15)(if c in {0,5,15} then lSB_int[r,c] > 1 else lSB_int[r,c] = 0 endif);
constraint forall(r in {8,9,10}, c in 0..15)(lPrSB[r,c] = 0);

% MC
constraint forall(r = 6, c in 0..15)(if c in {0,1,3,8,9,10,11,12,13,14} then lMC_int[r,c] > 1 else lMC_int[r,c] = 0 endif);
constraint forall(r = 7, c in 0..15)(if c in {6,7} then lMC_int[r,c] > 1 else lMC_int[r,c] = 0 endif);
constraint forall(r = 8, c in 0..15)(if c in {} then lMC_int[r,c] > 1 else lMC_int[r,c] = 0 endif);
constraint forall(r = 9, c in 0..15)(if c in {} then lMC_int[r,c] > 1 else lMC_int[r,c] = 0 endif); % 0
constraint forall(r = 10, c in 0..15)(if c in {} then lMC_int[r,c] > 1 else lMC_int[r,c] = 0 endif); % 0
% constraint forall(r = 11, c in 0..15)(if c in {} then lMC_int[r,c] > 1 else lMC_int[r,c] = 0 endif); % 0
% constraint forall(r = 12, c in 0..15)(if c in {} then lMC_int[r,c] > 1 else lMC_int[r,c] = 0 endif);

constraint forall(r in 8..10, c in 0..15)(lSR_int[r,c] = 0);
% % ================================= LOWER (end) ===================================


% % ------------- Em ---------------
var int: PrEm_1;
var int: PrEm_2;

constraint PrEm_1 = BCT[uSB_int[6,12],lSR_int[6,12]] /\ PrEm_1 > 0;
constraint PrEm_2 = BCT[uSB_int[6,13],lSR_int[6,13]] /\ PrEm_2 > 0;

% % ------------- Em ---------------

% % ==================================== Overall Prob. (begin) =======================================

var int: PEb;
var int: PEu;
var int: PEl;
var int: PEf;
var int: Prob;

constraint PEb = 0 /\ PEf = 16;
constraint PEu = sum(r = 1, c in 0..15)(uPrSB[r,c]);
constraint PEl = lPrSB[6,8] + sum(r = 7, c in 0..15)(lPrSB[r,c]);

constraint Prob = PEb + PEu + PEl + PEf + PrEm_1 + PrEm_2;
solve minimize Prob;

constraint Prob <= 98;

% Prob <= 97 unsat
% % include "format.dzn";
