#include "__cf_tev5sim.h"
#ifndef RTW_HEADER_tev5sim_acc_h_
#define RTW_HEADER_tev5sim_acc_h_
#ifndef tev5sim_acc_COMMON_INCLUDES_
#define tev5sim_acc_COMMON_INCLUDES_
#include <stdlib.h>
#include <stddef.h>
#define S_FUNCTION_NAME simulink_only_sfcn 
#define S_FUNCTION_LEVEL 2
#define RTW_GENERATED_S_FUNCTION
#include "rtwtypes.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "rt_defines.h"
#include "rt_nonfinite.h"
#endif
#include "tev5sim_acc_types.h"
typedef struct { real_T B_0_0_0 ; real_T B_0_1_0 ; real_T B_0_2_0 ; real_T
B_0_3_0 ; real_T B_0_4_0 ; real_T B_0_5_0 ; real_T B_0_6_0 ; real_T B_0_7_0 ;
real_T B_0_8_0 ; real_T B_0_9_0 ; real_T B_0_10_0 ; real_T B_0_11_0 ; real_T
B_0_12_0 ; real_T B_0_13_0 ; real_T B_0_14_0 ; real_T B_0_15_0 ; real_T
B_0_16_0 ; real_T B_0_17_0 ; real_T B_0_18_0 ; real_T B_0_19_0 ; real_T
B_0_20_0 ; real_T B_0_21_0 ; real_T B_0_22_0 ; real_T B_0_23_0 ; real_T
B_0_24_0 ; real_T B_0_25_0 ; real_T B_0_26_0 ; real_T B_0_27_0 ; real_T
B_0_28_0 ; real_T B_0_29_0 ; real_T B_0_30_0 ; real_T B_0_31_0 ; real_T
B_0_32_0 [ 32 ] ; real_T B_0_33_0 [ 41 ] ; } BlockIO_tev5sim ; typedef struct
{ void * ToWorkspace_PWORK ; struct { void * LoggedData ; }
XMEAS10PurgeRate_PWORK ; struct { void * LoggedData ; }
XMEAS11ProdSepTemp_PWORK ; struct { void * LoggedData ; }
XMEAS12ProdSepLevel_PWORK ; struct { void * LoggedData ; }
XMEAS18StripperTemp_PWORK ; struct { void * LoggedData ; } XMEAS6RxFeed_PWORK
; struct { void * LoggedData ; } XMEAS7RxPress_PWORK ; struct { void *
LoggedData ; } XMEAS8RxLevel_PWORK ; struct { void * LoggedData ; }
XMEAS9ReacTemp_PWORK ; } D_Work_tev5sim ; typedef struct { real_T
SFunction_CSTATE [ 50 ] ; } ContinuousStates_tev5sim ; typedef struct {
real_T SFunction_CSTATE [ 50 ] ; } StateDerivatives_tev5sim ; typedef struct
{ boolean_T SFunction_CSTATE [ 50 ] ; } StateDisabled_tev5sim ; struct
Parameters_tev5sim_ { real_T P_0 ; real_T P_1 ; real_T P_2 ; real_T P_3 ;
real_T P_4 ; real_T P_5 ; real_T P_6 ; real_T P_7 ; real_T P_8 ; real_T P_9 ;
real_T P_10 ; real_T P_11 ; real_T P_12 ; real_T P_13 ; real_T P_14 ; real_T
P_15 ; real_T P_16 ; real_T P_17 ; real_T P_18 ; real_T P_19 ; real_T P_20 ;
real_T P_21 ; real_T P_22 ; real_T P_23 ; real_T P_24 ; real_T P_25 ; real_T
P_26 ; real_T P_27 ; real_T P_28 ; real_T P_29 ; real_T P_30 ; real_T P_31 ;
} ; extern Parameters_tev5sim tev5sim_rtDefaultParameters ;
#endif
