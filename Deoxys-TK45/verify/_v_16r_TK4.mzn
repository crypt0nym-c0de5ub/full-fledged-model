
% include "AES_DDT.dzn";
% include "AES_BCT.dzn";
include "GFmul.dzn";
include "GFadd.dzn";

array[0..15] of int: SRp = array1d(0..15, [0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11]);
array[0..15, 0..20] of int: hperm = array2d(0..15, 0..20, 
    [0,7,14,9,8,15,6,1,0,7,14,9,8,15,6,1,0,7,14,9,8,
     1,0,7,14,9,8,15,6,1,0,7,14,9,8,15,6,1,0,7,14,9,
     2,13,12,3,10,5,4,11,2,13,12,3,10,5,4,11,2,13,12,3,10,
     3,10,5,4,11,2,13,12,3,10,5,4,11,2,13,12,3,10,5,4,11,
     4,11,2,13,12,3,10,5,4,11,2,13,12,3,10,5,4,11,2,13,12,
     5,4,11,2,13,12,3,10,5,4,11,2,13,12,3,10,5,4,11,2,13,
     6,1,0,7,14,9,8,15,6,1,0,7,14,9,8,15,6,1,0,7,14,
     7,14,9,8,15,6,1,0,7,14,9,8,15,6,1,0,7,14,9,8,15,
     8,15,6,1,0,7,14,9,8,15,6,1,0,7,14,9,8,15,6,1,0,
     9,8,15,6,1,0,7,14,9,8,15,6,1,0,7,14,9,8,15,6,1,
     10,5,4,11,2,13,12,3,10,5,4,11,2,13,12,3,10,5,4,11,2,
     11,2,13,12,3,10,5,4,11,2,13,12,3,10,5,4,11,2,13,12,3,
     12,3,10,5,4,11,2,13,12,3,10,5,4,11,2,13,12,3,10,5,4,
     13,12,3,10,5,4,11,2,13,12,3,10,5,4,11,2,13,12,3,10,5,
     14,9,8,15,6,1,0,7,14,9,8,15,6,1,0,7,14,9,8,15,6,
     15,6,1,0,7,14,9,8,15,6,1,0,7,14,9,8,15,6,1,0,7]);
array[0..3, 0..17] of int: VM = array2d(0..3, 0..17, 
    [1,  1,  1,  1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,  1,   1,   1,
     1,  2,  4,  8,  16,  32,  64, 128,  27,  54, 108, 216, 171,  77, 154, 47,  94, 188,
     1,  4, 16, 64,  27, 108, 171, 154,  94,  99, 151, 106, 179, 250, 197, 57, 228, 189,
     1,  8, 64, 54, 171,  47,  99,  53, 179, 239,  57, 211, 194,  74, 102, 29, 232,   1]);
int: KSize = 4;
int: bR = 2;
int: uR = 4;
int: mR = 2;
int: lR = 4;
int: fR = 4;
int: rUpper = bR + uR + mR - 1;

% ================================= UPPER =====================================
% =========== Key schedule [begin] ==============
array[0..15] of var 0..255: utk01;
array[0..15] of var 0..255: utk02;
array[0..15] of var 0..255: utk03;
array[0..15] of var 0..255: utk04;

array[0..rUpper, 0..15] of var 0..255: utk1;
array[0..rUpper, 0..15] of var 0..255: utk2; 
array[0..rUpper, 0..15] of var 0..255: utk3;
array[0..rUpper, 0..15] of var 0..255: utk4;
array[0..rUpper, 0..15] of var 0..255: uSTK;

constraint forall(r in 0..rUpper, c in 0..15)(
    let {
        int: pos = hperm[c, r],
        var 0..255: k1_val = utk01[c],
        var 0..255: k2_val = GFmul[utk02[c], VM[1, r]],
        var 0..255: k3_val = GFmul[utk03[c], VM[2, r]],
        var 0..255: k4_val = GFmul[utk04[c], VM[3, r]],
        
        var 0..255: sum12 = GFadd[k1_val, k2_val],
        var 0..255: sum34 = GFadd[k3_val, k4_val]
    } in (
        utk1[r, pos] = k1_val /\
        utk2[r, pos] = k2_val /\
        utk3[r, pos] = k3_val /\
        utk4[r, pos] = k4_val /\
        uSTK[r, pos] = GFadd[sum12, sum34]
    )
);

% Pattern for Subtweakey
constraint forall(r = 0, c in 0..15)(if c in {1,3,5,10} then uSTK[r,c] >= 1 else uSTK[r,c] = 0 endif);
constraint forall(r = 1, c in 0..15)(if c in {0,4,5,10} then uSTK[r,c] >= 1 else uSTK[r,c] = 0 endif);
constraint forall(r = 2, c in 0..15)(if c in {4,5,7} then uSTK[r,c] >= 1 else uSTK[r,c] = 0 endif);
constraint forall(r in {3,4}, c in 0..15)(uSTK[r,c] = 0);
constraint forall(r = 5, c in 0..15)(if c in {12} then uSTK[r,c] >= 1 else uSTK[r,c] = 0 endif);
constraint forall(r = 6, c in 0..15)(if c in {3,12,13,15} then uSTK[r,c] >= 1 else uSTK[r,c] = 0 endif);
constraint forall(r = 7, c in 0..15)(if c in {3,6,10,12} then uSTK[r,c] >= 1 else uSTK[r,c] = 0 endif);
% =========== Key schedule [end] ==============

% constraint 
%   forall(c in {1,3,5,10})(utk1[0,c] = 1 /\ utk2[0,c] = 44 /\ utk3[0,c] = 69 /\ utk4[0,c] = 103) /\ 
%   forall(c in {0,2,4,6,7,8,9,11,12,13,14,15})(utk1[0,c] = 0 /\ utk2[0,c] = 0 /\ utk3[0,c] = 0 /\ utk4[0,c] = 0)
% ;

int: fx1;
int: fx2;
constraint 
  forall(c in {1,3,5,10})(utk1[0,c] = fx1)
  /\
  forall(c in {1,3,5,10})(utk2[0,c] = fx2)
  /\ 
  forall(c in {0,2,4,6,7,8,9,11,12,13,14,15})(utk1[0,c] = 0 /\ utk2[0,c] = 0 /\ utk3[0,c] = 0 /\ utk4[0,c] = 0)
;

% NOTE:
% Since PrEb = 1 and PrEu = 1, 
% we need not to model the differential propagation in the upper trail,

% % ======== Diff. Propagation [begin] =======
% array[bR..bR+uR+mR-1, 0..15] of var 0..255: uAK; % before AK
% array[bR..bR+uR+mR-1, 0..15] of var 0..255: uSB; % before SB
% array[bR..bR+uR-1, 0..15] of var 0..255: uSR; % before SR
% array[bR..bR+uR-1, 0..15] of var 0..255: uMC; % before MC
% array[bR..bR+uR-1, 0..15] of var 0..255: uPrSB; % prob. of SB


% % --- operation AK ---
% constraint forall(r in bR..bR+uR+mR-1, c in 0..15, i in 0..7)(
%   uSB[r,c] = GFadd[uAK[r,c], uSTK[r,c]]
% );

% % --- operation SB ---
% constraint forall(r in bR..bR+uR-1, c in 0..15)(
%   if uSB[r,c] > 0
%   then (uPrSB[r,c] = DDT[uSB[r,c], uSR[r,c]]) /\ uPrSB[r,c] > 0 /\ uSR[r,c] > 0
%   else uSR[r,c] = 0 /\ uPrSB[r,c] = 0
%   endif
% );

% % --- operation SR ---
% constraint forall(r in bR..bR+uR-1, c in 0..15)(
%   forall(i in 0..7)(uMC[r,c] = uSR[r,SRp[c]]) /\
%   uMC[r,c] = uSR[r,SRp[c]]
% );

% % --- operation MC ---
% constraint forall(r in 0..bR+uR-1, col in [0,4,8,12])(
%   _MC(array1d(0..3, [uMC_int[r,c] | c in col..col+3]), 
%       array2d(0..3, 0..7, [uMC[r,c,i] | c in col..col+3, i in 0..7]),
%       array2d(0..3, 0..7, [uAK[r+1,c,i] | c in col..col+3, i in 0..7])
%      )
% );
% ======== Diff. Propagation [end] =======










% % ================================= LOWER (begin) ===================================
% array[0..15] of var 0..255: ltk01;
% array[0..15] of var 0..255: ltk02;
% array[0..15] of var 0..255: ltk03;
% array[0..15] of var 0..255: ltk04;

% array[bR+uR..bR+uR+mR+lR+fR, 0..15] of var 0..255: ltk1;
% array[bR+uR..bR+uR+mR+lR+fR, 0..15] of var 0..255: ltk2; 
% array[bR+uR..bR+uR+mR+lR+fR, 0..15] of var 0..255: ltk3;
% array[bR+uR..bR+uR+mR+lR+fR, 0..15] of var 0..255: ltk4;

% array[bR+uR..bR+uR+mR+lR+fR, 0..15] of var 0..255: lSTK;

% % =========== Key schedule [begin] ==============
% % tk_i = VM^T * tk (and permutation)

% constraint forall(r in bR+uR..bR+uR+mR+lR+fR, c in 0..15)(ltk1[r,hperm[c,r]] = ltk01[c]);
% constraint forall(r in bR+uR..bR+uR+mR+lR+fR, c in 0..15)(ltk2[r,hperm[c,r]] = GFmul[ltk02[c], VM[1,r]]);
% constraint forall(r in bR+uR..bR+uR+mR+lR+fR, c in 0..15)(ltk3[r,hperm[c,r]] = GFmul[ltk03[c], VM[2,r]]);
% constraint forall(r in bR+uR..bR+uR+mR+lR+fR, c in 0..15)(ltk4[r,hperm[c,r]] = GFmul[ltk04[c], VM[3,r]]);

% % % Get STK
% constraint forall(r in bR+uR..bR+uR+mR+lR+fR, c in 0..15)(lSTK[r,c] = GFadd[GFadd[ltk1[r,c], ltk2[r,c]], GFadd[ltk3[r,c], ltk4[r,c]]]);
% % =========== Key schedule [end] ==============

% constraint 
%   forall(c in 0..15)(if c in {2,3,12,14} then ltk01[c] >= 1 /\ ltk02[c] >= 1 /\ ltk03[c] >= 1 /\ ltk04[c] >= 1 else ltk01[c] = 0 /\ ltk02[c] = 0 /\ ltk03[c] = 0 /\ ltk04[c] = 0 endif) /\
%   forall(c in {0,2,4,13})(ltk1[6,c] = 1 /\ ltk2[6,c] = 24 /\ ltk3[6,c] = 82 /\ ltk4[6,c] = 85) /\ 
%   forall(c in {1,3,5,6,7,8,9,10,11,12,14,15})(ltk1[6,c] = 0 /\ ltk2[6,c] = 0 /\ ltk3[6,c] = 0 /\ ltk4[6,c] = 0) /\
  
%   forall(c in {7,11,12,13})(ltk1[7,c] = 1 /\ ltk2[7,c] = 48 /\ ltk3[7,c] = 83 /\ ltk4[7,c] = 158) /\ 
%   forall(c in {0,1,2,3,4,5,6,8,9,10,14,15})(ltk1[7,c] = 0 /\ ltk2[7,c] = 0 /\ ltk3[7,c] = 0 /\ ltk4[7,c] = 0);


% predicate _MC(var int: x1, var int: x2, var int: x3, var int: x4,
%               var int: y1, var int: y2, var int: y3, var int: y4) = 

%   y1 = GFadd[GFadd[GFmul[x1,2],GFmul[x2,3]], GFadd[x3,x4]] /\
%   y2 = GFadd[GFadd[x1,GFmul[x2,2]], GFadd[GFmul[x3,3],x4]] /\
%   y3 = GFadd[GFadd[x1,x2], GFadd[GFmul[x3,2],GFmul[x4,3]]] /\
%   y4 = GFadd[GFadd[GFmul[x1,3],x2], GFadd[x3,GFmul[x4,2]]]
% ;


