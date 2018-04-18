import sys
import RulesFactory
def get_stdin():
    buf = ""
    for line in sys.stdin:
         buf = buf + line

    return buf

if(__name__ == "__main__"):
    print("################### Welcome to BRM engine ###################### ")
    data =  sys.stdin.readlines()
    print ( "Request:", data  )
    # pass the first line only 
    print(RulesFactory.invoke(data[0]))
#   print(st)

