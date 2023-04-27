from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
def stoken(surveyid,html_page,seconds):
    s=Serializer('*grsig@khgy',seconds)
    return s.dumps({'sid':surveyid,'html_page':html_page}).decode('utf-8')
