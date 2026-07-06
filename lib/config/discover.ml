module C = Configurator.V1

let preamble =
  {|#include "tinyfiledialogs/tinyfiledialogs.h"
#include <string.h>|}

let () =
  C.main ~name:"discover" (fun c ->
      let system =
        match C.ocaml_config_var c "system" with Some s -> s | None -> ""
      in
      let link_flags, preamble =
        match system with
        | "mingw64" ->
            (* In windows, add the appropriate header, and links with
             commdlg.

             https://learn.microsoft.com/en-us/windows/win32/api/commdlg/
          *)
            (["-lcomdlg32"], ["#include <windows.h>\n" ^ preamble])
        | _ ->
            ([], [preamble])
      in
      C.Flags.write_sexp "c_library_flags.sexp" link_flags ;
      C.Flags.write_lines "preamble.lines" preamble )
