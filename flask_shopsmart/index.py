from flask import Flask,render_template,request,redirect,url_for,flash,session
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from database_setup import Base, Category, Product,Storeshopper_track,db,Users
from datetime import datetime
from forms import ContactForm,SignupForm,SigninForm
from flask_mail import Message,Mail

app=Flask(__name__)
# engine=create_engine("mysql+mysqlconnector://root:@localhost/shopsmart")
# Base.metadata.bind = engine

app.secret_key='my_key'

app.config["MAIL_SERVER"] = "smtp.gmail.com"
app.config["MAIL_PORT"] = 465
app.config["MAIL_USE_SSL"] = True
app.config["MAIL_USERNAME"] = 'studyonlyonline@gmail.com'
app.config["MAIL_PASSWORD"] = 'samtron56v'

def show_category():
	global categories
	categories=db.query(Category).all()

@app.route('/')
def home():
	session['user']="sarthak"
	return redirect(url_for('viewProduct',cat_id=1))

# @app.route('/category/',defaults={'cat_id':1})
@app.route('/category/<int:cat_id>/')
def viewProduct(cat_id):
	show_category()
	items=db.query(Product).filter_by(cat_id=cat_id)
	return render_template('cat_item.html',items=items,category="category",categories=categories)

@app.route('/addToCart/<string:item_id>',methods=['GET','POST'])
def addToCart(item_id):
	if 'user' in session:
		mycart=Storeshopper_track(session_id=session['user'],sel_item_qty=1,sel_item_id=item_id,date_added=datetime.now())
		db.add(mycart)
		db.commit()
		return redirect(url_for('viewProduct',cat_id=item_id[0]))
	else:
		return render_template('cart.html',passed="false")


@app.route('/contact/',methods=['GET','POST'])
def contact():
	form=ContactForm()

	if request.method=='POST':
		if form.validate()==False:
			flash('All fields are required')
			return render_template('contact.html',form=form)
		else:
			msg=Message(form.subject.data,sender='sarthak937gupta@gmail.com',recipients=['studyonlyonline@gmail.com'])
			msg.body="""
			From %s <%s>
			%s
			"""%(form.name.data,form.email.data,form.message.data)
			mail.send(msg)
			return 'Form posted'

	elif request.method=='GET':
		return render_template('contact.html',form=form)

@app.route('/signup/',methods=['GET','POST'])
def signup():
	form=SignupForm()

	if request.method=='POST':
		if form.validate()==False:
			return render_template('signup.html',form=form)
		else:
			newUser=Users(form.firstname.data,form.lastname.data,form.email.data,form.password.data)
			db.add(newUser)
			db.commit()
			session['email']=newUser.email
			return redirect(url_for('profile'))

	elif request.method=='GET':
		return render_template('signup.html',form=form)

@app.route('/signin/',methods=['GET','POST'])
def signin():
	form=SigninForm()
	if request.method=='POST':
		if form.validate()==False:
			return render_template('signin.html',form=form)
		else:
			session['email']=form.email.data
			return redirect(url_for('profile'))
	elif request.method=='GET':
		if 'email' in session:
			return redirect(url_for('profile'))
		return render_template('signin.html',form=form)


@app.route('/signout')
def signout():
	if 'email' not in session:
		return redirect(url_for('signin'))
	
	session.pop('email',None)
	return redirect(url_for('home'))

@app.route('/profile/')
def profile():
	if 'email' not in session:
		return redirect(url_for('signin'))
	
	user=db.query(Users).filter_by(email=session['email']).first()
	if user is None:
		return redirect(url_for('signup'))
	else:
		return render_template('profile.html')


if __name__=='__main__':
	app.debug=True
	app.run(host='0.0.0.0',port=5002)
