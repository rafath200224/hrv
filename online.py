from flask import Flask,request,redirect,render_template,url_for,flash,session,send_file,abort
from flask_mysqldb import MySQL
import flask_excel as excel
from flask_session import Session
from otp import genotp
import mysql.connector
from cmail import sendmail
import random
from surid import gensur
from surveydynamic import stoken
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from tokenreset import token
from io import BytesIO                      # files input &output package
app=Flask(__name__)
app.secret_key='*grsig@khgy'
app.config['SESSION_TYPE']='filesystem'
excel.init_excel(app)
Session(app)
mydb=mysql.connector.connect(host='localhost',user='root',password='admin',db='platform')
@app.route('/',methods=['GET','POST'])
def index():
    if request.method=="POST":
        print(request.form)
        name=request.form['name']
        emailid=request.form['email']
        message=request.form['message']
        cursor=mydb.cursor(buffered=True)
        cursor.execute('insert into contactus(name,email,text) values(%s,%s,%s)',[name,emailid,message])
        mydb.commit()
        flash('contactus details submitted')
        return render_template('index.html')

    return render_template('index.html')
@app.route('/registration',methods=['GET','POST'])
def register():
    if request.method=='POST':
        fid=request.form['faculty']
        name=request.form['name']
        gender=request.form['gender']
        emailid=request.form['email']
        password=request.form['password']
        
        
        cursor=mydb.cursor(buffered=True)
        cursor.execute('Select fid from faculty')
        data=cursor.fetchall()
        cursor.execute('SELECT emailid from faculty')
        edata=cursor.fetchall()
        if(fid,)in data:
            flash('User already already exists')
            return render_template('register.html')
        if(emailid,) in edata:
            flash('Email id already already exists')
            return render_template('register.html')
        cursor.close()
        otp=genotp()
        subject='Thanks for registering to the application'
        body=f'Use this otp to register {otp}'
        sendmail(emailid,body,subject)
        return render_template('otp.html',otp=otp,fid=fid,name=name,gender=gender,emailid=emailid,password=password)
    return render_template('register.html')
@app.route('/login',methods=['GET','POST'])
def login():
    if session.get('user'):
        return redirect(url_for('dashboard'))
    if request.method=='POST':
        fid=request.form['faculty']
        password=request.form['password']
        cursor=mydb.cursor(buffered=True)
        cursor.execute('select count(*) from faculty where fid=%s and password=%s',[fid,password])
        count=cursor.fetchone()  [0]
        if count==0:
            flash('Invalid fid or password')
            return render_template('login.html')
        else:
            session['user']=fid
            return redirect(url_for('dashboard'))
    return render_template('login.html')

@app.route('/logout')
def logout():
    if session.get('user'):
        session.pop('user')
        return redirect(url_for('index'))
    else:
        flash('already logged out!')
        return redirect(url_for('login'))
@app.route('/otp/<otp>/<fid>/<name>/<gender>/<emailid>/<password>',methods=['GET','POST'])
def otp(otp,fid,name,gender,emailid,password):
    if request.method=='POST':
        uotp=request.form['otp']
        if otp==uotp:
            lst=[fid,name,gender,emailid,password]
            query='insert into faculty values(%s,%s,%s,%s,%s)'
            cursor=mydb.cursor(buffered=True)
            cursor.execute(query,lst)
            mydb.commit()
            cursor.close()
            flash('Details registered')
            return redirect(url_for('login'))
        else:
            flash('Wrong otp')
            return render_template('otp.html',otp=otp,fid=fid,name=name,gender=gender,emailid=emailid,password=password)
@app.route('/forgetpassword',methods=['GET','POST'])
def forget():
    if request.method=='POST':
        fid=request.form['id']
        cursor=mydb.cursor(buffered=True)
        cursor.execute('select fid from faculty')
        data=cursor.fetchall()
        if  (fid,) in data:
            cursor.execute('select emailid from faculty where fid=%s',[fid])
            data=cursor.fetchone() [0]
            cursor.close()
            subject=f'Reset Password for {data}'
            body=f'Reset the password using-{request.host+url_for("createpassword",token=token(fid,240))}'
            sendmail(data,subject,body)
            flash('Reset link sent to your mail')
            return redirect(url_for('login'))
        else:
            return 'Invalid user id'
    return render_template('forgot.html')

@app.route('/createpassword/<token>',methods=['GET','POST'])
def createpassword(token):
    try:
        s=Serializer(app.config['SECRET_KEY'])
        fid=s.loads(token)['user']
        if request.method=='POST':
            npass=request.form['npassword']
            cpass=request.form['cpassword']
            if npass==cpass:
                cursor=mydb.cursor(buffered=True)
                cursor.execute('update faculty set password=%s where fid=%s',[npass,fid])
                mydb.commit()
                return 'Password reset Successfull'
            else:
                return 'Password mismatch'
        return render_template('newpassword.html')
    except Exception as e:
        print(e)
        return 'Link expired try again'
@app.route('/dashboard')
def dashboard():
    if session.get('user'):
        return render_template('dashboard.html')
    else:
        return redirect(url_for('index'))
@app.route('/createsurvey',methods=['GET','POST'])
def create():
    if session.get('user'):
        if request.method=='POST':
            surid=gensur()
            surname=request.form['form']
            duration=int(request.form['duration'])
            url=url_for("survey",token=stoken(surid,surname,duration),_external=True)
            cursor=mydb.cursor(buffered=True)
            cursor.execute('insert into surveymeta (surid,username,html,url) values(%s,%s,%s,%s)',(surid,session.get('user'),surname,url))
            mydb.commit()
            flash('Survey created successfully')
            return redirect(url_for('allsurveys'))
        return render_template('createsurvey.html')
    else:
        return redirect(url_for('index'))
@app.route('/preview/<file>')
def preview(file):
    if session.get('user'):
        return render_template(f'{file}.html')
    else:
        return redirect(url_for('index'))
@app.route('/allsurveys')
def allsurveys():
    if session.get('user'):
        cursor=mydb.cursor(buffered=True)
        cursor.execute('SELECT * FROM surveymeta where username=%s',[session.get('user')])
        data=cursor.fetchall()
        return render_template('allsurveys.html',surveys=data)
    else:
        return redirect(url_for('index'))
@app.route('/survey/<token>',methods=['GET','POST'])
def survey(token):
    try:
        s=Serializer(app.config['SECRET_KEY'])
        survey_dict=s.loads(token)
        sid=survey_dict['sid']
        html_page=survey_dict['html_page']
        if request.method=='POST':
            rollno=request.form['rollno']
            name=request.form['name']
            section=request.form['section']
            one=request.form['one']
            two=request.form['two']
            three=request.form['three']
            four=request.form['four']
            five=request.form['five']
            six=request.form['six']
            seven=request.form['seven']
            eight=request.form['eight']
            nine=request.form['nine']
            ten=request.form['ten']
            points=request.form['points']        
            cursor=mydb.cursor(buffered=True)
            cursor.execute('insert into surveys values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)',[sid,rollno,name,section,one,two,three,four,five,six,seven,eight,nine,ten,points])
            mydb.commit()
            return 'Survey submitted successfully'
        return render_template(f'{html_page}.html')
    except Exception as e:
        print(e)
        abort(410,description='SUrvey link expired')
@app.route('/download/<sid>/<ftype>')
def download(sid,ftype):
    cursor=mydb.cursor(buffered=True)
    
    lst1=['Roll no','Name','Section','1.How satisfied are you with the overall quality of the course?','2.Did the course meet your expectations?if not,please explain.','3.How engaged did you feel during the course?','4.Were the course materials(textbook,reading,videos, etc.)helping in your learning?','5.Was the work load of the course appropriate for the level and credit value of the course?','6.How effective were the instructors in delivering course content and providing feedback?','7.Were the course organized in a way that facilitated your learning?','8.How helpful was the course in preparing you for future courses or career opportunities?','9.What aspects of the course did you find most valuable?','10.What suggestions did you have for improving the course for the future.','overall satisfaction']
    list2=['Roll no','Name','Section','1.How satisfied are you with the overall quality of the workshop?','2.Did the workshop meet your expectations?','3.How engaged did you feel during the workshop?','4.Did the workshop cover enough content or was it too much/too little?','5.Was the workshop interactive enough?','6.Was the workshop well organized','7.Did the workshop meet your learning needs?','8.How helpful was the course in preparing you for future courses or career opportunities?','9.Did the workshop provide you with new skills or knowledge?','10.Is there anything else would you like to share about the workshop?','Overall satisfaction']
    list3=['Roll no','Name','Section','1.Was the library easily accessible for you?','2.How satisfied were you with the library hours of opearation?','3.Did the library have sufficient seating or workspace for you?','4.Did you find the library staff friendly and helpful?','5.Was the library collection diverse and inclusive ?','6.Was the library well organized',"7.Did you find the library's technology(e.g. computers,printers,scanners) easy to use?",'8.Was the library website user-friendly and informative?','9.Did you receive sufficient information on library policies and procedures?','10.Did you encounter any issues with borrowing library materials?if yes explain','Overall satisfaction']
    list4=['Roll no','Name','Section','1.How did you hear about our hostel?','2.How was your check-in experience?','3.Were the hostel mess services satisfactory and hygienic?','4.Was your room comfortable?','5.Was the staff friendly and helpful ?','6.Were the facilities well-maintained?','7.How was the overall atmosphere of the hostel?','8.Did you feel safe and secure during your stay?','9.Was the location of the hostel convenient for your needs?','10.Were there any issues with your booking or payment?if yes explain.','Overall Satisfaction' ]
    list5=['Roll no','Name','Section','1.Did the placement process match your skillset and area of interest?','2.How satisfied were you with the overall placement process?','3.How was the selection process conducted by the placement team?','4.Were you adequately informed about the placement process and the requirements?','5.Were you provided with enough guidance and support during the placement process?','6.Did you receive adequate training and preparation for the placement process','7.Was the placement process efficient and weel-organized?,','8.Was the placement process fair and transparent','9.Were you given equal opportunities as other candidates during placement process?','10.Were your expectations from the placement process met?if yes explain.','Overall satisfaction']
    list6=['Roll no','Name','Section','1.Were the objectives of the NSS program clear to you ?','2.How satisfied were you with the overall NSS program?','3.How has your participation in the NSS program impacted your personal and professional growth?','4.Were you given enough information about the community or organization you worked with during NSS  program?','5.Did the NSS program provide you with enough opportunities for skill development ?',"6.Were the NSS program's activities inclusive and diverse","7.Were you saatisfied with the NSS program's duration and frequency of activities?",'8.Were the NSS team members supportive and helpful in guiding you through the program',"9.Were the NSS program's goals and objective met",'10.Did the NSS program meet your expectations?if yes explain.','Overall Satisfaction' ]
    cursor.execute('SELECT rollno,name,section,one,two,three,four,five,six,seven,eight,nine,ten,eleven from surveys where surid=%s',[sid])
    user_data=[list(i) for i in cursor.fetchall()]
    if ftype=='form1':
        user_data.insert(0,lst1)
    elif ftype=='form2':
        user_data.insert(0,list2)
        print(user_data)
    elif ftype=='form3':
        user_data.insert(0,list3)
    elif ftype=='form4':
        user_data.insert(0,list4)
    elif ftype=='form5':
        user_data.insert(0,list5)
    elif ftype=='form6':
        user_data.insert(0,list6)
    print(user_data)
    return excel.make_response_from_array(user_data, "xlsx",file_name="Faculty_data")
app.run(use_reloader=True,debug=True)
