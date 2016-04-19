import os
import sys
from sqlalchemy import Column,ForeignKey,Integer,String,VARCHAR,DateTime
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from werkzeug import generate_password_hash, check_password_hash

Base=declarative_base()

class Category(Base):
	__tablename__='category'
	id=Column(Integer,primary_key=True)
	name=Column(String(250),nullable=False)

class Product(Base):
	__tablename__='product'
	id=Column(Integer,primary_key=True)
	cat_id=Column(Integer,ForeignKey('category.id'))
	item_id=Column(String(250),nullable=False)
	name=Column(String(80),nullable=False)
	price=Column(String(8))
	category=relationship(Category)

class Storeshopper_track(Base):
	__tablename__='storeshopper_track'
	id=Column(Integer,primary_key=True)
	sel_item_qty=Column(Integer)	
	session_id=Column(VARCHAR(50))
	sel_item_id=Column(VARCHAR(50))
	date_added=Column(DateTime)

class Users(Base):
	__tablename__='users'
	uid=Column(Integer,primary_key=True)
	firstname=Column(String(100))
	lastname=Column(String(100))
	email=Column(String(120),unique=True)
	pwdhash=Column(String(255))

	def __init__(self,firstname,lastname,email,password):
		self.firstname=firstname.title()
		self.lastname=lastname.title()
		self.email=email.lower()
		self.set_password(password)

	def set_password(self,password):
		self.pwdhash=generate_password_hash(password)

	def check_password(self,password):
		return check_password_hash(self.pwdhash,password)

engine=create_engine("mysql+mysqlconnector://root:@localhost/shopsmart")
Base.metadata.create_all(engine)
DBSession = sessionmaker(bind=engine)
db = DBSession()
