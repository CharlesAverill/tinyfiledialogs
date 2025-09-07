(lang dune 3.19)
(using ctypes 0.3)

(name tinyfiledialogs)

(generate_opam_files true)

(source
 (github CharlesAverill/tinyfiledialogs))

(authors "Charles Averill <charlesaverill20@gmail.com>")

(maintainers "Charles Averill <charlesaverill20@gmail.com>")
(maintenance_intent "(latest)")

(license MIT)

(documentation https://charlesaverill.github.io/tinyfiledialogs/tinyfiledialogs/)

(package
 (name tinyfiledialogs)
 (synopsis "OCaml bindings to tinyfiledialogs")
 (description "Simple, cross-platform file dialogs")
 (depends ocaml dune 
  (ctypes (>= 0.18.0))
  (ctypes-foreign (>= 0.18.0)))
 (tags
 ("GUI" "Dialogs" "File Dialog" "Color Picker" "Cross-Platform"
  "TinyFileDialogs" "Open File Dialog" "Save File Dialog"
  "Select Folder" "Message Box" "Input Box")))
