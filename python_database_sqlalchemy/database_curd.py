from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from database_setup import Base,Restaurant ,MenuItem

def start_lines():
	global session
	engine=create_engine("mysql+mysqlconnector://root:@localhost/python_mysql")
	Base.metadata.create_all(engine)

	DBSession=sessionmaker(bind=engine)
	session=DBSession()