from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from database_setup import Base,Restaurant ,MenuItem

engine=create_engine("mysql+mysqlconnector://root:@localhost/python_mysql")
Base.metadata.create_all(engine)

DBSession=sessionmaker(bind=engine)
session=DBSession()

myFirstRestaurant=Restaurant(name="Pizza palace")
session.add(myFirstRestaurant)
session.commit()

cheesepizza=MenuItem(name="cheesepizza",description="this is cheese pizza",
					price="8.99",course="meal",restaurant=myFirstRestaurant)
session.add(cheesepizza)
session.commit()

session.query(Restaurant).all()
session.query(MenuItem).all()