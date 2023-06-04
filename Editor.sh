#!/bin/bash

function start {
    VALIDINPUT=0
    # if input is equal to e, edit file
    if [ "$INPUT" = 'e' ]; then 
            VALIDINPUT=1
            clear
            editFile
    fi
    # if input is equal to c, create file
    if [ "$INPUT" = 'c' ]; then 
        VALIDINPUT=1
        clear
        createFile
    fi
    if [ "$INPUT" = 'd' ]; then 
        VALIDINPUT=1
        clear
        deleteFile
    fi
    # if input is invalid, exit program
    if [ "$VALIDINPUT" != 1 ]; then
        returnInvalid
    fi 
}
function returnInvalid {
    echo "invalid argument, please run command again with valid argument."
    echo "acceptable arguments: \"e\", \"c\", \"d\""
    echo "provided argument: \""$INPUT"\""
    exit 1
}
function editFile {
    echo "EDITING FILE";echo "";echo ""
    printf "file path: "
    read FILE
    echo "searching for file \""$FILE"\" ..."
    if test -f "$FILE"; 
    then
        clear
        echo "file \""$FILE"\" found."
        edit
    else 
        echo "file \""$FILE"\" not found, please run again with valid file."
        exit 2
    fi

}
function createFile {
    echo "CREATING FILE";echo "";echo ""
    printf "filename: "
    read FILE
    echo "creating file \""$FILE"\" ..."
    if test -f "$FILE"; 
    then
        echo "file \""$FILE"\" already exists, please run again with unique file name."
        exit 3
    else 
        clear
        touch $FILE
        echo "file \""$FILE"\" created."
        edit
    fi
}
function  deleteFile {
    echo "DELETING FILE";echo"";echo"";
    printf "filename: "
    read FILE

    if test -f "$FILE"; 
    then
        echo "file \""$FILE"\" found, are you sure you want to delete it? (y/n)"
        read YESNO
        if [ "$YESNO" = 'y' ]; 
        then
            rm $FILE
            echo "deleted file \""$FILE"\"."
        fi
        if [ "$YESNO" = 'n' ];
        then    
            echo "no longer deleting file \""$FILE"\"."
            exit 5
        fi
        if [ "$YESNO" != 'y' ] && [ "$YESNO" != 'n' ]; 
        then 
            echo "invalid argument, please run command again with valid argument."
            echo "acceptable arguments: \"y\", \"n\""
            echo "provided argument: \""$YESNO"\""
        fi
    else 
        echo "file \""$FILE"\" not found, please run again with valid file."
        exit 2
    fi
}
function edit {
    echo "editing file \""$FILE"\"."
    
}

echo "Would you like to edit (e), create (c), or delete (d) a file?"
read INPUT 
start
