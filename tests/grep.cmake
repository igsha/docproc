# Platform independent grep
file(STRINGS ${FILENAME} OUT REGEX ${REGEXSTR})

list(LENGTH OUT LEN)
if(LEN GREATER 0)
    if(NOT SILENT)
        foreach(LINE ${OUT})
            message(${LINE})
        endforeach()
    endif()
    return()
endif()

message(SEND_ERROR "Regex not found")
