from flask.ext.wtf import Form
from wtforms import TextField,TextAreaField,SubmitField,PasswordField
from wtforms import validators,ValidationError
from database_setup import Users,db

class ContactForm(Form):
	name=TextField("Name" ,[validators.Required()])
	email=TextField("Email", [validators.Required(),validators.Email()])
	subject=TextField("Subject", [validators.Required()])
	message=TextAreaField("Message", [validators.Required()])
	submit=SubmitField("Send")
	
class SignupForm(Form):
	firstname=TextField("First name" , [validators.Required("Please enter your first name")])
	lastname=TextField("Last name", [validators.Required("please enter your last name")])
	email=TextField("email",[validators.Required("Please enter your email"),validators.Email("Please enter valid emiail address")])
	password=PasswordField('password',[validators.Required("Please enter a password")])
	address=TextAreaField("Adress",[validators.Required("Please enter your Address")])
	submit=SubmitField("Creat Account")

	def __init__(self,*args,**kwargs):
		Form.__init__(self,*args,**kwargs)

	def validate(self):
		if not Form.validate(self):
			return False

		user=db.query(Users).filter_by(email=self.email.data.lower()).first()
		if user:
			self.email.errors.append("That email is already taken")
			return False
		else:
			return True

class SigninForm(Form):
	email=TextField("Email", [validators.Required("Please enter the email address"),validators.Email("This email address is not valid")])
	password=PasswordField('Password',[validators.Required('Please enter the password')])
	submit=SubmitField("Sign In")

	def __init__(self,*args,**kwargs):
		Form.__init__(self,*args,**kwargs)

	def validate(self):
		if not Form.validate(self):
			return False

		user=db.query(Users).filter_by(email=self.email.data.lower()).first()
		if user and user.check_password(self.password.data):
			return True
		else:
			self.email.errors.append("Invalid email or password")
			return False

