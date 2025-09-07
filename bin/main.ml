open Tinyfiledialogs
open Printf

let () =
  (* === Configure TinyFileDialogs globals === *)
  (* set_tinyfd_verbose 1 ;
  set_tinyfd_silent 0 ;
  set_tinyfd_allowCursesDialogs 0 ;
  set_tinyfd_forceConsole 0 ;
  printf
    "TinyFileDialogs globals set: verbose=%d, silent=%d, curses=%d, \
     force_console=%d\n"
    (get_tinyfd_verbose ()) (get_tinyfd_silent ())
    (get_tinyfd_allowCursesDialogs ())
    (get_tinyfd_forceConsole ()) ; *)
  (* === 1. Test input box === *)
  ( match
      input_box ~title:"Input Box" ~message:"Enter your name:" ~default_input:""
    with
  | None ->
      print_endline "Input box cancelled"
  | Some s ->
      printf "You entered: %s\n" s ) ;
  (* === 2. Test message box === *)
  let res =
    message_box ~title:"Message Box" ~message:"Do you like OCaml?"
      ~dialog_type:YesNo ~icon_type:Question ~default_button:OkYes
  in
  printf "Message box result: %d\n" res ;
  (* === 3. Test save file dialog === *)
  ( match
      save_file_dialog ~title:"Save File" ~default_path:"untitled.txt"
        ~filter_patterns:(Some ["*.txt"; "*.md"])
        ~filter_desc:"Text files"
    with
  | None ->
      print_endline "Save file cancelled"
  | Some f ->
      printf "Save file: %s\n" f ) ;
  (* === 4. Test open file dialog === *)
  ( match
      open_file_dialog ~title:"Open File" ~default_path:""
        ~filter_patterns:(Some ["*.txt"; "*.md"])
        ~filter_desc:"Text files" ~allow_multiple:false
    with
  | None ->
      print_endline "Open file cancelled"
  | Some f ->
      printf "Opened file: %s\n" f ) ;
  (* === 5. Test select folder dialog === *)
  ( match select_folder_dialog ~title:"Select Folder" ~default_path:"" with
  | None ->
      print_endline "Folder selection cancelled"
  | Some f ->
      printf "Selected folder: %s\n" f ) ;
  (* === 6. Test color chooser === *)
  ( match
      color_chooser ~title:"Choose a color" ~default_hex:(Some "#0080FF")
        ~default_rgb:(0, 0, 0)
    with
  | None ->
      print_endline "Color chooser cancelled"
  | Some (hex, r, g, b) ->
      printf "Color chosen: %s (RGB: %d,%d,%d)\n" hex r g b ) ;
  (* === 7. Test beep === *)
  print_endline "Beeping..." ;
  beep () ;
  (* === 8. Test notification popup === *)
  notify_popup ~title:"Hello" ~message:"This is a notification" ~icon_type:Info ;
  print_endline "Notification shown."
