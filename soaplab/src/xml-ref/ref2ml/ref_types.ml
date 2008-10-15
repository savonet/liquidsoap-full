type xml_element = { tag: string ; var_name: string ; var_type: string ; default: string option }
type xml_child = ( xml_element * bool )
type xml_class_content = XML_Element of xml_element | XML_Child of xml_child
type xml_class = { name: string ; xmlns: string ; contents: xml_class_content list }
type xml_model = xml_class list

let classes = ref []
let add_class (name:string) (content:xml_class) =
  classes := !classes@[(name, content)]
let find_class name =
  List.assoc name !classes
