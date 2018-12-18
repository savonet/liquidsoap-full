# Authentication for live 1:
auth1 = harbor_auth(9000)
live1 = input.harbor(port=9000,auth=auth1,"/")

# Authentication for live 2:
auth2 = harbor_auth(7000)
live2 = input.harbor(port=7000,auth=auth2,"/")
