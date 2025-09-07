(* function_description.ml *)

open Ctypes

(* The generated module from your type_description.ml *)
module Types = Types_generated

module Functions (F : Ctypes.FOREIGN) = struct
  open F

  (* strlen *)
  let strlen = foreign "strlen" (ptr char @-> returning size_t)

  (* tinyfd_inputBox *)
  let tinyfd_inputBox =
    foreign "tinyfd_inputBox"
      (string @-> string @-> string @-> returning (ptr_opt char))

  (* tinyfd_messageBox *)
  let tinyfd_messageBox =
    foreign "tinyfd_messageBox"
      (string @-> string @-> string @-> string @-> int @-> returning int)

  (* tinyfd_saveFileDialog *)
  let tinyfd_saveFileDialog =
    foreign "tinyfd_saveFileDialog"
      ( string @-> string @-> int
      @-> ptr (ptr char)
      @-> string
      @-> returning (ptr_opt char) )

  (* tinyfd_openFileDialog *)
  let tinyfd_openFileDialog =
    foreign "tinyfd_openFileDialog"
      ( string @-> string @-> int
      @-> ptr (ptr char)
      @-> string @-> int
      @-> returning (ptr_opt char) )

  (* tinyfd_selectFolderDialog *)
  let tinyfd_selectFolderDialog =
    foreign "tinyfd_selectFolderDialog"
      (string @-> string @-> returning (ptr_opt char))

  (* tinyfd_colorChooser *)
  let tinyfd_colorChooser =
    foreign "tinyfd_colorChooser"
      ( string @-> string @-> ptr uint8_t @-> ptr uint8_t
      @-> returning (ptr_opt char) )

  (* tinyfd_beep *)
  let tinyfd_beep = foreign "tinyfd_beep" (void @-> returning void)

  (* tinyfd_notifyPopup *)
  let tinyfd_notifyPopup =
    foreign "tinyfd_notifyPopup"
      (string @-> string @-> string @-> returning void)
end
