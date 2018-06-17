# Supported commands

`docproc` uses pandoc json format to store object files.
It has libraries and document.
Moast of usefull commands are listed in @tbl:commands.

|Command|Description|
|:------|:----------|
|`add_library`|Adds so-called library of jsons|
|`add_document`|Adds complete document (the first argument is a format and extension)|
|`target_compile_options`|The way to pass arguments to pandoc: variables, filters, etc.|
|`target_link_libraries`|Link libraries to main document|

:   List of useful commands {#tbl:commands}
