#!/bin/bash

# Get the command line arguments
OPTNUM=0
CLASSNAME=""
XMLNS=""
HEADER="yes"
while getopts "c:x:h" option
do
  case $option in
    c)
      CLASSNAME=$OPTARG
      let OPTNUM+=2
      ;;
    x)
      XMLNS=$OPTARG
      let OPTNUM+=2
      ;;
    h)
      HEADER="no"
      let OPTNUM+=1
      ;;
  esac
done
shift $OPTNUM

# Check that the cli args were given.
if [ -z "${CLASSNAME}" ]
then
  echo "Missing argument -c <classname>."
  exit 1
fi
if [ -z "${XMLNS}" ]
then
  echo "Missing argument -x <xmlns>."
  exit 1
fi

# Create temporary files
TEMP_M=`mktemp`
TEMP_P=`mktemp`
rm $TEMP_M $TEMP_P

# Header
if [ "$HEADER" == "yes" ]
then
  echo "open Dom_helper"
  echo ""
fi

# Beginning of source code
cat <<EOF
exception Not_${CLASSNAME}
let ${CLASSNAME}_ns = "${XMLNS}"

EOF

# Start of class definition
cat <<EOF
class ${CLASSNAME} =
  object (self)
EOF

# Output the vals and store the methods
while [ "$1" != "+" -a -n "$1" ]
do
  if [ "${1:0:1}" == "@" ] # List var
  then
    v=${1:1}
    s=$(expr "${v}" : "\([^:]*\):")
    t=$(expr "${v}" : ".*:\([^:]*\)")
    echo -e "    val mutable $s : $t list = []"
    echo -e "    method $s = $s\n    method add_$s ${s:0:1} = $s <- $s@[${s:0:1}]" >> ${TEMP_M}
    echo -e "                | \"$s\" -> c#add_${s} (${t}_from_xml e)" >> ${TEMP_P}
  elif [ "${1:0:1}" == "#" ] # Numerical var
  then
    if [ "${1:1:1}" == "." ] # Float var
    then
      s=${1:2}
      d="0."
      f="float_of_string"
    else # Int var
      s=${1:1}
      d="0"
      f="int_of_string"
    fi
    
    echo -e "    val mutable $s = "${d}
    echo -e "    method $s = $s\n    method set_$s ${s:0:1} = $s <- ${s:0:1}" >> ${TEMP_M}
    echo -e "                | \"$s\" -> c#set_${s} (${f} (get_element_contents e))" >> ${TEMP_P}
  else # string var
    s=$1
    echo -e "    val mutable $s = \"\""
    echo -e "    method $s = $s\n    method set_$s ${s:0:1} = $s <- ${s:0:1}" >> ${TEMP_M}
    echo -e "                | \"$s\" -> c#set_${s} (get_element_contents e)" >> ${TEMP_P}
  fi
  
  shift 1
done

# Display the methods, trash the temp file
echo ""
cat ${TEMP_M}
rm ${TEMP_M}

# Close the class
echo "  end"

# Now the parser method
cat <<EOF
let ${CLASSNAME}_from_xml root =
  (match root#get_namespaceURI with
    | Some s -> if (s#to_string <> ${CLASSNAME}_ns) then raise Not_${CLASSNAME}
    | None -> raise Not_${CLASSNAME} ) ;
  let c = new ${CLASSNAME} in
    (* Children *)
    let children = domiterator_to_element_list root#get_childNodes in
      List.iter (fun (_,e) ->
        match e#get_localName with
          | Some s ->
              (match s#to_string with
EOF
cat ${TEMP_P}
rm ${TEMP_P}
cat <<EOF
                | _ -> () (* be extensible, and ignore any unknown element *)
              )
          | None -> assert false (* impossible *)
        ) children ;
        c

EOF
