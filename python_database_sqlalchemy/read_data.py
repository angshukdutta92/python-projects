from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from database_setup import Base,Restaurant ,MenuItem
import database_curd

database_curd.start_lines()

session=database_curd.session
restaurant=session.query(Restaurant).all()
for i in restaurant:
	print i.name
# items=session.query(MenuItem).all()

# veggie=session.query(MenuItem).filter_by(name='Veggie Burger')
# for veg in veggie:
# 	print veg.id
# 	print veg.price
# 	print veg.restaurant.name
# 	print "\n"

#updating
# urban_veggie=session.query(MenuItem).filter_by(id=11).one()
# print urban_veggie.price
# urban_veggie.price="25"
# session.add(urban_veggie)
# session.commit()
# for veg in veggie:
# 	print veg.id
# 	print veg.price
# 	print veg.restaurant.name
# 	print "\n"
	
