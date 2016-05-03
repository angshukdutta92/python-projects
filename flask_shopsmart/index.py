from flask import Flask,render_template,request,redirect,url_for,flash,session
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from database_setup import Base, Category, Product,Storeshopper_track,db,Users,UserData
from datetime import datetime
from forms import ContactForm,SignupForm,SigninForm
from flask_mail import Message,Mail

app=Flask(__name__)
mail=Mail()
# engine=create_engine("mysql+mysqlconnector://root:@localhost/shopsmart")
# Base.metadata.bind = engine

app.secret_key='my_key'

app.config["MAIL_SERVER"] = "smtp.gmail.com"
app.config["MAIL_PORT"] = 465
app.config["MAIL_USE_SSL"] = True
app.config["MAIL_USERNAME"] = 'your_email_id_here'
app.config["MAIL_PASSWORD"] = 'your_email_id_password'
mail.init_app(app)

def show_category():
	global categories
	categories=db.query(Category).all()

@app.route('/')
def home():
	return redirect(url_for('viewProduct',cat_id=1))

# @app.route('/category/',defaults={'cat_id':1})
@app.route('/category/<int:cat_id>/')
def viewProduct(cat_id):
	show_category()
	if cat_id>=3:
		return render_template('game.html')
	else:
		items=db.query(Product).filter_by(cat_id=cat_id)
		return render_template('cat_item.html',items=items,category="category",categories=categories)


@app.route('/addToCart/<string:item_id>',methods=['GET','POST'])
def addToCart(item_id):
	if 'email' not in session:
		return redirect(url_for('signin'))
	else:
		item=db.query(Product).filter_by(item_id=item_id).first()
		item_present=db.query(Storeshopper_track).filter_by(session_id=session['email'],sel_item_id=item_id).count()
		if item_present==0:
			mycart=Storeshopper_track(session_id=session['email'],name=item.name,sel_item_qty=1,sel_item_id=item_id,date_added=datetime.now(),price=item.price)
			db.add(mycart)
			db.commit()
		else:
			item_present=db.query(Storeshopper_track).filter_by(session_id=session['email'],sel_item_id=item_id).first()
			item_present.sel_item_qty+=2
		flash("Item is Added to Cart")
	return redirect(url_for('viewProduct',cat_id=item_id[0]))

@app.route('/showCart/')
def showCart():
	if 'email' not in session:
		return redirect(url_for('signin'))
	else:
		cart_item=db.query(Storeshopper_track).filter_by(session_id=session['email'])
		total=0
		for item in cart_item:
			total=total+item.price*item.sel_item_qty
		return render_template('cart.html',cart_item=cart_item,total=total)

@app.route('/remove/<string:item_id>')
def removeItemFromCart(item_id):
	item=db.query(Storeshopper_track).filter_by(session_id=session['email'],sel_item_id=item_id).one()
	db.delete(item)
	db.commit()
	return redirect(url_for('showCart'))

@app.route('/updateQuantity/<string:item_id>',methods=['GET','POST'])
def updateQuantity(item_id):
	if request.method=='POST':
		item=db.query(Storeshopper_track).filter_by(session_id=session['email'],sel_item_id=item_id).first()
		item.sel_item_qty=request.form['quantity']
	return redirect(url_for('showCart'))

@app.route('/checkout/')
def checkout():
	msg=Message("you subject",sender='studyonlyonline@gmail.com',recipients=[session['email']])
	items=db.query(Storeshopper_track).filter_by(session_id=session['email']).all()
	msg.body=""" """
	total=0
	for i in items:
		msg.body+="""
		Name: %s Price: %s  Quantity: %s  
		Total Price: %s
		"""%(i.name,i.price,i.sel_item_qty,i.price*i.sel_item_qty)
		total=total+i.price*i.sel_item_qty
	msg.body+=""" 
		Total: %s 
		Thankyou For Shopping
	"""%(total)
	mail.send(msg)
	
	#adding user data to userData table
	newUserData=UserData(user_email=session['email'],date_added=items[0].date_added,amount=total)
	db.add(newUserData)
	db.commit()

	#deleting data from the storeshopper_trac
	for i in items:
		db.delete(i)
	db.commit()	
	return render_template('checkout.html')

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
			newUser=Users(form.firstname.data,form.lastname.data,form.email.data,form.password.data,form.address.data)
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
			return redirect(url_for('home'))
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
		return redirect(url_for('profileHome'))

@app.route('/profile/home/')
def profileHome():
	userData=db.query(UserData).filter_by(user_email=session['email'])
	return render_template('profileHome.html',userData=userData)

@app.route('/profile/personalDetails/')
def profileDetails():
	user=db.query(Users).filter_by(email=session['email']).first()
	return render_template('profileDetails.html',user=user)

@app.route('/profile/sellItem/')
def sellItem():
	show_category()
	return render_template('profileSellItem.html',categories=categories)

@app.route('/addProduct/',methods=['GET','POST'])
def sellProduct():
	if request.method=='POST':
		if request.form['productName']=='' or request.form['productPrice']=='':
			flash("Enter all details Product Name and Product Price")
		else:
			newProduct=Product(cat_id=request.form['Category'],item_id='2I',name=request.form['productName'],price=request.form['productPrice'],seller=session['email'])
			db.add(newProduct)
			db.commit()
			flash('Your Product is added')

	return redirect(url_for('sellItem'))		

@app.route('/sendMessage/<string:sendTo>/',methods=['GET','POST'])
def sendMessage(sendTo):
	if request.method=='POST':
		if request.form['subject']=='' or request.form['message']=='':
			flash("Enter both Subject and Message")
			return render_template('sendMessage.html',sendTo=sendTo)
		else:
			msg=Message(request.form['subject'],sender='studyonlyonline@gmail.com',recipients=[sendTo])
			msg.body=""" 
				%s
			"""%(request.form['message'])
			mail.send(msg)
			flash("Message Send")
			return redirect(url_for('home'))
	else:
		return render_template('sendMessage.html',sendTo=sendTo)


if __name__=='__main__':
	app.debug=True
	app.run(host='0.0.0.0',port=5002)

	
	
