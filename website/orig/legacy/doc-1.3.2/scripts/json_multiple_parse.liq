# First parse key,value list:
hint = [("key","value")]
data = of_json(default=hint,payload)
print(data["uri"]) # "https://..."

# Then key -> (key,value) list
hint = [("list",[("key","value")])]
data = of_json(default=hint,payload)
m    = list.assoc(default=[],"metadata",data)
print(m["title"]) # "foo"
