(lang dune 3.19)

(name tinyfiledialogs)

(generate_opam_files true)

(source
 (github CharlesAverill/tinyfiledialogs))

(authors "Charles Averill <charlesaverill20@gmail.com>")

(maintainers "Charles Averill <charlesaverill20@gmail.com>")

(license MIT)

(documentation https://charlesaverill.github.io/tinyfiledialogs)

(package
 (name tinyfiledialogs)
 (synopsis "OCaml bindings to tinyfiledialogs")
 (description "Simple, cross-platform file dialogs")
 (depends ocaml dune ctypes)
 (tags
 ("GUI" "Dialogs" "File Dialog" "Color Picker" "Cross-Platform"
  "TinyFileDialogs" "Open File Dialog" "Save File Dialog"
  "Select Folder" "Message Box" "Input Box")))
