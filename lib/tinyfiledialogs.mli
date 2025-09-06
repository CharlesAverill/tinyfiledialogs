(** OCaml bindings for [TinyFileDialogs] *)

(** {1 Dialog Types} *)

type dialog_type =
  | Ok
  | OkCancel
  | YesNo
  | YesNoCancel  (** Type of dialog for message boxes. *)

type default_button =
  | CancelNo
  | OkYes
  | No  (** The default selected button in a message box. *)

type icon_type =
  | Info
  | Warning
  | Error
  | Question  (** Icon type for message boxes and notifications. *)

(** {1 Dialog Functions} *)

val input_box :
  title:string -> message:string -> default_input:string -> string option
(** Display an input box dialog.
    Returns [Some input] if the user provides input, [None] if cancelled. *)

val message_box :
     title:string
  -> message:string
  -> dialog_type:dialog_type
  -> icon_type:icon_type
  -> default_button:default_button
  -> int
(** Display a message box.
    Returns 0, 1, or 2 depending on the button pressed:
    - 0: Cancel / No
    - 1: Ok / Yes
    - 2: No (only for YesNoCancel) *)

val save_file_dialog :
     title:string
  -> default_path:string
  -> filter_patterns:string list option
  -> filter_desc:string
  -> string option
(** Show a save file dialog.
    Returns [Some filename] if a file was selected, [None] if cancelled. *)

val open_file_dialog :
     title:string
  -> default_path:string
  -> filter_patterns:string list option
  -> filter_desc:string
  -> allow_multiple:bool
  -> string option
(** Show an open file dialog.
    If [allow_multiple] is true, multiple filenames are returned separated by '|' in the string. *)

val select_folder_dialog : title:string -> default_path:string -> string option
(** Show a folder selection dialog.
    Returns [Some folder_path] if a folder is selected, [None] if cancelled. *)

val color_chooser :
     title:string
  -> default_hex:string option
  -> default_rgb:int * int * int
  -> (string * int * int * int) option
(** Show a color chooser dialog.
    Returns [Some (hex, r, g, b)] if a color is chosen, [None] if cancelled.
    [default_hex] can override [default_rgb]. *)

(** {1 Notifications and Sound} *)

val beep : unit -> unit
(** Play a system beep sound. *)

val notify_popup : title:string -> message:string -> icon_type:icon_type -> unit
(** Display a system notification popup with the given [title], [message], and [icon_type]. *)

(** {1 Global Variables} *)

val tinyfd_verbose : int Ctypes_static.ptr
(** Verbose mode for TinyFileDialogs. 0 = off, 1 = on. *)

val tinyfd_silent : int Ctypes_static.ptr
(** Silent mode for TinyFileDialogs. 0 = show errors/warnings, 1 = hide them. *)

val tinyfd_allowCursesDialogs : int Ctypes_static.ptr
(** Enable curses dialogs on Unix. 0 = off, 1 = on. *)

val tinyfd_forceConsole : int Ctypes_static.ptr
(** Force console dialogs. 0 = off, 1 = on. *)

(** {1 Global Variable Accessors} *)

val get_tinyfd_verbose : unit -> int

val get_tinyfd_silent : unit -> int

val get_tinyfd_allowCursesDialogs : unit -> int

val get_tinyfd_forceConsole : unit -> int

val set_tinyfd_verbose : int -> unit

val set_tinyfd_silent : int -> unit

val set_tinyfd_allowCursesDialogs : int -> unit

val set_tinyfd_forceConsole : int -> unit
