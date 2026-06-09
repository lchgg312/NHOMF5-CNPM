from sqlalchemy import Column, Integer, String, Text
from database import Base

class Medicine(Base):
    __tablename__ = "medicines"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), index=True)
    ingredient = Column(String(255))
    usage = Column(Text)
    side_effects = Column(Text)

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    full_name = Column(String(255))  # THÊM DÒNG NÀY VÀO ĐÂY
    email = Column(String(255), unique=True, index=True)
    hashed_password = Column(String(255))