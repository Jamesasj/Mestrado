#include "__cf_tev5sim.h"
#include <math.h>
#include "tev5sim_acc.h"
#include "tev5sim_acc_private.h"
#include <stdio.h>
#include "simstruc.h"
#include "fixedpoint.h"
#define CodeFormat S-Function
#define AccDefine1 Accelerator_S-Function
static void mdlOutputs ( SimStruct * S , int_T tid ) { BlockIO_tev5sim * _rtB
; Parameters_tev5sim * _rtP ; D_Work_tev5sim * _rtDW ; _rtDW = ( (
D_Work_tev5sim * ) ssGetRootDWork ( S ) ) ; _rtP = ( ( Parameters_tev5sim * )
ssGetDefaultParam ( S ) ) ; _rtB = ( ( BlockIO_tev5sim * ) _ssGetBlockIO ( S
) ) ; if ( ssIsSampleHit ( S , 1 , 0 ) ) { _rtB -> B_0_0_0 = _rtP -> P_0 ;
_rtB -> B_0_1_0 = _rtP -> P_1 ; _rtB -> B_0_2_0 = _rtP -> P_2 ; _rtB ->
B_0_3_0 = _rtP -> P_3 ; _rtB -> B_0_4_0 = _rtP -> P_4 ; _rtB -> B_0_5_0 =
_rtP -> P_5 ; _rtB -> B_0_6_0 = _rtP -> P_6 ; _rtB -> B_0_7_0 = _rtP -> P_7 ;
_rtB -> B_0_8_0 = _rtP -> P_8 ; _rtB -> B_0_9_0 = _rtP -> P_9 ; _rtB ->
B_0_10_0 = _rtP -> P_10 ; _rtB -> B_0_11_0 = _rtP -> P_11 ; _rtB -> B_0_12_0
= _rtP -> P_12 ; _rtB -> B_0_13_0 = _rtP -> P_13 ; _rtB -> B_0_14_0 = _rtP ->
P_14 ; _rtB -> B_0_15_0 = _rtP -> P_15 ; _rtB -> B_0_16_0 = _rtP -> P_16 ;
_rtB -> B_0_17_0 = _rtP -> P_17 ; _rtB -> B_0_18_0 = _rtP -> P_18 ; _rtB ->
B_0_19_0 = _rtP -> P_19 ; _rtB -> B_0_20_0 = _rtP -> P_20 ; _rtB -> B_0_21_0
= _rtP -> P_21 ; _rtB -> B_0_22_0 = _rtP -> P_22 ; _rtB -> B_0_23_0 = _rtP ->
P_23 ; _rtB -> B_0_24_0 = _rtP -> P_24 ; _rtB -> B_0_25_0 = _rtP -> P_25 ;
_rtB -> B_0_26_0 = _rtP -> P_26 ; _rtB -> B_0_27_0 = _rtP -> P_27 ; _rtB ->
B_0_28_0 = _rtP -> P_28 ; _rtB -> B_0_29_0 = _rtP -> P_29 ; _rtB -> B_0_30_0
= _rtP -> P_30 ; _rtB -> B_0_31_0 = _rtP -> P_31 ; } _rtB -> B_0_32_0 [ 0 ] =
_rtB -> B_0_0_0 ; _rtB -> B_0_32_0 [ 1 ] = _rtB -> B_0_1_0 ; _rtB -> B_0_32_0
[ 2 ] = _rtB -> B_0_2_0 ; _rtB -> B_0_32_0 [ 3 ] = _rtB -> B_0_3_0 ; _rtB ->
B_0_32_0 [ 4 ] = _rtB -> B_0_4_0 ; _rtB -> B_0_32_0 [ 5 ] = _rtB -> B_0_5_0 ;
_rtB -> B_0_32_0 [ 6 ] = _rtB -> B_0_6_0 ; _rtB -> B_0_32_0 [ 7 ] = _rtB ->
B_0_7_0 ; _rtB -> B_0_32_0 [ 8 ] = _rtB -> B_0_8_0 ; _rtB -> B_0_32_0 [ 9 ] =
_rtB -> B_0_9_0 ; _rtB -> B_0_32_0 [ 10 ] = _rtB -> B_0_10_0 ; _rtB ->
B_0_32_0 [ 11 ] = _rtB -> B_0_11_0 ; _rtB -> B_0_32_0 [ 12 ] = _rtB ->
B_0_12_0 ; _rtB -> B_0_32_0 [ 13 ] = _rtB -> B_0_13_0 ; _rtB -> B_0_32_0 [ 14
] = _rtB -> B_0_14_0 ; _rtB -> B_0_32_0 [ 15 ] = _rtB -> B_0_15_0 ; _rtB ->
B_0_32_0 [ 16 ] = _rtB -> B_0_16_0 ; _rtB -> B_0_32_0 [ 17 ] = _rtB ->
B_0_17_0 ; _rtB -> B_0_32_0 [ 18 ] = _rtB -> B_0_18_0 ; _rtB -> B_0_32_0 [ 19
] = _rtB -> B_0_19_0 ; _rtB -> B_0_32_0 [ 20 ] = _rtB -> B_0_20_0 ; _rtB ->
B_0_32_0 [ 21 ] = _rtB -> B_0_21_0 ; _rtB -> B_0_32_0 [ 22 ] = _rtB ->
B_0_22_0 ; _rtB -> B_0_32_0 [ 23 ] = _rtB -> B_0_23_0 ; _rtB -> B_0_32_0 [ 24
] = _rtB -> B_0_24_0 ; _rtB -> B_0_32_0 [ 25 ] = _rtB -> B_0_25_0 ; _rtB ->
B_0_32_0 [ 26 ] = _rtB -> B_0_26_0 ; _rtB -> B_0_32_0 [ 27 ] = _rtB ->
B_0_27_0 ; _rtB -> B_0_32_0 [ 28 ] = _rtB -> B_0_28_0 ; _rtB -> B_0_32_0 [ 29
] = _rtB -> B_0_29_0 ; _rtB -> B_0_32_0 [ 30 ] = _rtB -> B_0_30_0 ; _rtB ->
B_0_32_0 [ 31 ] = _rtB -> B_0_31_0 ; ssCallAccelRunBlock ( S , 0 , 33 ,
SS_CALL_MDL_OUTPUTS ) ; if ( ssIsSampleHit ( S , 1 , 0 ) ) {
ssCallAccelRunBlock ( S , 0 , 34 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 0 , 35 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 0 , 36 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 0 , 37 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 0 , 38 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 0 , 39 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 0 , 40 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 0 , 41 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 0 , 42 , SS_CALL_MDL_OUTPUTS ) ; } UNUSED_PARAMETER
( tid ) ; }
#define MDL_UPDATE
static void mdlUpdate ( SimStruct * S , int_T tid ) { BlockIO_tev5sim * _rtB
; _rtB = ( ( BlockIO_tev5sim * ) _ssGetBlockIO ( S ) ) ; ssCallAccelRunBlock
( S , 0 , 33 , SS_CALL_MDL_UPDATE ) ; UNUSED_PARAMETER ( tid ) ; }
#define MDL_DERIVATIVES
static void mdlDerivatives ( SimStruct * S ) { BlockIO_tev5sim * _rtB ; _rtB
= ( ( BlockIO_tev5sim * ) _ssGetBlockIO ( S ) ) ; ssCallAccelRunBlock ( S , 0
, 33 , SS_CALL_MDL_DERIVATIVES ) ; } static void mdlInitializeSizes (
SimStruct * S ) { ssSetChecksumVal ( S , 0 , 490620025U ) ; ssSetChecksumVal
( S , 1 , 3969045009U ) ; ssSetChecksumVal ( S , 2 , 596973333U ) ;
ssSetChecksumVal ( S , 3 , 1052234346U ) ; { mxArray * slVerStructMat = NULL
; mxArray * slStrMat = mxCreateString ( "simulink" ) ; char slVerChar [ 10 ]
; int status = mexCallMATLAB ( 1 , & slVerStructMat , 1 , & slStrMat , "ver"
) ; if ( status == 0 ) { mxArray * slVerMat = mxGetField ( slVerStructMat , 0
, "Version" ) ; if ( slVerMat == NULL ) { status = 1 ; } else { status =
mxGetString ( slVerMat , slVerChar , 10 ) ; } } mxDestroyArray ( slStrMat ) ;
mxDestroyArray ( slVerStructMat ) ; if ( ( status == 1 ) || ( strcmp (
slVerChar , "7.9" ) != 0 ) ) { return ; } } ssSetOptions ( S ,
SS_OPTION_EXCEPTION_FREE_CODE ) ; if ( ssGetSizeofDWork ( S ) != sizeof (
D_Work_tev5sim ) ) { ssSetErrorStatus ( S ,
"Unexpected error: Internal DWork sizes do "
"not match for accelerator mex file." ) ; } if ( ssGetSizeofGlobalBlockIO ( S
) != sizeof ( BlockIO_tev5sim ) ) { ssSetErrorStatus ( S ,
"Unexpected error: Internal BlockIO sizes do "
"not match for accelerator mex file." ) ; } { int ssSizeofParams ;
ssGetSizeofParams ( S , & ssSizeofParams ) ; if ( ssSizeofParams != sizeof (
Parameters_tev5sim ) ) { static char msg [ 256 ] ; sprintf ( msg ,
"Unexpected error: Internal Parameters sizes do "
"not match for accelerator mex file." ) ; } } _ssSetDefaultParam ( S , (
real_T * ) & tev5sim_rtDefaultParameters ) ; rt_InitInfAndNaN ( sizeof (
real_T ) ) ; } static void mdlInitializeSampleTimes ( SimStruct * S ) { }
static void mdlTerminate ( SimStruct * S ) { }
#include "simulink.c"
