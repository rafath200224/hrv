from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
def token(fid,seconds):
    s=Serializer("*grsig@khgy",seconds)
    return s.dumps({'user':fid}).decode('utf-8')
