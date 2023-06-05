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
    CONTENT=$(cat $FILE)
    echo $CONTENT
    EDITING=1
    CURSORLOC=${#CONTENT}

    while [ $EDITING != 0 ]; 
    do 
        CONTENT="${CONTENT:0:$CURSORLOC}""${CONTENT:$CURSORLOC+1}"
        LENGTH=${#CONTENT}
        read -s -n 1 key
        read -s -n 4 arw
        
        if [ "$key" = "0" ]; 
        then 
            EDITING=0 
        fi

        if [ "$key" = "-" ]; 
        then
            if [ $CURSORLOC -gt 0 ]; 
            then
                let "CURSORLOC=CURSORLOC-1"
            fi
        fi 

        if [ "$key" = "=" ];
        then
            if [ $CURSORLOC -lt $LENGTH ];
            then
                let "CURSORLOC=CURSORLOC+1"
            fi
        fi

        if [ "$key" = "9" ];
        then
            if [ $CURSORLOC -gt 0 ];
            then
                CONTENT="${CONTENT:0:$CURSORLOC-1}""${CONTENT:$CURSORLOC}"
                let "CURSORLOC=CURSORLOC-1"
            fi
        fi

        if [ "$key" = "8" ];
        then
            CONTENT="${CONTENT:0:$CURSORLOC} ${CONTENT:$CURSORLOC}"
        fi

        if [ "$key" != "0" ] && [ "$key" != "-" ] && [ "$key" != "=" ] && [ "$key" != "9" ] && [ "$key" != "8" ];
        then 
            CONTENT="${CONTENT:0:$CURSORLOC}""$key""${CONTENT:$CURSORLOC}"
            let "CURSORLOC=CURSORLOC+1"
        fi
        clear
        CONTENT="${CONTENT:0:$CURSORLOC}""▮""${CONTENT:$CURSORLOC}"
        echo $CONTENT

    done
    printf "\n\n\n\n"
    printf "save modified file? (y/n) "
    read YN
    if [ "$YN" = "n" ];
    then 
        echo "not saving file, exiting program."
        exit 6
    fi
    rm $FILE
    touch $FILE
    CONTENT="${CONTENT:0:$CURSORLOC}""${CONTENT:$CURSORLOC+1}"
    echo $CONTENT >> $FILE
}

echo "Would you like to edit (e), create (c), or delete (d) a file?"
read INPUT 
start
