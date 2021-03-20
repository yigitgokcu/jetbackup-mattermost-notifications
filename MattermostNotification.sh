#!/bin/bash

MATTERMOST_WEBHOOK_URL=

sIFS=$IFS
declare -A param
while IFS='=' read -r -d '&' key value; do
        [[ -z "$key" ]] && continue;
        param["$key"]=$value
done <<<$(cat)"&"
IFS=$sIFS;

SECTIONS=""
JOB_NAME=${param[name]}
CURRENT_DATE="$(date)"
STATUS="" 
HOSTNAME="$(hostname)"

#Mattermost Section Template
SECTION_TPL='{
              "title": "$HOSTNAME", 
              "text": "__MESSAGE__"}';


addSection() {
    _MSG="$1"
    _S=""
    [[ "" != "$SECTIONS" ]] && _S=","    
    SECTIONS+=${_S}$( echo "$SECTION_TPL" | sed "s/__MESSAGE__/${_MSG}/" )    
}

setStatus(){
    case "${param[status]}" in      
        1)
        STATUS='Success'
        ;;          
        2)
        STATUS='Failed'
        ;;
        3)
        STATUS='Aborted'
        ;;  
        4)
        STATUS='Partially Completed'
        ;;
   esac  
}

case "${param[stage]}" in 
    "onBackupStart")
        addSection "Backup Job (${JOB_NAME}) Started at ${CURRENT_DATE}"
    ;;

    "onBackupEnd")
        setStatus
        addSection "Backup Job (${JOB_NAME}) Finished at ${CURRENT_DATE} - **Backup Status: ${STATUS}**"
    ;;
    *)
        exit
    ;;
esac

MATTERMOST_MSG='{"attachments": ['"${SECTIONS}"']}'

curl -X POST -H 'Content-type: application/json' --data "${MATTERMOST_MSG}" "${MATTERMOST_WEBHOOK_URL}"
