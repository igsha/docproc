add_library(images OBJECT diagram.uml)
add_library(images2 OBJECT class.dot)
set_source_files_properties(diagram.uml PROPERTIES COMPILE_OPTIONS -SdefaultFontSize=20)
