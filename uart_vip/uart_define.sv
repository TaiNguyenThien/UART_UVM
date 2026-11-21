//=============================================================================
// Project       : AHB VIP
//=============================================================================
// Filename      : ahb_define.sv
// Author        : Huy Nguyen
// Email         : ?
// Date          : 19-Oct-2024
//=============================================================================
// Description   : Define can override by environment
//
//
//
//=============================================================================
`ifndef GUARD_AHB_DEFINE__SV
`define GUARD_AHB_DEFINE__SV

  `ifndef FORK_GUARD_BEGIN
    `define FORK_GUARD_BEGIN fork begin
  `endif

  `ifndef FORK_GUARD_END
    `define FORK_GUARD_END   fork end
  `endif

`endif


