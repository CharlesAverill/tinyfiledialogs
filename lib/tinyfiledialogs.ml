open Ctypes
open C.Functions

(* let lib =
  Dl.dlopen ~filename:"libtinyfiledialogs_stubs.so"
    ~flags:Dl.[RTLD_NOW; RTLD_GLOBAL] *)

let strlen (s : char Ctypes_static.ptr) =
  Unsigned.Size_t.to_int (strlen s)

let input_box ~(title : string) ~(message : string) ~(default_input : string) :
    string option =
  match tinyfd_inputBox title message default_input with
  | None ->
      None
  | Some ptr ->
      Some (string_from_ptr ptr ~length:(strlen ptr))

type dialog_type = Ok | OkCancel | YesNo | YesNoCancel

type default_button = CancelNo | OkYes | No

type icon_type = Info | Warning | Error | Question

let int_of_default_button = function CancelNo -> 0 | OkYes -> 1 | No -> 2

let string_of_dialog_type = function
  | Ok ->
      "ok"
  | OkCancel ->
      "okcancel"
  | YesNo ->
      "yesno"
  | YesNoCancel ->
      "yesnocancel"

let string_of_icon_type = function
  | Info ->
      "info"
  | Warning ->
      "warning"
  | Error ->
      "error"
  | Question ->
      "question"

let message_box ~(title : string) ~(message : string)
    ~(dialog_type : dialog_type) ~(icon_type : icon_type)
    ~(default_button : default_button) =
  tinyfd_messageBox title message
    (string_of_dialog_type dialog_type)
    (string_of_icon_type icon_type)
    (int_of_default_button default_button)

let string_list_to_c_ptr (list : string list) : char Ctypes_static.ptr ptr =
  let arr = Array.of_list list in
  let ptrs = Array.map CArray.of_string arr in
  (* each string -> CArray of char *)
  let c_ptrs = CArray.make (ptr char) (Array.length arr) in
  Array.iteri (fun i cstr -> CArray.set c_ptrs i (CArray.start cstr)) ptrs ;
  CArray.start c_ptrs

let save_file_dialog ~(title : string) ~(default_path : string)
    ~(filter_patterns : string list option) ~(filter_desc : string) =
  let num_filters, patterns_ptr =
    match filter_patterns with
    | None ->
        (0, from_voidp (ptr char) null)
    | Some lst ->
        let c_ptr = string_list_to_c_ptr lst in
        (List.length lst, c_ptr)
  in
  match
    tinyfd_saveFileDialog title default_path num_filters patterns_ptr
      filter_desc
  with
  | None ->
      None
  | Some ptr ->
      Some (string_from_ptr ptr ~length:(strlen ptr))

(* OCaml wrapper *)
let open_file_dialog ~(title : string) ~(default_path : string)
    ~(filter_patterns : string list option) ~(filter_desc : string)
    ~(allow_multiple : bool) : string option =
  let num_filters, patterns_ptr =
    match filter_patterns with
    | None ->
        (0, from_voidp (ptr char) null)
    | Some lst ->
        (List.length lst, string_list_to_c_ptr lst)
  in
  match
    tinyfd_openFileDialog title default_path num_filters patterns_ptr
      filter_desc
      ( if allow_multiple then
          1
        else
          0 )
  with
  | None ->
      None
  | Some ptr ->
      Some (string_from_ptr ptr ~length:(strlen ptr))

(* OCaml wrapper *)
let select_folder_dialog ~(title : string) ~(default_path : string) :
    string option =
  match tinyfd_selectFolderDialog title default_path with
  | None ->
      None
  | Some ptr ->
      Some (string_from_ptr ptr ~length:(strlen ptr))

let fst3 (x, _, _) = x

let snd3 (_, y, _) = y

let thd3 (_, _, z) = z

let color_chooser ~(title : string) ~(default_hex : string option)
    ~(default_rgb : int * int * int) : (string * int * int * int) option =
  (* default RGB array *)
  let default_rgb_arr =
    CArray.of_list uint8_t
      (List.map Unsigned.UInt8.of_int
         [fst3 default_rgb; snd3 default_rgb; thd3 default_rgb] )
  in
  (* result RGB array *)
  let result_rgb = CArray.make uint8_t 3 in
  (* Convert default_hex option to string ("" if None) *)
  let hex_str = match default_hex with None -> "" | Some s -> s in
  match
    tinyfd_colorChooser title hex_str
      (CArray.start default_rgb_arr)
      (CArray.start result_rgb)
  with
  | None ->
      None
  | Some ptr ->
      let hex = string_from_ptr ptr ~length:(strlen ptr) in
      let r = CArray.get result_rgb 0 in
      let g = CArray.get result_rgb 1 in
      let b = CArray.get result_rgb 2 in
      Some
        ( hex
        , Unsigned.UInt8.to_int r
        , Unsigned.UInt8.to_int g
        , Unsigned.UInt8.to_int b )

(* let tinyfd_verbose : int Ctypes_static.ptr = foreign_value "tinyfd_verbose" int

let tinyfd_silent : int Ctypes_static.ptr = foreign_value "tinyfd_silent" int

let tinyfd_allowCursesDialogs : int Ctypes_static.ptr =
  foreign_value "tinyfd_allowCursesDialogs" int

let tinyfd_forceConsole : int Ctypes_static.ptr =
  foreign_value "tinyfd_forceConsole" int

(* Getters *)
let get_tinyfd_verbose () : int = !@tinyfd_verbose

let get_tinyfd_silent () : int = !@tinyfd_silent

let get_tinyfd_allowCursesDialogs () : int = !@tinyfd_allowCursesDialogs

let get_tinyfd_forceConsole () : int = !@tinyfd_forceConsole

(* Setters *)
let set_tinyfd_verbose (v : int) : unit = tinyfd_verbose <-@ v

let set_tinyfd_silent (v : int) : unit = tinyfd_silent <-@ v

let set_tinyfd_allowCursesDialogs (v : int) : unit =
  tinyfd_allowCursesDialogs <-@ v

let set_tinyfd_forceConsole (v : int) : unit = tinyfd_forceConsole <-@ v *)

let notify_popup ~(title : string) ~(message : string) ~(icon_type : icon_type)
    : unit =
    tinyfd_notifyPopup title message (string_of_icon_type icon_type)

let beep = tinyfd_beep
