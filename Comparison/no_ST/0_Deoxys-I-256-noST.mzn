include "table.mzn";
include "x_predicates.dzn";

int: SpecDeoxys = 3;
int: block_size = 128;
int: key_size = block_size * SpecDeoxys;

int: Rb = 2;
int: Ru = 4;
int: Rm = 2;
int: Rl = 3;
int: Rf = 3;

array[0..15] of var 0..15: SRp = array1d(0..15, [0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11]);
array[0..15, 0..15] of int: hTable = array2d(0..15, 0..15, [0,7,14,9,8,15,6,1,0,7,14,9,8,15,6,1,
                                                            1,0,7,14,9,8,15,6,1,0,7,14,9,8,15,6,
                                                            2,13,12,3,10,5,4,11,2,13,12,3,10,5,4,11,
                                                            3,10,5,4,11,2,13,12,3,10,5,4,11,2,13,12,
                                                            4,11,2,13,12,3,10,5,4,11,2,13,12,3,10,5,
                                                            5,4,11,2,13,12,3,10,5,4,11,2,13,12,3,10,
                                                            6,1,0,7,14,9,8,15,6,1,0,7,14,9,8,15,
                                                            7,14,9,8,15,6,1,0,7,14,9,8,15,6,1,0,
                                                            8,15,6,1,0,7,14,9,8,15,6,1,0,7,14,9,
                                                            9,8,15,6,1,0,7,14,9,8,15,6,1,0,7,14,
                                                            10,5,4,11,2,13,12,3,10,5,4,11,2,13,12,3,
                                                            11,2,13,12,3,10,5,4,11,2,13,12,3,10,5,4,
                                                            12,3,10,5,4,11,2,13,12,3,10,5,4,11,2,13,
                                                            13,12,3,10,5,4,11,2,13,12,3,10,5,4,11,2,
                                                            14,9,8,15,6,1,0,7,14,9,8,15,6,1,0,7,
                                                            15,6,1,0,7,14,9,8,15,6,1,0,7,14,9,8]);
                                                            
constraint assert((Rb >= 1) /\ (Ru >=1) /\ (Rm >=1) /\ (Rl >=1) /\ (Rf >= 1), "Rounds out of bounds");

% =============
%   VARIABLES
% =============

% %============== Differential [begin] ================
array[0..Rb+Ru+Rm, 0..15] of var 0..1: uXAK;
array[0..Rb+Ru+Rm, 0..15] of var 0..1: uYAK;
array[0..Rb+Ru+Rm+1, 0..15] of var 0..1: uSTK;
array[0..Rb+Ru+Rm-1, 0..15] of var 0..1: uXSB;
array[0..Rb+Ru+Rm-1, 0..15] of var 0..1: uYSB;
array[0..Rb+Ru+Rm-1, 0..15] of var 0..1: uXSR;
array[0..Rb+Ru+Rm-1, 0..15] of var 0..1: uYSR;
array[0..Rb+Ru+Rm-1, 0..15] of var 0..1: uCAN;
array[0..Rb+Ru+Rm-1, 0..3] of var 0..1: uAC;
array[0..Rb+Ru+Rm-1, 0..3] of var 0..1: uTC;

% Key Schedule Auxiliary
array[0..15] of var 0..1: uLANE;
array[0..Rb+Ru, 0..3] of var 0..4: uPasDeg;
array[0..Rb+Ru, 0..3] of var 0..4: uCanDeg;
% --------------------------------------------


% ---------------------------------------------------------
% Lower Differential
array[Rb+Ru..Rb+Ru+Rm+Rl+Rf, 0..15] of var 0..1: lXAK;
array[Rb+Ru..Rb+Ru+Rm+Rl+Rf, 0..15] of var 0..1: lYAK;
array[Rb+Ru..Rb+Ru+Rm+Rl+Rf, 0..15] of var 0..1: lSTK;
array[Rb+Ru..Rb+Ru+Rm+Rl+Rf, 0..15] of var 0..1: lXSB;
array[Rb+Ru..Rb+Ru+Rm+Rl+Rf, 0..15] of var 0..1: lYSB;
array[Rb+Ru..Rb+Ru+Rm+Rl+Rf, 0..15] of var 0..1: lCAN;
array[Rb+Ru..Rb+Ru+Rm+Rl+Rf, 0..15] of var 0..1: lXSR;
array[Rb+Ru..Rb+Ru+Rm+Rl+Rf, 0..15] of var 0..1: lYSR;
array[Rb+Ru..Rb+Ru+Rm+Rl+Rf-1, 0..3] of var 0..1: lAC;
array[Rb+Ru..Rb+Ru+Rm+Rl+Rf-1, 0..3] of var 0..1: lTC;

% Key Schedule Auxiliary
array[0..15] of var 0..1: lLANE;
array[Rb+Ru+Rm-1..Rb+Ru+Rm+Rl-1, 0..3] of var 0..4: lPasDeg;
array[Rb+Ru+Rm-1..Rb+Ru+Rm+Rl-1, 0..3] of var 0..4: lCanDeg;

var int: VSTK_SUM;
% ---------------------------------------------------------

% ----------------------------------------------
% Affixation and Prob.
array[Rb+Ru..Rb+Ru+Rm-1, 0..15] of var 0..1: Ta;
array[Rb+Ru..Rb+Ru+Rm-1, 0..15] of var 0..1: Tb;
var int: PrEb;
var int: PrEu;
var int: PrEm;
var int: PrEl;
var int: PrEf;
var int: PrAtt = PrEb + PrEu + PrEm + PrEl + PrEf;
% constraint PrAtt <= 128;


% Upper Boundaries
array[0..Rb, 0..15] of var 0..1: uVAK;
array[0..Rb-1, 0..15] of var 0..1: uVSB;
array[0..Rb-1, 0..15] of var 0..1: uVSR;
array[0..Rb-1, 0..15] of var 0..1: uVSTK;
array[0..Rb-1, 0..15] of var 0..1: uBND;
array[0..Rb-1, 0..3] of var 0..1: uVC;

% Lower Boundaries
array[Rb+Ru+Rm+Rl+1..Rb+Ru+Rm+Rl+Rf, 0..15] of var 0..1: lVAK;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, 0..15] of var 0..1: lVSB;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, 0..15] of var 0..1: lVSR;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, 0..15] of var 0..1: lVMC;
array[Rb+Ru+Rm+Rl+1..Rb+Ru+Rm+Rl+Rf, 0..15] of var 0..1: lVSTK;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, 0..15] of var 0..1: lBND;
array[Rb+Ru+Rm+Rl-1..Rb+Ru+Rm+Rl+Rf-1, 0..3] of var 0..1: lVC;
% ------------------------------------------------------------

% Upper Determine
array[0..Rb, 0..15] of var 0..1: uDetAK;
array[0..Rb-1, 0..15] of var 0..1: uDetSB;
array[0..Rb-1, 0..15] of var 0..1: uDetSR;
array[0..Rb-1, 0..15] of var 0..1: uDetMC;
array[0..Rb-1, 0..15] of var 0..1: uGSTK;
array[0..Rb-1, 0..15] of var 0..1: uDiffDetMC;
array[0..Rb-1, 0..3] of var 0..1: uDiffDetC;
array[0..Rb-1, 0..3] of var 0..1: uDetC;
array[0..Rb-1, 0..15] of var 0..1: uFSB;
array[0..Rb-1, 0..15] of var 0..1: uFMC;

% Lower Determine
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, 0..15] of var 0..1: lDetAK;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, 0..15] of var 0..1: lDetSB;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, 0..15] of var 0..1: lDetSR;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-2, 0..15] of var 0..1: lDetMC;
array[Rb+Ru+Rm+Rl+1..Rb+Ru+Rm+Rl+Rf, 0..15] of var 0..1: lGSTK;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-2, 0..15] of var 0..1: lDiffDetMC;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-2, 0..3] of var 0..1: lDiffDetC;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, 0..3] of var 0..1: lDetC;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, 0..15] of var 0..1: lFSB;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, 0..15] of var 0..1: lFMC;
% %============== Differential [end] ================


%============== On epsilon (State Test) [begin] ================
int: Step =  5;
array[0..Rb, 0..15] of var -1..Step: uSAK;
array[0..Rb-1, 0..15] of var -1..Step: uSSB;
array[0..Rb-1, 0..15] of var -1..Step: uSSR;
array[0..Rb-1, 0..15] of var -1..Step: uSMC;
array[0..Rb-1, 0..3] of var -1..Step: uSBigMC;
array[0..Rb-1, 0..15] of var -1..Step: uSGK;

% r in Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf = 11 .. 14
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, 0..15] of var -1..Step: lSSB;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, 0..15] of var -1..Step: lSSR;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-2, 0..15] of var -1..Step: lSMC;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-2, 0..3]  of var -1..Step: lSBigMC;
array[Rb+Ru+Rm+Rl+1..Rb+Ru+Rm+Rl+Rf, 0..15] of var -1..Step: lSGK;

% --- For State Test ---
array[0..Rb-1, 0..15] of var -1..Step: uST; % For State Test
array[0..Rb-1, -1..Step] of var 0..1: uFlagST;
array[0..Rb-1, 0..15] of var -1..Step: uEGK; % 'E' = Eliminate
array[0..Rb-1, 0..15] of var -1..Step: uESB;
array[0..Rb-1, 0..15] of var -1..Step: uEMC;

array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, 0..15] of var -1..Step: lST; % For State Test
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, -1..Step] of var 0..1: lFlagST;
array[Rb+Ru+Rm+Rl+1..Rb+Ru+Rm+Rl+Rf, 0..15] of var -1..Step: lEGK;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, 0..15] of var -1..Step: lESB;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-2, 0..15] of var -1..Step: lEMC;

array[1..Step] of var int: SFSB;
array[1..Step] of var int: SFMC;

array[0..Rb-1, 0..3] of var -1..Step: uSBigDiffMC;
array[Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-2, 0..3]  of var -1..Step: lSBigDiffMC;

array[1..Step] of var {1,2}: Fg_PQ;
array[1..Step] of var int: STTGK;  % count Key guess in each step
array[1..Step] of var int: SDeRM;  % count Data remain in each "gandf" step
array[1..Step] of var int: SMcSB;  % count Memory cost (SBox) in each "table" step
array[1..Step] of var int: SMvMC;  % count Memory cost (MC value) in each "table" step
array[1..Step] of var int: SMdMC;  % count Memory cost (MC diff.) in each "table" step
array[1..Step] of var int: SFrTT;  % count Filter obtain (total) in each step
array[1..Step] of var int: STeTT;  % count Time cost in each step
array[1..Step] of var int: SMeTT;  % count Memory cost (total) in each "table" step
var int: Mepsilon;  % count Memory cost (max) in each "table" step
var int: Tepsilon;  % count Time cost (total) in each step

%============== On epsilon (State Test) [end] ================


% ---------------------------------
% Part 1 (Differential Propagation)
include "1_differential.dzn";
% ---------------------------------
% --------------------------------
% Part 2 (Guess-and-Determine)
include "2_guess_and_determine.dzn";
% --------------------------------

% --------------------------------
% % Part 3 (epsilon G and F)
% include "3-1_epsilon_gandf-ST.dzn";
% include "3-1_format_out_gandfST.dzn";

% % Part 3 (epsilon table)
include "3-2_epsilon_table-ST.dzn";

% % % === when close epsilon calculation, open the next constraint ===
% constraint Tepsilon = 0;
% constraint Mepsilon = 0;


int: OpenST = 0; % 1 -> Trun on State Test;
constraint if OpenST = 0 
           then forall(r in 0..Rb-1, i in 0..15)(uST[r,i] = -1) /\ forall(r in Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, i in 0..15)(lST[r,i] = -1) /\ 
                forall(r in 0..Rb-1, i in 0..15)(uEGK[r,i] = -1) /\ 
                forall(r in 0..Rb-1, i in 0..15)(uESB[r,i] = -1) /\ 
                forall(r in 0..Rb-1, i in 0..15)(uEMC[r,i] = -1) /\
                forall(r in Rb+Ru+Rm+Rl+1..Rb+Ru+Rm+Rl+Rf, i in 0..15)(lEGK[r,i] = -1) /\ 
                forall(r in Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, i in 0..15)(lESB[r,i] = -1) /\ 
                forall(r in Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-2, i in 0..15)(lEMC[r,i] = -1)
           endif;

% --------------------------------

% ================================================================================================================================================
% Complexity Analysis
var int: rb   = sum(i in 0..15)(uYAK[0,i]);
var int: rf   = sum(i in 0..15)(lYSR[Rb+Ru+Rm+Rl+Rf-1,i]);
var int: rb_p = sum(r in 0..Rb-1, i in 0..15)(uFSB[r,i] + uFMC[r,i]);
var int: rf_p = sum(r in Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-1, i in 0..15)(lFSB[r,i]) + sum(r in Rb+Ru+Rm+Rl..Rb+Ru+Rm+Rl+Rf-2, i in 0..15)(lFMC[r,i]);
var int: mb  = sum(r in 0..Rb-1, i in 0..15)(uVSTK[r,i] == 1 /\ uEGK[r,i] == -1);
var int: mf  = sum(r in Rb+Ru+Rm+Rl+1..Rb+Ru+Rm+Rl+Rf, i in 0..15)(lVSTK[r,i] = 1 /\ lEGK[r,i] = -1);
var int: mb_p = sum(r in 0..Rb-1, i in 0..15)(uGSTK[r,i]);
var int: mf_p = sum(r in Rb+Ru+Rm+Rl+1..Rb+Ru+Rm+Rl+Rf, i in 0..15)(lGSTK[r,i]);

var int: DataC;
int: N = 128;
var int: T1;
var int: T2u;
var int: T2l;
var int: T2;
var int: T3;  
var int: TimeC;
var int: MemoryC;

var 0..1: chooseP;

constraint 2*DataC = N + 4 + PrAtt;

constraint MemoryC = max([DataC, min(T2u-(8*mb_p + 8*mf_p), T2l-(8*mb_p + 8*mf_p)), (mb+mf-mb_p-mf_p)*8, Mepsilon*8]);

constraint T1 = DataC + 8*mb_p + 8*mf_p;
constraint T2u = T1 + 8*rb - 8*rb_p + 1;
constraint T2l = T1 + 8*rf - 8*rf_p + DataC - N + 1;
constraint if(T2u <= T2l) then(T2 = T2u /\ chooseP = 1) else(T2 = T2l /\ chooseP = 0) endif;
constraint T3 = 8*mb_p + 8*mf_p + 2*DataC + 16*rb + 16*rf - 16*rb_p - 16*rf_p - 2*N + 8*Tepsilon;
constraint TimeC = max([T1, T2, T3]);



include "./format_out/1_format_out_diff.dzn";
include "./format_out/3-2_format_out_tableST.dzn";
include "./format_out/0_format_out_Main.dzn";

include "./format_out/drawlatex.dzn";

constraint sum(i in 0..15)(uLANE[i]) = 2;
constraint forall(r = 0, c in 0..15)(if c in {7,12} then uSTK[r,c] = 1 else uSTK[r,c] = 0 endif);
constraint sum(i in 0..15)(lLANE[i]) = 2;
constraint forall(r = 6, c in 0..15)(if c in {7,12} then lSTK[r,c] = 1 else lSTK[r,c] = 0 endif);
constraint mb_p = mb;

constraint PrAtt <= 132;
constraint DataC <= 124;
% solve minimize PrAtt + 5*VSTK_SUM;
solve minimize 9*TimeC + 5*MemoryC + 3*Mepsilon;

