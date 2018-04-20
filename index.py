import sys
import RulesFactory
def get_stdin():
    buf = ""
    for line in sys.stdin:
        buf = buf + line
    return buf

if(__name__ == "__main__"):
    st = get_stdin()
    #st ='!!!'
    #ret = RulesFactory.invoke('')
    print("################### Welcome to BRM engine ###################### ")
    print ( "Request:", st  )
    ret = RulesFactory.invoke(st)
    #ret = 'Cool!!'
    print(ret)
