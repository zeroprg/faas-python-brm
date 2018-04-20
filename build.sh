docker build -t zeroprg/python-brm .
# --no-cache .
docker service rm python-brm
faas-cli deploy --image=zeroprg/python-brm --name=python-brm  --fprocess "python3 index.py" 
#docker run zeroprg/python-brm
docker service logs -f python-brm
